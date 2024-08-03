unit Form.Endpoint;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Interfaces.Conexao,
  FiltroModel,
  Terasoft.Framework.DB,
  EndpointController, EndpointModel, Vcl.StdCtrls, Vcl.DBCtrls,
  Terasoft.VCL.ComboBox, Vcl.Grids, XDBGrids, Vcl.Buttons;

type
  TformEP = class(TForm)
    cbEP: TTeraComboBox;
    grid: TXDBGrid;
    sbAbrir: TSpeedButton;
    cbFiltros: TTeraComboBox;
    lblConsulta: TLabel;
    Label1: TLabel;
    sbLImparFiltros: TSpeedButton;
    sbValoresFiltro: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure cbEPChange(Sender: TObject);
    procedure sbAbrirClick(Sender: TObject);
    procedure sbLImparFiltrosClick(Sender: TObject);
    procedure cbFiltrosChange(Sender: TObject);
    procedure sbValoresFiltroClick(Sender: TObject);
  private
    vIConexao:IConexao;
    epControl: IController_Endpoint;
    fSelecionado: ITEndpointModel;
    fLista: TListaEndpointModel;
    fFiltroSelecionado: ITFiltroModel;
    fDS: IDatasetSimples;
    procedure selecionaEP(ep: ITEndpointModel);
    { Private declarations }
  public
    constructor Create(pIConexao:IConexao);
    { Public declarations }
  end;

var
  formEP: TformEP;

  function criaViewEndpoint(pIConexao: IConexao):TformEP;

implementation
  uses
    FuncoesSelecaoLista;

{$R *.dfm}

procedure TformEP.cbEPChange(Sender: TObject);
begin
  sbValoresFiltro.Enabled:=false;
  sbAbrir.Enabled:=false;
  cbFiltros.Enabled := false;
  sbAbrir.Enabled := cbEP.ItemIndex<>-1;
  if(sbAbrir.Enabled=false) then exit;
  selecionaEP(fLista.Items[cbEP.ItemIndex]);
end;

procedure TformEP.cbFiltrosChange(Sender: TObject);
begin
  sbValoresFiltro.Enabled:=false;
  if(fSelecionado=nil) then exit;
  sbValoresFiltro.Enabled := cbFiltros.ItemIndex<>-1;
  if(sbValoresFiltro.Enabled=false) then exit;
  fFiltroSelecionado := fSelecionado.objeto.FILTROS.Items[cbFiltros.ItemIndex];
end;

constructor TformEP.Create(pIConexao: IConexao);
begin
  inherited Create(nil);
  vIConexao := pIConexao;
end;

procedure TformEP.FormCreate(Sender: TObject);
  var
    m: ITEndpointModel;
begin
  cbEP.Items.Clear;
  cbEP.values.Clear;
  cbEP.Text := '';
  epControl := getEndpointController(vIConexao);
  fLista := epControl.getLista;
  for m in fLista do
  begin
    //
    cbEp.items.add(m.objeto.DESCRICAO);
    cbEp.values.add(m.objeto.NOME);
  end;

end;

procedure TformEP.sbAbrirClick(Sender: TObject);
begin
  fDS := fSelecionado.objeto.executaQuery;
  grid.DataSource := fDS.dataSource;
end;

procedure TformEP.sbLImparFiltrosClick(Sender: TObject);
  var
    p: ITFiltroModel;
begin
  if(fSelecionado=nil) then exit;
  for p in fSelecionado.objeto.FILTROS do
    p.objeto.opcoesSelecionadas:=nil;
end;

procedure TformEP.sbValoresFiltroClick(Sender: TObject);
  var
    ds: IDatasetSimples;
begin
  if(fFiltroSelecionado=nil) then exit;

  //Podemos filtros quantos registos são retornados e a partir de qual...
  //fFiltroSelecionado.objeto.registros := 100;
  //fFiltroSelecionado.objeto.primeiro := 500;

  //Podemos passar a lista de palavras de pesquisa de id, descricao...
  //ds := fFiltroSelecionado.objeto.getOpcoes('ODERCO');

  ds := fFiltroSelecionado.objeto.getOpcoes;

  if(ds=nil) then
  begin
    fFiltroSelecionado.objeto.opcoesSelecionadas.text:=
          InputBox('Busca avançada','Texto', fFiltroSelecionado.objeto.opcoesSelecionadas.text);
    exit;
  end else
  begin
    fFiltroSelecionado.objeto.opcoesSelecionadas.text :=
          FuncoesSelecaoLista.SelecionaItems(fFiltroSelecionado.objeto.opcoesSelecionadas.text,ds.dataset,false,'',ds.dataset.Fields[0].FieldName);
  end;

end;

procedure TformEP.selecionaEP(ep: ITEndpointModel);
  var
    p: ITFiltroModel;
begin
  if(fSelecionado=ep) or (ep=nil) then
    exit;
  cbFiltros.Enabled := true;
  fSelecionado := ep;
  cbFiltros.Items.Clear;
  cbFiltros.values.Clear;
  for p in fSelecionado.objeto.FILTROS do
  begin
    cbFiltros.Items.Add(p.objeto.DESCRICAO);
    cbFiltros.Values.add(p.objeto.NOME);
  end;

end;

function criaViewEndpoint(pIConexao: IConexao):TformEP;
begin
  Result := TformEP.Create(pIConexao);
end;


end.
