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
    //��̬�����˵�
    pmUser: TPopupMenu;
    procedure IniConnect;
    procedure SetPanel(v: Boolean);
    function TestConnectServerDM(IsShowMsg: Boolean = true): Boolean;

    procedure GetAppServerInfoFromReg; //��ע����ж����м����Ϣ
    function WriteAppServerInfoToReg: Boolean; //д�м����Ϣ��ע���
    procedure DoSaveUser;//add by wangxin 2015-08-17 v10.3�������洢��¼�û���������
    procedure WriteRegS(Akey,Avalue:string);//add by wangxin 2015-08-17 дע���
    procedure DelRemUser(Sender: TObject);//add by wangxin 2015-08-18
    procedure ClearRemUsers(Sender: TObject);//add by wangxin 2015-08-18
    function MixStr(const AText: string): string; //�����м�����ݿ����� ��xiangjun 20070417
    function UnMixStr(const ACode: string; var AText: string): Boolean;
    function GetRegDBInfo: string;
    function GetRegLogPath: string;
    procedure SetIsChangeND(const Value: Boolean);
    procedure SetShowTitle(const Value: String);
    //hch ��Ϣ��ʾ����ʱ���޷���ȡ��Ϣ�Ľ��㣬ֱ�Ӳ���ϵͳ����Ϣ��ʾ����
    procedure SysMessage(msg:String);
    // ������ 2010.10.12
    procedure WMLoginAsOfflineMode(var Message: TMessage); message WM_LoginAsOfflineMode;
    // ��������Ƿ�Ϲ� Added by chengjf 2016-03-23
    function CheckPassword: Boolean;
  public
    bHSCAKey:Boolean;
    sHSCZY:string;  
    BlLoginOk: boolean;
    bLoginClick: Boolean;
    LoginCount: Integer;
    //�Ƿ�ȡ��ѡ��λ.
    IsCancelChoseUnit: Boolean;
    function CheckAppVersion: Boolean;
    procedure ShowLogin;
    function ReChoseUnitLogin(piType:Integer): Boolean;
    //add by wangxin 2009.07.09����ʾѡ�������
    function ChgUnitLogin: Boolean;
    function GetDWZTHExists: Boolean;
    //hch ��ʼ��������ʾ,R9i���汣�ֲ��䣬R9������Ҫ���е���
    procedure InitInterface;
    //�ж��Ƿ���R9i���ݿ�ṹ������GL_ztcs�Ƿ�����������������ж�
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
    property ReloginCzyID :string read FReloginCzyID write FReloginCzyID;  //zhengjy 2014-10-11 ����������������汾,��ʱ��¼���µ�½ʱԭ����ԱID
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
  FormLogin: TFormLogin;    //�Ƿ���������
  FNetStart: Boolean;
  LocalZTH: string;
  GiConType:Integer;
  szOtherPassword:string;  // hch 2010.1.21 �ⲿϵͳ���ô��밴���Ĵ���� password
  GsParamGNFLMC:string='';
  gsSingleMode_Bak:string;

function GetCacheService: string;

procedure ApplicationExec(ParentForm: TCustomForm = nil; Params: TStrings = nil);  //�ú���Ϊ��ܳ�����ã�����ģ������
procedure ApplicationRun();
procedure RunGNFLMC(sGNFLMC:String);
//function GetAllModeEncrypt:Boolean;
function SysLogin(Params: TStrings): Boolean;
function SysReLogin(KJND:String=''): boolean;

{zhangwh20120823��õ��ò����Ĳ���ֵ        DDSL
 szParaName �ĸ�ʽΪ��������ʶ:ʵ�ʲ�������
 �� MODEL:SA ��BILLID:00.2012.0.1 ��CALL:FE
}
function FGetParaValueByName(szParaName:String):String;

const
  // Get copy from updateljxt.pas // bryan
  OldProSignNames: array[0..2, 0..19] of string = (
    ('GL', 'GS', 'CM', 'GZ', 'FA', 'ZJ', 'PR', 'BG', 'BZ', 'CS', 'ZB', 'PJ', 'SC', 'RI', 'NT' {}, '', '', '', '', ''),
    // Old
    ('GL', '', 'CM', 'PA', 'FA', 'BM;BMIN', '', 'BG', 'ECS', '', 'FBI', 'CHQ', '', '', 'NTMF;NTMD;NTMJ' {}, 'DBG',
    'FCP', 'ATM', 'ADM', 'CNT'), // New
    ('����', '', '����', '����', '�̶��ʲ�', '�ʽ�', '', 'Ԥ�����', '����', '', '����ָ���벦��', 'Ʊ��', '', '',
    '��˰' {֮ǰ��10��}, '����Ԥ��', '����֧��', 'ũ˰����', '��Ƶ���', '��ͬ����') // Caption
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

// ������ 2009.09.27 ����U�ܵ�¼��ش��롣
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
  FShowTitle := '���ڵ�¼';
  InitInterface;
  self.ActiveControl := EditPwd;
  IsCancelChoseUnit := False; //�Ƿ�ȡ��ѡ��λ.
  FNetStart := False;

  bLoginClick := False;
  LoginCount := 0; 

  // ������ 2009.07.14  ����Ԥ�㵥λ�治���Ƽ��ܡ�
  // ������ 2010.03.15  ����ܲ�Ӧ���е�¼�������ơ�
  // if ((GszRelease = 'DEMO') or (GNotEncrypt = '1')) and 
  //if (GszRelease = 'DEMO') and (GszVersion <> 'SA') and (GszVersion <> 'DBGDS') then
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
  // ������ 2011.04.18 ��ʱֻ���Ƶ�¼ҵ�����ڣ�����ʾ��ʾ��������
  //DateTimePickerBusinessDate.MaxDate := TString.StrToDate('2011-06-30');

  // ��ʼ����¼��Ŀ�Ⱥ͸߶�
  Height := Height - PanelOptions.Height;
  PanelLogin.Height := PanelLogin.Height - PanelOptions.Height;
  PanelOptions.Height := PanelOptions.Height - PanelAppParam.Height;
  PanelOptions.Visible := False;
  PanelAppParam.Visible := False;

  // ��ע����ȡ��Ҫ�ĵ�¼��Ϣ
  PRegister := TRegistry.Create;
  PRegister.RootKey := HKEY_CURRENT_USER;

  // ������ 2010.10.11 ����Login�����ϵġ����߹�����ѡ��״̬���Ƿ����߹���ģʽ��¼��
  if PRegister.OpenKey('\SOFTWARE\UFGOV', True) and
     PRegister.ValueExists('UseOfflineMode') then
  begin
    CheckBoxUseOfflineMode.Checked := PRegister.ReadBool('UseOfflineMode');
  end
  else
    CheckBoxUseOfflineMode.Checked := False;

  // ������ 2009.4.7 ��ȡ UseSameLoginParams������ǰ̨ģ��ʹ����ͬ�ĵ�¼����������ֵ��
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

  // ȡ���һ�ε�¼���û��͵�¼���м�����ڵĻ���
  if PHostList.Count > 0 then
    szHost := PHostList.Strings[PHostList.Count - 1];
  if PUserList.Count > 0 then
    szUser := PUserList.Strings[PUserList.Count - 1];

  //  ��ʼ��
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

  // ������ 2009.11.27 ���µ�¼ʱ��ȡ����ǰ���ӵĶ˿ںš�
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
  //��ɽCA��¼
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
  // ������ 2010.11.12
  if (ModalResult = mrOK) then
  begin
    if GblOfflineMode then
    begin
      ShowMessage('*** ע�� ***' + #13#10#13#10 + 
                  '��ǰ�ǡ����߹���ģʽ�������ֹ����ܵ����Ʋ���ʹ�á������ʹ��ȫ�����ܣ����ԡ����߹���ģʽ�����µ�¼��' + #13#10#13#10 +
                  '���¡�ȷ������ť��ʼ���߹�����' + #13#10);

      // ������ 2011.06.20 "����"����ʾ"G��"����
      if (Pos('����', GProSeriesName) > 1) then
        Application.MainForm.Caption := GProSeriesName +
                            '  �����߹���ģʽ�� '
      else
        Application.MainForm.Caption := GProSeriesName +'('+GszEdition+')��' +
                            '  �����߹���ģʽ�� ';
    end
    else
    begin
      // ������ 2011.06.20 "����"����ʾ"G��"����
      if GNOJMVer_CusName<>'' then else begin
         if (Pos('����', GProSeriesName) > 1)  or (GszEdition='����') then
           Application.MainForm.Caption := GProSeriesName
         else
           Application.MainForm.Caption := GProSeriesName;// +'('+GszEdition+')��';
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
  // ������ 2009.02.23 ���ݼ��ܲ�Ʒ��Ȩ����ǰ̨�������ӵ����ݿ�����
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
  //ֻ������SQL���ݿ⣬����汾ΪB�汾
  if (UpperCase(GszEdition) = 'B') or (UpperCase(GszEdition) = '����') then
  begin
    ComboBoxDBType.ItemIndex := 0;
    ComboBoxDBType.Visible := False;
    lblDBTypeHint.Caption := 'SQL Server';
    lblDBTypeHint.Visible := True;
    ComboBoxDBTypeChange(ComboBoxDBType);
  end;

  ResImgReplace(Self);
  SetXPMenu(Self);
  //�ռ���
  //1����ֹ�û������м�㡢
  //2����ʾ���׹���ť��ͨ���ð�ť�������׹�����
  if GProSeries = 'S' then
  begin
    ComboBoxHost.Enabled := False;
    ComboBoxHost.Text := '127.0.0.1';
  end;
  Timer1.Enabled := False;

  // ������ 2010.12.10 ��ʱֻ�������ܻ�ƣ�����ʹ�����߹��ܡ�
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
      ButtonOptions.Caption := 'ѡ��(&P) >>';
      Height := Height - PanelOptions.Height;
    end
    else
    begin
      PanelOptions.Visible := True;
      ButtonOptions.Caption := 'ѡ��(&P) <<';
      Height := Height + PanelOptions.Height; //PanelLoginSet.Height +
    end;
  end
  else if GpsSeries = psR9 then
  begin
    if PanelOptions.Visible then
    begin
      PanelOptions.Visible := False;
      PanelLoginSet.Visible := False;
      ButtonOptions.Caption := 'ѡ��(&P) >>';
      Height := Height - PanelOptions.Height;
    end
    else
    begin
      PanelOptions.Visible := True;
      PanelLoginSet.Visible := True;
      ButtonOptions.Caption := 'ѡ��(&P) <<';
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

  // ������ 2010.05.11 ֻ�� ComboBoxUser �������¼��Ž����û���/�û�IDת����
  if (Sender = ComboBoxUser) then
  begin
    // ������ 2010.03.31 ֧�ֲ���ԱID��¼��
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
  // ������ 2010.03.31 ֧�ֲ���ԱID��¼��
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

  // ������ 2010.10.11 ʹ�����߹���ģʽ��¼
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
      // �ֶ�ģʽ

      // ����������� hch ������������
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
            //�������ʧ�ܣ���������
            DataModulePub.MidasConnectionPub.ServerName := 'R9i_AppSrvr.R9DMPooler';
            DataModulePub.MidasConnectionPub.ServerGUID := CServerGUID;
            //ADO����
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
      // �Զ�ģʽ
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
  //if GpsSeries = psR9 then//wx 2009-10-15��������֤��Ӧ������R9i��R9
  begin
    if RadioButtonHandApp.Checked and (GpsSeries = psR9i) then
    begin
      GDBType := GetDBType(True);//wx 2009-10-15 9i���м��ģʽ�����ݿ��ж�һ�����ݿ�����
    end else if RadioButtonAutoApp.Checked then//wx 2009-10-15 ֱ����ģʽ��дһ�±䶯
    begin
      if not WriteAppServerInfoToReg then
        Exit;
      WriteDBType(GDBType);

    end;

    try
      IniConnect;
    except
      if ShowLoginHint('�޷���Ӧ�÷������������ӣ�' + #13#10#13#10 +
        '���飺' + #13#10 +
        '    1��Ӧ�÷�������ַ�Ƿ���ȷ��' + #13#10 +
        '    2��Ӧ�÷������Ƿ�����������') = mrYes then
      begin
        PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
      end;
      Exit;
    end;
    if GpsSeries = psR9 then//2009-10-15��r9i����Ҫ����Ƿ�ѡ������
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
      if ShowLoginHint('�޷���Ӧ�÷������������ӣ�' + #13#10#13#10 +
        '���飺' + #13#10 +
        '    1��Ӧ�÷�������ַ�Ƿ���ȷ��' + #13#10 +
        '    2��Ӧ�÷������Ƿ�����������') = mrYes then
      begin
        PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
      end;
      Exit;
    end;
    if GpsSeries = psR9 then//2009-10-15��r9i����Ҫ����ѡ���������
    begin
      ReChangeDB;
    end;
  end;
  try
    ChangePassWord(true);
    EditPwd.Text := GCzy.Password; //���µ�½��������롣
  except
  end;
end;

function TFormLogin.GetReadSubKey(Reg: TRegistry; const RootKey, ExeName: string): string;
var
  i: Integer;
  sKey: string;
  ss: TStrings;
begin
  // ������ 2008.11.17 ���û���ҵ���ǰ����ר�ò�����������Ĭ�ϲ����
  Result := RootKey;
  if CheckBoxUseSameLoginParams.Checked then
    Exit;

  // ������ 2008.11.17 ���ҵ�ǰ����ר�õĲ�����
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

// ������ 2008.11.17

function TFormLogin.GetWriteSubKey(Reg: TRegistry; const RootKey, ExeName: string): string;
var
  i: Integer;
  sKey, sn: string;
  ss: TStrings;
begin
  // ������ 2008.11.17 ���û���ҵ���ǰ����ר�ò��������Ĭ�ϲ�������¼������µ�ר�ò����
  Result := RootKey;
  if CheckBoxUseSameLoginParams.Checked then
    Exit;

  // ������ 2008.11.17 ���ҵ�ǰ����ר�õĲ�����
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
  // ������ 2008.11.17 ���û���ҵ���ǰ����ר�ò��������Ĭ�ϲ�������¼������µ�ר�ò����
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
    SysMessage('���볤�ȱ���8λ���ϣ�����8λ��');
    Exit;
  end;
  case GblEncryType of
    1:begin  //��֤����һ�ֵĿ���
      if not (TCheckType.CheckCharType(EditPwd.Text,edCharTypeOne)
         or TCheckType.CheckCharType(EditPwd.Text,edCharTypeTwo)
         or TCheckType.CheckCharType(EditPwd.Text,edCharTypeThree)) then
      begin
        SysMessage('��������ĸ�����ֺ������ַ���ɡ���������������һ�����');
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
        SysMessage('��������ĸ�����ֺ������ַ���ɡ��������������ж������');
        Exit;
      end;
    end;
    3:begin
      if not (TCheckType.CheckCharType(EditPwd.Text,edCharTypeOne)
         and  TCheckType.CheckCharType(EditPwd.Text,edCharTypeTwo)
         and  TCheckType.CheckCharType(EditPwd.Text,edCharTypeThree)) then
      begin
        SysMessage('��������ĸ�����ֺ������ַ���ɡ����������������������');
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
  // ������ 2009.02.16 ֧��R9iʵ����ע�ᣬʹ�ü�����Ȩ��Ч�ڿ��Ƶ�¼ҵ�����ڡ�
  if (GiValidDate > 0) then begin
    iLoginDate := Trunc(DateTimePickerBusinessDate.Date);
    if (iLoginDate > GiValidDate) then begin
      Application.MessageBox(PChar('��¼ҵ�����ڣ�' + FormatDateTime('yyyy"��"m"��"d"��"', iLoginDate) + '��' +
        '�����ڼ��������Ч�ڣ�' + FormatDateTime('yyyy"��"m"��"d"��"', GiValidDate) + '��֮�ڡ�' + #13#10#13#10 +
        '����"ȷ��"��ť��������ѡ��ҵ�����ڡ�'),
        'ϵͳ��ʾ',MB_ICONInformation+MB_OK);

      DateTimePickerBusinessDate.SetFocus;
      Exit;
    end;

    if (iLoginDate >= GiValidDate - 30) then begin
       Application.MessageBox(PChar('��Ʒʹ�������Ȩ����' + FormatDateTime('yyyy"��"m"��"d"��"', GiValidDate) + '���ڣ�����ϵ�����Ӧ�̹�����ɷ���' + #13#10#13#10 +
        '����"ȷ��"��ť�������¼��'),'ϵͳ��ʾ',MB_ICONInformation+MB_OK);        
    end;
  end;

  // ������ 2010.10.11 ����Login�����ϵġ����߹�����ѡ��״̬���Ƿ����߹���ģʽ��¼��
  if PRegister.OpenKey('\SOFTWARE\UFGOV', True) then begin
    PRegister.WriteBool('UseOfflineMode', CheckBoxUseOfflineMode.Checked);
  end;  

  // ������ 2010.12.10 ��ʱֻ�������ܻ�ƣ�����ʹ�����߹��ܡ�
  //if (GProSign = 'GAL') or (GProSign = 'GL') then
  //     GblOfflineMode := CheckBoxUseOfflineMode.Checked
  //else
  GblOfflineMode := False;
  FbBtnOKClick := True;
  WriteAppServerInfoToReg;
  FbBtnOKClick := False;

  // huangch 2008.11.17 ���� UseSameLoginParams������ǰ̨ģ��ʹ����ͬ�ĵ�¼����������ֵ��
  if PRegister.OpenKey('\SOFTWARE\UFGOV', True) then begin
     PRegister.WriteBool('UseSameLoginParams', CheckBoxUseSameLoginParams.Checked);
  end;  

  // ������ 2010.10.11 ���߹���ģʽֻ��ʹ��MSSQL/MSDE���ݿ⡣
  if GblOfflineMode then
     GDBType := MSSQL;
  WriteDBType(GDBType);

  BlLoginOk := false;
  GbSysLoginOK := false;
  SetPanel(True);
  if PanelOptions.Visible then begin
    PanelOptions.Visible := False;
    ButtonOptions.Caption := 'ѡ��(&P) >>';
    Height := Height - PanelOptions.Height;
  end;
  update;
  ShowLogin;

  ShowLogin;
  if bLoginClick then
    goto LoginFailure; // ��ֹ�ظ����½��ɴ���,Lzn 2005.10.11
  update;
  if ButtonOK.Parent.Visible and ButtonOK.Visible and ButtonOK.Enabled then
    ButtonOK.SetFocus;
  if Length(Trim(SMaskEditPort.Text)) = 0 then
  begin
    SysMessage('�����ö˿ںš�');
    goto LoginFailure;
    if (self.Active) and (PanelOptions.Visible) and SMaskEditPort.Enabled then
       SMaskEditPort.SetFocus;
  end;
  ShowLogin;
  try
    IniConnect;
  except
    // ������ 2010.10.11 ���߹���ģʽ��¼
    if GblOfflineMode then
    begin
      SysMessage('�޷�ʹ�����߹���ģʽ��' + #13#10#13#10 +'����ͨ���Ż���ҳ��װ�����߹�����������');
    end
    else
    begin
      if RadioButtonHandApp.Checked then
      begin
        if ShowLoginHint('�޷���Ӧ�÷������������ӣ�' + #13#10#13#10 +
          '���飺' + #13#10 +
          '    1��Ӧ�÷�������ַ�Ƿ���ȷ��' + #13#10 +
          '    2��Ӧ�÷������Ƿ�����������') = mrYes then
        begin
          PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
        end;
      end
      else
      begin
        if ShowLoginHint('�޷������ݿ⽨�����ӣ�' + #13#10#13#10 +
          '���飺' + #13#10 +
          '    1�����ݿ��ַ�Ƿ���ȷ��' + #13#10 +
          '    2�����ݿ��Ƿ�����������' + #13#10 +
          '    3�����ݿ����Ƿ���ȷ��') = mrYes then
        begin
          PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
        end;
      end;
    end;
    SetPanel(False);
    Exit;
  end;

  // ������ 2010.03.31 ֧�ֲ���ԱID��¼��
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
  
  try   // �����м��
    if not DataModulePub.MidasConnectionPub.Connected then
       DataModulePub.MidasConnectionPub.Connected := True;

    //hch ����SQL������ַ�ʽ
    if (GpsSeries = psR9) then
    begin
      try
        ReChangeDB
      except
        on e: exception do
        begin
          raise Exception.Create('�������ݿ�ʧ��! ' + e.Message);
        end;
      end;
      //��ȡ���׺ź͵�λ����
      if CdsLogin.active then
      begin
        if CdsLogin.Locate('dbname', GszDBNAME, []) then
        begin
          GszGSDM := CdsLogin.FieldByName('dwdm').AsString;
          GszZTH := CdsLogin.FieldByName('zth').AsString;
          GszZTMC := CdsLogin.FieldByName('ztmc').AsString;
          GszHSDWDM := GszGSDM;
          GszHSDWMC := CdsLogin.FieldByName('dwmc').AsString;
          //2009.3.19 hy ������Ĭ�ϸ�GszHZGSDM��GszHZZTH��ֵ
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
      // ������ 2010.10.11 ���߹���ģʽ��¼
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
                SysMessage('���ݿ�����ʧ�ܣ�'+#13+E.Message);
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
      SysMessage('��ѡ���˾ɰ汾���ף���ʹ����Ӧ�ĺ�̨���ݹ����߶��������'
        + #13#10 + '������ʹ���������߽������������°汾����ʹ�ñ����ߡ�');
      SetPanel(False);
      Exit;
    end;

    GDBType := GetDBType(True);

    // ������ 2009.06.05 ���д�������� GetDBType(True) ֮��ִ�С�
    // ������ 2009.02.23 ���ݼ��ܲ�Ʒ��Ȩ����ǰ̨�������ӵ����ݿ����͡�
    if GAnyiLicenseInfo.IsConnected then // (GszRelease <> 'DEMO') then
    begin
      if UpperCase(GszDBOS) = 'MSSQL' then
      begin
        if GDBType = ORACLE then
        begin
          if GpsSeries = psR9i then
            Application.MessageBox(pChar('���ʹ�����ֻ������ SQL Server ���ݿ⡣' + #13#10#13#10 +
              '���ʹ���Զ�ģʽ��¼��������ѡ�����ݿ����͡���' + #13#10 +
              '���ʹ���ֹ�ģʽ��¼�����޸�Ӧ�÷����������ݿ����Ӳ�����'),
              'ϵͳ��ʾ',MB_ICONInformation+MB_OK)
          else
            Application.MessageBox(pchar('���ʹ�����ֻ������ SQL Server ���ݿ⡣' + #13#10#13#10 +
              '������ѡ�����ݿ����͡���'),'ϵͳ��ʾ',MB_ICONInformation+MB_OK);
          SetPanel(False);
          Exit;
        end;
      end
      else if UpperCase(GszDBOS) = 'ORACLE' then
      begin
        if GDBType = MSSQL then
        begin
          if GpsSeries = psr9i then
            Application.MessageBox(pchar('���ʹ�����ֻ������ Oracle ���ݿ⡣' + #13#10#13#10 +
              '���ʹ���Զ�ģʽ��¼��������ѡ�����ݿ����͡���' + #13#10 +
              '���ʹ���ֹ�ģʽ��¼�����޸�Ӧ�÷����������ݿ����Ӳ�����'),'ϵͳ��ʾ',MB_ICONInformation+MB_OK)
                          
          else
            Application.MessageBox(pchar('���ʹ�����ֻ������ Oracle ���ݿ⡣'),'ϵͳ��ʾ',MB_ICONInformation+MB_OK);
          SetPanel(False);
          Exit;
        end;
      end;
    end;
  except
    if GblOfflineMode then
    begin
      SysMessage('�޷���������ģʽ�������Ƿ�װ�����߻���������ֱ�ӵ�¼Զ�̷�������');
      CheckBoxUseOfflineMode.Checked := False;
      CheckBoxUseOfflineModeClick(nil);
    end else
    begin
      if ShowLoginHint('�޷������ݿ⽨�����ӣ�' + #13#10#13#10 +
        '���飺' + #13#10 +
        '    1�����ݿ��ַ�Ƿ���ȷ��' + #13#10 +
        '    2�����ݿ��Ƿ�����������' + #13#10 +
        '    3�����ݿ����Ƿ���ȷ��') = mrYes then
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
    zhengjy 2014-10-11 ����������������汾����ȡ��ȫ��������
  }
  ReadSafeParam;
  //zhengjy 2014-10-11 ����������������汾������ǰ��̨�ı��ļ��ܲ���
  if GblMessageEncry=1 then
    HttpFile.HTTPEncrypted :=true;  //û���°����޷����ã���ʱ����
  //���¸�ֵȫ�ֱ���
  if GDbType = Oracle then begin  //�����Ƶ���¼ǰ�ı�����ʼ����  999
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
  //hch �Ƿ��¼��־
  GbUseLog := TLog.IsRecordLog;

  // �������Ƿ���ܻ��Ƿ��������   //GCzyMMCanJM := true;
  with DataModulePub do begin
    // ������ 2011.08.23 Ϊ����ǰ��̨������������ߵ�¼�ٶȣ��������η���gl_czy�Ĵ���ϲ�����
    //begin jm--
    (*if GCzyMMCanJM then begin
    try
      GCzyMMJM := false;
      SQL_TEMP := 'select id,name,password from gl_czy where name =''ϵͳ����'' ';
      POpenSql(ClientDataSetTmp, SQL_TEMP);

      //if ClientDataSetTmp.FindFirst then begin
      //  if VertifyCZYMM('', 'ϵͳ����', ClientDataSetTmp.FieldByName('password').asString) then
      TAnyiCoder.Decode(ClientDataSetTmp.FieldByName('password').AsString,sKeyPass,bSucceed);
      if bsucceed then
         GCzyMMJM := true;

    except
      on E: Exception do begin
        // ������ 2008.06.03
        TLog.WriteErr('[1]������ʱ����������󡣴�����Ϣ��' + #13#10 + E.Message);
        SysMessage('������ʱ������������������ݿ�������Ƿ�����������');
        SetPanel(False);
        Exit;
      end;
    end;
    end; //end jm-- *)

    try // �������Ƿ���ȷ
      if iUID > 0 then
      begin
        SQL_TEMP := 'select * from gl_czy ' + //�Ƕ������Ա
                    ' where (((Upper(ID)='+IntToStr(iUID)+') or (Upper(czyCode)='''+AnsiUpperCase(sCZYCode)+'''))'+
                    '  and (type = ''1''))' +  //and (syzt <> ''2'')
                    '  or (name = ''ϵͳ����'')' +
                    ' order by ID';
      end else if sCZYCode<>'' then begin  //����Ա���뷽ʽ��¼
        SQL_TEMP := 'select * from gl_czy ' +
                    ' where ((Upper(czyCode) = ''' + AnsiUpperCase(sCZYCode) + ''')' +
                    '  and (type = ''1'') )'+     //and (syzt <> ''2'')
                    '  or (name = ''ϵͳ����'')';
      end else begin
        SQL_TEMP := 'select * from gl_czy ' + //�Ƕ������Ա
                    ' where ((Upper(name) = ''' + AnsiUpperCase(ComboBoxUser.Text) + ''')' +
                    '  and (type = ''1'') )' +         //and (syzt <> ''2'')
                    '  or (name = ''ϵͳ����'')' +
                    ' order by ID';
      end;
      POpenSql(ClientDataSetTmp, SQL_TEMP);

      // ����'ϵͳ����'��¼�С�
      if (ClientDataSetTmp.FieldByName('ID').AsString = '0') then
      begin
        ClientDataSetTmp.FindNext;
      end;

      // ������ 2010.05.25 ����ж�����������Ĳ���Ա�������Ի������û�ѡ��
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
            SQL_TEMP := 'select * from gl_czy ' + //�Ƕ������Ա
                        ' where (Upper(ID) = ' + sCZYID + ')' +
                        '  and (type = ''1'') and (syzt <> ''2'')';
            POpenSql(ClientDataSetTmp, SQL_TEMP);
          end else
          begin
            SysMessage('��ȡ���˵�¼������');
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
        // ������ 2008.06.03
        TLog.WriteErr('[2]������ʱ����������󡣴�����Ϣ��' + #13#10 + E.Message);
        SysMessage('������ʱ������������������ݿ�������Ƿ�����������');
        SetPanel(False);
        Exit;
      end;
    end;
    ShowLogin;

    GCzy.bCA := False;
    if not ClientDataSetTmp.Eof then begin 
      if ClientDataSetTmp.FieldByName('SYZT').AsString = '2' then

      begin
        SysMessage('��ǰ�û��Ѷ��ᣬ������ѡ������롣');
        SetPanel(False);
        ComboBoxUser.SetFocus;
        Exit;      
      end;
      tmpPassCode := Trim(ClientDataSetTmp.FieldByName('password').asString);
      tmpID := Trim(ClientDataSetTmp.FieldByName('id').asString);
      tmpCZY := ClientDataSetTmp.FieldByName('name').asString;
      sgsdmtemp := ClientDataSetTmp.FieldByName('gsdm').asString;
      GCzy.sCzyGsdm := sGsdmTemp;

      sDecode := TAnyiCoder.Decode(tmpPassCode,sKeyPass,bSucceed); //���Խ���
      GCzyMMJM := bsucceed;   //�����Ƿ�ɹ����ɹ����ʾ�����������

      //zhengjy 2014-10-11 ����������������汾������״̬��¼
      if ((GblReLogin=1) or (GblInputCount>0))  then
        TControlLogin.addOperState(tmpID);

      //zhengjy 2014-10-11 ����������������汾����֤�û��Ƿ��Ѿ���½
      if (GblReLogin=1) and (tmpID<>'1')
         and (FReloginCzyID<>tmpID) then  //���������������µ�½ʱ����������֤
      begin
        case  TControlLogin.GetOperState(tmpID) of
          2 :begin
            SysMessage('�û��Ѿ���½���������ظ���½������ϵͳ����Ա��ϵ��');
            SetPanel(False);
            EditPwd.SetFocus;
            exit;
          end;
        end;
      end;
      //zhengjy 2014-10-11 ����������������汾���ж��Ƿ�����
      if  GblInputCount>0 then
      begin
        if TControlLogin.IsLockOper(tmpID)=1 then
        begin
          SysMessage('�û��Ѿ���������"'+IntToStr(GblLimitTime)+'"���Ӻ��Զ�����������ϵͳ����Ա��ϵ����');
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

        //zhengjy 2014-10-11 ����������������汾������"�����������"��"�û���½����"���Ӧ���û�״̬��ѯ���棬ֻ��ϵͳ����Ա��ʹ�ô˹���
        if ((GblInputCount>0) or (GblReLogin=1)) and (GCzy.ID=1) then FormMain.mniUserState.Visible :=true
        else FormMain.mniUserState.Visible :=false;

        if LoginKeyIntf.LoginKeyCanWriteHS then begin
          if (ClientDataSetTmp.FindField('CaKeyFixdUSer') <> nil) and bHSCAKey and (ClientDataSetTmp.FieldByName('CaKeyFixdUSer').AsString = '1') then begin  //��ɽCA����Ҫǰ̨��¼ʱ���ƣ���Ҫ���Ż����Ƽ���
             sHSCZY := LoginKeyIntf.ReadUserKEY_CA(False);
             if Trim(sHSCZY)='' then begin
                SysMessage('��ǰ��¼�û���'+GCzy.Name+' �Ѱ�CA֤���¼����������Լ���CA֤���ٵ�¼');
                SetPanel(False);
                Exit;
             end;
             if Pos(GCzy.name+';',sHSCZY)<=0 then begin
                SysMessage('��¼���ܣ���ǰ�û�:'+GCzy.Name+'����CA�ĵ�¼�û���һ�¡�'+#13#10+'��������Լ���CA֤���ٵ�¼');
                SetPanel(False);
                Exit;
             end;
          end   
        end else
        // ������ 2009.06.16 ���´������Ƿ���Ҫ��¼������¼U�ܣ����ܵ�¼��
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
                Pub_Message.SysMessage('��¼���ܾ���' + #13#10 + #13#10 +
                           '��ǰ�û���' + GCzy.name + '����U�ܵĵ�¼�û���' + gLoginKey.UserName + '����һ�¡�' +#13#10 +
                           '��������Լ���U�����µ�¼��', 'Login_01_JG', [mbOK]);
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
                Pub_Message.SysMessage('������ʹ�õ�¼U�ܲ��ܽ���ϵͳ�������U�ܺ����µ�¼��' + #13#10 + #13#10 +
                                       '������Ϣ:  ' + LoginKeyIntf.GetLastError, 'Login_01_JG', [mbOK]);
                SetPanel(False);
                EditPwd.SetFocus;
                Exit;
              end;
            end;
          except
          end;
        // ������ 2009.06.16 ���ϼ���Ƿ���Ҫ��¼������¼U�ܣ����ܵ�¼��
        //Lzn 2011.07.01 ���ϼ���Ƿ���ҪCA-KEY����¼CA_key�����ܵ�¼�� -- {(ParamCount<12) and} �Ż��ѽ�����CA��֤�����ͻ��˻�Ҫ��֤�£���Ҫ�����Ż���������pin��������֤��
        //chengjf 20150331����or (LoginKeyIntf.LoginKeyCanWriteGE)������������Ϻ����CA�����Ż������ֱ�ӽ��붼Ҫ���CA
        end else if ((ParamCount<10) or (LoginKeyIntf.LoginKeyCanWriteGE))and(ClientDataSetTmp.FindField('LoginCaKeyEnabled')<> nil) and (ClientDataSetTmp.FieldByName('LoginCaKeyEnabled').AsString = '1') then begin  //and (ClientDataSetTmp.FindField('LoginCaKeyPIn')<> nil)
          //  Pub_Message.SysMessage('������ʹ��CA֤����ܽ���ϵͳ�������CA֤������µ�¼��' + #13#10 + #13#10 +
          //                         '������Ϣ�������豸���ͻ��豸��ʼ��ʧ�ܡ�' ,'Login_01_JG', [mbOK]);
          GCzy.bCA := True;
          //10.3�������˶�CA�ļ�����Ȩ��ShowCustomerInfo����ȡ�� Modified by chengjf 2016-07-08
          //if FormBackGround.ShowCustomerInfo then //add by wangxin 2014-12-05 �Ƿ�ȡ���ͻ���Ϣ���ж��Ƿ�ʹ��ca
          begin
            sKey := LoginKeyIntf.ReadUserKEY_CA; //'abcde'; ShowMessage('1:'+skey);
            if sKey='' then begin
               Pub_Message.SysMessage('������ʹ��CA֤����ܽ���ϵͳ�������CA֤������µ�¼��' + #13#10 + #13#10 +
                                      '������Ϣ�������豸���ͻ��豸��ʼ��ʧ�ܡ�' ,'Login_01_JG', [mbOK]);
               Exit;
            end;












            if (ClientDataSetTmp.FindField('CaKeyFixdUSer')<> nil) and (ClientDataSetTmp.FindField('CaKeyFixdXH')<> nil) and (ClientDataSetTmp.FieldByName('CaKeyFixdUSer').AsString = '1') then begin
               if Trim(ClientDataSetTmp.FieldByName('CaKeyFixdXH').AsString)='' then begin
                  Pub_Message.SysMessage('û�����ð󶨵�CA֤�顣','Login_01_JG', [mbOK]);
                  Exit;
               end;
               if Trim(ClientDataSetTmp.FieldByName('CaKeyFixdXH').AsString)<>sKey then begin
                  Pub_Message.SysMessage('��ǰ����Աδ�뵱ǰCA֤����а󶨣���������Լ���CA֤������µ�¼��','Login_01_JG', [mbOK]);
                  SetPanel(False);
                  EditPwd.SetFocus;
                  Exit;
               end;
            end;

            POpenSql(DataModulePub.ClientDataSetPub, 'Select * from gl_czy where type=''1'' and id<>' + IntToStr(GCzy.id) +' and CaKeyFixdUSer=''1'' and CaKeyFixdXH='''+sKey+'''');
            if DataModulePub.ClientDataSetPub.RecordCount>0 then begin  //û�������˰�
               Pub_Message.SysMessage('CA֤����֤δͨ��!' + #13#10 + #13#10 +
                           '��ʹ�������Լ��󶨵�CA֤�顣', 'Login_01_JG', [mbOK]);
               SetPanel(False);
               EditPwd.SetFocus;
               Exit;
            end;

            try
              if GbCaPinLogin then begin                //ShowMessage('pin������'+GsPin);
                  gLoginKey.iReadType := LoginKeyIntf.ReadUserInfo_CA(Trim(GsPin));
              end
              else gLoginKey.iReadType := LoginKeyIntf.ReadUserInfo_CA('');























              case gLoginKey.iReadType of
                 7:begin
                     Pub_Message.SysMessage('CA֤���ѹ��ڡ�','Login_01_JG', [mbOK]);
                     SetPanel(False);
                     EditPwd.SetFocus;
                     Exit;
                   end;
               0,1:begin
                     Pub_Message.SysMessage('������ʹ��CA֤����ܽ���ϵͳ�������CA֤������µ�¼��' + #13#10 + #13#10 +
                                             '������Ϣ�������豸���ͻ��豸��ʼ��ʧ�ܡ�' ,'Login_01_JG', [mbOK]);
                     SetPanel(False);
                     EditPwd.SetFocus;
                     Exit;
                   end;
                 8:begin  //��֤δ�ɹ�
                     Pub_Message.SysMessage('CA֤����֤δͨ��!' + #13#10 + #13#10 +
                              '������û�м���CA��֤���ļ�"CA_CERT.cer"������Ŀ¼'+#13#10 +
                              '������û�в������Լ���CA֤�顣', 'Login_01_JG', [mbOK]);
                     SetPanel(False);
                     EditPwd.SetFocus;
                     Exit;
                   end;
                 9:begin     //���������ʾ����¼�롣��û��ʾ��������
                     SetPanel(False);
                     EditPwd.SetFocus;
                     Exit;
                   end;

                10:begin
                     //��֤ͨ��
                     GCzy.bCA := True;
                   end;

                (*11:begin  //��֤ͨ��
                     if (sPinPass<>'') and (sPinPass<>ClientDataSetTmp.FieldbyName('LoginCaKeyPIn').AsString) then begin
                        //��ʾPIN����������¼�룬�����ݿⱣ���PIN��һ�£���Ҫ�������ݿ�
                        try
                          PExecSQL('update gl_czy set LoginCaKeyPIn='''+sPinPass+''' where id='+ClientDataSetTmp.FieldbyName('id').AsString);
                        except
                        end;
                     end;
                   end; *)

                 else begin
                    Pub_Message.SysMessage('CA֤����֤δͨ��!' + #13#10 + #13#10 +
                                           '��ʹ�����Լ���CA֤�顣', 'Login_01_JG', [mbOK]);
                    SetPanel(False);
                    EditPwd.SetFocus;
                    Exit;
                 end;
              end;
            except
              Pub_Message.SysMessage('CA֤����֤ʧ�ܡ�','Login_01_JG', [mbOK]);
              SetPanel(False);
              EditPwd.SetFocus;
              Exit;
            end;
          end;
          //10.3�������˶�CA�ļ�����Ȩ��ShowCustomerInfo����ȡ�� Modified by chengjf 2016-07-08
//          else
//          begin
//            Pub_Message.SysMessage('CA�û���Ϣ��ʼ��ʧ��,���������Ӧ����ϵ��' ,'Login_01_JG', [mbOK]);
//            Exit;
//          end;

        end;
        // lzn 2011.07.01 ���ϼ���Ƿ���ҪCA-KEY����¼CA_key�����ܵ�¼��
        (*if ParamCount>10 then begin //����Χ����
           if ClientDataSetTmp.FieldByName('LoginPTEnabled').AsString<>'1' then begin
              SysMessage('��ǰ�û�������ֻ��ͨ��ƽ̨�Ż���¼��');
              SetPanel(False);
              EditPwd.SetFocus;
              Exit;
           end;
        end;  *)
        if (ParamCount<10) and(ClientDataSetTmp.FieldByName('LoginPTEnabled').AsString='1') then begin
            SysMessage('��ǰ�û�������ֻ��ͨ��ƽ̨�Ż���¼��');
            SetPanel(False);
            EditPwd.SetFocus;
            Exit;
        end;
        if (ParamCount>10) and GbAgainLogin and (ClientDataSetTmp.FieldByName('LoginPTEnabled').AsString='1') then begin
            SysMessage('��ǰ�û�������ֻ��ͨ��ƽ̨�Ż���¼��');
            SetPanel(False);
            EditPwd.SetFocus;
            Exit;
        end;
      end
      else
      begin
        //SysMessage('��¼�û����������󣬻���û������ᣬ������ѡ������롣');
        SysMessage('�û��������������ѡ������롣');

        {
          zhengjy 2014-10-11 ����������������汾����������������Ӽ���
        }
        if (GblInputCount>0) then
        begin
          TControlLogin.LockOperProcess(tmpID);
          if TControlLogin.IsLockOper(tmpID)=1 then
          begin
            SysMessage('�û��Ѿ���������"'+IntToStr(GblLimitTime)+'"���Ӻ��Զ�����������ϵͳ����Ա��ϵ����');
          end;
        end;

        SetPanel(False);
        EditPwd.SetFocus;
        Exit;
      end;
    end
    else
    begin
      //SysMessage('��¼�û����������󣬻���û������ᣬ������ѡ������롣');
      SysMessage('��ǰ�û������ڣ�������ѡ������롣');
      SetPanel(False);
      ComboBoxUser.SetFocus;
      Exit;
    end;
  end;
  DoSaveUser;//add by wangxin 2015-08-17 ��¼��֤ͨ����������

  //zhengjy 20140717 ������������ʽͨѶ
  Main.SetR9PacketsCDS;

  ShowLogin;
  //����ǰExe���ļ��汾��sysControlVersion�����ݿ�汾���бȽϣ���� ��汾�Ų��죬����ʾ
  szAppVersion := GetProgramInfo(application.exename, 'FileVersion');
  ShowLogin;
  //�����½�м����Ϣ
  GszServerComputer := ComboBoxHost.Text;
  GszServerPort := SMaskEditPort.Text;
  GszConType := cbConType.Text;

  GblTYLZT := False;
  GblXZSYLZT := True;
  ShowLogin;
  GszLanguage := '����';

{$IFNDEF ocx}
    if ((GszHSDWDM = '') or (GszHSDWDM <> CSysDWDM)) and (not FNetStart) then {// ����ֱ�Ӵ�����������ֱ��ͨ����������} 
    if PRegister.OpenKey(RegLoginPath, True) then begin
      GszHSDWDM := PRegister.ReadString('Dwdm');
      GszHSDWMC := PRegister.ReadString('Dwmc');
      GszGSDM := GszHSDWDM;//2010.1.7 hy �麣ȫ��Ԥ��֧�ֿ�������
      GszZth := PRegister.ReadString('Ztbh');
      GszZTMC := PRegister.ReadString('Ztmc');
      PRegister.CloseKey;
    end;
{$ENDIF}

  // 2007-7-9 16:49 hch ��ȡ������
  //GszKJND := Copy(GszYWRQ, 1, 4);
  //2009.12.9 hy ԭ��ֱ��ʹ��ҵ�����ڵõ������ȣ���֧�ֿ���ȵ����ף�
  //���ڸ�Ϊ��ȡ��ǰ���׵Ļ����ȣ����û�У��ٴ�ҵ�����ڵõ�������
  GProSign := 'SYS';         //ά����ZWR900314014 ָ����Ʒ��ʶΪsys�����ĵ�λ�����µ�¼ʱ�õ� chengjf 20151228
  GszYWRQ := PGetPickerDate(DateTimePickerBusinessDate);
  GszKJND := PGetKjnd(GszYWRQ);
  if GszKJND = '' then
     GszKJND := Copy(GszYWRQ, 1, 4);

  ShowLogin;


  //zhengjy 20161213 ��ʼ����дǩ��������
  KeyFactroy :=GetKeyFactory;
  //zhengjy 20161226 �������ݿ���ܿ��Ʋ˵���ʾ
  FormBackGround.GetCustomerCaption; //��ü��ܵ���ʾ����
  FormBackGround.DealSignCertMenu;  //Ԥ����дǩ�ֲ˵���������� GetCustomerCaption֮��ShowCustomerInfo֮��
  FormBackGround.ShowCustomerInfo;   //������ʾ��

  with DataModulePub do
  begin
    //zhengjy ֣��ӥ 2008-7-1 begin ����Ԥ�����ȵ�ʱ�������
    if (GszVersion = 'DBGFS') or (GszVersion = 'DBGDS') then
    begin
    end else
    begin
    //zhengjy ֣��ӥ 2008-7-1 end ����Ԥ�����ȵ�ʱ�������

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
              SysMessage('��鵥λ��Ϣʧ�ܡ�' + #13#10 + E.Message);
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
              SysMessage('�õ�λ�Ѿ�������,�������¼��');
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
            SysMessage('��鵥λ��Ϣʧ�ܡ�');
            SetPanel(False);
            Exit;
          end;

          if ClientDataSetTmp.RecordCount = 0 then begin
            SysMessage('���������Ϣʧ��, ԭ�����£�' + #13#10
              + '1. ��ȷ����������Ϣ���еĵ�λ�����Ƿ������ݿ���һ�¡�'
              + #13#10 + '2. ��ȷ���Ƿ��б�������ݣ����û���������������ݳ�ʼ����');
            SetPanel(False);
            Exit;
           (*
            //ȥ��һ���Լ�飬�ĳɴ����ݿ���ȡ��˾���룬���׺ŵȲ���
            try
              SQL_TEMP := 'select * from GL_ZTCS where kjnd=''' + GszKJND + ''' and HSDWDM<>''' + CSysDWDM + ''' and ztbh<>'''+CSysZTH+''' and ' + PSJQX('G', 'HSDWDM');
              POpenSql(ClientDataSetTmp, SQL_TEMP);
            except
              SysMessage('��鵥λ��Ϣʧ�ܡ�');
              SetPanel(False);
              Exit;
            end;
            if ClientDataSetTmp.RecordCount <> 0 then begin
              GszGSDM := ClientDataSetTmp.FieldByName('hsdwdm').AsString;
              GszZTH := ClientDataSetTmp.FieldByName('ztbh').AsString;
              GszZTMC := ClientDataSetTmp.FieldByName('ztmc').AsString;
              GszHSDWDM := GszGSDM;
              GszHSDWMC := ClientDataSetTmp.FieldByName('hsdwmc').AsString;
              //2009.3.19 hy ������Ĭ�ϸ�GszHZGSDM��GszHZZTH��ֵ
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
              SysMessage('���������Ϣʧ��, ԭ�����£�' + #13#10+
                       ' ��ȷ���Ƿ��б�������ݣ����û���������������ݳ�ʼ����'+#13#10+'��ȷ�����Ƿ�����ص�λ������Ȩ��');
              SetPanel(False);
              Exit;
            end;  *)
          end else begin
            GszHSDWMC := ClientDataSetTmp.FieldByName('HSDWMC').asString;
          end;
        end;
      end;
    end;

    if Trim(GszZTH) <> '' then //�Ż������Ϊ�ո�
    begin
      try
        SQL_TEMP := 'select * from gl_ztcs where kjnd=''' + GszKJND + ''' and hsdwdm=''' + GszHSDWDM + ''' and ztbh=''' + GszZTH + ''' and ' +
          PSJQX('ZT', 'ztbh');
        POpenSql(ClientDataSetTmp, SQL_TEMP);
      except
        SysMessage('���������Ϣʧ�ܡ�');
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
              SysMessage('���������Ϣʧ��, ԭ�����£�' + #13#10+
                       ' ��ȷ���Ƿ��б�������ݣ����û���������������ݳ�ʼ����'+#13#10+'��ȷ�����Ƿ���������׵�����Ȩ��');
              SetPanel(False);
              Exit;
            end;  *)
          SysMessage('���������Ϣʧ��, ԭ�����£�' + #13#10
            + '1. ��ȷ����������Ϣ����еĵ�λ�����Ƿ������ݿ�һ�¡�'
            + #13#10 + '2. ��ȷ���Ƿ��б�������ݣ����û���������������ݳ�ʼ����');
          SetPanel(False);
          Exit;
        end;
      end
      else
        GszZTMC := ClientDataSetTmp.FieldByName('ztmc').asString;
    end else
    begin
      //FUXJȥ��ԭ��Login.pas��SpeedButtonOKClick�������õ� PInitZTCS
      //�ͷ���Main��InitAccount �����е��õ� PInitZTCS
      SQL_TEMP := 'select * from gl_ztcs where hsdwdm=''' + CSysDWDM + ''' and ztbh=''' + CSysZTH + ''' and kjnd=''' + GszKJND + ''' ';
      POpenSql(DataModulePub.ClientDataSetTmp, SQL_TEMP);
    end;

    GszGSFJ := DataModulePub.ClientDataSetTmp.FieldByName('gsbmfa').asstring;
    //hch DLSI ��ȡÿҳ������
    GiPagePerNum := StrToIntDef(DataModulePub.ClientDataSetTmp.FieldByName('bmbmfa').AsString, 500);  // 2007-8-27 19:50 hch ��ʼ��GsProductSign
  end;

  ShowLogin;  //ShowMessage('GszVersion='+GszVersion+' GszHSDWDM='+GszHSDWDM+' GProSign='+GProSign);

 //zhengjy 2013-06-03 ���Ӵ󸽼��ĳ�ʼ������
  if RadioButtonAutoApp.Checked then
    InitFileOperParam('SOCKET',ComboBoxDBType.Text+';'+
      EditServerName.Text+';'+EditDatabaseName.Text+
      EditUserName.Text+';'+EditPassword.Text,GCzy.CzyCode,GCzy.name)
  else begin
    InitFileOperParam('HTTP',ComboBoxHost.Text,GCzy.CzyCode,GCzy.name);
    InitDataTransferParam('HTTP',ComboBoxHost.Text);
  end;

   //��λ��ϢΪ��, ��Ҫѡ��λ.  DDSL
  if (not IsCancelChoseUnit) and ((Trim(GszHSDWDM)='') or (GszHSDWDM=CSysDWDM)) then begin //����ǳ�����õģ����Ӳ�Ʒ���ж�����һ�������� //and (GProSign <> 'CIM') and (GProSign <> 'IDA') and (GProSign <> 'GE') and (GProSign <> 'BKA') and (GProSign <> 'SA') and (GProSign <> 'BEM') and (GProSign='SYS')
    //zhangwh20120810 begin �ⲿ�����Զ���¼ϵͳ����ģ�鹦��ʱ���������õ�λ��������Ϣ
    if (Pos('SA',GszModelName)<1) then begin  //zhangwh20120823 (UpperCase(Copy(GsParamGNFLMC,1,2))<>'SA')
      Application.CreateForm(TFormSetGS, FormSetGS);    //��Щע����ﵥλ�����дΪ999999����ʱҲӦ��Ҫ�����õ�λ
      if FormSetGS.ShowModal = mrOK then begin
        GszGSDM := FormSetGS.GSDM;
        GszHSDWDM := FormSetGS.GSDM;
        GszHSDWMC := FormSetGS.GSMC;
        GszZth := FormSetGS.ZTH;
        GszZTMC := FormSetGS.ZTMC;
        GszYWRQ := FormSetGS.YWRQ;
	    	//20150120 houy �����Ż���½ʱ����λΪ�պ�������ò���ȥ
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
      
  (* //��λ��ϢΪ��, ��Ҫѡ��λ.
  if (not IsCancelChoseUnit) and ((Trim(GszHSDWDM)='') or (GszHSDWDM=CSysDWDM)) then //����ǳ�����õģ����Ӳ�Ʒ���ж�����һ�������� //and (GProSign <> 'CIM') and (GProSign <> 'IDA') and (GProSign <> 'GE') and (GProSign <> 'BKA') and (GProSign <> 'SA') and (GProSign <> 'BEM') and (GProSign='SYS')
  begin
    //hch �����λ����Ϊ�գ� ����Ҫѡ��λ
    if DataModulePub.GetCountBySQL('Select 1 from pubgszl')>0 then
    begin
      Application.CreateForm(TFormSetGS, FormSetGS);    //��Щע����ﵥλ�����дΪ999999����ʱҲӦ��Ҫ�����õ�λ
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
     SysMessage('��û���������׺ţ�һЩģ�齫�޷�����ʹ�ã����¼����������á�');//,'_JG',[mbok]); //SetPanel(False); EditPwd.SetFocus; Exit;
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
    zhengjy 2014-10-11 ����������������汾����������������Ӽ���
  }
  //ע�͵��������Ƶ�¼Ҳ��¼��¼ʱ��  chengf 20150408
//  if GblReLogin=1 then
  begin
    TControlLogin.SetOperLogin(tmpID);
  end;
  ShowLogin;

  //һ�����µ�¼���л���λʱ��ÿ��ģ��Ҫ���³�ʼ��
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
  begin    // Added by miaopf 2008-4-22 11:18:34 ȡ��,�����л���λ���ɹ�    //BlLoginOk := False;
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
  //hch ��ȡ�Զ�ģʽ���ݿ�������Ϣ
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
  // ������ 2008.07.22
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

   UserName=[1]    //�Ż�����
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
      // ������ 2010.05.26 UserName�п��ܴ��û���Ҳ�����ǲ���ԱID�������Ƿ��з������жϡ�
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

      //hch 2009.3.17 ͨ���������ô���İ�������ܴ���� password
      sPassword := TString.DecryptSTR(Params.Values['Password']);
      //hch 2010.1.21 �ⲿϵͳ���ô��밴���Ĵ���� password
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
    if szHSDWDMParam='' then  //�Ż�����ĵ�λ�����ǿո� ' '
    begin
      SysMessage('��������������Ҫ�Ĳ�����Ϣ', 'AOther_YB', [mbOk]);
      Application.Terminate;
      Exit;
    end;
    //Զ�̷���ֱ�����ֶ�ģʽ����
    //if GIsNetVersion then    begin
    if sConnectionType = 'AUTO' then
    begin
      FormLogin.RadioButtonAutoApp.Checked := True;
      FormLogin.RadioButtonAutoAppClick(nil);
      //��ȡ���ݿ��������Ϣ
      //GDbType
      ExtractParams;
      //hch 2009-06-17 ���
      if length(OtherParams)>2 then
      begin
        bOtherParamsLogin := True;
        FormLogin.cbxZT.ItemIndex := FormLogin.cbxZT.Items.IndexOf(GszZth+'|'+GszZtmc); //�Զ���λ����ǰ�������׺�

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

    if bOtherParamsLogin then     //������ʽ��ʹ����������
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
      bOtherParamsLogin := False; //���¸�ֵΪFalse���������µ�¼������
    end
    else
    begin
      //showmessage('������ʽ��¼ʧ�ܣ�');
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

  if rMainSub.GiReLogin >= 2 then begin //�½����ף���ʼ���������ú�Ҫǿ��Ҫ�����µ�¼�������Ŀģ�����ݲ��ԡ�
     try //�Զ���¼ FormMain.ActLoginExecute(FormMain.ActLogin);
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

begin  //����ԭ����½ʱ������ 20050408 zhouyunlu
  tmpDBName := GszDBName;
  //tmpGsProductSign := GsProductSign;
  tmpGSJQXFX := GSJQXFX;
  tmpGszServerComputer := GszServerComputer;
  tmpServerPort := GszServerPort;
  //������½�����ݿ�������Ϣ��ȡ��ע�����������ԭ�����ݿ�
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

  FormLogin.ReloginCzyID :=IntToStr(GCZY.ID);//zhengjy 2014-10-11 ����������������汾,��ֵ
  // ������ 2010.04.14
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
      FormLogin.ShowTitle := '�����л�'+KJND+'���';
      //Ӧ�û�ȡ����ȵ����һ��
      if GProSign='GL' then
      begin
        //2010.4.6 hy ά����2010032910788����ǰ��2010�꣬�ȵ�¼��2009�꣬���л���2010�꣬ҵ������Ӧ���ǵ�ǰϵͳʱ��
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
    //zhengjy 2014-10-11 ����������������汾,���µ�½��ɺ�ɾ��ԭ����½��Ϣ.
    TControlLogin.DelOperState(FormLogin.ReloginCzyID);
    FormLogin.ReloginCzyID :='';//zhengjy 2014-10-11 ����������������汾,ԭֵ�ÿ�
  end
  else
  begin
    //���ȡ������ע�ᣬ��ȫ�ֱ������������ 20050408
    //�������ڸ����û��Ȳ���������������DB
    //FormLogin.ReChangeDB;
    //�ָ�����������Ϣ��Ŀǰ��ʱֻ����R972
    GDbType := tmpGDBType;
    GszDBNAME := tmpDBName;
    GsServerName := tmpServerName;
    GsUserName := tmpUserName;
    GsPassword := tmpPasswod;
    szDBType := IFF(GDBType = MSSQL, 'MSSQL', 'ORACLE');

    // ������ 2010.10.11 ���߹���ģʽ��¼
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
            if ShowLoginHint('�޷���Ӧ�÷������������ӣ�' + #13#10#13#10 +
              '���飺' + #13#10 +
              '    1��Ӧ�÷�������ַ�Ƿ���ȷ��' + #13#10 +
              '    2��Ӧ�÷������Ƿ�����������') = mrYes then
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
    FormLogin.ReloginCzyID :='';//zhengjy 2014-10-11 ����������������汾,���µ�½ʧ�ܣ�ԭֵ�ÿ�
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
    //zhouyunlu added ԭ��ɾ��ĳ��������������½�ɹ�������Ȼ������ɾ������Ŀ
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
      'GL') and (GDbType = MSSQL)) then //�ռ���Ϊ x.x.s  R97��������ҪR9.7���м�� Lzn For R97
    begin
      if ((Pos('.s', szAPPServername) < 1) and (GProSeries = 'S')) then
        SysMessage('Ӧ�÷������汾��������Ӧ�÷������Ƿ�Ϊ�ռ���ר�ð汾��')
      else
        SysMessage('��ʾ����ǰӦ�÷������汾��̫�� Ӧ�÷�������Ҫ��������');
      Exit;
    end;
  except
    SysMessage('��ʹ�õĿ����Ǿɰ汾Ӧ�÷�����������Ӧ�÷�������װ�Ƿ���ȷ��');
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
  else if FGlobalMessage = Msg.Msg then // Sever����ʱ��Client�㲥�Լ���Handle
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
  // ������ 2009.10.22 ����ֹ��������׺�cbxZT.ItemIndex��Ȼ��-1�����⡣
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
        if ShowLoginHint('�޷���Ӧ�÷������������ӣ�' + #13#10#13#10 +
          '���飺' + #13#10 +
          '    1��Ӧ�÷�������ַ�Ƿ���ȷ��' + #13#10 +
          '    2��Ӧ�÷������Ƿ�����������') = mrYes then
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
        if ShowLoginHint('�޷���Ӧ�÷������������ӣ�' + #13#10#13#10 +
          '���飺' + #13#10 +
          '    1��Ӧ�÷�������ַ�Ƿ���ȷ��' + #13#10 +
          '    2��Ӧ�÷������Ƿ�����������') = mrYes then
        begin
          PostMessage(FormLogin.Handle, WM_LoginAsOfflineMode, 0, 0);
        end;
        Exit;
      end;

      //hch �������ݿ�
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
        SysMessage('�����������ݿ⣬���飺' + #13#10 +
          '1���Ƿ��ѽ����ף�' + #13#10 +
          '��鹤��λ�ã�����˵�[��ʼ]��[����]��[����R9�������]��[��̨���ݹ�����]' + #13#10 +
          '2: ���ݿ������Ƿ���ȷ��' + #13#10 +
          '��鷽����' + #13#10 +
          'һ�����[ѡ��]��ť��' + #13#10 +
          '������ȷ��������������û��������룬' + #13#10 +
          '�������[��������]��');
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
    LblInfo.Caption := '�޸�����...';
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
        LabelHost.Caption := '�����ַ��';
      end;
    1:
      begin
        PHostList.CommaText := PRegister.ReadString('SrvHost');
        LabelPort.Enabled := True;
        SMaskEditPort.Enabled := True;
        CheckBoxPooler.Enabled := True;
        LabelHost.Caption := '�����ַ��';
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

  //if rMainSub.GiReLogin=2 then begin //ǿ�����µ�¼����������λ���ô���
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

        if PRegister.OpenKey(RegLoginPath, True) then //�쵼��ѯģʽ��¼,���¼��Ϣ����¼��ע���
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
        if PRegister.OpenKey(RegLoginPath, True) then //�쵼��ѯģʽ��¼,���¼��Ϣ����¼��ע���
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
         GszGSDM311:=''; //�൱��ȡ����ѯ�������      
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
  begin //ע���ע��ĵ�λ�����ڣ�����Ҫ�������õ�λ
    GszHSDWDM := '';
    GszZth := '';
  end;
  Result := True;
end;

procedure TFormLogin.RadioButtonAutoAppClick(Sender: TObject);
begin
  if RadioButtonAutoApp.Checked then
  begin
    //�Զ�Ӧ��ģʽ
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
  // CdsLogin.Close;  //���ܹص�������sys����ģʽ����ʱ������C�棬���������ݼ��м�¼��������գ�����Ҫʹ��
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
  // �Զ�ģʽ
 // TerminateProcessByExeName('R9i_AppSrvr.exe');
 // gsPassword := EditPassword.Text;
  TestConnectServerDM; //�������� ServerDM
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
        SysMessage('������ȷ���ӵ����ݿ⡣');
    except
      SysMessage('������ȷ���ӵ����ݿ⣬���飺' + #13#10 +
        '1�����ݿ��û������û������Ƿ�������ȷ��' + #13#10 +
        '2����ǰ�����ܷ���ȷ���������硣');
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
  // ��ע����ȡ��Ҫ�ĵ�¼��Ϣ
  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    //��ȡ��½��Ϣ
    //sPath := RegLoginPath+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');
    bOpenKey := Reg.OpenKey(RegLoginPath, False);
    if not bOpenKey then
       bOpenKey := Reg.OpenKey(Format(szDBInfo, [GsProductID]), True);  //'\SOFTWARE\UFGOV\U8\DbInfo'

    //��ȡ��½��Ϣ //'\SOFTWARE\UFGOV\U8\DbInfo'
    if bOpenKey then begin
      if GbAutoLogin then begin //���ô�ע���ȡ��
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

      //����������ʾ��һ��
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
      //�������ײ�������
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

    //��ȡ����������Ϣ       //if Reg.OpenKey(RegDBInfo, True) then      begin //'\SOFTWARE\UFGOV\U8\DbInfo'
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
      //����ģʽ�����ݿ������������¼���ݿ��û�������
      if GbAutoLogin then
      else begin
        GsServerName := Reg.ReadString('ServerName');
        //ֻ��R9i����ҪDBName
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
      //hch �޸ļ��ܽ��ܷ�ʽ
      if Reg.ValueExists('Password_2') then
      begin
        // 1������ҵ��¼��ܿ��ֱ�ӽ��ܡ�
        szTemp := Reg.ReadString(Ident_Password_2);
        gsPassword := TString.DecryptStr(szTemp);
      end
      else
      begin
        // 2�����û�ҵ��¼��ܿ�����ȡ�ͼ��ܿ��
        if Reg.ValueExists(Ident_Password) then
        begin
          szTemp := Reg.ReadString(Ident_Password);
          if UnMixStr(szTemp, szTemp) then
          begin
            gsPassword := szTemp;
            // 1���ȱ����¼��ܿ�� Ident_Password_2 ��
            Reg.WriteString(Ident_Password_2, TString.EncryptStr(szTemp));
            // 2����ɾ���ɼ��ܿ��� Ident_Password ��
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
    //��ȡ��½��Ϣ
    //sPath := RegLoginPath+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');
    bOpenKey := Reg.OpenKey(RegLoginPath, False);
    if not bOpenKey then
       bOpenKey := Reg.OpenKey(Format(szDBInfo, [GsProductID]), True);  //'\SOFTWARE\UFGOV\U8\DbInfo'

    //��ȡ��½��Ϣ //'\SOFTWARE\UFGOV\U8\DbInfo'
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

  if (Trim(ComboBoxUser.Text)<>'') and (chkSaveUser.Checked) then  //zhengjy 2014-10-11 ����������������汾,ͨ����ѡ���������Ƿ񱣴��½�û���Ϣ
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
  //д��ע����м����Ϣ
  //������ӳɹ�����д��ע���������Ϣ
  if (GpsSeries <> psR9i) then
  begin
    Result := (TestConnectServerDM(false));
    if not Result then
      Exit;
  end;

  try
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_CURRENT_USER;
    //ֻ�е��ȷ�ϵ�¼ʱ�����ж��Ƿ��¼�û��� Modified by chengjf 2015-02-06 14:04:17
    //��¼ʱ����ѡ��ס�û��������¼���û����������ѡ������֮ǰ�Ѽ�¼��ɾ����
    if FbBtnOKClick then
    begin
      {by wangxin 2015-08-17 ���˴�������������DoSaveUser
      iPos := PUserList.IndexOf(ComboBoxUser.Text);
      if (iPos <> -1) and (chkSaveUser.Checked) then
        PUserList.Delete(iPos);
      if PUserList.Count >= ComboBoxUser.DropDownCount then
        PUserList.Delete(0);

      if (Trim(ComboBoxUser.Text)<>'') and (chkSaveUser.Checked) then  //zhengjy 2014-10-11 ����������������汾,ͨ����ѡ���������Ƿ񱣴��½�û���Ϣ
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
      // 2007-5-17 hch ���ñ���ע�������ӷ�ʽ
      PRegister.WriteString('ConType', IntToStr(cbConType.ItemIndex));
      GiConType:=cbConType.ItemIndex;
      
      //PRegister.WriteString('User', PUserList.CommaText);//��������
      PRegister.WriteBool('LoginAsUserID', rbtnCZYID.Checked);
      // 2007-5-17 hch ���ݲ�ͬ�����ӷ�ʽ���治ͬ����������
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
      //ע����к�ǰ̨��һ�£���Ҫ����д��ע���
      if (GDBType = MSSQL) and (Reg.ReadString('DBType') <> 'MSSQL') then
        Reg.WriteString('DBType', 'MSSQL');
      if (GDBType = ORACLE) and (Reg.ReadString('DBType') <> 'ORACLE') then
        Reg.WriteString('DBType', 'ORACLE');
      //����ģʽ�µ����ݿ���Ϣ
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
      // 2����ɾ���ɼ��ܿ��� Ident_Password ��
      //gsPassWord := EditPassword.Text;
      Reg.WriteString(Ident_Password_2, TString.EncryptStr(gsPassWord));
      if Reg.ValueExists(Ident_Password) then
        Reg.DeleteValue(Ident_Password);
      Reg.WriteString('SafeMode', '1'); // ���ݰ�ȫ(&S) Ĭ�ϱ��� Ϊ �����Կ���������˲��������Կ���ͻ��˽��ʹ���Կ���������ݽ��ܣ���ʽ
      Reg.WriteString('TDSPackSize', '4096'); //bde�Ĳ�����Ĭ�ϱ��� Ϊ4096�ֽڴ���
      Reg.WriteString('EnabledBCD', '0'); //bde�Ĳ�����Ĭ�ϱ��� Ϊ��bcd��ʽ����
    end;
  finally
    Reg.Destroy;
  end;
end;

function TFormLogin.MixStr(const AText: string): string;
var
  RandomNum: integer; // �������
  iPasslen: integer; // ���볤��
  i, iTemp: integer;
  sTemp, sTempPass: string;
  szBCDPass: string;
begin
  Result := '';
  if Trim(AText) = '' then
    exit; // û������,�������
  iPasslen := length(AText);

  // 1) �γ�n����λ���������
  sTempPass := '';
  Randomize;
  for i := 1 to iPasslen do
  begin
    RandomNum := random(9999);
    sTemp := '0000' + IntToStr(RandomNum);
    sTemp := copy(sTemp, length(sTemp) - 3, 4);
    sTempPass := sTempPass + sTemp;
  end;

  // 2) ����ת����BCD��,Ȼ��ת�������ִ�
  szBCDPass := '';
  for i := 1 to iPassLen do
  begin
    iTemp := ord(AText[i]);
    sTemp := '000' + IntToStr(iTemp);
    sTemp := copy(sTemp, length(sTemp) - 2, 3);
    szBCDPass := szBCDPass + sTemp;
  end;

  // 3) �����γ��´�
  sTemp := '';
  for i := 1 to iPassLen do
  begin
    sTemp := sTemp + sTempPass[i * 4 - 3] + szBCDPass[i * 3 - 2]
      + sTempPass[i * 4 - 2] + szBCDPass[i * 3 - 1]
      + sTempPass[i * 4 - 1] + szBCDPass[i * 3]
      + sTempPass[i * 4];
  end;
  sTempPass := sTemp;

  // 4) �γɼӷ�У����,�����볤��
  iTemp := 0;
  for i := 1 to length(sTempPass) do
  begin
    iTemp := iTemp + StrToInt(copy(sTempPass, i, 1));
  end;
  iTemp := (iTemp mod 10);
  sTemp := '00' + IntToStr(iPassLen);
  sTemp := copy(sTemp, length(sTemp) - 1, 2);
  sTempPass := sTemp[1] + IntToStr(iTemp) + sTemp[2] + sTempPass;

  // 5) ����λΪһ��,����ǰ��+'1', ��ĩһ�����ֻ��һ��,��+'20', �γ�����
  sTemp := '';
  iTemp := length(sTempPass);
  for i := 1 to ((iTemp + 1) div 2) do
  begin
    if i > (iTemp div 2) then // ���һ��,��Ϊ1�ַ� + '20'
    begin
      sTemp := sTemp + '20' + sTempPass[i * 2 - 1];
      break;
    end;
    sTemp := sTemp + '1' + sTempPass[i * 2 - 1] + sTempPass[i * 2];
  end;

  // 6) ��λΪһ��,ת����Chr�ַ�������
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
    exit; // û������,�������
  end;

  // 1) ת����BCD�봮
  sTempPass := '';
  for i := 1 to length(ACode) do
  begin
    // �Ƿ�ֵ�˳�            or (ord(ACode[i]) < 100)
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
  // 2) ��λһ�飬ȥ��1��20
  sTemp := '';
  // �Ƿ������˳�
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

  // �Ƿ�У����
  if (sTemp[2] < '0') or (sTemp[2] > '9') then
    exit;

  // 3) ����У���룬��������Աȼ��
  sTempPass := copy(sTemp, 4, length(sTemp) - 3);
  iTemp := 0;
  for i := 1 to length(sTempPass) do
  begin
    iTemp := iTemp + StrToInt(copy(sTempPass, i, 1));
  end;
  iTemp := (iTemp mod 10);
  // ���������,�˳�
  {if iTemp <> StrToInt(sTemp[2]) then
    exit;        }

  // ȥ��ǰ��λ����λΪһ�飬����������BCD��ֵ
  // �Ƿ�����
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
  if LabelOption.Caption = ' ���� <<' then
  begin
    PanelAppParam.Visible := False;
    LabelOption.Caption := ' �߼� >>';
    Height := Height - PanelAppParam.Height;
    PanelLogin.Height := PanelLogin.Height - PanelAppParam.Height;
    PanelOptions.Height := PanelOptions.Height - PanelAppParam.Height;
    PanelAppParam.Visible := False;
  end
  else if LabelOption.Caption = ' �߼� >>' then
  begin
    PanelAppParam.Visible := True;
    LabelOption.Caption := ' ���� <<';
    Height := Height + PanelAppParam.Height;
    PanelLogin.Height := PanelLogin.Height + PanelAppParam.Height;
    PanelOptions.Height := PanelOptions.Height + PanelAppParam.Height;
    PanelAppParam.Visible := True;
  end;
end;

procedure TFormLogin.ButtonDataExcuteClick(Sender: TObject);
var
  Reg: TRegistry;
  szFileName, szSafeMode, szTDSPackSize, szEnabledBCD, sTemp: string; //���ݿ���Ϣ
  szAppComputer, szAppPort: string; //�м����Ϣ
  szFile: TextFile;
begin
  szFileName := FilenameEditData.FileName;
  if trim(szFileName) = '' then
  begin
    SysMessage('�������ѡ���ļ�����');
    FilenameEditData.SetFocus;
    exit;
  end;
  if RadioButtonDataIn.Checked then //�������
  begin
    if uppercase(copy(Trim(szFileName), length(trim(szfileName)) - 3, 4)) <> '.INI' then
    begin
      szFileName := szfileName + '.ini';
    end;
    if not FileExists(szFileName) then
    begin
      SysMessage('ָ���ļ�"'+szFileName+'"�����ڣ�������ѡ��');
      FilenameEditData.SetFocus;
      exit;
    end;
   //if SysMessage('����������м��������Ϣ�Ḳ�����е�������Ϣ���Ƿ��������', 'Pub_01', [mbYes, mbNo], szFileName) = mrNo then
   //   exit;
    try
      assignFile(szFile, szFileName);
      reset(szFile);

      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_CURRENT_USER;
      //��¼��Ϣ
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
      //��ȡ����������Ϣ
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
      SysMessage('�м��������Ϣ����ɹ���');
    finally
      CloseFile(szFile);
      Reg.Destroy;
    end;
  end
  else if RadioButtonDataOut.Checked then //��������
  begin
    if uppercase(copy(Trim(szFileName), length(trim(szfileName)) - 3, 4)) <> '.INI' then
    begin
      if uppercase(copy(Trim(szFileName), length(trim(szfileName)), 1)) <> '\' then
        szFileName := szfileName + '.ini';
    end;
    if not DirectoryExists(ExtractFilePath(szFileName)) then
    begin
      SysMessage('ָ��Ŀ¼'+szFileName+'�����ڣ�����������Ŀ¼��');
      exit;
    end;

    if FileExists(szFileName) then
    begin
      if Application.MessageBox(PChar('ָ���ļ�'+szFileName+'�Ѿ����ڣ��Ƿ񸲸ǣ�ѡ��[��]�������ѡ��[��]���˳���'),
        'ϵͳ��ʾ', MB_ICONQuestion+MB_YesNo)
         = Id_No then
        exit;
    end;
    WriteAppServerInfoToReg;
    try
      Reg := TRegistry.Create;
      Reg.RootKey := HKEY_CURRENT_USER;
      assignFile(szFile, szFileName);
      rewrite(szFile);
      //��¼��Ϣ
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

      //��ȡ����������Ϣ
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
      SysMessage('�м��������Ϣ�����ɹ���');
    finally
      CloseFile(szFile);
      Reg.Destroy;
    end;
  end;
end;

procedure TFormLogin.RadioButtonDataInClick(Sender: TObject);
begin
  if RadioButtonDataIn.Checked then
    ButtonDataExcute.Caption := '����(&I)'
  else
    ButtonDataExcute.Caption := '����(&I)';
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
     if bOtherParamsLogin then  //sys.exe ��������ģʽ�£��������
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

    // ������ 2010.10.26 ֻ�� R9i ֧������ģʽ��
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
    Label16.Caption := '���ݿ�������뵼��';
    Label6.Caption := '���ݿ�ѡ��';
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
    if ShowLoginHint('�޷���Ӧ�÷������������ӣ�' + #13#10#13#10 +
      '���飺' + #13#10 +
      '    1��Ӧ�÷�������ַ�Ƿ���ȷ��' + #13#10 +
      '    2��Ӧ�÷������Ƿ�����������') = mrYes then
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
    if ShowLoginHint('�޷���Ӧ�÷������������ӣ�' + #13#10#13#10 +
      '���飺' + #13#10 +
      '    1��Ӧ�÷�������ַ�Ƿ���ȷ��' + #13#10 +
      '    2��Ӧ�÷������Ƿ�����������') = mrYes then
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
      SysMessage('��ʹ�ú�̨���ݹ����߽������ס�');
      Exit;
    end;
    result := true;
  except
    on E: exception do
    begin
      if pos('Insufficient memory', E.message) > 0 then
      begin
        if GpsSeries = psR9 then
          SysMessage('��ǰ�����Ŀ����ڴ治�㣬�����Գ������²�����' + #13#10 +
            '1�����˳�һЩӦ�ó���,Ȼ�����ԡ�')
        else
          SysMessage('��ǰ�����Ŀ����ڴ治�㣬�����Գ������²�����' + #13#10 +
            '1�����˳�һЩӦ�ó���' + #13#10 +
            '2����[ѡ��]�������м��ģʽΪ[�ֹ�ģʽ]��¼ϵͳ��');
      end
      else
      begin
        if pos(UpperCase('Anyisys'), UpperCase(E.message)) > 0 then
        begin
          SysMessage('��ʹ�ú�̨���ݹ����߽������ס�');
        end
        else
        begin
          SysMessage('�޷������ݿ���������������ݽ������ӣ�' + #13#10 +
            '�������ݿ�������Ƿ������������û��������Ƿ���ȷ��' + #13#10 +
            '��鷽����' + #13#10 +
            '  1�����[ѡ��]��ť��' + #13#10 +
            '  2����ȷ��������������û��������룬' + #13#10 +
            '  3�����[��������]��');
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
  //������������ַ������Ӧ�����
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
      SysMessage('��ѡ�����ף�');
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
  // ������ 2010.10.11 ���߹���ģʽ��¼
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
  //hch �����м������ݿ�������Ϣ
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
  //�޸Ļ�ȡע���·��
  //sPath := RegLoginPath+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');
  Result := Format(szDBInfo, [GsProductID])+'\'+ReplaceSub(ExtractFilePath(application.ExeName),'\','&');
  //Result := GetWriteSubKey(PRegister, Result, Application.ExeName);
end;

function TFormLogin.GetRegLogPath: string;    //DSL
begin
  //�޸Ļ�ȡע���·��
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
  Application.MessageBox(PChar(msg),'ϵͳ��ʾ',MB_ICONInformation+MB_OK);
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
    //������ϵͳ ���ɹ���ϵͳ��������//ͨ�ð� �������İ� ������/���磬��׼����
    GProVerSionScript := GetProVerSionScript(GDbType, GProSign, GProSeries, GProVersion, GszVersion);
    GProSeriesName := GetProSeriesName(GProSeries); //ͨ�ò���������������������GRP�������������

    if GNOJMVer_CusName<>'' then begin
       Application.Title := GProSeriesName+'-'+GNOJMVer_CusName;// +'('+GszEdition+')��';
       Application.MainForm.Caption := GProSeriesName+'-'+GNOJMVer_CusName;// +'('+GszEdition+')��';
    end else begin
      // ������ 2011.06.20 "����"����ʾ"G��"����
      if (Pos('����', GProSeriesName) > 1) or (GszEdition='����') then
        Application.Title := GProSeriesName
      else
        Application.Title := GProSeriesName +'('+GszEdition+')��';    //������ 2009.07.27 Ӧ���ĺ�Ҫ������������жϴ��롣 if GProSeries_GK = 'FOMS' then GProName := GFOMSCaption;

      // ������ 2011.06.20 "����"����ʾ"G��"����
      // �̽��� 20150716 �����治��ʾGszEdition��ֱ��ȡ��Դ�ļ��е�����
      if (Pos('����', GProSeriesName) > 1) or (GszEdition='����') then
        Application.MainForm.Caption := GProSeriesName
      else
        Application.MainForm.Caption := GProSeriesName +'('+GszEdition+')��';
    end;
    
    try
      Application.MainForm.Enabled := False;
      GAnyiLicenseInfo.ConnectAnyiServer;
    finally
      Application.MainForm.Enabled := True;
    end;
    //modified by chengjf 20150717 �����治���sps
    if (GszEdition<>'����') and (not CheckSPS) then begin  //�������ʱ������֤   //SPS
       Application.MainForm.free;
       Result := False;
       Exit;
    end;
        
    SplashShow();
    GPubProviderName := DataModulePub.ClientDataSetPub.ProviderName;
    GPubProviderOpenName := DataModulePub.ClientDataSetPub.ProviderName;
    InitGnScript(GGnScripts); //��ʼ��ȫ�ֹ�����������
    SplashClose;  // ��������

    // ϵͳ��¼
    if SysLogin(Params) then begin
      Result := True;
      if (ParamCount>=13) and (GsParamGNFLMC<>'')  then begin  //��¼����������
          //RunGNFLMC(GsParamGNFLMC);   //����������ʱ�ӿ��Ƶģ�����ȡ����
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
  //hch �ж�����滹�ǵ�����.
  //Pub_Res.Res_InitGlobal; //hch ��ʼ��Res����

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
    if SysMessage('ǰ̨�����Ѿ������У��Ƿ�������һ����', '_XW', [mbYes, mbNo]) = mrYes then begin   //DSL
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
  //ShowMessage('��13�������ǣ�DBSY:'+sGNFLMC);
  iPos:= Pos(':',sGNFLMC); // sParamDBSY:=DBSY:PA:���ʴ�������
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
  //sys.exe  ����Ա�� ���� ��¼���� ���׺� �������� ��˾���� ��˾���� ��������ַ �˿ں� 0(������ģʽ) http ���ݿ�����(MSSQL��ORACLE)
  //SYS.exe ϵͳ����Ա 1 20131118 01zth ������ztmc 201gsdm ְҵѧԺgsmc 127.0.0.1AppServerName 88 0 HTTP MSSQL

  //C/B��
  //SYS.exe ϵͳ����Ա 1 20131118 002 B 002 b 10.10.65.170 88 0 AUTO MSSQL G��
  //SYS.exe ϵͳ����Ա 1 20131118 013 �������� 013 �������� 127.0.0.1 ServerName=127.0.0.1&DatabaseName=Master&UserName=sa&Password=zz AUTO MSSQL    C��
  //ϵͳ����Ա 1 20131118 013 һְ�� 013 һְ�� . 211 ServerName=.&DatabaseName=Master&UserName=sa&Password=zz AUTO MSSQL

  //SYS.exe ϵͳ����Ա 1 20131128 ���׺� �������� ��˾���� ��˾���� 127.0.0.1 80 ServerName=127.0.0.1&DatabaseName=Master&UserName=sa&Password=1 AUTO MSSQL

  (* �����¼��ʽ˵�� lzn
  Ŀǰ����G���ǰ̨����SYS����ȫ֧�ֵ����¼�ĵ���

  ���ø�ʽΪ ��
      Sys.exe ����Ա�� ���� ҵ������ ���ױ�� �������� ��λ���� ��λ���� U8Ӧ�÷�������ַ U8Ӧ�÷������˿� 0 HTTP ���ݿ�����
  �磺SYS.exe ϵͳ����Ա 1 20131118 01 ������ 201 ְҵѧԺ 127.0.0.1 88 0 HTTP MSSQL
 
 
  ����C��ĵ��ø�ʽ�����ǣ�
          Sys.exe  ����Ա�� ����Ա���� ҵ������ ���ױ�� �������� ��λ���� ��λ���� U8Ӧ�÷�������ַ  U8Ӧ�÷������˿� ���ݿ����Ӵ�  AUTO ���ݿ�����
 
  �磺SYS.exe ϵͳ����Ա 1 20131118 U8XZC2013071 U8XZC2013071 U8XZC2013071 U8XZC2013071 127.0.0.1 80 ServerName=127.0.0.1&DatabaseName=Master&UserName=sa&Password=1 AUTO MSSQL
 
  ע�⣬���ݿ����Ӵ�����ʽ�磺ServerName=127.0.0.1&DatabaseName=Master&UserName=sa&Password=1
  ������ AUTO ������http
  *)

  //�Ϻ����CA ����ʱ�Ƚ���CA��֤ Added by chengjf 2015-03-26 9:14:54
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
    //ShowMessage('��12�����������ݿ�:'+ParamStr(12));
    if ParamCount>=13 then begin
       sParamGNFLMC := trim(ParamStr(13));       //ShowMessage('��13������:'+sParamGNFLMC);  FBI:����������
       //===�Զ����ô������˴���
       iPos:= Pos('DBSY:',sParamGNFLMC); // sParamDBSY:=DBSY:PA:���ʴ�������
       if iPos>0 then begin
          ParamList.Add('FormName=' + sParamGNFLMC);
          iLen := Length('DBSY:');
          GsParamGNFLMC := Copy(sParamGNFLMC,iLen+1,Length(sParamGNFLMC)-iLen);          //iPos:= Pos(':',sParamDBSY);
       end else begin //modified by chuym 20150720 ���ⲿϵͳ���ݲ��������ܴ������磺FBI����λָ��Ǽǲ� �˵���  
         GsParamGNFLMC := sParamGNFLMC ;          //iPos:= Pos(':',sParamDBSY);
       end;
    end;

    //zhangwh20120823 begin   �������  DDSL
    if FGetParaValueByName('MODEL:')<>'' then begin
        //ParamList.Add('ModelName=' + FGetParaValueByName('MODEL:'));
        GszModelName := FGetParaValueByName('MODEL:') ; //ģ���ʶ �� FCP
    end;
    if FGetParaValueByName('BILLID:')<>'' then begin
        //ParamList.Add('BillID=' + FGetParaValueByName('BILLID:'));
        GszBillID  := FGetParaValueByName('BILLID:'); //����ID   �� 00.2012.0.1
    end;    
    if FGetParaValueByName('CALL:')<>'' then begin
        //ParamList.Add('CallFlag=' + FGetParaValueByName('CALL:'));
        GszCallFlag := FGetParaValueByName('CALL:'); //�ⲿ����ϵͳ�ı�ʶ �����칫ϵͳ����Ϊ FE
    end;

    if FGetParaValueByName('OperateFlag:')<>'' then begin
        //ParamList.Add('CallFlag=' + FGetParaValueByName('CALL:'));
        GszOperateFlag := FGetParaValueByName('OperateFlag:'); //�ⲿ����ϵͳ�ı�ʶ �����칫ϵͳ����Ϊ FE
    end;
    //zhangwh20120823 end

    GsPin := '';
    sPin := '';  //�����һλ��PIN����  
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
    ShowMessage('����������'+IntToStr(ParamCount)+#13+'�����ַ�����'+#13+ssss+' '+#13+'����һ��pin�����ǵڼ�������');
    if sPin='' then
         showmessage('pin����Ϊ��')
    else showmessage(spin); *)

    if sPin<>'' then begin  //�����Ż�����PIN������16������
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
      //����ģ����Ϣ���ֵ
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
  if PRegister.OpenKey(RegLoginPath, True) then //�쵼��ѯģʽ��¼,���¼��Ϣ����¼��ע���
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
  gsSingleMode := gsSingleMode_Bak; //����ȡ���ˣ����Խ��˱����Ļ���
end;

procedure TFormLogin.btnUserClick(Sender: TObject);
var
  N1,N2: TMenuItem;
begin
  if pmUser = nil then
  begin
    pmUser := TPopupMenu.Create(Self);
    N1 := TMenuItem.Create(pmUser);
    N1.Caption := 'ɾ����ǰ��ס�û�';
    N1.OnClick := DelRemUser;
    pmUser.Items.Add(N1);

    N2 := TMenuItem.Create(pmUser);
    N2.Caption := '������м�ס�û�';
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

