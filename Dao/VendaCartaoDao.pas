unit VendaCartaoDao;

interface

uses
  VendaCartaoModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto;

type
  TVendaCartaoDao = class

  private
    FVendaCartaosLista: TObjectList<TVendaCartaoModel>;
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
    procedure SetVendaCartaosLista(const Value: TObjectList<TVendaCartaoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;

    procedure setParams(var pQry: TFDQuery; pVendaCartaoModel: TVendaCartaoModel);

  public
    constructor Create;
    destructor Destroy; override;

    property VendaCartaosLista: TObjectList<TVendaCartaoModel> read FVendaCartaosLista write SetVendaCartaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AVendaCartaoModel: TVendaCartaoModel): String;
    function alterar(AVendaCartaoModel: TVendaCartaoModel): String;
    function excluir(AVendaCartaoModel: TVendaCartaoModel): String;
	
    procedure obterLista;

end;

implementation

{ TVendaCartao }

uses VariaveisGlobais;

constructor TVendaCartaoDao.Create;
begin

end;

destructor TVendaCartaoDao.Destroy;
begin

  inherited;
end;

function TVendaCartaoDao.incluir(AVendaCartaoModel: TVendaCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := xConexao.CriarQuery;

  lSQL := '	  insert into vendacartao (id,                     '+SLineBreak+
          '							               numero_car,             '+SLineBreak+
          '							               autorizacao_car,        '+SLineBreak+
          '							               parcela_car,            '+SLineBreak+
          '							               parcelas_car,           '+SLineBreak+
          '							               valor_car,              '+SLineBreak+
          '							               codigo_cli,             '+SLineBreak+
          '							               adm_car,                '+SLineBreak+
          '							               venda_car,              '+SLineBreak+
          '							               parcelado_car,          '+SLineBreak+
          '							               vencimento_car,         '+SLineBreak+
          '							               numero_venda,           '+SLineBreak+
          '							               loja,                   '+SLineBreak+
          '							               numero_os,              '+SLineBreak+
          '							               fatura_id,              '+SLineBreak+
          '							               cancelamento_data,      '+SLineBreak+
          '							               cancelamento_codigo,    '+SLineBreak+
          '							               taxa,                   '+SLineBreak+
          '							               parcela_tef,            '+SLineBreak+
          '							               parcelas_tef)           '+SLineBreak+
          '	  values (:id,                                     '+SLineBreak+
          '			      :numero_car,                             '+SLineBreak+
          '			      :autorizacao_car,                        '+SLineBreak+
          '   			  :parcela_car,                            '+SLineBreak+
          '	    		  :parcelas_car,                           '+SLineBreak+
          '	    		  :valor_car,                              '+SLineBreak+
          '		    	  :codigo_cli,                             '+SLineBreak+
          '			      :adm_car,                                '+SLineBreak+
          '   			  :venda_car,                              '+SLineBreak+
          '	    		  :parcelado_car,                          '+SLineBreak+
          '	    		  :vencimento_car,                         '+SLineBreak+
          '		    	  :numero_venda,                           '+SLineBreak+
          '		    	  :loja,                                   '+SLineBreak+
          '		    	  :numero_os,                              '+SLineBreak+
          '			      :fatura_id,                              '+SLineBreak+
          '			      :cancelamento_data,                      '+SLineBreak+
          '	    		  :cancelamento_codigo,                    '+SLineBreak+
          '	    		  :taxa,                                   '+SLineBreak+
          '	    		  :parcela_tef,                            '+SLineBreak+
          '		    	  :parcelas_tef)                           '+SLineBreak+
          ' returning ID                                       '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := xConexao.Generetor('GEN_VENDACARTAO');
    setParams(lQry, AVendaCartaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TVendaCartaoDao.alterar(AVendaCartaoModel: TVendaCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := xConexao.CriarQuery;

  lSQL := '   update vendacartao                                   '+SLineBreak+
          '      set numero_car = :numero_car,                     '+SLineBreak+
          '          autorizacao_car = :autorizacao_car,           '+SLineBreak+
          '          parcela_car = :parcela_car,                   '+SLineBreak+
          '          parcelas_car = :parcelas_car,                 '+SLineBreak+
          '          valor_car = :valor_car,                       '+SLineBreak+
          '          codigo_cli = :codigo_cli,                     '+SLineBreak+
          '          adm_car = :adm_car,                           '+SLineBreak+
          '          venda_car = :venda_car,                       '+SLineBreak+
          '          parcelado_car = :parcelado_car,               '+SLineBreak+
          '          vencimento_car = :vencimento_car,             '+SLineBreak+
          '          numero_venda = :numero_venda,                 '+SLineBreak+
          '          loja = :loja,                                 '+SLineBreak+
          '          numero_os = :numero_os,                       '+SLineBreak+
          '          fatura_id = :fatura_id,                       '+SLineBreak+
          '          cancelamento_data = :cancelamento_data,       '+SLineBreak+
          '          cancelamento_codigo = :cancelamento_codigo,   '+SLineBreak+
          '          taxa = :taxa,                                 '+SLineBreak+
          '          parcela_tef = :parcela_tef,                   '+SLineBreak+
          '          parcelas_tef = :parcelas_tef                  '+SLineBreak+
          '      where (id = :id)                                  '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := IIF(AVendaCartaoModel.ID = '', Unassigned, AVendaCartaoModel.ID);
    setParams(lQry, AVendaCartaoModel);
    lQry.ExecSQL;

    Result := AVendaCartaoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TVendaCartaoDao.excluir(AVendaCartaoModel: TVendaCartaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := xConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from vendacartao where ID = :ID',[AVendaCartaoModel.ID]);
   lQry.ExecSQL;
   Result := AVendaCartaoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TVendaCartaoDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and vendacartao.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TVendaCartaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := xConexao.CriarQuery;

    lSql := 'select count(*) records From vendacartao where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TVendaCartaoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := xConexao.CriarQuery;

  FVendaCartaosLista := TObjectList<TVendaCartaoModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       vendacartao.*            '+
	    '  from vendacartao              '+
      ' where 1=1                      ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FVendaCartaosLista.Add(TVendaCartaoModel.Create);

      i := FVendaCartaosLista.Count -1;

      FVendaCartaosLista[i].ID                  := lQry.FieldByName('ID').AsString;
      FVendaCartaosLista[i].NUMERO_CAR          := lQry.FieldByName('NUMERO_CAR').AsString;
      FVendaCartaosLista[i].AUTORIZACAO_CAR     := lQry.FieldByName('AUTORIZACAO_CAR').AsString;
      FVendaCartaosLista[i].PARCELA_CAR         := lQry.FieldByName('PARCELA_CAR').AsString;
      FVendaCartaosLista[i].PARCELAS_CAR        := lQry.FieldByName('PARCELAS_CAR').AsString;
      FVendaCartaosLista[i].VALOR_CAR           := lQry.FieldByName('VALOR_CAR').AsString;
      FVendaCartaosLista[i].CODIGO_CLI          := lQry.FieldByName('CODIGO_CLI').AsString;
      FVendaCartaosLista[i].ADM_CAR             := lQry.FieldByName('ADM_CAR').AsString;
      FVendaCartaosLista[i].VENDA_CAR           := lQry.FieldByName('VENDA_CAR').AsString;
      FVendaCartaosLista[i].PARCELADO_CAR       := lQry.FieldByName('PARCELADO_CAR').AsString;
      FVendaCartaosLista[i].VENCIMENTO_CAR      := lQry.FieldByName('VENCIMENTO_CAR').AsString;
      FVendaCartaosLista[i].NUMERO_VENDA        := lQry.FieldByName('NUMERO_VENDA').AsString;
      FVendaCartaosLista[i].LOJA                := lQry.FieldByName('LOJA').AsString;
      FVendaCartaosLista[i].NUMERO_OS           := lQry.FieldByName('NUMERO_OS').AsString;
      FVendaCartaosLista[i].FATURA_ID           := lQry.FieldByName('FATURA_ID').AsString;
      FVendaCartaosLista[i].CANCELAMENTO_DATA   := lQry.FieldByName('CANCELAMENTO_DATA').AsString;
      FVendaCartaosLista[i].CANCELAMENTO_CODIGO := lQry.FieldByName('CANCELAMENTO_CODIGO').AsString;
      FVendaCartaosLista[i].SYSTIME             := lQry.FieldByName('SYSTIME').AsString;
      FVendaCartaosLista[i].TAXA                := lQry.FieldByName('TAXA').AsString;
      FVendaCartaosLista[i].PARCELA_TEF         := lQry.FieldByName('PARCELA_TEF').AsString;
      FVendaCartaosLista[i].PARCELAS_TEF        := lQry.FieldByName('PARCELAS_TEF').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TVendaCartaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVendaCartaoDao.SetVendaCartaosLista(const Value: TObjectList<TVendaCartaoModel>);
begin
  FVendaCartaosLista := Value;
end;

procedure TVendaCartaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TVendaCartaoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TVendaCartaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVendaCartaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TVendaCartaoDao.setParams(var pQry: TFDQuery; pVendaCartaoModel: TVendaCartaoModel);
begin
  pQry.ParamByName('numero_car').Value           := IIF(pVendaCartaoModel.NUMERO_CAR           = '', Unassigned, pVendaCartaoModel.NUMERO_CAR);
  pQry.ParamByName('autorizacao_car').Value      := IIF(pVendaCartaoModel.AUTORIZACAO_CAR      = '', Unassigned, pVendaCartaoModel.AUTORIZACAO_CAR);
  pQry.ParamByName('parcela_car').Value          := IIF(pVendaCartaoModel.PARCELA_CAR          = '', Unassigned, pVendaCartaoModel.PARCELA_CAR);
  pQry.ParamByName('parcelas_car').Value         := IIF(pVendaCartaoModel.PARCELAS_CAR         = '', Unassigned, pVendaCartaoModel.PARCELAS_CAR);
  pQry.ParamByName('valor_car').Value            := IIF(pVendaCartaoModel.VALOR_CAR            = '', Unassigned, FormataFloatFireBird(pVendaCartaoModel.VALOR_CAR));
  pQry.ParamByName('codigo_cli').Value           := IIF(pVendaCartaoModel.CODIGO_CLI           = '', Unassigned, pVendaCartaoModel.CODIGO_CLI);
  pQry.ParamByName('adm_car').Value              := IIF(pVendaCartaoModel.ADM_CAR              = '', Unassigned, pVendaCartaoModel.ADM_CAR);
  pQry.ParamByName('venda_car').Value            := IIF(pVendaCartaoModel.VENDA_CAR            = '', Unassigned, transformaDataFireBird(pVendaCartaoModel.VENDA_CAR));
  pQry.ParamByName('parcelado_car').Value        := IIF(pVendaCartaoModel.PARCELADO_CAR        = '', Unassigned, pVendaCartaoModel.PARCELADO_CAR);
  pQry.ParamByName('vencimento_car').Value       := IIF(pVendaCartaoModel.VENCIMENTO_CAR       = '', Unassigned, transformaDataFireBird(pVendaCartaoModel.VENCIMENTO_CAR));
  pQry.ParamByName('numero_venda').Value         := IIF(pVendaCartaoModel.NUMERO_VENDA         = '', Unassigned, pVendaCartaoModel.NUMERO_VENDA);
  pQry.ParamByName('loja').Value                 := IIF(pVendaCartaoModel.LOJA                 = '', Unassigned, pVendaCartaoModel.LOJA);
  pQry.ParamByName('numero_os').Value            := IIF(pVendaCartaoModel.NUMERO_OS            = '', Unassigned, pVendaCartaoModel.NUMERO_OS);
  pQry.ParamByName('fatura_id').Value            := IIF(pVendaCartaoModel.FATURA_ID            = '', Unassigned, pVendaCartaoModel.FATURA_ID);
  pQry.ParamByName('cancelamento_data').Value    := IIF(pVendaCartaoModel.CANCELAMENTO_DATA    = '', Unassigned, transformaDataFireBird(pVendaCartaoModel.CANCELAMENTO_DATA));
  pQry.ParamByName('cancelamento_codigo').Value  := IIF(pVendaCartaoModel.CANCELAMENTO_CODIGO  = '', Unassigned, pVendaCartaoModel.CANCELAMENTO_CODIGO);
  pQry.ParamByName('taxa').Value                 := IIF(pVendaCartaoModel.TAXA                 = '', Unassigned, FormataFloatFireBird(pVendaCartaoModel.TAXA));
  pQry.ParamByName('parcela_tef').Value          := IIF(pVendaCartaoModel.PARCELA_TEF          = '', Unassigned, pVendaCartaoModel.PARCELA_TEF);
  pQry.ParamByName('parcelas_tef').Value         := IIF(pVendaCartaoModel.PARCELAS_TEF         = '', Unassigned, pVendaCartaoModel.PARCELAS_TEF);
end;

procedure TVendaCartaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TVendaCartaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TVendaCartaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
