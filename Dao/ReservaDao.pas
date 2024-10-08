unit ReservaDao;

interface

uses
  ReservaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TReservaDao = class;
  ITReservaDao=IObject<TReservaDao>;

  TReservaDao = class
  private
    [unsafe] mySelf: ITReservaDao;
    vIConexao : IConexao;
    vConstrutor : IConstrutorDao;

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
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;


  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITReservaDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pReservaModel: ITReservaModel): String;
    function alterar(pReservaModel: ITReservaModel): String;
    function excluir(pReservaModel: ITReservaModel): String;

    function AtualizaReservaVendaAssistida(pAtualizaReserva_Parametros: TAtualizaReserva_Parametros): String;

    function carregaClasse(pID : String): ITReservaModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pReservaModel: ITReservaModel);

end;

implementation

uses
  System.Rtti;

{ TReserva }

function TReservaDao.carregaClasse(pID : String): ITReservaModel;
var
  lQry: TFDQuery;
  lModel: ITReservaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TReservaModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from RESERVA where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                     := lQry.FieldByName('ID').AsString;
    lModel.objeto.PRODUTO_ID             := lQry.FieldByName('PRODUTO_ID').AsString;
    lModel.objeto.CLIENTE_ID             := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.objeto.VENDEDOR_ID            := lQry.FieldByName('VENDEDOR_ID').AsString;
    lModel.objeto.QUANTIDADE             := lQry.FieldByName('QUANTIDADE').AsString;
    lModel.objeto.VALOR_UNITARIO         := lQry.FieldByName('VALOR_UNITARIO').AsString;
    lModel.objeto.DESCONTO               := lQry.FieldByName('DESCONTO').AsString;
    lModel.objeto.DATA                   := lQry.FieldByName('DATA').AsString;
    lModel.objeto.HORAS_BAIXA            := lQry.FieldByName('HORAS_BAIXA').AsString;
    lModel.objeto.STATUS                 := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.HORA                   := lQry.FieldByName('HORA').AsString;
    lModel.objeto.FILIAL                 := lQry.FieldByName('FILIAL').AsString;
    lModel.objeto.PEDIDO_ID              := lQry.FieldByName('PEDIDO_ID').AsString;
    lModel.objeto.INFORMACOES_PED        := lQry.FieldByName('INFORMACOES_PED').AsString;
    lModel.objeto.OBSERVACAO             := lQry.FieldByName('OBSERVACAO').AsString;
    lModel.objeto.WEB_PEDIDOITENS_ID     := lQry.FieldByName('WEB_PEDIDOITENS_ID').AsString;
    lModel.objeto.TIPO                   := lQry.FieldByName('TIPO').AsString;
    lModel.objeto.DATAHORA_EFETIVADA     := lQry.FieldByName('DATAHORA_EFETIVADA').AsString;
    lModel.objeto.RETIRA_LOJA            := lQry.FieldByName('RETIRA_LOJA').AsString;
    lModel.objeto.ENTREGA                := lQry.FieldByName('ENTREGA').AsString;
    lModel.objeto.ENTREGA_DATA           := lQry.FieldByName('ENTREGA_DATA').AsString;
    lModel.objeto.ENTREGA_HORA           := lQry.FieldByName('ENTREGA_HORA').AsString;
    lModel.objeto.MONTAGEM_DATA          := lQry.FieldByName('MONTAGEM_DATA').AsString;
    lModel.objeto.MONTAGEM_HORA          := lQry.FieldByName('MONTAGEM_HORA').AsString;
    lModel.objeto.SYSTIME                := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.PRODUCAO_ID            := lQry.FieldByName('PRODUCAO_ID').AsString;
    lModel.objeto.PRODUCAO_LOJA          := lQry.FieldByName('PRODUCAO_LOJA').AsString;
    lModel.objeto.ENTREGA_ENDERECO       := lQry.FieldByName('ENTREGA_ENDERECO').AsString;
    lModel.objeto.ENTREGA_COMPLEMENTO    := lQry.FieldByName('ENTREGA_COMPLEMENTO').AsString;
    lModel.objeto.ENTREGA_NUMERO         := lQry.FieldByName('ENTREGA_NUMERO').AsString;
    lModel.objeto.ENTREGA_BAIRRO         := lQry.FieldByName('ENTREGA_BAIRRO').AsString;
    lModel.objeto.ENTREGA_CIDADE         := lQry.FieldByName('ENTREGA_CIDADE').AsString;;
    lModel.objeto.ENTREGA_UF             := lQry.FieldByName('ENTREGA_UF').AsString;
    lModel.objeto.ENTREGA_CEP            := lQry.FieldByName('ENTREGA_CEP').AsString;
    lModel.objeto.ENTREGA_COD_MUNICIPIO  := lQry.FieldByName('ENTREGA_COD_MUNICIPIO').AsString;
    lModel.objeto.VALOR_ACRESCIMO        := lQry.FieldByName('VALOR_ACRESCIMO').AsString;
    lModel.objeto.VALOR_TOTAL            := lQry.FieldByName('VALOR_TOTAL').AsString;
    lModel.objeto.WEB_PEDIDO_ID          := lQry.FieldByName('WEB_PEDIDO_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TReservaDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TReservaDao.Destroy;
begin
  inherited;
end;

function TReservaDao.incluir(pReservaModel: ITReservaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('RESERVA', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pReservaModel.objeto.ID := vIConexao.Generetor('GEN_RESERVA');
    setParams(lQry, pReservaModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TReservaDao.alterar(pReservaModel: ITReservaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('RESERVA','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pReservaModel);
    lQry.ExecSQL;

    Result := pReservaModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TReservaDao.AtualizaReservaVendaAssistida(pAtualizaReserva_Parametros: TAtualizaReserva_Parametros): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=
          ' update reserva                                         '+
          ' set                                                    '+
          '     cliente_id = :cliente_id,                          '+
          '     vendedor_id = :vendedor_id,                        '+
          '     status = :status,                                  '+
          '     filial = :filial,                                  '+
          '     informacoes_ped = :informacoes_ped,                '+
          '     VALOR_ACRESCIMO = :VALOR_ACRESCIMO,                '+
          '     valor_total = :valor_total,                        '+
          '     entrega_data = :entrega_data,                      '+
          '     entrega_hora = :entrega_hora,                      '+
          '     montagem_data = :montagem_data,                    '+
          '     montagem_hora = :montagem_hora,                    '+
          '     entrega_endereco = :entrega_endereco,              '+
          '     entrega_complemento = :entrega_complemento,        '+
          '     entrega_numero = :entrega_numero,                  '+
          '     entrega_bairro = :entrega_bairro,                  '+
          '     entrega_cidade = :entrega_cidade,                  '+
          '     entrega_uf = :entrega_uf,                          '+
          '     entrega_cep = :entrega_cep,                        '+
          '     entrega_cod_municipio = :entrega_cod_municipio     '+
          ' where                                                  '+
          '      web_pedido_id = :web_pedido_id and filial = :filial ';
  try

    lQry.SQL.Add(lSQL);
    lQry.ParamByName('CLIENTE_ID').Value              := IIF(pAtualizaReserva_Parametros.Cliente_id              = '', Unassigned, pAtualizaReserva_Parametros.Cliente_id);
    lQry.ParamByName('STATUS').Value                  := IIF(pAtualizaReserva_Parametros.status                  = '', Unassigned, pAtualizaReserva_Parametros.status);
    lQry.ParamByName('VENDEDOR_ID').Value             := IIF(pAtualizaReserva_Parametros.Vendedor_id             = '', Unassigned, pAtualizaReserva_Parametros.Vendedor_id);
    lQry.ParamByName('FILIAL').Value                  := IIF(pAtualizaReserva_Parametros.Filial                  = '', Unassigned, pAtualizaReserva_Parametros.Filial);
    lQry.ParamByName('INFORMACOES_PED').Value         := IIF(pAtualizaReserva_Parametros.Informacoes_ped         = '', Unassigned, pAtualizaReserva_Parametros.Informacoes_ped);

    lQry.ParamByName('VALOR_ACRESCIMO').Value         := IIF(FloatToStr(pAtualizaReserva_Parametros.Valor_Acrescimo) = '', Unassigned, pAtualizaReserva_Parametros.Valor_Acrescimo);
    lQry.ParamByName('VALOR_TOTAL').Value             := IIF(FloatToStr(pAtualizaReserva_Parametros.Valor_Total)     = '', Unassigned, pAtualizaReserva_Parametros.Valor_Total);

    lQry.ParamByName('ENTREGA_DATA').Value            := IIF(pAtualizaReserva_Parametros.Entrega_data            = '', Unassigned, pAtualizaReserva_Parametros.Entrega_data);
    lQry.ParamByName('ENTREGA_HORA').Value            := IIF(pAtualizaReserva_Parametros.Entrega_hora            = '', Unassigned, pAtualizaReserva_Parametros.Entrega_hora);
    lQry.ParamByName('MONTAGEM_DATA').Value           := IIF(pAtualizaReserva_Parametros.Montagem_data           = '', Unassigned, pAtualizaReserva_Parametros.Montagem_data);
    lQry.ParamByName('MONTAGEM_HORA').Value           := IIF(pAtualizaReserva_Parametros.Montagem_hora           = '', Unassigned, pAtualizaReserva_Parametros.Montagem_hora);
    lQry.ParamByName('WEB_PEDIDO_ID').Value           := IIF(pAtualizaReserva_Parametros.Web_pedido_id           = '', Unassigned, pAtualizaReserva_Parametros.Web_pedido_id);
    lQry.ParamByName('entrega_endereco').Value        := IIF(pAtualizaReserva_Parametros.entrega_endereco        = '', Unassigned, pAtualizaReserva_Parametros.entrega_endereco);
    lQry.ParamByName('entrega_complemento').Value     := IIF(pAtualizaReserva_Parametros.entrega_complemento     = '', Unassigned, pAtualizaReserva_Parametros.entrega_complemento);
    lQry.ParamByName('entrega_numero').Value          := IIF(pAtualizaReserva_Parametros.entrega_numero          = '', Unassigned, pAtualizaReserva_Parametros.entrega_numero);
    lQry.ParamByName('entrega_bairro').Value          := IIF(pAtualizaReserva_Parametros.entrega_bairro          = '', Unassigned, pAtualizaReserva_Parametros.entrega_bairro);
    lQry.ParamByName('entrega_cidade').Value          := IIF(pAtualizaReserva_Parametros.entrega_cidade          = '', Unassigned, pAtualizaReserva_Parametros.entrega_cidade);
    lQry.ParamByName('entrega_uf').Value              := IIF(pAtualizaReserva_Parametros.entrega_uf              = '', Unassigned, pAtualizaReserva_Parametros.entrega_uf);
    lQry.ParamByName('entrega_cep').Value             := IIF(pAtualizaReserva_Parametros.entrega_cep             = '', Unassigned, pAtualizaReserva_Parametros.entrega_cep);
    lQry.ParamByName('entrega_cod_municipio').Value   := IIF(pAtualizaReserva_Parametros.entrega_cod_municipio   = '', Unassigned, pAtualizaReserva_Parametros.entrega_cod_municipio);
    lQry.ParamByName('filial').Value                  := IIF(pAtualizaReserva_Parametros.Filial                  = '', Unassigned, pAtualizaReserva_Parametros.Filial);

    lQry.ExecSQL;

    Result := pAtualizaReserva_Parametros.Web_pedido_id;
  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TReservaDao.excluir(pReservaModel: ITReservaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;
  try
   lQry.ExecSQL('delete from RESERVA where ID = :ID ', [pReservaModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pReservaModel.objeto.ID;
  finally
    lQry.Free;
  end;
end;

class function TReservaDao.getNewIface(pIConexao: IConexao): ITReservaDao;
begin
  Result := TImplObjetoOwner<TReservaDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TReservaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TReservaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From RESERVA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TReservaDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                         '+SLineBreak+
              '         reserva.*,                                                            '+SLineBreak+
              '         produto.nome_pro PRODUTO,                                             '+SLineBreak+
              '         funcionario.nome_fun VENDEDOR                                         '+SLineBreak+
              '    from reserva                                                               '+SLineBreak+
              '    left join produto on produto.codigo_pro = reserva.produto_id               '+SLineBreak+
              '    left join funcionario on funcionario.codigo_fun = reserva.vendedor_id      '+SLineBreak+
              '   where 1=1                                                                   '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TReservaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TReservaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TReservaDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TReservaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TReservaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TReservaDao.setParams(var pQry: TFDQuery; pReservaModel: ITReservaModel);
begin
  vConstrutor.setParams('RESERVA',pQry,pReservaModel.objeto);
end;

procedure TReservaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TReservaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TReservaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
