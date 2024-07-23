unit Terasoft.Framework.View.Impl.BaseVCLForm;

interface

uses
  Terasoft.Framework.Generics.View,
  Terasoft.Framework.Texto,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TBaseViewVCLForm = class(TForm,IGeneric_View)
  private
    { Private declarations }
  protected
    function view(pResultado: IResultadoOperacao): IResultadoOperacao;
    function viewModal(pResultado: IResultadoOperacao): IResultadoOperacao;
  public
    { Public declarations }
  end;

var
  BaseViewVCLForm: TBaseViewVCLForm;

implementation

{$R *.dfm}

{ TBaseViewVCLForm }

function TBaseViewVCLForm.view;
begin
  Result := checkResultadoOperacao(pResultado);
  Show;
end;

function TBaseViewVCLForm.viewModal;
begin
  Result := checkResultadoOperacao(pResultado);
  ShowModal;
end;

end.
