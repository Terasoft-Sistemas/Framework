//Teste Git
unit PixDao;

interface

uses
  PixModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TPixDao = class

  private
    vIConexao : IConexao;
    FPixsLista: TObjectList<TPixModel>;
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
    procedure SetPixsLista(const Value: TObjectList<TPixModel>);
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

    property PixsLista: TObjectList<TPixModel> read FPixsLista write SetPixsLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(APixModel: TPixModel): String;
    function alterar(APixModel: TPixModel): String;
    function excluir(APixModel: TPixModel): String;
	
    procedure obterLista;

    function carregaClasse(pId: String): TPixModel;

    procedure setParams(var pQry: TFDQuery; pPixModel: TPixModel);

end;

implementation

{ TPix }

function TPixDao.carregaClasse(pId: String): TPixModel;
var
  lQry: TFDQuery;
  lModel: TPixModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TPixModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from pix where id = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                     := lQry.FieldByName('ID').AsString;
    lModel.DATA_CADASTRO          := lQry.FieldByName('DATA_CADASTRO').AsString;
    lModel.SYSTIME                := lQry.FieldByName('SYSTIME').AsString;
    lModel.CLIENTE_ID             := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.VALOR                  := lQry.FieldByName('VALOR').AsString;
    lModel.VENCIMENTO             := lQry.FieldByName('VENCIMENTO').AsString;
    lModel.EXPIRA                 := lQry.FieldByName('EXPIRA').AsString;
    lModel.MENSAGEM               := lQry.FieldByName('MENSAGEM').AsString;
    lModel.DOCUMENTO              := lQry.FieldByName('DOCUMENTO').AsString;
    lModel.JUROS_TIPO             := lQry.FieldByName('JUROS_TIPO').AsString;
    lModel.JUROS_VALOR            := lQry.FieldByName('JUROS_VALOR').AsString;
    lModel.MULTA_TIPO             := lQry.FieldByName('MULTA_TIPO').AsString;
    lModel.MULTA_VALOR            := lQry.FieldByName('MULTA_VALOR').AsString;
    lModel.DESCONTO_TIPO          := lQry.FieldByName('DESCONTO_TIPO').AsString;
    lModel.DESCONTO_VALOR         := lQry.FieldByName('DESCONTO_VALOR').AsString;
    lModel.DESCONTO_DATA          := lQry.FieldByName('DESCONTO_DATA').AsString;
    lModel.PIX_ID                 := lQry.FieldByName('PIX_ID').AsString;
    lModel.PIX_DATA               := lQry.FieldByName('PIX_DATA').AsString;
    lModel.PIX_URL                := lQry.FieldByName('PIX_URL').AsString;
    lModel.PIX_TIPO               := lQry.FieldByName('PIX_TIPO').AsString;
    lModel.VALOR_RECEBIDO         := lQry.FieldByName('VALOR_RECEBIDO').AsString;
    lModel.CONTASRECEBERITENS_ID  := lQry.FieldByName('CONTASRECEBERITENS_ID').AsString;
    lModel.DATA_PAGAMENTO         := lQry.FieldByName('DATA_PAGAMENTO').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TPixDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPixDao.Destroy;
begin

  inherited;
end;

function TPixDao.incluir(APixModel: TPixModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := '   insert into pix (cliente_id,                 '+SLineBreak+
          '                    valor,                      '+SLineBreak+
          '                    vencimento,                 '+SLineBreak+
          '                    expira,                     '+SLineBreak+
          '                    mensagem,                   '+SLineBreak+
          '                    documento,                  '+SLineBreak+
          '                    juros_tipo,                 '+SLineBreak+
          '                    juros_valor,                '+SLineBreak+
          '                    multa_tipo,                 '+SLineBreak+
          '                    multa_valor,                '+SLineBreak+
          '                    desconto_tipo,              '+SLineBreak+
          '                    desconto_valor,             '+SLineBreak+
          '                    desconto_data,              '+SLineBreak+
          '                    pix_id,                     '+SLineBreak+
          '                    pix_data,                   '+SLineBreak+
          '                    pix_url,                    '+SLineBreak+
          '                    pix_tipo,                   '+SLineBreak+
          '                    valor_recebido,             '+SLineBreak+
          '                    data_pagamento,             '+SLineBreak+
          '                    contasreceberitens_id)      '+SLineBreak+
          '   values (:cliente_id,                         '+SLineBreak+
          '           :valor,                              '+SLineBreak+
          '           :vencimento,                         '+SLineBreak+
          '           :expira,                             '+SLineBreak+
          '           :mensagem,                           '+SLineBreak+
          '           :documento,                          '+SLineBreak+
          '           :juros_tipo,                         '+SLineBreak+
          '           :juros_valor,                        '+SLineBreak+
          '           :multa_tipo,                         '+SLineBreak+
          '           :multa_valor,                        '+SLineBreak+
          '           :desconto_tipo,                      '+SLineBreak+
          '           :desconto_valor,                     '+SLineBreak+
          '           :desconto_data,                      '+SLineBreak+
          '           :pix_id,                             '+SLineBreak+
          '           :pix_data,                           '+SLineBreak+
          '           :pix_url,                            '+SLineBreak+
          '           :pix_tipo,                           '+SLineBreak+
          '           :valor_recebido,                     '+SLineBreak+
          '           :data_pagamento,                     '+SLineBreak+
          '           :contasreceberitens_id)              '+SLineBreak+
          ' returning ID                                   '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, APixModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPixDao.alterar(APixModel: TPixModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=   '   update pix                                             '+SLineBreak+
            '      set cliente_id = :cliente_id,                       '+SLineBreak+
            '          valor = :valor,                                 '+SLineBreak+
            '          vencimento = :vencimento,                       '+SLineBreak+
            '          expira = :expira,                               '+SLineBreak+
            '          mensagem = :mensagem,                           '+SLineBreak+
            '          documento = :documento,                         '+SLineBreak+
            '          juros_tipo = :juros_tipo,                       '+SLineBreak+
            '          juros_valor = :juros_valor,                     '+SLineBreak+
            '          multa_tipo = :multa_tipo,                       '+SLineBreak+
            '          multa_valor = :multa_valor,                     '+SLineBreak+
            '          desconto_tipo = :desconto_tipo,                 '+SLineBreak+
            '          desconto_valor = :desconto_valor,               '+SLineBreak+
            '          desconto_data = :desconto_data,                 '+SLineBreak+
            '          pix_id = :pix_id,                               '+SLineBreak+
            '          pix_data = :pix_data,                           '+SLineBreak+
            '          pix_url = :pix_url,                             '+SLineBreak+
            '          pix_tipo = :pix_tipo,                           '+SLineBreak+
            '          valor_recebido = :valor_recebido,               '+SLineBreak+
            '          data_pagamento = :data_pagamento,               '+SLineBreak+
            '          contasreceberitens_id = :contasreceberitens_id  '+SLineBreak+
            '    where (id = :id)                                      '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value   := IIF(APixModel.ID   = '', Unassigned, APixModel.ID);
    setParams(lQry, APixModel);
    lQry.ExecSQL;

    Result := APixModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TPixDao.excluir(APixModel: TPixModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from pix where ID = :ID',[APixModel.ID]);
   lQry.ExecSQL;
   Result := APixModel.ID;

  finally
    lQry.Free;
  end;
end;

function TPixDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and pix.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TPixDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From pix where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TPixDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FPixsLista := TObjectList<TPixModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
    '       pix.*          '+
	  '  from pix            '+
    ' where 1=1            ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FPixsLista.Add(TPixModel.Create(vIConexao));

      i := FPixsLista.Count -1;

      FPixsLista[i].ID                    := lQry.FieldByName('ID').AsString;
      FPixsLista[i].DATA_CADASTRO         := lQry.FieldByName('DATA_CADASTRO').AsString;
      FPixsLista[i].SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
      FPixsLista[i].CLIENTE_ID            := lQry.FieldByName('CLIENTE_ID').AsString;
      FPixsLista[i].VALOR                 := lQry.FieldByName('VALOR').AsString;
      FPixsLista[i].VENCIMENTO            := lQry.FieldByName('VENCIMENTO').AsString;
      FPixsLista[i].EXPIRA                := lQry.FieldByName('EXPIRA').AsString;
      FPixsLista[i].MENSAGEM              := lQry.FieldByName('MENSAGEM').AsString;
      FPixsLista[i].DOCUMENTO             := lQry.FieldByName('DOCUMENTO').AsString;
      FPixsLista[i].JUROS_TIPO            := lQry.FieldByName('JUROS_TIPO').AsString;
      FPixsLista[i].JUROS_VALOR           := lQry.FieldByName('JUROS_VALOR').AsString;
      FPixsLista[i].MULTA_TIPO            := lQry.FieldByName('MULTA_TIPO').AsString;
      FPixsLista[i].MULTA_VALOR           := lQry.FieldByName('MULTA_VALOR').AsString;
      FPixsLista[i].DESCONTO_TIPO         := lQry.FieldByName('DESCONTO_TIPO').AsString;
      FPixsLista[i].DESCONTO_VALOR        := lQry.FieldByName('DESCONTO_VALOR').AsString;
      FPixsLista[i].DESCONTO_DATA         := lQry.FieldByName('DESCONTO_DATA').AsString;
      FPixsLista[i].PIX_ID                := lQry.FieldByName('PIX_ID').AsString;
      FPixsLista[i].PIX_DATA              := lQry.FieldByName('PIX_DATA').AsString;
      FPixsLista[i].PIX_URL               := lQry.FieldByName('PIX_URL').AsString;
      FPixsLista[i].PIX_TIPO              := lQry.FieldByName('PIX_TIPO').AsString;
      FPixsLista[i].VALOR_RECEBIDO        := lQry.FieldByName('VALOR_RECEBIDO').AsString;
      FPixsLista[i].DATA_PAGAMENTO        := lQry.FieldByName('DATA_PAGAMENTO').AsString;
      FPixsLista[i].CONTASRECEBERITENS_ID := lQry.FieldByName('CONTASRECEBERITENS_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TPixDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TPixDao.SetPixsLista(const Value: TObjectList<TPixModel>);
begin
  FPixsLista := Value;
end;

procedure TPixDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TPixDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPixDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPixDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPixDao.setParams(var pQry: TFDQuery; pPixModel: TPixModel);
begin
  pQry.ParamByName('cliente_id').Value            := IIF(pPixModel.CLIENTE_ID            = '', Unassigned, pPixModel.CLIENTE_ID);
  pQry.ParamByName('valor').Value                 := IIF(pPixModel.VALOR                 = '', Unassigned, FormataFloatFireBird(pPixModel.VALOR));
  pQry.ParamByName('vencimento').Value            := IIF(pPixModel.VENCIMENTO            = '', Unassigned, transformaDataFireBird(pPixModel.VENCIMENTO));
  pQry.ParamByName('expira').Value                := IIF(pPixModel.EXPIRA                = '', Unassigned, pPixModel.EXPIRA);
  pQry.ParamByName('mensagem').Value              := IIF(pPixModel.MENSAGEM              = '', Unassigned, pPixModel.MENSAGEM);
  pQry.ParamByName('documento').Value             := IIF(pPixModel.DOCUMENTO             = '', Unassigned, pPixModel.DOCUMENTO);
  pQry.ParamByName('juros_tipo').Value            := IIF(pPixModel.JUROS_TIPO            = '', Unassigned, pPixModel.JUROS_TIPO);
  pQry.ParamByName('juros_valor').Value           := IIF(pPixModel.JUROS_VALOR           = '', Unassigned, FormataFloatFireBird(pPixModel.JUROS_VALOR));
  pQry.ParamByName('multa_tipo').Value            := IIF(pPixModel.MULTA_TIPO            = '', Unassigned, pPixModel.MULTA_TIPO);
  pQry.ParamByName('multa_valor').Value           := IIF(pPixModel.MULTA_VALOR           = '', Unassigned, FormataFloatFireBird(pPixModel.MULTA_VALOR));
  pQry.ParamByName('desconto_tipo').Value         := IIF(pPixModel.DESCONTO_TIPO         = '', Unassigned, pPixModel.DESCONTO_TIPO);
  pQry.ParamByName('desconto_valor').Value        := IIF(pPixModel.DESCONTO_VALOR        = '', Unassigned, FormataFloatFireBird(pPixModel.DESCONTO_VALOR));
  pQry.ParamByName('desconto_data').Value         := IIF(pPixModel.DESCONTO_DATA         = '', Unassigned, transformaDataFireBird(pPixModel.DESCONTO_DATA));
  pQry.ParamByName('pix_id').Value                := IIF(pPixModel.PIX_ID                = '', Unassigned, pPixModel.PIX_ID);
  pQry.ParamByName('pix_data').Value              := IIF(pPixModel.PIX_DATA              = '', Unassigned, pPixModel.PIX_DATA);
  pQry.ParamByName('pix_url').Value               := IIF(pPixModel.PIX_URL               = '', Unassigned, pPixModel.PIX_URL);
  pQry.ParamByName('pix_tipo').Value              := IIF(pPixModel.PIX_TIPO              = '', Unassigned, pPixModel.PIX_TIPO);
  pQry.ParamByName('valor_recebido').Value        := IIF(pPixModel.VALOR_RECEBIDO        = '', Unassigned, FormataFloatFireBird(pPixModel.VALOR_RECEBIDO));
  pQry.ParamByName('data_pagamento').Value        := IIF(pPixModel.DATA_PAGAMENTO        = '', Unassigned, transformaDataFireBird(pPixModel.DATA_PAGAMENTO));
  pQry.ParamByName('contasreceberitens_id').Value := IIF(pPixModel.CONTASRECEBERITENS_ID = '', Unassigned, pPixModel.CONTASRECEBERITENS_ID);
end;

procedure TPixDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPixDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPixDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
