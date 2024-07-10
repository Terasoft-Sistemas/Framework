unit ChequeDao;

interface

uses
  ChequeModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TChequeDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
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

    function incluir(pChequeModel: TChequeModel): String;
    function alterar(pChequeModel: TChequeModel): String;
    function excluir(pChequeModel: TChequeModel): String;

    function carregaClasse(pID : String): TChequeModel;
    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pChequeModel: TChequeModel);

end;

implementation

uses
  System.Rtti;

{ TCheque }

function TChequeDao.carregaClasse(pID : String): TChequeModel;
var
  lQry: TFDQuery;
  lModel: TChequeModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TChequeModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CHEQUE where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_CHQ         := lQry.FieldByName('NUMERO_CHQ').AsString;
    lModel.BANCO_CHQ          := lQry.FieldByName('BANCO_CHQ').AsString;
    lModel.EMITENTE_CHQ       := lQry.FieldByName('EMITENTE_CHQ').AsString;
    lModel.EMISSAO_CHQ        := lQry.FieldByName('EMISSAO_CHQ').AsString;
    lModel.VALOR_CHQ          := lQry.FieldByName('VALOR_CHQ').AsString;
    lModel.HISTORICO_CHQ      := lQry.FieldByName('HISTORICO_CHQ').AsString;
    lModel.VENCIMENTO_CHQ     := lQry.FieldByName('VENCIMENTO_CHQ').AsString;
    lModel.BAIXA_CHQ          := lQry.FieldByName('BAIXA_CHQ').AsString;
    lModel.DEVOLVIDO_CHQ      := lQry.FieldByName('DEVOLVIDO_CHQ').AsString;
    lModel.DEVOLVIDO2_CHQ     := lQry.FieldByName('DEVOLVIDO2_CHQ').AsString;
    lModel.CODIGO_CLI         := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.DESTINO_CHQ        := lQry.FieldByName('DESTINO_CHQ').AsString;
    lModel.AGENCIA_CHQ        := lQry.FieldByName('AGENCIA_CHQ').AsString;
    lModel.CONTA_CHQ          := lQry.FieldByName('CONTA_CHQ').AsString;
    lModel.USUARIO_CHQ        := lQry.FieldByName('USUARIO_CHQ').AsString;
    lModel.OBS_CHQ            := lQry.FieldByName('OBS_CHQ').AsString;
    lModel.TIPO               := lQry.FieldByName('TIPO').AsString;
    lModel.NUMERO_DOC         := lQry.FieldByName('NUMERO_DOC').AsString;
    lModel.NUMERO             := lQry.FieldByName('NUMERO').AsString;
    lModel.LOJA               := lQry.FieldByName('LOJA').AsString;
    lModel.CNPJ_CPF_CHEQUE    := lQry.FieldByName('CNPJ_CPF_CHEQUE').AsString;
    lModel.ID                 := lQry.FieldByName('ID').AsString;
    lModel.CMC7               := lQry.FieldByName('CMC7').AsString;
    lModel.FORMA_PAGAMENTO_ID := lQry.FieldByName('FORMA_PAGAMENTO_ID').AsString;
    lModel.DATAHORA           := lQry.FieldByName('DATAHORA').AsString;
    lModel.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;
	
    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TChequeDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TChequeDao.Destroy;
begin
  inherited;
end;

function TChequeDao.incluir(pChequeModel: TChequeModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CHEQUE', 'ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pChequeModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TChequeDao.alterar(pChequeModel: TChequeModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('CHEQUE','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pChequeModel);
    lQry.ExecSQL;

    Result := pChequeModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TChequeDao.excluir(pChequeModel: TChequeModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CHEQUE where ID = :ID' ,[pChequeModel.ID]);
   lQry.ExecSQL;
   Result := pChequeModel.ID;

  finally
    lQry.Free;
  end;
end;


function TChequeDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TChequeDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from CHEQUE where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TChequeDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao+' *       '+SLineBreak+
              '    from cheque          		   '+SLineBreak+
              '   where 1=1                    '+SLineBreak;


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

procedure TChequeDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TChequeDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TChequeDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TChequeDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TChequeDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TChequeDao.setParams(var pQry: TFDQuery; pChequeModel: TChequeModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CHEQUE');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TChequeModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pChequeModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pChequeModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TChequeDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TChequeDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TChequeDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
