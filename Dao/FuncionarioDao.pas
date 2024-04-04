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
  Terasoft.Utils,
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
    function carregaClasse(pId: String): TFuncionarioModel;
end;

implementation

uses
  System.Rtti;

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
    setParams(lQry, AFuncionarioModel);
    lQry.ExecSQL;

    Result := AFuncionarioModel.CODIGO_FUN;

  finally
    lSQL := '';
    lQry.Free;

  end;
end;

function TFuncionarioDao.carregaClasse(pId: String): TFuncionarioModel;
var
  lQry: TFDQuery;
  lModel: TFuncionarioModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TFuncionarioModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from FUNCIONARIO where CODIGO_FUN = ' + pID);

    if lQry.IsEmpty then
      Exit;

    lModel.CODIGO_FUN                     := lQry.FieldByName('CODIGO_FUN').AsString;
    lModel.NOME_FUN                       := lQry.FieldByName('NOME_FUN').AsString;
    lModel.END_FUN                        := lQry.FieldByName('END_FUN').AsString;
    lModel.BAI_FUN                        := lQry.FieldByName('BAI_FUN').AsString;
    lModel.CEP_FUN                        := lQry.FieldByName('CEP_FUN').AsString;
    lModel.CID_FUN                        := lQry.FieldByName('CID_FUN').AsString;
    lModel.UF_FUN                         := lQry.FieldByName('UF_FUN').AsString;
    lModel.FON1_FUN                       := lQry.FieldByName('FON1_FUN').AsString;
    lModel.CEL_FUN                        := lQry.FieldByName('CEL_FUN').AsString;
    lModel.EMAIL_FUN                      := lQry.FieldByName('EMAIL_FUN').AsString;
    lModel.CPF_FUN                        := lQry.FieldByName('CPF_FUN').AsString;
    lModel.TIPO_VEN                       := lQry.FieldByName('TIPO_VEN').AsString;
    lModel.COMIS_FUN                      := lQry.FieldByName('COMIS_FUN').AsString;
    lModel.TECNICO_FUN                    := lQry.FieldByName('TECNICO_FUN').AsString;
    lModel.DESCONTO_FUN                   := lQry.FieldByName('DESCONTO_FUN').AsString;
    lModel.STATUS_FUN                     := lQry.FieldByName('STATUS_FUN').AsString;
    lModel.COD_USER                       := lQry.FieldByName('COD_USER').AsString;
    lModel.BANCO_FUN                      := lQry.FieldByName('BANCO_FUN').AsString;
    lModel.AGENCIA_FUN                    := lQry.FieldByName('AGENCIA_FUN').AsString;
    lModel.CONTA_FUN                      := lQry.FieldByName('CONTA_FUN').AsString;
    lModel.LOJA                           := lQry.FieldByName('LOJA').AsString;
    lModel.CAIXA                          := lQry.FieldByName('CAIXA').AsString;
    lModel.FUNCAO_FUN                     := lQry.FieldByName('FUNCAO_FUN').AsString;
    lModel.NASCIMENTO_FUN                 := lQry.FieldByName('NASCIMENTO_FUN').AsString;
    lModel.ADMISSAO_FUN                   := lQry.FieldByName('ADMISSAO_FUN').AsString;
    lModel.ASO_FUN                        := lQry.FieldByName('ASO_FUN').AsString;
    lModel.ESCOLARIDADE_FUN               := lQry.FieldByName('ESCOLARIDADE_FUN').AsString;
    lModel.FONE_RECADO_FUN                := lQry.FieldByName('FONE_RECADO_FUN').AsString;
    lModel.VENC_EXPERIENCIA_FUN           := lQry.FieldByName('VENC_EXPERIENCIA_FUN').AsString;
    lModel.DATA_EXAME_FUN                 := lQry.FieldByName('DATA_EXAME_FUN').AsString;
    lModel.DATA_VENC_EXAME_FUN            := lQry.FieldByName('DATA_VENC_EXAME_FUN').AsString;
    lModel.IMAGEM_FUN                     := lQry.FieldByName('IMAGEM_FUN').AsString;
    lModel.IMAGEM2_FUN                    := lQry.FieldByName('IMAGEM2_FUN').AsString;
    lModel.DIRETORIO_FUN                  := lQry.FieldByName('DIRETORIO_FUN').AsString;
    lModel.ASO2_FUN                       := lQry.FieldByName('ASO2_FUN').AsString;
    lModel.LOCACAO_FUN                    := lQry.FieldByName('LOCACAO_FUN').AsString;
    lModel.RG                             := lQry.FieldByName('RG').AsString;
    lModel.PIS                            := lQry.FieldByName('PIS').AsString;
    lModel.ID                             := lQry.FieldByName('ID').AsString;
    lModel.SALARIO                        := lQry.FieldByName('SALARIO').AsString;
    lModel.REGIAO_ID                      := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.GERENTE                        := lQry.FieldByName('GERENTE').AsString;
    lModel.GERENTE_ID                     := lQry.FieldByName('GERENTE_ID').AsString;
    lModel.MOTORISTA                      := lQry.FieldByName('MOTORISTA').AsString;
    lModel.COR                            := lQry.FieldByName('COR').AsString;
    lModel.CABELO                         := lQry.FieldByName('CABELO').AsString;
    lModel.OLHO                           := lQry.FieldByName('OLHO').AsString;
    lModel.ALTURA                         := lQry.FieldByName('ALTURA').AsString;
    lModel.PESO                           := lQry.FieldByName('PESO').AsString;
    lModel.SINAIS                         := lQry.FieldByName('SINAIS').AsString;
    lModel.OBS_CARACTERISTICA             := lQry.FieldByName('OBS_CARACTERISTICA').AsString;
    lModel.ESTADO_CIVIL                   := lQry.FieldByName('ESTADO_CIVIL').AsString;
    lModel.CONJUGE                        := lQry.FieldByName('CONJUGE').AsString;
    lModel.LOCAL_NASCIMENTO               := lQry.FieldByName('LOCAL_NASCIMENTO').AsString;
    lModel.NACIONALIDADE                  := lQry.FieldByName('NACIONALIDADE').AsString;
    lModel.MAE                            := lQry.FieldByName('MAE').AsString;
    lModel.NACIONALIDADE_MAE              := lQry.FieldByName('NACIONALIDADE_MAE').AsString;
    lModel.PAI                            := lQry.FieldByName('PAI').AsString;
    lModel.NACIONALIDADE_PAI              := lQry.FieldByName('NACIONALIDADE_PAI').AsString;
    lModel.CBO                            := lQry.FieldByName('CBO').AsString;
    lModel.MATRICULA                      := lQry.FieldByName('MATRICULA').AsString;
    lModel.TIPO_SALARIO                   := lQry.FieldByName('TIPO_SALARIO').AsString;
    lModel.SECAO                          := lQry.FieldByName('SECAO').AsString;
    lModel.QUADRO_HORARIO                 := lQry.FieldByName('QUADRO_HORARIO').AsString;
    lModel.CARTEIRA_TRABALHO              := lQry.FieldByName('CARTEIRA_TRABALHO').AsString;
    lModel.EMISSOR_RG                     := lQry.FieldByName('EMISSOR_RG').AsString;
    lModel.UF_RG                          := lQry.FieldByName('UF_RG').AsString;
    lModel.CARTEIRA_RESERVISTA            := lQry.FieldByName('CARTEIRA_RESERVISTA').AsString;
    lModel.CATEGORIA_RESERVISTA           := lQry.FieldByName('CATEGORIA_RESERVISTA').AsString;
    lModel.TITULO_ELEITOR                 := lQry.FieldByName('TITULO_ELEITOR').AsString;
    lModel.CNH                            := lQry.FieldByName('CNH').AsString;
    lModel.CATEGORIA_CNH                  := lQry.FieldByName('CATEGORIA_CNH').AsString;
    lModel.FGTS                           := lQry.FieldByName('FGTS').AsString;
    lModel.FGTS_DATA                      := lQry.FieldByName('FGTS_DATA').AsString;
    lModel.FGTS_RETRATACAO                := lQry.FieldByName('FGTS_RETRATACAO').AsString;
    lModel.FGTS_BANCO                     := lQry.FieldByName('FGTS_BANCO').AsString;
    lModel.DEMITIDO                       := lQry.FieldByName('DEMITIDO').AsString;
    lModel.CAUSA_DEMISSAO                 := lQry.FieldByName('CAUSA_DEMISSAO').AsString;
    lModel.SMS                            := lQry.FieldByName('SMS').AsString;
    lModel.EMAIL                          := lQry.FieldByName('EMAIL').AsString;
    lModel.QTDE_VALE_TRANSPORTE           := lQry.FieldByName('QTDE_VALE_TRANSPORTE').AsString;
    lModel.VALOR_VALE_TRANSPORTE          := lQry.FieldByName('VALOR_VALE_TRANSPORTE').AsString;
    lModel.AGENDA                         := lQry.FieldByName('AGENDA').AsString;
    lModel.EMAIL_HOST                     := lQry.FieldByName('EMAIL_HOST').AsString;
    lModel.EMAIL_ENDERECO                 := lQry.FieldByName('EMAIL_ENDERECO').AsString;
    lModel.EMAIL_SENHA                    := lQry.FieldByName('EMAIL_SENHA').AsString;
    lModel.EMAIL_PORTA                    := lQry.FieldByName('EMAIL_PORTA').AsString;
    lModel.EMAIL_NOME                     := lQry.FieldByName('EMAIL_NOME').AsString;
    lModel.EMAIL_SSL                      := lQry.FieldByName('EMAIL_SSL').AsString;
    lModel.EMAIL_SMTP                     := lQry.FieldByName('EMAIL_SMTP').AsString;
    lModel.TIPO                           := lQry.FieldByName('TIPO').AsString;
    lModel.REPRESENTANTE                  := lQry.FieldByName('REPRESENTANTE').AsString;
    lModel.EMAIL_RESPOSTA                 := lQry.FieldByName('EMAIL_RESPOSTA').AsString;
    lModel.ATALHOS_WEB                    := lQry.FieldByName('ATALHOS_WEB').AsString;
    lModel.NOME_COMPLETO                  := lQry.FieldByName('NOME_COMPLETO').AsString;
    lModel.CONTATO                        := lQry.FieldByName('CONTATO').AsString;
    lModel.VENC_EXPERIENCIA_PRORROGADO    := lQry.FieldByName('VENC_EXPERIENCIA_PRORROGADO').AsString;
    lModel.LOJA_ID                        := lQry.FieldByName('LOJA_ID').AsString;
    lModel.COMPLEMENTO                    := lQry.FieldByName('COMPLEMENTO').AsString;
    lModel.CLT                            := lQry.FieldByName('CLT').AsString;
    lModel.TIPO_COMISSAO                  := lQry.FieldByName('TIPO_COMISSAO').AsString;
    lModel.DIA_FECHAMENTO_COMISSAO        := lQry.FieldByName('DIA_FECHAMENTO_COMISSAO').AsString;
    lModel.TEMPO_TAREFA                   := lQry.FieldByName('TEMPO_TAREFA').AsString;
    lModel.DATA_RG                        := lQry.FieldByName('DATA_RG').AsString;
    lModel.CODIGO_ANTERIOR                := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.MENU_WEB                       := lQry.FieldByName('MENU_WEB').AsString;
    lModel.SYSTIME                        := lQry.FieldByName('SYSTIME').AsString;
    lModel.MONTADOR                       := lQry.FieldByName('MONTADOR').AsString;
    lModel.COMISSAO_MONTADOR              := lQry.FieldByName('COMISSAO_MONTADOR').AsString;
    lModel.MSG_FINALIZAR_TAREFA           := lQry.FieldByName('MSG_FINALIZAR_TAREFA').AsString;
    lModel.TIPO_ESTOQUE                   := lQry.FieldByName('TIPO_ESTOQUE').AsString;

    Result := lModel;

  finally
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
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('FUNCIONARIO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TFuncionarioModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pFuncionarioModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pFuncionarioModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
