{$i definicoes.inc}

unit Terasoft.Framework.ListaSimples;

interface

  uses
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
      procedure add(pValue: T);
      function getTo(pIndex: Integer; out value: T): boolean;
      function get(pIndex: Integer): T;
      procedure clear;
      function count: Integer;
      function GetEnumerator: IEnumeratorSimples<T>;
      procedure lock;
      procedure unlock;
      function tryLock(pTimeout: Integer): boolean;
      procedure setUseLock(const pValue: boolean);
      function getUseLock: boolean;

      property useLock: boolean read getUseLock write setUseLock;
    end;

    IDicionarioSimples<T,X> = interface
    ['{733C34FD-3BE9-472F-8527-E35CA248D97B}']

      function GetEnumerator: IEnumeratorPair<T,X>;

      procedure add(pKey: T; pValue: X);
      function get(pKey: T; out pValue: X ): boolean;
      function getItem(pIndex: Integer; out pValue: TPair<T,X> ): boolean;
      procedure clear;
      function count: Integer;

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

implementation

end.
