unit CaixaDao;

interface

uses
  CaixaModel,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TCaixaDao = class

  private
    vIconexao : Iconexao;
    FCaixasLista: TObjectList<TCaixaModel>;
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
    procedure SetCaixasLista(const Value: TObjectList<TCaixaModel>);
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

    property CaixasLista: TObjectList<TCaixaModel> read FCaixasLista write SetCaixasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(ACaixaModel: TCaixaModel): String;
    function alterar(ACaixaModel: TCaixaModel): String;
    function excluir(ACaixaModel: TCaixaModel): String;

    procedure obterLista;
    function carregaClasse(pIdCaixa: String): TCaixaModel;

    procedure setParams(var pQry: TFDQuery; pCaixaModel: TCaixaModel);

end;

implementation

{ TCaixa }


function TCaixaDao.carregaClasse(pIdCaixa: String): TCaixaModel;
var
  lQry: TFDQuery;
  lModel: TCaixaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCaixaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from caixa where numero_cai = '+pIdCaixa);

    if lQry.IsEmpty then
      Exit;

    lModel.NUMERO_CAI            := lQry.FieldByName('NUMERO_CAI').AsString;
    lModel.CODIGO_CTA            := lQry.FieldByName('CODIGO_CTA').AsString;
    lModel.DATA_CAI              := lQry.FieldByName('DATA_CAI').AsString;
    lModel.HORA_CAI              := lQry.FieldByName('HORA_CAI').AsString;
    lModel.HISTORICO_CAI         := lQry.FieldByName('HISTORICO_CAI').AsString;
    lModel.VALOR_CAI             := lQry.FieldByName('VALOR_CAI').AsString;
    lModel.USUARIO_CAI           := lQry.FieldByName('USUARIO_CAI').AsString;
    lModel.TIPO_CAI              := lQry.FieldByName('TIPO_CAI').AsString;
    lModel.CLIENTE_CAI           := lQry.FieldByName('CLIENTE_CAI').AsString;
    lModel.NUMERO_PED            := lQry.FieldByName('NUMERO_PED').AsString;
    lModel.FATURA_CAI            := lQry.FieldByName('FATURA_CAI').AsString;
    lModel.PARCELA_CAI           := lQry.FieldByName('PARCELA_CAI').AsString;
    lModel.STATUS                := lQry.FieldByName('STATUS').AsString;
    lModel.PORTADOR_CAI          := lQry.FieldByName('PORTADOR_CAI').AsString;
    lModel.CONCILIADO_CAI        := lQry.FieldByName('CONCILIADO_CAI').AsString;
    lModel.DATA_CON              := lQry.FieldByName('DATA_CON').AsString;
    lModel.CENTRO_CUSTO          := lQry.FieldByName('CENTRO_CUSTO').AsString;
    lModel.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.RECIBO                := lQry.FieldByName('RECIBO').AsString;
    lModel.RELATORIO             := lQry.FieldByName('RELATORIO').AsString;
    lModel.OBSERVACAO            := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.DR                    := lQry.FieldByName('DR').AsString;
    lModel.ID                    := lQry.FieldByName('ID').AsString;
    lModel.TROCO                 := lQry.FieldByName('TROCO').AsString;
    lModel.CARGA_ID              := lQry.FieldByName('CARGA_ID').AsString;
    lModel.TIPO                  := lQry.FieldByName('TIPO').AsString;
    lModel.SUB_ID                := lQry.FieldByName('SUB_ID').AsString;
    lModel.LOCACAO_ID            := lQry.FieldByName('LOCACAO_ID').AsString;
    lModel.FUNCIONARIO_ID        := lQry.FieldByName('FUNCIONARIO_ID').AsString;
    lModel.OS_ID                 := lQry.FieldByName('OS_ID').AsString;
    lModel.PLACA                 := lQry.FieldByName('PLACA').AsString;
    lModel.TRANSFERENCIA_ORIGEM  := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
    lModel.TRANSFERENCIA_ID      := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
    lModel.COMPETENCIA           := lQry.FieldByName('COMPETENCIA').AsString;
    lModel.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.LOJA_REMOTO           := lQry.FieldByName('LOJA_REMOTO').AsString;
    lModel.PEDIDO_ID             := lQry.FieldByName('PEDIDO_ID').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TCaixaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCaixaDao.Destroy;
begin

  inherited;
end;

function TCaixaDao.incluir(ACaixaModel: TCaixaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

lSQL :=   '       insert into caixa (numero_cai,                   '+SLineBreak+
          '                          codigo_cta,                   '+SLineBreak+
          '                          data_cai,                     '+SLineBreak+
          '                          hora_cai,                     '+SLineBreak+
          '                          historico_cai,                '+SLineBreak+
          '                          valor_cai,                    '+SLineBreak+
          '                          usuario_cai,                  '+SLineBreak+
          '                          tipo_cai,                     '+SLineBreak+
          '                          cliente_cai,                  '+SLineBreak+
          '                          numero_ped,                   '+SLineBreak+
          '                          fatura_cai,                   '+SLineBreak+
          '                          parcela_cai,                  '+SLineBreak+
          '                          status,                       '+SLineBreak+
          '                          portador_cai,                 '+SLineBreak+
          '                          conciliado_cai,               '+SLineBreak+
          '                          data_con,                     '+SLineBreak+
          '                          centro_custo,                 '+SLineBreak+
          '                          loja,                         '+SLineBreak+
          '                          recibo,                       '+SLineBreak+
          '                          relatorio,                    '+SLineBreak+
          '                          observacao,                   '+SLineBreak+
          '                          dr,                           '+SLineBreak+
          '                          troco,                        '+SLineBreak+
          '                          carga_id,                     '+SLineBreak+
          '                          tipo,                         '+SLineBreak+
          '                          sub_id,                       '+SLineBreak+
          '                          locacao_id,                   '+SLineBreak+
          '                          funcionario_id,               '+SLineBreak+
          '                          os_id,                        '+SLineBreak+
          '                          placa,                        '+SLineBreak+
          '                          transferencia_origem,         '+SLineBreak+
          '                          transferencia_id,             '+SLineBreak+
          '                          competencia,                  '+SLineBreak+
          '                          loja_remoto,                  '+SLineBreak+
          '                          pedido_id)                    '+SLineBreak+
          '       values (:numero_cai,                             '+SLineBreak+
          '               :codigo_cta,                             '+SLineBreak+
          '               :data_cai,                               '+SLineBreak+
          '               :hora_cai,                               '+SLineBreak+
          '               :historico_cai,                          '+SLineBreak+
          '               :valor_cai,                              '+SLineBreak+
          '               :usuario_cai,                            '+SLineBreak+
          '               :tipo_cai,                               '+SLineBreak+
          '               :cliente_cai,                            '+SLineBreak+
          '               :numero_ped,                             '+SLineBreak+
          '               :fatura_cai,                             '+SLineBreak+
          '               :parcela_cai,                            '+SLineBreak+
          '               :status,                                 '+SLineBreak+
          '               :portador_cai,                           '+SLineBreak+
          '               :conciliado_cai,                         '+SLineBreak+
          '               :data_con,                               '+SLineBreak+
          '               :centro_custo,                           '+SLineBreak+
          '               :loja,                                   '+SLineBreak+
          '               :recibo,                                 '+SLineBreak+
          '               :relatorio,                              '+SLineBreak+
          '               :observacao,                             '+SLineBreak+
          '               :dr,                                     '+SLineBreak+
          '               :troco,                                  '+SLineBreak+
          '               :carga_id,                               '+SLineBreak+
          '               :tipo,                                   '+SLineBreak+
          '               :sub_id,                                 '+SLineBreak+
          '               :locacao_id,                             '+SLineBreak+
          '               :funcionario_id,                         '+SLineBreak+
          '               :os_id,                                  '+SLineBreak+
          '               :placa,                                  '+SLineBreak+
          '               :transferencia_origem,                   '+SLineBreak+
          '               :transferencia_id,                       '+SLineBreak+
          '               :competencia,                            '+SLineBreak+
          '               :loja_remoto,                            '+SLineBreak+
          '               :pedido_id)                              '+SLineBreak+
          ' returning NUMERO_CAI                                   '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_cai').Value := vIConexao.Generetor('GEN_CAIXA');
    setParams(lQry, ACaixaModel);
    lQry.Open;

    Result := lQry.FieldByName('NUMERO_CAI').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaDao.alterar(ACaixaModel: TCaixaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := '    update caixa                                               '+SLineBreak+
          '       set codigo_cta = :codigo_cta,                           '+SLineBreak+
          '           data_cai = :data_cai,                               '+SLineBreak+
          '           hora_cai = :hora_cai,                               '+SLineBreak+
          '           historico_cai = :historico_cai,                     '+SLineBreak+
          '           valor_cai = :valor_cai,                             '+SLineBreak+
          '           usuario_cai = :usuario_cai,                         '+SLineBreak+
          '           tipo_cai = :tipo_cai,                               '+SLineBreak+
          '           cliente_cai = :cliente_cai,                         '+SLineBreak+
          '           numero_ped = :numero_ped,                           '+SLineBreak+
          '           fatura_cai = :fatura_cai,                           '+SLineBreak+
          '           parcela_cai = :parcela_cai,                         '+SLineBreak+
          '           status = :status,                                   '+SLineBreak+
          '           portador_cai = :portador_cai,                       '+SLineBreak+
          '           conciliado_cai = :conciliado_cai,                   '+SLineBreak+
          '           data_con = :data_con,                               '+SLineBreak+
          '           centro_custo = :centro_custo,                       '+SLineBreak+
          '           loja = :loja,                                       '+SLineBreak+
          '           recibo = :recibo,                                   '+SLineBreak+
          '           relatorio = :relatorio,                             '+SLineBreak+
          '           observacao = :observacao,                           '+SLineBreak+
          '           dr = :dr,                                           '+SLineBreak+
          '           troco = :troco,                                     '+SLineBreak+
          '           carga_id = :carga_id,                               '+SLineBreak+
          '           tipo = :tipo,                                       '+SLineBreak+
          '           sub_id = :sub_id,                                   '+SLineBreak+
          '           locacao_id = :locacao_id,                           '+SLineBreak+
          '           funcionario_id = :funcionario_id,                   '+SLineBreak+
          '           os_id = :os_id,                                     '+SLineBreak+
          '           placa = :placa,                                     '+SLineBreak+
          '           transferencia_origem = :transferencia_origem,       '+SLineBreak+
          '           transferencia_id = :transferencia_id,               '+SLineBreak+
          '           competencia = :competencia,                         '+SLineBreak+
          '           loja_remoto = :loja_remoto,                         '+SLineBreak+
          '           pedido_id = :pedido_id                              '+SLineBreak+
          '     where (numero_cai = :numero_cai)                          '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('numero_cai').Value := IIF(ACaixaModel.NUMERO_CAI = '', Unassigned, ACaixaModel.NUMERO_CAI);
    setParams(lQry, ACaixaModel);
    lQry.ExecSQL;

    Result := ACaixaModel.NUMERO_CAI;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCaixaDao.excluir(ACaixaModel: TCaixaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from caixa where numero_cai = :NUMERO_CAI',[ACaixaModel.NUMERO_CAI]);
   lQry.ExecSQL;
   Result := ACaixaModel.ID;

  finally
    lQry.Free;
  end;
end;

function TCaixaDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> '' then
    lSQL := lSQL + ' and caixa.numero_cai = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TCaixaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From caixa where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TCaixaDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FCaixasLista := TObjectList<TCaixaModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       caixa.*         '+
	    '  from caixa           '+
      ' where 1=1             ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FCaixasLista.Add(TCaixaModel.Create(vIConexao));

      i := FCaixasLista.Count -1;

      FCaixasLista[i].NUMERO_CAI           := lQry.FieldByName('NUMERO_CAI').AsString;
      FCaixasLista[i].CODIGO_CTA           := lQry.FieldByName('CODIGO_CTA').AsString;
      FCaixasLista[i].DATA_CAI             := lQry.FieldByName('DATA_CAI').AsString;
      FCaixasLista[i].HORA_CAI             := lQry.FieldByName('HORA_CAI').AsString;
      FCaixasLista[i].HISTORICO_CAI        := lQry.FieldByName('HISTORICO_CAI').AsString;
      FCaixasLista[i].VALOR_CAI            := lQry.FieldByName('VALOR_CAI').AsString;
      FCaixasLista[i].USUARIO_CAI          := lQry.FieldByName('USUARIO_CAI').AsString;
      FCaixasLista[i].TIPO_CAI             := lQry.FieldByName('TIPO_CAI').AsString;
      FCaixasLista[i].CLIENTE_CAI          := lQry.FieldByName('CLIENTE_CAI').AsString;
      FCaixasLista[i].NUMERO_PED           := lQry.FieldByName('NUMERO_PED').AsString;
      FCaixasLista[i].FATURA_CAI           := lQry.FieldByName('FATURA_CAI').AsString;
      FCaixasLista[i].PARCELA_CAI          := lQry.FieldByName('PARCELA_CAI').AsString;
      FCaixasLista[i].STATUS               := lQry.FieldByName('STATUS').AsString;
      FCaixasLista[i].PORTADOR_CAI         := lQry.FieldByName('PORTADOR_CAI').AsString;
      FCaixasLista[i].CONCILIADO_CAI       := lQry.FieldByName('CONCILIADO_CAI').AsString;
      FCaixasLista[i].DATA_CON             := lQry.FieldByName('DATA_CON').AsString;
      FCaixasLista[i].CENTRO_CUSTO         := lQry.FieldByName('CENTRO_CUSTO').AsString;
      FCaixasLista[i].LOJA                 := lQry.FieldByName('LOJA').AsString;
      FCaixasLista[i].RECIBO               := lQry.FieldByName('RECIBO').AsString;
      FCaixasLista[i].RELATORIO            := lQry.FieldByName('RELATORIO').AsString;
      FCaixasLista[i].OBSERVACAO           := lQry.FieldByName('OBSERVACAO').AsString;
      FCaixasLista[i].DR                   := lQry.FieldByName('DR').AsString;
      FCaixasLista[i].ID                   := lQry.FieldByName('ID').AsString;
      FCaixasLista[i].TROCO                := lQry.FieldByName('TROCO').AsString;
      FCaixasLista[i].CARGA_ID             := lQry.FieldByName('CARGA_ID').AsString;
      FCaixasLista[i].TIPO                 := lQry.FieldByName('TIPO').AsString;
      FCaixasLista[i].SUB_ID               := lQry.FieldByName('SUB_ID').AsString;
      FCaixasLista[i].LOCACAO_ID           := lQry.FieldByName('LOCACAO_ID').AsString;
      FCaixasLista[i].FUNCIONARIO_ID       := lQry.FieldByName('FUNCIONARIO_ID').AsString;
      FCaixasLista[i].OS_ID                := lQry.FieldByName('OS_ID').AsString;
      FCaixasLista[i].PLACA                := lQry.FieldByName('PLACA').AsString;
      FCaixasLista[i].TRANSFERENCIA_ORIGEM := lQry.FieldByName('TRANSFERENCIA_ORIGEM').AsString;
      FCaixasLista[i].TRANSFERENCIA_ID     := lQry.FieldByName('TRANSFERENCIA_ID').AsString;
      FCaixasLista[i].COMPETENCIA          := lQry.FieldByName('COMPETENCIA').AsString;
      FCaixasLista[i].SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
      FCaixasLista[i].LOJA_REMOTO          := lQry.FieldByName('LOJA_REMOTO').AsString;
      FCaixasLista[i].PEDIDO_ID            := lQry.FieldByName('PEDIDO_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TCaixaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCaixaDao.SetCaixasLista(const Value: TObjectList<TCaixaModel>);
begin
  FCaixasLista := Value;
end;

procedure TCaixaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;


procedure TCaixaDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TCaixaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCaixaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCaixaDao.setParams(var pQry: TFDQuery; pCaixaModel: TCaixaModel);
begin
  pQry.ParamByName('codigo_cta').Value           := IIF(pCaixaModel.CODIGO_CTA           = '', Unassigned, pCaixaModel.CODIGO_CTA);
  pQry.ParamByName('data_cai').Value             := IIF(pCaixaModel.DATA_CAI             = '', Unassigned, transformaDataFireBird(pCaixaModel.DATA_CAI));
  pQry.ParamByName('hora_cai').Value             := IIF(pCaixaModel.HORA_CAI             = '', Unassigned, pCaixaModel.HORA_CAI);
  pQry.ParamByName('historico_cai').Value        := IIF(pCaixaModel.HISTORICO_CAI        = '', Unassigned, pCaixaModel.HISTORICO_CAI);
  pQry.ParamByName('valor_cai').Value            := IIF(pCaixaModel.VALOR_CAI            = '', Unassigned, FormataFloatFireBird(pCaixaModel.VALOR_CAI));
  pQry.ParamByName('usuario_cai').Value          := IIF(pCaixaModel.USUARIO_CAI          = '', Unassigned, pCaixaModel.USUARIO_CAI);
  pQry.ParamByName('tipo_cai').Value             := IIF(pCaixaModel.TIPO_CAI             = '', Unassigned, pCaixaModel.TIPO_CAI);
  pQry.ParamByName('cliente_cai').Value          := IIF(pCaixaModel.CLIENTE_CAI          = '', Unassigned, pCaixaModel.CLIENTE_CAI);
  pQry.ParamByName('numero_ped').Value           := IIF(pCaixaModel.NUMERO_PED           = '', Unassigned, pCaixaModel.NUMERO_PED);
  pQry.ParamByName('fatura_cai').Value           := IIF(pCaixaModel.FATURA_CAI           = '', Unassigned, pCaixaModel.FATURA_CAI);
  pQry.ParamByName('parcela_cai').Value          := IIF(pCaixaModel.PARCELA_CAI          = '', Unassigned, pCaixaModel.PARCELA_CAI);
  pQry.ParamByName('status').Value               := IIF(pCaixaModel.STATUS               = '', Unassigned, pCaixaModel.STATUS);
  pQry.ParamByName('portador_cai').Value         := IIF(pCaixaModel.PORTADOR_CAI         = '', Unassigned, pCaixaModel.PORTADOR_CAI);
  pQry.ParamByName('conciliado_cai').Value       := IIF(pCaixaModel.CONCILIADO_CAI       = '', Unassigned, pCaixaModel.CONCILIADO_CAI);
  pQry.ParamByName('data_con').Value             := IIF(pCaixaModel.DATA_CON             = '', Unassigned, transformaDataFireBird(pCaixaModel.DATA_CON));
  pQry.ParamByName('centro_custo').Value         := IIF(pCaixaModel.CENTRO_CUSTO         = '', Unassigned, pCaixaModel.CENTRO_CUSTO);
  pQry.ParamByName('loja').Value                 := IIF(pCaixaModel.LOJA                 = '', Unassigned, pCaixaModel.LOJA);
  pQry.ParamByName('recibo').Value               := IIF(pCaixaModel.RECIBO               = '', Unassigned, pCaixaModel.RECIBO);
  pQry.ParamByName('relatorio').Value            := IIF(pCaixaModel.RELATORIO            = '', Unassigned, pCaixaModel.RELATORIO);
  pQry.ParamByName('observacao').Value           := IIF(pCaixaModel.OBSERVACAO           = '', Unassigned, pCaixaModel.OBSERVACAO);
  pQry.ParamByName('dr').Value                   := IIF(pCaixaModel.DR                   = '', Unassigned, pCaixaModel.DR);
  pQry.ParamByName('troco').Value                := IIF(pCaixaModel.TROCO                = '', Unassigned, pCaixaModel.TROCO);
  pQry.ParamByName('carga_id').Value             := IIF(pCaixaModel.CARGA_ID             = '', Unassigned, pCaixaModel.CARGA_ID);
  pQry.ParamByName('tipo').Value                 := IIF(pCaixaModel.TIPO                 = '', Unassigned, pCaixaModel.TIPO);
  pQry.ParamByName('sub_id').Value               := IIF(pCaixaModel.SUB_ID               = '', Unassigned, pCaixaModel.SUB_ID);
  pQry.ParamByName('locacao_id').Value           := IIF(pCaixaModel.LOCACAO_ID           = '', Unassigned, pCaixaModel.LOCACAO_ID);
  pQry.ParamByName('funcionario_id').Value       := IIF(pCaixaModel.FUNCIONARIO_ID       = '', Unassigned, pCaixaModel.FUNCIONARIO_ID);
  pQry.ParamByName('os_id').Value                := IIF(pCaixaModel.OS_ID                = '', Unassigned, pCaixaModel.OS_ID);
  pQry.ParamByName('placa').Value                := IIF(pCaixaModel.PLACA                = '', Unassigned, pCaixaModel.PLACA);
  pQry.ParamByName('transferencia_origem').Value := IIF(pCaixaModel.TRANSFERENCIA_ORIGEM = '', Unassigned, pCaixaModel.TRANSFERENCIA_ORIGEM);
  pQry.ParamByName('transferencia_id').Value     := IIF(pCaixaModel.TRANSFERENCIA_ID     = '', Unassigned, pCaixaModel.TRANSFERENCIA_ID);
  pQry.ParamByName('competencia').Value          := IIF(pCaixaModel.COMPETENCIA          = '', Unassigned, pCaixaModel.COMPETENCIA);
  pQry.ParamByName('loja_remoto').Value          := IIF(pCaixaModel.LOJA_REMOTO          = '', Unassigned, pCaixaModel.LOJA_REMOTO);
  pQry.ParamByName('pedido_id').Value            := IIF(pCaixaModel.PEDIDO_ID            = '', Unassigned, pCaixaModel.PEDIDO_ID);
end;

procedure TCaixaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCaixaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCaixaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
