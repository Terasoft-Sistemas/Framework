unit ChequeDao;

interface

uses
  ChequeModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TChequeDao = class;
  ITChequeDao=IObject<TChequeDao>;

  TChequeDao = class
  private
    [unsafe] mySelf: ITChequeDao;
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

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

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITChequeDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pChequeModel: ITChequeModel): String;
    function alterar(pChequeModel: ITChequeModel): String;
    function excluir(pChequeModel: ITChequeModel): String;

    function carregaClasse(pID : String): ITChequeModel;
    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pChequeModel: ITChequeModel);

end;

implementation

uses
  System.Rtti;

{ TCheque }

function TChequeDao.carregaClasse(pID : String): ITChequeModel;
var
  lQry: TFDQuery;
  lModel: ITChequeModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TChequeModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CHEQUE where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.NUMERO_CHQ         := lQry.FieldByName('NUMERO_CHQ').AsString;
    lModel.objeto.BANCO_CHQ          := lQry.FieldByName('BANCO_CHQ').AsString;
    lModel.objeto.EMITENTE_CHQ       := lQry.FieldByName('EMITENTE_CHQ').AsString;
    lModel.objeto.EMISSAO_CHQ        := lQry.FieldByName('EMISSAO_CHQ').AsString;
    lModel.objeto.VALOR_CHQ          := lQry.FieldByName('VALOR_CHQ').AsString;
    lModel.objeto.HISTORICO_CHQ      := lQry.FieldByName('HISTORICO_CHQ').AsString;
    lModel.objeto.VENCIMENTO_CHQ     := lQry.FieldByName('VENCIMENTO_CHQ').AsString;
    lModel.objeto.BAIXA_CHQ          := lQry.FieldByName('BAIXA_CHQ').AsString;
    lModel.objeto.DEVOLVIDO_CHQ      := lQry.FieldByName('DEVOLVIDO_CHQ').AsString;
    lModel.objeto.DEVOLVIDO2_CHQ     := lQry.FieldByName('DEVOLVIDO2_CHQ').AsString;
    lModel.objeto.CODIGO_CLI         := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.objeto.DESTINO_CHQ        := lQry.FieldByName('DESTINO_CHQ').AsString;
    lModel.objeto.AGENCIA_CHQ        := lQry.FieldByName('AGENCIA_CHQ').AsString;
    lModel.objeto.CONTA_CHQ          := lQry.FieldByName('CONTA_CHQ').AsString;
    lModel.objeto.USUARIO_CHQ        := lQry.FieldByName('USUARIO_CHQ').AsString;
    lModel.objeto.OBS_CHQ            := lQry.FieldByName('OBS_CHQ').AsString;
    lModel.objeto.TIPO               := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.NUMERO_DOC         := lQry.FieldByName('NUMERO_DOC').AsString;
    lModel.objeto.NUMERO             := lQry.FieldByName('NUMERO').AsString;
    lModel.objeto.LOJA               := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.CNPJ_CPF_CHEQUE    := lQry.FieldByName('CNPJ_CPF_CHEQUE').AsString;
    lModel.objeto.ID                 := lQry.FieldByName('ID').AsString;
    lModel.objeto.CMC7               := lQry.FieldByName('CMC7').AsString;
    lModel.objeto.FORMA_PAGAMENTO_ID := lQry.FieldByName('FORMA_PAGAMENTO_ID').AsString;
    lModel.objeto.DATAHORA           := lQry.FieldByName('DATAHORA').AsString;
    lModel.objeto.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;
	
    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TChequeDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TChequeDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TChequeDao.incluir(pChequeModel: ITChequeModel): String;
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

function TChequeDao.alterar(pChequeModel: ITChequeModel): String;
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

    Result := pChequeModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TChequeDao.excluir(pChequeModel: ITChequeModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CHEQUE where ID = :ID' ,[pChequeModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pChequeModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;


class function TChequeDao.getNewIface(pIConexao: IConexao): ITChequeDao;
begin
  Result := TImplObjetoOwner<TChequeDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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

function TChequeDao.obterLista: IFDDataset;
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

procedure TChequeDao.setParams(var pQry: TFDQuery; pChequeModel: ITChequeModel);
begin
  vConstrutor.setParams('CHEQUE',pQry,pChequeModel.objeto);
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
