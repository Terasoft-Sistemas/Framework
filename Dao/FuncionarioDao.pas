unit FuncionarioDao;

interface

uses
  FuncionarioModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao;

type
  TFuncionarioDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FFuncionariosLista: TObjectList<TFuncionarioModel>;
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
    procedure SetFuncionariosLista(const Value: TObjectList<TFuncionarioModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property FuncionariosLista: TObjectList<TFuncionarioModel> read FFuncionariosLista write SetFuncionariosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pFuncionarioModel: TFuncionarioModel);

    function where: String;
    function incluir(AFuncionarioModel: TFuncionarioModel): String;
    function alterar(AFuncionarioModel: TFuncionarioModel): String;
    function excluir(AFuncionarioModel: TFuncionarioModel): String;
    function comissaoVendedor(pIdVendedor, pIdTipoComissao: String): Double;
end;

implementation

{ TFuncionario }

function TFuncionarioDao.alterar(AFuncionarioModel: TFuncionarioModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIconexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('FUNCIONARIO','CODIGO_FUN');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('CODIGO_FUN').Value := AFuncionarioModel.CODIGO_FUN;
    setParams(lQry, AFuncionarioModel);
    lQry.ExecSQL;

    Result := AFuncionarioModel.CODIGO_FUN;

  finally
    lSQL := '';
    lQry.Free;

  end;
end;

function TFuncionarioDao.comissaoVendedor(pIdVendedor, pIdTipoComissao: String): Double;
var
  lQry: TFDQuery;
  lSQL: String;
begin
  try
    lQry     := vIConexao.CriarQuery;

    lSql := '  select distinct coalesce(comissao, 0) comissao  '+
            '    from comissao_vendedor                        '+
            '   where 1=1                                      ';

    lSql := lSql + ' and vendedor   = '+ QuotedStr(pIdVendedor);
    lSql := lSql + ' and tipo_venda = '+ QuotedStr(pIdTipoComissao);

    lQry.Open(lSQL);

    Result := lQry.FieldByName('comissao').AsFloat;

  finally
    lQry.Free;
  end;

end;

constructor TFuncionarioDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TFuncionarioDao.Destroy;
begin

  inherited;
end;

function TFuncionarioDao.excluir(AFuncionarioModel: TFuncionarioModel): String;
var
  lQry: TFDQuery;

begin

  lQry := vIconexao.CriarQuery;

  try
   lQry.ExecSQL('delete from FUNCIONARIO where CODIGO_FUN = :CODIGO_FUN',[AFuncionarioModel.CODIGO_FUN]);
   lQry.ExecSQL;
   Result := AFuncionarioModel.CODIGO_FUN;

  finally
    lQry.Free;
  end;
end;

function TFuncionarioDao.incluir(AFuncionarioModel: TFuncionarioModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIconexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('FUNCIONARIO', 'CODIGO_FUN', True);

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AFuncionarioModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_FUN').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TFuncionarioDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and FUNCIONARIO.CODIGO_FUN = '+ QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TFuncionarioDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From FUNCIONARIO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TFuncionarioDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FFuncionariosLista := TObjectList<TFuncionarioModel>.Create;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       funcionario.codigo_fun,     '+
      '       funcionario.nome_fun,       '+
      '       funcionario.gerente_id,     '+
      '       funcionario.tipo_comissao   '+
	    '  from funcionario                 '+
      ' where 1=1                         ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FFuncionariosLista.Add(TFuncionarioModel.Create(vIConexao));

      i := FFuncionariosLista.Count -1;

      FFuncionariosLista[i].CODIGO_FUN       := lQry.FieldByName('CODIGO_FUN').AsString;
      FFuncionariosLista[i].NOME_FUN         := lQry.FieldByName('NOME_FUN').AsString;
      FFuncionariosLista[i].GERENTE_ID       := lQry.FieldByName('GERENTE_ID').AsString;
      FFuncionariosLista[i].TIPO_COMISSAO    := lQry.FieldByName('TIPO_COMISSAO').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TFuncionarioDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFuncionarioDao.SetFuncionariosLista(const Value: TObjectList<TFuncionarioModel>);
begin
  FFuncionariosLista := Value;
end;

procedure TFuncionarioDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TFuncionarioDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TFuncionarioDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFuncionarioDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFuncionarioDao.setParams(var pQry: TFDQuery; pFuncionarioModel: TFuncionarioModel);

begin
    pQry.ParamByName('codigo_fun').Value                     := ifThen(pFuncionarioModel.codigo_fun						= '', Unassigned, pFuncionarioModel.CODIGO_FUN);
    pQry.ParamByName('nome_fun').Value                       := ifThen(pFuncionarioModel.nome_fun						  = '', Unassigned, pFuncionarioModel.NOME_FUN);
    pQry.ParamByName('end_fun').Value                        := ifThen(pFuncionarioModel.end_fun					  	= '', Unassigned, pFuncionarioModel.END_FUN);
    pQry.ParamByName('bai_fun').Value                        := ifThen(pFuncionarioModel.bai_fun					  	= '', Unassigned, pFuncionarioModel.BAI_FUN);
    pQry.ParamByName('cep_fun').Value                        := ifThen(pFuncionarioModel.cep_fun					  	= '', Unassigned, pFuncionarioModel.CEP_FUN);
    pQry.ParamByName('cid_fun').Value                        := ifThen(pFuncionarioModel.cid_fun					  	= '', Unassigned, pFuncionarioModel.CID_FUN);
    pQry.ParamByName('uf_fun').Value                         := ifThen(pFuncionarioModel.uf_fun					  		= '', Unassigned, pFuncionarioModel.UF_FUN);
    pQry.ParamByName('fon1_fun').Value                       := ifThen(pFuncionarioModel.fon1_fun				  		= '', Unassigned, pFuncionarioModel.FON1_FUN);
    pQry.ParamByName('cel_fun').Value                        := ifThen(pFuncionarioModel.cel_fun				  		= '', Unassigned, pFuncionarioModel.CEL_FUN);
    pQry.ParamByName('email_fun').Value                      := ifThen(pFuncionarioModel.email_fun						= '', Unassigned, pFuncionarioModel.EMAIL_FUN);
    pQry.ParamByName('cpf_fun').Value                        := ifThen(pFuncionarioModel.cpf_fun			  			= '', Unassigned, pFuncionarioModel.CPF_FUN);
    pQry.ParamByName('tipo_ven').Value                       := ifThen(pFuncionarioModel.tipo_ven			  			= '', Unassigned, pFuncionarioModel.TIPO_VEN);
    pQry.ParamByName('comis_fun').Value                      := ifThen(pFuncionarioModel.comis_fun						= '', Unassigned, pFuncionarioModel.COMIS_FUN);
    pQry.ParamByName('tecnico_fun').Value                    := ifThen(pFuncionarioModel.tecnico_fun					= '', Unassigned, pFuncionarioModel.TECNICO_FUN);
    pQry.ParamByName('desconto_fun').Value                   := ifThen(pFuncionarioModel.desconto_fun					= '', Unassigned, pFuncionarioModel.DESCONTO_FUN);
    pQry.ParamByName('status_fun').Value                     := ifThen(pFuncionarioModel.status_fun						= '', Unassigned, pFuncionarioModel.STATUS_FUN);
    pQry.ParamByName('cod_user').Value                       := ifThen(pFuncionarioModel.cod_user		  				= '', Unassigned, pFuncionarioModel.COD_USER);
    pQry.ParamByName('banco_fun').Value                      := ifThen(pFuncionarioModel.banco_fun						= '', Unassigned, pFuncionarioModel.BANCO_FUN);
    pQry.ParamByName('agencia_fun').Value                    := ifThen(pFuncionarioModel.agencia_fun					= '', Unassigned, pFuncionarioModel.AGENCIA_FUN);
    pQry.ParamByName('conta_fun').Value                      := ifThen(pFuncionarioModel.conta_fun						= '', Unassigned, pFuncionarioModel.CONTA_FUN);
    pQry.ParamByName('loja').Value                           := ifThen(pFuncionarioModel.loja				    			= '', Unassigned, pFuncionarioModel.LOJA);
    pQry.ParamByName('caixa').Value                          := ifThen(pFuncionarioModel.caixa			   				= '', Unassigned, pFuncionarioModel.CAIXA);
    pQry.ParamByName('funcao_fun').Value                     := ifThen(pFuncionarioModel.funcao_fun						= '', Unassigned, pFuncionarioModel.FUNCAO_FUN);
    pQry.ParamByName('nascimento_fun').Value                 := ifThen(pFuncionarioModel.nascimento_fun					= '', Unassigned, pFuncionarioModel.NASCIMENTO_FUN);
    pQry.ParamByName('admissao_fun').Value                   := ifThen(pFuncionarioModel.admissao_fun					= '', Unassigned, pFuncionarioModel.ADMISSAO_FUN);
    pQry.ParamByName('aso_fun').Value                        := ifThen(pFuncionarioModel.aso_fun			  			= '', Unassigned, pFuncionarioModel.ASO_FUN);
    pQry.ParamByName('escolaridade_fun').Value               := ifThen(pFuncionarioModel.escolaridade_fun				= '', Unassigned, pFuncionarioModel.ESCOLARIDADE_FUN);
    pQry.ParamByName('fone_recado_fun').Value                := ifThen(pFuncionarioModel.fone_recado_fun				= '', Unassigned, pFuncionarioModel.FONE_RECADO_FUN);
    pQry.ParamByName('venc_experiencia_fun').Value           := ifThen(pFuncionarioModel.venc_experiencia_fun			= '', Unassigned, pFuncionarioModel.VENC_EXPERIENCIA_FUN);
    pQry.ParamByName('data_exame_fun').Value                 := ifThen(pFuncionarioModel.data_exame_fun					= '', Unassigned, pFuncionarioModel.DATA_EXAME_FUN);
    pQry.ParamByName('data_venc_exame_fun').Value            := ifThen(pFuncionarioModel.data_venc_exame_fun			= '', Unassigned, pFuncionarioModel.DATA_VENC_EXAME_FUN);
    pQry.ParamByName('imagem_fun').Value                     := ifThen(pFuncionarioModel.imagem_fun						= '', Unassigned, pFuncionarioModel.IMAGEM_FUN);
    pQry.ParamByName('imagem2_fun').Value                    := ifThen(pFuncionarioModel.imagem2_fun					= '', Unassigned, pFuncionarioModel.IMAGEM2_FUN);
    pQry.ParamByName('diretorio_fun').Value                  := ifThen(pFuncionarioModel.diretorio_fun					= '', Unassigned, pFuncionarioModel.DIRETORIO_FUN);
    pQry.ParamByName('aso2_fun').Value                       := ifThen(pFuncionarioModel.aso2_fun			   			= '', Unassigned, pFuncionarioModel.ASO2_FUN);
    pQry.ParamByName('locacao_fun').Value                    := ifThen(pFuncionarioModel.locacao_fun					= '', Unassigned, pFuncionarioModel.LOCACAO_FUN);
    pQry.ParamByName('rg').Value                             := ifThen(pFuncionarioModel.rg								= '', Unassigned, pFuncionarioModel.RG);
    pQry.ParamByName('pis').Value                            := ifThen(pFuncionarioModel.pis							= '', Unassigned, pFuncionarioModel.PIS);
    pQry.ParamByName('id').Value                             := ifThen(pFuncionarioModel.id								= '', Unassigned, pFuncionarioModel.ID);
    pQry.ParamByName('salario').Value                        := ifThen(pFuncionarioModel.salario						= '', Unassigned, pFuncionarioModel.SALARIO);
    pQry.ParamByName('regiao_id').Value                      := ifThen(pFuncionarioModel.regiao_id						= '', Unassigned, pFuncionarioModel.REGIAO_ID);
    pQry.ParamByName('gerente').Value                        := ifThen(pFuncionarioModel.gerente						= '', Unassigned, pFuncionarioModel.GERENTE);
    pQry.ParamByName('gerente_id').Value                     := ifThen(pFuncionarioModel.gerente_id						= '', Unassigned, pFuncionarioModel.GERENTE_ID);
    pQry.ParamByName('motorista').Value                      := ifThen(pFuncionarioModel.motorista						= '', Unassigned, pFuncionarioModel.MOTORISTA);
    pQry.ParamByName('cor').Value                            := ifThen(pFuncionarioModel.cor							= '', Unassigned, pFuncionarioModel.COR);
    pQry.ParamByName('cabelo').Value                         := ifThen(pFuncionarioModel.cabelo							= '', Unassigned, pFuncionarioModel.CABELO);
    pQry.ParamByName('olho').Value                           := ifThen(pFuncionarioModel.olho							= '', Unassigned, pFuncionarioModel.OLHO);
    pQry.ParamByName('altura').Value                         := ifThen(pFuncionarioModel.altura							= '', Unassigned, pFuncionarioModel.ALTURA);
    pQry.ParamByName('peso').Value                           := ifThen(pFuncionarioModel.peso							= '', Unassigned, pFuncionarioModel.PESO);
    pQry.ParamByName('sinais').Value                         := ifThen(pFuncionarioModel.sinais							= '', Unassigned, pFuncionarioModel.SINAIS);
    pQry.ParamByName('obs_caracteristica').Value             := ifThen(pFuncionarioModel.obs_caracteristica				= '', Unassigned, pFuncionarioModel.OBS_CARACTERISTICA);
    pQry.ParamByName('estado_civil').Value                   := ifThen(pFuncionarioModel.estado_civil					= '', Unassigned, pFuncionarioModel.ESTADO_CIVIL);
    pQry.ParamByName('conjuge').Value                        := ifThen(pFuncionarioModel.conjuge						= '', Unassigned, pFuncionarioModel.CONJUGE);
    pQry.ParamByName('local_nascimento').Value               := ifThen(pFuncionarioModel.local_nascimento				= '', Unassigned, pFuncionarioModel.LOCAL_NASCIMENTO);
    pQry.ParamByName('nacionalidade').Value                  := ifThen(pFuncionarioModel.nacionalidade					= '', Unassigned, pFuncionarioModel.NACIONALIDADE);
    pQry.ParamByName('mae').Value                            := ifThen(pFuncionarioModel.mae							= '', Unassigned, pFuncionarioModel.MAE);
    pQry.ParamByName('nacionalidade_mae').Value              := ifThen(pFuncionarioModel.nacionalidade_mae				= '', Unassigned, pFuncionarioModel.NACIONALIDADE_MAE);
    pQry.ParamByName('pai').Value                            := ifThen(pFuncionarioModel.pai							= '', Unassigned, pFuncionarioModel.PAI);
    pQry.ParamByName('nacionalidade_pai').Value              := ifThen(pFuncionarioModel.nacionalidade_pai				= '', Unassigned, pFuncionarioModel.NACIONALIDADE_PAI);
    pQry.ParamByName('cbo').Value                            := ifThen(pFuncionarioModel.cbo							= '', Unassigned, pFuncionarioModel.CBO);
    pQry.ParamByName('matricula').Value                      := ifThen(pFuncionarioModel.matricula						= '', Unassigned, pFuncionarioModel.MATRICULA);
    pQry.ParamByName('tipo_salario').Value                   := ifThen(pFuncionarioModel.tipo_salario					= '', Unassigned, pFuncionarioModel.TIPO_SALARIO);
    pQry.ParamByName('secao').Value                          := ifThen(pFuncionarioModel.secao							= '', Unassigned, pFuncionarioModel.SECAO);
    pQry.ParamByName('quadro_horario').Value                 := ifThen(pFuncionarioModel.quadro_horario					= '', Unassigned, pFuncionarioModel.QUADRO_HORARIO);
    pQry.ParamByName('carteira_trabalho').Value              := ifThen(pFuncionarioModel.carteira_trabalho				= '', Unassigned, pFuncionarioModel.CARTEIRA_TRABALHO);
    pQry.ParamByName('emissor_rg').Value                     := ifThen(pFuncionarioModel.emissor_rg						= '', Unassigned, pFuncionarioModel.EMISSOR_RG);
    pQry.ParamByName('uf_rg').Value                          := ifThen(pFuncionarioModel.uf_rg							= '', Unassigned, pFuncionarioModel.UF_RG);
    pQry.ParamByName('carteira_reservista').Value            := ifThen(pFuncionarioModel.carteira_reservista			= '', Unassigned, pFuncionarioModel.CARTEIRA_RESERVISTA);
    pQry.ParamByName('categoria_reservista').Value           := ifThen(pFuncionarioModel.categoria_reservista			= '', Unassigned, pFuncionarioModel.CATEGORIA_RESERVISTA);
    pQry.ParamByName('titulo_eleitor').Value                 := ifThen(pFuncionarioModel.titulo_eleitor					= '', Unassigned, pFuncionarioModel.TITULO_ELEITOR);
    pQry.ParamByName('cnh').Value                            := ifThen(pFuncionarioModel.cnh							= '', Unassigned, pFuncionarioModel.CNH);
    pQry.ParamByName('categoria_cnh').Value                  := ifThen(pFuncionarioModel.categoria_cnh					= '', Unassigned, pFuncionarioModel.CATEGORIA_CNH);
    pQry.ParamByName('fgts').Value                           := ifThen(pFuncionarioModel.fgts							= '', Unassigned, pFuncionarioModel.FGTS);
    pQry.ParamByName('fgts_data').Value                      := ifThen(pFuncionarioModel.fgts_data						= '', Unassigned, pFuncionarioModel.FGTS_DATA);
    pQry.ParamByName('fgts_retratacao').Value                := ifThen(pFuncionarioModel.fgts_retratacao				= '', Unassigned, pFuncionarioModel.FGTS_RETRATACAO);
    pQry.ParamByName('fgts_banco').Value                     := ifThen(pFuncionarioModel.fgts_banco						= '', Unassigned, pFuncionarioModel.FGTS_BANCO);
    pQry.ParamByName('demitido').Value                       := ifThen(pFuncionarioModel.demitido						= '', Unassigned, pFuncionarioModel.DEMITIDO);
    pQry.ParamByName('causa_demissao').Value                 := ifThen(pFuncionarioModel.causa_demissao					= '', Unassigned, pFuncionarioModel.CAUSA_DEMISSAO);
    pQry.ParamByName('sms').Value                            := ifThen(pFuncionarioModel.sms							= '', Unassigned, pFuncionarioModel.SMS);
    pQry.ParamByName('email').Value                          := ifThen(pFuncionarioModel.email							= '', Unassigned, pFuncionarioModel.EMAIL);
    pQry.ParamByName('qtde_vale_transporte').Value           := ifThen(pFuncionarioModel.qtde_vale_transporte			= '', Unassigned, pFuncionarioModel.QTDE_VALE_TRANSPORTE);
    pQry.ParamByName('valor_vale_transporte').Value          := ifThen(pFuncionarioModel.valor_vale_transporte			= '', Unassigned, pFuncionarioModel.VALOR_VALE_TRANSPORTE);
    pQry.ParamByName('agenda').Value                         := ifThen(pFuncionarioModel.agenda							= '', Unassigned, pFuncionarioModel.AGENDA);
    pQry.ParamByName('email_host').Value                     := ifThen(pFuncionarioModel.email_host						= '', Unassigned, pFuncionarioModel.EMAIL_HOST);
    pQry.ParamByName('email_endereco').Value                 := ifThen(pFuncionarioModel.email_endereco					= '', Unassigned, pFuncionarioModel.EMAIL_ENDERECO);
    pQry.ParamByName('email_senha').Value                    := ifThen(pFuncionarioModel.email_senha					= '', Unassigned, pFuncionarioModel.EMAIL_SENHA);
    pQry.ParamByName('email_porta').Value                    := ifThen(pFuncionarioModel.email_porta					= '', Unassigned, pFuncionarioModel.EMAIL_PORTA);
    pQry.ParamByName('email_nome').Value                     := ifThen(pFuncionarioModel.email_nome						= '', Unassigned, pFuncionarioModel.EMAIL_NOME);
    pQry.ParamByName('email_ssl').Value                      := ifThen(pFuncionarioModel.email_ssl						= '', Unassigned, pFuncionarioModel.EMAIL_SSL);
    pQry.ParamByName('email_smtp').Value                     := ifThen(pFuncionarioModel.email_smtp						= '', Unassigned, pFuncionarioModel.EMAIL_SMTP);
    pQry.ParamByName('tipo').Value                           := ifThen(pFuncionarioModel.tipo							= '', Unassigned, pFuncionarioModel.TIPO);
    pQry.ParamByName('representante').Value                  := ifThen(pFuncionarioModel.representante					= '', Unassigned, pFuncionarioModel.REPRESENTANTE);
    pQry.ParamByName('email_resposta').Value                 := ifThen(pFuncionarioModel.email_resposta					= '', Unassigned, pFuncionarioModel.EMAIL_RESPOSTA);
    pQry.ParamByName('atalhos_web').Value                    := ifThen(pFuncionarioModel.atalhos_web					= '', Unassigned, pFuncionarioModel.ATALHOS_WEB);
    pQry.ParamByName('nome_completo').Value                  := ifThen(pFuncionarioModel.nome_completo					= '', Unassigned, pFuncionarioModel.NOME_COMPLETO);
    pQry.ParamByName('contato').Value                        := ifThen(pFuncionarioModel.contato						= '', Unassigned, pFuncionarioModel.CONTATO);
    pQry.ParamByName('venc_experiencia_prorrogado').Value    := ifThen(pFuncionarioModel.venc_experiencia_prorrogado	= '', Unassigned, pFuncionarioModel.VENC_EXPERIENCIA_PRORROGADO);
    pQry.ParamByName('loja_id').Value                        := ifThen(pFuncionarioModel.loja_id						= '', Unassigned, pFuncionarioModel.LOJA_ID);
    pQry.ParamByName('complemento').Value                    := ifThen(pFuncionarioModel.complemento					= '', Unassigned, pFuncionarioModel.COMPLEMENTO);
    pQry.ParamByName('clt').Value                            := ifThen(pFuncionarioModel.clt							= '', Unassigned, pFuncionarioModel.CLT);
    pQry.ParamByName('tipo_comissao').Value                  := ifThen(pFuncionarioModel.tipo_comissao					= '', Unassigned, pFuncionarioModel.TIPO_COMISSAO);
    pQry.ParamByName('dia_fechamento_comissao').Value        := ifThen(pFuncionarioModel.dia_fechamento_comissao		= '', Unassigned, pFuncionarioModel.DIA_FECHAMENTO_COMISSAO);
    pQry.ParamByName('tempo_tarefa').Value                   := ifThen(pFuncionarioModel.tempo_tarefa					= '', Unassigned, pFuncionarioModel.TEMPO_TAREFA);
    pQry.ParamByName('data_rg').Value                        := ifThen(pFuncionarioModel.data_rg						= '', Unassigned, pFuncionarioModel.DATA_RG);
    pQry.ParamByName('codigo_anterior').Value                := ifThen(pFuncionarioModel.codigo_anterior				= '', Unassigned, pFuncionarioModel.CODIGO_ANTERIOR);
    pQry.ParamByName('menu_web').Value                       := ifThen(pFuncionarioModel.menu_web						= '', Unassigned, pFuncionarioModel.MENU_WEB);
    pQry.ParamByName('systime').Value                        := ifThen(pFuncionarioModel.systime						= '', Unassigned, pFuncionarioModel.SYSTIME);
    pQry.ParamByName('montador').Value                       := ifThen(pFuncionarioModel.montador						= '', Unassigned, pFuncionarioModel.MONTADOR);
    pQry.ParamByName('comissao_montador').Value              := ifThen(pFuncionarioModel.comissao_montador				= '', Unassigned, pFuncionarioModel.COMISSAO_MONTADOR);
    pQry.ParamByName('msg_finalizar_tarefa').Value           := ifThen(pFuncionarioModel.msg_finalizar_tarefa			= '', Unassigned, pFuncionarioModel.MSG_FINALIZAR_TAREFA);
    pQry.ParamByName('tipo_estoque').Value                   := ifThen(pFuncionarioModel.tipo_estoque					= '', Unassigned, pFuncionarioModel.TIPO_ESTOQUE);

end;

procedure TFuncionarioDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TFuncionarioDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TFuncionarioDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
