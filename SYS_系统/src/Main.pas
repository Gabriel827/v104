unit Main;
(*  �˵�����·����LZN�ܽ� 2012.03.09  label052301test

 1.Login��Ԫ�е�¼֮��
    if FormMain.AfterLoginInitData() then
    AfterLoginInitData����Ҫ�Ǵ����ݿ⣬��ȡȨ�����ݣ���ִ�й���������ʼ������InitPubSYS
    begin
       BlLoginOk := true;
       ModalResult := mrOK;
       PostMessage(FormMain.Handle, UM_AFTERLOGIN, 0, 0);   //������Ϣ��ִ�� AfterLoginInitMenu
    end;

 2.AfterLoginInitMenu���Ǵ����˵����������˵�����ʼ������������TPublicModSYS�������µ�¼����ϵͳ����������������˵�
   1) InitFuncTree  ��ִ��InitModTreeNode
      a. InitModTreeNode    ����ǰ̨ģ��˵����ڵ�
         ��gl_gnfl���˵���ִ�� CreateMenuTree ����TreeViewFunc ��
          ������ʾ��˵�

   2) FMenuBox.LoadMenuItem(NGNFL);             ���ص������˵���
      FDailyWorkMenu.LoadMenuItem(mDailyWork);  ���ص��������˲˵���
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

  //=====�˵������ݽṹ
  PTreeRec = ^TTreeRec;
  TTreeRec = record
    sModCode: string; //ģ���ʶ
    sMenuCode: string; //�˵�����
    sGNFLDM: string; //���ܴ���
    sGnflMc: string; //��������
    sGnflExec: string; //����̬���ļ�
    sShortCut: string; //��ݼ�
    GszVersion: string; //���ܱ�ʶ
    bDemo: Boolean;
    bVisible: Boolean;
    sRpt: string;
    sGnScripts: string;
    bSubMenuCreated: Boolean; // ������ 2011.08.23 ǰ̨ģ��˵��״δ���ʱ�������������ܲ˵���������ֵΪFalse����һ�η��ʸ�ģ��ʱ�ٴ����������ܲ˵���������ֵ��ΪTrue��
  end;

  TDLLGNRec = record //���ö�̬��ʱ��Ҫ��������Ϣ
    sModeName: string;
    sGnflMc: string;
    bNewMode: Boolean; //�Ƿ񴴽�����ģ��
    iFunIndex: Integer; //��Ӧ�Ĳ˵���ʶ
    bClickTask: Boolean; //�Ƿ�����������    //DLLHandle:HWND;
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
    //�޺�����Ŀ����˫�������л���λ�Ĵ��� Added by chengjf 2016-01-13
    procedure StatusBarMainDblClick(Sender: TObject);
    procedure EditInputChange(Sender: TObject);
    procedure btnDWZTClick(Sender: TObject);
    procedure EditInputKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnYwrqClick(Sender: TObject);

  private
    { Private declarations }
    FLeftIsHide: Boolean; // ��ࣨ�����������Ƿ�����
    FLeftIsHideSel: Boolean; // ��ࣨ���ù��ܣ����Ƿ�����
    FLeftIsHideAll: Boolean; // ��ࣨȫ�����ܣ����Ƿ�����
    FMyFuncRoot: TTreeNode; //�ղؼй��ܸ��ڵ�
    OtherProNode: TTreeNode; //������Ʒ�ڵ�
    OtherProStringList: TStringList; //������Ʒ�б�
    CanExecFunc: Boolean;
    FOrgMenuItem: TStringList;

    // ������ 2010.05.11 ���ڱ�����
    FWinIconRect: TRect;
    FWinMinBtnRect: TRect;
    FWinMaxBtnRect: TRect;
    FWinCloseBtnRect: TRect;
    FDownWinBtn: Integer;
    FMenuBox: TMenuBox;
    FDailyWorkMenu: TMenuBox;
    FWinCaptionDrawing: Boolean;

    {�����������½���ʾ���Ӵ��� R96 20050614 zhouyunlu}
    FWndList: TMDIChildList;
    FOldClientProc, FNewClientProc: TFarProc;
    ActiveMIDPre: TForm; //ǰһ������Ĵ���
    BTimer:TTimer;
    FCurrNodeNum : string;
    bExitFind : Boolean;  //�˳�����
    //zhengjy 2014-10-11 ����������������汾������ͨ��
    procedure OnMyMessage(var Msg: TMsg; var Handled: Boolean);
    procedure SetBitmapBtn(AimgLst:TImageList;Aimg:TImage;id:Integer);
    //�������
    procedure SetMainBorder;
    //�����������ֵ
    procedure SetDArrayPnls;
        //�����¼�,Atype:0:leave,1:enter;
    procedure DoMouseEvent(Atag,Atype:Integer);
    //��������򿪴���
    function ChangeUnit:Boolean;
    //�л�����ʱ��������򿪴���
    function ChangeDWZT:Boolean;
    procedure ClientWndProc(var Message: TMessage);
    procedure onPopup(Index: Integer; var Popop: Boolean);

    // procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure RefreshBG;
    procedure WMERASEBKGND(var Msg: TWMERASEBKGND); message WM_ERASEBKGND;
    procedure WMSETCURSOR(var Msg: TWMSETCURSOR); message WM_SETCURSOR;

    procedure WMDLLMainClose(var Msg: TMessage); message WM_DLLMainClose; //�ͷŰ�
    //procedure WMInitEncryptDemo(var Msg: TMessage); message WM_InitEncryptDemo; //��������˵�����ʾ����ʾ����Ϣ
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

    // ������ 2010.04.20 ��ʼ��������Ƥ����ʽ
    procedure InitMainFormSkin;
    // ������ 2010.04.21 ����Ƥ��
    procedure MSkinMenuClick(Sender: TObject);
    // ������ 2010.05.10 �ϲ���������Ӵ���˵�
    procedure UpdateMIDMenuBar(AMainMenu: TMainMenu);
    // ������ 2010.05.26 �޸�״̬������֧���ػ�
    procedure UpdateStatusBar;
    procedure treeFindnode(Anode: TTreeNode;FindStr : string);
    //ȡ�ڵ�Ψһ��� add by chengjf 20160323
    function GetGloabNum(Anode: TTreeNode;ChildNum : string) : string;
    procedure RunAutoLoad;
    (*procedure WMNCLButtonUp(var Message: TWMNCLButtonUp); message WM_NCLBUTTONUP;
    procedure WMNCHitText(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure UpdateWinBtnRect; *)

  protected
    procedure PRegNC(AMenuItem: TMenuItem); //�Զ�����˵�����
    procedure InitFuncTree;
    procedure InitMenu; //���ò˵�/Ȩ��
    procedure ReActiveXPMenu;

    procedure InitFunTreeNode; // ������ 2011.08.23 Ϊ����״ε�¼�ٶȣ�InitFunTreeNode �����ѱ� InitModTreeNode ϵ�к����滻��
    procedure InitModTreeNode; // ������ 2011.08.23 ����ǰ̨ģ��˵����ڵ�
    procedure InitSubFuncTreeNode(ANode: TTreeNode); // ������ 2011.08.23 ����ǰ̨ģ��˵����ڵ��������ܲ˵�
    procedure InitSubFuncMenu(AMenu: TMenuItem);
    function FindTreeNodeByModCaption(AText: string): TTreeNode;
    Procedure INitSAMenu;
    procedure INitAQRMenu;

    //��д���ڴ���ʱ�Ŀͻ������ڹ��� �����ø��Ӵ��� R96 20050614
    procedure CreateWnd; override;
    // 2007-10-25 14:48 hch ���ͳһ��ȡ�ּ��Ľӿ�    //procedure InitFJ;
    procedure SetBitMap(img: TBitmap; index: Integer);
    //�����ⲿӦ�ó���ִ��
    procedure ChangeYearMenuItemClick(Sender: TObject);
    //�����ⲿӦ�ó����Ȩ���ж�
    function CheckPowerFun(GnID: Integer): Boolean;
    {�ж��Ƿ�Ϊ����ڵ�}
    function IsAQRNode(Node: TTreeNode): Boolean;
    {�ж��Ƿ�Ϊ�쵼���߽ڵ�}
    function IsMIDSNode(Node: TTreeNode): Boolean;  //added by guozy 2012-02-17
    {����MIDS�Ĳ�ѯ�˵�}
    function GetMIDSTree(tv: TTreeView): Boolean;
    {����Ԥ��ִ�з���������}
    function GetBKATree(tv: TTreeView): Boolean;
    {����Ԥ��ִ�з���������}
    function GetGETree(tv: TTreeView): Boolean;
    {�������ϱ�����ҵ�񵥾ݲ˵�}
    function GetOERDJLX(tv: TTreeView): Boolean;
    {�����ÿ�����ҵ�񵥾ݲ˵�}
    function GetFDADJLX(tv:TTreeView):Boolean;
    //����ģ��ڵ�
    function FindLevel0Node(tv: TTreeView; aName: string): TTreeNode;
    //����ģ��ָ�����ܽڵ�
    function FindLevelNode(tv: TTreeView; ANode: TTreeNode; AName: String): TTreeNode;
    {��ʾ��ǰѡ��Ĺ������}
    procedure DispStatus(ModName: String);
    //procedure SetTreeDemoText;
    procedure InitTreeQXKZ; //�˵���ʾ����
  public
    AnyiClient1: TAnyiClient;
    FMenu: TMergerMenu;
    FslUIR9_IMPL: TslUIR9_IMPL; //��̬������࣬��������ӿ���    //FListDLL:TStringList;
    FSkin: string;
    TempMenuDBSYRef: TMenuItem;
    sCurAPTsGnflmc:string;
    procedure InitModSubTreeNodeAndMenuBox(ANode: TTreeNode);  // ������ 2011.08.23 ����ǰ̨ģ��˵����ڵ��������ܲ˵���ˢ�²˵��С�

    procedure InitStatusBar;
    function AfterLoginInitData: Boolean;
    function AfterLoginInitMenu: Boolean;
    function MenuOnClick(AMenuItem: TMenuItem; ItemText, ParentText: string): Boolean;
    procedure FuncTreeClick(ATreeView: TTreeView = nil); //procedure ClearShortCutMenu; //�����ݲ˵�
    // ������ 2010.04.20 ��ʼ��������Ƥ����ʽ
    procedure InitNoExistsImage;
    procedure CreateSkinMenu;
    procedure AfterMainFormSkinChanged; virtual;
    procedure LoadModeDll(psModeName, sGnflMc, sGnflExec: string); //ParamList:string='';
    function InitPubSYS: Boolean;
    //procedure UpdateMainMenuDemo(psModeName:String);
	function UpdateDBSY(pBupdateMenbox: Boolean; psModeCode: string): Integer;
    function FreeEncrypt(sModeName:String):Boolean; //�ͷ�ģʽ����ļ���
    procedure BeforeAPT(Sender:TObject; var AParams: String);
    procedure RadioDBSY;
  end;

  // ������ 2011.06.18 �������˸�Ϊ���̲߳�ѯ��ʽ������������ȴ�ʱ�������
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
  GbCaPinLogin:Boolean=False; //CA��֤���Ż�����Pin���뵽�ͻ��˵�¼
  GsPin : string='';
  GbAutoLogin:Boolean=False;      // DSL
  // ������ 2011.08.23 HashParentList�������游�ڵ�ָ�룬��߲���Ч�ʡ�
  HashNodeList: THashedStringList;
  Gszkjnd_First:String; //�״ε�¼�����ȣ����ڲ�ѯ������Ⱥ��˻�
  GbAgainLogin:Boolean=False; //��ǰ��¼�Ƿ������µ�¼
  DArrayPnls:array of TPanel;
  DArrayImgs:array of TImage;
  DArrayActive:array of Boolean;
  DArrayTitle:array of string;
    
// ��TreeView�д����˵���
procedure CreateMenuTree(Tree: TTreeView; Query: TClientDataSet; NeedClear, AVisible: Boolean);

//Procedure CreateDWTree(Tree:TTreeView;Query:TClientDataSet;NodeSJ:TTreeNode);
function InterceptText(S: string): string; //ȡ�ַ���Sstr�У��ַ�'('֮ǰ���ַ���
function GetSYSHelpFile: string;
//zhengjy 20140717 �������̨ͨѶ��ʽ��XML ��CDS��ʽ
procedure SetR9PacketsCDS;

implementation

uses Pub_Function, Pub_Message, Pub_Power, PubClass_GL,
  Login, {$IFNDEF ocx}BackGroundUnit, PLAT_LAWRULEMANAGER, {$ENDIF}PLAT_Utils,
  About, Pub_Res, CZRZ, ChgPassword, OtherProLstEdit, GLPreview, Wait, DataSyncDownload,
  uRptCaller,LoginKeyIntf, ChgUsername,SYS_YHTDCL,FBSIP_ZFSBCX,SYS_HTAlarm,UUserStatus,ULockForm{,
  UIKey, SYS_DBSY};

// ������ 2010.05.11 ���ڱ�������ʱ����
//FWinCaptionBmp: TBitmap;

{$R *.DFM}
procedure SetR9PacketsCDS;
var
  szSQL:string;
begin
  szSQL :='select csvalue from pub_ztcs where gsdm=''99999999999999999999'' and kjnd=''9999'' and csdm=''SYS_CONFIG''';
  try
    POpenSQL(DataModulePub.ClientDataSetTmp,szSQL);
    //zhengjy 20140813 �ж��Ƿ��м�¼��ֵΪ�գ���ֹCASE���ǿת����ʱ�����쳣
    if (DataModulePub.ClientDataSetTmp.RecordCount<=0)
      or (Trim(DataModulePub.ClientDataSetTmp.FieldByName('csvalue').AsString)='') then
    begin
      DataModuleMain.SetR9PacketsCDS(False);
      FormMain.mniBinaryGet.Visible :=false;
      Exit;
    end;
    case DataModulePub.ClientDataSetTmp.FieldByName('csvalue').AsInteger of
      0:begin  //����ͨѶ��ʽXML�������ز˵�
        DataModuleMain.SetR9PacketsCDS(False);
        FormMain.mniBinaryGet.Visible :=false;
      end;
      1:begin  //����ѡ������ͨѶ��ʽ�������ز˵�
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

// ��TreeView�д����˵���
procedure CreateMenuTree(Tree: TTreeView; Query: TClientDataSet; NeedClear, AVisible: Boolean);
// NodeSJ ��ʾ���Ե�ǰ�ڵ���Ϊ�������ĸ��ڵ���
var
  ParentNode: TTreeNode;
  sModCode, sMenuCode, sMenuName, sGnflmc, sGnflExec, sShortCut, sGNFLDM, sGnScripts, sGNFL_Ver,sGNFL_VerHB,sVercode: string;
  Cds:TClientDataSet;
  // ������ 2011.08.23 ԭ�� FindParentЧ�ʽϵͣ���ΪFindHashParent()��
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
    pRecPtr^.bVisible := AVisible; //(TempNode=nil); //һ���ڵ�ɼ�
    Result := Tree.Items.AddChildObject(TempNode, psMenuName, pRecPtr);
    Result.ImageIndex := 2;
    Result.SelectedIndex := 2;
    // ������ 2011.08.23 ǰ̨ģ��˵��״δ���ʱ�������������ܲ˵���������ֵΪFalse��
    //                   ��һ�η��ʸ�ģ��ʱ�ٴ����������ܲ˵���������ֵ��ΪTrue��
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
  if GszRelease='��������' then begin
    sGNFL_Ver:=',ZF_'+GszEdition+',';
    sGNFL_VerHB:=',XZ_'+GszEdition+',' //������������ҵ�ϲ���
       
  end else if GszRelease='������ҵ����' then begin
    sGNFL_Ver:=',XZ_'+GszEdition+',';
    sGNFL_VerHB:=',ZF_'+GszEdition+',' //������������ҵ�ϲ��� 
  end else if GszRelease='��������' then
    sGNFL_Ver:=',WS_'+GszEdition+','
  else if GszRelease='��������' then
    sGNFL_Ver:=',JY_'+GszEdition+','
  else if GszRelease='�籣����' then
    sGNFL_Ver:=',SB_'+GszEdition+','

  else if GszRelease='����' then
    sGNFL_Ver:=',CZ_'+GszEdition+','
  else if GszRelease='�������' then
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

        // ������ 2011.11.01 ֻ�� TreeViewFunc ��Ϊ���ܲ˵�������Ų���Hash���ٶ�λ��TreeViewMyFunc�������˲���Ҫ��
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
            //��ǰ�汾�ù��ܲ����ã�����������һ����¼
            if sGNFL_VerHB='' then begin
               Continue;
            end else begin
               if Pos(sGNFL_VerHB,sVercode)=0 then  //������������ҵ��ϲ��ˣ�����2�߲˵����Ի���
                  Continue;
            end;      
          end;
        end;

        ParentNode := nil;
        if (Length(sMenuCode) > 2) then
        begin
          // ������ 2011.11.01 ֻ�� TreeViewFunc ��Ϊ���ܲ˵�������Ų���Hash���ٶ�λ��TreeViewMyFunc�������˲���Ҫ��
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
  //hch ֻ��ʼ��һ�Σ���λᵼ��һЩ����
  TPlugDev.FreeInvoke;
  //2009-4-15 ����Exe�Ĳ��Ӧ��
  TPlugDev.LoadFun;
  TPlugDev.LoadLib; //����Lib���Ӧ��
  Result := False;
  GszGSDM := GszHSDWDM;
  try
    GOldGqx := Gqx; //GsProductSign := 'SA;GL;GAL;FA;PA;CM;FBI;GBG';   //��Ҫ���ݵ�ǰ���ݿ��д��ڵ�ģ��Ȩ����ƴ�� 99?
    cdsTemp := GetPower(Gqx, GCzy.ID); //�õ��²���Ա���¹���Ȩ�ޣ�������ԱȨ�޸�ֵ
    CdsPower.Data := cdsTemp.Data;
    CdsPower.IndexFieldNames := 'GNFLDM';
    // ������ 2010.10.12 ����Ӧ�ã�ֻ��������¼��ƾ֤����֧����ˡ����ˣ�������ģ��ֻ�ܲ�ѯ����¼�롣
    if GblOfflineMode then
      GetOfflinePower(Gqx);
  except
    SysMessage('Ȩ�����ݲ���ȷ������¼�Ŀ����Ǿɰ汾�����ݿ⣬��Ը����ݿ��������ٵ�¼��', '', [mbOK]);
    Gqx := GOldGqx;
    Exit;
  end;

  GblTerminateApp := False;
  InitPubSYS; //��ʼ������ҵ�����
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
  // 2007-10-25 14:49 hch ���ͳһ��ȡ�ּ� //InitFJ;
  // 2008.12.23 hy ��ʹ������ĺ����ˣ���ϵͳ��ʼ��ʱ��ͳһ�������ʼ��

  try
    Label4.Caption := '  ��ʼ���˵�...';
    Label4.Update;

    FOrgMenuItem.Clear;
    InitFuncTree; //��ʼ�������������˵�
    Label4.Caption := '  ���ع��ܲ˵�...';
    Label4.Update;

    InitMenu; //���ò˵�����
    Label4.Caption := '  ���ز˵����...';
    Label4.Update;

    InitStatusBar; //��ʼ��״̬��

    //��ʼ�����������
    szSQL := 'Select Count(*) num from PubModSetup where gsdm=''' + CSysDWDM + ''' and ModName=''SYS''';
    //szSQL := 'Select Count(*) num from pubModSetup where IsStart=''1''  and Gsdm<>'+QuotedStr(CSysDWDM);
    POpenSql(DataModulePub.ClientDataSetTmp, szSQL);
    if (DataModulePub.ClientDataSetTmp.FieldByName('num').AsInteger <= 0) then
    begin //LoadXTCS;
      for i := 0 to TreeViewFunc.Items.Count - 1 do
      begin
        if Pos('ϵͳ��ʼ������', TreeViewFunc.Items[i].Text) > 0 then
        begin
          TreeViewFunc.Items[i].Selected := True;
          bGiReLogin := True; // ������ʼ�����ô��ڣ���Ҫ�ں��浯�������ⴰ�ڳ�������
          //rMainSub.GiReLogin := 2;         //��ʾ���ڵ�¼�������ײ������ֺ���Ҫǿ�Ƶ�½
          //FuncTreeClick(TreeViewFunc);
          Break;
        end;
      end;
    end;

    Label4.Caption := '  ���������˵�...';
    Label4.Update;

    FMenuBox.LoadMenuItem(NGNFL);
    FDailyWorkMenu.LoadMenuItem(mDailyWork);

    Label4.Caption := '  ��ʼ������...';
    Label4.Update;

    if Assigned(FormBackGround) then
       FormBackGround.LoadConfig(GCzy.name);

    (* // ������ 2009.02.25 �� FormCreate ʱ TimerDemo.Enabled := False;
    if GszRelease = 'DEMO' then begin // ��ʾ����� Lzn 20060918 For R97
      TimerDemo.Enabled := True;
      TimerDemo.Interval := 15 * 60 * 1000; //15 minutes
    end; *)
   
    if Global_SYS=nil then begin
       Global_SYS := TPublicModSYS.Create;
    end else
       Global_SYS.BakGlobal;

    Label4.Caption := '  ��ѯ��������...';
    Label4.Update;
    if GpsSeries <> psR9 then begin
       TimerDBSY.Enabled := True; //���µ�¼ʱҲ��ִ������ ,��������ⴥ���¼�
       TimerDBSYTimer(nil);
       RadioDBSY;
    end;

    if GCzy.bCA then begin
       TimerCA.Interval := 12 * 60 * 1000; //12����
       TimerCA.Enabled := True;
    end else
       TimerCA.Enabled := False;

    Label4.Caption := '  ���ܵ���';
    Result := True;

  finally
    CloseWait;
  end;

  if bGiReLogin then begin
     rMainSub.GiReLogin := 2;         //��ʾ���ڵ�¼�������ײ������ֺ���Ҫǿ�Ƶ�½
     FuncTreeClick(TreeViewFunc);
  end;
  //FMenuBox.Visible := False;

  //20140529--wjh--���������˵���ѯ--Ȩ�޺Ͳ��������Ƿ�
  if TPower.GetPower('1169') and IsShowYHTDCLFrom then Load_SYS_YHTDCL;
  if TPower.GetPower('1170') and IsShowYHTDCLFrom then Load_FBSIP_ZFSBCX;

  //20141113-yangxda-��ͬ����
  if TPower.GetPower('6535') and IsShowHTAlarm then LoadHTALARM(0,False);
  //�����Զ����еĹ��� add by chengjf 20160822
  RunAutoLoad;
  //�����������Ѵ���    ZWR900404058\ZWR900404059 ȥ��  
//  if TPubModSetup.IsStart(GszGSDM, 'GSP') or TPubModSetup.IsStart(GszGSDM, 'GBI')
//    or TPubModSetup.IsStart(GszGSDM, 'GCP') or TPubModSetup.IsStart(GszGSDM, 'OER') then
//    LoadDBSY;
end;

procedure TFormMain.InitStatusBar;
var
  szTemp,szYSND: string;
begin
  if Trim(GCZY.CzyCode)='' then
       szTemp := '����Ա��[' + IntToStr(GCzy.ID)+'] ' + GCzy.Name
  else szTemp := '����Ա��[' + IntToStr(GCzy.ID)+' '+Trim(GCZY.CzyCode) + '] ' + GCzy.Name;

  StatusBarMain.Panels[1].Width := StatusBarMain.Canvas.TextWidth(szTemp) + 20;
  StatusBarMain.Panels[1].Text := szTemp;

  //wjh--20141106--ά����ZWR900211942  �����ò���Ԥ�� ״̬�� ���Ԥ�����
  if TPubModSetup.IsStart(GszGSDM,'DBGFS') then
  begin
     szYSND:=PGetKJND(GszYWRQ,True);
     szTemp := 'ҵ�����ڣ�' + GszYWRQ+'  Ԥ����ȣ�'+IFF(szYSND<>'',szYSND,GszKJND)
  end
  else
  szTemp := 'ҵ�����ڣ�' + GszYWRQ;
  
  StatusBarMain.Panels[2].Width := StatusBarMain.Canvas.TextWidth(szTemp) + 20;
  StatusBarMain.Panels[2].Text := szTemp;

  if GszHSDWDM <> CSysDWDM then
    szTemp := '��λ��[' + GszHSDWDM + '] ' + GszHSDWMC
  else
    szTemp := '��λ��[ϵͳ����λ]';

  StatusBarMain.Panels[3].Width := StatusBarMain.Canvas.TextWidth(szTemp) + 20;
  StatusBarMain.Panels[3].Text := szTemp;

  szTemp := '���ף�' + '[' + GszZth + '] ' + GszZtmc;
  StatusBarMain.Panels[4].Width := StatusBarMain.Canvas.TextWidth(szTemp) + 20;
  StatusBarMain.Panels[4].Text := szTemp;

 (* if DataModulePub.MidasConnectionPub.ServerGUID = CLocalServerGUID then  �л���httpģʽʱ���Ĵ���ִ�������⣬��ע��
    if GDbType = Oracle then
      szTemp := '���ݿ��������' + GsServerName + ' [' + GsUserName + '] '
    else
      szTemp := '���ݿ��������' + GsServerName + ' [' + GsDatabaseName + '] '
  else if DataModulePub.MidasConnectionPub.ServerGUID = COfflineServerGUID then
    szTemp := ' ��ǰ�ǡ����߹���ģʽ�������ֹ����ܵ����Ʋ���ʹ�ã�'
  else
    szTemp := 'Ӧ�÷�������' + GszServerComputer;
  *)
  if DataModulePub.MidasConnectionPub.ConnectType = ctDCOM then begin
     if GDbType = Oracle then
          szTemp := '���ݿ��������' + GsServerName + ' [' + GsUserName + '] '
     else szTemp := '���ݿ��������' + GsServerName + ' [' + GsDatabaseName + '] '
  end else if DataModulePub.MidasConnectionPub.ServerGUID = COfflineServerGUID then
       szTemp := ' ��ǰ�ǡ����߹���ģʽ�������ֹ����ܵ����Ʋ���ʹ�ã�'
  else szTemp := 'Ӧ�÷�������' + GszServerComputer;

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
    if not SameText(MDIChildren[i].Caption, '����') then
    begin
      MDIChildren[i].BringToFront;
    end;

  if not SameText(AMDI.Caption, '����') then
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
    SysMessage('���µ�¼ǰ��ر����д򿪵Ĵ��ڡ�', '', [mbOk]);
    Exit;
  end;
  
  if Assigned(FormBackGround) then begin
     FormBackGround.SaveConfig(gCZy.name);
     FormBackGround.SaveDesktopImageSettings;
  end;

  GbCaPinLogin := False;  //���µ�¼ʱҪ���pin����
  GsPin := '';
  //if not AlertCLoseAllWindow('���µ�¼ǰ��ر����д򿪵Ĵ��ڡ�',FormBackGround) then Exit;

  PRegNC(MRelogin);
  FGszGSDM := GszGSDM;
  FGszHSDWDM := GszHSDWDM;
  FGszHSDWMC := GszHSDWMC;
  FGszZth := GszZth;
  FGszZTMC := GszZTMC;
  FYWRQ := GszYWRQ;
  FKJND := GszKJND;
  FCzy := GCzy;
  GszGSDM311 := ''; //���µ�¼Ҫ��գ��������������ݿ�
  GbAgainLogin :=True;
  if SysReLogin then
  begin
    // ������ 2011.10.26 ��¼���һ�ε�"����"�˵�ʱ��������ģ����¼������Ӳ˵���
    NGNFL.Tag := 0;
    if GpsSeries = psR9i then
    begin
      //���µ�½��Ĭ����ʾ������  add by chengjf 20150507
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
      if Pos('ϵͳ����',TreeViewFunc.Items[i].Text)>0 then begin
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
      if Pos('���ӱ���',TreeViewFunc.Items[i].Text)>0 then begin
         InitSubFuncTreeNode(TreeViewFunc.Items[i]);
         Exit;
      end;
  end;
end;

procedure TFormMain.InitFuncTree;
var
  iCount: Integer;
  TempMenuDBSY: TMenuItem;  

  procedure AddMenu(AParentMenu: TMenuItem; Node: TTreeNode); //�������˲˵�
  var
    TempMenu: TMenuItem;
    iM: Integer;
    sShortCut: string;
  begin //szCaption := Node.Caption; ipos := Pos('(', szCaption); if ipos > 0 then  szCaption := copy(szCaption, 1, iPos - 1);
    (*if GCzy.ID <> 1 then
    begin //ϵͳ����ԱĬ�������пɼ��˵�����Ϊ������Ȩ�ޣ����ϵͳ����Ա�Ĵ���Ч��
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

  procedure InitMyNode; //��������
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

      //ֻ��ʾ�����˵�
      sWhere := sWhere + ' (modcode in (select modName from pubmodsetup where gsdm=''' + Gszgsdm +
        ''' and isstart=1)) and ';
      sWhere := Trim(sWhere);
      if sWhere <> '' then //ȥ�� and
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
        MDBSY.Caption := '�������ˣ�������ȡ...��';
      end;
      for i := 0 to Items.Count - 1 do
      begin
        if Items[i].Level = 0 then
          AddMenu(MDBSY, Items[i]);
      end;
    end;

    TempMenuDBSYRef := TMenuItem.Create(MDBSY);
    TempMenuDBSYRef.Name := 'NDB_DS';
    TempMenuDBSYRef.Caption := '��ʱˢ��';
    TempMenuDBSYRef.OnClick := nil;
    TempMenuDBSYRef.Tag := -1;
    MDBSY.Add(TempMenuDBSYRef);

    TempMenuDBSY:= TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_NO';
    TempMenuDBSY.Caption := '��ˢ��';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;
    TempMenuDBSY.Checked := True;
    TempMenuDBSY.Tag := -2;
    TempMenuDBSYRef.Add(TempMenuDBSY);
        
    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_5';
    TempMenuDBSY.Caption := '5����';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;
    TempMenuDBSY.Tag := -5;
    TempMenuDBSYRef.Add(TempMenuDBSY);

    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_10';
    TempMenuDBSY.Caption := '10����';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;
    TempMenuDBSY.Tag := -10;
    TempMenuDBSYRef.Add(TempMenuDBSY);

    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_20';
    TempMenuDBSY.Caption := '20����';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;    
    TempMenuDBSY.Tag := -20;
    TempMenuDBSYRef.Add(TempMenuDBSY);

    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_30';
    TempMenuDBSY.Caption := '30����';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;
    TempMenuDBSY.Tag := -30;
    TempMenuDBSYRef.Add(TempMenuDBSY);

    TempMenuDBSY := TMenuItem.Create(TempMenuDBSYRef);
    TempMenuDBSY.Name := 'NDB_60';
    TempMenuDBSY.Caption := '60����';
    TempMenuDBSY.OnClick := NDB_DBClick;
    TempMenuDBSY.GroupIndex:=1;
    TempMenuDBSY.RadioItem:= True;     
    TempMenuDBSY.Tag := -60;
    TempMenuDBSYRef.Add(TempMenuDBSY);            

    TreeViewMyFunc.FullExpand;
  end;

begin
  try //hch ������µ�½�ͷŵ�����
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

  // ������ 2011.08.23 HashNodeList�������游�ڵ�ָ�룬��߲���Ч�ʡ�
  HashNodeList.Clear;
  FMenuBox.Visible := NFDMenu.Checked;  
  if NFDMenu.Checked then begin
     InitModTreeNode;
  end;
  // ������ 2011.08.23 Ϊ����״ε�¼�ٶȣ�InitFunTreeNode �����ѱ� InitModTreeNode ϵ�к����滻��
  if not NFDMenu.Checked then begin
     InitFunTreeNode; //����������
  end;
  INitSAMenu;//Ҫ�ȳ�ʼ��ϵͳ����ģ����¼��˵�����Ϊ�״ε�¼ϵͳʱҪʹ�ó�ʼ�������˵�
  //�����������ʽ�£��Զ��屨����ʾ������ Added by chengjf 2015-04-13 15:06:55
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

  procedure AddQuitMenu(AParentMenu: TMenuItem); //�����˳��˵�
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
    //if GCzy.ID <> 1 then begin //ϵͳ����ԱĬ��������Ȩ��
    //hch ��Ҫ�жϷ�ĩ���˵���Ȩ�� //if not Node.HasChildren then  begin

    if (Node.Data <> nil) and (not PTreeRec(Node.Data)^.bVisible) then //���ɼ����򲻴����˵�
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

    // ���˵����δ�����Ҳ˵����ڵ�
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
  if GszRelease='��������' then
     sGNFL_Ver:=',ZF_'+GszEdition+','
  else if GszRelease='��������' then
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
   
  //fuxj 20110418 Ϊ���ܹ�����modcaption�����ض���SA��BAS��modcaption�ֱ�����Ϊ000001,000002
  sSQL := 'select GL_GNFL.*,''000001'' modcaption  from GL_GNFL where (modcode=''SA'') ';
  if GszHSDWDM = '' then //=''ʱֻ��ʾϵͳ����
  else
  begin
    sSQL := sSQL +
         ' union ' +
         //fuxj 20110418 �Ի������ϲ��ֹ����Ƿ���ʾ���п��ƣ����ƹ���
         //CPBBDM�ֶ�Ϊ�յı�ʾ�ù��ܲ��ܿ���
         //CPBBDM�ֶβ�Ϊ�յı�ʾ�ù���ֻ�е�ǰ��λ�����˶�Ӧ��ģ��ʱ����ʾ
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
  //��������MenuCode�������ƽӿ������β˵���ʽ�²���ʾ�����⣬
  //��Ϊ�ȼ���7401���ټ���74�������74��hasChild����Ϊfalse�������ɾ�������Ľڵ㡣 Modified by chengjf 2014-09-29
  sSQL := ' select * from (' + sSQL + ' ) a order by modcaption,MenuCode '; //fuxj 20110418�޸ģ�ģ�鰴��ϵͳ����������ģ���˳����ʾ

  POpenSql(DataModulePub.ClientDataSetTmp, sSQL);
  with DataModulePub.ClientDataSetTmp do
  begin
    if Recordcount <= 0 then
      Exit;
    CreateMenuTree(TreeViewFunc, DataModulePub.ClientDataSetTmp, True, False);
  end;

  if Assigned(GAnyiLicenseInfo) then
  begin //������ʾ��˵�
    for i := TreeViewFunc.Items.Count - 1 downto 0 do
    begin
      if TreeViewFunc.Items[i].Level <> 0 then
        Continue;

      // ������ 2011.04.18 �����ǰģ������ʾ�棬���ڲ˵�������ʾ��ʾ��������
      sFuncName := TreeViewFunc.Items[i].Text;
      szModeCode := PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode;
      if (*(sFuncName <> '���ƽ̨') and*) (sFuncName <> 'ϵͳ����') and (sFuncName <> '�������ݹ���') and (szModeCode <> 'RMIS') then
      begin
        if GAnyiLicenseInfo.ProductExists(GetGszAnyiByModeName(PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode)) or (GNOJMVer_CusName<>'')  then
        begin
          PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := False;
        end
        else
        begin
          PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := True;
          TreeViewFunc.Items[i].Text := TreeViewFunc.Items[i].Text + '[��ʾ��]';
          //add by chengjf 20150811 ������ʾ���Ƿ���ʾ����
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
  //  TfrmRptCaller.GetRepTreeByUnitCode(TreeViewFunc, GszGSDM, '1'); ����Ȩ�޿���
  //end;

  {��������֧�ַ���ϵͳ}
  //if (sModCode = 'MIDS') then
  //begin
    //GetMIDSTree(TreeViewFunc);
  //end;

  {����Ԥ��ִ�з����˵�}
  //if (sModCode = 'BKA') then
  //begin
    GetBKATree(TreeViewFunc);
  //end;

  {�����ּ�Ԥ���˵�}
  //if (sModCode = 'GE') then
  //begin
    GetGETree(TreeViewFunc);
  //end;



  try
    HideMenu.InitFastTree(GszGSDM, GszKJND,TreeViewFunc);
  except
  end;
  InitTreeQXKZ; //����Ȩ��

  try
    if GszGSDM <> '' then //Pub_ExterialFun�������
    begin
      {����˵�֮ǰ��BeforeAPT���ø÷��������߼�}
      TPlugDev.InitInvokeTree(Self, TreeViewFunc, BeforeAPT, True); //��ʼ���˵���ť
    end;
  except
  end;

  //hch ���ز���Ҫ�Ĳ˵��� ͨ��HideMenu���������
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
          //ɾ����ĩ���ڵ��в������Ľڵ����ݴ���
          if (TreeViewFunc.Items[i].Level < 2) and not TreeViewFunc.Items[i].HasChildren then
            TreeViewFunc.Items[i].Delete;
        end;
      end;
    end;
  end;
  
  {�������ϱ����˵�}
  //if (sModCode = 'OER') then
  //begin
  //end;
  GetOERDJLX(TreeViewFunc);
  GetFDADJLX(TreeViewMyFunc);
  //�����˵�
  HashMenuList := THashedStringList.Create;
  try
    NGNFL.Clear;
    for i := 0 to TreeViewFunc.Items.Count - 1 do
    begin
      // ������ 2011.08.23 Ϊ��ߴ����˵��ٶȣ�ע���������С�
      // if (TreeViewFunc.Items[i].Level = 0) then
      //   AddMenu(NGNFL, TreeViewFunc.Items[i]);
      AddMenuEx(TreeViewFunc.Items[i]);
    end;
    AddQuitMenu(NGNFL); //�����˳��˵�
  finally
    HashMenuList.Free;
  end;




end;

procedure TFormMain.InitModTreeNode; // ����ǰ̨ģ��˵����ڵ�
var
  i, j: Integer;
  sSQL: string;
  sFuncName,szModeCode: string;
  HashMenuList: THashedStringList;
  sFuncLength: string;

  procedure AddQuitMenu(AParentMenu: TMenuItem); //�����˳��˵�
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

    // ���˵����δ�����Ҳ˵����ڵ�
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
    //����Աû�н�ɫ������ʾ��������ʾ�κ�ģ��
    if not (CdsPower.Active and (CdsPower.RecordCount > 0)) then begin
      SysMessage('��ǰ����Աû���κι���Ȩ��.' + #13 + '�����Ƿ����˽�ɫȨ�޻�������ɫ�Ƿ�������Ȩ�ޡ�', '_JG', [mbok]);
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
          
  if  not ((GblManagerLimit=1) and (GCzy.ID=1)) then // zhengjy 2014-10-11 ����������������汾�����ƹ���ԱȨ�����ƣ�0��ʾ������ 1��ʾ����Աֻ��"����Ա����"����
  begin
    if (GszHSDWDM = '') then // GszHSDWDM=''ʱֻ��ʾϵͳ����ģ��
    else
    begin
      sSQL := sSQL +
           'union ' +
           //fuxj 20110418 �Ի������ϲ��ֹ����Ƿ���ʾ���п��ƣ����ƹ���
           //CPBBDM�ֶ�Ϊ�յı�ʾ�ù��ܲ��ܿ���
           //CPBBDM�ֶβ�Ϊ�յı�ʾ�ù���ֻ�е�ǰ��λ�����˶�Ӧ��ģ��ʱ����ʾ
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
  // ������ 2011.12.06 Ϊ�����˵���ģ���б�����Ȩ�޿��ƹ���
  sSQL := 'select a.* from (' + sSQL + ') a where a.gnfldm in ' +
          ' (select distinct substring(b.gnfldm, 1, 2) gnfldm from ' +
          ' (' + GetPowerSql(GCzy.ID) + ') b ) ' +
          ' order by modcaption '; //fuxj 20110418�޸ģ�ģ�鰴��ϵͳ����������ģ���˳����ʾ

  POpenSql(DataModulePub.ClientDataSetTmp, sSQL);
  with DataModulePub.ClientDataSetTmp do
  begin
    if Recordcount <= 0 then begin
       FIndUseRole; //û�н�ɫȨ�ޣ�����ʾģ��˵�
       //Exit;
    end;
    CreateMenuTree(TreeViewFunc, DataModulePub.ClientDataSetTmp, True, True);
  end;

  if Assigned(GAnyiLicenseInfo) then
  begin //������ʾ��˵�
    for i := TreeViewFunc.Items.Count - 1 downto 0 do
    begin
      if TreeViewFunc.Items[i].Level <> 0 then
        Continue;

      // ������ 2011.04.18 �����ǰģ������ʾ�棬���ڲ˵�������ʾ��ʾ��������
      sFuncName := TreeViewFunc.Items[i].Text;
      szModeCode := PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode;
      if (*(sFuncName <> '���ƽ̨') and *) (sFuncName <> 'ϵͳ����') and (sFuncName <> '�������ݹ���') and (sFuncName <> '��Ŀ����')
        and (* (sFuncName <> 'Ʊ�ݳ����') and (sFuncName <> 'Ʊ�ݴ�ӡͨ') and (sFuncName <> 'Ʊ�ݿ�' )and *) (sFuncName <> '�����ɹ�ϵͳ')
        and  (szModeCode <> 'RMIS') and (szModeCode <> 'SRM') and (Copy(szModeCode,1,3) <> 'UDF') then
      begin
        if GAnyiLicenseInfo.ProductExists(GetGszAnyiByModeName(PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode)) or (GNOJMVer_CusName<>'') then
        begin
          PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := False;
        end
        else
        begin
          PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := True;
          TreeViewFunc.Items[i].Text := TreeViewFunc.Items[i].Text + '[��ʾ��]';
          //add by chengjf 20150811 ������ʾ���Ƿ���ʾ����
          if GblDemoNotVisible = 1 then
            TreeViewFunc.Items[i].delete;
        end;
      end
      else
        PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := False;
    end;
  end;

  //�����˵�
  HashMenuList := THashedStringList.Create;
  try
    NGNFL.Clear;
    for i := 0 to TreeViewFunc.Items.Count - 1 do
    begin
      // ������ 2011.08.23 Ϊ��ߴ����˵��ٶȣ�ע���������С�
      // if (TreeViewFunc.Items[i].Level = 0) then
      //   AddMenu(NGNFL, TreeViewFunc.Items[i]);
      AddMenuEx(TreeViewFunc.Items[i]);
    end;
    AddQuitMenu(NGNFL); //�����˳��˵�
  finally
    HashMenuList.Free;
  end;

  // ������ 2011.10.30 THideMenu.Refresh �� InitTreeQXKZ() �����Ƶ���ʼ��ģ���б�ʱִ�С�
  
  //if not FIndUseRole then  //û�н�ɫȨ�ޣ�����ʾģ��˵�
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
    if (Node.Data <> nil) and (not PTreeRec(Node.Data)^.bVisible) then //���ɼ����򲻴����˵�
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

    // ���˵����δ�����Ҳ˵����ڵ�
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
      if MainMenu.Items[i].Find('���ƽ̨ ') <> nil then
      begin
        AMenuItem := MainMenu.Items[i].Find('���ƽ̨ ');
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
    //zhengjy 2014-10-11 ����������������汾������ϵͳ����Ա��ʾ�Ĳ˵�����
    if (GblManagerLimit=1) and (GCzy.ID=1) then
      sSQL := 'select ''000001'' modcaption, GL_GNFL.* from GL_GNFL ' +
            ' where (modcode=''SA'') and MENUCODE IN (''00'',''0001'',''000109'',''0002'',''000205'')  '
    else
      sSQL := 'select ''000001'' modcaption, GL_GNFL.* from GL_GNFL ' +
            ' where (modcode=''SA'')  ';
  end
  else if (sModCode = 'BAS') then // GszHSDWDM=''ʱֻ��ʾϵͳ����ģ��
  begin
         //fuxj 20110418 �Ի������ϲ��ֹ����Ƿ���ʾ���п��ƣ����ƹ���
         //CPBBDM�ֶ�Ϊ�յı�ʾ�ù��ܲ��ܿ���
         //CPBBDM�ֶβ�Ϊ�յı�ʾ�ù���ֻ�е�ǰ��λ�����˶�Ӧ��ģ��ʱ����ʾ
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
  sSQL := sSQL + ' order by menucode, modcaption '; //fuxj 20110418�޸ģ�ģ�鰴��ϵͳ����������ģ���˳����ʾ

  POpenSql(DataModulePub.ClientDataSetTmp, sSQL);
  if DataModulePub.ClientDataSetTmp.Recordcount <= 0 then Exit;

  CreateMenuTree(TreeViewFunc, DataModulePub.ClientDataSetTmp, False, True);

  if (sModCode = 'AQR') then
  begin
    TfrmRptCaller.GetRepTreeByUnitCode(TreeViewFunc, GszGSDM, '1');
  end;

  {��������֧�ַ���ϵͳ}
  if (sModCode = 'MIDS') then
  begin
    GetMIDSTree(TreeViewFunc);
  end;

  {����Ԥ��ִ�з����˵�}
  if (sModCode = 'BKA') then
  begin
    GetBKATree(TreeViewFunc);
  end;

  {�����ּ�Ԥ���˵�}
  if (sModCode = 'GE') then
  begin
    GetGETree(TreeViewFunc);
  end;

  {�������ϱ����˵�}
  if (sModCode = 'OER') then
  begin
    GetOERDJLX(TreeViewFunc);
  end;
  if (sModCode ='GSP')  then
  begin
    GetFDADJLX(TreeViewFunc);
  end;
  HideMenu.InitFast(GszGSDM, GszKJND,sModCode);

  InitTreeQXKZ; //����Ȩ��

  //�����˵�
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

  // ������ 2011.11.01 ���ڻ��ƽ̨֮��Ĳ����ֱ����MainMenu��Ӳ˵���
  // ���Ա���������˵���MainMenu���Ӳ˵�����MenuTree���������֮�󣡣���
  // ע�⣺���㲻�ǳ�ʼ��APTģ�飬ҲҪ���APTģ�鹦�ܲ˵���ԭ��ͬ�ϡ�
  {if (sModCode = 'APT') then}
  begin
    //ע��������Դ��Ȼ�����µ�½����г�ʼ��
    //2009-4-15 ����Exe�Ĳ��Ӧ��
    try
      if NFDMenu.Checked then
      begin
        if GszGSDM <> '' then
        begin
          //RemoveAPTMenu;
          {����˵�֮ǰ��BeforeAPT���ø÷��������߼�}
          TPlugDev.InitInvokeMenu(Self, MainMenu, BeforeAPT, True); //��ʼ���˵���ť
        end;
      end;
      {����APT�˵�}
      // ������ 2011.11.01 Ϊ����Ӧ��¼�Ż���Ĳ˵������߼�����ʱ����"���ƽ̨"������롣
      // RemoveAPTMenu;
    except
    end;
  end;

end;

procedure TFormMain.PRegNC(AMenuItem: TMenuItem);
var
  CurCount: Integer;
  CurMenuIndex: Integer;
  iMax: Integer; //�Զ�����������
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
        SysMessage('��û�иù��ܵĲ���Ȩ�ޣ�', '', [mbOk]);
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
  //zhengjy 20140717 ������������ʽͨѶ
  FilePath :=ExtractFilePath(Application.ExeName)+'_HTTP_CDS_';
  if not FileExists(FilePath) then mniBinaryGet.Checked :=false
  else mniBinaryGet.Checked :=true;

  TimerDBSY.Enabled := False;
  AnyiClient1 := TAnyiClient.Create(nil); //���ڲ��ԣ���¼����ܵ�ַ�õ�
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
  // 2007-5-21 14:27 hch ��ҳ���޷���ʾ����˵�
  Self.WindowMenu := nil;
{$ENDIF}
  OtherProStringList := TStringList.Create;
  FOrgMenuItem := TStringList.Create;
  Application.OnException := AppException;

  PRegReadS('\SOFTWARE\UFGOV\'+GsProductID+'\Main', 'SingleClick', szSingleClick);
  ActEnableClick.Checked := (szSingleClick = '1');

  ShortDateFormat := 'yyyy-mm-dd';
  DateSeparator := '-'; // ������ 2009.06.26

  //20050614 R96 �Ӵ����б�  zhouyunlu
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
  // ������ 2009.02.26 �����ȹر� TimerDemo �������û��������ϼ��ܣ����15�����ڲ���¼Ҳ���С���ʾ�桱��ʾ��
  TimerDemo.Enabled := False;
  //2009.4.7 hy Oracle������HR
//  if GDbType=ORACLE then
  ActHRSynInit.Visible := False;

  TreeViewFunc.DoubleBuffered := True;
  TreeViewMyFunc.DoubleBuffered := True;

  {���ܵ���}
  Label4.Caption := '  ���ܵ���';
  FMenuBox := TMenuBox.Create(self);
  FMenuBox.Align := alClient;
  FMenuBox.Parent := PanelFunc;
  FMenuBox.Color := GMenuButtonColor;
  FMenuBox.MenuButtonHeight := 28;
  FMenuBox.AlphaBlend := 240;
  FMenuBox.AlphaBlendEnabled := (Win32MajorVersion > 5) or ((Win32MajorVersion = 5) and (Win32MinorVersion > 0));

  FMenuBox.UpDownEnabled := True;
  {hch ʵ�ֽ��������ݷ�ʽ}
  FMenuBox.OnCreateDesktopMenuIcon := CreateDesktopMenuClick;
  FMenuBox.OnShowMenuPanel := ShowMenuPanel;
  {���칤��}
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
  {hch ���ع�����ʾ}
  GCUProgress := PgOnProgress;
  //zhengjy 2014-10-11 ����������������汾������ͨ��
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
    if SysMessage('��ȷ���˳�ϵͳ��', '_XW', [mbYes, mbNo]) <> mrYes then
      CanClose := False;
  {$ELSE}
    CanClose := True;
  {$ENDIF}
  try
    //zhengjy 2014-10-11 ����������������汾,�˳�ɾ���û�״̬
    TControlLogin.DelOperState(IntToStr(GCzy.ID));  
    // �˳�����ǰ��Ҫ�ر�Զ������
    if CanClose then
     DataModulePub.MidasConnectionPub.Connected := False;
     //zhengjy 20161213 �ͷ�Key����
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
  try //�ͷŲ˵�ָ��
    for i := 0 to TreeViewFunc.Items.Count - 1 do
      if TreeViewFunc.Items[i].Data <> nil then
        Dispose(TreeViewFunc.Items[i].Data);
  except
  end;

  try //�ͷŲ˵�ָ��
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
  TerminateProcess(GetCurrentProcess,0);  //zhengjy 20140523 ����Ԥ��ִ��ϵͳ�󣬽���˳���������⡣
end;

procedure TFormMain.FormResize(Sender: TObject);
begin
  //RefreshBG;
  Invalidate;
  // ������ 2009.10.26 �����ĳЩ�����������岻����ȷ�����ػ�����Ϣ�����²��ܵ�¼�����⡣
  // ��������ԭ�������ֳ��������� ProcessMessages() �������ÿ��Խ�����ԭ������Bug��
  //Application.ProcessMessages;
end;

procedure TFormMain.FormShortCut(var Msg: TWMKey;
  var Handled: Boolean);
begin
  // ������ 2010.05.10 �����Ӵ���˵���ݼ�
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
    if SysMessage('���д򿪵Ĵ��ڶ����رգ��Ƿ������', '', [mbOK, mbCancel]) = mrOk then
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
      if rMainSub.GiReLogin=3 then begin  //ǿ�����µ�¼
         rMainSub.GiReLogin:=0;
         ActLoginExecute(ActLogin);
      end;
    finally
    end;
  end
  else if not IsAQRNode(CurNode) and (CurNode.Data<>nil) and (pTreeRec(CurNode.Data)^.sGnScripts='APT') then
  begin
    //���û��ƽ̨
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
      if rMainSub.GiReLogin=3 then begin  //ǿ�����µ�¼
         rMainSub.GiReLogin:=0;   
         ActLoginExecute(ActLogin);
      end;
      //LoadModeDll(sModeName,sCZY+';1;2011-02-27;111;111zt;000;000zt;127.0.0.1;211;0;Socket;MSSQL;;'+sGnflMc+';',sGnflMc);
    finally
      //ATreeView.Invalidate; �ѿ������������ˣ���ע��
    end;
  end
  else
  begin
    {hch ��д��,�Ժ�����������}
    if (CurNode.Text = '�������') then
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
  if (Node.Text <> MPreViouschild.Caption) and // ��һ����
  (Node.Text <> MNextChild.Caption) and // ��һ����
  (Node.Text <> MMyDesktop.Caption) then // ����
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
    Application.MessageBox('ֻ�������ĩ�����ܵ����ղؼС���', 'ϵͳ��ʾ', MB_ICONInformation + MB_OK);
    Exit;
  end;

  if TreeViewFunc.Selected.Parent = OtherProNode then
    Exit;

  if FMyFuncRoot.Count >= 20 then
  begin
    Application.MessageBox('���ղؼС��Ѿ��ﵽ���ޣ�20�����ܣ������������µĳ��ù��ܣ�����ɾ�������õľɹ��ܡ�',
      'ϵͳ��ʾ', MB_ICONInformation + MB_OK);
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
    Exit; // ����

  if ANode.Count > 0 then
  begin
    Application.MessageBox('��ǰ�����»����������ܣ�����ɾ����', 'ϵͳ��ʾ', MB_ICONInformation + MB_OK);
  end;

  if SysMessage('ȷ���ӡ��ղؼС���ɾ����ѡ���ܡ�' + ANode.text + '����', '',
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
  // ȫ������
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
  // �ղؼ�
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
  //֮ǰ��֪�ιʱ�ע�ͣ��ַſ������������� Modified by chengjf 2015-09-24
  FormBackGround.BringToFront;
end;

procedure TFormMain.ClientWndProc(var Message: TMessage);
//�ͻ������ڹ��� R96 zhouyunlu 200506
const
  WM_MDICHILD_UPDATE = WM_User + 5611; //�Զ�����Ϣ�������޸��Ӵ����б�
  WM_MDICHILD_MAX = WM_USER + 5612; //�Զ�����Ϣ������ʹĳ�Ӵ������   wparam Ϊ �Ӵ���handle
var
  CurFormhandle: HWND;
  pMsg: Cardinal;
  i: Integer;
begin
  case Message.Msg of
    WM_MDICHILD_UPDATE:
      begin
        if FWndList <> nil then
          FWndList.UpdateList; //�����б�
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
    WM_MouseActivate, //33 �л�����ʱһ�㴥�����������Ϣ
    WM_ChildActivate, //34
    WM_MDIDESTROY, //545 �ر�һ�����壬�ἤ����һ������
    $3F: //63
      begin //CurFormhandle := Message.wParam;  //ShowMessage(IntToStr(Message.Msg));
        pMsg := Message.Msg;
        Message.Result := CallWindowProc(FOldClientProc, ClientHandle, Message.Msg, Message.wParam, Message.lParam);
        PostMessage(ClientHandle, WM_MDICHILD_UPDATE, 0, 0);
        if (ActiveMDIChild is TFormBackGround) then
          TFormBackGround(ActiveMDIChild).WindowState := wsMaximized;
        DispStatus(rMainSub.GsCurModName);
        //������������ʱ���ٳ�ʼ�����ģ��ı���
        if (FWndList <> nil) and (FslUIR9_IMPL <> nil) and (ActiveMDIChild <> nil)
          and ((ActiveMDIChild <> ActiveMIDPre) or ((rMainSub.GsPriModName <> rMainSub.GsCurModName)
          and (rMainSub.GsPriModName <> ''))) //�л�������л�ģ��ʱ
          and ((pMsg = WM_MouseActivate) or (pMsg = WM_MDIDESTROY)) {//���弤����߹ر�ʱ} then
        begin
          for i := 0 to FWndList.FList.Count - 1 do
          begin
            if TMDIChildItem(FWndList.FList[i]).FormHandle = ActiveMDIChild.Handle then
            begin //���ݴ������ҵ�����һ��ģ��
              FslUIR9_IMPL.ActiveForm(TMDIChildItem(FWndList.FList[i]).sModeName); //����壬ִ�г�ʼ������ ActiveMDIChild.Handle
              Break;
            end;
          end;
        end;
        ActiveMIDPre := ActiveMDIChild;
        //����showmodal���壬���ܲ�����Ϣ�����ܸ���ActiveMIDPreֵ��������showmodal����ر�ʱ�����޷�������һ�����壬�����޷�ִ�б�����ʼ�����ʸ���GsPriModName��GscurModName���ж�
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
//��д ���滻Ĭ�ϵĿͻ������ڹ��� R96 zhouyunlu 200506
begin
  inherited CreateWnd;
  FNewClientProc := MakeObjectInstance(ClientWndProc);
  FOldClientProc := Pointer(GetWindowLong(ClientHandle, GWL_WNDPROC));
  //�滻���ͻ������ڹ���
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
  sDemo = '��Ŀǰʹ�õ�����ʾ�棬ϵͳ�޷���֤�������������ԡ���ȫ�ԣ�' + #13 +
    '�����������������������';
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
    SysMessage('������λǰ��ر����д򿪵Ĵ��ڡ�', '', [mbOk]);
    Exit;
  end;

  if Assigned(FormBackGround) then begin
     FormBackGround.SaveConfig(gCZy.name);
     FormBackGround.SaveDesktopImageSettings;
  end;

  //������λ
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
    SysMessage('��û�в���ϵͳ������־��Ȩ�ޡ�', 'PZ_97_JG', [mbOK]);
    Exit;
  end;
  //zhengjy 2014-10-11 ϵͳ����Ȩ�����ƣ�����ʾ������־���ܲ˵�,���벻�ܼ�else������֧
  if (GblManagerLimit=1) and (GCzy.ID=1) then
  begin
    SysMessage('��û�в���ϵͳ������־��Ȩ�ޡ�', 'PZ_97_JG', [mbOK]);
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

  (* GModeEncryptList.Free; //���»�ȡ���м���
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
    (Application.MessageBox('ǰ̨��־��¼�����Ѿ����ã��Ƿ������־���ܣ�',
    'ϵͳ��ʾ', MB_ICONWarning + MB_YesNo) <> IDYes) then
  begin
    Exit
  end;
  if not GbUseLog and
    (Application.MessageBox('ǰ̨��־��¼����û�����ã��Ƿ�������־���ܣ�' + #13#10
    + 'ע�⣺ ������־����־�ļ�������Ӧ���ļ���LogĿ¼�С�'
    , 'ϵͳ��ʾ', MB_ICONWarning + MB_YesNo) <> IDYes) then
  begin
    Exit;
  end;
  //���û��߽�����־���ܡ�
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
    SysMessage('��ѯ�������ǰ��ر����д򿪵Ĵ��ڡ�', '', [mbOk]);
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

    // ������ 2011.10.26 ��¼���һ�ε�"����"�˵�ʱ��������ģ����¼������Ӳ˵���
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
  if trim(Label4.Caption) = '���ܵ���' then
  begin
    PanelFunc.Visible := not PanelFunc.Visible;
    if PanelFunc.Visible then
      imgLeftAllClose.Picture.Bitmap.Assign(GImageUp)
    else
      imgLeftAllClose.Picture.Bitmap.Assign(GImageDown);
  end
  else if trim(Label4.Caption) = '��λ����' then
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
  {�ճ�����}
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
  GImageLeftBar.Assign(ImageNoExists.Picture.Bitmap); // ��������๦��������������
  GImageFuncBar.Assign(ImageNoExists.Picture.Bitmap); // ������׿�๦��������������
  GImageLeft.Assign(ImageNoExists.Picture.Bitmap); // ���ͷ
  GImageRight.Assign(ImageNoExists.Picture.Bitmap); // �Ҽ�ͷ
  GImageUp.Assign(ImageNoExists.Picture.Bitmap); // �ϼ�ͷ
  GImageDown.Assign(ImageNoExists.Picture.Bitmap); // �¼�ͷ
  GImageLeftHot.Assign(ImageNoExists.Picture.Bitmap); // ���ͷ��ѡ�У�
  GImageRightHot.Assign(ImageNoExists.Picture.Bitmap); // �Ҽ�ͷ��ѡ�У�
  GImageUpHot.Assign(ImageNoExists.Picture.Bitmap); // �ϼ�ͷ��ѡ�У�
  GImageDownHot.Assign(ImageNoExists.Picture.Bitmap); // �¼�ͷ��ѡ�У�
  GImageWinBarHot.Assign(ImageNoExists.Picture.Bitmap); // ����������
  GImageWinBar.Assign(ImageNoExists.Picture.Bitmap); // ������������ѡ�У�

  GImageMyWork.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_�ҵĹ���
  GImageMyWorkHot.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_�ҵĹ�����ѡ�У�
  GImageHomePage.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_��ҳ
  GImageHomePageHot.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_��ҳ��ѡ�У�
  GImageLaw.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_���ɷ���
  GImageLawHot.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_���ɷ��棨ѡ�У�
  GImageFlow.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_����
  GImageFlowHot.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_���̣�ѡ�У�
  GImageLeftMargin.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_��߿հױ���
  GImageRightMargin.Assign(ImageNoExists.Picture.Bitmap); // ���水ť��_�ұ߿հױ���

  GImageGridHeader.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�����������
  GImageSpeedBar.Assign(ImageNoExists.Picture.Bitmap); // ���ڰ�ť������
  GImageSpeedButton.Assign(ImageNoExists.Picture.Bitmap); // ���ڰ�ť״̬����
  GImageSpeedButtonDown.Assign(ImageNoExists.Picture.Bitmap); // ���ڰ�ť״̬������������

  GImageEditorUp.Assign(ImageNoExists.Picture.Bitmap); // �༭���ϼ�ͷ
  GImageEditorDown.Assign(ImageNoExists.Picture.Bitmap); // �༭���¼�ͷ
  GImageEditorButton.Assign(ImageNoExists.Picture.Bitmap); // �༭��ť

  GImageStatusBar.Assign(ImageNoExists.Picture.Bitmap); // ״̬������

  GImageWinCaption.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ���������
  GImageWinBtnMin.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_��С��
  GImageWinBtnMinHot.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_��С����ѡ�У�
  GImageWinBtnMinDown.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_��С�������£�
  GImageWinBtnMax.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_���
  GImageWinBtnMaxHot.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_��󻯣�ѡ�У�
  GImageWinBtnMaxDown.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_��󻯣����£�
  GImageWinBtnRes.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_��ԭ
  GImageWinBtnResHot.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_��ԭ��ѡ�У�
  GImageWinBtnResDown.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_��ԭ�����£�
  GImageWinBtnClose.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_�ر�
  GImageWinBtnCloseHot.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_�رգ�ѡ�У�
  GImageWinBtnCloseDown.Assign(ImageNoExists.Picture.Bitmap); // ���ڱ�������ť_�رգ����£�

  //����������ɫ
  GImageFormFontColor.Assign(ImageNoExists.Picture.Bitmap);

  //�������ı���ɫ
  GImageFormBackgroundColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageFuncTreeBackGroundColor.Assign(ImageNoExists.Picture.Bitmap);

  //������˲������õĽ���ɫ�ؼ�TGradPan����ʼ��ɫ����
  GImageGradPanColorStart.Assign(ImageNoExists.Picture.Bitmap);
  GImageGradPanColorEnd.Assign(ImageNoExists.Picture.Bitmap);
  GImageGradPanColorHot.Assign(ImageNoExists.Picture.Bitmap);

  //�Ǽǲ�֮��������ҳǩ�ؼ�TabSet�ı�����ѡ����ɫ����
  GImageTabSetBackGroundColor.Assign(ImageNoExists.Picture.Bitmap);
  GImageTabSetSelectedColor.Assign(ImageNoExists.Picture.Bitmap);

  //THStringGrid��THDBGridGrid�ı�ͷ�������С������ߡ�����ѡ�е���ɫ����
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
  // ɾ���ɵ���ʽ�˵���
  for i := MSkin.Count - 1 downto 0 do
    MSkin.Items[i].Free;

  // �����µ���ʽ�˵���
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
      SysMessage('����������ʽǰ��ر����д򿪵Ĵ��ڡ�', '', [mbOk]);
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
  // ������ 2010.10.11 ʹ�����߹���ģʽ��¼
  if not GblOfflineMode then
    DownloadDataDialogShowModal
  else
    ShowMessage('������Ч��ʹ�ô˹���֮ǰ������Զ�̷�������');
end;

procedure TFormMain.MUploadDataClick(Sender: TObject);
begin
  // ������ 2010.10.11 ʹ�����߹���ģʽ��¼
  // ֻ����������ϴ�����ƾ֤����Main.pas�ļ��ɷ�����ʵ�֣���
  ShowMessage('������Ч����ǰģ�鲻֧���ϴ��������ݡ�');
end;

procedure TFormMain.AfterMainFormSkinChanged;
begin
  { no code here ... }
end;

procedure TFormMain.LoadModeDll(psModeName, sGnflMc, sGnflExec: string); //ParamList:string
var
  FR9_IMPL: TUIR9_IMPL; //��̬�������
  i:Integer;
begin
  (*if GAnyiLicenseInfo.ProductExists(GetGszAnyiByModeName(psModeName)) then begin //��ʽ��ſ��ƣ���ʾ�治���п���
     if not CheckSPS then begin //SPS
        Exit;
     end;
  end; *)
  try
    FR9_IMPL := FslUIR9_IMPL.CreateUIR9(psModeName, sGnflExec);
    if FR9_IMPL = nil then
    begin
      ShowMessage('��ȡģ���ļ�ʧ�ܣ�ԭ�����£�' + #13#10 +
        '1.��������Ŀ¼��ȱ��"' + sGnflExec + '"�ļ�' + #13#10 +
        '2.GL_GNFL��ȱ�����ģ���ļ�������' + #13#10 +
        '3.����δ��ȷ��Ϣ������ϵͳ����Ա��ϵ');
      Exit;
    end;
    (*if (FR9_IMPL.FExeType=etCustomRpt)or(FR9_IMPL.FExeType=etGE) then begin //���ͷű�Ķ��Ʊ���ģ��ļ��ܣ���Ϊ�п������ٴ�һ��������ģ�飬��Ҫ�Զ��ͷ������
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

procedure TFormMain.WMDLLMainClose(var Msg: TMessage); //����Ϣ��ֻ������ж�ؼ���֮�ã���Ҫд�������룬by �����Ƽ��ܵ����޸� 2011.11.14
begin //if not rMainSub.bFreeBpl then Exit; if Msg.WParam<>0 then  FslUIR9_IMPL.DeleteUIR9('',Msg.WParam)   Msg.WParam��ģ����Ӵ���
  FslUIR9_IMPL.DeleteUIR9(rMainSub.GsCurFreeAnyiCleintModName, 0);
end;

(*procedure TFormMain.WMDLLMDICreate(var Msg: TMessage); //�����Ѵ�������Ϣ���Ѳ�����
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
  begin //��Щģ����Ȼʹ�����±���
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
      // Added by miaopf 2008-4-24 19:26:46 ������λ�ּ���Ԥ�㵥λ�ּ���һ��������ֱ��������ֵ      //GszWLDWFJ := GszGSFJ;
    end;

    if Locate('lbdm', '4', []) then
    begin // for BEM? 2010.12.08 �ϲ�BEM����
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
                  SysMessage('û���ҵ�"'+NGNFL.Items[j].Caption+'"�ļ�����Ϣ������Ϊ��ʾ��ʹ��!','_YB',[mbok]);
                  NGNFL.Items[j].Caption := NGNFL.Items[j].Caption+'[��ʾ��]';
                  TreeViewFunc.Items[i].Text := TreeViewFunc.Items[i].Text+'[��ʾ��]';
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
      begin // ���ð档�˵�����ÿ����Ʒ�Ӹ�'(��ʾ��)'
        //PostMessage(Application.MainForm.Handle,WM_InitEncryptDemo,0,0)  //��ʾ���ڵ�¼ʱ�����ӣ����ﲻ���ٴ�����
      end;
    ERR_AC_SERVERNOTFOUND:
      begin
        SysMessage('δ�ҵ����ܷ������������ü��ܷ����ַ', '_YB', [mbok]);
        AnyiClient1.Setup(True);
        Exit;
      end;

    ERR_AC_DEMOEXPIRED:
      begin
        //SysMessage('���ð汾�ѹ���','_YB',[mbok]);
        //����Ҳ�����ð棬���Լ���ʹ��
      end;

    ERR_AC_PRODUCTNOTFOUND:
      begin
        SysMessage('δȡ�ò�Ʒ��Ȩ��Ϣ', '_YB', [mbok]);
        Exit;
      end;

    ERR_AC_INVALIDLOCALFILE:
      begin
        SysMessage('��Ч�ı��ؼ����ļ�', '_YB', [mbok]);
        Exit;
      end;

    ERR_AC_SOCKETERROR:
      begin
        SysMessage('������ϣ��޷���ȡ������Ϣ', '_YB', [mbok]);
        Exit;
      end;

    ERR_AC_SERVERERROR:
      begin
        SysMessage('������֤�����ܷ���ܾ�', '_YB', [mbok]);
        Exit;
      end;

    ERR_AC_UNKNOWN:
      begin
        SysMessage('δ֪�ļ��ܴ���', '_YB', [mbok]);
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
  MBType1 = '��ʻ�����';
  MBType2 = 'ר�ⱨ��';
  MBType3 = 'ר�ⱨ��';
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
        pRecPtr^.sGnflExec := 'MIDS.exe';      //��־���޸� 2012-02-14   //'MIDS.exe';
        with tv.Items.AddChild(PNode, Cds.FieldByName('TabName').AsString) do
          Data := pRecPtr;
        Cds.Next;
      end;
    end;
  end;
  procedure newSetTree;    // Added by guozy 2013/5/16 ������ 12:05:36
  begin
    New(pRecPtr);
    pRecPtr^.sModCode := 'MIDS';
    pRecPtr^.sMenuCode := '�쵼����֧��';
    pRecPtr^.sGnflmc := '�쵼����֧��';
    pRecPtr^.sGnflExec := 'MIDS.exe';      //��־���޸� 2012-02-14   //'MIDS.exe';
    with tv.Items.AddChild(MIDSNode, '�쵼����֧��') do
      Data := pRecPtr;
  end;
begin
  //MIDSNode := FindMIDS(tv, '�쵼����֧��');
  //if MIDSNode = nil then
    //Exit;
  //newSetTree; Exit;  // Added by guozy 2013/5/16 ������ 12:03:09
  //Treelst := nil;
  //if not Assigned(Treelst) then
    //Treelst := TList.Create;
  {��ʻ�����}
  //internalSetTree(SQL1, MBType1);
  {ר�ⱨ��}
  //internalSetTree(SQL2, MBType2);
  {ר�ⱨ��}
  //internalSetTree(SQL3, MBType3);
end;

(*procedure TFormMain.SetTreeDemoText; //������ʾ�湦�����ı�
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
              PTreeRec(TreeViewFunc.Items[i].Data)^.bDemo := False;  //���ڼ���
              Break;
           end;
       end;
    end;

    if (GModeEncryptList.AEncryptStr=nil) or (j>High(GModeEncryptList.AEncryptStr)) then begin
       sModeName:=PTreeRec(TreeViewFunc.Items[i].Data)^.sModCode;
       if (Pos('��ʾ��',TreeViewFunc.Items[i].Text)<=0)and(sModeName<>'SA')and(sModeName<>'BAS') then begin
          TreeViewFunc.Items[i].Text := TreeViewFunc.Items[i].Text+'[��ʾ��]';
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
  // ��ʾ��Ч�����ã����ε���
  //// OpenWait(TCommonAVI(0), '����˵�Ȩ��...', '');

  try
    if (GCzy.ID = 1) then
    begin
      //Ĭ��ϵͳ����Ա�ɼ����й��ܽڵ㣬Ϊ�����Ч�ʣ��Ͳ���CdsPower.FindKey([sGNFLDM]) ���ж���
      for i := 0 to TreeViewFunc.Items.Count - 1 do
      begin
        if TreeViewFunc.Items[i].Data <> nil then
        begin
          NodeTemp := TreeViewFunc.Items[i];
          if Nodetemp.Level > 0 then
          begin
            sModeCode := PTreeRec(NodeTemp.Data)^.sModCode;
            (*OpenWait(TCommonAVI(0), '����˵�Ȩ��...' +
                     '[' + PTreeRec(NodeTemp.Data)^.sMenuCode + '] ' +
                     PTreeRec(NodeTemp.Data)^.sGnflMc, '');*)
            if (sModeCode <> 'SA') and (sModeCode <> 'BAS') then
            begin
              {hch ѭ����ȡ�˵��Ƿ�ɼ�}
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

      // ϵͳ����Ա�ڴ�ֱ���˳���
      Exit;
    end;

    if not (CdsPower.Active and (CdsPower.RecordCount > 0)) then
    begin
      SysMessage('��ǰ����Աû���κι���Ȩ��.' + #13 + '�����Ƿ����˽�ɫȨ�޻�������ɫ�Ƿ�������Ȩ�ޡ�', '_JG',
        [mbok]);
      for i := 0 to TreeViewFunc.Items.Count - 1 do
        if TreeViewFunc.Items[i].Data <> nil then
          PTreeRec(TreeViewFunc.Items[i].Data)^.bVisible := False;
      Exit;
    end;

    //sSQL:='select * from gl_gn';  //POpenSQL(CdsGL_GN,sSQL);    //CdsPower.Filtered := False;        CdsPower.Filter := 'gnfldm='''+sGNFLDM+'*''';        CdsPower.Filtered := True;        PTreeRec(TreeViewFunc.Items[i].Data)^.bVisible :=not (CdsPower.RecordCount<=0);
    //����ڵ㣺û��Ȩ�޲��ɼ�
    for i := 0 to TreeViewFunc.Items.Count - 1 do
    begin
      NodeTemp := TreeViewFunc.Items[i];
      if NodeTemp.Data = nil then
        Continue; (*if TreeViewFunc.Items[i].Level=0 then begin  //���ϼ��ڵ����ǿɼ���        PTreeRec(TreeViewFunc.Items[i].Data)^.bVisible := True;        Continue;     end;*)
      sGNFLDM := Trim(PTreeRec(NodeTemp.Data)^.sGNFLDM);
      if (sGNFLDM = '') or (NodeTemp.Level = 0)  then
      begin
        PTreeRec(NodeTemp.Data)^.bVisible := True; //�����Ǹ��ϼ��ڵ㣬û�й���Ȩ�޴���
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
          {hch ������Ĵ���˼·���ӿ�����ٶ�}
          PTreeRec(NodeTemp.Data)^.bVisible := (not THideMenu.IsHide(GszGSDM, GszKJND, PTreeRec(NodeTemp.Data)^.sMenuCode));
        end else
          PTreeRec(NodeTemp.Data)^.bVisible := True;
      end
    end;

    //�����ϼ��ڵ㣺�¼��ڵ㶼����ʾ�����ϼ�����ʾ lzn
    for i := 0 to TreeViewFunc.Items.Count - 1 do
    begin
      NodeTemp := TreeViewFunc.Items[i];
      if NodeTemp.Data = nil then
        Continue;
        //if not PTreeRec(NodeTemp.Data)^.bVisible then Continue; //���ɼ��ڵ㣬���ô��� ������Ǹ��ڵ㣬Ӧ�ñ�����һ�����ڽڵ㣻����ж���ӽڵ㣬�������Ҫע��

      if NodeTemp.HasChildren or (PTreeRec(NodeTemp.Data)^.sModCode='APT') then //�ҵ��ӽڵ�
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
  {���������ݷ�ʽ}
  if FormBackGround <> nil then
  begin
    try
      if AMenuItem.Tag < 900 then
      begin
        node := TreeViewFunc.Items[AMenuItem.Tag];
        FormBackGround.CreateLink(PTreeRec(node.Data)^.sModCode, Trim(AMenuItem.Caption), node.Level);
      end
      else begin
        ShowMessage('��ģ�鲻֧�ִ��������ݷ�ʽ��');
      end;
    except
      ShowMessage('�Ҳ�����Ӧ�Ĳ˵���޷����������ݷ�ʽ��');
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

  i := Pos('[��ʾ��]', tmpText);
  if (i > 0) then
    s1 := Trim(Copy(tmpText, 1, i - 1))
  else
    s1 := Trim(tmpText);

  Result := TreeViewFunc.Items[0];
  while (Result <> nil) do
  begin
    i := Pos('[��ʾ��]', Result.Text);
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
      // ������ 2011.08.23 ǰ̨ģ��˵��״δ���ʱ�������������ܲ˵���������ֵΪFalse����һ�η��ʸ�ģ��ʱ�ٴ����������ܲ˵���������ֵ��ΪTrue��
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
  MDBSY.Caption := '�������ˣ�������ȡ...��';
  UpdateDBSY(True, '');
  if (ParamCount>=13) and (GsParamGNFLMC<>'')  then begin  //��¼����������
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
  BKANode := FindMIDS(tv, 'Ԥ��ִ�з���');
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
            pRecPtr^.sGnflExec := ''; // luzn 2011.11.11 ��ģ��û�ж�Ӧ��bpl�ļ���
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
            pRecPtr^.sGnflExec := ''; // luzn 2011.11.11 ��ģ��û�ж�Ӧ��bpl�ļ���
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
  BKANode := FindMIDS(tv, '�ּ�Ԥ��');
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
    StatusBarMain.Panels[6].Text := '��ǰ�������:'+gvLBDM+'['+gvLBMC+']';
  end
  else
  begin
    if StatusBarMain.Panels.Count =7 then
      StatusBarMain.Panels.Delete(6);
  end;
end;

function TFormMain.FreeEncrypt(sModeName:String): Boolean;
begin
   if (FWndList.GetModeGnCount(sModeName,'')<=0) or (FWndList.FList.Count<=0) then begin //��ʵ��ʱ�����޷���⵽�Ѵ򿪵�show����?
       rMainSub.GsCurFreeAnyiCleintModName := sModeName;
       SendMessage(Self.Handle,WM_DLLMainClose, 0,0); //��ǰģ�����д����ѹر���
   end;
end;

function TFormMain.UpdateDBSY(pBupdateMenbox: Boolean; psModeCode: string): Integer;
{ ����˵����pBupdateMenbox����Ҫ��ʹ���²˵���ʾ
            psModeCode    :�����ڿգ���ʾֻ���µ�ǰģ��Ĵ�����Ϣ�����ڿգ���ʾ��������ģ��Ĵ�����Ϣ

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
     FormMain.MDBSY.Caption := '��������';
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
  FMainForm.MDBSY.Caption := '�������ˣ�' + IntToStr(FWorkCount) + '��';

  with FMainForm.TreeViewMYFunc do //���²˵�
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

// ������ 2011.06.18 ������û���߳�ͬ��������UpdateDBSY()ֱ�ӷ���������˵�ʱ
// ���������̳߳�ͻ�Ŀ��ܣ���ʵ����������˵�������һ�㲻�����٣����Է�������
// ���ʳ�ͻ�Ļ��᲻���ڡ��򷢰�ʱ�������ʱ����д�������д��Ľ���
// �Ľ����������������˵������ǽ���ѯ������Ϣ��ģ���б�TStringList�������̡߳�
function TDBSYThread.UpdateDBSY(pBupdateMenbox: Boolean; psModeCode: string): Integer;
{ ����˵����pBupdateMenbox����Ҫ��ʹ���²˵���ʾ
            psModeCode    :�����ڿգ���ʾֻ���µ�ǰģ��Ĵ�����Ϣ�����ڿգ���ʾ��������ģ��Ĵ�����Ϣ

}

  // ������ 2011.10.30 ��ȡ�������˸�Ϊ�̷߳�ʽ�����Ա����õ�����CDS��MidasConnection��
  // Ϊ�˲��޸�Pub_Function�����±���R9Public.bpl����ʱ���µĺ���д�����
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
      // ������ 2011.06.18 ��ȡ�������˸�Ϊ�̷߳�ʽ�����Ա����õ�����CDS��MidasConnection��
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
        //hch �Զ�ֱ�� 2012.05.05 Oracle�Զ�ֱ�����м������ݿ����͵�û�иı����
        if tmpConnection.ConnectType = ctDCOM then
        begin
          with tmpConnection do
          begin
            if GDBType=MSSQL then
               AppServer.changedb(MSSQL,GsDatabaseName)  //��ֱ��ģʽ�£���Ϊapp.dll�����������ӵ�oracle���ݿ⣬Ӧ�ø�app.dll��Ĵ��룬���˴��벻ȫ����Ҫ���������û��ͻ��˵Ĵ��ļ���������ʱ������ط���ǿ������mssq  20140627
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
      //ֻ���µ�ǰģ��
      if (psModeCode <> '') and (psModeCode <> sModeCode) then
        Continue;

      sMenuName := CurNode.text;
      iPos := Pos('��',sMenuName);    //��ʱˢ�´�������ʱ���ڵ��ı��У�,��������ȡ��
      if iPos>0 then begin
         sMenuName := Copy(sMenuName,1,iPos-1);
      end;

      //iDBSY := GetHaveDBSY(sModeCode);

      iDBSYGS := 0;
      //case iDBSY of
      //  -3:
      //begin // ͨ���洢���̣���ȡ������Ϣ����Ч�ʺ�����������������д
      sGnScripts := pTreeRec(CurNode.Data)^.sGnScripts;
      if Trim(sGnScripts) = '' then
        Continue;
      iDBSYGS := GetDbsyGsThread(sModeCode, sGnScripts);
      CurNode.Text := sMenuName + '��' + IntToStr(iDBSYGS) + '��';
      //end;

      (*  -2:
          begin //û�д�����Ϣ
            CurNode.Text := sMenuName + '��' + IntToStr(iDBSYGS) + '��';
          end;

        -1:
          begin //�д�����Ϣ������֪������
            CurNode.Text := sMenuName + '���д�����Ϣ��';
          end;

      else
        begin //�д�����Ϣ������֪������
          if iDBSY >= 0 then
          begin
            iDBSYGS := iDBSY;
            CurNode.Text := sMenuName + '��' + IntToStr(iDBSYGS) + '��';
          end;
        end;
      end; *)

      iDBSYZS := iDBSYZS + iDBSYGS;

      if (psModeCode <> '') and (psModeCode = sModeCode) then //ֻ���µ�ǰģ��
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
      //10.2�н�APT���ƽ̨��ΪAPT ����ͨ�ýӿڲ����APP���˹���ӿڲ�� �������޸Ĳ�����APP��APT modified by chengjf 20140925
//      if Pos('���ƽ̨', Trim(AMenuItem.Caption))>0  then //��ʱ������ʾ������
      if Pos('����ͨ�ýӿڲ��', Trim(AMenuItem.Caption))>0  then //��ʱ������ʾ������
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
      //10.2�н�APT���ƽ̨��ΪAPT ����ͨ�ýӿڲ����APP���˹���ӿڲ�� �������޸Ĳ�����APP��APT modified by chengjf 20140925
//      if Pos('���ƽ̨', Trim(AMenuItem.Caption))>0  then //��ʱ������ʾ������
      if Pos('���˹���ӿڲ��', Trim(AMenuItem.Caption))>0  then //��ʱ������ʾ������
      begin
        Result := True;
        break;
      end; 
      AMenuItem := AMenuItem.Parent;
    end;
  end;

begin
{ ���ƽ̨�����������ˣ������˴���죬���㺯����
  LoadModeDll(sModeName, sGnflMc, sGnflExec);
  ���������3������Ӧ����bpl�������ֻ���Ϊ�գ�Ҫ��ÿ�δ����ֵ��һ������ᴴ�����UIR9_IMPLʵ����������ÿ��һ�����ڣ��ʹ���һ������
}
  {��ִ������֮ǰ��������APT}
  GAPTConnectEncrypt:=False;
  if (Sender <> nil) and FindAPT(TMenuItem(Sender)) then
     Self.LoadModeDll('APT', TMenuItem(Sender).Caption, 'APT')
  else if (Sender <> nil) and FindAPP(TMenuItem(Sender)) then
     Self.LoadModeDll('APP', TMenuItem(Sender).Caption, 'APP')
  else if Sender=nil then   //�����˵��������֧��Ҫ����FslUIR9_IMPL�Ĺ������ܹ��������
     Self.LoadModeDll('APT', sCurAPTsGnflmc, 'APT')
  else if Sender<>nil then begin
     //FindAPT(TMenuItem(Sender))����False����һ�����ƽ̨�µĽڵ�˵�������APTģ����
     GProSign_temp := GProSign;  
     Self.LoadModeDll('APT', TMenuItem(Sender).Caption, 'APT'); //Self.LoadModeDll('APT', '�Զ�ƾ֤', 'APT');
     if GProSign_temp<>'SYS' then
        GProSign := GProSign_temp;  //for ZWR900156965  �ڶ�̬��VoucherCSH.dll�Զ�ƾ֤�л����execute gl.bpl���µģ��˷����ƹ����ٴ���
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
  //�Ϻ����CA �����д���֤����Ϊ�����п���900s�������Զ��Ͽ�����ʱ��CA�������������ȫ��������ؿ��Ƽ��� Added by chengjf 2015-03-26 9:14:54
  if LoginKeyIntf.LoginKeyCanWriteGE then Exit;
  if GCzy.bCA then begin
     sKey := '';
     try
       sKey := LoginKeyIntf.ReadUserKEY_CA;
     except
     end;
     if sKey='' then begin
        SysMessage('������ʹ��CA֤����ܽ���ϵͳ��'+#13+'������20�����Զ��˳�,��ע�Ᵽ����Ҫ��Ϣ��','Login_01_JG', [mbOK]);
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
  procedure AddQuitMenu(AParentMenu: TMenuItem); //�����˳��˵�
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
  // ������ 2011.11.11 ȡ��һ�γ�ʼ������ģ��˵��Ĵ���ʽ������ Exit ֱ���˳����롣
  Exit;
(*
  // ������ 2011.10.26 ��¼���һ�ε�"����"�˵�ʱ��������ģ����¼������Ӳ˵���
  if (NGNFL.Tag > 0) then Exit;
  NGNFL.Tag := 1;

  // ��Ϊ�˵����������У����Ա��뵹��ѭ��������           
  for i := TreeViewFunc.Items.Count - 1 downto 0 do
  begin
    tmpNode := TreeViewFunc.Items[i];
    if (tmpNode <> nil) and (tmpNode.Level = 0) and (tmpNode.Data <> nil) then
    begin
      // ������ 2011.08.23 ǰ̨ģ��˵��״δ���ʱ�������������ܲ˵���������ֵΪFalse����һ�η��ʸ�ģ��ʱ�ٴ����������ܲ˵���������ֵ��ΪTrue��
      if not PTreeRec(tmpNode.Data)^.bSubMenuCreated then
      begin
        InitSubFuncTreeNode(tmpNode);
        PTreeRec(tmpNode.Data)^.bSubMenuCreated := True;
      end;
    end;
  end;
  AddQuitMenu(NGNFL); //�����˳��˵�
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
      // ������ 2011.08.23 ǰ̨ģ��˵��״δ���ʱ�������������ܲ˵���������ֵΪFalse����һ�η��ʸ�ģ��ʱ�ٴ����������ܲ˵���������ֵ��ΪTrue��
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
    //�Ȳ���ģ��Ľڵ�
    OERModNode := FindLevel0Node(tv,'���ϱ���');
    if OERModNode = nil then
      Exit;
    //�ٲ���Ҫ��Ӳ˵��Ĺ��ܲ˵�
    OERFuncNode := FindLevelNode(tv,OERModNode,'ҵ����');
    if OERFuncNode = nil then
      Exit;
    //��ѯ����SQL���
    szJKDSQL := 'select * from oer_djlx where gsdm='''+GszGSDM+''' and kjnd='''+GszKJND+''''
      +' and DJLXID<900 and YWLX=''0'' and ' + PSJQX('OBLX','DJLXBM') + 'and syzt=''2'' order by djlxbm';
    //��ѯ��������SQL���
    szBXDSQL := 'select * from oer_djlx where gsdm='''+GszGSDM+''' and kjnd='''+GszKJND+''''
      +' and DJLXID<900  and YWLX=''2'' and ' + PSJQX('OBLX','DJLXBM') + 'and syzt=''2'' order by djlxbm';

    //�ȴ�������
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

    //�ٴ����
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
  SysMessage('ѡ���Ѹı䣬�����µ�¼��', '', [mbOk]);
end;

procedure TFormMain.NDWZTClick(Sender: TObject);
begin
  NDWZT.Checked := not NDWZT.Checked;
  if NDWZT.Checked then
       PIniWriteS('GlSys.ini', 'NMainMenu', 'NDWZT', '1')
  else PIniWriteS('GlSys.ini', 'NMainMenu', 'NDWZT', '0');
  SysMessage('ѡ���Ѹı䣬�����µ�¼��', '', [mbOk]);
end;

procedure TFormMain.N7Click(Sender: TObject);
begin
  if not TPower.GetPower('9425') then //Gqx[ord(CZYGL_Edit)] then
  begin
    SysMessage('��û�и�Ȩ�ޡ�', 'PZ_97_JG', [mbOK]);
    Exit;
  end;
  ChangeUsername;
end;

procedure TFormMain.mniBinaryGetClick(Sender: TObject);
var
  filePath:string;
begin
  //zhengjy 20140429 ������������ʽͨѶ
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
  //���ĵ�Ԫ���÷�ʽ Modified by chengjf 2015-04-08
  LoadUserState;
end;

procedure TFormMain.tmrLockFormTimer(Sender: TObject);
begin
  if (tmrLockFormMin.Enabled) or (frmLockForm<>nil) then
    Exit;
  //���������Ϊ0���������µ�¼�󻹻ᵯ��һ������������⣬��Ϊ��ʱtmrLockForm.Enabled��Ϊtrue add by chengjf 20151022
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
      SysMessage('����ע����Ҫ�ȹر����д򿪵Ĵ��ڣ�����ĳЩû�б�������ݿ��ܶ�ʧ��', '', [mbOk]);
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
      if SysMessage('����ע����Ҫ�ȹر����д򿪵Ĵ��ڣ�����ĳЩû�б�������ݿ��ܶ�ʧ��'+#13#10
          +'���д򿪵Ĵ��ڶ����رգ��Ƿ������', '', [mbOK, mbCancel]) = MrCancel then
      exit;
      if (MDIChildCount > 1) then
      begin
//        if SysMessage('���д򿪵Ĵ��ڶ����رգ��Ƿ������', '', [mbOK, mbCancel]) = mrOk then
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

  DArrayTitle[0] := '  ���ܵ���';
  DArrayTitle[1] := '  ��λ����';
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
    //���ݼ�������������ҵ������ chengjf 20150608
    if not GAnyiLicenseInfo.IsConnected then begin
      // ������ 2010.12.07 MaxDate�����������ʾ���� + 1���������һ�첻�ܵ�¼��
      // ���������ʾ����11��30�գ���MaxDate������12��1��0ʱ0��0�룬������11��30��0ʱ0��0�롣
      DateTimePickerBusinessDate.MaxDate := TString.StrToDate(AI_DEMO_DATE); // + 1;   ���Ƶ�11.30��23.59.59ǰ���Ե�¼��12.01��Ӧ�ò������¼
    end else
    // ������ 2015.04.02 ���������Ȩ��������Ч��(VD>0)����ǰ̨��¼���ڲ��ܳ�������Ч�ڡ�
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
  //ά����20151231092454 �л�ǰ�ȱ����������� add by chengjf 20160121
  if Assigned(FormBackGround) then begin
     FormBackGround.SaveConfig(gCZy.name);
     FormBackGround.SaveDesktopImageSettings;
  end;

//  if tvAccInfo.Selected.ImageIndex<>2 then exit;
  //��ϸ���������л�
  if tvAccInfo.Selected.HasChildren then exit;

  //�����
  FGszGSDM := GszGSDM;
  FGszHSDWDM := GszHSDWDM;
  FGszHSDWMC := GszHSDWMC;
  FGszZth := GszZth;
  FGszZTMC := GszZTMC;
  FYWRQ := GszYWRQ;


//  if PublicUnit_SZ.DisplayAccount then
  if tvAccInfo.Selected.ImageIndex=2 then  //����
  begin
    GszGSDM := pDecodeDM(tvAccInfo.Selected.Parent.Text);
    GszHSDWMC := pDecodeDMP(tvAccInfo.Selected.Parent.Text);
    GszZth := pDecodeDM(tvAccInfo.Selected.Text);
    GszZTMC := pDecodeDMP(tvAccInfo.Selected.Text);
  end else   //ĩ����λ
  begin
    GszGSDM := pDecodeDM(tvAccInfo.Selected.Text);
    GszHSDWMC := pDecodeDMP(tvAccInfo.Selected.Text);
    GszZth := '';
    GszZTMC := '';
  end;
  GszHSDWDM:=GszGSDM;
  GszYWRQ := PGetPickerDate(DateTimePickerBusinessDate);
  //�����ǰ��λ���������л� Added by chengjf 2015-04-24
  if (FGszGSDM = GszGSDM) and (FGszZth = GszZth) and (FYWRQ = GszYWRQ) then Exit;
  //if Application.FindComponent('FormLogin') = nil then
  try
    Application.CreateForm(TFormLogin,FormLogin);
  //��¼ʧ��
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
        if PRegister.OpenKey(FormLogin.RegLoginPath, True) then //�쵼��ѯģʽ��¼,���¼��Ϣ����¼��ע���
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
  //hch 2009-07-26 ������λ��ֱ����ʾ������
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

  //������λ
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
    //�Ȳ���ģ��Ľڵ�
    OERModNode := FindLevel0Node(tv,'��������');
    if OERModNode = nil then
      Exit;
    //�ٲ���Ҫ��Ӳ˵��Ĺ��ܲ˵�
    OERFuncNode := FindLevelNode(tv,OERModNode,'ҵ����');
    if OERFuncNode = nil then
      Exit;

    szSQL:=' select * from FDA_DJLX where gsdm='''+ GszGSDM +'''' +
           ' and kjnd='''+ GszKJND + ''''+
           ' and syzt=''2'' and ' + PSJQX('FDADJ','DJLXBM') + ' order by fbzt';

    ACds.Data := DataModulePub.GetDataBySQL(szSQL);
    if ACds.RecordCount > 0 then
    begin
      ACds.last;               //����ֱ����ʽ order by   desc�������ã�ֻ�ܵ������Ӳ˵�����ֱ֤�����м����ʾ��һ��
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
  if tvAccInfo.selected.Text = '��λ����' then
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
  //ά����20151231092454 �л�ǰ�ȱ����������� add by chengjf 20160121
  if Assigned(FormBackGround) then begin
     FormBackGround.SaveConfig(gCZy.name);
     FormBackGround.SaveDesktopImageSettings;
  end;

  //�����
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
    //��¼ʧ��
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
        if PRegister.OpenKey(FormLogin.RegLoginPath, True) then //�쵼��ѯģʽ��¼,���¼��Ϣ����¼��ע���
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
  //hch 2009-07-26 ������λ��ֱ����ʾ������
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
//        LoadModeDll('BAS', '������λ����', 'bas.bpl');
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

