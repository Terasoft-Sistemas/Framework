unit ItensProdutoDao;

interface

uses
  ItensProdutoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TItensProdutoDao = class;
  ITItensProdutoDao=IObject<TItensProdutoDao>;

  TItensProdutoDao = class
  private
    [weak] mySelf :ITItensProdutoDao;
    vIConexao     : IConexao;
    vConstrutor   : IConstrutorDao;

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

    class function getNewIface(pIConexao: IConexao): ITItensProdutoDao;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function obterLista: IFDDataset;
    function carregaClasse(pID : String): ITItensProdutoModel;

    procedure setParams(var pQry: TFDQuery; pItensProdutoModel: ITItensProdutoModel);
end;

implementation

{ TItensProduto }

function TItensProdutoDao.carregaClasse(pID : String): ITItensProdutoModel;
var
  lQry: TFDQuery;
  lModel: ITItensProdutoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TItensProdutoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from itens_produto where CODIGO_PRODUTO = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.CODIGO_PRODUTO        := lQry.FieldByName('CODIGO_PRODUTO').AsString;
    lModel.objeto.CODIGO_MATERIA_PRIMA  := lQry.FieldByName('CODIGO_MATERIA_PRIMA').AsString;
    lModel.objeto.QTDE_MATERIA_PRIMA    := lQry.FieldByName('QTDE_MATERIA_PRIMA').AsString;
    lModel.objeto.UNIDADE_MATERIA_PRIMA := lQry.FieldByName('UNIDADE_MATERIA_PRIMA').AsString;
    lModel.objeto.VALOR_VENDA           := lQry.FieldByName('VALOR_VENDA').AsString;
    lModel.objeto.ORDEM                 := lQry.FieldByName('ORDEM').AsString;
    lModel.objeto.ID                    := lQry.FieldByName('ID').AsString;
    lModel.objeto.CUSTO_PRODUTO         := lQry.FieldByName('CUSTO_PRODUTO').AsString;
    lModel.objeto.SALDO                 := lQry.FieldByName('SALDO').AsString;
    lModel.objeto.ALTURA_M              := lQry.FieldByName('ALTURA_M').AsString;
    lModel.objeto.LARGURA_M             := lQry.FieldByName('LARGURA_M').AsString;
    lModel.objeto.PROFUNDIDADE_M        := lQry.FieldByName('PROFUNDIDADE_M').AsString;
    lModel.objeto.VIDRO                 := lQry.FieldByName('VIDRO').AsString;
    lModel.objeto.MDF                   := lQry.FieldByName('MDF').AsString;
    lModel.objeto.PADRAO                := lQry.FieldByName('PADRAO').AsString;
    lModel.objeto.UNICO                 := lQry.FieldByName('UNICO').AsString;
    lModel.objeto.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.LISTAR                := lQry.FieldByName('LISTAR').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TItensProdutoDao._Create(pIConexao: IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TItensProdutoDao.Destroy;
begin
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

class function TItensProdutoDao.getNewIface(pIConexao: IConexao): ITItensProdutoDao;
begin
  Result := TImplObjetoOwner<TItensProdutoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TItensProdutoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  Result := lSQL;
end;

procedure TItensProdutoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from itens_produto where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TItensProdutoDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSQL := ' select '+lPaginacao+'                      '+sLineBreak+
            '        codigo_produto,                     '+sLineBreak+
            '        codigo_materia_prima,               '+sLineBreak+
            '        qtde_materia_prima,                 '+sLineBreak+
            '        unidade_materia_prima,              '+sLineBreak+
            '        valor_venda,                        '+sLineBreak+
            '        ordem,                              '+sLineBreak+
            '        id,                                 '+sLineBreak+
            '        custo_produto,                      '+sLineBreak+
            '        saldo,                              '+sLineBreak+
            '        altura_m,                           '+sLineBreak+
            '        largura_m,                          '+sLineBreak+
            '        profundidade_m,                     '+sLineBreak+
            '        vidro,                              '+sLineBreak+
            '        mdf,                                '+sLineBreak+
            '        padrao,                             '+sLineBreak+
            '        unico,                              '+sLineBreak+
            '        systime,                            '+sLineBreak+
            '        listar                              '+sLineBreak+
            '   from itens_produto                       '+sLineBreak+
            '  where 1=1                                 '+sLineBreak;

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

procedure TItensProdutoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TItensProdutoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TItensProdutoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TItensProdutoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TItensProdutoDao.setParams(var pQry: TFDQuery; pItensProdutoModel: ITItensProdutoModel);
begin
  vConstrutor.setParams('ITENS_PRODUTO',pQry,pItensProdutoModel.objeto);
end;

procedure TItensProdutoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TItensProdutoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TItensProdutoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
