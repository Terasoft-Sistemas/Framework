
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

      //Queue
      procedure enqueue(const pValue: T);
      function dequeue(out pValue: T; pRemove: boolean): boolean;

      //Stacks
      procedure push(const pValue: T);
      function pop(out pValue: T; pRemove: boolean): boolean;
      function getRandom(out pValue: T; pRemove: boolean): boolean;

      function getFirst(out pValue: T; pRemove: boolean): boolean;
      function getLast(out pValue: T; pRemove: boolean): boolean;

      procedure setUseLock(const pValue: boolean);
      function getUseLock: boolean;

      procedure add(const pValue: T);
      function getTo(pIndex: Integer; out pValue: T; pRemove: boolean): boolean;
      function get(pIndex: Integer; pRemove: boolean): T;
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
      function getItem(pIndex: Integer; out pValue: TPair<T,X>; pRemove: boolean ): boolean;
      function getRandom(out pValue: TPair<T,X>; pRemove: boolean ): boolean;

      procedure lock;
      procedure unlock;
      function tryLock(pTimeout: Integer): boolean;
      function getList: IListaSimples<TPair<T,X>>;
      function getValues: IListaSimples<X>;
      function getKeys: IListaSimples<T>;

      procedure add(pKey: T; pValue: X);
      function get(pKey: T; out pValue: X; pRemove: boolean ): boolean;
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
    Framework.Random,
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

procedure TListaSimples<T>.add(const pValue: T);
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

function TListaSimples<T>.dequeue(out pValue: T; pRemove: boolean): boolean;
begin
  Result := getFirst(pValue,pRemove);
end;

destructor TListaSimples<T>.Destroy;
begin
  FreeAndNil(fSecaoCritica);
  inherited;
end;

procedure TListaSimples<T>.enqueue(const pValue: T);
begin
  add(pValue);
end;

function TListaSimples<T>.get;
begin
  if(fUseLock) then
    lock;
  try
    Result := fLista.Items[pIndex];
    if(pRemove) then
      fLista.Delete(pIndex);
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

function TListaSimples<T>.getFirst;
begin
  Result := getTo(0,pValue,pRemove);
end;

function TListaSimples<T>.getLast;
begin
  Result := false;
  if(fUseLock) then
    lock;
  try
    Result := fLista.TryGetLast(pValue);
    if (Result and pRemove) then
      fLista.Delete(fLista.Count-1);
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TListaSimples<T>.getRandom(out pValue: T; pRemove: boolean): boolean;
  var
    lIndex: Cardinal;
begin
  if(fUseLock) then
    lock;
  try
    Result := fLista.Count>0;
    if(Result=false) then
      exit;
    lIndex := randomUINT32 mod fLista.Count;
    pValue := fLista.Items[lIndex];
    if(pRemove) then
      fLista.Delete(lIndex);
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TListaSimples<T>.getTo;
begin
  if(fUseLock) then
    lock;
  try
    Result := (pIndex>=0) and (pIndex<fLista.Count);
    if(Result) then begin
      pValue := fLista.Items[pIndex];
      if(pRemove) then
        fLista.Delete(pIndex);
    end;
  finally
    if(fUseLock) then
      unlock;
  end;
end;
procedure TListaSimples<T>.lock;
begin
  fSecaoCritica.Enter;
end;

function TListaSimples<T>.pop;
begin
  Result := getLast(pValue,pRemove);
end;

procedure TListaSimples<T>.push(const pValue: T);
begin
  add(pValue);
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

function TDicionarioSimples<T, X>.get;
begin
  if(fUseLock) then
    lock;
  try
    Result := fDicionario.TryGetValue(pKey,pValue);
    if Result and pRemove then
      fDicionario.Remove(pKey);
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

function TDicionarioSimples<T, X>.getItem;
begin
  if(fUseLock) then
    lock;
  try
    Result := (pIndex>=0) and (pIndex<fDicionario.Count);
    if(Result) then begin
      pValue := fDicionario.ElementAt(pIndex);
      if(pRemove) then
        fDicionario.Remove(pValue.Key);
    end;
  finally
    if(fUseLock) then
      unlock;
  end;
end;

function TDicionarioSimples<T, X>.getRandom;
  var
    lIndex: Cardinal;
begin
  if(fUseLock) then
    lock;
  try
    Result := fDicionario.Count>0;
    if(Result=false) then
      exit;
    lIndex := randomUINT32 mod fDicionario.Count;
    pValue := fDicionario.ElementAt(lIndex);
    if(pRemove) then
      fDicionario.Remove(pValue.Key);
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

