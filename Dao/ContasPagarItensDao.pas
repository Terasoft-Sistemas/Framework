unit ContasPagarItensDao;

interface

uses
  ContasPagarItensModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TContasPagarItensDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FDuplicataView: String;
    FFornecedorView: String;
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
    procedure SetDuplicataView(const Value: String);
    procedure SetFornecedorView(const Value: String);

  public

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property DuplicataView: String read FDuplicataView write SetDuplicataView;
    property FornecedorView: String read FFornecedorView write SetFornecedorView;

    function incluir(AContasPagarItensModel: TContasPagarItensModel): String;
    function alterar(AContasPagarItensModel: TContasPagarItensModel): String;
    function excluir(AContasPagarItensModel: TContasPagarItensModel): String;

    function carregaClasse(pID, pIDItem : String): TContasPagarItensModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pContasPagarItensModel: TContasPagarItensModel);

end;

implementation

uses
  System.Rtti;

{ TContasPagarItens }

function TContasPagarItensDao.carregaClasse(pID, pIDItem: String): TContasPagarItensModel;
var
  lQry: TFDQuery;
  lModel: TContasPagarItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContasPagarItensModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CONTASPAGARITENS where DUPLIACATA_PAG = '+ QuotedStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.ID                        := lQry.FieldByName('ID').AsString;
    lModel.DUPLIACATA_PAG            := lQry.FieldByName('DUPLIACATA_PAG').AsString;
    lModel.CODIGO_FOR                := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.VENC_PAG                  := lQry.FieldByName('VENC_PAG').AsString;
    lModel.PACELA_PAG                := lQry.FieldByName('PACELA_PAG').AsString;
    lModel.TOTALPARCELAS             := lQry.FieldByName('TOTALPARCELAS').AsString;
    lModel.VALORPARCELA_PAG          := lQry.FieldByName('VALORPARCELA_PAG').AsString;
    lModel.VALORPAGO_PAG             := lQry.FieldByName('VALORPAGO_PAG').AsString;
    lModel.DATABAIXA_PAG             := lQry.FieldByName('DATABAIXA_PAG').AsString;
    lModel.SITUACAO_PAG              := lQry.FieldByName('SITUACAO_PAG').AsString;
    lModel.BOLETO_PAG                := lQry.FieldByName('BOLETO_PAG').AsString;
    lModel.DATA_ACEITE               := lQry.FieldByName('DATA_ACEITE').AsString;
    lModel.USUARIO_ACEITE            := lQry.FieldByName('USUARIO_ACEITE').AsString;
    lModel.LOJA                      := lQry.FieldByName('LOJA').AsString;
    lModel.PORTADOR_ID               := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.OBS                       := lQry.FieldByName('OBS').AsString;
    lModel.SYSTIME                   := lQry.FieldByName('SYSTIME').AsString;
    lModel.CTR_CHEQUE_ID             := lQry.FieldByName('CTR_CHEQUE_ID').AsString;
    lModel.LIMITE_ATRAZO             := lQry.FieldByName('LIMITE_ATRAZO').AsString;
    lModel.DESCONTO                  := lQry.FieldByName('DESCONTO').AsString;
    lModel.VALORPARCELA_BASE         := lQry.FieldByName('VALORPARCELA_BASE').AsString;
    lModel.BARRAS_BOLETO             := lQry.FieldByName('BARRAS_BOLETO').AsString;
    lModel.REMESSA_GESTAO_PAGAMENTO  := lQry.FieldByName('REMESSA_GESTAO_PAGAMENTO').AsString;
    lModel.DOCUMENTO                 := lQry.FieldByName('DOCUMENTO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TContasPagarItensDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TContasPagarItensDao.Destroy;
begin
  inherited;
end;

function TContasPagarItensDao.incluir(AContasPagarItensModel: TContasPagarItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CONTASPAGARITENS', 'DUPLIACATA_PAG');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasPagarItensModel);
    lQry.Open;

    Result := lQry.FieldByName('DUPLIACATA_PAG').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasPagarItensDao.alterar(AContasPagarItensModel: TContasPagarItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('CONTASPAGARITENS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasPagarItensModel);
    lQry.ExecSQL;

    Result := AContasPagarItensModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasPagarItensDao.excluir(AContasPagarItensModel: TContasPagarItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CONTASPAGARITENS where ID = :ID',[AContasPagarItensModel.ID]);
   lQry.ExecSQL;
   Result := AContasPagarItensModel.ID;

  finally
    lQry.Free;
  end;
end;

function TContasPagarItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and id = '+IntToStr(FIDRecordView);

  if not FDuplicataView.IsEmpty then
    lSQL := lSQL + ' and DUPLIACATA_PAG = '+ QuotedStr(FDuplicataView);

  if not FFornecedorView.IsEmpty then
    lSQL := lSQL + ' and CODIGO_FOR = '+ QuotedStr(FFornecedorView);

  Result := lSQL;
end;

procedure TContasPagarItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CONTASPAGARITENS where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TContasPagarItensDao.obterLista: TFDMemTable;
var
  lQry : TFDQuery;
  lSQL : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSQL := ' select '+lPaginacao+'                                                         '+SLineBreak+
            '        contaspagaritens.*,                                                    '+SLineBreak+
            '        coalesce(fornecedor.razao_for, fornecedor.fantasia_for) FORNECEDOR,    '+SLineBreak+
            '        portador.nome_port PORTADOR                                            '+SLineBreak+
            '   from contaspagaritens                                                       '+SLineBreak+
            '   left join fornecedor on fornecedor.codigo_for = contaspagaritens.codigo_for '+SLineBreak+
            '   left join portador on portador.codigo_port = contaspagaritens.portador_id   '+SLineBreak+
            '  where 1=1                                                                    '+SLineBreak;

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

procedure TContasPagarItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasPagarItensDao.SetDuplicataView(const Value: String);
begin
  FDuplicataView := Value;
end;

procedure TContasPagarItensDao.SetFornecedorView(const Value: String);
begin
  FFornecedorView := Value;
end;

procedure TContasPagarItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasPagarItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasPagarItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasPagarItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasPagarItensDao.setParams(var pQry: TFDQuery; pContasPagarItensModel: TContasPagarItensModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CONTASPAGARITENS');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TContasPagarItensModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pContasPagarItensModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pContasPagarItensModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TContasPagarItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasPagarItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasPagarItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
