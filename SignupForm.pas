unit SignupForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Hash, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.IBDef, FireDAC.Phys.IBBase,
  FireDAC.Phys.IB, Vcl.StdCtrls, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TForm4 = class(TForm)
    MainPanel: TPanel;
    Image1: TImage;
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    btnSignup: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    FDQuery1: TFDQuery;
    lblPassword: TLabel;
    lblUsername: TLabel;
    btnBack: TButton;
    procedure btnSignupClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses Unit1;


function HashPassword(const Password: string): string;
begin
  Result := THashSHA2.GetHashString(Password);
end;

procedure TForm4.btnBackClick(Sender: TObject);
begin
  Form4.Hide;
  MainMenuForm.Show
end;

procedure TForm4.btnSignupClick(Sender: TObject);
begin
var
  Username, Password: string;
begin

  Username := edtUsername.Text;
  Password := edtPassword.Text;

  if (Username = '') or (Password = '') then
  begin
    ShowMessage('Please enter both username and password.');
    Exit;
  end;

  try
    FDQuery1.SQL.Text := 'INSERT INTO users (username, password_hash) VALUES (:username, :password)';
    FDQuery1.Params.ParamByName('username').AsString := Username;
    FDQuery1.Params.ParamByName('password').AsString := Password;
    FDQuery1.ExecSQL;

    ShowMessage('User added successfully!');
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;
end;
end;

end.
