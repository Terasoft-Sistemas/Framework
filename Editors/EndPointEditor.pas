unit EndPointEditor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Interfaces.Conexao,
  Terasoft.Framework.Texto,
  Terasoft.Framework.ObjectIface,
  EndpointModel, FiltroModel,
  FiltroController,
  EndpointController,
  Terasoft.Framework.MultiConfig,
  DB,
  Terasoft.Framework.DB,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, XDBGrids, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.Mask;

type

  TfrmEditorConsultas = class;
  ITfrmEditorConsultas=IObject<TfrmEditorConsultas>;

  TfrmEditorConsultas = class(TForm)
    gridEP: TXDBGrid;
    pnGestao: TPanel;
    btnNovo: TBitBtn;
    btnEditar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    pnEdicao: TPanel;
    PC: TPageControl;
    tsQuery: TTabSheet;
    tsDados: TTabSheet;
    DBMemo1: TDBMemo;
    dsEP: TDataSource;
    Testar: TBitBtn;
    edNome: TDBLabeledEdit;
    edDescricao: TDBMemo;
    lblDescricao: TLabel;
    TabSheet1: TTabSheet;
    dsFiltros: TDataSource;
    gridFiltros: TXDBGrid;
    pnGestaoPropriedadesFiltro: TPanel;
    pnPropFiltro: TPanel;
    btnFiltroEditar: TBitBtn;
    edPropFiltroValor: TLabeledEdit;
    edPropFiltroDescricao: TLabeledEdit;
    edPropFiltroValores: TLabeledEdit;
    btnFiltroCancelar: TBitBtn;
    mmProFiltroValores: TMemo;
    btnFiltroSalvar: TBitBtn;
    btnFiltroNovo: TBitBtn;
    btnFiltroExcluir: TBitBtn;
    edPropFiltroNome: TComboBox;
    lblNome: TLabel;
    tsFormatações: TTabSheet;
    gridCampos: TXDBGrid;
    dsCampos: TDataSource;
    pnGestaoFormatacoes: TPanel;
    btnGestaoformatacoesEditar: TBitBtn;
    btnGestaoformatacoesCancelar: TBitBtn;
    btnGestaoformatacoesSalvar: TBitBtn;
    pnPropCampo: TPanel;
    edtFormatacaoCampoFormato: TLabeledEdit;
    edtFormatacaoCampoTamanho: TLabeledEdit;
    edtFormatacaoCampoVisivel: TCheckBox;
    edtFormatacaoCampoSumario: TCheckBox;
    edtFormatacaoCampoTitulo: TLabeledEdit;
    edtFormatacaoCampoExpressao: TLabeledEdit;
    edtFormatacaoCampoOperacoes: TRadioGroup;
    edtFormatacaoCampoPosicao: TLabeledEdit;
    tsImpressoes: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure TestarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dsEPStateChange(Sender: TObject);
    procedure btnFiltroEditarClick(Sender: TObject);
    procedure btnFiltroCancelarClick(Sender: TObject);
    procedure btnFiltroSalvarClick(Sender: TObject);
    procedure btnFiltroNovoClick(Sender: TObject);
    procedure btnFiltroExcluirClick(Sender: TObject);
    procedure PCChange(Sender: TObject);
    procedure btnGestaoformatacoesEditarClick(Sender: TObject);
    procedure gridCamposCellClick(Column: TXColumn);
    procedure btnGestaoformatacoesCancelarClick(Sender: TObject);
    procedure btnGestaoformatacoesSalvarClick(Sender: TObject);
    procedure edtFormatacaoCampoOperacoesClick(Sender: TObject);
  private
    { Private declarations }
  protected
    vQuery: IDatasetSimples;
    vDatasetEndpoints: IDataset;
    vDatasetCampos, vDatasetFiltros,vDatasetFiltrosValores: IDatasetSimples;


    [weak] mySelf: ITfrmEditorConsultas;
    vIConexao:IConexao;
    vEPControl: IController_Endpoint;
    procedure query;
    procedure beforePost(DataSet: TDataSet);
    procedure ajustaBotoes;
    procedure ajustaBotoesFiltros;
    procedure ajustaBotoesCampos;
    function critica(pResultado: IResultadoOperacao=nil): IResultadoOperacao;
    function getDatasetFiltros: IDatasetSimples;
    procedure preencheFiltros;
    procedure preencheCampos;
    procedure geraConfiguracoesFiltro;
    function getMultiConfigPropriedades: IMultiConfig;
    procedure geraPropriedades001;
    procedure openQuery;
  public
    constructor _Create(pIConexao:IConexao);
    class function getNewIface(pIConexao: IConexao): ITfrmEditorConsultas;
    { Public declarations }
  end;

var
  frmEditorConsultas: TfrmEditorConsultas;

implementation
  uses
    Terasoft.Framework.MensagemVisual;

{$R *.dfm}

{ TfrmEditorConsultas }

procedure TfrmEditorConsultas.beforePost(DataSet: TDataSet);
begin
  with critica do
    if erros>0 then
      msgErro(toString);

  if(dataset.FieldByName('ID').IsNull) then
  begin
    dataset.FieldByName('ID').AsString := vIConexao.Generetor('gen_endpoint');
    dataset.FieldByName('metodo').AsString := 'RELATORIO';
  end;
end;

procedure TfrmEditorConsultas.btnGestaoformatacoesCancelarClick(
  Sender: TObject);
begin
  if not pergunta('Deseja cancelar a edição da formatação do campo selecionado?') then
    exit;

  vDatasetCampos.dataset.Cancel;
  preencheCampos;
  ajustaBotoes;
end;

procedure TfrmEditorConsultas.btnGestaoformatacoesEditarClick(Sender: TObject);
begin
  vDatasetCampos.dataset.Edit;
  preencheCampos;
  ajustaBotoes;
end;

procedure TfrmEditorConsultas.btnGravarClick(Sender: TObject);
begin
  msgErro('Gravação desabilitada ainda no momento.');
  with critica do
    if erros>0 then
      msgErro(toString);

//  if not podeGravar then
//    msgErro('Você precisa fornecer os campos obrigatórios.');
  vDatasetEndpoints.dataset.CheckBrowseMode;
  ajustaBotoes;
end;

procedure TfrmEditorConsultas.btnCancelarClick(Sender: TObject);
begin
  vDatasetEndpoints.dataset.Cancel;
  ajustaBotoes;
end;

procedure TfrmEditorConsultas.btnEditarClick(Sender: TObject);
begin
  if(vDatasetEndpoints.dataset.State=dsBrowse) then
    vDatasetEndpoints.dataset.Edit;
  ajustaBotoes;
  edNome.Show;
  edNome.SetFocus;
end;

procedure TfrmEditorConsultas.geraConfiguracoesFiltro;
  var
    sName,sDescricao,sValores,tmp1,tmp2: String;
    i: Integer;
begin

  sName := trim(edPropFiltroNome.Text);
  if(sName='') then
    msgErro('Nome do filtro dever ser preenchido.');
  sDescricao := trim(edPropFiltroDescricao.Text);

  sValores := '';

  for i := 0 to mmProFiltroValores.Lines.Count - 1 do
  begin
    tmp1 := trim(mmProFiltroValores.Lines.Names[i]);
    if(tmp1='') then
      tmp1 := '<vazio>';
    tmp2 := trim(mmProFiltroValores.Lines.ValueFromIndex[i]);
    if(tmp2<>'') then
    begin
      tmp2 := Format('\<%s\>', [ tmp2 ]);
      if(sValores<>'') then
        sValores := sValores + ';';
    end;
    sValores := sValores + tmp1+tmp2;
  end;
  if(sValores<>'') then
    sDescricao := sDescricao + '|' +  sValores;


  if(sDescricao<>'') then
    sName :=format('%s|%s', [ sName, trim(sDescricao) ]);

  vDatasetFiltros.dataset.Fields[0].AsString := sName;
  vDatasetFiltros.dataset.Fields[1].AsString := trim(edPropFiltroValor.Text);

end;

procedure TfrmEditorConsultas.preencheFiltros;
  var
    sName, tmp1,tmp2,tmp3: String;
    l: IListaTextoEX;
    i: Integer;
begin
  sName := vDatasetFiltros.dataset.FieldByName('ID').AsString;
  edPropFiltroNome.Text := textoEntreTags(sName,'','|');
  if(edPropFiltroNome.Text='') then
    edPropFiltroNome.Text := sName;
  tmp1 := textoEntreTags(sName,'|','');
  tmp2 := textoEntreTags(tmp1,'','|');
  tmp3 := textoEntreTags(tmp1,'|','');
  if(tmp2<>'') then
    tmp1 := tmp2;

  edPropFiltroDescricao.Text := tmp1;

  edPropFiltroValores.Text := tmp3;
  edPropFiltroValores.Enabled := false;

  l := novaListaTexto;
  l.strings.Delimiter := ';';
  l.strings.StrictDelimiter := true;
  l.strings.DelimitedText := tmp3;


  vDatasetFiltrosValores:= getGenericID_DescricaoDataset(1000,1000,true);

  mmProFiltroValores.lines.clear;

  for i := 0 to l.strings.Count - 1 do
  begin
    sName := l.strings.Strings[i];
    tmp1 := textoEntreTags(sName,'','\<');
    if(tmp1='') then
      tmp1 := sName;
    tmp2 := textoEntreTags(sName,'\<','\>');
    tmp1 := StringReplace(tmp1,'<vazio>','',[rfReplaceAll,rfIgnoreCase]);
    tmp2 := StringReplace(tmp2,'<vazio>','',[rfReplaceAll,rfIgnoreCase]);
    mmProFiltroValores.Lines.Values[tmp1] := tmp2;
    vDatasetFiltrosValores.dataset.Append;
    vDatasetFiltrosValores.dataset.fields[0].AsString := tmp1;
    vDatasetFiltrosValores.dataset.fields[1].AsString := tmp2;
  end;
  //gridPropFiltroValores.DataSource := vDatasetFiltrosValores.dataSource;

  //mmProFiltroValores.Lines.Text := StringReplace(mmProFiltroValores.Lines.Text,'<vazio>','',[rfReplaceAll,rfIgnoreCase]);
  edPropFiltroValor.Text := vDatasetFiltros.dataset.fields[1].asString;

end;

procedure TfrmEditorConsultas.btnGestaoformatacoesSalvarClick(Sender: TObject);
  var
    lCFG: IMultiConfig;
    campo,str: String;
    op: TOperacoesField;
    f: TField;
    lOriginal: String;
begin
  lCFG := getMultiConfigPropriedades;

  lOriginal := vDatasetEndpoints.fieldByName('propriedades').AsString;

  campo := vDatasetCampos.dataset.Fields[0].AsString;
  f := vQuery.dataset.FieldByName(campo);
  if(f=nil) then
    exit;

  op := TOperacoesField(edtFormatacaoCampoOperacoes.ItemIndex);

  edtFormatacaoCampoExpressao.Text := trim(edtFormatacaoCampoExpressao.Text);

  //Críticas

  if (op=tofExpressao) and (edtFormatacaoCampoExpressao.Text='') then
    msgErro('Falta definir a expressão para a operação do campo.');

  if(edtFormatacaoCampoTamanho.Text<>'') and (StrToIntDef(edtFormatacaoCampoTamanho.Text,-1)<0) then
    msgErro('O valor TAMANHO especificado é inválido.');



  //Fim das críticas


  if(edtFormatacaoCampoVisivel.Checked) then
    lCFG.deleteKey('visible',campo)
  else
    lCFG.WriteBool('visible',campo,false);

  if(edtFormatacaoCampoSumario.Checked) then
    lCFG.deleteKey('sumario',campo)
  else
    lCFG.WriteBool('sumario',campo,false);

  if(edtFormatacaoCampoTitulo.Text='') then
    lCFG.deleteKey('label',campo)
  else
    lCFG.WriteString('label',campo,edtFormatacaoCampoTitulo.Text);

  if(edtFormatacaoCampoTamanho.Text='') then
    lCFG.deleteKey('width',campo)
  else
    lCFG.WriteString('width',campo,edtFormatacaoCampoTamanho.Text);

  if(edtFormatacaoCampoPosicao.Text='') then
    lCFG.deleteKey('posicao',campo)
  else
    lCFG.WriteString('posicao',campo,edtFormatacaoCampoPosicao.Text);


  if(edtFormatacaoCampoFormato.Text='') then
    lCFG.deleteKey('formato',campo)
  else
    lCFG.WriteString('formato',campo,edtFormatacaoCampoFormato.Text);

  if(op=tofSoma) then
    lCFG.deleteKey('operacoes',campo)
  else
  begin
    str := opFieldToStr(op);
    if(op=tofExpressao) then
      str := format('%s=%s',[str,trim(edtFormatacaoCampoExpressao.Text)]);
    lCFG.WriteString('operacoes',campo,str);
  end;

  str := inputMemo('Verifique os valores','Propriedades', lCFG.toString);

  vDatasetEndpoints.fieldByName('propriedades').AsString := str;

  if (pergunta('Deseja salvar as alterações na formatação do campo?')=false) then
  begin
    vDatasetEndpoints.fieldByName('propriedades').AsString := lOriginal;
    exit;
  end;

  vDatasetCampos.dataset.CheckBrowseMode;
  preencheCampos;
  ajustaBotoes;

{

  edtFormatacaoCampoPosicao.Text := lCFG.ReadString('posicao', campo, '');
}

end;



procedure TfrmEditorConsultas.preencheCampos;
  var
    lCfg: IMultiConfig;
    campo: String;
    f: TField;
    op: TOperacoesField;
begin
  if(vDatasetCampos=nil) then exit;
  if(vQuery=nil) then exit;
  campo := vDatasetCampos.dataset.Fields[0].AsString;
  f := vQuery.dataset.FieldByName(campo);
  if(f=nil) then
    exit;
  lCFG := getMultiConfigPropriedades;

  op := strToOpField(lCFG.ReadString('operacoes', campo, ''));
  edtFormatacaoCampoTitulo.Text := lCFG.ReadString('label', campo, '');
  if(f is TNumericField) then
  begin
    edtFormatacaoCampoFormato.Enabled := true;
    edtFormatacaoCampoFormato.Text := lCFG.ReadString('formato', campo, '');
    edtFormatacaoCampoSumario.Enabled := true;
    edtFormatacaoCampoSumario.Checked := lCFG.ReadBool('sumario', campo, true);
    edtFormatacaoCampoSumario.Enabled := true;
    edtFormatacaoCampoOperacoes.Enabled := true;
    edtFormatacaoCampoOperacoes.ItemIndex := Integer(op);
    edtFormatacaoCampoExpressao.Enabled := op=tofExpressao;
  end else
  begin
    edtFormatacaoCampoFormato.Enabled := false;
    edtFormatacaoCampoFormato.Text := '';
    edtFormatacaoCampoSumario.Enabled := false;
    edtFormatacaoCampoSumario.Checked := false;
    edtFormatacaoCampoSumario.Enabled := false;
    edtFormatacaoCampoExpressao.Text := '';
    edtFormatacaoCampoOperacoes.Enabled := false;
    edtFormatacaoCampoExpressao.Enabled := false;
  end;
  if(edtFormatacaoCampoExpressao.Enabled) then
    edtFormatacaoCampoExpressao.Text := textoEntreTags(lCFG.ReadString('operacoes', campo, ''),'=','')
  else
    edtFormatacaoCampoExpressao.Text := '';

  edtFormatacaoCampoTamanho.Text := lCFG.ReadString('width', campo,'');
  edtFormatacaoCampoVisivel.Checked := lCFG.ReadBool('visible', campo, f.Visible);
  edtFormatacaoCampoPosicao.Text := lCFG.ReadString('posicao', campo, '');
end;

procedure TfrmEditorConsultas.btnFiltroEditarClick(Sender: TObject);
begin
  vDatasetFiltros.dataset.Edit;
  preencheFiltros;
  ajustaBotoesFiltros;
end;

procedure TfrmEditorConsultas.btnFiltroExcluirClick(Sender: TObject);
begin
  if not pergunta('Deseja excluir o filtro selecionado?') then
    exit;

  vDatasetFiltros.dataset.Delete;
  ajustaBotoesFiltros;

  geraPropriedades001;

end;

procedure TfrmEditorConsultas.btnFiltroNovoClick(Sender: TObject);
begin
  vDatasetFiltros.dataset.last;
  vDatasetFiltros.dataset.Append;
  preencheFiltros;
  ajustaBotoesFiltros;
end;

procedure TfrmEditorConsultas.geraPropriedades001;
  var
    m: IMultiConfig;
    s: String;
begin
  m := getMultiConfigPropriedades;
  m.deleteKey('filtros');
  vDatasetFiltros.dataset.First;
  while not vDatasetFiltros.dataset.Eof do
  begin
    m.writeString('filtros',trim(vDatasetFiltros.dataset.fields[0].AsString),trim(vDatasetFiltros.dataset.fields[1].AsString));
    vDatasetFiltros.dataset.Next;
  end;
  s := inputMemo('Verifique os valores','Propriedades', m.toString);

  vDatasetEndpoints.fieldByName('propriedades').AsString := s;

  getDatasetFiltros;
end;

procedure TfrmEditorConsultas.btnFiltroSalvarClick(Sender: TObject);
begin

  geraConfiguracoesFiltro;

  if (not pergunta('Deseja salvar o filtro selecionado?')) then
    exit;

  vDatasetFiltros.dataset.CheckBrowseMode;

  ajustaBotoesFiltros;

  geraPropriedades001;

end;

procedure TfrmEditorConsultas.ajustaBotoesCampos;
begin
  if(vDatasetCampos=nil) then
  begin
    gridCampos.Enabled := false;
    btnGestaoformatacoesEditar.Enabled := false;
    btnGestaoformatacoesSalvar.Enabled := false;
    btnGestaoformatacoesCancelar.Enabled := false;
    pnPropCampo.Enabled := false;
    exit;
  end;
  gridCampos.Enabled := vDatasetCampos.dataset.State=dsBrowse;
  pnPropCampo.Enabled := vDatasetCampos.dataset.State<>dsBrowse;

  btnGestaoformatacoesEditar.Enabled := (vDatasetCampos.dataset.State=dsBrowse) and (vDatasetCampos.dataset.RecordCount>0);
  btnGestaoformatacoesCancelar.Enabled := vDatasetCampos.dataset.State<>dsBrowse;
  btnGestaoformatacoesSalvar.Enabled := vDatasetCampos.dataset.State<>dsBrowse;
end;

procedure TfrmEditorConsultas.ajustaBotoesFiltros;
begin
  if(vDatasetFiltros=nil) then
  begin
    gridFiltros.Enabled := false;
    pnPropFiltro.Visible := false;
    btnFiltroEditar.Enabled := false;
    btnFiltroExcluir.Enabled := false;
    btnFiltroNovo.Enabled := false;
    btnFiltroCancelar.Enabled := false;
    btnFiltroSalvar.Enabled := false;
    exit;
  end;
  gridFiltros.Enabled := vDatasetFiltros.dataset.State=dsBrowse;
  pnPropFiltro.Visible := vDatasetFiltros.dataset.State<>dsBrowse;

  btnFiltroNovo.Enabled := vDatasetFiltros.dataset.State=dsBrowse;
  btnFiltroEditar.Enabled := (vDatasetFiltros.dataset.State=dsBrowse) and (vDatasetFiltros.dataset.RecordCount>0);
  btnFiltroCancelar.Enabled := vDatasetFiltros.dataset.State<>dsBrowse;
  btnFiltroSalvar.Enabled := vDatasetFiltros.dataset.State<>dsBrowse;
  btnFiltroExcluir.Enabled := (vDatasetFiltros.dataset.RecordCount>0) or (vDatasetFiltros.dataset.State = dsInsert);
end;

procedure TfrmEditorConsultas.ajustaBotoes;
begin
  ajustaBotoesFiltros;
  ajustaBotoesCampos;
  pnEdicao.Enabled := vDatasetEndpoints.dataset.State<>dsBrowse;
  gridEP.Enabled := vDatasetEndpoints.dataset.State=dsBrowse;
  btnNovo.Enabled := vDatasetEndpoints.dataset.State=dsBrowse;
  btnEditar.Enabled := vDatasetEndpoints.dataset.State=dsBrowse;
  btnCancelar.Enabled := vDatasetEndpoints.dataset.State<>dsBrowse;
  btnGravar.Enabled := vDatasetEndpoints.dataset.State<>dsBrowse;
end;

procedure TfrmEditorConsultas.btnNovoClick(Sender: TObject);
begin
  vDatasetEndpoints.dataset.Append;
  ajustaBotoes;
  edNome.Show;
  edNome.SetFocus;
end;

procedure TfrmEditorConsultas.openQuery;
  var
    ep: ITEndpointModel;
    i: Integer;
begin
  ep := vEPControl.getFromRecord(vDatasetEndpoints.dataset);
  ep.objeto.registros := 1;
  vQuery := ep.objeto.executaQuery;
  vDatasetCampos := getGenericID_DescricaoDataset(32,0,true);
  vDatasetCampos.dataset.Fields[0].DisplayLabel := 'Campo';
  for i := 0 to vQuery.dataset.FieldCount - 1 do
  begin
    if (pos(DBFIELDINTERNO,vQuery.dataset.Fields[i].FieldName,1)>0) then continue;

    vDatasetCampos.dataset.Append;
    vDatasetCampos.dataset.Fields[0].AsString := vQuery.dataset.Fields[i].FieldName;
    vDatasetCampos.dataset.CheckBrowseMode;
  end;
  dsCampos.DataSet := vDatasetCampos.dataset;
  ajustaBotoes;
  vDatasetCampos.dataset.First;
  preencheCampos;
end;

procedure TfrmEditorConsultas.btnFiltroCancelarClick(Sender: TObject);
begin
  if not pergunta('Deseja cancelar a edição do filtro selecionado?') then
    exit;

  vDatasetFiltros.dataset.Cancel;
  ajustaBotoesFiltros;
end;

procedure TfrmEditorConsultas.FormCreate(Sender: TObject);
begin
  vEPControl := getEndpointController(vIConexao);
end;

procedure TfrmEditorConsultas.FormShow(Sender: TObject);
begin
  query;
  PC.ActivePage := tsDados;
end;

function TfrmEditorConsultas.getDatasetFiltros: IDatasetSimples;
begin

  Result := getMultiConfigPropriedades.ReadSectionValuesLista('filtros').toDataset([],1000,1000);
  Result.dataset.Fields[1].Visible := false;
  Result.dataset.Fields[0].DisplayLabel := 'Filtro';
  Result.dataset.First;

  vDatasetFiltros := Result;
  dsFiltros.DataSet := vDatasetFiltros.dataset;
end;

function TfrmEditorConsultas.getMultiConfigPropriedades: IMultiConfig;
begin
  Result := criaMultiConfig.adicionaInterface(criaConfigIniString(vDatasetEndpoints.fieldByName('propriedades').AsString));
end;

class function TfrmEditorConsultas.getNewIface(pIConexao: IConexao): ITfrmEditorConsultas;
begin
  Result := TImplObjetoOwner<TfrmEditorConsultas>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TfrmEditorConsultas.gridCamposCellClick(Column: TXColumn);
begin
  preencheCampos;
end;

procedure TfrmEditorConsultas.PCChange(Sender: TObject);
begin
  if(PC.ActivePage=tsFormatações) then
    openQuery;
end;

function TfrmEditorConsultas.critica(pResultado: IResultadoOperacao=nil): IResultadoOperacao;
  var
    q: String;
    l: IListaTexto;
begin
  Result := checkResultadoOperacao(pResultado);
  if(trim(vDatasetEndpoints.fieldByName('nome').asString)='') then
    Result.adicionaErro('Falta definir o NOME do relatório.');

  q := trim(vDatasetEndpoints.fieldByName('query').asString);

  if(q='') then
    Result.adicionaErro('Falta definir o QUERY do relatório.');

  if(pos('<where>',q,1)=0) then
    Result.adicionaErro('Falta definir a tag <where> no query do relatório.');

//  if(pos('<group>',q,1)=0) then
//    Result.adicionaErro('Falta definir a tag <group> no query do relatório.)';

  if(pos('<order>',q,1)=0) then
    Result.adicionaErro('Falta definir a tag <order> no query do relatório.');

  l := novaListaTexto;
  l.text := trim(vDatasetEndpoints.fieldByName('descricao').asString);
  if (l.text='') or (l.strings.Count<>1) then
    Result.adicionaErro('Falta definir a DESCRIÇÂO corretamente com apena 1 linha.');


end;

procedure TfrmEditorConsultas.dsEPStateChange(Sender: TObject);
begin
  if(vDatasetEndpoints.dataset.RecordCount>0) then
    getDatasetFiltros;
end;

procedure TfrmEditorConsultas.edtFormatacaoCampoOperacoesClick(Sender: TObject);
begin
  edtFormatacaoCampoExpressao.Enabled := edtFormatacaoCampoOperacoes.ItemIndex=6;
end;

procedure TfrmEditorConsultas.query;
begin
  if(vDatasetEndpoints=nil) then
  begin
    vDatasetEndpoints := vIConexao.gdb.criaDataset;
    vDatasetEndpoints.dataset.BeforePost := beforePost;
    dsEP.DataSet := vDatasetEndpoints.dataset;
  end;

  vDatasetEndpoints.query('select * from endpoint where metodo=''RELATORIO'' ','',[]);

  vDatasetEndpoints.fieldByName('id').Visible := false;
  vDatasetEndpoints.fieldByName('metodo').Visible := false;

  ajustaBotoes;

end;

procedure TfrmEditorConsultas.TestarClick(Sender: TObject);
begin
  openQuery;
end;

constructor TfrmEditorConsultas._Create(pIConexao: IConexao);
begin
  inherited Create(nil);
  vIConexao := pIConexao;
end;

end.
