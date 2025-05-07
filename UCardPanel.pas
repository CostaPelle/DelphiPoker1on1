unit UCardPanel;

interface

uses
  Vcl.Controls, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Graphics, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Forms, Vcl.Dialogs;

type
  TCardPanel = class(TPanel)
  private
    FImage: TImage;
    FLabel: TLabel;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetCard(Value: Integer; ImagePath: string);
  end;

implementation

constructor TCardPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.Width := 73;
  Self.Height := 105;
  Self.BevelOuter := bvRaised;

  FImage := TImage.Create(Self);
  FImage.Parent := Self;
  FImage.Align := alClient;
  FImage.Stretch := True;
  FImage.Proportional := True;

  FLabel := TLabel.Create(Self);
  FLabel.Parent := Self;
  FLabel.Align := alBottom;
  FLabel.Alignment := taCenter;
  FLabel.Font.Size := 10;
end;

procedure TCardPanel.SetCard(Value: Integer; ImagePath: string);
begin
  FLabel.Caption := 'Card ' + Value.ToString;
  FImage.Picture.LoadFromFile(ImagePath);
end;

end.

