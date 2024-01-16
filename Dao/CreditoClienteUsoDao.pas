unit CreditoClienteUsoDao;

interface

uses
  CreditoClienteUsoModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TCreditoClienteUsoDao = class

  private
    vIConexao : IConexao;
    FCreditoClienteUsosLista: TObjectList<TCreditoClienteUsoModel>;
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
    procedure SetCreditoClienteUsosLista(const Value: TObjectList<TCreditoClienteUsoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property CreditoClienteUsosLista: TObjectList<TCreditoClienteUsoModel> read FCreditoClienteUsosLista write SetCreditoClienteUsosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
    function alterar(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
    function excluir(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
	
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pCreditoClienteUsoModel: TCreditoClienteUsoModel);

end;

implementation

{ TCreditoClienteUso }

constructor TCreditoClienteUsoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCreditoClienteUsoDao.Destroy;
begin

  inherited;
end;

function TCreditoClienteUsoDao.incluir(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL :=   '     insert into credito_cliente_uso (id,                   '+SLineBreak+
            '                                      credito_cliente_id,   '+SLineBreak+
            '                                      data,                 '+SLineBreak+
            '                                      valor,                '+SLineBreak+
            '                                      parcela,              '+SLineBreak+
            '                                      receber_id,           '+SLineBreak+
            '                                      local,                '+SLineBreak+
            '                                      usuario_id,           '+SLineBreak+
            '                                      datahora)             '+SLineBreak+
            '     values (:id,                                           '+SLineBreak+
            '             :credito_cliente_id,                           '+SLineBreak+
            '             :data,                                         '+SLineBreak+
            '             :valor,                                        '+SLineBreak+
            '             :parcela,                                      '+SLineBreak+
            '             :receber_id,                                   '+SLineBreak+
            '             :local,                                        '+SLineBreak+
            '             :usuario_id,                                   '+SLineBreak+
            '             :datahora)                                     '+SLineBreak+
            ' returning ID                                               '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := vIConexao.Generetor('GEN_CREDITO_CLIENTE_USO');
    setParams(lQry, ACreditoClienteUsoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCreditoClienteUsoDao.alterar(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=   '   update credito_cliente_uso                          '+SLineBreak+
            '      set credito_cliente_id = :credito_cliente_id,    '+SLineBreak+
            '          data = :data,                                '+SLineBreak+
            '          valor = :valor,                              '+SLineBreak+
            '          parcela = :parcela,                          '+SLineBreak+
            '          receber_id = :receber_id,                    '+SLineBreak+
            '          local = :local,                              '+SLineBreak+
            '          usuario_id = :usuario_id,                    '+SLineBreak+
            '          datahora = :datahora                         '+SLineBreak+
            '    where (id = :id)                                   '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := IIF(ACreditoClienteUsoModel.ID = '', Unassigned, ACreditoClienteUsoModel.ID);
    setParams(lQry, ACreditoClienteUsoModel);
    lQry.ExecSQL;

    Result := ACreditoClienteUsoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCreditoClienteUsoDao.excluir(ACreditoClienteUsoModel: TCreditoClienteUsoModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from credito_cliente_uso where ID = :ID',[ACreditoClienteUsoModel.ID]);
   lQry.ExecSQL;
   Result := ACreditoClienteUsoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TCreditoClienteUsoDao.montaCondicaoQuery: String;
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

procedure TCreditoClienteUsoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From credito_cliente_uso where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteUsoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin

  lQry := vIConexao.CriarQuery;

  FCreditoClienteUsosLista := TObjectList<TCreditoClienteUsoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       credito_cliente_uso.*    '+
	    '  from credito_cliente_uso      '+
      ' where 1=1                      ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FCreditoClienteUsosLista.Add(TCreditoClienteUsoModel.Create);

      i := FCreditoClienteUsosLista.Count -1;

      FCreditoClienteUsosLista[i].ID                  := lQry.FieldByName('ID').AsString;
      FCreditoClienteUsosLista[i].CREDITO_CLIENTE_ID  := lQry.FieldByName('CREDITO_CLIENTE_ID').AsString;
      FCreditoClienteUsosLista[i].DATA                := lQry.FieldByName('DATA').AsString;
      FCreditoClienteUsosLista[i].VALOR               := lQry.FieldByName('VALOR').AsString;
      FCreditoClienteUsosLista[i].PARCELA             := lQry.FieldByName('PARCELA').AsString;
      FCreditoClienteUsosLista[i].RECEBER_ID          := lQry.FieldByName('RECEBER_ID').AsString;
      FCreditoClienteUsosLista[i].LOCAL               := lQry.FieldByName('LOCAL').AsString;
      FCreditoClienteUsosLista[i].USUARIO_ID          := lQry.FieldByName('USUARIO_ID').AsString;
      FCreditoClienteUsosLista[i].DATAHORA            := lQry.FieldByName('DATAHORA').AsString;
      FCreditoClienteUsosLista[i].SYSTIME             := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteUsoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCreditoClienteUsoDao.SetCreditoClienteUsosLista(const Value: TObjectList<TCreditoClienteUsoModel>);
begin
  FCreditoClienteUsosLista := Value;
end;

procedure TCreditoClienteUsoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCreditoClienteUsoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCreditoClienteUsoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCreditoClienteUsoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCreditoClienteUsoDao.setParams(var pQry: TFDQuery; pCreditoClienteUsoModel: TCreditoClienteUsoModel);
begin
  pQry.ParamByName('credito_cliente_id').Value  := IIF(pCreditoClienteUsoModel.CREDITO_CLIENTE_ID = '', Unassigned, pCreditoClienteUsoModel.CREDITO_CLIENTE_ID);
  pQry.ParamByName('data').Value                := IIF(pCreditoClienteUsoModel.DATA               = '', Unassigned, transformaDataFireBird(pCreditoClienteUsoModel.DATA));
  pQry.ParamByName('valor').Value               := IIF(pCreditoClienteUsoModel.VALOR              = '', Unassigned, FormataFloatFireBird(pCreditoClienteUsoModel.VALOR));
  pQry.ParamByName('parcela').Value             := IIF(pCreditoClienteUsoModel.PARCELA            = '', Unassigned, pCreditoClienteUsoModel.PARCELA);
  pQry.ParamByName('receber_id').Value          := IIF(pCreditoClienteUsoModel.RECEBER_ID         = '', Unassigned, pCreditoClienteUsoModel.RECEBER_ID);
  pQry.ParamByName('local').Value               := IIF(pCreditoClienteUsoModel.LOCAL              = '', Unassigned, pCreditoClienteUsoModel.LOCAL);
  pQry.ParamByName('usuario_id').Value          := IIF(pCreditoClienteUsoModel.USUARIO_ID         = '', Unassigned, pCreditoClienteUsoModel.USUARIO_ID);
  pQry.ParamByName('datahora').Value            := IIF(pCreditoClienteUsoModel.DATAHORA           = '', Unassigned, transformaDataHoraFireBird(pCreditoClienteUsoModel.DATAHORA));
end;

procedure TCreditoClienteUsoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCreditoClienteUsoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCreditoClienteUsoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
