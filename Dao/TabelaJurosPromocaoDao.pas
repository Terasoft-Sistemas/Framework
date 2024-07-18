unit TabelaJurosPromocaoDao;

interface

uses
  TabelaJurosPromocaoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TTabelaJurosPromocaoDao = class

  private
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

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pTabelaJurosPromocaoModel: TTabelaJurosPromocaoModel): String;
    function alterar(pTabelaJurosPromocaoModel: TTabelaJurosPromocaoModel): String;
    function excluir(pTabelaJurosPromocaoModel: TTabelaJurosPromocaoModel): String;

    function carregaClasse(pID : String): TTabelaJurosPromocaoModel;
    function obterLista: TFDMemTable;
    function obterTabelaJurosProduto(pProduto : String): TFDMemTable;
    procedure setParams(var pQry: TFDQuery; pTabelaJurosPromocaoModel: TTabelaJurosPromocaoModel);

end;

implementation

uses
  System.Rtti;

{ TTabelaJurosPromocao }

function TTabelaJurosPromocaoDao.carregaClasse(pID : String): TTabelaJurosPromocaoModel;
var
  lQry: TFDQuery;
  lModel: TTabelaJurosPromocaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TTabelaJurosPromocaoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from TABELAJUROS_PROMOCAO where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID                := lQry.FieldByName('ID').AsString;
    lModel.PROMOCAO_ID       := lQry.FieldByName('PROMOCAO_ID').AsString;
    lModel.PORTADOR_ID       := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.PARCELA           := lQry.FieldByName('PARCELA').AsString;
    lModel.TAXA_JUROS        := lQry.FieldByName('TAXA_JUROS').AsString;
    lModel.SYSTIME           := lQry.FieldByName('SYSTIME').AsString;
    lModel.COM_ENTRADA       := lQry.FieldByName('COM_ENTRADA').AsString;
    lModel.LIMITADO_PARCELA  := lQry.FieldByName('LIMITADO_PARCELA').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TTabelaJurosPromocaoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TTabelaJurosPromocaoDao.Destroy;
begin
  inherited;
end;

function TTabelaJurosPromocaoDao.incluir(pTabelaJurosPromocaoModel: TTabelaJurosPromocaoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('TABELAJUROS_PROMOCAO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pTabelaJurosPromocaoModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTabelaJurosPromocaoDao.alterar(pTabelaJurosPromocaoModel: TTabelaJurosPromocaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('TABELAJUROS_PROMOCAO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pTabelaJurosPromocaoModel);
    lQry.ExecSQL;

    Result := pTabelaJurosPromocaoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTabelaJurosPromocaoDao.excluir(pTabelaJurosPromocaoModel: TTabelaJurosPromocaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from TABELAJUROS_PROMOCAO where ID = :ID' ,[pTabelaJurosPromocaoModel.ID]);
   lQry.ExecSQL;
   Result := pTabelaJurosPromocaoModel.ID;

  finally
    lQry.Free;
  end;
end;

function TTabelaJurosPromocaoDao.where: String;
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

function TTabelaJurosPromocaoDao.obterTabelaJurosProduto(pProduto: String): TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := '  select pt.nome_port||'' - ''||j.parcela||''x'' descricao,            '+SLineBreak+
            '         j.portador_id,                                                '+SLineBreak+
            '         j.parcela,                                                    '+SLineBreak+
            '         j.taxa_juros,                                                 '+SLineBreak+
            '         j.com_entrada,                                                '+SLineBreak+
            '         j.limitado_parcela                                            '+SLineBreak+
            '    from promocao p                                                    '+SLineBreak+
            '    left join promocaoitens i on i.promocao_id = p.id                  '+SLineBreak+
            '    left join tabelajuros_promocao j on j.promocao_id = p.id           '+SLineBreak+
            '    left join portador pt on pt.codigo_port = j.portador_id            '+SLineBreak+
            '   where i.produto_id = '+ QuotedStr(pProduto) +'                      '+SLineBreak+
            '     and current_date between p.datainicio and p.datafim               '+SLineBreak+
            '     and current_time between p.horainicio and p.horafim               '+SLineBreak+
            '     and p.segunda = ''S''                                             '+SLineBreak;

    lQry.Open(lSQL);
    Result := vConstrutor.atribuirRegistros(lQry);

  finally
    lQry.Free;
  end;

end;

procedure TTabelaJurosPromocaoDao.obterTotalRegistros;
var
  lQry : TFDQuery;
  lSQL : String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From TABELAJUROS_PROMOCAO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TTabelaJurosPromocaoDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao+'          '+SLineBreak+
              '         id,                     '+SLineBreak+
              '         promocao_id,            '+SLineBreak+
              '         portador_id,            '+SLineBreak+
              '         parcela,                '+SLineBreak+
              '         taxa_juros,             '+SLineBreak+
              '         systime,                '+SLineBreak+
              '         com_entrada,            '+SLineBreak+
              '         limitado_parcela        '+SLineBreak+
              '    from tabelajuros_promocao    '+SLineBreak;


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

procedure TTabelaJurosPromocaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTabelaJurosPromocaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTabelaJurosPromocaoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TTabelaJurosPromocaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTabelaJurosPromocaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TTabelaJurosPromocaoDao.setParams(var pQry: TFDQuery; pTabelaJurosPromocaoModel: TTabelaJurosPromocaoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('TABELAJUROS_PROMOCAO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TTabelaJurosPromocaoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pTabelaJurosPromocaoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pTabelaJurosPromocaoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TTabelaJurosPromocaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TTabelaJurosPromocaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TTabelaJurosPromocaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
