unit PLAT_ChangeIcons;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TFormChangeIcon = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    ComboBoxImages: TComboBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    OpenDialog: TOpenDialog;
    procedure ComboBoxImagesDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Images: TImageList;
    function ShowModal(Index: Integer; ImgList: TImageList): Integer;
  end;

var
  FormChangeIcon: TFormChangeIcon;

implementation

{$R *.DFM}

{ TForm1 }

function TFormChangeIcon.ShowModal(Index: Integer; ImgList: TImageList): Integer;
var
  i: integer;
  aIcon: TIcon;
begin
  aIcon := TIcon.Create;
  ImgList.GetIcon(Index, aIcon);
  self.Image1.Picture.Bitmap.Width := 32;
  self.Image1.Picture.Bitmap.Height := 32;

  self.Image1.Picture.Bitmap.Canvas.Draw(1, 1, aIcon);
  aIcon.Free;
  self.Images := ImgList;
  ComboboxImages.Clear;
  for i := 0 to ImgList.Count - 1 do
  begin
    ComboboxImages.Items.Add(inttostr(i));
  end;
  ComboboxImages.ItemIndex := Index;

  Result := inherited ShowModal();
end;

procedure TFormChangeIcon.ComboBoxImagesDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Icon: TIcon;
begin

  with (Control as TCombobox).canvas do
  begin
    Icon := TIcon.Create;
    Images.GetIcon(Index, icon);
    Draw(Rect.Left, Rect.Top, Icon);

  end;
end;

procedure TFormChangeIcon.Button3Click(Sender: TObject);
var
  icon: TIcon;
  imageIndex: Integer;
begin
  if OpenDialog.Execute then
  begin
    Icon := TIcon.Create;
    Icon.LoadFromFile(OpenDialog.FileName);
    ImageIndex := Images.AddIcon(Icon);
    Icon.free;
    ComboBoxImages.Items.Add(Inttostr(ImageIndex));
    ComboBoxImages.ItemIndex := ComboBoxImages.Items.IndexOf(Inttostr(ImageIndex));

  end;

end;

end.
