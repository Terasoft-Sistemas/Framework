unit Impressao.Contratos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, RLReport, RLBarcode,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  RLXLSXFilter, RLFilters, RLPDFFilter, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Terasoft.Utils, Interfaces.Conexao, xPNGimage,
  Vcl.Imaging.jpeg, PedidoVendaModel, Terasoft.FuncoesTexto;

type
  TImpressaoContratos = class(TForm)
    PageControl1: TPageControl;
    GarantidaEstendida: TTabSheet;
    dsItens: TDataSource;
    dsCliente: TDataSource;
    mtCliente: TFDMemTable;
    mtClienteCLIENTE_NOME: TStringField;
    mtClienteRAZAO_SOCIAL: TStringField;
    mtClienteCNPJ_CPF: TStringField;
    mtClienteENDERECO: TStringField;
    mtClienteNUMERO: TStringField;
    mtClienteCOMPLEMENTO: TStringField;
    mtClienteBAIRRO: TStringField;
    mtClienteCIDADE: TStringField;
    mtClienteUF: TStringField;
    mtClienteCEP: TStringField;
    mtClienteCELULAR: TStringField;
    mtClienteTELEFONE: TStringField;
    mtClienteEMAIL: TStringField;
    mtClienteCONTATO: TStringField;
    mtItens: TFDMemTable;
    mtItensID: TStringField;
    mtItensPRODUTO_ID: TStringField;
    mtItensPRODUTO: TStringField;
    mtItensQUANTIDADE: TFloatField;
    mtItensVALOR_UNITARIO: TFloatField;
    mtItensVALOR_TOTAL: TFloatField;
    dsPedido: TDataSource;
    rlFilterXSLX: TRLXLSXFilter;
    mtPedido: TFDMemTable;
    mtPedidoNUMERO: TStringField;
    mtPedidoEMISSAO: TStringField;
    mtPedidoHORA: TStringField;
    mtPedidoOBSERVACAO: TStringField;
    mtPedidoTIPO_VENDA: TStringField;
    mtPedidoVENDEDOR: TStringField;
    mtPedidoVALOR_PRODUTOS: TFloatField;
    mtPedidoVALOR_DESCONTO: TFloatField;
    mtPedidoVALOR_ACRESCIMO: TFloatField;
    mtPedidoVALOR_FRETE: TFloatField;
    mtPedidoVALOR_TOTAL: TFloatField;
    mtPedidoCLIENTE_ID: TStringField;
    mtPedidoNUMERO_NF: TStringField;
    rlFilterPDF: TRLPDFFilter;
    mtClienteRG: TStringField;
    mtItensVLR_GARANTIA: TFloatField;
    mtItensMONTAGEM: TStringField;
    mtItensTIPO_GARANTIA: TStringField;
    mtItensUNIDADE_PRO: TStringField;
    mtItensENTREGA: TStringField;
    mtItensTIPO: TStringField;
    mtItensTIPO_ENTREGA: TStringField;
    mtPedidoTOTAL_GARANTIA: TFloatField;
    mtPedidoSEGURO_PRESTAMISTA: TFloatField;
    mtItensTIPO_GARANTIA_FR: TStringField;
    mtItensOBSERVACAO: TStringField;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    RLReport1: TRLReport;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel30: TRLLabel;
    RLLabel31: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel36: TRLLabel;
    RLLabel37: TRLLabel;
    RLImage4: TRLImage;
    RLDraw6: TRLDraw;
    RLLabel38: TRLLabel;
    RLLabel39: TRLLabel;
    RLLabel40: TRLLabel;
    RLLabel41: TRLLabel;
    RLDraw8: TRLDraw;
    RLDraw9: TRLDraw;
    RLLabel42: TRLLabel;
    RLLabel43: TRLLabel;
    RLLabel44: TRLLabel;
    RLImage5: TRLImage;
    RLDraw10: TRLDraw;
    RLLabel45: TRLLabel;
    RLLabel46: TRLLabel;
    RLLabel47: TRLLabel;
    RLLabel48: TRLLabel;
    RLLabel49: TRLLabel;
    RLLabel50: TRLLabel;
    RLImage6: TRLImage;
    RLLabel51: TRLLabel;
    RLLabel52: TRLLabel;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    RLReport2: TRLReport;
    RLMemo1: TRLMemo;
    RLImage7: TRLImage;
    RLReport3: TRLReport;
    RLReport4: TRLReport;
    RLLabel1: TRLLabel;
    RLImage1: TRLImage;
    RLImage2: TRLImage;
    RLImage3: TRLImage;
    RLImage8: TRLImage;
    PageControl3: TPageControl;
    TabSheet5: TTabSheet;
    RLReport5: TRLReport;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLLabel10: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLImage9: TRLImage;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel16: TRLLabel;
    RLDraw3: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel24: TRLLabel;
    RLImage11: TRLImage;
    RLLabel26: TRLLabel;
    RLLabel53: TRLLabel;
    TabSheet6: TTabSheet;
    RLReport6: TRLReport;
    TabSheet7: TTabSheet;
    RLReport7: TRLReport;
    TabSheet8: TTabSheet;
    RLReport8: TRLReport;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel19: TRLLabel;
    RLDraw7: TRLDraw;
    RLDraw11: TRLDraw;
    RLLabel55: TRLLabel;
    RLLabel56: TRLLabel;
    RLLabel57: TRLLabel;
    RLLabel58: TRLLabel;
    RLLabel59: TRLLabel;
    RLLabel60: TRLLabel;
    RLLabel61: TRLLabel;
    RLLabel62: TRLLabel;
    RLImage10: TRLImage;
    RLImage12: TRLImage;
    RLImage17: TRLImage;
    RLImage13: TRLImage;
    RLImage14: TRLImage;
    RLImage15: TRLImage;
    TabSheet9: TTabSheet;
    RLReport9: TRLReport;
    RLImage16: TRLImage;
    RLMemo2: TRLMemo;
    TabSheet10: TTabSheet;
    PageControl4: TPageControl;
    TabSheet11: TTabSheet;
    RLReport10: TRLReport;
    RLLabel23: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel54: TRLLabel;
    RLLabel63: TRLLabel;
    RLLabel64: TRLLabel;
    RLLabel65: TRLLabel;
    RLLabel66: TRLLabel;
    RLLabel67: TRLLabel;
    RLLabel68: TRLLabel;
    RLLabel69: TRLLabel;
    RLLabel70: TRLLabel;
    RLImage18: TRLImage;
    RLDraw12: TRLDraw;
    RLDraw13: TRLDraw;
    RLLabel71: TRLLabel;
    RLLabel72: TRLLabel;
    RLLabel73: TRLLabel;
    RLLabel74: TRLLabel;
    RLDraw14: TRLDraw;
    RLDraw15: TRLDraw;
    RLDraw16: TRLDraw;
    RLLabel75: TRLLabel;
    RLLabel76: TRLLabel;
    RLLabel77: TRLLabel;
    RLLabel78: TRLLabel;
    RLImage19: TRLImage;
    RLLabel79: TRLLabel;
    RLLabel80: TRLLabel;
    RLLabel81: TRLLabel;
    RLLabel82: TRLLabel;
    RLLabel83: TRLLabel;
    RLDraw17: TRLDraw;
    RLDraw18: TRLDraw;
    RLLabel84: TRLLabel;
    RLLabel85: TRLLabel;
    RLLabel86: TRLLabel;
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel89: TRLLabel;
    RLLabel90: TRLLabel;
    RLLabel91: TRLLabel;
    TabSheet12: TTabSheet;
    RLReport11: TRLReport;
    RLImage21: TRLImage;
    RLImage22: TRLImage;
    TabSheet13: TTabSheet;
    RLReport12: TRLReport;
    RLImage23: TRLImage;
    RLImage24: TRLImage;
    TabSheet14: TTabSheet;
    RLReport13: TRLReport;
    TabSheet15: TTabSheet;
    RLReport14: TRLReport;
    TabSheet16: TTabSheet;
    RLDraw19: TRLDraw;
    RLLabel92: TRLLabel;
    RLImage20: TRLImage;
    RLImage25: TRLImage;
    RLImage27: TRLImage;
    RLImage26: TRLImage;
    RLReport15: TRLReport;
    RLImage28: TRLImage;
    RLMemo3: TRLMemo;
    TabSheet17: TTabSheet;
    PageControl5: TPageControl;
    TabSheet18: TTabSheet;
    RLReport16: TRLReport;
    RLLabel93: TRLLabel;
    RLLabel94: TRLLabel;
    RLLabel95: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    RLLabel99: TRLLabel;
    RLLabel100: TRLLabel;
    RLLabel101: TRLLabel;
    RLImage29: TRLImage;
    TabSheet19: TTabSheet;
    RLReport17: TRLReport;
    TabSheet20: TTabSheet;
    RLReport18: TRLReport;
    RLImage34: TRLImage;
    RLImage35: TRLImage;
    TabSheet21: TTabSheet;
    RLReport19: TRLReport;
    RLImage36: TRLImage;
    RLImage37: TRLImage;
    TabSheet22: TTabSheet;
    RLReport20: TRLReport;
    RLImage38: TRLImage;
    TabSheet23: TTabSheet;
    RLReport21: TRLReport;
    RLImage39: TRLImage;
    TabSheet24: TTabSheet;
    RLImage30: TRLImage;
    RLImage31: TRLImage;
    RLImage32: TRLImage;
    RLLabel98: TRLLabel;
    RLLabel102: TRLLabel;
    RLLabel103: TRLLabel;
    RLLabel104: TRLLabel;
    RLReport22: TRLReport;
    RLImage33: TRLImage;
    RLMemo4: TRLMemo;
    RLDraw20: TRLDraw;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    mtClienteNASCIMENTO: TStringField;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    mtProdutos: TFDMemTable;
    dsProdutos: TDataSource;
    mtProdutosNOME_MAR: TStringField;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    RLDBText11: TRLDBText;
    mtReceber: TFDMemTable;
    dsReceber: TDataSource;
    mtReceberNOME_PORT: TStringField;
    RLDBText12: TRLDBText;
    RLLabel105: TRLLabel;
    RLDBText13: TRLDBText;
    RLDBText14: TRLDBText;
    RLDBText15: TRLDBText;
    RLDBText16: TRLDBText;
    RLDBText17: TRLDBText;
    RLDBText18: TRLDBText;
    RLDBText19: TRLDBText;
    RLDBText20: TRLDBText;
    RLDBText21: TRLDBText;
    RLDBText22: TRLDBText;
    RLDBText23: TRLDBText;
    RLDBText24: TRLDBText;
    RLDBText25: TRLDBText;
    RLDBText26: TRLDBText;
    RLDBText27: TRLDBText;
    RLDBText28: TRLDBText;
    RLDBText29: TRLDBText;
    RLDBText30: TRLDBText;
    RLDBText31: TRLDBText;
    RLDBText32: TRLDBText;
    RLDBText33: TRLDBText;
    RLDBText34: TRLDBText;
    RLDBText35: TRLDBText;
    RLDBText36: TRLDBText;
    RLDBText37: TRLDBText;
    RLDBText38: TRLDBText;
    RLDBText39: TRLDBText;
    RLDBText40: TRLDBText;
    RLDBText41: TRLDBText;
    RLDBText42: TRLDBText;
    RLDBText43: TRLDBText;
    RLDBText44: TRLDBText;
    RLDBText45: TRLDBText;
    RLDBText46: TRLDBText;
    dsEmpresa: TDataSource;
    mtEmpresa: TFDMemTable;
    mtEmpresaCNPJ: TStringField;
    RLDBText47: TRLDBText;
    RLDBText48: TRLDBText;
    RLDBText49: TRLDBText;
    RLDBText50: TRLDBText;
    mtReceberItens: TFDMemTable;
    dsReceberItens: TDataSource;
    mtReceberItensVALOR_PARCELA: TFloatField;
    mtReceberItensTOTAL_PARCELAS: TIntegerField;
    RLDBText51: TRLDBText;
    RLDBText52: TRLDBText;
    mtReceberVALOR_REC: TFloatField;
    RLDBText53: TRLDBText;
    mtEmpresaLOCAL_DATA: TStringField;
    RLDBText54: TRLDBText;
    RLDBText55: TRLDBText;
    RLDBText56: TRLDBText;
    RLDBText57: TRLDBText;
    mtProdutosNOME_PRO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPREVIEW: Variant;
    FDIR: Variant;
    FPDF: Variant;
    FNOMEARQUIVO: Variant;
    FIDPEDIDO: Variant;
    FCNPJEMPRESA: Variant;
    FCONTADOR: Variant;
    FDIRLOGO: Variant;
    FCONEXAO: IConexao;
    procedure SetCNPJEMPRESA(const Value: Variant);
    procedure SetCONTADOR(const Value: Variant);
    procedure SetDIR(const Value: Variant);
    procedure SetDIRLOGO(const Value: Variant);
    procedure SetIDPEDIDO(const Value: Variant);
    procedure SetNOMEARQUIVO(const Value: Variant);
    procedure SetPDF(const Value: Variant);
    procedure SetPREVIEW(const Value: Variant);
    procedure SetCONEXAO(const Value: IConexao);
    { Private declarations }
  public

    vGarantia : Double;

    property IDPEDIDO: Variant read FIDPEDIDO write SetIDPEDIDO;
    property NOMEARQUIVO: Variant read FNOMEARQUIVO write SetNOMEARQUIVO;
    property PREVIEW: Variant read FPREVIEW write SetPREVIEW;
    property PDF: Variant read FPDF write SetPDF;
    property DIR: Variant read FDIR write SetDIR;
    property CNPJEMPRESA : Variant read FCNPJEMPRESA write SetCNPJEMPRESA;
    property CONTADOR: Variant read FCONTADOR write SetCONTADOR;
    property DIRLOGO: Variant read FDIRLOGO write SetDIRLOGO;
    property CONEXAO: IConexao read FCONEXAO write SetCONEXAO;

    procedure imprimir;
    procedure fetchPedido;
    procedure fetchCliente;
    procedure fetchPedidoItens;
    procedure fetchMemo(lPedidoVendaModel : TPedidoVendaModel);
    procedure fetchEmpresa;

    { Public declarations }
  end;

var
	ImpressaoContratos: TImpressaoContratos;

implementation

uses
  Winapi.ActiveX, ClienteModel, PedidoItensModel, EmpresaModel, WebPedidoModel, WebPedidoItensModel,
  FinanceiroPedidoModel, ProdutosModel, LojasModel, Terasoft.Types, ContasReceberModel, ContasReceberItensModel;

{$R *.dfm}

procedure TImpressaoContratos.FormCreate(Sender: TObject);
begin
  CoInitialize(nil);
  mtCliente.Open;
  mtPedido.Open;
  mtReceber.Open;
  mtItens.Open;
  mtProdutos.Open;
  mtEmpresa.Open;
  mtReceberItens.Open;
end;

procedure TImpressaoContratos.FormDestroy(Sender: TObject);
begin
 CoUninitialize;
end;

procedure TImpressaoContratos.fetchCliente;
var
  lClienteModel : TClienteModel;
begin

  lClienteModel := TClienteModel.Create(CONEXAO);
  try
//    if mtPedidoCLIENTE_ID.AsString = '' then
//      raise Exception.Create('ID do Cliente não localizado');
//
    lClienteModel.IDRecordView := '005968';
    lClienteModel.obterLista;
//
//    if Length(lClienteModel.ClientesLista[0].CNPJ_CPF_CLI) = 14 then
//      mtClienteCNPJ_CPF.EditMask := '99.999.999/9999-99;0;'
//    else
//      mtClienteCNPJ_CPF.EditMask := '999.999.999-99;0;';

    mtCliente.Append;
    mtClienteCLIENTE_NOME.Value := lClienteModel.ClientesLista[0].FANTASIA_CLI;
    mtClienteRAZAO_SOCIAL.Value := lClienteModel.ClientesLista[0].RAZAO_CLI;
    mtClienteCNPJ_CPF.Value     := lClienteModel.ClientesLista[0].CNPJ_CPF_CLI;
    mtClienteRG.Value           := lClienteModel.ClientesLista[0].INSCRICAO_RG_CLI;
    mtClienteNASCIMENTO.Value   := lClienteModel.ClientesLista[0].NASCIMENTO_CLI;

    mtClienteENDERECO.Value     := lClienteModel.ClientesLista[0].ENDERECO;
    mtClienteNUMERO.Value       := lClienteModel.ClientesLista[0].NUMERO_END;
    mtClienteCIDADE.Value       := lClienteModel.ClientesLista[0].CIDADE_CLI;
    mtClienteBAIRRO.Value       := lClienteModel.ClientesLista[0].BAIRRO_CLI;
    mtClienteCOMPLEMENTO.Value  := lClienteModel.ClientesLista[0].COMPLEMENTO;
    mtClienteUF.Value           := lClienteModel.ClientesLista[0].UF_CLI;
    mtClienteCEP.Value          := lClienteModel.ClientesLista[0].CEP_CLI;

    mtClienteTELEFONE.Value     := lClienteModel.ClientesLista[0].TELEFONE_CLI;
    mtClienteCELULAR.Value      := lClienteModel.ClientesLista[0].CELULAR_CLI;
    mtClienteEMAIL.Value        := lClienteModel.ClientesLista[0].EMAIL_CLI;
    mtClienteCONTATO.Value      := lClienteModel.ClientesLista[0].CONTATO_CLI;
    mtCliente.Post;

  finally
    lClienteModel.Free;
  end;

end;

procedure TImpressaoContratos.fetchMemo(lPedidoVendaModel : TPedidoVendaModel);
var
  lClienteModel : TClienteModel;
begin

  lClienteModel := TClienteModel.Create(CONEXAO);
  try
    lClienteModel.IDRecordView := lPedidoVendaModel.CODIGO_CLI;
    lClienteModel.obterLista;

    RLMemo1.Lines.Text := '      Eu, '+lPedidoVendaModel.FANTASIA_CLI+', inscrito no CPF/MF sob o nº '+formatoCNPJCPFGenerico(nil,lClienteModel.ClientesLista[0].CNPJ_CPF_CLI, true)+', proponente do '+
                             'seguro Garantia Estendida, autorizo que o pagamento do prêmio de seguro no valor de R$ 135,37 '+
                             'seja realizado em conjunto com o pagamento do(s) produto(s)/serviço(s) ora adquirido(s).';

    RLMemo2.Lines.Text := '   Eu, '+lPedidoVendaModel.FANTASIA_CLI+', inscrito no CPF/MF sob o nº '+formatoCNPJCPFGenerico(nil,lClienteModel.ClientesLista[0].CNPJ_CPF_CLI, true)+', proponente do ' +
                              'Seguro Proteção de Bens, autorizo que o pagamento do prêmio de seguro no valor de R$ 1.160,00 '+
                              'seja realizado em conjunto com o pagamento do(s) produto(s)/serviço(s) ora adquirido(s).';

    RLMemo3.Lines.Text := RLMemo2.Lines.Text;

    RLMemo4.Lines.Text := '    Eu, '+lPedidoVendaModel.FANTASIA_CLI+', inscrito no CPF/MF sob o nº '+formatoCNPJCPFGenerico(nil,lClienteModel.ClientesLista[0].CNPJ_CPF_CLI, true)+', '+
                              'proponente do Seguro Prestamista, autorizo que o pagamento do prêmio de seguro no valor de '+
                              'R$ 417,44 seja realizado em conjunto com o  pagamento do(s) produto(s)/serviço(s) ora adquirido(s).';
  finally
    lClienteModel.Free;
  end;

end;

procedure TImpressaoContratos.fetchPedido;
var
  lPedidoVendaModel : TPedidoVendaModel;
  lContasReceberModel : TContasReceberModel;
  lContasReceberItensModel : TContasReceberItensModel;
begin
  lPedidoVendaModel   := TPedidoVendaModel.Create(CONEXAO);
  lContasReceberModel := TContasReceberModel.Create(CONEXAO);
  lContasReceberItensModel := TContasReceberItensModel.Create(CONEXAO);
  try

    lPedidoVendaModel.IDRecordView := '040440';
    lPedidoVendaModel.Obterlista;
    lPedidoVendaModel.ID := '040440';
    lPedidoVendaModel.calcularTotais;

    if lPedidoVendaModel.TotalRecords = 0 then
      raise Exception.Create('Pedido de venda '+Self.FIDPEDIDO+' não localizado');

    for lPedidoVendaModel in lPedidoVendaModel.PedidoVendasLista do
    begin
      mtPedido.Append;
      mtPedidoNUMERO.Value              := lPedidoVendaModel.NUMERO_PED;
      mtPedidoEMISSAO.Value             := lPedidoVendaModel.DATA_PED;
      mtPedidoOBSERVACAO.Value          := lPedidoVendaModel.OBS_GERAL;
      mtPedidoVALOR_PRODUTOS.Value      := lPedidoVendaModel.VALOR_PED;
      mtPedidoVALOR_DESCONTO.Value      := lPedidoVendaModel.DESC_PED;
      mtPedidoSEGURO_PRESTAMISTA.Value  := IIF(lPedidoVendaModel.SEGURO_PRESTAMISTA_VALOR = '', 0 , lPedidoVendaModel.SEGURO_PRESTAMISTA_VALOR);
      mtPedidoVALOR_ACRESCIMO.Value     := lPedidoVendaModel.ACRES_PED;
      mtPedidoVALOR_FRETE.Value         := lPedidoVendaModel.FRETE_PED;
      mtPedidoVALOR_TOTAL.Value         := lPedidoVendaModel.TOTAL_PED;
      mtPedidoVENDEDOR.Value            := lPedidoVendaModel.NOME_VENDEDOR;
      mtPedidoCLIENTE_ID.Value          := lPedidoVendaModel.CODIGO_CLI;
      mtPedido.Post;

      lContasReceberModel.IDPedidoView := lPedidoVendaModel.NUMERO_PED;
      lContasReceberModel.obterLista;

      for lContasReceberModel in lContasReceberModel.ContasRecebersLista do
      begin
        mtReceber.Append;
        mtReceberNOME_PORT.Value := lContasReceberModel.PORTADOR_NOME;
        mtReceberVALOR_REC.Value := lContasReceberModel.VALOR_REC;
        mtReceber.Post;
      end;

      lContasReceberItensModel.IDContasReceberView := lContasReceberModel.FATURA_REC;
      lContasReceberItensModel.obterLista;

      for lContasReceberItensModel in lContasReceberItensModel.ContasReceberItenssLista do
      begin
        mtReceberItens.Append;
        mtReceberItensVALOR_PARCELA.Value  := lContasReceberItensModel.VALORREC_REC;
        mtReceberItensTOTAL_PARCELAS.Value := lContasReceberItensModel.TOTALPARCELAS_REC;
        mtReceberItens.Post;
      end;
    end;

    fetchMemo(lPedidoVendaModel);

  finally
    lPedidoVendaModel.Free;
    lContasReceberModel.Free;
    lContasReceberItensModel.Free;
  end;
end;

procedure TImpressaoContratos.fetchPedidoItens;
var
  lPedidoItensModel : TPedidoItensModel;
  lProdutosModel    : TProdutosModel;
  lGarantia : Double;
begin
  lPedidoItensModel := TPedidoItensModel.Create(CONEXAO);
  lProdutosModel    := TProdutosModel.Create(CONEXAO);
  try
    lPedidoItensModel.IDPedidoVendaView := '040440';
    lPedidoItensModel.obterLista;
    vGarantia := 0;

    for lPedidoItensModel in lPedidoItensModel.PedidoItenssLista do begin
      mtItens.Append;
      mtItensID.Value               := lPedidoItensModel.ID;
      mtItensPRODUTO_ID.Value       := lPedidoItensModel.CODIGO_PRO;
      mtItensQUANTIDADE.Value       := lPedidoItensModel.QUANTIDADE_NEW;
      mtItensVALOR_UNITARIO.Value   := lPedidoItensModel.VALORUNITARIO_PED;
      mtItensVLR_GARANTIA.Value     := lPedidoItensModel.VALOR_TOTAL_GARANTIA;
      mtItensTIPO_GARANTIA_FR.Value := lPedidoItensModel.TIPO_GARANTIA_FR;
      mtItensVALOR_TOTAL.Value      := lPedidoItensModel.VALOR_TOTAL_ITENS;
      mtItensOBSERVACAO.Value       := lPedidoItensModel.OBSERVACAO;
      mtItens.Post;

      vGarantia := vGarantia + mtItensQUANTIDADE.Value * mtItensVLR_GARANTIA.Value;

      mtPedido.Edit;
      mtPedidoTOTAL_GARANTIA.Value := vGarantia;
      mtPedido.Post;

      lProdutosModel.IDRecordView := lPedidoItensModel.CODIGO_PRO;
      lProdutosModel.obterLista;

      for lProdutosModel in lProdutosModel.ProdutossLista do begin
        mtProdutos.Append;
        mtProdutosNOME_MAR.Value := lProdutosModel.NOME_MAR;
        mtProdutosNOME_PRO.Value := lProdutosModel.NOME_PRO;
        mtProdutos.Post;
      end;

    end;

  finally
    lPedidoItensModel.Free;
    lProdutosModel.Free;
  end;
end;

procedure TImpressaoContratos.fetchEmpresa;
var
  lEmpresaModel : TEmpresaModel;
begin
  lEmpresaModel := TEmpresaModel.Create(CONEXAO);
  try
    lEmpresaModel.Carregar;
    mtEmpresa.Append;
    mtEmpresaCNPJ.Value := lEmpresaModel.CNPJ;
    mtEmpresaLOCAL_DATA.Value := VarToStr(lEmpresaModel.CIDADE) +'/'+ VarToStr(lEmpresaModel.UF) + '  ' + DateToStr(CONEXAO.DataServer);
    mtEmpresa.Post;
  finally
    lEmpresaModel.Free;
  end;
end;

procedure TImpressaoContratos.imprimir;
var
  lNameArchive : string;
begin

//  if Self.FIDPEDIDO = '' then
//    raise Exception.Create('Pedido não informado para impressão');
//
//  lNameArchive := '';
//
//  try
    Self.fetchPedido;
    Self.fetchCliente;
    Self.fetchPedidoItens;
    Self.fetchEmpresa;
//
//    Self.FCONTADOR := 1;
//
//    if Self.FPREVIEW then
      RLReport1.Preview(); //Garantia Estendida
      RLReport5.Preview(); //Roubo e Furto
      RLReport10.Preview(); //Roubo e Furto Danos
      RLReport16.Preview(); //Seguro Prestamista

//    if Self.FPDF then begin
//      if Self.FDIR = '' then
//        raise Exception.Create('Diretório não informado');
//
//      if not DirectoryExists(Self.FDIR) then
//        ForceDirectories(Self.FDIR);
//
//      lNameArchive := FloatToStr(Round(random(999999))) + Self.FIDPEDIDO + '.pdf';
//      try
//        rlPadrao.SaveToFile(Self.FDIR+lNameArchive);
//      except
//        on E:Exception do
//
//      end;
//      Self.SetNOMEARQUIVO(lNameArchive);
//    end;
//
//  finally
//  end;
end;

procedure TImpressaoContratos.SetCNPJEMPRESA(const Value: Variant);
begin
  FCNPJEMPRESA := Value;
end;

procedure TImpressaoContratos.SetCONEXAO(const Value: IConexao);
begin
  FCONEXAO := Value;
end;

procedure TImpressaoContratos.SetCONTADOR(const Value: Variant);
begin
  FCONTADOR := Value;
end;

procedure TImpressaoContratos.SetDIR(const Value: Variant);
begin
  FDIR := Value;
end;

procedure TImpressaoContratos.SetDIRLOGO(const Value: Variant);
begin
  FDIRLOGO := Value;
end;

procedure TImpressaoContratos.SetIDPEDIDO(const Value: Variant);
begin
  FIDPEDIDO := Value;
end;

procedure TImpressaoContratos.SetNOMEARQUIVO(const Value: Variant);
begin
  FNOMEARQUIVO := Value;
end;

procedure TImpressaoContratos.SetPDF(const Value: Variant);
begin
  FPDF := Value;
end;

procedure TImpressaoContratos.SetPREVIEW(const Value: Variant);
begin
  FPREVIEW := Value;
end;
end.
