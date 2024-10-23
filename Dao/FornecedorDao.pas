unit FornecedorDao;

interface

uses
  FornecedorModel,
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
  TFornecedorDao = class;
  ITFornecedorDao=IObject<TFornecedorDao>;

  TFornecedorDao = class
  private
    [unsafe] mySelf: ITFornecedorDao;
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCNPJCPFRecordView: Variant;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetCNPJCPFRecordView(const Value: Variant);
    procedure SetIDRecordView(const Value: String);

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITFornecedorDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property CNPJCPFRecordView : Variant read FCNPJCPFRecordView write SetCNPJCPFRecordView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(pFornecedorModel: ITFornecedorModel): String;
    function alterar(pFornecedorModel: ITFornecedorModel): String;
    function excluir(pFornecedorModel: ITFornecedorModel): String;

    function where: String;
    function carregaClasse(pID : String): ITFornecedorModel;
    function obterLista: IFDDataset;
    function ConsultarFornecedoresProduto(pProduto : String): IFDDataset;
    procedure setParams(var pQry: TFDQuery; pFornecedorModel: ITFornecedorModel);

end;

implementation

uses
  System.Rtti;

{ TFornecedor }

function TFornecedorDao.carregaClasse(pID : String): ITFornecedorModel;
var
  lQry: TFDQuery;
  lModel: ITFornecedorModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TFornecedorModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from FORNECEDOR where CODIGO_FOR = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.CODIGO_FOR                   := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.objeto.ENDERECO_FOR                 := lQry.FieldByName('ENDERECO_FOR').AsString;
    lModel.objeto.BAIRRO_FOR                   := lQry.FieldByName('BAIRRO_FOR').AsString;
    lModel.objeto.CIDADE_FOR                   := lQry.FieldByName('CIDADE_FOR').AsString;
    lModel.objeto.UF_FOR                       := lQry.FieldByName('UF_FOR').AsString;
    lModel.objeto.TELEFONE_FOR                 := lQry.FieldByName('TELEFONE_FOR').AsString;
    lModel.objeto.TELEFONE2_FOR                := lQry.FieldByName('TELEFONE2_FOR').AsString;
    lModel.objeto.FAX_FOR                      := lQry.FieldByName('FAX_FOR').AsString;
    lModel.objeto.CONTATO_FOR                  := lQry.FieldByName('CONTATO_FOR').AsString;
    lModel.objeto.CELULARCONTATO_FOR           := lQry.FieldByName('CELULARCONTATO_FOR').AsString;
    lModel.objeto.EMAIL_FOR                    := lQry.FieldByName('EMAIL_FOR').AsString;
    lModel.objeto.URL_FOR                      := lQry.FieldByName('URL_FOR').AsString;
    lModel.objeto.CEP_FOR                      := lQry.FieldByName('CEP_FOR').AsString;
    lModel.objeto.CNPJ_CPF_FOR                 := lQry.FieldByName('CNPJ_CPF_FOR').AsString;
    lModel.objeto.INSCRICAO_RG_FOR             := lQry.FieldByName('INSCRICAO_RG_FOR').AsString;
    lModel.objeto.FANTASIA_FOR                 := lQry.FieldByName('FANTASIA_FOR').AsString;
    lModel.objeto.RAZAO_FOR                    := lQry.FieldByName('RAZAO_FOR').AsString;
    lModel.objeto.BANCO_FOR                    := lQry.FieldByName('BANCO_FOR').AsString;
    lModel.objeto.AGENCIA_FOR                  := lQry.FieldByName('AGENCIA_FOR').AsString;
    lModel.objeto.CONTA_FOR                    := lQry.FieldByName('CONTA_FOR').AsString;
    lModel.objeto.OBSERVACAO_FOR               := lQry.FieldByName('OBSERVACAO_FOR').AsString;
    lModel.objeto.LIMITE_CREDITO_FOR           := lQry.FieldByName('LIMITE_CREDITO_FOR').AsString;
    lModel.objeto.TIPO_FOR                     := lQry.FieldByName('TIPO_FOR').AsString;
    lModel.objeto.USUARIO_ENT                  := lQry.FieldByName('USUARIO_ENT').AsString;
    lModel.objeto.LOJA                         := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.DESCRICAO                    := lQry.FieldByName('DESCRICAO').AsString;
    lModel.objeto.FAVORECIDO                   := lQry.FieldByName('FAVORECIDO').AsString;
    lModel.objeto.COD_MUNICIPIO                := lQry.FieldByName('COD_MUNICIPIO').AsString;
    lModel.objeto.TELEFONE_EXTERIOR            := lQry.FieldByName('TELEFONE_EXTERIOR').AsString;
    lModel.objeto.PAIS                         := lQry.FieldByName('PAIS').AsString;
    lModel.objeto.BANCO_EXTERIOR               := lQry.FieldByName('BANCO_EXTERIOR').AsString;
    lModel.objeto.SWIFT_CODE                   := lQry.FieldByName('SWIFT_CODE').AsString;
    lModel.objeto.CONTA_EXTERIOR               := lQry.FieldByName('CONTA_EXTERIOR').AsString;
    lModel.objeto.FAVORECIDO_EXTERIOR          := lQry.FieldByName('FAVORECIDO_EXTERIOR').AsString;
    lModel.objeto.MODALIDADECONTA              := lQry.FieldByName('MODALIDADECONTA').AsString;
    lModel.objeto.OPERACAOBANCO                := lQry.FieldByName('OPERACAOBANCO').AsString;
    lModel.objeto.CELULARCONTATO_FOR2          := lQry.FieldByName('CELULARCONTATO_FOR2').AsString;
    lModel.objeto.ID                           := lQry.FieldByName('ID').AsString;
    lModel.objeto.SUFRAMA                      := lQry.FieldByName('SUFRAMA').AsString;
    lModel.objeto.NUMERO_END                   := lQry.FieldByName('NUMERO_END').AsString;
    lModel.objeto.COMPLEMENTO                  := lQry.FieldByName('COMPLEMENTO').AsString;
    lModel.objeto.CONDICOES_PAG                := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.objeto.STATUS                       := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.TRANSPORTADORA_ID            := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    lModel.objeto.TIPO_MOVIMENTO               := lQry.FieldByName('TIPO_MOVIMENTO').AsString;
    lModel.objeto.TIPO_APURACAO                := lQry.FieldByName('TIPO_APURACAO').AsString;
    lModel.objeto.CREDITO_IMPOSTO              := lQry.FieldByName('CREDITO_IMPOSTO').AsString;
    lModel.objeto.COMPRA_PRAZO                 := lQry.FieldByName('COMPRA_PRAZO').AsString;
    lModel.objeto.COMPRA_MINIMO                := lQry.FieldByName('COMPRA_MINIMO').AsString;
    lModel.objeto.CONTA_ID                     := lQry.FieldByName('CONTA_ID').AsString;
    lModel.objeto.CODIGO_CONTABIL              := lQry.FieldByName('CODIGO_CONTABIL').AsString;
    lModel.objeto.NASCIMENTO_FOR               := lQry.FieldByName('NASCIMENTO_FOR').AsString;
    lModel.objeto.PERIODICIDADE                := lQry.FieldByName('PERIODICIDADE').AsString;
    lModel.objeto.PREVISAO_ENTREGA             := lQry.FieldByName('PREVISAO_ENTREGA').AsString;
    lModel.objeto.MATRIZ_FORNECEDOR_ID         := lQry.FieldByName('MATRIZ_FORNECEDOR_ID').AsString;
    lModel.objeto.VINCULAR_PRODUTOS_ENTRADA    := lQry.FieldByName('VINCULAR_PRODUTOS_ENTRADA').AsString;
    lModel.objeto.CODIGO_ANTERIOR              := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.objeto.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

function TFornecedorDao.ConsultarFornecedoresProduto(pProduto: String): IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
begin
  lQry := vIConexao.CriarQuery;
  try
    lSQL := ' select                                                                                                                                  '+sLineBreak+
            '        c.codigo_for,                                                                                                                    '+sLineBreak+
            '        c.fantasia_for,                                                                                                                  '+sLineBreak+
            '        c.razao_for,                                                                                                                     '+sLineBreak+
            '        c.telefone_for,                                                                                                                  '+sLineBreak+
            '        coalesce((                                                                                                                       '+sLineBreak+
            '                  select first 1                                                                                                         '+sLineBreak+
            '                         ((cast(i.quantidade_ent as float) * cast(i.valoruni_ent as float) -                                             '+sLineBreak+
            '                         coalesce(i.desc_i17, 0) +                                                                                       '+sLineBreak+
            '                         coalesce(i.vseg_i16, 0) +                                                                                       '+sLineBreak+
            '                         coalesce(i.vipi_014, 0) +                                                                                       '+sLineBreak+
            '                         coalesce(i.vfrete_i15, 0) +                                                                                     '+sLineBreak+
            '                         coalesce(i.vicms_st_ent, 0)) / coalesce(i.quantidade_ent, 0))                                                   '+sLineBreak+
            '                    from entrada e                                                                                                       '+sLineBreak+
            '                    join entradaitens i on e.numero_ent = i.numero_ent and e.codigo_for = i.codigo_for                                   '+sLineBreak+
            '                   where e.codigo_for = c.codigo_for                                                                                     '+sLineBreak+
            '                     and i.codigo_pro = '+pProduto+'                                                                                     '+sLineBreak+
            '                     and e.datamovi_ent = (select max(e2.datamovi_ent)                                                                   '+sLineBreak+
            '                                             from entrada e2                                                                             '+sLineBreak+
            '                                             join entradaitens ei on e2.numero_ent = ei.numero_ent and e2.codigo_for = ei.codigo_for     '+sLineBreak+
            '                                            where e2.codigo_for = c.codigo_for and ei.codigo_pro = i.codigo_pro)                         '+sLineBreak+
            '                  ), 0) as valoruni_ent,                                                                                                 '+sLineBreak+
            '        coalesce((                                                                                                                       '+sLineBreak+
            '                  select first 1 cast(i.quantidade_ent as float)                                                                         '+sLineBreak+
            '                    from entrada e                                                                                                       '+sLineBreak+
            '                    join entradaitens i on e.numero_ent = i.numero_ent and e.codigo_for = i.codigo_for                                   '+sLineBreak+
            '                   where e.codigo_for = c.codigo_for                                                                                     '+sLineBreak+
            '                     and i.codigo_pro = '+pProduto+'                                                                                     '+sLineBreak+
            '                     and e.datamovi_ent = (select max(e2.datamovi_ent)                                                                   '+sLineBreak+
            '                                             from entrada e2                                                                             '+sLineBreak+
            '                                             join entradaitens ei on e2.numero_ent = ei.numero_ent and e2.codigo_for = ei.codigo_for     '+sLineBreak+
            '                                            where e2.codigo_for = c.codigo_for and ei.codigo_pro = i.codigo_pro)                         '+sLineBreak+
            '                   ), 0) as quantidade,                                                                                                  '+sLineBreak+
            '                 (select first 1 e.datamovi_ent                                                                                          '+sLineBreak+
            '                    from entrada e                                                                                                       '+sLineBreak+
            '                    join entradaitens i on e.numero_ent = i.numero_ent and e.codigo_for = i.codigo_for                                   '+sLineBreak+
            '                   where e.codigo_for = c.codigo_for                                                                                     '+sLineBreak+
            '                     and i.codigo_pro = '+pProduto+'                                                                                     '+sLineBreak+
            '                     and e.datamovi_ent = (select max(e2.datamovi_ent)                                                                   '+sLineBreak+
            '                                            from entrada e2                                                                              '+sLineBreak+
            '                                            join entradaitens ei on e2.numero_ent = ei.numero_ent and e2.codigo_for = ei.codigo_for      '+sLineBreak+
            '                                           where e2.codigo_for = c.codigo_for and ei.codigo_pro = i.codigo_pro)                          '+sLineBreak+
            '                 ) as data                                                                                                               '+sLineBreak+
            '   from fornecedor c                                                                                                                     '+sLineBreak+
            '  where (select first 1 coalesce(cast(sum(i.quantidade_ent) as float), 0)                                                                '+sLineBreak+
            '   from entrada e                                                                                                                        '+sLineBreak+
            '   join entradaitens i on e.numero_ent = i.numero_ent and e.codigo_for = i.codigo_for                                                    '+sLineBreak+
            '  where e.codigo_for = c.codigo_for                                                                                                      '+sLineBreak+
            '    and i.codigo_pro = '+pProduto+'                                                                                                      '+sLineBreak+
            '    and e.datamovi_ent = (select max(e2.datamovi_ent)                                                                                    '+sLineBreak+
            '                            from entrada e2                                                                                              '+sLineBreak+
            '                            join entradaitens ei on e2.numero_ent = ei.numero_ent and e2.codigo_for = ei.codigo_for                      '+sLineBreak+
            '                           where e2.codigo_for = c.codigo_for and ei.codigo_pro = i.codigo_pro)) > 0                                     '+sLineBreak+
            '  order by data desc                                                                                                                     '+sLineBreak;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);
  finally
    lQry.Free;
  end;
end;

constructor TFornecedorDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TFornecedorDao.Destroy;
begin
  inherited;
end;

function TFornecedorDao.incluir(pFornecedorModel: ITFornecedorModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('FORNECEDOR', 'CODIGO_FOR');

  try
    lQry.SQL.Add(lSQL);
    pFornecedorModel.objeto.CODIGO_FOR := vIConexao.Generetor('GEN_FORNECEDOR');
    setParams(lQry, pFornecedorModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_FOR').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TFornecedorDao.alterar(pFornecedorModel: ITFornecedorModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('FORNECEDOR','CODIGO_FOR');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pFornecedorModel);
    lQry.ExecSQL;

    Result := pFornecedorModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TFornecedorDao.excluir(pFornecedorModel: ITFornecedorModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from FORNECEDOR where CODIGO_FOR = :CODIGO_FOR' ,[pFornecedorModel.objeto.CODIGO_FOR]);
   lQry.ExecSQL;
   Result := pFornecedorModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TFornecedorDao.getNewIface(pIConexao: IConexao): ITFornecedorDao;
begin
  Result := TImplObjetoOwner<TFornecedorDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TFornecedorDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> '' then
    lSQL := lSQL + ' and CODIGO_FOR = ' +QuotedStr(FIDRecordView);

  if FCNPJCPFRecordView <> ''  then
    lSQL := lSQL + ' and CNPJ_CPF_FOR = ' +QuotedStr(FCNPJCPFRecordView);

  Result := lSQL;
end;

procedure TFornecedorDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From FORNECEDOR where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TFornecedorDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := 'select '+lPaginacao+' * From FORNECEDOR where 1=1 ';


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

procedure TFornecedorDao.SetCNPJCPFRecordView(const Value: Variant);
begin
  FCNPJCPFRecordView := Value;
end;

procedure TFornecedorDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFornecedorDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TFornecedorDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TFornecedorDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFornecedorDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFornecedorDao.setParams(var pQry: TFDQuery; pFornecedorModel: ITFornecedorModel);
begin
  vConstrutor.setParams('FORNECEDOR',pQry,pFornecedorModel.objeto);
end;

procedure TFornecedorDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TFornecedorDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TFornecedorDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
