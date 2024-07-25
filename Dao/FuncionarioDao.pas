unit FuncionarioDao;

interface

uses
  FuncionarioModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TFuncionarioDao = class;

  ITFuncionarioDao = IObject<TFuncionarioDao>;

  TFuncionarioDao = class
  private
    [weak] mySelf: ITFuncionarioDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FFuncionariosLista: IList<ITFuncionarioModel>;
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
    procedure SetFuncionariosLista(const Value: IList<ITFuncionarioModel>);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITFuncionarioDao;

    property FuncionariosLista: IList<ITFuncionarioModel> read FFuncionariosLista write SetFuncionariosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pFuncionarioModel: ITFuncionarioModel);

    function where: String;
    function incluir(AFuncionarioModel: ITFuncionarioModel): String;
    function alterar(AFuncionarioModel: ITFuncionarioModel): String;
    function excluir(AFuncionarioModel: ITFuncionarioModel): String;
    function comissaoVendedor(pIdVendedor, pIdTipoComissao: String): Double;
    function carregaClasse(pId: String): ITFuncionarioModel;
end;

implementation

uses
  System.Rtti;

{ TFuncionario }

function TFuncionarioDao.alterar(AFuncionarioModel: ITFuncionarioModel): String;
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

    Result := AFuncionarioModel.objeto.CODIGO_FUN;

  finally
    lSQL := '';
    lQry.Free;

  end;
end;

function TFuncionarioDao.carregaClasse(pId: String): ITFuncionarioModel;
var
  lQry: TFDQuery;
  lModel: ITFuncionarioModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TFuncionarioModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from FUNCIONARIO where CODIGO_FUN = ' + pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.CODIGO_FUN                     := lQry.FieldByName('CODIGO_FUN').AsString;
    lModel.objeto.NOME_FUN                       := lQry.FieldByName('NOME_FUN').AsString;
    lModel.objeto.END_FUN                        := lQry.FieldByName('END_FUN').AsString;
    lModel.objeto.BAI_FUN                        := lQry.FieldByName('BAI_FUN').AsString;
    lModel.objeto.CEP_FUN                        := lQry.FieldByName('CEP_FUN').AsString;
    lModel.objeto.CID_FUN                        := lQry.FieldByName('CID_FUN').AsString;
    lModel.objeto.UF_FUN                         := lQry.FieldByName('UF_FUN').AsString;
    lModel.objeto.FON1_FUN                       := lQry.FieldByName('FON1_FUN').AsString;
    lModel.objeto.CEL_FUN                        := lQry.FieldByName('CEL_FUN').AsString;
    lModel.objeto.EMAIL_FUN                      := lQry.FieldByName('EMAIL_FUN').AsString;
    lModel.objeto.CPF_FUN                        := lQry.FieldByName('CPF_FUN').AsString;
    lModel.objeto.TIPO_VEN                       := lQry.FieldByName('TIPO_VEN').AsString;
    lModel.objeto.COMIS_FUN                      := lQry.FieldByName('COMIS_FUN').AsString;
    lModel.objeto.TECNICO_FUN                    := lQry.FieldByName('TECNICO_FUN').AsString;
    lModel.objeto.DESCONTO_FUN                   := lQry.FieldByName('DESCONTO_FUN').AsString;
    lModel.objeto.STATUS_FUN                     := lQry.FieldByName('STATUS_FUN').AsString;
    lModel.objeto.COD_USER                       := lQry.FieldByName('COD_USER').AsString;
    lModel.objeto.BANCO_FUN                      := lQry.FieldByName('BANCO_FUN').AsString;
    lModel.objeto.AGENCIA_FUN                    := lQry.FieldByName('AGENCIA_FUN').AsString;
    lModel.objeto.CONTA_FUN                      := lQry.FieldByName('CONTA_FUN').AsString;
    lModel.objeto.LOJA                           := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.CAIXA                          := lQry.FieldByName('CAIXA').AsString;
    lModel.objeto.FUNCAO_FUN                     := lQry.FieldByName('FUNCAO_FUN').AsString;
    lModel.objeto.NASCIMENTO_FUN                 := lQry.FieldByName('NASCIMENTO_FUN').AsString;
    lModel.objeto.ADMISSAO_FUN                   := lQry.FieldByName('ADMISSAO_FUN').AsString;
    lModel.objeto.ASO_FUN                        := lQry.FieldByName('ASO_FUN').AsString;
    lModel.objeto.ESCOLARIDADE_FUN               := lQry.FieldByName('ESCOLARIDADE_FUN').AsString;
    lModel.objeto.FONE_RECADO_FUN                := lQry.FieldByName('FONE_RECADO_FUN').AsString;
    lModel.objeto.VENC_EXPERIENCIA_FUN           := lQry.FieldByName('VENC_EXPERIENCIA_FUN').AsString;
    lModel.objeto.DATA_EXAME_FUN                 := lQry.FieldByName('DATA_EXAME_FUN').AsString;
    lModel.objeto.DATA_VENC_EXAME_FUN            := lQry.FieldByName('DATA_VENC_EXAME_FUN').AsString;
    lModel.objeto.IMAGEM_FUN                     := lQry.FieldByName('IMAGEM_FUN').AsString;
    lModel.objeto.IMAGEM2_FUN                    := lQry.FieldByName('IMAGEM2_FUN').AsString;
    lModel.objeto.DIRETORIO_FUN                  := lQry.FieldByName('DIRETORIO_FUN').AsString;
    lModel.objeto.ASO2_FUN                       := lQry.FieldByName('ASO2_FUN').AsString;
    lModel.objeto.LOCACAO_FUN                    := lQry.FieldByName('LOCACAO_FUN').AsString;
    lModel.objeto.RG                             := lQry.FieldByName('RG').AsString;
    lModel.objeto.PIS                            := lQry.FieldByName('PIS').AsString;
    lModel.objeto.ID                             := lQry.FieldByName('ID').AsString;
    lModel.objeto.SALARIO                        := lQry.FieldByName('SALARIO').AsString;
    lModel.objeto.REGIAO_ID                      := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.objeto.GERENTE                        := lQry.FieldByName('GERENTE').AsString;
    lModel.objeto.GERENTE_ID                     := lQry.FieldByName('GERENTE_ID').AsString;
    lModel.objeto.MOTORISTA                      := lQry.FieldByName('MOTORISTA').AsString;
    lModel.objeto.COR                            := lQry.FieldByName('COR').AsString;
    lModel.objeto.CABELO                         := lQry.FieldByName('CABELO').AsString;
    lModel.objeto.OLHO                           := lQry.FieldByName('OLHO').AsString;
    lModel.objeto.ALTURA                         := lQry.FieldByName('ALTURA').AsString;
    lModel.objeto.PESO                           := lQry.FieldByName('PESO').AsString;
    lModel.objeto.SINAIS                         := lQry.FieldByName('SINAIS').AsString;
    lModel.objeto.OBS_CARACTERISTICA             := lQry.FieldByName('OBS_CARACTERISTICA').AsString;
    lModel.objeto.ESTADO_CIVIL                   := lQry.FieldByName('ESTADO_CIVIL').AsString;
    lModel.objeto.CONJUGE                        := lQry.FieldByName('CONJUGE').AsString;
    lModel.objeto.LOCAL_NASCIMENTO               := lQry.FieldByName('LOCAL_NASCIMENTO').AsString;
    lModel.objeto.NACIONALIDADE                  := lQry.FieldByName('NACIONALIDADE').AsString;
    lModel.objeto.MAE                            := lQry.FieldByName('MAE').AsString;
    lModel.objeto.NACIONALIDADE_MAE              := lQry.FieldByName('NACIONALIDADE_MAE').AsString;
    lModel.objeto.PAI                            := lQry.FieldByName('PAI').AsString;
    lModel.objeto.NACIONALIDADE_PAI              := lQry.FieldByName('NACIONALIDADE_PAI').AsString;
    lModel.objeto.CBO                            := lQry.FieldByName('CBO').AsString;
    lModel.objeto.MATRICULA                      := lQry.FieldByName('MATRICULA').AsString;
    lModel.objeto.TIPO_SALARIO                   := lQry.FieldByName('TIPO_SALARIO').AsString;
    lModel.objeto.SECAO                          := lQry.FieldByName('SECAO').AsString;
    lModel.objeto.QUADRO_HORARIO                 := lQry.FieldByName('QUADRO_HORARIO').AsString;
    lModel.objeto.CARTEIRA_TRABALHO              := lQry.FieldByName('CARTEIRA_TRABALHO').AsString;
    lModel.objeto.EMISSOR_RG                     := lQry.FieldByName('EMISSOR_RG').AsString;
    lModel.objeto.UF_RG                          := lQry.FieldByName('UF_RG').AsString;
    lModel.objeto.CARTEIRA_RESERVISTA            := lQry.FieldByName('CARTEIRA_RESERVISTA').AsString;
    lModel.objeto.CATEGORIA_RESERVISTA           := lQry.FieldByName('CATEGORIA_RESERVISTA').AsString;
    lModel.objeto.TITULO_ELEITOR                 := lQry.FieldByName('TITULO_ELEITOR').AsString;
    lModel.objeto.CNH                            := lQry.FieldByName('CNH').AsString;
    lModel.objeto.CATEGORIA_CNH                  := lQry.FieldByName('CATEGORIA_CNH').AsString;
    lModel.objeto.FGTS                           := lQry.FieldByName('FGTS').AsString;
    lModel.objeto.FGTS_DATA                      := lQry.FieldByName('FGTS_DATA').AsString;
    lModel.objeto.FGTS_RETRATACAO                := lQry.FieldByName('FGTS_RETRATACAO').AsString;
    lModel.objeto.FGTS_BANCO                     := lQry.FieldByName('FGTS_BANCO').AsString;
    lModel.objeto.DEMITIDO                       := lQry.FieldByName('DEMITIDO').AsString;
    lModel.objeto.CAUSA_DEMISSAO                 := lQry.FieldByName('CAUSA_DEMISSAO').AsString;
    lModel.objeto.SMS                            := lQry.FieldByName('SMS').AsString;
    lModel.objeto.EMAIL                          := lQry.FieldByName('EMAIL').AsString;
    lModel.objeto.QTDE_VALE_TRANSPORTE           := lQry.FieldByName('QTDE_VALE_TRANSPORTE').AsString;
    lModel.objeto.VALOR_VALE_TRANSPORTE          := lQry.FieldByName('VALOR_VALE_TRANSPORTE').AsString;
    lModel.objeto.AGENDA                         := lQry.FieldByName('AGENDA').AsString;
    lModel.objeto.EMAIL_HOST                     := lQry.FieldByName('EMAIL_HOST').AsString;
    lModel.objeto.EMAIL_ENDERECO                 := lQry.FieldByName('EMAIL_ENDERECO').AsString;
    lModel.objeto.EMAIL_SENHA                    := lQry.FieldByName('EMAIL_SENHA').AsString;
    lModel.objeto.EMAIL_PORTA                    := lQry.FieldByName('EMAIL_PORTA').AsString;
    lModel.objeto.EMAIL_NOME                     := lQry.FieldByName('EMAIL_NOME').AsString;
    lModel.objeto.EMAIL_SSL                      := lQry.FieldByName('EMAIL_SSL').AsString;
    lModel.objeto.EMAIL_SMTP                     := lQry.FieldByName('EMAIL_SMTP').AsString;
    lModel.objeto.TIPO                           := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.REPRESENTANTE                  := lQry.FieldByName('REPRESENTANTE').AsString;
    lModel.objeto.EMAIL_RESPOSTA                 := lQry.FieldByName('EMAIL_RESPOSTA').AsString;
    lModel.objeto.ATALHOS_WEB                    := lQry.FieldByName('ATALHOS_WEB').AsString;
    lModel.objeto.NOME_COMPLETO                  := lQry.FieldByName('NOME_COMPLETO').AsString;
    lModel.objeto.CONTATO                        := lQry.FieldByName('CONTATO').AsString;
    lModel.objeto.VENC_EXPERIENCIA_PRORROGADO    := lQry.FieldByName('VENC_EXPERIENCIA_PRORROGADO').AsString;
    lModel.objeto.LOJA_ID                        := lQry.FieldByName('LOJA_ID').AsString;
    lModel.objeto.COMPLEMENTO                    := lQry.FieldByName('COMPLEMENTO').AsString;
    lModel.objeto.CLT                            := lQry.FieldByName('CLT').AsString;
    lModel.objeto.TIPO_COMISSAO                  := lQry.FieldByName('TIPO_COMISSAO').AsString;
    lModel.objeto.DIA_FECHAMENTO_COMISSAO        := lQry.FieldByName('DIA_FECHAMENTO_COMISSAO').AsString;
    lModel.objeto.TEMPO_TAREFA                   := lQry.FieldByName('TEMPO_TAREFA').AsString;
    lModel.objeto.DATA_RG                        := lQry.FieldByName('DATA_RG').AsString;
    lModel.objeto.CODIGO_ANTERIOR                := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.objeto.MENU_WEB                       := lQry.FieldByName('MENU_WEB').AsString;
    lModel.objeto.SYSTIME                        := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.MONTADOR                       := lQry.FieldByName('MONTADOR').AsString;
    lModel.objeto.COMISSAO_MONTADOR              := lQry.FieldByName('COMISSAO_MONTADOR').AsString;
    lModel.objeto.MSG_FINALIZAR_TAREFA           := lQry.FieldByName('MSG_FINALIZAR_TAREFA').AsString;
    lModel.objeto.TIPO_ESTOQUE                   := lQry.FieldByName('TIPO_ESTOQUE').AsString;

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

constructor TFuncionarioDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TFuncionarioDao.Destroy;
begin
  FFuncionariosLista:=nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TFuncionarioDao.excluir(AFuncionarioModel: ITFuncionarioModel): String;
var
  lQry: TFDQuery;

begin

  lQry := vIconexao.CriarQuery;

  try
   lQry.ExecSQL('delete from FUNCIONARIO where CODIGO_FUN = :CODIGO_FUN',[AFuncionarioModel.objeto.CODIGO_FUN]);
   lQry.ExecSQL;
   Result := AFuncionarioModel.objeto.CODIGO_FUN;

  finally
    lQry.Free;
  end;
end;

class function TFuncionarioDao.getNewIface;
begin
  Result := TImplObjetoOwner<TFuncionarioDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TFuncionarioDao.incluir(AFuncionarioModel: ITFuncionarioModel): String;
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
  modelo  : ITFuncionarioModel;
begin
  lQry := vIConexao.CriarQuery;

  FFuncionariosLista := TCollections.CreateList<ITFuncionarioModel>;

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

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TFuncionarioModel.getNewIface(vIConexao);
      FFuncionariosLista.Add(modelo);

      modelo.objeto.CODIGO_FUN       := lQry.FieldByName('CODIGO_FUN').AsString;
      modelo.objeto.NOME_FUN         := lQry.FieldByName('NOME_FUN').AsString;
      modelo.objeto.GERENTE_ID       := lQry.FieldByName('GERENTE_ID').AsString;
      modelo.objeto.TIPO_COMISSAO    := lQry.FieldByName('TIPO_COMISSAO').AsString;

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

procedure TFuncionarioDao.SetFuncionariosLista;
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

procedure TFuncionarioDao.setParams(var pQry: TFDQuery; pFuncionarioModel: ITFuncionarioModel);
var
  lTabela : IFDDataset;
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pFuncionarioModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pFuncionarioModel).AsString))
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
