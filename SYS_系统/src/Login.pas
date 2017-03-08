unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LggExchanger, Db, DBClient, StdCtrls, Mask, Buttons, ComCtrls, jpeg, ExtCtrls,
  MConnect, SConnect, Registry, WEdit, ToolEdit, SMaskEdit, IniFiles, DataModuleMain,
  HTTPConnect, CMidasCon, RxGIF,AnyiClient, shellfolderBrowse, RXCtrls, Animate,
  GIFCtrl, FileCtrl, DBTables,MSXML2_TLB,ComObj,AnyiCoder,HttpFile, Menus,
  ToolWin;

const
  WM_TranUserDefData    = WM_USER + 1876;
  WM_LoginAsOfflineMode = WM_USER + 1877;
  
type

  TIntegrateOptions = procedure(AHandle: THandle); stdcall;

  TFormLogin = class(TForm)
    imgTop: TImage;
    pnl: TPanel;
    rxgfnmtr1: TRxGIFAnimator;
    PanelLogin: TPanel;
    ImageChgPassword: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    ComboBoxUser: TComboBox;
    EditPwd: TEdit;
    PanelOptions: TPanel;
    DateTimePickerBusinessDate: TDateTimePicker;
    ButtonOK: TButton;
    ButtonCancel: TButton;
    ButtonOptions: TButton;
    ButtonHelp: TButton;
    Timer1: TTimer;
    PanelR: TPanel;
    LabelHost: TLabel;
    LabelPort: TLabel;
    LabelConType: TLabel;
    ComboBoxHost: TComboBox;
    SMaskEditPort: TSMaskEdit;
    CheckBoxPooler: TCheckBox;
    cbConType: TComboBox;
    Shape2: TShape;
    Label6: TLabel;
    LabelAppMode: TLabel;
    RadioButtonAutoApp: TRadioButton;
    RadioButtonHandApp: TRadioButton;
    PanelS: TPanel;
    LabelServerName: TLabel;
    lblUser: TLabel;
    LabelPassword: TLabel;
    EditPassword: TEdit;
    EditUserName: TEdit;
    ButtonTestConnect: TButton;
    SpeedButtonFind: TButton;
    lblInfo: TLabel;
    CdsLogin: TClientDataSet;
    PanelAppParam: TPanel;
    Label16: TLabel;
    Shape3: TShape;
    Label15: TLabel;
    Label17: TLabel;
    RadioButtonDataOut: TRadioButton;
    RadioButtonDataIn: TRadioButton;
    ButtonDataExcute: TButton;
    FilenameEditData: TFilenameEdit;
    LabelOption: TLabel;
    BrowseForShellFolderSelect: TBrowseForShellFolder;
    lblDBName: TLabel;
    EditDatabaseName: TEdit;
    LabelDBType: TLabel;
    ComboBoxDBType: TComboBox;
    lblZT: TLabel;
    cbxZT: TComboBox;
    PanelLoginSet: TPanel;
    Label14: TLabel;
    Label5: TLabel;
    Shape1: TShape;
    EditEditAccountFilter: TEdit;
    CheckBoxListAllUsers: TCheckBox;
    EditServerName: TEdit;
    lblDBTypeHint: TLabel;
    CheckBoxUseSameLoginParams: TCheckBox;
    PanelLoginAsID: TPanel;
    rbtnCZYName: TRadioButton;
    rbtnCZYID: TRadioButton;
    rxlbl1: TRxLabel;
    CheckBoxUseOfflineMode: TCheckBox;
    CheckBox1: TCheckBox;
    chkSaveUser: TCheckBox;
    btnUser: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButtonOKClick(Sender: TObject);
    procedure SpeedButtonOptionsClick(Sender: TObject);
    procedure ComboBoxUserChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ButtonHelpClick(Sender: TObject);
    procedure ComboBoxUserKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function GetNewProSign(AProSign: string): string;
    procedure SMaskEditPortKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxUserDropDown(Sender: TObject);
    procedure ImageChgPasswordMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageChgPasswordClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure cbConTypeChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure RadioButtonAutoAppClick(Sender: TObject);
    procedure CdsLoginAfterClose(DataSet: TDataSet);
    procedure SpeedButtonFindClick(Sender: TObject);
    procedure ButtonTestConnectClick(Sender: TObject);
    procedure LabelOptionClick(Sender: TObject);
    procedure ButtonDataExcuteClick(Sender: TObject);
    procedure RadioButtonDataInClick(Sender: TObject);
    procedure ComboBoxDBTypeChange(Sender: TObject);
    procedure cbxZTDropDown(Sender: TObject);
    procedure cbxZTChange(Sender: TObject);
    procedure EditServerNameExit(Sender: TObject);
    procedure EditPasswordChange(Sender: TObject);
    procedure CheckBoxUseOfflineModeClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure btnUserClick(Sender: TObject);
  private
    PRegister: TRegistry;
    PUserList, PHostList, PLanguageList: TStrings;
    PLoginAsUserID: Boolean;
    DBLst: TStringList;
    FIsChangeND: Boolean;
    FShowTitle: String;
    FReloginCzyID: String;
    FbBtnOKClick : boolean;
    //动态创建菜单
    pmUser: TPopupMenu;
    procedure IniConnect;
    procedure SetPanel(v: Boolean);
    function TestConnectServerDM(IsShowMsg: Boolean = true): Boolean;

    procedure GetAppServerInfoFromReg; //从注册表中读出中间层信息
    function WriteAppServerInfoToReg: Boolean; //写中间层信息到注册表
    procedure DoSaveUser;//add by wangxin 2015-08-17 v10.3升级将存储登录用户独立处理
    procedure WriteRegS(Akey,Avalue:string);//add by wangxin 2015-08-17 写注册表
    procedure DelRemUser(Sender: TObject);//add by wangxin 2015-08-18
    procedure ClearRemUsers(Sender: TObject);//add by wangxin 2015-08-18
    function MixStr(const AText: string): string; //加密中间层数据库密码 ，xiangjun 20070417
    function UnMixStr(const ACode: string; var AText: string): Boolean;
    function GetRegDBInfo: string;
    function GetRegLogPath: string;
    procedure SetIsChangeND(const Value: Boolean);
    procedure SetShowTitle(const Value: String);
    //hch 消息提示框，有时候无法获取消息的焦点，直接采用系统的消息提示框处理。
    procedure SysMessage(msg:String);
    // 崔立国 2010.10.12
    procedure WMLoginAsOfflineMode(var Message: TMessage); message WM_LoginAsOfflineMode;
    // 检查密码是否合规 Added by chengjf 2016-03-23
    function CheckPassword: Boolean;
  public
    bHSCAKey:Boolean;
    sHSCZY:string;  
    BlLoginOk: boolean;
    bLoginClick: Boolean;
    LoginCount: Integer;
    //是否取消选择单位.
    IsCancelChoseUnit: Boolean;
    function CheckAppVersion: Boolean;
    procedure ShowLogin;
    function ReChoseUnitLogin(piType:Integer): Boolean;
    //add by wangxin 2009.07.09不显示选择窗体界面
    function ChgUnitLogin: Boolean;
    function GetDWZTHExists: Boolean;
    //hch 初始化界面显示,R9i界面保持不变，R9界面需要进行调整
    procedure InitInterface;
    //判断是否是R9i数据库结构，根据GL_ztcs是否含有年度内容来进行判断
    function IsR9iDB: Boolean;
    function GetAccountList: Boolean;
    function GetDBName: string;
    procedure ReChangeDB(dbName:string='');
    procedure SetDBInfo;
    function GetWriteSubKey(Reg: TRegistry; const RootKey, ExeName: string): string;
    function GetReadSubKey(Reg: TRegistry; const RootKey, ExeName: string): string;
    property RegLoginPath:string read GetRegLogPath;
    property RegDBInfo:string read GetRegDBInfo;
    property IsChangeND:Boolean read FIsChangeND write SetIsChangeND;
    property ShowTitle:String read FShowTitle write SetShowTitle;
    property ReloginCzyID :string read FReloginCzyID write FReloginCzyID;  //zhengjy 2014-10-11 广西需求基础卫生版本,临时记录重新登陆时原操作员ID
  end;

const
  PDTStopTag = 0;
  PDTStr = 1;
  PDTInt = 2;
  PDTHandle = 3;

type
  TProfileChat = class(TObject)
  private
    FTmpStr: string;
    FStr: string;
    FInt: Integer;
    FGlobalMessage: UINT;
    FSelfHWnd: HWND;
    FTargetHWnd: HWND;
    FDataReady: Boolean;
    FDataType: Integer;
    FCommandList: TStrings;
    FIsDebug: Boolean;
    FDebugStr: string;
  private
    procedure ClearState;
    // Send
    function SendString(AWnd: HWnd; AStr: string): Boolean;
    // Get
    function RecvString(): string;
    function RecvInteger(): Integer;
    procedure ResponseCommand(AType: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    function RegProfileStr(AName: string; AVal: string): Boolean;
    procedure ClearProfiles;

    function GetProfileStr(AName: string): string;
    function GetProfileInt(AName: string): Integer;

    function MsgHandle(var Msg: TMessage): Boolean;
    property SelfHWnd: HWND read FSelfHWnd write FSelfHWnd;
    property TargetHWnd: HWND read FTargetHWnd write FTargetHWnd;
    property IsDebug: Boolean read FIsDebug write FIsDebug;
    property DebugStr: string read FDebugStr write FDebugStr;
  end;

var
  FormLogin: TFormLogin;    //是否网络启动
  FNetStart: Boolean;
  LocalZTH: string;
  GiConType:Integer;
  szOtherPassword:string;  // hch 2010.1.21 外部系统调用传入按明文处理的 password
  GsParamGNFLMC:string='';
  gsSingleMode_Bak:string;

function GetCacheService: string;

procedure ApplicationExec(ParentForm: TCustomForm = nil; Params: TStrings = nil);  //该函数为框架程序调用，其他模块勿用
procedure ApplicationRun();
procedure RunGNFLMC(sGNFLMC:String);
//function GetAllModeEncrypt:Boolean;
function SysLogin(Params: TStrings): Boolean;
function SysReLogin(KJND:String=''): boolean;

{zhangwh20120823获得调用参数的参数值        DDSL
 szParaName 的格式为“参数标识:实际参数名”
 如 MODEL:SA 、BILLID:00.2012.0.1 、CALL:FE
}
function FGetParaValueByName(szParaName:String):String;

const
  // Get copy from updateljxt.pas // bryan
  OldProSignNames: array[0..2, 0..19] of string = (
    ('GL', 'GS', 'CM', 'GZ', 'FA', 'ZJ', 'PR', 'BG', 'BZ', 'CS', 'ZB', 'PJ', 'SC', 'RI', 'NT' {}, '', '', '', '', ''),
    // Old
    ('GL', '', 'CM', 'PA', 'FA', 'BM;BMIN', '', 'BG', 'ECS', '', 'FBI', 'CHQ', '', '', 'NTMF;NTMD;NTMJ' {}, 'DBG',
    'FCP', 'ATM', 'ADM', 'CNT'), // New
    ('账务', '', '出纳', '工资', '固定资产', '资金', '', '预算分析', '报账', '', '财政指标与拨款', '票据', '', '',
    '非税' {之前有10个}, '部门预算', '集中支付', '农税征管', '会计档案', '合同管理') // Caption
    );

implementation

uses WinSock, Pub_Res, Pub_Global, Pub_Function, Pub_Message,
  Pub_Power, PubClass_GL, ChgPassword, SetGS, piKeyPass,
  DECUtil, Cipher, Hash, LoginKeyIntf, LoginSelectCZY,
  LoginHint, Pub_ProInfo, Main,Pub_SPlash, BackGroundUnit, UIR9_IMPL,
  SetKJND,UfileOper,UdataTransfer,UIKey,UKeyDataInterface;

{$R *.DFM}

const
  Ident_Password_2 = 'Password_2';
  Ident_Password = 'Password';

// 崔立国 2009.09.27 常州U盾登录相关代码。
type
  TLoginKey = record
    Enabled: Boolean;
    KeyType: string;
    UserID: string;
    UserName: string;
    Password: string;
    KeyDate: string;
    iReadType:Integer;
  end;

var
  gLoginKey: TLoginKey;
  GProfileTool: TProfileChat;
  bOtherParamsLogin:Boolean=False;

procedure TFormLogin.FormCreate(Sender: TObject);
var
  szPort, szHost, szUser,sKey: string;
  strlist1:TStrings;
  iVD: Integer;
begin
  CdsLogin.RemoteServer := DataModulePub.MidasConnectionPub;
  FShowTitle := '正在登录';
  InitInterface;
  self.ActiveControl := EditPwd;
  IsCancelChoseUnit := False; //是否取消选择单位.
  FNetStart := False;

  bLoginClick := False;
  LoginCount := 0; 

  // 崔立国 2009.07.14  部门预算单位版不控制加密。
  // 崔立国 2010.03.15  软加密不应该有登录日期限制。
  // if ((GszRelease = 'DEMO') or (GNotEncrypt = '1')) and 
  //if (GszRelease = 'DEMO') and (GszVersion <> 'SA') and (GszVersion <> 'DBGDS') then
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
  // 崔立国 2011.04.18 暂时只控制登录业务日期，不显示演示版字样。
  //DateTimePickerBusinessDate.MaxDate := TString.StrToDate('2011-06-30');

  // 初始化登录框的宽度和高度
  Height := Height - PanelOptions.Height;
  PanelLogin.Height := PanelLogin.Height - PanelOptions.Height;
  PanelOptions.Height := PanelOptions.Height - PanelAppParam.Height;
  PanelOptions.Visible := False;
  PanelAppParam.Visible := False;

  // 读注册表获取必要的登录信息
  PRegister := TRegistry.Create;
  PRegister.RootKey := HKEY_CURRENT_USER;

  // 崔立国 2010.10.11 保存Login界面上的【离线工作】选择状态（是否离线工作模式登录）
  if PRegister.OpenKey('\SOFTWARE\UFGOV', True) and
     PRegister.ValueExists('UseOfflineMode') then
  begin
    CheckBoxUseOfflineMode.Checked := PRegister.ReadBool('UseOfflineMode');
  end
  else
    CheckBoxUseOfflineMode.Checked := False;

  // 崔立国 2009.4.7 读取 UseSameLoginParams（所有前台模块使用相同的登录参数）参数值。
  if PRegister.OpenKey('\SOFTWARE\UFGOV', True) and
    PRegister.ValueExists('UseSameLoginParams') then
  begin
    CheckBoxUseSameLoginParams.Checked := PRegister.ReadBool('UseSameLoginParams');
  end
  else
    CheckBoxUseSameLoginParams.Checked := True;

  PUserList := TStringList.Create;
  PHostList := TStringList.Create;
  PLanguageList := TStringList.Create;

  GetAppServerInfoFromReg;

  // 取最近一次登录的用户和登录的中间层所在的机器
  if PHostList.Count > 0 then
    szHost := PHostList.Strings[PHostList.Count - 1];
  if PUserList.Count > 0 then
    szUser := PUserList.Strings[PUserList.Count - 1];

  //  初始化
  ComboBoxUser.Items.AddStrings(PUserList);
  if ComboBoxUser.Items.Count > 0 then //add by wangxin 215-08-17
  begin
    //ComboBoxUser.ItemIndex := 0;
    ComboBoxUser.ItemIndex := ComboBoxUser.Items.Count - 1;
  end;
  ComboBoxHost.Items.AddStrings(PHostList);
  if ComboBoxHost.Items.Count > 0 then
    ComboBoxHost.ItemIndex := ComboBoxHost.Items.Count - 1
  else
    ComboBoxHost.Text := '127.0.0.1';

  rbtnCZYID.Checked := PLoginAsUserID;

  // 崔立国 2009.11.27 重新登录时，取出当前连接的端口号。
  if DataModulePub.MidasConnectionPub.Connected then
    szPort := IntToStr(DataModulePub.MidasConnectionPub.ServerPort);

  if szPort <> '' then
    SMaskEditPort.Text := szPort
  else
    SMaskEditPort.Text := '211';

  GetHostNameIPAddress(GStation, GIPAddress);
  if not GAnyiLicenseInfo.IsConnected then begin // (GszRelease = 'DEMO')  then //or (GNotEncrypt = '1')
    if (Now < DateTimePickerBusinessDate.MaxDate) then
         DateTimePickerBusinessDate.Date := Now
    else DateTimePickerBusinessDate.Date := DateTimePickerBusinessDate.MaxDate - 1;
  end else
    DateTimePickerBusinessDate.Date := Now;

  // 2007-5-17 hch
  cbConType.ItemIndex := 0;
  cbConType.Enabled := false;
  LabelConType.Enabled := false;
  cbConTypeChange(nil);
  //惠山CA登录
  bHSCAKey := False;
  if (PIniReadS('GlSys.ini', 'HS_CAKey', 'HS_CAY_Enabled', '0')='1') and LoginKeyIntf.LoginKeyCanWriteHS then begin
     bHSCAKey := True;
     (*sHSCZY := LoginKeyIntf.ReadUserKEY_CA(False);
     ComboBoxUser.Items.Clear;
     strlist1 := Tstringlist.Create;
     ExtractStrings([';'], [' '], pchar(sHSCZY), strlist1);
     ComboBoxUser.Items.AddStrings(strlist1);
     strlist1.Free; *)
  end;
end;

procedure TFormLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // 崔立国 2010.11.12
  if (ModalResult = mrOK) then
  begin
    if GblOfflineMode then
    begin
      ShowMessage('*** 注意 ***' + #13#10#13#10 + 
                  '当前是【离线工作模式】，部分功能受到限制不能使用。如果想使用全部功能，请以【在线工作模式】重新登录。' + #13#10#13#10 +
                  '按下“确定”按钮开始离线工作。' + #13#10);

      // 崔立国 2011.06.20 "财政"不显示"G版"字样
      if (Pos('财政', GProSeriesName) > 1) then
        Application.MainForm.Caption := GProSeriesName +
                            '  【离线工作模式】 '
      else
        Application.MainForm.Caption := GProSeriesName +'('+GszEdition+')版' +
                            '  【离线工作模式】 ';
    end
    else
    begin
      // 崔立国 2011.06.20 "财政"不显示"G版"字样
      if GNOJMVer_CusName<>'' then else begin
         if (Pos('财政', GProSeriesName) > 1)  or (GszEdition='精华') then
           Application.MainForm.Caption := GProSeriesName
         else
           Application.MainForm.Caption := GProSeriesName;// +'('+GszEdition+')版';
      end;
    end;
  end;

  PUserList.Free;
  PHostList.Free;
  PLanguageList.Free;
  PRegister.Free;
  Action := caFree;
end;

procedure TFormLogin.FormShow(Sender: TObject);
var
  OptionsFileName: string;
begin
  Application.HelpFile := GetSYSHelpFile;

  SetComponentsColor(self);
  Left := (Screen.Width - Width) div 2;
  Top := Screen.Height * 2 div 7 - 10;
  // 崔立国 2009.02.23 根据加密产品授权控制前台可以连接的数据库类型
  if GAnyiLicenseInfo.IsConnected then
  begin
    if UpperCase(GszDBOS) = 'MSSQL' then
    begin
      ComboBoxDBType.ItemIndex := 0;
      ComboBoxDBType.Visible := False;
      lblDBTypeHint.Caption := 'SQL Server';
      lblDBTypeHint.Visible := True;
    end
    else if UpperCase(GszDBOS) = 'ORACLE' then
    begin
      ComboBoxDBType.ItemIndex := 1;
      ComboBoxDBType.Visible := False;
      lblDBTypeHint.Caption := 'Oracle';
      lblDBTypeHint.Visible := True;
    end;
    ComboBoxDBTypeChange(ComboBoxDBType);
  end
  else
  begin
  end;
  //只能连接SQL数据库，如果版本为B版本
  if (UpperCase(GszEdition) = 'B') or (UpperCase(GszEdition) = '精华') then
  begin
    ComboBoxDBType.ItemIndex := 0;
    ComboBoxDBType.Visible := False;
    lblDBTypeHint.Caption := 'SQL Server';
    lblDBTypeHint.Visible := True;
    ComboBoxDBTypeChange(ComboBoxDBType);
  end;

  ResImgReplace(Self);
  SetXPMenu(Self);
  //普及版
  //1、禁止用户更改中间层、
  //2、显示账套管理按钮，通过该按钮调用账套管理工具
  if GProSeries = 'S' then
  begin
    ComboBoxHost.Enabled := False;
    ComboBoxHost.Text := '127.0.0.1';
  end;
  Timer1.Enabled := False;

  // 崔立国 2010.12.10 暂时只有账务（总会计）可以使用离线功能。
  (*if (GProSign = 'GAL') or (GProSign = 'GL') then begin
    CheckBoxUseOfflineMode.Visible := True;
  end else begin *)
    CheckBoxUseOfflineMode.Visible := False;
    CheckBoxUseOfflineMode.Checked := False;
  //end;

  if IsChangeND then
    Timer1.Enabled := True;
  if ComboBoxUser.Text = '' then
  begin
    if self.Active then
      ComboBoxUser.SetFocus
  end
  else if self.Active then
    EditPwd.SetFocus;

  if GpsSeries = psR9 then
     cbxZTDropDown(nil);
  btnUser.Top := ComboBoxUser.Top;
end;

procedure TFormLogin.ButtonHelpClick(Sender: TObject);
var
  szOldHelpFile: string;
begin
  szoldHelpFile := Application.HelpFile;
  Application.HelpFile := GetSYSHelpFile;
  Application.HelpCommand(Help_Context, 10);
  Application.HelpFile := szoldHelpFile;
end;

procedure TFormLogin.SpeedButtonOptionsClick(Sender: TObject);
begin
  if GpsSeries = psR9i then
  begin
    if PanelOptions.Visible then
    begin
      PanelOptions.Visible := False;
      ButtonOptions.Caption := '选项(&P) >>';
      Height := Height - PanelOptions.Height;
    end
    else
    begin
      PanelOptions.Visible := True;
      ButtonOptions.Caption := '选项(&P) <<';
      Height := Height + PanelOptions.Height; //PanelLoginSet.Height +
    end;
  end
  else if GpsSeries = psR9 then
  begin
    if PanelOptions.Visible then
    begin
      PanelOptions.Visible := False;
      PanelLoginSet.Visible := False;
      ButtonOptions.Caption := '选项(&P) >>';
      Height := Height - PanelOptions.Height;
    end
    else
    begin
      PanelOptions.Visible := True;
      PanelLoginSet.Visible := True;
      ButtonOptions.Caption := '选项(&P) <<';
      Height := Height + PanelOptions.Height; //PanelLoginSet.Height +
    end;
  end;
end;

procedure TFormLogin.ComboBoxUserChange(Sender: TObject);
begin
  if (ComboBoxUser.Text <> '') and
    (ComboBoxHost.Text <> '') and (EditPwd.Text <> '') and
    (SMaskEditPort.Text <> '') then
  begin
    ButtonOK.Enabled := True;
  end
  else
  begin
    ButtonOK.Enabled := False;
  end;
  ImageChgPassword.Visible := (buttonOk.Enabled) and (DataModulePub.MidasConnectionPub.Connected);
  lblInfo.Visible := ImageChgPassword.Visible;

  if Sender = ComboBoxHost then
  begin
    if DataModulePub.MidasConnectionPub.Connected then
      DataModulePub.MidasConnectionPub.Connected := False;
  end;

  // 崔立国 2010.05.11 只有 ComboBoxUser 触发该事件才进行用户名/用户ID转换。
  if (Sender = ComboBoxUser) then
  begin
    // 崔立国 2010.03.31 支持操作员ID登录。
    if rbtnCZYID.Checked then
    begin
      GCzy.CzyCode := trim(ComboBoxUser.Text);
      if TryStrToInt(GCzy.CzyCode,GCzy.ID) and (Copy(GCzy.CzyCode,1,1)<>'0')  then begin
         GCzy.name := '';
         GCzy.LoginAsID := True;
      end else begin
         GCzy.ID := 0;
         GCzy.CzyCode := '';
         GCzy.name := ComboBoxUser.Text;
         GCzy.LoginAsID := False;
      end;

      (*try
        GCzy.ID := StrToInt(ComboBoxUser.Text);
        GCzy.name := '';
        GCzy.LoginAsID := True;
      except
        GCzy.ID := 0;
        GCzy.CzyCode := '';
        GCzy.name := ComboBoxUser.Text;
        GCzy.LoginAsID := False;
      end;*)
      
    end else
    begin
      GCzy.ID := 0;
      GCzy.CzyCode := '';
      GCzy.name := ComboBoxUser.Text;
      GCzy.LoginAsID := False;
    end;
  end;
end;

procedure TFormLogin.IniConnect;
var
  iCount, iNum: Integer;
  szHost, szUser, szPort: string;
  iUID: Integer;
  u: Cardinal;
begin
  iNum := 0;
  szHost := ComboBoxHost.Text;
  // 崔立国 2010.03.31 支持操作员ID登录。
  if rbtnCZYID.Checked then
  begin
    try
      iUID := StrToInt(ComboBoxUser.Text);
      szUser := '';
    except
      iUID := 0;
      szUser := ComboBoxUser.Text;
    end;
  end else
  begin
    iUID := 0;
    szUser := ComboBoxUser.Text;
  end;
  szPort := SMaskEditPort.Text;


  for iCount := 0 to Length(szHost) - 1 do
  begin
    if szHost[iCount] = '.' then
      iNum := iNum + 1;
  end;

  // 崔立国 2010.10.11 使用离线工作模式登录
  if GblOfflineMode then
  begin
    DataModulePub.MidasConnectionPub.Connected := False;
    DataModulePub.MidasConnectionPub.ConnectType := ctDCOM;
    DataModulePub.MidasConnectionPub.ComputerName := '';
    DataModulePub.MidasConnectionPub.ServerName := COfflineServerName;
    DataModulePub.MidasConnectionPub.ServerGUID := COfflineServerGUID;
    DataModulePub.MidasConnectionPub.Connected := True;

  end else
  begin

    if RadioButtonHandApp.Checked then
    begin
      // 手动模式

      // 设置相关属性 hch 增加两种属性
      // 2007-5-17 hch
      case cbConType.ItemIndex of
        0: DataModulePub.MidasConnectionPub.ConnectType := ctHTTP;
        1: DataModulePub.MidasConnectionPub.ConnectType := ctSockets;
      end;

      if DataModulePub.MidasConnectionPub.ConnectType = ctSockets then
      begin

        with DataModulePub.MidasConnectionPub do
        begin
          if iNum >= 4 then
            ComputerName := szHost
          else
          begin
            if szHost = '.' then
              ComputerName := '127.0.0.1'
            else
            begin
              u := inet_addr(PChar(szHost));
              if u = INADDR_NONE then
                ComputerName := szHost
              else
                ComputerName := szHost;
            end;
          end;
          ServerPort := StrToInt(szPort);
          try
            //如果连接失败，启动连接
            DataModulePub.MidasConnectionPub.ServerName := 'R9i_AppSrvr.R9DMPooler';
            DataModulePub.MidasConnectionPub.ServerGUID := CServerGUID;
            //ADO连接
            //DataModulePub.MidasConnectionPub.ServerName := 'R9i_AppSrv.SQLServerPub';
            //DataModulePub.MidasConnectionPub.ServerGUID := '{53E01AA5-85AC-4E55-9858-D08D8152055B}';
            DataModulePub.MidasConnectionPub.Connected := True;
          except
            abort;
          end;
        end;
      end
      else if DataModulePub.MidasConnectionPub.ConnectType = ctHttp then
      begin

        with DataModulePub.MidasConnectionPub do
        begin
          Prefix := 'dp=';
          ServerPlatform := spJava;
          URL := Trim(ComboBoxHost.Text);
          DataModulePub.MidasConnectionPub.Connected := True;
        end;

      end;
    end
    else
    begin
      // 自动模式
      //TerminateProcessByExeName('R9i_AppSrvr.exe');
      DataModulePub.MidasConnectionPub.Connected := False;
      DataModulePub.MidasConnectionPub.ConnectType := ctDCOM;
      DataModulePub.MidasConnectionPub.ComputerName := '';
      DataModulePub.MidasConnectionPub.ServerName := 'R9iApp.R9ServerDM';
      DataModulePub.MidasConnectionPub.ServerGUID := CLocalServerGUID;
      DataModulePub.MidasConnectionPub.Connected := True;

      if DataModulePub.MidasConnectionPub.Connected then
        SetDBInfo;
    end;
  end;

end;

procedure TFormLogin.ImageChgPasswordClick(Sender: TObject);
var
  szZTH, szLocalZTH: string;
  szDBType: string;
begin
  //if GpsSeries = psR9 then//wx 2009-10-15此连接验证不应该区分R9i和R9
  begin
    if RadioButtonHandApp.Checked and (GpsSeries = psR9i) then
    begin
      GDBType := GetDBType(True);//wx 2009-10-15 9i的中间层模式从数据库中读一下数据库类型
    end else if RadioButtonAutoApp.Checked then//wx 2009-10-15 直连接模式需写一下变动
    begin
      if not WriteAppServerInfoToReg then
        Exit;
      WriteDBType(GDBType);

    end;

    try
      IniConnect;
    except
      if ShowLoginHint('无法与应用服务器建立连接！' + #13#10#13#10 +
        '请检查：' + #13#10 +
        '    1、应用服务器地址是否正确；' + #13#10 +
        '    2、应用服务器是否正常启动。') = mrYes then
      begin
        PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
      end;
      Exit;
    end;
    if GpsSeries = psR9 then//2009-10-15非r9i的需要检查是否选择账套
    begin
      if cbxZT.ItemIndex < 0 then
        Exit;
    end;

    try
      if not DataModulePub.MidasConnectionPub.Connected then
      begin
        DataModulePub.MidasConnectionPub.Connected := True;
      end;
    except
      if ShowLoginHint('无法与应用服务器建立连接！' + #13#10#13#10 +
        '请检查：' + #13#10 +
        '    1、应用服务器地址是否正确；' + #13#10 +
        '    2、应用服务器是否正常启动。') = mrYes then
      begin
        PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
      end;
      Exit;
    end;
    if GpsSeries = psR9 then//2009-10-15非r9i的需要根据选择的账套切
    begin
      ReChangeDB;
    end;
  end;
  try
    ChangePassWord(true);
    EditPwd.Text := GCzy.Password; //更新登陆界面的密码。
  except
  end;
end;

function TFormLogin.GetReadSubKey(Reg: TRegistry; const RootKey, ExeName: string): string;
var
  i: Integer;
  sKey: string;
  ss: TStrings;
begin
  // 崔立国 2008.11.17 如果没有找到当前程序专用参数项，这个就是默认参数项。
  Result := RootKey;
  if CheckBoxUseSameLoginParams.Checked then
    Exit;

  // 崔立国 2008.11.17 查找当前程序专用的参数项
  if Reg.OpenKey(Result, False) and Reg.HasSubKeys then
  begin
    ss := TStringList.Create;
    try
      Reg.GetKeyNames(ss);
      for i := 0 to ss.Count - 1 do
      begin
        sKey := Result + '\' + ss[i];
        if Reg.OpenKey(sKey, False) and Reg.ValueExists(S_ExeName) then
        begin
          if SameText(ExeName, Reg.ReadString(S_ExeName)) then
          begin
            Result := sKey;
            Exit;
          end;
        end;
      end;
    finally
      ss.Free;
    end;
  end;
end;

// 崔立国 2008.11.17

function TFormLogin.GetWriteSubKey(Reg: TRegistry; const RootKey, ExeName: string): string;
var
  i: Integer;
  sKey, sn: string;
  ss: TStrings;
begin
  // 崔立国 2008.11.17 如果没有找到当前程序专用参数项，就在默认参数项的下级创建新的专用参数项。
  Result := RootKey;
  if CheckBoxUseSameLoginParams.Checked then
    Exit;

  // 崔立国 2008.11.17 查找当前程序专用的参数项
  if Reg.OpenKey(Result, False) and Reg.HasSubKeys then
  begin
    ss := TStringList.Create;
    try
      Reg.GetKeyNames(ss);
      for i := 0 to ss.Count - 1 do
      begin
        sKey := Result + '\' + ss[i];
        if Reg.OpenKey(sKey, False) and Reg.ValueExists(S_ExeName) then
        begin
          if SameText(ExeName, Reg.ReadString(S_ExeName)) then
          begin
            Result := sKey;
            Exit;
          end;
        end;
      end;
    finally
      ss.Free;
    end;
  end;
  // 崔立国 2008.11.17 如果没有找到当前程序专用参数项，就在默认参数项的下级创建新的专用参数项。
  Result := RootKey;
  i := 1;
  while i <= 10000 do
  begin
    sn := IntToStr(i);
    case Length(sn) of
      1: sn := '0000' + sn;
      2: sn := '000' + sn;
      3: sn := '00' + sn;
      4: sn := '0' + sn;
    end;
    sKey := Result + '\' + sn;
    if not Reg.OpenKey(sKey, False) then
    begin
      if Reg.OpenKey(sKey, True) then
        Reg.WriteString(S_ExeName, ExeName);
      Result := sKey;
      Exit;
    end;
    Inc(i);
  end;
end;

function TFormLogin.CheckPassword : Boolean;
begin
  Result := False;
  if (GblEncryType>0) and (Length(Trim(EditPwd.Text))<8) then
  begin
    SysMessage('密码长度必须8位以上（包括8位）');
    Exit;
  end;
  case GblEncryType of
    1:begin  //验证符合一种的可能
      if not (TCheckType.CheckCharType(EditPwd.Text,edCharTypeOne)
         or TCheckType.CheckCharType(EditPwd.Text,edCharTypeTwo)
         or TCheckType.CheckCharType(EditPwd.Text,edCharTypeThree)) then
      begin
        SysMessage('密码由字母、数字和特殊字符组成。密码必须符合其中一种组合');
        Exit;
      end;
    end;
    2:begin
      if not ((TCheckType.CheckCharType(EditPwd.Text,edCharTypeOne)
               and TCheckType.CheckCharType(EditPwd.Text,edCharTypeTwo))
         or (TCheckType.CheckCharType(EditPwd.Text,edCharTypeOne)
               and TCheckType.CheckCharType(EditPwd.Text,edCharTypeThree))
         or (TCheckType.CheckCharType(EditPwd.Text,edCharTypeTwo)
               and TCheckType.CheckCharType(EditPwd.Text,edCharTypeThree))) then
      begin
        SysMessage('密码由字母、数字和特殊字符组成。密码必须符合其中二种组合');
        Exit;
      end;
    end;
    3:begin
      if not (TCheckType.CheckCharType(EditPwd.Text,edCharTypeOne)
         and  TCheckType.CheckCharType(EditPwd.Text,edCharTypeTwo)
         and  TCheckType.CheckCharType(EditPwd.Text,edCharTypeThree)) then
      begin
        SysMessage('密码由字母、数字和特殊字符组成。密码必须符合其中三种组合');
        Exit;
      end;
    end;
    else begin

    end;
  end;
  Result := True;
end;

procedure TFormLogin.SpeedButtonOKClick(Sender: TObject);
var
  szPassword, szDBType, szUser, szMessage, sCZYCode: string; //zhangwh20120810
  iUID: Integer;
  iPos, iMessRes: Integer;
  SQL_TEMP: string;
  szAppVersion, szDatabaseVersion: string;
  tmpID,tmpCZY, tmpPassCode: string;
  FKJND, TempKJND, FHSDWDM, FHSDWMC, FCurDate: string;
  i,istart,iEnd:Integer;
  sKeyPass,sDecode,sTemp:string;
  bSucceed:Boolean;
label
  LoginFailure;
var
  iLoginDate: Integer;
  IsStart:Boolean;
  ssCZY: TStrings;
  sCZYID: string;
  sVersion: string;
  szVer: ShortString;
  sgsdmtemp,sKey: string;
begin
  GszDBNAME := GetDBName;
  // 崔立国 2009.02.16 支持R9i实名制注册，使用加密授权有效期控制登录业务日期。
  if (GiValidDate > 0) then begin
    iLoginDate := Trunc(DateTimePickerBusinessDate.Date);
    if (iLoginDate > GiValidDate) then begin
      Application.MessageBox(PChar('登录业务日期（' + FormatDateTime('yyyy"年"m"月"d"日"', iLoginDate) + '）' +
        '必须在加密许可有效期（' + FormatDateTime('yyyy"年"m"月"d"日"', GiValidDate) + '）之内。' + #13#10#13#10 +
        '按下"确定"按钮后请重新选择业务日期。'),
        '系统提示',MB_ICONInformation+MB_OK);

      DateTimePickerBusinessDate.SetFocus;
      Exit;
    end;

    if (iLoginDate >= GiValidDate - 30) then begin
       Application.MessageBox(PChar('产品使用许可授权将于' + FormatDateTime('yyyy"年"m"月"d"日"', GiValidDate) + '到期，请联系软件供应商购买许可服务。' + #13#10#13#10 +
        '按下"确定"按钮后继续登录。'),'系统提示',MB_ICONInformation+MB_OK);        
    end;
  end;

  // 崔立国 2010.10.11 保存Login界面上的【离线工作】选择状态（是否离线工作模式登录）
  if PRegister.OpenKey('\SOFTWARE\UFGOV', True) then begin
    PRegister.WriteBool('UseOfflineMode', CheckBoxUseOfflineMode.Checked);
  end;  

  // 崔立国 2010.12.10 暂时只有账务（总会计）可以使用离线功能。
  //if (GProSign = 'GAL') or (GProSign = 'GL') then
  //     GblOfflineMode := CheckBoxUseOfflineMode.Checked
  //else
  GblOfflineMode := False;
  FbBtnOKClick := True;
  WriteAppServerInfoToReg;
  FbBtnOKClick := False;

  // huangch 2008.11.17 保存 UseSameLoginParams（所有前台模块使用相同的登录参数）参数值。
  if PRegister.OpenKey('\SOFTWARE\UFGOV', True) then begin
     PRegister.WriteBool('UseSameLoginParams', CheckBoxUseSameLoginParams.Checked);
  end;  

  // 崔立国 2010.10.11 离线工作模式只能使用MSSQL/MSDE数据库。
  if GblOfflineMode then
     GDBType := MSSQL;
  WriteDBType(GDBType);

  BlLoginOk := false;
  GbSysLoginOK := false;
  SetPanel(True);
  if PanelOptions.Visible then begin
    PanelOptions.Visible := False;
    ButtonOptions.Caption := '选项(&P) >>';
    Height := Height - PanelOptions.Height;
  end;
  update;
  ShowLogin;

  ShowLogin;
  if bLoginClick then
    goto LoginFailure; // 防止重复点登陆造成错误,Lzn 2005.10.11
  update;
  if ButtonOK.Parent.Visible and ButtonOK.Visible and ButtonOK.Enabled then
    ButtonOK.SetFocus;
  if Length(Trim(SMaskEditPort.Text)) = 0 then
  begin
    SysMessage('请设置端口号。');
    goto LoginFailure;
    if (self.Active) and (PanelOptions.Visible) and SMaskEditPort.Enabled then
       SMaskEditPort.SetFocus;
  end;
  ShowLogin;
  try
    IniConnect;
  except
    // 崔立国 2010.10.11 离线工作模式登录
    if GblOfflineMode then
    begin
      SysMessage('无法使用离线工作模式！' + #13#10#13#10 +'请先通过门户网页安装【离线工作环境】。');
    end
    else
    begin
      if RadioButtonHandApp.Checked then
      begin
        if ShowLoginHint('无法与应用服务器建立连接！' + #13#10#13#10 +
          '请检查：' + #13#10 +
          '    1、应用服务器地址是否正确；' + #13#10 +
          '    2、应用服务器是否正常启动。') = mrYes then
        begin
          PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
        end;
      end
      else
      begin
        if ShowLoginHint('无法与数据库建立连接！' + #13#10#13#10 +
          '请检查：' + #13#10 +
          '    1、数据库地址是否正确；' + #13#10 +
          '    2、数据库是否正常启动。' + #13#10 +
          '    3、数据库名是否正确。') = mrYes then
        begin
          PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
        end;
      end;
    end;
    SetPanel(False);
    Exit;
  end;

  // 崔立国 2010.03.31 支持操作员ID登录。
  if rbtnCZYID.Checked then
  begin
    sCZYCode := trim(comboboxUser.Text);
    if TryStrToInt(sCZYCode,iUID) and (Copy(sCZYCode,1,1)<>'0')  then begin
       szUser := '';
    end else begin
       iUID := 0;
       szUser := ComboBoxUser.Text;
    end;
   (* try
      iUID := StrToInt(ComboBoxUser.Text);
      szUser := '';
    except
      iUID := 0;
      szUser := ComboBoxUser.Text;
    end;*)
  end else
  begin
    iUID := 0;
    sCZYCode := '';
    szUser := ComboBoxUser.Text;
  end;
  szPassword := EditPwd.Text;
  ShowLogin;
  
  try   // 启动中间层
    if not DataModulePub.MidasConnectionPub.Connected then
       DataModulePub.MidasConnectionPub.Connected := True;

    //hch 对于SQL处理该种方式
    if (GpsSeries = psR9) then
    begin
      try
        ReChangeDB
      except
        on e: exception do
        begin
          raise Exception.Create('更换数据库失败! ' + e.Message);
        end;
      end;
      //获取账套号和单位代码
      if CdsLogin.active then
      begin
        if CdsLogin.Locate('dbname', GszDBNAME, []) then
        begin
          GszGSDM := CdsLogin.FieldByName('dwdm').AsString;
          GszZTH := CdsLogin.FieldByName('zth').AsString;
          GszZTMC := CdsLogin.FieldByName('ztmc').AsString;
          GszHSDWDM := GszGSDM;
          GszHSDWMC := CdsLogin.FieldByName('dwmc').AsString;
          //2009.3.19 hy 在这里默认个GszHZGSDM和GszHZZTH赋值
          GszHZGSDM := GszHSDWDM;
          GszHZGSMC := GszHSDWMC;
          GszHZZTH := GszZTH;
          GszHZZTMC := GszZTMC;
          if PRegister.OpenKey(RegLoginPath, True) then
          begin
            PRegister.WriteString('Dwdm', GszHSDWDM);
            PRegister.WriteString('Dwmc', GszHSDWMC);
            PRegister.WriteString('Ztbh', GszZth);
            PRegister.WriteString('Ztmc', GszZTMC);
            PRegister.CloseKey;
          end;
        end;
      end;
    end
    else
    begin
      // 崔立国 2010.10.11 离线工作模式登录
      if not GblOfflineMode then
      begin
        if RadioButtonAutoApp.Checked then
        begin
          if DataModulePub.MidasConnectionPub.Connected then begin
           try
             if GDBType = MSSQL then
                  DataModulePub.MidasConnectionPub.AppServer.ChangeDB('MSSQL',EditDatabaseName.Text)
             else DataModulePub.MidasConnectionPub.AppServer.ChangeDB('ORACLE', '');
           except
             on e:Exception do begin
                SysMessage('数据库连接失败：'+#13+E.Message);
                SetPanel(False);
                Exit;
             end;
           end;

          end;
        end;
      end;
    end;

    if not IsR9iDB then
    begin
      SysMessage('您选择了旧版本账套，请使用相应的后台数据管理工具对其操作。'
        + #13#10 + '或者请使用升级工具将其升级到最新版本后再使用本工具。');
      SetPanel(False);
      Exit;
    end;

    GDBType := GetDBType(True);

    // 崔立国 2009.06.05 下列代码必须在 GetDBType(True) 之后执行。
    // 崔立国 2009.02.23 根据加密产品授权控制前台可以连接的数据库类型。
    if GAnyiLicenseInfo.IsConnected then // (GszRelease <> 'DEMO') then
    begin
      if UpperCase(GszDBOS) = 'MSSQL' then
      begin
        if GDBType = ORACLE then
        begin
          if GpsSeries = psR9i then
            Application.MessageBox(pChar('软件使用许可只能连接 SQL Server 数据库。' + #13#10#13#10 +
              '如果使用自动模式登录，请重新选择“数据库类型”；' + #13#10 +
              '如果使用手工模式登录，请修改应用服务器的数据库连接参数。'),
              '系统提示',MB_ICONInformation+MB_OK)
          else
            Application.MessageBox(pchar('软件使用许可只能连接 SQL Server 数据库。' + #13#10#13#10 +
              '请重新选择“数据库类型”；'),'系统提示',MB_ICONInformation+MB_OK);
          SetPanel(False);
          Exit;
        end;
      end
      else if UpperCase(GszDBOS) = 'ORACLE' then
      begin
        if GDBType = MSSQL then
        begin
          if GpsSeries = psr9i then
            Application.MessageBox(pchar('软件使用许可只能连接 Oracle 数据库。' + #13#10#13#10 +
              '如果使用自动模式登录，请重新选择“数据库类型”；' + #13#10 +
              '如果使用手工模式登录，请修改应用服务器的数据库连接参数。'),'系统提示',MB_ICONInformation+MB_OK)
                          
          else
            Application.MessageBox(pchar('软件使用许可只能连接 Oracle 数据库。'),'系统提示',MB_ICONInformation+MB_OK);
          SetPanel(False);
          Exit;
        end;
      end;
    end;
  except
    if GblOfflineMode then
    begin
      SysMessage('无法启用离线模式，请检查是否安装了离线环境。或请直接登录远程服务器。');
      CheckBoxUseOfflineMode.Checked := False;
      CheckBoxUseOfflineModeClick(nil);
    end else
    begin
      if ShowLoginHint('无法与数据库建立连接！' + #13#10#13#10 +
        '请检查：' + #13#10 +
        '    1、数据库地址是否正确；' + #13#10 +
        '    2、数据库是否正常启动。' + #13#10 +
        '    3、数据库名是否正确。') = mrYes then
      begin
        PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
      end;
    end;
    SetPanel(False);
    Exit;
  end;
  update;

  WriteDBType(GDBType);
  {
    zhengjy 2014-10-11 广西需求基础卫生版本，读取安全公共参数
  }
  ReadSafeParam;
  //zhengjy 2014-10-11 广西需求基础卫生版本，设置前后台的报文加密参数
  if GblMessageEncry=1 then
    HttpFile.HTTPEncrypted :=true;  //没有新包，无法调用，临时屏掉
  //重新赋值全局变量
  if GDbType = Oracle then begin  //考虑移到登录前的变量初始化中  999
    GBSpace := '_';
    GSQLStrADDChar := '||';
    GSQLSplitChar := ';';
    GszDbFgf :=';';
  end else begin
    GBSpace := '';
    GSQLSplitChar := ' ';
    GSQLStrADDChar := '+';
    GszDbFgf := '';
  end;
  //hch 是否记录日志
  GbUseLog := TLog.IsRecordLog;

  // 检查口令是否加密或是否允许加密   //GCzyMMCanJM := true;
  with DataModulePub do begin
    // 崔立国 2011.08.23 为减少前后台交互次数，提高登录速度，下面两次访问gl_czy的代码合并处理。
    //begin jm--
    (*if GCzyMMCanJM then begin
    try
      GCzyMMJM := false;
      SQL_TEMP := 'select id,name,password from gl_czy where name =''系统管理'' ';
      POpenSql(ClientDataSetTmp, SQL_TEMP);

      //if ClientDataSetTmp.FindFirst then begin
      //  if VertifyCZYMM('', '系统管理', ClientDataSetTmp.FieldByName('password').asString) then
      TAnyiCoder.Decode(ClientDataSetTmp.FieldByName('password').AsString,sKeyPass,bSucceed);
      if bsucceed then
         GCzyMMJM := true;

    except
      on E: Exception do begin
        // 崔立国 2008.06.03
        TLog.WriteErr('[1]检查口令时出现意外错误。错误信息：' + #13#10 + E.Message);
        SysMessage('检查口令时出现意外错误，请检查数据库服务器是否运行正常。');
        SetPanel(False);
        Exit;
      end;
    end;
    end; //end jm-- *)

    try // 检查口令是否正确
      if iUID > 0 then
      begin
        SQL_TEMP := 'select * from gl_czy ' + //非冻结操作员
                    ' where (((Upper(ID)='+IntToStr(iUID)+') or (Upper(czyCode)='''+AnsiUpperCase(sCZYCode)+'''))'+
                    '  and (type = ''1''))' +  //and (syzt <> ''2'')
                    '  or (name = ''系统管理'')' +
                    ' order by ID';
      end else if sCZYCode<>'' then begin  //操作员编码方式登录
        SQL_TEMP := 'select * from gl_czy ' +
                    ' where ((Upper(czyCode) = ''' + AnsiUpperCase(sCZYCode) + ''')' +
                    '  and (type = ''1'') )'+     //and (syzt <> ''2'')
                    '  or (name = ''系统管理'')';
      end else begin
        SQL_TEMP := 'select * from gl_czy ' + //非冻结操作员
                    ' where ((Upper(name) = ''' + AnsiUpperCase(ComboBoxUser.Text) + ''')' +
                    '  and (type = ''1'') )' +         //and (syzt <> ''2'')
                    '  or (name = ''系统管理'')' +
                    ' order by ID';
      end;
      POpenSql(ClientDataSetTmp, SQL_TEMP);

      // 跳过'系统管理'记录行。
      if (ClientDataSetTmp.FieldByName('ID').AsString = '0') then
      begin
        ClientDataSetTmp.FindNext;
      end;

      // 崔立国 2010.05.25 如果有多个符合条件的操作员，弹出对话框让用户选择。
      if ClientDataSetTmp.RecordCount > 2 then
      begin
        ssCZY := TStringList.Create;
        try
          repeat
            ssCZY.Add(ClientDataSetTmp.FieldByName('id').AsString + '|' +
                      ClientDataSetTmp.FieldByName('name').AsString+'|'+
                      ClientDataSetTmp.FieldByName('grpscript').AsString);
          until not ClientDataSetTmp.FindNext;

          if SelectLoginCZY(ssCZY, sCZYID) then
          begin
            SQL_TEMP := 'select * from gl_czy ' + //非冻结操作员
                        ' where (Upper(ID) = ' + sCZYID + ')' +
                        '  and (type = ''1'') and (syzt <> ''2'')';
            POpenSql(ClientDataSetTmp, SQL_TEMP);
          end else
          begin
            SysMessage('您取消了登录操作。');
            SetPanel(False);
            Exit;
          end;
        finally
          ssCZY.Free;
        end;
      end;

    except
      on E: Exception do
      begin
        // 崔立国 2008.06.03
        TLog.WriteErr('[2]检查口令时出现意外错误。错误信息：' + #13#10 + E.Message);
        SysMessage('检查口令时出现意外错误，请检查数据库服务器是否运行正常。');
        SetPanel(False);
        Exit;
      end;
    end;
    ShowLogin;

    GCzy.bCA := False;
    if not ClientDataSetTmp.Eof then begin 
      if ClientDataSetTmp.FieldByName('SYZT').AsString = '2' then

      begin
        SysMessage('当前用户已冻结，请重新选择或输入。');
        SetPanel(False);
        ComboBoxUser.SetFocus;
        Exit;      
      end;
      tmpPassCode := Trim(ClientDataSetTmp.FieldByName('password').asString);
      tmpID := Trim(ClientDataSetTmp.FieldByName('id').asString);
      tmpCZY := ClientDataSetTmp.FieldByName('name').asString;
      sgsdmtemp := ClientDataSetTmp.FieldByName('gsdm').asString;
      GCzy.sCzyGsdm := sGsdmTemp;

      sDecode := TAnyiCoder.Decode(tmpPassCode,sKeyPass,bSucceed); //尝试解密
      GCzyMMJM := bsucceed;   //解密是否成功，成功则表示该密码加密了

      //zhengjy 2014-10-11 广西需求基础卫生版本，插入状态记录
      if ((GblReLogin=1) or (GblInputCount>0))  then
        TControlLogin.addOperState(tmpID);

      //zhengjy 2014-10-11 广西需求基础卫生版本，验证用户是否已经登陆
      if (GblReLogin=1) and (tmpID<>'1')
         and (FReloginCzyID<>tmpID) then  //后面条件控制重新登陆时，不进行验证
      begin
        case  TControlLogin.GetOperState(tmpID) of
          2 :begin
            SysMessage('用户已经登陆，不允许重复登陆，请与系统管理员联系！');
            SetPanel(False);
            EditPwd.SetFocus;
            exit;
          end;
        end;
      end;
      //zhengjy 2014-10-11 广西需求基础卫生版本，判断是否锁定
      if  GblInputCount>0 then
      begin
        if TControlLogin.IsLockOper(tmpID)=1 then
        begin
          SysMessage('用户已经锁定，需"'+IntToStr(GblLimitTime)+'"分钟后自动解锁（或与系统管理员联系）！');
          SetPanel(False);
          EditPwd.SetFocus;
          exit;
        end;
      end;

      //GCzyMMCanJM := GCzyMMJM;
      //if (GCzyMMJM and (VertifyCZYMM(tmpCzy, EditPwd.text, tmpPassCode) or VertifyCZYMM(tmpCzy, szOtherPassword, tmpPassCode))) or
      //  ((not GCzyMMJM) and ((tmpPassCode = EditPwd.Text) or (szOtherPassword = tmpPassCode)) and (tmpPassCode <> ''))  then
      if (GCzyMMJM and (sDecode=Trim(EditPwd.Text)))
         or ((not GCzyMMJM) and ((tmpPassCode = EditPwd.Text) or (szOtherPassword = tmpPassCode)) and (tmpPassCode <> ''))  then
      begin
        GCzy.ID := ClientDataSetTmp.FieldByName('ID').asInteger;
        GCzy.name := ClientDataSetTmp.FieldByName('name').asString;
        GCzy.CzyCode := ClientDataSetTmp.FieldByName('CzyCode').asString;
        GCzy.LoginAsID := rbtnCZYID.Checked;
        GCzy.GID := ClientDataSetTmp.FieldByName('GroupID').asInteger;
        GCzy.Password := EditPwd.Text;
        GSJQXFX := ClientDataSetTmp.FieldByName('kzqx').asString;

        //zhengjy 2014-10-11 广西需求基础卫生版本，当打开"密码输入次数"或"用户登陆限制"则对应有用户状态查询界面，只有系统管理员能使用此功能
        if ((GblInputCount>0) or (GblReLogin=1)) and (GCzy.ID=1) then FormMain.mniUserState.Visible :=true
        else FormMain.mniUserState.Visible :=false;

        if LoginKeyIntf.LoginKeyCanWriteHS then begin
          if (ClientDataSetTmp.FindField('CaKeyFixdUSer') <> nil) and bHSCAKey and (ClientDataSetTmp.FieldByName('CaKeyFixdUSer').AsString = '1') then begin  //惠山CA不需要前台登录时控制，主要是门户控制即可
             sHSCZY := LoginKeyIntf.ReadUserKEY_CA(False);
             if Trim(sHSCZY)='' then begin
                SysMessage('当前登录用户：'+GCzy.Name+' 已绑定CA证书登录，请插入您自己的CA证书再登录');
                SetPanel(False);
                Exit;
             end;
             if Pos(GCzy.name+';',sHSCZY)<=0 then begin
                SysMessage('登录被拒：当前用户:'+GCzy.Name+'，与CA的登录用户不一致。'+#13#10+'请插入您自己的CA证书再登录');
                SetPanel(False);
                Exit;
             end;
          end   
        end else
        // 崔立国 2009.06.16 以下代码检查是否需要登录卡（登录U盾）才能登录。
        if (ClientDataSetTmp.FindField('LoginKeyEnabled') <> nil) and
           (ClientDataSetTmp.FieldByName('LoginKeyEnabled').AsString = '1') then
        begin

          with gLoginKey do
          begin
            Enabled := False;
            UserID := '';
            UserName := '';
            Password := '';
            KeyDate := '';
          end;
          try
            if LoginKeyIntf.LoginKeyEnabled then
               gLoginKey.KeyType := GetLoginKeyType;

            gLoginKey.Enabled := LoginKeyIntf.ReadUserInfo(gLoginKey.UserID, gLoginKey.UserName, gLoginKey.KeyDate) ;
            if gLoginKey.Enabled then
            begin
              if not SameText(gLoginKey.UserName, GCzy.name) then
              begin
                Pub_Message.SysMessage('登录被拒绝！' + #13#10 + #13#10 +
                           '当前用户（' + GCzy.name + '）与U盾的登录用户（' + gLoginKey.UserName + '）不一致。' +#13#10 +
                           '请插入您自己的U盾重新登录。', 'Login_01_JG', [mbOK]);
                SetPanel(False);
                EditPwd.SetFocus;
                Exit;
              end;
            end
            else
            begin
              gLoginKey.UserName := GCzy.name;
              gLoginKey.Enabled := LoginKeyIntf.ReadUserInfo2(GszVersion, gLoginKey.UserID, gLoginKey.UserName, gLoginKey.Password, gLoginKey.KeyDate);
              if not gLoginKey.Enabled then
              begin
                Pub_Message.SysMessage('您必须使用登录U盾才能进入系统，请插入U盾后重新登录。' + #13#10 + #13#10 +
                                       '错误信息:  ' + LoginKeyIntf.GetLastError, 'Login_01_JG', [mbOK]);
                SetPanel(False);
                EditPwd.SetFocus;
                Exit;
              end;
            end;
          except
          end;
        // 崔立国 2009.06.16 以上检查是否需要登录卡（登录U盾）才能登录。
        //Lzn 2011.07.01 以上检查是否需要CA-KEY（登录CA_key）才能登录。 -- {(ParamCount<12) and} 门户已进行了CA验证，但客户端还要验证下，需要接受门户传过来的pin密码再验证下
        //chengjf 20150331增加or (LoginKeyIntf.LoginKeyCanWriteGE)条件，如果是上海格尔CA，则门户进入和直接进入都要检查CA
        end else if ((ParamCount<10) or (LoginKeyIntf.LoginKeyCanWriteGE))and(ClientDataSetTmp.FindField('LoginCaKeyEnabled')<> nil) and (ClientDataSetTmp.FieldByName('LoginCaKeyEnabled').AsString = '1') then begin  //and (ClientDataSetTmp.FindField('LoginCaKeyPIn')<> nil)
          //  Pub_Message.SysMessage('您必须使用CA证书才能进入系统，请插入CA证书后重新登录。' + #13#10 + #13#10 +
          //                         '错误信息：设置设备类型或设备初始化失败。' ,'Login_01_JG', [mbOK]);
          GCzy.bCA := True;
          //10.3中增加了对CA的加密授权，ShowCustomerInfo控制取消 Modified by chengjf 2016-07-08
          //if FormBackGround.ShowCustomerInfo then //add by wangxin 2014-12-05 是否取到客户信息来判断是否使用ca
          begin
            sKey := LoginKeyIntf.ReadUserKEY_CA; //'abcde'; ShowMessage('1:'+skey);
            if sKey='' then begin
               Pub_Message.SysMessage('您必须使用CA证书才能进入系统，请插入CA证书后重新登录。' + #13#10 + #13#10 +
                                      '错误信息：设置设备类型或设备初始化失败。' ,'Login_01_JG', [mbOK]);
               Exit;
            end;












            if (ClientDataSetTmp.FindField('CaKeyFixdUSer')<> nil) and (ClientDataSetTmp.FindField('CaKeyFixdXH')<> nil) and (ClientDataSetTmp.FieldByName('CaKeyFixdUSer').AsString = '1') then begin
               if Trim(ClientDataSetTmp.FieldByName('CaKeyFixdXH').AsString)='' then begin
                  Pub_Message.SysMessage('没有设置绑定的CA证书。','Login_01_JG', [mbOK]);
                  Exit;
               end;
               if Trim(ClientDataSetTmp.FieldByName('CaKeyFixdXH').AsString)<>sKey then begin
                  Pub_Message.SysMessage('当前操作员未与当前CA证书进行绑定，请插入您自己的CA证书后重新登录。','Login_01_JG', [mbOK]);
                  SetPanel(False);
                  EditPwd.SetFocus;
                  Exit;
               end;
            end;

            POpenSql(DataModulePub.ClientDataSetPub, 'Select * from gl_czy where type=''1'' and id<>' + IntToStr(GCzy.id) +' and CaKeyFixdUSer=''1'' and CaKeyFixdXH='''+sKey+'''');
            if DataModulePub.ClientDataSetPub.RecordCount>0 then begin  //没有其他人绑定
               Pub_Message.SysMessage('CA证书验证未通过!' + #13#10 + #13#10 +
                           '请使用与您自己绑定的CA证书。', 'Login_01_JG', [mbOK]);
               SetPanel(False);
               EditPwd.SetFocus;
               Exit;
            end;

            try
              if GbCaPinLogin then begin                //ShowMessage('pin密码是'+GsPin);
                  gLoginKey.iReadType := LoginKeyIntf.ReadUserInfo_CA(Trim(GsPin));
              end
              else gLoginKey.iReadType := LoginKeyIntf.ReadUserInfo_CA('');























              case gLoginKey.iReadType of
                 7:begin
                     Pub_Message.SysMessage('CA证书已过期。','Login_01_JG', [mbOK]);
                     SetPanel(False);
                     EditPwd.SetFocus;
                     Exit;
                   end;
               0,1:begin
                     Pub_Message.SysMessage('您必须使用CA证书才能进入系统，请插入CA证书后重新登录。' + #13#10 + #13#10 +
                                             '错误信息：设置设备类型或设备初始化失败。' ,'Login_01_JG', [mbOK]);
                     SetPanel(False);
                     EditPwd.SetFocus;
                     Exit;
                   end;
                 8:begin  //验证未成功
                     Pub_Message.SysMessage('CA证书验证未通过!' + #13#10 + #13#10 +
                              '可能是没有加载CA根证书文件"CA_CERT.cer"到程序目录'+#13#10 +
                              '或者是没有插入您自己的CA证书。', 'Login_01_JG', [mbOK]);
                     SetPanel(False);
                     EditPwd.SetFocus;
                     Exit;
                   end;
                 9:begin     //密码错误，提示重新录入。若没提示或已锁定
                     SetPanel(False);
                     EditPwd.SetFocus;
                     Exit;
                   end;

                10:begin
                     //验证通过
                     GCzy.bCA := True;
                   end;

                (*11:begin  //验证通过
                     if (sPinPass<>'') and (sPinPass<>ClientDataSetTmp.FieldbyName('LoginCaKeyPIn').AsString) then begin
                        //表示PIN密码已重新录入，和数据库保存的PIN不一致，需要更新数据库
                        try
                          PExecSQL('update gl_czy set LoginCaKeyPIn='''+sPinPass+''' where id='+ClientDataSetTmp.FieldbyName('id').AsString);
                        except
                        end;
                     end;
                   end; *)

                 else begin
                    Pub_Message.SysMessage('CA证书验证未通过!' + #13#10 + #13#10 +
                                           '请使用您自己的CA证书。', 'Login_01_JG', [mbOK]);
                    SetPanel(False);
                    EditPwd.SetFocus;
                    Exit;
                 end;
              end;
            except
              Pub_Message.SysMessage('CA证书验证失败。','Login_01_JG', [mbOK]);
              SetPanel(False);
              EditPwd.SetFocus;
              Exit;
            end;
          end;
          //10.3中增加了对CA的加密授权，ShowCustomerInfo控制取消 Modified by chengjf 2016-07-08
//          else
//          begin
//            Pub_Message.SysMessage('CA用户信息初始化失败,请与软件供应商联系。' ,'Login_01_JG', [mbOK]);
//            Exit;
//          end;

        end;
        // lzn 2011.07.01 以上检查是否需要CA-KEY（登录CA_key）才能登录。
        (*if ParamCount>10 then begin //从外围进来
           if ClientDataSetTmp.FieldByName('LoginPTEnabled').AsString<>'1' then begin
              SysMessage('当前用户已设置只能通过平台门户登录。');
              SetPanel(False);
              EditPwd.SetFocus;
              Exit;
           end;
        end;  *)
        if (ParamCount<10) and(ClientDataSetTmp.FieldByName('LoginPTEnabled').AsString='1') then begin
            SysMessage('当前用户已设置只能通过平台门户登录。');
            SetPanel(False);
            EditPwd.SetFocus;
            Exit;
        end;
        if (ParamCount>10) and GbAgainLogin and (ClientDataSetTmp.FieldByName('LoginPTEnabled').AsString='1') then begin
            SysMessage('当前用户已设置只能通过平台门户登录。');
            SetPanel(False);
            EditPwd.SetFocus;
            Exit;
        end;
      end
      else
      begin
        //SysMessage('登录用户名或口令错误，或该用户被冻结，请重新选择或输入。');
        SysMessage('用户口令错误，请重新选择或输入。');

        {
          zhengjy 2014-10-11 广西需求基础卫生版本，密码输入错误增加记数
        }
        if (GblInputCount>0) then
        begin
          TControlLogin.LockOperProcess(tmpID);
          if TControlLogin.IsLockOper(tmpID)=1 then
          begin
            SysMessage('用户已经锁定，需"'+IntToStr(GblLimitTime)+'"分钟后自动解锁（或与系统管理员联系）！');
          end;
        end;

        SetPanel(False);
        EditPwd.SetFocus;
        Exit;
      end;
    end
    else
    begin
      //SysMessage('登录用户名或口令错误，或该用户被冻结，请重新选择或输入。');
      SysMessage('当前用户不存在，请重新选择或输入。');
      SetPanel(False);
      ComboBoxUser.SetFocus;
      Exit;
    end;
  end;
  DoSaveUser;//add by wangxin 2015-08-17 登录验证通过后记忆操作

  //zhengjy 20140717 采用数据流方式通讯
  Main.SetR9PacketsCDS;

  ShowLogin;
  //将当前Exe的文件版本与sysControlVersion的数据库版本进行比较，如果 大版本号差异，则提示
  szAppVersion := GetProgramInfo(application.exename, 'FileVersion');
  ShowLogin;
  //保存登陆中间层信息
  GszServerComputer := ComboBoxHost.Text;
  GszServerPort := SMaskEditPort.Text;
  GszConType := cbConType.Text;

  GblTYLZT := False;
  GblXZSYLZT := True;
  ShowLogin;
  GszLanguage := '中文';

{$IFNDEF ocx}
    if ((GszHSDWDM = '') or (GszHSDWDM <> CSysDWDM)) and (not FNetStart) then {// 不是直接传参数，而是直接通过命令启动} 
    if PRegister.OpenKey(RegLoginPath, True) then begin
      GszHSDWDM := PRegister.ReadString('Dwdm');
      GszHSDWMC := PRegister.ReadString('Dwmc');
      GszGSDM := GszHSDWDM;//2010.1.7 hy 珠海全面预算支持跨年账套
      GszZth := PRegister.ReadString('Ztbh');
      GszZTMC := PRegister.ReadString('Ztmc');
      PRegister.CloseKey;
    end;
{$ENDIF}

  // 2007-7-9 16:49 hch 获取会计年度
  //GszKJND := Copy(GszYWRQ, 1, 4);
  //2009.12.9 hy 原来直接使用业务日期得到会计年度，不支持跨年度的账套，
  //现在改为先取当前账套的会计年度，如果没有，再从业务日期得到会计年度
  GProSign := 'SYS';         //维护单ZWR900314014 指定产品标识为sys，更改单位或重新登录时用到 chengjf 20151228
  GszYWRQ := PGetPickerDate(DateTimePickerBusinessDate);
  GszKJND := PGetKjnd(GszYWRQ);
  if GszKJND = '' then
     GszKJND := Copy(GszYWRQ, 1, 4);

  ShowLogin;


  //zhengjy 20161213 初始化手写签名工厂类
  KeyFactroy :=GetKeyFactory;
  //zhengjy 20161226 依据数据库加密控制菜单显示
  FormBackGround.GetCustomerCaption; //获得加密的显示内容
  FormBackGround.DealSignCertMenu;  //预置手写签字菜单，必须放在 GetCustomerCaption之后，ShowCustomerInfo之后。
  FormBackGround.ShowCustomerInfo;   //进行显示。

  with DataModulePub do
  begin
    //zhengjy 郑建鹰 2008-7-1 begin 部门预算跨年度的时间调整。
    if (GszVersion = 'DBGFS') or (GszVersion = 'DBGDS') then
    begin
    end else
    begin
    //zhengjy 郑建鹰 2008-7-1 end 部门预算跨年度的时间调整。

      if (GszHSDWDM <> '') and (GszHSDWDM <> CSysDWDM) then
      begin
        if GpsSeries = psR9i then
        begin
          try
            SQL_TEMP := 'select * from PubGSZL where kjnd=''' + GszKJND + ''' and GSDM=''' + GszHSDWDM + ''' and ' + PSJQX('G', 'GSDM');
            POpenSql(ClientDataSetTmp, SQL_TEMP);
          except
            on E: Exception do
            begin
              SysMessage('检查单位信息失败。' + #13#10 + E.Message);
              SetPanel(False);
              Exit;
            end;
          end;

          if ClientDataSetTmp.RecordCount = 0 then
          begin
            GszHSDWDM := '';
            GszHSDWMC := '';
            GszZTH := '';
            GszZTMC := '';
          end else
          begin
            if ClientDataSetTmp.FieldByName('syzt').asString = '2' then
            begin
              SysMessage('该单位已经被冻结,不允许登录。');
              SetPanel(False);
              Exit;
            end;
            GszHSDWMC := ClientDataSetTmp.FieldByName('gsmc').asString;
          end;
        end
        else
        begin
          try
            SQL_TEMP := 'select * from GL_ZTCS where kjnd=''' + GszKJND + ''' and HSDWDM=''' + GszHSDWDM + ''' and ' + PSJQX('G', 'HSDWDM');
            POpenSql(ClientDataSetTmp, SQL_TEMP);
          except
            SysMessage('检查单位信息失败。');
            SetPanel(False);
            Exit;
          end;

          if ClientDataSetTmp.RecordCount = 0 then begin
            SysMessage('检查账套信息失败, 原因如下：' + #13#10
              + '1. 请确定是账套信息表中的单位代码是否与数据库中一致。'
              + #13#10 + '2. 请确定是否含有本年度数据，如果没有请进行下年度数据初始化。');
            SetPanel(False);
            Exit;
           (*
            //去掉一致性检查，改成从数据库中取公司代码，账套号等参数
            try
              SQL_TEMP := 'select * from GL_ZTCS where kjnd=''' + GszKJND + ''' and HSDWDM<>''' + CSysDWDM + ''' and ztbh<>'''+CSysZTH+''' and ' + PSJQX('G', 'HSDWDM');
              POpenSql(ClientDataSetTmp, SQL_TEMP);
            except
              SysMessage('检查单位信息失败。');
              SetPanel(False);
              Exit;
            end;
            if ClientDataSetTmp.RecordCount <> 0 then begin
              GszGSDM := ClientDataSetTmp.FieldByName('hsdwdm').AsString;
              GszZTH := ClientDataSetTmp.FieldByName('ztbh').AsString;
              GszZTMC := ClientDataSetTmp.FieldByName('ztmc').AsString;
              GszHSDWDM := GszGSDM;
              GszHSDWMC := ClientDataSetTmp.FieldByName('hsdwmc').AsString;
              //2009.3.19 hy 在这里默认个GszHZGSDM和GszHZZTH赋值
              GszHZGSDM := GszHSDWDM;
              GszHZGSMC := GszHSDWMC;
              GszHZZTH := GszZTH;
              GszHZZTMC := GszZTMC;
              if PRegister.OpenKey(RegLoginPath, True) then begin
                PRegister.WriteString('Dwdm', GszHSDWDM);
                PRegister.WriteString('Dwmc', GszHSDWMC);
                PRegister.WriteString('Ztbh', GszZth);
                PRegister.WriteString('Ztmc', GszZTMC);
                PRegister.CloseKey;
              end;
            end else begin
              SysMessage('检查账套信息失败, 原因如下：' + #13#10+
                       ' 请确定是否含有本年度数据，如果没有请进行下年度数据初始化。'+#13#10+'请确定您是否有相关单位的数据权限');
              SetPanel(False);
              Exit;
            end;  *)
          end else begin
            GszHSDWMC := ClientDataSetTmp.FieldByName('HSDWMC').asString;
          end;
        end;
      end;
    end;

    if Trim(GszZTH) <> '' then //门户传入的为空格
    begin
      try
        SQL_TEMP := 'select * from gl_ztcs where kjnd=''' + GszKJND + ''' and hsdwdm=''' + GszHSDWDM + ''' and ztbh=''' + GszZTH + ''' and ' +
          PSJQX('ZT', 'ztbh');
        POpenSql(ClientDataSetTmp, SQL_TEMP);
      except
        SysMessage('检查账套信息失败。');
        SetPanel(False);
        Exit;
      end;
      
      if ClientDataSetTmp.RecordCount = 0 then begin
        if GpsSeries = psR9i then begin
          GszZTH := '';
          GszZTMC := '';
        end else begin
         (* SQL_TEMP := 'select * from gl_ztcs where kjnd=''' + GszKJND + ''' and HSDWDM<>''' + CSysDWDM + ''' and ztbh<>'''+CSysZTH+''' and hsdwdm=''' + GszHSDWDM + ''' and '+PSJQX('ZT', 'ztbh');
          POpenSql(ClientDataSetTmp, SQL_TEMP);
            if ClientDataSetTmp.RecordCount <> 0 then begin
              GszZTH := ClientDataSetTmp.FieldByName('ztbh').AsString;
              GszZTMC := ClientDataSetTmp.FieldByName('ztmc').AsString;
              GszHZZTH := GszZTH;
              GszHZZTMC := GszZTMC;
              if PRegister.OpenKey(RegLoginPath, True) then begin
                PRegister.WriteString('Ztbh', GszZth);
                PRegister.WriteString('Ztmc', GszZTMC);
                PRegister.CloseKey;
              end;
            end else begin
              SysMessage('检查账套信息失败, 原因如下：' + #13#10+
                       ' 请确定是否含有本年度数据，如果没有请进行下年度数据初始化。'+#13#10+'请确定您是否有相关账套的数据权限');
              SetPanel(False);
              Exit;
            end;  *)
          SysMessage('检查账套信息失败, 原因如下：' + #13#10
            + '1. 请确定是账套信息表表中的单位代码是否与数据库一致。'
            + #13#10 + '2. 请确定是否含有本年度数据，如果没有请进行下年度数据初始化。');
          SetPanel(False);
          Exit;
        end;
      end
      else
        GszZTMC := ClientDataSetTmp.FieldByName('ztmc').asString;
    end else
    begin
      //FUXJ去掉原来Login.pas中SpeedButtonOKClick方法调用的 PInitZTCS
      //释放了Main中InitAccount 方法中调用的 PInitZTCS
      SQL_TEMP := 'select * from gl_ztcs where hsdwdm=''' + CSysDWDM + ''' and ztbh=''' + CSysZTH + ''' and kjnd=''' + GszKJND + ''' ';
      POpenSql(DataModulePub.ClientDataSetTmp, SQL_TEMP);
    end;

    GszGSFJ := DataModulePub.ClientDataSetTmp.FieldByName('gsbmfa').asstring;
    //hch DLSI 获取每页的数量
    GiPagePerNum := StrToIntDef(DataModulePub.ClientDataSetTmp.FieldByName('bmbmfa').AsString, 500);  // 2007-8-27 19:50 hch 初始化GsProductSign
  end;

  ShowLogin;  //ShowMessage('GszVersion='+GszVersion+' GszHSDWDM='+GszHSDWDM+' GProSign='+GProSign);

 //zhengjy 2013-06-03 增加大附件的初始化参数
  if RadioButtonAutoApp.Checked then
    InitFileOperParam('SOCKET',ComboBoxDBType.Text+';'+
      EditServerName.Text+';'+EditDatabaseName.Text+
      EditUserName.Text+';'+EditPassword.Text,GCzy.CzyCode,GCzy.name)
  else begin
    InitFileOperParam('HTTP',ComboBoxHost.Text,GCzy.CzyCode,GCzy.name);
    InitDataTransferParam('HTTP',ComboBoxHost.Text);
  end;

   //单位信息为空, 需要选择单位.  DDSL
  if (not IsCancelChoseUnit) and ((Trim(GszHSDWDM)='') or (GszHSDWDM=CSysDWDM)) then begin //是外壳程序调用的，个子产品的判断在另一个函数里 //and (GProSign <> 'CIM') and (GProSign <> 'IDA') and (GProSign <> 'GE') and (GProSign <> 'BKA') and (GProSign <> 'SA') and (GProSign <> 'BEM') and (GProSign='SYS')
    //zhangwh20120810 begin 外部调用自动登录系统管理模块功能时，不用设置单位、账套信息
    if (Pos('SA',GszModelName)<1) then begin  //zhangwh20120823 (UpperCase(Copy(GsParamGNFLMC,1,2))<>'SA')
      Application.CreateForm(TFormSetGS, FormSetGS);    //有些注册表里单位代码会写为999999，这时也应当要求设置单位
      if FormSetGS.ShowModal = mrOK then begin
        GszGSDM := FormSetGS.GSDM;
        GszHSDWDM := FormSetGS.GSDM;
        GszHSDWMC := FormSetGS.GSMC;
        GszZth := FormSetGS.ZTH;
        GszZTMC := FormSetGS.ZTMC;
        GszYWRQ := FormSetGS.YWRQ;
	    	//20150120 houy 处理门户登陆时，单位为空后，年度设置不上去
        if (GszYWRQ <> '') and (length(GszYWRQ) = 8) then
        begin
          DateTimePickerBusinessDate.Date := TString.StrToDate(copy(GszYWRQ, 1, 4) + '-' + copy(GszYWRQ, 5, 2) + '-' + copy(GszYWRQ, 7, 2));
          GszKJND := PGetKjnd(GszYWRQ);
          if GszKJND = '' then
            GszKJND := Copy(GszYWRQ, 1, 4);
        end;
      end else begin
        goto LoginFailure;
      end;
    end ;
    //zhangwh20120810 end
  end;
      
  (* //单位信息为空, 需要选择单位.
  if (not IsCancelChoseUnit) and ((Trim(GszHSDWDM)='') or (GszHSDWDM=CSysDWDM)) then //是外壳程序调用的，个子产品的判断在另一个函数里 //and (GProSign <> 'CIM') and (GProSign <> 'IDA') and (GProSign <> 'GE') and (GProSign <> 'BKA') and (GProSign <> 'SA') and (GProSign <> 'BEM') and (GProSign='SYS')
  begin
    //hch 如果单位数据为空， 则不需要选择单位
    if DataModulePub.GetCountBySQL('Select 1 from pubgszl')>0 then
    begin
      Application.CreateForm(TFormSetGS, FormSetGS);    //有些注册表里单位代码会写为999999，这时也应当要求设置单位
      if FormSetGS.ShowModal = mrOK then
      begin
        GszGSDM := FormSetGS.GSDM;
        GszHSDWDM := FormSetGS.GSDM;
        GszHSDWMC := FormSetGS.GSMC;
        GszZth := FormSetGS.ZTH;
        GszZTMC := FormSetGS.ZTMC;
        GszYWRQ := FormSetGS.YWRQ;
        if (GszYWRQ <> '') and (length(GszYWRQ) = 8) then
          DateTimePickerBusinessDate.Date := TString.StrToDate(copy(GszYWRQ, 1, 4) + '-' + copy(GszYWRQ, 5, 2) + '-' + copy(GszYWRQ, 7, 2));
      end else
      begin
        goto LoginFailure;
      end;
    end;
  end;   *)

  if (GszHSDWDM<>'') and (GszHSDWDM<>CSysDWDM)and(GszZth='') then
  begin
     SysMessage('您没有设置账套号，一些模块将无法正常使用，请登录后请进行设置。');//,'_JG',[mbok]); //SetPanel(False); EditPwd.SetFocus; Exit;
  end;

  if PRegister.OpenKey(RegLoginPath, True) then
  begin
     PRegister.WriteString('Dwdm', GszHSDWDM);
     PRegister.WriteString('Dwmc', GszHSDWMC);
     PRegister.WriteString('Ztbh', GszZth);
     PRegister.WriteString('Ztmc', GszZTMC);
     PRegister.CloseKey;
  end;
  
  bLoginClick := True;
  {
    zhengjy 2014-10-11 广西需求基础卫生版本，密码输入错误增加记数
  }
  //注释掉，不限制登录也记录登录时间  chengf 20150408
//  if GblReLogin=1 then
  begin
    TControlLogin.SetOperLogin(tmpID);
  end;
  ShowLogin;

  //一般重新登录及切换单位时，每个模块要重新初始化
  with FormMain do 
    if (FslUIR9_IMPL <> nil) then
    begin
       for i := 0 to FslUIR9_IMPL.FslUIR9.Count - 1 do
       begin
          if TUIR9_IMPL(FslUIR9_IMPL.FslUIR9.Objects[i]).Global_Mode <> nil then
             TUIR9_IMPL(FslUIR9_IMPL.FslUIR9.Objects[i]).Global_Mode.bNeedInitMode := True;
       end;
       rMainSub.GListAnyiClient.Clear;
    end;

  try
    //istart := GetTickCount;
    if FormMain.AfterLoginInitData() then
    begin
       BlLoginOk := true;
       GbSysLoginOK := true;
       gsSingleMode_Bak := gsSingleMode;
       sTemp := Application.Title;
       if Pos('|',sTemp)>0 then begin
           sTemp := Copy(sTemp,1,Pos('|',sTemp))
       end else
           sTemp := sTemp + '|';
       Application.Title := sTemp+' '+ Gszgsdm+' '+Gszgsdm+'-'+GszZTH+' '+Gszztmc;

       ModalResult := mrOK;
       PostMessage(FormMain.Handle, UM_AFTERLOGIN, 0, 0);
    end;
    //iEnd := GetTickCount;  ShowMessage(IntToStr(iEnd-istart));
  finally
    bLoginClick := False;
  end;

  // For Client AutoUpdate, Added by gh, 2013.06.05
  if RadioButtonHandApp.Checked and not FNetStart then
  begin  
    CheckAndUpdate(
      'SYS',
      IntToStr(GCzy.ID),
      GCzy.name,
      TString.EncryptSTR(GCzy.Password),
      GszYWRQ,
      GszZTH,
      GszZTMC,
      GszHSDWDM,
      GszHSDWMC,
      StringReplace(GszServerComputer, 'Proxy', '', []),
      GszServerPort,
      Application.ExeName);
  end;

  LoginFailure:
  begin    // Added by miaopf 2008-4-22 11:18:34 取消,导致切换单位不成功    //BlLoginOk := False;
    ButtonOK.Enabled := True;
    SetPanel(False);
  end;
  if not CheckPassword then ChangePassWord(True);
end;

function SysLogin(Params: TStrings): Boolean;
var
  sParam, sUser, sPassWord, sName, sID, sDate, sServer, sPort, sConnectionType: string;
  bWithPrompt: Boolean;
  dbServer, dbName, dbUser, dbPwd: string;
  OtherParams,szHSDWDMParam: string;
  i: integer;

  function GetSparam(stype, Sparam: string): string;
  var
    stemp: string;
    itemp, itemp1: integer;
  begin
    result := '';
    itemp := pos(stype, sparam);
    if itemp > 0 then
    begin
      stemp := copy(sparam, itemp + 2, length(sparam) - itemp + 1);
      itemp1 := pos(' -', stemp);
      result := stemp;
      if itemp1 > 0 then
      begin
        stemp := copy(stemp, 1, itemp1 - 1);
        result := stemp;
      end;
    end;
  end;
  //hch 获取自动模式数据库连接信息
  procedure ExtractParams;
  var
    lst: TStringList;
  begin
    lst := TStringList.Create;
    lst.Text := StringReplace(OtherParams, '&', #13#10, [rfReplaceAll]);
    dbServer := lst.Values['ServerName'];
    dbName := lst.Values['DatabaseName'];
    dbUser := lst.Values['UserName'];
    dbPwd := lst.Values['Password'];
    lst.Free;
  end;
begin
  // 崔立国 2008.07.22
  if (Application.MainForm <> nil) and (Application.MainForm is TFormMain) and(TFormMain(Application.MainForm).Anyiclient1.Terminated) then begin
      Result := False;
      Exit;
  end;

 (* Params := TStringList.Create;
  Params.Clear;
  Params.Add('UserName=[1]');
  Params.Add('Password=wg==');
  Params.Add('TransDate=2011-11-03');
  Params.Add('AccountID= ');
  Params.Add('AccountName=undefined');
  Params.Add('CompanyID=111');
  Params.Add('CompanyName=111%u5355%u4F4D');
  Params.Add('AppServerName=127.0.0.1');
  Params.Add('AppServerPort=8044');
  Params.Add('WithPrompt= ');
  Params.Add('ConnectionType=HTTP');
  Params.Add('DBType=ORACLE');
  Params.Add('FormName=');

   UserName=[1]    //门户参数
    Password=wg==
    TransDate=2011-11-03
    AccountID=
    AccountName=undefined
    CompanyID=111
    CompanyName=111%u5355%u4F4D
    AppServerName=127.0.0.1
    AppServerPort=8044
    WithPrompt=
    ConnectionType=HTTP
    DBType=ORACLE
    FormName=  *)

  //Params.SaveToFile('c:\aaa.txt');

  FormLogin := TFormLogin.Create(nil);
  if (ParamCount > 2) or (Params <> nil) then
  begin
    //ShowMessage(Params.Text);
    //Params.SaveToFile('c:\paramsT.TXT');
    FormLogin.Show;
    szHSDWDMParam := ' ';
    if Params <> nil then
    begin
      sUser := Params.Values['UserName'];
      // 崔立国 2010.05.26 UserName有可能传用户名也可能是操作员ID，根据是否有方括号判断。
      if sUser <> '' then
      begin
        if sUser[1] = '[' then
        begin
          Delete(sUser, 1, 1);
          if sUser[Length(sUser)] = ']' then
            Delete(sUser, Length(sUser), 1);
          FormLogin.rbtnCZYID.Checked := True;
        end;
      end;

      //hch 2009.3.17 通过参数调用传入的按口令加密处理的 password
      sPassword := TString.DecryptSTR(Params.Values['Password']);
      //hch 2010.1.21 外部系统调用传入按明文处理的 password
      szOtherPassword := Params.Values['Password'];
      sDate := Params.Values['TransDate'];
      sServer := Params.Values['AppServerName'];
      sPort := Params.Values['AppServerPort'];
      bWithPrompt := Params.Values['WithPrompt'] = '1';
      OtherParams := Params.Values['WithPrompt'];
      sConnectionType := Params.Values['ConnectionType'];
      GszHSDWDM := Trim(Params.Values['CompanyID']);
      szHSDWDMParam := Params.Values['CompanyID'];
      GszHSDWMC := Trim(Params.Values['CompanyName']);
      GszZth := Trim(Params.Values['AccountID']);
      GszZTMC := Trim(Params.Values['AccountName']);
    end;
    FNetStart := True;
    if szHSDWDMParam='' then  //门户传入的单位代码是空格 ' '
    begin
      SysMessage('请代入程序运行需要的参数信息', 'AOther_YB', [mbOk]);
      Application.Terminate;
      Exit;
    end;
    //远程访问直接用手动模式处理。
    //if GIsNetVersion then    begin
    if sConnectionType = 'AUTO' then
    begin
      FormLogin.RadioButtonAutoApp.Checked := True;
      FormLogin.RadioButtonAutoAppClick(nil);
      //获取数据库的连接信息
      //GDbType
      ExtractParams;
      //hch 2009-06-17 如果
      if length(OtherParams)>2 then
      begin
        bOtherParamsLogin := True;
        FormLogin.cbxZT.ItemIndex := FormLogin.cbxZT.Items.IndexOf(GszZth+'|'+GszZtmc); //自动定位到当前传入账套号

        FormLogin.ComboBoxDBTypeChange(nil);
        FormLogin.EditServerName.Text := dbServer;
        FormLogin.EditDatabaseName.Text := dbName;
        FormLogin.EditUserName.Text := dbUser;
        FormLogin.EditPassword.Text := dbPwd;
      end;
    end
    else
    begin
      FormLogin.RadioButtonHandApp.Checked := True;
      FormLogin.RadioButtonAutoAppClick(nil);
      FormLogin.cbConType.ItemIndex := FormLogin.cbConType.Items.IndexOf(sConnectionType);
    end;

    if bOtherParamsLogin then     //参数方式，使用明文密码
       sPassWord := szOtherPassword;
    FormLogin.EditPwd.Text := sPassWord;

    FormLogin.ComboBoxUser.Text := sUser;
    FormLogin.cbConType.ItemIndex := FormLogin.cbConType.Items.IndexOf(sConnectionType);
    if FormLogin.cbConType.ItemIndex = 0 then
    begin
      if Pos('http', lowercase(sServer)) > 0 then
        FormLogin.ComboBoxHost.Text := sServer+'/Proxy'
      else
        FormLogin.ComboBoxHost.Text := 'http://'+sServer+':'+sPort+'/Proxy';
      FormLogin.SMaskEditPort.Text := sPort;
    end;
    if length(sDate) = 8 then
      sDate := copy(sDate, 0, 4) + '-' + copy(sDate, 5, 2) + '-' + copy(sDate, 7, 2);
    PSetPickerDate(FormLogin.DateTimePickerBusinessDate, formatDateTime('yyyymmdd', TString.StrToDate(sDate)));
    FormLogin.ButtonOK.Click;
    if FormLogin.BlLoginOk then
    begin
      Result := True;
      bOtherParamsLogin := False; //重新赋值为False，以免重新登录出问题
    end
    else
    begin
      //showmessage('参数方式登录失败！');
      FormLogin.Hide;
      if FormLogin.ShowModal = MrOk then
      begin
        Result := True;
      end
      else
        Result := False;
    end;
    FreeAndNil(FormLogin);

  end else begin
    Result := (FormLogin.ShowModal = MrOk);  //  if FormLogin.ShowModal = MrOk then    begin      Result := true;    end    else    begin      Result := false;    end;
  end;

  if rMainSub.GiReLogin >= 2 then begin //新建账套，初始化参数设置后，要强制要求重新登录，否则科目模版数据不对。
     try //自动登录 FormMain.ActLoginExecute(FormMain.ActLogin);
       FormLogin := TFormLogin.Create(Application);
       FormLogin.ReChoseUnitLogin(0);
     finally
       rMainSub.GiReLogin := 0;     
       FormLogin.Free;
     end;
  end;  
end;

function SysReLogin(KJND:String=''): boolean;
var
  tmpDBName, tmpGSJQXFX, tmpGszServerComputer, tmpServerPort: string;
  tmpGszZth, tmpGszZTMC, tmpGszYWRQ, tmpGszLanguage, tmpCZYName,tmpCZYCode, tmpCZYPassword: string;
  tmpCZYID, tmpCZYGID: integer;
  tmpLoginAsCZYID: Boolean;
  szDBType: string;
  tmpServerName, tmpUserName, tmpPasswod, tmpYWRQ:String;
  tmpGDBType:TDbType;
  function GetMaxYear(CurYear:String):String;
  begin
    Result := DataModulePub.GetFldValue('PubKJQJ',
      'Max(JSRQ) JSRQ',
      'gsdm='''+GszGSDM+''' and ZTH='''+GszZTH+''' and KJND='''+CurYear+'''',
      CurYear+'1231');
  end;

  function GetMaxKJND: String;
  begin
    Result := DataModulePub.GetFldValue('PubKJQJ',
      'Max(KJND) MaxKJND','gsdm='''+GszGSDM+''' and ZTH='''+GszZTH+'''',GszKJND);
  end;

begin  //保留原来登陆时的数据 20050408 zhouyunlu
  tmpDBName := GszDBName;
  //tmpGsProductSign := GsProductSign;
  tmpGSJQXFX := GSJQXFX;
  tmpGszServerComputer := GszServerComputer;
  tmpServerPort := GszServerPort;
  //保留登陆的数据库连接信息，取消注册就重新连接原有数据库
  tmpServerName := GsServerName;
  tmpUserName := GsUserName;
  tmpPasswod := GsPassword;
  tmpGDBType := GDbType;

  tmpGszZth := GszZth;
  tmpGszZTMC := GszZTMC;
  tmpGszYWRQ := GszYWRQ;
  tmpGszLanguage := GszLanguage;

  tmpCZYName := GCZY.name;
  tmpCZYCode := GCzy.CzyCode;
  tmpCZYPassword := GCZY.Password;
  tmpCZYID := GCZY.ID;
  tmpCZYGID := GCZY.GID;
  tmpLoginAsCZYID := GCZY.LoginAsID;
  FormLogin := TFormLogin.Create(Application);

  FormLogin.ReloginCzyID :=IntToStr(GCZY.ID);//zhengjy 2014-10-11 广西需求基础卫生版本,附值
  // 崔立国 2010.04.14
  if tmpLoginAsCZYID then
     try
       FormLogin.ComboBoxUser.Text := IntToStr(tmpCZYID)
     except
       //FormLogin.ComboBoxUser.Text := tmpCZYCode;
     end
  else
    FormLogin.ComboBoxUser.Text := tmpCZYName;
  FormLogin.rbtnCZYID.Checked := tmpLoginAsCZYID;

  FormLogin.ComboBoxHost.Enabled := false;
  FormLogin.cbConType.Enabled := false;
  if GpsSeries = psR9 then
    FormLogin.ComboBoxDBType.Enabled := False;
  if (kjnd<>'') then
  begin
    try
      FormLogin.EditPwd.Text := tmpCZYPassword;
      FormLogin.IsChangeND := True;
      FormLogin.ShowTitle := '正在切换'+KJND+'年度';
      //应该获取当年度的最后一天
      if GProSign='GL' then
      begin
        //2010.4.6 hy 维护单2010032910788，当前是2010年，先登录到2009年，后切换到2010年，业务日期应该是当前系统时间
        if KJND = GetMaxKJND then
        begin
          tmpYWRQ := '-'+Copy(DateToStr(Now),6,2)+'-'+Copy(DateToStr(Now),9,2);
          FormLogin.DateTimePickerBusinessDate.Date := TString.StrToDate(Copy(KJND, 1, 4)+tmpYWRQ);
        end
        else
          FormLogin.DateTimePickerBusinessDate.Date := TString.StrToDate(GetMaxYear(KJND));
      end
      else
        FormLogin.DateTimePickerBusinessDate.Date := TString.StrToDate(copy(KJND, 1, 4)+'-12-31');
      FormLogin.Timer1.Enabled := True;
    except

    end;
  end;
  if FormLogin.ShowModal = MrOk then
  begin
    result := true;
    //zhengjy 2014-10-11 广西需求基础卫生版本,重新登陆完成后，删除原来登陆信息.
    TControlLogin.DelOperState(FormLogin.ReloginCzyID);
    FormLogin.ReloginCzyID :='';//zhengjy 2014-10-11 广西需求基础卫生版本,原值置空
  end
  else
  begin
    //如果取消重新注册，将全局变量重新设回来 20050408
    //可能由于更改用户等操作导致重新连接DB
    //FormLogin.ReChangeDB;
    //恢复数据连接信息，目前暂时只处理R972
    GDbType := tmpGDBType;
    GszDBNAME := tmpDBName;
    GsServerName := tmpServerName;
    GsUserName := tmpUserName;
    GsPassword := tmpPasswod;
    szDBType := IFF(GDBType = MSSQL, 'MSSQL', 'ORACLE');

    // 崔立国 2010.10.11 离线工作模式登录
    if not GblOfflineMode then
    begin
      if GpsSeries = psR9 then
      begin
        FormLogin.SetDBInfo;
        if DataModulePub.MidasConnectionPub.Connected then
          DataModulePub.MidasConnectionPub.AppServer.ChangeDB(szDBType, GszDBNAME)
        else
        begin
          try
            FormLogin.IniConnect;
            DataModulePub.MidasConnectionPub.AppServer.ChangeDB(szDBType, GszDBNAME)
          except
            if ShowLoginHint('无法与应用服务器建立连接！' + #13#10#13#10 +
              '请检查：' + #13#10 +
              '    1、应用服务器地址是否正确；' + #13#10 +
              '    2、应用服务器是否正常启动。') = mrYes then
            begin
              PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
            end;
            Exit;
          end;
        end;
      end;
    end;

    //GsProductSign := tmpGsProductSign;
    GSJQXFX := tmpGSJQXFX;
    GszServerComputer := tmpGszServerComputer;
    GszServerPort := tmpServerPort;

    GszZth := tmpGszZth;
    GszZTMC := tmpGszZTMC;
    GszYWRQ := tmpGszYWRQ;
    GszLanguage := tmpGszLanguage;

    GCZY.name := tmpCZYName;
    GCZY.CzyCode := tmpCZYCode;
    GCZY.Password := tmpCZYPassword;
    GCZY.ID := tmpCZYID;
    GCZY.GID := tmpCZYGID;
    FormLogin.ReloginCzyID :='';//zhengjy 2014-10-11 广西需求基础卫生版本,重新登陆失败，原值置空
    Result := false;
  end;

  if Result then
    BackGroundUnit.FormBackGround.LoadConfig(Gczy.Name);
end;

procedure TFormLogin.ComboBoxUserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  iIndex: integer;
begin
  if (ssCtrl in Shift) and (Key = 46) then
  begin
    iIndex := ComboBoxUser.items.IndexOf(ComboBoxUser.Text);
    if iIndex >= 0 then
      ComboBoxUser.Items.Delete(iIndex);

    if PRegister.OpenKey(RegLoginPath, True) then
    begin
      PRegister.WriteString('User', ComboBoxUser.items.CommaText);
      PRegister.CloseKey;
    end;
    //zhouyunlu added 原来删除某下拉项后，如果，登陆成功，则仍然保存了删除的项目
    puserlist.CommaText := ComboBoxUser.items.CommaText;
  end;
  
end;

function TFormLogin.CheckAppVersion: Boolean;
var
  szAppServerName: string;
begin
  Result := False;
  try
    if DataModulePub.MidasConnectionPub.ConnectType = ctSockets then
      szAppServerName := DataModulePub.MidasConnectionPub.AppServer.GetAppServerVer
    else
      szAppServerName := '9.7'; //THTTPConnection(DataModulePub.MidasConnectionPub).AppServer.GetAppServerVer;

    if ((Pos('.s', szAPPServername) < 1) and (GProSeries = 'S')) or ((Pos('9.7', szAppServerName) <= 0) and (GProSign =
      'GL') and (GDbType = MSSQL)) then //普及版为 x.x.s  R97的账务需要R9.7的中间层 Lzn For R97
    begin
      if ((Pos('.s', szAPPServername) < 1) and (GProSeries = 'S')) then
        SysMessage('应用服务器版本错误，请检查应用服务器是否为普及版专用版本！')
      else
        SysMessage('提示，当前应用服务器版本号太低 应用服务器需要升级！！');
      Exit;
    end;
  except
    SysMessage('您使用的可能是旧版本应用服务器，请检查应用服务器安装是否正确！');
    Exit;
  end;
  Result := True;
end;

function TFormLogin.GetNewProSign(AProSign: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Length(OldProSignNames[0]) - 1 do
  begin
    if Pos(OldProSignNames[0][i], AProSign) <> 0 then
    begin
      if Trim(OldProSignNames[1][i]) <> '' then
        Result := Result + OldProSignNames[1][i] + ';';
    end;
  end;
end;

{ TProfileChat }

function TProfileChat.RecvInteger: Integer;
var
  i: Integer;
begin
  i := 0;
  while (not FDataReady) and (i < 3) do
  begin
    Sleep(20);
    Inc(i);
  end;
  Result := FInt;
end;

function TProfileChat.GetProfileInt(AName: string): Integer;
begin
  SendString(FTargetHWnd, AName);
  Result := RecvInteger;
end;

function TProfileChat.GetProfileStr(AName: string): string;
begin
  SendString(FTargetHWnd, AName);
  Result := RecvString;
end;

function TProfileChat.RecvString: string;
var
  i: Integer;
begin
  i := 0;
  while (not FDataReady) and (i < 3) do
  begin
    Sleep(20);
    Inc(i);
  end;
  Result := FStr;
end;

function TProfileChat.SendString(AWnd: HWnd; AStr: string): Boolean;
var
  t: array[0..3] of Byte;
  P: PAnsiChar;
begin
  Result := True;
  ClearState;
  SendMessage(AWnd, WM_TranUserDefData, PDTHandle, LongWord(FSelfHWnd));
  P := PAnsiChar(AStr);
  while p^ <> #0 do
  begin
    t[0] := Byte(p^);
    Inc(P);
    if p^ <> #0 then
    begin
      t[1] := Byte(p^);
      Inc(P);
      if p^ <> #0 then
      begin
        t[2] := Byte(p^);
        Inc(P);
        if p^ <> #0 then
        begin
          t[3] := Byte(p^);
          Inc(P);
        end
        else
        begin
          t[3] := 0;
        end;
      end
      else
      begin
        t[2] := 0;
      end;
    end
    else
    begin
      t[1] := 0;
    end;
    SendMessage(AWnd, WM_TranUserDefData, PDTStr, LongWord(PInteger(@t)^));
  end;
  SendMessage(AWnd, WM_TranUserDefData, PDTStopTag, 0);
end;

function TProfileChat.RegProfileStr(AName: string; AVal: string): Boolean;
var
  str: string;
begin
  Result := False;
  str := AName + '=' + AVal;
  if FCommandList.IndexOf(str) = -1 then
  begin
    FCommandList.Add(str);
    Result := True;
  end;
end;

function TProfileChat.MsgHandle(var Msg: TMessage): Boolean;
var
  t: array[0..3] of Char;
begin
  Result := False;
  if Msg.Msg = WM_TranUserDefData then
  begin
    if Msg.WParam <> 0 then
      FDataType := Msg.WParam;
    case Msg.WParam of
      PDTStopTag: //= 0
        begin
          FStr := StrPas(PChar(FTmpStr));
          //FInt := FInt;
          ResponseCommand(FDataType);
          if FIsDebug then
          begin
            FDebugStr := Format('Str=%s,Int=%d', [FStr, FInt]);
            ShowMessage(FDebugStr);
          end;
          // Clear state
          FTmpStr := '';
          FDataReady := True;
          FDataType := -1;
        end;
      PDTStr: //= 1
        begin
          Integer(t) := Msg.LParam;
          FTmpStr := FTmpStr + t[0] + t[1] + t[2] + t[3];
        end;
      PDTInt: //= 2
        begin
          FInt := Msg.LParam;
        end;
      PDTHandle: //= 2
        begin
          FTargetHWnd := Msg.LParam;
          if FIsDebug then
          begin
            FDebugStr := Format('Target HWnd=%d', [FTargetHWnd]);
            ShowMessage(FDebugStr);
          end;
        end;
    end;
  end
  else if FGlobalMessage = Msg.Msg then // Sever启动时向Client广播自己的Handle
  begin //
    if Msg.WParam <> 0 then
      case Msg.WParam of
        PDTHandle: //= 2
          begin
            FTargetHWnd := Msg.LParam;
            if FIsDebug then
            begin
              FDebugStr := Format('Target HWnd=%d', [FTargetHWnd]);
              ShowMessage(FDebugStr);
            end;
          end;
      end;
  end;
end;

procedure TProfileChat.ClearState;
begin
  FDataReady := False;
  FInt := 0;
  FStr := '';
end;

procedure TProfileChat.ResponseCommand(AType: Integer);
var
  i: Integer;
begin
  case AType of
    PDTStr:
      begin
        if SameText(FStr, 'BryanPleaseShowAllOK?') then
        begin
          SendString(FTargetHWnd, #13#10 + FCommandList.Text);
          Exit;
        end;
        for i := 0 to FCommandList.Count - 1 do
        begin
          if SameText(Copy(FCommandList[i], 1, Pos('=', FCommandList[i]) - 1), FStr) then
          begin
            SendString(FTargetHWnd, Copy(FCommandList[i], Pos('=', FCommandList[i]) + 1, MaxInt));
            Break;
          end;
        end;
      end;
    PDTInt:
      begin
      end;
  end;
end;

constructor TProfileChat.Create;
begin
  inherited;
  FIsDebug := False;
  FCommandList := TStringList.Create;
  FSelfHWnd := Application.Handle;
  FGlobalMessage := Windows.RegisterWindowMessage('TProfileChat');
  // First..
  PostMessage(HWND_BROADCAST, FGlobalMessage, PDTHandle, FSelfHWnd);
  // Then..
  //Application.HookMainWindow(MsgHandle);  99??
end;

destructor TProfileChat.Destroy;
begin
  try
    //Application.UnHookMainWindow(MsgHandle);
    //FCommandList.Free;
  except
  end;    
  inherited;

end;

procedure TProfileChat.ClearProfiles;
begin
  FCommandList.Clear;
end;

procedure TFormLogin.SMaskEditPortKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TFormLogin.ComboBoxUserDropDown(Sender: TObject);
var
  szZTH, szLocalZTH: string;
  szDBType: string;
  iZT: Integer;
begin
  // 崔立国 2009.10.22 解决手工输入账套后，cbxZT.ItemIndex仍然是-1的问题。
  iZT := cbxZT.Items.IndexOf(Trim(cbxZT.Text));
  if (GpsSeries = psR9)
    and (CheckBoxListAllUsers.Checked)
    and (iZT >= 0) then
    // and (cbxZT.ItemIndex >= 0) then
  begin
    try
      if not WriteAppServerInfoToReg then
        Exit;

      try
        IniConnect;
      except
        if ShowLoginHint('无法与应用服务器建立连接！' + #13#10#13#10 +
          '请检查：' + #13#10 +
          '    1、应用服务器地址是否正确；' + #13#10 +
          '    2、应用服务器是否正常启动。') = mrYes then
        begin
          PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
          Exit;
        end;
      end;

      try
        if not DataModulePub.MidasConnectionPub.Connected then
        begin
          DataModulePub.MidasConnectionPub.Connected := True;
        end;
      except
        if ShowLoginHint('无法与应用服务器建立连接！' + #13#10#13#10 +
          '请检查：' + #13#10 +
          '    1、应用服务器地址是否正确；' + #13#10 +
          '    2、应用服务器是否正常启动。') = mrYes then
        begin
          PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
        end;
        Exit;
      end;

      //hch 更换数据库
      ReChangeDB;
      try

        with DataModulePub.ClientDataSetPub do
        begin
          POpenSQL(DataModulePub.ClientDataSetPub, 'select name from gl_czy where type=''1'' and syzt<>''2'' ');
          ComboBoxUser.Items.Clear;
          while not Eof do
          begin
            ComboBoxUser.Items.Add(trim(fieldbyName('name').asString));
            Next;
          end;
        end;
      except
        SysMessage('不能连到数据库，请检查：' + #13#10 +
          '1：是否已建账套！' + #13#10 +
          '检查工具位置：桌面菜单[开始]－[程序]－[用友R9财务软件]－[后台数据管理工具]' + #13#10 +
          '2: 数据库设置是否正确。' + #13#10 +
          '检查方法：' + #13#10 +
          '一：点击[选项]按钮；' + #13#10 +
          '二：正确输入服务器名、用户名和密码，' + #13#10 +
          '三：点击[测试连接]。');
        Exit;
      end;
    except
    end;
  end
  else
  begin
    ComboBoxUser.Items.Clear;
    ComboBoxUser.Items.AddStrings(PUserList);
  end;

end;

procedure TFormLogin.ImageChgPasswordMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 { if sender <> ImageChgPassword then
  begin
    LblInfo.Caption := '';
    exit;
  end;
  if (X > 1) and (X < ImageChgPassword.Width - 1)
    and (Y > 1) and (Y < ImageChgPassword.Height - 1) then
  begin
    LblInfo.Caption := '修改密码...';
  end
  else
  begin
    LblInfo.Caption := '';
  end;  }
end;

procedure TFormLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if not ButtonOK.Enabled then
    begin
      if ActiveControl = ComboBoxUser then
        EditPwd.SetFocus
      else
      begin
        Key := #0;
        SelectNext(ActiveControl, True, True);
      end;
    end
    else
      ButtonOK.Click;
  end;
end;

procedure TFormLogin.cbConTypeChange(Sender: TObject);
begin
  // 2007-5-17 hch
  PRegister := TRegistry.Create;
  PRegister.RootKey := HKEY_CURRENT_USER;
  PRegister.OpenKey(RegLoginPath, True);
  PHostList.Clear;
  case cbConType.ItemIndex of
    0:
      begin
        PHostList.CommaText := PRegister.ReadString('HTTP');
        LabelPort.Enabled := False;
        SMaskEditPort.Enabled := False;
        CheckBoxPooler.Enabled := False;
        LabelHost.Caption := '服务地址：';
      end;
    1:
      begin
        PHostList.CommaText := PRegister.ReadString('SrvHost');
        LabelPort.Enabled := True;
        SMaskEditPort.Enabled := True;
        CheckBoxPooler.Enabled := True;
        LabelHost.Caption := '服务地址：';
      end;
  end;
  ComboBoxHost.Clear;
  ComboBoxHost.Items.AddStrings(PHostList);
  if ComboBoxHost.Items.Count > 0 then
    ComboBoxHost.ItemIndex := ComboBoxHost.Items.Count - 1
  else
    ComboBoxHost.Text := '127.0.0.1';
  PRegister.CloseKey;
end;

procedure TFormLogin.ShowLogin;
begin
  inc(LoginCount);
  if LoginCount mod 4 = 0 then
    rxlbl1.Caption := FShowTitle
  else if LoginCount mod 4 = 1 then
    rxlbl1.Caption := FShowTitle+'.'
  else if LoginCount mod 4 = 2 then
    rxlbl1.Caption := FShowTitle+'..'
  else if LoginCount mod 4 = 3 then
    rxlbl1.Caption := FShowTitle+'...';
  Update;
  rxgfnmtr1.Update;
end;

procedure TFormLogin.SetPanel(v: Boolean);
begin

  pnl.Visible := v;
  PanelLogin.Visible := not v;
  PanelLoginSet.Visible := (not (GpsSeries = psR9i))
    and (pos('<<', ButtonOptions.Caption) > 0);
  if v then
  begin
    pnl.Align := alClient;
    pnl.BringToFront;
    PanelLogin.Align := alNone;
  end
  else
  begin
    PanelLogin.Align := alClient;
    pnl.Align := alNone;
    PanelLogin.BringToFront;
  end;
end;

procedure TFormLogin.Timer1Timer(Sender: TObject);
begin
  if IsChangeND then
  begin
    Timer1.Enabled := False;
    SpeedButtonOKClick(ButtonOK);
  end;
end;

function TFormLogin.ReChoseUnitLogin(piType:Integer): Boolean;
var
  FGszGSDM, FYWRQ, FGszHSDWDM, FGszHSDWMC, FGszZth, FGszZTMC: string;
  FGszGSDM1, FYWRQ1, FGszHSDWDM1, FGszHSDWMC1, FGszZth1, FGszZTMC1: string;
  iResult: Integer;
begin
  Result := True;
  if GCzy.LoginAsID then
  begin
    ComboBoxUser.Text := IntToStr(GCzy.ID);
    rbtnCZYID.Checked := True;
  end else
  begin
    ComboBoxUser.Text := GCzy.name;
    rbtnCZYName.Checked := True;
  end;
  EditPwd.Text := GCzy.Password;
  IsCancelChoseUnit := True;
  //DecodeDate

  DateTimePickerBusinessDate.Date := EncodeDate(StrToInt(Copy(GszYWRQ, 1, 4)),
    StrToInt(Copy(GszYWRQ, 5, 2)),
    StrToInt(Copy(GszYWRQ, 7, 2)));
  GDBType := GetDBType(True);

  //if rMainSub.GiReLogin=2 then begin //强制重新登录，不弹出单位设置窗体
  //   iResult := -1;
  //end else begin
  if Gszkjnd_First = '' then
     Gszkjnd_First := GszKJND;
       
  if piType=0 then begin
     Application.CreateForm(TFormSetGS, FormSetGS);
     iResult:=FormSetGS.ShowModal;
     if iResult = mrOK then begin
        FGszGSDM := GszGSDM;
        FGszHSDWDM := GszHSDWDM;
        FGszHSDWMC := GszHSDWMC;
        FGszZth := GszZth;
        FGszZTMC := GszZTMC;
        FYWRQ := GszYWRQ;

        GszGSDM := FormSetGS.GSDM;
        GszHSDWDM := FormSetGS.GSDM;
        GszHSDWMC := FormSetGS.GSMC;
        GszZth := FormSetGS.ZTH;
        GszZTMC := FormSetGS.ZTMC;
        GszYWRQ := FormSetGS.YWRQ;
        DateTimePickerBusinessDate.Date := TString.StrToDate(Copy(GszYWRQ, 1, 4) + '-' + Copy(GszYWRQ, 5, 2) + '-' + Copy(GszYWRQ, 7, 2));

        if PRegister.OpenKey(RegLoginPath, True) then //领导查询模式登录,则登录信息不记录到注册表
        begin
          PRegister.WriteString('Dwdm', GszHSDWDM);
          PRegister.WriteString('Dwmc', GszHSDWMC);
          PRegister.WriteString('Ztbh', GszZth);
          PRegister.WriteString('Ztmc', GszZTMC);
          PRegister.CloseKey;
        end;
     end;
  end else if piType=1 then begin
     Application.CreateForm(TFormSetKJND, FormSetKJND);
     iResult:=FormSetKJND.ShowModal;
     if iResult = mrOK then
        DateTimePickerBusinessDate.Date := TString.StrToDate(GszGSDM311 + '-' + Copy(GszYWRQ, 5, 2) + '-' + Copy(GszYWRQ, 7, 2))
     else Exit;
  end;

  if (iResult=-1) or (iResult = mrOK) then begin
      SpeedButtonOKClick(nil);
      if not BlLoginOk then
      begin
        GszGSDM := FGszGSDM;
        GszHSDWDM := FGszHSDWDM;
        GszHSDWMC := FGszHSDWMC;
        GszZth := FGszZth;
        GszZTMC := FGszZTMC;
        GszYWRQ := FYWRQ;
        DateTimePickerBusinessDate.Date := TString.StrToDate(Copy(GszYWRQ, 1, 4) + '-' + Copy(GszYWRQ, 5, 2) + '-' + Copy(GszYWRQ, 7, 2));
        if PRegister.OpenKey(RegLoginPath, True) then //领导查询模式登录,则登录信息不记录到注册表
        begin
          PRegister.WriteString('Dwdm', GszHSDWDM);
          PRegister.WriteString('Dwmc', GszHSDWMC);
          PRegister.WriteString('Ztbh', GszZth);
          PRegister.WriteString('Ztmc', GszZTMC);
          PRegister.CloseKey;
        end;
        SpeedButtonOKClick(nil);
      end;
      if Gszkjnd_First=GszGSDM311 then
         GszGSDM311:=''; //相当于取消查询其他年度      
  end;
end;

function TFormLogin.GetDWZTHExists: Boolean;
var
  SQL_TEMP: string;
begin
  Result := False;
  SQL_TEMP := 'select * from gl_ztcs where kjnd=''' + GszKJND + ''' and hsdwdm=''' + GszHSDWDM + ''' and ztbh=''' + GszZth + ''' ';
  POpenSql(DataModulePub.ClientDataSetTmp, SQL_TEMP);
  if not DataModulePub.ClientDataSetTmp.FindFirst then
  begin //注册表注册的单位不存在，则需要重新设置单位
    GszHSDWDM := '';
    GszZth := '';
  end;
  Result := True;
end;

procedure TFormLogin.RadioButtonAutoAppClick(Sender: TObject);
begin
  if RadioButtonAutoApp.Checked then
  begin
    //自动应用模式
    PanelS.Visible := True;
    PanelR.Visible := False;
    gsSingleMode := '1';
  end
  else if RadioButtonHandApp.Checked then
  begin
    PanelS.Visible := False;
    PanelR.Visible := True;
    gsSingleMode := '0';
  end;
  // CdsLogin.Close;  //不能关掉，由于sys参数模式传入时，对于C版，此账套数据集有记录，不能清空，后面要使用
  //SetRemoteServerConnectType;
  //mpf 20070410
end;

procedure TFormLogin.CdsLoginAfterClose(DataSet: TDataSet);
begin
  CdsLogin.Params.Clear;
end;

procedure TFormLogin.SpeedButtonFindClick(Sender: TObject);
begin
  if BrowseForShellFolderSelect.Execute then
    EditServerName.Text := BrowseForShellFolderSelect.DisplayName;
end;

procedure TFormLogin.ButtonTestConnectClick(Sender: TObject);
begin
  // 自动模式
 // TerminateProcessByExeName('R9i_AppSrvr.exe');
 // gsPassword := EditPassword.Text;
  TestConnectServerDM; //测试连接 ServerDM
end;

function TFormLogin.TestConnectServerDM(IsShowMsg: Boolean = true): Boolean;
var
  Database1: TDataBase;
begin
  Result := False;
  Database1 := TDataBase.Create(nil);
  try
    Database1.Close;
    Database1.DatabaseName := 'R9i_DLL';
    Database1.LoginPrompt := False;
    with Database1.Params do
    begin
      Clear;
      Add('SERVER NAME=' + Trim(EditServerName.Text));
      if GpsSeries = psR9 then
        Add('DATABASE NAME=master')
      else
        Add('DATABASE NAME=' + Trim(EditDatabaseName.Text));
      Add('USER NAME=' + Trim(EditUserName.Text));
      Add('CONNECT TIMEOUT=10');
      if gsPassword='********' then gsPassword := '';
      Add('PASSWORD=' + Trim(gsPassword));
    end;
    {
    if GDbType = MSSQL then
      Database1.DriverName := 'MSSQL'
    else
      Database1.DriverName := 'ORACLE';
    }
    if ComboBoxDBType.ItemIndex = 0 then //SQLServer
      Database1.DriverName := 'MSSQL'
    else //Oracle
      Database1.DriverName := 'ORACLE';

    try
      Database1.Open;
      Result := Database1.Connected;
      if IsShowMsg then
        SysMessage('可以正确连接到数据库。');
    except
      SysMessage('不能正确连接到数据库，请检查：' + #13#10 +
        '1：数据库用户名、用户密码是否输入正确。' + #13#10 +
        '2：当前机器能否正确连接上网络。');
    end;
    Database1.Close;
  finally
    Database1.Free;
  end;
end;

procedure TFormLogin.GetAppServerInfoFromReg;  //DSL
var
  Reg: TRegistry;
  szPort, szTemp: string;
  bOpenKey:Boolean;
begin
  // 读注册表获取必要的登录信息
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    //获取登陆信息
    //sPath := RegLoginPath+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');
    bOpenKey := Reg.OpenKey(RegLoginPath, False);
    if not bOpenKey then
       bOpenKey := Reg.OpenKey(Format(szDBInfo, [GsProductID]), True);  //'\SOFTWARE\UFGOV\U8\DbInfo'

    //获取登陆信息 //'\SOFTWARE\UFGOV\U8\DbInfo'
    if bOpenKey then begin
      if GbAutoLogin then begin //不用从注册表取了
         try
           RadioButtonHandApp.OnClick := nil;
           RadioButtonAutoApp.OnClick := nil;
           RadioButtonHandApp.Checked := (gsSingleMode='0');
           RadioButtonAutoApp.Checked := not RadioButtonHandApp.Checked;
         finally
           RadioButtonHandApp.OnClick := RadioButtonAutoAppClick;
           RadioButtonAutoApp.OnClick := RadioButtonAutoAppClick;
         end;
      end else begin
         if Reg.ValueExists('IsHandApp') then begin
            RadioButtonHandApp.Checked := Reg.ReadBool('IsHandApp');
            RadioButtonAutoApp.Checked := not RadioButtonHandApp.Checked;
         end else
            RadioButtonHandApp.Checked := True;      
      end;

      //更换出现显示不一致
      if GpsSeries = psR9 then
        RadioButtonAutoApp.Checked := True;

      RadioButtonAutoAppClick(nil);

      if GbAutoLogin then
           cbConType.ItemIndex := GiConType
      else cbConType.ItemIndex := StrToIntDef(Reg.ReadString('ConType'), 1);

      PUserList.CommaText := Reg.ReadString('User');
      if Reg.ValueExists('LoginAsUserID') then
        PLoginAsUserID := Reg.ReadBool('LoginAsUserID')
      else
        PLoginAsUserID := False;
      case cbConType.ItemIndex of
        0: PHostList.CommaText := Reg.ReadString('HTTP');
        1: PHostList.CommaText := Reg.ReadString('SrvHost');
      end;
      PLanguageList.CommaText := Reg.ReadString('LgList');
      //控制账套参数内容
      if GpsSeries = psR9 then
      begin
        LocalZTH := Reg.ReadString('CurrZTH');
        EditEditAccountFilter.Text := Reg.ReadString('LocalZTH');
        CheckBoxListAllUsers.Checked := IFF(Reg.ReadString('UserListFromDB') = '1', True, False);
      end;
      szPort := Reg.ReadString('SrvScktPort');
      try
        if Reg.ValueExists('Pooler') then
           CheckBoxPooler.Checked := Reg.ReadBool('Pooler');
      except
        CheckBoxPooler.Checked := True;
      end;

    //获取数据连接信息       //if Reg.OpenKey(RegDBInfo, True) then      begin //'\SOFTWARE\UFGOV\U8\DbInfo'
      if GpsSeries = psR9i then begin
        if GbAutoLogin then
        else begin
          if Reg.ReadString('DBType') = 'ORACLE' then
            GDbType := Oracle
          else
            GDbType := MSSQL;
        end;

        if GDbType = MSSQL then
          ComboBoxDBType.ItemIndex := 0
        else
          ComboBoxDBType.ItemIndex := 1;
        ComboBoxDBTypeChange(nil);
      end else begin
        if GbAutoLogin then
        else begin      
          if Reg.ReadString('DBType') = 'ORACLE' then
            GDbType := Oracle
          else
            GDbType := MSSQL;
        end;

        if GDbType = MSSQL then
          ComboBoxDBType.ItemIndex := 0
        else
          ComboBoxDBType.ItemIndex := 1;
        ComboBoxDBTypeChange(nil);
      end;
      //单机模式下数据库服务器名，登录数据库用户和密码
      if GbAutoLogin then
      else begin
        GsServerName := Reg.ReadString('ServerName');
        //只有R9i才需要DBName
        if GpsSeries = psR9i then
           GsDatabaseName := Reg.ReadString('DatabaseName');
        GsUserName := Reg.ReadString('UserName');
      end;
      szTemp := Reg.ReadString('Password');
      if (Trim(GsServerName) <> '') and (Trim(GsServerName) <> '.') then
        EditServerName.Text := GsServerName
      else
        EditServerName.Text := '.'; //'localhost';
      if GsDatabaseName <> '' then
        EditDatabaseName.Text := GsDatabaseName
      else
        EditDatabaseName.Text := 'master';
      if GsUserName <> '' then
        EditUserName.Text := GsUserName
      else
        EditUserName.Text := 'sa';

      EditPassword.Text := '********';
      //hch 修改加密解密方式
      if Reg.ValueExists('Password_2') then
      begin
        // 1、如果找到新加密口令，直接解密。
        szTemp := Reg.ReadString(Ident_Password_2);
        gsPassword := TString.DecryptStr(szTemp);
      end
      else
      begin
        // 2、如果没找到新加密口令，则读取就加密口令。
        if Reg.ValueExists(Ident_Password) then
        begin
          szTemp := Reg.ReadString(Ident_Password);
          if UnMixStr(szTemp, szTemp) then
          begin
            gsPassword := szTemp;
            // 1、先保存新加密口令到 Ident_Password_2 。
            Reg.WriteString(Ident_Password_2, TString.EncryptStr(szTemp));
            // 2、再删除旧加密口令 Ident_Password 。
            if Reg.ValueExists(Ident_Password) then
               Reg.DeleteValue(Ident_Password);
          end;
        end;
      end;

    end;
  finally
    Reg.Destroy;
  end;

  btnUser.Enabled := PUserList.Count > 0;//add by wangxin 2015-08-18
end;

procedure TFormLogin.WriteRegS(Akey, Avalue: string);
var
  Reg:TRegistry;
  bOpenKey:Boolean;
begin
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    //获取登陆信息
    //sPath := RegLoginPath+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');
    bOpenKey := Reg.OpenKey(RegLoginPath, False);
    if not bOpenKey then
       bOpenKey := Reg.OpenKey(Format(szDBInfo, [GsProductID]), True);  //'\SOFTWARE\UFGOV\U8\DbInfo'

    //获取登陆信息 //'\SOFTWARE\UFGOV\U8\DbInfo'
    if bOpenKey then
    begin
      Reg.WriteString(Akey, Avalue);
    end;
  finally
    Reg.CloseKey;
    Reg.Destroy;
  end;
end;

procedure TFormLogin.DoSaveUser;
var
  iPos:Integer;
  Reg:TRegistry;
  bOpenKey:Boolean;
begin
  iPos := PUserList.IndexOf(ComboBoxUser.Text);
  if (iPos <> -1) and (chkSaveUser.Checked) then
    PUserList.Delete(iPos);
  if PUserList.Count >= ComboBoxUser.DropDownCount then
    PUserList.Delete(0);

  if (Trim(ComboBoxUser.Text)<>'') and (chkSaveUser.Checked) then  //zhengjy 2014-10-11 广西需求基础卫生版本,通过复选框来控制是否保存登陆用户信息
  begin
    PUserList.Add(ComboBoxUser.Text);
    WriteRegS('User', PUserList.CommaText);

  end;
end;

function TFormLogin.WriteAppServerInfoToReg: Boolean;   //DSL
var
  Reg: TRegistry;
  sTemp, s,sPath: string;
  i, iPos: integer;
begin
  Result := True;
  //写入注册表中间层信息
  //如果连接成功，就写入注册表内容信息
  if (GpsSeries <> psR9i) then
  begin
    Result := (TestConnectServerDM(false));
    if not Result then
      Exit;
  end;

  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    //只有点击确认登录时，才判断是否记录用户名 Modified by chengjf 2015-02-06 14:04:17
    //登录时，勾选记住用户名，则记录此用户；如果不勾选，不将之前已记录的删除掉
    if FbBtnOKClick then
    begin
      {by wangxin 2015-08-17 将此处独立方法处理：DoSaveUser
      iPos := PUserList.IndexOf(ComboBoxUser.Text);
      if (iPos <> -1) and (chkSaveUser.Checked) then
        PUserList.Delete(iPos);
      if PUserList.Count >= ComboBoxUser.DropDownCount then
        PUserList.Delete(0);

      if (Trim(ComboBoxUser.Text)<>'') and (chkSaveUser.Checked) then  //zhengjy 2014-10-11 广西需求基础卫生版本,通过复选框来控制是否保存登陆用户信息
        PUserList.Add(ComboBoxUser.Text);
      }
    end;

    iPos := PHostList.IndexOf(ComboBoxHost.Text);
    if iPos <> -1 then
      PHostList.Delete(iPos);
    if PHostList.Count >= 3 then
      PHostList.Delete(0);

    PHostList.Add(ComboBoxHost.Text);

    //sPath := RegLoginPath+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');
    if PRegister.OpenKey(RegLoginPath, True) then
    begin
      PRegister.WriteBool('IsHandApp', RadioButtonHandApp.Checked);
      // 2007-5-17 hch 设置保存注册表的连接方式
      PRegister.WriteString('ConType', IntToStr(cbConType.ItemIndex));
      GiConType:=cbConType.ItemIndex;
      
      //PRegister.WriteString('User', PUserList.CommaText);//独立处理
      PRegister.WriteBool('LoginAsUserID', rbtnCZYID.Checked);
      // 2007-5-17 hch 根据不同的连接方式保存不同的连接资料
      case cbConType.ItemIndex of
        0: PRegister.WriteString('HTTP', PHostList.CommaText);
        1: PRegister.WriteString('SrvHost', PHostList.CommaText);
      end;
      PRegister.WriteString('SrvScktPort', SMaskEditPort.Text);
      PRegister.WriteString('Language', GszLanguage);
      PRegister.WriteBool('Pooler', CheckBoxPooler.Checked);
      if GpsSeries = psR9 then
      begin
        if cbxZT.ItemIndex >= 0 then
          PRegister.WriteString('CurrZTH', cbxZT.Items[cbxZT.ItemIndex]);
        PRegister.WriteString('LocalZTH', EditEditAccountFilter.Text);
        PRegister.WriteString('UserListFromDB', IFF(CheckBoxListAllUsers.Checked, '1', '0'));
      end;
      PRegister.CloseKey;
    end;

    if Reg.OpenKey(RegDBInfo, True) then
    begin
      if (ComboBoxDBType.ItemIndex = 0) then
      begin
        GDBType := MSSQL;
        Reg.WriteString('DBType', 'MSSQL');
      end;
      if (ComboBoxDBType.ItemIndex = 1) then
      begin
        GDBType := ORACLE;
        Reg.WriteString('DBType', 'ORACLE');
      end;
    end;
    if Reg.OpenKey(RegDBInfo, True) and RadioButtonAutoApp.Checked then
    begin
      //注册表中和前台不一致，需要重新写入注册表
      if (GDBType = MSSQL) and (Reg.ReadString('DBType') <> 'MSSQL') then
        Reg.WriteString('DBType', 'MSSQL');
      if (GDBType = ORACLE) and (Reg.ReadString('DBType') <> 'ORACLE') then
        Reg.WriteString('DBType', 'ORACLE');
      //单机模式下的数据库信息
      GsServerName := EditServerName.Text;
      Reg.WriteString('ServerName', GsServerName);

      if GpsSeries = psR9i then
      begin
        if GsDatabaseName <> EditDatabaseName.Text then
        begin
          GsDatabaseName := EditDatabaseName.Text;
          Reg.WriteString('DatabaseName', GsDatabaseName);
        end;
      end
      else
      begin
        Reg.WriteString('DatabaseName', 'master');
      end;
      GsUserName := EditUserName.Text;
      Reg.WriteString('UserName', GsUserName);
      // 2、再删除旧加密口令 Ident_Password 。
      //gsPassWord := EditPassword.Text;
      Reg.WriteString(Ident_Password_2, TString.EncryptStr(gsPassWord));
      if Reg.ValueExists(Ident_Password) then
        Reg.DeleteValue(Ident_Password);
      Reg.WriteString('SafeMode', '1'); // 数据安全(&S) 默认保存 为 随机密钥（服务器端产生随机密钥，客户端解释此密钥，并对数据解密）方式
      Reg.WriteString('TDSPackSize', '4096'); //bde的参数，默认保存 为4096字节传输
      Reg.WriteString('EnabledBCD', '0'); //bde的参数，默认保存 为非bcd格式传输
    end;
  finally
    Reg.Destroy;
  end;
end;

function TFormLogin.MixStr(const AText: string): string;
var
  RandomNum: integer; // 随机整数
  iPasslen: integer; // 密码长度
  i, iTemp: integer;
  sTemp, sTempPass: string;
  szBCDPass: string;
begin
  Result := '';
  if Trim(AText) = '' then
    exit; // 没有密码,无需加密
  iPasslen := length(AText);

  // 1) 形成n个四位的随机数串
  sTempPass := '';
  Randomize;
  for i := 1 to iPasslen do
  begin
    RandomNum := random(9999);
    sTemp := '0000' + IntToStr(RandomNum);
    sTemp := copy(sTemp, length(sTemp) - 3, 4);
    sTempPass := sTempPass + sTemp;
  end;

  // 2) 密码转换成BCD码,然后转换成数字串
  szBCDPass := '';
  for i := 1 to iPassLen do
  begin
    iTemp := ord(AText[i]);
    sTemp := '000' + IntToStr(iTemp);
    sTemp := copy(sTemp, length(sTemp) - 2, 3);
    szBCDPass := szBCDPass + sTemp;
  end;

  // 3) 交叉形成新串
  sTemp := '';
  for i := 1 to iPassLen do
  begin
    sTemp := sTemp + sTempPass[i * 4 - 3] + szBCDPass[i * 3 - 2]
      + sTempPass[i * 4 - 2] + szBCDPass[i * 3 - 1]
      + sTempPass[i * 4 - 1] + szBCDPass[i * 3]
      + sTempPass[i * 4];
  end;
  sTempPass := sTemp;

  // 4) 形成加法校验码,并加入长度
  iTemp := 0;
  for i := 1 to length(sTempPass) do
  begin
    iTemp := iTemp + StrToInt(copy(sTempPass, i, 1));
  end;
  iTemp := (iTemp mod 10);
  sTemp := '00' + IntToStr(iPassLen);
  sTemp := copy(sTemp, length(sTemp) - 1, 2);
  sTempPass := sTemp[1] + IntToStr(iTemp) + sTemp[2] + sTempPass;

  // 5) 以两位为一组,在其前面+'1', 最末一组如果只有一个,则+'20', 形成新码
  sTemp := '';
  iTemp := length(sTempPass);
  for i := 1 to ((iTemp + 1) div 2) do
  begin
    if i > (iTemp div 2) then // 最后一组,且为1字符 + '20'
    begin
      sTemp := sTemp + '20' + sTempPass[i * 2 - 1];
      break;
    end;
    sTemp := sTemp + '1' + sTempPass[i * 2 - 1] + sTempPass[i * 2];
  end;

  // 6) 三位为一组,转换成Chr字符串保存
  sTempPass := '';
  for i := 1 to (length(sTemp) div 3) do
  begin
    sTempPass := sTempPass +
      chr(StrToInt(sTemp[i * 3 - 2] + sTemp[i * 3 - 1] + sTemp[i * 3]));
  end;

  Result := sTempPass + chr(strtoint('100'));
end;

function TFormLogin.UnMixStr(const ACode: string;
  var AText: string): Boolean;
var
  i, iTemp: integer;
  sTemp, sTempPass: string;
begin
  Result := False;
  if Trim(ACode) = '' then
  begin
    Result := True;
    exit; // 没有密码,无需解密
  end;

  // 1) 转换成BCD码串
  sTempPass := '';
  for i := 1 to length(ACode) do
  begin
    // 非法值退出            or (ord(ACode[i]) < 100)
    if (ord(ACode[i]) > 210) then
    begin
      sTempPass := '';
      exit;

    end;
    if ord(ACode[i]) >= 100 then
      sTempPass := sTempPass + IntToStr(ord(ACode[i]))
    else
      sTempPass := sTempPass + '0' + IntToStr(ord(ACode[i]));
  end;
  sTemppass := copy(sTemppass, 1, length(sTempPass) - 3);
  // 2) 三位一组，去掉1或20
  sTemp := '';
  // 非法长度退出
  if (length(sTempPass) div 3) <> ((length(sTempPass) + 2) div 3) then
    exit;
  if length(sTempPass) < 10 then
    exit;

  for i := 1 to (length(sTempPass) div 3) do
  begin
    if sTempPass[i * 3 - 2] = '2' then
      sTemp := sTemp + sTempPass[i * 3]
    else
      sTemp := sTemp + sTempPass[i * 3 - 1] + sTempPass[i * 3];
  end;

  // 非法校验码
  if (sTemp[2] < '0') or (sTemp[2] > '9') then
    exit;

  // 3) 生成校验码，并与新码对比检查
  sTempPass := copy(sTemp, 4, length(sTemp) - 3);
  iTemp := 0;
  for i := 1 to length(sTempPass) do
  begin
    iTemp := iTemp + StrToInt(copy(sTempPass, i, 1));
  end;
  iTemp := (iTemp mod 10);
  // 检验码错误,退出
  {if iTemp <> StrToInt(sTemp[2]) then
    exit;        }

  // 去掉前三位，七位为一组，分离出密码的BCD码值
  // 非法长度
  sTemp := '';
  if (length(sTempPass) div 7) <> ((length(sTempPass) + 6) div 7) then
    exit;
  for i := 1 to (length(sTempPass) div 7) do
  begin
    try
      iTemp := StrToInt(sTempPass[i * 7 - 5] + sTempPass[i * 7 - 3] + sTempPass[i
        * 7 - 1]);
    except
      exit;
    end;
    sTemp := sTemp + chr(iTemp);
  end;
  AText := sTemp;
  Result := True;
end;

procedure TFormLogin.LabelOptionClick(Sender: TObject);
begin
  if LabelOption.Caption = ' 常规 <<' then
  begin
    PanelAppParam.Visible := False;
    LabelOption.Caption := ' 高级 >>';
    Height := Height - PanelAppParam.Height;
    PanelLogin.Height := PanelLogin.Height - PanelAppParam.Height;
    PanelOptions.Height := PanelOptions.Height - PanelAppParam.Height;
    PanelAppParam.Visible := False;
  end
  else if LabelOption.Caption = ' 高级 >>' then
  begin
    PanelAppParam.Visible := True;
    LabelOption.Caption := ' 常规 <<';
    Height := Height + PanelAppParam.Height;
    PanelLogin.Height := PanelLogin.Height + PanelAppParam.Height;
    PanelOptions.Height := PanelOptions.Height + PanelAppParam.Height;
    PanelAppParam.Visible := True;
  end;
end;

procedure TFormLogin.ButtonDataExcuteClick(Sender: TObject);
var
  Reg: TRegistry;
  szFileName, szSafeMode, szTDSPackSize, szEnabledBCD, sTemp: string; //数据库信息
  szAppComputer, szAppPort: string; //中间层信息
  szFile: TextFile;
begin
  szFileName := FilenameEditData.FileName;
  if trim(szFileName) = '' then
  begin
    SysMessage('请输入或选择文件名。');
    FilenameEditData.SetFocus;
    exit;
  end;
  if RadioButtonDataIn.Checked then //导入操作
  begin
    if uppercase(copy(Trim(szFileName), length(trim(szfileName)) - 3, 4)) <> '.INI' then
    begin
      szFileName := szfileName + '.ini';
    end;
    if not FileExists(szFileName) then
    begin
      SysMessage('指定文件"'+szFileName+'"不存在，请重新选择。');
      FilenameEditData.SetFocus;
      exit;
    end;
   //if SysMessage('即将导入的中间层设置信息会覆盖现有的设置信息，是否继续？。', 'Pub_01', [mbYes, mbNo], szFileName) = mrNo then
   //   exit;
    try
      assignFile(szFile, szFileName);
      reset(szFile);

      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_CURRENT_USER;
      //登录信息
      if Reg.OpenKey(RegLoginPath, True) then
      begin
        Readln(szFile, sTemp);
        Reg.WriteBool('IsHandApp', IFF(uppercase(sTemp) = 'TRUE', True, False));
        Readln(szFile, sTemp);
        Reg.WriteString('ConType', sTemp);
        Readln(szFile, sTemp);
        Reg.WriteString('User', sTemp);
        Readln(szFile, sTemp);
        Reg.WriteString('HTTP', sTemp);
        Readln(szFile, sTemp);
        Reg.WriteString('SrvHost', sTemp);
        Readln(szFile, sTemp);
        Reg.WriteString('SrvScktPort', sTemp);
      end;
      //获取数据连接信息
      if Reg.OpenKey(RegDBInfo, True) then
      begin
        Readln(szFile, sTemp);
        Reg.WriteString('ServerName', sTemp);
        Readln(szFile, sTemp);
        Reg.WriteString('DatabaseName', sTemp);
        Readln(szFile, sTemp);
        Reg.WriteString('UserName', sTemp);
        Readln(szFile, sTemp);
        Reg.WriteString('Password_2', sTemp);
        Readln(szFile, sTemp);
        Reg.WriteString('AutoAppMode', sTemp);
        Readln(szFile, sTemp);
        Reg.WriteString('DBType', sTemp);
      end;
      GetAppServerInfoFromReg;
      SysMessage('中间层配置信息导入成功。');
    finally
      CloseFile(szFile);
      Reg.Destroy;
    end;
  end
  else if RadioButtonDataOut.Checked then //导出操作
  begin
    if uppercase(copy(Trim(szFileName), length(trim(szfileName)) - 3, 4)) <> '.INI' then
    begin
      if uppercase(copy(Trim(szFileName), length(trim(szfileName)), 1)) <> '\' then
        szFileName := szfileName + '.ini';
    end;
    if not DirectoryExists(ExtractFilePath(szFileName)) then
    begin
      SysMessage('指定目录'+szFileName+'不存在，请重新设置目录。');
      exit;
    end;

    if FileExists(szFileName) then
    begin
      if Application.MessageBox(PChar('指定文件'+szFileName+'已经存在，是否覆盖？选择[是]则继续，选择[否]则退出。'),
        '系统提示', MB_ICONQuestion+MB_YesNo)
         = Id_No then
        exit;
    end;
    WriteAppServerInfoToReg;
    try
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_CURRENT_USER;
      assignFile(szFile, szFileName);
      rewrite(szFile);
      //登录信息
      if Reg.OpenKey(RegLoginPath, True) then
      begin
        sTemp := IFF(Reg.ReadBool('IsHandApp'), 'True', 'False');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('ConType');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('User');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('HTTP');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('SrvHost');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('SrvScktPort');
        writeln(szFile, sTemp);
      end;

      //获取数据连接信息
      if Reg.OpenKey(RegDBInfo, True) then
      begin
        sTemp := Reg.ReadString('ServerName');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('DatabaseName');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('UserName');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('Password_2');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('AutoAppMode');
        writeln(szFile, sTemp);
        sTemp := Reg.ReadString('DBType');
        writeln(szFile, sTemp);
      end;
      SysMessage('中间层配置信息导出成功。');
    finally
      CloseFile(szFile);
      Reg.Destroy;
    end;
  end;
end;

procedure TFormLogin.RadioButtonDataInClick(Sender: TObject);
begin
  if RadioButtonDataIn.Checked then
    ButtonDataExcute.Caption := '导入(&I)'
  else
    ButtonDataExcute.Caption := '导出(&I)';
end;

procedure TFormLogin.ComboBoxDBTypeChange(Sender: TObject);
begin
  if GpsSeries = psR9i then
  begin
    if ComboBoxDBType.ItemIndex = 0 then //SQLServer
    begin
      lblDBName.Visible := True;
      EditDatabaseName.Visible := True;
      LabelServerName.Top := 42;
      EditServerName.Top := 37;
      lblUser.Top := 95;
      EditUserName.Top := 91;
    end //Oracle
    else
    begin
      lblDBName.Visible := False;
      EditDatabaseName.Visible := False;
      LabelServerName.Top := 42;
      EditServerName.Top := 37;
      lblUser.Top := 83;
      EditUserName.Top := 77;
    end;
  end
  else begin
     if bOtherParamsLogin then  //sys.exe 参数传入模式下，不能清空
     else
        cbxZT.Clear;
  end; 
end;

procedure TFormLogin.InitInterface;
begin
  if GpsSeries = psR9 then
  begin
    RadioButtonAutoApp.Checked := True;
    RadioButtonAutoAppClick(nil);
    LabelAppMode.Visible := False;
    RadioButtonAutoApp.Visible := False;
    RadioButtonHandApp.Visible := False;
    cbxZT.Visible := True;
    lblZT.Visible := True;
    lblDBName.Visible := False;
    EditDatabaseName.Visible := False;
    lblDBName.Visible := False;
    EditDatabaseName.Visible := False;

    cbxZT.Top := 10;
    lblZT.Top := 14;
    label8.Top := 39;
    DateTimePickerBusinessDate.Top := 35;
    Label9.Top := 67;
    ComboBoxUser.Top := 63;

    PanelLoginAsID.Top := 83;
    Label10.Top := 114;
    EditPwd.Top := 110;
    chkSaveUser.Top := 133;
    Shape2.Top := 20;
    Label6.Top := 15;
    ButtonOK.Top := 451;
    ButtonCancel.Top := 451;
    ButtonOptions.Top := 451;
    ButtonHelp.Top := 451;

    // 崔立国 2010.10.26 只有 R9i 支持离线模式。
    CheckBoxUseOfflineMode.Visible := False;
    CheckBoxUseOfflineMode.Checked := False;

    PanelOptions.Top := 182;
    PanelS.Top := 30;
    PanelS.Height := 120;

    lblUser.Top := 70;
    EditUserName.Top := 64;
    LabelPassword.Top := 95;
    EditPassword.Top := 90;
    ButtonTestConnect.Top := 88;

    PanelLoginSet.Top := 145;

    LabelOption.Top := 154;
    CheckBoxUseSameLoginParams.Top := 154;
    PanelAppParam.Top := 176;
    ImageChgPassword.Top := 109;
    Label16.Caption := '数据库参数导入导出';
    Label6.Caption := '数据库选项';
  end;
end;

procedure TFormLogin.cbxZTDropDown(Sender: TObject);
var
  szZTH, szLocalZTH: string;
  MaxWidth:integer;
begin
  MaxWidth := 0;
  if not WriteAppServerInfoToReg then
    Exit;
  WriteDBType(GDBType);
  try
    IniConnect;
  except
    if ShowLoginHint('无法与应用服务器建立连接！' + #13#10#13#10 +
      '请检查：' + #13#10 +
      '    1、应用服务器地址是否正确；' + #13#10 +
      '    2、应用服务器是否正常启动。') = mrYes then
    begin
      PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
    end;
    Exit;
  end;

  try
    if not DataModulePub.MidasConnectionPub.Connected then
    begin
      DataModulePub.MidasConnectionPub.Connected := True;
    end;
  except
    if ShowLoginHint('无法与应用服务器建立连接！' + #13#10#13#10 +
      '请检查：' + #13#10 +
      '    1、应用服务器地址是否正确；' + #13#10 +
      '    2、应用服务器是否正常启动。') = mrYes then
    begin
      PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
    end;
    Exit;
  end;

  CdsLogin.filter := '';
  if not GetAccountList() then
    exit;
  cbxZT.Items.Clear;
  CdsLogin.filtered := True;
  szLocalZTH := EditEditAccountFilter.Text;
  if trim(szLocalZTH) <> '' then
  begin
    szLocalZTH := PGetLikeStr(Trim(szLocalZTH), '*', ';', 'ZTH');
    CdsLogin.filter := szLocalZTH;
  end;
  CdsLogin.FindFirst;
  if not Assigned(DBLst) then
    DBLst := TStringList.Create;
  DBLst.Clear;
  while not CdsLogin.EOF do
  begin
    cbxZT.Items.Add(
      trim(CdsLogin.FieldByName('Zth').asString) + '|' +
      trim(CdsLogin.FieldByName('Ztmc').asString));
    if Canvas.TextWidth(cbxZT.Items[cbxZT.Items.Count-1])>MaxWidth then
       MaxWidth := Canvas.TextWidth(cbxZT.Items[cbxZT.Items.Count-1]);
    DBLst.Values[CdsLogin.FieldByName('dbName').AsString] := cbxZT.Items[cbxZT.Items.Count - 1];
    CdsLogin.next;
  end;
  if MaxWidth > cbxZT.Width then
    cbxZT.Width := 260;
  cbxZT.ItemIndex := cbxZT.Items.IndexOf(LocalZTH);
  if cbxZT.ItemIndex = -1 then
    cbxZT.ItemIndex := 0;
  CdsLogin.Filtered := FALSE;
end;

function TFormLogin.GetAccountList: Boolean;
begin
  Result := False;
  GAppDBUserName := EditUserName.Text;
  if GDbType = ORACLE then
    ReChangeDB(GAppDBUserName)
  else
    ReChangeDB('master');
  try
    if GDbType = ORACLE then
      POpenSQL(CdsLogin, 'Select * from ' + GAppDBUserName + '.anyigl order by zth')
    else
      POpenSQL(CdsLogin, 'Select * from AnyiSys..anyigl order by zth');
    if not CdsLogin.FindFirst then
    begin
      CdsLogin.Close;
      SysMessage('请使用后台数据管理工具建立账套。');
      Exit;
    end;
    result := true;
  except
    on E: exception do
    begin
      if pos('Insufficient memory', E.message) > 0 then
      begin
        if GpsSeries = psR9 then
          SysMessage('当前机器的可用内存不足，您可以尝试以下操作：' + #13#10 +
            '1：请退出一些应用程序,然后重试。')
        else
          SysMessage('当前机器的可用内存不足，您可以尝试以下操作：' + #13#10 +
            '1：请退出一些应用程序。' + #13#10 +
            '2：在[选项]中设置中间层模式为[手工模式]登录系统。');
      end
      else
      begin
        if pos(UpperCase('Anyisys'), UpperCase(E.message)) > 0 then
        begin
          SysMessage('请使用后台数据管理工具建立账套。');
        end
        else
        begin
          SysMessage('无法与数据库服务器或账套数据建立连接！' + #13#10 +
            '请检查数据库服务器是否已启动，及用户和密码是否正确。' + #13#10 +
            '检查方法：' + #13#10 +
            '  1：点击[选项]按钮；' + #13#10 +
            '  2：正确输入服务器名、用户名和密码，' + #13#10 +
            '  3：点击[测试连接]。');
        end;
      end;
      CdsLogin.Close;
      Exit;
    end;
  end;
end;

procedure TFormLogin.cbxZTChange(Sender: TObject);
var
  lFind: longint;
  iLen: integer;
  oldONChange: TNotifyEvent;
begin
(*
  iLen := length(cbxZT.text);
  lFind := cbxZT.Perform(CB_FINDSTRING, -1, longint(pchar(cbxZT.Text)));
  if LFind <> -1 then
  begin
    oldOnChange := cbxZT.OnChange;
    cbxZT.OnChange := nil;

    cbxZT.text := cbxZT.Items[LFind];
    cbxZT.SelStart := iLen;
    cbxZT.SelLength := length(cbxZT.text) - ilen;

    cbxZT.OnChange := oldOnchange;
  end;
  if cbxZT.Items.IndexOf(cbxZT.Text) >= 0 then
  begin
    if Pos('|', cbxZT.Text) = 0 then
      Exit;
    if not CdsLogin.Active then
      Exit;
  end; *)

end;

procedure TFormLogin.EditServerNameExit(Sender: TObject);
begin
  //更换服务器地址，账套应该清空
  if GpsSeries = psR9 then
  begin
    if EditServerName.Text <> GsServerName then
      cbxZT.Clear;
  end;
end;

function TFormLogin.IsR9iDB: Boolean;
var
  i: integer;
begin
  Result := False;
  with DataModulePub.ClientDataSetPub do
  begin
    POpenSQL(DataModulePub.ClientDataSetPub, 'Select * from GL_ztcs where 0=1');
    for i := 0 to Fields.Count - 1 do
    begin
      if uppercase(Fields[i].FieldName) = 'KJND' then
      begin
        Result := True;
        break;
      end;
    end;
  end;
end;

function TFormLogin.GetDBName: string;
begin
  Result := '';
  if (GszGSDM311<>'') and (GszDBNAME<>'') then
     Result := GszDBNAME
  else if CdsLogin.Active then begin
    if (cbxZT.ItemIndex = -1) and (cbxZT.Text<>'') then
      cbxZT.ItemIndex := cbxZT.Items.IndexOf(cbxZT.Text);
    if cbxZT.ItemIndex = -1 then
    begin
      SysMessage('请选择账套！');
      Exit;
    end;
    if CdsLogin.Locate('zth',
      TString.LeftStrBySp(cbxZT.Items[cbxZT.ItemIndex], '|'), []) then
      Result := CdsLogin.FieldByName('dbname').AsString;
  end;
end;

procedure TFormLogin.ReChangeDB(dbName:string='');
var
  szDBType: string;
begin
  // 崔立国 2010.10.11 离线工作模式登录
  if not GblOfflineMode then
  begin
    szDBType := IFF(GDBType = MSSQL, 'MSSQL', 'ORACLE');
    if dbName='' then
      GszDBNAME := GetDBName
    else
      GszDBNAME := dbName;

    if DataModulePub.MidasConnectionPub.Connected and (GszDBNAME<>'')  then
      DataModulePub.MidasConnectionPub.AppServer.ChangeDB(szDBType, GszDBNAME);
  end;
end;

procedure TFormLogin.EditPasswordChange(Sender: TObject);
begin
  gsPassWord := EditPassword.Text;
end;

procedure TFormLogin.SetDBInfo;
var
  Params:string;
begin
  //hch 设置中间层的数据库连接信息
  with DataModulePub.MidasConnectionPub do
  begin
    Params := 'ServerName='+GsServerName;
    Params := Params + #8+'&DatabaseName='+GsDatabaseName;
    Params := Params + #8+'&Username='+GsUserName;
    Params := Params + #8+'&Password='+GsPassword;
    Params := Params + #8+'&DBType='+IFF(GDBType=MSSQL, 'MSSQL', 'ORACLE');
    AppServer.SetDBinfo(Params);
  end;
end;

function TFormLogin.GetRegDBInfo: string;    //DSL
begin
  //修改获取注册表路径
  //sPath := RegLoginPath+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');
  Result := Format(szDBInfo, [GsProductID])+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');
  //Result := GetWriteSubKey(PRegister, Result, Application.ExeName);
end;

function TFormLogin.GetRegLogPath: string;    //DSL
begin
  //修改获取注册表路径
  Result := Format(szDBInfo, [GsProductID])+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');  
end;
procedure TFormLogin.SetIsChangeND(const Value: Boolean);
begin
  FIsChangeND := Value;
end;

procedure TFormLogin.SetShowTitle(const Value: String);
begin
  FShowTitle := Value;
  if Length(FShowTitle)>4 then
   rxlbl1.Left := 139;
end;

procedure TFormLogin.SysMessage(msg: String);
begin
  //MessageDlg(msg, Dialogs.mtInformation, [Dialogs.mbOK], 0);
  Application.MessageBox(PChar(msg),'系统提示',MB_ICONInformation+MB_OK);
end;

procedure TFormLogin.WMLoginAsOfflineMode(var Message: TMessage);
begin
  CheckBoxUseOfflineMode.Checked := True;
  ButtonOK.Click;
end;

procedure TFormLogin.CheckBoxUseOfflineModeClick(Sender: TObject);
begin
  if CheckBoxUseOfflineMode.Checked then
  begin
    PanelOptions.Enabled := False;
    LabelAppMode.Enabled := False;
    RadioButtonAutoApp.Enabled := False;
    RadioButtonHandApp.Enabled := False;

    PanelS.Enabled := False;
    ComboBoxDBType.Color := clBtnFace;
    EditServerName.Color := clBtnFace;
    EditDatabaseName.Color := clBtnFace;
    EditUserName.Color := clBtnFace;
    EditPassword.Color := clBtnFace;
    ComboBoxDBType.Font.Color := clInactiveCaption;
    EditServerName.Font.Color := clInactiveCaption;
    EditDatabaseName.Font.Color := clInactiveCaption;
    EditUserName.Font.Color := clInactiveCaption;
    EditPassword.Font.Color := clInactiveCaption;
    SpeedButtonFind.Enabled := False;
    ButtonTestConnect.Enabled := False;
    LabelDBType.Enabled := False;
    LabelServerName.Enabled := False;
    lblDBName.Enabled := False;
    lblUser.Enabled := False;
    LabelPassword.Enabled := False;

    PanelR.Enabled := False;
    cbConType.Color := clBtnFace;
    ComboBoxHost.Color := clBtnFace;
    SMaskEditPort.Color := clBtnFace;
    LabelConType.Enabled := False;
    LabelHost.Enabled := False;
    LabelPort.Enabled := False and (cbConType.ItemIndex = 1);

    CheckBoxUseSameLoginParams.Enabled := False;
  end else
  begin
    PanelOptions.Enabled := True;
    LabelAppMode.Enabled := True;
    RadioButtonAutoApp.Enabled := True;
    RadioButtonHandApp.Enabled := True;

    PanelS.Enabled := True;
    ComboBoxDBType.Color := clWindow;
    EditServerName.Color := clWindow;
    EditDatabaseName.Color := clWindow;
    EditUserName.Color := clWindow;
    EditPassword.Color := clWindow;
    ComboBoxDBType.Font.Color := clWindowText;
    EditServerName.Font.Color := clWindowText;
    EditDatabaseName.Font.Color := clWindowText;
    EditUserName.Font.Color := clWindowText;
    EditPassword.Font.Color := clWindowText;
    SpeedButtonFind.Enabled := True;
    ButtonTestConnect.Enabled := True;
    LabelDBType.Enabled := True;
    LabelServerName.Enabled := True;
    lblDBName.Enabled := True;
    lblUser.Enabled := True;
    LabelPassword.Enabled := True;

    PanelR.Enabled := True;
    cbConType.Color := clWindow;
    ComboBoxHost.Color := clWindow;
    SMaskEditPort.Color := clWindow;
    LabelConType.Enabled := True;
    LabelHost.Enabled := True;
    LabelPort.Enabled := True and (cbConType.ItemIndex = 1);

    CheckBoxUseSameLoginParams.Enabled := True;
  end;
end;

procedure ApplicationExec(ParentForm: TCustomForm; Params: TStrings);
  function AppAlreadyExists(): boolean;
  var
    hMutex: HWND;
    Ret: Integer;
  begin
    hMutex := CreateMutex(nil, False, PChar(string(GszVersion))); //GProSign
    Ret := Windows.GetLastError;
    if Ret = ERROR_ALREADY_EXISTS then begin
      result := true;
    end else begin
      result := false;
    end;
    ReleaseMutex(hMutex);
  end;

  function SystemInitialize: Boolean;
  var
    sdbname, susername, spassword: string;
    szSOS: ShortString;
  begin
    Result := True;
    GExePath := GetExePath;
    //账务处理系统 出纳管理系统。。。。//通用版 核算中心版 ，单机/网络，标准集团
    GProVerSionScript := GetProVerSionScript(GDbType, GProSign, GProSeries, GProVersion, GszVersion);
    GProSeriesName := GetProSeriesName(GProSeries); //通用财务软件，财政管理软件，GRP财务软件。。。

    if GNOJMVer_CusName<>'' then begin
       Application.Title := GProSeriesName+'-'+GNOJMVer_CusName;// +'('+GszEdition+')版';
       Application.MainForm.Caption := GProSeriesName+'-'+GNOJMVer_CusName;// +'('+GszEdition+')版';
    end else begin
      // 崔立国 2011.06.20 "财政"不显示"G版"字样
      if (Pos('财政', GProSeriesName) > 1) or (GszEdition='精华') then
        Application.Title := GProSeriesName
      else
        Application.Title := GProSeriesName +'('+GszEdition+')版';    //崔立国 2009.07.27 应张文海要求，增加下面的判断代码。 if GProSeries_GK = 'FOMS' then GProName := GFOMSCaption;

      // 崔立国 2011.06.20 "财政"不显示"G版"字样
      // 程建福 20150716 精华版不显示GszEdition，直接取资源文件中的名称
      if (Pos('财政', GProSeriesName) > 1) or (GszEdition='精华') then
        Application.MainForm.Caption := GProSeriesName
      else
        Application.MainForm.Caption := GProSeriesName +'('+GszEdition+')版';
    end;
    
    try
      Application.MainForm.Enabled := False;
      GAnyiLicenseInfo.ConnectAnyiServer;
    finally
      Application.MainForm.Enabled := True;
    end;
    //modified by chengjf 20150717 精华版不检查sps
    if (GszEdition<>'精华') and (not CheckSPS) then begin  //进入程序时进行验证   //SPS
       Application.MainForm.free;
       Result := False;
       Exit;
    end;
        
    SplashShow();
    GPubProviderName := DataModulePub.ClientDataSetPub.ProviderName;
    GPubProviderOpenName := DataModulePub.ClientDataSetPub.ProviderName;
    InitGnScript(GGnScripts); //初始化全局功能描述数组
    SplashClose;  // 闪动窗关

    // 系统登录
    if SysLogin(Params) then begin
      Result := True;
      if (ParamCount>=13) and (GsParamGNFLMC<>'')  then begin  //登录后启动功能
          //RunGNFLMC(GsParamGNFLMC);   //待办事宜是时钟控制的，这里取不到
      end;
    end else begin
      GCancelLogin := true;
      if Assigned(FormBackGround) then
         FormBackGround.Free;
      if DataModulePub.MidasConnectionPub.Connected then
         DataModulePub.MidasConnectionPub.Connected := False;
      DataModulePub.free;
      Application.MainForm.free;
      Result := False;
    end;
  end;

begin
  Application.Initialize;
  //hch 判断网络版还是单机版.
  //Pub_Res.Res_InitGlobal; //hch 初始化Res变量

  if Params = nil then
     GDbType := GetDBType;
  GsReloadCache := GetCacheService;    // 2007-10-22 09:44 hch
  if not AppAlreadyExists() then begin
    if SystemInitialize() then begin
      Application.Run;
    end else begin
      Application.Terminate;
    end;
  end else begin
    if SysMessage('前台程序已经在运行，是否再运行一个？', '_XW', [mbYes, mbNo]) = mrYes then begin   //DSL
       if SystemInitialize() then begin
         Application.Run;
       end else begin
         Application.Terminate;
       end;
    end else begin
      if Assigned(FormBackGround) then
          FormBackGround.Free;
      if DataModulePub.MidasConnectionPub.Connected then
         DataModulePub.MidasConnectionPub.Connected := False;
      DataModulePub.free;
      Application.MainForm.Free;
      Application.Terminate;
    end;  
  end;
end;

procedure RunGNFLMC(sGNFLMC:String);
var
  iPos,i:Integer;
  sModeCode:String;
  sSQL:string;
begin
  //ShowMessage('第13个参数是：DBSY:'+sGNFLMC);
  iPos:= Pos(':',sGNFLMC); // sParamDBSY:=DBSY:PA:工资待办事宜
  if sGNFLMC='' then Exit;
  if iPos<=0 then Exit;
  sModeCode := Trim(Copy(sGNFLMC,1,iPos-1));
  if sModeCode='' then Exit;
  sGNFLMC := Copy(sGNFLMC,iPos+1,Length(sGNFLMC)-iPos);
  sSQL := 'select ModCode,Menucode,GnFlExec from GL_GNFL where ModCode='+QuotedStr(sModeCode)+' and GNFLMC='+QuotedStr(sGNFLMC);
  POpenSql(DataModulePub.ClientDataSetTmp, sSQL);
  with DataModulePub.ClientDataSetTmp do
  begin
    if RecordCount=1 then
    begin
      FormMain.LoadModeDll(
        sModeCode,
        sGNFLMC,
        FieldByName('GnFlExec').AsString
        );
    end;
  end;

  {
  with FormMain.TreeViewMyFunc do begin
    for i := 0 to Items.Count - 1 do begin
        if Items[i].Data=nil then Continue;
        if SameText(PTreeRec(Items[i].Data)^.sModCode,sModeCode)
           and SameText(sGNFLMC,PTreeRec(Items[i].Data)^.sGnflMc) then begin
           Items[i].Selected := True;
           FormMain.FuncTreeClick(FormMain.TreeViewMyFunc);
           Break;
        end;
    end;
  end; }

end;

procedure ApplicationRun();
var
  ParamList: TStringList;
  sParamGNFLMC,sPin,ssss,szKey:String;
  iPos,iLen,i:Integer;
begin
  //showmessage('ParamCount='+inttostr(ParamCount)+' ConnectionType='+ParamStr(11));
  GsParamGNFLMC := '';
  //sys.exe  操作员名 密码 登录日期 账套号 账套名称 公司代码 公司名称 服务器地址 端口号 0(服务器模式) http 数据库类型(MSSQL或ORACLE)
  //SYS.exe 系统管理员 1 20131118 01zth 经费账ztmc 201gsdm 职业学院gsmc 127.0.0.1AppServerName 88 0 HTTP MSSQL

  //C/B版
  //SYS.exe 系统管理员 1 20131118 002 B 002 b 10.10.65.170 88 0 AUTO MSSQL G版
  //SYS.exe 系统管理员 1 20131118 013 工资帐套 013 工资帐套 127.0.0.1 ServerName=127.0.0.1&DatabaseName=Master&UserName=sa&Password=zz AUTO MSSQL    C版
  //系统管理员 1 20131118 013 一职中 013 一职中 . 211 ServerName=.&DatabaseName=Master&UserName=sa&Password=zz AUTO MSSQL

  //SYS.exe 系统管理员 1 20131128 账套号 账套名称 公司代码 公司名称 127.0.0.1 80 ServerName=127.0.0.1&DatabaseName=Master&UserName=sa&Password=1 AUTO MSSQL

  (* 单点登录格式说明 lzn
  目前对于G版的前台程序SYS，完全支持单点登录的调用

  调用格式为 ：
      Sys.exe 操作员名 密码 业务日期 账套编号 账套名称 单位编码 单位名称 U8应用服务器地址 U8应用服务器端口 0 HTTP 数据库类型
  如：SYS.exe 系统管理员 1 20131118 01 经费账 201 职业学院 127.0.0.1 88 0 HTTP MSSQL
 
 
  但是C版的调用格式参数是：
          Sys.exe  操作员名 操作员密码 业务日期 账套编号 账套名称 单位编码 单位名称 U8应用服务器地址  U8应用服务器端口 数据库连接串  AUTO 数据库类型
 
  如：SYS.exe 系统管理员 1 20131118 U8XZC2013071 U8XZC2013071 U8XZC2013071 U8XZC2013071 127.0.0.1 80 ServerName=127.0.0.1&DatabaseName=Master&UserName=sa&Password=1 AUTO MSSQL
 
  注意，数据库连接串，格式如：ServerName=127.0.0.1&DatabaseName=Master&UserName=sa&Password=1
  后面用 AUTO ，不是http
  *)

  //上海格尔CA 启动时先进行CA验证 Added by chengjf 2015-03-26 9:14:54
  if LoginKeyIntf.LoginKeyCanWriteGE then
  begin
    szKey := LoginKeyIntf.ReadUserKEY_CA(True);
    if szKey = '' then
    begin
      Application.Terminate;
    end;
  end;
  if ParamCount >= 12 then
  begin
    ParamList := TStringList.Create;
    ParamList.Add('UserName=' + ParamStr(1));
    ParamList.Add('Password=' + ParamStr(2));
    ParamList.Add('TransDate=' + ParamStr(3));
    ParamList.Add('AccountID=' + ParamStr(4));
    ParamList.Add('AccountName=' + ParamStr(5));
    ParamList.Add('CompanyID=' + ParamStr(6));
    ParamList.Add('CompanyName=' + ParamStr(7));
    ParamList.Add('AppServerName=' + ParamStr(8));
    ParamList.Add('AppServerPort=' + ParamStr(9));
    ParamList.Add('WithPrompt=' + ParamStr(10));
    ParamList.Add('ConnectionType=' + ParamStr(11));
    ParamList.Add('DBType=' + ParamStr(12));
    if ParamStr(12)='MSSQL' then
         GDbType := MSSQL
    else GDbType := ORACLE;

    sParamGNFLMC := '';
    //ShowMessage('第12个参数是数据库:'+ParamStr(12));
    if ParamCount>=13 then begin
       sParamGNFLMC := trim(ParamStr(13));       //ShowMessage('第13个参数:'+sParamGNFLMC);  FBI:功能中文名
       //===自动调用待办事宜窗体
       iPos:= Pos('DBSY:',sParamGNFLMC); // sParamDBSY:=DBSY:PA:工资待办事宜
       if iPos>0 then begin
          ParamList.Add('FormName=' + sParamGNFLMC);
          iLen := Length('DBSY:');
          GsParamGNFLMC := Copy(sParamGNFLMC,iLen+1,Length(sParamGNFLMC)-iLen);          //iPos:= Pos(':',sParamDBSY);
       end else begin //modified by chuym 20150720 由外部系统传递参数调功能窗口例如：FBI：单位指标登记簿 菜单。  
         GsParamGNFLMC := sParamGNFLMC ;          //iPos:= Pos(':',sParamDBSY);
       end;
    end;

    //zhangwh20120823 begin   增加入参  DDSL
    if FGetParaValueByName('MODEL:')<>'' then begin
        //ParamList.Add('ModelName=' + FGetParaValueByName('MODEL:'));
        GszModelName := FGetParaValueByName('MODEL:') ; //模块标识 如 FCP
    end;
    if FGetParaValueByName('BILLID:')<>'' then begin
        //ParamList.Add('BillID=' + FGetParaValueByName('BILLID:'));
        GszBillID  := FGetParaValueByName('BILLID:'); //单据ID   如 00.2012.0.1
    end;    
    if FGetParaValueByName('CALL:')<>'' then begin
        //ParamList.Add('CallFlag=' + FGetParaValueByName('CALL:'));
        GszCallFlag := FGetParaValueByName('CALL:'); //外部调用系统的标识 如飞企办公系统调用为 FE
    end;

    if FGetParaValueByName('OperateFlag:')<>'' then begin
        //ParamList.Add('CallFlag=' + FGetParaValueByName('CALL:'));
        GszOperateFlag := FGetParaValueByName('OperateFlag:'); //外部调用系统的标识 如飞企办公系统调用为 FE
    end;
    //zhangwh20120823 end

    GsPin := '';
    sPin := '';  //检测哪一位是PIN密码  
    if ParamCount>=13 then begin
       if Pos('PIN:',ParamStr(13))<=0 then begin
          ParamList.Add('FormName=' + ParamStr(13));
       end else
          sPin := ParamStr(13);
    end;

    if ParamCount>=14 then begin
       if Pos('PIN:',ParamStr(14))>0 then
         sPin :=ParamStr(14) ;
    end;

    if ParamCount>=15 then begin
       if Pos('PIN:',ParamStr(15))>0 then
         sPin :=ParamStr(15) ;
    end;

    if ParamCount>=16 then begin
       if Pos('PIN:',ParamStr(16))>0 then
         sPin :=ParamStr(16) ;
    end;        

    (*ssss := '';
    for i:=0 to ParamCount do begin
      ssss := ssss+';'+#13+ParamStr(i);
    end;
    ShowMessage('参数个数：'+IntToStr(ParamCount)+#13+'参数字符串：'+#13+ssss+' '+#13+'请数一下pin密码是第几个参数');
    if sPin='' then
         showmessage('pin密码为空')
    else showmessage(spin); *)

    if sPin<>'' then begin  //由于门户传的PIN密码是16个参数
       GsPin := trim(sPin);
       iPos := Pos('PIN:',GsPin);
       GsPin := Copy(GsPin,iPos+4,Length(GsPin)-4);
       GbCaPinLogin := True;
    end;     

    ApplicationExec(nil, ParamList);
    ParamList.free;
  end else
    ApplicationExec();
end;

function GetCacheService: string;
var
  sWinPath: array[1..255] of char;
  XmlFile: string;
  IXMLC: IXMLDOMDocument;
  Node: IXMLDOMNode;
begin
  GetSystemDirectory(@sWinPath, 255);
  XmlFile := Trim(sWinPath) + '\' + cAutoXML;
  if FileExists(XmlFile) then
  begin
    IXMLC := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
    IXMLC.load(XmlFile);
    Node := IXMLC.Get_documentElement;
    Node := Node.selectSingleNode('DataSource');
    if Node <> nil then
    begin
      if Node.attributes.getNamedItem('CacheService') <> nil then
      begin
        Result := Node.attributes.getNamedItem('CacheService').Get_nodeValue
      end
      else
        Result := ''
    end
    else
      Result := '';
  end
  else
    Result := '';
end;

function FGetParaValueByName(szParaName: String): String;   // DDSL
Var
    i,iPos:Integer;
    szTemp:String;
begin
    Result := '' ;
    if szParaName='' then Exit ;
    for i:=1 to ParamCount do begin
      szTemp := ParamStr(i) ;
      szTemp := uppercase(szTemp);
      //传递模块信息入参值
      iPos := Pos(szParaName,szTemp);
      if iPos>0 then begin
        Result := Copy(szTemp,iPos+1,Length(szTemp)-iPos);
        Break;
      end;
    end;
end;

function TFormLogin.ChgUnitLogin: Boolean;
var
  //FGszGSDM, FYWRQ, FGszHSDWDM, FGszHSDWMC, FGszZth, FGszZTMC: string;
  FGszGSDM1, FYWRQ1, FGszHSDWDM1, FGszHSDWMC1, FGszZth1, FGszZTMC1: string;
begin
  Result := True;
  FormLogin.ReloginCzyID :=IntToStr(GCZY.ID);
  if rbtnCZYID.Checked then
    ComboBoxUser.Text := IntToStr(GCzy.id)
  else
    ComboBoxUser.Text := GCzy.name;
  EditPwd.Text := GCzy.Password;
  IsCancelChoseUnit := True;
  //DecodeDate

  DateTimePickerBusinessDate.Date := EncodeDate(StrToInt(Copy(GszYWRQ, 1, 4)),
    StrToInt(Copy(GszYWRQ, 5, 2)),
    StrToInt(Copy(GszYWRQ, 7, 2)));
  GDBType := GetDBType(True);

  DateTimePickerBusinessDate.Date := TString.StrToDate(Copy(GszYWRQ, 1, 4) + '-' + Copy(GszYWRQ, 5, 2) + '-' + Copy(GszYWRQ, 7, 2));
  if PRegister.OpenKey(RegLoginPath, True) then //领导查询模式登录,则登录信息不记录到注册表
  begin
    PRegister.WriteString('Dwdm', GszHSDWDM);
    PRegister.WriteString('Dwmc', GszHSDWMC);
    PRegister.WriteString('Ztbh', GszZth);
    PRegister.WriteString('Ztmc', GszZTMC);
    PRegister.CloseKey;
  end;
  SpeedButtonOKClick(nil);
  Result := BlLoginOk;
end;

procedure TFormLogin.ButtonCancelClick(Sender: TObject);
begin
  gsSingleMode := gsSingleMode_Bak; //由于取消了，所以将此变量改回来
end;

procedure TFormLogin.btnUserClick(Sender: TObject);
var
  N1,N2: TMenuItem;
begin
  if pmUser = nil then
  begin
    pmUser := TPopupMenu.Create(Self);
    N1 := TMenuItem.Create(pmUser);
    N1.Caption := '删除当前记住用户';
    N1.OnClick := DelRemUser;
    pmUser.Items.Add(N1);

    N2 := TMenuItem.Create(pmUser);
    N2.Caption := '清除所有记住用户';
    N2.OnClick := ClearRemUsers;
    pmUser.Items.Add(N2);
  end;
  pmUser.Popup(Self.Left +  btnUser.Left+2,Mouse.CursorPos.Y+10);
end;

procedure TFormLogin.ClearRemUsers(Sender: TObject);
begin
  PUserList.Clear;
  ComboBoxUser.Clear;
  WriteRegS('User', PUserList.CommaText);
  btnUser.Enabled := PUserList.Count > 0;
end;

procedure TFormLogin.DelRemUser(Sender: TObject);
var
  iPos:Integer;
begin
  iPos := PUserList.IndexOf(ComboBoxUser.Text);
  if iPos=-1 then
  begin
    Exit;
  end;
  PUserList.Delete(iPos);

  WriteRegS('User', PUserList.CommaText);

  if iPos < ComboBoxUser.Items.Count then
    ComboBoxUser.Items.Delete(iPos);

  if PUserList.Count<=0 then
  begin
    ComboBoxUser.Clear;
    ComboBoxUser.Text := '';
    Exit;
  end;
  if iPos>PUserList.Count then
  begin
    ComboBoxUser.ItemIndex := ComboBoxUser.Items.IndexOf(PUserList.Strings[0]);
  end
  else
  begin
    ComboBoxUser.ItemIndex := ComboBoxUser.Items.IndexOf(PUserList.Strings[iPos]);
  end;
  btnUser.Enabled := PUserList.Count > 0;
end;


initialization
 // GProfileTool := TProfileChat.Create;

finalization
 // GProfileTool.Free;

end.

