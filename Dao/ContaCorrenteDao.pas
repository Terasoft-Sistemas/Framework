unit ContaCorrenteDao;

interface

uses
  ContaCorrenteModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TContaCorrenteDao = class

  private
    vIConexao : IConexao;
    FContaCorrentesLista: TObjectList<TContaCorrenteModel>;
    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetContaCorrentesLista(const Value: TObjectList<TContaCorrenteModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;
    procedure SetIDRecordView(const Value: String);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ContaCorrentesLista: TObjectList<TContaCorrenteModel> read FContaCorrentesLista write SetContaCorrentesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(AContaCorrenteModel: TContaCorrenteModel): String;
    function alterar(AContaCorrenteModel: TContaCorrenteModel): String;
    function excluir(AContaCorrenteModel: TContaCorrenteModel): String;
	
    procedure obterLista;
    function carregaClasse(pId: String): TContaCorrenteModel;

    procedure setParams(var pQry: TFDQuery; pContaCorrenteModel: TContaCorrenteModel);

end;

implementation

{ TContaCorrente }


function TContaCorrenteDao.carregaClasse(pId: String): TContaCorrenteModel;
var
  lQry: TFDQuery;
  lModel: TContaCorrenteModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TContaCorrenteModel.Create;
  Result   := lModel;

  try
    lQry.Open('select * from contacorrente where numero_cor = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_COR            := lQry.FieldByName('NUMERO_COR').AsString;
    lModel.DATA_COR              := lQry.FieldByName('DATA_COR').AsString;
    lModel.HORA_COR              := lQry.FieldByName('HORA_COR').AsString;
    lModel.CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.CODIGO_BAN            := lQry.FieldByName('CODIGO_BAN').AsString;
    lModel.OBSERVACAO_COR        := lQry.FieldByName('OBSERVACAO_COR').AsString;
    lModel.VALOR_COR             := lQry.FieldByName('VALOR_COR').AsString;
    lModel.TIPO_CTA              := lQry.FieldByName('TIPO_CTA').AsString;
    lModel.STATUS                := lQry.FieldByName('STATUS').AsString;
    lModel.CONCILIADO_COR        := lQry.FieldByName('CONCILIADO_COR').AsString;
    lModel.DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
    lModel.CLIENTE_COR           := lQry.FieldByName('CLIENTE_COR').AsString;
    lModel.FATURA_COR            := lQry.FieldByName('FATURA_COR').AsString;
    lModel.PARCELA_COR           := lQry.FieldByName('PARCELA_COR').AsString;
    lModel.CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
    lModel.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.NUMERO_CHQ            := lQry.FieldByName('NUMERO_CHQ').AsString;
    lModel.DR                    := lQry.FieldByName('DR').AsString;
    lModel.ID                    := lQry.FieldByName('ID').AsString;
    lModel.PORTADOR_COR          := lQry.FieldByName('PORTADOR_COR').AsString;
    lModel.TROCO                 := lQry.FieldByName('TROCO').AsString;
    lModel.USUARIO_COR           := lQry.FieldByName('USUARIO_COR').AsString;
    lModel.TIPO                  := lQry.FieldByName('TIPO').AsString;
    lModel.SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
    lModel.LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
    lModel.EMPRESTIMO_RECEBER_ID := lQry.FieldByName('EMPRESTIMO_RECEBER_ID').AsString;
    lModel.FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.OS_NEW_ID             := lQry.FieldByName('OS_NEW_ID').AsString;
    lModel.CONCILIACAO_ID        := lQry.FieldByName('CONCILIACAO_ID').AsString;
    lModel.PLACA                 := lQry.FieldByName('PLACA').AsString;
    lModel.TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
    lModel.TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
    lModel.COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
    lModel.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.PAGARME_LOTE          := lQry.FieldByName('PAGARME_LOTE').AsString;
    lModel.LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
    lModel.PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.IUGU_ID               := lQry.FieldByName('IUGU_ID').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TContaCorrenteDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TContaCorrenteDao.Destroy;
begin

  inherited;
end;

function TContaCorrenteDao.incluir(AContaCorrenteModel: TContaCorrenteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=   '   insert into contacorrente (numero_cor,                 '+SLineBreak+
            '                              data_cor,                   '+SLineBreak+
            '                              hora_cor,                   '+SLineBreak+
            '                              codigo_cta,                 '+SLineBreak+
            '                              codigo_ban,                 '+SLineBreak+
            '                              observacao_cor,             '+SLineBreak+
            '                              valor_cor,                  '+SLineBreak+
            '                              tipo_cta,                   '+SLineBreak+
            '                              status,                     '+SLineBreak+
            '                              conciliado_cor,             '+SLineBreak+
            '                              data_con,                   '+SLineBreak+
            '                              cliente_cor,                '+SLineBreak+
            '                              fatura_cor,                 '+SLineBreak+
            '                              parcela_cor,                '+SLineBreak+
            '                              centro_custo,               '+SLineBreak+
            '                              loja,                       '+SLineBreak+
            '                              numero_chq,                 '+SLineBreak+
            '                              dr,                         '+SLineBreak+
            '                              portador_cor,               '+SLineBreak+
            '                              troco,                      '+SLineBreak+
            '                              usuario_cor,                '+SLineBreak+
            '                              tipo,                       '+SLineBreak+
            '                              sub_id,                     '+SLineBreak+
            '                              locacao_id,                 '+SLineBreak+
            '                              emprestimo_receber_id,      '+SLineBreak+
            '                              funcionario_id,             '+SLineBreak+
            '                              os_new_id,                  '+SLineBreak+
            '                              conciliacao_id,             '+SLineBreak+
            '                              placa,                      '+SLineBreak+
            '                              transferencia_origem,       '+SLineBreak+
            '                              transferencia_id,           '+SLineBreak+
            '                              competencia,                '+SLineBreak+
            '                              pagarme_lote,               '+SLineBreak+
            '                              loja_remoto,                '+SLineBreak+
            '                              pedido_id,                  '+SLineBreak+
            '                              iugu_id)                    '+SLineBreak+
            '   values (:numero_cor,                                   '+SLineBreak+
            '           :data_cor,                                     '+SLineBreak+
            '           :hora_cor,                                     '+SLineBreak+
            '           :codigo_cta,                                   '+SLineBreak+
            '           :codigo_ban,                                   '+SLineBreak+
            '           :observacao_cor,                               '+SLineBreak+
            '           :valor_cor,                                    '+SLineBreak+
            '           :tipo_cta,                                     '+SLineBreak+
            '           :status,                                       '+SLineBreak+
            '           :conciliado_cor,                               '+SLineBreak+
            '           :data_con,                                     '+SLineBreak+
            '           :cliente_cor,                                  '+SLineBreak+
            '           :fatura_cor,                                   '+SLineBreak+
            '           :parcela_cor,                                  '+SLineBreak+
            '           :centro_custo,                                 '+SLineBreak+
            '           :loja,                                         '+SLineBreak+
            '           :numero_chq,                                   '+SLineBreak+
            '           :dr,                                           '+SLineBreak+
            '           :portador_cor,                                 '+SLineBreak+
            '           :troco,                                        '+SLineBreak+
            '           :usuario_cor,                                  '+SLineBreak+
            '           :tipo,                                         '+SLineBreak+
            '           :sub_id,                                       '+SLineBreak+
            '           :locacao_id,                                   '+SLineBreak+
            '           :emprestimo_receber_id,                        '+SLineBreak+
            '           :funcionario_id,                               '+SLineBreak+
            '           :os_new_id,                                    '+SLineBreak+
            '           :conciliacao_id,                               '+SLineBreak+
            '           :placa,                                        '+SLineBreak+
            '           :transferencia_origem,                         '+SLineBreak+
            '           :transferencia_id,                             '+SLineBreak+
            '           :competencia,                                  '+SLineBreak+
            '           :pagarme_lote,                                 '+SLineBreak+
            '           :loja_remoto,                                  '+SLineBreak+
            '           :pedido_id,                                    '+SLineBreak+
            '           :iugu_id)                                      '+SLineBreak+
            ' returning NUMERO_COR                                     '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_cor').Value := vIConexao.Generetor('GEN_CONTACORRENTE');
    setParams(lQry, AContaCorrenteModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_COR').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContaCorrenteDao.alterar(AContaCorrenteModel: TContaCorrenteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := '    update contacorrente                                    '+SLineBreak+
          '       set data_cor = :data_cor,                            '+SLineBreak+
          '           hora_cor = :hora_cor,                            '+SLineBreak+
          '           codigo_cta = :codigo_cta,                        '+SLineBreak+
          '           codigo_ban = :codigo_ban,                        '+SLineBreak+
          '           observacao_cor = :observacao_cor,                '+SLineBreak+
          '           valor_cor = :valor_cor,                          '+SLineBreak+
          '           tipo_cta = :tipo_cta,                            '+SLineBreak+
          '           status = :status,                                '+SLineBreak+
          '           conciliado_cor = :conciliado_cor,                '+SLineBreak+
          '           data_con = :data_con,                            '+SLineBreak+
          '           cliente_cor = :cliente_cor,                      '+SLineBreak+
          '           fatura_cor = :fatura_cor,                        '+SLineBreak+
          '           parcela_cor = :parcela_cor,                      '+SLineBreak+
          '           centro_custo = :centro_custo,                    '+SLineBreak+
          '           loja = :loja,                                    '+SLineBreak+
          '           numero_chq = :numero_chq,                        '+SLineBreak+
          '           dr = :dr,                                        '+SLineBreak+
          '           portador_cor = :portador_cor,                    '+SLineBreak+
          '           troco = :troco,                                  '+SLineBreak+
          '           usuario_cor = :usuario_cor,                      '+SLineBreak+
          '           tipo = :tipo,                                    '+SLineBreak+
          '           sub_id = :sub_id,                                '+SLineBreak+
          '           locacao_id = :locacao_id,                        '+SLineBreak+
          '           emprestimo_receber_id = :emprestimo_receber_id,  '+SLineBreak+
          '           funcionario_id = :funcionario_id,                '+SLineBreak+
          '           os_new_id = :os_new_id,                          '+SLineBreak+
          '           conciliacao_id = :conciliacao_id,                '+SLineBreak+
          '           placa = :placa,                                  '+SLineBreak+
          '           transferencia_origem = :transferencia_origem,    '+SLineBreak+
          '           transferencia_id = :transferencia_id,            '+SLineBreak+
          '           competencia = :competencia,                      '+SLineBreak+
          '           pagarme_lote = :pagarme_lote,                    '+SLineBreak+
          '           loja_remoto = :loja_remoto,                      '+SLineBreak+
          '           pedido_id = :pedido_id,                          '+SLineBreak+
          '           iugu_id = :iugu_id                               '+SLineBreak+
          '     where (numero_cor = :numero_cor)                       '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_cor').Value := IIF(AContaCorrenteModel.DATA_COR = '', Unassigned, AContaCorrenteModel.DATA_COR);
    setParams(lQry, AContaCorrenteModel);
    lQry.ExecSQL;

    Result := AContaCorrenteModel.NUMERO_COR;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TContaCorrenteDao.excluir(AContaCorrenteModel: TContaCorrenteModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from contacorrente where numero_cor = :numero_cor',[AContaCorrenteModel.NUMERO_COR]);
   lQry.ExecSQL;
   Result := AContaCorrenteModel.ID;

  finally
    lQry.Free;
  end;
end;

function TContaCorrenteDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and contacorrente.numero_cor = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TContaCorrenteDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From contacorrente where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TContaCorrenteDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FContaCorrentesLista := TObjectList<TContaCorrenteModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       contacorrente.*          '+
	    '  from contacorrente            '+
      ' where 1=1                      ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FContaCorrentesLista.Add(TContaCorrenteModel.Create);

      i := FContaCorrentesLista.Count -1;

      FContaCorrentesLista[i].NUMERO_COR            := lQry.FieldByName('NUMERO_COR').AsString;
      FContaCorrentesLista[i].DATA_COR              := lQry.FieldByName('DATA_COR').AsString;
      FContaCorrentesLista[i].HORA_COR              := lQry.FieldByName('HORA_COR').AsString;
      FContaCorrentesLista[i].CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
      FContaCorrentesLista[i].CODIGO_BAN            := lQry.FieldByName('CODIGO_BAN').AsString;
      FContaCorrentesLista[i].OBSERVACAO_COR        := lQry.FieldByName('OBSERVACAO_COR').AsString;
      FContaCorrentesLista[i].VALOR_COR             := lQry.FieldByName('VALOR_COR').AsString;
      FContaCorrentesLista[i].TIPO_CTA              := lQry.FieldByName('TIPO_CTA').AsString;
      FContaCorrentesLista[i].STATUS                := lQry.FieldByName('STATUS').AsString;
      FContaCorrentesLista[i].CONCILIADO_COR        := lQry.FieldByName('CONCILIADO_COR').AsString;
      FContaCorrentesLista[i].DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
      FContaCorrentesLista[i].CLIENTE_COR           := lQry.FieldByName('CLIENTE_COR').AsString;
      FContaCorrentesLista[i].FATURA_COR            := lQry.FieldByName('FATURA_COR').AsString;
      FContaCorrentesLista[i].PARCELA_COR           := lQry.FieldByName('PARCELA_COR').AsString;
      FContaCorrentesLista[i].CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
      FContaCorrentesLista[i].LOJA                  := lQry.FieldByName('LOJA').AsString;
      FContaCorrentesLista[i].NUMERO_CHQ            := lQry.FieldByName('NUMERO_CHQ').AsString;
      FContaCorrentesLista[i].DR                    := lQry.FieldByName('DR').AsString;
      FContaCorrentesLista[i].ID                    := lQry.FieldByName('ID').AsString;
      FContaCorrentesLista[i].PORTADOR_COR          := lQry.FieldByName('PORTADOR_COR').AsString;
      FContaCorrentesLista[i].TROCO                 := lQry.FieldByName('TROCO').AsString;
      FContaCorrentesLista[i].USUARIO_COR           := lQry.FieldByName('USUARIO_COR').AsString;
      FContaCorrentesLista[i].TIPO                  := lQry.FieldByName('TIPO').AsString;
      FContaCorrentesLista[i].SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
      FContaCorrentesLista[i].LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
      FContaCorrentesLista[i].EMPRESTIMO_RECEBER_ID := lQry.FieldByName('EMPRESTIMO_RECEBER_ID').AsString;
      FContaCorrentesLista[i].FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      FContaCorrentesLista[i].OS_NEW_ID             := lQry.FieldByName('OS_NEW_ID').AsString;
      FContaCorrentesLista[i].CONCILIACAO_ID        := lQry.FieldByName('CONCILIACAO_ID').AsString;
      FContaCorrentesLista[i].PLACA                 := lQry.FieldByName('PLACA').AsString;
      FContaCorrentesLista[i].TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
      FContaCorrentesLista[i].TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
      FContaCorrentesLista[i].COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
      FContaCorrentesLista[i].SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
      FContaCorrentesLista[i].PAGARME_LOTE          := lQry.FieldByName('PAGARME_LOTE').AsString;
      FContaCorrentesLista[i].LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
      FContaCorrentesLista[i].PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;
      FContaCorrentesLista[i].IUGU_ID               := lQry.FieldByName('IUGU_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TContaCorrenteDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TContaCorrenteDao.SetContaCorrentesLista(const Value: TObjectList<TContaCorrenteModel>);
begin
  FContaCorrentesLista := Value;
end;

procedure TContaCorrenteDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TContaCorrenteDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TContaCorrenteDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TContaCorrenteDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TContaCorrenteDao.setParams(var pQry: TFDQuery; pContaCorrenteModel: TContaCorrenteModel);
begin
  pQry.ParamByName('data_cor').Value              := IIF(pContaCorrenteModel.DATA_COR               = '', Unassigned, transformaDataFireBird(pContaCorrenteModel.DATA_COR));
  pQry.ParamByName('hora_cor').Value              := IIF(pContaCorrenteModel.HORA_COR               = '', Unassigned, pContaCorrenteModel.HORA_COR);
  pQry.ParamByName('codigo_cta').Value            := IIF(pContaCorrenteModel.CODIGO_CTA             = '', Unassigned, pContaCorrenteModel.CODIGO_CTA);
  pQry.ParamByName('codigo_ban').Value            := IIF(pContaCorrenteModel.CODIGO_BAN             = '', Unassigned, pContaCorrenteModel.CODIGO_BAN);
  pQry.ParamByName('observacao_cor').Value        := IIF(pContaCorrenteModel.OBSERVACAO_COR         = '', Unassigned, pContaCorrenteModel.OBSERVACAO_COR);
  pQry.ParamByName('valor_cor').Value             := IIF(pContaCorrenteModel.VALOR_COR              = '', Unassigned, FormataFloatFireBird(pContaCorrenteModel.VALOR_COR));
  pQry.ParamByName('tipo_cta').Value              := IIF(pContaCorrenteModel.TIPO_CTA               = '', Unassigned, pContaCorrenteModel.TIPO_CTA);
  pQry.ParamByName('status').Value                := IIF(pContaCorrenteModel.STATUS                 = '', Unassigned, pContaCorrenteModel.STATUS);
  pQry.ParamByName('conciliado_cor').Value        := IIF(pContaCorrenteModel.CONCILIADO_COR         = '', Unassigned, pContaCorrenteModel.CONCILIADO_COR);
  pQry.ParamByName('data_con').Value              := IIF(pContaCorrenteModel.DATA_CON               = '', Unassigned, transformaDataFireBird(pContaCorrenteModel.DATA_CON));
  pQry.ParamByName('cliente_cor').Value           := IIF(pContaCorrenteModel.CLIENTE_COR            = '', Unassigned, pContaCorrenteModel.CLIENTE_COR);
  pQry.ParamByName('fatura_cor').Value            := IIF(pContaCorrenteModel.FATURA_COR             = '', Unassigned, pContaCorrenteModel.FATURA_COR);
  pQry.ParamByName('parcela_cor').Value           := IIF(pContaCorrenteModel.PARCELA_COR            = '', Unassigned, pContaCorrenteModel.PARCELA_COR);
  pQry.ParamByName('centro_custo').Value          := IIF(pContaCorrenteModel.CENTRO_CUSTO           = '', Unassigned, pContaCorrenteModel.CENTRO_CUSTO);
  pQry.ParamByName('loja').Value                  := IIF(pContaCorrenteModel.LOJA                   = '', Unassigned, pContaCorrenteModel.LOJA);
  pQry.ParamByName('numero_chq').Value            := IIF(pContaCorrenteModel.NUMERO_CHQ             = '', Unassigned, pContaCorrenteModel.NUMERO_CHQ);
  pQry.ParamByName('dr').Value                    := IIF(pContaCorrenteModel.DR                     = '', Unassigned, pContaCorrenteModel.DR);
  pQry.ParamByName('portador_cor').Value          := IIF(pContaCorrenteModel.PORTADOR_COR           = '', Unassigned, pContaCorrenteModel.PORTADOR_COR);
  pQry.ParamByName('troco').Value                 := IIF(pContaCorrenteModel.TROCO                  = '', Unassigned, pContaCorrenteModel.TROCO);
  pQry.ParamByName('usuario_cor').Value           := IIF(pContaCorrenteModel.USUARIO_COR            = '', Unassigned, pContaCorrenteModel.USUARIO_COR);
  pQry.ParamByName('tipo').Value                  := IIF(pContaCorrenteModel.TIPO                   = '', Unassigned, pContaCorrenteModel.TIPO);
  pQry.ParamByName('sub_id').Value                := IIF(pContaCorrenteModel.SUB_ID                 = '', Unassigned, pContaCorrenteModel.SUB_ID);
  pQry.ParamByName('locacao_id').Value            := IIF(pContaCorrenteModel.LOCACAO_ID             = '', Unassigned, pContaCorrenteModel.LOCACAO_ID);
  pQry.ParamByName('emprestimo_receber_id').Value := IIF(pContaCorrenteModel.EMPRESTIMO_RECEBER_ID  = '', Unassigned, pContaCorrenteModel.EMPRESTIMO_RECEBER_ID);
  pQry.ParamByName('funcionario_id').Value        := IIF(pContaCorrenteModel.FUNCIONARIO_ID         = '', Unassigned, pContaCorrenteModel.FUNCIONARIO_ID);
  pQry.ParamByName('os_new_id').Value             := IIF(pContaCorrenteModel.OS_NEW_ID              = '', Unassigned, pContaCorrenteModel.OS_NEW_ID);
  pQry.ParamByName('conciliacao_id').Value        := IIF(pContaCorrenteModel.CONCILIACAO_ID         = '', Unassigned, pContaCorrenteModel.CONCILIACAO_ID);
  pQry.ParamByName('placa').Value                 := IIF(pContaCorrenteModel.PLACA                  = '', Unassigned, pContaCorrenteModel.PLACA);
  pQry.ParamByName('transferencia_origem').Value  := IIF(pContaCorrenteModel.TRANSFERENCIA_ORIGEM   = '', Unassigned, pContaCorrenteModel.TRANSFERENCIA_ORIGEM);
  pQry.ParamByName('transferencia_id').Value      := IIF(pContaCorrenteModel.TRANSFERENCIA_ID       = '', Unassigned, pContaCorrenteModel.TRANSFERENCIA_ID);
  pQry.ParamByName('competencia').Value           := IIF(pContaCorrenteModel.COMPETENCIA            = '', Unassigned, pContaCorrenteModel.COMPETENCIA);
  pQry.ParamByName('pagarme_lote').Value          := IIF(pContaCorrenteModel.PAGARME_LOTE           = '', Unassigned, pContaCorrenteModel.PAGARME_LOTE);
  pQry.ParamByName('loja_remoto').Value           := IIF(pContaCorrenteModel.LOJA_REMOTO            = '', Unassigned, pContaCorrenteModel.LOJA_REMOTO);
  pQry.ParamByName('pedido_id').Value             := IIF(pContaCorrenteModel.PEDIDO_ID              = '', Unassigned, pContaCorrenteModel.PEDIDO_ID);
  pQry.ParamByName('iugu_id').Value               := IIF(pContaCorrenteModel.IUGU_ID                = '', Unassigned, pContaCorrenteModel.IUGU_ID);
end;

procedure TContaCorrenteDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TContaCorrenteDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TContaCorrenteDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
