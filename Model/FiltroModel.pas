unit FiltroModel;

interface
uses
  Terasoft.Framework.Types,
  System.SysUtils,
  Spring.Collections,
  Terasoft.Framework.MultiConfig,
  Terasoft.Framework.Texto,
  Terasoft.Framework.ObjectIface,
  Terasoft.Framework.DB,
  Interfaces.Conexao;

type
  TFiltroModel=class;
  ITFiltroModel=IObject<TFiltroModel>;
  TListaFiltroModel=IList<ITFiltroModel>;

  TFiltroModel=class
  private
    [weak] mySelf: ITFiltroModel;
    //function getValores: IDatasetSimples;
  protected
    vIConexao   : IConexao;

    fID: TipoWideStringFramework;
    fNOME: TipoWideStringFramework;
    fDESCRICAO: TipoWideStringFramework;
    fPROPRIEDADES: TipoWideStringFramework;

    function getValido: boolean;

  //property ID getter/setter
    function getID: TipoWideStringFramework;
    procedure setID(const pValue: TipoWideStringFramework);

  //property DESCRICAO getter/setter
    function getDESCRICAO: TipoWideStringFramework;
    procedure setDESCRICAO(const pValue: TipoWideStringFramework);

  //property QUERY getter/setter
    function getPROPRIEDADES: TipoWideStringFramework;
    procedure setPROPRIEDADES(const pValue: TipoWideStringFramework);

  //property NOME getter/setter
    function getNOME: TipoWideStringFramework;
    procedure setNOME(const pValue: TipoWideStringFramework);

  public
    property ID: TipoWideStringFramework read getID write setID;
    property NOME: TipoWideStringFramework read getNOME write setNOME;
    property DESCRICAO: TipoWideStringFramework read getDESCRICAO write setDESCRICAO;
    property PROPRIEDADES: TipoWideStringFramework read getPROPRIEDADES write setPROPRIEDADES;

    //Se não é válido, deverá usar BUSCA AVNÇADA...
    property valido: boolean read getValido;

  protected
    function getCFG: IMultiConfig;
    function listaOpcoes: IListaTextoEX;

  public
    const
      _TABELA_ = 'FILTROS';
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITFiltroModel;

    function getOpcoes: IDatasetSimples;

  end;


implementation
  uses
    DBClient;
{ TFiltroModel }

constructor TFiltroModel.Create(pIConexao: IConexao);
begin
  inherited Create;
  vIConexao := pIConexao;
end;

destructor TFiltroModel.Destroy;
begin
  vIConexao:=nil;
  inherited;
end;

class function TFiltroModel.getNewIface(pIConexao: IConexao): ITFiltroModel;
begin
  Result := TImplObjetoOwner<TFiltroModel>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TFiltroModel.setID(const pValue: TipoWideStringFramework);
begin
  fID := pValue;
end;

function TFiltroModel.getID: TipoWideStringFramework;
begin
  Result := fID;
end;

procedure TFiltroModel.setNOME(const pValue: TipoWideStringFramework);
begin
  fNOME := pValue;
end;

function TFiltroModel.getNOME: TipoWideStringFramework;
begin
  Result := fNOME;
end;

procedure TFiltroModel.setPROPRIEDADES(const pValue: TipoWideStringFramework);
begin
  fPROPRIEDADES := pValue;
end;

function TFiltroModel.getPROPRIEDADES: TipoWideStringFramework;
begin
  Result := fPROPRIEDADES;
end;

function TFiltroModel.getValido: boolean;
begin
  Result := fPROPRIEDADES<>'';
end;

function TFiltroModel.getOpcoes: IDatasetSimples;
  var
    lOpcoesTxt: IListaTextoEx;
    i: Integer;
    lName, lValue: String;
begin
  Result := nil;
  if not valido then
    exit;

  lOpcoesTxt := listaOpcoes;

  if (lOpcoesTxt.strings.Count>0) then
  begin
    Result := getGenericID_DescricaoDataset;
    Result.dataset.Fields[0].DisplayLabel := 'Código';
    Result.dataset.Fields[1].DisplayLabel := 'Descrição';
    for i := 0 to lOpcoesTxt.strings.Count - 1 do
    begin
      lName := lOpcoesTxt.strings.Names[i];
      lValue := lOpcoesTxt.strings.ValueFromIndex[i];
      Result.dataset.Append;
      Result.dataset.FieldValues['ID;DESCRICAO'] := array2Variant([lName,lValue]);
      Result.dataset.CheckBrowseMode;
    end;
    exit;
  end else
  begin

  end;
end;

function TFiltroModel.getCFG: IMultiConfig;
begin
  Result := criaMultiConfig.adicionaInterface(criaConfigIniString(fPROPRIEDADES));
end;



function TFiltroModel.listaOpcoes: IListaTextoEX;
begin
  Result := getCFG.ReadSectionValuesLista('opcoes');
end;

procedure TFiltroModel.setDESCRICAO(const pValue: TipoWideStringFramework);
begin
  fDESCRICAO := pValue;
end;

function TFiltroModel.getDESCRICAO: TipoWideStringFramework;
begin
  Result := fDESCRICAO;
end;

end.
