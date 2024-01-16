unit ContasDao;

interface

uses
  ContasModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao;

type
  TContasDao = class

  private
    vIConexao : IConexao;
    FContassLista: TObjectList<TContasModel>;
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
    procedure SetContassLista(const Value: TObjectList<TContasModel>);
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

    property ContassLista: TObjectList<TContasModel> read FContassLista write SetContassLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AContasModel: TContasModel): String;
    function alterar(AContasModel: TContasModel): String;
    function excluir(AContasModel: TContasModel): String;

    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pContasModel: TContasModel);

end;

implementation

{ TContas }

constructor TContasDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContasDao.Destroy;
begin

  inherited;
end;

function TContasDao.incluir(AContasModel: TContasModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := '   insert into contas (classificacao,                '+SLineBreak+
          '                       codigo_cta,                   '+SLineBreak+
          '                       nome_cta,                     '+SLineBreak+
          '                       tipo_cta,                     '+SLineBreak+
          '                       dr_cta,                       '+SLineBreak+
          '                       usuario_cta,                  '+SLineBreak+
          '                       banco_cta,                    '+SLineBreak+
          '                       baixapagar_cta,               '+SLineBreak+
          '                       tiposemdr_cta,                '+SLineBreak+
          '                       tiposemdr_cta_recebimento,    '+SLineBreak+
          '                       grupo_cta,                    '+SLineBreak+
          '                       subgrupo_cta,                 '+SLineBreak+
          '                       centrocusto_cta,              '+SLineBreak+
          '                       extrato_cta,                  '+SLineBreak+
          '                       ordem,                        '+SLineBreak+
          '                       loja,                         '+SLineBreak+
          '                       emprestimo_cta,               '+SLineBreak+
          '                       status,                       '+SLineBreak+
          '                       credito_icms,                 '+SLineBreak+
          '                       receitaxdespesas,             '+SLineBreak+
          '                       credito_cliente_cta,          '+SLineBreak+
          '                       credito_fornecedor_cta)       '+SLineBreak+
          '   values (:classificacao,                           '+SLineBreak+
          '           :codigo_cta,                              '+SLineBreak+
          '           :nome_cta,                                '+SLineBreak+
          '           :tipo_cta,                                '+SLineBreak+
          '           :dr_cta,                                  '+SLineBreak+
          '           :usuario_cta,                             '+SLineBreak+
          '           :banco_cta,                               '+SLineBreak+
          '           :baixapagar_cta,                          '+SLineBreak+
          '           :tiposemdr_cta,                           '+SLineBreak+
          '           :tiposemdr_cta_recebimento,               '+SLineBreak+
          '           :grupo_cta,                               '+SLineBreak+
          '           :subgrupo_cta,                            '+SLineBreak+
          '           :centrocusto_cta,                         '+SLineBreak+
          '           :extrato_cta,                             '+SLineBreak+
          '           :ordem,                                   '+SLineBreak+
          '           :loja,                                    '+SLineBreak+
          '           :emprestimo_cta,                          '+SLineBreak+
          '           :status,                                  '+SLineBreak+
          '           :credito_icms,                            '+SLineBreak+
          '           :receitaxdespesas,                        '+SLineBreak+
          '           :credito_cliente_cta,                     '+SLineBreak+
          '           :credito_fornecedor_cta)                  '+SLineBreak+
          ' returning ID                                        '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasDao.alterar(AContasModel: TContasModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL :=   '  update contas                                                     '+SLineBreak+
            '     set classificacao = :classificacao,                            '+SLineBreak+
            '         nome_cta = :nome_cta,                                      '+SLineBreak+
            '         tipo_cta = :tipo_cta,                                      '+SLineBreak+
            '         dr_cta = :dr_cta,                                          '+SLineBreak+
            '         usuario_cta = :usuario_cta,                                '+SLineBreak+
            '         banco_cta = :banco_cta,                                    '+SLineBreak+
            '         baixapagar_cta = :baixapagar_cta,                          '+SLineBreak+
            '         tiposemdr_cta = :tiposemdr_cta,                            '+SLineBreak+
            '         tiposemdr_cta_recebimento = :tiposemdr_cta_recebimento,    '+SLineBreak+
            '         grupo_cta = :grupo_cta,                                    '+SLineBreak+
            '         subgrupo_cta = :subgrupo_cta,                              '+SLineBreak+
            '         centrocusto_cta = :centrocusto_cta,                        '+SLineBreak+
            '         extrato_cta = :extrato_cta,                                '+SLineBreak+
            '         ordem = :ordem,                                            '+SLineBreak+
            '         loja = :loja,                                              '+SLineBreak+
            '         emprestimo_cta = :emprestimo_cta,                          '+SLineBreak+
            '         status = :status,                                          '+SLineBreak+
            '         credito_icms = :credito_icms,                              '+SLineBreak+
            '         receitaxdespesas = :receitaxdespesas,                      '+SLineBreak+
            '         credito_cliente_cta = :credito_cliente_cta,                '+SLineBreak+
            '         credito_fornecedor_cta = :credito_fornecedor_cta           '+SLineBreak+
            '   where (codigo_cta = :codigo_cta)                                 '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AContasModel);
    lQry.ExecSQL;

    Result := AContasModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContasDao.excluir(AContasModel: TContasModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from contas where ID = :ID',[AContasModel.ID]);
   lQry.ExecSQL;
   Result := AContasModel.ID;

  finally
    lQry.Free;
  end;
end;

function TContasDao.montaCondicaoQuery: String;
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

procedure TContasDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From contas where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TContasDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin

  lQry := vIConexao.CriarQuery;

  FContassLista := TObjectList<TContasModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       contas.*                 '+
	    '  from contas                   '+
      ' where 1=1                      ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FContassLista.Add(TContasModel.Create);

      i := FContassLista.Count -1;

      FContassLista[i].ID                         := lQry.FieldByName('ID').AsString;
      FContassLista[i].CLASSIFICACAO              := lQry.FieldByName('CLASSIFICACAO').AsString;
      FContassLista[i].CODIGO_CTA                 := lQry.FieldByName('CODIGO_CTA').AsString;
      FContassLista[i].NOME_CTA                   := lQry.FieldByName('NOME_CTA').AsString;
      FContassLista[i].TIPO_CTA                   := lQry.FieldByName('TIPO_CTA').AsString;
      FContassLista[i].DR_CTA                     := lQry.FieldByName('DR_CTA').AsString;
      FContassLista[i].USUARIO_CTA                := lQry.FieldByName('USUARIO_CTA').AsString;
      FContassLista[i].BANCO_CTA                  := lQry.FieldByName('BANCO_CTA').AsString;
      FContassLista[i].BAIXAPAGAR_CTA             := lQry.FieldByName('BAIXAPAGAR_CTA').AsString;
      FContassLista[i].TIPOSEMDR_CTA              := lQry.FieldByName('TIPOSEMDR_CTA').AsString;
      FContassLista[i].TIPOSEMDR_CTA_RECEBIMENTO  := lQry.FieldByName('TIPOSEMDR_CTA_RECEBIMENTO').AsString;
      FContassLista[i].GRUPO_CTA                  := lQry.FieldByName('GRUPO_CTA').AsString;
      FContassLista[i].SUBGRUPO_CTA               := lQry.FieldByName('SUBGRUPO_CTA').AsString;
      FContassLista[i].CENTROCUSTO_CTA            := lQry.FieldByName('CENTROCUSTO_CTA').AsString;
      FContassLista[i].EXTRATO_CTA                := lQry.FieldByName('EXTRATO_CTA').AsString;
      FContassLista[i].ORDEM                      := lQry.FieldByName('ORDEM').AsString;
      FContassLista[i].LOJA                       := lQry.FieldByName('LOJA').AsString;
      FContassLista[i].EMPRESTIMO_CTA             := lQry.FieldByName('EMPRESTIMO_CTA').AsString;
      FContassLista[i].STATUS                     := lQry.FieldByName('STATUS').AsString;
      FContassLista[i].CREDITO_ICMS               := lQry.FieldByName('CREDITO_ICMS').AsString;
      FContassLista[i].RECEITAXDESPESAS           := lQry.FieldByName('RECEITAXDESPESAS').AsString;
      FContassLista[i].SYSTIME                    := lQry.FieldByName('SYSTIME').AsString;
      FContassLista[i].CREDITO_CLIENTE_CTA        := lQry.FieldByName('CREDITO_CLIENTE_CTA').AsString;
      FContassLista[i].CREDITO_FORNECEDOR_CTA     := lQry.FieldByName('CREDITO_FORNECEDOR_CTA').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;

  end;
end;

procedure TContasDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContasDao.SetContassLista(const Value: TObjectList<TContasModel>);
begin
  FContassLista := Value;
end;

procedure TContasDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContasDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TContasDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContasDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContasDao.setParams(var pQry: TFDQuery; pContasModel: TContasModel);
begin
  pQry.ParamByName('classificacao').Value              := IIF(pContasModel.CLASSIFICACAO              = '', Unassigned, pContasModel.CLASSIFICACAO);
  pQry.ParamByName('codigo_cta').Value                 := IIF(pContasModel.CODIGO_CTA                 = '', Unassigned, pContasModel.CODIGO_CTA);
  pQry.ParamByName('nome_cta').Value                   := IIF(pContasModel.NOME_CTA                   = '', Unassigned, pContasModel.NOME_CTA);
  pQry.ParamByName('tipo_cta').Value                   := IIF(pContasModel.TIPO_CTA                   = '', Unassigned, pContasModel.TIPO_CTA);
  pQry.ParamByName('dr_cta').Value                     := IIF(pContasModel.DR_CTA                     = '', Unassigned, pContasModel.DR_CTA);
  pQry.ParamByName('usuario_cta').Value                := IIF(pContasModel.USUARIO_CTA                = '', Unassigned, pContasModel.USUARIO_CTA);
  pQry.ParamByName('banco_cta').Value                  := IIF(pContasModel.BANCO_CTA                  = '', Unassigned, pContasModel.BANCO_CTA);
  pQry.ParamByName('baixapagar_cta').Value             := IIF(pContasModel.BAIXAPAGAR_CTA             = '', Unassigned, pContasModel.BAIXAPAGAR_CTA);
  pQry.ParamByName('tiposemdr_cta').Value              := IIF(pContasModel.TIPOSEMDR_CTA              = '', Unassigned, pContasModel.TIPOSEMDR_CTA);
  pQry.ParamByName('tiposemdr_cta_recebimento').Value  := IIF(pContasModel.TIPOSEMDR_CTA_RECEBIMENTO  = '', Unassigned, pContasModel.TIPOSEMDR_CTA_RECEBIMENTO);
  pQry.ParamByName('grupo_cta').Value                  := IIF(pContasModel.GRUPO_CTA                  = '', Unassigned, pContasModel.GRUPO_CTA);
  pQry.ParamByName('subgrupo_cta').Value               := IIF(pContasModel.SUBGRUPO_CTA               = '', Unassigned, pContasModel.SUBGRUPO_CTA);
  pQry.ParamByName('centrocusto_cta').Value            := IIF(pContasModel.CENTROCUSTO_CTA            = '', Unassigned, pContasModel.CENTROCUSTO_CTA);
  pQry.ParamByName('extrato_cta').Value                := IIF(pContasModel.EXTRATO_CTA                = '', Unassigned, pContasModel.EXTRATO_CTA);
  pQry.ParamByName('ordem').Value                      := IIF(pContasModel.ORDEM                      = '', Unassigned, pContasModel.ORDEM);
  pQry.ParamByName('loja').Value                       := IIF(pContasModel.LOJA                       = '', Unassigned, pContasModel.LOJA);
  pQry.ParamByName('emprestimo_cta').Value             := IIF(pContasModel.EMPRESTIMO_CTA             = '', Unassigned, pContasModel.EMPRESTIMO_CTA);
  pQry.ParamByName('status').Value                     := IIF(pContasModel.STATUS                     = '', Unassigned, pContasModel.STATUS);
  pQry.ParamByName('credito_icms').Value               := IIF(pContasModel.CREDITO_ICMS               = '', Unassigned, pContasModel.CREDITO_ICMS);
  pQry.ParamByName('receitaxdespesas').Value           := IIF(pContasModel.RECEITAXDESPESAS           = '', Unassigned, pContasModel.RECEITAXDESPESAS);
  pQry.ParamByName('credito_cliente_cta').Value        := IIF(pContasModel.CREDITO_CLIENTE_CTA        = '', Unassigned, pContasModel.CREDITO_CLIENTE_CTA);
  pQry.ParamByName('credito_fornecedor_cta').Value     := IIF(pContasModel.CREDITO_FORNECEDOR_CTA     = '', Unassigned, pContasModel.CREDITO_FORNECEDOR_CTA);
end;

procedure TContasDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContasDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContasDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
