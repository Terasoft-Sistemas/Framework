unit DashbordModel;

interface

uses
  Terasoft.Types,
  Classes, SysUtils,
  Terasoft.Framework.Types,
  Terasoft.Framework.Collections,
  Generics.Defaults,
  Generics.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  Terasoft.Framework.Texto,
  FireDAC.Comp.Client;

type
  TStatusDashboardAsync = (sda_Idle, sda_Running, sda_Done);

  TDashbordModel = class;
  ITDashbordModel=IObject<TDashbordModel>;

  TDashboardProc = reference to function(pConexao: IConexao; pParam: TDashbord_Parametros): IFDDataset;

  IResultadoDashboard = interface
  ['{6844797F-81E2-43A2-A229-1B0F04F042BA}']
    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);

    //property parametros getter/setter
      function getParametros: TDashbord_Parametros;
      procedure setParametros(const pValue: TDashbord_Parametros);

    //property dataset getter/setter
      function getDataset: IFDDataset;
      procedure setDataset(const pValue: IFDDataset);

    //property status getter/setter
      function getStatus: TStatusDashboardAsync;
      procedure setStatus(const pValue: TStatusDashboardAsync);

      function espera: TStatusDashboardAsync;
      procedure run(pModel: ITDashbordModel; pProc: TDashboardProc; pParam: TDashbord_Parametros);

    //property operacao getter/setter
      function getOperacao: TOperacoesDashboardAsync;
      procedure setOperacao(const pValue: TOperacoesDashboardAsync);

    //property conexao getter/setter
      function getConexao: IConexao;
      procedure setConexao(const pValue: IConexao);

    //property proc getter/setter
      function getProc: TDashboardProc;
      procedure setProc(const pValue: TDashboardProc);

      property proc: TDashboardProc read getProc write setProc;
      property conexao: IConexao read getConexao write setConexao;
      property operacao: TOperacoesDashboardAsync read getOperacao write setOperacao;
      property status: TStatusDashboardAsync read getStatus write setStatus;
      property dataset: IFDDataset read getDataset write setDataset;
      property parametros: TDashbord_Parametros read getParametros write setParametros;
      property resultado: IResultadoOperacao read getResultado write setResultado;
  end;

  TLockDictionaryImplDashBoard = ILockDictionary<TOperacoesDashboardAsync,IResultadoDashboard>;

  TDashbordModel = class
  private
    [weak] mySelf: ITDashbordModel;
    vIConexao : IConexao;
    vListaOld: ILockList<IResultadoDashboard>;
    vLista: TLockDictionaryImplDashBoard;
    vOperacoes: array [od_totalizador..od_filiais] of TDashboardProc;

  protected
    procedure checkAsync(pDashbord_Parametros: TDashbord_Parametros);

  public

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    procedure clear;
    procedure clearOld;

    class function getNewIface(pIConexao: IConexao): ITDashbordModel;

    function ObterQuery1_Totalizador(pDashbord_Parametros: TDashbord_Parametros): IResultadoDashboard;
    function ObterQuery2_VendaPorDia(pDashbord_Parametros: TDashbord_Parametros): IResultadoDashboard;
    function ObterQuery3_VendaPorAno(pDashbord_Parametros: TDashbord_Parametros): IResultadoDashboard;
    function ObterQuery4_VendaPorHora(pDashbord_Parametros: TDashbord_Parametros): IResultadoDashboard;
    function ObterQuery6_RankingVendedores(pDashbord_Parametros: TDashbord_Parametros): IResultadoDashboard;
    function ObterQuery7_RankingFiliais(pDashbord_Parametros: TDashbord_Parametros): IResultadoDashboard;
    function ObterQuery_Anos(pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
  end;

implementation

uses
  DashbordDao;

  type

    TResultadoDashboardImpl=class(TInterfacedObject, IResultadoDashboard)
    protected
      fResultado: IResultadoOperacao;
      fParametros: TDashbord_Parametros;
      fDataset: IFDDataset;
      fStatus: TStatusDashboardAsync;
      vTh: TThread;
      vModel: ITDashbordModel;
      fOperacao: TOperacoesDashboardAsync;
      fConexao: IConexao;
      fProc: TDashboardProc;

    //property proc getter/setter
      function getProc: TDashboardProc;
      procedure setProc(const pValue: TDashboardProc);

    //property conexao getter/setter
      function getConexao: IConexao;
      procedure setConexao(const pValue: IConexao);

    //property operacao getter/setter
      function getOperacao: TOperacoesDashboardAsync;
      procedure setOperacao(const pValue: TOperacoesDashboardAsync);

      procedure doIt;

      procedure run(pModel: ITDashbordModel; pProc: TDashboardProc; pParam: TDashbord_Parametros);

      function espera: TStatusDashboardAsync;

    //property status getter/setter
      function getStatus: TStatusDashboardAsync;
      procedure setStatus(const pValue: TStatusDashboardAsync);

    //property dataset getter/setter
      function getDataset: IFDDataset;
      procedure setDataset(const pValue: IFDDataset);

    //property parametros getter/setter
      function getParametros: TDashbord_Parametros;
      procedure setParametros(const pValue: TDashbord_Parametros);

    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);
    public
      destructor Destroy; override;

    end;


  var
    gTagStr: array [ od_totalizador .. od_filiais] of String = (
      'Totalizador',
      'Por dia',
      'Por hora',
      'Por ano',
      'Vendedores',
      'Filiais'
//      'Anos'
    );

function doObterQuery7_RankingFiliais(pConexao: IConexao; pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(pConexao);

  lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
  lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
  lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
  lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
  lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
  lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
  lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
  lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
  lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

  Result := lDashbordDao.objeto.ObterQuery7_RankingFiliais(lDashbord_Parametros);

end;

function doObterQuery6_RankingVendedores(pConexao: IConexao;  pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(pConexao);

  try
    lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
    lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
    lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
    lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
    lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
    lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
    lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
    lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
    lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;
    lDashbord_Parametros.TipoAnalise    := pDashbord_Parametros.TipoAnalise;

    Result := lDashbordDao.objeto.ObterQuery6_RankingVendedores(lDashbord_Parametros);

  finally
    lDashbordDao:=nil;
  end;
end;

function doObterQuery_Anos(pConexao: IConexao; pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(pConexao);

  lDashbord_Parametros.Lojas := pDashbord_Parametros.Lojas;

  Result := lDashbordDao.objeto.ObterQuery_Anos(lDashbord_Parametros);

end;

function doObterQuery3_VendaPorAno(pConexao: IConexao; pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin

  lDashbordDao := TDashbordDao.getNewIface(pConexao);

  lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
  lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
  lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
  lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
  lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
  lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
  lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
  lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
  lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

  Result := lDashbordDao.objeto.ObterQuery3_VendaPorAno(lDashbord_Parametros);

end;

function doObterQuery4_VendaPorHora(pConexao: IConexao; pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(pConexao);

  try
    lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
    lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
    lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
    lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
    lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
    lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
    lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
    lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
    lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

    Result := lDashbordDao.objeto.ObterQuery4_VendaPorHora(lDashbord_Parametros);

  finally
    lDashbordDao:=nil;
  end;
end;


function doObterQuery2_VendaPorDia(pConexao: IConexao; pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(pConexao);

  lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
  lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
  lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
  lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
  lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
  lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
  lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
  lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
  lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

  Result := lDashbordDao.objeto.ObterQuery2_VendaPorDia(lDashbord_Parametros);

end;

function doObterQuery1_Totalizador(pConexao: IConexao; pDashbord_Parametros: TDashbord_Parametros): IFDDataset;
var
  lDashbordDao: ITDashbordDao;
  lDashbord_Parametros: TDashbord_Parametros;
begin
  lDashbordDao := TDashbordDao.getNewIface(pConexao);

  lDashbord_Parametros.TipoData       := pDashbord_Parametros.TipoData;
  lDashbord_Parametros.DataInicio     := pDashbord_Parametros.DataInicio;
  lDashbord_Parametros.DataFim        := pDashbord_Parametros.DataFim;
  lDashbord_Parametros.Lojas          := pDashbord_Parametros.Lojas;
  lDashbord_Parametros.SomarST        := pDashbord_Parametros.SomarST;
  lDashbord_Parametros.SomarAcrescimo := pDashbord_Parametros.SomarAcrescimo;
  lDashbord_Parametros.SomarIPI       := pDashbord_Parametros.SomarIPI;
  lDashbord_Parametros.SomarFrete     := pDashbord_Parametros.SomarFrete;
  lDashbord_Parametros.Vendedores     := pDashbord_Parametros.Vendedores;

  Result := lDashbordDao.objeto.ObterQuery1_Totalizador(lDashbord_Parametros);

end;

{ TDashbordModel }

constructor TDashbordModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vOperacoes[od_totalizador] := doObterQuery1_Totalizador;
  vOperacoes[od_pordia] := doObterQuery2_VendaPorDia;
  vOperacoes[od_porano] := doObterQuery3_VendaPorAno;
  vOperacoes[od_porhora] := doObterQuery4_VendaPorHora;
  vOperacoes[od_vendedores] := doObterQuery6_RankingVendedores;
  vOperacoes[od_filiais] := doObterQuery7_RankingFiliais;
//  vOperacoes[od_anos] := doObterQuery_Anos;
end;

procedure TDashbordModel.checkAsync(pDashbord_Parametros: TDashbord_Parametros);
  var
    res: IResultadoDashboard;

    op: TOperacoesDashboardAsync;
    i: Integer;
begin
  if(vLista=nil) then
    vLista := TLockDictionaryImpl<TOperacoesDashboardAsync,IResultadoDashboard>.Create;

  clearOld;

  for op := low(TOperacoesDashboardAsync) to high(TOperacoesDashboardAsync) do
  begin
    if not vLista.TryGetValue(op,res) then
    begin
      res := TResultadoDashboardImpl.Create;
      res.operacao := op;

      if(pDashbord_Parametros.expandeAsync=[]) or (op in pDashbord_Parametros.expandeAsync) then
        res.run(myself,vOperacoes[op],pDashbord_Parametros);
      vLista.addOrSetValue(op,res);
    end;
  end;
end;

procedure TDashbordModel.clear;
  var
    par: TPair<TOperacoesDashboardAsync,IResultadoDashboard>;
    i: Integer;
    p: IResultadoDashboard;
begin
  if(vLista<>nil) and (vLista.count>0) then
  begin
    if(vListaOld=nil) then
      vListaOld := TLockListImpl<IResultadoDashboard>.Create;
      while vLista.unstack(par) do
        if(par.Value.status=sda_Running) then
          vListaOld.add(par.Value);
    i := vListaOld.count;

    while i > 0 do
    begin
      dec(i);
      vListaOld.get(i,p);
      if(p.status<>sda_Running) then
        vListaOld.delete(i);
    end;

    if(vListaOld.count=0) then
      vListaOld:=nil;
  end;
end;

procedure TDashbordModel.clearOld;
  var
    i: Integer;
    p: IResultadoDashboard;
begin
  if(vListaOld<>nil) then
  begin
    i := vListaOld.count;

    while i > 0 do
    begin
      dec(i);
      vListaOld.get(i,p);
      if(p.status<>sda_Running) then
        vListaOld.delete(i);
    end;

    if(vListaOld.count=0) then
      vListaOld:=nil;
  end;
end;

destructor TDashbordModel.Destroy;
begin
  vLista := nil;
  vListaOld := nil;
  inherited;
end;

class function TDashbordModel.getNewIface(pIConexao: IConexao): ITDashbordModel;
begin
  Result := TImplObjetoOwner<TDashbordModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDashbordModel.ObterQuery1_Totalizador;
begin
  checkAsync(pDashbord_Parametros);
  vLista.TryGetValue(od_totalizador,Result);
  Result.espera;
  if(Result.status=sda_Idle) or (Result.parametros.compare(pDashbord_Parametros)=false) then
  begin
    Result.run(myself,doObterQuery1_Totalizador,pDashbord_Parametros);
  end;
  Result.espera;
end;

function TDashbordModel.ObterQuery2_VendaPorDia;
begin
  checkAsync(pDashbord_Parametros);
  vLista.TryGetValue(od_pordia,Result);
  Result.espera;
  if(Result.status=sda_Idle) or (Result.parametros.compare(pDashbord_Parametros)=false) then
  begin
    Result.run(myself,doObterQuery2_VendaPorDia,pDashbord_Parametros);
  end;
  Result.espera;
end;

function TDashbordModel.ObterQuery3_VendaPorAno;
begin
  checkAsync(pDashbord_Parametros);
  vLista.TryGetValue(od_porano,Result);
  Result.espera;
  if(Result.status=sda_Idle) or (Result.parametros.compare(pDashbord_Parametros)=false) then
  begin
    Result.run(myself,doObterQuery3_VendaPorAno,pDashbord_Parametros);
  end;
  Result.espera;
end;

function TDashbordModel.ObterQuery4_VendaPorHora;
begin
  checkAsync(pDashbord_Parametros);
  vLista.TryGetValue(od_porhora,Result);
  Result.espera;
  if(Result.status=sda_Idle) or (Result.parametros.compare(pDashbord_Parametros)=false) then
  begin
    Result.run(myself,doObterQuery4_VendaPorHora,pDashbord_Parametros);
  end;
  Result.espera;
end;

function TDashbordModel.ObterQuery6_RankingVendedores;
begin
  checkAsync(pDashbord_Parametros);
  vLista.TryGetValue(od_vendedores,Result);
  Result.espera;
  if(Result.status=sda_Idle) or (Result.parametros.compare(pDashbord_Parametros)=false) then
  begin
    Result.run(myself,doObterQuery6_RankingVendedores,pDashbord_Parametros);
  end;
  Result.espera;
end;

function TDashbordModel.ObterQuery7_RankingFiliais;
begin
  checkAsync(pDashbord_Parametros);
  vLista.TryGetValue(od_filiais,Result);
  Result.espera;
  if(Result.status=sda_Idle) or (Result.parametros.compare(pDashbord_Parametros)=false) then
  begin
    Result.run(myself,doObterQuery7_RankingFiliais,pDashbord_Parametros);
  end;
  Result.espera;
end;

function TDashbordModel.ObterQuery_Anos;
begin
{  checkAsync(pDashbord_Parametros);
  vLista.TryGetValue(od_anos,Result);
  Result.espera;
  if(Result.status=sda_Idle) or (Result.parametros.compare(pDashbord_Parametros)=false) then
  begin
    Result.run(myself,doObterQuery_Anos,pDashbord_Parametros);
  end;
  Result.espera;}

  Result := doObterQuery_Anos(vIConexao,pDashbord_Parametros);
end;

{ TResultadoDashboardImpl }

procedure TResultadoDashboardImpl.setProc(const pValue: TDashboardProc);
begin
  fProc := pValue;
end;

function TResultadoDashboardImpl.getProc: TDashboardProc;
begin
  Result := fProc;
end;

procedure TResultadoDashboardImpl.setConexao(const pValue: IConexao);
begin
  fConexao := pValue;
end;

function TResultadoDashboardImpl.getConexao: IConexao;
begin
  Result := fConexao;
end;

procedure TResultadoDashboardImpl.setOperacao(const pValue: TOperacoesDashboardAsync);
begin
  fOperacao := pValue;
end;

function TResultadoDashboardImpl.getOperacao: TOperacoesDashboardAsync;
begin
  Result := fOperacao;
end;

procedure TResultadoDashboardImpl.setStatus(const pValue: TStatusDashboardAsync);
begin
  fStatus := pValue;
end;

function TResultadoDashboardImpl.getStatus: TStatusDashboardAsync;
begin
  Result := fStatus;
end;

procedure TResultadoDashboardImpl.run;
begin
  espera;
  try
    vModel := pModel;
    fConexao := pModel.objeto.vIConexao;
    fResultado := nil;

    fProc := pProc;
    fParametros := pParam;

    fConexao := fConexao.NovaConexao(fConexao.empresa.loja);
    fStatus := sda_Running;
    TThread.CreateAnonymousThread(doIt).Start;
  except
    on
      e: exception do
        getResultado.formataErro('TResultadoDashboardImpl.run: %s: %s', [ e.ClassName, e.Message ] );
  end;

end;

procedure TResultadoDashboardImpl.setDataset(const pValue: IFDDataset);
begin
  fDataset := pValue;
end;

destructor TResultadoDashboardImpl.Destroy;
begin
  espera;
  inherited;
end;

procedure TResultadoDashboardImpl.doIt;
begin
  fStatus := sda_Running;
  try
    try
      if assigned(fProc) then
        fDataset := fProc(fConexao, fParametros);
    except
      on e: Exception do
      begin
        getResultado.formataErro('Resultado dashboard async: [%s] %s: %s', [ gTagStr[fOperacao], e.ClassName, e.Message ]);
      end;
    end;

  finally
    fStatus := sda_Done;
    vModel := nil;
  end;
end;

function TResultadoDashboardImpl.espera;
begin
  while fStatus=sda_Running do
    sleep(10);
  //vTh := nil;
  Result := fStatus;
end;

function TResultadoDashboardImpl.getDataset: IFDDataset;
begin
  Result := fDataset;
end;

procedure TResultadoDashboardImpl.setParametros(const pValue: TDashbord_Parametros);
begin
  fParametros := pValue;
end;

function TResultadoDashboardImpl.getParametros: TDashbord_Parametros;
begin
  Result := fParametros;
end;

procedure TResultadoDashboardImpl.setResultado(const pValue: IResultadoOperacao);
begin
  fResultado := pValue;
end;

function TResultadoDashboardImpl.getResultado: IResultadoOperacao;
begin
  Result := checkResultadoOperacao(fResultado);
end;

end.
