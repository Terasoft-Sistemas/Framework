
{$i definicoes.inc}

unit Framework.View.BaseForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TBaseForm = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    primeiroFoco: TWinControl;
    procedure doView; virtual;
    procedure doAfterShow; virtual;
  public
    procedure view; virtual;
    procedure show;
    function ShowModal: Integer; override;
    { Public declarations }
  end;

var
  BaseForm: TBaseForm;

implementation

{$R *.dfm}

{ TBaseForm }

procedure TBaseForm.doAfterShow;
begin
  if assigned(primeiroFoco) then
    primeiroFoco.SetFocus;
end;

procedure TBaseForm.doView;
begin
  //
end;

procedure TBaseForm.FormShow(Sender: TObject);
begin
  doAfterShow;
end;

procedure TBaseForm.show;
begin
  view;
end;

function TBaseForm.ShowModal: Integer;
begin
  doView;
  Result := inherited;
end;

procedure TBaseForm.view;
begin
  if not visible then begin
    doView;
    inherited show;
  end;
end;

end.
