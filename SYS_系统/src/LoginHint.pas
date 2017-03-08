unit LoginHint;

interface

uses
  Windows, Messages, SysUtils,Variants, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TFormLoginHint = class(TForm)
    Image1: TImage;
    LabelHint: TLabel;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function ShowLoginHint(const AHint: string): TModalResult;

implementation

uses Pub_Global;

{$R *.DFM}

function ShowLoginHint(const AHint: string): TModalResult;
var
  FormLoginHint: TFormLoginHint;
begin
  FormLoginHint := TFormLoginHint.Create(nil);
  with FormLoginHint do
  try
    LabelHint.Caption := AHint;
    Left := (Screen.Width - Width) div 2;
    Top := (Screen.Height - Height) div 2;
    // 崔立国 2010.12.10 暂时只有账务（总会计）可以使用离线功能。
    if (GProSign <> 'GAL') and (GProSign <> 'GL') then
    begin
      Button1.Visible := False;
      Button2.Left := (Width - Button2.Width) div 2;
    end;
    Result := ShowModal;
  finally
    Free;
  end;
end;

end.
