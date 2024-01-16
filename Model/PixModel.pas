unit PixModel;

interface

uses
  Terasoft.Enumerado,
  System.Generics.Collections;

type
  TPixModel = class

  private
    FPixsLista: TObjectList<TPixModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    Fcontasreceberitens_id: Variant;
    Fmulta_tipo: Variant;
    Fjuros_tipo: Variant;
    Fdata_pagamento: Variant;
    Fvalor: Variant;
    Fmulta_valor: Variant;
    Fjuros_valor: Variant;
    Fdata_cadastro: Variant;
    Fvalor_recebido: Variant;
    Fvencimento: Variant;
    Fcliente_id: Variant;
    Fpix_id: Variant;
    Fdocumento: Variant;
    Fid: Variant;
    Fdesconto_tipo: Variant;
    Fdesconto_data: Variant;
    Fsystime: Variant;
    Fmensagem: Variant;
    Fpix_url: Variant;
    Fexpira: Variant;
    Fpix_tipo: Variant;
    Fdesconto_valor: Variant;
    Fpix_data: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetPixsLista(const Value: TObjectList<TPixModel>);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure Setcliente_id(const Value: Variant);
    procedure Setcontasreceberitens_id(const Value: Variant);
    procedure Setdata_cadastro(const Value: Variant);
    procedure Setdata_pagamento(const Value: Variant);
    procedure Setdesconto_data(const Value: Variant);
    procedure Setdesconto_tipo(const Value: Variant);
    procedure Setdesconto_valor(const Value: Variant);
    procedure Setdocumento(const Value: Variant);
    procedure Setexpira(const Value: Variant);
    procedure Setid(const Value: Variant);
    procedure Setjuros_tipo(const Value: Variant);
    procedure Setjuros_valor(const Value: Variant);
    procedure Setmensagem(const Value: Variant);
    procedure Setmulta_tipo(const Value: Variant);
    procedure Setmulta_valor(const Value: Variant);
    procedure Setpix_data(const Value: Variant);
    procedure Setpix_id(const Value: Variant);
    procedure Setpix_tipo(const Value: Variant);
    procedure Setpix_url(const Value: Variant);
    procedure Setsystime(const Value: Variant);
    procedure Setvalor(const Value: Variant);
    procedure Setvalor_recebido(const Value: Variant);
    procedure Setvencimento(const Value: Variant);
  public
    property id: Variant read Fid write Setid;
    property data_cadastro: Variant read Fdata_cadastro write Setdata_cadastro;
    property systime: Variant read Fsystime write Setsystime;
    property cliente_id: Variant read Fcliente_id write Setcliente_id;
    property valor: Variant read Fvalor write Setvalor;
    property vencimento: Variant read Fvencimento write Setvencimento;
    property expira: Variant read Fexpira write Setexpira;
    property mensagem: Variant read Fmensagem write Setmensagem;
    property documento: Variant read Fdocumento write Setdocumento;
    property juros_tipo: Variant read Fjuros_tipo write Setjuros_tipo;
    property juros_valor: Variant read Fjuros_valor write Setjuros_valor;
    property multa_tipo: Variant read Fmulta_tipo write Setmulta_tipo;
    property multa_valor: Variant read Fmulta_valor write Setmulta_valor;
    property desconto_tipo: Variant read Fdesconto_tipo write Setdesconto_tipo;
    property desconto_valor: Variant read Fdesconto_valor write Setdesconto_valor;
    property desconto_data: Variant read Fdesconto_data write Setdesconto_data;
    property pix_id: Variant read Fpix_id write Setpix_id;
    property pix_data: Variant read Fpix_data write Setpix_data;
    property pix_url: Variant read Fpix_url write Setpix_url;
    property pix_tipo: Variant read Fpix_tipo write Setpix_tipo;
    property valor_recebido: Variant read Fvalor_recebido write Setvalor_recebido;
    property data_pagamento: Variant read Fdata_pagamento write Setdata_pagamento;
    property contasreceberitens_id: Variant read Fcontasreceberitens_id write Setcontasreceberitens_id;

  	constructor Create;
    destructor Destroy; override;

    function Salvar: String;
    procedure obterLista;

    function carregaClasse(pId: String): TPixModel;
    function carregaClasseIndexOf(pIndex: Integer): TPixModel;

    property PixsLista: TObjectList<TPixModel> read FPixsLista write SetPixsLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

  end;

implementation

uses
  PixDao;

{ TPixModel }

function TPixModel.carregaClasse(pId: String): TPixModel;
var
  lPixDao: TPixDao;
begin
  lPixDao := TPixDao.Create;

  try
    Result := lPixDao.carregaClasse(pId);
  finally
    lPixDao.Free;
  end;
end;

function TPixModel.carregaClasseIndexOf(pIndex: Integer): TPixModel;
begin
  Result := FPixsLista[pIndex];
end;

constructor TPixModel.Create;
begin

end;

destructor TPixModel.Destroy;
begin


end;

procedure TPixModel.obterLista;
var
  lPixLista: TPixDao;
begin
  lPixLista := TPixDao.Create;

  try
    lPixLista.TotalRecords    := FTotalRecords;
    lPixLista.WhereView       := FWhereView;
    lPixLista.CountView       := FCountView;
    lPixLista.OrderView       := FOrderView;
    lPixLista.StartRecordView := FStartRecordView;
    lPixLista.LengthPageView  := FLengthPageView;
    lPixLista.IDRecordView    := FIDRecordView;

    lPixLista.obterLista;

    FTotalRecords  := lPixLista.TotalRecords;
    FPixsLista := lPixLista.PixsLista;

  finally
    lPixLista.Free;
  end;
end;

function TPixModel.Salvar: String;
var
  lPixDao: TPixDao;
begin
  lPixDao := TPixDao.Create;

  Result := '';

  try
    case FAcao of
      Terasoft.Enumerado.tacIncluir: Result := lPixDao.incluir(Self);
      Terasoft.Enumerado.tacAlterar: Result := lPixDao.alterar(Self);
      Terasoft.Enumerado.tacExcluir: Result := lPixDao.excluir(Self);
    end;

  finally
    lPixDao.Free;
  end;
end;

procedure TPixModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TPixModel.Setcliente_id(const Value: Variant);
begin
  Fcliente_id := Value;
end;

procedure TPixModel.Setcontasreceberitens_id(const Value: Variant);
begin
  Fcontasreceberitens_id := Value;
end;

procedure TPixModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;


procedure TPixModel.Setdata_cadastro(const Value: Variant);
begin
  Fdata_cadastro := Value;
end;

procedure TPixModel.Setdata_pagamento(const Value: Variant);
begin
  Fdata_pagamento := Value;
end;

procedure TPixModel.Setdesconto_data(const Value: Variant);
begin
  Fdesconto_data := Value;
end;

procedure TPixModel.Setdesconto_tipo(const Value: Variant);
begin
  Fdesconto_tipo := Value;
end;

procedure TPixModel.Setdesconto_valor(const Value: Variant);
begin
  Fdesconto_valor := Value;
end;

procedure TPixModel.Setdocumento(const Value: Variant);
begin
  Fdocumento := Value;
end;

procedure TPixModel.Setexpira(const Value: Variant);
begin
  Fexpira := Value;
end;

procedure TPixModel.Setid(const Value: Variant);
begin
  Fid := Value;
end;

procedure TPixModel.SetPixsLista(const Value: TObjectList<TPixModel>);
begin
  FPixsLista := Value;
end;

procedure TPixModel.Setpix_data(const Value: Variant);
begin
  Fpix_data := Value;
end;

procedure TPixModel.Setpix_id(const Value: Variant);
begin
  Fpix_id := Value;
end;

procedure TPixModel.Setpix_tipo(const Value: Variant);
begin
  Fpix_tipo := Value;
end;

procedure TPixModel.Setpix_url(const Value: Variant);
begin
  Fpix_url := Value;
end;

procedure TPixModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TPixModel.Setjuros_tipo(const Value: Variant);
begin
  Fjuros_tipo := Value;
end;

procedure TPixModel.Setjuros_valor(const Value: Variant);
begin
  Fjuros_valor := Value;
end;

procedure TPixModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TPixModel.Setmensagem(const Value: Variant);
begin
  Fmensagem := Value;
end;

procedure TPixModel.Setmulta_tipo(const Value: Variant);
begin
  Fmulta_tipo := Value;
end;

procedure TPixModel.Setmulta_valor(const Value: Variant);
begin
  Fmulta_valor := Value;
end;

procedure TPixModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TPixModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TPixModel.Setsystime(const Value: Variant);
begin
  Fsystime := Value;
end;

procedure TPixModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TPixModel.Setvalor(const Value: Variant);
begin
  Fvalor := Value;
end;

procedure TPixModel.Setvalor_recebido(const Value: Variant);
begin
  Fvalor_recebido := Value;
end;

procedure TPixModel.Setvencimento(const Value: Variant);
begin
  Fvencimento := Value;
end;

procedure TPixModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
