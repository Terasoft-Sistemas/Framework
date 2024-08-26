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
  private
    { Private declarations }
  protected
    vDatasetEndpoints: IDataset;
    vDatasetFiltros,vDatasetFiltrosValores: IDatasetSimples;

    [weak] mySelf: ITfrmEditorConsultas;
    vIConexao:IConexao;
    epControl: IController_Endpoint;
    procedure query;
    procedure beforePost(DataSet: TDataSet);
    procedure ajustaBotoes;
    procedure ajustaBotoesFiltros;
    function critica(pResultado: IResultadoOperacao=nil): IResultadoOperacao;
    function getDatasetFiltros: IDatasetSimples;
    procedure preencheFiltros;
    procedure geraConfiguracoesFiltro;
    function getMultiConfigPropriedades: IMultiConfig;
    procedure geraPropriedades001;
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

procedure TfrmEditorConsultas.btnFiltroCancelarClick(Sender: TObject);
begin
  if not pergunta('Deseja cancelar a edição do filtro selecionado?') then
    exit;

  vDatasetFiltros.dataset.Cancel;
  ajustaBotoesFiltros;
end;

procedure TfrmEditorConsultas.FormCreate(Sender: TObject);
begin
  epControl := getEndpointController(vIConexao);
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
  epControl.getFromRecord(dsEP.DataSet);
end;

constructor TfrmEditorConsultas._Create(pIConexao: IConexao);
begin
  inherited Create(nil);
  vIConexao := pIConexao;
end;

end.
