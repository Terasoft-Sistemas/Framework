unit BancoDao;

interface

uses
  BancoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao;

type
  TBancoDao = class

  private
    vIConexao : Iconexao;
    vConstrutor : TConstrutorDao;

    FBancosLista: TObjectList<TBancoModel>;
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
    procedure SetBancosLista(const Value: TObjectList<TBancoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    constructor Create(pIConexao : Iconexao);
    destructor Destroy; override;

    property BancosLista: TObjectList<TBancoModel> read FBancosLista write SetBancosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(ABancoModel: TBancoModel): String;
    function alterar(ABancoModel: TBancoModel): String;
    function excluir(ABancoModel: TBancoModel): String;
	
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pBancoModel: TBancoModel);

end;

implementation

{ TBanco }

constructor TBancoDao.Create(pIConexao : Iconexao);
begin
  vIconexao := pIconexao;
  vConstrutor := TConstrutorDao.Create(vIconexao);
end;

destructor TBancoDao.Destroy;
begin

  inherited;
end;

function TBancoDao.incluir(ABancoModel: TBancoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIconexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('BANCO', 'ID', True);

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('NUMERO_BAN').Value := vIconexao.Generetor('GEN_BANCO');
    setParams(lQry, ABancoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TBancoDao.alterar(ABancoModel: TBancoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIconexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('BANCO','ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('NUMERO_BAN').Value := ABancoModel.numero_ban;
    setParams(lQry, ABancoModel);
    lQry.ExecSQL;

    Result := ABancoModel.ID;

  finally
    lSQL := '';
    lQry.Free;

  end;
end;

function TBancoDao.excluir(ABancoModel: TBancoModel): String;
var
  lQry: TFDQuery;

begin

  lQry := vIconexao.CriarQuery;

  try
   lQry.ExecSQL('delete from BANCO where ID = :ID',[ABancoModel.ID]);
   lQry.ExecSQL;
   Result := ABancoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TBancoDao.where: String;
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

procedure TBancoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;

begin
  try

    lQry := vIconexao.CriarQuery;

    lSql := 'select count(*) records From banco where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TBancoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;

begin

  lQry := vIconexao.CriarQuery;

  FBancosLista := TObjectList<TBancoModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       banco.*           '+
	    '  from banco             '+
      ' where 1=1               ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FBancosLista.Add(TBancoModel.Create(vIConexao));

      i := FBancosLista.Count -1;

      FBancosLista[i].NUMERO_BAN                    := lQry.FieldByName('NUMERO_BAN').AsString;
      FBancosLista[i].NOME_BAN                      := lQry.FieldByName('NOME_BAN').AsString;
      FBancosLista[i].AGENCIA_BAN                   := lQry.FieldByName('AGENCIA_BAN').AsString;
      FBancosLista[i].CONTA_BAN                     := lQry.FieldByName('CONTA_BAN').AsString;
      FBancosLista[i].CONTATO_BAN                   := lQry.FieldByName('CONTATO_BAN').AsString;
      FBancosLista[i].TELEFONE_BAN                  := lQry.FieldByName('TELEFONE_BAN').AsString;
      FBancosLista[i].USUARIO_BAN                   := lQry.FieldByName('USUARIO_BAN').AsString;
      FBancosLista[i].DIGAGENCIA_BAN                := lQry.FieldByName('DIGAGENCIA_BAN').AsString;
      FBancosLista[i].DIGCONTA_BAN                  := lQry.FieldByName('DIGCONTA_BAN').AsString;
      FBancosLista[i].NUM_BAN                       := lQry.FieldByName('NUM_BAN').AsString;
      FBancosLista[i].CODIGO_CEDENTE                := lQry.FieldByName('CODIGO_CEDENTE').AsString;
      FBancosLista[i].LICENCA                       := lQry.FieldByName('LICENCA').AsString;
      FBancosLista[i].LAYOUT_RETORNO                := lQry.FieldByName('LAYOUT_RETORNO').AsString;
      FBancosLista[i].LAYOUT_REMESSA                := lQry.FieldByName('LAYOUT_REMESSA').AsString;
      FBancosLista[i].CAMINHO_RETORNO               := lQry.FieldByName('CAMINHO_RETORNO').AsString;
      FBancosLista[i].CAMINHO_REMESSA               := lQry.FieldByName('CAMINHO_REMESSA').AsString;
      FBancosLista[i].LIMITE_BAN                    := lQry.FieldByName('LIMITE_BAN').AsString;
      FBancosLista[i].ID                            := lQry.FieldByName('ID').AsString;
      FBancosLista[i].VALOR_BOLETO                  := lQry.FieldByName('VALOR_BOLETO').AsString;
      FBancosLista[i].DESPESA_BOLETO_CONTA_ID       := lQry.FieldByName('DESPESA_BOLETO_CONTA_ID').AsString;
      FBancosLista[i].CODIGO_CEDENTE2               := lQry.FieldByName('CODIGO_CEDENTE2').AsString;
      FBancosLista[i].OUTRAS_CONFIGURACOES          := lQry.FieldByName('OUTRAS_CONFIGURACOES').AsString;
      FBancosLista[i].LOJA                          := lQry.FieldByName('LOJA').AsString;
      FBancosLista[i].TIPO_IMPRESSAO                := lQry.FieldByName('TIPO_IMPRESSAO').AsString;
      FBancosLista[i].LIMITE_TROCA                  := lQry.FieldByName('LIMITE_TROCA').AsString;
      FBancosLista[i].STATUS                        := lQry.FieldByName('STATUS').AsString;
      FBancosLista[i].OUTRAS_CONFIGURACOES2         := lQry.FieldByName('OUTRAS_CONFIGURACOES2').AsString;
      FBancosLista[i].DIAS_PROTESTO_DEVOLUCAO       := lQry.FieldByName('DIAS_PROTESTO_DEVOLUCAO').AsString;
      FBancosLista[i].CODIGO_PROTESTO_DEVOLUCAO     := lQry.FieldByName('CODIGO_PROTESTO_DEVOLUCAO').AsString;
      FBancosLista[i].CONTA_APLICACAO               := lQry.FieldByName('CONTA_APLICACAO').AsString;
      FBancosLista[i].LOCAL_PAGAMENTO               := lQry.FieldByName('LOCAL_PAGAMENTO').AsString;
      FBancosLista[i].BANCO_REFERENTE               := lQry.FieldByName('BANCO_REFERENTE').AsString;
      FBancosLista[i].DETALHAMENTO_REMESSA          := lQry.FieldByName('DETALHAMENTO_REMESSA').AsString;
      FBancosLista[i].URL_ATUALIZACAO_BOLETO        := lQry.FieldByName('URL_ATUALIZACAO_BOLETO').AsString;
      FBancosLista[i].ATUALIZAR_BOLETO              := lQry.FieldByName('ATUALIZAR_BOLETO').AsString;
      FBancosLista[i].DRG                           := lQry.FieldByName('DRG').AsString;
      FBancosLista[i].PERSONALIZACAO_BOLETO         := lQry.FieldByName('PERSONALIZACAO_BOLETO').AsString;
      FBancosLista[i].SEQUENCIA_REMESSA_PAGAMENTO   := lQry.FieldByName('SEQUENCIA_REMESSA_PAGAMENTO').AsString;
      FBancosLista[i].CODIGO_CONVENIO_PAGAMENTO     := lQry.FieldByName('CODIGO_CONVENIO_PAGAMENTO').AsString;
      FBancosLista[i].CAMINHO_RETORNO_PAGAMENTO     := lQry.FieldByName('CAMINHO_RETORNO_PAGAMENTO').AsString;
      FBancosLista[i].CAMINHO_REMESSA_PAGAMENTO     := lQry.FieldByName('CAMINHO_REMESSA_PAGAMENTO').AsString;
      FBancosLista[i].CONTA_JUROS_ANTECIPACAO       := lQry.FieldByName('CONTA_JUROS_ANTECIPACAO').AsString;
      FBancosLista[i].CONTA_IOF_ANTECIPACAO         := lQry.FieldByName('CONTA_IOF_ANTECIPACAO').AsString;
      FBancosLista[i].CONTA_ESTORNO_ANTECIPACAO     := lQry.FieldByName('CONTA_ESTORNO_ANTECIPACAO').AsString;
      FBancosLista[i].SYSTIME                       := lQry.FieldByName('SYSTIME').AsString;
      FBancosLista[i].TIPO_COBRANCA                 := lQry.FieldByName('TIPO_COBRANCA').AsString;
      FBancosLista[i].DEVELOPER_APPLICATION_KEY     := lQry.FieldByName('DEVELOPER_APPLICATION_KEY').AsString;
      FBancosLista[i].CLIENT_ID                     := lQry.FieldByName('CLIENT_ID').AsString;
      FBancosLista[i].CLIENT_SECRET                 := lQry.FieldByName('CLIENT_SECRET').AsString;
      FBancosLista[i].FANTASIA                      := lQry.FieldByName('FANTASIA').AsString;
      FBancosLista[i].RAZAO                         := lQry.FieldByName('RAZAO').AsString;
      FBancosLista[i].CNPJ                          := lQry.FieldByName('CNPJ').AsString;
      FBancosLista[i].ENDERECO                      := lQry.FieldByName('ENDERECO').AsString;
      FBancosLista[i].BAIRRO                        := lQry.FieldByName('BAIRRO').AsString;
      FBancosLista[i].CIDADE                        := lQry.FieldByName('CIDADE').AsString;
      FBancosLista[i].UF                            := lQry.FieldByName('UF').AsString;
      FBancosLista[i].CEP                           := lQry.FieldByName('CEP').AsString;
      FBancosLista[i].TELEFONE                      := lQry.FieldByName('TELEFONE').AsString;
      FBancosLista[i].TIPO_EMITENTE                 := lQry.FieldByName('TIPO_EMITENTE').AsString;
      FBancosLista[i].INDICADORPIX                  := lQry.FieldByName('INDICADORPIX').AsString;
      FBancosLista[i].CONVENIO                      := lQry.FieldByName('CONVENIO').AsString;
      FBancosLista[i].MODALIDADE                    := lQry.FieldByName('MODALIDADE').AsString;
      FBancosLista[i].CODIGOTRANSMISSAO             := lQry.FieldByName('CODIGOTRANSMISSAO').AsString;
      FBancosLista[i].SCOPE                         := lQry.FieldByName('SCOPE').AsString;
      FBancosLista[i].CARACTERISTICA_TITULO         := lQry.FieldByName('CARACTERISTICA_TITULO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TBancoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TBancoDao.SetBancosLista(const Value: TObjectList<TBancoModel>);
begin
  FBancosLista := Value;
end;

procedure TBancoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TBancoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TBancoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TBancoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TBancoDao.setParams(var pQry: TFDQuery; pBancoModel: TBancoModel);
begin
  pQry.ParamByName('nome_ban').Value                      := ifThen(pBancoModel.NOME_BAN                      = '', Unassigned, pBancoModel.NOME_BAN);
  pQry.ParamByName('agencia_ban').Value                   := ifThen(pBancoModel.AGENCIA_BAN                   = '', Unassigned, pBancoModel.AGENCIA_BAN);
  pQry.ParamByName('conta_ban').Value                     := ifThen(pBancoModel.CONTA_BAN                     = '', Unassigned, pBancoModel.CONTA_BAN);
  pQry.ParamByName('contato_ban').Value                   := ifThen(pBancoModel.CONTATO_BAN                   = '', Unassigned, pBancoModel.CONTATO_BAN);
  pQry.ParamByName('telefone_ban').Value                  := ifThen(pBancoModel.TELEFONE_BAN                  = '', Unassigned, pBancoModel.TELEFONE_BAN);
  pQry.ParamByName('usuario_ban').Value                   := ifThen(pBancoModel.USUARIO_BAN                   = '', Unassigned, pBancoModel.USUARIO_BAN);
  pQry.ParamByName('digagencia_ban').Value                := ifThen(pBancoModel.DIGAGENCIA_BAN                = '', Unassigned, pBancoModel.DIGAGENCIA_BAN);
  pQry.ParamByName('digconta_ban').Value                  := ifThen(pBancoModel.DIGCONTA_BAN                  = '', Unassigned, pBancoModel.DIGCONTA_BAN);
  pQry.ParamByName('num_ban').Value                       := ifThen(pBancoModel.NUM_BAN                       = '', Unassigned, pBancoModel.NUM_BAN);
  pQry.ParamByName('codigo_cedente').Value                := ifThen(pBancoModel.CODIGO_CEDENTE                = '', Unassigned, pBancoModel.CODIGO_CEDENTE);
  pQry.ParamByName('licenca').Value                       := ifThen(pBancoModel.LICENCA                       = '', Unassigned, pBancoModel.LICENCA);
  pQry.ParamByName('layout_retorno').Value                := ifThen(pBancoModel.LAYOUT_RETORNO                = '', Unassigned, pBancoModel.LAYOUT_RETORNO);
  pQry.ParamByName('layout_remessa').Value                := ifThen(pBancoModel.LAYOUT_REMESSA                = '', Unassigned, pBancoModel.LAYOUT_REMESSA);
  pQry.ParamByName('caminho_retorno').Value               := ifThen(pBancoModel.CAMINHO_RETORNO               = '', Unassigned, pBancoModel.CAMINHO_RETORNO);
  pQry.ParamByName('caminho_remessa').Value               := ifThen(pBancoModel.CAMINHO_REMESSA               = '', Unassigned, pBancoModel.CAMINHO_REMESSA);
  pQry.ParamByName('limite_ban').Value                    := ifThen(pBancoModel.LIMITE_BAN                    = '', Unassigned, pBancoModel.LIMITE_BAN);
  pQry.ParamByName('valor_boleto').Value                  := ifThen(pBancoModel.VALOR_BOLETO                  = '', Unassigned, pBancoModel.VALOR_BOLETO);
  pQry.ParamByName('despesa_boleto_conta_id').Value       := ifThen(pBancoModel.DESPESA_BOLETO_CONTA_ID       = '', Unassigned, pBancoModel.DESPESA_BOLETO_CONTA_ID);
  pQry.ParamByName('codigo_cedente2').Value               := ifThen(pBancoModel.CODIGO_CEDENTE2               = '', Unassigned, pBancoModel.CODIGO_CEDENTE2);
  pQry.ParamByName('outras_configuracoes').Value          := ifThen(pBancoModel.OUTRAS_CONFIGURACOES          = '', Unassigned, pBancoModel.OUTRAS_CONFIGURACOES);
  pQry.ParamByName('loja').Value                          := ifThen(pBancoModel.LOJA                          = '', Unassigned, pBancoModel.LOJA);
  pQry.ParamByName('tipo_impressao').Value                := ifThen(pBancoModel.TIPO_IMPRESSAO                = '', Unassigned, pBancoModel.TIPO_IMPRESSAO);
  pQry.ParamByName('limite_troca').Value                  := ifThen(pBancoModel.LIMITE_TROCA                  = '', Unassigned, pBancoModel.LIMITE_TROCA);
  pQry.ParamByName('status').Value                        := ifThen(pBancoModel.STATUS                        = '', Unassigned, pBancoModel.STATUS);
  pQry.ParamByName('outras_configuracoes2').Value         := ifThen(pBancoModel.OUTRAS_CONFIGURACOES2         = '', Unassigned, pBancoModel.OUTRAS_CONFIGURACOES2);
  pQry.ParamByName('dias_protesto_devolucao').Value       := ifThen(pBancoModel.DIAS_PROTESTO_DEVOLUCAO       = '', Unassigned, pBancoModel.DIAS_PROTESTO_DEVOLUCAO);
  pQry.ParamByName('codigo_protesto_devolucao').Value     := ifThen(pBancoModel.CODIGO_PROTESTO_DEVOLUCAO     = '', Unassigned, pBancoModel.CODIGO_PROTESTO_DEVOLUCAO);
  pQry.ParamByName('conta_aplicacao').Value               := ifThen(pBancoModel.CONTA_APLICACAO               = '', Unassigned, pBancoModel.CONTA_APLICACAO);
  pQry.ParamByName('local_pagamento').Value               := ifThen(pBancoModel.LOCAL_PAGAMENTO               = '', Unassigned, pBancoModel.LOCAL_PAGAMENTO);
  pQry.ParamByName('banco_referente').Value               := ifThen(pBancoModel.BANCO_REFERENTE               = '', Unassigned, pBancoModel.BANCO_REFERENTE);
  pQry.ParamByName('detalhamento_remessa').Value          := ifThen(pBancoModel.DETALHAMENTO_REMESSA          = '', Unassigned, pBancoModel.DETALHAMENTO_REMESSA);
  pQry.ParamByName('url_atualizacao_boleto').Value        := ifThen(pBancoModel.URL_ATUALIZACAO_BOLETO        = '', Unassigned, pBancoModel.URL_ATUALIZACAO_BOLETO);
  pQry.ParamByName('atualizar_boleto').Value              := ifThen(pBancoModel.ATUALIZAR_BOLETO              = '', Unassigned, pBancoModel.ATUALIZAR_BOLETO);
  pQry.ParamByName('drg').Value                           := ifThen(pBancoModel.DRG                           = '', Unassigned, pBancoModel.DRG);
  pQry.ParamByName('personalizacao_boleto').Value         := ifThen(pBancoModel.PERSONALIZACAO_BOLETO         = '', Unassigned, pBancoModel.PERSONALIZACAO_BOLETO);
  pQry.ParamByName('sequencia_remessa_pagamento').Value   := ifThen(pBancoModel.SEQUENCIA_REMESSA_PAGAMENTO   = '', Unassigned, pBancoModel.SEQUENCIA_REMESSA_PAGAMENTO);
  pQry.ParamByName('codigo_convenio_pagamento').Value     := ifThen(pBancoModel.CODIGO_CONVENIO_PAGAMENTO     = '', Unassigned, pBancoModel.CODIGO_CONVENIO_PAGAMENTO);
  pQry.ParamByName('caminho_retorno_pagamento').Value     := ifThen(pBancoModel.CAMINHO_RETORNO_PAGAMENTO     = '', Unassigned, pBancoModel.CAMINHO_RETORNO_PAGAMENTO);
  pQry.ParamByName('caminho_remessa_pagamento').Value     := ifThen(pBancoModel.CAMINHO_REMESSA_PAGAMENTO     = '', Unassigned, pBancoModel.CAMINHO_REMESSA_PAGAMENTO);
  pQry.ParamByName('conta_juros_antecipacao').Value       := ifThen(pBancoModel.CONTA_JUROS_ANTECIPACAO       = '', Unassigned, pBancoModel.CONTA_JUROS_ANTECIPACAO);
  pQry.ParamByName('conta_iof_antecipacao').Value         := ifThen(pBancoModel.CONTA_IOF_ANTECIPACAO         = '', Unassigned, pBancoModel.CONTA_IOF_ANTECIPACAO);
  pQry.ParamByName('conta_estorno_antecipacao').Value     := ifThen(pBancoModel.CONTA_ESTORNO_ANTECIPACAO     = '', Unassigned, pBancoModel.CONTA_ESTORNO_ANTECIPACAO);
  pQry.ParamByName('tipo_cobranca').Value                 := ifThen(pBancoModel.TIPO_COBRANCA                 = '', Unassigned, pBancoModel.TIPO_COBRANCA);
  pQry.ParamByName('developer_application_key').Value     := ifThen(pBancoModel.DEVELOPER_APPLICATION_KEY     = '', Unassigned, pBancoModel.DEVELOPER_APPLICATION_KEY);
  pQry.ParamByName('client_id').Value                     := ifThen(pBancoModel.CLIENT_ID                     = '', Unassigned, pBancoModel.CLIENT_ID);
  pQry.ParamByName('client_secret').Value                 := ifThen(pBancoModel.CLIENT_SECRET                 = '', Unassigned, pBancoModel.CLIENT_SECRET);
  pQry.ParamByName('fantasia').Value                      := ifThen(pBancoModel.FANTASIA                      = '', Unassigned, pBancoModel.FANTASIA);
  pQry.ParamByName('razao').Value                         := ifThen(pBancoModel.RAZAO                         = '', Unassigned, pBancoModel.RAZAO);
  pQry.ParamByName('cnpj').Value                          := ifThen(pBancoModel.CNPJ                          = '', Unassigned, pBancoModel.CNPJ);
  pQry.ParamByName('endereco').Value                      := ifThen(pBancoModel.ENDERECO                      = '', Unassigned, pBancoModel.ENDERECO);
  pQry.ParamByName('bairro').Value                        := ifThen(pBancoModel.BAIRRO                        = '', Unassigned, pBancoModel.BAIRRO);
  pQry.ParamByName('cidade').Value                        := ifThen(pBancoModel.CIDADE                        = '', Unassigned, pBancoModel.CIDADE);
  pQry.ParamByName('uf').Value                            := ifThen(pBancoModel.UF                            = '', Unassigned, pBancoModel.UF);
  pQry.ParamByName('cep').Value                           := ifThen(pBancoModel.CEP                           = '', Unassigned, pBancoModel.CEP);
  pQry.ParamByName('telefone').Value                      := ifThen(pBancoModel.TELEFONE                      = '', Unassigned, pBancoModel.TELEFONE);
  pQry.ParamByName('tipo_emitente').Value                 := ifThen(pBancoModel.TIPO_EMITENTE                 = '', Unassigned, pBancoModel.TIPO_EMITENTE);
  pQry.ParamByName('indicadorpix').Value                  := ifThen(pBancoModel.INDICADORPIX                  = '', Unassigned, pBancoModel.INDICADORPIX);
  pQry.ParamByName('convenio').Value                      := ifThen(pBancoModel.CONVENIO                      = '', Unassigned, pBancoModel.CONVENIO);
  pQry.ParamByName('modalidade').Value                    := ifThen(pBancoModel.MODALIDADE                    = '', Unassigned, pBancoModel.MODALIDADE);
  pQry.ParamByName('codigotransmissao').Value             := ifThen(pBancoModel.CODIGOTRANSMISSAO             = '', Unassigned, pBancoModel.CODIGOTRANSMISSAO);
  pQry.ParamByName('scope').Value                         := ifThen(pBancoModel.SCOPE                         = '', Unassigned, pBancoModel.SCOPE);
  pQry.ParamByName('caracteristica_titulo').Value         := ifThen(pBancoModel.CARACTERISTICA_TITULO         = '', Unassigned, pBancoModel.CARACTERISTICA_TITULO);
end;

procedure TBancoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TBancoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TBancoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
