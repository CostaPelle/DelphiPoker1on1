unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, SignupForm, LoginForm;

type
  TMainMenuForm = class(TForm)
    btnPlay: TButton;
    btnQuit: TButton;
    MainPanel: TPanel;
    Image1: TImage;
    btnSignup: TButton;
    procedure btnPlayClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure btnSignupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainMenuForm: TMainMenuForm;

implementation

{$R *.dfm}

uses
  Unit2;

procedure TMainMenuForm.btnPlayClick(Sender: TObject);
begin
  MainMenuForm.Hide;
  Form5 := TForm5.Create(Self);
  Form5.Show;
end;

procedure TMainMenuForm.btnQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainMenuForm.btnSignupClick(Sender: TObject);
begin
  MainMenuForm.Hide;
  Form4 := TForm4.Create(Self);
  Form4.Show;
end;

end.

