unit Terasoft.Framework.ListaSimples.Impl;

interface
  uses
    Terasoft.Framework.SimpleTypes,
    Terasoft.Framework.Types,
    Spring.Collections,
    System.SyncObjs,
    System.Generics.Collections,
    Terasoft.Framework.ListaSimples;

  type
    TListaSimplesCreator = class
    public
      class function CreateList<T>: IListaSimples<T>; static;
      class function CreateLockList<T>: IListaSimples<T>; static;
      class function CreateDictionary<T,X>: IDicionarioSimples<T,X>; static;
      class function CreateLockDictionary<T,X>: IDicionarioSimples<T,X>; static;
      class function CreateEnumeratorSimples<T>(const pLista: IListaSimples<T>): IEnumeratorSimples<T>; static;
      class function CreateEnumeratorDicionarioSimples<T,X>(const pLista: IDicionarioSimples<T,X>): IEnumeratorPair<T,X>; static;
    end;

    TListaSimples<T> = class(TInterfacedObject, IListaSimples<T>)
    protected
      fLista: IList<T>;
      fUseLock: boolean;
      fSecaoCritica: TCriticalSection;

      procedure setUseLock(const pValue: boolean);
      function getUseLock: boolean;

      procedure add(pValue: T);
      function getTo(pIndex: Integer; out pValue: T): boolean;
      function get(pIndex: Integer): T;
      procedure clear;
      function count: Integer;
      procedure lock;
      procedure unlock;
      function tryLock(pTimeout: Integer): boolean;
    public
      function GetEnumerator: IEnumeratorSimples<T>;
      constructor Create;
      destructor Destroy; override;
    end;

    TDicionarioSimples<T,X> = class(TInterfacedObject, IDicionarioSimples<T,X>)
    protected
      fDicionario: IDictionary<T,X>;
      fUseLock: boolean;
      fSecaoCritica: TCriticalSection;

      function GetEnumerator: IEnumeratorPair<T,X>;

      procedure setUseLock(const pValue: boolean);
      function getUseLock: boolean;
      function getItem(pIndex: Integer; out pValue: TPair<T,X> ): boolean;

      procedure lock;
      procedure unlock;
      function tryLock(pTimeout: Integer): boolean;
      function getList: IListaSimples<TPair<T,X>>;
      function getValues: IListaSimples<X>;
      function getKeys: IListaSimples<T>;

      procedure add(pKey: T; pValue: X);
      function get(pKey: T; out pValue: X ): boolean;
      procedure clear;
      function count: Integer;
    public
      constructor Create;
      destructor Destroy; override;
    end;

    TEnumeratorSimples<TValue>=class(TInterfacedObject, IEnumeratorSimples<TValue>)
    protected
      fLista: IListaSimples<TValue>;
      position: Integer;
      fCurrent: TValue;
      function GetCurrent: TValue;
      function MoveNext: Boolean;
    public
      constructor Create(pLista:IListaSimples<TValue>);
      destructor Destroy; override;
    end;

    TEnumeratorPair<TKey,TValue> = class(TInterfacedObject, IEnumeratorPair<TKey,TValue>)
    protected
      fLista: IDicionarioSimples<TKey, TValue>;
      position: Integer;
      fCurrent: TPair<TKey,TValue>;
      function GetCurrent: TPair<TKey,TValue>;
      function MoveNext: Boolean;
    public
      constructor Create(pLista: IDicionarioSimples<TKey,TValue>);
      destructor Destroy; override;
    end;



implementation
  uses
    SysUtils;

{ TListaSimples<T> }

procedure TListaSimples<T>.setUseLock(const PValue: boolean);
begin
   fUseLock := pValue;
end;

function TListaSimples<T>.getUseLock: boolean;
begin
   Result := fUseLock;
end;

procedure TListaSimples<T>.add(pValue: T);
begin
  if(fUseLock) then
    lock;
  try
    fLista.Add(pValue);
  finally
    if(fUseLock) then
      unlock;
  end;
end;

procedure TListaSimples<T>.clear;
begin
  if(fUseLock) then
    lock;
  try
    fLista.Clear;
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TListaSimples<T>.count: Integer;
begin
  if(fUseLock) then
    lock;
  try
    Result := fLista.Count;
  finally
    if(fUseLock) then
      unlock;
  end;
end;

constructor TListaSimples<T>.Create;
begin
  fLista := TCollections.CreateList<T>;
  fSecaoCritica := TCriticalSection.Create;
end;

destructor TListaSimples<T>.Destroy;
begin
  FreeAndNil(fSecaoCritica);
  inherited;
end;

function TListaSimples<T>.get(pIndex: Integer): T;
begin
  if(fUseLock) then
    lock;
  try
    Result := fLista.Items[pIndex];
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TListaSimples<T>.GetEnumerator: IEnumeratorSimples<T>;
  var
    x: IListaSimples<T>;
begin
  x := self;
  Result := TListaSimplesCreator.CreateEnumeratorSimples<T>(x);
end;

function TListaSimples<T>.getTo(pIndex: Integer; out pValue: T): boolean;
begin
  if(fUseLock) then
    lock;
  try
    Result := (pIndex>=0) and (pIndex<fLista.Count);
    if(Result) then
      pValue := fLista.Items[pIndex];
  finally
    if(fUseLock) then
      unlock;
  end;
end;

procedure TListaSimples<T>.lock;
begin
  fSecaoCritica.Enter;
end;

function TListaSimples<T>.tryLock(pTimeout: Integer): boolean;
begin
  Result := fSecaoCritica.TryEnter;
end;

 procedure TListaSimples<T>.unlock;
begin
  fSecaoCritica.Leave;
end;

{ TListaSimplesCreator }

class function TListaSimplesCreator.CreateDictionary<T, X>: IDicionarioSimples<T, X>;
begin
  Result := TDicionarioSimples<T,X>.Create;
  Result.useLock := false;
end;

class function TListaSimplesCreator.CreateLockDictionary<T, X>: IDicionarioSimples<T, X>;
begin
  Result := TDicionarioSimples<T,X>.Create;
  Result.useLock := true;
end;

class function TListaSimplesCreator.CreateEnumeratorSimples<T>(const pLista: IListaSimples<T>): IEnumeratorSimples<T>;
begin
  Result := TEnumeratorSimples<T>.Create(pLista);
end;

class function TListaSimplesCreator.CreateEnumeratorDicionarioSimples<T,X>(const pLista: IDicionarioSimples<T,X>): IEnumeratorPair<T,X>;
begin
  Result := TEnumeratorPair<T,X>.Create(pLista);
end;

class function TListaSimplesCreator.CreateList<T>: IListaSimples<T>;
begin
  Result := TListaSimples<T>.Create;
  Result.useLock := false;
end;

class function TListaSimplesCreator.CreateLockList<T>: IListaSimples<T>;
begin
  Result := TListaSimples<T>.Create;
  Result.useLock :=true;
end;

{ TEnumeratorSimples<TValue> }

constructor TEnumeratorSimples<TValue>.Create(pLista: IListaSimples<TValue>);
begin
  position := -1;
  fLista := pLista;
end;

destructor TEnumeratorSimples<TValue>.Destroy;
begin

  inherited;
end;

function TEnumeratorSimples<TValue>.GetCurrent: TValue;
begin
  Result := fCurrent;
{  if not (position<0) then
    Result := fLista.get(position);}
end;

function TEnumeratorSimples<TValue>.MoveNext: Boolean;
begin
  inc(position);
  Result := fLista.getTo(position,fCurrent);
//  Result := position < fLista.count;
end;

{ TDicionarioSimples<T, X> }

destructor TDicionarioSimples<T,X>.Destroy;
begin
  FreeAndNil(fSecaoCritica);
  inherited;
end;

procedure TDicionarioSimples<T,X>.setUseLock(const pValue: boolean);
begin
   fUseLock := pValue;
end;

function TDicionarioSimples<T,X>.getUseLock: boolean;
begin
   Result := fUseLock;
end;

procedure TDicionarioSimples<T, X>.add(pKey: T; pValue: X);
begin
  if(fUseLock) then
    lock;
  try
    fDicionario.AddOrSetValue(pKey,pValue);
  finally
    if(fUseLock) then
      unlock;
  end;
end;

procedure TDicionarioSimples<T, X>.clear;
begin
  if(fUseLock) then
    lock;
  try
    fDicionario.Clear;
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TDicionarioSimples<T, X>.count: Integer;
begin
  if(fUseLock) then
    lock;
  try
    Result := fDicionario.Count;
  finally
    if(fUseLock) then
      unlock;
  end;
end;

constructor TDicionarioSimples<T, X>.Create;
begin
  fSecaoCritica := TCriticalSection.Create;
  fDicionario := TCollections.CreateDictionary<T,X>;

end;

function TDicionarioSimples<T, X>.get(pKey: T; out pValue: X): boolean;
begin
  if(fUseLock) then
    lock;
  try
    Result := fDicionario.TryGetValue(pKey,pValue);
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TDicionarioSimples<T, X>.GetEnumerator: IEnumeratorPair<T, X>;
  var
    p: IDicionarioSimples<T,X>;
begin
  p := self;
  Result := TListaSimplesCreator.CreateEnumeratorDicionarioSimples<T,X>(p);
end;

function TDicionarioSimples<T, X>.getItem(pIndex: Integer; out pValue: TPair<T,X>): boolean;
begin
  if(fUseLock) then
    lock;
  try
    Result := (pIndex>=0) and (pIndex<fDicionario.Count);
    if(Result) then
      pValue := fDicionario.ElementAt(pIndex);
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TDicionarioSimples<T, X>.getKeys: IListaSimples<T>;
  var
    p: TPair<T,X>;
begin
  if(fUseLock) then
    lock;
  try
    Result := TListaSimplesCreator.CreateList<T>;
    for p in fDicionario do
      Result.add(p.Key);
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TDicionarioSimples<T, X>.getValues: IListaSimples<X>;
  var
    p: TPair<T,X>;
begin
  if(fUseLock) then
    lock;
  try
    Result := TListaSimplesCreator.CreateList<X>;
    for p in fDicionario do
      Result.add(p.Value);
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TDicionarioSimples<T, X>.getList: IListaSimples<TPair<T, X>>;
  var
    p: TPair<T,X>;
begin
  if(fUseLock) then
    lock;
  try
    Result := TListaSimplesCreator.CreateList<TPair<T,X>>;
    for p in fDicionario do
      Result.add(p);
  finally
    if(fUseLock) then
      unlock;
  end;
end;

procedure TDicionarioSimples<T, X>.lock;
begin
  fSecaoCritica.Enter;
end;

function TDicionarioSimples<T, X>.tryLock(pTimeout: Integer): boolean;
begin
  Result := fSecaoCritica.TryEnter;
end;

procedure TDicionarioSimples<T, X>.unlock;
begin
  fSecaoCritica.Leave;
end;

{ TEnumeratorPair<TKey, TValue> }

constructor TEnumeratorPair<TKey, TValue>.Create(pLista: IDicionarioSimples<TKey, TValue>);
begin
  fLista := pLista;
  position := -1;
end;

destructor TEnumeratorPair<TKey, TValue>.Destroy;
begin

  inherited;
end;

function TEnumeratorPair<TKey, TValue>.GetCurrent: TPair<TKey, TValue>;
begin
  Result := fCurrent;
end;

function TEnumeratorPair<TKey, TValue>.MoveNext: Boolean;
begin
  inc(position);
  Result := fLista.getItem(position,fCurrent);
end;

end.

