unit Impressao.Contratos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, RLReport, RLBarcode,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  RLXLSXFilter, RLFilters, RLPDFFilter, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Terasoft.Utils, Interfaces.Conexao, xPNGimage,
  Vcl.Imaging.jpeg;

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
    RLDraw7: TRLDraw;
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RLBand3BeforePrint(Sender: TObject; var PrintIt: Boolean);
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
    procedure fetchFinanceiro;
    procedure fetchEmpresa;

    { Public declarations }
  end;

var
	ImpressaoContratos: TImpressaoContratos;

implementation

uses
  Winapi.ActiveX, PedidoVendaModel, ClienteModel, PedidoItensModel, EmpresaModel, WebPedidoModel, WebPedidoItensModel,
  FinanceiroPedidoModel, ProdutosModel, LojasModel, Terasoft.Types;

{$R *.dfm}

procedure TImpressaoContratos.fetchCliente;
var
  lClienteModel : TClienteModel;
begin

  lClienteModel := TClienteModel.Create(CONEXAO);
  try
    if mtPedidoCLIENTE_ID.AsString = '' then
      raise Exception.Create('ID do Cliente não localizado');

    lClienteModel.IDRecordView := mtPedidoCLIENTE_ID.AsString;
    lClienteModel.obterLista;

    if Length(lClienteModel.ClientesLista[0].CNPJ_CPF_CLI) = 14 then
      mtClienteCNPJ_CPF.EditMask := '99.999.999/9999-99;0;'
    else
      mtClienteCNPJ_CPF.EditMask := '999.999.999-99;0;';

    mtCliente.Open;
    mtCliente.Append;
    mtClienteCLIENTE_NOME.Value := lClienteModel.ClientesLista[0].FANTASIA_CLI;
    mtClienteRAZAO_SOCIAL.Value := lClienteModel.ClientesLista[0].RAZAO_CLI;
    mtClienteCNPJ_CPF.Value     := lClienteModel.ClientesLista[0].CNPJ_CPF_CLI;
    mtClienteRG.Value           := lClienteModel.ClientesLista[0].INSCRICAO_RG_CLI;

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

procedure TImpressaoContratos.fetchEmpresa;
var
  lEmpresaModel : TEmpresaModel;
  lLojasModel, l   : TLojasModel;
begin
  lEmpresaModel := TEmpresaModel.Create(CONEXAO);
  lLojasModel   := TLojasModel.Create(CONEXAO);
  try
    lEmpresaModel.Carregar;

    rlLabelEmpresaNome.Caption     := lEmpresaModel.RAZAO_SOCIAL;
    rlLabelEmpresaEndereco.Caption := lEmpresaModel.ENDERECO+' '+lEmpresaModel.NUMERO+' '+lEmpresaModel.COMPLEMENTO;

    lLojasModel.LojaView := lEmpresaModel.LOJA;
    lLojasModel.obterLista;

    LOJA.Text := lLojasModel.LojassLista[0].DESCRICAO;
    Self.FDIRLOGO := lEmpresaModel.LOGO;
  finally
    lEmpresaModel.Free;
    lLojasModel.Free;
  end;
end;

procedure TImpressaoContratos.fetchFinanceiro;
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  lMemtable              : TFDMemtable;
  lParcela               : Integer;
begin

  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(CONEXAO);

  try
    lFinanceiroPedidoModel.WhereView := 'AND FINANCEIRO_PEDIDO.WEB_PEDIDO_ID ='+ Self.FIDPEDIDO;
    lFinanceiroPedidoModel.OrderView := 'FINANCEIRO_PEDIDO.ID_FINANCEIRO, FINANCEIRO_PEDIDO.PARCELA';

    lMemtable := lFinanceiroPedidoModel.obterLista;
    if (lMemtable.RecordCount > 0) then begin
      lParcela := 0;
      lMemtable.First;
      while not lMemTable.Eof do
      begin
        inc(lParcela);
        if Odd(lParcela) then begin
          rlMemoParcelaLeft.Lines.Add(lMemtable.FieldByName('PARCELA').AsString+'/'+lMemtable.FieldByName('QUANTIDADE_PARCELAS').AsString);
          rlMemoVencimentoLeft.Lines.Add(lMemtable.FieldByName('VENCIMENTO').AsString);
          rlMemoValorLeft.Lines.Add(FormatCurr('#,###0.00', lMemtable.FieldByName('VALOR_PARCELA').AsFloat));
          rlMemoPortadorLeft.Lines.Add(lMemtable.FieldByName('NOME_PORT').AsString);
        end
        else begin
          rlMemoParcelaRight.Lines.Add(lMemtable.FieldByName('PARCELA').AsString+'/'+lMemtable.FieldByName('QUANTIDADE_PARCELAS').AsString);
          rlMemoVencimentoRight.Lines.Add(lMemtable.FieldByName('VENCIMENTO').AsString);
          rlMemoValorRight.Lines.Add(FormatCurr('#,###0.00', lMemtable.FieldByName('VALOR_PARCELA').AsFloat));
          rlMemoPortadorRight.Lines.Add(lMemtable.FieldByName('NOME_PORT').AsString);
        end;
        lMemtable.Next;
      end;

      drawFaturasLeft.Height  := rlMemoVencimentoLeft.Height+3;
      drawFaturasRight.Height := drawFaturasLeft.Height;
      rlBandFatura.Height     := rlTitleFatura.Height + drawFaturasLeft.Height + 10;
    end
    else
      rlBandFatura.Visible := false;
  finally
    lFinanceiroPedidoModel.Free;
    lMemtable.Free;
  end;
end;

procedure TImpressaoContratos.fetchPedido;
var
  lWebPedidoModel : TWebPedidoModel;
  lMemtable       : TFDMemtable;
begin
  lWebPedidoModel := TWebPedidoModel.Create(CONEXAO);
  try

    lWebPedidoModel.IDRecordView := Self.FIDPEDIDO;
    lMemtable := lWebPedidoModel.Obterlista;
    lWebPedidoModel.ID := Self.FIDPEDIDO;
    lWebPedidoModel.ObterTotais;

    if lMemtable.RecordCount = 0 then
      raise Exception.Create('Pedido de venda '+Self.FIDPEDIDO+' não localizado');

    mtPedido.Open;
    mtPedido.Append;
    mtPedidoNUMERO.Value              := lMemtable.FieldByName('ID').AsString;
    mtPedidoEMISSAO.Value             := lMemtable.FieldByName('DATAHORA').AsString;
    mtPedidoOBSERVACAO.Value          := lMemtable.FieldByName('OBSERVACAO').AsString;
    mtPedidoVALOR_PRODUTOS.Value      := lMemtable.FieldByName('VALOR_ITENS').AsFloat;
    mtPedidoVALOR_DESCONTO.Value      := lMemtable.FieldByName('VALOR_CUPOM_DESCONTO').AsFloat*100/lMemtable.FieldByName('VALOR_ITENS').AsFloat;
    mtPedidoSEGURO_PRESTAMISTA.Value  := lWebPedidoModel.SEGURO_PRESTAMISTA_VALOR;
    mtPedidoVALOR_ACRESCIMO.Value     := lMemtable.FieldByName('ACRESCIMO').AsFloat;
    mtPedidoVALOR_FRETE.Value         := lMemtable.FieldByName('VALOR_FRETE').AsFloat;
    mtPedidoVALOR_TOTAL.Value         := lMemtable.FieldByName('VALOR_TOTAL').AsFloat;
    mtPedidoVENDEDOR.Value            := lMemtable.FieldByName('VENDEDOR').AsString;
    mtPedidoCLIENTE_ID.Value          := lMemtable.FieldByName('CLIENTE_ID').AsString;
    mtPedido.Post;

    IMPRESSO.Text := FormatDateTime('dd/mm/yyyy hh:nn:ss', CONEXAO.DataHoraServer);
  finally
    lWebPedidoModel.Free;
  end;
end;

procedure TImpressaoContratos.fetchPedidoItens;
var
  lWebPedidoItensModel : TWebPedidoItensModel;
  lGarantia : Double;
begin
  lWebPedidoItensModel := TWebPedidoItensModel.Create(CONEXAO);
  try
    lWebPedidoItensModel.IDWebPedidoView := Self.FIDPEDIDO;
    lWebPedidoItensModel.obterLista;
    vGarantia := 0;
    mtItens.Open;
    for lWebPedidoItensModel in lWebPedidoItensModel.WebPedidoItenssLista do begin
      mtItens.Append;
      mtItensID.Value               := lWebPedidoItensModel.ID;
      mtItensUNIDADE_PRO.Value      := lWebPedidoItensModel.UNIDADE_PRO;
      mtItensPRODUTO_ID.Value       := lWebPedidoItensModel.PRODUTO_ID;
      mtItensPRODUTO.Value          := lWebPedidoItensModel.PRODUTO_NOME;
      mtItensQUANTIDADE.Value       := lWebPedidoItensModel.QUANTIDADE;
      mtItensVALOR_UNITARIO.Value   := lWebPedidoItensModel.VALOR_UNITARIO;
      mtItensVLR_GARANTIA.Value     := lWebPedidoItensModel.TOTAL_GARANTIA;
      mtItensENTREGA.AsString       := IIF(lWebPedidoItensModel.ENTREGA = 'N', 'NÃO', 'SIM');
      mtItensMONTAGEM.AsString      := IIF(lWebPedidoItensModel.MONTAGEM = 'N', 'NÃO', 'SIM');
      mtItensTIPO.AsString          := IIF(lWebPedidoItensModel.TIPO = 'FUTURA', 'SIM', 'NÃO');
      mtItensTIPO_ENTREGA.AsString  := IIF(lWebPedidoItensModel.TIPO_ENTREGA = 'LJ', 'LOJA', 'CD');
      mtItensTIPO_GARANTIA.Value    := lWebPedidoItensModel.TIPO_GARANTIA;
      mtItensTIPO_GARANTIA_FR.Value := lWebPedidoItensModel.TIPO_GARANTIA_FR;
      mtItensVALOR_TOTAL.Value      := lWebPedidoItensModel.VALOR_TOTALITENS;
      mtItensOBSERVACAO.Value       := lWebPedidoItensModel.OBSERVACAO;

      mtItens.Post;

      vGarantia := vGarantia + mtItensQUANTIDADE.Value * mtItensVLR_GARANTIA.Value;
    end;

    mtPedido.Edit;
    mtPedidoTOTAL_GARANTIA.Value := vGarantia;
    mtPedido.Post;

  finally
    lWebPedidoItensModel.Free;
  end;
end;

procedure TImpressaoContratos.FormCreate(Sender: TObject);
begin
  CoInitialize(nil);
end;

procedure TImpressaoContratos.FormDestroy(Sender: TObject);
begin
 CoUninitialize;
end;

procedure TImpressaoContratos.imprimir;
var
  lNameArchive : string;
begin

  if Self.FIDPEDIDO = '' then
    raise Exception.Create('Pedido não informado para impressão');

  lNameArchive := '';

  try
    Self.fetchPedido;
    Self.fetchCliente;
    Self.fetchPedidoItens;
    Self.fetchFinanceiro;
    Self.fetchEmpresa;

    if FDIRLOGO <> '' then
    begin
      try
        Self.rlImageLogo.Picture.LoadFromFile(Self.FDIRLOGO);
      Except
        RLBand4.Visible := false;
      end;
    end;

    Self.FCONTADOR := 1;

    if Self.FPREVIEW then
      rlPadrao.Preview();

    if Self.FPDF then begin
      if Self.FDIR = '' then
        raise Exception.Create('Diretório não informado');

      if not DirectoryExists(Self.FDIR) then
        ForceDirectories(Self.FDIR);

      lNameArchive := FloatToStr(Round(random(999999))) + Self.FIDPEDIDO + '.pdf';
      try
        rlPadrao.SaveToFile(Self.FDIR+lNameArchive);
      except
        on E:Exception do

      end;
      Self.SetNOMEARQUIVO(lNameArchive);
    end;

  finally
  end;
end;

procedure TImpressaoContratos.RLBand3BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
var
  lCOntador: Integer;
begin
  lContador := Self.FCONTADOR;

  if Odd(lContador) then
    RLBand3.Color := clWhite
  else
    RLBand3.Color := cl3DLight;

  Self.FCONTADOR := Self.FCONTADOR + 1;

  if mtItensOBSERVACAO.Value = '' then
    RLBand3.Height := 25
  else
    RLBand3.Height := 45;
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
