unit PedidoCompraDao;

interface

uses
  PedidoCompraModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface;

type
  TPedidoCompraDao = class;
  ITPedidoCompraDao=IObject<TPedidoCompraDao>;

  TPedidoCompraDao = class
  private
    [unsafe] mySelf: ITPedidoCompraDao;
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FNumeroView: String;
    FFornecedorVew: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetFornecedorVew(const Value: String);
    procedure SetNumeroView(const Value: String);

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPedidoCompraDao;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property FornecedorVew: String read FFornecedorVew write SetFornecedorVew;
    property NumeroView: String read FNumeroView write SetNumeroView;

    function incluir(pPedidoCompraModel : ITPedidoCompraModel): String;
    function alterar(pPedidoCompraModel : ITPedidoCompraModel): String;
    function excluir(pPedidoCompraModel : ITPedidoCompraModel): String;

    function carregaClasse(pID : String): ITPedidoCompraModel;
    function obterLista: IFDDataset;
    function ObterTotalizador : IFDDataset;
    procedure setParams(var pQry: TFDQuery; pPedidoCompraModel: ITPedidoCompraModel);

end;

implementation

uses
  System.Rtti;

{ TPedidoCompra }

function TPedidoCompraDao.carregaClasse(pID : String): ITPedidoCompraModel;
var
  lQry: TFDQuery;
  lModel: ITPedidoCompraModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPedidoCompraModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from PEDIDOCOMPRA where NUMERO_PED = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_PED                      := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.objeto.CODIGO_FOR                      := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.objeto.DATA_PED                        := lQry.FieldByName('DATA_PED').AsString;
    lModel.objeto.DATAPREV_PED                    := lQry.FieldByName('DATAPREV_PED').AsString;
    lModel.objeto.PARCELAS_PED                    := lQry.FieldByName('PARCELAS_PED').AsString;
    lModel.objeto.PRIMEIROVENC_PED                := lQry.FieldByName('PRIMEIROVENC_PED').AsString;
    lModel.objeto.FRETE_PED                       := lQry.FieldByName('FRETE_PED').AsString;
    lModel.objeto.ICMS_PED                        := lQry.FieldByName('ICMS_PED').AsString;
    lModel.objeto.OUTROS_PED                      := lQry.FieldByName('OUTROS_PED').AsString;
    lModel.objeto.DESC_PED                        := lQry.FieldByName('DESC_PED').AsString;
    lModel.objeto.TOTAL_PED                       := lQry.FieldByName('TOTAL_PED').AsString;
    lModel.objeto.OBSERVACAO_PED                  := lQry.FieldByName('OBSERVACAO_PED').AsString;
    lModel.objeto.USUARIO_PED                     := lQry.FieldByName('USUARIO_PED').AsString;
    lModel.objeto.STATUS_PED                      := lQry.FieldByName('STATUS_PED').AsString;
    lModel.objeto.TOTALPRODUTOS_PED               := lQry.FieldByName('TOTALPRODUTOS_PED').AsString;
    lModel.objeto.TIPO_PRO                        := lQry.FieldByName('TIPO_PRO').AsString;
    lModel.objeto.CTR_IMPRESSAO_PED               := lQry.FieldByName('CTR_IMPRESSAO_PED').AsString;
    lModel.objeto.LOJA                            := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.DOLAR                           := lQry.FieldByName('DOLAR').AsString;
    lModel.objeto.CONDICOES_PAG                   := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.objeto.ID                              := lQry.FieldByName('ID').AsString;
    lModel.objeto.TRANSPORTADORA_ID               := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    lModel.objeto.STATUS_ID                       := lQry.FieldByName('STATUS_ID').AsString;
    lModel.objeto.AUTORIZADO                      := lQry.FieldByName('AUTORIZADO').AsString;
    lModel.objeto.ENVIADO                         := lQry.FieldByName('ENVIADO').AsString;
    lModel.objeto.IPI_PED                         := lQry.FieldByName('IPI_PED').AsString;
    lModel.objeto.ST_PED                          := lQry.FieldByName('ST_PED').AsString;
    lModel.objeto.TIPO_MOEDA_ESTRANGEIRA          := lQry.FieldByName('TIPO_MOEDA_ESTRANGEIRA').AsString;
    lModel.objeto.PEDIDO_FORNECEDOR               := lQry.FieldByName('PEDIDO_FORNECEDOR').AsString;
    lModel.objeto.DATA_ACEITE                     := lQry.FieldByName('DATA_ACEITE').AsString;
    lModel.objeto.AUTORIZACAO_ESTOQUE_STATUS      := lQry.FieldByName('AUTORIZACAO_ESTOQUE_STATUS').AsString;
    lModel.objeto.AUTORIZACAO_ESTOQUE_USUARIO     := lQry.FieldByName('AUTORIZACAO_ESTOQUE_USUARIO').AsString;
    lModel.objeto.AUTORIZACAO_ESTOQUE_DATAHORA    := lQry.FieldByName('AUTORIZACAO_ESTOQUE_DATAHORA').AsString;
    lModel.objeto.AUTORIZACAO_ESTOQUE_OBS         := lQry.FieldByName('AUTORIZACAO_ESTOQUE_OBS').AsString;
    lModel.objeto.AUTORIZACAO_FINANCEIRO_STATUS   := lQry.FieldByName('AUTORIZACAO_FINANCEIRO_STATUS').AsString;
    lModel.objeto.AUTORIZACAO_FINANCEIRO_USUARIO  := lQry.FieldByName('AUTORIZACAO_FINANCEIRO_USUARIO').AsString;
    lModel.objeto.AUTORIZACAO_FINANCEIRO_DATAHORA := lQry.FieldByName('AUTORIZACAO_FINANCEIRO_DATAHORA').AsString;
    lModel.objeto.AUTORIZACAO_FINANCEIRO_OBS      := lQry.FieldByName('AUTORIZACAO_FINANCEIRO_OBS').AsString;
    lModel.objeto.TIPO_FRETE                      := lQry.FieldByName('TIPO_FRETE').AsString;
    lModel.objeto.BASE_ICMS                       := lQry.FieldByName('BASE_ICMS').AsString;
    lModel.objeto.BASE_ST                         := lQry.FieldByName('BASE_ST').AsString;
    lModel.objeto.VFCP                            := lQry.FieldByName('VFCP').AsString;
    lModel.objeto.VFCPST                          := lQry.FieldByName('VFCPST').AsString;
    lModel.objeto.HORAPREV_PED                    := lQry.FieldByName('HORAPREV_PED').AsString;
    lModel.objeto.CONTATOPREV_PED                 := lQry.FieldByName('CONTATOPREV_PED').AsString;
    lModel.objeto.TELEFONEPREV_PED                := lQry.FieldByName('TELEFONEPREV_PED').AsString;
    lModel.objeto.CALCULAR_VALORES                := lQry.FieldByName('CALCULAR_VALORES').AsString;
    lModel.objeto.USO_CONSUMO                     := lQry.FieldByName('USO_CONSUMO').AsString;
    lModel.objeto.FRETE_NO_IPI                    := lQry.FieldByName('FRETE_NO_IPI').AsString;
    lModel.objeto.PORTADOR_ID                     := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.objeto.SYSTIME                         := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.ENVIO_WHATSAPP                  := lQry.FieldByName('ENVIO_WHATSAPP').AsString;
    lModel.objeto.DATA_COTACAO                    := lQry.FieldByName('DATA_COTACAO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TPedidoCompraDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TPedidoCompraDao.Destroy;
begin
  vConstrutor := nil;
  vIConexao   := nil;
  inherited;
end;

function TPedidoCompraDao.incluir(pPedidoCompraModel: ITPedidoCompraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PEDIDOCOMPRA', 'NUMERO_PED');

  try
    lQry.SQL.Add(lSQL);
    pPedidoCompraModel.objeto.NUMERO_PED := vIConexao.Generetor('GEN_PEDIDOCOMPRA');
    setParams(lQry, pPedidoCompraModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_PED').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoCompraDao.alterar(pPedidoCompraModel: ITPedidoCompraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PEDIDOCOMPRA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPedidoCompraModel);
    lQry.ExecSQL;

    Result := pPedidoCompraModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPedidoCompraDao.excluir(pPedidoCompraModel: ITPedidoCompraModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from PEDIDOCOMPRA where NUMERO_PED = ' + QuotedStr(pPedidoCompraModel.objeto.NUMERO_PED) + ' and CODIGO_FOR = ' + QuotedStr(pPedidoCompraModel.objeto.CODIGO_FOR));
   lQry.ExecSQL;
   Result := pPedidoCompraModel.objeto.NUMERO_PED;

  finally
    lQry.Free;
  end;
end;

class function TPedidoCompraDao.getNewIface(pIConexao: IConexao): ITPedidoCompraDao;
begin
  Result := TImplObjetoOwner<TPedidoCompraDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPedidoCompraDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and pc.id = ' +IntToStr(FIDRecordView);

  if FNumeroView <> ''  then
    lSQL := lSQL + ' and pc.numero_ped = ' +QuotedStr(FNumeroView);

  if FFornecedorVew <> ''  then
    lSQL := lSQL + ' and pc.codigo_for = ' +QuotedStr(FFornecedorVew);

  Result := lSQL;
end;

procedure TPedidoCompraDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From PEDIDOCOMPRA PC                         ' + SLineBreak +
            '       left join fornecedor on fornecedor.codigo_for = pc.codigo_for ' + SLineBreak +
            'where 1=1                                                            ' + SLineBreak;

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TPedidoCompraDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select ' + lPaginacao + '                                                                          '+SLineBreak+
              '        pc.numero_ped,                                                                              '+SLineBreak+
              '        pc.codigo_for,                                                                              '+SLineBreak+
              '        pc.data_ped,                                                                                '+SLineBreak+
              '        pc.dataprev_ped,                                                                            '+SLineBreak+
              '        pc.parcelas_ped,                                                                            '+SLineBreak+
              '        pc.primeirovenc_ped,                                                                        '+SLineBreak+
              '        pc.frete_ped,                                                                               '+SLineBreak+
              '        pc.icms_ped,                                                                                '+SLineBreak+
              '        pc.outros_ped,                                                                              '+SLineBreak+
              '        pc.desc_ped,                                                                                '+SLineBreak+
              '        pc.total_ped,                                                                               '+SLineBreak+
              '        pc.observacao_ped,                                                                          '+SLineBreak+
              '        pc.usuario_ped,                                                                             '+SLineBreak+
              '        pc.status_ped,                                                                              '+SLineBreak+
              '        pc.totalprodutos_ped,                                                                       '+SLineBreak+
              '        pc.tipo_pro,                                                                                '+SLineBreak+
              '        pc.dolar,                                                                                   '+SLineBreak+
              '        pc.condicoes_pag,                                                                           '+SLineBreak+
              '        pc.id,                                                                                      '+SLineBreak+
              '        pc.transportadora_id,                                                                       '+SLineBreak+
              '        pc.status_id,                                                                               '+SLineBreak+
              '        pc.autorizado,                                                                              '+SLineBreak+
              '        pc.enviado,                                                                                 '+SLineBreak+
              '        pc.ipi_ped,                                                                                 '+SLineBreak+
              '        pc.st_ped,                                                                                  '+SLineBreak+
              '        pc.tipo_moeda_estrangeira,                                                                  '+SLineBreak+
              '        pc.pedido_fornecedor,                                                                       '+SLineBreak+
              '        pc.data_aceite,                                                                             '+SLineBreak+
              '        pc.autorizacao_estoque_status,                                                              '+SLineBreak+
              '        pc.autorizacao_estoque_datahora,                                                            '+SLineBreak+
              '        pc.autorizacao_estoque_obs,                                                                 '+SLineBreak+
              '        pc.autorizacao_financeiro_status,                                                           '+SLineBreak+
              '        pc.autorizacao_financeiro_datahora,                                                         '+SLineBreak+
              '        pc.autorizacao_financeiro_obs,                                                              '+SLineBreak+
              '        pc.tipo_frete,                                                                              '+SLineBreak+
              '        pc.base_icms,                                                                               '+SLineBreak+
              '        pc.base_st,                                                                                 '+SLineBreak+
              '        pc.vfcp,                                                                                    '+SLineBreak+
              '        pc.vfcpst,                                                                                  '+SLineBreak+
              '        pc.frete_no_ipi,                                                                            '+SLineBreak+
              '        pc.portador_id,                                                                             '+SLineBreak+
              '        pc.systime,                                                                                 '+SLineBreak+
              '        pc.data_cotacao,                                                                            '+SLineBreak+
              '        fornecedor.fantasia_for fornecedor_nome,                                                    '+SLineBreak+
              '        pc.autorizacao_estoque_usuario,                                                             '+SLineBreak+
              '        pc.autorizacao_financeiro_usuario,                                                          '+SLineBreak+
              '        usua_estoque.nome estoque_usuario_nome,                                                     '+SLineBreak+
              '        usua_financeiro.nome financeiro_usuario_nome                                                '+SLineBreak+
              '   from pedidocompra pc                                                                             '+SLineBreak+
              '        left join fornecedor on fornecedor.codigo_for = pc.codigo_for                               '+SLineBreak+
              '        left join usuario usua_estoque on usua_estoque.id = pc.autorizacao_estoque_usuario          '+SLineBreak+
              '        left join usuario usua_financeiro on usua_financeiro.id = pc.autorizacao_financeiro_usuario '+SLineBreak+
              '   where 1=1                                                                                        '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

function TPedidoCompraDao.ObterTotalizador: IFDDataset;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSql := ' select                                                                                                   '+SLineBreak+
            '       quantidade_itens,                                                                                  '+SLineBreak+
            '       quantidade_produtos,                                                                               '+SLineBreak+
            '       valor_total_produtos,                                                                              '+SLineBreak+
            '       valor_total_icms,                                                                                  '+SLineBreak+
            '       valor_total_icms_st,                                                                               '+SLineBreak+
            '       valor_total_ipi,                                                                                   '+SLineBreak+
            '       valor_total_frete,                                                                                 '+SLineBreak+
            '       valor_total_outras_depesas,                                                                        '+SLineBreak+
            '       valor_total_desconto,                                                                              '+SLineBreak+
            '       percentual_desconto,                                                                               '+SLineBreak+
            '       valor_total_pedido                                                                                 '+SLineBreak+
            '   from                                                                                                   '+SLineBreak+
            '   (select                                                                                                '+SLineBreak+
            '          quantidade_itens,                                                                               '+SLineBreak+
            '          quantidade_produtos,                                                                            '+SLineBreak+
            '          valor_total_produtos,                                                                           '+SLineBreak+
            '          valor_total_icms,                                                                               '+SLineBreak+
            '          valor_total_icms_st,                                                                            '+SLineBreak+
            '          valor_total_ipi,                                                                                '+SLineBreak+
            '          valor_total_frete,                                                                              '+SLineBreak+
            '          valor_total_outras_depesas,                                                                     '+SLineBreak+
            '          valor_total_desconto,                                                                           '+SLineBreak+
            '          cast(valor_total_desconto * 100 / valor_total_produtos as numeric(18, 2)) percentual_desconto,  '+SLineBreak+
            '          valor_total_produtos                                                                            '+SLineBreak+
            '            + valor_total_icms                                                                            '+SLineBreak+
            '            + valor_total_icms_st                                                                         '+SLineBreak+
            '            + valor_total_ipi                                                                             '+SLineBreak+
            '            + valor_total_frete                                                                           '+SLineBreak+
            '            + valor_total_outras_depesas                                                                  '+SLineBreak+
            '            - valor_total_desconto valor_total_pedido                                                     '+SLineBreak+
            '      from                                                                                                '+SLineBreak+
            '      (select                                                                                             '+SLineBreak+
            '              count(*) quantidade_itens,                                                                  '+SLineBreak+
            '              sum(i.quantidade_ped) quantidade_produtos,                                                  '+SLineBreak+
            '              sum(i.valoruni_ped * i.quantidade_ped) valor_total_produtos,                                '+SLineBreak+
            '              coalesce(sum(i.vicms_n17), 0) valor_total_icms,                                             '+SLineBreak+
            '              coalesce(sum(i.vst_n23), 0) valor_total_icms_st,                                            '+SLineBreak+
            '              coalesce(sum(i.vipi_014), 0) valor_total_ipi,                                               '+SLineBreak+
            '              coalesce(sum(i.frete_ped), 0) valor_total_frete,                                            '+SLineBreak+
            '              coalesce(sum(i.vlr_outras), 0) valor_total_outras_depesas,                                  '+SLineBreak+
            '              coalesce(sum(i.vlr_desconto), 0) valor_total_desconto                                       '+SLineBreak+
            '         from pedidocompraitens i                                                                         '+SLineBreak+
            '        where i.numero_ped = '+QuotedStr(NumeroView)+'                                                    '+SLineBreak+
            '          and i.codigo_for = '+QuotedStr(FornecedorVew)+'                                                 '+SLineBreak+
            '       )                                                                                                  '+SLineBreak+
            '   )                                                                                                      '+SLineBreak;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

procedure TPedidoCompraDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPedidoCompraDao.SetFornecedorVew(const Value: String);
begin
  FFornecedorVew := Value;
end;

procedure TPedidoCompraDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPedidoCompraDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPedidoCompraDao.SetNumeroView(const Value: String);
begin
  FNumeroView := Value;
end;

procedure TPedidoCompraDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPedidoCompraDao.setParams(var pQry: TFDQuery; pPedidoCompraModel: ITPedidoCompraModel);
begin
  vConstrutor.setParams('PEDIDOCOMPRA',pQry,pPedidoCompraModel.objeto);
end;

procedure TPedidoCompraDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPedidoCompraDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPedidoCompraDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
