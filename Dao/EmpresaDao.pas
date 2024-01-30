unit EmpresaDao;

interface

uses
  EmpresaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type

  TEmpresaDao = class

  private
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
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

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

    function where: String;

    function incluir(AEmpresaModel: TEmpresaModel): String;
    function alterar(AEmpresaModel: TEmpresaModel): String;
    function excluir(AEmpresaModel: TEmpresaModel): String;

    procedure obterLista;
    procedure carregar(pEmpresaModel: TEmpresaModel);
    procedure setParams(var pQry: TFDQuery; pEmpresaModel: TEmpresaModel);

end;

implementation

uses
  System.Rtti, System.Variants;

procedure TEmpresaDao.carregar(pEmpresaModel: TEmpresaModel);
var
  lQry: TFDQuery;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;
   try
      lQry.Open(' select * from EMPRESA ');
      try
        pEmpresaModel.ID                       := lQry.fieldByName('ID').AsString;
        pEmpresaModel.SYSTIME                  := lQry.fieldByName('SYSTIME').AsString;
        pEmpresaModel.CODIGO                   := lQry.fieldByName('CODIGO_EMP').AsString;
        pEmpresaModel.FANTASIA                 := lQry.fieldByName('FANTASIA_EMP').AsString;
        pEmpresaModel.RAZAO_SOCIAL             := lQry.fieldByName('RAZAO_EMP').AsString;
        pEmpresaModel.CNPJ                     := lQry.fieldByName('CNPJ_EMP').AsString;
        pEmpresaModel.INSCRICAO_ESTADUAL       := lQry.fieldByName('INSCRICAO_EMP').AsString;
        pEmpresaModel.INSCRICAO_MUNICIPAL      := lQry.fieldByName('INSCRICAO_MUNICIPAL').AsString;
        pEmpresaModel.ENDERECO                 := lQry.fieldByName('ENDERECO_EMP').AsString;
        pEmpresaModel.BAIRRO                   := lQry.fieldByName('BAIRRO_EMP').AsString;
        pEmpresaModel.CIDADE                   := lQry.fieldByName('CIDADE_EMP').AsString;
        pEmpresaModel.UF                       := lQry.fieldByName('UF_EMP').AsString;
        pEmpresaModel.NUMERO                   := lQry.fieldByName('NUMERO_END').AsString;
        pEmpresaModel.COMPLEMENTO              := lQry.fieldByName('COMPLEMENTO').AsString;
        pEmpresaModel.CODIGO_MUNUCIPIO         := lQry.fieldByName('COD_MUNICIPIO').AsString;
        pEmpresaModel.TELEFONE                 := lQry.fieldByName('TELEFONE_EMP').AsString;
        pEmpresaModel.CONTATO                  := lQry.fieldByName('CONTATO_EMP').AsString;
        pEmpresaModel.EMAIL                    := lQry.fieldByName('EMAIL_EMP').AsString;
        pEmpresaModel.URL                      := lQry.fieldByName('URL_EMP').AsString;
        pEmpresaModel.CEP                      := lQry.fieldByName('CEP_EMP').AsString;
        pEmpresaModel.REGIME_TRIBUTARIO        := lQry.fieldByName('REGIME_NFE').AsString;
        pEmpresaModel.JUROS_BOL                := lQry.fieldByName('JUROS_BOL').AsString;
        pEmpresaModel.LOJA                     := lQry.fieldByName('LOJA').AsString;
        pEmpresaModel.LIMITE_ATRASO            := lQry.fieldByName('LIMITE_ATRAZO').AsString;
        pEmpresaModel.STRING_CONEXAO_RESERVA   := lQry.fieldByName('STRING_CONEXAO_RESERVA').AsString;
      finally
        lQry.Close;
      end;
   finally
     lQry.Free;
   end;
end;

constructor TEmpresaDao.Create(pIConexao: IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TEmpresaDao.Destroy;
begin
  inherited;
end;

function TEmpresaDao.excluir(AEmpresaModel: TEmpresaModel): String;
var
  lQry: TFDQuery;

begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from EMPRESA where ID = :ID',[AEmpresaModel.ID]);
   lQry.ExecSQL;
   Result := AEmpresaModel.ID;

  finally
    lQry.Free;
  end;
end;

function TEmpresaDao.incluir(AEmpresaModel: TEmpresaModel): String;
begin

end;

procedure TEmpresaDao.obterLista;
begin

end;

function TEmpresaDao.alterar(AEmpresaModel: TEmpresaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('EMPRESA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AEmpresaModel);
    lQry.ExecSQL;

    Result := AEmpresaModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;

end;

procedure TEmpresaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TEmpresaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TEmpresaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TEmpresaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TEmpresaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TEmpresaDao.setParams(var pQry: TFDQuery; pEmpresaModel: TEmpresaModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('EMPRESA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TEmpresaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pEmpresaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pEmpresaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TEmpresaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TEmpresaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TEmpresaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TEmpresaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

end.
