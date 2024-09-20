
{$i definicoes.inc}

unit Terasoft.Framework.EventosUso;

interface
  uses
    Classes,SysUtils,
    Terasoft.Framework.JSON,
    Interfaces.Conexao,
    Terasoft.Types,
    Terasoft.Framework.Types;

  type
    IEventosUsoSessao = interface
    ['{B958AB15-F535-4A8B-B5BE-80164B13349D}']
          //property identificador getter/setter
      function getIdentificador: TBytes;
      procedure setIdentificador(const pValue: TBytes);

      //function toJSON: ITlkJSONObject;

      procedure registraEvento(pDH: TDateTime; pEvento: TipoWideStringFramework; pParametros: TParametrosEventoUso);
      procedure registraEventoParams(pDH: TDateTime; pEvento: TipoWideStringFramework; pObjeto: TipoWideStringFramework = ''; pDescricao: TipoWideStringFramework = ''; pParam02: TipoWideStringFramework = ''; pParam03: TipoWideStringFramework = '' );


      procedure gravaEvento(pDH: TDateTime; pEvento: TipoWideStringFramework; pParametros: TParametrosEventoUso);

      function getIDStr: TipoWideStringFramework;

    //property conexao getter/setter
      function getConexao: IConexao;
      procedure setConexao(const pValue: IConexao);

    //property mobile getter/setter
      function getMobile: boolean;
      procedure setMobile(const pValue: boolean);

      property mobile: boolean read getMobile write setMobile;
      property conexao: IConexao read getConexao write setConexao;
      property identificador: TBytes read getIdentificador write setIdentificador;

    end;

  function getEventosUsoSessao(pConexao: IConexao): IEventosUsoSessao;
  function getIDExecucao: TipoWideStringFramework;

  function getEventosExecucao: IEventosUsoSessao;

  procedure iniciaServicoEventosUso;
  procedure pararServicoEventosUso;

implementation
  uses

    Terasoft.Framework.Collections,
    Terasoft.Framework.PoolThreads,
    Terasoft.Framework.Texto,
    Terasoft.Framework.FuncoesDiversas,
    Terasoft.Framework.EventosUso.consts,
    Terasoft.Framework.EventosUso.Coleta,
    Terasoft.Framework.LOG,
    FuncoesConfig,
    Terasoft.Framework.FuncoesArquivos,
    Terasoft.Framework.Bytes;

  type
    TDadosEventoUso = record
      estatistica: IEventosUsoSessao;
      dh: TDateTime;
      evento: TipoWideStringFramework;
      parametros: TParametrosEventoUso;
    end;

    TEstatisticaUsoImpl = class(TInterfacedObject, IEventosUsoSessao)
  private
    protected
      [weak] fConexao: IConexao;
      fIdentificador: TBytes;
      fDH: TDateTime;
      fMobile: boolean;
      vSeq,vSeqConexao: Integer;

    //property mobile getter/setter
      function getMobile: boolean;
      procedure setMobile(const pValue: boolean);

    //property conexao getter/setter
      function getConexao: IConexao;
      procedure setConexao(const pValue: IConexao);

      function toJSON(pEvento: TipoWideStringFramework): ITlkJSONObject;

      procedure registraEvento(pDH: TDateTime; pEvento: TipoWideStringFramework; pParametros: TParametrosEventoUso);
      procedure registraEventoParams(pDH: TDateTime; pEvento: TipoWideStringFramework; pObjeto: TipoWideStringFramework = ''; pDescricao: TipoWideStringFramework = ''; pParam02: TipoWideStringFramework = ''; pParam03: TipoWideStringFramework = '' );

      procedure gravaEvento(pDH: TDateTime; pEvento: TipoWideStringFramework; pParametros: TParametrosEventoUso);
      procedure _gravaEvento(pEvento: TipoWideStringFramework; pJSON: ITlkJSONObject);

      function getIDStr: TipoWideStringFramework;


    //property identificador getter/setter
      function getIdentificador: TBytes;
      procedure setIdentificador(const pValue: TBytes);
    public
      constructor Create(pConexao: IConexao);
      destructor Destroy; override;
    end;

  var
    gProcessoGravacao: IProcesso;
    gLista: ILockList<TDadosEventoUso>;
    gTerminar: boolean;

function proc(pProcesso: IProcesso; pResultado: IResultadoOperacao): IResultadoOperacao;
  var
    p: TDadosEventoUso;
begin
  Result := checkResultadoOperacao(pResultado);
  while gLista.dequeue(p) do
  begin
    sleep(10);
    if(p.estatistica<>nil) then
      p.estatistica.gravaEvento(p.dh,p.evento,p.parametros);
    //p.estatistica := nil;
    //p.parametros := nil;
  end;

  if(gTerminar) then
  begin
    pProcesso.quantidadeExecutar := 0;
    pResultado.adicionaAviso('Processo finalizado.');
  end;
end;

procedure iniciaServicoEventosUso;
begin
  if(gLista=nil) then
    gLista := TCreateLock.CreateList<TDadosEventoUso>;
  if(gProcessoGravacao=nil) then
  begin
    gProcessoGravacao := criaProcessoAnonimo(proc,'Gravação de eventos');
    gProcessoGravacao.quantidadeExecutar := MaxInt;
    gProcessoGravacao.tempoEntreExecucoes := 1000;
    gProcessoGravacao.runAsync;
  end;
end;

procedure pararServicoEventosUso;
  var
    p: TDadosEventoUso;
begin
  if(gProcessoGravacao=nil) then exit;
  gTerminar := true;
  gProcessoGravacao.esperar;
  gProcessoGravacao := nil;
  while gLista.dequeue(p) do
  begin
    if(p.estatistica<>nil) then
      p.estatistica.gravaEvento(p.dh,p.evento,p.parametros);

    //p.estatistica := nil;
    //p.parametros := nil;
  end;

  gLista := nil;
end;

function getEventosUsoSessao;
begin
  Result := TEstatisticaUsoImpl.Create(pConexao);
end;

{ TEstatisticaUsoImpl }

constructor TEstatisticaUsoImpl.Create;
begin
  inherited Create;
  fConexao := pConexao;
  fDH := Now;
end;

procedure TEstatisticaUsoImpl._gravaEvento(pEvento: TipoWideStringFramework; pJSON: ITlkJSONObject);
  var
    s: String;
begin
  s := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)) + 'Stats\' + gNomeInstanciaSistema);
  ForceDirectories(s);
  pEvento:=retiraACENTOS(trim(uppercase(pEvento)));
  s := s + format('%s_%s.%s.json',[getIDStr,randomBase32(8),pEvento]);
  stringToFile(GenerateText(pJSON.json,false),s+'.tmp',TEncoding.UTF8);
  RenameFile(s+'.tmp',s);
end;

procedure TEstatisticaUsoImpl.registraEvento;
  var
    p: TDadosEventoUso;
begin
  if(gTerminar=true) then
    exit;
  p.estatistica := self;
  p.dh := pDH;
  p.evento := pEvento;
  p.parametros := pParametros;
  gLista.add(p);
  p.estatistica := nil;
  p.parametros := nil;
end;

procedure TEstatisticaUsoImpl.gravaEvento;
  var
    s: TipoWideStringFramework;
    js: ITlkJSONObject;
    jsParametros: TlkJSONlist;
    i: Integer;
begin
  js := nil;

  //logaByTagSeNivel(TAGLOG_CONDICIONAL, format('TEstatisticaUsoImpl.dump: Registra ação [%s]', [pEvento]), LOG_LEVEL_DEBUG);
  if(stringNoArray(pEvento, [ EVENTOUSO_ACAO_CONEXAO, EVENTOUSO_ACAO_SISTEMA ])) then
  begin
    fDH := pDH;
    js := toJSON(pEvento);
    if(fConexao<>nil) then
    begin
      if(fConexao.gdb.conectado) then
        registraEventoParams(pDH, EVENTOUSO_PROPRIEDADE_CONEXAO,'database','',fConexao.gdb.databaseName);
      if(fConexao.empresa.LOJA<>'') then
        registraEventoParams(pDH, EVENTOUSO_PROPRIEDADE_CONEXAO,'empresa','',fConexao.empresa.LOJA);
      if(fConexao.empresa.EMPRESA_CNPJ<>'') then
        registraEventoParams(pDH, EVENTOUSO_PROPRIEDADE_CONEXAO,'cnpj','',fConexao.empresa.EMPRESA_CNPJ);
      if(fConexao.empresa.ID<>'') then
        registraEventoParams(pDH, EVENTOUSO_PROPRIEDADE_CONEXAO,'id','',fConexao.empresa.ID);
    end;
  end else
  begin
    js := TlkJSON.cria;
    js.json.Add('conexao',getIDStr);
    js.json.Add('id',randomBase32(TAMANHOENTROPIA_BYTES));
    js.json.Add('dh',DateTimeToStr(pDH));
    AtomicIncrement(vSeq);
    js.json.Add('seq',vSeq);
    js.json.Add('evento',pEvento);
    if(pParametros<>nil) and (pParametros.Count > 0) then
    begin
      jsParametros := TlkJSONlist.Generate;
      js.json.Add('parametros',jsParametros);
      for s in pParametros do
        jsParametros.Add(s);
    end;
  end;

  if(js<>nil) then
    _gravaEvento(pEvento,js);
end;

procedure TEstatisticaUsoImpl.registraEventoParams(pDH: TDateTime; pEvento, pObjeto, pDescricao, pParam02, pParam03: TipoWideStringFramework);
begin
  self.registraEvento(pDH,pEvento,getStringListFromItens([pDescricao,pObjeto,pParam02,pParam03]));
end;

destructor TEstatisticaUsoImpl.Destroy;
begin
  if assigned(fConexao) then
    fConexao.eventosUsoSessao := nil;
  inherited;
end;

function TEstatisticaUsoImpl.getConexao: IConexao;
begin
  Result := fConexao;
end;

procedure TEstatisticaUsoImpl.setConexao(const pValue: IConexao);
begin
  fConexao := pValue;
end;

procedure TEstatisticaUsoImpl.setIdentificador(const pValue: TBytes);
begin
  fIdentificador := pValue;
end;

function TEstatisticaUsoImpl.toJSON;
  var
    lEmpresa: TlkJSONobject;
begin
  Result := TlkJSON.cria;
  Result.json.Add('id',getIDStr);
  Result.json.Add('dh',DateTimeToStr(Now));
  AtomicIncrement(vSeqConexao);
  Result.json.Add('seq',vSeqConexao);
  Result.json.Add('evento',pEvento);

  Result.json.Add('instancia',gNomeInstanciaSistema);
  Result.json.Add('execucao',getIDExecucao);
  Result.json.Add('mobile',fMobile);
  if(fConexao<>nil) then
  begin
    lEmpresa := TlkJSONobject.Generate;
    Result.json.Add('empresa',lEmpresa);
    lEmpresa.Add('id',fConexao.empresa.ID);
    lEmpresa.Add('cnpj',fConexao.empresa.EMPRESA_CNPJ);
    lEmpresa.Add('loja',fConexao.empresa.LOJA);
    lEmpresa.Add('conexao',fConexao.gdb.databaseName);
  end;

end;

procedure TEstatisticaUsoImpl.setMobile(const pValue: boolean);
begin
  fMobile := pValue;
end;

function TEstatisticaUsoImpl.getMobile: boolean;
begin
  Result := fMobile;
end;

function TEstatisticaUsoImpl.getIdentificador: TBytes;
begin
  if(length(fIdentificador)<>TAMANHOENTROPIA_BYTES) then
  begin
    fIdentificador := randomBytes(TAMANHOENTROPIA_BYTES);
  end;
  Result := fIdentificador;
end;

function TEstatisticaUsoImpl.getIDStr: TipoWideStringFramework;
begin
  Result := bytesToBase32(getIdentificador);
end;

  var
    fEventosExecucao: IEventosUsoSessao;

function getIDExecucao: TipoWideStringFramework;
begin
  Result := getEventosExecucao.getIDStr;
end;

function getEventosExecucao: IEventosUsoSessao;
begin
  if (fEventosExecucao=nil) then
  begin
    fEventosExecucao := getEventosUsoSessao(nil);
    fEventosExecucao.registraEvento(Now,EVENTOUSO_ACAO_SISTEMA,nil)

  end;
  Result := fEventosExecucao;

end;

initialization

finalization
  pararServicoEventosUso;

end.

