unit BackGroundUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, SHDocVw, ComCtrls, ExtCtrls, StdCtrls, Buttons, ImgList, Menus,
  shellAPI, ExtDlgs, FileCtrl, jpeg,Variants,Main,IdHashMessageDigest, IdHash, IdGlobal,
  DB, DBClient;



type
  TMD5 = class(TIdHashMessageDigest5);
  TFormBackGround = class(TForm)
    ImageList: TImageList;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    PanelHomePage: TPanel;
    PanelToolbar: TPanel;
    Label1: TLabel;
    SpeedButtonGo: TSpeedButton;
    SpeedButtonStop: TSpeedButton;
    SpeedButtonRefresh: TSpeedButton;
    SpeedButtonBack: TSpeedButton;
    SpeedButtonAhead: TSpeedButton;
    ComboBoxAddress: TComboBox;
    Panel1: TPanel;
    WebBrowserHomePage: TWebBrowser;
    PanelWorkFlow: TPanel;
    WebBrowser1: TWebBrowser;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    N8: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N9: TMenuItem;
    N12: TMenuItem;
    ColorDialog1: TColorDialog;
    PanelDesktop: TPanel;
    ImageDesktop: TImage;
    imgDefaultBackground: TImage;
    PanelLawRule: TPanel;
    WebBrowserLawRules: TWebBrowser;
    PanelLawToolbar: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButtonADDLaw: TSpeedButton;
    SpeedButtonchoice: TSpeedButton;
    ImageTest: TImage;
    ImageDFGround: TImage;
    TimerFlowChange: TTimer;
    lblCustomerInfo: TLabel;
    cdsTmp: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1BeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure PanelDesktopDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure PanelDesktopDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure SpeedButtonGoClick(Sender: TObject);
    procedure ComboBoxAddressKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButtonStopClick(Sender: TObject);
    procedure SpeedButtonRefreshClick(Sender: TObject);
    procedure ComboBoxAddressKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButtonAheadClick(Sender: TObject);
    procedure SpeedButtonBackClick(Sender: TObject);
    procedure WebBrowserHomePageNavigateComplete2(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure PanelDesktopResize(Sender: TObject);
    procedure imgMyWorkClick(Sender: TObject);
    procedure imgHomePageClick(Sender: TObject);
    procedure imgLawClick(Sender: TObject);
    procedure imgFlowClick(Sender: TObject);
    procedure WndProc(var Message: TMessage); override;
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure SpeedButtonADDLawClick(Sender: TObject);
    procedure SpeedButtonchoiceClick(Sender: TObject);
    procedure WebBrowserFlowBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
        {add by wangxin }
    function BeforeNavagate(Aurl:OleVariant):Boolean;
    {调用其它模块功能-流程图中使用}
    function ExecOtherProGN(AProSign,AProductGN:string):Boolean;
    procedure TimerFlowChangeTimer(Sender: TObject);
     // 参数说明：ProductExecName：产品应用程序名称,ProductSign：产品标识，ProductGN：产品功能点
    procedure ExecProduce(ProductExecName,ProductSign,ProductGN:string);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure FormResize(Sender: TObject); //调用产品功能
  private
    { Private declarations }
    FCustomerInfo:string;
    FCanDropFile: Boolean;
    FCanBringToFront: boolean;
    FHomePageOpened: boolean;
    DefaultBmp: Tbitmap;
    function GetQuickLinkerCount(AComponent: TComponent): Integer;
    procedure HandleNavigateCommand(Command: string);
    procedure WMNCHitTest(var Msg: TMessage); message WM_NCHITTEST;
    procedure SaveDesktopToFile(FileName: string);
    procedure LoadDesktopFromFile(FileName: string);
    procedure SaveImageListConfig(FileName: string; ImageList: TImageList);
    procedure LoadImageListConfig(FileName: string; ImageList: TImageList);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure CreateDocumentLink(FileName: string; x, y: Integer);
    procedure PaintBKGround;
    procedure LoadDesktopImageSettings;
    //zhengjy 20161226 MD5加密
    function StrToMD5(S: String): String;
  protected
  public
    { Public declarations }
    procedure LoadConfig(UserName: string);
    procedure SaveConfig(UserName: string);
    procedure SaveDesktopImageSettings;
    procedure ShowLawRule;
    function GetMainPage:string;
    procedure RefreshMainPage;
    // 崔立国 2010.04.20 初始化桌面皮肤样式
    procedure InitDesktopSkin;
    procedure CreateLink(AModCode, ACaption: string; ANodeLevel: Integer);
    //处理手写版的菜单显示，临时方法，后期列入产品后，必须进行调整。
    procedure DealSignCertMenu;
    //zhengjy 20161226 读CA或手写签字加密数据, 并返回显示内容信息
    procedure GetCustomerCaption;
    function ShowCustomerInfo:Boolean;//add by wangxin 显示客户信息
  end;

var
  FormBackGround: TFormBackGround;
  Iindex: integer = 99;
  
implementation

uses Registry, PLAT_Utils, Pub_Global, PLAT_LawRuleManager,
  PLAT_QuickLink, PLAT_QuickLinker, PLAT_TreeFuncNodeLink, PLAT_DocumentLink,Pub_Res,
  Pub_Message, Pub_Function,DataModuleMain;

{$R *.DFM}

var
  sCustomDesktopImageFile: string;

procedure TFormBackGround.FormCreate(Sender: TObject);
begin
  //设定为无Caption
  SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not WS_CAPTION);
  //　一些初始化代码，不应该放置在此处

  //self.PanelBackGroundTop.Height := 35;

  //TLawRuleManager.GetInstance.RefreshMenu(TUtils.GetLawRuleMenuItem,TUtils.GetProSign());
  //PanelFlow.Visible := UpperCase(GProSeries) <> 'S';

  // LoadJpgRes(imgDefaultBackground.Picture, 'DEFAULTBACKGROUND');
  //hch 2009-06-03 取消，在Main_templet中重新调用
  //WebBrowserFlow.Navigate(ExtractFilePath(ParamStr(0))+'Desktop\'+GetMainPage);
end;

procedure TFormBackGround.WMNCHitTest(var Msg: TMessage); //不能移动
begin
  inherited;
  Msg.Result := HTCLIENT;
end;

procedure TFormBackGround.FormActivate(Sender: TObject);
begin
  // if not FCanBringToFront then
  //     Self.SendToBack;
  WebBrowser1.UseRightToLeftScrollBar;
end;

procedure TFormBackGround.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WebBrowser1.Free;
  Action := caFree;
end;

procedure TFormBackGround.SaveImageListConfig(FileName: string;
  ImageList: TImageList);
var
  i: Integer;
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  bmp.Height := 32;
  bmp.Width := 32 * ImageList.Count;
  for i := 0 to Imagelist.Count - 1 do
  begin
    ImageList.Draw(bmp.Canvas, 32 * i, 0, i);
  end;
  bmp.SaveToFile(FileName);
  bmp.Free;

end;

procedure TFormBackGround.LoadImageListConfig(FileName: string;
  ImageList: TImageList);
var
  i: Integer;
  bmp: Tbitmap;
  icon: TBitmap;

begin
  if not FileExists(FileName) then
  begin
    exit;
  end;
  ImageList.Clear;

  bmp := Tbitmap.Create;
  bmp.LoadFromFile(FileName);
  icon := TBitmap.Create;
  icon.Height := 32;
  Icon.Width := 32;
  for i := 0 to bmp.Width div 32 - 1 do
  begin
    bitblt(icon.Canvas.Handle, 0, 0, 32, 32, bmp.Canvas.Handle, i * 32, 0,
      SRCCOPY);
    ImageList.Add(icon, nil);
  end;

  Icon.Free;
  bmp.Free;

end;

procedure TFormBackGround.SaveDesktopToFile(FileName: string);
var
  i: Integer;
  AQuickLinker: TQuickLinker;
  stream: TStream;
  LinkCount: Integer;
begin
  LinkCount := 0;
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (Components[i] is TQuickLinker) and ((Components[i] as
      TQuickLinker).Parent = panelDesktop) then
      Inc(LinkCount);
  end;
  Stream := TFileStream.Create(FileName, fmCreate);
  Stream.Write(LinkCount, sizeof(LinkCount));
  for i := 0 to ComponentCount - 1 do
  begin
    if (Components[i] is TQuickLinker) and ((Components[i] as
      TQuickLinker).Parent = panelDesktop) then
    begin
      AQuickLinker := Components[i] as TQuickLinker;
      AQuickLinker.SaveToStream(Stream);
    end;

  end;

  Stream.Free;
end;

procedure TFormBackGround.LoadDesktopFromFile(FileName: string);
var
  i: Integer;
  AQuickLinker: TQuickLinker;
  stream: TStream;
  LinkCount: Integer;
begin
  if not FileExists(FileName) then
    exit;
  Stream := TFileStream.Create(FileName, fmOpenRead);
  Stream.Read(LinkCount, Sizeof(LinkCount));

  try
    for i := 0 to LinkCount - 1 do
    begin
      AQuickLinker := TQuickLinker.Create(self, nil);
      AquickLinker.LoadFromStream(stream);
      AQuickLinker.SetImage(ImageList);
      //ImageList.GetBitmap (AquickLinker.ImageIndex,AquickLinker.Glyph)  ;
      AquickLinker.Parent := PanelDesktop;
    end;
    Stream.Free;
  except
    on E: Exception do
    begin
      Stream.Free;
      DeleteFile(FileName);
      for i := Self.ComponentCount - 1 downto 0 do
        if (Components[i] is TQuickLinker) and ((Components[i] as
          TQuickLinker).Parent = panelDesktop) then
        begin
          (Components[i]).Free;
        end;
      SysMessage('读取桌面配置文件失败，请关闭系统重新启动！', '提示信息', [mbOK]);
      Application.Terminate;
    end;
  end;
end;

procedure TFormBackGround.FormShow(Sender: TObject);
begin
  DragAcceptFiles(handle, True);
  PanelDesktop.Align := alClient;
  PanelDesktop.BringToFront;
  ComboBoxAddress.Visible := false;

  FCanDropFile := true;
  FCanBringToFront := false;

{//  if FileExists(GExePath + 'DeskTop\index'+GProSign+'.htm') then
    WebBrowser1.Navigate(GExePath + 'DeskTop\index'+GProSign+'.htm');

//  if FileExists(GExePath + 'DeskTop\LawRules.htm') then
//    WebBrowserLawRules.Navigate(GExePath + 'DeskTop\LawRules.htm'); }
  ResImgReplace(FormBackGround, GSkinNames.Values[FormMain.FSkin]);
  {hch 默认图片显示系统导入图片}
  imgDefaultBackground.Picture.Assign(ImageDesktop.Picture);
  LoadDesktopImageSettings;
  FormBackGround.InitDesktopSkin;
  //if (GProSign='SA') then
  //   PanelFlow.Visible := False;

  
end;

procedure TFormBackGround.PaintBKGround;
begin
end;

procedure TFormBackGround.LoadConfig(UserName: string);
var
  i: Integer;
begin
  for i := self.ComponentCount - 1 downto 0 do
  begin
    if (Components[i] is TQuickLinker) and ((Components[i] as
      TQuickLinker).Parent = panelDesktop) then
    begin
      (Components[i]).Free;

    end;
  end;

  LoadImageListConfig(ExtractFilePath(application.exename) + '\MyWorkDir\' + '_' +
    UserName + 'Images.Bmp', ImageList);
  LoadDesktopFromFile(ExtractFilePath(application.exename) + '\MyWorkDir\' + '_' +
    UserName + 'desktop.dsk');
end;

procedure TFormBackGround.WebBrowser1BeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
  szMenuCaption: string;
  i, iPos: Integer;
begin
  iPos := Pos('FC:\\', UpperCase(string(URL)));
  //  showmessage(URL);
  if iPos > 0 then
  begin
    //ShowMessage(URL);
    if Pos('.', URL) > 0 then
    begin
      HandleNavigateCommand(URL);
    end
    else
    begin
      szMenuCaption := Copy(URL, iPos + Length('FC:\\'), Length(URL) - iPos -
        Length('FC:\\') + 1);
      for i := 0 to TFormMain(Application.MainForm).MainMenu.Items.Count - 1 do
      begin
        try
          if szMenuCaption ='凭证审核' then
          begin
              szMenuCaption:='凭证处理' ;
              Iindex :=1;
          end;
          if szMenuCaption ='凭证记账' then
          begin
              szMenuCaption:='凭证处理' ;
              Iindex :=2;
          end;
          if szMenuCaption ='凭证查询' then
          begin
              szMenuCaption:='凭证处理' ;
              Iindex :=0;
          end;

//          if TFormMain_templet(Application.MainForm).MenuOnClick(TFormMain_templet(Application.MainForm).MainMenu.Items[i], szMenuCaption, '') then
          begin
  //          Cancel := True;
    //        exit;
          end;
        finally
          Iindex := 99;
        end;
      end;
    end;

    Cancel := True;
  end;
end;

function TFormBackGround.GetQuickLinkerCount(AComponent: TComponent): Integer;
var
  i: Integer;
  Comp: TComponent;
begin
  Result := 0;
  for i := 0 to ComponentCount - 1 do
  begin
    Comp := Components[i];
    if (Comp is TQuickLinker) and ((AComponent = nil) or (AComponent <> Comp)) then
      Inc(Result);
  end;
end;

procedure TFormBackGround.HandleNavigateCommand(Command: string);
var
  szSectionName: string;
  szCommandName: string;
  iPos1, iPos2: Integer;
begin
  iPos1 := Pos('\\', Command) + 2;
  if iPos1 <= 2 then
    raise Exception.Create('不认识的命令' + Command);
  iPos2 := Pos('.', Command);
  if iPos1 <= 0 then
    raise Exception.Create('不认识的命令' + Command);
  szSectionName := UPpercase(Copy(Command, iPos1, iPos2 - iPos1));
  szCommandName := Uppercase(Copy(Command, iPos2 + 1, 1000));
  if szSectionName = 'LAWRULES' then
    TLawRuleManager.GetInstance.Execute(szCommandName);
  //

end;

procedure TFormBackGround.CreateDocumentLink(FileName: string; x, y: Integer);
var
  ALink: TQuickLink;
  bmp: TBitmap;

begin
  ALink := TDocumentLink.Create(FileName);
  if ALink <> nil then
  begin
    with TQuickLinker.Create(self, ALink) do
    begin
      //if (Source as TTreeView).Selected.Count>0 then
      //    ImageIndex:=1
      //else
      //    ImageIndex:=0;
      //ImageList.GetBitmap (ImageIndex, Glyph)  ;
      //}
      Left := x - Width div 2;
      Top := y - Height div 2;
      Parent := PanelDeskTop;
    end;
  end;
end;

procedure TFormBackGround.PanelDesktopDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  ALink: TTreeFuncNodeLink;
  bmp: TBitmap;
begin
  if Source is TTreeView then
  begin
    ALink := TTreeFuncNodeLink.Create((Source as TTreeView).Selected.Text);
    if ALink <> nil then
    begin
      // Bryan 20040901 ,根据TreeNode属性查找功能
      ALink.NodeLevel := (Source as TTreeView).Selected.Level;
      // 为了处理
      if (Source as TTreeView).Selected.Parent <> nil then
        ALink.PNodeCaption := (Source as TTreeView).Selected.Parent.Text
      else
        ALink.PNodeCaption := '';

      with TQuickLinker.Create(Self, ALink) do
      begin
        if (Source as TTreeView).Selected.Count > 0 then
          ImageIndex := 1
        else
          ImageIndex := 0;
        ImageList.GetBitmap(ImageIndex, Glyph);

        if (Sender <> nil) and (Sender is TControl) then
        begin
          Left := TControl(Sender).Left + X - Width div 2;
          Top := TControl(Sender).Top + Y - Height div 2;
        end
        else
        begin
          Left := X - Width div 2;
          Top := Y - Height div 2;
        end;
        Parent := PanelDeskTop;
      end;
    end;
  end;
  if Source is TQuickLinker then
  begin
    with (Source as TQuickLinker) do
    begin
      if Locked then
        exit;
      Left := X - MouseDownX;
      Top := Y - MouseDownY;
      EndDrag(true);
    end;
  end;
end;

procedure TFormBackGround.PanelDesktopDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := True;
  if Source is TQuickLinker then
    Accept := not (Source as TQuickLinker).Locked;
end;

procedure TFormBackGround.SaveConfig(UserName: string);
var
  szPath: string;
begin
  szPath := ExtractFilePath(Application.ExeName);
  if Copy(szPath, length(szPath), 1) = '\' then
    szPath := szPath + 'MyWorkDir\'
  else
    szPath := szPath + '\MyWorkDir\';
  //以上是解决在不同系统平台下 ExtractFilePath返回的结果中有在最后有  '\' 而有的则没有
  //所以要在这进行分析处理.  anhanying   2004.04.27
  try
    if not DirectoryExists(szPath) then
      ForceDirectories(szPath);
    if not DirectoryExists(szPath) then
    begin
      //SysMessage('建立目录%1失败，请在当前应用目录下手工创建。','_JG',[mbOK],szPath);
      Exit;
    end;
  except
  end;

  SaveDesktopToFile(szPath + '_' + UserName + 'desktop.dsk');
  SaveImageListConfig(szPath + '_' + UserName + 'Images.Bmp', ImageList);
end;

procedure TFormBackGround.FormDestroy(Sender: TObject);
begin
  SaveConfig(gCZy.name);
  SaveDesktopImageSettings;
  //FormBackGround := nil;
end;

procedure TFormBackGround.N1Click(Sender: TObject);
var
  iRow, iHeight: Integer;
  LinkCount: Integer;
  i: Integer;
begin
  iHeight := panelDesktop.ClientHeight div 96;
  iRow := PanelDesktop.ClientWidth div 96;
  LinkCount := 0;
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (Components[i] is TQuickLinker) and ((Components[i] as
      TQuickLinker).Parent = panelDesktop) then
    begin
      (Components[i] as TControl).Left := LinkCount div iHeight * 96 + 32;
      (Components[i] as TControl).Top := LinkCount mod iHeight * 96 + 32;

      Inc(LinkCount);
    end;
  end;

end;

procedure TFormBackGround.N2Click(Sender: TObject);
var
  iRow, iHeight: Integer;
  LinkCount: Integer;
  i: Integer;
begin
  iHeight := panelDesktop.ClientHeight div 96;
  iRow := PanelDesktop.ClientWidth div 96;
  LinkCount := 0;
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (Components[i] is TQuickLinker) and ((Components[i] as
      TQuickLinker).Parent = panelDesktop) then
    begin
      (Components[i] as TControl).Left := LinkCount mod iRow * 96 + 32;
      (Components[i] as TControl).Top := LinkCount div iRow * 96 + 32;

      Inc(LinkCount);
    end;
  end;

end;

procedure TFormBackGround.N4Click(Sender: TObject);
var
  iRow, iHeight: Integer;
  LinkCount: Integer;
  i: Integer;
begin
  iHeight := panelDesktop.ClientHeight div 96;
  iRow := PanelDesktop.ClientWidth div 96;
  LinkCount := 0;
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (Components[i] is TQuickLinker) and ((Components[i] as
      TQuickLinker).Parent = panelDesktop) then
    begin
      (Components[i] as TControl).Left := LinkCount mod iRow * 96 + 32;
      (Components[i] as TControl).Top := PanelDesktop.ClientHeight - LinkCount
        div iRow * 96 - 32 - 96;

      Inc(LinkCount);
    end;
  end;

end;

procedure TFormBackGround.N3Click(Sender: TObject);
var
  iRow, iHeight: Integer;
  LinkCount: Integer;
  i: Integer;
begin
  iHeight := panelDesktop.ClientHeight div 96;
  iRow := PanelDesktop.ClientWidth div 96;
  LinkCount := 0;
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (Components[i] is TQuickLinker) and ((Components[i] as
      TQuickLinker).Parent = panelDesktop) then
    begin
      (Components[i] as TControl).Left := panelDesktop.ClientWidth - LinkCount
        div iHeight * 96 - 32 - 96;
      (Components[i] as TControl).Top := LinkCount mod iHeight * 96 + 32;

      Inc(LinkCount);
    end;
  end;

end;

procedure TFormBackGround.SpeedButtonGoClick(Sender: TObject);
var
  i: integer;
  bExist: boolean;
begin
  try
    if trim(ComboBoxAddress.Text) = '' then
      exit;
    bExist := False;
    for i := 0 to ComboBoxAddress.Items.Count - 1 do
    begin
      if UpperCase(ComboBoxAddress.Items[i]) = UpperCase(ComboBoxAddress.Text) then
      begin
        bExist := True;
        break;
      end;
    end;
    if not bExist then
      ComboBoxAddress.Items.Insert(0, ComboBoxAddress.Text)
    else
      ComboBoxAddress.Items.Move(ComboBoxAddress.Items.IndexOf(ComboBoxAddress.Text), 0);
    ComboBoxAddress.Text := ComboBoxAddress.Items[0];
    WebBrowserHomePage.Navigate(ComboBoxAddress.Text);
    //保存
    if not DirectoryExists(GExePath + 'DeskTop\') then
      CreateDir(GExePath + 'DeskTop\');
    ComboBoxAddress.Items.SaveToFile(GExePath + 'DeskTop\HomePage.txt');
  except
  end;
end;

procedure TFormBackGround.ComboBoxAddressKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    SpeedButtonGo.Click;
end;

procedure TFormBackGround.SpeedButtonStopClick(Sender: TObject);
begin
  try
    WebBrowserHomePage.Stop;
  except
  end;
end;

procedure TFormBackGround.SpeedButtonRefreshClick(Sender: TObject);
begin
  try
    WebBrowserHomePage.Refresh;
  except
  end;
end;

procedure TFormBackGround.ComboBoxAddressKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = 46) then
  begin
    ComboboxAddress.Items.Delete(ComboboxAddress.Items.IndexOf(ComboBoxAddress.Text));
    ComboBoxAddress.Items.Delete(ComboboxAddress.Items.IndexOf(''));
  end;
end;

procedure TFormBackGround.SpeedButtonAheadClick(Sender: TObject);
begin
  try
    WebBrowserHomePage.GoForward;
  except
  end;
end;

procedure TFormBackGround.SpeedButtonBackClick(Sender: TObject);
begin
  try
    WebBrowserHomePage.GoBack;
  except
  end;
end;

procedure TFormBackGround.WebBrowserHomePageNavigateComplete2(
  Sender: TObject; const pDisp: IDispatch; var URL: OleVariant);
begin
  ComboBoxAddress.Text := URL;
end;

procedure TFormBackGround.WMDropFiles(var Msg: TWMDropFiles);
var
  cFileName: array[0..MAX_PATH] of Char;
  I, iFileCount: Integer;
  pt: TPoint;
begin

  if not FCanDropFile then
    exit;
  DragQueryPoint(msg.Drop, pt);
  try
    FillChar(cFileName, SizeOf(cFileName), 0);
    iFileCount := DragQueryFile(Msg.Drop, 0, cFileName, MAX_PATH);
    for I := 0 to iFileCount - 1 do
    begin
      if DragQueryFile(Msg.Drop, I, cFileName, MAX_PATH) > 0 then
      begin

        CreateDocumentLink(cFileName, pt.x, pt.y);
        pt.x := pt.x + 64;
        //ShowMessage(Format('[%d] - %s', [I, cFileName]));
        Msg.Result := 0;
      end;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TFormBackGround.PanelDesktopResize(Sender: TObject);
begin
  PaintBKGround;
end;

procedure TFormBackGround.imgMyWorkClick(Sender: TObject);
begin
  {imgMyWorkHot.BringToFront;
  imgHomePage.BringToFront;
  imgLaw.BringToFront;
  imgFlow.BringToFront;

  PanelDesktop.Align := alClient;
  PanelDesktop.BringToFront;
  ComboBoxAddress.Visible := false;
  FCanDropFile := true;
  FCanBringToFront := false;}
end;

procedure TFormBackGround.imgHomePageClick(Sender: TObject);
begin
 { imgMyWork.BringToFront;
  imgHomePageHot.BringToFront;
  imgLaw.BringToFront;
  imgFlow.BringToFront;

  PanelHomePage.Align := alClient;
  PanelHomePage.BringToFront;
  ComboBoxAddress.Visible := true;
  if not FHomePageOpened then
  begin
    if FileExists(GExePath + 'DeskTop\HomePage.txt') then
    begin
      ComboBoxAddress.Items.LoadFromFile(GExePath + 'DeskTop\HomePage.txt');
      ComboBoxAddress.ItemIndex := 0;
      WebBrowserHomePage.Navigate(ComboBoxAddress.Text);
    end
    else
    begin
      WebBrowserHomePage.Navigate('http://www.ufgov.com.cn');
      ComboBoxAddress.Text := 'http://www.ufgov.com.cn';
      ComboBoxAddress.Items.Add('http://www.ufgov.com.cn');
    end;
    FHomePageOpened := true;
  end;

  FCanDropFile := false;
  FCanBringToFront := false;  }
end;

procedure TFormBackGround.imgLawClick(Sender: TObject);
begin
 { imgMyWork.BringToFront;
  imgHomePage.BringToFront;
  imgLawHot.BringToFront;
  imgFlow.BringToFront;

  try
   // if Main.Application.MainForm.MenuItemLawRules.Count = 0 then
     // TLawRuleManager.GetInstance.RefreshMenu(TUtils.GetLawRuleMenuItem(),
       // Tutils.GetProSign());
    PanelLawRule.Align := alClient;
    PanelLawRule.BringToFront;
    ComboBoxAddress.Visible := false;
    FCanDropFile := false;
    FCanBringToFront := true;
  except
    SysMessage('无法打开政策法规表，请先升级数据库。', '_JG', [mbOK]);

  end; }

end;

procedure TFormBackGround.ShowLawRule;
begin
  PanelLawRule.Align := alClient;
  PanelLawRule.BringToFront;
  ComboBoxAddress.Visible := false;
  FCanDropFile := false;
  FCanBringToFront := false;
  Application.ProcessMessages;
  self.BringToFront;
  Application.ProcessMessages;

end;

procedure TFormBackGround.imgFlowClick(Sender: TObject);
var
  document,ProductObj:OleVariant;
begin
 { imgMyWork.BringToFront;
  imgHomePage.BringToFront;
  imgLaw.BringToFront;
  imgFlowHot.BringToFront;

  WebBrowserFlow.BringToFront;
  document := WebBrowserFlow.Document;

  if not VarIsEmpty(document) then
  begin
    ProductObj := document.getElementById(GszVersion);
    if VarIsEmpty(ProductObj) then
      ProductObj := document.getElementById(GProSign);
    if not VarIsEmpty(ProductObj) then
      ProductObj.click;
  end;              }
  {add by wangxin end}
end;

procedure TFormBackGround.WndProc(var Message: TMessage);
begin
  if (message.msg = WM_SYSCOMMAND) and (message.WParam = SC_CLOSE) then
    Exit;
  inherited;
end;

procedure TFormBackGround.N7Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  begin
    if FileExists(OpenPictureDialog1.Files[0]) then
    begin
      sCustomDesktopImageFile := OpenPictureDialog1.Files[0];
      try
        ImageTest.Picture.LoadFromFile(OpenPictureDialog1.Files[0]);
        ImageTest.Picture.LoadFromFile('');
        ImageDesktop.Picture.LoadFromFile(OpenPictureDialog1.Files[0]);
      except
        SysMessage('无法正常加载图片"' + OpenPictureDialog1.Files[0] +
          '"，请选择其他图片文件。', '提示信息', [mbOK]);
        Exit;
      end;
      N6.Checked := False;
      N8.Enabled := True;
    end
    else
    begin
      SysMessage('没有找到图片文件"' + OpenPictureDialog1.Files[0] +
        '"，背景图将自动设置为默认图片。', '提示信息', [mbOK]);
      N6Click(N6);
    end;
  end;
end;

procedure TFormBackGround.N6Click(Sender: TObject);
begin
  N6.Checked := True;
  ImageDesktop.Picture.Assign(imgDefaultBackground.Picture);
  ImageDesktop.Stretch := True;
  N11.Checked := True;
  N8.Enabled := False;
  PanelDesktop.Color := clWhite;
  
end;

procedure TFormBackGround.N10Click(Sender: TObject);
begin
  if not N6.Checked then
  begin
    N10.Checked := True;
    ImageDesktop.Stretch := False;
  end;
end;

procedure TFormBackGround.N11Click(Sender: TObject);
begin
  if not N6.Checked then
  begin
    N11.Checked := True;
    ImageDesktop.Stretch := True;
  end;
end;

procedure TFormBackGround.N12Click(Sender: TObject);
begin
  ColorDialog1.Color := PanelDesktop.Color;
  if ColorDialog1.Execute then
    PanelDesktop.Color := ColorDialog1.Color;
end;

procedure TFormBackGround.LoadDesktopImageSettings;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    if Reg.OpenKey('\Software\UFGOV\'+GsProductID+'\Settings', True) then
    begin
      if Reg.ValueExists('桌面背景图') then
        sCustomDesktopImageFile := Reg.ReadString('桌面背景图')
      else
        sCustomDesktopImageFile := '';

      if (Length(sCustomDesktopImageFile) <> 0) and
        FileExists(sCustomDesktopImageFile) then
      begin
        ImageDesktop.Picture.LoadFromFile(sCustomDesktopImageFile);
        N6.Checked := False;
        N8.Enabled := True;

        N10.Checked := Reg.ValueExists('图片居中') and Reg.ReadBool('图片居中');
        N11.Checked := not N10.Checked;
        ImageDesktop.Stretch := not N10.Checked;

        if Reg.ValueExists('桌面背景颜色') then
          PanelDesktop.Color := Reg.ReadInteger('桌面背景颜色');
      end
      else
      begin
        N6Click(N6);
      end;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TFormBackGround.SaveDesktopImageSettings;
var
  Reg: TRegistry;
  sImageFile: string;
begin
  Reg := TRegistry.Create;
  try
    if Reg.OpenKey('\Software\UFGOV\'+GsProductID+'\Settings', True) then
    begin
      if N6.Checked then
      begin
        Reg.WriteString('桌面背景图', '');
      end
      else
      begin
        Reg.WriteString('桌面背景图', sCustomDesktopImageFile);
        Reg.WriteBool('图片居中', N10.Checked);

        Reg.WriteInteger('桌面背景颜色', PanelDesktop.Color);
      end;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TFormBackGround.Image1Click(Sender: TObject);
begin
//  main.Application.MainForm.ActLeftClose.Execute;
end;

procedure TFormBackGround.SpeedButtonADDLawClick(Sender: TObject);
begin
  HandleNavigateCommand('fc:\\LawRules.NewRule');
end;

procedure TFormBackGround.SpeedButtonchoiceClick(Sender: TObject);
begin
  HandleNavigateCommand('fc:\\LawRules.Select');
end;

procedure TFormBackGround.WebBrowserFlowBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
begin
  Cancel := BeforeNavagate(URL);
end;

function TFormBackGround.BeforeNavagate(Aurl: OleVariant): Boolean;
var
  szMenuCaption,szProSign,szurl :string;
  i, iPos: Integer;
begin
  Result := False;
  szurl := UpperCase(string(Aurl));
  iPos := Pos('?',szurl);
  szProSign := '';
  szProSign := Copy(szurl,iPos+1,Length(szurl)-iPos+1);
  szurl := Copy(szurl,1,iPos-1);
  iPos := Pos('FC:\\', szurl);
  if iPos > 0 then
  begin
    if Pos('.', szurl) > 0 then
    begin
      HandleNavigateCommand(szurl);
    end
    else
    begin
      szMenuCaption := Copy(Aurl, iPos + Length('FC:\\'), Length(szurl) - iPos -
        Length('FC:\\') + 1);
      if (szProSign = '') or (szProSign = UpperCase(GProSign))
        or (szProSign = GetOldVersion(GszVersion))
        or (szProSign = UpperCase(GszVersion))
         then//自身功能
      begin
        for i := 0 to TFormMain(Application.MainForm).MainMenu.Items.Count - 1 do
        begin
          if TFormMain(Application.MainForm).MenuOnClick(TFormMain(Application.MainForm).MainMenu.Items[i], szMenuCaption, '')
            then
          begin
            Result := True;
            exit;
          end;
        end;
      end
      else begin //外部模块功能
        ExecOtherProGN(szProSign,szMenuCaption);
      end;
    end;

    Result := True;
  end;
end;

function TFormBackGround.ExecOtherProGN(AProSign,
  AProductGN: string): Boolean;
var
  szProductExecName:string;
begin
  Result := False;
  if AProSign='GL' then
  begin
    if (GProSeries='E') then
        szProductExecName := 'R9i_GAL.EXE'
    else
        szProductExecName := 'R9i_GL.EXE';
  end
  else if AProSign='FA' then
  begin
    if GProSeries = 'C' then
      szProductExecName := 'R9i_FA.EXE'
    else
      szProductExecName := 'R9i_FAQC.EXE'
  end
  else if AProSign='GAL' then
    szProductExecName := 'R9i_GAL.EXE'
  else if AProSign='GBG' then
    szProductExecName := 'R9i_GBG.EXE'
  else if AProSign='CM' then
    szProductExecName := 'R9i_CM.EXE'
  else if AProSign='BM' then
    szProductExecName := 'R9i_BM.EXE'
  else if AProSign='BG' then
    szProductExecName := 'R9i_BG.EXE'
  else if AProSign='PAAC' then
    szProductExecName := 'R9i_PAAC.EXE'
  else if AProSign='PA' then
  begin
    if ((GProSeries ='E') or (GProSeries ='T')) then
      szProductExecName := 'R9i_PAAC.EXE'
    else
      szProductExecName := 'R9i_PA.EXE';
  end  
  else if AProSign='AQR' then
    szProductExecName := 'R9i_AQR.EXE'
  else if AProSign='GIM' then
    szProductExecName := 'R9i_GIM.EXE'
  else if AProSign='ADM' then
    szProductExecName := 'R9i_ADM.EXE'
  else if AProSign='FBS' then
    szProductExecName := 'R9i_FBS.EXE'
  else if AProSign='FBI' then
    szProductExecName := 'R9i_FBI.EXE'

  else if AProSign='ECS' then
    szProductExecName := 'R9i_ECS.EXE'
  else if AProSign='CHQ' then
    szProductExecName := 'R9i_CHQ.EXE'
  else if AProSign='YBC' then
    szProductExecName := 'R9i_YBC.EXE'
  else if AProSign='FCP' then
    szProductExecName := 'R9i_FCP.EXE'
  else if AProSign='CCD' then
    szProductExecName := 'R9i_CCD.EXE'
  else if AProSign='NTCZ' then
  begin
    AProSign:='NTMF';
    szProductExecName := 'R9i_NTMF.EXE';
  end
  else if AProSign='NTDW' then
  begin
    AProSign:='NTMD';
    szProductExecName := 'R9i_NTDW.EXE';
  end
  else if AProSign='NTDS' then
  begin
    AProSign:='NTMJ';
    szProductExecName := 'R9i_NTDS.EXE';
  end
  else if AProSign='BR' then
    szProductExecName := 'R9i_BR.EXE'
  else if AProSign='DBAM' then
    szProductExecName := 'R9i_DBAM.EXE'
  else if AProSign='DBGFS' then
    szProductExecName := 'R9i_DBGFS.EXE'
  else if AProSign='DBGDS' then
    szProductExecName := 'R9i_DBGDS.EXE';
  if GpsSeries = psR9 then
    szProductExecName := StringReplace(szProductExecName,'R9i', 'R9', []);
  if AProductGN<>'' then
  begin
    // 崔立国 2010.05.31 设置当前路径，否则IE中启动会报错“找不到文件”。
    SetCurrentDir(ExtractFilePath(Application.ExeName));
    szProductExecName := ExtractFilePath(Application.ExeName) +
                         ExtractFileName(szProductExecName);
    ExecProduce(szProductExecName,AProSign,AProductGN);
  end;
  Result := True;
end;

procedure TFormBackGround.TimerFlowChangeTimer(Sender: TObject);
begin
  imgFlowClick(nil);
  TimerFlowChange.Enabled := False;
end;

procedure TFormBackGround.ExecProduce(ProductExecName, ProductSign,
  ProductGN: string);
var
    StartPath:String;
    i:integer;
    szFileName,szTemp,sVersion:string;
    aryCommand: array[0..1024] of Char;

    function fAppAlreadyExists(SzVersion:string): boolean;
      var
          hMutex : HWND;
      begin
          hMutex := OpenMutex(MUTEX_ALL_ACCESS	, False,PChar(string(SzVersion)));//GProSign

          if hMutex > 0 then
          begin
              result:=true;
          end else
          begin
              result:=false;
          end;
          //ReleaseMutex(hMutex);
          CloseHandle(hMutex);
      end;

begin
    if (ProductSign=GProSign) or (ProductSign=GszVersion) then //如果调当前前台的功能点
    begin
        for i := 0 to TFormMain(Application.MainForm).MainMenu.Items.Count - 1 do
        begin
            if TFormMain(Application.MainForm).MenuOnClick(TFormMain(Application.MainForm).MainMenu.Items[i], ProductGN, '') then
               exit;
        end;
    end
    else//调其他产品的功能点
    begin
        if ProductSign='GL' then
        begin
            szTemp := '账务处理系统';
            if GProSeries = 'G' then
                sVersion := 'GLNP'
            else if GProSeries = 'C' then
                sVersion := 'GL'
            else if GProSeries = 'S' then
                sVersion := 'GLNPS';
        end
        else if ProductSign='FA' then
        begin
            if ((GszVersion = GszAnyi_FAQC) or (GszVersion = GszAnyi_FAQCG)) or (GszVersion='FAQCS') then szTemp:='资产管理系统' else
            szTemp := '固定资产管理系统';
            if GProSeries = 'G' then
                sVersion := 'FA'
            else if GProSeries = 'C' then
                sVersion := 'FA'
            else if GProSeries = 'S' then
                if (GszVersion='FAS') then
                sVersion := 'FAS' else
                if (GszVersion='FAQCS') then
                sVersion:='FAQCS';
        end
        else if ProductSign='GBG' then
        begin
            szTemp := '全面预算管理系统';
            if GProSeries = 'G' then
                sVersion := 'GBG';
        end
        else if ProductSign='CM' then
        begin
            szTemp := '出纳管理系统';
            if GProSeries = 'G' then
                sVersion := 'CM'
            else if GProSeries = 'C' then
                sVersion := 'CM'
            else if GProSeries = 'S' then
                sVersion := 'CMS';
        end
        else if ProductSign='BM' then
        begin
            szTemp := '资金管理系统';
            sVersion := 'BM';
        end
        else if ProductSign='BG' then
        begin
            szTemp := '财务预算与分析系统';
            if GProSeries = 'G' then
                sVersion := 'BG'
            else if GProSeries = 'C' then
                sVersion := 'BG'
            else if GProSeries = 'S' then
                sVersion := 'BGS';
        end
        else if ProductSign='PA' then
        begin
            szTemp := '工资管理系统';
            if GProSeries = 'G' then
                sVersion := 'PA'
            else if GProSeries = 'C' then
                sVersion := 'PA'
            else if GProSeries = 'S' then
                sVersion := 'PAS';
        end
        else if ProductSign='PAAC' then
        begin
            szTemp := '工资统发管理系统';
            if GProSeries = 'E' then
                sVersion := 'PAAA';
        end
        else if ProductSign='AQR' then
        begin
            szTemp := '电子报表系统';
            if GProSeries = 'G' then
                sVersion := 'AQRNP'
            else if GProSeries = 'C' then
                sVersion := 'AQR'
            else if GProSeries = 'S' then
                sVersion := 'AQRNPS';
        end
        //mpf 20070522 add
        else if ProductSign='FBS' then
        begin
            szTemp := '拨款管理系统';
            if GProSeries = 'G' then
                sVersion := 'FBSNP'
            else if GProSeries = 'C' then
                sVersion := 'FBS'
            else if GProSeries = 'S' then
                sVersion := 'FBSNPS';
        end
        else if ProductSign='GIM' then
        begin
            szTemp := '物资管理系统';
            if GProSeries = 'G' then
                sVersion := 'GIMNP'
            else if GProSeries = 'C' then
                sVersion := 'GIM'
            else if GProSeries = 'S' then
                sVersion := 'GIMNPS';
        end
        else if ProductSign='ADM' then
        begin
            szTemp := '会计档案系统';
            if GProSeries = 'G' then
                sVersion := 'ADMNP'
            else if GProSeries = 'C' then
                sVersion := 'ADM'
            else if GProSeries = 'S' then
                sVersion := 'ADMNPS';
        end
        else if ProductSign='FBI' then
        begin
            szTemp := '指标管理系统';
            if GProSeries = 'G' then
                sVersion := 'FBINP'
            else if GProSeries = 'C' then
                sVersion := 'FBI'
            else if GProSeries = 'S' then
                sVersion := 'FBINPS';
        end;
        if fAppAlreadyExists(sVersion) then     //如果已经打开
        begin
            SysMessage(szTemp+'已经打开，请在该系统中去进行功能操作!', '',[mbOK]);
            Exit;
        end;
        if ProductSign='AQR' then //电子报表只调用应用程序
        begin
            szFilename := ProductExecName;
        end
        else
        begin
            //先启动产品，再调功能点
           { szFilename := ProductExecName+
                        ' -I ' +GszZth+//+ UserLoginInfo.AccountID +
                        ' -U ' +GCzy.name+// UserLoginInfo.UserName +
                        ' -P ' +GCzy.Password+// UserLoginInfo.UserPassword +
                        ' -N ' +GszZTMC+// UserLoginInfo.AccountName +
                        ' -D ' +GszYWRQ+//+ UserLoginInfo.CurrentDate +
                        ' -S ' +GszServerComputer+
                        ' -T ' +GszServerPort+
                        ' -G ' +ProductGN;  }
          //启动其他产品模块
          StartPath:='';

          StartPath := StartPath + ' "'+GCzy.name+'"';
          StartPath := StartPath + ' "'+TString.EncryptSTR(GCzy.Password)+'"';
          StartPath := StartPath + ' "'+GszYWRQ+'"';
          if GszZth<>'' then
            StartPath := StartPath + ' "'+GszZth+'"'
          else
            StartPath := StartPath + ' " "';
          if GszZTMC<>'' then
            StartPath := StartPath + ' "'+GszZTMC+'"'
          else
            StartPath := StartPath + ' " "';
          if GszGSDM<>'' then
            StartPath := StartPath + ' "'+GszGSDM+'"'
          else
            StartPath := StartPath + ' " "';
          if GszHSDWMC<>'' then
            StartPath := StartPath + ' "'+GszHSDWMC+'"'
          else
            StartPath := StartPath + ' " "';
          StartPath := StartPath + ' "'+GszServerComputer+'"';
          StartPath := StartPath + ' "'+GszServerPort+'"';
          StartPath := StartPath + ' "0"';
          StartPath := StartPath + ' "'+GszConType+'"';

          if GDBType= MSSQL then
            StartPath := StartPath + ' "MSSQL"'
          else
            StartPath := StartPath + ' "ORACLE"';
          szFilename := ProductExecName + StartPath;
         // WinExec(Pchar(StartPath), SW_SHOWNORMAL);
        end;
        if ProductExecName <> '' then
        begin
            if not FileExists(ProductExecName) then
            begin
              SysMessage('调用的执行程序'+ProductExecName+'不存在，请下载或安装。','', [mbOK]);
              Exit;
            end;

            StrPCopy(aryCommand, szFilename);
            case WinExec(aryCommand,SW_SHOWNORMAL) of
            0:
                begin
                    SysMessage('系统资源不足,请关闭一些程序!','', [mbOK]);
                    Exit;
                end;
            ERROR_BAD_FORMAT:
                begin
                    SysMessage(ProductExecName+':非法可执行文件!', '',[mbOK]);
                    Exit;
                end;
            ERROR_FILE_NOT_FOUND:
                begin
                    SysMessage(ProductExecName+':找不到可执行文件!','', [mbOK]);
                    Exit;
                end;
            ERROR_PATH_NOT_FOUND:
                begin
                    SysMessage(ProductExecName+':找不到可执行文件路径!', '',[mbOK]);
                    Exit;
                end;
            end;
            
         end;
         
    end;
end;

function TFormBackGround.GetMainPage: string;
const
  //2010.6.7 hy 维护单同步//2010.5.6 hy 维护单2010042711317，集中查询显示的流程图不是是财政，是财务
  CW = 'GL;GLNP;GBG;IGBG;AQR;FA;BM;FAQC;CM;PA;CNT;ADM;IDA;';
  CZ = 'ECS;CHQ;GAL;PAAC;FBI;FBS;';
begin
  if pos(GetOldVersion(GszVersion)+';', cw) >0 then
  begin
    if GDbType = Oracle then
      Result := 'mainCWOra.html'
    else
      Result := 'mainCW.html';
  end
  else
    Result := 'mainCZ.html';

  if (GszVersion = GszAnyi_BM) or (GszVersion = GszAnyi_BMG) then
  begin
      if pos('财政',GProSeriesName)>0 then
          Result := 'mainCZ.html'
      else
          Result := 'mainCW.html';
  end;
end;

procedure TFormBackGround.RefreshMainPage;
var
  szMainPage:string;
begin
  //2010.6.7 hy 维护单同步//2010.5.6 hy 维护单2010042711317，集中查询显示的流程图不是是财政，是财务
  //szMainPage:= GetMainPage;
  {if szMainPage<>'' then
    WebBrowserFlow.Navigate(ExtractFilePath(ParamStr(0))+'Desktop\'+GetMainPage);  }
end;

procedure TFormBackGround.SpeedButton4Click(Sender: TObject);
begin
  //WebBrowserLawRules.GoBack;
end;

procedure TFormBackGround.SpeedButton5Click(Sender: TObject);
begin
  //WebBrowserLawRules.GoForward;
end;

procedure TFormBackGround.InitDesktopSkin;
begin

 { if (GImageMyWork.Height > 10) then
  begin
    PanelToolbar.Color := GFormBackgroundColor;
    PanelLawToolbar.Color := GFormBackgroundColor;

    PanelBackGroundTop.Height := GImageMyWork.Height;
    imgMyWork.Picture.Bitmap.Assign(GImageMyWork);
    imgMyWorkHot.Picture.Bitmap.Assign(GImageMyWorkHot);
    imgHomePageHot.Picture.Bitmap.Assign(GImageHomePageHot);
    imgHomePage.Picture.Bitmap.Assign(GImageHomePage);
    imgLawHot.Picture.Bitmap.Assign(GImageLawHot);
    imgLaw.Picture.Bitmap.Assign(GImageLaw);
    imgFlowHot.Picture.Bitmap.Assign(GImageFlowHot);
    imgFlow.Picture.Bitmap.Assign(GImageFlow);
    imgLeftMargin.Picture.Bitmap.Assign(GImageLeftMargin);
    imgRightMargin.Picture.Bitmap.Assign(GImageRightMargin);
  end;  }
  imgDefaultBackground.Picture.Assign(ImageDesktop.Picture);
end;

procedure TFormBackGround.CreateLink(AModCode, ACaption: string; ANodeLevel: Integer);
var
  ALink: TTreeFuncNodeLink;
  bmp: TBitmap;
begin
  ALink := TTreeFuncNodeLink.Create(ACaption);
  ALink.PNodeCaption := ACaption;
  ALink.PModCode := AModCode;
  ALink.NodeLevel := ANodeLevel;
  with TQuickLinker.Create(Self, ALink) do
  begin
    ImageIndex := 0;
    ImageList.GetBitmap(ImageIndex, Glyph);
    Left := 10;
    Top := 15;
    Parent := PanelDeskTop;
  end;
end;

procedure TFormBackGround.GetCustomerCaption;
const md5='ufgov';
var
  sSQL,sCheckStr:string;
begin
  FCustomerInfo:='';
  sSQL := 'select groupxh,xh,gsdm,kjnd,csdm,csmc,bz from pub_ztcs where csdm=''UKey_Ctrl''';
  POpenSql(cdsTmp, sSQL);
  with cdsTmp do
  begin
    if RecordCount > 0 then
    begin
      sCheckStr := FieldByName('bz').AsString;
      if StrToMD5(FieldByName('csmc').AsString+md5)= sCheckStr then
        FCustomerInfo:= FieldByName('csmc').AsString;
    end;
  end;
end;

function TFormBackGround.StrToMD5(S: String): String;
var
  Md5Encode: TMD5;
begin
  Md5Encode:= TMD5.Create;
  result:= Md5Encode.AsHex(Md5Encode.HashValue(S));
  Md5Encode.Free;
end;

function TFormBackGround.ShowCustomerInfo:Boolean;
var
  lst:TStringList;
begin
  //if not GCzy.bCA then Exit;
  if Trim(FCustomerInfo)='' then
  begin
    Result := False;
    Exit;
  end;
  Result := True;
  lblCustomerInfo.Caption := StringReplace(FCustomerInfo,'#13',#13#10,[rfReplaceAll]);
  lblCustomerInfo.Visible := True;
  lblCustomerInfo.Left := Self.Width - lblCustomerInfo.Width - 10;
  lblCustomerInfo.Top := Self.Height - lblCustomerInfo.Height-10;
end;

procedure TFormBackGround.FormResize(Sender: TObject);
begin
  ShowCustomerInfo;//add by wangxin 2014-12-05 显示客户信息
end;

procedure TFormBackGround.DealSignCertMenu;
var
  sInsSQL,sDelSQL:string;
begin
  sInsSQL := 'insert into GL_GNFL (MODCODE,MODNAME,MENUCODE,MENUNAME,MENUShortCut,GNFLDM,GNFLMC,GNFLEXEC,GNSCRIPTS,CPBBDM,VERCODE) values (''BAS'',''基础数据管理'',''0163'',''手写签字设置'','''',''0163'',''手写签字设置'', ''BAS.bpl'', '''', '''', '',XZ_G,XZ_C,JY_G,'');'
            +'insert into GL_GNFL (MODCODE,MODNAME,MENUCODE,MENUNAME,MENUShortCut,GNFLDM,GNFLMC,GNFLEXEC,GNSCRIPTS,CPBBDM,VERCODE) values (''BAS'',''基础数据管理'',''016301'',''手写签字设备设置'','''',''016301'',''手写签字设备设置'', ''BAS.bpl'', '''', '''', '',XZ_G,XZ_C,JY_G,'');'
            +'insert into GL_GNFL (MODCODE,MODNAME,MENUCODE,MENUNAME,MENUShortCut,GNFLDM,GNFLMC,GNFLEXEC,GNSCRIPTS,CPBBDM,VERCODE) values (''BAS'',''基础数据管理'',''016302'',''手写签字环节设置'','''',''016302'',''手写签字环节设置'', ''BAS.bpl'', '''', '''', '',XZ_G,XZ_C,JY_G,'');';
  sDelSQL := 'delete from GL_GNFL where gnfldm like ''0163%''';
  try
    if trim(FCustomerInfo)='' then PExecSQL(sDelSQL)
    else begin
      POpenSql(cdsTmp,'select count(*) Res from GL_GNFL where gnfldm like ''0163%''');
      if cdsTmp.Fields[0].AsInteger=0 then
        PExecSQL(sInsSQL);
    end;
  except
  end;

end;

end.
