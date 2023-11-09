
{$i definicoes.inc}

unit Framework.View.BaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TBaseForm = class(TForm)
  private
    { Private declarations }
  protected
    procedure doView; virtual;
  public
    procedure view; virtual;
    function ShowModal: Integer; override;
    { Public declarations }
  end;

var
  BaseForm: TBaseForm;

implementation

{$R *.dfm}

{ TBaseForm }

procedure TBaseForm.doView;
begin

end;

function TBaseForm.ShowModal: Integer;
begin
  doView;
  Result := inherited;
end;

procedure TBaseForm.view;
begin
  doView;
  if not visible then
    show;
end;

end.
