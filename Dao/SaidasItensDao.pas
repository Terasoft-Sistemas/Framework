unit SaidasItensDao;

interface

uses
  SaidasItensModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TSaidasItensDao = class;
  ITSaidasItensDao=IObject<TSaidasItensDao>;

  TSaidasItensDao = class
  private
    [weak] mySelf: ITSaidasItensDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FNumeroSaidaView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;
    procedure SetNumeroSaidaView(const Value: String);

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITSaidasItensDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property NumeroSaidaView : String read FNumeroSaidaView write SetNumeroSaidaView;

    function incluir(pSaidasItensModel: ITSaidasItensModel): String;
    function alterar(pSaidasItensModel: ITSaidasItensModel): String;
    function excluir(pSaidasItensModel: ITSaidasItensModel): String;
    function carregaClasse(pID : String): ITSaidasItensModel;
    function obterLista: IFDDataset;

    function ObterTotais(pNumeroSaida : String) : IFDDataset;
    procedure setParams(var pQry: TFDQuery; pSaidasItensModel: ITSaidasItensModel);

end;

implementation

uses
  System.Rtti;

{ TSaidasItens }

function TSaidasItensDao.carregaClasse(pID : String): ITSaidasItensModel;
var
  lQry : TFDQuery;
  lModel : ITSaidasItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TSaidasItensModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from saidasitens where id = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_SAI     := lQry.FieldByName('NUMERO_SAI').AsString;
    lModel.objeto.CODIGO_CLI     := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.objeto.CODIGO_PRO     := lQry.FieldByName('CODIGO_PRO').AsString;
    lModel.objeto.QUANTIDADE_SAI := lQry.FieldByName('QUANTIDADE_SAI').AsString;
    lModel.objeto.QUANTIDADE_ATE := lQry.FieldByName('QUANTIDADE_ATE').AsString;
    lModel.objeto.VALOR_UNI_SAI  := lQry.FieldByName('VALOR_UNI_SAI').AsString;
    lModel.objeto.IPI_SAI        := lQry.FieldByName('IPI_SAI').AsString;
    lModel.objeto.ICMS_SAI       := lQry.FieldByName('ICMS_SAI').AsString;
    lModel.objeto.STATUS         := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.LOJA           := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.ID             := lQry.FieldByName('ID').AsString;
    lModel.objeto.RESERVA_ID     := lQry.FieldByName('RESERVA_ID').AsString;
    lModel.objeto.AVULSO         := lQry.FieldByName('AVULSO').AsString;
    lModel.objeto.DESCONTO_PED   := lQry.FieldByName('DESCONTO_PED').AsString;
    lModel.objeto.ALTURA_M       := lQry.FieldByName('ALTURA_M').AsString;
    lModel.objeto.LARGURA_M      := lQry.FieldByName('LARGURA_M').AsString;
    lModel.objeto.PROFUNDIDADE_M := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.objeto.DATA_CAD       := lQry.FieldByName('DATA_CAD').AsString;
    lModel.objeto.QTD_CHECAGEM   := lQry.FieldByName('QTD_CHECAGEM').AsString;
    lModel.objeto.REPOSICAO_ID   := lQry.FieldByName('REPOSICAO_ID').AsString;
    lModel.objeto.PRODUCAO_ID    := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.objeto.SAIDA_ID       := lQry.FieldByName('SAIDA_ID').AsString;
    lModel.objeto.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TSaidasItensDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TSaidasItensDao.Destroy;
begin
  inherited;
end;

function TSaidasItensDao.incluir(pSaidasItensModel: ITSaidasItensModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('SAIDASITENS', 'ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pSaidasItensModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSaidasItensDao.alterar(pSaidasItensModel: ITSaidasItensModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin

  lQry := vIConexao.CriarQuery;
  lSQL :=  vConstrutor.gerarUpdate('SAIDASITENS','ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pSaidasItensModel);
    lQry.ExecSQL;

    Result := pSaidasItensModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TSaidasItensDao.excluir(pSaidasItensModel: ITSaidasItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from saidasitens where id = :id' ,[pSaidasItensModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pSaidasItensModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TSaidasItensDao.getNewIface(pIConexao: IConexao): ITSaidasItensDao;
begin
  Result := TImplObjetoOwner<TSaidasItensDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TSaidasItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and saidasitens.id = '+IntToStr(FIDRecordView);

  if FNumeroSaidaView <> '' then
    lSQL := lSQL + ' and saidasitens.numero_sai = '+ QuotedStr(FNumeroSaidaView);

  Result := lSQL;
end;

procedure TSaidasItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from saidasitens where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TSaidasItensDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSql := ' select '+lPaginacao+'                                                          ' +
            '        saidasitens.id,                                                         ' +
            '        saidasitens.numero_sai,                                                 ' +
            '        saidasitens.codigo_cli,                                                 ' +
            '        saidasitens.codigo_pro,                                                 ' +
            '        produto.nome_pro produto_nome,                                          ' +
            '        produto.unidade_pro produto_unidade,                                    ' +
            '        saidasitens.quantidade_sai,                                             ' +
            '        saidasitens.quantidade_ate,                                             ' +
            '        saidasitens.valor_uni_sai,                                              ' +
            '        (saidasitens.valor_uni_sai * saidasitens.quantidade_sai) valor_tot_sai, ' +
            '        saidasitens.status,                                                     ' +
            '        saidasitens.loja,                                                       ' +
            '        saidasitens.desconto_ped,                                               ' +
            '        saidasitens.data_cad,                                                   ' +
            '        saidasitens.saida_id                                                    ' +
            '   from saidasitens                                                             ' +
            '   left join produto on produto.codigo_pro = saidasitens.codigo_pro             ' +
            '  where 1=1                                                                     ';

    lSql := lSql + Where;

    if not FOrderView.IsEmpty then
      lSql := lSql + ' order by '+FOrderView;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

function TSaidasItensDao.ObterTotais(pNumeroSaida : String): IFDDataset;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSql := ' select                                                                                   '+SLineBreak+
            '        PERCENTUAL_DESCONTO,                                                              '+SLineBreak+
            '        QUANTIDADE_ITENS,                                                                 '+SLineBreak+
            '        QUANTIDADE_PRODUTOS,                                                              '+SLineBreak+
            '        CUSTO,                                                                            '+SLineBreak+
            '        VALOR                                                                             '+SLineBreak+
            '   from                                                                                   '+SLineBreak+
            '   (select                                                                                '+SLineBreak+
            '           cast(percentual_desconto as numeric(18, 2)) percentual_desconto,               '+SLineBreak+
            '           count(*) as quantidade_itens,                                                  '+SLineBreak+
            '           sum(quantidade) quantidade_produtos,                                           '+SLineBreak+
            '           sum(quantidade * (custo - custo * percentual_desconto)) custo,                 '+SLineBreak+
            '           sum(quantidade * (valor_saida - valor_saida * percentual_desconto)) valor      '+SLineBreak+
            '      from                                                                                '+SLineBreak+
            '      (select                                                                             '+SLineBreak+
            '              cast(saidasitens.quantidade_sai as float) quantidade,                       '+SLineBreak+
            '              coalesce(saidasitens.icms_sai,0) custo,                                     '+SLineBreak+
            '              coalesce(saidasitens.desconto_ped,0) / 100 percentual_desconto,             '+SLineBreak+
            '              coalesce(saidasitens.valor_uni_sai,0) valor_saida                           '+SLineBreak+
            '         from saidas                                                                      '+SLineBreak+
            '        inner join saidasitens on saidasitens.numero_sai = saidas.numero_sai              '+SLineBreak+
            '        where saidas.numero_sai = '+QuotedStr(pNumeroSaida)+'                             '+SLineBreak+
            '       )                                                                                  '+SLineBreak+
            '        group by 1                                                                        '+SLineBreak+
            '    )                                                                                     '+SLineBreak;

    lQry.Open(lSql);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

procedure TSaidasItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TSaidasItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TSaidasItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TSaidasItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TSaidasItensDao.SetNumeroSaidaView(const Value: String);
begin
  FNumeroSaidaView := Value;
end;

procedure TSaidasItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TSaidasItensDao.setParams(var pQry: TFDQuery; pSaidasItensModel: ITSaidasItensModel);
begin
  vConstrutor.setParams('SAIDASITENS',pQry,pSaidasItensModel.objeto);
end;

procedure TSaidasItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TSaidasItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TSaidasItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
