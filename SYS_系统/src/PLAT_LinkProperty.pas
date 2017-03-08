unit PLAT_LinkProperty;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls;

type
  TFormLinkProperty = class(TForm)
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Bevel1: TBevel;
    Image1: TImage;
    LabelTitle: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelTitleName: TLabel;
    LableTarget: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    function ShowModal(Icon: TIcon; Name, TargetName: string): Integer;
  end;

var
  FormLinkProperty: TFormLinkProperty;

implementation

{$R *.DFM}

function TFormLinkProperty.ShowModal(Icon: TIcon; Name, TargetName: string): Integer;
begin
  Image1.Picture.bitmap.width := Icon.Width;
  Image1.Picture.bitmap.Height := Icon.Height;
  Image1.Picture.Bitmap.Canvas.Draw(0, 0, Icon);
  LabelTitle.Caption := Name;
  LabelTitleName.Caption := Name;
  LableTarget.Caption := Targetname;

  result := inherited ShowModal;
end;

end.
