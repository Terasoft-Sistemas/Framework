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
    edNome: TDBLabeledEdit;
    edDescricao: TDBMemo;
    lblDescricao: TLabel;
    tsFiltros: TTabSheet;
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
    dsImpressoes: TDataSource;
    gridImpressoes: TXDBGrid;
    Panel1: TPanel;
    btnImpressoesEditar: TBitBtn;
    btnImpressoesCancelar: TBitBtn;
    btnImpressoesSalvar: TBitBtn;
    btnImpressoesNovo: TBitBtn;
    btnImpressoesExcluir: TBitBtn;
    pnImpressoes: TPanel;
    edGroupBy: TLabeledEdit;
    edWhere: TLabeledEdit;
    edtFormatacaoCampoAlinhamento: TRadioGroup;
    PCImpressoes: TPageControl;
    tsImpressaoDados: TTabSheet;
    edtImpressaoNome: TLabeledEdit;
    edtImpressaoDescricao: TLabeledEdit;
    edtImpressaoTitulo: TLabeledEdit;
    edImpressaoOrientacao: TRadioGroup;
    tsImpressaoFormatacao: TTabSheet;
    gridImpressaoFormatacaoCampo: TXDBGrid;
    pnGestaoImpressao: TPanel;
    btnImpressaoEditar: TBitBtn;
    btnImpressaoCancelar: TBitBtn;
    btnImpressaoSalvar: TBitBtn;
    pnImpressaoFormatacao: TPanel;
    edtImpressaoFormatoVisivel: TCheckBox;
    edtImpressaoFormatoSumário: TCheckBox;
    edtImpressaoFormatoLabel: TLabeledEdit;
    edtImpressaoTituloSumario: TLabeledEdit;
    edtImpressaoFormatoTamanho: TLabeledEdit;
    edtImpressaoFormatoTamanhoSumario: TLabeledEdit;
    edtImpressaoFormatoAlinhamento: TRadioGroup;
    edtImpressaoFormatoAlinhamentoSumario: TRadioGroup;
    edtImpressaoFormatoFormato: TLabeledEdit;
    edtImpressaoFormatoFormatoSumario: TLabeledEdit;
    edtImpressaoFormatoPosicao: TLabeledEdit;
    edtImpressaoFormatoPosicaoSumario: TLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
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
    procedure btnImpressoesNovoClick(Sender: TObject);
    procedure btnImpressoesEditarClick(Sender: TObject);
    procedure btnImpressoesSalvarClick(Sender: TObject);
    procedure btnImpressoesCancelarClick(Sender: TObject);
    procedure btnImpressoesExcluirClick(Sender: TObject);
    procedure PCImpressoesChange(Sender: TObject);
    procedure btnImpressaoEditarClick(Sender: TObject);
    procedure gridImpressaoFormatacaoCampoCellClick(Column: TXColumn);
    procedure btnImpressaoCancelarClick(Sender: TObject);
    procedure btnImpressaoSalvarClick(Sender: TObject);
  private
    { Private declarations }
  protected
    vQuery: IDatasetSimples;
    vDatasetEndpoints: IDataset;
    vDatasetImpressoes, vDatasetCampos, vDatasetFiltros,vDatasetFiltrosValores: IDatasetSimples;


    [weak] mySelf: ITfrmEditorConsultas;
    vIConexao:IConexao;
    vEPControl: IController_Endpoint;
    procedure query;
    procedure beforePost(DataSet: TDataSet);
    function ajustaBotoes: boolean;
    function ajustaBotoesImpressoes: boolean;
    function ajustaBotoesFiltros: boolean;
    function ajustaBotoesCampos: boolean;
    function critica(pResultado: IResultadoOperacao=nil): IResultadoOperacao;
    function getDatasetFiltros: IDatasetSimples;
    procedure preencheFiltros;
    procedure preencheCampos;
    procedure preencheCamposImpressao;
    procedure preencheImpressoes;
    procedure geraConfiguracoesFiltro;
    function getMultiConfigPropriedades: IMultiConfig;
    procedure geraPropriedades001;
    procedure geraPropriedades002;
    procedure openQueryCampos;
    procedure openQueryImpressoes;
    procedure geraConfiguracoesImpressoes;
    procedure geraConfiguracoesImpressoesFormatos;
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
  var
    m: IMultiConfig;
    s: String;
begin
  m := getMultiConfigPropriedades;
  m.deleteKey('group');
  edGroupBy.Text := trim(edGroupBy.Text);
  if(edGroupBy.Text<>'') then
    m.WriteString('group','1',edGroupBy.Text);

  m.deleteKey('where');
  edWhere.Text := trim(edWhere.Text);
  if(edWhere.Text<>'') then
    m.WriteString('where','1',edWhere.Text);


  s :=  inputMemo('Verifique os valores','Propriedades', m.toString);

  vDatasetEndpoints.dataset.FieldByName('propriedades').AsString := s;

  with critica do
    if erros>0 then
      msgErro(toString);

  if not pergunta('Deseja salvar a edição do relatório?') then
    exit;

  vDatasetEndpoints.dataset.CheckBrowseMode;
  ajustaBotoes;
  edNome.Show;
end;

procedure TfrmEditorConsultas.btnImpressaoCancelarClick(Sender: TObject);
begin
  if not pergunta('Deseja cancelar a edição da formatação da impressão selecionada?') then
    exit;

  vDatasetCampos.dataset.Cancel;
  preencheCamposImpressao;
  ajustaBotoes;
  gridImpressaoFormatacaoCampo.SetFocus;
end;

procedure TfrmEditorConsultas.btnImpressaoEditarClick(Sender: TObject);
begin
  vDatasetCampos.dataset.Edit;
  preencheCamposImpressao;
  ajustaBotoes;
  edtImpressaoFormatoLabel.SetFocus;
end;

procedure TfrmEditorConsultas.btnImpressaoSalvarClick(Sender: TObject);
  var
    save: String;
begin
  save := vDatasetEndpoints.dataset.FieldByName('propriedades').AsString;
  geraConfiguracoesImpressoesFormatos;

  if (not pergunta('Deseja salvar a formatação da impressão selecionada?')) then
  begin
    vDatasetEndpoints.dataset.FieldByName('propriedades').AsString := save;
    exit;
  end;

  vDatasetCampos.dataset.CheckBrowseMode;

  openQueryCampos;
  ajustaBotoes;

  gridImpressaoFormatacaoCampo.SetFocus;
end;

procedure TfrmEditorConsultas.btnImpressoesCancelarClick(Sender: TObject);
begin
  if not pergunta('Deseja cancelar a edição da impressão selecionada?') then
    exit;

  vDatasetImpressoes.dataset.Cancel;
  ajustaBotoes;
  openQueryImpressoes;
  gridImpressoes.SetFocus;
end;

procedure TfrmEditorConsultas.btnImpressoesEditarClick(Sender: TObject);
begin
  vDatasetImpressoes.dataset.Edit;
  preencheImpressoes;
  ajustaBotoes;
  edtImpressaoNome.Show;
  edtImpressaoNome.SetFocus;
end;

procedure TfrmEditorConsultas.btnImpressoesExcluirClick(Sender: TObject);
  var
    cfg: IMultiConfig;
    s: String;
begin
  cfg := getMultiConfigPropriedades;
  cfg.deleteKey('impressoes',vDatasetImpressoes.dataset.Fields[0].AsString);

  s := inputMemo('Verifique os valores','Propriedades', cfg.toString);

  if not pergunta('Deseja excluir a impressão selecionada?') then
    exit;


  vDatasetEndpoints.fieldByName('propriedades').AsString := s;

  openQueryImpressoes;
  //vDatasetImpressoes.dataset.Delete;
  ajustaBotoes;
  gridImpressoes.SetFocus;
end;

procedure TfrmEditorConsultas.btnImpressoesNovoClick(Sender: TObject);
begin
  vDatasetImpressoes.dataset.last;
  vDatasetImpressoes.dataset.Append;
  preencheImpressoes;
  ajustaBotoes;
  edtImpressaoNome.Show;
  edtImpressaoNome.SetFocus;
end;

procedure TfrmEditorConsultas.btnImpressoesSalvarClick(Sender: TObject);
  var
    save: String;
begin
  save := vDatasetEndpoints.dataset.FieldByName('propriedades').AsString;
  geraConfiguracoesImpressoes;

  if (not pergunta('Deseja salvar a impressão selecionada?')) then
  begin
    vDatasetEndpoints.dataset.FieldByName('propriedades').AsString := save;
    exit;
  end;

  vDatasetImpressoes.dataset.CheckBrowseMode;

  ajustaBotoes;

  openQueryImpressoes;
  gridImpressoes.SetFocus;
end;

procedure TfrmEditorConsultas.btnCancelarClick(Sender: TObject);
begin
  if not pergunta('Deseja cancelar a edição do relatório?') then
    exit;
  vDatasetEndpoints.dataset.Cancel;
  edNome.Show;
  ajustaBotoes;
end;

procedure TfrmEditorConsultas.btnEditarClick(Sender: TObject);
  var
    l: IListaTexto;
begin
  if(vDatasetEndpoints.dataset.State=dsBrowse) then
    vDatasetEndpoints.dataset.Edit;
  ajustaBotoes;
  l := getMultiConfigPropriedades.ReadSectionValuesLista('group');
  edGroupBy.Text := '';
  if(l.strings.Count>0) then
    edGroupBy.Text := l.strings.ValueFromIndex[0];

  l := getMultiConfigPropriedades.ReadSectionValuesLista('where');
  edWhere.Text := '';
  if(l.strings.Count>0) then
    edWhere.Text := l.strings.ValueFromIndex[0];


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

procedure TfrmEditorConsultas.geraConfiguracoesImpressoes;
  var
    sName,sDescricao,sTitulo,sValores,tmp1,tmp2: String;
    i: Integer;
    cfg: IMultiConfig;
    s: String;
begin

  sName := trim(edtImpressaoNome.Text);
  if(sName='') then
    msgErro('Nome da impressão deve ser preenchido.');
  sDescricao := trim(edtImpressaoDescricao.Text);
  sTitulo := trim(edtImpressaoTitulo.Text);
  if(sTitulo<>'') then
    sDescricao := sDescricao + '|'+sTitulo;

  cfg := getMultiConfigPropriedades;
  if (vDatasetImpressoes.dataset.fields[0].AsString<>'') and (CompareText(sName, vDatasetImpressoes.dataset.fields[0].AsString)<>0) then
  begin
    cfg.deleteKey('impressoes',vDatasetImpressoes.dataset.fields[0].AsString);
    //apagar demais??
  end;
  cfg.WriteString('impressoes',sName,sDescricao);

  if(edImpressaoOrientacao.ItemIndex=0) then
    CFG.deleteKey('impressao.'+sName,'pagina.orientacao')
  else
    CFG.WriteInteger('impressao.'+sName,'pagina.orientacao',1);

  s := inputMemo('Verifique os valores','Propriedades', cfg.toString);
  vDatasetEndpoints.fieldByName('propriedades').AsString := s;

end;

procedure TfrmEditorConsultas.geraConfiguracoesImpressoesFormatos;
  var
    save: String;
  var
    lCfg: IMultiConfig;
    campo: String;
    lNome: String;
    f: TField;
begin
  if(vDatasetImpressoes=nil) then exit;
  if(vQuery=nil) then exit;

  save := vDatasetEndpoints.fieldByName('propriedades').AsString;

  lNome := vDatasetImpressoes.dataset.Fields[0].AsString;
  campo := vDatasetCampos.dataset.Fields[0].AsString;
  f := vQuery.dataset.FieldByName(campo);
  if(f=nil) then
    msgErro('Campo não existe.');
  lCFG := getMultiConfigPropriedades;

  try

    //Criticas


    //fim das críticas

    //edtImpressaoFormatoSumário.Enabled := f is TNumericField;
    lCFG.writeBool('impressao.'+lNome,campo,edtImpressaoFormatoVisivel.Checked);
    lCFG.writeBool('impressao.sumario.'+lNome,campo,edtImpressaoFormatoSumário.Checked);

    if(edtImpressaoFormatoLabel.Text='') then
      lCFG.deleteKey('impressao.label.'+lnome,campo)
    else
      lCFG.WriteString('impressao.label.'+lnome,campo,edtImpressaoFormatoLabel.Text);

    if (edtImpressaoTituloSumario.Text='') then
      lCFG.deleteKey('impressao.sumario.label.'+lnome,campo)
    else
      lCFG.WriteString('impressao.sumario.label.'+lnome,campo,edtImpressaoTituloSumario.Text);

    if (edtImpressaoFormatoTamanho.Text='') then
      lCFG.deleteKey('impressao.largura.'+lnome,campo)
    else
      lCFG.WriteString('impressao.largura.'+lnome,campo,edtImpressaoFormatoTamanho.Text);

    if (edtImpressaoFormatoTamanhoSumario.Text='') then
      lCFG.deleteKey('impressao.sumario.largura.'+lnome,campo)
    else
      lCFG.WriteString('impressao.sumario.largura.'+lnome,campo,edtImpressaoFormatoTamanhoSumario.Text);

    if(edtImpressaoFormatoAlinhamento.ItemIndex=0) then
      lCFG.deleteKey('impressao.alinhamento.'+lNome,campo)
    else
      lCFG.WriteInteger('impressao.alinhamento.'+lNome,campo, edtImpressaoFormatoAlinhamento.ItemIndex-1);

    if(edtImpressaoFormatoAlinhamentoSumario.ItemIndex=0) then
      lCFG.deleteKey('impressao.sumario.alinhamento.'+lNome,campo)
    else
      lCFG.WriteInteger('impressao.sumario.alinhamento.'+lNome,campo, edtImpressaoFormatoAlinhamentoSumario.ItemIndex-1);

    if (edtImpressaoFormatoFormato.Text='') then
      lCFG.deleteKey('impressao.formato.'+lnome,campo)
    else
      lCFG.WriteString('impressao.formato.'+lnome,campo,edtImpressaoFormatoFormato.Text);

    if (edtImpressaoFormatoFormatoSumario.Text='') then
      lCFG.deleteKey('impressao.sumario.formato.'+lnome,campo)
    else
      lCFG.WriteString('impressao.sumario.formato.'+lnome,campo,edtImpressaoFormatoFormatoSumario.Text);

    save := inputMemo('Verifique os valores','Propriedades', lCFG.toString);

  finally
    vDatasetEndpoints.fieldByName('propriedades').AsString := save;
  end;

  //
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

  if(edtFormatacaoCampoAlinhamento.ItemIndex=0) then
    lCFG.deleteKey('alinhamento', campo)
  else
    lCFG.WriteInteger('alinhamento', campo, edtFormatacaoCampoAlinhamento.ItemIndex-1);


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

procedure TfrmEditorConsultas.preencheImpressoes;
  var
    lCfg: IMultiConfig;
    sNome, s: String;
begin
  if(vDatasetImpressoes=nil) then exit;
  lCFG := getMultiConfigPropriedades;

  sNome := trim(vDatasetImpressoes.dataset.Fields[0].AsString);
  edtImpressaoNome.Text := sNome;

  s := lCfg.ReadString('impressoes',sNome,'');
  edtImpressaoDescricao.Text := textoEntreTags(s,'','|');
  if(edtImpressaoDescricao.Text='') then
    edtImpressaoDescricao.Text := s;
  edtImpressaoTitulo.Text := textoEntreTags(s,'|','');

  edImpressaoOrientacao.ItemIndex := lCFG.ReadInteger('impressao.'+sNome,'pagina.orientacao',0);

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

  edtFormatacaoCampoAlinhamento.ItemIndex := lCFG.ReadInteger('alinhamento', campo, -1)+1;
end;

procedure TfrmEditorConsultas.preencheCamposImpressao;
  var
    lCfg: IMultiConfig;
    campo: String;
    lNome: String;
    f: TField;
begin
  if(vDatasetImpressoes=nil) then exit;
  if(vQuery=nil) then exit;
  lNome := vDatasetImpressoes.dataset.Fields[0].AsString;
  campo := vDatasetCampos.dataset.Fields[0].AsString;
  f := vQuery.dataset.FieldByName(campo);
  if(f=nil) then
    exit;
  lCFG := getMultiConfigPropriedades;

  edtImpressaoFormatoVisivel.Checked := lCFG.ReadBool('impressao.'+lNome,campo,true);

  edtImpressaoFormatoSumário.Enabled := f is TNumericField;
  edtImpressaoFormatoSumário.Checked := lCFG.ReadBool('impressao.sumario.'+lNome,campo,true);

  edtImpressaoFormatoLabel.Text := lCFG.ReadString('impressao.label.'+lnome,campo,'');
  edtImpressaoTituloSumario.Text := lCFG.ReadString('impressao.sumario.label.'+lnome,campo,'');
  edtImpressaoFormatoTamanho.Text := lCFG.ReadString('impressao.largura.'+lnome,campo,'');
  edtImpressaoFormatoTamanhoSumario.Text := lCFG.ReadString('impressao.sumario.largura.'+lnome,campo,'');

  edtImpressaoFormatoAlinhamento.ItemIndex := lCFG.ReadInteger('impressao.alinhamento.'+lNome,campo, -1)+1;
  edtImpressaoFormatoAlinhamentoSumario.ItemIndex := lCFG.ReadInteger('impressao.sumario.alinhamento.'+lNome,campo, -1)+1;

  edtImpressaoFormatoFormato.Text := lCFG.ReadString('impressao.formato.'+lnome,campo,'');
  edtImpressaoFormatoFormatoSumario.Text := lCFG.ReadString('impressao.sumario.formato.'+lnome,campo,'');

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

procedure TfrmEditorConsultas.geraPropriedades002;
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

function TfrmEditorConsultas.ajustaBotoesCampos;
begin
  if(vDatasetCampos=nil) then
  begin
    Result := true;
    gridCampos.Enabled := false;
    gridImpressaoFormatacaoCampo.Enabled := false;

    btnGestaoformatacoesEditar.Enabled := false;
    btnImpressaoEditar.Enabled := false;

    btnGestaoformatacoesSalvar.Enabled := false;
    btnImpressaoSalvar.Enabled := false;

    btnGestaoformatacoesCancelar.Enabled := false;
    btnImpressaoCancelar.Enabled := false;

    pnPropCampo.Enabled := false;
    pnImpressaoFormatacao.Enabled := false;
    exit;
  end;
  Result :=vDatasetCampos.dataset.State=dsBrowse;

  gridCampos.Enabled := vDatasetCampos.dataset.State=dsBrowse;
  gridImpressaoFormatacaoCampo.Enabled := vDatasetCampos.dataset.State=dsBrowse;

  pnPropCampo.Enabled := vDatasetCampos.dataset.State<>dsBrowse;
  pnImpressaoFormatacao.Enabled := vDatasetCampos.dataset.State<>dsBrowse;

  btnGestaoformatacoesEditar.Enabled := (vDatasetCampos.dataset.State=dsBrowse) and (vDatasetCampos.dataset.RecordCount>0);
  btnImpressaoEditar.Enabled := btnGestaoformatacoesEditar.Enabled;

  btnGestaoformatacoesCancelar.Enabled := vDatasetCampos.dataset.State<>dsBrowse;
  btnImpressaoCancelar.Enabled := btnGestaoformatacoesCancelar.Enabled;

  btnGestaoformatacoesSalvar.Enabled := vDatasetCampos.dataset.State<>dsBrowse;
  btnImpressaoSalvar.Enabled := btnGestaoformatacoesSalvar.Enabled;
end;

function TfrmEditorConsultas.ajustaBotoesImpressoes;
  var
    rCampo: boolean;
begin
  rCampo := (vDatasetCampos=nil) or (vDatasetCampos.dataset.State=dsBrowse);
  if(vDatasetImpressoes=nil) then
  begin
    Result := true;
    gridImpressoes.enabled := false;
    btnImpressoesEditar.Enabled := false;
    btnImpressoesCancelar.Enabled := false;
    btnImpressoesSalvar.Enabled := false;
    btnImpressoesNovo.Enabled := false;
    btnImpressoesExcluir.Enabled := false;
    pnImpressoes.Enabled := false;
    exit;
  end;
  Result := vDatasetImpressoes.dataset.State=dsBrowse;
  gridImpressoes.Enabled := vDatasetImpressoes.dataset.State=dsBrowse;
  pnImpressoes.Enabled := vDatasetImpressoes.dataset.State<>dsBrowse;
  btnImpressoesEditar.Enabled := rCampo and (vDatasetImpressoes.dataset.State=dsBrowse) and (vDatasetImpressoes.dataset.RecordCount>0);
  btnImpressoesCancelar.Enabled := rCampo and (vDatasetImpressoes.dataset.State<>dsBrowse);
  btnImpressoesSalvar.Enabled := rCampo and (vDatasetImpressoes.dataset.State<>dsBrowse);
  btnImpressoesNovo.Enabled := rCampo and (vDatasetImpressoes.dataset.State=dsBrowse);
  btnImpressoesExcluir.Enabled := rCampo and ((vDatasetImpressoes.dataset.RecordCount>0) or (vDatasetImpressoes.dataset.State = dsInsert));

end;

function TfrmEditorConsultas.ajustaBotoesFiltros;
begin
  if(vDatasetFiltros=nil) then
  begin
    Result := true;
    gridFiltros.Enabled := false;
    pnPropFiltro.Visible := false;
    btnFiltroEditar.Enabled := false;
    btnFiltroExcluir.Enabled := false;
    btnFiltroNovo.Enabled := false;
    btnFiltroCancelar.Enabled := false;
    btnFiltroSalvar.Enabled := false;
    exit;
  end;
  Result := vDatasetFiltros.dataset.State=dsBrowse;
  gridFiltros.Enabled := vDatasetFiltros.dataset.State=dsBrowse;
  pnPropFiltro.Visible := vDatasetFiltros.dataset.State<>dsBrowse;

  btnFiltroEditar.Enabled := (vDatasetFiltros.dataset.State=dsBrowse) and (vDatasetFiltros.dataset.RecordCount>0);
  btnFiltroCancelar.Enabled := vDatasetFiltros.dataset.State<>dsBrowse;
  btnFiltroSalvar.Enabled := vDatasetFiltros.dataset.State<>dsBrowse;
  btnFiltroNovo.Enabled := vDatasetFiltros.dataset.State=dsBrowse;
  btnFiltroExcluir.Enabled := (vDatasetFiltros.dataset.RecordCount>0) or (vDatasetFiltros.dataset.State = dsInsert);
end;

function TfrmEditorConsultas.ajustaBotoes;
begin
{$B+}
  Result := ajustaBotoesFiltros and ajustaBotoesCampos and ajustaBotoesImpressoes;
{$B-}
  if(Result=false) then
  begin
    pnEdicao.Enabled := true;
    gridEP.Enabled := false;
    btnNovo.Enabled := false;
    btnEditar.Enabled := false;
    btnCancelar.Enabled := false;
    btnGravar.Enabled := false;
    exit;
  end;
  Result := vDatasetEndpoints.dataset.State=dsBrowse;
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

procedure TfrmEditorConsultas.openQueryCampos;
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
  preencheCamposImpressao;
end;

procedure TfrmEditorConsultas.openQueryImpressoes;
  var
    i: Integer;
    l: IListaTexto;
begin
  vDatasetImpressoes := getGenericID_DescricaoDataset(50,0,true);
  vDatasetImpressoes.dataset.Fields[0].DisplayLabel := 'Impressão';
  vDatasetImpressoes.dataset.Fields[0].DisplayWidth := 35;
  l := getMultiConfigPropriedades.ReadSectionValuesLista('impressoes');
  for i := 0 to l.strings.Count - 1 do
  begin
    vDatasetImpressoes.dataset.Append;
    vDatasetImpressoes.dataset.Fields[0].AsString := l.strings.Names[i];
    vDatasetImpressoes.dataset.CheckBrowseMode;
  end;
  dsImpressoes.DataSet := vDatasetImpressoes.dataset;
  ajustaBotoes;
  vDatasetImpressoes.dataset.First;
  preencheImpressoes;
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
  PC.ActivePageIndex := 0;
  PCImpressoes.ActivePageIndex := 0;
end;

procedure TfrmEditorConsultas.FormShow(Sender: TObject);
begin
  query;
  PC.ActivePage := tsDados;
end;

function TfrmEditorConsultas.getDatasetFiltros: IDatasetSimples;
  var
    cfg: IMultiConfig;
begin
  cfg := getMultiConfigPropriedades;
  if(cfg.ReadSectionValuesLista('filtros').Strings.Count= 0) then
  begin
    cfg.WriteString('filtros','@filiais','');
    cfg.WriteString('filtros','@busca','');
    vDatasetEndpoints.dataset.FieldByName('propriedades').AsString := cfg.toString;
  end;

  Result := getMultiConfigPropriedades.ReadSectionValuesLista('filtros').toDataset([],1000,1000);
  Result.dataset.Fields[1].Visible := false;
  Result.dataset.Fields[0].DisplayLabel := 'Filtro';
  Result.dataset.First;

  vDatasetFiltros := Result;
  dsFiltros.DataSet := vDatasetFiltros.dataset;
  ajustaBotoesFiltros;
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

procedure TfrmEditorConsultas.gridImpressaoFormatacaoCampoCellClick(Column: TXColumn);
begin
  preencheCamposImpressao;
end;

procedure TfrmEditorConsultas.PCChange(Sender: TObject);
begin
  if(PC.ActivePage=tsFormatações) then
    openQueryCampos
  else if(PC.ActivePage=tsImpressoes) then
    openQueryImpressoes
  else if(PC.ActivePage = tsFiltros) then
    getDatasetFiltros;

end;

procedure TfrmEditorConsultas.PCImpressoesChange(Sender: TObject);
begin
  if(PCImpressoes.ActivePage=tsImpressaoFormatacao) then
    openQueryCampos
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
//    getDatasetFiltros;
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

constructor TfrmEditorConsultas._Create(pIConexao: IConexao);
begin
  inherited Create(nil);
  vIConexao := pIConexao;
end;

end.
