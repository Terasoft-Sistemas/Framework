unit Impressao.Contratos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, RLReport, RLBarcode,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  RLXLSXFilter, RLFilters, RLPDFFilter, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Terasoft.Utils, Interfaces.Conexao, xPNGimage,
  Vcl.Imaging.jpeg, PedidoVendaModel, Terasoft.FuncoesTexto, Terasoft.Configuracoes, System.Math,
  Vcl.StdCtrls;

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
    RLLabel87: TRLLabel;
    RLLabel88: TRLLabel;
    RLLabel89: TRLLabel;
    RLLabel90: TRLLabel;
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
    RLDBText36: TRLDBText;
    RLDBText37: TRLDBText;
    RLDBText38: TRLDBText;
    RLDBText39: TRLDBText;
    RLDBText40: TRLDBText;
    RLDBText41: TRLDBText;
    RLDBText43: TRLDBText;
    RLDBText44: TRLDBText;
    RLDBText45: TRLDBText;
    RLDBText46: TRLDBText;
    dsEmpresa: TDataSource;
    mtEmpresa: TFDMemTable;
    mtEmpresaCNPJ: TStringField;
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
    RLLabel106: TRLLabel;
    RLLabel107: TRLLabel;
    RLDBText4: TRLDBText;
    RLLabel108: TRLLabel;
    RLLabel109: TRLLabel;
    RLLabel110: TRLLabel;
    mtItensINICIO_VIGENCIA: TStringField;
    mtItensFIM_VIGENCIA: TStringField;
    RLDBText12: TRLDBText;
    RLDBText47: TRLDBText;
    RLDBText58: TRLDBText;
    RLDBText59: TRLDBText;
    RLDBText60: TRLDBText;
    RLDBText61: TRLDBText;
    mtItensPREMIO_LIQUIDO: TFloatField;
    RLDBText62: TRLDBText;
    mtItensIOF: TFloatField;
    RLLabel111: TRLLabel;
    lblRRGarantiaEstendida: TRLLabel;
    mtItensRR_GARANTIA_ESTENDIDA: TFloatField;
    RLDBText63: TRLDBText;
    RLDBText64: TRLDBText;
    mtItensNUMERO_BILHETE: TStringField;
    RLDBText65: TRLDBText;
    RLDBText66: TRLDBText;
    RLLabel113: TRLLabel;
    RLLabel114: TRLLabel;
    RLLabel115: TRLLabel;
    RLLabel116: TRLLabel;
    RLLabel117: TRLLabel;
    RLLabel118: TRLLabel;
    RLLabel119: TRLLabel;
    RLLabel120: TRLLabel;
    RLDBText42: TRLDBText;
    RLLabel121: TRLLabel;
    RLLabel122: TRLLabel;
    RLLabel123: TRLLabel;
    RLDBText50: TRLDBText;
    RLDBText67: TRLDBText;
    mtReceberItensFIM_VIGENCIA_VENCIMENTO: TStringField;
    RLDBText68: TRLDBText;
    RLDBText69: TRLDBText;
    RLDBText70: TRLDBText;
    mtPedidoRR_PRESTAMISTA: TFloatField;
    lblRRPrestamista: TRLLabel;
    lblIOFPrestamista: TRLLabel;
    memoCoberturaPrestamista: TRLMemo;
    lblPlano3: TRLLabel;
    RLDBText71: TRLDBText;
    RLDBText72: TRLDBText;
    mtItensVALOR_NOTA_FISCAL: TFloatField;
    RLLabel61: TRLLabel;
    RLDBText24: TRLDBText;
    RLLabel62: TRLLabel;
    RLDBText48: TRLDBText;
    RLLabel112: TRLLabel;
    RLDBText73: TRLDBText;
    RLDBText74: TRLDBText;
    RLDBText75: TRLDBText;
    mtItensVALOR_FRANQUIA: TFloatField;
    mtItensPREMIO_UNICO_FR: TFloatField;
    RLDBText76: TRLDBText;
    RLDBText77: TRLDBText;
    RLDBText78: TRLDBText;
    RLDBText79: TRLDBText;
    lblRRRouboFurto: TRLLabel;
    mtItensIOF_FR: TFloatField;
    RLDBText80: TRLDBText;
    RLDBText81: TRLDBText;
    RLDBText35: TRLDBText;
    RLLabel86: TRLLabel;
    RLDBText49: TRLDBText;
    RLLabel91: TRLLabel;
    RLDBText82: TRLDBText;
    RLDBText83: TRLDBText;
    RLLabel92: TRLLabel;
    RLDBText84: TRLDBText;
    RLDBText85: TRLDBText;
    RLDBText86: TRLDBText;
    RLDBText87: TRLDBText;
    lblRRRouboFurtoDanos: TRLLabel;
    RLDBText88: TRLDBText;
    RLDBText89: TRLDBText;
    RLDBText90: TRLDBText;
    mtItensRR_RF: TFloatField;
    mtItensRR_RFD: TFloatField;
    mtPedidoPREMIO_UNICO_1: TFloatField;
    mtPedidoPREMIO_UNICO_2: TFloatField;
    mtPedidoPREMIO_UNICO_3: TFloatField;
    mtItensFIM_VIGENCIA_FR: TStringField;
    TabSheet25: TTabSheet;
    RLReport23: TRLReport;
    Label1: TLabel;
    RLBand1: TRLBand;
    RLLabel126: TRLLabel;
    RLLabel140: TRLLabel;
    RLLabel124: TRLLabel;
    RLDraw19: TRLDraw;
    RLDraw21: TRLDraw;
    RLDraw22: TRLDraw;
    RLLabel125: TRLLabel;
    RLLabel127: TRLLabel;
    RLLabel128: TRLLabel;
    RLLabel129: TRLLabel;
    RLLabel130: TRLLabel;
    RLLabel131: TRLLabel;
    RLLabel132: TRLLabel;
    RLLabel133: TRLLabel;
    RLLabel134: TRLLabel;
    RLLabel135: TRLLabel;
    RLLabel136: TRLLabel;
    RLLabel137: TRLLabel;
    RLLabel138: TRLLabel;
    RLLabel139: TRLLabel;
    RLLabel141: TRLLabel;
    RLLabel142: TRLLabel;
    RLLabel143: TRLLabel;
    RLLabel144: TRLLabel;
    RLLabel145: TRLLabel;
    RLLabel146: TRLLabel;
    RLLabel147: TRLLabel;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    rlBandFatura: TRLBand;
    RLLabel156: TRLLabel;
    RLDraw29: TRLDraw;
    RLDraw30: TRLDraw;
    drawFaturasT1: TRLDraw;
    drawFaturasT3: TRLDraw;
    RLLabel158: TRLLabel;
    RLDraw33: TRLDraw;
    RLDraw34: TRLDraw;
    drawFaturasT2: TRLDraw;
    drawFaturasT4: TRLDraw;
    drawFaturasC1: TRLDraw;
    drawFaturasC2: TRLDraw;
    drawFaturasC3: TRLDraw;
    drawFaturasC4: TRLDraw;
    rlMemoParcelaC1: TRLMemo;
    rlMemoVencimentoC1: TRLMemo;
    rlMemoValorC1: TRLMemo;
    rlMemoParcelaC2: TRLMemo;
    rlMemoVencimentoC2: TRLMemo;
    rlMemoValorC2: TRLMemo;
    rlMemoParcelaC3: TRLMemo;
    rlMemoVencimentoC3: TRLMemo;
    rlMemoValorC3: TRLMemo;
    rlMemoParcelaC4: TRLMemo;
    rlMemoVencimentoC4: TRLMemo;
    rlMemoValorC4: TRLMemo;
    RLLabel162: TRLLabel;
    RLLabel167: TRLLabel;
    RLLabel168: TRLLabel;
    RLLabel169: TRLLabel;
    RLLabel170: TRLLabel;
    RLLabel171: TRLLabel;
    RLLabel172: TRLLabel;
    RLDraw31: TRLDraw;
    RLLabel173: TRLLabel;
    RLDraw32: TRLDraw;
    RLDBText93: TRLDBText;
    RLDBText94: TRLDBText;
    RLDBText95: TRLDBText;
    RLDBText96: TRLDBText;
    RLDBText97: TRLDBText;
    RLDBText98: TRLDBText;
    RLDBText99: TRLDBText;
    RLLabel153: TRLLabel;
    RLLabel152: TRLLabel;
    RLDraw28: TRLDraw;
    RLLabel150: TRLLabel;
    RLDraw25: TRLDraw;
    RLLabel149: TRLLabel;
    RLDraw24: TRLDraw;
    RLDraw23: TRLDraw;
    RLLabel148: TRLLabel;
    RLDraw26: TRLDraw;
    RLLabel151: TRLLabel;
    RLDraw27: TRLDraw;
    RLLabel154: TRLLabel;
    RLLabel155: TRLLabel;
    RLMemo6: TRLMemo;
    RLMemo5: TRLMemo;
    RLDraw35: TRLDraw;
    rlMemoNome: TRLMemo;
    rlMemoCodigo: TRLMemo;
    dsFiador: TDataSource;
    mtFiador: TFDMemTable;
    mtFiadorFIADOR: TStringField;
    mtFiadorCNPJ_CPF_FIADOR: TStringField;
    mtFiadorRG_FIADOR: TStringField;
    mtFiadorENDERECO_FIADOR: TStringField;
    mtFiadorBAIRRO_FIADOR: TStringField;
    mtFiadorCIDADE_FIADOR: TStringField;
    mtFiadorUF_FIADOR: TStringField;
    mtPedidoCODIGO_FIADOR: TStringField;
    RLDBText91: TRLDBText;
    RLDBText92: TRLDBText;
    RLDBText100: TRLDBText;
    RLDBText101: TRLDBText;
    RLDBText102: TRLDBText;
    RLDBText103: TRLDBText;
    RLDBText104: TRLDBText;
    mtClienteMAE_CLI: TStringField;
    RLDBText105: TRLDBText;
    RLDBText106: TRLDBText;
    RLDBText107: TRLDBText;
    lblNotaPedido: TRLLabel;
    lblFilial: TRLLabel;
    lblParcelas: TRLLabel;
    lblEmpresa: TRLLabel;
    RLLabel157: TRLLabel;
    RLLabel159: TRLLabel;
    RLLabel160: TRLLabel;
    RLLabel161: TRLLabel;
    lblData: TRLLabel;
    RLLabel163: TRLLabel;
    RLLabel164: TRLLabel;
    mtPedidoCONTRATO: TStringField;
    RLDBText108: TRLDBText;
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

    property IDPEDIDO: Variant read FIDPEDIDO write SetIDPEDIDO;
    property NOMEARQUIVO: Variant read FNOMEARQUIVO write SetNOMEARQUIVO;
    property PREVIEW: Variant read FPREVIEW write SetPREVIEW;
    property PDF: Variant read FPDF write SetPDF;
    property DIR: Variant read FDIR write SetDIR;
    property CNPJEMPRESA : Variant read FCNPJEMPRESA write SetCNPJEMPRESA;
    property CONTADOR: Variant read FCONTADOR write SetCONTADOR;
    property DIRLOGO: Variant read FDIRLOGO write SetDIRLOGO;
    property CONEXAO: IConexao read FCONEXAO write SetCONEXAO;

    procedure imprimirGarantiaEstendida;
    procedure imprimirRF;
    procedure imprimirRFD;
    procedure imprimirPrestamista;
    procedure imprimirCarteira;
    procedure fetchPedido;
    procedure fetchCliente;
    procedure fetchFiador;
    procedure fetchPedidoItens(pID : String);
    procedure fetchMemo;
    procedure fetchEmpresa;
    procedure fetchFinanceiro;
    procedure reportPreview(pReportItem: TRLReport; pItem: String);
    function retornaInicioVigencia(pInicio: String; pMesesGarantia: Integer) : String;
    procedure clearAllMemo;

    function retornaNumeroBilhete(pTipo, pFilial, pNumero: String): String;

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
  mtFiador.Open;
end;

procedure TImpressaoContratos.FormDestroy(Sender: TObject);
begin
 CoUninitialize;
end;

procedure TImpressaoContratos.fetchPedido;
var
  lPedidoVendaModel        : ITPedidoVendaModel;
  lContasReceberModel      : TContasReceberModel;
  lContasReceberItensModel : TContasReceberItensModel;
  lConfiguracoes           : ITerasoftConfiguracoes;
  lPrimeiraParcela,
  lTotalPremio             : Double;
begin
  lPedidoVendaModel        := TPedidoVendaModel.getNewIface(CONEXAO);
  lContasReceberModel      := TContasReceberModel.Create(CONEXAO);
  lContasReceberItensModel := TContasReceberItensModel.Create(CONEXAO);
  lConfiguracoes           := TerasoftConfiguracoes.getNewIface(CONEXAO);
  try

    lPedidoVendaModel.objeto.IDRecordView := Self.IDPEDIDO;
    lPedidoVendaModel.objeto.Obterlista;

    lPedidoVendaModel.objeto.ID := Self.IDPEDIDO;
    lPedidoVendaModel.objeto.calcularTotais;

    if lPedidoVendaModel.objeto.TotalRecords = 0 then
      raise Exception.Create('Pedido de venda '+Self.FIDPEDIDO+' não localizado');

    lPedidoVendaModel := lPedidoVendaModel.objeto.PedidoVendasLista[0];

    mtPedido.Append;
    mtPedidoNUMERO.Value              := lPedidoVendaModel.objeto.NUMERO_PED;
    mtPedidoEMISSAO.Value             := lPedidoVendaModel.objeto.DATA_PED;
    mtPedidoOBSERVACAO.Value          := lPedidoVendaModel.objeto.OBS_GERAL;
    mtPedidoVALOR_PRODUTOS.Value      := lPedidoVendaModel.objeto.VALOR_PED;
    mtPedidoVALOR_DESCONTO.Value      := lPedidoVendaModel.objeto.DESC_PED;
    mtPedidoSEGURO_PRESTAMISTA.Value  := RoundTo(StrToFloatDef(lPedidoVendaModel.objeto.SEGURO_PRESTAMISTA_VALOR, 0), -2);
    mtPedidoRR_PRESTAMISTA.Value      := (lConfiguracoes.objeto.valorTag('PERCENTUAL_RR_PRESTAMISTA', '0', tvNumero));

    mtPedidoPREMIO_UNICO_1.Value      := RoundTo((mtPedidoSEGURO_PRESTAMISTA.Value / 100 * 6.23), -2);
    mtPedidoPREMIO_UNICO_2.Value      := RoundTo((mtPedidoSEGURO_PRESTAMISTA.Value / 100 * 0.53), -2);
    mtPedidoPREMIO_UNICO_3.Value      := RoundTo((mtPedidoSEGURO_PRESTAMISTA.Value / 100 * 93.24), -2);
    lTotalPremio                      := mtPedidoPREMIO_UNICO_1.Value + mtPedidoPREMIO_UNICO_2.Value + mtPedidoPREMIO_UNICO_3.Value;

    if lTotalPremio <> mtPedidoSEGURO_PRESTAMISTA.Value then
      mtPedidoPREMIO_UNICO_3.Value := mtPedidoPREMIO_UNICO_3.Value - (lTotalPremio - mtPedidoSEGURO_PRESTAMISTA.Value);

    mtPedidoVALOR_ACRESCIMO.Value     := lPedidoVendaModel.objeto.ACRES_PED;
    mtPedidoVALOR_FRETE.Value         := lPedidoVendaModel.objeto.FRETE_PED;
    mtPedidoVALOR_TOTAL.Value         := lPedidoVendaModel.objeto.TOTAL_PED;
    mtPedidoVENDEDOR.Value            := lPedidoVendaModel.objeto.NOME_VENDEDOR;
    mtPedidoCLIENTE_ID.Value          := lPedidoVendaModel.objeto.CODIGO_CLI;
    mtPedidoCODIGO_FIADOR.Value       := lPedidoVendaModel.objeto.CONDICOES2_PAG;
    mtPedidoNUMERO_NF.Value           := lPedidoVendaModel.objeto.NUMERO_NF;
    mtPedidoCONTRATO.Value            := lPedidoVendaModel.objeto.LOJA +'.'+ mtPedidoNUMERO.Value;
    mtPedido.Post;

    lContasReceberModel.IDPedidoView := lPedidoVendaModel.objeto.NUMERO_PED;
    lContasReceberModel.obterLista;

    lContasReceberModel := lContasReceberModel.ContasRecebersLista.First;

    mtReceber.Append;
    mtReceberNOME_PORT.Value := lContasReceberModel.PORTADOR_NOME;
    mtReceberVALOR_REC.Value := lContasReceberModel.VALOR_REC;
    mtReceber.Post;

    lContasReceberItensModel.WhereView           := ' AND PORTADOR.TIPO = ''R'' AND PORTADOR.TPAG_NFE NOT IN (''03'', ''04'', ''17'', ''20'') ';
    lContasReceberItensModel.IDContasReceberView := lContasReceberModel.FATURA_REC;
    lContasReceberItensModel.OrderView := 'CONTASRECEBERITENS.VENCIMENTO_REC';
    lContasReceberItensModel.obterLista;

    lPrimeiraParcela := 0;

    for lContasReceberItensModel in lContasReceberItensModel.ContasReceberItenssLista do begin
      mtReceberItens.Append;

      if lContasReceberItensModel.PACELA_REC = 1 then
        lPrimeiraParcela := lContasReceberItensModel.VLRPARCELA_REC;

      mtReceberItensVALOR_PARCELA.Value           := lPrimeiraParcela;
      mtReceberItensTOTAL_PARCELAS.Value          := lContasReceberItensModel.TOTALPARCELAS_REC;
      mtReceberItensFIM_VIGENCIA_VENCIMENTO.Value := lContasReceberItensModel.VENCIMENTO_REC;
      mtReceberItens.Post;

      lblRRPrestamista.Caption  := 'RR: '+ FormataFloat(mtPedidoRR_PRESTAMISTA.Value) +'%  (R$ '+ FormataFloat((mtPedidoSEGURO_PRESTAMISTA.Value / 1.0738) * (mtPedidoRR_PRESTAMISTA.Value / 100)) +')';
      lblIOFPrestamista.Caption := 'R$ '+FormataFloat(mtPedidoSEGURO_PRESTAMISTA.Value - (mtPedidoSEGURO_PRESTAMISTA.Value / 1.0738))+' ';

    end;

  finally
    lPedidoVendaModel:=nil;
    lContasReceberModel.Free;
    lContasReceberItensModel.Free;
  end;
end;

procedure TImpressaoContratos.fetchPedidoItens(pID : String);
var
  lPedidoItensModel    : ITPedidoItensModel;
  lProdutosModel       : ITProdutosModel;
  lWebPedidoItensModel : ITWebPedidoItensModel;
  lConfiguracoes       : ITerasoftConfiguracoes;
  lTipoGarantia,
  lTipoGarantiaFR      : String;
begin
  lPedidoItensModel    := TPedidoItensModel.getNewIface(CONEXAO);
  lProdutosModel       := TProdutosModel.getNewIface(CONEXAO);
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(CONEXAO);
  lConfiguracoes       := TerasoftConfiguracoes.getNewIface(CONEXAO);
  try
    lPedidoItensModel.objeto.IDRecordView := pID;
    lPedidoItensModel.objeto.obterLista;

    lProdutosModel.objeto.IDRecordView := lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.CODIGO_PRO;
    lProdutosModel.objeto.obterLista;

    lWebPedidoItensModel.objeto.IDRecordView := StrToIntDef(lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.WEB_PEDIDOITENS_ID, 0);
    lWebPedidoItensModel.objeto.obterLista;

    mtItens.Edit;
    mtItensID.Value                    := lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.ID;
    mtItensPRODUTO_ID.Value            := lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.CODIGO_PRO;
    mtItensQUANTIDADE.Value            := lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.QTDE_CALCULADA;
    mtItensVALOR_UNITARIO.Value        := lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.VLRVENDA_PRO;
    mtItensVLR_GARANTIA.Value          := StrToFloatDef(lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.QUANTIDADE_TIPO, 0);
    mtItensTIPO_GARANTIA_FR.Value      := Copy(lWebPedidoItensModel.objeto.WebPedidoItenssLista[0].objeto.TIPO_GARANTIA_FR,3,2) + ' Meses';
    mtItensVALOR_TOTAL.Value           := lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.VALOR_TOTAL_ITENS;
    mtItensVALOR_NOTA_FISCAL.Value     := lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.VALORUNITARIO_PED * (1 - (lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.DESCONTO_PED / 100));
    mtItensPREMIO_LIQUIDO.Value        := mtItensVLR_GARANTIA.Value / 1.0738;
    mtItensIOF.Value                   := mtItensVLR_GARANTIA.Value - mtItensPREMIO_LIQUIDO.Value;
    mtItensRR_GARANTIA_ESTENDIDA.Value := (lConfiguracoes.objeto.valorTag('PERCENTUAL_RR_GARANTIA_ESTENDIDA', '0', tvNumero));
    mtItensRR_RF.Value                 := (lConfiguracoes.objeto.valorTag('PERCENTUAL_RR_RF', '0', tvNumero));
    mtItensRR_RFD.Value                := (lConfiguracoes.objeto.valorTag('PERCENTUAL_RR_RFD', '0', tvNumero));
    mtItensVALOR_FRANQUIA.Value        := mtItensVALOR_UNITARIO.Value * (20 / 100);
    mtItensPREMIO_UNICO_FR.Value       := StrToFloatDef(lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.VLR_GARANTIA_FR, 0);
    mtItensIOF_FR.Value                := mtItensPREMIO_UNICO_FR.Value - (mtItensPREMIO_UNICO_FR.Value / 1.0738);
    mtItensOBSERVACAO.Value            := lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.OBSERVACAO;
    mtItensINICIO_VIGENCIA.Value       := retornaInicioVigencia(mtPedidoEMISSAO.Value, lProdutosModel.objeto.ProdutossLista.First.objeto.GARANTIA_PRO);

    lTipoGarantia   := Copy(lWebPedidoItensModel.objeto.WebPedidoItenssLista.First.objeto.TIPO_GARANTIA,3,2);
    lTipoGarantiaFR := Copy(lWebPedidoItensModel.objeto.WebPedidoItenssLista.First.objeto.TIPO_GARANTIA_FR,3,2);

    mtItensFIM_VIGENCIA.Value := mtItensINICIO_VIGENCIA.Value;

    if (lTipoGarantia = '12') or (lTipoGarantia = '24') then
      mtItensFIM_VIGENCIA.Value := DateToStr(IncMonth(StrToDate(mtItensINICIO_VIGENCIA.Value),StrToInt(lTipoGarantia)));

    if (lTipoGarantiaFR = '12') or (lTipoGarantiaFR = '24') then
      mtItensFIM_VIGENCIA_FR.Value := DateToStr(IncMonth(StrToDate(mtPedidoEMISSAO.Value),StrToInt(lTipoGarantiaFR)));

    mtItens.Post;

    mtProdutos.EmptyDataSet;

    mtProdutos.Append;
    mtProdutosNOME_MAR.Value := lProdutosModel.objeto.ProdutossLista.First.objeto.NOME_MAR;
    mtProdutosNOME_PRO.Value := lProdutosModel.objeto.ProdutossLista.First.objeto.NOME_PRO;
    mtProdutos.Post;

    rlMemoCodigo.Lines.Add(mtItensPRODUTO_ID.Value + ' -');
    rlMemoNome.Lines.Add(mtProdutosNOME_PRO.Value);

    lblRRGarantiaEstendida.Caption := '*RR: '+ FormataFloat(mtItensRR_GARANTIA_ESTENDIDA.Value) +'%  (R$ '+ FormataFloat(mtItensPREMIO_LIQUIDO.Value * (mtItensRR_GARANTIA_ESTENDIDA.Value / 100)) +')';
    lblRRRouboFurto.Caption        := '*RR: '+ FormataFloat(mtItensRR_RF.Value) +'%  (R$ '+ FormataFloat((mtItensPREMIO_UNICO_FR.Value / 1.0738) * (mtItensRR_RF.Value / 100)) +')';
    lblRRRouboFurtoDanos.Caption   := '*RR: '+ FormataFloat(mtItensRR_RFD.Value) +'%  (R$ '+ FormataFloat((mtItensPREMIO_UNICO_FR.Value / 1.0738) * (mtItensRR_RFD.Value / 100)) +')';
    Self.fetchMemo;
  finally
    lPedidoItensModel:=nil;
    lProdutosModel:=nil;
    lWebPedidoItensModel:=nil;
  end;

end;

procedure TImpressaoContratos.fetchCliente;
var
  lClienteModel : ITClienteModel;
begin

  lClienteModel := TClienteModel.getNewIface(CONEXAO);
  try
    lClienteModel.objeto.IDRecordView := mtPedidoCLIENTE_ID.Value;
    lClienteModel.objeto.obterLista;

    mtCliente.Append;
    mtClienteCLIENTE_NOME.Value := lClienteModel.objeto.ClientesLista[0].objeto.FANTASIA_CLI;
    mtClienteRAZAO_SOCIAL.Value := lClienteModel.objeto.ClientesLista[0].objeto.RAZAO_CLI;
    mtClienteCNPJ_CPF.Value     := lClienteModel.objeto.ClientesLista[0].objeto.CNPJ_CPF_CLI;
    mtClienteRG.Value           := lClienteModel.objeto.ClientesLista[0].objeto.INSCRICAO_RG_CLI;
    mtClienteNASCIMENTO.Value   := lClienteModel.objeto.ClientesLista[0].objeto.NASCIMENTO_CLI;

    mtClienteENDERECO.Value     := lClienteModel.objeto.ClientesLista[0].objeto.ENDERECO;
    mtClienteNUMERO.Value       := lClienteModel.objeto.ClientesLista[0].objeto.NUMERO_END;
    mtClienteCIDADE.Value       := lClienteModel.objeto.ClientesLista[0].objeto.CIDADE_CLI;
    mtClienteBAIRRO.Value       := lClienteModel.objeto.ClientesLista[0].objeto.BAIRRO_CLI;
    mtClienteCOMPLEMENTO.Value  := lClienteModel.objeto.ClientesLista[0].objeto.COMPLEMENTO;
    mtClienteUF.Value           := lClienteModel.objeto.ClientesLista[0].objeto.UF_CLI;
    mtClienteCEP.Value          := lClienteModel.objeto.ClientesLista[0].objeto.CEP_CLI;

    mtClienteTELEFONE.Value     := lClienteModel.objeto.ClientesLista[0].objeto.TELEFONE_CLI;
    mtClienteCELULAR.Value      := lClienteModel.objeto.ClientesLista[0].objeto.CELULAR_CLI;
    mtClienteEMAIL.Value        := lClienteModel.objeto.ClientesLista[0].objeto.EMAIL_CLI;
    mtClienteCONTATO.Value      := lClienteModel.objeto.ClientesLista[0].objeto.CONTATO_CLI;
    mtClienteMAE_CLI.Value      := lClienteModel.objeto.ClientesLista[0].objeto.MAE_CLI;
    mtCliente.Post;

    if (lClienteModel.objeto.ClientesLista[0].objeto.CODIGO_OCUPACAO_CLI = '2') or (lClienteModel.objeto.ClientesLista[0].objeto.CODIGO_OCUPACAO_CLI = '8') or (lClienteModel.objeto.ClientesLista[0].objeto.CODIGO_OCUPACAO_CLI = 'M') then
      memoCoberturaPrestamista.Lines.Text := 'Desemprego Involuntário (DI)'
    else
    if (lClienteModel.objeto.ClientesLista[0].objeto.CODIGO_OCUPACAO_CLI = '3') or (lClienteModel.objeto.ClientesLista[0].objeto.CODIGO_OCUPACAO_CLI = '4') or (lClienteModel.objeto.ClientesLista[0].objeto.CODIGO_OCUPACAO_CLI = '5') then
      memoCoberturaPrestamista.Lines.Text := 'Incapacidade Física Total e Temporária por Acidente ou Doença'
    else
    begin
      memoCoberturaPrestamista.Lines.Text := 'Internação Hospitalar por Acidente *';
      lblPlano3.Visible := true;
    end;
  finally
    lClienteModel:=nil;
  end;
end;

procedure TImpressaoContratos.fetchFiador;
var
  lClienteModel : ITClienteModel;
begin
  lClienteModel := TClienteModel.getNewIface(CONEXAO);
  try

    lblNotaPedido.Caption := IIF(mtPedidoNUMERO_NF.AsString = '', '0', mtPedidoNUMERO_NF.AsString) +' - '+ mtPedidoNUMERO.AsString;

    if mtPedidoCODIGO_FIADOR.Value = '' then
      exit;

    lClienteModel.objeto.IDRecordView := mtPedidoCODIGO_FIADOR.Value;
    lClienteModel.objeto.obterLista;

    mtFiador.Append;
    mtFiadorFIADOR.Value          := lClienteModel.objeto.ClientesLista[0].objeto.FANTASIA_CLI;
    mtFiadorCNPJ_CPF_FIADOR.Value := lClienteModel.objeto.ClientesLista[0].objeto.CNPJ_CPF_CLI;
    mtFiadorRG_FIADOR.Value       := lClienteModel.objeto.ClientesLista[0].objeto.INSCRICAO_RG_CLI;
    mtFiadorENDERECO_FIADOR.Value := lClienteModel.objeto.ClientesLista[0].objeto.ENDERECO;
    mtFiadorCIDADE_FIADOR.Value   := lClienteModel.objeto.ClientesLista[0].objeto.CIDADE_CLI;
    mtFiadorBAIRRO_FIADOR.Value   := lClienteModel.objeto.ClientesLista[0].objeto.BAIRRO_CLI;
    mtFiadorUF_FIADOR.Value       := lClienteModel.objeto.ClientesLista[0].objeto.UF_CLI;
    mtFiador.Post;

  finally
    lClienteModel:=nil;
  end;
end;

procedure TImpressaoContratos.fetchEmpresa;
var
  lEmpresaModel : ITEmpresaModel;
  lLojasModel   : ITLojasModel;
begin
  lEmpresaModel := TEmpresaModel.getNewIface(CONEXAO);
  lLojasModel   := TLojasModel.getNewIface(CONEXAO);
  try
    lEmpresaModel.objeto.Carregar;
    mtEmpresa.Append;
    mtEmpresaCNPJ.Value := lEmpresaModel.objeto.CNPJ;
    mtEmpresaLOCAL_DATA.Value := VarToStr(lEmpresaModel.objeto.CIDADE) +'/'+ VarToStr(lEmpresaModel.objeto.UF) + '  ' + DateToStr(CONEXAO.DataServer);
    mtEmpresa.Post;

    lLojasModel.objeto.LojaView := lEmpresaModel.objeto.LOJA;
    lLojasModel.objeto.obterLista;

    lblFilial.Caption := lLojasModel.objeto.LojassLista.First.objeto.LOJA +' - '+ lLojasModel.objeto.LojassLista.First.objeto.DESCRICAO;

    lblEmpresa.Caption := lEmpresaModel.objeto.RAZAO_SOCIAL;

    lblData.Caption := lEmpresaModel.objeto.CIDADE +', '+ FormatDateTime('dd "de" mmmm "de" yyyy', mtPedidoEMISSAO.AsDateTime);

    RLMemo6.Lines.Text := 'A empresa '+lEmpresaModel.objeto.RAZAO_SOCIAL+', estabelecida na '+lEmpresaModel.objeto.ENDERECO+', '+lEmpresaModel.objeto.NUMERO+', inscrita no CNPJ No. '+removeCaracteresGraficos(lEmpresaModel.objeto.CNPJ)+', ' +
                          'doravante denominada simplesmente VENDEDORA e de outro lado o(a) COMPRADOR(A) e seu fiador(a) já anteriormente qualificados, ' +
                          'tem entre si justo e contratado o presente INSTRUMENTO PARTICULAR DE COMPRA E VENDA DE BENS MÓVEIS COM RESERVA DE DOMÍNIO, cujas cláusulas e condições são as seguintes:';

  finally
    lEmpresaModel := nil;
  end;
end;

procedure TImpressaoContratos.fetchFinanceiro;
var
  lContasReceberModel      : TContasReceberModel;
  lContasReceberItensModel : TContasReceberItensModel;
  lContadorColunas         : Integer;
begin
  lContasReceberModel      := TContasReceberModel.Create(CONEXAO);
  lContasReceberItensModel := TContasReceberItensModel.Create(CONEXAO);
  try
    lContasReceberModel.IDPedidoView := Self.IDPEDIDO;
    lContasReceberModel.obterLista;

    if lContasReceberModel.TotalRecords = 0 then
     begin
       rlBandFatura.Visible := false;
       Exit;
     end;

    lContadorColunas := 0;

    for lContasReceberModel in lContasReceberModel.ContasRecebersLista do
    begin

      lContasReceberItensModel.IDContasReceberView := lContasReceberModel.FATURA_REC;
      lContasReceberItensModel.WhereView := ' AND PORTADOR.TIPO = ''R'' AND PORTADOR.TPAG_NFE NOT IN (''01'', ''03'', ''04'', ''99'') ';
      lContasReceberItensModel.OrderView := 'CONTASRECEBERITENS.ID, CONTASRECEBERITENS.PACELA_REC';
      lContasReceberItensModel.obterLista;

      if lContasReceberItensModel.TotalRecords > 0 then
        lblParcelas.Caption := FloatToStr(StrToFloatDef(lblParcelas.Caption, 0) + lContasReceberItensModel.ContasReceberItenssLista[0].TOTALPARCELAS_REC);

      for lContasReceberItensModel in lContasReceberItensModel.ContasReceberItenssLista do
      begin

        case (lContadorColunas mod 4) of
          0:
          begin
            rlMemoParcelaC1.Lines.Add(lContasReceberItensModel.PACELA_REC + 'ª');
            rlMemoVencimentoC1.Lines.Add(lContasReceberItensModel.VENCIMENTO_REC);
            rlMemoValorC1.Lines.Add(FormatCurr('#,###0.00', lContasReceberItensModel.VLRPARCELA_REC));
          end;
          1:
          begin
            rlMemoParcelaC2.Lines.Add(lContasReceberItensModel.PACELA_REC + 'ª');
            rlMemoVencimentoC2.Lines.Add(lContasReceberItensModel.VENCIMENTO_REC);
            rlMemoValorC2.Lines.Add(FormatCurr('#,###0.00', lContasReceberItensModel.VLRPARCELA_REC));
          end;
          2:
          begin
            rlMemoParcelaC3.Lines.Add(lContasReceberItensModel.PACELA_REC + 'ª');
            rlMemoVencimentoC3.Lines.Add(lContasReceberItensModel.VENCIMENTO_REC);
            rlMemoValorC3.Lines.Add(FormatCurr('#,###0.00', lContasReceberItensModel.VLRPARCELA_REC));
          end;
          3:
          begin
            rlMemoParcelaC4.Lines.Add(lContasReceberItensModel.PACELA_REC + 'ª');
            rlMemoVencimentoC4.Lines.Add(lContasReceberItensModel.VENCIMENTO_REC);
            rlMemoValorC4.Lines.Add(FormatCurr('#,###0.00', lContasReceberItensModel.VLRPARCELA_REC));
          end;
        end;

        Inc(lContadorColunas);

        drawFaturasC1.Height := rlMemoVencimentoC1.Height+5;
        drawFaturasC2.Height := rlMemoVencimentoC1.Height+5;
        drawFaturasC3.Height := drawFaturasC1.Height;
        drawFaturasC4.Height := drawFaturasC1.Height;
        rlBandFatura.Height  := drawFaturasT1.Height + drawFaturasC1.Height + 10;
      end;
    end;

  finally
    lContasReceberModel.Free;
    lContasReceberItensModel.Free;
  end;
end;

procedure TImpressaoContratos.imprimirCarteira;
var
  lPedidoItensModel,
  lItens : ITPedidoItensModel;
  i      : Integer;
begin
  Self.clearAllMemo;
  Self.fetchPedido;
  Self.fetchCliente;
  Self.fetchFiador;
  Self.fetchEmpresa;
  Self.fetchFinanceiro;

  lPedidoItensModel := TPedidoItensModel.getNewIface(CONEXAO);
  try
    lPedidoItensModel.objeto.IDPedidoVendaView := Self.IDPEDIDO;
    lPedidoItensModel.objeto.obterLista;

    mtItens.EmptyDataSet;

    for lItens in lPedidoItensModel.objeto.PedidoItenssLista do
    begin
      fetchPedidoItens(lItens.objeto.ID);
    end;

    RLReport23.Preview;

  finally
    lPedidoItensModel:=nil;
  end;
end;

procedure TImpressaoContratos.clearAllMemo;
begin
  rlMemoCodigo.Lines.Clear;
  rlMemoNome.Lines.Clear;
  rlMemoParcelaC1.Lines.Clear;
  rlMemoVencimentoC1.Lines.Clear;
  rlMemoValorC1.Lines.Clear;
  rlMemoParcelaC2.Lines.Clear;
  rlMemoVencimentoC2.Lines.Clear;
  rlMemoValorC2.Lines.Clear;
  rlMemoParcelaC3.Lines.Clear;
  rlMemoVencimentoC3.Lines.Clear;
  rlMemoValorC3.Lines.Clear;
  rlMemoParcelaC4.Lines.Clear;
  rlMemoVencimentoC4.Lines.Clear;
  rlMemoValorC4.Lines.Clear;
end;

procedure TImpressaoContratos.imprimirGarantiaEstendida;
var
  lPedidoItensModel    : ITPedidoItensModel;
  lWebPedidoItensModel : ITWebPedidoItensModel;
begin
  lPedidoItensModel    := TPedidoItensModel.getNewIface(CONEXAO);
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(CONEXAO);
  try
    try
      lPedidoItensModel.objeto.IDPedidoVendaView := IDPEDIDO;
      lPedidoItensModel.objeto.obterLista;

      if lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.WEB_PEDIDOITENS_ID <> '' then
      begin
        for lPedidoItensModel in lPedidoItensModel.objeto.PedidoItenssLista do
        begin
          lWebPedidoItensModel.objeto.IDRecordView := lPedidoItensModel.objeto.WEB_PEDIDOITENS_ID;
          lWebPedidoItensModel.objeto.obterLista;

          mtItens.EmptyDataSet;
          mtItens.Append;
          mtItensNUMERO_BILHETE.Value := retornaNumeroBilhete('9', CONEXAO.getEmpresa.LOJA, lPedidoItensModel.objeto.ID);
          mtItens.Post;

          if (Copy(lWebPedidoItensModel.objeto.WebPedidoItenssLista[0].objeto.TIPO_GARANTIA,3,2) = '12') or (Copy(lWebPedidoItensModel.objeto.WebPedidoItenssLista[0].objeto.TIPO_GARANTIA,3,2) = '24') then
            reportPreview(RLReport1, lPedidoItensModel.objeto.ID)
        end;
        RLReport3.Preview;
      end;

    except
    on E:Exception do
      CriaException(E.Message);
    end;
  finally
    lPedidoItensModel:=nil;
    lWebPedidoItensModel:=nil;
  end;
end;

procedure TImpressaoContratos.fetchMemo;
var
  lClienteModel : ITClienteModel;
begin

  lClienteModel := TClienteModel.getNewIface(CONEXAO);
  try
    lClienteModel.objeto.IDRecordView := mtPedidoCLIENTE_ID.Value;
    lClienteModel.objeto.obterLista;

    RLMemo1.Lines.Text := '    Eu, '+lClienteModel.objeto.ClientesLista[0].objeto.FANTASIA_CLI+', inscrito no CPF/MF sob o nº '+formatoCNPJCPFGenerico(nil,lClienteModel.objeto.ClientesLista[0].objeto.CNPJ_CPF_CLI, true)+', proponente do seguro Garantia Estendida, autorizo que o pagamento do prêmio de seguro no valor de R$'+FormataFloat(mtItensVLR_GARANTIA.Value)+' seja realizado em conjunto com o pagamento do(s) produto(s)/serviço(s) ora adquirido(s).';

    RLMemo2.Lines.Text := '    Eu, '+lClienteModel.objeto.ClientesLista[0].objeto.FANTASIA_CLI+', inscrito no CPF/MF sob o nº '+formatoCNPJCPFGenerico(nil,lClienteModel.objeto.ClientesLista[0].objeto.CNPJ_CPF_CLI, true)+', proponente do Seguro Proteção de Bens, autorizo que o pagamento do prêmio de seguro no valor de R$'+FormataFloat(mtItensPREMIO_UNICO_FR.Value)+' seja realizado em conjunto com o pagamento do(s) produto(s)/serviço(s) ora adquirido(s).';

    RLMemo3.Lines.Text := RLMemo2.Lines.Text;
  finally
    lClienteModel:=nil;
  end;

end;


function TImpressaoContratos.retornaInicioVigencia(pInicio: String; pMesesGarantia: Integer): String;
begin
  if pMesesGarantia > 0 then
    Result := DateToStr(IncMonth((StrToDate(pInicio)+1),pMesesGarantia))
  else
    Result := pInicio;
end;

function TImpressaoContratos.retornaNumeroBilhete(pTipo, pFilial, pNumero : String) : String;
begin
  Result := '0000055666'+pTipo+pFilial+StringOfChar('0', 11 - Length(pNumero))+pNumero;
end;

procedure TImpressaoContratos.imprimirPrestamista;
var
  lPedidoVendaModel : ITPedidoVendaModel;
  lWebPedidoModel   : ITWebPedidoModel;
  lMemtable         : TFDMemtable;
begin
  lPedidoVendaModel := TPedidoVendaModel.getNewIface(CONEXAO);
  lWebPedidoModel   := TWebPedidoModel.getNewIface(CONEXAO);
  try
    try
      lPedidoVendaModel.objeto.IDRecordView := IDPEDIDO;
      lPedidoVendaModel.objeto.obterLista;

      lWebPedidoModel.objeto.ID := lPedidoVendaModel.objeto.PedidoVendasLista.First.objeto.WEB_PEDIDO_ID;
      lWebPedidoModel.objeto.obterTotais;

      if lWebPedidoModel.objeto.SEGURO_PRESTAMISTA_VALOR <> 0 then
      begin
        mtItens.EmptyDataSet;

        mtItens.Append;
        mtItensNUMERO_BILHETE.Value := retornaNumeroBilhete('7', CONEXAO.getEmpresa.LOJA, lPedidoVendaModel.objeto.PedidoVendasLista.First.objeto.NUMERO_PED);
        mtItens.Post;

        Self.fetchPedido;
        Self.fetchCliente;
        Self.fetchEmpresa;
        RLMemo4.Lines.Text := '    Eu, '+mtClienteCLIENTE_NOME.Value+', inscrito no CPF/MF sob o nº '+formatoCNPJCPFGenerico(nil,mtClienteCNPJ_CPF.Value , true)+', proponente do Seguro Prestamista, autorizo que o pagamento do prêmio de seguro no valor de R$'+FormataFloat(mtPedidoSEGURO_PRESTAMISTA.Value)+' seja realizado em conjunto com o  pagamento do(s) produto(s)/serviço(s) ora adquirido(s).';
        RLReport16.Preview;
      end;

    except
    on E:Exception do
      CriaException(E.Message);
    end;
  finally
    lPedidoVendaModel:=nil;
    lWebPedidoModel:=nil;
  end;
end;

procedure TImpressaoContratos.imprimirRF;
var
  lPedidoItensModel    : ITPedidoItensModel;
  lWebPedidoItensModel : ITWebPedidoItensModel;
begin
  lPedidoItensModel    := TPedidoItensModel.getNewIface(CONEXAO);
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(CONEXAO);
  try
    try
      lPedidoItensModel.objeto.IDPedidoVendaView := IDPEDIDO;
      lPedidoItensModel.objeto.obterLista;

      if lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.WEB_PEDIDOITENS_ID <> '' then
      begin
        for lPedidoItensModel in lPedidoItensModel.objeto.PedidoItenssLista do
        begin
          lWebPedidoItensModel.objeto.IDRecordView := lPedidoItensModel.objeto.WEB_PEDIDOITENS_ID;
          lWebPedidoItensModel.objeto.obterLista;

          mtItens.EmptyDataSet;
          mtItens.Append;
          mtItensNUMERO_BILHETE.Value := retornaNumeroBilhete('8', CONEXAO.getEmpresa.LOJA, lPedidoItensModel.objeto.ID);
          mtItens.Post;

          if (Copy(lWebPedidoItensModel.objeto.WebPedidoItenssLista[0].objeto.TIPO_GARANTIA_FR,3,2) = '12') or (Copy(lWebPedidoItensModel.objeto.WebPedidoItenssLista[0].objeto.TIPO_GARANTIA_FR,3,2) = '24') then
            reportPreview(RLReport5, lPedidoItensModel.objeto.ID)
        end;
        RLReport6.Preview;
      end;

    except
    on E:Exception do
      CriaException(E.Message);
    end;
  finally
    lPedidoItensModel:=nil;
    lWebPedidoItensModel:=nil;
  end;
end;

procedure TImpressaoContratos.imprimirRFD;
var
  lPedidoItensModel    : ITPedidoItensModel;
  lWebPedidoItensModel : ITWebPedidoItensModel;
begin
  lPedidoItensModel    := TPedidoItensModel.getNewIface(CONEXAO);
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(CONEXAO);
  try
    try
      lPedidoItensModel.objeto.IDPedidoVendaView := IDPEDIDO;
      lPedidoItensModel.objeto.obterLista;

      if lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.WEB_PEDIDOITENS_ID <> '' then
      begin
        for lPedidoItensModel in lPedidoItensModel.objeto.PedidoItenssLista do
        begin
          lWebPedidoItensModel.objeto.IDRecordView := lPedidoItensModel.objeto.WEB_PEDIDOITENS_ID;
          lWebPedidoItensModel.objeto.obterLista;

          mtItens.EmptyDataSet;
          mtItens.Append;
          mtItensNUMERO_BILHETE.Value := retornaNumeroBilhete('8', CONEXAO.getEmpresa.LOJA, lPedidoItensModel.objeto.ID);
          mtItens.Post;

          if (Copy(lWebPedidoItensModel.objeto.WebPedidoItenssLista[0].objeto.TIPO_GARANTIA_FR,3,2) = '12') or (Copy(lWebPedidoItensModel.objeto.WebPedidoItenssLista[0].objeto.TIPO_GARANTIA_FR,3,2) = '24') then
          reportPreview(RLReport10, lPedidoItensModel.objeto.ID)
        end;
        RLReport11.Preview;
      end;

    except
    on E:Exception do
      CriaException(E.Message);
    end;
  finally
    lPedidoItensModel:=nil;
    lWebPedidoItensModel:=nil;
  end;
end;

procedure TImpressaoContratos.reportPreview(pReportItem: TRLReport; pItem: String);
var
  lPedidoItensModel : ITPedidoItensModel;
  i : Integer;
begin

  Self.fetchPedido;
  Self.fetchCliente;
  Self.fetchEmpresa;

  lPedidoItensModel := TPedidoItensModel.getNewIface(CONEXAO);
  try
    lPedidoItensModel.objeto.IDRecordView := pItem;
    lPedidoItensModel.objeto.obterLista;

    for i := 0 to lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.QUANTIDADE_PED - 1 do
    begin
      fetchPedidoItens(lPedidoItensModel.objeto.PedidoItenssLista[0].objeto.ID);
      pReportItem.PreviewModal();
    end;

  finally
    lPedidoItensModel:=nil;
  end;

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
