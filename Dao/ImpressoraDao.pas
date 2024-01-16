unit ImpressoraDao;

interface

uses
  ImpressoraModel,
  Conexao,
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants;

type
  TImpressoraDao = class

  private
    FImpressorasLista: TObjectList<TImpressoraModel>;
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
    procedure SetImpressorasLista(const Value: TObjectList<TImpressoraModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;
    procedure setParams(var pQry: TFDQuery; pImpressoraModel: TImpressoraModel);

  public
    constructor Create;
    destructor Destroy; override;

    property ImpressorasLista: TObjectList<TImpressoraModel> read FImpressorasLista write SetImpressorasLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AImpressoraModel: TImpressoraModel): String;
    function alterar(AImpressoraModel: TImpressoraModel): String;
    function excluir(AImpressoraModel: TImpressoraModel): String;
	
    procedure obterLista;
    function carregaClasse(pId: Integer): TImpressoraModel;

end;

implementation

{ TImpressora }

uses VariaveisGlobais;

function TImpressoraDao.carregaClasse(pId: Integer): TImpressoraModel;
var
  lQry: TFDQuery;
  lModel: TImpressoraModel;
begin
  lQry     := xConexao.CriarQuery;
  lModel   := TImpressoraModel.Create;
  Result   := lModel;

  try
    lQry.Open('select * from impressora where id = '+pId.ToString);

    if lQry.IsEmpty then
      Exit;

    lModel.ID              := lQry.FieldByName('ID').AsString;
    lModel.NOME            := lQry.FieldByName('NOME').AsString;
    lModel.CAMINHO         := lQry.FieldByName('CAMINHO').AsString;
    lModel.VIAS            := lQry.FieldByName('VIAS').AsString;
    lModel.DIRETA          := lQry.FieldByName('DIRETA').AsString;
    lModel.LISTA_IMPRESSAO := lQry.FieldByName('LISTA_IMPRESSAO').AsString;
    lModel.CORTE           := lQry.FieldByName('CORTE').AsString;
    lModel.SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
    lModel.CABECALHO       := lQry.FieldByName('CABECALHO').AsString;
    lModel.CORPO           := lQry.FieldByName('CORPO').AsString;
    lModel.RODAPE          := lQry.FieldByName('RODAPE').AsString;
    lModel.PORTA           := lQry.FieldByName('PORTA').AsString;
    lModel.MODELO          := lQry.FieldByName('MODELO').AsString;
    lModel.RECIBO          := lQry.FieldByName('RECIBO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TImpressoraDao.Create;
begin

end;

destructor TImpressoraDao.Destroy;
begin

  inherited;
end;

function TImpressoraDao.incluir(AImpressoraModel: TImpressoraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := xConexao.CriarQuery;

  lSQL := '    insert into impressora (id,                 '+SLineBreak+
          '                            nome,               '+SLineBreak+
          '                            caminho,            '+SLineBreak+
          '                            vias,               '+SLineBreak+
          '                            direta,             '+SLineBreak+
          '                            lista_impressao,    '+SLineBreak+
          '                            corte,              '+SLineBreak+
          '                            cabecalho,          '+SLineBreak+
          '                            corpo,              '+SLineBreak+
          '                            rodape,             '+SLineBreak+
          '                            porta,              '+SLineBreak+
          '                            modelo,             '+SLineBreak+
          '                            recibo)             '+SLineBreak+
          '    values (:id,                                '+SLineBreak+
          '            :nome,                              '+SLineBreak+
          '            :caminho,                           '+SLineBreak+
          '            :vias,                              '+SLineBreak+
          '            :direta,                            '+SLineBreak+
          '            :lista_impressao,                   '+SLineBreak+
          '            :corte,                             '+SLineBreak+
          '            :cabecalho,                         '+SLineBreak+
          '            :corpo,                             '+SLineBreak+
          '            :rodape,                            '+SLineBreak+
          '            :porta,                             '+SLineBreak+
          '            :modelo,                            '+SLineBreak+
          '            :recibo)                            '+SLineBreak+
          ' returning ID                                   '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value := xConexao.Generetor('GEN_IMPRESSORA');
    setParams(lQry, AImpressoraModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TImpressoraDao.alterar(AImpressoraModel: TImpressoraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := xConexao.CriarQuery;

  lSQL :=  '  update impressora                            '+SLineBreak+
           '     set nome = :nome,                         '+SLineBreak+
           '         caminho = :caminho,                   '+SLineBreak+
           '         vias = :vias,                         '+SLineBreak+
           '         direta = :direta,                     '+SLineBreak+
           '         lista_impressao = :lista_impressao,   '+SLineBreak+
           '         corte = :corte,                       '+SLineBreak+
           '         cabecalho = :cabecalho,               '+SLineBreak+
           '         corpo = :corpo,                       '+SLineBreak+
           '         rodape = :rodape,                     '+SLineBreak+
           '         porta = :porta,                       '+SLineBreak+
           '         modelo = :modelo,                     '+SLineBreak+
           '         recibo = :recibo                      '+SLineBreak+
           '   where (id = :id)                            '+SLineBreak;

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('id').Value   := IIF(AImpressoraModel.ID   = '', Unassigned, AImpressoraModel.ID);
    setParams(lQry, AImpressoraModel);
    lQry.ExecSQL;

    Result := AImpressoraModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TImpressoraDao.excluir(AImpressoraModel: TImpressoraModel): String;
var
  lQry: TFDQuery;
begin
  lQry := xConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from impressora where ID = :ID',[AImpressoraModel.ID]);
   lQry.ExecSQL;
   Result := AImpressoraModel.ID;

  finally
    lQry.Free;
  end;
end;

function TImpressoraDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and impressora.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TImpressoraDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := xConexao.CriarQuery;

    lSql := 'select count(*) records From impressora where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TImpressoraDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := xConexao.CriarQuery;

  FImpressorasLista := TObjectList<TImpressoraModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '        impressora.*            '+
	    '   from impressora              '+
      '  where 1=1                     ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FImpressorasLista.Add(TImpressoraModel.Create);

      i := FImpressorasLista.Count -1;

      FImpressorasLista[i].ID              := lQry.FieldByName('ID').AsString;
      FImpressorasLista[i].NOME            := lQry.FieldByName('NOME').AsString;
      FImpressorasLista[i].CAMINHO         := lQry.FieldByName('CAMINHO').AsString;
      FImpressorasLista[i].VIAS            := lQry.FieldByName('VIAS').AsString;
      FImpressorasLista[i].DIRETA          := lQry.FieldByName('DIRETA').AsString;
      FImpressorasLista[i].LISTA_IMPRESSAO := lQry.FieldByName('LISTA_IMPRESSAO').AsString;
      FImpressorasLista[i].CORTE           := lQry.FieldByName('CORTE').AsString;
      FImpressorasLista[i].SYSTIME         := lQry.FieldByName('SYSTIME').AsString;
      FImpressorasLista[i].CABECALHO       := lQry.FieldByName('CABECALHO').AsString;
      FImpressorasLista[i].CORPO           := lQry.FieldByName('CORPO').AsString;
      FImpressorasLista[i].RODAPE          := lQry.FieldByName('RODAPE').AsString;
      FImpressorasLista[i].PORTA           := lQry.FieldByName('PORTA').AsString;
      FImpressorasLista[i].MODELO          := lQry.FieldByName('MODELO').AsString;
      FImpressorasLista[i].RECIBO          := lQry.FieldByName('RECIBO').AsString;
      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TImpressoraDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TImpressoraDao.SetImpressorasLista(const Value: TObjectList<TImpressoraModel>);
begin
  FImpressorasLista := Value;
end;

procedure TImpressoraDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TImpressoraDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TImpressoraDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TImpressoraDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TImpressoraDao.setParams(var pQry: TFDQuery; pImpressoraModel: TImpressoraModel);
begin
  pQry.ParamByName('nome').Value            := IIF(pImpressoraModel.NOME            = '', Unassigned, pImpressoraModel.NOME);
  pQry.ParamByName('caminho').Value         := IIF(pImpressoraModel.CAMINHO         = '', Unassigned, pImpressoraModel.CAMINHO);
  pQry.ParamByName('vias').Value            := IIF(pImpressoraModel.VIAS            = '', Unassigned, pImpressoraModel.VIAS);
  pQry.ParamByName('direta').Value          := IIF(pImpressoraModel.DIRETA          = '', Unassigned, pImpressoraModel.DIRETA);
  pQry.ParamByName('lista_impressao').Value := IIF(pImpressoraModel.LISTA_IMPRESSAO = '', Unassigned, pImpressoraModel.LISTA_IMPRESSAO);
  pQry.ParamByName('corte').Value           := IIF(pImpressoraModel.CORTE           = '', Unassigned, pImpressoraModel.CORTE);
  pQry.ParamByName('cabecalho').Value       := IIF(pImpressoraModel.CABECALHO       = '', Unassigned, pImpressoraModel.CABECALHO);
  pQry.ParamByName('corpo').Value           := IIF(pImpressoraModel.CORPO           = '', Unassigned, pImpressoraModel.CORPO);
  pQry.ParamByName('rodape').Value          := IIF(pImpressoraModel.RODAPE          = '', Unassigned, pImpressoraModel.RODAPE);
  pQry.ParamByName('porta').Value           := IIF(pImpressoraModel.PORTA           = '', Unassigned, pImpressoraModel.PORTA);
  pQry.ParamByName('modelo').Value          := IIF(pImpressoraModel.MODELO          = '', Unassigned, pImpressoraModel.MODELO);
  pQry.ParamByName('recibo').Value          := IIF(pImpressoraModel.RECIBO          = '', Unassigned, pImpressoraModel.RECIBO);

end;

procedure TImpressoraDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TImpressoraDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TImpressoraDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
