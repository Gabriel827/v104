unit Main;
(*  菜单创建路径：LZN总结 2012.03.09  label052301test

 1.Login单元中登录之后
    if FormMain.AfterLoginInitData() then
    AfterLoginInitData：主要是从数据库，读取权限数据，及执行公共变量初始化函数InitPubSYS
    begin
       BlLoginOk := true;
       ModalResult := mrOK;
       PostMessage(FormMain.Handle, UM_AFTERLOGIN, 0, 0);   //发送消息，执行 AfterLoginInitMenu
    end;

 2.AfterLoginInitMenu，是创建菜单树，浮动菜单，初始化引导，创建TPublicModSYS对象，重新登录备份系统变量，处理待办事宜的
   1) InitFuncTree  里执行InitModTreeNode
      a. InitModTreeNode    创建前台模块菜单根节点
         从gl_gnfl读菜单，执行 CreateMenuTree 创建TreeViewFunc 数
          设置演示版菜单

   2) FMenuBox.LoadMenuItem(NGNFL);             加载到浮动菜单盒
      FDailyWorkMenu.LoadMenuItem(mDailyWork);  加载到待办事宜菜单盒
*)

interface

uses
  Windows, Messages, CSConnect, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, RxCalc, ComCtrls, ImgList, ExtCtrls, Buttons, db,
  RXSplit, StdCtrls, dbclient, jpeg, XPMenu, WindowsList, contnrs, IniFiles,
  Registry, ToolWin, MenuBox, RXCtrls, Gradpan, CMidasCon, IBaseInvoke, IExternalFun,
  UIR9_IMPL, Pub_Global, DataModuleMain, Gauges, AnyiClient, ActiveX;

const
  UM_AFTERLOGIN = WM_USER + 5101;
  UM_SWITCHGZLB = WM_USER + 5105;

type
  TWinBtnState = (wbsNone, wbsMinDown, wbsMaxDown, wbsCloseDown, wbsMinMove, wbsMaxMove, wbsCloseMove);

  //=====菜单树数据结构
  PTreeRec = ^TTreeRec;
  TTreeRec = record
    sModCode: string; //模块标识
    sMenuCode: string; //菜单编码
    sGNFLDM: string; //功能代码
    sGnflMc: string; //功能名称
    sGnflExec: string; //包或动态库文件
    sShortCut: string; //快捷键
    GszVersion: string; //加密标识
    bDemo: Boolean;
    bVisible: Boolean;
    sRpt: string;
    sGnScripts: string;
    bSubMenuCreated: Boolean; // 崔立国 2011.08.23 前台模块菜单首次创建时不创建下属功能菜单，此属性值为False。第一次访问该模块时再创建下属功能菜单，此属性值变为True。
  end;

  TDLLGNRec = record //调用动态库时需要交互的信息
    sModeName: string;
    sGnflMc: string;
    bNewMode: Boolean; //是否创建的新模块
    iFunIndex: Integer; //对应的菜单标识
    bClickTask: Boolean; //是否点击的任务栏    //DLLHandle:HWND;
  end;

type
  TFormMain = class(TForm)
    ActionListMM: TActionList;
    ActAbout: TAction;
    ActHelp: TAction;
    ActExit: TAction;
    ActCalculator: TAction;
    ActTile: TAction;
    ActCascade: TAction;
    ActHelpIndex: TAction;
    ActLogin: TAction;
    RxCalculatorMain: TRxCalculator;
    StatusBarMain: TStatusBar;
    ImageListFolderBlue: TImageList;
    ImageListFolderRed: TImageList;
    ActLeftClose: TAction;
    PopupMenuFunc: TPopupMenu;
    ActDelMyFunc: TAction;
    ActAddMyFunc: TAction;
    ActEditOtherPro: TAction;
    ActEnableClick: TAction;
    MAddMyFunc: TMenuItem;
    MEditOtherPro: TMenuItem;
    MEnableClick: TMenuItem;
    MN91: TMenuItem;
    MN92: TMenuItem;
    PanelLeftMain: TPanel;
    PanelLeftBox: TPanel;
    PanelLeftTitle: TPanel;
    ImageLeftTitle: TImage;
    Label1: TLabel;
    SplitterLeft: TRxSplitter;
    Label2: TLabel;
    PopupMenuWinList: TPopupMenu;
    NClose: TMenuItem;
    NMax: TMenuItem;
    NMin: TMenuItem;
    TimerDemo: TTimer;
    PanelNavBar: TPanel;
    PanelLeftOpen: TPanel;
    imgOpenLeft: TImage;
    RxLabelLeftOpen: TRxLabel;
    PanelLeftShow: TGradPan;
    RxLabelLeftShow: TRxLabel;
    ActLog: TAction;
    ActHRSynInit: TAction;
    XPMenu1: TXPMenu;
    pnlLeftAll: TPanel;
    ImageLeftFunc: TImage;
    Label4: TLabel;
    imgLeftAllClose: TImage;
    RxLabelLeftAllClose: TRxLabel;
    pnlLeftSel: TPanel;
    ImageLeftMyFunc: TImage;
    Label3: TLabel;
    imgLeftMyClose: TImage;
    RxLabelLeftMyClose: TRxLabel;
    PanelMyFunc: TPanel;
    TreeViewMyFunc: TTreeView;
    ImageListLeftRight: TImageList;
    ImageSpeedButton: TImage;
    ImageSpeedBar: TImage;             
    ImageTHGridHeader: TImage;
    ImageLeftBar: TImage;
    ImageFuncBar: TImage;
    ImageLeft: TImage;
    ImageRight: TImage;
    ImageUp: TImage;
    ImageDown: TImage;
    ImageWinBarHot: TImage;
    ImageWinBar: TImage;
    ImageNoExists: TImage;
    PanelLeftLine: TPanel;
    PanelBottom: TPanel;
    ToolBarMainMenu: TToolBar;
    ImageWinCaption: TImage;
    ActCloseChild: TAction;
    PopupMenuMyFunc: TPopupMenu;
    MDelMyFunc: TMenuItem;
    PanelTopMain: TPanel;
    PanelToolBar: TPanel;
    Image1: TImage;
    Image2: TImage;
    MainMenu: TMainMenu;
    SysMenu: TMenuItem;
    MIChangeUnit: TMenuItem;
    MRelogin: TMenuItem;
    MOpRecord: TMenuItem;
    MChangePassword: TMenuItem;
    MChangeAnyiServerAddress: TMenuItem;
    WinMenu: TMenuItem;
    MSkinName: TMenuItem;
    NWindow1: TMenuItem;
    MFuncTree: TMenuItem;
    MPp: TMenuItem;
    MCd: TMenuItem;
    MCloseTopChild: TMenuItem;
    MCloseAllChild: TMenuItem;
    MPreViouschild: TMenuItem;
    MNextChild: TMenuItem;
    MMyDesktop: TMenuItem;
    HelpMenu: TMenuItem;
    MHelp: TMenuItem;
    MHelpIndex: TMenuItem;
    NLlawrule: TMenuItem;
    MAbout: TMenuItem;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    NGNFL: TMenuItem;
    Pgb: TGauge;
    N1: TMenuItem;
    N2: TMenuItem;
    MSkin: TMenuItem;
    imgLeftClose: TImage;
    RxLabelLeftClose: TRxLabel;
    N3: TMenuItem;
    pmDailyWork: TPopupMenu;
    MDBSY: TMenuItem;
    N4: TMenuItem;
    mDailyWork: TMenuItem;
    CdsGL_GN: TClientDataSet;
    CdsPower: TClientDataSet;
    TimerDBSY: TTimer;
    TimerCA: TTimer;
    Panel_StatusBarMain: TPanel;
    Panel1: TPanel;
    SpeedButton_xzdw: TSpeedButton;
    N5: TMenuItem;
    N6: TMenuItem;
    MCalculator: TMenuItem;
    NFDMenu: TMenuItem;
    N7: TMenuItem;
    mniBinaryGet: TMenuItem;
    mniUserState: TMenuItem;
    tmrLockForm: TTimer;
    ImageListDWZT: TImageList;
    ImageListBtn: TImageList;
    PanelBG: TPanel;
    PanelFunc: TPanel;
    TreeViewFunc: TTreeView;
    pnlAccInfo: TPanel;
    imgAccInfo: TImage;
    rxlblAccount: TRxLabel;
    lblAccInfo: TLabel;
    Image7: TImage;
    Panelgndh: TPanel;
    imgFunc: TImage;
    rxlblFunc: TRxLabel;
    Label5: TLabel;
    Image6: TImage;
    pnlAccInfoSelect: TPanel;
    tvAccInfo: TTreeView;
    Panel8: TPanel;
    lblYWRQ: TLabel;
    DateTimePickerBusinessDate: TDateTimePicker;
    tmrLockFormMin: TTimer;
    NDWZT: TMenuItem;
    LabelFind: TLabel;
    EditInput: TEdit;
    btnYwrq: TSpeedButton;
    btnDWZT: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure ActionListMMExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure ActAboutExecute(Sender: TObject);
    procedure ActHelpExecute(Sender: TObject);
    procedure ActHelpIndexExecute(Sender: TObject);
    procedure RxCalculatorMainCalcKey(Sender: TObject; var Key: Char);
    procedure ActCalculatorExecute(Sender: TObject);
    procedure ActTileExecute(Sender: TObject);
    procedure ActExitExecute(Sender: TObject);
    procedure ActCascadeExecute(Sender: TObject);
    procedure ActLoginExecute(Sender: TObject);
    procedure ActLeftCloseExecute(Sender: TObject);
    procedure TreeViewFuncDblClick(Sender: TObject);
    procedure MPreViouschildClick(Sender: TObject);
    procedure MNextChildClick(Sender: TObject);
    procedure MCloseAllChildClick(Sender: TObject);
    procedure TreeViewFuncCollapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeViewFuncExpanded(Sender: TObject; Node: TTreeNode);
    procedure ActEnableClickExecute(Sender: TObject);
    procedure ActCloseChildExecute(Sender: TObject);
    procedure TreeViewFuncClick(Sender: TObject);
    procedure TreeViewFuncDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure TreeViewFuncMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeViewFuncChange(Sender: TObject; Node: TTreeNode);
    procedure ActDelMyFuncExecute(Sender: TObject);
    procedure ActAddMyFuncExecute(Sender: TObject);
    procedure MMyDesktopClick(Sender: TObject);
    procedure NCloseClick(Sender: TObject);
    procedure NewMenuItemClick(Sender: TObject);
    procedure TimerDemoTimer(Sender: TObject);
    procedure RxLabelLeftCloseMouseEnter(Sender: TObject);
    procedure RxLabelLeftCloseMouseLeave(Sender: TObject);
    procedure RxLabelLeftShowMouseEnter(Sender: TObject);
    procedure RxLabelLeftShowMouseLeave(Sender: TObject);
    procedure PanelLeftOpenClick(Sender: TObject);
    procedure RxLabelLeftShowClick(Sender: TObject);
    procedure RxLabelLeftOpenMouseEnter(Sender: TObject);
    procedure RxLabelLeftOpenMouseLeave(Sender: TObject);
    procedure MIChangeUnitClick(Sender: TObject);
    procedure MOpRecordClick(Sender: TObject);
    procedure MenuItemLawRulesClick(Sender: TObject);
    procedure MChangePasswordClick(Sender: TObject);
    procedure MChangeAnyiServerAddressClick(Sender: TObject);
    procedure AppException(Sender: TObject; E: Exception);
    procedure ActLogExecute(Sender: TObject);
    procedure RxLabelLeftMyCloseClick(Sender: TObject);
    procedure RxLabelLeftMyCloseMouseEnter(Sender: TObject);
    procedure RxLabelLeftMyCloseMouseLeave(Sender: TObject);
    procedure RxLabelLeftAllCloseClick(Sender: TObject);
    procedure RxLabelLeftAllCloseMouseEnter(Sender: TObject);
    procedure RxLabelLeftAllCloseMouseLeave(Sender: TObject);
    procedure StatusBarMainDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure sbtnMDICloseClick(Sender: TObject);
    procedure sbtnMDIResClick(Sender: TObject);
    procedure sbtnMDIMinClick(Sender: TObject);
    procedure MDownloadDataClick(Sender: TObject);
    procedure MUploadDataClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PgOnProgress(Rate: integer);
    procedure SplitterLeftDblClick(Sender: TObject);
    procedure SplitterLeftPosChanged(Sender: TObject);
    procedure SplitterLeftResize(Sender: TObject);
    procedure PanelLeftBoxResize(Sender: TObject);
    procedure CreateDesktopMenuClick(AMenuItem: TMenuItem);
    procedure ShowMenuPanel(AMenuButton: TMenuButton);
    procedure TimerDBSYTimer(Sender: TObject);
    procedure NDB_DBClick(Sender: TObject);
    procedure TimerCATimer(Sender: TObject);
    procedure MyBTimerExit(Sender: TObject);
    procedure NGNFLClick(Sender: TObject);
    procedure SpeedButton_xzdwClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure MCalculatorClick(Sender: TObject);
    procedure NFDMenuClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure mniBinaryGetClick(Sender: TObject);
    procedure mniUserStateClick(Sender: TObject);
    procedure tmrLockFormTimer(Sender: TObject);
    procedure rxlblFuncClick(Sender: TObject);
    procedure rxlblFuncMouseEnter(Sender: TObject);
    procedure rxlblFuncMouseLeave(Sender: TObject);
    procedure tvAccInfoClick(Sender: TObject);
    procedure tvAccInfoCollapsed(Sender: TObject; Node: TTreeNode);
    procedure tvAccInfoDblClick(Sender: TObject);
    procedure tvAccInfoExpanded(Sender: TObject; Node: TTreeNode);
    procedure tmrLockFormMinTimer(Sender: TObject);
    procedure NDWZTClick(Sender: TObject);
    //罗湖区项目需求，双击弹出切换单位的窗体 Added by chengjf 2016-01-13
    procedure StatusBarMainDblClick(Sender: TObject);
    procedure EditInputChange(Sender: TObject);
    procedure btnDWZTClick(Sender: TObject);
    procedure EditInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnYwrqClick(Sender: TObject);

  private
    { Private declarations }
    FLeftIsHide: Boolean; // 左侧（功能树）栏是否隐藏
    FLeftIsHideSel: Boolean; // 左侧（常用功能）栏是否隐藏
    FLeftIsHideAll: Boolean; // 左侧（全部功能）栏是否隐藏
    FMyFuncRoot: TTreeNode; //收藏夹功能根节点
    OtherProNode: TTreeNode; //其它产品节点
    OtherProStringList: TStringList; //其它产品列表
    CanExecFunc: Boolean;
    FOrgMenuItem: TStringList;

    // 崔立国 2010.05.11 窗口标题栏
    FWinIconRect: TRect;
    FWinMinBtnRect: TRect;
    FWinMaxBtnRect: TRect;
    FWinCloseBtnRect: TRect;
    FDownWinBtn: Integer;
    FMenuBox: TMenuBox;
    FDailyWorkMenu: TMenuBox;
    FWinCaptionDrawing: Boolean;

    {在主窗口左下脚显示各子窗口 R96 20050614 zhouyunlu}
    FWndList: TMDIChildList;
    FOldClientProc, FNewClientProc: TFarProc;
    ActiveMIDPre: TForm; //前一个激活的窗体
    BTimer:TTimer;
    FCurrNodeNum : string;
    bExitFind : Boolean;  //退出查找
    //zhengjy 2014-10-11 广西需求基础卫生版本，锁屏通数
    procedure OnMyMessage(var Msg: TMsg; var Handled: Boolean);
    procedure SetBitmapBtn(AimgLst:TImageList;Aimg:TImage;id:Integer);
    //设置面板
    procedure SetMainBorder;
    //设置面板数组值
    procedure SetDArrayPnls;
        //处理事件,Atype:0:leave,1:enter;
    procedure DoMouseEvent(Atag,Atype:Integer);
    //检查其它打开窗口
    function ChangeUnit:Boolean;
    //切换账套时检查其他打开窗口
    function ChangeDWZT:Boolean;
    procedure ClientWndProc(var Message: TMessage);
    procedure onPopup(Index: Integer; var Popop: Boolean);

    // procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RefreshBG;
    procedure WMERASEBKGND(var Msg: TWMERASEBKGND); message WM_ERASEBKGND;
    procedure WMSETCURSOR(var Msg: TWMSETCURSOR); message WM_SETCURSOR;

    procedure WMDLLMainClose(var Msg: TMessage); message WM_DLLMainClose; //释放包
    //procedure WMInitEncryptDemo(var Msg: TMessage); message WM_InitEncryptDemo; //给主程序菜单加演示版提示的消息
    procedure WMAC_ERRORCODE(var Msg: TMessage); message WM_AC_ERRORCODE;
    procedure UMAfterLogin(var Msg: TMessage); message UM_AFTERLOGIN;

    //procedure WMDLLMDICreate(var Msg: TMessage); message WM_DLLMDICreate;

    procedure UMSWITCHGZLB(var AMsg: TMessage); message UM_SWITCHGZLB; // 2012-05-15 mengjin

    function GetClickMenuItemByHint(AHint: string): TMenuItem;
    function CanAddMyNode: Boolean;
    procedure AddMyNode(ANode: TTreeNode);
    procedure DelMyNode(ANode: TTreeNode);
    procedure UpdateTreeViewMyFuncHeight;
    procedure SaveMyFuncToDB;
    procedure SetFuncTreeIcon;
    procedure SetParent;
    procedure MenuClick(Sender: TObject);
    procedure MenuMYClick(Sender: TObject);

    // 崔立国 2010.04.20 初始化主窗口皮肤样式
    procedure InitMainFormSkin;
    // 崔立国 2010.04.21 更换皮肤
    procedure MSkinMenuClick(Sender: TObject);
    // 崔立国 2010.05.10 合并主窗体和子窗体菜单
    procedure UpdateMIDMenuBar(AMainMenu: TMainMenu);
    // 崔立国 2010.05.26 修改状态栏属性支持重画
    procedure UpdateStatusBar;
    procedure treeFindnode(Anode: TTreeNode;FindStr : string);
    //取节点唯一编号 add by chengjf 20160323
    function GetGloabNum(Anode: TTreeNode;ChildNum : string) : string;
    procedure RunAutoLoad;
    (*procedure WMNCLButtonUp(var Message: TWMNCLButtonUp); message WM_NCLBUTTONUP;
    procedure WMNCHitText(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure UpdateWinBtnRect; *)

  protected
    procedure PRegNC(AMenuItem: TMenuItem); //自动记忆菜单命令
    procedure InitFuncTree;
    procedure InitMenu; //设置菜单/权限
    procedure ReActiveXPMenu;

    procedure InitFunTreeNode; // 崔立国 2011.08.23 为提高首次登录速度，InitFunTreeNode 功能已被 InitModTreeNode 系列函数替换。
    procedure InitModTreeNode; // 崔立国 2011.08.23 创建前台模块菜单根节点
    procedure InitSubFuncTreeNode(ANode: TTreeNode); // 崔立国 2011.08.23 创建前台模块菜单根节点下属功能菜单
    procedure InitSubFuncMenu(AMenu: TMenuItem);
    function FindTreeNodeByModCaption(AText: string): TTreeNode;
    Procedure INitSAMenu;
    procedure INitAQRMenu;

    //重写窗口创建时的客户区窗口过程 以设置各子窗口 R96 20050614
    procedure CreateWnd; override;
    // 2007-10-25 14:48 hch 添加统一获取分级的接口    //procedure InitFJ;
    procedure SetBitMap(img: TBitmap; index: Integer);
    //调用外部应用程序执行
    procedure ChangeYearMenuItemClick(Sender: TObject);
    //调用外部应用程序的权限判断
    function CheckPowerFun(GnID: Integer): Boolean;
    {判断是否为报表节点}
    function IsAQRNode(Node: TTreeNode): Boolean;
    {判断是否为领导决策节点}
    function IsMIDSNode(Node: TTreeNode): Boolean;  //added by guozy 2012-02-17
    {生成MIDS的查询菜单}
    function GetMIDSTree(tv: TTreeView): Boolean;
    {生成预算执行分析的树型}
    function GetBKATree(tv: TTreeView): Boolean;
    {生成预算执行分析的树型}
    function GetGETree(tv: TTreeView): Boolean;
    {生成网上报销的业务单据菜单}
    function GetOERDJLX(tv: TTreeView): Boolean;
    {生成用款申请业务单据菜单}
    function GetFDADJLX(tv:TTreeView):Boolean;
    //查找模块节点
    function FindLevel0Node(tv: TTreeView; aName: string): TTreeNode;
    //查找模块指定功能节点
    function FindLevelNode(tv: TTreeView; ANode: TTreeNode; AName: String): TTreeNode;
    {显示当前选择的工资类别}
    procedure DispStatus(ModName: String);
    //procedure SetTreeDemoText;
    procedure InitTreeQXKZ; //菜单显示控制
  public
    AnyiClient1: TAnyiClient;
    FMenu: TMergerMenu;
    FslUIR9_IMPL: TslUIR9_IMPL; //动态库控制类，包含多个接口类    //FListDLL:TStringList;
    FSkin: string;
    TempMenuDBSYRef: TMenuItem;
    sCurAPTsGnflmc:string;
    procedure InitModSubTreeNodeAndMenuBox(ANode: TTreeNode);  // 崔立国 2011.08.23 创建前台模块菜单根节点下属功能菜单，刷新菜单盒。

    procedure InitStatusBar;
    function AfterLoginInitData: Boolean;
    function AfterLoginInitMenu: Boolean;
    function MenuOnClick(AMenuItem: TMenuItem; ItemText, ParentText: string): Boolean;
    procedure FuncTreeClick(ATreeView: TTreeView = nil); //procedure ClearShortCutMenu; //清除快捷菜单
    // 崔立国 2010.04.20 初始化主窗口皮肤样式
    procedure InitNoExistsImage;
    procedure CreateSkinMenu;
    procedure AfterMainFormSkinChanged; virtual;
    procedure LoadModeDll(psModeName, sGnflMc, sGnflExec: string); //ParamList:string='';
    function InitPubSYS: Boolean;
    //procedure UpdateMainMenuDemo(psModeName:String);
	function UpdateDBSY(pBupdateMenbox: Boolean; psModeCode: string): Integer;
    function FreeEncrypt(sModeName:String):Boolean; //释放模式窗体的加密
    procedure BeforeAPT(Sender:TObject; var AParams: String);
    procedure RadioDBSY;
  end;

  // 崔立国 2011.06.18 待办事宜改为多线程查询方式，避免主界面等待时间过长。
  TDBSYThread = class(TThread)
  private
    { Private declarations }
    FMainForm: TFormMain;
    FNeedUpdateMenuBox: Boolean;
    FModeCode: string;
    FWorkCount: Integer;
  protected
    procedure Execute; override;
    procedure UpdateMainFormDBSY;
    function UpdateDBSY(pBupdateMenbox: Boolean; psModeCode: string): Integer;
  public
    constructor Create(MainForm: TFormMain; NeedUpdateMenuBox: Boolean;
      ModeCode: string);
  end;

var
  FormMain: TFormMain;
  GbCaPinLogin:Boolean=False; //CA认证，门户传递Pin密码到客户端登录
  GsPin : string='';
  GbAutoLogin:Boolean=False;      // DSL
  // 崔立国 2011.08.23 HashParentList用来保存父节点指针，提高查找效率。
  HashNodeList: THashedStringList;
  Gszkjnd_First:String; //首次登录会计年度，便于查询其他年度后，退回
  GbAgainLogin:Boolean=False; //当前登录是否是重新登录
  DArrayPnls:array of TPanel;
  DArrayImgs:array of TImage;
  DArrayActive:array of Boolean;
  DArrayTitle:array of string;
    
// 在TreeView中创建菜单树
procedure CreateMenuTree(Tree: TTreeView; Query: TClientDataSet; NeedClear, AVisible: Boolean);

//Procedure CreateDWTree(Tree:TTreeView;Query:TClientDataSet;NodeSJ:TTreeNode);
function InterceptText(S: string): string; //取字符串Sstr中，字符'('之前的字符串
function GetSYSHelpFile: string;
//zhengjy 20140717 设置与后台通讯格式：XML 、CDS格式
procedure SetR9PacketsCDS;

implementation

uses Pub_Function, Pub_Message, Pub_Power, PubClass_GL,
  Login, {$IFNDEF ocx}BackGroundUnit, PLAT_LAWRULEMANAGER, {$ENDIF}PLAT_Utils,
  About, Pub_Res, CZRZ, ChgPassword, OtherProLstEdit, GLPreview, Wait, DataSyncDownload,
  uRptCaller,LoginKeyIntf, ChgUsername,SYS_YHTDCL,FBSIP_ZFSBCX,SYS_HTAlarm,UUserStatus,ULockForm{,
  UIKey, SYS_DBSY};

// 崔立国 2010.05.11 窗口标题栏临时画布
//FWinCaptionBmp: TBitmap;

{$R *.DFM}
procedure SetR9PacketsCDS;
var
  szSQL:string;
begin
  szSQL :='select csvalue from pub_ztcs where gsdm=''99999999999999999999'' and kjnd=''9999'' and csdm=''SYS_CONFIG''';
  try
    POpenSQL(DataModulePub.ClientDataSetTmp,szSQL);
    //zhengjy 20140813 判断是否有记录或值为空，防止CASE语句强转整型时出现异常
    if (DataModulePub.ClientDataSetTmp.RecordCount<=0)
      or (Trim(DataModulePub.ClientDataSetTmp.FieldByName('csvalue').AsString)='') then
    begin
      DataModuleMain.SetR9PacketsCDS(False);
      FormMain.mniBinaryGet.Visible :=false;
      Exit;
    end;
    case DataModulePub.ClientDataSetTmp.FieldByName('csvalue').AsInteger of
      0:begin  //设置通讯格式XML，并隐藏菜单
        DataModuleMain.SetR9PacketsCDS(False);
        FormMain.mniBinaryGet.Visible :=false;
      end;
      1:begin  //设置选项设置通讯格式，并隐藏菜单
        FormMain.mniBinaryGet.Visible :=true;
        if FormMain.mniBinaryGet.Checked  then DataModuleMain.SetR9PacketsCDS(true)
        else DataModuleMain.SetR9PacketsCDS(false);
      end;
      2:begin
        DataModuleMain.SetR9PacketsCDS(true);
        FormMain.mniBinaryGet.Visible :=False;
      end;
    end;
  except
    DataModuleMain.SetR9PacketsCDS(False);
    FormMain.mniBinaryGet.Visible :=false;
  end;
end;

// 在TreeView中创建菜单树
procedure CreateMenuTree(Tree: TTreeView; Query: TClientDataSet; NeedClear, AVisible: Boolean);
// NodeSJ 表示在以当前节点作为创建树的根节点下
var
  ParentNode: TTreeNode;
  sModCode, sMenuCode, sMenuName, sGnflmc, sGnflExec, sShortCut, sGNFLDM, sGnScripts, sGNFL_Ver,sGNFL_VerHB,sVercode: string;
  Cds:TClientDataSet;
  // 崔立国 2011.08.23 原有 FindParent效率较低，改为FindHashParent()。
  function FindHashParent(AMenuCode: string): TTreeNode;
  var
    sSJDM: string;
    i: Integer;
  begin
    sSJDM := Copy(AMenuCode, 1, Length(AMenuCode) - 2);
    i := HashNodeList.IndexOf(sSJDM);
    if (i >= 0) then
      Result := TTreeNode(HashNodeList.Objects[i])
    else
      Result := nil;
  end;

  function FindHashMenu(AMenuCode: string): TTreeNode;
  var
    i: Integer;
  begin
    i := HashNodeList.IndexOf(AMenuCode);
    if (i >= 0) then
      Result := TTreeNode(HashNodeList.Objects[i])
    else
      Result := nil;
  end;

  function FindMenu(AMenuCode: string): TTreeNode;
  var
    i: Integer;
  begin
    for i := 0 to Tree.Items.Count - 1 do
    begin
      Result := Tree.Items[i];
      if (Result.Data <> nil) and SameText(PTreeRec(Result.Data)^.sMenuCode, AMenuCode) then
        Exit;
    end;
    Result := nil;
  end;

  function FindParent(AMenuCode: string): TTreeNode;
  var
    sSJDM: string;
    i: Integer;
  begin
    sSJDM := Copy(AMenuCode, 1, Length(AMenuCode) - 2);
    Result := FindMenu(sSJDM);
  end;

  function AddTreeNode(TempNode: TTreeNode; psModCode, psMenuCode, psMenuName, psGnflmc, psGnflExec, psShortCut,
    sGNFLDM, sGnScripts: string): TTreeNode;
  var
    pRecPtr: PTreeRec;
    i: Integer;
  begin
    New(pRecPtr);
    pRecPtr^.sModCode := psModCode;
    pRecPtr^.sMenuCode := psMenuCode;
    pRecPtr^.sGnflmc := psGnflmc;
    pRecPtr^.sGnflExec := psGnflExec;
    pRecPtr^.sShortCut := psShortCut;
    pRecPtr^.sGNFLDM := sGNFLDM;
    pRecPtr^.sGnScripts := sGnScripts;
    pRecPtr^.bSubMenuCreated := False;
    pRecPtr^.bVisible := AVisible; //(TempNode=nil); //一级节点可见
    Result := Tree.Items.AddChildObject(TempNode, psMenuName, pRecPtr);
    Result.ImageIndex := 2;
    Result.SelectedIndex := 2;
    // 崔立国 2011.08.23 前台模块菜单首次创建时不创建下属功能菜单，此属性值为False。
    //                   第一次访问该模块时再创建下属功能菜单，此属性值变为True。
    if (TempNode <> nil) and (TempNode.Data <> nil) then
      PTreeRec(TempNode.Data)^.bSubMenuCreated := True;

    if (Tree = FormMain.TreeViewFunc) then
    begin
      i := HashNodeList.IndexOf(psMenuCode);
      if (i >= 0) then
        HashNodeList.Objects[i] := Result
      else
        HashNodeList.AddObject(psMenuCode, Result);
    end;
  end;

begin
  sGNFL_Ver:='';
  sGNFL_VerHB:='';
  if GszRelease='政府财务' then begin
    sGNFL_Ver:=',ZF_'+GszEdition+',';
    sGNFL_VerHB:=',XZ_'+GszEdition+',' //政府和行政事业合并了
       
  end else if GszRelease='行政事业财务' then begin
    sGNFL_Ver:=',XZ_'+GszEdition+',';
    sGNFL_VerHB:=',ZF_'+GszEdition+',' //政府和行政事业合并了 
  end else if GszRelease='卫生财务' then
    sGNFL_Ver:=',WS_'+GszEdition+','
  else if GszRelease='教育财务' then
    sGNFL_Ver:=',JY_'+GszEdition+','
  else if GszRelease='社保财务' then
    sGNFL_Ver:=',SB_'+GszEdition+','

  else if GszRelease='财政' then
    sGNFL_Ver:=',CZ_'+GszEdition+','
  else if GszRelease='乡镇财政' then
    sGNFL_Ver:=',XC_'+GszEdition+',';

  if NeedClear then Tree.Items.Clear;
  Cds := TClientDataSet.Create(nil);
  Cds.Data := Query.Data;
  Cds.Open;
  Tree.Items.BeginUpdate;
  try
    with Cds do
    begin
      FindFirst;
      repeat
        sModCode := FieldByName('ModCode').AsString;
        sMenuCode := FieldByName('MenuCode').AsString;
        sMenuName := FieldByName('MenuName').AsString;
        sGnflMc := FieldByName('Gnflmc').AsString;
        sGnflExec := FieldByName('GnflExec').AsString;
        sGNFLDM := FieldByName('GNFLDM').AsString;
        sShortCut := FieldByName('MenuShortCut').AsString;
        sGnScripts := Trim(FieldbyName('GnScripts').AsString);

        // 崔立国 2011.11.01 只有 TreeViewFunc 因为功能菜单数量多才采用Hash快速定位，TreeViewMyFunc待办事宜不需要。
        if (Tree = FormMain.TreeViewFunc) then
        begin
          if (FindHashMenu(sMenuCode) <> nil) then Continue;
        end else
        begin
          if (FindMenu(sMenuCode) <> nil) then Continue;
        end;
        
        {if HideMenu.FHideList.IndexOfName(AMenuCode)
        if HideMenu.IsHide(GszGSDM, GszKJND, sGNFLDM) then
        begin
          Continue;  
        end;  }

        if ((sGNFL_Ver<>'') or (sGNFL_VerHB<>'')) and (Query.FindField('VERCODE')<>nil) then
        begin
          sVercode := Trim(FieldbyName('VERCODE').AsString);

          if pos(sGNFL_Ver,sVercode)=0 then begin
            //当前版本该功能不可用，继续处理下一条记录
            if sGNFL_VerHB='' then begin
               Continue;
            end else begin
               if Pos(sGNFL_VerHB,sVercode)=0 then  //政府和行政事业版合并了，所以2者菜单可以互用
                  Continue;
            end;      
          end;
        end;

        ParentNode := nil;
        if (Length(sMenuCode) > 2) then
        begin
          // 崔立国 2011.11.01 只有 TreeViewFunc 因为功能菜单数量多才采用Hash快速定位，TreeViewMyFunc待办事宜不需要。
          if (Tree = FormMain.TreeViewFunc) then
          begin
            ParentNode := FindHashParent(sMenuCode);
          end else
          begin
            ParentNode := FindParent(sMenuCode);
          end;
          if ParentNode <> nil then
            ParentNode.ImageIndex := 0; //end else ParentNode := NodeSJ;     AddTreeNode(ParentNode,sDM,sMC,sGNEXec);
        end;
        AddTreeNode(ParentNode, sModCode, sMenuCode, sMenuName, sGnflmc, sGnflExec, sShortCut, sGNFLDM, sGnScripts);
      until not FindNext;
    end;
  finally
    Tree.Items.EndUpdate;
  end;
end;

function GetSYSHelpFile: string;
begin
  Result := GExePath + 'help\Login.hlp';
end;

function InterceptText(S: string): string;
begin
  if Pos('(', S) > 0 then
    Result := Copy(S, 1, Pos('(', S) - 1)
  else
    Result := S;
end;

procedure TFormMain.RefreshBG;
begin
  if FormBackGround <> nil then
  begin
    FormBackGround.Top := 0;
    FormBackGround.Left := 0;

    if FormBackGround.WindowState <> wsMaximized then
    begin
      if PanelLeftMain.Visible then
        FormBackGround.Width := ClientWidth - SplitterLeft.Left - SplitterLeft.Width - 4
      else
        FormBackGround.Width := ClientWidth - PanelNavBar.Left + PanelNavBar.Width - 4;

      FormBackGround.Height := ClientHeight - PanelToolBar.Height - Panel_StatusBarMain.Height - 9;
    end;
  end;

  {
  if Label1.Left <= 54 then
    Label2.Visible := False
  else
    Label2.Visible := True;
  }
end;

procedure TFormMain.WMERASEBKGND(var Msg: TWMERASEBKGND);
begin
  inherited;
  RefreshBG;
end;

procedure TFormMain.WMSETCURSOR(var Msg: TWMSETCURSOR);
begin
  inherited;
  RefreshBG;
end;

procedure TFormMain.ActionListMMExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
  //  PRegNC(Action);
end;

procedure TFormMain.ActAboutExecute(Sender: TObject);
begin
  PRegNC(MAbout);
  GetAbout;
end;

procedure TFormMain.ActHelpExecute(Sender: TObject);
var
  sHelpFileTemp: string;
begin
  sHelpFileTemp := Application.HelpFile;
  try
    Application.HelpFile := GetSYSHelpFile;
    Application.HelpCommand(HELP_CONTENTS, 0);
  finally
    Application.HelpFile := sHelpFileTemp;
  end;
end;

procedure TFormMain.ActHelpIndexExecute(Sender: TObject);
var
  sHelpFileTemp: string;
begin
  sHelpFileTemp := Application.HelpFile;
  try
    Application.HelpFile := GetSYSHelpFile;
    Application.HelpCommand(HELP_FINDER, 0);
  finally
    Application.HelpFile := sHelpFileTemp;
  end;
end;

function TFormMain.AfterLoginInitData: Boolean;
var
  cdsTemp: TClientDataSet;
begin
  THideMenu.Refresh;
  //hch 只初始化一次，多次会导致一些问题
  TPlugDev.FreeInvoke;
  //2009-4-15 导入Exe的插件应用
  TPlugDev.LoadFun;
  TPlugDev.LoadLib; //导入Lib插件应用
  Result := False;
  GszGSDM := GszHSDWDM;
  try
    GOldGqx := Gqx; //GsProductSign := 'SA;GL;GAL;FA;PA;CM;FBI;GBG';   //需要根据当前数据库中存在的模拟权限来拼串 99?
    cdsTemp := GetPower(Gqx, GCzy.ID); //得到新操作员的新功能权限，给操作员权限赋值
    CdsPower.Data := cdsTemp.Data;
    CdsPower.IndexFieldNames := 'GNFLDM';
    // 崔立国 2010.10.12 离线应用，只有账务能录入凭证（不支持审核、记账），其他模块只能查询不能录入。
    if GblOfflineMode then
      GetOfflinePower(Gqx);
  except
    SysMessage('权限数据不正确，您登录的可能是旧版本的数据库，请对该数据库升级后再登录！', '', [mbOK]);
    Gqx := GOldGqx;
    Exit;
  end;

  GblTerminateApp := False;
  InitPubSYS; //初始化公用业务变量
  Result := True;

end;

function TFormMain.AfterLoginInitMenu: Boolean;
var
  i: Integer;
  szSQL: string;
  bGiReLogin :Boolean;
begin
  Result := False;
  bGiReLogin := False;
  // 2007-10-25 14:49 hch 添加统一获取分级 //InitFJ;
  // 2008.12.23 hy 不使用这里的函数了，在系统初始化时会统一处理辅项初始化

  try
    Label4.Caption := '  初始化菜单...';
    Label4.Update;

    FOrgMenuItem.Clear;
    InitFuncTree; //初始化功能树，及菜单
    Label4.Caption := '  加载功能菜单...';
    Label4.Update;

    InitMenu; //设置菜单界面
    Label4.Caption := '  加载菜单插件...';
    Label4.Update;

    InitStatusBar; //初始化状态拦

    //初始化引导检查下
    szSQL := 'Select Count(*) num from PubModSetup where gsdm=''' + CSysDWDM + ''' and ModName=''SYS''';
    //szSQL := 'Select Count(*) num from pubModSetup where IsStart=''1''  and Gsdm<>'+QuotedStr(CSysDWDM);
    POpenSql(DataModulePub.ClientDataSetTmp, szSQL);
    if (DataModulePub.ClientDataSetTmp.FieldByName('num').AsInteger <= 0) then
    begin //LoadXTCS;
      for i := 0 to TreeViewFunc.Items.Count - 1 do
      begin
        if Pos('系统初始化引导', TreeViewFunc.Items[i].Text) > 0 then
        begin
          TreeViewFunc.Items[i].Selected := True;
          bGiReLogin := True; // 弹出初始化设置窗口，但要在后面弹出，以免窗口出现乱码
          //rMainSub.GiReLogin := 2;         //表示正在登录，修账套参数这种后，需要强制登陆
          //FuncTreeClick(TreeViewFunc);
          Break;
        end;
      end;
    end;

    Label4.Caption := '  创建浮动菜单...';
    Label4.Update;

    FMenuBox.LoadMenuItem(NGNFL);
    FDailyWorkMenu.LoadMenuItem(mDailyWork);

    Label4.Caption := '  初始化桌面...';
    Label4.Update;

    if Assigned(FormBackGround) then
       FormBackGround.LoadConfig(GCzy.name);

    (* // 崔立国 2009.02.25 在 FormCreate 时 TimerDemo.Enabled := False;
    if GszRelease = 'DEMO' then begin // 演示版调整 Lzn 20060918 For R97
      TimerDemo.Enabled := True;
      TimerDemo.Interval := 15 * 60 * 1000; //15 minutes
    end; *)
   
    if Global_SYS=nil then begin
       Global_SYS := TPublicModSYS.Create;
    end else
       Global_SYS.BakGlobal;

    Label4.Caption := '  查询待办事宜...';
    Label4.Update;
    if GpsSeries <> psR9 then begin
       TimerDBSY.Enabled := True; //重新登录时也会执行这里 ,放最后，以免触发事件
       TimerDBSYTimer(nil);
       RadioDBSY;
    end;

    if GCzy.bCA then begin
       TimerCA.Interval := 12 * 60 * 1000; //12分钟
       TimerCA.Enabled := True;
    end else
       TimerCA.Enabled := False;

    Label4.Caption := '  功能导航';
    Result := True;

  finally
    CloseWait;
  end;

  if bGiReLogin then begin
     rMainSub.GiReLogin := 2;         //表示正在登录，修账套参数这种后，需要强制登陆
     FuncTreeClick(TreeViewFunc);
  end;
  //FMenuBox.Visible := False;

  //20140529--wjh--龙岗银行退单查询--权限和参数控制是否
  if TPower.GetPower('1169') and IsShowYHTDCLFrom then Load_SYS_YHTDCL;
  if TPower.GetPower('1170') and IsShowYHTDCLFrom then Load_FBSIP_ZFSBCX;

  //20141113-yangxda-合同提醒
  if TPower.GetPower('6535') and IsShowHTAlarm then LoadHTALARM(0,False);
  //调用自动运行的功能 add by chengjf 20160822
  RunAutoLoad;
  //弹出待办提醒窗体    ZWR900404058\ZWR900404059 去掉  
//  if TPubModSetup.IsStart(GszGSDM, 'GSP') or TPubModSetup.IsStart(GszGSDM, 'GBI')
//    or TPubModSetup.IsStart(GszGSDM, 'GCP') or TPubModSetup.IsStart(GszGSDM, 'OER') then
//    LoadDBSY;
end;

procedure TFormMain.InitStatusBar;
var
  szTemp,szYSND: string;
begin
  if Trim(GCZY.CzyCode)='' then
       szTemp := '操作员：[' + IntToStr(GCzy.ID)+'] ' + GCzy.Name
  else szTemp := '操作员：[' + IntToStr(GCzy.ID)+' '+Trim(GCZY.CzyCode) + '] ' + GCzy.Name;

  StatusBarMain.Panels[1].Width := StatusBarMain.Canvas.TextWidth(szTemp) + 20;
  StatusBarMain.Panels[1].Text := szTemp;

  //wjh--20141106--维护单ZWR900211942  如启用部门预算 状态栏 添加预算年度
  if TPubModSetup.IsStart(GszGSDM,'DBGFS') then
  begin
     szYSND:=PGetKJND(GszYWRQ,True);
     szTemp := '业务日期：' + GszYWRQ+'  预算年度：'+IFF(szYSND<>'',szYSND,GszKJND)
  end
  else
  szTemp := '业务日期：' + GszYWRQ;
  
  StatusBarMain.Panels[2].Width := StatusBarMain.Canvas.TextWidth(szTemp) + 20;
  StatusBarMain.Panels[2].Text := szTemp;

  if GszHSDWDM <> CSysDWDM then
    szTemp := '单位：[' + GszHSDWDM + '] ' + GszHSDWMC
  else
    szTemp := '单位：[系统级单位]';

  StatusBarMain.Panels[3].Width := StatusBarMain.Canvas.TextWidth(szTemp) + 20;
  StatusBarMain.Panels[3].Text := szTemp;

  szTemp := '账套：' + '[' + GszZth + '] ' + GszZtmc;
  StatusBarMain.Panels[4].Width := StatusBarMain.Canvas.TextWidth(szTemp) + 20;
  StatusBarMain.Panels[4].Text := szTemp;

 (* if DataModulePub.MidasConnectionPub.ServerGUID = CLocalServerGUID then  切换到http模式时，改代码执行有问题，特注释
    if GDbType = Oracle then
      szTemp := '数据库服务器：' + GsServerName + ' [' + GsUserName + '] '
    else
      szTemp := '数据库服务器：' + GsServerName + ' [' + GsDatabaseName + '] '
  else if DataModulePub.MidasConnectionPub.ServerGUID = COfflineServerGUID then
    szTemp := ' 当前是【离线工作模式】，部分功能受到限制不能使用！'
  else
    szTemp := '应用服务器：' + GszServerComputer;
  *)
  if DataModulePub.MidasConnectionPub.ConnectType = ctDCOM then begin
     if GDbType = Oracle then
          szTemp := '数据库服务器：' + GsServerName + ' [' + GsUserName + '] '
     else szTemp := '数据库服务器：' + GsServerName + ' [' + GsDatabaseName + '] '
  end else if DataModulePub.MidasConnectionPub.ServerGUID = COfflineServerGUID then
       szTemp := ' 当前是【离线工作模式】，部分功能受到限制不能使用！'
  else szTemp := '应用服务器：' + GszServerComputer;

  StatusBarMain.Panels[5].Width := StatusBarMain.Canvas.TextWidth(szTemp) + 20;
  StatusBarMain.Panels[5].Text := szTemp;
end;

procedure TFormMain.RxCalculatorMainCalcKey(Sender: TObject;
  var Key: Char);
begin
  if (Key = '=') then
  begin
    if RxCalculatorMain.Tag <> 0 then
    begin
      RxCalculatorMain.Tag := 300; //RxCalculatorMain.Close;
      Key := #0;
    end;
  end
  else if Key = #27 then
  begin
    RxCalculatorMain.Tag := 1; //RxCalculatorMain.Close;
    Key := #0;
  end;
end;

procedure TFormMain.ActCalculatorExecute(Sender: TObject);
var
  AKey: Char;
begin
  { PRegNC(MCalculator);
   RxCalculatorMain.Tag := 0;
   AKey := '+';
   RxCalculatorMain.Execute(); }
end;

procedure TFormMain.ActTileExecute(Sender: TObject);
begin
  Tile;
end;

procedure TFormMain.ActExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormMain.ActCascadeExecute(Sender: TObject);
var
  i: Integer;
  AMDI: TForm;
begin
  AMDI := ActiveMDIChild;
  Cascade;
  for i := 0 to MDIChildCount - 1 do
    if not SameText(MDIChildren[i].Caption, '桌面') then
    begin
      MDIChildren[i].BringToFront;
    end;

  if not SameText(AMDI.Caption, '桌面') then
  begin
    AMDI.BringToFront;
  end;
end;

procedure TFormMain.ActLoginExecute(Sender: TObject);
var
  i: Integer;
  FGszGSDM, FYWRQ, FGszHSDWDM, FGszHSDWMC, FGszZth, FGszZTMC, FKJND: string;
  FCzy: TCzy;
  iCount: integer;
begin
  if Assigned(FormBackGround) then
    iCount := 1
  else
    iCount := 0;

  if (MDIChildCount > iCount) then
  begin
    for i := 0 to MDIChildCount - 1 do
      if not (MDIChildren[i] is TFormBackGround) then
        MDIChildren[i].BringToFront;
    SysMessage('重新登录前请关闭所有打开的窗口。', '', [mbOk]);
    Exit;
  end;
  
  if Assigned(FormBackGround) then begin
     FormBackGround.SaveConfig(gCZy.name);
     FormBackGround.SaveDesktopImageSettings;
  end;

  GbCaPinLogin := False;  //重新登录时要清空pin密码
  GsPin := '';
  //if not AlertCLoseAllWindow('重新登录前请关闭所有打开的窗口。',FormBackGround) then Exit;

  PRegNC(MRelogin);
  FGszGSDM := GszGSDM;
  FGszHSDWDM := GszHSDWDM;
  FGszHSDWMC := GszHSDWMC;
  FGszZth := GszZth;
  FGszZTMC := GszZTMC;
  FYWRQ := GszYWRQ;
  FKJND := GszKJND;
  FCzy := GCzy;
  GszGSDM311 := ''; //重新登录要清空，以免连不上数据库
  GbAgainLogin :=True;
  if SysReLogin then
  begin
    // 崔立国 2011.10.26 登录后第一次点"功能"菜单时构建所有模块的下级功能子菜单。
    NGNFL.Tag := 0;
    if GpsSeries = psR9i then
    begin
      //重新登陆后默认显示功能树  add by chengjf 20150507
      rxlblFuncClick(rxlblFunc);
      NDWZT.Checked := (PIniReadS('GlSys.ini', 'NMainMenu', 'NDWZT', '1')='1');
      if NDWZT.Checked  then
      begin
        if not Panelgndh.Visible then
        begin
          pnlAccInfo.Visible := True;        
          Panelgndh.Visible := True;
          SetMainBorder;
          SetDArrayPnls;
        end;
      end
      else begin
        pnlAccInfo.Visible := False;      
        Panelgndh.Visible := False;
        SetMainBorder;
        SetDArrayPnls;
      end;
    end;
  end
  else
  begin
    GszGSDM := FGszGSDM;
    GszHSDWDM := FGszHSDWDM;
    GszHSDWMC := FGszHSDWMC;
    GszZth := FGszZth;
    GszZTMC := FGszZTMC;
    GszYWRQ := FYWRQ;
    GszKJND := FKJND;
    GCzy := FCzy;
    GDBType := GetDBType(True);
  end;
end;

procedure TFormMain.ActLeftCloseExecute(Sender: TObject);
begin
  if (Sender <> nil) then
    FLeftIsHide := not FLeftIsHide;

  MFuncTree.Checked := not FLeftIsHide;

  if FLeftIsHide then
  begin
    PanelTopMain.Height := 6;
    PanelLeftMain.Visible := False;
    SplitterLeft.Visible := False;
    PanelNavBar.Visible := True;
    PanelNavBar.Left := 0;
  end
  else
  begin
    PanelTopMain.Height := PanelTopMain.Tag;
    PanelLeftMain.Visible := True;
    SplitterLeft.Visible := True;
    SplitterLeft.Left := PanelLeftMain.Width + 10;
    PanelNavBar.Visible := False;
  end;

  SetParent;
end;

procedure TFormMain.InitMenu;
begin

  XPMenu1.Active := False;
  XPMenu1.XPContainers := [xccForm, xccFrame, xccToolbar, xccCoolbar, xccControlbar,
    xccPanel, xccScrollBox, xccGroupBox, xccTabSheet, xccPageScroller, xccNoteBook];
  XPMenu1.XPControls := [xcMainMenu, xcPopupMenu, xcToolbar, xcControlbar, xcCombo,
    xcEdit, xcMaskEdit, xcMemo, xcRichEdit, xcCheckBox, xcRadioButton,
    xcButton, xcBitBtn, xcSpeedButton, xcPanel, xcGroupBox, xcDirectoryEdit,
    xcGrid, xcTreeView, xcListBox, xcProgressBar];
  XPMenu1.Active := True;

end;

procedure TFormMain.INitSAMenu;
var
  i:Integer;
begin
  for i:=0 to TreeViewFunc.Items.Count-1 do begin
      if Pos('系统管理',TreeViewFunc.Items[i].Text)>0 then begin
         InitSubFuncTreeNode(TreeViewFunc.Items[i]);
         Exit;
      end;
  end;
end;

procedure TFormMain.INitAQRMenu;
var
  i:Integer;
begin
  for i:=0 to TreeViewFunc.Items.Count-1 do begin
      if Pos('电子报表',TreeViewFunc.Items[i].Text)>0 then begin
         InitSubFuncTreeNode(TreeViewFunc.Items[i]);
         Exit;
      end;
  end;
end;

procedure TFormMain.InitFuncTree;
var
  iCount: Integer;
  TempMenuDBSY: TMenuItem;  

  procedure AddMenu(AParentMenu: TMenuItem; Node: TTreeNode); //待办事宜菜单
  var
    TempMenu: TMenuItem;
    iM: Integer;
    sShortCut: string;
  begin //szCaption := Node.Caption; ipos := Pos('(', szCaption); if ipos > 0 then  szCaption := copy(szCaption, 1, iPos - 1);
    (*if GCzy.ID <> 1 then
    begin //系统管理员默认有所有可见菜单，因为有所有权限，提高系统管理员的处理效率
      if not Node.HasChildren then
      begin
        if (Node.Data <> nil) and (not PTreeRec(Node.Data)^.bVisible) then
          Exit;
      end;
    end; *)

    TempMenu := TMenuItem.Create(AParentMenu);
    TempMenu.Caption := Node.Text + ' ';
    TempMenu.OnClick := MenuMYClick;
    try
      if {(not IsAQRNode(Node)) and}(Node.Data <> nil) then
      begin
        sShortCut := UpperCase(Trim(PTreeRec(Node.Data)^.sShortCut));
        if sShortCut <> '' then
          TempMenu.ShortCut := TextToShortCut(sShortCut);
      end;
      TempMenu.Tag := Node.AbsoluteIndex;
    except

    end;

    AParentMenu.Add(TempMenu);
    for iM := 0 to Node.Count - 1 do
    begin
      if Node.Item[iM].Level = Node.Level + 1 then
        AddMenu(TempMenu, Node.Item[iM]);
    end;
  end;

  procedure InitMyNode; //待办事宜
  var
    sSQL, sWhere: string;
    i: Integer;
  begin
    MDBSY.Clear;
    with TreeViewMyFunc do
    begin
      sWhere := '';
      if GszHSDWDM = '' then
      begin
        Exit;
      end;

      if GszZth = '' then
        sWhere := sWhere + ' modcode<>''GL'' and modcode<>''GAL'' and ';

      //只显示启用了的
      sWhere := sWhere + ' (modcode in (select modName from pubmodsetup where gsdm=''' + Gszgsdm +
        ''' and isstart=1)) and ';
      sWhere := Trim(sWhere);
      if sWhere <> '' then //去掉 and
        System.Delete(sWhere, Length(sWhere) - 3, 4);

      if Trim(sWhere) <> '' then
        sWhere := ' where ' + sWhere;

      sSQL := 'select * from pub_dbsy ' + sWhere + ' order by MenuCode';
      POpenSql(DataModulePub.ClientDataSetTmp, sSQL);
      with DataModulePub.ClientDataSetTmp do
      begin
        if Recordcount <= 0 then
          Exit;
        CreateMenuTree(TreeViewMyFunc, DataModulePub.ClientDataSetTmp, True, False);
        MDBSY.Caption := '待办事宜（正在提取...）';
      end;
      for i := 0 to Items.Count - 1 do
      begin
        if Items[i].Level = 0 then
          AddMenu(MDBSY, Items[i]);
      end;
    end;

    TempMenuDBSYRef := TMenuItem.Create(MDBSY);
    TempMenuDBSYRef.Name := 'NDB_DS';
    TempMenuDBSYRef.Caption := '定时刷新';
    TempMenuDBSYRef.OnClick := nil;
    TempMenuDBSYRef.Tag := -1;
    MDBSY.Add(TempMenuDBSYRef);

    TempMenuDBSY:= TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_NO';
    TempMenuDBSY.Caption := '不刷新';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;
    TempMenuDBSY.Checked := True;
    TempMenuDBSY.Tag := -2;
    TempMenuDBSYRef.Add(TempMenuDBSY);
        
    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_5';
    TempMenuDBSY.Caption := '5分钟';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;
    TempMenuDBSY.Tag := -5;
    TempMenuDBSYRef.Add(TempMenuDBSY);

    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_10';
    TempMenuDBSY.Caption := '10分钟';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;
    TempMenuDBSY.Tag := -10;
    TempMenuDBSYRef.Add(TempMenuDBSY);

    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_20';
    TempMenuDBSY.Caption := '20分钟';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;    
    TempMenuDBSY.Tag := -20;
    TempMenuDBSYRef.Add(TempMenuDBSY);

    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_30';
    TempMenuDBSY.Caption := '30分钟';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;
    TempMenuDBSY.Tag := -30;
    TempMenuDBSYRef.Add(TempMenuDBSY);

    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_60';
    TempMenuDBSY.Caption := '60分钟';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;     
    TempMenuDBSY.Tag := -60;
    TempMenuDBSYRef.Add(TempMenuDBSY);            

    TreeViewMyFunc.FullExpand;
  end;

begin
  try //hch 解决重新登陆释放的问题
    for iCount := TreeViewFunc.Items.Count - 1 downto 0 do
    begin
      if TreeViewFunc.Items[iCount].Data <> nil then
        Dispose(TreeViewFunc.Items[iCount].Data);
      TreeViewFunc.Items[iCount].Delete;
    end;
  except
  end;

  if GpsSeries = psR9 then
     MDBSY.Visible := False;

  // 崔立国 2011.08.23 HashNodeList用来保存父节点指针，提高查找效率。
  HashNodeList.Clear;
  FMenuBox.Visible := NFDMenu.Checked;  
  if NFDMenu.Checked then begin
     InitModTreeNode;
  end;
  // 崔立国 2011.08.23 为提高首次登录速度，InitFunTreeNode 功能已被 InitModTreeNode 系列函数替换。
  if not NFDMenu.Checked then begin
     InitFunTreeNode; //创建功能树
  end;
  INitSAMenu;//要先初始化系统管理模块的下级菜单，因为首次登录系统时要使用初始化引导菜单
  //解决功能树方式下，自定义报表不显示的问题 Added by chengjf 2015-04-13 15:06:55
  if not NFDMenu.Checked then
    INitAQRMenu;

  if GpsSeries <> psR9 then
     InitMyNode;
  SetFuncTreeIcon;
end;

procedure TFormMain.InitFunTreeNode;
var
  i, j: Integer;
  sSQL: string; //MenuItem,MenuItemParent:TMenuItem;
  sFuncName, sGNCode, szModeCode: string;

  HashMenuList: THashedStringList;

  procedure AddQuitMenu(AParentMenu: TMenuItem); //创建退出菜单
  var
    TempMenu: TMenuItem;
  begin
    TempMenu := TMenuItem.Create(AParentMenu);
    TempMenu.Caption := '-';
    AParentMenu.Add(TempMenu);

    TempMenu := TMenuItem.Create(AParentMenu);
    TempMenu.Action := ActExit;
    //TempMenu.Caption := '-';    TempMenu.OnClick:= MenuClick;    //TempMenu.ShortCut := TextToShortCut(sShortCut);
    AParentMenu.Add(TempMenu);
    TempMenu.Tag := -1;
  end;

  procedure AddMenu(AParentMenu: TMenuItem; Node: TTreeNode);
  var
    TempMenu: TMenuItem;
    i: Integer;
    sShortCut: string;
  begin
    //szCaption := Node.Caption; ipos := Pos('(', szCaption); if ipos > 0 then  szCaption := copy(szCaption, 1, iPos - 1);
    //if GCzy.ID <> 1 then begin //系统管理员默认有所有权限
    //hch 需要判断非末级菜单的权限 //if not Node.HasChildren then  begin

    if (Node.Data <> nil) and (not PTreeRec(Node.Data)^.bVisible) then //不可见，则不创建菜单
        Exit;

    TempMenu := TMenuItem.Create(AParentMenu);
    TempMenu.Caption := Node.Text + ' ';
    TempMenu.OnClick := MenuClick;
    try
      if (not IsAQRNode(Node)) and (Node.Data <> nil) then
      begin
        sShortCut := UpperCase(Trim(PTreeRec(Node.Data)^.sShortCut));
        if sShortCut <> '' then
          TempMenu.ShortCut := TextToShortCut(sShortCut);
      end;
      TempMenu.Tag := Node.AbsoluteIndex;
    except
    end;
    AParentMenu.Add(TempMenu);

    for i := 0 to Node.Count - 1 do
    begin
      if Node.Item[i].Level = Node.Level + 1 then
        AddMenu(TempMenu, Node.Item[i]);
    end;
  end;

  procedure AddMenuEx(Node: TTreeNode);
  var
    TempMenu, ParentMenu: TMenuItem;
    sMenuCode, sParentCode: string;
    i: Integer;
    sShortCut: string;
  begin
    if (Node.Data = nil) or (not PTreeRec(Node.Data)^.bVisible) then
      Exit;

    TempMenu := TMenuItem.Create(NGNFL);
    TempMenu.Caption := Node.Text + ' ';
    TempMenu.OnClick := MenuClick;
    try
      if (not IsAQRNode(Node)) and (Node.Data <> nil) then
      begin
        sShortCut := UpperCase(Trim(PTreeRec(Node.Data)^.sShortCut));
        if sShortCut <> '' then
          TempMenu.ShortCut := TextToShortCut(sShortCut);
      end;
      TempMenu.Tag := Node.AbsoluteIndex;
    except
    end;

    // 按菜单级次代码查找菜单父节点
    sMenuCode := PTreeRec(Node.Data)^.sMenuCode;
    sParentCode := Copy(sMenuCode, 1, Length(sMenuCode) - 2);
    i := HashMenuList.IndexOf(sParentCode);
    if (i >= 0) then
      ParentMenu := TMenuItem(HashMenuList.Objects[i])
    else
      ParentMenu := NGNFL;
    ParentMenu.Add(TempMenu);
    HashMenuList.AddObject(sMenuCode, TempMenu);

  end;

begin
  {
  sGNFL_Ver:='';
  sVercodeSQL := '';
  if GszRelease='政府财务' then
     sGNFL_Ver:=',ZF_'+GszEdition+','
  else if GszRelease='卫生财务' then
     sGNFL_Ver:=',WS_'+GszEdition+',';
           
  if GDbType=oracle then begin
     if sGNFL_Ver<>'' then
        sVercodeSQL := sVercodeSQL+' and (instr(Vercode,'''+sGNFL_Ver+''')>0 or rtrim(Vercode)='''' or Vercode is null)'
  end else begin
     if sGNFL_Ver<>'' then
        sVercodeSQL := sVercodeSQL+' and (charindex('''+sGNFL_Ver+''',Vercode)>0 or rtrim(Vercode)='''' or Vercode is null)'
  end;

  if sGNFL_Ver<>'' then
     sVercodeSQL := sVercodeSQL+' and (rtrim(Vercode)='''' or vercode like ''%'+sGNFL_Ver+'%'' or Vercode is null)';
  }
   
  //fuxj 20110418 为了能够按照modcaption排序，特定将SA、BAS的modcaption分别设置为000001,000002
  sSQL := 'select GL_GNFL.*,''000001'' modcaption  from GL_GNFL where (modcode=''SA'') ';
  if GszHSDWDM = '' then //=''时只显示系统管理
  else
  begin
    sSQL := sSQL +
         ' union ' +
         //fuxj 20110418 对基础资料部分功能是否显示进行控制，控制规则：
         //CPBBDM字段为空的表示该功能不受控制
         //CPBBDM字段不为空的表示该功能只有当前单位启用了对应的模块时才显示
         'select distinct GL_GNFL.*,''000002'' modcaption from GL_GNFL,(select modname from pubmodsetup where pubmodsetup.gsdm=''' + Gszgsdm +
         ''' and pubmodsetup.isstart=1) pubmodsetup ' +
         'where (modcode=''BAS'') and ((CPBBDM is null) or (CPBBDM='''') or charindex('',''' + GSQLStrADDChar +
         'pubmodsetup.modname' + GSQLStrADDChar + ''','',CPBBDM)>0) '+
         ' union ' +
         'select GL_GNFL.*,pubmodsetup.modcaption from GL_GNFL,pubmodsetup where GL_GNFL.modcode=pubmodsetup.modName ' +
         'and pubmodsetup.gsdm=''' + Gszgsdm + ''' and pubmodsetup.isstart=1 and pubmodsetup.modname<>''SA''';
    if GszZth = '' then
      sSQL := sSQL + ' and GL_GNFL.modcode<>''GL'' and GL_GNFL.modcode<>''GAL'' and GL_GNFL.modcode<>''FAQC'' and GL_GNFL.modcode<>''CM''';
  end;
  //排序增加MenuCode，解决审计接口在树形菜单方式下不显示的问题，
  //因为先加载7401，再加载74，会造成74的hasChild属性为false，后面会删除这样的节点。 Modified by chengjf 2014-09-29
  sSQL := ' select * from (' + sSQL + ' ) a order by modcaption,MenuCode '; //fuxj 20110418修改，模块按照系统管理中启用模块的顺序显示

  POpenSql(DataModulePub.ClientDataSetTmp, sSQL);
  with DataModulePub.ClientDataSetTmp do
  begin
    if Recordcount <= 0 then
      Exit;
    CreateMenuTree(TreeViewFunc, DataModulePub.ClientDataSetTmp, True, False);
  end;

  if Assigned(GAnyiLicenseInfo) then
  begin //设置演示版菜单
    for i := TreeViewFunc.Items.Count - 1 downto 0 do
    begin
      if TreeViewFunc.Items[i].Level <> 0 then
        Continue;

      // 崔立国 2011.04.18 如果当前模块是演示版，则在菜单盒上显示演示版字样。
      sFuncName := TreeViewFunc.Items[i].Text;
      szModeCode := PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode;
      if (*(sFuncName <> '会计平台') and*) (sFuncName <> '系统管理') and (sFuncName <> '基础数据管理') and (szModeCode <> 'RMIS') then
      begin
        if GAnyiLicenseInfo.ProductExists(GetGszAnyiByModeName(PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode)) or (GNOJMVer_CusName<>'')  then
        begin
          PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := False;
        end
        else
        begin
          PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := True;
          TreeViewFunc.Items[i].Text := TreeViewFunc.Items[i].Text + '[演示版]';
          //add by chengjf 20150811 增加演示版是否显示控制
          if GblDemoNotVisible = 1 then
            TreeViewFunc.Items[i].delete;
        end;
      end
      else
        PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := False;
    end;
  end;

  //if (sModCode = 'AQR') then
  //begin
  //  TfrmRptCaller.GetRepTreeByUnitCode(TreeViewFunc, GszGSDM, '1'); 不受权限控制
  //end;

  {创建决策支持分析系统}
  //if (sModCode = 'MIDS') then
  //begin
    //GetMIDSTree(TreeViewFunc);
  //end;

  {创建预算执行分析菜单}
  //if (sModCode = 'BKA') then
  //begin
    GetBKATree(TreeViewFunc);
  //end;

  {创建分级预警菜单}
  //if (sModCode = 'GE') then
  //begin
    GetGETree(TreeViewFunc);
  //end;



  try
    HideMenu.InitFastTree(GszGSDM, GszKJND,TreeViewFunc);
  except
  end;
  InitTreeQXKZ; //设置权限

  try
    if GszGSDM <> '' then //Pub_ExterialFun表的内容
    begin
      {点击菜单之前，BeforeAPT调用该方法处理逻辑}
      TPlugDev.InitInvokeTree(Self, TreeViewFunc, BeforeAPT, True); //初始化菜单按钮
    end;
  except
  end;

  //hch 隐藏不必要的菜单， 通过HideMenu类查找隐藏
  if not NFDMenu.Checked then
  begin
    THideMenu.IsHide(GszGSDM, GszKJND, '');
    for i := TreeViewFunc.Items.Count-1 downto 0 do
    begin
      if TreeViewFunc.Items[i].Data <> nil then
      begin
        sGNCode := PTreeRec(TreeViewFunc.Items[i].Data)^.sMenuCode;
        if not PTreeRec(TreeViewFunc.Items[i].Data)^.bVisible then
          TreeViewFunc.Items[i].Delete
        else if HideMenu.FHideList.IndexOfName(sGNCode)>=0 then
        begin
          if not TreeViewFunc.Items[i].HasChildren then
            TreeViewFunc.Items[i].Delete;
        end
        else
        begin
          //删除非末级节点中不包括的节点数据处理
          if (TreeViewFunc.Items[i].Level < 2) and not TreeViewFunc.Items[i].HasChildren then
            TreeViewFunc.Items[i].Delete;
        end;
      end;
    end;
  end;
  
  {创建网上报销菜单}
  //if (sModCode = 'OER') then
  //begin
  //end;
  GetOERDJLX(TreeViewFunc);
  GetFDADJLX(TreeViewMyFunc);
  //创建菜单
  HashMenuList := THashedStringList.Create;
  try
    NGNFL.Clear;
    for i := 0 to TreeViewFunc.Items.Count - 1 do
    begin
      // 崔立国 2011.08.23 为提高创建菜单速度，注释下面两行。
      // if (TreeViewFunc.Items[i].Level = 0) then
      //   AddMenu(NGNFL, TreeViewFunc.Items[i]);
      AddMenuEx(TreeViewFunc.Items[i]);
    end;
    AddQuitMenu(NGNFL); //创建退出菜单
  finally
    HashMenuList.Free;
  end;




end;

procedure TFormMain.InitModTreeNode; // 创建前台模块菜单根节点
var
  i, j: Integer;
  sSQL: string;
  sFuncName,szModeCode: string;
  HashMenuList: THashedStringList;
  sFuncLength: string;

  procedure AddQuitMenu(AParentMenu: TMenuItem); //创建退出菜单
  var
    TempMenu: TMenuItem;
  begin
    TempMenu := TMenuItem.Create(AParentMenu);
    TempMenu.Caption := '-';
    AParentMenu.Add(TempMenu);

    TempMenu := TMenuItem.Create(AParentMenu);
    TempMenu.Action := ActExit;
    AParentMenu.Add(TempMenu);
    TempMenu.Tag := -1;
  end;

  procedure AddMenuEx(Node: TTreeNode);
  var
    TempMenu, ParentMenu: TMenuItem;
    sMenuCode, sParentCode: string;
    i: Integer;
    sShortCut: string;
  begin
    if (Node.Data = nil) or (not PTreeRec(Node.Data)^.bVisible) then
      Exit;

    sMenuCode := PTreeRec(Node.Data)^.sMenuCode;
    if (HashMenuList.IndexOf(sMenuCode) >= 0) then Exit;

    TempMenu := TMenuItem.Create(NGNFL);
    TempMenu.Caption := Node.Text + ' ';
    TempMenu.OnClick := MenuClick;
    try
      if (not IsAQRNode(Node)) and (Node.Data <> nil) then
      begin
        sShortCut := UpperCase(Trim(PTreeRec(Node.Data)^.sShortCut));
        if sShortCut <> '' then
          TempMenu.ShortCut := TextToShortCut(sShortCut);
      end;
      TempMenu.Tag := Node.AbsoluteIndex;
    except
    end;

    // 按菜单级次代码查找菜单父节点
    sParentCode := Copy(sMenuCode, 1, Length(sMenuCode) - 2);
    i := HashMenuList.IndexOf(sParentCode);
    if (i >= 0) then
      ParentMenu := TMenuItem(HashMenuList.Objects[i])
    else
      ParentMenu := NGNFL;
    ParentMenu.Add(TempMenu);
    HashMenuList.AddObject(sMenuCode, TempMenu);
  end;

  function FIndUseRole:Boolean;
  var
    ii:Integer;
  begin
    Result := False;
    //操作员没有角色给予提示，并不显示任何模块
    if not (CdsPower.Active and (CdsPower.RecordCount > 0)) then begin
      SysMessage('当前操作员没有任何功能权限.' + #13 + '请检查是否赋予了角色权限或所属角色是否配置了权限。', '_JG', [mbok]);
      for ii := 0 to TreeViewFunc.Items.Count - 1 do
        if TreeViewFunc.Items[ii].Data <> nil then
           PTreeRec(TreeViewFunc.Items[ii].Data)^.bVisible := False;
      Exit;
    end;    
    Result := True;    
  end;

begin
  if (GDBType = ORACLE) then
    sFuncLength := 'length'
  else
    sFuncLength := 'len';

  sSQL := 'select ''000001'' modcaption, GL_GNFL.* from GL_GNFL ' +
          ' where (modcode=''SA'') and ' + sFuncLength + '(menucode)=2 ';
          
  if  not ((GblManagerLimit=1) and (GCzy.ID=1)) then // zhengjy 2014-10-11 广西需求基础卫生版本，控制管理员权限限制：0表示不限制 1表示管理员只有"操作员管理"功能
  begin
    if (GszHSDWDM = '') then // GszHSDWDM=''时只显示系统管理模块
    else
    begin
      sSQL := sSQL +
           'union ' +
           //fuxj 20110418 对基础资料部分功能是否显示进行控制，控制规则：
           //CPBBDM字段为空的表示该功能不受控制
           //CPBBDM字段不为空的表示该功能只有当前单位启用了对应的模块时才显示
           'select distinct ''000002'' modcaption, GL_GNFL.* from GL_GNFL, ' +
           ' (select modname from pubmodsetup ' +
           ' where pubmodsetup.gsdm=''' + Gszgsdm + ''' ' +
           ' and pubmodsetup.isstart=1) pubmodsetup ' +
           ' where (modcode=''BAS'') and ((CPBBDM is null) or (CPBBDM='''') ' +
           ' or charindex('',''' + GSQLStrADDChar + ' pubmodsetup.modname' + GSQLStrADDChar + ''','',CPBBDM)>0) ' +
           ' and ' + sFuncLength + '(menucode)=2 ' + 
           'union ' +
           'select distinct pubmodsetup.modcaption, GL_GNFL.* from GL_GNFL, pubmodsetup ' +
           ' where GL_GNFL.modcode=pubmodsetup.modName and ' + sFuncLength + '(menucode)=2 ' +
           ' and pubmodsetup.gsdm=''' + Gszgsdm + ''' and pubmodsetup.isstart=1 and pubmodsetup.modname<>''SA''';
      if GszZth = '' then
        sSQL := sSQL + ' and GL_GNFL.modcode<>''GL'' and GL_GNFL.modcode<>''GAL'' and GL_GNFL.modcode<>''FAQC'' and GL_GNFL.modcode<>''CM''';
    end;
  end;
  // 崔立国 2011.12.06 为浮动菜单的模块列表增加权限控制过滤
  sSQL := 'select a.* from (' + sSQL + ') a where a.gnfldm in ' +
          ' (select distinct substring(b.gnfldm, 1, 2) gnfldm from ' +
          ' (' + GetPowerSql(GCzy.ID) + ') b ) ' +
          ' order by modcaption '; //fuxj 20110418修改，模块按照系统管理中启用模块的顺序显示

  POpenSql(DataModulePub.ClientDataSetTmp, sSQL);
  with DataModulePub.ClientDataSetTmp do
  begin
    if Recordcount <= 0 then begin
       FIndUseRole; //没有角色权限，不显示模块菜单
       //Exit;
    end;
    CreateMenuTree(TreeViewFunc, DataModulePub.ClientDataSetTmp, True, True);
  end;

  if Assigned(GAnyiLicenseInfo) then
  begin //设置演示版菜单
    for i := TreeViewFunc.Items.Count - 1 downto 0 do
    begin
      if TreeViewFunc.Items[i].Level <> 0 then
        Continue;

      // 崔立国 2011.04.18 如果当前模块是演示版，则在菜单盒上显示演示版字样。
      sFuncName := TreeViewFunc.Items[i].Text;
      szModeCode := PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode;
      if (*(sFuncName <> '会计平台') and *) (sFuncName <> '系统管理') and (sFuncName <> '基础数据管理') and (sFuncName <> '项目管理')
        and (* (sFuncName <> '票据出入库') and (sFuncName <> '票据打印通') and (sFuncName <> '票据卡' )and *) (sFuncName <> '政府采购系统')
        and  (szModeCode <> 'RMIS') and (szModeCode <> 'SRM') and (Copy(szModeCode,1,3) <> 'UDF') then
      begin
        if GAnyiLicenseInfo.ProductExists(GetGszAnyiByModeName(PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode)) or (GNOJMVer_CusName<>'') then
        begin
          PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := False;
        end
        else
        begin
          PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := True;
          TreeViewFunc.Items[i].Text := TreeViewFunc.Items[i].Text + '[演示版]';
          //add by chengjf 20150811 增加演示版是否显示控制
          if GblDemoNotVisible = 1 then
            TreeViewFunc.Items[i].delete;
        end;
      end
      else
        PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := False;
    end;
  end;

  //创建菜单
  HashMenuList := THashedStringList.Create;
  try
    NGNFL.Clear;
    for i := 0 to TreeViewFunc.Items.Count - 1 do
    begin
      // 崔立国 2011.08.23 为提高创建菜单速度，注释下面两行。
      // if (TreeViewFunc.Items[i].Level = 0) then
      //   AddMenu(NGNFL, TreeViewFunc.Items[i]);
      AddMenuEx(TreeViewFunc.Items[i]);
    end;
    AddQuitMenu(NGNFL); //创建退出菜单
  finally
    HashMenuList.Free;
  end;

  // 崔立国 2011.10.30 THideMenu.Refresh 从 InitTreeQXKZ() 函数移到初始化模块列表时执行。
  
  //if not FIndUseRole then  //没有角色权限，不显示模块菜单
  //   Exit;
end;

procedure TFormMain.InitModSubTreeNodeAndMenuBox(ANode: TTreeNode);
begin
  if (ANode <> nil) and (not PTreeRec(ANode.Data)^.bSubMenuCreated) then
  begin
    InitSubFuncTreeNode(ANode);
    PTreeRec(ANode.Data)^.bSubMenuCreated := True;
    ReActiveXPMenu;
    FMenuBox.RefreshMenus;
  end;
end;

procedure TFormMain.InitSubFuncTreeNode(ANode: TTreeNode);
var
  i, j: Integer;
  sSQL: string;
  sModCode, sFuncName: string;
  HashMenuList: THashedStringList;

  procedure AddMenu(AParentMenu: TMenuItem; Node: TTreeNode);
  var
    TempMenu: TMenuItem;
    i: Integer;
    sShortCut: string;
  begin
    if (Node.Data <> nil) and (not PTreeRec(Node.Data)^.bVisible) then //不可见，则不创建菜单
        Exit;

    TempMenu := TMenuItem.Create(AParentMenu);
    TempMenu.Caption := Node.Text + ' ';
    TempMenu.OnClick := MenuClick;
    try
      if (not IsAQRNode(Node)) and (Node.Data <> nil) then
      begin
        sShortCut := UpperCase(Trim(PTreeRec(Node.Data)^.sShortCut));
        if sShortCut <> '' then
          TempMenu.ShortCut := TextToShortCut(sShortCut);
      end;
      TempMenu.Tag := Node.AbsoluteIndex;
    except
    end;
    AParentMenu.Add(TempMenu);

    for i := 0 to Node.Count - 1 do
    begin
      if Node.Item[i].Level = Node.Level + 1 then
        AddMenu(TempMenu, Node.Item[i]);
    end;
  end;

  procedure AddMenuEx(Node: TTreeNode);
  var
    TempMenu, ParentMenu: TMenuItem;
    sMenuCode, sParentCode: string;
    i: Integer;
    sShortCut: string;
  begin
    if (Node.Data = nil) or (not PTreeRec(Node.Data)^.bVisible) then
      Exit;

    sMenuCode := PTreeRec(Node.Data)^.sMenuCode;
    if (HashMenuList.IndexOf(sMenuCode) >= 0) then Exit;

    TempMenu := TMenuItem.Create(NGNFL);
    TempMenu.Caption := Node.Text + ' ';
    TempMenu.OnClick := MenuClick;
    try
      if (not IsAQRNode(Node)) and (Node.Data <> nil) then
      begin
        sShortCut := UpperCase(Trim(PTreeRec(Node.Data)^.sShortCut));
        if sShortCut <> '' then
          TempMenu.ShortCut := TextToShortCut(sShortCut);
      end;
      TempMenu.Tag := Node.AbsoluteIndex;
    except
    end;

    // 按菜单级次代码查找菜单父节点
    sParentCode := Copy(sMenuCode, 1, Length(sMenuCode) - 2);
    i := HashMenuList.IndexOf(sParentCode);
    if (i >= 0) then
      ParentMenu := TMenuItem(HashMenuList.Objects[i])
    else
      ParentMenu := NGNFL;
    ParentMenu.Add(TempMenu);
    HashMenuList.AddObject(sMenuCode, TempMenu);
  end;

  procedure RemoveAPTMenu;
  var
    i: integer;
    AMenuItem: TMenuItem;
  begin
    AMenuItem := nil;

    for i := 0 to MainMenu.Items.Count - 1 do
    begin
      if MainMenu.Items[i].Find('会计平台 ') <> nil then
      begin
        AMenuItem := MainMenu.Items[i].Find('会计平台 ');
        break;
      end;
    end;

    if AMenuItem <> nil then
    begin
      for i:=AMenuItem.Count-1 downto 0 do
      begin
        if AMenuItem.Items[i].Count =0 then
          AMenuItem.Items[i].Free;   
      end;
      if AMenuItem.Count = 0 then AMenuItem.Free;
    end;
  end;  

begin
  if (ANode = nil) or (ANode.Data = nil) then Exit;

  sModCode := PTreeRec(ANode.Data)^.sModCode;

  if (sModCode = 'SA') then
  begin
    //zhengjy 2014-10-11 广西需求基础卫生版本，控制系统管理员显示的菜单内容
    if (GblManagerLimit=1) and (GCzy.ID=1) then
      sSQL := 'select ''000001'' modcaption, GL_GNFL.* from GL_GNFL ' +
            ' where (modcode=''SA'') and MENUCODE IN (''00'',''0001'',''000109'',''0002'',''000205'')  '
    else
      sSQL := 'select ''000001'' modcaption, GL_GNFL.* from GL_GNFL ' +
            ' where (modcode=''SA'')  ';
  end
  else if (sModCode = 'BAS') then // GszHSDWDM=''时只显示系统管理模块
  begin
         //fuxj 20110418 对基础资料部分功能是否显示进行控制，控制规则：
         //CPBBDM字段为空的表示该功能不受控制
         //CPBBDM字段不为空的表示该功能只有当前单位启用了对应的模块时才显示
    sSQL := 'select distinct ''000002'' modcaption, GL_GNFL.* from GL_GNFL, ' +
         ' (select modname from pubmodsetup ' +
         ' where pubmodsetup.gsdm=''' + Gszgsdm + ''' ' +
         ' and pubmodsetup.isstart=1) pubmodsetup ' +
         ' where (modcode=''BAS'') and ((CPBBDM is null) or (CPBBDM='''') ' +
         ' or charindex('',''' + GSQLStrADDChar + ' pubmodsetup.modname' + GSQLStrADDChar + ''','',CPBBDM)>0) ';
  end
  else
  begin
    sSQL := 'select distinct pubmodsetup.modcaption, GL_GNFL.* from GL_GNFL, pubmodsetup ' +
         ' where GL_GNFL.modcode=pubmodsetup.modName ' +
         ' and pubmodsetup.gsdm=''' + Gszgsdm + ''' and pubmodsetup.isstart=1 and pubmodsetup.modname=''' + sModCode + '''';
    if GszZth = '' then
      sSQL := sSQL + ' and GL_GNFL.modcode<>''GL'' and GL_GNFL.modcode<>''GAL'' and GL_GNFL.modcode<>''FAQC'' and GL_GNFL.modcode<>''CM''';
  end;
  sSQL := sSQL + ' order by menucode, modcaption '; //fuxj 20110418修改，模块按照系统管理中启用模块的顺序显示

  POpenSql(DataModulePub.ClientDataSetTmp, sSQL);
  if DataModulePub.ClientDataSetTmp.Recordcount <= 0 then Exit;

  CreateMenuTree(TreeViewFunc, DataModulePub.ClientDataSetTmp, False, True);

  if (sModCode = 'AQR') then
  begin
    TfrmRptCaller.GetRepTreeByUnitCode(TreeViewFunc, GszGSDM, '1');
  end;

  {创建决策支持分析系统}
  if (sModCode = 'MIDS') then
  begin
    GetMIDSTree(TreeViewFunc);
  end;

  {创建预算执行分析菜单}
  if (sModCode = 'BKA') then
  begin
    GetBKATree(TreeViewFunc);
  end;

  {创建分级预警菜单}
  if (sModCode = 'GE') then
  begin
    GetGETree(TreeViewFunc);
  end;

  {创建网上报销菜单}
  if (sModCode = 'OER') then
  begin
    GetOERDJLX(TreeViewFunc);
  end;
  if (sModCode ='GSP')  then
  begin
    GetFDADJLX(TreeViewFunc);
  end;
  HideMenu.InitFast(GszGSDM, GszKJND,sModCode);

  InitTreeQXKZ; //设置权限

  //创建菜单
  HashMenuList := THashedStringList.Create;
  try
    NGNFL.Clear;
    for i := 0 to TreeViewFunc.Items.Count - 1 do
    begin
      if (TreeViewFunc.Items[i].Level = 0) then
        AddMenu(NGNFL, TreeViewFunc.Items[i]);
    end;
  finally
    HashMenuList.Free;
  end;

  // 崔立国 2011.11.01 由于会计平台之类的插件是直接向MainMenu添加菜单，
  // 所以必须放在主菜单（MainMenu）从菜单树（MenuTree）更新完成之后！！！
  // 注意：即便不是初始化APT模块，也要添加APT模块功能菜单。原因同上。
  {if (sModCode = 'APT') then}
  begin
    //注销所有资源，然后重新登陆后进行初始化
    //2009-4-15 导入Exe的插件应用
    try
      if NFDMenu.Checked then
      begin
        if GszGSDM <> '' then
        begin
          //RemoveAPTMenu;
          {点击菜单之前，BeforeAPT调用该方法处理逻辑}
          TPlugDev.InitInvokeMenu(Self, MainMenu, BeforeAPT, True); //初始化菜单按钮
        end;
      end;
      {处理APT菜单}
      // 崔立国 2011.11.01 为了适应登录优化后的菜单处理逻辑，暂时屏蔽"会计平台"处理代码。
      // RemoveAPTMenu;
    except
    end;
  end;

end;

procedure TFormMain.PRegNC(AMenuItem: TMenuItem);
var
  CurCount: Integer;
  CurMenuIndex: Integer;
  iMax: Integer; //自动记忆最大个数
  FMenuItem: TMenuItem;
begin
  iMax := 6;
  CurCount := FOrgMenuItem.Count;

  if FOrgMenuItem.Count = 0 then
  begin
    FOrgMenuItem.AddObject(AMenuItem.name, AMenuItem);
  end
  else
  begin
    CurMenuIndex := FOrgMenuItem.IndexOf(AMenuItem.name);
    //FindMenuItem('His_'+AMenuItem.Name );   //FOrgMenuItem.IndexOf (AMenuItem);
    if CurMenuIndex < 0 then
    begin
      FOrgMenuItem.InsertObject(0, AMenuItem.name, AMenuItem);
    end
    else
    begin
      FOrgMenuItem.delete(CurMenuIndex);
      FOrgMenuItem.InsertObject(0, AMenuItem.name, AMenuItem);
    end;
    while FOrgMenuItem.Count > iMax do
    begin
      FOrgMenuItem.Delete(FOrgMenuItem.count - 1);
    end;
  end;

  // ToolBarMainMenu.ClearTempMenu;
  XPMenu1.Active := False;
  XPMenu1.Active := True;
end;

function TFormMain.MenuOnClick(AMenuItem: TMenuItem; ItemText, ParentText: string): Boolean;
var
  i, iPos: Integer;
  sItem, sParent: string;
begin
  Result := False;
  if AMenuItem = nil then
    Exit;

  if AMenuItem.Count > 0 then
  begin
    for i := 0 to AMenuItem.Count - 1 do
    begin
      if MenuOnClick(AMenuItem.Items[i], ItemText, ParentText) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end
  else
  begin
    sItem := AMenuItem.Caption;
    if AMenuItem.HasParent then
      sParent := AMenuItem.Parent.Caption;
    if ParentText = '' then
      sParent := '';
    iPos := Pos('(', sItem);
    if iPos > 0 then
    begin
      sItem := Copy(sItem, 1, ipos - 1);
    end;
    sItem := StringReplace(sItem, '&', '', [rfReplaceAll]);

    iPos := Pos('(', sParent);
    if iPos > 0 then
    begin
      sParent := Copy(sParent, 1, ipos - 1);
    end;
    sParent := StringReplace(sParent, '&', '', [rfReplaceAll]);

    if (sItem = ItemText) and (sParent = ParentText) then
    begin
      if (AMenuItem.Enabled = False) or (AMenuItem.Visible = False) then
      begin
        SysMessage('您没有该功能的操作权限！', '', [mbOk]);
        Exit;
      end;
      AMenuItem.Click;
      Result := True;
      Exit;
    end;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  szSingleClick: string;
  FilePath:string;
  iVD: Integer;
begin
  //zhengjy 20140717 采用数据流方式通讯
  FilePath :=ExtractFilePath(Application.ExeName)+'_HTTP_CDS_';
  if not FileExists(FilePath) then mniBinaryGet.Checked :=false
  else mniBinaryGet.Checked :=true;

  TimerDBSY.Enabled := False;
  AnyiClient1 := TAnyiClient.Create(nil); //用于测试，及录入加密地址用的
  rMainSub.GAnyiClient := AnyiClient1;

  Global_PriMode := nil;
  rMainSub.GiReLogin := 0;
  rMainSub.GsStartModName := '';
  rMainSub.GsCurModName := '';
  rMainSub.GsPriModName := '';
  rMainSub.GListAnyiClient := TstringList.Create;
  //rMainSub.bFreeBpl:=False;  //rMainSub.bRelogin:=False;

  FWinCaptionDrawing := False;
  XPMenu1.AutoDetect := True;
  XPMenu1.Gradient := True;
  XPMenu1.SelectBorderColor := GiSelectBorderColor;
  XPMenu1.SelectColor := GiSelectColor;
  XPMenu1.IconBackColor := GFormBackgroundColor;
  XPMenu1.UseSystemColors := False;
  XPMenu1.MenuBarColor := clBtnFace;
  XPMenu1.MenuOnly := False;

  if not Assigned(FslUIR9_IMPL) then
    FslUIR9_IMPL := TslUIR9_IMPL.Create(ExtractFileDir(Application.ExeName) + '\');

{$IFDEF ocx}
  image5.Visible := False;
  // 2007-5-21 14:27 hch 网页中无法显示窗体菜单
  Self.WindowMenu := nil;
{$ENDIF}
  OtherProStringList := TStringList.Create;
  FOrgMenuItem := TStringList.Create;
  Application.OnException := AppException;

  PRegReadS('\SOFTWARE\UFGOV\'+GsProductID+'\Main', 'SingleClick', szSingleClick);
  ActEnableClick.Checked := (szSingleClick = '1');

  ShortDateFormat := 'yyyy-mm-dd';
  DateSeparator := '-'; // 崔立国 2009.06.26

  //20050614 R96 子窗口列表  zhouyunlu
  FWndList := TMDIChildList.Create(self);
  FWndList.Parent := PanelLeftBox;
  FWndList.Align := alBottom;
  FWndList.Top := 100;
  FWndList.Height := 35;
  FWndList.MaxHeight := 140;
  FWndList.ImageList := ImageListFolderBlue;
  FWndList.ImageIndex := 8;
  FWndList.SelectedIndex := 8;
  WindowsList.GWinBarBmp.Assign(ImageWinBar.Picture.Bitmap);
  WindowsList.GWinBarHotBmp.Assign(ImageWinBarHot.Picture.Bitmap);
  FWndList.MDIMain := Self; //self
  FWndList.VertScrollBarStyle := ssRegular;
  FWndList.PopupMenu := PopupMenuWinList;
  FWndList.ParentColor := True;
  FWndList.SelectedColor := $00E7E3DE; //$00DDC4B4;
  FWndList.ItemColor := $00E9E9E9; //$00EEE1D9;
  FWndList.ItemHeight := WindowsList.GWinBarBmp.Height - 8;
  FWndList.OnPopupMenu := onPopup;

  MIChangeUnit.Visible := GpsSeries = psR9i;
  NDWZT.Visible := GpsSeries = psR9i;
  // 崔立国 2009.02.26 必须先关闭 TimerDemo ，否则用户即便连上加密，如果15分钟内不登录也会有“演示版”提示框。
  TimerDemo.Enabled := False;
  //2009.4.7 hy Oracle版屏蔽HR
//  if GDbType=ORACLE then
  ActHRSynInit.Visible := False;

  TreeViewFunc.DoubleBuffered := True;
  TreeViewMyFunc.DoubleBuffered := True;

  {功能导航}
  Label4.Caption := '  功能导航';
  FMenuBox := TMenuBox.Create(self);
  FMenuBox.Align := alClient;
  FMenuBox.Parent := PanelFunc;
  FMenuBox.Color := GMenuButtonColor;
  FMenuBox.MenuButtonHeight := 28;
  FMenuBox.AlphaBlend := 240;
  FMenuBox.AlphaBlendEnabled := (Win32MajorVersion > 5) or ((Win32MajorVersion = 5) and (Win32MinorVersion > 0));

  FMenuBox.UpDownEnabled := True;
  {hch 实现建立桌面快捷方式}
  FMenuBox.OnCreateDesktopMenuIcon := CreateDesktopMenuClick;
  FMenuBox.OnShowMenuPanel := ShowMenuPanel;
  {代办工作}
  FDailyWorkMenu := TMenuBox.Create(self);
  FDailyWorkMenu.Align := alClient;
  FDailyWorkMenu.Parent := PanelMyFunc;
  FDailyWorkMenu.MenuPanelWidth := 530;
  FDailyWorkMenu.Color := GMenuButtonColor;
  FDailyWorkMenu.MenuButtonHeight := 28;
  FDailyWorkMenu.AlphaBlend := 240;

  FDailyWorkMenu.AlphaBlendEnabled := (Win32MajorVersion > 5) or ((Win32MajorVersion = 5) and (Win32MinorVersion > 0));

  FDailyWorkMenu.UpDownEnabled := False;
  FDailyWorkMenu.OtherMenuButtons := [mbCalendar];
  {hch 下载过程显示}
  GCUProgress := PgOnProgress;
  //zhengjy 2014-10-11 广西需求基础卫生版本，锁屏通数
  Application.OnMessage :=OnMyMessage;
end;

procedure TFormMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
  szSelfFuncList: string;
begin
  try
    if Assigned(FMyFuncRoot) then
    begin
      for i := 0 to FMyFuncRoot.Count - 1 do
        szSelfFuncList := szSelfFuncList + FMyFuncRoot.Item[i].text + ',';
      szSelfFuncList := copy(szSelfFuncList, 1, length(szSelfFuncList) - 1);
      PRegWriteS('\SOFTWARE\UFGOV\'+GsProductID+'\Main\SelfFuncList', GProSign, szSelfFuncList);
    end;
  except 
  end;
end;

procedure TFormMain.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  {$IFNDEF ocx}
    if SysMessage('您确定退出系统吗？', '_XW', [mbYes, mbNo]) <> mrYes then
      CanClose := False;
  {$ELSE}
    CanClose := True;
  {$ENDIF}
  try
    //zhengjy 2014-10-11 广西需求基础卫生版本,退出删除用户状态
    TControlLogin.DelOperState(IntToStr(GCzy.ID));  
    // 退出程序前先要关闭远程连接
    if CanClose then
     DataModulePub.MidasConnectionPub.Connected := False;
     //zhengjy 20161213 释放Key对象
    // KeyFactroy :=nil;
  except
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  try
    rMainSub.GListAnyiClient.Free;
    AnyiClient1.Free;
    TPlugDev.FreeInvoke;
    OtherProStringList.Free;
    FOrgMenuItem.Free;
    FreeAndNil(FMyFuncRoot);
    FreeAndNil(OtherProNode);
  except
  end;
  try //释放菜单指针
    for i := 0 to TreeViewFunc.Items.Count - 1 do
      if TreeViewFunc.Items[i].Data <> nil then
        Dispose(TreeViewFunc.Items[i].Data);
  except
  end;

  try //释放菜单指针
    for i := 0 to TreeViewMYFunc.Items.Count - 1 do
      if TreeViewMYFunc.Items[i].Data <> nil then
        Dispose(TreeViewMYFunc.Items[i].Data);
  except
  end;

  try
    if Assigned(Self.FslUIR9_IMPL) then
      FreeAndNil(FslUIR9_IMPL);
    Global_PriMode := nil;
  except
  end;
  TerminateProcess(GetCurrentProcess,0);  //zhengjy 20140523 调用预算执行系统后，解决退出报错的问题。
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  //RefreshBG;
  Invalidate;
  // 崔立国 2009.10.26 解决在某些机器上主窗体不能正确处理重画的消息，导致不能登录的问题。
  // 上述故障原因不明，现场测试增加 ProcessMessages() 方法调用可以解决这个原因不明的Bug。
  //Application.ProcessMessages;
end;

procedure TFormMain.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  // 崔立国 2010.05.10 处理子窗体菜单快捷键
  if (ActiveMDIChild <> nil) and (ActiveMDIChild.Menu <> nil) and
    (ActiveMDIChild.Menu.IsShortCut(Msg)) then
  begin
    Handled := True;
  end
  else
  begin
    if MainMenu.IsShortCut(Msg) then
      Handled := True;
  end;
end;

function TFormMain.GetClickMenuItemByHint(AHint: string): TMenuItem;
begin
  Result := TMenuItem(FindComponent(AHint));
end;

procedure TFormMain.MPreViouschildClick(Sender: TObject);
begin
  Previous;
  if ActiveMDIChild is TFormBackGround then
  begin
    ActiveMDIChild.SendToBack;
    Previous;
  end;
  ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TFormMain.MNextChildClick(Sender: TObject);
begin
  Next;
  if ActiveMDIChild is TFormBackGround then
  begin
    ActiveMDIChild.SendToBack;
    Next;
  end;
  ActiveMDIChild.WindowState := wsMaximized;
end;

procedure TFormMain.MCloseAllChildClick(Sender: TObject);
var
  i: Integer;
begin
  if (MDIChildCount > 1) then
  begin
    if SysMessage('所有打开的窗口都将关闭，是否继续？', '', [mbOK, mbCancel]) = mrOk then
    begin
      for i := MDIChildCount - 1 downto 0 do
      begin
        if (MDIChildren[i] <> nil) and
          (not (MDIChildren[i] is TFormBackGround)) then
          MDIChildren[i].Close;
      end;
    end;
  end;
end;

procedure TFormMain.TreeViewFuncCollapsed(Sender: TObject;
  Node: TTreeNode);
begin
  Node.ImageIndex := 0;
  Node.SelectedIndex := 0;
end;

procedure TFormMain.TreeViewFuncExpanded(Sender: TObject;
  Node: TTreeNode);
begin
  Node.ImageIndex := 1;
  Node.SelectedIndex := 1;
end;

procedure TFormMain.ActEnableClickExecute(Sender: TObject);
begin
  ActEnableClick.Checked := not ActEnableClick.Checked;
  if ActEnableClick.Checked then
    PRegWriteS('\SOFTWARE\UFGOV\'+GsProductID+'\Main', 'SingleClick', '1')
  else
    PRegWriteS('\SOFTWARE\UFGOV\'+GsProductID+'\Main', 'SingleClick', '0')
end;

procedure TFormMain.ActCloseChildExecute(Sender: TObject);
begin
  if not (ActiveMDIChild is TFormBackGround) then
    ActiveMDIChild.Close;
end;

procedure TFormMain.FuncTreeClick(ATreeView: TTreeView = nil);
var
  i, j, iPos: Integer;
  sParentText, sModeName, sGnflMc, sGnflExec: string; //sSelText,sCZY,sComm,sYWRQ,sGDbType: string;  //Comp: TComponent;
  CurNode: TTreeNode;
begin
  if ATreeView = nil then
    ATreeView := TreeViewFunc;
  CurNode := ATreeView.Selected;
  if CurNode = nil then
    Exit;
  if CurNode.HasChildren then
    Exit;

  if IsMIDSNode(CurNode) then begin
    try
      sModeName := pTreeRec(CurNode.Data)^.sModCode;
      sGnflMc := pTreeRec(CurNode.Data)^.sMenuCode;
      sGnflExec := pTreeRec(CurNode.Data)^.sGnflExec;
      FWndList.bMDICanUnLoad := True;
      LoadModeDll(sModeName, sGnflMc, sGnflExec);
      if rMainSub.GiReLogin=3 then begin  //强制重新登录
         rMainSub.GiReLogin:=0;
         ActLoginExecute(ActLogin);
      end;
    finally
    end;
  end
  else if not IsAQRNode(CurNode) and (CurNode.Data<>nil) and (pTreeRec(CurNode.Data)^.sGnScripts='APT') then
  begin
    //调用会计平台
    if NFDMenu.Checked then
         sCurAPTsGnflmc := pTreeRec(CurNode.Data)^.sGnflMc
    else sCurAPTsGnflmc := Trim(CurNode.Text);
    TPlugDev.InvokeExec((pTreeRec(CurNode.Data)^.sGnflExec));
  end
  else if not IsAQRNode(CurNode) then
  begin
    try
      sModeName := pTreeRec(CurNode.Data)^.sModCode;
      sGnflMc := pTreeRec(CurNode.Data)^.sGnflMc;
      sGnflExec := pTreeRec(CurNode.Data)^.sGnflExec;
      FWndList.bMDICanUnLoad := True;
      LoadModeDll(sModeName, sGnflMc, sGnflExec);
      if rMainSub.GiReLogin=3 then begin  //强制重新登录
         rMainSub.GiReLogin:=0;   
         ActLoginExecute(ActLogin);
      end;
      //LoadModeDll(sModeName,sCZY+';1;2011-02-27;111;111zt;000;000zt;127.0.0.1;211;0;Socket;MSSQL;;'+sGnflMc+';',sGnflMc);
    finally
      //ATreeView.Invalidate; 已看不到功能树了，特注释
    end;
  end
  else
  begin
    {hch 先写死,以后解决调用问题}
    if (CurNode.Text = '报表编制') then
    begin
      sModeName := pTreeRec(CurNode.Data)^.sModCode;
      sGnflMc := pTreeRec(CurNode.Data)^.sGnflMc;
      sGnflExec := pTreeRec(CurNode.Data)^.sGnflExec;
      LoadModeDll(sModeName, sGnflMc, sGnflExec);
      Exit;
    end;
    if not PReportTree(CurNode.Data)^.IsCata then
    begin
      if PReportTree(CurNode.Data)^.Rpt_Rt_Id <> 0 then
      begin
        LoadModeDll('AQR', IntToStr(PReportTree(CurNode.Data)^.Rpt_Rt_Id), '.CLL');
      end
    end;
  end;
end;

procedure TFormMain.TreeViewFuncDblClick(Sender: TObject);
begin
  if CanExecFunc and not ActEnableClick.Checked then
  begin
    if FLeftIsHide then
      ActLeftCloseExecute(nil);
    FuncTreeClick(TTreeView(Sender));
  end;
end;

procedure TFormMain.TreeViewFuncClick(Sender: TObject);
begin
  if CanExecFunc and ActEnableClick.Checked then
  begin
    if FLeftIsHide then
      ActLeftCloseExecute(nil);
    FuncTreeClick(TTreeView(Sender));
  end;
end;

procedure TFormMain.TreeViewFuncDragOver(Sender, Source: TObject;
  X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := False;
end;

procedure TFormMain.TreeViewFuncMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  HT: THitTests;
begin
  HT := TTreeView(Sender).GetHitTestInfoAt(X, Y);
  CanExecFunc := False;
  if (HT - [htOnItem, htOnIcon, htNowhere, htOnIndent] <> HT) then
  begin
    if (htOnItem in HT) or (htOnIcon in HT) then
      CanExecFunc := True;
  end;
end;

procedure TFormMain.TreeViewFuncChange(Sender: TObject;
  Node: TTreeNode);
begin
  ActDelMyFunc.Enabled := False;
  if (Node.Text <> MPreViouschild.Caption) and // 上一窗口
  (Node.Text <> MNextChild.Caption) and // 下一窗口
  (Node.Text <> MMyDesktop.Caption) then // 桌面
  begin
    ActDelMyFunc.Enabled := True;
  end;

  if (Node.Parent = FMyFuncRoot) or (Node.Count > 0) or
    (Node.Parent = OtherProNode) then
    ActAddMyFunc.Enabled := False
  else
    ActAddMyFunc.Enabled := True;

  ActEditOtherPro.Enabled := (Node = OtherProNode);
end;

procedure TFormMain.ActDelMyFuncExecute(Sender: TObject);
begin
  DelMyNode(TreeViewMyFunc.Selected);
end;

procedure TFormMain.ActAddMyFuncExecute(Sender: TObject);
begin
  if TreeViewFunc.Selected = nil then
    Exit;
  if CanAddMyNode then
    AddMyNode(TreeViewFunc.Selected);
end;

function TFormMain.CanAddMyNode: Boolean;
var
  i: Integer;
begin
  Result := False;
  if TreeViewFunc.Selected = nil then
    Exit;
  if TreeViewFunc.Selected.Count > 0 then
  begin
    Application.MessageBox('只能添加最末级功能到『收藏夹』。', '系统提示', MB_ICONInformation + MB_OK);
    Exit;
  end;

  if TreeViewFunc.Selected.Parent = OtherProNode then
    Exit;

  if FMyFuncRoot.Count >= 20 then
  begin
    Application.MessageBox('『收藏夹』已经达到上限（20个功能），如果想添加新的常用功能，请先删除不常用的旧功能。',
      '系统提示', MB_ICONInformation + MB_OK);
    Exit;
  end;

  Result := True;
  for i := 0 to FMyFuncRoot.Count - 1 do
  begin
    if FMyFuncRoot.Item[i].Text = TreeViewFunc.Selected.Text then
    begin
      Result := False;
      Exit;
    end;
  end;
end;

procedure TFormMain.AddMyNode(ANode: TTreeNode);
begin
  if ANode = nil then
    Exit;

  TreeViewMyFunc.Items.AddChild(FMyFuncRoot, ANode.Text);

  UpdateTreeViewMyFuncHeight;
  SetFuncTreeIcon;

  SaveMyFuncToDB;
end;

procedure TFormMain.DelMyNode(ANode: TTreeNode);
begin
  if ANode = nil then
    Exit;
  if ANode.Parent <> FMyFuncRoot then
    Exit;

  if Anode.Text = MMyDesktop.Caption then
    Exit; // 桌面

  if ANode.Count > 0 then
  begin
    Application.MessageBox('当前功能下还有其他功能，不能删除。', '系统提示', MB_ICONInformation + MB_OK);
  end;

  if SysMessage('确定从『收藏夹』中删除所选功能“' + ANode.text + '”？', '',
    [mbOK, mbCancel]) = mrOk then
  begin
    TreeViewMyFunc.Items.Delete(ANode);

    UpdateTreeViewMyFuncHeight;
    SaveMyFuncToDB;
  end;
end;

procedure TFormMain.UpdateTreeViewMyFuncHeight;
var
  iH, iMax: Integer;
begin
  iH := TreeViewMyFunc.Items.Count * 16 + 30;
  iMax := PanelLeftBox.Height * 2 div 3;
  if iH > iMax then
    iH := iMax;
  PanelMyFunc.Height := iH;
end;

procedure TFormMain.SaveMyFuncToDB;
var
  sSQL: string;
  ssMyNodes: TStrings;
  ACds: TClientDataSet;
  i: Integer;
begin
  try
    ACds := TClientDataSet.Create(nil);
    try
      ACds.RemoteServer := DataModulePub.MidasConnectionPub;
      sSQL := 'delete from GL_Czy_CYGN ' +
        ' where id = ' + IntToStr(GCzy.ID) +
        ' and ModName = ''' + GProSign + '''';
      PExecSQL(ACds, sSQL);

      ssMyNodes := TStringList.Create;
      try
        for i := 0 to FMyFuncRoot.Count - 1 do
          ssMyNodes.Add(FMyFuncRoot.Item[i].Text);

        sSQL := 'insert into GL_Czy_CYGN ' +
          ' values (' + IntToStr(GCzy.ID) + ', ' +
          ' ''' + GProSign + ''', ' +
          ' ''' + ssMyNodes.Text + ''')';
      finally
        ssMyNodes.Free;
      end;
      PExecSQL(ACds, sSQL);
    finally
      ACds.Free;
    end;
  except
  end;
end;

procedure TFormMain.SetFuncTreeIcon;
var
  i: Integer;
begin
  // 全部功能
  with TreeViewFunc do
  begin
    for i := 0 to Items.Count - 1 do
    begin
      if Items[i].getFirstChild <> nil then
      begin
        Items[i].ImageIndex := 0;
        Items[i].SelectedIndex := 0;
      end
      else
      begin
        Items[i].ImageIndex := 2;
        Items[i].SelectedIndex := 2;
      end;
    end;
  end;
  // 收藏夹
  with TreeViewMyFunc do
  begin
    for i := 0 to Items.Count - 1 do
    begin
      if Items[i].getFirstChild <> nil then
      begin
        Items[i].ImageIndex := 0;
        Items[i].SelectedIndex := 0;
      end
      else
      begin
        Items[i].ImageIndex := 2;
        Items[i].SelectedIndex := 2;
      end;
    end;
  end;
end;

procedure TFormMain.MMyDesktopClick(Sender: TObject);
begin
  //之前不知何故被注释，现放开，测试无问题 Modified by chengjf 2015-09-24
  FormBackGround.BringToFront;
end;

procedure TFormMain.ClientWndProc(var Message: TMessage);
//客户区窗口过程 R96 zhouyunlu 200506
const
  WM_MDICHILD_UPDATE = WM_User + 5611; //自定义消息，用于修改子窗口列表
  WM_MDICHILD_MAX = WM_USER + 5612; //自定义消息，用于使某子窗口最大化   wparam 为 子窗口handle
var
  CurFormhandle: HWND;
  pMsg: Cardinal;
  i: Integer;
begin
  case Message.Msg of
    WM_MDICHILD_UPDATE:
      begin
        if FWndList <> nil then
          FWndList.UpdateList; //更新列表
        Message.Result := 1;
      end;

    WM_MDICHILD_MAX:
      begin
        if MDIChildCount > 1 then
          SendMessage(Message.WParam, WM_SYSCommand, SC_MAXIMIZE, 0);
        message.Result := 1;
      end;
    WM_MDICREATE:
      begin
        Message.Result := CallWindowProc(FOldClientProc, ClientHandle,
          Message.Msg, Message.wParam, Message.lParam);
      end;
    WM_MDIACTIVATE,
    WM_MouseActivate, //33 切换窗体时一般触发的是这个消息
    WM_ChildActivate, //34
    WM_MDIDESTROY, //545 关闭一个窗体，会激活另一个窗体
    $3F: //63
      begin //CurFormhandle := Message.wParam;  //ShowMessage(IntToStr(Message.Msg));
        pMsg := Message.Msg;
        Message.Result := CallWindowProc(FOldClientProc, ClientHandle, Message.Msg, Message.wParam, Message.lParam);
        PostMessage(ClientHandle, WM_MDICHILD_UPDATE, 0, 0);
        if (ActiveMDIChild is TFormBackGround) then
          TFormBackGround(ActiveMDIChild).WindowState := wsMaximized;
        DispStatus(rMainSub.GsCurModName);
        //激活其他窗体时，再初始化这个模块的变量
        if (FWndList <> nil) and (FslUIR9_IMPL <> nil) and (ActiveMDIChild <> nil)
          and ((ActiveMDIChild <> ActiveMIDPre) or ((rMainSub.GsPriModName <> rMainSub.GsCurModName)
          and (rMainSub.GsPriModName <> ''))) //切换窗体或切换模块时
          and ((pMsg = WM_MouseActivate) or (pMsg = WM_MDIDESTROY)) {//窗体激活或者关闭时} then
        begin
          for i := 0 to FWndList.FList.Count - 1 do
          begin
            if TMDIChildItem(FWndList.FList[i]).FormHandle = ActiveMDIChild.Handle then
            begin //根据窗体句柄找到是哪一个模块
              FslUIR9_IMPL.ActiveForm(TMDIChildItem(FWndList.FList[i]).sModeName); //激活窗体，执行初始化过程 ActiveMDIChild.Handle
              Break;
            end;
          end;
        end;
        ActiveMIDPre := ActiveMDIChild;
        //对于showmodal窗体，不能捕获消息，则不能更新ActiveMIDPre值，所以在showmodal窗体关闭时，将无法激活下一个窗体，所以无法执行变量初始化，故改用GsPriModName和GscurModName来判断
      end;

  else
    begin
      Message.Result := CallWindowProc(FOldClientProc, ClientHandle, Message.Msg, Message.wParam, Message.lParam);
      (*if bmessage then begin
         //if im=-100 then
         iM:=Message.Msg;
         if im<>553 then
            ShowMessage(IntToStr(Message.Msg));
      end;*)
    end;
  end;
end;

procedure TFormMain.CreateWnd;
//重写 以替换默认的客户区窗口过程 R96 zhouyunlu 200506
begin
  inherited CreateWnd;
  FNewClientProc := MakeObjectInstance(ClientWndProc);
  FOldClientProc := Pointer(GetWindowLong(ClientHandle, GWL_WNDPROC));
  //替换掉客户区窗口过程
  SetWindowLong(ClientHandle, GWL_WNDPROC, LongInt(FNewClientProc));
end;

procedure TFormMain.NCloseClick(Sender: TObject);
begin
  if FWndList.GetSelectedIndex = 0 then
    Exit;
  FWndList.CallWindow(FWndList.GetSelectedIndex, TWindowOperation(TMenuItem(Sender).Tag));
end;

procedure TFormMain.onPopup(Index: Integer; var Popop: Boolean);
begin
  if Index = 0 then
    Popop := False;
end;

procedure TFormMain.NewMenuItemClick(Sender: TObject);
begin
  if sender is TMenuItem then
  begin
    if (TMenuItem(sender).tag > 0) and
      (FOrgMenuItem.Objects[TMenuItem(sender).tag - 1] <> nil) and
    (FOrgMenuItem.Objects[TMenuItem(sender).tag - 1] is TMenuItem) then
      TMenuItem(FOrgMenuItem.Objects[TMenuItem(sender).tag - 1]).Click;
  end;
end;

procedure TFormMain.TimerDemoTimer(Sender: TObject);
const
  sDemo = '您目前使用的是演示版，系统无法保证您的数据完整性、安全性，' + #13 +
    '请您尽快升级到正版软件。';
begin
  if TTimer(sender).Tag = 0 then
  begin
    TTimer(sender).Tag := 1;
    Sysmessage(sDemo, '_JG', [mbOK]);
    TTimer(sender).Tag := 0;
  end;
end;

procedure TFormMain.RxLabelLeftCloseMouseEnter(Sender: TObject);
begin
  imgLeftClose.Picture.Bitmap.Assign(GImageLeftHot);
end;

procedure TFormMain.RxLabelLeftCloseMouseLeave(Sender: TObject);
begin
  imgLeftClose.Picture.Bitmap.Assign(GImageLeft);
end;

procedure TFormMain.RxLabelLeftShowMouseEnter(Sender: TObject);
begin
  PanelLeftShow.BackGroundEffect := bdHorzOut;

  PanelLeftShow.Color := GGradPanColorHot;
  PanelLeftShow.ColorEnd := GGradPanColorEnd;
  PanelLeftShow.ColorShadow := GGradPanColorHot;
  PanelLeftShow.ColorStart := GGradPanColorHot;
  PanelNavBar.Color := GFormBackgroundColor;

  RxLabelLeftShow.Font.Color := GFormFontColor;
end;

procedure TFormMain.RxLabelLeftShowMouseLeave(Sender: TObject);
begin
  PanelLeftShow.BackGroundEffect := bdHorzIn;

  PanelLeftShow.Color := GGradPanColorStart;
  PanelLeftShow.ColorEnd := GGradPanColorEnd;
  PanelLeftShow.ColorShadow := GGradPanColorStart;
  PanelLeftShow.ColorStart := GGradPanColorStart;
  PanelNavBar.Color := GFormBackgroundColor;

  RxLabelLeftShow.Font.Color := GFormFontColor;
end;

procedure TFormMain.PanelLeftOpenClick(Sender: TObject);
begin
  FLeftIsHide := False;
  PanelTopMain.Height := PanelTopMain.Tag;
  PanelLeftMain.Visible := True;
  SplitterLeft.Visible := True;
  SplitterLeft.Left := PanelLeftMain.Width + 10;
  PanelNavBar.Visible := False;
  SetParent;
end;

procedure TFormMain.SetParent;
begin
  if FLeftIsHide then
    FWndList.Parent := PanelNavBar
  else
    FWndList.Parent := PanelLeftBox;
end;

procedure TFormMain.RxLabelLeftShowClick(Sender: TObject);
begin
  FLeftIsHide := True;
  PanelLeftMain.Visible := not PanelLeftMain.Visible;
  SplitterLeft.Visible := False;
  PanelNavBar.Visible := True;
  PanelNavBar.Left := 0;
  SetParent;

  if PanelLeftMain.Width < 200 then
    PanelLeftMain.Width := 200;
end;

procedure TFormMain.SetBitMap(img: TBitmap; index: Integer);
begin
  ImageListLeftRight.GetBitmap(index, img);
end;

procedure TFormMain.RxLabelLeftOpenMouseEnter(Sender: TObject);
begin
  imgOpenLeft.Picture.Bitmap.Assign(GImageRightHot);
end;

procedure TFormMain.RxLabelLeftOpenMouseLeave(Sender: TObject);
begin
  imgOpenLeft.Picture.Bitmap.Assign(GImageRight);
end;

(*procedure TFormMain.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited;
end;   *)

procedure TFormMain.MIChangeUnitClick(Sender: TObject);
var
  i: Integer;
  iCount: integer;
begin
  if Assigned(FormBackGround) then
    iCount := 1
  else
    iCount := 0;
  if (MDIChildCount > iCount) then
  begin
    for i := 0 to MDIChildCount - 1 do
      if not (MDIChildren[i] is TFormBackGround) then
        MDIChildren[i].BringToFront;
    SysMessage('更换单位前请关闭所有打开的窗口。', '', [mbOk]);
    Exit;
  end;

  if Assigned(FormBackGround) then begin
     FormBackGround.SaveConfig(gCZy.name);
     FormBackGround.SaveDesktopImageSettings;
  end;

  //更换单位
  try
    GbAutoLogin := True;  // DSL
    FormLogin := TFormLogin.Create(Application);
    FormLogin.ReChoseUnitLogin(0);
  finally
    FormLogin.Free;
  end;

end;

procedure TFormMain.MOpRecordClick(Sender: TObject);
begin
  if not Gqx[ord(CZRZ_Read)] then
  begin
    SysMessage('您没有查阅系统操作日志的权限。', 'PZ_97_JG', [mbOK]);
    Exit;
  end;
  //zhengjy 2014-10-11 系统管理权限限制，不显示操作日志功能菜单,代码不能加else条件分支
  if (GblManagerLimit=1) and (GCzy.ID=1) then
  begin
    SysMessage('您没有查阅系统操作日志的权限。', 'PZ_97_JG', [mbOK]);
    Exit;
  end;  
  LoadCZRZ;
end;

procedure TFormMain.MenuItemLawRulesClick(Sender: TObject);
begin
  if Assigned(FormBackGround) then
    FormBackGround.imgLawClick(nil);
end;

procedure TFormMain.MChangePasswordClick(Sender: TObject);
begin
  ChangePassWord;
end;

procedure TFormMain.MChangeAnyiServerAddressClick(Sender: TObject);
begin
  AnyiClient1.Setup(True);

  (* GModeEncryptList.Free; //重新获取所有加密
   GModeEncryptList := TModeEncryptList.Create;
   SetTreeDemoText;*)
end;

procedure TFormMain.AppException(Sender: TObject; E: Exception);
begin
  TLog.WriteErr(E.Message);
end;

procedure TFormMain.ActLogExecute(Sender: TObject);
begin
  if GbUseLog and
    (Application.MessageBox('前台日志记录功能已经启用，是否禁用日志功能？',
    '系统提示', MB_ICONWarning + MB_YesNo) <> IDYes) then
  begin
    Exit
  end;
  if not GbUseLog and
    (Application.MessageBox('前台日志记录功能没有启用，是否启用日志功能？' + #13#10
    + '注意： 启用日志后，日志文件保存在应用文件的Log目录中。'
    , '系统提示', MB_ICONWarning + MB_YesNo) <> IDYes) then
  begin
    Exit;
  end;
  //启用或者禁用日志功能。
  TLog.InitLog;
end;

procedure SearchFileEx(const Dir: string; Files: TStrings);
var
  Found: TSearchRec;
  i: Integer;
  Dirs: TStrings;
  Finished: Integer;
  StopSearch: Boolean;
begin
  StopSearch := False;
  Dirs := TStringList.Create;
  Finished := FindFirst(Dir + '*.*', 63, Found);
  while (Finished = 0) and not (StopSearch) do
  begin
    if (Found.Name <> '.') then
    begin
      if (Found.Attr and faDirectory) = faDirectory then
        Dirs.Add(Dir + Found.Name)
      else
        Files.Add(Dir + Found.Name);
    end;
    Finished := FindNext(Found);
  end;
  FindClose(Found);
  if not StopSearch then
    for i := 0 to Dirs.Count - 1 do
      SearchFileEx(Dirs[i], Files);
  Dirs.Free;
end;

function TFormMain.CheckPowerFun(GnID: Integer): Boolean;
const
  cSQL = 'Select 1 from GL_QNQX where gnID=%s and UserID=%s';
begin
  Result := DataModulePub.GetCountBySQL(format(cSQL, [IntToStr(GnID),
    IntToStr(GCzy.ID)])) > 0;
end;

procedure TFormMain.ChangeYearMenuItemClick(Sender: TObject);
var
  i: Integer;
  FGszGSDM, FYWRQ, FGszHSDWDM, FGszHSDWMC, FGszZth, FGszZTMC, FKJND: string;
  FCzy: TCzy;
begin
  if (MDIChildCount > 1) then
  begin
    for i := 0 to MDIChildCount - 1 do
      if not (MDIChildren[i] is TFormBackGround) then
        MDIChildren[i].BringToFront;
    SysMessage('查询其他年度前请关闭所有打开的窗口。', '', [mbOk]);
    Exit;
  end;

  PRegNC(MRelogin);
  FGszGSDM := GszGSDM;
  FGszHSDWDM := GszHSDWDM;
  FGszHSDWMC := GszHSDWMC;
  FGszZth := GszZth;
  FGszZTMC := GszZTMC;
  FYWRQ := GszYWRQ;
  FKJND := GszKJND;
  FCzy := GCzy;
  if SysReLogin(TMenuItem(Sender).hint) then
  begin
    //InitMenuToNew;

    // 崔立国 2011.10.26 登录后第一次点"功能"菜单时构建所有模块的下级功能子菜单。
    NGNFL.Tag := 0;
  end
  else
  begin
    GszGSDM := FGszGSDM;
    GszHSDWDM := FGszHSDWDM;
    GszHSDWMC := FGszHSDWMC;
    GszZth := FGszZth;
    GszZTMC := FGszZTMC;
    GszYWRQ := FYWRQ;
    GszKJND := FKJND;
    GCzy := FCzy;
    GDBType := GetDBType(True);
  end;
end;

procedure TFormMain.RxLabelLeftMyCloseClick(Sender: TObject);
begin
  PanelMyFunc.Visible := not PanelMyFunc.Visible;
  if PanelMyFunc.Visible then
    imgLeftMyClose.Picture.Bitmap.Assign(GImageUp)
  else
    imgLeftMyClose.Picture.Bitmap.Assign(GImageDown);
end;

procedure TFormMain.RxLabelLeftMyCloseMouseEnter(Sender: TObject);
begin
  {  if PanelMyFunc.Visible then
      imgLeftMyClose.Picture.Bitmap.Assign(GImageUpHot)
    else
      imgLeftMyClose.Picture.Bitmap.Assign(GImageDownHot); }
end;

procedure TFormMain.RxLabelLeftMyCloseMouseLeave(Sender: TObject);
begin
  { if PanelMyFunc.Visible then
     imgLeftMyClose.Picture.Bitmap.Assign(GImageUp)
   else
     imgLeftMyClose.Picture.Bitmap.Assign(GImageDown);}
end;

procedure TFormMain.RxLabelLeftAllCloseClick(Sender: TObject);
begin
  if trim(Label4.Caption) = '功能导航' then
  begin
    PanelFunc.Visible := not PanelFunc.Visible;
    if PanelFunc.Visible then
      imgLeftAllClose.Picture.Bitmap.Assign(GImageUp)
    else
      imgLeftAllClose.Picture.Bitmap.Assign(GImageDown);
  end
  else if trim(Label4.Caption) = '单位账套' then
  begin
    pnlAccInfoSelect.Visible := not pnlAccInfoSelect.Visible;
    if pnlAccInfoSelect.Visible then
      imgLeftAllClose.Picture.Bitmap.Assign(GImageUp)
    else
      imgLeftAllClose.Picture.Bitmap.Assign(GImageDown);
  end;
end;

procedure TFormMain.RxLabelLeftAllCloseMouseEnter(Sender: TObject);
begin
  {  if PanelFunc.Visible then
      imgLeftAllClose.Picture.Bitmap.Assign(GImageUpHot)
    else
      imgLeftAllClose.Picture.Bitmap.Assign(GImageDownHot);}
end;

procedure TFormMain.RxLabelLeftAllCloseMouseLeave(Sender: TObject);
begin
  { if PanelFunc.Visible then
     imgLeftAllClose.Picture.Bitmap.Assign(GImageUp)
   else
     imgLeftAllClose.Picture.Bitmap.Assign(GImageDown); }
end;

procedure TFormMain.InitMainFormSkin;

  procedure RefreshChildWin;
  var
    i: Integer;
  begin
    for i := 0 to MDIChildCount - 1 do
      if MDIChildren[i] is TFormBackGround then
      begin
        ResImgReplace(MDIChildren[i], GSkinNames.Values[FSkin]);
        TFormBackGround(MDIChildren[i]).InitDesktopSkin;
      end
      else
        SetComponentsColor(MDIChildren[i]);
  end;
begin
  XPMenu1.IconBackColor := GFormBackgroundColor;
  MenuBox.GMenuBoxLineColor := GLeftSplitterColor;
  MenuBox.GMenuButtonColor := MixColors(GFormBackgroundColor, clWhite);
  MenuBox.GMenuTextColor := GFormFontColor;
  FMenuBox.Color := MenuBox.GMenuButtonColor;
  PanelMyFunc.Color := MenuBox.GMenuButtonColor;
  FMenuBox.RefreshMenus;
  {日常工作}
  FDailyWorkMenu.Color := MenuBox.GMenuButtonColor;
  FDailyWorkMenu.RefreshMenus;
  Label2.Left := GIntLeftBarTextX;
  Label2.Top := GIntLeftBarTextY;
  imgLeftClose.Top := GIntLeftBarTextY;
  Label3.Left := GIntLeftBarTextX;
  Label3.Top := (GImageFuncBar.Height - Label3.Height) div 2 + 1;
  Label4.Left := GIntLeftBarTextX;
  Label4.Top := (GImageFuncBar.Height - Label4.Height) div 2 + 1;

  Label2.Font.Color := GFormFontColor;
  Label3.Font.Color := GFormFontColor;
  Label4.Font.Color := GFormFontColor;
  RxLabelLeftShow.Font.Color := GFormFontColor;

  PanelLeftTitle.Height := GImageLeftBar.Height;
  ImageLeftTitle.Picture.Bitmap.Assign(GImageLeftBar);
  pnlLeftSel.Height := GImageFuncBar.Height;
  ImageLeftMyFunc.Picture.Bitmap.Assign(GImageFuncBar);
  pnlLeftAll.Height := GImageFuncBar.Height;
  ImageLeftFunc.Picture.Bitmap.Assign(GImageFuncBar);

  WindowsList.GWinBarBmp.Assign(GImageWinBar);
  WindowsList.GWinBarHotBmp.Assign(GImageWinBarHot);

  Wait.BorderColor := GLeftSplitterColor;

  imgLeftClose.Picture.Bitmap.Assign(GImageLeft);
  imgLeftMyClose.Picture.Bitmap.Assign(GImageUp);
  imgLeftAllClose.Picture.Bitmap.Assign(GImageUp);
  imgOpenLeft.Picture.Bitmap.Assign(GImageRight);

  PanelLeftMain.Color := GFormBackgroundColor;
  PanelLeftBox.Color := GFormBackgroundColor;
  PanelLeftShow.ParentColor := False;
  PanelLeftShow.Color := GGradPanColorStart;
  PanelLeftShow.ColorEnd := GGradPanColorEnd;
  PanelLeftShow.ColorShadow := GGradPanColorStart;
  PanelLeftShow.ColorStart := GGradPanColorStart;
  PanelNavBar.Color := GFormBackgroundColor;
  SplitterLeft.Color := GLeftSplitterColor;
  PanelLeftLine.Color := GLeftSplitterColor;
  PanelBottom.Color := GLeftSplitterColor;

  Panel_StatusBarMain.Height := GImageStatusBar.Height - 5;
  StatusBarMain.Color := GImageStatusBar.Canvas.Pixels[0, 0];
  Panel_StatusBarMain.Color := StatusBarMain.Color;
  StatusBarMain.Invalidate;

  Color := GFormBackgroundColor;

  FWndList.Font.Style := [fsBold];
  FWndList.Font.Color := GFormFontColor;
  FWndList.Refresh;

  RefreshChildWin;

  AfterMainFormSkinChanged;

end;

procedure TFormMain.InitNoExistsImage;
begin
  GImageLeftBar.Assign(ImageNoExists.Picture.Bitmap); // 主窗口左侧功能树标题栏背景
  GImageFuncBar.Assign(ImageNoExists.Picture.Bitmap); // 主窗口卓侧功能树分组栏背景
  GImageLeft.Assign(ImageNoExists.Picture.Bitmap); // 左箭头
  GImageRight.Assign(ImageNoExists.Picture.Bitmap); // 右箭头
  GImageUp.Assign(ImageNoExists.Picture.Bitmap); // 上箭头
  GImageDown.Assign(ImageNoExists.Picture.Bitmap); // 下箭头
  GImageLeftHot.Assign(ImageNoExists.Picture.Bitmap); // 左箭头（选中）
  GImageRightHot.Assign(ImageNoExists.Picture.Bitmap); // 右箭头（选中）
  GImageUpHot.Assign(ImageNoExists.Picture.Bitmap); // 上箭头（选中）
  GImageDownHot.Assign(ImageNoExists.Picture.Bitmap); // 下箭头（选中）
  GImageWinBarHot.Assign(ImageNoExists.Picture.Bitmap); // 窗口栏背景
  GImageWinBar.Assign(ImageNoExists.Picture.Bitmap); // 窗口栏背景（选中）

  GImageMyWork.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_我的工作
  GImageMyWorkHot.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_我的工作（选中）
  GImageHomePage.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_主页
  GImageHomePageHot.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_主页（选中）
  GImageLaw.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_法律法规
  GImageLawHot.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_法律法规（选中）
  GImageFlow.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_流程
  GImageFlowHot.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_流程（选中）
  GImageLeftMargin.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_左边空白背景
  GImageRightMargin.Assign(ImageNoExists.Picture.Bitmap); // 桌面按钮栏_右边空白背景

  GImageGridHeader.Assign(ImageNoExists.Picture.Bitmap); // 窗口表格标题栏背景
  GImageSpeedBar.Assign(ImageNoExists.Picture.Bitmap); // 窗口按钮栏背景
  GImageSpeedButton.Assign(ImageNoExists.Picture.Bitmap); // 窗口按钮状态背景
  GImageSpeedButtonDown.Assign(ImageNoExists.Picture.Bitmap); // 窗口按钮状态背景（下拉）

  GImageEditorUp.Assign(ImageNoExists.Picture.Bitmap); // 编辑框上箭头
  GImageEditorDown.Assign(ImageNoExists.Picture.Bitmap); // 编辑框下箭头
  GImageEditorButton.Assign(ImageNoExists.Picture.Bitmap); // 编辑框按钮

  GImageStatusBar.Assign(ImageNoExists.Picture.Bitmap); // 状态栏背景

  GImageWinCaption.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏背景
  GImageWinBtnMin.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_最小化
  GImageWinBtnMinHot.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_最小化（选中）
  GImageWinBtnMinDown.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_最小化（按下）
  GImageWinBtnMax.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_最大化
  GImageWinBtnMaxHot.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_最大化（选中）
  GImageWinBtnMaxDown.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_最大化（按下）
  GImageWinBtnRes.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_还原
  GImageWinBtnResHot.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_还原（选中）
  GImageWinBtnResDown.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_还原（按下）
  GImageWinBtnClose.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_关闭
  GImageWinBtnCloseHot.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_关闭（选中）
  GImageWinBtnCloseDown.Assign(ImageNoExists.Picture.Bitmap); // 窗口标题栏按钮_关闭（按下）

  //窗口字体颜色
  GImageFormFontColor.Assign(ImageNoExists.Picture.Bitmap);

  //功能树的背景色
  GImageFormBackgroundColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageFuncTreeBackGroundColor.Assign(ImageNoExists.Picture.Bitmap);

  //账务各账簿封面用的渐近色控件TGradPan的起始颜色设置
  GImageGradPanColorStart.Assign(ImageNoExists.Picture.Bitmap);
  GImageGradPanColorEnd.Assign(ImageNoExists.Picture.Bitmap);
  GImageGradPanColorHot.Assign(ImageNoExists.Picture.Bitmap);

  //登记簿之类的下面的页签控件TabSet的背景和选中颜色设置
  GImageTabSetBackGroundColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageTabSetSelectedColor.Assign(ImageNoExists.Picture.Bitmap);

  //THStringGrid、THDBGridGrid的表头、锁定列、网格线、高亮选中等颜色设置
  GImageTHGridFixedColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageTHGridHeaderColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageTHGridLineColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageTHGridLockColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageTHGridHighLightColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageTHGridHighLightTextColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageTHGridWavedColor.Assign(ImageNoExists.Picture.Bitmap);
end;

procedure TFormMain.CreateSkinMenu;
var
  i: Integer;
  Item: TMenuItem;
  szSkinName: string;
begin
  // 删除旧的样式菜单项
  for i := MSkin.Count - 1 downto 0 do
    MSkin.Items[i].Free;

  // 增加新的样式菜单项
  for i := 0 to GSkinNames.Count - 1 do
  begin
    if (GSkinNames.Names[i] <> '') then
    begin
      Item := TMenuItem.Create(self);
      Item.Caption := GSkinNames.Names[i];
      if (Item.Caption <> '-') then
      begin
        Item.RadioItem := True;
        Item.OnClick := MSkinMenuClick;
        Item.Hint := GSkinNames.Names[i];
      end;
      MSkin.Add(Item);
    end;
  end;

  szSkinName := '';
  if PRegReadS('\SOFTWARE\UFGOV\'+GsProductID+'\Main', 'FormSkin', szSkinName) then
  begin
    for i := 0 to MSkin.Count - 1 do
    begin
      if (szSkinName <> '') and SameText(MSkin.Items[i].Hint, szSkinName) then
      begin
        MSkin.Items[i].Click;
        Exit;
      end;
    end;
    if i = MSkin.Count then
    begin
      if MSkin.Count > 2 then
        MSkin.Items[1].Click;
    end;
  end
  else
  begin
    if MSkin.Count > 2 then
      MSkin.Items[1].Click;
  end;

end;

procedure TFormMain.MSkinMenuClick(Sender: TObject);
var
  i: Integer;
  Item: TMenuItem;
begin
  if (Sender <> nil) and (Sender is TMenuItem) and
    (TMenuItem(Sender).Parent = MSkin) then
  begin
    if (MDIChildCount > 1) then
    begin
      for i := 0 to MDIChildCount - 1 do
        if not (MDIChildren[i] is TFormBackGround) then
          MDIChildren[i].BringToFront;
      SysMessage('更换窗口样式前请关闭所有打开的窗口。', '', [mbOk]);
      Exit;
    end;

    Item := TMenuItem(Sender);
    Item.Checked := True;
    FSkin := Item.Hint;
    LoadSkinImages(Item.Hint);
    ResImgReplace(Self, GSkinNames.Values[Item.Hint]);

    InitMainFormSkin;
    if Assigned(FMenuBox) then
      FMenuBox.Repaint; // Invalidate;
    PRegWriteS('\SOFTWARE\UFGOV\'+GsProductID+'\Main', 'FormSkin', Item.Hint);
  end;
end;

procedure TFormMain.UpdateStatusBar;
var
  i: Integer;
begin
  for i := 0 to StatusBarMain.Panels.Count - 1 do
  begin
    StatusBarMain.Panels[i].Bevel := pbNone;
    StatusBarMain.Panels[i].Style := psOwnerDraw;
  end;
end;

procedure TFormMain.StatusBarMainDrawPanel(StatusBar: TStatusBar;  Panel: TStatusPanel; const Rect: TRect);
var
  R: TRect;
begin
  R := Rect;
  with StatusBarMain.Canvas do
  begin
    if Assigned(GImageStatusBar) then
      StretchDraw(R, GImageStatusBar);
    Brush.Style := bsClear;
    Font.Color := GFormFontColor;
    Font.Style := [fsBold];
    if Panel.Index > 0 then
      TextOut(R.Left + 6, R.Top + (R.Bottom - R.Top - TextHeight('Hg')) div 2 -
        1, Panel.Text);
  end;

  if Panel.Index = 5 then
  begin
    Pgb.Parent := StatusBarMain;
    Pgb.Left := Rect.Left;
    Pgb.Top := Rect.Top;
    Pgb.Height := Rect.Bottom - 2;
    Pgb.Width := StatusBarMain.Width - Rect.Left - 2;
    Pgb.Visible := False;
    Pgb.MaxValue := 100;
  end;
end;

(*
procedure TFormMain.WMNCLButtonUp(var Message: TWMNCLButtonUp);
begin
  if Message.HitTest = FDownWinBtn then
  begin
    if Message.HitTest = HTMINBUTTON then
      Application.Minimize
    else if Message.HitTest = HTMAXBUTTON then
    begin
      if WindowState = wsNormal then
        WindowState := wsMaximized
      else if WindowState = WSMAXIMIZED then
        WindowState := wsNormal;
    end
    else if Message.HitTest = HTCLOSE then
      Close
    else
      inherited;
  end else
    inherited;

  FDownWinBtn := 0;
end;

procedure TFormMain.WMNCHitText(var Message: TWMNCHitTest);
var
  minrect: TRect;
  maxrect: TRect;
  closerect: TRect;
  pt: TPoint;
begin
  inherited;
  if Message.Result in [HTCaption, HTMINBUTTON, HTMAXBUTTON, HTCLOSE] then
  begin
    GetCursorPos(pt);
    pt := ScreenToClient(pt);
    pt.x := pt.x + 2;
    pt.y := pt.y + GetSystemMetrics(SM_CYCaption) + 2;

    UpdateWinBtnRect;

    if PtInRect(FWinIconRect, pt) then
      Message.Result := HTSYSMENU
    else if PtInRect(FWinMinBtnRect, pt) then
      Message.Result := HTMINBUTTON
    else if PtInRect(FWinMaxBtnRect, pt) then
      Message.Result := HTMAXBUTTON
    else if PtInRect(FWinCloseBtnRect, pt) then
      Message.Result := HTCLOSE
    else
      Message.Result := HTCaption;
  end;
end;

procedure TFormMain.UpdateWinBtnRect;
var
  dw, dh, dx, dy: Integer;
begin
  dh := GetSystemMetrics(SM_CYCaption) - 4;
  dw := dh;

  dx := 2;
  dy := 2;
  FWinIconRect := Rect(dx, dy, dw, dh);

  dx := ClientWidth - dw - 1;
  dy := 1;
  if dw > GImageWinBtnClose.Width then dw := GImageWinBtnClose.Width;
  if dh > GImageWinBtnClose.Height then dh := GImageWinBtnClose.Height;
  FWinCloseBtnRect := Rect(dx, dy, dx + dw, dy + dh);
  dx := dx - dw - 2;
  FWinMaxBtnRect := Rect(dx, dy, dx + dw, dy + dh);
  dx := dx - dw;
  FWinMinBtnRect := Rect(dx, dy, dx + dw, dy + dh);
end;
  *)

procedure TFormMain.sbtnMDICloseClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and not (ActiveMDIChild is TFormBackGround) then
    ActiveMDIChild.Close;
end;

procedure TFormMain.sbtnMDIResClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and not (ActiveMDIChild is TFormBackGround) then
    ActiveMDIChild.WindowState := wsNormal;
end;

procedure TFormMain.sbtnMDIMinClick(Sender: TObject);
begin
  if (ActiveMDIChild <> nil) and not (ActiveMDIChild is TFormBackGround) then
    ActiveMDIChild.WindowState := wsMinimized;
end;

procedure TFormMain.MDownloadDataClick(Sender: TObject);
begin
  // 崔立国 2010.10.11 使用离线工作模式登录
  if not GblOfflineMode then
    DownloadDataDialogShowModal
  else
    ShowMessage('操作无效。使用此功能之前请连接远程服务器。');
end;

procedure TFormMain.MUploadDataClick(Sender: TObject);
begin
  // 崔立国 2010.10.11 使用离线工作模式登录
  // 只有账务可以上传离线凭证（在Main.pas的集成方法中实现）。
  ShowMessage('操作无效。当前模块不支持上传离线数据。');
end;

procedure TFormMain.AfterMainFormSkinChanged;
begin
  { no code here ... }
end;

procedure TFormMain.LoadModeDll(psModeName, sGnflMc, sGnflExec: string); //ParamList:string
var
  FR9_IMPL: TUIR9_IMPL; //动态库控制类
  i:Integer;
begin
  (*if GAnyiLicenseInfo.ProductExists(GetGszAnyiByModeName(psModeName)) then begin //正式版才控制，演示版不进行控制
     if not CheckSPS then begin //SPS
        Exit;
     end;
  end; *)
  try
    FR9_IMPL := FslUIR9_IMPL.CreateUIR9(psModeName, sGnflExec);
    if FR9_IMPL = nil then
    begin
      ShowMessage('获取模块文件失败，原因如下：' + #13#10 +
        '1.程序运行目录下缺少"' + sGnflExec + '"文件' + #13#10 +
        '2.GL_GNFL表缺少相关模块文件名描述' + #13#10 +
        '3.其它未明确信息，请与系统管理员联系');
      Exit;
    end;
    (*if (FR9_IMPL.FExeType=etCustomRpt)or(FR9_IMPL.FExeType=etGE) then begin //先释放别的定制报表模块的加密，因为有可能是再打开一个报表类模块，则要自动释放其加密
       for i:=0 to FslUIR9_IMPL.FslUIR9.Count-1 do begin
           if (TUIR9_IMPL(FslUIR9_IMPL.FslUIR9.Objects[i])<>FR9_IMPL) and TUIR9_IMPL(FslUIR9_IMPL.FslUIR9.Objects[i]).bIsCusReport then begin
              if TUIR9_IMPL(FslUIR9_IMPL.FslUIR9.Objects[i]).Anyiclient1<>nil then
                 FreeAndNil(TUIR9_IMPL(FslUIR9_IMPL.FslUIR9.Objects[i]).Anyiclient1);
           end;
       end;
    end;*)
    FR9_IMPL.CallDll(PChar(sGnflMc));
  finally
    FR9_IMPL := nil;
  end;
end;

procedure TFormMain.UpdateMIDMenuBar(AMainMenu: TMainMenu);
var
  i: Integer;
begin
  for i := ToolBarMainMenu.ButtonCount - 1 downto 0 do
    ToolBarMainMenu.Buttons[i].Free;

  for i := MainMenu.Items.Count - 1 downto 0 do
  begin
    if MainMenu.Items[i].Visible then
      with TToolButton.Create(self) do
      begin
        MenuItem := MainMenu.Items[i];
        Grouped := True;
        Parent := ToolBarMainMenu;
      end;
  end;

  if (AMainMenu <> nil) then
  begin
    for i := AMainMenu.Items.Count - 1 downto 0 do
    begin
      if AMainMenu.Items[i].Visible then
        with TToolButton.Create(self) do
        begin
          MenuItem := AMainMenu.Items[i];
          Grouped := True;
          Left := ToolBarMainMenu.ButtonWidth;
          Parent := ToolBarMainMenu;
        end;
    end;
  end;
  PanelTopMain.Height := PanelTopMain.Tag;
end;

procedure TFormMain.MenuClick(Sender: TObject);
var
  i: Integer;
begin
  if TMenuItem(Sender).Parent = NGNFL then
  begin
    InitSubFuncMenu(TMenuItem(Sender));
    Exit;
  end;

  if TMenuItem(Sender).Count > 0 then
    Exit;

  TreeViewFunc.Items[TMenuItem(Sender).Tag].Selected := True;
  FuncTreeClick(TreeViewFunc);
end;

procedure TFormMain.MenuMYClick(Sender: TObject);
var
  i: Integer;
begin
  if TMenuItem(Sender).Count > 0 then
    Exit;
  TreeViewMYFunc.Items[TMenuItem(Sender).Tag].Selected := True;
  //ShowMessage(TreeViewMYFunc.Items[TMenuItem(Sender).Tag].Text);
  FuncTreeClick(TreeViewMYFunc);
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
  PanelTopMain.Tag := PanelTopMain.Height;

  ResImgReplace(Self);
  InitNoExistsImage;
  CreateSkinMenu;
  UpdateStatusBar;
  ActiveMIDPre := nil;
  NFDMenu.Checked := (PIniReadS('GlSys.ini', 'NMainMenu', 'NFDMenu', '1')='1');
  FMenuBox.Visible := NFDMenu.Checked;
  if GpsSeries = psR9i then
  begin
    NDWZT.Checked := (PIniReadS('GlSys.ini', 'NMainMenu', 'NDWZT', '1')='1');
    if NDWZT.Checked then
    begin
      Panelgndh.Visible := True;
      pnlAccInfo.Visible := True;
      SetMainBorder;
      SetDArrayPnls;
    end;
  end;
  bExitFind := False;
  FCurrNodeNum := '';
end;

procedure TFormMain.WMDLLMainClose(var Msg: TMessage); //该消息，只能用来卸载加密之用，不要写其他代码，by 针对乡财加密调整修改 2011.11.14
begin //if not rMainSub.bFreeBpl then Exit; if Msg.WParam<>0 then  FslUIR9_IMPL.DeleteUIR9('',Msg.WParam)   Msg.WParam是模块的子窗体
  FslUIR9_IMPL.DeleteUIR9(rMainSub.GsCurFreeAnyiCleintModName, 0);
end;

(*procedure TFormMain.WMDLLMDICreate(var Msg: TMessage); //窗体已创建的消息，已不用了
var
  pUIR9_IMPL:TUIR9_IMPL;
begin
  if (FWndList<>nil)and(rMainSub.GsCurModName<>'') then begin
      pUIR9_IMPL:= FslUIR9_IMPL.Values[rMainSub.GsCurModName];
      if pUIR9_IMPL<>nil then
         pUIR9_IMPL.FR9_DLLHandle:=Msg.WParam;
  end;
end; *)

function TFormMain.InitPubSYS: Boolean;
var
  szSQL: string;
begin
  GblHasCheck2007Newkm := False;
  GZtcs_gl := TZTCS_Ex.create(DataModulePub.ClientDataSetPub);
  with DataModulePub.ClientDataSetData do
  begin //有些模块仍然使用以下变量
    POpenSql(DataModulePub.ClientDataSetData,
      'select * from gl_fzxlb where kjnd=''' + GszKJND + ''' and gsdm=''' + IFF(GszGSDM <> '', GszGSDM, CSysDWDM) +
      '''');
    if Locate('lbdm', '0', []) then
    begin
      GszBMFJ := FieldByName('LBFJ').AsString;
    end;
    if Locate('lbdm', '1', []) then
    begin
      GszXMFJ := FieldByName('LBFJ').AsString;
    end;
    if Locate('lbdm', '3', []) then
    begin
      GszWLDWFJ := FieldByName('LBFJ').AsString;
      // Added by miaopf 2008-4-24 19:26:46 往来单位分级和预算单位分级不一样。不能直接这样赋值      //GszWLDWFJ := GszGSFJ;
    end;

    if Locate('lbdm', '4', []) then
    begin // for BEM? 2010.12.08 合并BEM代码
      GszFX1FJ := FieldByName('LBFJ').AsString;
    end;

    if Locate('lbdm', '5', []) then
    begin
      GszFX2FJ := FieldByName('LBFJ').AsString;
    end;

    if Locate('lbdm', 'X', []) then
    begin
      GszXJFJ := FieldByName('LBFJ').AsString;
    end;
    if Locate('lbdm', 'D', []) then
    begin
      GszDQFJ := FieldByName('LBFJ').AsString;
    end;
  end;
end;

procedure TFormMain.PgOnProgress(Rate: integer);
begin
  Application.ProcessMessages;
  if not Pgb.Visible then
    Pgb.Visible := True;
  Pgb.Progress := Rate;
  Pgb.Invalidate;
  Pgb.Repaint;
  if pgb.MaxValue = pgb.Progress then
  begin
    pgb.Visible := False;
    Pgb.Progress := 0;
  end;
end;

(*procedure TFormMain.UpdateMainMenuDemo(psModeName: String);
var
  i,j:Integer;
begin
  for i:= 0 to TreeViewFunc.Items.Count-1 do begin
      if TreeViewFunc.Items[i].Level=0 then
        if PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode=psModeName then begin
           for j:=0 to NGNFL.Count-1 do begin
               if NGNFL.Items[j].Tag=TreeViewFunc.Items[i].AbsoluteIndex then begin
                  SysMessage('没有找到"'+NGNFL.Items[j].Caption+'"的加密信息，暂作为演示版使用!','_YB',[mbok]);
                  NGNFL.Items[j].Caption := NGNFL.Items[j].Caption+'[演示版]';
                  TreeViewFunc.Items[i].Text := TreeViewFunc.Items[i].Text+'[演示版]';
                  FMenuBox.Invalidate;
                  Exit;
               end;
           end;
        end;
  end;
end;

procedure TFormMain.WMInitEncryptDemo(var Msg: TMessage);
begin
  UpdateMainMenuDemo(rMainSub.GsCurModName);
end;
*)

procedure TFormMain.WMAC_ERRORCODE(var Msg: TMessage);
begin
  case Msg.WParam of
    ERR_AC_DEMO:
      begin // 试用版。菜单盒上每个产品加个'(演示版)'
        //PostMessage(Application.MainForm.Handle,WM_InitEncryptDemo,0,0)  //演示版在登录时已增加，这里不用再处理了
      end;
    ERR_AC_SERVERNOTFOUND:
      begin
        SysMessage('未找到加密服务，请重新设置加密服务地址', '_YB', [mbok]);
        AnyiClient1.Setup(True);
        Exit;
      end;

    ERR_AC_DEMOEXPIRED:
      begin
        //SysMessage('试用版本已过期','_YB',[mbok]);
        //过期也是试用版，可以继续使用
      end;

    ERR_AC_PRODUCTNOTFOUND:
      begin
        SysMessage('未取得产品授权信息', '_YB', [mbok]);
        Exit;
      end;

    ERR_AC_INVALIDLOCALFILE:
      begin
        SysMessage('无效的本地加密文件', '_YB', [mbok]);
        Exit;
      end;

    ERR_AC_SOCKETERROR:
      begin
        SysMessage('网络故障，无法获取加密信息', '_YB', [mbok]);
        Exit;
      end;

    ERR_AC_SERVERERROR:
      begin
        SysMessage('加密认证被加密服务拒绝', '_YB', [mbok]);
        Exit;
      end;

    ERR_AC_UNKNOWN:
      begin
        SysMessage('未知的加密错误', '_YB', [mbok]);
        Exit;
      end;

  end;
end;

procedure TFormMain.UMAfterLogin(var Msg: TMessage);
begin
  AfterLoginInitMenu;
end;

procedure TFormMain.SplitterLeftDblClick(Sender: TObject);
begin
  ActLeftCloseExecute(SplitterLeft);
end;

procedure TFormMain.SplitterLeftPosChanged(Sender: TObject);
begin
  //
  if PanelLeftBox.Width < 50 then
  begin
    ActLeftCloseExecute(SplitterLeft);
  end;
end;

procedure TFormMain.SplitterLeftResize(Sender: TObject);
begin
  //
end;

procedure TFormMain.PanelLeftBoxResize(Sender: TObject);
begin
  //
end;

function TFormMain.IsAQRNode(Node: TTreeNode): Boolean;
var
  ANode: TTreeNode;
begin
  ANode := Node;
  while ANode.Level <> 0 do
  begin
    ANode := ANode.Parent;
  end;
  Result := PTreeRec(ANode.Data)^.sModCode = 'AQR';
end;

function FindMIDS(tv: TTreeView; aName: string): TTreeNode;
var
  iCount: integer;
begin
  Result := nil;
  for iCount := 0 to tv.Items.Count - 1 do
  begin
    if tv.Items[iCount].Level = 0 then
    begin
      if (Pos(aName, tv.Items[iCount].Text) > 0) then
      begin
        Result := tv.Items[iCount];
        break;
      end;
    end;
  end
end;

function TFormMain.GetMIDSTree(tv: TTreeView): Boolean;
const
  SQL1 = 'select TabCode, TabName, OrderNo  from MI_TabSet where TabType = ''1'' order by OrderNo ';
  {SQL2 = 'select a.TabDetailID TabCode, a.TabDetailName TabName,a.OrderNo from MI_TabDetails a,MI_TabSet b '
    + 'where a.TabCode=b.TabCode and b.TabType = ''2'' order by a.OrderNo ';
  SQL3 = 'select a.TabDetailID TabCode, a.TabDetailName TabName,a.OrderNo from MI_TabDetails a,MI_TabSet b '
    + 'where a.TabCode=b.TabCode and b.TabType = ''3'' order by a.OrderNo '; }
  SQL2 = 'select TabCode, TabName, OrderNo  from MI_TabSet where TabType = ''2'' order by OrderNo ';
  SQL3 = 'select TabCode, TabName, OrderNo  from MI_TabSet where TabType = ''3'' order by OrderNo ';
  MBType1 = '驾驶舱面板';
  MBType2 = '专题报表';
  MBType3 = '专题报告';
var
  MIDSNode, PNode: TTreeNode;
  //Treelst: TList;
  Cds: TClientDataSet;
  pRecPtr: PTreeRec;
  procedure internalSetTree(currSQL, currMBType: string);
  begin
    Cds := DataModulePub.GetCdsBySQL(currSQL);
    if Cds.RecordCount > 0 then
    begin
      PNode := tv.Items.AddChild(MIDSNode, currMBType);
      while not Cds.eof do
      begin
        New(pRecPtr);
        pRecPtr^.sModCode := 'MIDS';
        pRecPtr^.sMenuCode := Cds.FieldByName('TabCode').AsString;
        pRecPtr^.sGnflmc := Cds.FieldByName('TabName').AsString;
        pRecPtr^.sGnflExec := 'MIDS.exe';      //郭志勇修改 2012-02-14   //'MIDS.exe';
        with tv.Items.AddChild(PNode, Cds.FieldByName('TabName').AsString) do
          Data := pRecPtr;
        Cds.Next;
      end;
    end;
  end;
  procedure newSetTree;    // Added by guozy 2013/5/16 星期四 12:05:36
  begin
    New(pRecPtr);
    pRecPtr^.sModCode := 'MIDS';
    pRecPtr^.sMenuCode := '领导决策支持';
    pRecPtr^.sGnflmc := '领导决策支持';
    pRecPtr^.sGnflExec := 'MIDS.exe';      //郭志勇修改 2012-02-14   //'MIDS.exe';
    with tv.Items.AddChild(MIDSNode, '领导决策支持') do
      Data := pRecPtr;
  end;
begin
  //MIDSNode := FindMIDS(tv, '领导决策支持');
  //if MIDSNode = nil then
    //Exit;
  //newSetTree; Exit;  // Added by guozy 2013/5/16 星期四 12:03:09
  //Treelst := nil;
  //if not Assigned(Treelst) then
    //Treelst := TList.Create;
  {驾驶舱面板}
  //internalSetTree(SQL1, MBType1);
  {专题报表}
  //internalSetTree(SQL2, MBType2);
  {专题报告}
  //internalSetTree(SQL3, MBType3);
end;

(*procedure TFormMain.SetTreeDemoText; //设置演示版功能树文本
var
  i,j:Integer;
  sModeName:String;
begin
( if not Assigned(GModeEncryptList) then Exit;
  for i:= 0 to TreeViewFunc.Items.Count-1 do begin
    if TreeViewFunc.Items[i].Level<>0 then Continue;
    if GModeEncryptList.AEncryptStr<>nil then begin
       for j:=Low(GModeEncryptList.AEncryptStr) to High(GModeEncryptList.AEncryptStr) do begin
           if CompareText(GModeEncryptList.AEncryptStr[j].GszVersion,PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode)=0 then begin
              PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := False;  //存在加密
              Break;
           end;
       end;
    end;

    if (GModeEncryptList.AEncryptStr=nil) or (j>High(GModeEncryptList.AEncryptStr)) then begin
       sModeName:=PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode;
       if (Pos('演示版',TreeViewFunc.Items[i].Text)<=0)and(sModeName<>'SA')and(sModeName<>'BAS') then begin
          TreeViewFunc.Items[i].Text := TreeViewFunc.Items[i].Text+'[演示版]';
          PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := True;
       end;
    end;
  end;
end; *)

procedure TFormMain.InitTreeQXKZ;
var
  i: Integer;
  bdefaultVisible: Boolean;
  sSQL, sGNFLDM, sModeCode: string;
  NodeTemp, tmpNodeParent, tmpNodeChild: TTreeNode;
  t: Longword;
begin
  // 提示框效果不好，屏蔽掉。
  //// OpenWait(TCommonAVI(0), '处理菜单权限...', '');

  try
    if (GCzy.ID = 1) then
    begin
      //默认系统管理员可见所有功能节点，为了提高效率，就不作CdsPower.FindKey([sGNFLDM]) 的判断了
      for i := 0 to TreeViewFunc.Items.Count - 1 do
      begin
        if TreeViewFunc.Items[i].Data <> nil then
        begin
          NodeTemp := TreeViewFunc.Items[i];
          if Nodetemp.Level > 0 then
          begin
            sModeCode := PTreeRec(NodeTemp.Data)^.sModCode;
            (*OpenWait(TCommonAVI(0), '处理菜单权限...' +
                     '[' + PTreeRec(NodeTemp.Data)^.sMenuCode + '] ' +
                     PTreeRec(NodeTemp.Data)^.sGnflMc, '');*)
            if (sModeCode <> 'SA') and (sModeCode <> 'BAS') then
            begin
              {hch 循环获取菜单是否可见}
              PTreeRec(NodeTemp.Data)^.bVisible := not THideMenu.IsHide(GszGSDM, GszKJND, PTreeRec(NodeTemp.Data)^.sMenuCode);
            end else
              PTreeRec(NodeTemp.Data)^.bVisible := True;
          end
          else
          begin
            PTreeRec(NodeTemp.Data)^.bVisible := True;
          end;
        end;
      end;

      // 系统管理员在此直接退出。
      Exit;
    end;

    if not (CdsPower.Active and (CdsPower.RecordCount > 0)) then
    begin
      SysMessage('当前操作员没有任何功能权限.' + #13 + '请检查是否赋予了角色权限或所属角色是否配置了权限。', '_JG',
        [mbok]);
      for i := 0 to TreeViewFunc.Items.Count - 1 do
        if TreeViewFunc.Items[i].Data <> nil then
          PTreeRec(TreeViewFunc.Items[i].Data)^.bVisible := False;
      Exit;
    end;

    //sSQL:='select * from gl_gn';  //POpenSQL(CdsGL_GN,sSQL);    //CdsPower.Filtered := False;        CdsPower.Filter := 'gnfldm='''+sGNFLDM+'*''';        CdsPower.Filtered := True;        PTreeRec(TreeViewFunc.Items[i].Data)^.bVisible :=not (CdsPower.RecordCount<=0);
    //处理节点：没有权限不可见
    for i := 0 to TreeViewFunc.Items.Count - 1 do
    begin
      NodeTemp := TreeViewFunc.Items[i];
      if NodeTemp.Data = nil then
        Continue; (*if TreeViewFunc.Items[i].Level=0 then begin  //最上级节点先是可见的        PTreeRec(TreeViewFunc.Items[i].Data)^.bVisible := True;        Continue;     end;*)
      sGNFLDM := Trim(PTreeRec(NodeTemp.Data)^.sGNFLDM);
      if (sGNFLDM = '') or (NodeTemp.Level = 0)  then
      begin
        PTreeRec(NodeTemp.Data)^.bVisible := True; //可能是个上级节点，没有功能权限代码
      end
      else
      begin
        PTreeRec(NodeTemp.Data)^.bVisible := CdsPower.FindKey([sGNFLDM]);
      end;

      if PTreeRec(NodeTemp.Data)^.bVisible and (Nodetemp.level > 0) then
      begin
        sModeCode := PTreeRec(NodeTemp.Data)^.sModCode;
        if (sModeCode <> 'SA') and (sModeCode <> 'BAS') (*and (sModeCode <> 'APT') *) then
        begin
          //PTreeRec(NodeTemp.Data)^.bVisible := GetModeMenuItemVisible(sModeCode, PTreeRec(NodeTemp.Data)^.sGnflMc);
          {hch 采用类的处理思路，加快检查的速度}
          PTreeRec(NodeTemp.Data)^.bVisible := (not THideMenu.IsHide(GszGSDM, GszKJND, PTreeRec(NodeTemp.Data)^.sMenuCode));
        end else
          PTreeRec(NodeTemp.Data)^.bVisible := True;
      end
    end;

    //处理上级节点：下级节点都不显示，则上级不显示 lzn
    for i := 0 to TreeViewFunc.Items.Count - 1 do
    begin
      NodeTemp := TreeViewFunc.Items[i];
      if NodeTemp.Data = nil then
        Continue;
        //if not PTreeRec(NodeTemp.Data)^.bVisible then Continue; //不可见节点，不用处理 ，如果是父节点，应该遍历下一个相邻节点；如果有多个子节点，则改行需要注释

      if NodeTemp.HasChildren or (PTreeRec(NodeTemp.Data)^.sModCode='APT') then //找到子节点
        Continue
      else
        tmpNodeParent := NodeTemp.Parent;

      while tmpNodeParent <> nil do
      begin
        if tmpNodeParent.Data = nil then
        begin
          tmpNodeParent := tmpNodeParent.Parent;
          Continue;
        end;
        PTreeRec(tmpNodeParent.Data)^.bVisible := False;
        tmpNodeChild := tmpNodeParent.GetFirstChild;

        while tmpNodeChild <> nil do
        begin
          if tmpNodeChild.Data = nil then
          begin
            tmpNodeChild := tmpNodeChild.GetNextSibling;
            Continue;
          end;
          if PTreeRec(tmpNodeChild.Data)^.bVisible then
          begin
            PTreeRec(tmpNodeParent.Data)^.bVisible := True;
            break;
          end;
          tmpNodeChild := tmpNodeChild.getNextSibling;
        end;

        tmpNodeParent := tmpNodeParent.Parent;
      end;
    end;

  finally
    //// CloseWait;
  end;

end;

procedure TFormMain.CreateDesktopMenuClick(AMenuItem: TMenuItem);
var
  node: TTreeNode;
  i : Integer;
  szGnmc : string;
begin
  {创建桌面快捷方式}
  if FormBackGround <> nil then
  begin
    try
      if AMenuItem.Tag < 900 then
      begin
        node := TreeViewFunc.Items[AMenuItem.Tag];
        FormBackGround.CreateLink(PTreeRec(node.Data)^.sModCode, Trim(AMenuItem.Caption), node.Level);
      end
      else begin
        ShowMessage('该模块不支持创建桌面快捷方式。');
      end;
    except
      ShowMessage('找不到对应的菜单项，无法创建桌面快捷方式。');
      Exit;
    end;
  end;
end;

function TFormMain.FindTreeNodeByModCaption(AText: string): TTreeNode;
var
  i: Integer;
  tmpText, s1, s2: string;
begin
  i := Pos('(&', AText);
  if (i > 0) then
    tmpText := Trim(Copy(AText, 1, i - 1))
  else
    tmpText := Trim(AText);

  i := Pos('[演示版]', tmpText);
  if (i > 0) then
    s1 := Trim(Copy(tmpText, 1, i - 1))
  else
    s1 := Trim(tmpText);

  Result := TreeViewFunc.Items[0];
  while (Result <> nil) do
  begin
    i := Pos('[演示版]', Result.Text);
    if (i > 0) then
      s2 := Trim(Copy(Result.Text, 1, i - 1))
    else
      s2 := Trim(Result.Text);

    if SameText(s1, s2) then
      Exit
    else
      Result := Result.getNextSibling;
  end;
end;

procedure TFormMain.ShowMenuPanel(AMenuButton: TMenuButton);
var
  i: Integer;
  tmpNode: TTreeNode;
begin
  if (AMenuButton <> nil) and (AMenuButton.Menu <> nil) then
  begin
    tmpNode := FindTreeNodeByModCaption(AMenuButton.Menu.Caption);
    if (tmpNode <> nil) and (tmpNode.Level = 0) and (tmpNode.Data <> nil) then
    begin
      // 崔立国 2011.08.23 前台模块菜单首次创建时不创建下属功能菜单，此属性值为False。第一次访问该模块时再创建下属功能菜单，此属性值变为True。
      if (not PTreeRec(tmpNode.Data)^.bSubMenuCreated) then
      begin
        AMenuButton.HideMenuPanelImmediately;
        InitModSubTreeNodeAndMenuBox(tmpNode);
      end;
    end;
  end;
end;

procedure TFormMain.TimerDBSYTimer(Sender: TObject);
begin
  //if TimerDBSY.Tag=1 then begin   //TimerDBSY.Enabled := False;
  MDBSY.Caption := '待办事宜（正在提取...）';
  UpdateDBSY(True, '');
  if (ParamCount>=13) and (GsParamGNFLMC<>'')  then begin  //登录后启动功能
     try
       RunGNFLMC(GsParamGNFLMC);
     finally
       GsParamGNFLMC:='';
     end;
  end;

end;

function TFormMain.GetBKATree(tv: TTreeView): Boolean;
const
  cSQL = 'Select * from DB_Report where (REPORT_TYPE=''0'') or (REPORT_TYPE=''1'' and %s) order by report_name';
var
  i, iIndex: Integer;
  slMenuName: string;
  FirstLst, SecondLst: TStrings;
  BKANode, PNode: TTreeNode;
  Cds: TClientDataSet;
  pRecPtr: PTreeRec;
begin
  BKANode := FindMIDS(tv, '预算执行分析');
  Cds := DataModulePub.GetCdsBySQL(format(cSQL, [PSJQX('RP', 'REPORT_CODE')]));
  FirstLst := TStringList.Create;
  try
    with Cds do
    begin
      if FindFirst then
        repeat
          slMenuName := TString.LeftStrBySp( Cds.FieldByName('REPORT_NAME').AsString, '\');
          if FirstLst.IndexOf(slMenuName) < 0 then
          begin
            PNode := tv.Items.AddChild(BKANode, slMenuName);
            FirstLst.AddObject(slMenuName, PNode);
            New(pRecPtr);
            pRecPtr^.sModCode := 'BKA';
            pRecPtr^.sMenuCode := Cds.FieldByName('REPORT_CODE').AsString;
            pRecPtr^.sGnflmc := Cds.FieldByName('REPORT_CODE').AsString;
            pRecPtr^.sGnflExec := ''; // luzn 2011.11.11 该模块没有对应的bpl文件。
            PNode.Data := pRecPtr;

          end;

          PNode := TTreeNode(FirstLst.Objects[FirstLst.IndexOf(slMenuName)]);
          if PNode <> nil then
          begin
            slMenuName := TString.RightStrBySp(Cds.FieldByName('REPORT_NAME').AsString, '\');
            New(pRecPtr);
            pRecPtr^.sModCode := 'BKA';
            pRecPtr^.sMenuCode := Cds.FieldByName('REPORT_CODE').AsString;
            pRecPtr^.sGnflmc := Cds.FieldByName('REPORT_NAME').AsString;
            pRecPtr^.sGnflExec := ''; // luzn 2011.11.11 该模块没有对应的bpl文件。
            with tv.Items.AddChild(PNode, slMenuName) do
              Data := pRecPtr;
          end;
        until not FindNext;
    end;
  finally
    FirstLst.Free;
    cds.Free;
  end;
end;

function TFormMain.GetGETree(tv: TTreeView): Boolean;
const
  cSQL = 'Select * from DB_Report where (REPORT_TYPE=''0'') or (REPORT_TYPE=''1'' and %s) order by report_name';
var
  slMenuName: string;
  FirstLst, SecondLst: TStrings;
  BKANode, PNode: TTreeNode;
  Cds: TClientDataSet;
  pRecPtr: PTreeRec;
begin
  BKANode := FindMIDS(tv, '分级预警');
  Cds := DataModulePub.GetCdsBySQL(format(cSQL, [PSJQX('RP', 'REPORT_CODE')]));
  FirstLst := TStringList.Create;
  try
    with Cds do
    begin
      if FindFirst then
        repeat
          slMenuName := TString.LeftStrBySp( Cds.FieldByName('REPORT_NAME').AsString, '\');
          if FirstLst.IndexOf(slMenuName) < 0 then
          begin
            PNode := tv.Items.AddChild(BKANode, slMenuName);
            FirstLst.AddObject(slMenuName, PNode);
            New(pRecPtr);
            pRecPtr^.sModCode := 'GE';
            pRecPtr^.sMenuCode := Cds.FieldByName('REPORT_CODE').AsString;
            pRecPtr^.sGnflmc := Cds.FieldByName('REPORT_CODE').AsString;
            pRecPtr^.sGnflExec := 'GE.bpl';
            PNode.Data := pRecPtr;

          end;

          PNode := TTreeNode(FirstLst.Objects[FirstLst.IndexOf(slMenuName)]);
          if PNode <> nil then
          begin
            slMenuName := TString.RightStrBySp(Cds.FieldByName('REPORT_NAME').AsString, '\');
            New(pRecPtr);
            pRecPtr^.sModCode := 'GE';
            pRecPtr^.sMenuCode := Cds.FieldByName('REPORT_CODE').AsString;
            pRecPtr^.sGnflmc := Cds.FieldByName('REPORT_NAME').AsString;
            pRecPtr^.sGnflExec := 'GE.bpl';
            with tv.Items.AddChild(PNode, slMenuName) do
              Data := pRecPtr;
          end;
        until not FindNext;
    end;
  finally
    FirstLst.Free;
    cds.Free;
  end;
end;
procedure TFormMain.DispStatus(ModName: String);
var
  sp:TStatusPanel;
begin
  if (ModName = 'PA') or (ModName = 'PAAC') or (ModName = 'PAO') then
  begin
    if StatusBarMain.Panels.Count <7 then
      sp := StatusBarMain.Panels.Add
    else
      sp := StatusBarMain.Panels[6];
    StatusBarMain.Panels[6].Text := '当前工资类别:'+gvLBDM+'['+gvLBMC+']';
  end
  else
  begin
    if StatusBarMain.Panels.Count =7 then
      StatusBarMain.Panels.Delete(6);
  end;
end;

function TFormMain.FreeEncrypt(sModeName:String): Boolean;
begin
   if (FWndList.GetModeGnCount(sModeName,'')<=0) or (FWndList.FList.Count<=0) then begin //其实此时可能无法检测到已打开的show窗体?
       rMainSub.GsCurFreeAnyiCleintModName := sModeName;
       SendMessage(Self.Handle,WM_DLLMainClose, 0,0); //当前模块所有窗口已关闭了
   end;
end;

function TFormMain.UpdateDBSY(pBupdateMenbox: Boolean; psModeCode: string): Integer;
{ 参数说明：pBupdateMenbox，需要即使更新菜单显示
            psModeCode    :不等于空，表示只更新当前模块的待办信息，等于空，表示更新所有模块的待办信息

}
begin
  TDBSYThread.Create(self, pBupdateMenbox, psModeCode);
end;

{ TDBSYThread }

constructor TDBSYThread.Create(MainForm: TFormMain; NeedUpdateMenuBox: Boolean;
  ModeCode: string);
begin
  inherited Create(True);
  FreeOnTerminate := True;

  FMainForm := MainForm;
  FNeedUpdateMenuBox := NeedUpdateMenuBox;
  FModeCode := ModeCode;

  Resume;
end;

{ Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TDBSYThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

procedure TDBSYThread.Execute;
begin
  if PIniReadS('GlSys.ini', 'SYS_DBSY', 'DBSY_NO', '1')='1' then begin
     FormMain.MDBSY.Caption := '待办事宜';
     Exit;
  end;
  FWorkCount := UpdateDBSY(FNeedUpdateMenuBox, FModeCode);
  if FNeedUpdateMenuBox then
    Synchronize(UpdateMainFormDBSY);
end;

procedure TDBSYThread.UpdateMainFormDBSY;
var
  i, j: Integer;
begin
  FMainForm.MDBSY.Caption := '待办事宜（' + IntToStr(FWorkCount) + '）';

  with FMainForm.TreeViewMYFunc do //更新菜单
  begin
    for i := 0 to Items.Count - 1 do
    begin
      for j := 0 to FMainForm.MDBSY.Count - 1 do
      begin
        if FMainForm.MDBSY.Items[j].Tag = Items[i].AbsoluteIndex then
          FMainForm.MDBSY.Items[j].Caption := Items[i].Text;
      end;
    end;
  end;

  FMainForm.FDailyWorkMenu.LoadMenuItem(FMainForm.mDailyWork);
end;

// 崔立国 2011.06.18 理论上没有线程同步保护的UpdateDBSY()直接访问主窗体菜单时
// 存在与主线程冲突的可能，但实际上主窗体菜单创建后一般不会销毁，所以发生对象
// 访问冲突的机会不存在。因发版时间紧迫暂时这样写，后续有待改进。
// 改进方法：不访问主菜单，而是将查询待办信息的模块列表（TStringList）传入线程。
function TDBSYThread.UpdateDBSY(pBupdateMenbox: Boolean; psModeCode: string): Integer;
{ 参数说明：pBupdateMenbox，需要即使更新菜单显示
            psModeCode    :不等于空，表示只更新当前模块的待办信息，等于空，表示更新所有模块的待办信息

}

  // 崔立国 2011.10.30 因取待办事宜改为线程方式，所以必须用单独的CDS和MidasConnection。
  // 为了不修改Pub_Function不重新编译R9Public.bpl，暂时将新的函数写在这里。
  function GetDbsyGsThread(sModeCode,sProcedureName:string):Integer;
  var
    sSQL: string;
    tmpConnection: TCMidasConnection;
    tmpCDS: TClientDataSet;
    Params,szModecode:String;
  begin
    Result := 0;
    szModecode:= sModeCode;
    if (UpperCase(szModecode)='FBI') and GetISXCZB then
       szModecode:='FBI_XC';

    if Gdbtype = Oracle then
    begin
       sSQL := 'begin '+sProcedureName+'('+
               '  AGsdm=>''' + GszGSDM   + ''',' +
               '  Akjnd=>''' + GszKJND   + ''',' +
               '  AYWRQ=>''' + GszYWRQ   + ''',' +
               '  AMKMC=>''' + szModecode + ''',' +
               '  ACZYID=>'  + IntToStr(GCzy.ID)+','+
               '  pRecCur=>:pRecCur); '+
               ' end;' ;
    end else
    begin
       sSQL := 'Exec '+sProcedureName +
               ' @Gsdm=''' + GszGSDM   + ''',' +
               ' @kjnd=''' + GszKJND   + ''',' +
               ' @YWRQ=''' + GszYWRQ   + ''',' +
               ' @MKMC=''' + szModecode + ''',' +
               ' @CZYID='  + IntToStr(GCzy.ID);
    end;

    CoInitialize(nil);
    try
      // 崔立国 2011.06.18 因取待办事宜改为线程方式，所以必须用单独的CDS和MidasConnection。
      tmpConnection := TCMidasConnection.Create(nil);
      try
        tmpConnection.ClientVersion := DataModulePub.MidasConnectionPub.ClientVersion;
        tmpConnection.ComputerName := DataModulePub.MidasConnectionPub.ComputerName;
        tmpConnection.ConnectType := DataModulePub.MidasConnectionPub.ConnectType;
        tmpConnection.Prefix := DataModulePub.MidasConnectionPub.Prefix;
        tmpConnection.ServerGUID := DataModulePub.MidasConnectionPub.ServerGUID;
        tmpConnection.ServerName := DataModulePub.MidasConnectionPub.ServerName;
        tmpConnection.ServerPlatform := DataModulePub.MidasConnectionPub.ServerPlatform;
        tmpConnection.ServerPort := DataModulePub.MidasConnectionPub.ServerPort;
        tmpConnection.URL := DataModulePub.MidasConnectionPub.URL;
        tmpConnection.Connected := True;
        //hch 自动直连 2012.05.05 Oracle自动直连，中间层的数据库类型等没有改变出错
        if tmpConnection.ConnectType = ctDCOM then
        begin
          with tmpConnection do
          begin
            if GDBType=MSSQL then
               AppServer.changedb(MSSQL,GsDatabaseName)  //在直连模式下，因为app.dll里面总是连接到oracle数据库，应该改app.dll里的代码，但此代码不全且需要更新所有用户客户端的此文件，所以临时改这个地方，强制连到mssq  20140627
            else
               AppServer.ChangeDB('ORACLE', '');

            Params := 'ServerName='+GsServerName;
            Params := Params + #8+'&DatabaseName='+GsDatabaseName;
            Params := Params + #8+'&Username='+GsUserName;
            Params := Params + #8+'&Password='+GsPassword;
            Params := Params + #8+'&DBType='+IFF(GDBType=MSSQL, 'MSSQL', 'ORACLE');
            AppServer.SetDBinfo(Params);
          end;
        end;
        tmpCDS := TClientDataSet.Create(nil);
        try
          try
            tmpCDS.RemoteServer := tmpConnection;
            tmpCDS.ProviderName := 'DataSetProviderData';

            POpenSQL(tmpCDS, sSQL);
            if tmpCDS.Active then
              Result := tmpCDS.RecordCount;
          except
          end;
        finally
          tmpCDS.Free;
        end;
      finally
        tmpConnection.Free;
      end;
    finally
      CoUninitialize;
    end;
  end;

var
  i, j, iDBSYGS, iDBSYZS,iPos: Integer;
  sMenuName, sModeCode, sGnScripts: string;
  CurNode: TTreeNode;
begin
  Result := 0;
  iDBSYZS := 0;

  with FMainForm.TreeViewMyFunc do
  begin
    for i := 0 to Items.Count - 1 do
    try
      CurNode := Items[i];
      sModeCode := pTreeRec(CurNode.Data)^.sModCode;
      //只更新当前模块
      if (psModeCode <> '') and (psModeCode <> sModeCode) then
        Continue;

      sMenuName := CurNode.text;
      iPos := Pos('（',sMenuName);    //定时刷新待办事宜时，节点文本有（,这里重新取出
      if iPos>0 then begin
         sMenuName := Copy(sMenuName,1,iPos-1);
      end;

      //iDBSY := GetHaveDBSY(sModeCode);

      iDBSYGS := 0;
      //case iDBSY of
      //  -3:
      //begin // 通过存储过程，获取待办信息，但效率很慢，不建议在这里写
      sGnScripts := pTreeRec(CurNode.Data)^.sGnScripts;
      if Trim(sGnScripts) = '' then
        Continue;
      iDBSYGS := GetDbsyGsThread(sModeCode, sGnScripts);
      CurNode.Text := sMenuName + '（' + IntToStr(iDBSYGS) + '）';
      //end;

      (*  -2:
          begin //没有待办信息
            CurNode.Text := sMenuName + '（' + IntToStr(iDBSYGS) + '）';
          end;

        -1:
          begin //有待办信息，但不知道个数
            CurNode.Text := sMenuName + '（有待办信息）';
          end;

      else
        begin //有待办信息，但不知道个数
          if iDBSY >= 0 then
          begin
            iDBSYGS := iDBSY;
            CurNode.Text := sMenuName + '（' + IntToStr(iDBSYGS) + '）';
          end;
        end;
      end; *)

      iDBSYZS := iDBSYZS + iDBSYGS;

      if (psModeCode <> '') and (psModeCode = sModeCode) then //只更新当前模块
         Break;

    except
    end;

  end;

  Result := iDBSYZS;

end;

procedure TFormMain.NDB_DBClick(Sender: TObject);
var
  i:Integer;
  MenuItemTemp:TMenuItem;
begin
  if Sender=nil then Exit;
  MenuItemTemp :=TMenuItem(Sender);

  if MenuItemTemp.Tag=-2 then begin
     TimerDBSY.Enabled := False;
     PIniWriteS('GlSys.ini', 'SYS_DBSY', 'DBSY_NO', '1');
  end else begin
     if MenuItemTemp.Tag=-5 then begin
        i := 5;
     end else if MenuItemTemp.Tag=-10 then begin
        i := 10;
     end else if MenuItemTemp.Tag=-20 then begin
        i := 20;
     end else if MenuItemTemp.Tag=-30 then begin
        i := 30;
     end else if MenuItemTemp.Tag=-60 then begin
        i := 60;
     end;

     TimerDBSY.Enabled := False;
     TimerDBSY.Interval := i * 1000 * 60;
     TimerDBSY.Enabled := True;
     PIniWriteS('GlSys.ini', 'SYS_DBSY', 'DBSY_NO', '0');
     PIniWriteS('GlSys.ini', 'SYS_DBSY', 'DBSY_MINU', IntToStr(i));
  end;
  MenuItemTemp.Checked := True; //not MenuItemTemp.Checked;
  FDailyWorkMenu.LoadMenuItem(mDailyWork);  
end;

procedure TFormMain.RadioDBSY;
var
  MenuItemTemp:TMenuItem;
  sDBSY:string;

  function GetMenuItemTemp(iT:Integer):TMenuItem;
  var
  i:Integer;  
  begin
     if TempMenuDBSYRef <> nil then 
     for i:=0 to TempMenuDBSYRef.Count-1 do begin
         if TempMenuDBSYRef.Items[i].Tag = iT then begin
            MenuItemTemp := TempMenuDBSYRef.Items[i]; //MenuItemTemp := (FindComponent('NDB_NO') as TMenuItem);
            Break;
         end;
     end;
  end;
begin
  //with TempMenuDBSYRef do
  if GpsSeries = psR9 then Exit;   
  try
    MenuItemTemp := nil;
    if PIniReadS('GlSys.ini', 'SYS_DBSY', 'DBSY_NO', '1')='1' then begin
       GetMenuItemTemp(-2);
    end else begin
       sDBSY := PIniReadS('GlSys.ini', 'SYS_DBSY', 'DBSY_MINU', '5');
       if sDBSY='5' then begin
          GetMenuItemTemp(-5);
       end else if sDBSY='10' then begin
          GetMenuItemTemp(-10);
       end else if sDBSY='15' then begin
          GetMenuItemTemp(-15);
       end else if sDBSY='25' then begin
          GetMenuItemTemp(-25);
       end else if sDBSY='35' then begin
          GetMenuItemTemp(-35);
       end;
    end;
    if MenuItemTemp<>nil then begin
       NDB_DBClick(MenuItemTemp);
    end;
  except
  end;
end;

procedure TFormMain.BeforeAPT(Sender: TObject; var AParams: String);
var
  GProSign_temp : string; 

  function FindAPT(AMenuItem: TMenuItem):Boolean;
  begin
    Result := false;
    while AMenuItem.Parent <> nil do
    begin
      //10.2中将APT会计平台拆为APT 总账通用接口插件和APP总账国库接口插件 ，所以修改并区分APP和APT modified by chengjf 20140925
//      if Pos('会计平台', Trim(AMenuItem.Caption))>0  then //有时会有演示版字样
      if Pos('总账通用接口插件', Trim(AMenuItem.Caption))>0  then //有时会有演示版字样
      begin
        Result := True;
        break;
      end; 
      AMenuItem := AMenuItem.Parent;
    end;
  end;
  function FindAPP(AMenuItem: TMenuItem):Boolean;
  begin
    Result := false;
    while AMenuItem.Parent <> nil do
    begin
      //10.2中将APT会计平台拆为APT 总账通用接口插件和APP总账国库接口插件 ，所以修改并区分APP和APT modified by chengjf 20140925
//      if Pos('会计平台', Trim(AMenuItem.Caption))>0  then //有时会有演示版字样
      if Pos('总账国库接口插件', Trim(AMenuItem.Caption))>0  then //有时会有演示版字样
      begin
        Result := True;
        break;
      end; 
      AMenuItem := AMenuItem.Parent;
    end;
  end;

begin
{ 会计平台加密问题解决了，跟踪了大半天，几层函数。
  LoadModeDll(sModeName, sGnflMc, sGnflExec);
  这个函数第3个参数应该是bpl包的名字或者为空，要是每次传入的值不一样，则会创建多个UIR9_IMPL实例，并导致每打开一个窗口，就创建一个加密
}
  {在执行命令之前，先下载APT}
  GAPTConnectEncrypt:=False;
  if (Sender <> nil) and FindAPT(TMenuItem(Sender)) then
     Self.LoadModeDll('APT', TMenuItem(Sender).Caption, 'APT')
  else if (Sender <> nil) and FindAPP(TMenuItem(Sender)) then
     Self.LoadModeDll('APP', TMenuItem(Sender).Caption, 'APP')
  else if Sender=nil then   //浮动菜单走这个分支，要纳入FslUIR9_IMPL的管理，才能管理其加密
     Self.LoadModeDll('APT', sCurAPTsGnflmc, 'APT')
  else if Sender<>nil then begin
     //FindAPT(TMenuItem(Sender))返回False，不一定会计平台下的节点菜单都挂在APT模块下
     GProSign_temp := GProSign;  
     Self.LoadModeDll('APT', TMenuItem(Sender).Caption, 'APT'); //Self.LoadModeDll('APT', '自动凭证', 'APT');
     if GProSign_temp<>'SYS' then
        GProSign := GProSign_temp;  //for ZWR900156965  在动态库VoucherCSH.dll自动凭证中会调用execute gl.bpl导致的，此方法绕过不少代码
  end;


end;

procedure TFormMain.MyBTimerExit(Sender: TObject);
begin
  BTimer.Enabled := False;
  if Application <> nil then
       Application.Terminate
  else Halt;
end;

procedure TFormMain.TimerCATimer(Sender: TObject);
var
  sKey: string;
begin
  //上海格尔CA 不进行此验证，因为网关有控制900s不操作自动断开，此时读CA编码读不到，完全受网关相关控制即可 Added by chengjf 2015-03-26 9:14:54
  if LoginKeyIntf.LoginKeyCanWriteGE then Exit;
  if GCzy.bCA then begin
     sKey := '';
     try
       sKey := LoginKeyIntf.ReadUserKEY_CA;
     except
     end;
     if sKey='' then begin
        SysMessage('您必须使用CA证书才能进入系统。'+#13+'程序将在20秒内自动退出,请注意保存重要信息！','Login_01_JG', [mbOK]);
        if BTimer=nil then begin
           BTimer := TTimer.Create(nil);
           BTimer.Enabled := False;
        end;
        BTimer.Interval := 20000; //20 seconds
        BTimer.OnTimer := MyBTimerExit;
        BTimer.Enabled := True;
     end;
  end;
end;

procedure TFormMain.NGNFLClick(Sender: TObject);
var
  i: Integer;
  tmpNode: TTreeNode;
  procedure AddQuitMenu(AParentMenu: TMenuItem); //创建退出菜单
  var
    TempMenu: TMenuItem;
  begin
    TempMenu := TMenuItem.Create(AParentMenu);
    TempMenu.Caption := '-';
    AParentMenu.Add(TempMenu);

    TempMenu := TMenuItem.Create(AParentMenu);
    TempMenu.Action := ActExit;
    AParentMenu.Add(TempMenu);
    TempMenu.Tag := -1;
  end;
begin
  // 崔立国 2011.11.11 取消一次初始化所有模块菜单的处理方式。增加 Exit 直接退出代码。
  Exit;
(*
  // 崔立国 2011.10.26 登录后第一次点"功能"菜单时构建所有模块的下级功能子菜单。
  if (NGNFL.Tag > 0) then Exit;
  NGNFL.Tag := 1;

  // 因为菜单不断增加中，所以必须倒序循环！！！           
  for i := TreeViewFunc.Items.Count - 1 downto 0 do
  begin
    tmpNode := TreeViewFunc.Items[i];
    if (tmpNode <> nil) and (tmpNode.Level = 0) and (tmpNode.Data <> nil) then
    begin
      // 崔立国 2011.08.23 前台模块菜单首次创建时不创建下属功能菜单，此属性值为False。第一次访问该模块时再创建下属功能菜单，此属性值变为True。
      if not PTreeRec(tmpNode.Data)^.bSubMenuCreated then
      begin
        InitSubFuncTreeNode(tmpNode);
        PTreeRec(tmpNode.Data)^.bSubMenuCreated := True;
      end;
    end;
  end;
  AddQuitMenu(NGNFL); //创建退出菜单
  ReActiveXPMenu;
  FMenuBox.RefreshMenus;
  *)
end;

procedure TFormMain.ReActiveXPMenu;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TXPMenu then
    begin
      TXPMenu(Components[i]).Active := False;
      TXPMenu(Components[i]).Active := True;
      Exit;
    end;
  end;
end;

procedure TFormMain.InitSubFuncMenu(AMenu: TMenuItem);
var
  i: Integer;
  tmpNode: TTreeNode;
begin
  if (AMenu <> nil) then
  begin
    tmpNode := FindTreeNodeByModCaption(AMenu.Caption);
    if (tmpNode <> nil) and (tmpNode.Level = 0) and (tmpNode.Data <> nil) then
    begin
      // 崔立国 2011.08.23 前台模块菜单首次创建时不创建下属功能菜单，此属性值为False。第一次访问该模块时再创建下属功能菜单，此属性值变为True。
      InitModSubTreeNodeAndMenuBox(tmpNode);
    end;
  end;
end;

function TFormMain.GetOERDJLX(tv: TTreeView): Boolean;
var
  szJKDSQL,szBXDSQL,szMenuName: String;
  OERModNode, OERFuncNode, PNode: TTreeNode;
  ACds: TClientDataSet;
  pRecPtr: PTreeRec;
begin
  ACds := TClientDataSet.Create(nil);
  try
    //先查找模块的节点
    OERModNode := FindLevel0Node(tv,'网上报销');
    if OERModNode = nil then
      Exit;
    //再查找要添加菜单的功能菜单
    OERFuncNode := FindLevelNode(tv,OERModNode,'业务处理');
    if OERFuncNode = nil then
      Exit;
    //查询借款单的SQL语句
    szJKDSQL := 'select * from oer_djlx where gsdm='''+GszGSDM+''' and kjnd='''+GszKJND+''''
      +' and DJLXID<900 and YWLX=''0'' and ' + PSJQX('OBLX','DJLXBM') + 'and syzt=''2'' order by djlxbm';
    //查询报销单的SQL语句
    szBXDSQL := 'select * from oer_djlx where gsdm='''+GszGSDM+''' and kjnd='''+GszKJND+''''
      +' and DJLXID<900  and YWLX=''2'' and ' + PSJQX('OBLX','DJLXBM') + 'and syzt=''2'' order by djlxbm';

    //先处理报销单
    ACds.Data := DataModulePub.GetDataBySQL(szBXDSQL);
    if ACds.RecordCount > 0 then
    begin
      ACds.First;
      while not ACds.eof do
      begin
        New(pRecPtr);
        pRecPtr^.sModCode := 'OER';
        pRecPtr^.sMenuCode := ACds.FieldByName('DJLXBM').AsString;
        pRecPtr^.sGnflmc := ACds.FieldByName('DJLXMC').AsString;
        pRecPtr^.sGnflExec := 'OER.bpl';
        PNode := tv.Items.AddChildFirst(OERFuncNode,ACds.FieldByName('DJLXMC').AsString);
        PNode.Data := pRecPtr;
        ACds.Next;
      end;
    end;

    //再处理借款单
    ACds.Data := DataModulePub.GetDataBySQL(szJKDSQL);
    if ACds.RecordCount > 0 then
    begin
      ACds.First;
      while not ACds.eof do
      begin
        New(pRecPtr);
        pRecPtr^.sModCode := 'OER';
        pRecPtr^.sMenuCode := ACds.FieldByName('DJLXBM').AsString;
        pRecPtr^.sGnflmc := ACds.FieldByName('DJLXMC').AsString;
        pRecPtr^.sGnflExec := 'OER.bpl';
        PNode := tv.Items.AddChildFirst(OERFuncNode,ACds.FieldByName('DJLXMC').AsString);
        PNode.Data := pRecPtr;
        ACds.Next;
      end;
    end;
  finally
    FreeAndNil(ACds);
  end;
end;

function TFormMain.FindLevel0Node(tv: TTreeView; aName: string): TTreeNode;
var
  iCount: integer;
begin
  Result := nil;
  for iCount := 0 to tv.Items.Count - 1 do
  begin
    if tv.Items[iCount].Level = 0 then
    begin
      if (Pos(aName, tv.Items[iCount].Text) > 0) then
      begin
        Result := tv.Items[iCount];
        break;
      end;
    end;
  end
end;

function TFormMain.FindLevelNode(tv: TTreeView; ANode: TTreeNode;
  AName: String): TTreeNode;
var
  iCount,iLevel: integer;
begin
  Result := nil;
  iLevel := -1;
  for iCount := 0 to tv.Items.Count - 1 do
  begin
    if ANode.Text = tv.Items[iCount].Text then
    begin
      iLevel := ANode.Level;
      break;
    end;
  end;
  if iLevel <> -1 then
    iLevel := iLevel + 1;
  for iCount := 0 to ANode.Count -1 do
  begin
    if ANode.Item[iCount].Level = iLevel then
    begin
      if Pos(AName,ANode.Item[iCount].Text) > 0 then
      begin
        Result := ANode.Item[iCount];
        Break;
      end;
    end;
  end;
end;

function TFormMain.IsMIDSNode(Node: TTreeNode): Boolean;
var
  ANode: TTreeNode;
begin
  ANode := Node;
  while ANode.Level <> 0 do
  begin
    ANode := ANode.Parent;
  end;
  Result := PTreeRec(ANode.Data)^.sModCode = 'MIDS';
end;

procedure TFormMain.SpeedButton_xzdwClick(Sender: TObject);
begin
  MIChangeUnitClick(nil);
end;

procedure TFormMain.UMSWITCHGZLB(var AMsg: TMessage);
begin
  DispStatus(rMainSub.GsCurModName);
end;

procedure TFormMain.N6Click(Sender: TObject);
begin
  try
    FormLogin := TFormLogin.Create(Application);
    FormLogin.ReChoseUnitLogin(1);
  finally
    FormLogin.Free;
  end;
end;

procedure TFormMain.MCalculatorClick(Sender: TObject);
var
  AKey: Char;
begin
  PRegNC(MCalculator);
  RxCalculatorMain.Tag := 0;
  AKey := '+';
  RxCalculatorMain.Execute(AKey);
end;

procedure TFormMain.NFDMenuClick(Sender: TObject);
begin
  NFDMenu.Checked := not NFDMenu.Checked;
  if NFDMenu.Checked then
       PIniWriteS('GlSys.ini', 'NMainMenu', 'NFDMenu', '1')
  else PIniWriteS('GlSys.ini', 'NMainMenu', 'NFDMenu', '0');
  SysMessage('选项已改变，请重新登录。', '', [mbOk]);
end;

procedure TFormMain.NDWZTClick(Sender: TObject);
begin
  NDWZT.Checked := not NDWZT.Checked;
  if NDWZT.Checked then
       PIniWriteS('GlSys.ini', 'NMainMenu', 'NDWZT', '1')
  else PIniWriteS('GlSys.ini', 'NMainMenu', 'NDWZT', '0');
  SysMessage('选项已改变，请重新登录。', '', [mbOk]);
end;

procedure TFormMain.N7Click(Sender: TObject);
begin
  if not TPower.GetPower('9425') then //Gqx[ord(CZYGL_Edit)] then
  begin
    SysMessage('您没有该权限。', 'PZ_97_JG', [mbOK]);
    Exit;
  end;
  ChangeUsername;
end;

procedure TFormMain.mniBinaryGetClick(Sender: TObject);
var
  filePath:string;
begin
  //zhengjy 20140429 采用数据流方式通讯
  FilePath :=ExtractFilePath(Application.ExeName)+'_HTTP_CDS_';  
  if not mniBinaryGet.checked then
  begin
    if not FileExists(FilePath) then
      FileCreate(FilePath);
  end else begin
    if FileExists(FilePath) then
      DeleteFile(FilePath);
  end;
  mniBinaryGet.checked :=not mniBinaryGet.checked;
  if FormMain.mniBinaryGet.Checked  then DataModuleMain.SetR9PacketsCDS(true)
  else DataModuleMain.SetR9PacketsCDS(false);
end;

procedure TFormMain.mniUserStateClick(Sender: TObject);
begin
//  if FrmUserState=nil then FrmUserState :=TFrmUserState.Create(Application);
//  FrmUserState.Show;
  //更改单元调用方式 Modified by chengjf 2015-04-08
  LoadUserState;
end;

procedure TFormMain.tmrLockFormTimer(Sender: TObject);
begin
  if (tmrLockFormMin.Enabled) or (frmLockForm<>nil) then
    Exit;
  //解决参数改为0，马上重新登录后还会弹出一次锁定框的问题，因为那时tmrLockForm.Enabled仍为true add by chengjf 20151022
  if GblLockFormTime=0 then
  begin
    tmrLockForm.Enabled :=false;
    exit;
  end;
  if IsIconic(Application.Handle) then
  begin
    tmrLockForm.Enabled :=false;
    tmrLockFormMin.Enabled :=true;
    exit;
  end;
  tmrLockForm.Enabled:=false;
  frmLockForm:=TfrmLockForm.Create(Application);
  frmLockForm.ShowModal;
  if frmLockForm<>nil then FreeAndNil(frmLockForm);
end;

procedure TFormMain.tmrLockFormMinTimer(Sender: TObject);
begin
  if not IsIconic(Application.Handle) then
  begin
    tmrLockFormMin.Enabled:=false;
    frmLockForm:=TfrmLockForm.Create(Application);
    frmLockForm.ShowModal;
    if frmLockForm<>nil then FreeAndNil(frmLockForm);
  end;

end;

procedure TFormMain.OnMyMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if (frmLockForm=nil) and (GblLockFormTime<>0) and GbSysLoginOK then
  begin
    if (Msg.message=WM_MOUSEMOVE) or  (Msg.message=WM_KEYDOWN) then //Self.Active) and
    begin
      tmrLockForm.Interval :=GblLockFormTime*60*1000;
      tmrLockForm.Enabled :=False;
    end else begin
      tmrLockForm.Interval :=GblLockFormTime*60*1000;
      tmrLockForm.Enabled :=true;
    end;
  end;
end;

procedure TFormMain.SetBitmapBtn(AimgLst: TImageList; Aimg: TImage;
  id: Integer);
begin
  Aimg.Picture.Bitmap.Width := 0;
  AimgLst.GetBitmap(id,Aimg.Picture.Bitmap);
end;

procedure TFormMain.DoMouseEvent(Atag,Atype: Integer);
var
  id,iCount:Integer;
begin
  iCount := Length(DArrayPnls);
  for id := 0 to iCount - 1 do
  begin
    if not DArrayActive[id] then
      DArrayPnls[id].Visible := False
    else
    begin
      DArrayPnls[id].Visible := True;
      DArrayPnls[id].Align := alClient;
    end;

    if (id <> Atag) or (Atype = 1) then
    begin
      if DArrayActive[id] then
        SetBitmapBtn(ImageListBtn,DArrayImgs[id],3)
      else
        SetBitmapBtn(ImageListBtn,DArrayImgs[id],1);
    end else
    begin
      if DArrayActive[id] then
        SetBitmapBtn(ImageListBtn,DArrayImgs[id],4)
      else
        SetBitmapBtn(ImageListBtn,DArrayImgs[id],2);
    end;

  end;
end;

function TFormMain.ChangeUnit: Boolean;
var
  i: integer;
begin
  Result := False;
  if (Self.MDIChildCount = 0) or ((Self.MDIChildCount = 1) and (Self.MDIChildren[0].Name = 'FormBackGround')) then
  begin
  end
  else
  begin
      SysMessage('重新注册需要先关闭所有打开的窗口，否则某些没有保存的数据可能丢失！', '', [mbOk]);
      exit;
  end;
  Result := True;
end;

function TFormMain.ChangeDWZT: Boolean;
var
  i: integer;
begin
  Result := False;
  if (Self.MDIChildCount = 0) or ((Self.MDIChildCount = 1) and (Self.MDIChildren[0].Name = 'FormBackGround')) then
  begin
  end
  else
  begin
      if SysMessage('重新注册需要先关闭所有打开的窗口，否则某些没有保存的数据可能丢失！'+#13#10
          +'所有打开的窗口都将关闭，是否继续？', '', [mbOK, mbCancel]) = MrCancel then
      exit;
      if (MDIChildCount > 1) then
      begin
//        if SysMessage('所有打开的窗口都将关闭，是否继续？', '', [mbOK, mbCancel]) = mrOk then
        begin
          for i := MDIChildCount - 1 downto 0 do
          begin
            if (MDIChildren[i] <> nil) and
              (not (MDIChildren[i] is TFormBackGround)) then
              MDIChildren[i].Close;
          end;
        end;
      end;
  end;
  Result := True;
end;

procedure TFormMain.SetMainBorder;
var
  tc:TColor;
begin
  //img
  ImageListBtn.GetBitmap(3,imgFunc.Picture.Bitmap);

  //
  rxlblFunc.Caption := '';
  rxlblAccount.Caption := '';
  rxlblFunc.BringToFront;
  rxlblAccount.BringToFront;
end;

procedure TFormMain.SetDArrayPnls;
var
  ilen:Integer;
begin
  ilen := 2;
  SetLength(DArrayPnls,ilen);
  SetLength(DArrayImgs,ilen);
  SetLength(DArrayActive,ilen);
  SetLength(DArrayTitle,ilen);

  rxlblFunc.Tag := 0;
  rxlblAccount.Tag := 1;
  //img
  DArrayImgs[0] := imgFunc;
  DArrayImgs[1] := imgAccInfo;
  //pnl
  DArrayPnls[0] := PanelFunc;
  DArrayPnls[1] := pnlAccInfoSelect;

  DArrayActive[0] := True;
  DArrayActive[1] := False;

  DArrayTitle[0] := '  功能导航';
  DArrayTitle[1] := '  单位账套';
end;

procedure TFormMain.rxlblFuncClick(Sender: TObject);
var
  id:Integer;
  bGetAccInfo:Boolean;
  iVD: Integer;
  szDWZT : string;
  Tempnode : TTreeNode;
begin
  for id := 0 to Length(DArrayActive) do
  begin
    if id <> (Sender as TRxLabel).Tag then
      DArrayActive[id] := False
    else
    begin
      DArrayActive[id] := True;
      Label4.Caption := DArrayTitle[id];
      Label4.Update;
    end;
  end;

  DoMouseEvent((Sender as TRxLabel).Tag,2);

  if Sender = rxlblAccount then
  begin
    //根据加密情况设置最大业务日期 chengjf 20150608
    if not GAnyiLicenseInfo.IsConnected then begin
      // 崔立国 2010.12.07 MaxDate必须是最大演示日期 + 1。否则最后一天不能登录。
      // 例如最大演示日期11月30日，则MaxDate必须是12月1日0时0分0秒，而不是11月30日0时0分0秒。
      DateTimePickerBusinessDate.MaxDate := TString.StrToDate(AI_DEMO_DATE); // + 1;   控制到11.30号23.59.59前可以登录，12.01号应该不允许登录
    end else
    // 崔立国 2015.04.02 如果加密授权设置了有效期(VD>0)，则前台登录日期不能超过该有效期。
    if TryStrToInt(GAnyiLicenseInfo.VD, iVD) then
    begin
      if iVD > 0 then
        DateTimePickerBusinessDate.MaxDate := iVD;
    end;
    DateTimePickerBusinessDate.Date := TString.StrToDate(Copy(GszYWRQ, 1, 4) + '-' + Copy(GszYWRQ, 5, 2) + '-' + Copy(GszYWRQ, 7, 2));

    DataModulePub.ClientDataSetPub.Close; //and '+PSJQX('G', 'hsdwdm')+'
    POpenSql(DataModulePub.ClientDataSetPub, 'select * from gl_ztcs where hsdwdm <>''99999999999999999999'' '+
       ' and kjnd='''+GszKJND+''' and ' + PSJQX('ZT', 'ztbh') + ' and hsdwdm '
    +' in (Select b.gsdm from (select GSDM, GSMC from pubgszl where kjnd=''' + GszKJND
    +'''  and ' + PSJQX('G', 'gsdm') + ') a, pubgszl b  where b.KJND='''+GszKJND+''' and '
    +'  a.gsdm like b.gsdm'+GSQLStrADDChar+'''%'')'+' order by hsdwdm,ztbh ');
    PInitializeAccountTree(tvAccInfo,DataModulePub.ClientDataSetPub);
    EditInput.SetFocus;
    szDWZT := GszZth+ ' ' + GszZTMC;
    bExitFind := False;
    FCurrNodeNum := '';
    Tempnode := tvAccInfo.Items.GetFirstNode;
    treeFindnode(Tempnode,szDWZT);
  end;
end;

procedure TFormMain.rxlblFuncMouseEnter(Sender: TObject);
begin
  DoMouseEvent((Sender as TRxLabel).Tag,0);
end;

procedure TFormMain.rxlblFuncMouseLeave(Sender: TObject);
begin
  DoMouseEvent((Sender as TRxLabel).Tag,1); 
end;

procedure TFormMain.tvAccInfoClick(Sender: TObject);
begin
  if ActEnableClick.Checked then
  begin
//    if isHide then
//      PN_mainShow(False);
    tvAccInfoDblClick(nil);
  end;
end;

procedure TFormMain.tvAccInfoCollapsed(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := 0;
  Node.SelectedIndex := 0;
end;

procedure TFormMain.tvAccInfoDblClick(Sender: TObject);
var
  FGszGSDM, FYWRQ, FGszHSDWDM, FGszHSDWMC, FGszZth, FGszZTMC: string;
  PRegister: TRegistry;
begin
//  if not ChangeUnit then Exit;
  if not ChangeDWZT then Exit;
  if tvAccInfo.Selected=nil then exit;
  //维护单20151231092454 切换前先保存桌面配置 add by chengjf 20160121
  if Assigned(FormBackGround) then begin
     FormBackGround.SaveConfig(gCZy.name);
     FormBackGround.SaveDesktopImageSettings;
  end;

//  if tvAccInfo.Selected.ImageIndex<>2 then exit;
  //明细级都可以切换
  if tvAccInfo.Selected.HasChildren then exit;

  //保存旧
  FGszGSDM := GszGSDM;
  FGszHSDWDM := GszHSDWDM;
  FGszHSDWMC := GszHSDWMC;
  FGszZth := GszZth;
  FGszZTMC := GszZTMC;
  FYWRQ := GszYWRQ;


//  if PublicUnit_SZ.DisplayAccount then
  if tvAccInfo.Selected.ImageIndex=2 then  //账套
  begin
    GszGSDM := pDecodeDM(tvAccInfo.Selected.Parent.Text);
    GszHSDWMC := pDecodeDMP(tvAccInfo.Selected.Parent.Text);
    GszZth := pDecodeDM(tvAccInfo.Selected.Text);
    GszZTMC := pDecodeDMP(tvAccInfo.Selected.Text);
  end else   //末级单位
  begin
    GszGSDM := pDecodeDM(tvAccInfo.Selected.Text);
    GszHSDWMC := pDecodeDMP(tvAccInfo.Selected.Text);
    GszZth := '';
    GszZTMC := '';
  end;
  GszHSDWDM:=GszGSDM;
  GszYWRQ := PGetPickerDate(DateTimePickerBusinessDate);
  //点击当前单位，不进行切换 Added by chengjf 2015-04-24
  if (FGszGSDM = GszGSDM) and (FGszZth = GszZth) and (FYWRQ = GszYWRQ) then Exit;
  //if Application.FindComponent('FormLogin') = nil then
  try
    Application.CreateForm(TFormLogin,FormLogin);
  //登录失败
    if not FormLogin.ChgUnitLogin then
    begin
      GszGSDM := FGszGSDM;
      GszHSDWDM := FGszHSDWDM;
      GszHSDWMC := FGszHSDWMC;
      GszZth := FGszZth;
      GszZTMC := FGszZTMC;
      GszYWRQ := FYWRQ;
      DateTimePickerBusinessDate.Date := TString.StrToDate(Copy(GszYWRQ, 1, 4) + '-' + Copy(GszYWRQ, 5, 2) + '-' + Copy(GszYWRQ, 7, 2));
      try
        PRegister := TRegistry.Create;
        PRegister.RootKey := HKEY_CURRENT_USER;
        if PRegister.OpenKey(FormLogin.RegLoginPath, True) then //领导查询模式登录,则登录信息不记录到注册表
        begin
          PRegister.WriteString('Dwdm', GszHSDWDM);
          PRegister.WriteString('Dwmc', GszHSDWMC);
          PRegister.WriteString('Ztbh', GszZth);
          PRegister.WriteString('Ztmc', GszZTMC);
          PRegister.CloseKey;
        end;
        FormLogin.SpeedButtonOKClick(nil);
      finally
        PRegister.Free;
      end;
    end else
      InitStatusBar;
  finally
    if Application.FindComponent('FormLogin') <> nil then
    FormLogin.Free;
  end;

//  if isHide then
//    PN_mainShow(False);
  //hch 2009-07-26 更换单位后直接显示功能树
  rxlblFuncClick(rxlblFunc);
end;

procedure TFormMain.tvAccInfoExpanded(Sender: TObject; Node: TTreeNode);
begin
  Node.ImageIndex := 1;
  Node.SelectedIndex := 1;
end;

procedure TFormMain.StatusBarMainDblClick(Sender: TObject);
begin
  if GpsSeries = psR9 then Exit;
  if not ChangeDWZT then Exit;
  if Assigned(FormBackGround) then begin
     FormBackGround.SaveConfig(gCZy.name);
     FormBackGround.SaveDesktopImageSettings;
  end;

  //更换单位
  try
    GbAutoLogin := True;  // DSL
    FormLogin := TFormLogin.Create(Application);
    FormLogin.ReChoseUnitLogin(0);
  finally
    FormLogin.Free;
  end;
end;

function TFormMain.GetFDADJLX(tv: TTreeView): Boolean;
var
  szSQL,szMenuName: String;
  OERModNode, OERFuncNode, PNode: TTreeNode;
  ACds: TClientDataSet;
  pRecPtr: PTreeRec;
begin
   ACds := TClientDataSet.Create(nil);
  try
    //先查找模块的节点
    OERModNode := FindLevel0Node(tv,'经费申请');
    if OERModNode = nil then
      Exit;
    //再查找要添加菜单的功能菜单
    OERFuncNode := FindLevelNode(tv,OERModNode,'业务处理');
    if OERFuncNode = nil then
      Exit;

    szSQL:=' select * from FDA_DJLX where gsdm='''+ GszGSDM +'''' +
           ' and kjnd='''+ GszKJND + ''''+
           ' and syzt=''2'' and ' + PSJQX('FDADJ','DJLXBM') + ' order by fbzt';

    ACds.Data := DataModulePub.GetDataBySQL(szSQL);
    if ACds.RecordCount > 0 then
    begin
      ACds.last;               //发现直连方式 order by   desc不起作用，只能倒序增加菜单，保证直连和中间层显示的一样
      while not ACds.Bof do
      begin
        New(pRecPtr);
        pRecPtr^.sModCode := 'GSP';
        pRecPtr^.sMenuCode := ACds.FieldByName('DJLXBM').AsString;
        pRecPtr^.sGnflmc := ACds.FieldByName('DJLXMC').AsString;
        pRecPtr^.sGnflExec := 'GSP.bpl';
        PNode := tv.Items.AddChildFirst(OERFuncNode,ACds.FieldByName('DJLXMC').AsString);
        PNode.Data := pRecPtr;
        ACds.Prior;
      end;
    end;
  finally
    FreeAndNil(ACds);
  end;
end;

function TFormMain.GetGloabNum(Anode: TTreeNode;ChildNum : string) : string;
var
  szNum : string;
begin
  szNum := IntToStr(Anode.Index);
  if ChildNum<>'' then
    szNum := szNum + '-' + ChildNum;
  if Anode.Parent <> nil then
    szNum := GetGloabNum(Anode.Parent,szNum);
  Result := szNum;
end;

procedure TFormMain.treeFindnode(Anode: TTreeNode;FindStr : string);
var
  i: integer;
  node: TTreeNode;
  szNodeNum : string;
  bFind : Boolean;
begin
//  szCurrNode := CurrNode;
//  if bExitFind then Exit;
  for i := 0 to Anode.Count - 1 do
  begin
    if bExitFind then Exit;
    bFind := True;
    Node := ANode.Item[i];
    szNodeNum := GetGloabNum(Node,'');
    if FCurrNodeNum<>'' then
    begin
      bFind := False;
      if szNodeNum <> FCurrNodeNum then
        bFind := False
      else begin
        FCurrNodeNum := '';
      end;
    end;

    if bFind and (Pos(FindStr,node.text) > 0) then
    begin
      tvAccInfo.Selected := node;
      bExitFind := True;
      Exit;
    end;
    if (node.Count > 0)   then
      treeFindnode(Node,FindStr);
  end;
end;

procedure TFormMain.EditInputChange(Sender: TObject);
var
  Tempnode: TTreeNode;
begin
  bExitFind := False;
  Tempnode := tvAccInfo.Items.GetFirstNode;
  treeFindnode(Tempnode,EditInput.Text);
end;

procedure TFormMain.btnDWZTClick(Sender: TObject);
var
  Tempnode: TTreeNode;
  szSelected : string;
begin
  bExitFind := False;
  Tempnode := tvAccInfo.Items.GetFirstNode;
  if tvAccInfo.selected.Text = '单位账套' then
    FCurrNodeNum := ''
  else
    FCurrNodeNum := GetGloabNum(tvAccInfo.selected,'');
  treeFindnode(Tempnode,EditInput.Text);
end;

procedure TFormMain.EditInputKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 114 then
    btnDWZTClick(nil); //F3 mxl 2002.04.28 for R9.1
end;

procedure TFormMain.btnYwrqClick(Sender: TObject);
var
  FGszGSDM, FYWRQ, FGszHSDWDM, FGszHSDWMC, FGszZth, FGszZTMC: string;
  PRegister: TRegistry;
begin
//  if not ChangeUnit then Exit;
  if not ChangeDWZT then Exit;
  //维护单20151231092454 切换前先保存桌面配置 add by chengjf 20160121
  if Assigned(FormBackGround) then begin
     FormBackGround.SaveConfig(gCZy.name);
     FormBackGround.SaveDesktopImageSettings;
  end;

  //保存旧
  FGszGSDM := GszGSDM;
  FGszHSDWDM := GszHSDWDM;
  FGszHSDWMC := GszHSDWMC;
  FGszZth := GszZth;
  FGszZTMC := GszZTMC;
  FYWRQ := GszYWRQ;

  GszYWRQ := PGetPickerDate(DateTimePickerBusinessDate);
  if FYWRQ = GszYWRQ then Exit;
  try
    Application.CreateForm(TFormLogin,FormLogin);
    //登录失败
    if not FormLogin.ChgUnitLogin then
    begin
      GszGSDM := FGszGSDM;
      GszHSDWDM := FGszHSDWDM;
      GszHSDWMC := FGszHSDWMC;
      GszZth := FGszZth;
      GszZTMC := FGszZTMC;
      GszYWRQ := FYWRQ;
      DateTimePickerBusinessDate.Date := TString.StrToDate(Copy(GszYWRQ, 1, 4) + '-' + Copy(GszYWRQ, 5, 2) + '-' + Copy(GszYWRQ, 7, 2));
      try
        PRegister := TRegistry.Create;
        PRegister.RootKey := HKEY_CURRENT_USER;
        if PRegister.OpenKey(FormLogin.RegLoginPath, True) then //领导查询模式登录,则登录信息不记录到注册表
        begin
          PRegister.WriteString('Dwdm', GszHSDWDM);
          PRegister.WriteString('Dwmc', GszHSDWMC);
          PRegister.WriteString('Ztbh', GszZth);
          PRegister.WriteString('Ztmc', GszZTMC);
          PRegister.CloseKey;
        end;
        FormLogin.SpeedButtonOKClick(nil);
      finally
        PRegister.Free;
      end;
    end else
      InitStatusBar;
  finally
    if Application.FindComponent('FormLogin') <> nil then
    FormLogin.Free;
  end;

//  if isHide then
//    PN_mainShow(False);
  //hch 2009-07-26 更换单位后直接显示功能树
  rxlblFuncClick(rxlblFunc);
end;

procedure TFormMain.RunAutoLoad;
var
  szSQL, szGnflmc, szModcode, szGnflexec, szGnid : string;
  cdsAutoLoad : TClientDataSet;
begin
  if not PGetTable('pub_autoload') then Exit;
  cdsAutoLoad := TClientDataSet.Create(nil);
  szSQL := 'select * from pub_autoload where isautoload=''1'' order by xh';
  POpenSql(cdsAutoLoad,szSQL);
  with cdsAutoLoad do
  begin
    while not Eof do
    begin
      szGnid := fieldByName('gnid').AsString;
      szModcode := fieldbyName('modcode').AsString;
      szGnflmc := fieldbyName('gnflmc').AsString;
      szGnflexec := fieldbyName('gnflexec').AsString;
      if (szGnid <> '') and not (TPower.GetPower(szGnid)) then
      begin
        Next;
        Continue;
      end;
//        LoadModeDll('BAS', '往来单位资料', 'bas.bpl');
      try
        LoadModeDll(szModcode, szGnflmc, szGnflexec);
      except
      end;
      Next;
    end;
  end;
end;

initialization
  HashNodeList := THashedStringList.Create;

finalization
  // ClearHashNodeList;
  HashNodeList.Free;
  FreeAndNil(Global_SYS);

end.

