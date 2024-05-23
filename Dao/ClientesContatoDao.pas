unit ClientesContatoDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  ClientesContatoModel;

type
  TClientesContatoDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

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
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pClientesContatoModel: TClientesContatoModel): String;
    function alterar(pClientesContatoModel: TClientesContatoModel): String;
    function excluir(pClientesContatoModel: TClientesContatoModel): String;

    function carregaClasse(pID : String): TClientesContatoModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pClientesContatoModel: TClientesContatoModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TClientesContato }

function TClientesContatoDao.alterar(pClientesContatoModel: TClientesContatoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('CLIENTES_CONTATO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pClientesContatoModel);
    lQry.ExecSQL;

    Result := pClientesContatoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TClientesContatoDao.carregaClasse(pID: String): TClientesContatoModel;
var
  lQry: TFDQuery;
  lModel: TClientesContatoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TClientesContatoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CLIENTES_CONTATO where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

      lModel.ID             := lQry.FieldByName('ID').AsString;
      lModel.CLIENTE_ID     := lQry.FieldByName('CLIENTE_ID').AsString;
      lModel.CONTATO        := lQry.FieldByName('CONTATO').AsString;
      lModel.DEPARTAMENTO   := lQry.FieldByName('DEPARTAMENTO').AsString;
      lModel.CELULAR        := lQry.FieldByName('CELULAR').AsString;
      lModel.TELEFONE       := lQry.FieldByName('TELEFONE').AsString;
      lModel.EMAIL          := lQry.FieldByName('EMAIL').AsString;
      lModel.OBS            := lQry.FieldByName('OBS').AsString;
      lModel.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;
      lModel.USUARIO_ID     := lQry.FieldByName('USUARIO_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TClientesContatoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TClientesContatoDao.Destroy;
begin
  inherited;
end;

function TClientesContatoDao.excluir(pClientesContatoModel: TClientesContatoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CLIENTES_CONTATO where ID = :ID' ,[pClientesContatoModel.ID]);
   lQry.ExecSQL;
   Result := pClientesContatoModel.ID;

  finally
    lQry.Free;
  end;
end;
function TClientesContatoDao.incluir(pClientesContatoModel: TClientesContatoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CLIENTES_CONTATO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pClientesContatoModel.ID := vIConexao.Generetor('GEN_CLIENTES_CONTATO');
    setParams(lQry, pClientesContatoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TClientesContatoDao.ObterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                    '+SLineBreak+
              '         CLIENTES_CONTATO.ID,                                             '+SLineBreak+
              '         CLIENTES_CONTATO.CLIENTE_ID,                                     '+SLineBreak+
              '         CLIENTES_CONTATO.CONTATO,                                        '+SLineBreak+
              '         CLIENTES_CONTATO.DEPARTAMENTO,                                   '+SLineBreak+
              '         CLIENTES_CONTATO.CELULAR,                                        '+SLineBreak+
              '         CLIENTES_CONTATO.TELEFONE,                                       '+SLineBreak+
              '         CLIENTES_CONTATO.EMAIL,                                          '+SLineBreak+
              '         CLIENTES_CONTATO.OBS                                             '+SLineBreak+
              '    from CLIENTES_CONTATO                                                 '+SLineBreak+
              '   where 1=1                                                              '+SLineBreak;

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

procedure TClientesContatoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CLIENTES_CONTATO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TClientesContatoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TClientesContatoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TClientesContatoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TClientesContatoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TClientesContatoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TClientesContatoDao.setParams(var pQry: TFDQuery; pClientesContatoModel: TClientesContatoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CLIENTES_CONTATO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TClientesContatoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pClientesContatoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pClientesContatoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TClientesContatoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TClientesContatoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TClientesContatoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TClientesContatoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and ID = ' + QuotedStr(FIDRecordView);

  Result := lSQL;
end;

end.
