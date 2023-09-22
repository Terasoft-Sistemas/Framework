unit Terasoft.Framework.ListaSimples.Impl;

interface
  uses
    Terasoft.Framework.SimpleTypes,
    Spring.Collections,
    Terasoft.Framework.ListaSimples;

  type
    TListaSimples<T> = class(TInterfacedObject, IListaSimples<T>)
    protected
      fLista: IList<T>;
      procedure add(value: T);
      function getTo(index: Integer; var value: T): boolean;
      function get(index: Integer): T;
      procedure clear;
      function count: Integer;
    public
      function GetEnumerator: IEnumeratorSimples<T>;
      constructor Create;
    end;

    TEnumeratorSimples<TValue>=class(TInterfacedObject, IEnumeratorSimples<TValue>)
    protected
      fLista: IListaSimples<TValue>;
      position: Integer;
      function GetCurrent: TValue;
      function MoveNext: Boolean;
    public
      constructor Create(lista:IListaSimples<TValue>);
    end;

    TListaSimplesCreator = class
    public
      class function CreateList<T>: IListaSimples<T>; static;
      class function CreateEnumeratorSimples<T>(const lista: IListaSimples<T>): IEnumeratorSimples<T>; static;
    end;





implementation


{ TListaSimples<T> }

procedure TListaSimples<T>.add(value: T);
begin
  fLista.Add(value);
end;

procedure TListaSimples<T>.clear;
begin
  fLista.Clear;
end;

function TListaSimples<T>.count: Integer;
begin
  Result := fLista.Count;
end;

constructor TListaSimples<T>.Create;
begin
  fLista := TCollections.CreateList<T>;
end;

function TListaSimples<T>.get(index: Integer): T;
begin
  Result := fLista.Items[index];
end;

function TListaSimples<T>.GetEnumerator: IEnumeratorSimples<T>;
  var
    x: IListaSimples<T>;
begin
  x := self;
  Result := TListaSimplesCreator.CreateEnumeratorSimples<T>(x);
end;

function TListaSimples<T>.getTo(index: Integer; var value: T): boolean;
begin
  Result := (index>=0) and (index<fLista.Count);
  if(Result) then
    value := fLista.Items[index];
end;

{ TListaSimplesCreator }

class function TListaSimplesCreator.CreateEnumeratorSimples<T>(const lista: IListaSimples<T>): IEnumeratorSimples<T>;
begin
  Result := TEnumeratorSimples<T>.Create(lista);
end;

class function TListaSimplesCreator.CreateList<T>: IListaSimples<T>;
begin
  Result := TListaSimples<T>.Create;
end;

{ TEnumeratorSimples<TValue> }

constructor TEnumeratorSimples<TValue>.Create(lista: IListaSimples<TValue>);
begin
  position := -1;
  fLista := lista;
end;

function TEnumeratorSimples<TValue>.GetCurrent: TValue;
begin
  if not (position<0) then
    Result := fLista.get(position);
end;

function TEnumeratorSimples<TValue>.MoveNext: Boolean;
begin
  Result := (position > -1) and (position < fLista.count);
  if(Result) then
    inc(position);
end;

end.
