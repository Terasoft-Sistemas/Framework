unit RecebimentoCartaoDao;

interface

uses
  RecebimentoCartaoModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TRecebimentoCartaoDao = class

  private
    vIConexao : IConexao;
    FRecebimentoCartaosLista: TObjectList<TRecebimentoCartaoModel>;
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
    procedure SetRecebimentoCartaosLista(const Value: TObjectList<TRecebimentoCartaoModel>);
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

    property RecebimentoCartaosLista: TObjectList<TRecebimentoCartaoModel> read FRecebimentoCartaosLista write SetRecebimentoCartaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
    function alterar(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
    function excluir(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
	
    procedure obterLista;

    procedure setParams(var pQry: TFDQuery; pCaixaModel: TRecebimentoCartaoModel);

end;

implementation

{ TRecebimentoCartao }

constructor TRecebimentoCartaoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TRecebimentoCartaoDao.Destroy;
begin

  inherited;
end;

function TRecebimentoCartaoDao.incluir(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := '  insert into recebimento_cartao (id,             '+SLineBreak+
          '			   			              		   usuario_id,     '+SLineBreak+
          '								                   data_hora,      '+SLineBreak+
          '								                   cliente_id,     '+SLineBreak+
          '								                   fatura,         '+SLineBreak+
          '								                   parcela,        '+SLineBreak+
          '								                   valor,          '+SLineBreak+
          '								                   bandeira_id,    '+SLineBreak+
          '								                   vencimento,     '+SLineBreak+
          '								                   tef_id)         '+SLineBreak+
          '	  values (:id,                                   '+SLineBreak+
          '		        :usuario_id,                           '+SLineBreak+
          '		        :data_hora,                            '+SLineBreak+
          '		        :cliente_id,                           '+SLineBreak+
          '		        :fatura,                               '+SLineBreak+
          '		        :parcela,                              '+SLineBreak+
          '		        :valor,                                '+SLineBreak+
          '		        :bandeira_id,                          '+SLineBreak+
          '		        :vencimento,                           '+SLineBreak+
          '		        :tef_id)                               '+SLineBreak+
          ' returning ID                                     '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := vIConexao.Generetor('GEN_RECEBIMENTO_CARTAO');
    setParams(lQry, ARecebimentoCartaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TRecebimentoCartaoDao.alterar(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  '  update recebimento_cartao              '+SLineBreak+
           '     set usuario_id = :usuario_id,       '+SLineBreak+
           '         data_hora = :data_hora,         '+SLineBreak+
           '         cliente_id = :cliente_id,       '+SLineBreak+
           '         fatura = :fatura,               '+SLineBreak+
           '         parcela = :parcela,             '+SLineBreak+
           '         valor = :valor,                 '+SLineBreak+
           '         bandeira_id = :bandeira_id,     '+SLineBreak+
           '         vencimento = :vencimento,       '+SLineBreak+
           '         tef_id = :tef_id                '+SLineBreak+
           '   where (id = :id)                      '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value   := IIF(ARecebimentoCartaoModel.ID = '', Unassigned, ARecebimentoCartaoModel.ID);
    setParams(lQry, ARecebimentoCartaoModel);
    lQry.ExecSQL;

    Result := ARecebimentoCartaoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TRecebimentoCartaoDao.excluir(ARecebimentoCartaoModel: TRecebimentoCartaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from recebimento_cartao where ID = :ID',[ARecebimentoCartaoModel.ID]);
   lQry.ExecSQL;
   Result := ARecebimentoCartaoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TRecebimentoCartaoDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and recebimento_cartao.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TRecebimentoCartaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From recebimento_cartao where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TRecebimentoCartaoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FRecebimentoCartaosLista := TObjectList<TRecebimentoCartaoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       recebimento_cartao.*      '+
	    '  from recebimento_cartao        '+
      ' where 1=1                       ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FRecebimentoCartaosLista.Add(TRecebimentoCartaoModel.Create(vIConexao));

      i := FRecebimentoCartaosLista.Count -1;

      FRecebimentoCartaosLista[i].ID          := lQry.FieldByName('ID').AsString;
      FRecebimentoCartaosLista[i].USUARIO_ID  := lQry.FieldByName('USUARIO_ID').AsString;
      FRecebimentoCartaosLista[i].DATA_HORA   := lQry.FieldByName('DATA_HORA').AsString;
      FRecebimentoCartaosLista[i].CLIENTE_ID  := lQry.FieldByName('CLIENTE_ID').AsString;
      FRecebimentoCartaosLista[i].FATURA      := lQry.FieldByName('FATURA').AsString;
      FRecebimentoCartaosLista[i].PARCELA     := lQry.FieldByName('PARCELA').AsString;
      FRecebimentoCartaosLista[i].VALOR       := lQry.FieldByName('VALOR').AsString;
      FRecebimentoCartaosLista[i].BANDEIRA_ID := lQry.FieldByName('BANDEIRA_ID').AsString;
      FRecebimentoCartaosLista[i].VENCIMENTO  := lQry.FieldByName('VENCIMENTO').AsString;
      FRecebimentoCartaosLista[i].TEF_ID      := lQry.FieldByName('TEF_ID').AsString;
      FRecebimentoCartaosLista[i].SYSTIME     := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TRecebimentoCartaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TRecebimentoCartaoDao.SetRecebimentoCartaosLista(const Value: TObjectList<TRecebimentoCartaoModel>);
begin
  FRecebimentoCartaosLista := Value;
end;

procedure TRecebimentoCartaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TRecebimentoCartaoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TRecebimentoCartaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TRecebimentoCartaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TRecebimentoCartaoDao.setParams(var pQry: TFDQuery; pCaixaModel: TRecebimentoCartaoModel);
begin
  pQry.ParamByName('usuario_id').Value  := IIF(pCaixaModel.USUARIO_ID  = '', Unassigned, pCaixaModel.USUARIO_ID);
  pQry.ParamByName('data_hora').Value   := IIF(pCaixaModel.DATA_HORA   = '', Unassigned, transformaDataHoraFireBird(pCaixaModel.DATA_HORA));
  pQry.ParamByName('cliente_id').Value  := IIF(pCaixaModel.CLIENTE_ID  = '', Unassigned, pCaixaModel.CLIENTE_ID);
  pQry.ParamByName('fatura').Value      := IIF(pCaixaModel.FATURA      = '', Unassigned, pCaixaModel.FATURA);
  pQry.ParamByName('parcela').Value     := IIF(pCaixaModel.PARCELA     = '', Unassigned, pCaixaModel.PARCELA);
  pQry.ParamByName('valor').Value       := IIF(pCaixaModel.VALOR       = '', Unassigned, FormataFloatFireBird(pCaixaModel.VALOR));
  pQry.ParamByName('bandeira_id').Value := IIF(pCaixaModel.BANDEIRA_ID = '', Unassigned, pCaixaModel.BANDEIRA_ID);
  pQry.ParamByName('vencimento').Value  := IIF(pCaixaModel.VENCIMENTO  = '', Unassigned, transformaDataFireBird(pCaixaModel.VENCIMENTO));
  pQry.ParamByName('tef_id').Value      := IIF(pCaixaModel.TEF_ID      = '', Unassigned, pCaixaModel.TEF_ID);
end;

procedure TRecebimentoCartaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TRecebimentoCartaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TRecebimentoCartaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
