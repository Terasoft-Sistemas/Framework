unit PermissaoRemotaDao;

interface

uses
  PermissaoRemotaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TPermissaoRemotaDao = class

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

    function incluir(pPermissaoRemotaModel: TPermissaoRemotaModel): String;
    function alterar(pPermissaoRemotaModel: TPermissaoRemotaModel): String;
    function excluir(pPermissaoRemotaModel: TPermissaoRemotaModel): String;

    function carregaClasse(pID : String): TPermissaoRemotaModel;

    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pPermissaoRemotaModel: TPermissaoRemotaModel);

end;

implementation

uses
  System.Rtti;

{ TPermissaoRemota }

function TPermissaoRemotaDao.carregaClasse(pID : String): TPermissaoRemotaModel;
var
  lQry: TFDQuery;
  lModel: TPermissaoRemotaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPermissaoRemotaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from permissao_remota where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                   := lQry.FieldByName('ID').AsString;
    lModel.USUARIO_SOLICITANTE  := lQry.FieldByName('USUARIO_SOLICITANTE').AsString;
    lModel.USUARIO_CEDENTE      := lQry.FieldByName('USUARIO_CEDENTE').AsString;
    lModel.OPERACAO             := lQry.FieldByName('OPERACAO').AsString;
    lModel.MSG_SOLICITACAO      := lQry.FieldByName('MSG_SOLICITACAO').AsString;
    lModel.STATUS               := lQry.FieldByName('STATUS').AsString;
    lModel.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
    lModel.TABELA               := lQry.FieldByName('TABELA').AsString;
    lModel.REGISTRO_ID          := lQry.FieldByName('REGISTRO_ID').AsString;
    lModel.PEDIDO_ID            := lQry.FieldByName('PEDIDO_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TPermissaoRemotaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TPermissaoRemotaDao.Destroy;
begin
  inherited;
end;

function TPermissaoRemotaDao.incluir(pPermissaoRemotaModel: TPermissaoRemotaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('PERMISSAO_REMOTA', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPermissaoRemotaModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPermissaoRemotaDao.alterar(pPermissaoRemotaModel: TPermissaoRemotaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('PERMISSAO_REMOTA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pPermissaoRemotaModel);
    lQry.ExecSQL;

    Result := pPermissaoRemotaModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPermissaoRemotaDao.excluir(pPermissaoRemotaModel: TPermissaoRemotaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from permissao_remota where ID = :ID' ,[pPermissaoRemotaModel.ID]);
   Result := pPermissaoRemotaModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPermissaoRemotaDao.where: String;
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

procedure TPermissaoRemotaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := '  select count(*) records                                                                   '+SLineBreak+
            '    From permissao_remota                                                                   '+SLineBreak+
            '    left join usuario solicitante on solicitante.id = permissao_remota.usuario_solicitante  '+SLineBreak+
            '    left join usuario cedente on cedente.id = permissao_remota.usuario_cedente              '+SLineBreak+
            '   where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TPermissaoRemotaDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select  '+lPaginacao+'                                                                    '+SLineBreak+
              '          permissao_remota.id,                                                              '+SLineBreak+
              '          permissao_remota.usuario_solicitante,                                             '+SLineBreak+
              '          solicitante.fantasia usuario_solicitante_nome,                                    '+SLineBreak+
              '          permissao_remota.usuario_cedente,                                                 '+SLineBreak+
              '          cedente.fantasia usuario_cedente_nome,                                            '+SLineBreak+
              '          permissao_remota.operacao,                                                        '+SLineBreak+
              '          permissao_remota.msg_solicitacao,                                                 '+SLineBreak+
              '          permissao_remota.status,                                                          '+SLineBreak+
              '          permissao_remota.tabela,                                                          '+SLineBreak+
              '          permissao_remota.registro_id,                                                     '+SLineBreak+
              '          permissao_remota.pedido_id                                                        '+SLineBreak+
              '    from permissao_remota                                                                   '+SLineBreak+
              '    left join usuario solicitante on solicitante.id = permissao_remota.usuario_solicitante  '+SLineBreak+
              '    left join usuario cedente on cedente.id = permissao_remota.usuario_cedente              '+SLineBreak+
              '   where 1=1                                                                                '+SLineBreak;


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

procedure TPermissaoRemotaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPermissaoRemotaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPermissaoRemotaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPermissaoRemotaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPermissaoRemotaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPermissaoRemotaDao.setParams(var pQry: TFDQuery; pPermissaoRemotaModel: TPermissaoRemotaModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('PERMISSAO_REMOTA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TPermissaoRemotaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pPermissaoRemotaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pPermissaoRemotaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TPermissaoRemotaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPermissaoRemotaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPermissaoRemotaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
