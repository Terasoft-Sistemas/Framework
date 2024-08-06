unit MovimentoSerialDao;

interface

uses
  MovimentoSerialModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TMovimentoSerialDao = class;
  ITMovimentoSerialDao=IObject<TMovimentoSerialDao>;

  TMovimentoSerialDao = class
  private
    [weak] mySelf: ITMovimentoSerialDao;
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

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

    class function getNewIface(pIConexao: IConexao): ITMovimentoSerialDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pMovimentoSerialModel: ITMovimentoSerialModel): String;
    function alterar(pMovimentoSerialModel: ITMovimentoSerialModel): String;
    function excluir(pMovimentoSerialModel: ITMovimentoSerialModel): String;

    function carregaClasse(pID : String): ITMovimentoSerialModel;
    function obterLista: IFDDataset;
    function ConsultaSerial: IFDDataset;

    function ValidaVendaSerial(pProduto: String): Boolean;
    function SaldoProdutoSerial(pProduto: String): Real;
    function RetornaSerialVenda(pProduto: String): String;
    function EstornaMovimentoSerial(pTipoDoc, pID_Doc, pSubId: String): String;

    procedure setParams(var pQry: TFDQuery; pMovimentoSerialModel: ITMovimentoSerialModel);

end;

implementation

uses
  System.Rtti;

{ TMovimentoSerial }

function TMovimentoSerialDao.ValidaVendaSerial(pProduto: String): Boolean;
var
  lQry: TFDQuery;
  lSQL: String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL :=
            ' select first 1                                           '+#13+
            '     p.controle_serial,                                   '+#13+
            '     m.numero                                             '+#13+
            ' from                                                     '+#13+
            '     produto p                                            '+#13+
            '                                                          '+#13+
            ' left join movimento_serial m on m.produto = p.codigo_pro '+#13+
            '                                                          '+#13+
            ' where                                                    '+#13+
            '     p.codigo_pro = '+QuotedStr(pProduto)                  +#13+
            '                                                          '+#13;
    lQry.Open(lSQL);

    if lQry.FieldByName('numero').AsString <> '' then
      Result := True
    else if lQry.FieldByName('controle_serial').AsString = 'S' then
      Result := True
    else
      Result := False;

  finally
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.SaldoProdutoSerial(pProduto: String): Real;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
    lQry.Open(' select sum(saldo) saldo from view_movimento_serial where produto = '+QuotedStr(pProduto));

    Result := lQry.FieldByName('saldo').AsFloat;

  finally
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.RetornaSerialVenda(pProduto: String): String;
var
  lQry: TFDQuery;
  lSQL: String;
begin

  lQry := vIConexao.CriarQuery;

  try

    lSQL :=
          ' select                                              '+#13+
          '     primeira_entrada,                               '+#13+
          '     serial,                                         '+#13+
          '     saldo                                           '+#13+
          ' from                                                '+#13+
          '     view_movimento_serial                           '+#13+
          '                                                     '+#13+
          ' where                                               '+#13+
          '     produto = '+QuotedStr(pProduto)+' and saldo > 0 '+#13+
          '                                                     '+#13+
          ' order by 1                                          '+#13;

    lQry.Open(lSQL);

    Result := lQry.FieldByName('serial').AsString;

  finally
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.EstornaMovimentoSerial(pTipoDoc, pID_Doc, pSubId: String): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   if pSubId = '' then
     lQry.ExecSQL(' update movimento_serial set status = ''X'' where tipo_documento = '+QuotedStr(pTipoDoc)+' and  id_documento = '+QuotedStr(pID_Doc))
   else
     lQry.ExecSQL(' update movimento_serial set status = ''X'' where tipo_documento = '+QuotedStr(pTipoDoc)+' and  id_documento = '+QuotedStr(pID_Doc)+' and sub_id = '+QuotedStr(pSubId)+' ');
  finally
    lQry.Free;
  end;

end;

function TMovimentoSerialDao.carregaClasse(pID : String): ITMovimentoSerialModel;
var
  lQry: TFDQuery;
  lModel: ITMovimentoSerialModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TMovimentoSerialModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from movimento_serial where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                := lQry.FieldByName('ID').AsString;
    lModel.objeto.LOGISTICA         := lQry.FieldByName('LOGISTICA').AsString;
    lModel.objeto.TIPO_SERIAL       := lQry.FieldByName('TIPO_SERIAL').AsString;
    lModel.objeto.NUMERO            := lQry.FieldByName('NUMERO').AsString;
    lModel.objeto.PRODUTO           := lQry.FieldByName('PRODUTO').AsString;
    lModel.objeto.DH_MOVIMENTO      := lQry.FieldByName('DH_MOVIMENTO').AsString;
    lModel.objeto.TIPO_DOCUMENTO    := lQry.FieldByName('TIPO_DOCUMENTO').AsString;
    lModel.objeto.ID_DOCUMENTO      := lQry.FieldByName('ID_DOCUMENTO').AsString;
    lModel.objeto.SUB_ID            := lQry.FieldByName('SUB_ID').AsString;
    lModel.objeto.TIPO_MOVIMENTO    := lQry.FieldByName('TIPO_MOVIMENTO').AsString;
    lModel.objeto.SYSTIME           := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.ConsultaSerial: IFDDataset;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSql := '  select                                                                                '+sLineBreak+
            '      case m.tipo_documento                                                             '+sLineBreak+
            '        when ''E'' then f.fantasia_for                                                  '+sLineBreak+
            '        when ''P'' then c.fantasia_cli                                                  '+sLineBreak+
            '        when ''T'' then cl.fantasia_cli                                                 '+sLineBreak+
            '        when ''D'' then cli.fantasia_cli                                                '+sLineBreak+
            '        else ''NAO INFORMADO''                                                          '+sLineBreak+
            '      end Cliente_fornecedor,                                                           '+sLineBreak+
            '                                                                                        '+sLineBreak+
            '      case m.tipo_documento                                                             '+sLineBreak+
            '        when ''I'' then ''INICIALIZACAO''                                               '+sLineBreak+
            '        when ''E'' then ''ENTRADA''                                                     '+sLineBreak+
            '        when ''P'' then ''VENDA''                                                       '+sLineBreak+
            '        when ''T'' then ''TRASNFERENCIA SAIDA''                                         '+sLineBreak+
            '        when ''D'' then ''DEVOLUCAO''                                                   '+sLineBreak+
            '        else ''NAO INFORMADO''                                                          '+sLineBreak+
            '      end tipo_documento,                                                               '+sLineBreak+
            '                                                                                        '+sLineBreak+
            '      m.numero,                                                                         '+sLineBreak+
            '      m.produto,                                                                        '+sLineBreak+
            '      t.nome_pro,                                                                       '+sLineBreak+
            '      m.id_documento,                                                                   '+sLineBreak+
            '      m.dh_movimento,                                                                   '+sLineBreak+
            '      m.tipo_movimento,                                                                 '+sLineBreak+
            '      p.numero_nf                                                                       '+sLineBreak+
            '  from                                                                                  '+sLineBreak+
            '       movimento_serial m                                                               '+sLineBreak+
            '                                                                                        '+sLineBreak+
            '  left join entrada e on e.id = m.id_documento and m.tipo_documento = ''E''             '+sLineBreak+
            '  left join fornecedor f on f.codigo_for = e.codigo_for and m.tipo_documento = ''E''    '+sLineBreak+
            '  left join pedidovenda p on p.numero_ped = m.id_documento and m.tipo_documento = ''P'' '+sLineBreak+
            '  left join clientes c on c.codigo_cli = p.codigo_cli and m.tipo_documento = ''P''      '+sLineBreak+
            '  left join saidas s on s.numero_sai = m.id_documento and m.tipo_documento = ''T''      '+sLineBreak+
            '  left join clientes cl on cl.codigo_cli = s.codigo_cli and m.tipo_documento = ''T''    '+sLineBreak+
            '  left join devolucao d on d.id = m.id_documento and m.tipo_documento = ''D''           '+sLineBreak+
            '  left join clientes cli on cli.codigo_cli = d.cliente and m.tipo_documento = ''D''     '+sLineBreak+
            '  left join produto t on t.codigo_pro = m.produto                                       '+sLineBreak+
            ' where 1=1                                                                              '+sLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;
end;

constructor TMovimentoSerialDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TMovimentoSerialDao.Destroy;
begin
  inherited;
end;

function TMovimentoSerialDao.incluir(pMovimentoSerialModel: ITMovimentoSerialModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('MOVIMENTO_SERIAL', 'ID');
  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMovimentoSerialModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.alterar(pMovimentoSerialModel: ITMovimentoSerialModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('MOVIMENTO_SERIAL','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMovimentoSerialModel);
    lQry.ExecSQL;

    Result := pMovimentoSerialModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.excluir(pMovimentoSerialModel: ITMovimentoSerialModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from movimento_serial where ID = :ID' ,[pMovimentoSerialModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pMovimentoSerialModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;


class function TMovimentoSerialDao.getNewIface(pIConexao: IConexao): ITMovimentoSerialDao;
begin
  Result := TImplObjetoOwner<TMovimentoSerialDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TMovimentoSerialDao.where: String;
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

procedure TMovimentoSerialDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from movimento_serial where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TMovimentoSerialDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao+' *       '+SLineBreak+
              '    from movimento_serial       '+SLineBreak+
              '   where 1=1                    '+SLineBreak;


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


procedure TMovimentoSerialDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMovimentoSerialDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMovimentoSerialDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TMovimentoSerialDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMovimentoSerialDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TMovimentoSerialDao.setParams(var pQry: TFDQuery; pMovimentoSerialModel: ITMovimentoSerialModel);
begin
  vConstrutor.setParams('movimento_serial',pQry,pMovimentoSerialModel.objeto);
end;

procedure TMovimentoSerialDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TMovimentoSerialDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TMovimentoSerialDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
