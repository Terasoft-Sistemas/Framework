
{$i definicoes.inc}

unit Terasoft.Framework.PoolThreads;

interface
  uses
    Classes,SysUtils,
    Terasoft.Framework.Timer,
    Terasoft.Framework.Types,
    Terasoft.Framework.Texto,
    Terasoft.Framework.Collections;

  type
    TStatusProcesso = (spOcioso,spEsperando,spRodando);

    TProcessoAnonimoProc = reference to function (pResultado: IResultadoOperacao): IResultadoOperacao;

    IProcesso = interface
    ['{153A322D-221D-4339-BD54-E48975CA7F71}']
      procedure executar;

      procedure esperar;

      procedure runAsync;

    //property status getter/setter
      function getStatus: TStatusProcesso;
      procedure setStatus(const pValue: TStatusProcesso);

    //property rotulo getter/setter
      function getRotulo: TipoWideStringFramework;
      procedure setRotulo(const pValue: TipoWideStringFramework);

    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);

    //property tempoInicio getter/setter
      function getTempoInicio: PTRTimerData;
      procedure setTempoInicio(const pValue: PTRTimerData);

    //property tempoCriacao getter/setter
      function getTempoCriacao: PTRTimerData;
      procedure setTempoCriacao(const pValue: PTRTimerData);

    //property tempoFim getter/setter
      function getTempoFim: PTRTimerData;
      procedure setTempoFim(const pValue: PTRTimerData);

      // tempo de execução em milisecs
      function tempoExecucao: Int64;

      property tempoFim: PTRTimerData read getTempoFim write setTempoFim;
      property tempoCriacao: PTRTimerData read getTempoCriacao write setTempoCriacao;
      property tempoInicio: PTRTimerData read getTempoInicio write setTempoInicio;
      property resultado: IResultadoOperacao read getResultado write setResultado;
      property rotulo: TipoWideStringFramework read getRotulo write setRotulo;
      property status: TStatusProcesso read getStatus write setStatus;

    end;

    TBaseProcessoThread=class(TInterfacedObject,
          IProcesso
    )
    protected
      fStatus: TStatusProcesso;
      fRotulo: TipoWideStringFramework;
      fResultado: IResultadoOperacao;
      fTempoCriacao: TRTimerData;
      fTempoInicio: TRTimerData;
      fTempoFim: TRTimerData;

    //property tempoFim getter/setter
      function getTempoFim: PTRTimerData;
      procedure setTempoFim(const pValue: PTRTimerData);

    //property tempoCriacao getter/setter
      function getTempoCriacao: PTRTimerData;
      procedure setTempoCriacao(const pValue: PTRTimerData);

    //property tempoInicio getter/setter
      function getTempoInicio: PTRTimerData;
      procedure setTempoInicio(const pValue: PTRTimerData);

    //property resultado getter/setter
      function getResultado: IResultadoOperacao;
      procedure setResultado(const pValue: IResultadoOperacao);

    //property rotulo getter/setter
      function getRotulo: TipoWideStringFramework;
      procedure setRotulo(const pValue: TipoWideStringFramework);

    //property status getter/setter
      function getStatus: TStatusProcesso;
      procedure setStatus(const pValue: TStatusProcesso);

      procedure doExecutar; virtual; abstract;
      procedure executar; virtual;

      procedure runAsync; virtual;

      function tempoExecucao: Int64; virtual;

      procedure esperar;

    public
      constructor Create(pRotulo: TipoWideStringFramework; pResultado: IResultadoOperacao);
      destructor Destroy; override;
    end;


  procedure executaProcesso(pProcesso: IProcesso);
  function criaProcessoAnonimo(pProcesso: TProcessoAnonimoProc; pRotulo: TipoWideStringFramework; pResultado: IResultadoOperacao=nil): IProcesso;
  procedure testaProcessos;

implementation
  uses
    Spring.Collections;

  type
    TThreadLocal = class(TThread)

    protected
      procedure Execute; override;
      procedure finaliza;

    public
      constructor Create;
      destructor Destroy; override;
    
    end;

    TProcessoAnonimo=class(TBaseProcessoThread)
    protected
      vProcessoAnonimo: TProcessoAnonimoProc;

      procedure doExecutar; override;

    public
      constructor Create(pProcesso: TProcessoAnonimoProc; pRotulo: TipoWideStringFramework; pResultado: IResultadoOperacao);
    end;



  var
    vListaProcessos: ILockList<IProcesso>;
    vListaThreads: ILockList<TThreadLocal>;

  const
    MAXIMO = 2;


procedure executaProcesso(pProcesso: IProcesso);
  var
    th: TThreadLocal;
begin
  if(pProcesso=nil) then exit;
  if(pProcesso.status<>spOcioso) then
    raise Exception.CreateFmt('executaProcesso: Processo [%s] não está ocioso', [ pProcesso.rotulo ]);

  pProcesso.status := spEsperando;

  vListaProcessos.add(pProcesso);

  if(vListaThreads.count<MAXIMO) then
  begin
    th := TThreadLocal.Create;
    th.FreeOnTerminate := true;
    th.Start;
  end;

end;

procedure cria;
begin
  if(vListaProcessos=nil) then
    vListaProcessos := TCreateLock.CreateList<IProcesso>;

  if(vListaThreads=nil) then
  begin
    vListaThreads := TCreateLock.CreateList<TThreadLocal>;
  end;
end;

{ TThreadLocal }

constructor TThreadLocal.Create;
begin
  inherited Create(true);
  vListaThreads.add(self);
end;

destructor TThreadLocal.Destroy;
begin
  if Terminated=false then
    finaliza;
  vListaThreads.remove(self);
  inherited;
end;

procedure TThreadLocal.Execute;
  var
    p: IProcesso;
begin
  inherited;
  while not Terminated do
  begin
    if vListaProcessos.unstack(p)=false then
    begin
      sleep(50);
      continue;
    end;
    try
      p.status := spRodando;
      p.executar;
      p.status := spOcioso;

    except
      on e: Exception do
      begin
        p.resultado.formataErro('TThreadLocal.Execute: [%s]: %s: %s', [p.rotulo, e.ClassName,e.Message]);
        p.status := spOcioso;
      end;
    end;
    p := nil;
    sleep(10);
  end;
  //Se terminou, vamos fianlziar os processos com erro.
  while vListaProcessos.unstack(p)=true do
  begin
    p.resultado.formataErro('TThreadLocal.Execute: [%s]: Processo finalizado', [p.rotulo]);
    p.status := spOcioso;
    p:=nil;
  end;
end;

procedure TThreadLocal.finaliza;
begin
  Terminate;
  WaitFor;
end;

{ TProcessoAnonimo }

procedure TBaseProcessoThread.setRotulo(const pValue: TipoWideStringFramework);
begin
  fRotulo := pValue;
end;

constructor TBaseProcessoThread.Create;
begin
  inherited Create;
  fStatus := spOcioso;
  fRotulo := pRotulo;
  fResultado := pResultado;
  fTempoCriacao := lrTimerGlobal.mark;
end;

destructor TBaseProcessoThread.Destroy;
begin
  esperar;
  inherited;
end;

procedure TBaseProcessoThread.executar;
begin
  fTempoInicio := lrTimerGlobal.mark;
  try
    doExecutar;
  finally
    fTempoFim := lrTimerGlobal.mark;
  end;
end;

procedure TBaseProcessoThread.esperar;
begin
  while (fStatus<>spOcioso) do
    sleep(50);
end;

function TBaseProcessoThread.getRotulo: TipoWideStringFramework;
begin
  Result := fRotulo;
end;

procedure TBaseProcessoThread.setResultado(const pValue: IResultadoOperacao);
begin
  fResultado := pValue;
end;

function TBaseProcessoThread.getResultado: IResultadoOperacao;
begin
  Result := checkResultadoOperacao(fResultado);
end;

procedure TBaseProcessoThread.setTempoInicio(const pValue: PTRTimerData);
begin
  fTempoInicio := pValue^;
end;

function TBaseProcessoThread.tempoExecucao: Int64;
begin
  Result := lrTimerGlobal.mSec(fTempoInicio,fTempoFim);
end;

function TBaseProcessoThread.getTempoInicio: PTRTimerData;
begin
  Result := @fTempoInicio;
end;

procedure TBaseProcessoThread.runAsync;
begin
  esperar;
  executaProcesso(self);
end;

procedure TBaseProcessoThread.setTempoCriacao(const pValue: PTRTimerData);
begin
  fTempoCriacao := pValue^;
end;

function TBaseProcessoThread.getTempoCriacao: PTRTimerData;
begin
  Result := @fTempoCriacao;
end;

procedure TBaseProcessoThread.setTempoFim(const pValue: PTRTimerData);
begin
  fTempoFim := pValue^;
end;

function TBaseProcessoThread.getTempoFim: PTRTimerData;
begin
  Result := @fTempoFim;
end;

{ TProcessoAnonimo }

constructor TProcessoAnonimo.Create(pProcesso: TProcessoAnonimoProc; pRotulo: TipoWideStringFramework; pResultado: IResultadoOperacao);
begin
  inherited Create(pRotulo, pResultado);
  vProcessoAnonimo:=pProcesso;
end;

procedure TProcessoAnonimo.doExecutar;
begin
  inherited;
  vProcessoAnonimo(getResultado);
end;

{ TProcessoAnonimo }

procedure TBaseProcessoThread.setStatus(const pValue: TStatusProcesso);
begin
  fStatus := pValue;
end;

function TBaseProcessoThread.getStatus: TStatusProcesso;
begin
  Result := fStatus;
end;

function testeSimples(pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  sleep(10000);
end;

procedure testaProcessos;
  var
    l: IList<IProcesso>;
    p: IProcesso;
    i: Integer;
begin
//  exit;
  l := TCollections.CreateList<IProcesso>;
  for I:= 1 to 100 do
  begin
    p := criaProcessoAnonimo(testeSimples,IntToStr(i));
    l.Add(p);
    p.runAsync;
    //executaProcesso(p);
  end;

//  for p in l do
//    p.esperar;

  l:=nil;

end;

function criaProcessoAnonimo;
  var
    p: TProcessoAnonimo;
begin
  if not assigned(pProcesso) then exit;
  p := TProcessoAnonimo.Create(pProcesso,pRotulo,pResultado);
  Result := p;
end;

procedure finaliza;
  var
    p: TThreadLocal;
begin
  for p in vListaThreads do
    p.Terminate;
  while (vListaThreads.count>0) do
    sleep(10);
  vListaProcessos := nil;
  vListaThreads := nil;
end;

initialization
  cria;
  testaProcessos;

finalization
  finaliza;

end.
