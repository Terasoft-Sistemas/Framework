unit Impressao.VendaAssistida;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, RLReport, RLBarcode,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  RLXLSXFilter, RLFilters, RLPDFFilter, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Terasoft.Utils, Interfaces.Conexao;

type
  TImpressaoVendaAssistida = class(TForm)
    PageControl1: TPageControl;
    VendaAssistida: TTabSheet;
    rlPadrao: TRLReport;
    RLBand4: TRLBand;
    RLBand5: TRLBand;
    RLDraw21: TRLDraw;
    RLLabel36: TRLLabel;
    RLDBText14: TRLDBText;
    RLLabel37: TRLLabel;
    RLDBText15: TRLDBText;
    RLLabel38: TRLLabel;
    RLDBText16: TRLDBText;
    RLLabel39: TRLLabel;
    RLDBText17: TRLDBText;
    RLLabel40: TRLLabel;
    RLDBText18: TRLDBText;
    RLLabel41: TRLLabel;
    RLDBText19: TRLDBText;
    RLLabel42: TRLLabel;
    RLDBText20: TRLDBText;
    RLLabel43: TRLLabel;
    RLDBText22: TRLDBText;
    RLLabel45: TRLLabel;
    RLDBText23: TRLDBText;
    RLLabel47: TRLLabel;
    RLDBText25: TRLDBText;
    RLLabel44: TRLLabel;
    RLDBText21: TRLDBText;
    RLLabel46: TRLLabel;
    RLDBText24: TRLDBText;
    RLLabel30: TRLLabel;
    RLDBText26: TRLDBText;
    RLLabel27: TRLLabel;
    RLDBText1: TRLDBText;
    RLBand7: TRLBand;
    RLDraw36: TRLDraw;
    RLDBMemo1: TRLDBMemo;
    RLDraw23: TRLDraw;
    RLDraw24: TRLDraw;
    RLDBText2: TRLDBText;
    RLBand9: TRLBand;
    rlLabelEmpresaNome: TRLLabel;
    rlLabelEmpresaEndereco: TRLLabel;
    RLBand2: TRLBand;
    RLDraw3: TRLDraw;
    RLBand3: TRLBand;
    RLDBText5: TRLDBText;
    RLDBText12: TRLDBText;
    RLDBText13: TRLDBText;
    RLDBText28: TRLDBText;
    rlBandFatura: TRLBand;
    RLLabel3: TRLLabel;
    rlTitleFatura: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    drawFaturasLeft: TRLDraw;
    rlMemoParcelaLeft: TRLMemo;
    rlMemoVencimentoLeft: TRLMemo;
    rlMemoValorLeft: TRLMemo;
    rlMemoPortadorLeft: TRLMemo;
    RLLabel31: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    drawFaturasRight: TRLDraw;
    rlMemoParcelaRight: TRLMemo;
    rlMemoVencimentoRight: TRLMemo;
    rlMemoValorRight: TRLMemo;
    rlMemoPortadorRight: TRLMemo;
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
    RLDBText3: TRLDBText;
    labelEmissao: TRLLabel;
    RLLabel65: TRLLabel;
    RLDBText49: TRLDBText;
    RLDBText42: TRLDBText;
    RLLabel57: TRLLabel;
    RLLabel64: TRLLabel;
    RLDBText48: TRLDBText;
    lblDescPercentual: TRLLabel;
    RLDBText41: TRLDBText;
    RLLabel63: TRLLabel;
    RLDBText47: TRLDBText;
    RLLabel16: TRLLabel;
    RLLabel17: TRLLabel;
    RLLabel18: TRLLabel;
    RLLabel20: TRLLabel;
    RLLabel21: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel11: TRLLabel;
    RLLabel12: TRLLabel;
    RLLabel13: TRLLabel;
    RLLabel14: TRLLabel;
    RLLabel15: TRLLabel;
    RLLabel32: TRLLabel;
    RLLabel33: TRLLabel;
    RLLabel35: TRLLabel;
    RLLabel34: TRLLabel;
    RLLabel48: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    IMPRESSO: TRLDBText;
    RLLabel50: TRLLabel;
    RLLabel51: TRLLabel;
    mtClienteRG: TStringField;
    RLDBText4: TRLDBText;
    LOJA: TRLDBText;
    mtItensVLR_GARANTIA: TFloatField;
    mtItensMONTAGEM: TStringField;
    mtItensTIPO_GARANTIA: TStringField;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLDBText10: TRLDBText;
    mtItensUNIDADE_PRO: TStringField;
    RLDBText11: TRLDBText;
    mtItensENTREGA: TStringField;
    mtItensTIPO: TStringField;
    mtItensTIPO_ENTREGA: TStringField;
    RLDBText29: TRLDBText;
    mtPedidoTOTAL_GARANTIA: TFloatField;
    RLDBText30: TRLDBText;
    RLDraw1: TRLDraw;
    RLDraw2: TRLDraw;
    RLDraw4: TRLDraw;
    RLDraw5: TRLDraw;
    RLDraw6: TRLDraw;
    RLDraw7: TRLDraw;
    RLBand1: TRLBand;
    RLLabel4: TRLLabel;
    RLDBText31: TRLDBText;
    RLLabel52: TRLLabel;
    rlImageLogo: TRLImage;
    RLDBMemo2: TRLDBMemo;
    RLLabel2: TRLLabel;
    RLDraw8: TRLDraw;
    mtPedidoSEGURO_PRESTAMISTA: TFloatField;
    RLDBText6: TRLDBText;
    mtItensTIPO_GARANTIA_FR: TStringField;
    RLDBText27: TRLDBText;
    mtItensOBSERVACAO: TStringField;
    RLDBMemo3: TRLDBMemo;
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

    property IDPEDIDO: Variant read FIDPEDIDO write SetIDPEDIDO;
    property NOMEARQUIVO: Variant read FNOMEARQUIVO write SetNOMEARQUIVO;
    property PREVIEW: Variant read FPREVIEW write SetPREVIEW;
    property PDF: Variant read FPDF write SetPDF;
    property DIR: Variant read FDIR write SetDIR;
    property CNPJEMPRESA : Variant read FCNPJEMPRESA write SetCNPJEMPRESA;
    property CONTADOR: Variant read FCONTADOR write SetCONTADOR;
    property DIRLOGO: Variant read FDIRLOGO write SetDIRLOGO;
    property CONEXAO: IConexao read FCONEXAO write SetCONEXAO;

    function imprimir: string;
    procedure fetchPedido;
    procedure fetchCliente;
    procedure fetchPedidoItens;
    procedure fetchFinanceiro;
    procedure fetchEmpresa;

    { Public declarations }
  end;

var
	ImpressaoVendaAssistida: TImpressaoVendaAssistida;

implementation

uses
  Winapi.ActiveX, PedidoVendaModel, ClienteModel, PedidoItensModel, EmpresaModel, WebPedidoModel, WebPedidoItensModel,
  FinanceiroPedidoModel, ProdutosModel, LojasModel, Terasoft.Types;

{$R *.dfm}

procedure TImpressaoVendaAssistida.fetchCliente;
var
  lClienteModel : ITClienteModel;
begin

  lClienteModel := TClienteModel.getNewIface(CONEXAO);
  try
    if mtPedidoCLIENTE_ID.AsString = '' then
      raise Exception.Create('ID do Cliente n�o localizado');

    lClienteModel.objeto.IDRecordView := mtPedidoCLIENTE_ID.AsString;
    lClienteModel.objeto.obterLista;

    if Length(lClienteModel.objeto.ClientesLista[0].objeto.CNPJ_CPF_CLI) = 14 then
      mtClienteCNPJ_CPF.EditMask := '99.999.999/9999-99;0;'
    else
      mtClienteCNPJ_CPF.EditMask := '999.999.999-99;0;';

    mtCliente.Open;
    mtCliente.Append;
    mtClienteCLIENTE_NOME.Value := lClienteModel.objeto.ClientesLista[0].objeto.FANTASIA_CLI;
    mtClienteRAZAO_SOCIAL.Value := lClienteModel.objeto.ClientesLista[0].objeto.RAZAO_CLI;
    mtClienteCNPJ_CPF.Value     := lClienteModel.objeto.ClientesLista[0].objeto.CNPJ_CPF_CLI;
    mtClienteRG.Value           := lClienteModel.objeto.ClientesLista[0].objeto.INSCRICAO_RG_CLI;

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
    mtCliente.Post;

  finally
    lClienteModel:=nil;
  end;

end;

procedure TImpressaoVendaAssistida.fetchEmpresa;
var
  lEmpresaModel : ITEmpresaModel;
  lLojasModel, l   : ITLojasModel;
begin
  lEmpresaModel := TEmpresaModel.getNewIface(CONEXAO);
  lLojasModel   := TLojasModel.getNewIface(CONEXAO);
  try
    lEmpresaModel.objeto.Carregar;

    rlLabelEmpresaNome.Caption     := lEmpresaModel.objeto.RAZAO_SOCIAL;
    rlLabelEmpresaEndereco.Caption := lEmpresaModel.objeto.ENDERECO+' '+lEmpresaModel.objeto.NUMERO+' '+lEmpresaModel.objeto.COMPLEMENTO;

    lLojasModel.objeto.LojaView := lEmpresaModel.objeto.LOJA;
    lLojasModel.objeto.obterLista;

    LOJA.Text := lLojasModel.objeto.LojassLista.First.objeto.DESCRICAO;
    Self.FDIRLOGO := lEmpresaModel.objeto.LOGO;
  finally
    lEmpresaModel := nil;
    lLojasModel:=nil;
  end;
end;

procedure TImpressaoVendaAssistida.fetchFinanceiro;
var
  lFinanceiroPedidoModel : ITFinanceiroPedidoModel;
  lMemtable              : IFDDataset;
  lParcela               : Integer;
begin

  lFinanceiroPedidoModel := TFinanceiroPedidoModel.getNewIface(CONEXAO);

  try
    lFinanceiroPedidoModel.objeto.WhereView := 'AND FINANCEIRO_PEDIDO.WEB_PEDIDO_ID ='+ Self.FIDPEDIDO;
    lFinanceiroPedidoModel.objeto.OrderView := 'FINANCEIRO_PEDIDO.ID_FINANCEIRO, FINANCEIRO_PEDIDO.PARCELA';

    lMemtable := lFinanceiroPedidoModel.objeto.obterLista;
    if (lMemtable.objeto.RecordCount > 0) then begin
      lParcela := 0;
      lMemtable.objeto.First;
      while not lMemTable.objeto.Eof do
      begin
        inc(lParcela);
        if Odd(lParcela) then begin
          rlMemoParcelaLeft.Lines.Add(lMemtable.objeto.FieldByName('PARCELA').AsString+'/'+lMemtable.objeto.FieldByName('QUANTIDADE_PARCELAS').AsString);
          rlMemoVencimentoLeft.Lines.Add(lMemtable.objeto.FieldByName('VENCIMENTO').AsString);
          rlMemoValorLeft.Lines.Add(FormatCurr('#,###0.00', lMemtable.objeto.FieldByName('VALOR_PARCELA').AsFloat));
          rlMemoPortadorLeft.Lines.Add(lMemtable.objeto.FieldByName('NOME_PORT').AsString);
        end
        else begin
          rlMemoParcelaRight.Lines.Add(lMemtable.objeto.FieldByName('PARCELA').AsString+'/'+lMemtable.objeto.FieldByName('QUANTIDADE_PARCELAS').AsString);
          rlMemoVencimentoRight.Lines.Add(lMemtable.objeto.FieldByName('VENCIMENTO').AsString);
          rlMemoValorRight.Lines.Add(FormatCurr('#,###0.00', lMemtable.objeto.FieldByName('VALOR_PARCELA').AsFloat));
          rlMemoPortadorRight.Lines.Add(lMemtable.objeto.FieldByName('NOME_PORT').AsString);
        end;
        lMemtable.objeto.Next;
      end;

      drawFaturasLeft.Height  := rlMemoVencimentoLeft.Height+3;
      drawFaturasRight.Height := drawFaturasLeft.Height;
      rlBandFatura.Height     := rlTitleFatura.Height + drawFaturasLeft.Height + 10;
    end
    else
      rlBandFatura.Visible := false;
  finally
    lFinanceiroPedidoModel:=nil;
  end;
end;

procedure TImpressaoVendaAssistida.fetchPedido;
var
  lWebPedidoModel : ITWebPedidoModel;
  lMemtable       : IFDDataset;
begin
  lWebPedidoModel := TWebPedidoModel.getNewIface(CONEXAO);
  try

    lWebPedidoModel.objeto.IDRecordView := Self.FIDPEDIDO;
    lMemtable := lWebPedidoModel.objeto.Obterlista;
    lWebPedidoModel.objeto.ID := Self.FIDPEDIDO;
    lWebPedidoModel.objeto.ObterTotais;

    if lMemtable.objeto.RecordCount = 0 then
      raise Exception.Create('Pedido de venda '+Self.FIDPEDIDO+' n�o localizado');

    mtPedido.Open;
    mtPedido.Append;
    mtPedidoNUMERO.Value              := lMemtable.objeto.FieldByName('ID').AsString;
    mtPedidoEMISSAO.Value             := lMemtable.objeto.FieldByName('DATAHORA').AsString;
    mtPedidoOBSERVACAO.Value          := lMemtable.objeto.FieldByName('OBSERVACAO').AsString;
    mtPedidoVALOR_PRODUTOS.Value      := lWebPedidoModel.objeto.VALOR_ITENS;
    mtPedidoVALOR_DESCONTO.Value      := lWebPedidoModel.objeto.VALOR_CUPOM_DESCONTO;
    lblDescPercentual.Caption         := 'Desconto ('+FormatFloat(',0.000',lWebPedidoModel.objeto.VALOR_CUPOM_DESCONTO*100/lWebPedidoModel.objeto.VALOR_ITENS)+'%)';
    mtPedidoTOTAL_GARANTIA.Value      := lWebPedidoModel.objeto.TOTAL_GARANTIA;
    mtPedidoSEGURO_PRESTAMISTA.Value  := lWebPedidoModel.objeto.SEGURO_PRESTAMISTA_VALOR;
    mtPedidoVALOR_ACRESCIMO.Value     := lWebPedidoModel.objeto.ACRESCIMO;
    mtPedidoVALOR_FRETE.Value         := lWebPedidoModel.objeto.VALOR_FRETE;
    mtPedidoVALOR_TOTAL.Value         := lWebPedidoModel.objeto.VALOR_TOTAL;
    mtPedidoVENDEDOR.Value            := lMemtable.objeto.FieldByName('VENDEDOR').AsString;
    mtPedidoCLIENTE_ID.Value          := lMemtable.objeto.FieldByName('CLIENTE_ID').AsString;
    mtPedido.Post;

    IMPRESSO.Text := FormatDateTime('dd/mm/yyyy hh:nn:ss', CONEXAO.DataHoraServer);
  finally
    lWebPedidoModel:=nil;
  end;
end;

procedure TImpressaoVendaAssistida.fetchPedidoItens;
var
  lWebPedidoItensModel : ITWebPedidoItensModel;
begin
  lWebPedidoItensModel := TWebPedidoItensModel.getNewIface(CONEXAO);
  try
    lWebPedidoItensModel.objeto.IDWebPedidoView := Self.FIDPEDIDO;
    lWebPedidoItensModel.objeto.obterLista;
    mtItens.Open;
    for lWebPedidoItensModel in lWebPedidoItensModel.objeto.WebPedidoItenssLista do begin
      mtItens.Append;
      mtItensID.Value               := lWebPedidoItensModel.objeto.ID;
      mtItensUNIDADE_PRO.Value      := lWebPedidoItensModel.objeto.UNIDADE_PRO;
      mtItensPRODUTO_ID.Value       := lWebPedidoItensModel.objeto.PRODUTO_ID;
      mtItensPRODUTO.Value          := lWebPedidoItensModel.objeto.PRODUTO_NOME;
      mtItensQUANTIDADE.Value       := lWebPedidoItensModel.objeto.QUANTIDADE;
      mtItensVALOR_UNITARIO.Value   := lWebPedidoItensModel.objeto.VALOR_UNITARIO;
      mtItensVLR_GARANTIA.Value     := lWebPedidoItensModel.objeto.TOTAL_GARANTIA;
      mtItensENTREGA.AsString       := IIF(lWebPedidoItensModel.objeto.ENTREGA = 'N', 'N�O', 'SIM');
      mtItensMONTAGEM.AsString      := IIF(lWebPedidoItensModel.objeto.MONTAGEM = 'N', 'N�O', 'SIM');
      mtItensTIPO.AsString          := IIF(lWebPedidoItensModel.objeto.TIPO = 'FUTURA', 'SIM', 'N�O');
      mtItensTIPO_ENTREGA.AsString  := IIF(lWebPedidoItensModel.objeto.TIPO_ENTREGA = 'LJ', 'LOJA', 'CD');
      mtItensTIPO_GARANTIA.Value    := lWebPedidoItensModel.objeto.TIPO_GARANTIA;
      mtItensTIPO_GARANTIA_FR.Value := lWebPedidoItensModel.objeto.TIPO_GARANTIA_FR;
      mtItensVALOR_TOTAL.Value      := lWebPedidoItensModel.objeto.VALOR_TOTALITENS;
      mtItensOBSERVACAO.Value       := lWebPedidoItensModel.objeto.OBSERVACAO;

      mtItens.Post;
    end;

  finally
    lWebPedidoItensModel:=nil;
  end;
end;

procedure TImpressaoVendaAssistida.FormCreate(Sender: TObject);
begin
  CoInitialize(nil);
end;

procedure TImpressaoVendaAssistida.FormDestroy(Sender: TObject);
begin
 CoUninitialize;
end;

function TImpressaoVendaAssistida.imprimir;
begin

  if Self.FIDPEDIDO = '' then
    raise Exception.Create('Pedido n�o informado para impress�o');

  Result := '';

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
        raise Exception.Create('Diret�rio n�o informado');

      if not DirectoryExists(Self.FDIR) then
        ForceDirectories(Self.FDIR);

      Result := FloatToStr(Round(random(999999))) + Self.FIDPEDIDO + '.pdf';
      try
        rlPadrao.SaveToFile(Self.FDIR+Result);
      except
        on E:Exception do

      end;
      Self.SetNOMEARQUIVO(Result);
    end;

  finally
  end;
end;

procedure TImpressaoVendaAssistida.RLBand3BeforePrint(Sender: TObject;
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

procedure TImpressaoVendaAssistida.SetCNPJEMPRESA(const Value: Variant);
begin
  FCNPJEMPRESA := Value;
end;

procedure TImpressaoVendaAssistida.SetCONEXAO(const Value: IConexao);
begin
  FCONEXAO := Value;
end;

procedure TImpressaoVendaAssistida.SetCONTADOR(const Value: Variant);
begin
  FCONTADOR := Value;
end;

procedure TImpressaoVendaAssistida.SetDIR(const Value: Variant);
begin
  FDIR := Value;
end;

procedure TImpressaoVendaAssistida.SetDIRLOGO(const Value: Variant);
begin
  FDIRLOGO := Value;
end;

procedure TImpressaoVendaAssistida.SetIDPEDIDO(const Value: Variant);
begin
  FIDPEDIDO := Value;
end;

procedure TImpressaoVendaAssistida.SetNOMEARQUIVO(const Value: Variant);
begin
  FNOMEARQUIVO := Value;
end;

procedure TImpressaoVendaAssistida.SetPDF(const Value: Variant);
begin
  FPDF := Value;
end;

procedure TImpressaoVendaAssistida.SetPREVIEW(const Value: Variant);
begin
  FPREVIEW := Value;
end;
end.
