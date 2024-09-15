
{$i definicoes.inc}

unit Terasoft.Framework.EventosUso.Coleta;

interface
  uses
    Classes, SysUtils,
    Terasoft.Framework.Types;

  procedure iniciaServicoColetaEventosUso(pDB: String);
  procedure pararServicoColetaEventosUso;

implementation
  uses
    Terasoft.Framework.FuncoesDiversas,
    FuncoesConfig,
    strUtils,
    Terasoft.Framework.FuncoesArquivos,
    Terasoft.Framework.Texto,
    Terasoft.Framework.DB,
    Terasoft.Framework.EventosUso.consts,
    Terasoft.Framework.JSON,
    Terasoft.Framework.DB.DAO,
    Terasoft.Framework.PoolThreads;

  var
    gColeta: IProcesso;
    gTerminar: boolean;
    gGDB: IGDB;
    gDBName: String;

    gListaTexto: IListaTextoEX;
    gDiretorioOrigem: String;
    ds: IDataset;

function importaArquivo(pArquivo: String): boolean;
  var
    js: ITlkJSONObject;
    evento,chave,conexao: String;
    dh: TDateTime;
begin
  Result := false;
  js := TlkJSON.loadFromFile(pArquivo,true,true);
  if(js=nil) then
    exit;

  evento := js.json.variantByPath('evento','');
  if(ds=nil) then
    ds := gGDB.criaDataset;

  chave := js.json.variantByPath('id','');
  dh := StrToDateTimeDef(js.json.variantByPath('dh',''),0);

  if stringNoArray( evento, [EVENTOUSO_ACAO_CONEXAO, EVENTOUSO_ACAO_SISTEMA]) then
  begin
    ds.query('select * from webcoleta_conexoes w where w.chave=:chave',
             'chave', [chave]);

    if(dh<ds.dataset.FieldByName('dh').AsDateTime) then exit;

    ds.dataset.Edit;
    ds.dataset.FieldByName('id').AsInteger := 0;
    ds.dataset.FieldByName('chave').AsString := chave;
    ds.dataset.FieldByName('dh').AsDateTime := dh;
    ds.dataset.FieldByName('evento').AsString := evento;
    ds.dataset.FieldByName('instancia').AsString := js.json.variantByPath('instancia','');
    ds.dataset.FieldByName('seq').AsString := js.json.variantByPath('seq','0');
    ds.dataset.FieldByName('execucao').AsString := js.json.variantByPath('execucao','');
    ds.dataset.FieldByName('mobile').AsString := ifthen(js.json.variantByPath('mobile',false),'S','N');
    ds.dataset.FieldByName('empresa_id').AsString := js.json.variantByPath('empresa\id','');
    ds.dataset.FieldByName('empresa_cnpj').AsString := js.json.variantByPath('empresa\cnpj','');
    ds.dataset.FieldByName('empresa_loja').AsString := js.json.variantByPath('empresa\loja','');
    ds.dataset.FieldByName('conexao').AsString := js.json.variantByPath('empresa\conexao','');
    ds.dataset.CheckBrowseMode;
    //Apaga arquivo..
    Result := true;
  end else
  begin
    conexao := js.json.variantByPath('conexao','');
    ds.query('select * from WEBCOLETA_EVENTOS where conexao=:conexao and identificador=:identificador', 'conexao;identificador', [ conexao, chave ]);
    ds.dataset.Edit;
    ds.dataset.FieldByName('id').AsInteger := 0;
    ds.dataset.FieldByName('conexao').AsString := conexao;
    ds.dataset.FieldByName('dh').AsDateTime := dh;
    ds.dataset.FieldByName('seq').AsString := js.json.variantByPath('seq','0');
    ds.dataset.FieldByName('identificador').AsString := chave;
    ds.dataset.FieldByName('evento').AsString := js.json.variantByPath('evento','');
    ds.dataset.FieldByName('descricao').AsString := js.json.variantByPath('parametros\0','');
    ds.dataset.FieldByName('valor01').AsString := js.json.variantByPath('parametros\1','');
    ds.dataset.FieldByName('valor02').AsString := js.json.variantByPath('parametros\2','');
    ds.dataset.FieldByName('valor03').AsString := js.json.variantByPath('parametros\3','');
    Result := true;
  end;
  ds.dataset.CheckBrowseMode;
  ds.commit(true);

end;

function coleta(pProcesso: IProcesso; pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    s: String;
    i: Integer;

begin
  Result := checkResultadoOperacao(pResultado);
  if(gTerminar) then
  begin
    gGDB := nil;
    pProcesso.quantidadeExecutar := 0;
    exit;
  end;
  sleep(10);
  if(gGDB=nil) then
  begin
    gGDB := criaDBFiredac;
    gGDB.testarPortaFirebird := false;
    gGDB.charset := GDBFIB_CHARSETPTBR;
  end;
  if not gGDB.conectado then
    gGDB.conectar(gDBName);

    if(gListaTexto=nil) or (gListaTexto.strings.Count=0) then
      gListaTexto := encontraArquivos(gDiretorioOrigem);

  i := gListaTexto.strings.Count;
  while i > 0 do
  begin
    dec(i);
    //sleep(10);
    s := gListaTexto.strings.Strings[i];
    gListaTexto.strings.Delete(i);
    if not FileExists(s) then continue;
    if importaArquivo(s) then
      DeleteFile(s)
    else
      RenameFile(s,s+'.rej');
  end;

end;

procedure iniciaServicoColetaEventosUso;
begin
  if(pDB='') then
    exit;

  if(gColeta=nil) then
  begin
    gDBName := pDB;

    gDiretorioOrigem := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)) + 'Stats\' + gNomeInstanciaSistema);
    ForceDirectories(gDiretorioOrigem);
    gDiretorioOrigem := gDiretorioOrigem + '*.json';

    gColeta := criaProcessoAnonimo(coleta,'Coleta Eventos de Uso');
    gColeta.quantidadeExecutar := MaxInt;
    gColeta.tempoEntreExecucoes := 5000;
    gColeta.runAsync;
  end;

end;

procedure pararServicoColetaEventosUso;
begin
  gTerminar := true;
  if(gColeta<>nil) then
    gColeta.esperar;
  gColeta := nil;
end;


initialization

finalization
  pararServicoColetaEventosUso;

end.

