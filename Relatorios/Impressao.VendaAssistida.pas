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
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    drawFaturasLeft: TRLDraw;
    rlMemoFaturaLeft: TRLMemo;
    rlMemoParcelaLeft: TRLMemo;
    rlMemoVencimentoLeft: TRLMemo;
    rlMemoValorLeft: TRLMemo;
    rlMemoPortadorLeft: TRLMemo;
    RLLabel31: TRLLabel;
    RLLabel22: TRLLabel;
    RLLabel23: TRLLabel;
    RLLabel24: TRLLabel;
    RLLabel25: TRLLabel;
    RLLabel26: TRLLabel;
    drawFaturasRight: TRLDraw;
    rlMemoFaturaRight: TRLMemo;
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
    RLLabel56: TRLLabel;
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
	ImpressaoVendaAssistida: TImpressaoVendaAssistida;

implementation

uses
  Winapi.ActiveX, PedidoVendaModel, ClienteModel, PedidoItensModel, EmpresaModel, WebPedidoModel, WebPedidoItensModel,
  FinanceiroPedidoModel, ProdutosModel, LojasModel, Terasoft.Types;

{$R *.dfm}

procedure TImpressaoVendaAssistida.fetchCliente;
var
  lClienteModel : TClienteModel;
begin

  lClienteModel := TClienteModel.Create(CONEXAO);
  try
    if not mtPedidoCLIENTE_ID.AsInteger > 0 then
      raise Exception.Create('Id do cliente não localizado');

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

procedure TImpressaoVendaAssistida.fetchEmpresa;
var
  lEmpresaModel : TEmpresaModel;
begin
  lEmpresaModel := TEmpresaModel.Create(CONEXAO);
  try
    lEmpresaModel.Carregar;

    rlLabelEmpresaNome.Caption     := lEmpresaModel.RAZAO_SOCIAL;
    rlLabelEmpresaEndereco.Caption := lEmpresaModel.ENDERECO+' '+lEmpresaModel.NUMERO+' '+lEmpresaModel.COMPLEMENTO;
    LOJA.Text := lEmpresaModel.RAZAO_SOCIAL;
    Self.FDIRLOGO := lEmpresaModel.LOGO;
  finally
    lEmpresaModel.Free;
  end;
end;

procedure TImpressaoVendaAssistida.fetchFinanceiro;
var
  lFinanceiroPedidoModel : TFinanceiroPedidoModel;
  lMemtable              : TFDMemtable;
  lParcela               : Integer;
begin

  lFinanceiroPedidoModel := TFinanceiroPedidoModel.Create(CONEXAO);

  try
    lFinanceiroPedidoModel.WhereView := 'AND FINANCEIRO_PEDIDO.WEB_PEDIDO_ID ='+ Self.FIDPEDIDO;
    lFinanceiroPedidoModel.OrderView := 'PORTADOR.NOME_PORT, FINANCEIRO_PEDIDO.PARCELA';

    lMemtable := lFinanceiroPedidoModel.obterLista;
    if (lMemtable.RecordCount > 0) then begin
      lParcela := 0;
      lMemtable.First;
      while not lMemTable.Eof do
      begin
        inc(lParcela);
        if Odd(lParcela) then begin
          rlMemoFaturaLeft.Lines.Add(lMemtable.FieldByName('ID_FINANCEIRO').AsString);
          rlMemoParcelaLeft.Lines.Add(lMemtable.FieldByName('PARCELA').AsString+'/'+lMemtable.FieldByName('QUANTIDADE_PARCELAS').AsString);
          rlMemoVencimentoLeft.Lines.Add(lMemtable.FieldByName('VENCIMENTO').AsString);
          rlMemoValorLeft.Lines.Add(FormatCurr('#,###0.00', lMemtable.FieldByName('VALOR_PARCELA').AsFloat));
          rlMemoPortadorLeft.Lines.Add(lMemtable.FieldByName('NOME_PORT').AsString);
        end
        else begin
          rlMemoFaturaRight.Lines.Add(lMemtable.FieldByName('ID_FINANCEIRO').AsString);
          rlMemoParcelaRight.Lines.Add(lMemtable.FieldByName('PARCELA').AsString+'/'+lMemtable.FieldByName('QUANTIDADE_PARCELAS').AsString);
          rlMemoVencimentoRight.Lines.Add(lMemtable.FieldByName('VENCIMENTO').AsString);
          rlMemoValorRight.Lines.Add(FormatCurr('#,###0.00', lMemtable.FieldByName('VALOR_PARCELA').AsFloat));
          rlMemoPortadorRight.Lines.Add(lMemtable.FieldByName('NOME_PORT').AsString);
        end;
        lMemtable.Next;
      end;

      drawFaturasLeft.Height  := rlMemoFaturaLeft.Height+3;
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

procedure TImpressaoVendaAssistida.fetchPedido;
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

procedure TImpressaoVendaAssistida.fetchPedidoItens;
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
      mtItensVLR_GARANTIA.Value     := lWebPedidoItensModel.VLR_GARANTIA;
      mtItensENTREGA.AsString       := IIF(lWebPedidoItensModel.ENTREGA = 'N', 'NÃO', 'SIM');
      mtItensMONTAGEM.AsString      := IIF(lWebPedidoItensModel.MONTAGEM = 'N', 'NÃO', 'SIM');
      mtItensTIPO.AsString          := IIF(lWebPedidoItensModel.TIPO = 'FUTURA', 'SIM', 'NÃO');
      mtItensTIPO_ENTREGA.AsString  := IIF(lWebPedidoItensModel.TIPO_ENTREGA = 'LJ', 'LOJA', 'CD');
      mtItensTIPO_GARANTIA.Value    := lWebPedidoItensModel.TIPO_GARANTIA;
      mtItensVALOR_TOTAL.Value      := lWebPedidoItensModel.VALOR_TOTALITENS;
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

procedure TImpressaoVendaAssistida.FormCreate(Sender: TObject);
begin
  CoInitialize(nil);
end;

procedure TImpressaoVendaAssistida.FormDestroy(Sender: TObject);
begin
 CoUninitialize;
end;

procedure TImpressaoVendaAssistida.imprimir;
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
