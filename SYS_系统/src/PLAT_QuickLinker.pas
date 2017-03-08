unit PLAT_QuickLinker;
//这是一个VCL的控件,用于界面控制,不在设计文档中

interface
uses sysutils, stdctrls, Dialogs, menus, Messages, Pub_Message, extctrls,
  Windows, Graphics, Classes, PLAT_Buttons, Controls, PLAT_QuickLink;
type
  TQuickLinker = class(TPLATSpeedButton)
  private
    FLink: TQuickLink;
    FImageIndex: Integer;
    FMouseDown: Boolean;
    FMouseDownX: Integer;
    FMouseDownY: Integer;
    Menu: TPopupMenu;
    FLocked: Boolean;
    LockMenuItem: TMenuItem;

    procedure SetLink(ALink: TQuickLink);
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message
      WM_LBUTTONDBLCLK;

    procedure SpeedButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButtonMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetImageIndex(const Value: Integer);
    procedure MenuItemClick(Sender: TObject);
    procedure Rename;
    procedure ChangeIcon;
    procedure Delete;
    procedure ShowProperty;
    procedure SetLocked(const Value: Boolean);
    procedure ParentPaint;
    function MyInputBox(const ACaption, APrompt, ADefault: string): string;
    function MyInputQuery(const ACaption, APrompt: string;
      var Value: string): Boolean;
    function FindSameCaptionLinker(const ACaption: string): Boolean;

    procedure ProcessMulitLine(var ACaption: string);
  protected
    procedure Paint; override;

  public
    ChangeIconItem: TMenuItem;
    constructor Create(AOwner: TComponent; ALink: TQuickLink);
    destructor Destroy;
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    procedure SetImage(ImageList: TImageList);
    property MouseDownX: Integer read FMouseDownX;
    property MouseDownY: Integer read FMouseDownY;
    property Link: TQuickLink read FLink;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Locked: Boolean read FLocked write SetLocked;

  end;

implementation

{ TQuickLinker }
uses forms, math, PLAT_LinkProperty, PLAT_Utils, PLAT_QuickLinkFactory,
  PLAT_GroupLink, PLAT_TreeFuncNodeLink, PLAT_ChangeIcons;

constructor TQuickLinker.Create(AOwner: TComponent; ALink: TQuickLink);
var
  Mi: TMenuItem;
begin
  inherited Create(AOwner);
  self.Flat := true;
  self.ParentFont := false;

  Font.Name := '宋体';
  Font.Size := 9;
  Font.Color := clNavy;

  self.width := 64;
  self.Height := 80; //64; Bryan20041215
  self.LayOut := blGlyphTop;
  self.OnMouseDown := self.SpeedButtonMouseDown;
  self.OnMouseUp := self.SpeedButtonMouseUp;

  Menu := TPopupMenu.Create(application);
  Menu.AutoHotkeys := maManual;
  Menu.Items.Clear;
  mi := TmenuItem.Create(self);
  mi.Caption := '打开';
  mi.OnClick := self.MenuItemClick;
  Menu.Items.Add(mi);

  mi := TmenuItem.Create(self);
  mi.Caption := '更名';
  mi.OnClick := self.MenuItemClick;
  Menu.Items.Add(mi);

  mi := TmenuItem.Create(self);
  mi.Caption := '更换图标';
  mi.OnClick := self.MenuItemClick;
  Menu.Items.Add(mi);
  ChangeIconItem := mi;

  mi := TmenuItem.Create(self);  //该功能不起作用，应去掉此功能
  if FLocked then
    mi.Caption := '解除锁定'
  else
    mi.Caption := '锁定';
  mi.OnClick := self.MenuItemClick;
  mi.Visible := False;
  Menu.Items.Add(mi);
  LockMenuItem := mi;   

  mi := TmenuItem.Create(self);
  mi.Caption := '删除';
  mi.OnClick := self.MenuItemClick;
  Menu.Items.Add(mi);

  mi := TmenuItem.Create(self);
  mi.Caption := '-';
  Menu.Items.Add(mi);

  mi := TmenuItem.Create(self);
  mi.Caption := '属性';
  mi.OnClick := self.MenuItemClick;
  Menu.Items.Add(mi);

  self.PopupMenu := Menu;

  SetLink(ALink);
end;

procedure TQuickLinker.SpeedButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if (Button = mbLeft) and (not Locked) then
  begin
    FMouseDown := true;
    FMouseDownX := X;
    FMouseDownY := y;
    //self.BeginDrag(true);
  end;
  inherited;
end;
{
procedure TQuickLinker.MouseDown(Button: TMouseButton; Shift: TShiftState;
X, Y: Integer);
begin

FMouseDownX:=X;
FMouseDownY:=y;
ShowMessage('sdfasdf');
Caption:=format('%d,%d',[FMouseDownX,FMouseDownY]);
inherited;
end;
}

procedure TQuickLinker.Paint;
var
  PaintRect: TRect;
begin

  //TCrackSpeedButton(self).FMouseInControl:=false;

  inherited;
  {
Canvas.pen.Color :=(self.Parent as TPanel).Color;
Canvas.Brush.Color :=(self.Parent as TPanel).Color;

Canvas.Brush.Style :=bsClear;
Canvas.FillRect (Rect (0,0,Width,1));
Canvas.FillRect (Rect (0,0,1,Height));
Canvas.FillRect (Rect (0,Height-1,Width,Height));
Canvas.FillRect (Rect (width-1,0,Width,Height));

{
Canvas.Rectangle (0,0,Width,1);

Canvas.Rectangle (0,0,1,Height);
Canvas.Rectangle (0,Height-1,Width,Height);
Canvas.Rectangle (width-1,0,Width,Height);
}
{flat:=true;
self.Down :=false;
AState:=FState;
FState:=(bsDisabled);

Fstate:=Astate;

SetBkMode(Canvas.handle,Windows.Transparent);
Canvas.copyMode:=cmSrcCopy	;
Canvas.Draw (16,0,self.glyph);
Canvas.Font.Color :=clWhite;
PaintRect:=Rect(0,33,Width,Height);
DrawText(canvas.Handle, PChar(Caption), Length(Caption), PaintRect,//TextBounds,
DT_CENTER or DT_VCENTER );//or self.BiDiFlags);
}
end;

function TQuickLinker.FindSameCaptionLinker(const ACaption: string): Boolean;
var
  i: Integer;
  str: string;
begin
  Result := False;
  if (Owner <> nil) then
  begin
    for i := 0 to Owner.ComponentCount - 1 do
    begin
      if (Owner.Components[i] <> Self) and
        (Owner.Components[i] is TQuickLinker) then
      begin
        str := StringReplace(TQuickLinker(Owner.Components[i]).Caption, #13#10, '', [rfReplaceAll]);
        if SameText(str, ACaption) then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TQuickLinker.SetLink(ALink: TQuickLink);
var
  sBaseCaption: string;
  i: Integer;
begin
  if ALink = nil then
    exit;
  if Assigned(FLink) then
    exit;
  FLink := ALink;

  ALink.UpdateLinker(self);
  //if (ALink is TGroupLink) and ((ALink as TGroupLink).GetCount>0) then
  sBaseCaption := Caption;
  i := 0;
  while FindSameCaptionLinker(Caption) do
  begin
    Inc(i);
    Caption := sBaseCaption + {#13#10} '(' + IntToStr(i) + ')';
  end;
  sBaseCaption := Caption;
  ProcessMulitLine(sBaseCaption);
  Caption := sBaseCaption;
end;

procedure TQuickLinker.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  inherited;
  Perform(WM_LButtonUp, 0, MakeLong(Message.Xpos, Message.YPos));
  FLink.Execute;

end;

procedure TQuickLinker.SpeedButtonMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

begin

  if FMouseDown and (mbLeft = Button) and (not Locked) then
  begin
    //if (FMouseDownX=x) and (FMouseDownY=Y) then exit;
    //if (X<Width) and  (Y<Height) then
    begin
      //self.EndDrag(false) ;
      self.Left := min(max(Left + X - FMouseDownX, 1), Parent.ClientWidth - 64);
      self.Top := min(max(Top + Y - FMouseDowny, 1), Parent.ClientHeight - 64);
    end;
    FMouseDown := false;
  end;

end;

procedure TQuickLinker.LoadFromStream(Stream: TStream);
var
  szData: string;
begin
  //if FLink=nil then FLink:=TTreeFuncNodeLink.Create('');
  if FLink = nil then
    FLink := TQuickLinkFactory.GetInstance.CreateQuickLinkFromStream(Stream);

  //FLink.LoadFromStream (Stream);
  self.Left := FLink.Left;
  self.Top := FLink.Top;

  Stream.Read(FImageIndex, SizeOf(FImageIndex));
  Stream.Read(FLocked, SizeOf(FLocked));
  Locked := FLocked;
  TUtils.LoadStringFromStream(stream, szData);

  FLink.UpdateLinker(self);
  Caption := szData;
end;

procedure TQuickLinker.SaveToStream(Stream: TStream);
begin
  FLink.Left := self.Left;
  FLink.Top := self.Top;
  FLink.SaveToStream(Stream);
  Stream.Write(FImageIndex, SizeOf(FImageIndex));
  Stream.Write(FLocked, SizeOf(FLocked));
  TUtils.SaveStringToStream(stream, Caption);
end;

procedure TQuickLinker.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
end;

destructor TQuickLinker.Destroy;
begin
  menu.Free;
  inherited;
end;

procedure TQuickLinker.Rename;
var
  szNewName, szOldName: string;
begin
  szOldName := StringReplace(Caption, #13#10, '', [rfReplaceAll]);
  szNewName := MyInputBox('更改快捷方式的名称', '将快捷方式[' + szOldName +
    ']的名称更改为', szOldName);
  if Length(szNewName) > 8 then
  begin
    self.Caption := Copy(szNewName, 1, 8) + #13#10 + Copy(szNewName, 9, 8);
  end
  else
    self.Caption := szNewName;

  while FindSameCaptionLinker(Caption) do
  begin
    Application.MessageBox(PChar('"我的工作"桌面上已经有一个名为'#13#10#13#10'"' + Caption + '"'#13#10#13#10'的快捷方式，请给当前的快捷方式重新命名。'),'系统提示',MB_ICONInformation+MB_OK);
    szOldName := StringReplace(Caption, #13#10, '', [rfReplaceAll]);
    szNewName := MyInputBox('更改快捷方式的名称', '将快捷方式[' + szOldName +
      ']的名称更改为', szOldName);
    if Length(szNewName) > 8 then
    begin
      self.Caption := Copy(szNewName, 1, 8) + #13#10 + Copy(szNewName, 9, 8);
    end
    else
      self.Caption := szNewName;
  end;
end;

procedure TQuickLinker.MenuItemClick(Sender: TObject);
begin
  if not (Sender is TMenuItem) then
    exit;
  with Sender as TMenuItem do
  begin
    if Caption = '打开' then
      FLink.Execute
    else if Caption = '更名' then
      ReName
    else if Caption = '更换图标' then
      ChangeIcon
    else if Caption = '删除' then
    begin
      if SysMessage('您确定要删除该快捷方式吗？', '_XW', [mbYes, mbNo]) = mrYes then
        self.Delete
    end
    else if Caption = '属性' then
      ShowProperty
    else if Caption = '锁定' then
      Locked := true
    else if Caption = '解除锁定' then
      Locked := false;
  end;

end;

procedure TQuickLinker.Delete;
begin
  self.Free;
end;

procedure TQuickLinker.ShowProperty;
var
  frm: TFormLinkProperty;
  icon: TIcon;
begin
  icon := TIcon.Create;
  frm := TFormLinkProperty.Create(application);
  TImageList(Owner.FindComponent('ImageList')).GetIcon(imageIndex, Icon);
  frm.ShowModal(icon, StringReplace(Caption, #13#10, '', [rfReplaceAll]),
    FLink.Caption);
  frm.Free;
  icon.Free;

end;

procedure TQuickLinker.ChangeIcon;
var
  frm: TFormChangeIcon;
var
  aicon: Ticon;
begin
  frm := TFormChangeIcon.Create(application);
  if frm.ShowModal(ImageIndex, TImageList(Owner.FindComponent('ImageList'))) =
    IDOK then
  begin
    aicon := TIcon.Create;

    ImageIndex := frm.ComboBoxImages.ItemIndex;
    TImageList(Owner.FindComponent('ImageList')).GetIcon(ImageIndex, aicon);
    Glyph.Canvas.Brush.Color := clWhite;

    Glyph.Canvas.FillRect(Rect(0, 0, 32, 32));
    Glyph.Canvas.Draw(0, 0, aicon);
    aicon.Free;
    self.Invalidate;

  end;
  frm.Free;

end;

procedure TQuickLinker.ParentPaint;
var
  PaintRect: TRect;
  Offset: TPoint;
begin
  Canvas.Font := Self.Font;
  PaintRect := Rect(0, 0, Width, Height);
  InflateRect(PaintRect, -1, -1);
  Offset.X := 1;
  Offset.Y := 1;
  //    TButtonGlyph(FGlyph).Draw(Canvas, PaintRect, Offset, Caption, FLayout, FMargin,
  //        FSpacing, FState, Transparent, DrawTextBiDiModeFlags(0));

end;

procedure TQuickLinker.SetLocked(const Value: Boolean);
begin
  FLocked := Value;
  if FLocked then
    LockMenuItem.Caption := '解除锁定'
  else
    LockMenuItem.Caption := '锁定';
end;

procedure TQuickLinker.SetImage(ImageList: TImageList);
begin
  if FLink is TTreeFuncNodeLink then
    ImageList.GetBitmap(ImageIndex, Glyph);
end;

function TQuickLinker.MyInputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
  try
    Font.Name := '宋体';
    Font.Size := 9;
    Canvas.Font := Font;
    DialogUnits := GetAveCharSize(Canvas);
    BorderStyle := bsDialog;
    Caption := ACaption;
    ClientWidth := MulDiv(180, DialogUnits.X, 3);
    ClientHeight := MulDiv(63, DialogUnits.Y, 6);

    Position := poScreenCenter;
    Prompt := TLabel.Create(Form);
    with Prompt do
    begin
      Parent := Form;
      AutoSize := True;
      Left := MulDiv(8, DialogUnits.X, 3);
      Top := MulDiv(8, DialogUnits.Y, 6);
      Caption := APrompt;
    end;
    Edit := TEdit.Create(Form);
    with Edit do
    begin
      Parent := Form;
      Left := Prompt.Left;
      Top := MulDiv(19, DialogUnits.Y, 6);
      Width := MulDiv(164, DialogUnits.X, 3);
      MaxLength := 255;
      Text := Value;
      SelectAll;
    end;
    ButtonTop := MulDiv(41, DialogUnits.Y, 6);
    ButtonWidth := MulDiv(50, DialogUnits.X, 3);
    ButtonHeight := MulDiv(14, DialogUnits.Y, 6);
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := '确定';
      ModalResult := mrOk;
      Default := True;
      SetBounds(MulDiv(38, DialogUnits.X, 3), ButtonTop, ButtonWidth,
        ButtonHeight);
    end;
    with TButton.Create(Form) do
    begin
      Parent := Form;
      Caption := '取消';
      ModalResult := mrCancel;
      Cancel := True;
      SetBounds(MulDiv(92, DialogUnits.X, 3), ButtonTop, ButtonWidth,
        ButtonHeight);
    end;
    if ShowModal = mrOk then
    begin
      Value := Edit.Text;
      Result := True;
    end;
  finally
    Form.Free;
  end;
end;

function TQuickLinker.MyInputBox(const ACaption, APrompt, ADefault: string):
  string;
begin
  Result := ADefault;
  MyInputQuery(ACaption, APrompt, Result);
end;

procedure TQuickLinker.ProcessMulitLine(var ACaption: string);
var
  i, Len, j: Integer;
begin
  Len := Length(ACaption);
  i := 1;
  j := i;
  while i <= Len do
  begin
    //by mxl 2006.01.18 处理中英文混合乱码情况
    while (ByteType(ACaption, i) = mbTrailByte) and (i <= Len) do
      Inc(i);
    if i - j >= 10 then
    begin
      Insert(#13#10, ACaption, i);
      j := i;
    end
    else
      Inc(i);
  end;
  ACaption := Trim(ACaption);
end;

end.
