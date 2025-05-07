program PokerProject;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {MainMenuForm},
  Unit2 in 'Unit2.pas' {GameForm},
  CardTypes in 'CardTypes.pas',
  PokerHandEvaluator in 'PokerHandEvaluator.pas',
  UCardPanel in 'UCardPanel.pas',
  SignupForm in 'SignupForm.pas' {Form4},
  LoginForm in 'LoginForm.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainMenuForm, MainMenuForm);
  Application.CreateForm(TGameForm, GameForm);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
