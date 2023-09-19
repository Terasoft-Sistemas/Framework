unit Terasoft.Framework.ListaSimples;

interface
  uses
    Terasoft.Framework.Types;

  type
    IEnumeratorSimples<TValue> = interface(IInvokable)
    ['{A2AD52DC-FA9F-4121-9B54-5C427DA5E62C}']
      function GetCurrent: TValue;
      function MoveNext: Boolean;
      property Current: TValue read GetCurrent;
    end;

    IListaSimples<T> = interface
    ['{C002E40F-061B-4456-938C-74587BAA4E4A}']
      procedure add(value: T);
      function getTo(index: Integer; var value: T): boolean;
      function get(index: Integer): T;
      procedure clear;
      function count: Integer;
      function GetEnumerator: IEnumeratorSimples<T>;
    end;

implementation

end.
