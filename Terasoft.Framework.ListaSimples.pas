{$i definicoes.inc}

unit Terasoft.Framework.ListaSimples;

interface

  uses
    SysUtils,Classes,
    System.Generics.Collections, Terasoft.Framework.SimpleTypes;

  type

    IEnumeratorSimples<TValue> = interface(IInvokable)
    ['{A2AD52DC-FA9F-4121-9B54-5C427DA5E62C}']
      function GetCurrent: TValue;
      function MoveNext: Boolean;
      property Current: TValue read GetCurrent;
    end;

    IEnumeratorPair<TKey,TValue> = interface(IInvokable)
    ['{CB8B6BE4-8327-449C-936E-ED1AF72AA507}']
      function GetCurrent: TPair<TKey, TValue>;
      function MoveNext: Boolean;
      property Current: TPair<TKey,TValue> read GetCurrent;
    end;

    IListaSimples<T> = interface
    ['{C002E40F-061B-4456-938C-74587BAA4E4A}']
      procedure add(const pValue: T);
      function getTo(pIndex: Integer; out value: T; pRemove: boolean = false): boolean;
      function get(pIndex: Integer; pRemove: boolean = false): T;
      procedure clear;
      function count: Integer;
      function GetEnumerator: IEnumeratorSimples<T>;
      procedure lock;
      procedure unlock;

      function getFirst(out pValue: T; pRemove: boolean = false): boolean;
      function getLast(out pValue: T; pRemove: boolean = false): boolean;
      function getRandom(out pValue: T; pRemove: boolean = true ): boolean;

      //Stacks
      procedure push(const pValue: T);
      function pop(out pValue: T; pRemove: boolean = true): boolean;

      //Queue
      procedure enqueue(const pValue: T);
      function dequeue(out pValue: T; pRemove: boolean = true): boolean;

      function tryLock(pTimeout: Integer): boolean;
      procedure setUseLock(const pValue: boolean);
      function getUseLock: boolean;

      property useLock: boolean read getUseLock write setUseLock;
    end;

    IDicionarioSimples<T,X> = interface
    ['{733C34FD-3BE9-472F-8527-E35CA248D97B}']

      function GetEnumerator: IEnumeratorPair<T,X>;

      procedure add(pKey: T; pValue: X);
      function get(pKey: T; out pValue: X; pRemove: boolean = false ): boolean;
      function getItem(pIndex: Integer; out pValue: TPair<T,X>; pRemove: boolean = false ): boolean;
      procedure clear;
      function count: Integer;

      function getRandom(out pValue: TPair<T,X>; pRemove: boolean = true ): boolean;

      procedure lock;
      procedure unlock;
      function tryLock(PTimeout: Integer): boolean;

      function getList: IListaSimples<TPair<T,X>>;
      function getValues: IListaSimples<X>;
      function getKeys: IListaSimples<T>;

      procedure setUseLock(const pValue: boolean);
      function getUseLock: boolean;

      property useLock: boolean read getUseLock write setUseLock;
    end;

{$if defined(__DEBUG_ANTONIO_BALLOON__)}
    procedure testes;
{$ifend}

implementation

{$if defined(__DEBUG_ANTONIO_BALLOON__)}
  uses
    Framework.Random,
    Terasoft.FRamework.ListaSimples.Impl;

procedure testes;
  var
    listaA: IListaSimples<Cardinal>;
    b: Cardinal;
    i: Integer;

    dicA: IDicionarioSimples<Cardinal,Cardinal>;
    par: TPair<Cardinal,Cardinal>;
    listaPar: IListaSimples<TPair<Cardinal,Cardinal>>;

begin

  listaA := TListaSimplesCreator.CreateList<Cardinal>;

  for i := 0 to 10 do
    listaA.enqueue(i);

  i := 0;
  while listaA.dequeue(b) do begin
    inc(i,b);
  end;

  for i := 0 to 10 do
    listaA.push(i);

  i := 0;
  while listaA.pop(b) do begin
    inc(i,b);
  end;

  for i := 0 to 10 do
    listaA.add(i);

  i := 0;
  while listaA.getRandom(b) do begin
    inc(i,b);
  end;

  dicA := TListaSimplesCreator.CreateDictionary<Cardinal,Cardinal>;
  for i := 0 to 10 do
    dicA.add(i,i);

  listaPar := dicA.getList;

  i := 0;
  while dicA.getRandom(par) do begin
    inc(i,par.Value);
  end;

  i := 0;
  while listaPar.getRandom(par) do begin
    inc(i,par.Value);
  end;


end;
{$ifend}

end.
