unit WindowsList;

interface  

uses SysUtils, Windows, Messages, Classes, extctrls, Controls, Graphics, Forms, Math, Menus,Dialogs,DataModuleMain,Pub_Global,Pub_Function;

type
  TWindowOperation = (woOpen, woClose, woNormal, woMax, woMin);

  TOnPopupMenu = procedure(Index: Integer; var Popop: Boolean) of object;
  TDrawPanel = class;

  TMDIChildItem = class
  public
    Existed: Boolean;
    Form: TForm;
    FormHandle:HWND;//因为窗体已释放了，所以这里要先记录下
    sModeName:String;
    sCurBplName:String;
    sGNFLMC:string;
    Button: TDrawPanel;
    DLLTaskHandle:HWND; //主程序任务栏句柄，用途是MDI窗体关闭时，再发消息给主程序
    bNotEncrypt:Boolean; //是否加密
  end;

  TMDIChildList = class(TScrollBox)
  private
    FContainerPanel: TPanel;
    FMDIMain: TForm;
    FImageList: TImageList;
    FImageIndex: Integer;
    FSelectedIndex: Integer;
    FItemHeight: Integer;
    FCount: Integer;
    FMaxHeight: Integer;
    FPopupMenu: TPopupMenu;
    FItemColor: TColor;
    FSelectedColor: TColor;
    FFont: TFont;
    FShowCloseButton: Boolean;
    FOnPopupMenu: TOnPopupMenu;
    procedure SetMDIMain(const Value: TForm);
    procedure SetImageList(const Value: TImageList);
    procedure SetImageIndex(const Value: Integer);
    procedure SetSelectedIndex(const Value: Integer);
    procedure SetParent(const Value: TWinControl);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetHeight(const Value: Integer);
    procedure SetFont(const Value: TFont);
    function GetHeight: Integer;
    function GetLeft: Integer;
    function GetParent: TWinControl;
    function GetTop: Integer;
    function GetWidth: Integer;
    function GetAlign: TAlign;
    procedure SetAlign(const Value: TAlign);
    function GetMaxHeight: Integer;
    procedure SetMaxHeight(const Value: Integer);
    function GetBevelInner: TPanelBevel;
    function GetBevelOuter: TPanelBevel;
    procedure SetBevelInner(const Value: TPanelBevel);
    procedure SetBevelOuter(const Value: TPanelBevel);
    function GetVBStyle: TScrollBarStyle;
    procedure SetVBStyle(const Value: TScrollBarStyle);
    procedure SetPopupMenu(const Value: TPopupMenu);
    function GetParentColor: Boolean;
    procedure SetItemColor(const Value: TColor);
    procedure SetParentColor(const Value: Boolean);
    procedure SetSelectedColor(const Value: TColor);
    procedure SetShowCloseButton(const Value: Boolean);
    procedure SetOnPopupMenu(const Value: TOnPopupMenu);
  private
    FBitmap: TBitmap;
    FSelectedBitmap: TBitmap;
    FSelectedButton: TDrawPanel;
    procedure GetItemBounds(Index: Integer; var ALeft, ATop, AWidth, AHeight: Integer);
    procedure ItemClick(Sender: TObject; Up: Boolean);
    procedure ClearListState;
    procedure UpdateItemPos(Index, Pos: Integer);
    procedure DeleteNotExist;
    procedure Add(ACom: TComponent;pForm:TForm);
    function IndexByForm(AForm: TForm): Integer;
    function IndexByButton(AButton: TDrawPanel): Integer;
    procedure ActivateChild(AButton: TDrawPanel);
    procedure UpdateHeight;
    procedure UpdateItemCaption;
  protected
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

  public
    FList: TList;    //sCurModeName:string; //当前正调用的模块名
    bHaveMDI:Boolean;
    bCreatingForm:Boolean; //正在创建窗体不能再次创建
    bMDICanUnLoad:Boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;

    procedure UpdateList;
    procedure Refresh;
    function HaveMode(psModeName:String):Boolean;
    function GetModeGnCount(psModename:string;pscurbplname:String):Integer;        
    function CallWindow(AIndex: Integer; Operation: TWindowOperation): Boolean;
    function GetSelectedIndex: Integer;
    function GetModeNameByHandle(FormHandle:HWND):string;    
  public
    property Parent: TWinControl read GetParent write SetParent;
    property MDIMain: TForm read FMDIMain write SetMDIMain;
    property Count: Integer read FCount;
    property ImageList: TImageList read FImageList write SetImageList;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property SelectedIndex: Integer read FSelectedIndex write SetSelectedIndex;
    property Left: Integer read GetLeft write SetLeft;
    property Top: Integer read GetTop write SetTop;
    property Width: Integer read GetWidth write SetWidth;
    property Height: Integer read GetHeight write SetHeight;
    property MaxHeight: Integer read GetMaxHeight write SetMaxHeight;
    property Align: TAlign read GetAlign write SetAlign;
    property BevelOuter: TPanelBevel read GetBevelOuter write SetBevelOuter;
    property BevelInner: TPanelBevel read GetBevelInner write SetBevelInner;
    property ItemHeight: Integer read FItemHeight write FItemHeight;
    property VertScrollBarStyle: TScrollBarStyle read GetVBStyle write SetVBStyle;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property ParentColor: Boolean read GetParentColor write SetParentColor;
    property ItemColor: TColor read FItemColor write SetItemColor default clBtnFace;
    property SelectedColor: TColor read FSelectedColor write SetSelectedColor default clBtnFace;
    property Font: TFont read FFont write SetFont;
    property ShowCloseButton: Boolean read FShowCloseButton write SetShowCloseButton;
    property OnPopupMenu: TOnPopupMenu read FOnPopupMenu write SetOnPopupMenu;
  end;

  TClickEvent = procedure(Sender: TObject; Up: Boolean) of object;

  TDrawPanel = class(TCustomPanel)
  private
    FOnClick: TClickEvent;
    FDown: Boolean;
    FForm: TForm;
    FShowCloseButton: Boolean;
    procedure SetOnClick(const Value: TClickEvent);
    procedure SetDown(const Value: Boolean);
    procedure SetShowCloseButton(const Value: Boolean);
  private
    FItemList: TMDIChildList;
    procedure UpdateOthers;
  protected
    procedure Paint; override;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Down: Boolean read FDown write SetDown;
    property Form: TForm read FForm write FForm;
    property OnClick: TClickEvent read FOnClick write SetOnClick;
    property ShowCloseButton: Boolean read FShowCloseButton write SetShowCloseButton;
  end;

var
  GWinBarBmp: TBitmap;
  GWinBarHotBmp: TBitmap;

implementation

uses Main, UIR9_IMPL;

{ TMDIChildList }
procedure TMDIChildList.ActivateChild(AButton: TDrawPanel);
var
  idx: Integer;
begin
  idx := IndexByButton(AButton);
  if idx >= 0 then
  begin
    TMDIChildItem(FList[idx]).Form.BringToFront; //TM201105240004 放在最大化前面，解决有的子窗体不能正常最大化的问题 by zhougf 2011.5.23
    TMDIChildItem(FList[idx]).Form.WindowState := wsMaximized;
    if (FormMain.FslUIR9_IMPL<>nil) then
        FormMain.FslUIR9_IMPL.ActiveForm(TMDIChildItem(FList[idx]).sModeName);  //窗体已创建，激活窗体，执行初始化过程 TMDIChildItem(FList[idx]).Form.Handle
  end;
end;

procedure TMDIChildList.Add(ACom: TComponent;pForm:TForm);
var
  itemLeft, itemTop, itemWidth, itemHeight: Integer;
  panel: TDrawPanel;
  item: TMDIChildItem;
  i:Integer;
  UIR9_IMPL : TUIR9_IMPL;
  bhaveSameModeAndBpl:Boolean;
begin
  bHaveMDI := True;

  if (FImageIndex >= 0) and (FSelectedIndex < 0) then
  begin
    if not Assigned(FSelectedBitmap) then
    begin
      FSelectedBitmap := TBitmap.Create;
      FImageList.GetBitmap(FImageIndex, FSelectedBitmap);
    end;
  end;
  Inc(FCount);
  panel := TDrawPanel.Create(Self);
  panel.Parent := Self;
  GetItemBounds(FCount - 1, itemLeft, itemTop, itemWidth, itemHeight);
  panel.SetBounds(itemLeft, itemTop, itemWidth, itemHeight);
  panel.OnClick := ItemClick;
  panel.Caption := TForm(ACom).Caption;
  panel.Hint := panel.Caption;
  panel.BevelOuter := BevelOuter;
  panel.BevelInner := BevelInner;
  item := TMDIChildItem.Create;
  item.Form := TForm(ACom);
  item.FormHandle := item.Form.handle;
  item.Button := panel;
  item.Existed := True;
  item.sGNFLMC := rMainSub.GsGnflMc;  //  GsGnflMc主要用于调试，测试是调用的什么功能
  item.sModeName := rMainSub.GsCurModName;
  item.sCurBplName := rMainSub.GsCurBplName;
  item.bNotEncrypt := rMainSub.bNotEncrypt; //但是打开showmodal窗体时，不会执行这段代码 既TMDIChildList.Add
  item.DLLTaskHandle:=0;
  FList.Add(item);

  try //由于存在这种情况，一个窗口打开后(特别是showmodal窗口)，如果关闭了这个窗口，则加密就被释放，但这个窗口在关闭后他又打开了另一个窗口，则加密不会被创建(因为不会调用showfor来创建加密)，所以在这里创建下
    bhaveSameModeAndBpl := False;
    if PGetNeedEncryptMode(rMainSub.GsCurModName) then begin
       for i:= 0 to FormMain.FslUIR9_IMPL.FslUIR9.Count-1 do begin
          UIR9_IMPL := TUIR9_IMPL(FormMain.FslUIR9_IMPL.FslUIR9.Objects[i]);
          if (rMainSub.GsCurModName=UIR9_IMPL.FsModeName)and(rMainSub.GsCurBplName=UIR9_IMPL.FsBPLName) then begin
             bhaveSameModeAndBpl := True; //增加rMainSub.GsCurBplName=UIR9_IMPL.FsBPLName条件 是为了解决同一个模块名下挂了其他的模块的bpl，切换时找到错误的UIR9_IMPL，比如FBS 菜单里调用 ybc.bpl，这时创建一个YBC.bpl的UIR9_IMPL对象，再打开FBS 的FBS.bpl，创建FBS.bpl的UIR9_IMPL对象，关闭这个FBS的窗体后再打开这个FBS的窗体，则会找到YBC.bpl的UIR9_IMPL对象,这是不对的，应该找FBS.bpl的UIR9_IMPL对象
             if (UIR9_IMPL.Global_Mode<>nil) and (UIR9_IMPL.Global_Mode.AnyiClient1=nil) then begin  // and (not UIR9_IMPL.Global_Mode.bNeedInitMode)
                 UIR9_IMPL.Global_Mode.ReConnectEncrypt;
             end;
             Break;
          end;
       end;

       if not bhaveSameModeAndBpl then begin //改代码可能不会被执行(但考虑到稳定及FsBPLName赋值出错及showmodal窗口，以免释放后，找不到原来的bpl名，而无法创建加密
          for i:= 0 to FormMain.FslUIR9_IMPL.FslUIR9.Count-1 do begin
            UIR9_IMPL := TUIR9_IMPL(FormMain.FslUIR9_IMPL.FslUIR9.Objects[i]);
            if (rMainSub.GsCurModName=UIR9_IMPL.FsModeName)and(rMainSub.GsCurBplName<>UIR9_IMPL.FsBPLName) then begin
               if (UIR9_IMPL.Global_Mode<>nil) and (UIR9_IMPL.Global_Mode.AnyiClient1=nil) then begin  // and (not UIR9_IMPL.Global_Mode.bNeedInitMode)
                   UIR9_IMPL.Global_Mode.ReConnectEncrypt;
               end;
               Break;
            end;
          end;       
       end;
    end;
  except
  end;
  (*if Trim(item.sModeName)<>'' then
     SendMessage(FMDIMain.Handle,WM_DLLMDICreate,item.FormHandle,0); //发消息到主程序，动态库窗口已创建，并发送了动态库任务栏上按钮的句柄 *)
end;

procedure TMDIChildList.ClearListState;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    TMDIChildItem(FList[i]).Existed := False;
end;

constructor TMDIChildList.Create(AOwner: TComponent);
begin
  bHaveMDI := False;
  bCreatingForm := False;
  bMDICanUnLoad := False;
  FContainerPanel := TPanel.Create(AOwner);
  FContainerPanel.BevelInner := bvNone;
  FContainerPanel.BevelOuter := bvNone;
  inherited Create(FContainerPanel);
  inherited Parent := FContainerPanel;
  VertScrollBar.Style := ssFlat;
  FCount := 0;
  FList := TList.Create;
  FImageIndex := -1;
  FSelectedIndex := -1;
  FItemColor := clBtnFace;
  FSelectedColor := clBtnFace;
  FFont := TFont.Create;
  FItemHeight := 29;
  BorderStyle := bsNone;
  FMaxHeight := -1;
  ParentColor := True;
  FShowCloseButton := True;
  inherited Align := alClient;
  FBitmap := nil;
  FSelectedBitmap := nil;
end;

procedure TMDIChildList.DeleteNotExist;
var
  i, j: Integer;
  Form: TForm;  
begin
  ClearListState;
  for i := FList.Count - 1 downto 0 do begin
    form := TMDIChildItem(FList[i]).Form;
    for j := 0 to FMDIMain.MDIChildCount - 1 do begin
      if FMDIMain.MDIChildren[j] = Form then begin
         Break;
      end;
    end;
    if (FMDIMain.MDIChildCount <> 0) and (j < FMDIMain.MDIChildCount) then begin
       TMDIChildItem(FList[i]).Existed := True;
    end;

    if not TMDIChildItem(FList[i]).Existed then begin
      if bHaveMDI {and rMainSub.bFreeBpl} then begin
         if (GetModeGnCount(TMDIChildItem(FList[i]).sModeName,TMDIChildItem(FList[i]).scurbplname)<=1) or (FList.Count<=1) then begin
             if TMDIChildItem(FList[i]).Formhandle<>0 then begin
                rMainSub.GsCurFreeAnyiCleintModName := TMDIChildItem(FList[i]).sModeName;
                rMainSub.GsCurBplName := TMDIChildItem(FList[i]).sCurBplName;
                SendMessage(FMDIMain.Handle,WM_DLLMainClose, TMDIChildItem(FList[i]).Formhandle,0); //当前模块所有窗口已关闭了
             end;
         end;
         //if (Global_Mode<>nil) and Global_Mode.FbDBProcess then //要重新更新下待办信息
         //   FormMain.UpdateDBSY(True,Global_Mode.FsModeName);
      end;
      TDrawPanel(TMDIChildItem(FList[i]).Button).Free;
      TMDIChildItem(FList[i]).Free;
      FList.Delete(i);
    end;
  end;
end;

destructor TMDIChildList.Destroy;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    TMDIChildItem(FList[i]).Free;
  FList.Free;
  FFont.Free;
  if FBitmap <> nil then FBitmap.Free;
  if FSelectedBitmap <> nil then FSelectedBitmap.Free;
end;

function TMDIChildList.GetAlign: TAlign;
begin
  Result := FContainerPanel.Align;
end;

function TMDIChildList.GetBevelInner: TPanelBevel;
begin
  Result := FContainerPanel.BevelInner
end;

function TMDIChildList.GetBevelOuter: TPanelBevel;
begin
  Result := FContainerPanel.BevelOuter
end;

function TMDIChildList.GetHeight: Integer;
begin
  Result := FContainerPanel.Height
end;

procedure TMDIChildList.GetItemBounds(Index: Integer; var ALeft, ATop, AWidth, AHeight: Integer);
begin
  ALeft := 0;
  ATop := Index * FItemHeight;
  AWidth := ClientWidth;
  AHeight := FItemHeight;
end;

function TMDIChildList.GetLeft: Integer;
begin
  Result := FContainerPanel.Left
end;

function TMDIChildList.GetMaxHeight: Integer;
begin
  Result := FMaxHeight
end;

function TMDIChildList.GetParent: TWinControl;
begin
  Result := FContainerPanel.Parent
end;

function TMDIChildList.GetSelectedIndex: Integer;
begin
  Result := -1;
  if Assigned(FSelectedButton) then
  begin
    Result := IndexByButton(FSelectedButton);
  end;
end;

function TMDIChildList.GetTop: Integer;
begin
  Result := FContainerPanel.Top
end;

function TMDIChildList.GetVBStyle: TScrollBarStyle;
begin
  Result := VertScrollBar.Style;
end;

function TMDIChildList.GetWidth: Integer;
begin
  Result := FContainerPanel.Width
end;

function TMDIChildList.IndexByButton(AButton: TDrawPanel): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FList.Count - 1 do
  begin
    if TMDIChildItem(FList[i]).Button = AButton then
    begin
      Result := i;
      Break;
    end;
  end;
end;

function TMDIChildList.IndexByForm(AForm: TForm): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to FList.Count - 1 do
  begin
    if TMDIChildItem(FList[i]).Form = AForm then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TMDIChildList.ItemClick(Sender: TObject; Up: Boolean);
begin
  ActivateChild(TDrawPanel(Sender));
  ScrollInView(TDrawPanel(Sender));
end;

function TMDIChildList.CallWindow(AIndex: Integer; Operation: TWindowOperation): Boolean;
var
  form: TForm;
begin
  Result := False;
  if (AIndex < 0) or (AIndex >= Count) then
    Exit;
  form := TMDIChildItem(FList[AIndex]).Form;
  if not Assigned(form) then
    Exit;
  case Operation of
    woOpen: form.BringToFront;
    woClose: form.Close;
    woNormal: form.WindowState := wsNormal;
    woMax: form.WindowState := wsMaximized;
    woMin: form.WindowState := wsMinimized;
  end;
  Result := True;
end;

procedure TMDIChildList.Refresh;
var
  i: Integer;
begin
  UpdateHeight;
  UpdateItemCaption;
  for i := 0 to FList.Count - 1 do
    TMDIChildItem(FList[i]).Button.Refresh;
end;

procedure TMDIChildList.SetAlign(const Value: TAlign);
begin
  FContainerPanel.Align := Value
end;

procedure TMDIChildList.SetBevelInner(const Value: TPanelBevel);
begin
  FContainerPanel.BevelInner := Value;
end;

procedure TMDIChildList.SetBevelOuter(const Value: TPanelBevel);
begin
  FContainerPanel.BevelOuter := Value;
end;

procedure TMDIChildList.SetHeight(const Value: Integer);
begin
  FContainerPanel.Height := Value;
  if FMaxHeight = -1 then
    FMaxHeight := Value
end;

procedure TMDIChildList.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
  Invalidate;
end;

procedure TMDIChildList.SetImageList(const Value: TImageList);
begin
  FImageList := Value;
end;

procedure TMDIChildList.SetImageIndex(const Value: Integer);
begin
  FImageIndex := Value;
  if Assigned(FImageList) and (FImageIndex >= 0) then
  begin
    if not Assigned(FBitmap) then
      FBitmap := TBitmap.Create;
    FImageList.GetBitmap(FImageIndex, FBitmap);
    FBitmap.Transparent := True;
    FBitmap.TransparentMode := tmAuto;
  end;
end;

procedure TMDIChildList.SetSelectedIndex(const Value: Integer);
begin
  FSelectedIndex := Value;
  if Assigned(FImageList) and (FSelectedIndex >= 0) then
  begin
    if not Assigned(FSelectedBitmap) then
      FSelectedBitmap := TBitmap.Create;
    FImageList.GetBitmap(FSelectedIndex, FSelectedBitmap);
    FSelectedBitmap.Transparent := True;
    FSelectedBitmap.TransparentMode := tmAuto;
  end;
end;

procedure TMDIChildList.SetLeft(const Value: Integer);
begin
  FContainerPanel.Left := Value;
end;

procedure TMDIChildList.SetMaxHeight(const Value: Integer);
begin
  if Value > Height then
    FMaxHeight := Value;
end;

procedure TMDIChildList.SetMDIMain(const Value: TForm);
begin
  FMDIMain := Value;
end;

procedure TMDIChildList.SetParent(const Value: TWinControl);
begin
  FContainerPanel.Parent := Value;
  inherited Parent := FContainerPanel;
end;

procedure TMDIChildList.SetPopupMenu(const Value: TPopupMenu);
begin
  FPopupMenu := Value;
end;

procedure TMDIChildList.SetTop(const Value: Integer);
begin
  FContainerPanel.Top := Value;
end;

procedure TMDIChildList.SetVBStyle(const Value: TScrollBarStyle);
begin
  VertScrollBar.Style := Value;
end;

procedure TMDIChildList.SetWidth(const Value: Integer);
begin
  FContainerPanel.Width := Value;
end;

procedure TMDIChildList.UpdateHeight;
var
  i, h: Integer;
begin
  h := FCount * FItemHeight;
  FContainerPanel.Height := Min(h, FMaxHeight);

  VertScrollBar.Range := FCount * FItemHeight;
  HorzScrollBar.Range := ClientWidth;
  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i] is TDrawPanel then
    begin
      (Controls[i] as TDrawPanel).Width := ClientWidth;
    end;
  end;
end;

procedure TMDIChildList.UpdateItemCaption;
var
  i: Integer;
  item: TMDIChildItem;
begin
  for i := 0 to FList.Count - 1 do
  begin
    item := TMDIChildItem(FList[i]);
    if not SameText(item.Form.Caption, item.Button.Caption) then
    begin
      item.Button.Caption := item.Form.Caption
    end;
  end;
end;

procedure TMDIChildList.UpdateItemPos(Index, Pos: Integer);
var
  t, l, w, h: Integer;
begin
  GetItemBounds(Pos, l, t, w, h);
  TDrawPanel(TMDIChildItem(FList[Index]).Button).SetBounds(l, t, w, h);
end;

procedure TMDIChildList.UpdateList;
var
  i, Idx: Integer;
  child: TForm;
begin
  if bCreatingForm then Exit;
  try
    bCreatingForm := True;
    DeleteNotExist;
    for i := 0 to FMDIMain.MDIChildCount - 1 do
    begin
      child := FMDIMain.MDIChildren[i];
      Idx := IndexByForm(child);
      if Idx < 0 then begin
         Add(child,FMDIMain);
         rMainSub.bShow := True; //表示捕获到了窗体，则赋值为true
      end;
    end;
    FCount := FList.Count;
    if IndexByButton(FSelectedButton) < 0 then
       FSelectedButton := nil;
    VertScrollBar.Position := 0;
    for i := 0 to FList.Count - 1 do
      UpdateItemPos(i, i);
    UpdateHeight;
    UpdateItemCaption;
    // Activate button
    Idx := IndexByForm(FMDIMain.ActiveMDIChild);
    if Idx >= 0 then begin
      if (rMainSub.GsStartModName= TMDIChildItem(FList[Idx]).sModeName) then begin
          rMainSub.bShow := True; //表示捕获到了窗体，则赋值为true
      end;

      TDrawPanel(TMDIChildItem(FList[Idx]).Button).Down := True;
      ScrollInView(TDrawPanel(TMDIChildItem(FList[Idx]).Button));
    end;
  finally
    bCreatingForm := False;  
  end;
end;

procedure TMDIChildList.WMSize(var Message: TWMSize);
begin
  UpdateHeight;
  UpdateItemCaption;
end;

function TMDIChildList.GetParentColor: Boolean;
begin
  Result := FContainerPanel.ParentColor;
end;

procedure TMDIChildList.SetItemColor(const Value: TColor);
begin
  FItemColor := Value;
end;

procedure TMDIChildList.SetParentColor(const Value: Boolean);
begin
  FContainerPanel.ParentColor := Value;
end;

procedure TMDIChildList.SetSelectedColor(const Value: TColor);
begin
  FSelectedColor := Value;
end;

procedure TMDIChildList.SetShowCloseButton(const Value: Boolean);
begin
  FShowCloseButton := Value;
end;

procedure TMDIChildList.SetOnPopupMenu(const Value: TOnPopupMenu);
begin
  FOnPopupMenu := Value;
end;

function TMDIChildList.GetModeGnCount(psModename: string;pscurbplname:String): Integer;
//统计某个模块，开启的可加密的MDI窗体功能个数
var
  i:Integer;
begin
  Result := 0;
  for i:=0 to FList.Count-1 do begin
      if TMDIChildItem(FList[i]).sModeName=psModeName then begin
      //modified by chengjf 20120912 乡财加密不再特殊处理
//         if GetISXCZB then begin     //带来的问题是，释放了加密，但是可能不执行 closemode里的过程
//            if TMDIChildItem(FList[i]).sCurBplName=pscurbplname then begin
//               if not TMDIChildItem(FList[i]).bNotEncrypt then  //需要加密才加1  bNotEncrypt=true 是不需要加密
//                  Inc(Result);
//            end;
//         end else
            Inc(Result);
      end;
  end;
end;

function TMDIChildList.HaveMode(psModeName: String): Boolean;
var
  i:Integer;
begin
  Result := False;
  for i:=0 to FList.Count-1 do begin
      if TMDIChildItem(FList[i]).sModeName=psModeName then begin
         Result := True;
         Exit;
      end;
  end;
end;

function TMDIChildList.GetModeNameByHandle(FormHandle: HWND): string;
var
  i:Integer;
begin
  Result := '';
  for i:=0 to FList.Count-1 do begin
      if TMDIChildItem(Flist[i]).Form.Handle=FormHandle then begin
         Result := TMDIChildItem(Flist[i]).sModeName;
         exit;
      end;
  end;
end;

{ TDrawPanel }
procedure TDrawPanel.Click;
begin
  inherited;
end;

constructor TDrawPanel.Create(AOwner: TComponent);
begin
  inherited;
  Alignment := taLeftJustify;
  ShowHint := True;
  FItemList := TMDIChildList(AOwner)
end;

destructor TDrawPanel.Destroy;
begin
  inherited;
end;

procedure TDrawPanel.Paint;
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Rect: TRect;
  Flags: Longint;
  dTop, dWidth, iHeight: Integer;
begin
  Rect := GetClientRect;
  with Canvas do
  begin
    Brush.Color := Color;
    FillRect(Rect);

    dWidth := 0;
    dTop := 0;
    if Down and (FItemList.FSelectedBitmap <> nil) then
    begin
      Canvas.StretchDraw(Rect, GWinBarHotBmp);
      dTop := (Height - FItemList.FSelectedBitmap.Height) div 2;
      Canvas.Draw(dTop, dTop, FItemList.FSelectedBitmap);
      dWidth := FItemList.FSelectedBitmap.Width + dTop + 8;
    end
    else if (FItemList.FBitmap <> nil) then
    begin
      Canvas.StretchDraw(Rect, GWinBarBmp);
      dTop := (Height - FItemList.FBitmap.Height) div 2;
      Canvas.Draw(dTop, dTop, FItemList.FBitmap);
      dWidth := FItemList.FBitmap.Width + dTop + 8;
    end;

    Brush.Style := bsClear;
    Font.Assign(FItemList.Font);
    iHeight := TextHeight('Hq');
    with Rect do
    begin
      Top := (Top + Bottom - iHeight) div 2;
      Bottom := Top + iHeight;
      if dWidth = 0 then dWidth := iHeight;
      Left := Rect.Left + dWidth;
    end;
    Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[Alignment];
    Flags := DrawTextBiDiModeFlags(Flags);
    Flags := Flags or DT_END_ELLIPSIS or DT_MODIFYSTRING;
    DrawText(Handle, PChar(Caption), -1, Rect, Flags);
  end;
end;

procedure TDrawPanel.SetDown(const Value: Boolean);
begin
  FDown := Value;
  Refresh;
  UpdateOthers;
end;

procedure TDrawPanel.SetOnClick(const Value: TClickEvent);
begin
  FOnClick := Value;
end;

procedure TDrawPanel.SetShowCloseButton(const Value: Boolean);
begin
  FShowCloseButton := Value;
end;

procedure TDrawPanel.UpdateOthers;
var
  i: Integer;
begin
  if Parent = nil then
    Exit;
  if FDown then
  begin
    for i := 0 to Parent.ControlCount - 1 do
    begin
      if (Parent.Controls[i] is TDrawPanel) and (Parent.Controls[i] <> Self) then
      begin
        (Parent.Controls[i] as TDrawPanel).Down := False;
      end;
    end;
  end;
end;

procedure TDrawPanel.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  BevelInner := bvNone;
  Down := True;
  if Assigned(FOnClick) then
    FOnClick(Self, not FDown);
end;

procedure TDrawPanel.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
end;

procedure TDrawPanel.WMRButtonDown(var Message: TWMRButtonDown);
var
  Menu: TPopupMenu;
  P: TPoint;
  ShowMenu: Boolean;
begin
  FItemList.FSelectedButton := Self;
  Menu := FItemList.PopupMenu;
  ShowMenu := True;
  if Assigned(FItemList.FOnPopupMenu) then
    FItemList.FOnPopupMenu(FItemList.IndexByButton(Self), ShowMenu);
  if Assigned(Menu) and ShowMenu then
  begin
    P := ClientToScreen(Point(Message.XPos, Message.YPos));
    Menu.Popup(P.x, P.y);
  end;
end;

initialization
  GWinBarBmp := TBitmap.Create;
  GWinBarHotBmp := TBitmap.Create;

finalization
  GWinBarBmp.Free;
  GWinBarHotBmp.Free;

end.
