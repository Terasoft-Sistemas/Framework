unit Form.Endpoint;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Interfaces.Conexao,
  FiltroModel,
  Terasoft.Framework.DB,
  Terasoft.Framework.ObjectIface,
  EndpointController, EndpointModel, Vcl.StdCtrls, Vcl.DBCtrls,
  Terasoft.VCL.ComboBox, Vcl.Grids, XDBGrids, Vcl.Buttons;

type

  TFormEP = class;
  ITFormEP=IObject<TFormEP>;


  TFormEP = class(TForm)
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
    [weak] mySelf: ITFormEP;
    vIConexao:IConexao;
    epControl: IController_Endpoint;
    fSelecionado: ITEndpointModel;
    fFiltroSelecionado: ITFiltroModel;
    fDS: IDatasetSimples;
    procedure selecionaEP(ep: ITEndpointModel);
  public
    //constructor Create(pIConexao:IConexao);
    constructor Create(pIConexao:IConexao);
    class function getNewIface(pIConexao: IConexao): ITFormEP;
  end;

var
  FormEP: TFormEP;

  function criaViewEndpoint(pIConexao: IConexao):ITFormEP;

implementation
  uses
    Terasoft.Framework.Conversoes,
    Terasoft.Framework.Texto,
    Terasoft.Framework.SCI.ValidacaoPadraoCamposTabelas,
    Terasoft.Framework.FuncoesDiversas,
    FuncoesSelecaoLista;

{$R *.dfm}

procedure TFormEP.cbEPChange(Sender: TObject);
begin
  sbValoresFiltro.Enabled:=false;
  sbAbrir.Enabled:=false;
  cbFiltros.Enabled := false;
  sbAbrir.Enabled := cbEP.ItemIndex<>-1;
  if(sbAbrir.Enabled=false) then exit;
//  epControl.lista.First.objeto.FILTROS.First.objeto.opcoesSelecionadas.strings.Add('mais este elemento');
  selecionaEP(epControl.lista.Items[cbEP.ItemIndex]);
end;

procedure TFormEP.cbFiltrosChange(Sender: TObject);
begin
  sbValoresFiltro.Enabled:=false;
  if(fSelecionado=nil) then exit;
  sbValoresFiltro.Enabled := cbFiltros.ItemIndex<>-1;
  if(sbValoresFiltro.Enabled=false) then exit;
  fFiltroSelecionado := fSelecionado.objeto.FILTROS.Items[cbFiltros.ItemIndex];
end;

constructor TFormEP.Create(pIConexao: IConexao);
begin
  inherited Create(nil);
  vIConexao := pIConexao;
end;

procedure TFormEP.FormCreate(Sender: TObject);
  var
    m: ITEndpointModel;
begin
  Caption := codificaEscape('"\');
  cbEP.Items.Clear;
  cbEP.values.Clear;
  cbEP.Text := '';
  epControl := getEndpointController(vIConexao);
  //Retorna a lista com busca no termo 'PROD'
  //Ordenado pelo campo DESCRICAO
//  for m in epControl.getNovaLista('prod',2) do
  for m in epControl.getNovaLista(nil,2) do
  begin
    cbEp.items.add(m.objeto.DESCRICAO);
    cbEp.values.add(m.objeto.NOME);
  end;

end;

class function TFormEP.getNewIface(pIConexao: IConexao): ITFormEP;
begin
  Result := TImplObjetoOwner<TFormEP>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TFormEP.sbAbrirClick(Sender: TObject);
begin
  if(fSelecionado=nil) then exit;

  fSelecionado.objeto.ordem := '2 desc';

  //fSelecionado.objeto.buscaAdicional := 'SAMSU';

  //Podemos filtrar quantos registos são retornados e a partir de qual...
  //fSelecionado.objeto.registros := 100;
  //fSelecionado.objeto.primeiro := 500;

  Caption := IntToStr(fSelecionado.objeto.contagem);

  fDS := fSelecionado.objeto.executaQuery;
  grid.DataSource := fDS.dataSource;
end;

procedure TFormEP.sbLImparFiltrosClick(Sender: TObject);
  var
    p: ITFiltroModel;
begin
  if(fSelecionado=nil) then exit;
  for p in fSelecionado.objeto.FILTROS do
    p.objeto.opcoesSelecionadas:=nil;
end;

procedure TFormEP.sbValoresFiltroClick(Sender: TObject);
  var
    ds: IDatasetSimples;
begin
  if(fFiltroSelecionado=nil) then exit;

  //Podemos filtros quantos registos são retornados e a partir de qual...
  //fFiltroSelecionado.objeto.registros := 100;
  //fFiltroSelecionado.objeto.primeiro := 500;

  //Podemos passar a lista de palavras de pesquisa de id, descricao...
  //ds := fFiltroSelecionado.objeto.getOpcoes('ODERCO');
  //Segundo parâmetro, determina o campo de ordem: 1-ID 2_DESCRICAO
  //ds := fFiltroSelecionado.objeto.getOpcoes('ODERCO',2);

  case fFiltroSelecionado.objeto.TIPO of

    tipoFiltro_Busca:
      fFiltroSelecionado.objeto.opcoesSelecionadas.text:=
          InputBox('Busca avançada','Texto', fFiltroSelecionado.objeto.opcoesSelecionadas.text);

    tipoFiltro_Set,tipoFiltro_SetSincrono:
    begin
      ds := fFiltroSelecionado.objeto.getOpcoes();
      fFiltroSelecionado.objeto.opcoesSelecionadas.text :=
          FuncoesSelecaoLista.SelecionaItems(fFiltroSelecionado.objeto.opcoesSelecionadas.text,ds.dataset,false,'',ds.dataset.Fields[0].FieldName);
    end;

    tipoFiltro_DataPeriodo:
    begin
        fFiltroSelecionado.objeto.dhInicial := selecionaData(fFiltroSelecionado.objeto.dhInicial,'Data Inicial');
        fFiltroSelecionado.objeto.dhFinal := selecionaData(fFiltroSelecionado.objeto.dhFinal,'Data Final');
    end;
    tipoFiltro_HoraPeriodo: ;

    tipoFiltro_DataHoraPeriodo:
        fFiltroSelecionado.objeto.dhInicial := selecionaData(fFiltroSelecionado.objeto.dhInicial);

  end;

end;

procedure TFormEP.selecionaEP(ep: ITEndpointModel);
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

function criaViewEndpoint(pIConexao: IConexao):ITFormEP;
begin
  Result := TformEP.getNewIface(pIConexao);
end;


end.
