//==============================================================================
//  U10 菜单盒、菜单面板控件单元
//==============================================================================
//  崔立国 2011.04
//==============================================================================

unit MenuBox;

interface

uses
  Windows, SysUtils, Classes, Controls, StdCtrls, ExtCtrls, Forms, Menus,
  Graphics, Messages, ComCtrls, Math, Dialogs, Buttons;

const
  WM_REFRESHMENUS = WM_USER + 1101;

type

  TMenuBox = class;
  TMenuButton = class;
  TMenuLabel = class;
  TMenuUpDownPanel = class;

{ TMenuPopup }

  TMenuPopup = class(TGraphicControl)
  private
    FMenuLabel: TMenuLabel;
  protected
    procedure Click; override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TMenuLabel }

  TMenuLabel = class(TLabel)
  private
    FMenu: TMenuItem;
    FMenuButton: TMenuButton;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TMenuPanel }

  TMenuPanel = class(TPanel)
  private
    FMenuButton: TMenuButton;
    FMenuPopup: TMenuPopup;
    FCalendar: TMonthCalendar;
    FCalendarTimer: TTimer;
    FMoveUpPanel: TMenuUpDownPanel;
    FMoveDownPanel: TMenuUpDownPanel;
    FMenuLabelTopPos: Integer;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    function GetMoveDownLimit: Integer;
    function GetMoveUpLimit: Integer;
    procedure CalendarTimerOnTimer(Sender: TObject);
    procedure BuildCalendar(AMenuButton: TMenuButton);
    procedure BuildMenus(AMenuButton: TMenuButton);
    procedure ClearMenus;
    procedure ShowMenuPopup(AMenuLabel: TMenuLabel; Pt: TPoint);
    procedure HideMenuPopup;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    function ScrollBy(DeltaY: Integer): Boolean;
    procedure Paint; override;
  end;

{ TMenuButton }

  TMenuButtonStyle = (mbMenu, mbCalendar);

  TMenuButton = class(TGraphicControl)
  private
    FMenu: TMenuItem;
    FMenuBox: TMenuBox;
    FMenuPanel: TMenuPanel;
    FMenuButtonStyle: TMenuButtonStyle;
    FHoldTimer: TTimer;
    FHoverTimer: TTimer;
    FHoverCursorPos: TPoint;
    FHoverTickCount: Longword;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure BuildMenuPanel(AMenuItem: TMenuItem);
    procedure MenuPanelHoldTimerOnTimer(Sender: TObject);
    procedure MenuPanelHoverTimerOnTimer(Sender: TObject);
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ShowMenuPanel;
    procedure ShowMenuPanelImmediately;
    procedure HideMenuPanel;
    procedure HideMenuPanelImmediately;
    property Menu: TMenuItem read FMenu;
  end;

{ TMenuUpDownPanel }

  TUpDownMode = (udmNone, udmUp, udmDown);

  TMenuUpDownPanel = class(TSpeedButton)
  private
    FMenuBox: TMenuBox;
    FMenuPanel: TMenuPanel;
    FUpDownMode: TUpDownMode;
    FMoveTimer: TTimer;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure Paint; override;
    procedure UpDownPanelMoveTimerOnTimer(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

{ TMenuBox }

  TOtherMenuButtons = set of TMenuButtonStyle;

  TMenuNotifyEvent = procedure (AMenuItem: TMenuItem) of Object;
  TMenuButtonNotifyEvent = procedure (AMenuButton: TMenuButton) of Object;

  TMenuBox = class(TPanel)
  private
    FMainMenu: TMainMenu;
    FMenuItem: TMenuItem;
    FAlphaBlend: Byte;
    FAlphaBlendEnabled: Boolean;
    FMenuButtonHeight: Integer;
    FMenuPanelWidth: Integer;
    FOtherMenuButtons: TOtherMenuButtons;
    FOnCreateDesktopMenuIcon: TMenuNotifyEvent;
    FOnShowMenuPanel: TMenuButtonNotifyEvent;
    FMoveUpPanel: TMenuUpDownPanel;
    FMoveDownPanel: TMenuUpDownPanel;
    FUpDownEnabled: Boolean;
    FMenuButtonTopPos: Integer;
    procedure SetAlphaBlend(Value: Byte);
    procedure SetAlphaBlendEnabled(Value: Boolean);
    procedure SetMenuButtonHeight(Value: Integer);
    procedure SetMenuPanelWidth(Value: Integer);
    procedure SetUpDownEnabled(Value: Boolean);
    procedure SetOtherMenuButtons(Value: TOtherMenuButtons);
    procedure WMRefreshMenus(var Message: TMessage); message WM_REFRESHMENUS;
  protected
    procedure ClearMenuButtons;
    function CurrentMenuPanel: TMenuPanel;
    function GetMoveDownLimit: Integer;
    function GetMoveUpLimit: Integer;
    procedure HideOtherMenuPanels(AMenuPanel: TMenuPanel);
    procedure ResizeMenuButtons;
    procedure ResizeMenuPanels;
    procedure Resize; override;
    procedure DoCreateDesktopMenuIcon(AMenuItem: TMenuItem);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Invalidate; override;
    procedure LoadMainMenu(AMainMenu: TMainMenu);
    procedure LoadMenuItem(AMenuItem: TMenuItem);
    procedure RefreshMenus;
    function ScrollBy(DeltaY: Integer): Boolean;
    property AlphaBlend: Byte read FAlphaBlend write SetAlphaBlend default 200;
    property AlphaBlendEnabled: Boolean read FAlphaBlendEnabled write SetAlphaBlendEnabled default True;
    property MenuButtonHeight: Integer read FMenuButtonHeight write SetMenuButtonHeight default 30;
    property MenuPanelWidth: Integer read FMenuPanelWidth write SetMenuPanelWidth default 30;
    property UpDownEnabled: Boolean read FUpDownEnabled write SetUpDownEnabled;
    property OtherMenuButtons: TOtherMenuButtons read FOtherMenuButtons
      write SetOtherMenuButtons default [];
    property OnCreateDesktopMenuIcon: TMenuNotifyEvent read FOnCreateDesktopMenuIcon
      write FOnCreateDesktopMenuIcon;
    property OnShowMenuPanel: TMenuButtonNotifyEvent read FOnShowMenuPanel
      write FOnShowMenuPanel;
  end;

var
  GMenuBoxLineColor: TColor = clRed;
  GMenuButtonColor: TColor = clWhite;
  GMenuTextColor: TColor = clBlack;
  GMenuTransparentColor: TColor = $00111111;

  GMenuButtonBmp: TBitmap;
  GMenuButtonHotBmp: TBitmap;

  GImage_MenuLabel_Check: TBitmap;
  GImage_MenuLabel_Radio: TBitmap;
  GImage_MenuLabel_Popup: TBitmap;

  GMenuPanelHoldInterval: Word = 300;

procedure MixBitmapColor(Dest, Source: TBitmap; AColor: TColor);
function MixColors(AColor1, AColor2: TColor): TColor;

procedure DisableLayeredAttribs(W: TWinControl);
procedure SetLayeredAttribs(W: TWinControl; Alpha: Byte);
function SetLayeredWindowAttributes(Hwnd: THandle; crKey: COLORREF; bAlpha: Byte; dwFlags: DWORD): Boolean; stdcall;

implementation

{$R MENUBOX.RES}

const
  ciMenuLeftMarge_1  = 20;
  ciMenuLeftMarge_2  = 120;
  ciMenuTopMarge     = 20;
  ciMenuOffsetX      = 20;
  ciMenuOffsetY      = 10;

  ciMenuUpDownButtonHeight = 12;

type
  TMyMonthCalendar = class(TMonthCalendar);


function SetLayeredWindowAttributes; external user32 name 'SetLayeredWindowAttributes';

function TrimMenuCaption(ACaption: string): string;
var
  p1, p2: Integer;
begin
  p1 := Pos('(', ACaption);
  p2 := Pos(')', ACaption);
  if (p1 > 1) and (p2 > p1) then
  begin
    Result := Trim(Copy(ACaption, 1, p1 - 1) +
                   Copy(ACaption, p2 + 1, Length(ACaption) - p2 + 1))
  end else
    Result := ACaption;
end;

function GetMenuVisible(AMenu: TMenuItem): Boolean;
var
  i: Integer;
begin
  if (AMenu = nil) then
  begin
    Result := False;
    Exit;
  end;

  Result := AMenu.Visible;
  if Result and (AMenu.Count > 0) then
  begin
    for i := 0 to AMenu.Count - 1 do
    begin
      if GetMenuVisible(AMenu.Items[i]) then
        Exit;
    end;
    Result := False;
  end;
end;

procedure ChangeMenuLabelCheckRadioColor;
begin
  with GImage_MenuLabel_Check do
    if (Width > 10) then
    begin
      Canvas.Brush.Color := GMenuTextColor;
      Canvas.FloodFill(6, 6, Canvas.Pixels[0, 0], fsBorder);
    end;
  with GImage_MenuLabel_Radio do
    if (Width > 10) then
    begin
      Canvas.Brush.Color := GMenuTextColor;
      Canvas.FloodFill(6, 6, Canvas.Pixels[0, 0], fsBorder);
    end;
end;

function CursorOutSideOf(C: TControl): Boolean;
var
  Pt: TPoint;
begin
  Result := True;
  if (C <> nil) and GetCursorPos(Pt) then
  begin
    Pt := C.ScreenToClient(Pt);
    if PtInRect(C.ClientRect, Pt) then
      Result := False;
  end;
end;

function CursorInSideOf(C: TControl): Boolean;
var
  Pt: TPoint;
begin
  Result := False;
  if (C <> nil) and GetCursorPos(Pt) then
  begin
    Pt := C.ScreenToClient(Pt);
    if PtInRect(C.ClientRect, Pt) then
      Result := True;
  end;
end;

function GetParentForm(C: TControl): TForm;
var
  W: TWinControl;
begin
  if (C.Owner <> nil) and (C.Owner is TForm) then
    Result := TForm(C.Owner)
  else
  begin
    W := C.Parent;
    while W <> nil do
    begin
      if (W is TForm) then
      begin
        Result := TForm(W);
        Exit;
      end else
        W := W.Parent;
    end;
    Result := nil;
  end;
end;

function GetLeftOnForm(C: TControl): Integer;
var
  P: TForm;
  W: TControl;
  Pt: TPoint;
begin
  P := GetParentForm(C);
  W := C;
  Result := W.Left;
  while True do
  begin
    W := W.Parent;
    if (W = P) then
    begin
      Pt := W.ClientToScreen(Point(0, 0));
      Result := Result + Pt.x;
      Break;
    end;
    if (W <> nil) then Inc(Result, W.Left);
  end;
end;

function GetTopOnForm(C: TControl): Integer;
var
  P: TForm;
  W: TControl;
  Pt: TPoint;
begin
  P := GetParentForm(C);
  W := C;
  Result := W.Top;
  while True do
  begin
    W := W.Parent;
    if (W = P) then
    begin
      Pt := W.ClientToScreen(Point(0, 0));
      Result := Result + Pt.y;
      Break;
    end;
    if (W <> nil) then Inc(Result, W.Top);
  end;
end;

function MixColors(AColor1, AColor2: TColor): TColor;
var
  R1, G1, B1: Word;
  R2, G2, B2: Word;
begin
  R1 := (AColor1 and $FF0000) div $10000;
  G1 := (AColor1 and $00FF00) div $100;
  B1 := (AColor1 and $0000FF);
  R2 := (AColor2 and $FF0000) div $10000;
  G2 := (AColor2 and $00FF00) div $100;
  B2 := (AColor2 and $0000FF);
  Result := ((R1 + R2) div 2 * $10000) + ((G1 + G2) div 2 * $100) + ((B1 + B2) div 2);
end;

procedure MixBitmapColor(Dest, Source: TBitmap; AColor: TColor);
var
  i, k: Integer;
begin
  Dest.Assign(Source);
  for i := 0 to Dest.Width do
    for k := 0 to Dest.Height do
      Dest.Canvas.Pixels[i, k] := MixColors(Dest.Canvas.Pixels[i, k], AColor);
end;

procedure DisableLayeredAttribs(W: TWinControl);
const
  WS_EX_LAYERED = $00080000;
var
  FormStyle: Integer;
begin
  if W.HandleAllocated then
  begin
    FormStyle := GetWindowLong(W.Handle, GWL_EXSTYLE);
    if (FormStyle and WS_EX_LAYERED = WS_EX_LAYERED) then
      FormStyle := FormStyle xor WS_EX_LAYERED;
    SetWindowLong(W.Handle, GWL_EXSTYLE, FormStyle or WS_EX_TOOLWINDOW);
  end;
end;

procedure SetLayeredAttribs(W: TWinControl; Alpha: Byte);
const
  WS_EX_LAYERED = $00080000;
var
  FormStyle: Integer;
begin
  if W.HandleAllocated then
  begin
    Windows.SetParent(W.Handle, GetDesktopWindow);
    FormStyle := GetWindowLong(W.Handle, GWL_EXSTYLE);
    SetWindowLong(W.Handle, GWL_EXSTYLE, FormStyle or WS_EX_TOOLWINDOW or WS_EX_LAYERED);
    SetLayeredWindowAttributes(W.Handle, 0, Alpha, 2);
  end;
end;

{ TMenuPopup }

procedure TMenuPopup.Click;
begin
  inherited;
  Visible := False;
  FMenuLabel.FMenuButton.FMenuBox.DoCreateDesktopMenuIcon(FMenuLabel.FMenu);
  FMenuLabel.FMenuButton.Refresh;
end;

constructor TMenuPopup.Create(AOwner: TComponent);
begin
  inherited;
  Visible := False;
  Width := GImage_MenuLabel_Popup.Width;
  Height := GImage_MenuLabel_Popup.Height;
end;

procedure TMenuPopup.Paint;
begin
  with GImage_MenuLabel_Popup do
  begin
    Transparent := True;
    TransparentColor := Canvas.Pixels[0, 0];
  end;
  Canvas.Draw(0, 0, GImage_MenuLabel_Popup);
end;

{ TMenuLabel }

constructor TMenuLabel.Create(AOwner: TComponent);
begin
  inherited;
  Transparent := True;
end;

procedure TMenuLabel.CMMouseEnter(var Message: TMessage);
begin
  Font.Color := clRed;
  Font.Style := [fsUnderline];
end;

procedure TMenuLabel.CMMouseLeave(var Message: TMessage);
begin
  Font.Color := clBlack;
  Font.Style := [];
end;

procedure TMenuLabel.Click;
begin
  FMenuButton.HideMenuPanelImmediately;
  if FMenu <> nil then
    FMenu.Click;
end;

{ TMenuPanel }

constructor TMenuPanel.Create(AOwner: TComponent);
begin
  inherited;
  FMenuLabelTopPos := ciMenuTopMarge;
  Color := GMenuButtonColor;
  FMenuPopup := TMenuPopup.Create(self);
end;

procedure TMenuPanel.CMMouseLeave(var Message: TMessage);
begin
  if CursorOutSideOf(FMenuButton) and CursorOutSideOf(self) then
    FMenuButton.HideMenuPanel;
end;


function TMenuPanel.GetMoveUpLimit: Integer;
var
  i, iMaxBottom: Integer;
  Control: TControl;
begin
  iMaxBottom := 0;
  for i := 0 to ControlCount - 1 do
  begin
    Control := Controls[i];
    if Control.Visible and
       (Control <> FMoveUpPanel) and
       (Control <> FMoveDownPanel) and
       (Control <> FMenuPopup) then
    begin
      if Control.BoundsRect.Bottom > iMaxBottom then
        iMaxBottom := Control.BoundsRect.Bottom;
    end;
  end;
  Result := (ClientHeight - ciMenuTopMarge) - iMaxBottom;
end;

function TMenuPanel.GetMoveDownLimit: Integer;
var
  i, iMinTop: Integer;
  Control: TControl;
begin
  iMinTop := ClientHeight;
  for i := 0 to ControlCount - 1 do
  begin
    Control := Controls[i];
    if Control.Visible and
       (Control <> FMoveUpPanel) and
       (Control <> FMoveDownPanel) and
       (Control <> FMenuPopup) then
    begin
      if Control.BoundsRect.Top < iMinTop then
        iMinTop := Control.BoundsRect.Top;
    end;
  end;
  Result := ciMenuTopMarge - iMinTop;
end;

procedure TMenuPanel.CalendarTimerOnTimer(Sender: TObject);
begin
  if (FCalendarTimer.Tag = 0) then
    FCalendarTimer.Tag := 1
  else
    FCalendarTimer.Tag := 0;
  FMenuButton.Invalidate;
end;

procedure TMenuPanel.BuildCalendar(AMenuButton: TMenuButton);

  procedure AddCalendar;
  begin
    FCalendar := TMonthCalendar.Create(self);
    with FCalendar do
    begin
      Left := 10;
      Top := 10;
      AutoSize := True;
      CalColors.TitleBackColor := GMenuBoxLineColor;
      Parent := self;
    end;
    FCalendarTimer := TTimer.Create(self);
    FCalendarTimer.Interval := 1000;
    FCalendarTimer.OnTimer := CalendarTimerOnTimer;
  end;

var
  iW, iH: Integer;
begin
  // 崔立国 2011.04.16 菜单字体已改为黑色，不再修改图标颜色。
  // ChangeMenuLabelCheckRadioColor;

  ClearMenus;
  FMenuButton := AMenuButton;

  AddCalendar;

  iW := FCalendar.Width;
  iH := Fcalendar.Height;
  FCalendar.HandleNeeded;
  TMyMonthCalendar(FCalendar).CanAutoSize(iW, iH);
  Width := iW + 20;
  Height := iH + 20;

  // 崔立国 2011.04.16 必须调用Canvas的方法，否则不能透明。原因待查！！！
  Canvas.TextHeight('高度');
end;

procedure TMenuPanel.BuildMenus(AMenuButton: TMenuButton);
var
  TmpMenu: TMenuItem; 
  i, iLeft, iTop: Integer;

  procedure AddBreakLine;
  begin
    if (iLeft > ciMenuLeftMarge_2) then
      Inc(iTop, Canvas.TextHeight('高度') + ciMenuOffsetY);
    iLeft := ciMenuLeftMarge_1;

    if iTop > ciMenuTopMarge then
    begin
      with TShape.Create(self) do
      begin
        Left := iLeft;
        Top := iTop;
        Height := 1;
        Width := self.ClientWidth - iLeft - ciMenuLeftMarge_1;
        Pen.Color := clSilver;
        Parent := self;
      end;
      Inc(iTop, ciMenuOffsetY);
    end;
  end;

  procedure AddMenuLabel(AMenu: TMenuItem; IsGroup: Boolean);
  var
    TmpLabel: TLabel;
    s: string;
  begin
    if not GetMenuVisible(AMenu) then Exit;

    if (AMenu.Caption <> '-') then
    begin
      if IsGroup then
      begin
        TmpLabel := TLabel.Create(self);
        TmpLabel.Font.Color := GMenuTextColor;
      end else
      begin
        TmpLabel := TMenuLabel.Create(self);
        TmpLabel.Font.Color := clBlack;
        TMenuLabel(TmpLabel).FMenu := AMenu;
        TMenuLabel(TmpLabel).FMenuButton := FMenuButton;
      end;

      s := TrimMenuCaption(AMenu.Caption);
      if IsGroup then
      begin
        if Length(s) > 12 then
          s := Copy(s, 1, 12);
      end;

      TmpLabel.Enabled := AMenu.Enabled;
      TmpLabel.Caption := s;
      TmpLabel.AutoSize := True;
      TmpLabel.Transparent := True;
      TmpLabel.Font.Name := '宋体';
      TmpLabel.Font.Size := 9;
      TmpLabel.Hint := AMenu.Hint;
      TmpLabel.ShowHint := True;

      if IsGroup then
        TmpLabel.Font.Style := [fsBold]
      else
        TmpLabel.Cursor := crHandPoint;

      if IsGroup then
      begin
        AddBreakLine;
      end
      else
      begin
        if (iLeft < ciMenuLeftMarge_2) then
          iLeft := ciMenuLeftMarge_2;
        if (iLeft + TmpLabel.Width + ciMenuOffsetX > ClientWidth) then
        begin
          iLeft := ciMenuLeftMarge_2;
          Inc(iTop, TmpLabel.Height + ciMenuOffsetY);
        end;
      end;
      
      if (not IsGroup) and (AMenu.Checked) then
      begin
        with TImage.Create(self) do
        begin
          if AMenu.RadioItem then
            Picture.Bitmap.Assign(GImage_MenuLabel_Radio)
          else
            Picture.Bitmap.Assign(GImage_MenuLabel_Check);

          Left := iLeft;
          Top := iTop + (TmpLabel.Height - GImage_MenuLabel_Check.Height) div 2;
          Transparent := True;
          Parent := self;
        end;

        Inc(iLeft, GImage_MenuLabel_Check.Width + 3);
      end;

      TmpLabel.Left := iLeft;
      TmpLabel.Top := iTop;
      TmpLabel.Parent := self;

      if (not IsGroup) then
      begin
        // 崔立国 2011.04.16 菜单之间增加隔线
        with TShape.Create(self) do
        begin
          Left := iLeft - ciMenuOffsetX div 2;
          if (not IsGroup) and (AMenu.Checked) then
            Left := Left - GImage_MenuLabel_Check.Width - 3;
          Top := iTop;
          Height := Canvas.TextHeight('高度');
          Width := 1;
          Pen.Color := clSilver;
          Parent := self;
        end;
      end;

      if IsGroup then
        iLeft := ciMenuLeftMarge_2
      else
        Inc(iLeft, TmpLabel.Width + ciMenuOffsetX);
    end;
  end;

  procedure AddSubMenuLabel(AMenu: TMenuItem; IsGroup: Boolean);
  var
    i: Integer;
  begin
    if not GetMenuVisible(AMenu) then Exit;

    // 崔立国 2011.04.14 添加菜单到左侧分组区域。
    if IsGroup then
      AddMenuLabel(AMenu, True);

    // 崔立国 2011.04.14 添加子菜单到右侧分层区域。
    for i := 0 to AMenu.Count - 1 do
    begin
      if AMenu.Items[i].Count = 0 then
        AddMenuLabel(AMenu.Items[i], False)
      else
        AddSubMenuLabel(AMenu.Items[i], False);
    end;
  end;

var
  bNewLine: Boolean;
  iPanelHeight: Integer;
begin
  // 崔立国 2011.04.16 菜单字体已改为黑色，不再修改图标颜色。
  // ChangeMenuLabelCheckRadioColor;

  ClearMenus;
  FMenuButton := AMenuButton;
  if (AMenuButton <> nil) and (AMenuButton.FMenu <> nil) then
  begin
    TmpMenu := AMenuButton.FMenu;

    iLeft := ciMenuLeftMarge_2;
    iTop  := ciMenuTopMarge;

    // 1、添加有子菜单的一级菜单到上面几层的二级菜单区域。
    for i := 0 to TmpMenu.Count - 1 do
    begin
      if TmpMenu.Items[i].Count > 0 then
      begin
        AddSubMenuLabel(TmpMenu.Items[i], True);
      end;
    end;

    // 2、添加没有子菜单的一级菜单到最下层二级菜单区域。
    bNewLine := True;
    for i := 0 to TmpMenu.Count - 1 do
    begin
      if TmpMenu.Items[i].Count = 0 then
      begin
        if bNewLine then
        begin
          AddBreakLine;
          bNewLine := False;
        end;
        AddMenuLabel(TmpMenu.Items[i], False);
      end;
    end;

    if TmpMenu.Count = 0 then
    begin
      AddMenuLabel(TmpMenu, False);
    end;

    iPanelHeight := iTop + Canvas.TextHeight('高度') + ciMenuTopMarge;
    if (iPanelHeight > Screen.Height - 80) then
      iPanelHeight := Screen.Height - 80;

    if iPanelHeight > Screen.Height - Top then
      Height := Screen.Height - Top
    else
      Height := iPanelHeight;
  end;

  // 崔立国 2011.04.15 添加顶部空白区域
  FMoveUpPanel := TMenuUpDownPanel.Create(self);
  with FMoveUpPanel do
  begin
    Top := 2;
    Left := 1;
    Width := ciMenuLeftMarge_2 - 21;
    Parent := self;
    FMenuPanel := self;
    FUpDownMode := udmUp;
  end;

  // 崔立国 2011.04.15 添加底部空白区域
  FMoveDownPanel := TMenuUpDownPanel.Create(self);
  with FMoveDownPanel do
  begin
    Top := self.ClientHeight - Height - 2;
    Left := 1;
    Width := ciMenuLeftMarge_2 - 21;
    Parent := self;
    FMenuPanel := self;
    FUpDownMode := udmDown;
  end;

end;

procedure TMenuPanel.ClearMenus;
var
  i: Integer;
begin
  for i := ComponentCount - 1 downto 0 do
  begin
    if not (Components[i] is TMenuPopup) then
      Components[i].Free;
  end;
  Height := 100;
end;

procedure TMenuPanel.ShowMenuPopup(AMenuLabel: TMenuLabel; Pt: TPoint);
begin
  FMenuPopup.FMenuLabel := AMenuLabel;
  FMenuPopup.Left := Pt.X - FMenuPopup.Width div 2;
  FMenuPopup.Top := Pt.Y + 2;
  FMenuPopup.Parent := self;
  FMenuPopup.Visible := True;
end;

procedure TMenuPanel.HideMenuPopup;
begin
  FMenuPopup.Visible := False;
end;

function TMenuPanel.ScrollBy(DeltaY: Integer): Boolean;
var
  i, iLimit: Integer;
  Control: TControl;
begin
  Result := False;

  if (DeltaY < 0) then
  begin
    iLimit := GetMoveUpLimit;
    // 如果想上移菜单面板但不需要上移，则退出。
    if (iLimit >= 0) then Exit;
    if (DeltaY < iLimit) then DeltaY := iLimit;
  end
  else if (DeltaY > 0) then
  begin
    iLimit := GetMoveDownLimit;
    // 如果想下移菜单面板但不需要下移，则退出。
    if (iLimit <= 0) then Exit;
    if (DeltaY > iLimit) then DeltaY := iLimit;
  end
  else
    Exit;

  FMenuLabelTopPos := ciMenuTopMarge;
  for i := 0 to ControlCount - 1 do
  begin
    Control := Controls[i];
    if not (Control is TMenuUpDownPanel) then
    begin
      Control.Top := Control.Top + DeltaY;
      // 保存顶部MenuLabel位置，以便在Resize时可以重新定位保持相对位置固定。
      if FMenuLabelTopPos > Control.Top then
        FMenuLabelTopPos := Control.Top;
    end;
  end;

  if (FMoveUpPanel <> nil) then
    FMoveUpPanel.Refresh;
  if (FMoveDownPanel <> nil) then
    FMoveDownPanel.Refresh;

  Result := True;
end;

procedure TMenuPanel.Paint;
var
  BufferBitmap: TBitmap;
  C: TCanvas;
  R: TRect;
  iOffsetY: Integer;
begin
  BufferBitmap := TBitmap.Create;
  try
    BufferBitmap.Width := ClientWidth;
    BufferBitmap.Height := ClientHeight;
    C := BufferBitmap.Canvas;

    // 1、画双色背景
    R := Rect(0, 0, ciMenuLeftMarge_2 - 20, ClientHeight);
    C.Brush.Color := GMenuButtonColor;
    C.FillRect(R);
    R := Rect(ciMenuLeftMarge_2 - 20, 0, ClientWidth, ClientHeight);
    C.Brush.Color := MixColors(MixColors(GMenuButtonColor, clWhite), clWhite);
    C.FillRect(R);

    // 2、画边框
    iOffsetY := GetTopOnForm(FMenuButton) - Top;
    // 画外线（正常色）
    C.Brush.Color := GMenuBoxLineColor;
    R := Rect(0, 0, ClientWidth, 1);
    C.FillRect(R);
    R := Rect(ClientWidth - 1, 0, ClientWidth, ClientHeight);
    C.FillRect(R);
    R := Rect(0, ClientHeight - 1, ClientWidth, ClientHeight);
    C.FillRect(R);
    R := Rect(0, FMenuButton.Height - 1 + iOffsetY, 1, ClientHeight);
    C.FillRect(R);
    R := Rect(0, 0, 1, iOffsetY + 1);
    C.FillRect(R);
    // 画中线（浅色）
    C.Brush.Color := MixColors(C.Brush.Color, clWhite);
    R := Rect(1, 1, ClientWidth - 1, 2);
    C.FillRect(R);
    R := Rect(ClientWidth - 2, 1, ClientWidth - 1, ClientHeight - 1);
    C.FillRect(R);
    R := Rect(1, ClientHeight - 2, ClientWidth - 1, ClientHeight - 1);
    C.FillRect(R);
    R := Rect(1, FMenuButton.Height - 1 + iOffsetY, 1, ClientHeight - 1);
    C.FillRect(R);
    R := Rect(1, 0, 1, iOffsetY + 1);
    C.FillRect(R);

    Canvas.Draw(0, 0, BufferBitmap);
  finally
    BufferBitmap.Free;
  end;
end;

procedure TMenuPanel.Resize;
begin
  inherited;
  // BuildMenus(FMenuButton);
end;

{ TMenuButton }

constructor TMenuButton.Create(AOwner: TComponent);
begin
  inherited;

  ParentFont := True;
  Color := GMenuButtonColor;
  Cursor := crHandPoint;

  FMenuPanel := nil;
  FMenuButtonStyle := mbMenu;

  FHoldTimer := TTimer.Create(self);
  FHoldTimer.Enabled := False;
  FHoldTimer.OnTimer := MenuPanelHoldTimerOnTimer;

  FHoverTimer := TTimer.Create(self);
  FHoverTimer.Enabled := False;
  FHoverTimer.Interval := 200;
  FHoverTimer.OnTimer := MenuPanelHoverTimerOnTimer;
  FHoverCursorPos := Point(0, 0);
  FHoverTickCount := GetTickCount;
end;

procedure TMenuButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  ShowMenuPanel;
end;

procedure TMenuButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  // 崔立国 2011.04.18 如果：
  // 1、光标位于FMenuBox界外；
  // 2、或同时位于FMenuPanel和FMenuButton界外；
  // 3、或位于FMoveUpButton或FMoveDownButton界内；
  // 则关闭FMenuPanel。
  if (CursorOutSideOf(FMenuBox)) or
     (CursorOutSideOf(FMenuPanel) and CursorOutSideOf(self)) or
     (CursorInSideOf(FMenuBox.FMoveUpPanel) or CursorInSideOf(FMenuBox.FMoveDownPanel)) then
    HideMenuPanel;
end;

procedure TMenuButton.BuildMenuPanel(AMenuItem: TMenuItem);
begin
  FMenu := AMenuItem;
  if FMenuPanel = nil then
  begin
    FMenuPanel := TMenuPanel.Create(self);
  end;
  FMenuPanel.FMenuButton := self;
  FMenuPanel.Visible := False;

  if FMenuBox.FMenuPanelWidth = 0 then
    FMenuPanel.Width := Screen.Width * 3 div 4
  else
    FMenuPanel.Width := FMenuBox.FMenuPanelWidth;

  FMenuPanel.ParentWindow := GetDesktopWindow;
  case FMenuButtonStyle of
    mbMenu: FMenuPanel.BuildMenus(self);
    mbCalendar: FMenuPanel.BuildCalendar(self);
  end;
  if FMenuBox.AlphaBlendEnabled then
    SetLayeredAttribs(FMenuPanel, 10)
  else
    DisableLayeredAttribs(FMenuPanel);
end;

procedure TMenuButton.MenuPanelHoldTimerOnTimer(Sender: TObject);
begin
  FHoldTimer.Enabled := False;
  if FHoldTimer.Tag = 1 then
  begin
    // 崔立国 2011.04.16 如果光标还停留在当前菜单按钮之内，并且没有在正在打开的其他菜单面板之内，则打开当前菜单面板
    if (not CursorOutSideOf(self)) and (CursorOutSideOf(FMenuBox.CurrentMenuPanel)) then
      ShowMenuPanelImmediately;
  end else
  begin
    // 崔立国 2011.04.16 如果光标已经不在当前菜单按钮和当前菜单面板之外则关闭菜单面板。
    if CursorOutSideOf(self) and CursorOutSideOf(FMenuPanel) then
      HideMenuPanelImmediately;
  end;
end;

procedure TMenuButton.MenuPanelHoverTimerOnTimer(Sender: TObject);
var
  Pt: TPoint;
  Ctrl: TControl;
begin
  if (FMenuPanel <> nil) and FMenuPanel.Visible then
  begin
    if GetCursorPos(Pt) then
    begin
      Pt := FMenuPanel.ScreenToClient(Pt);
      // 崔立国 2011.04.16 处理光标悬停
      if (FHoverCursorPos.X = Pt.X) and (FHoverCursorPos.Y = Pt.Y) then
      begin
        Ctrl := FMenuPanel.ControlAtPos(Pt, False);
        if (Ctrl <> nil) then
        begin
          if (Ctrl is TMenuLabel) then
          begin
            // 如果悬停时间超过2秒
            if ((GetTickCount - FHoverTickCount) >= 2000) then
            begin
              FHoverTickCount := GetTickCount;
              FMenuPanel.ShowMenuPopup(TMenuLabel(Ctrl), Pt);
            end;
          end
          else if not (Ctrl is TMenuPopup) then
            FMenuPanel.HideMenuPopup;
        end else
          FMenuPanel.HideMenuPopup;
      end else
      begin
        FHoverTickCount := GetTickCount;
        FHoverCursorPos := Pt;
      end;
    end;
  end else
    FHoverTimer.Enabled := False;
end;

procedure TMenuButton.Paint;
var
  BufferBitmap: TBitmap;
  C: TCanvas;
  s: string;
  R, CalcRect: TRect;
begin
  BufferBitmap := TBitmap.Create;
  try
    BufferBitmap.Width := ClientWidth;
    BufferBitmap.Height := ClientHeight;
    C := BufferBitmap.Canvas;

    s := ' 菜单按钮 ';
    case FMenuButtonStyle of
      mbMenu:
        begin
          if FMenu <> nil then
            s := ' ' + TrimMenuCaption(FMenu.Caption) + ' ';
        end;
      mbCalendar:
        begin
          if (FMenuPanel.FCalendarTimer.Tag = 1) then
            s := FormatDateTime('" "mm"月"dd"日 "hh:nn" "', Now)
          else
            s := FormatDateTime('" "mm"月"dd"日 "hh nn" "', Now);
        end;
    end;

    // 1、画底色
    C.Brush.Style := bsSolid;
    C.Brush.Color := GMenuButtonColor;
    C.FillRect(ClientRect);

    if (FMenuPanel <> nil) and FMenuPanel.Visible then
    begin
      if (GMenuButtonHotBmp.Height > 5) then
        C.StretchDraw(ClientRect, GMenuButtonHotBmp)
      else if (GMenuButtonBmp.Height > 5) then
        C.StretchDraw(ClientRect, GMenuButtonBmp);
    end else
    begin
      if (GMenuButtonBmp.Height > 5) then
        C.StretchDraw(ClientRect, GMenuButtonBmp);
    end;

    // 2、画底线
    if (GMenuButtonBmp.Height <= 5) then
    begin
      C.Brush.Color := GMenuBoxLineColor;
      R := Rect(10, ClientHeight - 1, ClientWidth - 10, ClientHeight);
      C.FillRect(R);
    end;

    // 3、画边框（三条线渐变色）
    if (FMenuPanel <> nil) and FMenuPanel.Visible then
    begin
      // 画外线（正常色）
      C.Brush.Color := GMenuBoxLineColor;
      R := Rect(10, 0, 11, ClientHeight - 1);
      C.FillRect(R);
      // 画中线（浅色）
      C.Brush.Color := MixColors(C.Brush.Color, clWhite);
      R := Rect(11, 0, ClientWidth - 10, 1);
      C.FillRect(R);
      R := Rect(11, ClientHeight - 2, ClientWidth - 10, ClientHeight - 1);
      C.FillRect(R);
      R := Rect(11, 1, 12, ClientHeight - 1);
      C.FillRect(R);
      // 画内线（更浅色）
      C.Brush.Color := MixColors(C.Brush.Color, clWhite);
      R := Rect(12, 1, ClientWidth - 10, 2);
      C.FillRect(R);
      R := Rect(12, ClientHeight - 3, ClientWidth - 10 - 1, ClientHeight - 2);
      C.FillRect(R);
      R := Rect(12, 1, 13, ClientHeight - 2);
      C.FillRect(R);
    end;

    // 4、菜单按钮文本
    C.Font.Color := GMenuTextColor;
    C.Font.Size := 9;
    C.Font.Name := '宋体';
    if (FMenuPanel <> nil) and FMenuPanel.Visible then
    begin
      C.Font.Style := [fsUnderline, fsBold];
    end else
    begin
      C.Font.Style := [fsBold];
    end;
    C.Brush.Style := bsClear;
    R := ClientRect;
    
    CalcRect := R;
    R.Left := 20;
    DrawText(C.Handle, PChar(s), Length(s), CalcRect, DT_LEFT or DT_CALCRECT);
    R.Top := R.Top + ((R.Bottom - R.Top) - (CalcRect.Bottom - CalcRect.Top)) div 2;
    DrawText(C.Handle, PChar(s), Length(s), R, DT_LEFT);

    Canvas.Draw(0, 0, BufferBitmap);
  finally
    BufferBitmap.Free;
  end;

  if (FMenuPanel <> nil) and FMenuPanel.Visible then
    FMenuPanel.BringToFront;

end;

procedure TMenuButton.ShowMenuPanel;
begin
  if (FMenuButtonStyle = mbCalendar) then Exit;

  if GMenuPanelHoldInterval = 0 then
  begin
    ShowMenuPanelImmediately;
  end else
  begin
    FHoldTimer.Interval := GMenuPanelHoldInterval;
    FHoldTimer.Tag := 1; //  崔立国 2011.04.14 打开菜单面板
    FHoldTimer.Enabled := True;
    if Assigned(FMenuBox.OnShowMenuPanel) then
      FMenuBox.OnShowMenuPanel(self);
  end;
end;

procedure TMenuButton.ShowMenuPanelImmediately;
var
  iTop, iMaxTop: Integer;
  i, n, iAlpha: Integer;
begin
  if (FMenuPanel <> nil) and (not FMenuPanel.Visible) then
  begin
    // 崔立国 2011.05.29 先关闭所有其他正在显示的菜单面板。
    FMenuBox.HideOtherMenuPanels(FMenuPanel);

    // 崔立国 2011.04.16 显示菜单面板前先隐藏MenuPopup。
    FMenuPanel.FMenuPopup.Visible := False;

    iTop := GetTopOnForm(self) - 1;
    if (FMenuButtonStyle = mbMenu) then
    begin
      iMaxTop := GetTopOnForm(FMenuBox) + FMenuBox.Height - FMenuPanel.Height;
      if iTop > iMaxTop then iTop := iMaxTop;
      if iTop < 0 then iTop := 0;
    end;

    FMenuPanel.Left := GetLeftOnForm(self) + Width - 10;
    if FMenuBox.FMenuPanelWidth <= 0 then
      FMenuPanel.Width := Screen.Width * 3 div 4
    else
      FMenuPanel.Width := FMenuBox.FMenuPanelWidth;
    if FMenuPanel.Width > Screen.Width - FMenuPanel.Left - 20 then
      FMenuPanel.Width := Screen.Width - FMenuPanel.Left - 20;

    FMenuPanel.Top := iTop;

    FMenuPanel.BuildMenus(self);

    FMenuPanel.Visible := True;

    Refresh;

    if FMenuBox.FAlphaBlendEnabled then
    begin
      // 崔立国 2011.04.16 实现淡入淡出效果
      n := 4;
      for i := 1 to n do
      begin
        iAlpha := FMenuBox.FAlphaBlend * i div n;
        SetLayeredWindowAttributes(FMenuPanel.Handle, 0, iAlpha, 2);
        Application.ProcessMessages;
        if (i < n) then
          Sleep(60);
      end;
    end else
    begin
      DisableLayeredAttribs(FMenuPanel);
      Application.ProcessMessages;
    end;

    FHoverTimer.Enabled := True;
  end;
end;

procedure TMenuButton.HideMenuPanel;
begin
  if GMenuPanelHoldInterval = 0 then
  begin
    HideMenuPanelImmediately;
  end else
  begin
    FHoldTimer.Interval := GMenuPanelHoldInterval;
    FHoldTimer.Tag := 0; //  崔立国 2011.04.14 关闭菜单面板
    FHoldTimer.Enabled := True;
  end;
end;

procedure TMenuButton.HideMenuPanelImmediately;
begin
  if (FMenuPanel <> nil) then
  begin
    FMenuPanel.Visible := False;

    Refresh;

    FHoverTimer.Enabled := False;
  end;
end;

{ TMenuUpDownPanel }

constructor TMenuUpDownPanel.Create(AOwner: TComponent);
begin
  inherited;
  Top := 0;
  Height := ciMenuUpDownButtonHeight;

  FUpDownMode := udmNone;

  FMoveTimer := TTimer.Create(self);
  FMoveTimer.Enabled := False;
  FMoveTimer.Interval := 100;
  FMoveTimer.OnTimer := UpDownPanelMoveTimerOnTimer;
end;

procedure TMenuUpDownPanel.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Refresh;
  if (FMenuBox <> nil) then
    FMenuBox.HideOtherMenuPanels(nil);
  FMoveTimer.Enabled := True;
end;

procedure TMenuUpDownPanel.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Refresh;
  FMoveTimer.Enabled := False;
end;

procedure TMenuUpDownPanel.Paint;
var
  C: TCanvas;
  R: TRect;
begin
  C := Canvas;

  // 1、画底色
  C.Brush.Style := bsSolid;
  if CursorInSideOf(self) and (FUpDownMode <> udmNone) then
    C.Brush.Color := MixColors(GMenuButtonColor, $80FFFF)
  else
    C.Brush.Color := GMenuButtonColor;
  C.FillRect(ClientRect);

  if (FMenuBox <> nil) then
  begin
    if (FUpDownMode <> udmNone) then
    begin
      C.Font.Name := '宋体';
      C.Font.Color := GMenuBoxLineColor;
      if (FUpDownMode = udmUp) and (FMenuBox.GetMoveDownLimit > 0) then
      begin
        C.Font.Size := 5;
        C.TextOut((ClientRect.Right - ClientRect.Left) div 2 - 5, 2, '▲');
      end else if (FUpDownMode = udmDown)  and (FMenuBox.GetMoveUpLimit < 0) then
      begin
        C.Font.Size := 6;
        C.TextOut((ClientRect.Right - ClientRect.Left) div 2 - 5, 2, '▼');
      end;
    end;
  end;

  if (FMenuPanel <> nil) then
  begin
    if (FUpDownMode <> udmNone) then
    begin
      C.Font.Name := '宋体';
      C.Font.Color := GMenuBoxLineColor;
      if (FUpDownMode = udmUp) and (FMenuPanel.GetMoveDownLimit > 0) then
      begin
        C.Font.Size := 5;
        C.TextOut((ClientRect.Right - ClientRect.Left) div 2 - 5, 2, '▲');
      end else if (FUpDownMode = udmDown)  and (FMenuPanel.GetMoveUpLimit < 0) then
      begin
        C.Font.Size := 6;
        C.TextOut((ClientRect.Right - ClientRect.Left) div 2 - 5, 2, '▼');
      end;
    end;
  end;

  if (FMenuBox <> nil) then
  begin
    // 2、画底线（与TMenuButton效果相同）
    // 如果向上
    if (FUpDownMode = udmUp) and (FMenuBox.GetMoveUpLimit > 0) then
      C.Brush.Color := MixColors(GMenuBoxLineColor, clRed)
    else if (FUpDownMode = udmDown) and (FMenuBox.GetMoveDownLimit > 0) then
      C.Brush.Color := MixColors(GMenuBoxLineColor, clRed)
    else    
      C.Brush.Color := GMenuBoxLineColor;
    R := Rect(10, ClientHeight - 1, ClientWidth - 10, ClientHeight);
    C.FillRect(R);
  end;
end;

procedure TMenuUpDownPanel.UpDownPanelMoveTimerOnTimer(Sender: TObject);
var
  b: Boolean;
  step: Integer;
begin
  step := 10;
  if (FMenuBox <> nil) then
  begin
    if FUpDownMode = udmUp then
      b := FMenuBox.ScrollBy(step)
    else if FUpDownMode = udmDown then
      b := FMenuBox.ScrollBy(-step);
  end
  else if (FMenuPanel <> nil) then
  begin
    if FUpDownMode = udmUp then
      b := FMenuPanel.ScrollBy(step)
    else if FUpDownMode = udmDown then
      b := FMenuPanel.ScrollBy(-step);
  end;

  if (not b) then FMoveTimer.Enabled := False;
end;

{ TMenuBox }

constructor TMenuBox.Create(AOwner: TComponent);
begin
  inherited;
  Color := GMenuButtonColor;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  ParentFont := True;
  FAlphaBlend := 200;
  FAlphaBlendEnabled := True;
  FMenuButtonHeight := 30;
  FOtherMenuButtons := [];
  FUpDownEnabled := True;
  FMenuButtonTopPos := ciMenuUpDownButtonHeight;
end;

procedure TMenuBox.SetAlphaBlend(Value: Byte);
begin
  if (FAlphaBlend <> Value) then
  begin
    FAlphaBlend := Value;
    RefreshMenus;
  end;
end;

procedure TMenuBox.SetAlphaBlendEnabled(Value: Boolean);
begin
  if (FAlphaBlendEnabled <> Value) then
  begin
    FAlphaBlendEnabled := Value;
    RefreshMenus;
  end;
end;

procedure TMenuBox.SetMenuButtonHeight(Value: Integer);
begin
  if FMenuButtonHeight <> Value then
  begin
    FMenuButtonHeight := Value;
    ResizeMenuButtons;
  end;
end;

procedure TMenuBox.SetMenuPanelWidth(Value: Integer);
begin
  if FMenuPanelWidth <> Value then
  begin
    FMenuPanelWidth := Value;
    ResizeMenuButtons;
  end;
end;

procedure TMenuBox.SetUpDownEnabled(Value: Boolean);
begin
  FUpDownEnabled := Value;
  if Value then
  begin
    if (FMoveUpPanel <> nil) then FMoveUpPanel.FUpDownMode := udmUp;
    if (FMoveDownPanel <> nil) then FMoveDownPanel.FUpDownMode := udmDown;
  end else
  begin
    if (FMoveUpPanel <> nil) then FMoveUpPanel.FUpDownMode := udmNone;
    if (FMoveDownPanel <> nil) then FMoveDownPanel.FUpDownMode := udmNone;
  end;
end;

procedure TMenuBox.SetOtherMenuButtons(Value: TOtherMenuButtons);
begin
  if FOtherMenuButtons <> Value then
  begin
    FOtherMenuButtons := Value;
    RefreshMenus;
  end;
end;

procedure TMenuBox.WMRefreshMenus(var Message: TMessage);
begin
  if (FMainMenu <> nil) then
    LoadMainMenu(FMainMenu)
  else if (FMenuItem <> nil) then
    LoadMenuItem(FMenuItem);
end;

procedure TMenuBox.ClearMenuButtons;
var
  i: Integer;
begin
  FMoveUpPanel := nil;
  FMoveDownPanel := nil;

  for i := ControlCount - 1 downto 0 do
    if (Controls[i] is TMenuButton) or (Controls[i] is TMenuUpDownPanel) then
      Controls[i].Free;
end;

function TMenuBox.GetMoveUpLimit: Integer;
var
  i, iMaxBottom: Integer;
  Control: TControl;
begin
  iMaxBottom := 0;
  for i := 0 to ControlCount - 1 do
  begin
    Control := Controls[i];
    if (Control is TMenuButton) then
    begin
      if Control.BoundsRect.Bottom > iMaxBottom then
        iMaxBottom := Control.BoundsRect.Bottom;
    end;
  end;
  Result := (ClientHeight - ciMenuUpDownButtonHeight) - iMaxBottom;
end;

function TMenuBox.GetMoveDownLimit: Integer;
var
  i, iMinTop: Integer;
  Control: TControl;
begin
  iMinTop := ClientHeight;
  for i := 0 to ControlCount - 1 do
  begin
    Control := Controls[i];
    if (Control is TMenuButton) then
    begin
      if Control.BoundsRect.Top < iMinTop then
        iMinTop := Control.BoundsRect.Top;
    end;
  end;
  Result := ciMenuUpDownButtonHeight - iMinTop;
end;

function TMenuBox.CurrentMenuPanel: TMenuPanel;
var
  i: Integer;
begin
  for i := ControlCount - 1 downto 0 do
    if (Controls[i] is TMenuButton) then
    begin
      Result := TMenuButton(Controls[i]).FMenuPanel;
      if (Result <> nil) and Result.Visible then
        Exit;
    end;

  Result := nil;
end;

procedure TMenuBox.HideOtherMenuPanels(AMenuPanel: TMenuPanel);
var
  i: Integer;
  panel: TMenuPanel;
begin
  for i := ControlCount - 1 downto 0 do
    if (Controls[i] is TMenuButton) then
    begin
      panel := TMenuButton(Controls[i]).FMenuPanel;
      if (panel <> nil) and (panel <> AMenuPanel) and panel.Visible then
      begin
        panel.Visible := False;
        TMenuButton(Controls[i]).Invalidate;
      end;
    end;
end;

procedure TMenuBox.ResizeMenuButtons;
var
  i, iTop: Integer;
begin
  iTop := FMenuButtonTopPos;

  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i] is TMenuButton then
    begin
      with Controls[i] do
      begin
        Left := 0;
        Top := iTop;
        Height := FMenuButtonHeight;
        Width := self.ClientWidth;

        Inc(iTop, FMenuButtonHeight);
      end;
    end;
  end;

  if (FMoveUpPanel <> nil) then
  begin
    FMoveUpPanel.Width := self.ClientWidth;
    FMoveUpPanel.Top := 0;
  end;

  if (FMoveDownPanel <> nil) then
  begin
    FMoveDownPanel.Width := self.ClientWidth;
    FMoveDownPanel.Top := self.ClientHeight - ciMenuUpDownButtonHeight;
  end;
end;

procedure TMenuBox.ResizeMenuPanels;
var
  i: Integer;
begin
  for i := ControlCount - 1 downto 0 do
    if Controls[i] is TMenuButton then
    begin
      with TMenuButton(Controls[i]).FMenuPanel do
      begin
        Width := FMenuPanelWidth;
      end;
    end;
end;

procedure TMenuBox.Resize;
begin
  inherited;
  ResizeMenuButtons;
end;

function TMenuBox.ScrollBy(DeltaY: Integer): Boolean;
var
  i, iLimit: Integer;
  Control: TControl;
begin
  Result := False;

  if (DeltaY < 0) then
  begin
    iLimit := GetMoveUpLimit;
    // 如果想上移菜单盒但不需要上移，则退出。
    if (iLimit >= 0) then Exit;
    if (DeltaY < iLimit) then DeltaY := iLimit;
  end
  else if (DeltaY > 0) then
  begin
    iLimit := GetMoveDownLimit;
    // 如果想下移菜单盒但不需要下移，则退出。
    if (iLimit <= 0) then Exit;
    if (DeltaY > iLimit) then DeltaY := iLimit;
  end
  else
    Exit;

  FMenuButtonTopPos := ciMenuUpDownButtonHeight;
  for i := 0 to ControlCount - 1 do
  begin
    Control := Controls[i];
    if (Control is TMenuButton) then
    begin
      Control.Top := Control.Top + DeltaY;
      // 保存顶部MenuButton位置，以便在Resize时可以重新定位保持相对位置固定。
      if FMenuButtonTopPos > Control.Top then
        FMenuButtonTopPos := Control.Top;
    end;
  end;

  if (FMoveUpPanel <> nil) then
    FMoveUpPanel.Refresh;
  if (FMoveDownPanel <> nil) then
    FMoveDownPanel.Refresh;

  Result := True;
end;

procedure TMenuBox.LoadMainMenu(AMainMenu: TMainMenu);
var
  i, iTop: Integer;
  mButton: TMenuButton;
begin
  ClearMenuButtons;

  FMainMenu := AMainMenu;
  FMenuItem := nil;

  if AMainMenu = nil then Exit;

  // 崔立国 2011.04.15 添加顶部空白区域
  iTop := FMenuButtonTopPos;

  for i := 0 to AMainMenu.Items.Count - 1 do
  begin
    if AMainMenu.Items[i].Visible and
      (AMainMenu.Items[i].Tag >= 0) then
    begin
      mButton := TMenuButton.Create(self);
      mButton.FMenuButtonStyle := mbMenu;
      mButton.FMenuBox := self;
      mButton.Height := FMenuButtonHeight;
      mButton.Top := iTop;
      mButton.Left := 0;
      mButton.Width := ClientWidth;
      mButton.Parent := self;
      // 崔立国 2011.04.14 BuildMenuPanel() 必须在 Parent := self 之后。
      mButton.BuildMenuPanel(AMainMenu.Items[i]);

      Inc(iTop, mButton.Height);
    end;
  end;

  // 崔立国 2011.04.16 增加其他菜单按钮
  if mbCalendar in FOtherMenuButtons then
  begin
    mButton := TMenuButton.Create(self);
    mButton.FMenuButtonStyle := mbCalendar;
    mButton.FMenuBox := self;
    mButton.Height := FMenuButtonHeight;
    mButton.Top := iTop;
    mButton.Left := 0;
    mButton.Width := ClientWidth;
    mButton.Parent := self;
    // 崔立国 2011.04.14 BuildMenuPanel() 必须在 Parent := self 之后。
    mButton.BuildMenuPanel(nil);
  end;

  // 崔立国 2011.04.15 添加顶部空白区域
  FMoveUpPanel := TMenuUpDownPanel.Create(self);
  with FMoveUpPanel do
  begin
    Top := 0;
    Left := 0;
    Width := self.ClientWidth;
    Parent := self;
    FMenuBox := self;
    if FUpDownEnabled then
      FUpDownMode := udmUp;
  end;

  // 崔立国 2011.04.15 添加底部空白区域
  FMoveDownPanel := TMenuUpDownPanel.Create(self);
  with FMoveDownPanel do
  begin
    Top := self.ClientHeight - Height;
    Left := 0;
    Width := self.ClientWidth;
    Parent := self;
    FMenuBox := self;
    if FUpDownEnabled then
      FUpDownMode := udmDown;
  end;
end;

procedure TMenuBox.LoadMenuItem(AMenuItem: TMenuItem);
var
  i, iTop: Integer;
  mButton: TMenuButton;
begin
  ClearMenuButtons;

  FMainMenu := nil;
  FMenuItem := AMenuItem;

  if AMenuItem = nil then Exit;

  // 崔立国 2011.04.15 添加顶部空白区域
  iTop := FMenuButtonTopPos;

  for i := 0 to AMenuItem.Count - 1 do
  begin
    if AMenuItem.Items[i].Visible and
      (AMenuItem.Items[i].Caption <> '-') and
      (AMenuItem.Items[i].Tag >= 0) then
    begin
      mButton := TMenuButton.Create(self);
      mButton.FMenuButtonStyle := mbMenu;
      mButton.FMenuBox := self;
      mButton.Height := FMenuButtonHeight;
      mButton.Top := iTop;
      mButton.Left := 0;
      mButton.Width := ClientWidth;
      mButton.Parent := self;
      // 崔立国 2011.04.14 BuildMenuPanel() 必须在 Parent := self 之后。
      mButton.BuildMenuPanel(AMenuItem.Items[i]);

      Inc(iTop, mButton.Height);
    end;
  end;

  // 崔立国 2011.04.16 增加其他菜单按钮
  if mbCalendar in FOtherMenuButtons then
  begin
    mButton := TMenuButton.Create(self);
    mButton.FMenuButtonStyle := mbCalendar;
    mButton.FMenuBox := self;
    mButton.Height := 40;
    mButton.Top := iTop;
    mButton.Left := 0;
    mButton.Width := ClientWidth;
    mButton.Parent := self;
    // 崔立国 2011.04.14 BuildMenuPanel() 必须在 Parent := self 之后。
    mButton.BuildMenuPanel(nil);
  end;

  // 崔立国 2011.04.15 添加顶部空白区域
  FMoveUpPanel := TMenuUpDownPanel.Create(self);
  with FMoveUpPanel do
  begin
    Top := 0;
    Left := 0;
    Width := self.ClientWidth;
    Parent := self;
    FMenuBox := self;
    if FUpDownEnabled then
      FUpDownMode := udmUp;
  end;

  // 崔立国 2011.04.15 添加底部空白区域
  FMoveDownPanel := TMenuUpDownPanel.Create(self);
  with FMoveDownPanel do
  begin
    Top := self.ClientHeight - Height;
    Left := 0;
    Width := self.ClientWidth;
    Parent := self;
    FMenuBox := self;
    if FUpDownEnabled then
      FUpDownMode := udmDown;
  end;

end;

procedure TMenuBox.RefreshMenus;
begin
  PostMessage(Handle, WM_REFRESHMENUS, 0, 0);
end;

procedure TMenuBox.Invalidate;
var
  i: Integer;
begin
  inherited;
  for i := 0 to ControlCount - 1 do
    Controls[i].Invalidate;
end;

procedure TMenuBox.DoCreateDesktopMenuIcon(AMenuItem: TMenuItem);
begin
  if Assigned(FOnCreateDesktopMenuIcon) then
    FOnCreateDesktopMenuIcon(AMenuItem);
end;

initialization
  // 崔立国 2011.04.16 获取Windows系统光标
  Screen.Cursors[crHandPoint] := LoadCursor(0, IDC_HAND); // crHandPoint;

  GMenuButtonBmp := TBitmap.Create;
  GMenuButtonHotBmp := TBitmap.Create;

  GImage_MenuLabel_Check := TBitmap.Create;
  GImage_MenuLabel_Radio := TBitmap.Create;
  GImage_MenuLabel_Popup := TBitmap.Create;
  GImage_MenuLabel_Check.LoadFromResourceName(HInstance, 'MenuLabel_CHECK');
  GImage_MenuLabel_Radio.LoadFromResourceName(HInstance, 'MenuLabel_RADIO');
  GImage_MenuLabel_Popup.LoadFromResourceName(HInstance, 'MenuLabel_POPUP');

finalization
  GMenuButtonBmp.Free;
  GMenuButtonHotBmp.Free;

  GImage_MenuLabel_Check.Free;
  GImage_MenuLabel_Radio.Free;
  GImage_MenuLabel_Popup.Free;

end.
