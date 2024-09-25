
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
    IProcesso = interface;

    TStatusProcesso = (spOcioso,spEsperando,spRodando);

    TProcessoAnonimoProc = reference to function (pProcesso: IProcesso; pResultado: IResultadoOperacao): IResultadoOperacao;

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

    //property quantidadeExecutar getter/setter
      function getQuantidadeExecutar: Integer;
      procedure setQuantidadeExecutar(const pValue: Integer);

    //property tempoEntreExecucoes getter/setter
      function getTempoEntreExecucoes: Integer;
      procedure setTempoEntreExecucoes(const pValue: Integer);

    //property proximaExecucao getter/setter
      function getProximaExecucao: TDateTime;
      procedure setProximaExecucao(const pValue: TDateTime);

    //property quantidadeExecucoes getter/setter
      function getQuantidadeExecucoes: Integer;
      procedure setQuantidadeExecucoes(const pValue: Integer);

      property quantidadeExecucoes: Integer read getQuantidadeExecucoes write setQuantidadeExecucoes;
      property proximaExecucao: TDateTime read getProximaExecucao write setProximaExecucao;
      //Tempo em milisecs
      property tempoEntreExecucoes: Integer read getTempoEntreExecucoes write setTempoEntreExecucoes;
      property quantidadeExecutar: Integer read getQuantidadeExecutar write setQuantidadeExecutar;
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
      fQuantidadeExecutar: Integer;
      fTempoEntreExecucoes: Integer;
      fProximaExecucao: TDateTime;
      fQuantidadeExecucoes: Integer;

    //property quantidadeExecucoes getter/setter
      function getQuantidadeExecucoes: Integer;
      procedure setQuantidadeExecucoes(const pValue: Integer);

    //property proximaExecucao getter/setter
      function getProximaExecucao: TDateTime;
      procedure setProximaExecucao(const pValue: TDateTime);

    //property tempoEntreExecucoes getter/setter
      function getTempoEntreExecucoes: Integer;
      procedure setTempoEntreExecucoes(const pValue: Integer);

    //property quantidadeExecutar getter/setter
      function getQuantidadeExecutar: Integer;
      procedure setQuantidadeExecutar(const pValue: Integer);

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

  function getContagemExecucoesAssincronas: Int64;
  function getContagemProcessos: Int64;

  procedure executaProcesso(pProcesso: IProcesso);
  function criaProcessoAnonimo(pProcesso: TProcessoAnonimoProc; pRotulo: TipoWideStringFramework; pResultado: IResultadoOperacao=nil): IProcesso;
  procedure testaProcessos;

  function getContagemThreadsExecutando: Int64;

implementation
  uses
    Terasoft.Framework.Log,
    DateUtils,
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
    gContagem: Int64;
    gContagemProcessos: Int64;

  const
    MAXIMO = 100;


function getContagemExecucoesAssincronas: Int64;
begin
  Result := gContagem;
end;

function getContagemProcessos: Int64;
begin
  Result := gContagemProcessos;
end;


procedure executaProcesso(pProcesso: IProcesso);
  var
    th: TThreadLocal;
begin
  if(pProcesso=nil) then exit;
  if not (pProcesso.status in [spOcioso,spEsperando]) then
    raise Exception.CreateFmt('executaProcesso: Processo [%s] não está ocioso', [ pProcesso.rotulo ]);

  if(pProcesso.status=spEsperando) and (vListaProcessos.indexOf(pProcesso)<>-1) then
    exit;

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

  var
    gThreadsExecutando: Int64;

function getContagemThreadsExecutando: Int64;
begin
  Result := gThreadsExecutando;
end;

procedure TThreadLocal.Execute;
  var
    p: IProcesso;
    tmr: TDateTime;
    msg: String;
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
      tmr := Now;
      if(p.proximaExecucao>tmr) then
      begin
        executaProcesso(p);
        sleep(10);
        continue;
      end;

      AtomicIncrement(gContagem);
      AtomicIncrement(gThreadsExecutando);
      p.quantidadeExecucoes:=p.quantidadeExecucoes+1;

      p.executar;

    except
      on e: Exception do
      begin
        msg := format('TThreadLocal.Execute: [%s]: %s: %s', [p.rotulo, e.ClassName,e.Message]);
        p.resultado.adicionaErro(msg);
        logaByTagSeNivel(TAGLOG_EXCEPTIONS,msg,LOG_LEVEL_ATENCAO,ls_Erro);
        //p.status := spOcioso;
      end;
    end;
    AtomicDecrement(gThreadsExecutando);
    if(p.quantidadeExecutar>0) then
    begin
      tmr := IncMilliSecond(Now,p.tempoEntreExecucoes);
      p.proximaExecucao := tmr;
      executaProcesso(p);
    end else
      p.status := spOcioso;
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
  fQuantidadeExecutar := 1;
  fQuantidadeExecucoes := 0;
  fTempoEntreExecucoes := 1000;

  AtomicIncrement(gContagemProcessos);
  fStatus := spOcioso;
  fRotulo := pRotulo;
  fResultado := pResultado;
  fTempoCriacao := lrTimerGlobal.mark;
end;

destructor TBaseProcessoThread.Destroy;
begin
  esperar;
  AtomicDecrement(gContagemProcessos);
  inherited;
end;

procedure TBaseProcessoThread.executar;
begin
  fTempoInicio := lrTimerGlobal.mark;
  fStatus := spRodando;
  try
    if(fQuantidadeExecutar>0) then
      fQuantidadeExecutar := fQuantidadeExecutar - 1;

    doExecutar;
  finally
    fStatus := spOcioso;
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

procedure TBaseProcessoThread.setQuantidadeExecutar(const pValue: Integer);
begin
  fQuantidadeExecutar := pValue;
end;

function TBaseProcessoThread.getQuantidadeExecutar: Integer;
begin
  Result := fQuantidadeExecutar;
end;

procedure TBaseProcessoThread.setTempoEntreExecucoes(const pValue: Integer);
begin
  fTempoEntreExecucoes := pValue;
end;

function TBaseProcessoThread.getTempoEntreExecucoes: Integer;
begin
  Result := fTempoEntreExecucoes;
end;

procedure TBaseProcessoThread.setProximaExecucao(const pValue: TDateTime);
begin
  fProximaExecucao := pValue;
end;

function TBaseProcessoThread.getProximaExecucao: TDateTime;
begin
  Result := fProximaExecucao;
end;

procedure TBaseProcessoThread.setQuantidadeExecucoes(const pValue: Integer);
begin
  fQuantidadeExecucoes := pValue;
end;

function TBaseProcessoThread.getQuantidadeExecucoes: Integer;
begin
  Result := fQuantidadeExecucoes;
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
  vProcessoAnonimo(self,getResultado);
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

function testeSimples(pProcesso: IProcesso; pResultado: IResultadoOperacao): IResultadoOperacao;
begin
  sleep(2000);
end;

procedure testaProcessos;
  var
    l: IList<IProcesso>;
    p: IProcesso;
    i: Integer;
begin
//  exit;
  l := TCollections.CreateList<IProcesso>;
  for I:= 1 to 5 do
  begin
    p := criaProcessoAnonimo(testeSimples,IntToStr(i));
    l.Add(p);
    p.quantidadeExecutar := 10;
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
  {$if defined(DEBUG)}
    //testaProcessos;
  {$endif}

finalization
  finaliza;

end.
