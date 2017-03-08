unit UIR9_IMPL;

interface

uses
  Windows, Controls, SysUtils, Forms, Classes, IniFiles, IBaseInvoke, Dialogs,
  DataModuleMain, anyiclient, MSXML2_TLB, Menus, DBClient, ComObj, Pub_Function,
  Pub_Global, Pub_Power, SYS_TLB, VCLUnZip, VCLZip, Registry, CMidasCon, HTTPFile,ComCtrls;

const
  {$J+}
  sSPS_Sys:string='';
  {$J-}
  
  cAutoXML = 'AutoUpdateIniC.xml';
  sAutoXML = 'AutoUpdateIniS.xml';
  cTempPath = 'C:\temp';
  cR9_FILECONFIG = 'R9_FILECONFIG.Ini';
type
  TExecute = function(AParams:String):Boolean;stdcall;
  //TGetFormProc = procedure(var FIR9: IR9_DLL; MidasConnection: TCMidasConnection); stdcall; //;pGInitDLLVar:TGInitDLLVar
  TShowForm = function(GNID: string; bActiveForm: Boolean): TPublicMod; stdcall;
  {��ʾ����}
  TOnProgress = procedure (Rate:integer) of object;
  {�˵��ϲ�������}
  TMergerMenu = class
  private
    FOnClick: TNotifyEvent;
    FOwner: TComponent;
    FSurMenu, FDesMenu: TMainMenu;
    FMenuInsBeg, FMenuInsEnd: integer;
    FSlMenu: TStringList;
    //�ָ����˵��������
    procedure RecoverMenu;
    //���Ӳ˵��Ľ��˵�
    function AddChildMenuItem(AMenuItem, ParentMenuItem: TMenuItem): Boolean;
    //���ҽڵ�˵������Ƿ����
    function FindMenuItem(sCaption: string): boolean;
    function FindMenuCaption(sCaption: string; AMenuItem: TMenuItem): Boolean;
  public
    constructor Create(Owner: TControl; MainMenu: TMainMenu); overload;
    destructor destroy; override;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    function MergerMenu(SurMenu: TMainMenu; OverWrite: Boolean = False): boolean;
  end;
  TExecType = (etExe, etBPL, etDLL, etCom, etReport, etCustomRpt, etGE, etMIDS, etAPT, etAPP, etNone);
  TUIR9_IMPL = class //bpl
  private //FR9_DLLIntf: IR9_DLL;
    FBPL_Handle: HMODULE; //Bpl���
    FDLLForm: LongWord;
    FLibPath: string;
  public //FR9_DLLHandle: THandle;   //��ǰ������
    FsBPLName: string; //bpl������
    FsModeName: string; //��Ӧģ�������
    bIsCusReport:Boolean;      //�Ƿ��Ǳ�����ļ���
    Global_Mode: TPublicMod; //��ǰģ���Ӧ�Ķ���
    FExeType: TExecType;
    Anyiclient1: TAnyiClient; //�������Ʒ�õļ��ܣ�������BPL�Ĳ�Ʒ�����������
    function CallDll(sGnflMc: string): Integer;
    function CloseDLL: Integer;
    function GetParms: string;
    constructor Create(LibPath: PChar; psModeName: string);
  end;

  TDllFile = class //�ö�����Ҫ�Ƕ�ȡ����bpl�����ļ���û������;��
  private
    FslFile: TStringList; //bpl�ļ��б�
  public
    constructor Create;
    function ReadIniFile(FilePath: string): integer;
    function GetDllName(GszVersion: string): string;
    destructor destroy; override;
  end;

  TslUIR9_IMPL = class
  private
    FAppPath: string;
    FDllFile: TDllFile;
    FServerURL: string;
    function GetValue(const ModuleName: string): TUIR9_IMPL;
    procedure SetValue(const ModuleName: string; const Value: TUIR9_IMPL);
    procedure SetServerURL(const Value: string);
  public //function GetBPLFileName:String;
    FslUIR9: TStringList; //bpl�ļ�ȫ·�����Լ� FUIR9_IMPL����  ��ÿ��bpl�ʹ���һ��TUIR9_IMPL���󣬲���ÿ��ģ��һ��������Ϊ����һ��ģ����ö����ͬ��bpl�ļ�
    constructor Create(AppPath: string);
    destructor Destroy; override;

    // For Client AutoUpdate, Added by gh, 2013.05.23
    function CheckUpdate(const ModName: string; CheckOnly: Boolean): Boolean;

    function CreateUIR9(psModuleName, sGnflExec: string): TUIR9_IMPL;
    function ActiveForm(psModeName: string): Boolean; // ����ģ�� FormHandle:HWND;
    procedure DeleteUIR9(psModuleName: string; DLLHandle: HWND);
    property Values[const ModuleName: string]: TUIR9_IMPL read GetValue write SetValue;
    property ServerURL: string read FServerURL write FServerURL;
  end;

  //�ͻ��˸����ļ���
  TClientInfo = class
  public
    NodeId: string;
    SetupPath: string;
    fileName: string;
    IsReplace: Boolean;
    Script: string;
    IsRegister: Boolean;
    Version: string;
    AutoRun: string;
    ModName: string;
  end;
  //�ͻ��˸����࣬ hch 2011-03-07
  TClientUpdate = class
  private
    //��������ַ���ͻ���XML���·��
    FServerURL, FClientXMLPath, FWindowsPath: string;
    //�������ŵ�ַ
    FAppPath: string;
    //�Ƿ�װBDE
    FIsSetupBDE: Boolean;
    //�����ļ��б�
    FUpFileLst: TList;
    IXMLS, IXMLC: IXMLDOMDocument;
    FModName: string;
    FDatabaseType: string;

    //����XML�ļ�����ȡ��Ʒ�б�
    procedure ExtractFile(var lst: TList; I: IXMLDOMDocument; FProductName: string);
    //�ж�XML�ļ��Ƿ��и��£������ļ�
    procedure FindDiff(slst, clst: TList; var uplst: TList; FDefaultPath: string; FIsSetupBDE: Boolean);
    //����Node�ڵ�
    function findNode(Nodes: TList; NodeId: string): integer;
    //���ó���Ӧ�õ�ַ
    procedure SetAppPath(const Value: string);
    //�����ļ�
    function downFile(Afile: string): Boolean;
    //��ѹ�ļ�
    function unzipFile(Aunzip: TVCLUnZip; AunzipFile, Afolder: string; IsReplace: Boolean): Boolean;
    function LoadFile(AFileName: string): IXMLDOMDocument;
    procedure SetDatabaseType(const Value: string);
    function GetHttpURL(AURL: string): string;
    function GetHttpURLPort(AURL: string): string;//���ش��˿ںŵ�URL��ַ //2011.12.5 hy DSL
 
    // For Client AutoUpdate, Added by gh, 2013.05.23
    function GetClientXmlFileName: string;         // DSL
  public
    //����
    constructor Create(ServerURL: string);
    //�ͷ�
    destructor Destroy; override;
    //Check�����¼�飬 ���ģ���ļ��Ƿ���Ҫ���£�Ȼ������
    //�Զ���������, ��ѹ����Ҫ��¼�Ƿ���м�飬����Ѿ����¹����Ͳ���Ҫ�������ظ���
    function Check(ModName: string): Boolean;
    //����
    function Update: Boolean;
    property AppPath: string read FAppPath write SetAppPath;
    property DatabaseType: string read FDatabaseType write SetDatabaseType;
  end;
  {hch 2011.05.19}
  {ʵ����Ҫ�Ĺ��ܣ�}
  {1������ģ���������е�����}
  {2���ܹ���̬��ʾ�������ز˵�������}
  THideMenu = class
    {�������в���Ҫ��ʾ�Ĳ˵�}
    FHideList:THashedStringList;
    {������Ⱥ��Զ���ȡ�Ƿ���ʾ�˵�}
    FGSDM, FKJND:String;
    {��ʼ��ģ���в���Ҫ��ʾ�Ĳ˵�}
    procedure Init(AGSDM, AKJND:String);
    procedure InitFast(AGSDM, AKJND, AModCode: string);
    procedure InitFastTree(AGSDM, AKJND: string;tv: TTreeView);
    procedure InitCM(AGSDM, AKJND:String);
    procedure InitGBG(AGSDM, AKJND:String);
    procedure InitFBI(AGSDM, AKJND:String);
    procedure InitYBC(AGSDM, AKJND:String);
    procedure InitFBS(AGSDM, AKJND:String);
    procedure initFA(AGSDM, AKJND:String);
    procedure InitPA(AGSDM, AKJND:String);
    procedure InitGL(AGSDM, AKJND:String);
    procedure InitCHQ(AGSDM, AKJND:String);
    procedure InitNTMF(AGSDM, AKJND:String);
    procedure InitBM(AGSDM, AKJND:String);
    procedure InitGBI(AGSDM, AKJND:String);
    procedure InitGBS(AGSDM, AKJND:String);
  public
    constructor Create;
    destructor Destroy;override;
    class function IsHide(AGSDM, AKJND:String; AMenuCode:String):Boolean;
    class procedure Refresh;    
  end;
  {hch ���ע������Ƿ���ȷ�� �������ȷ����ע��}
  TRegCheck = class
  public
    class procedure CheckReg(AName, APath:String);
  end;
  {ʵ��������ӿڵĵ���}
  TPubIntf = class(TInterfacedObject, IPub)
  public
    function Execute(vAction, vParams:WideString):Boolean;
  end;

// ���AProcessName�������е�ʵ������For Client AutoUpdate, Added by gh, 2013.05.23
// AProcessPathΪ��ʱ��������Ŀ¼�µ�����ʵ��������ֻ��������Ŀ¼ΪAProcessPath��ʵ����
function GetInstanceCount(const AProcessName, AProcessPath: string): Integer;
// ��Ⲣ����������SYS, IM etc.��, For Client AutoUpdate, Added by gh, 2013.05.23
procedure CheckAndUpdate(const AProductName, AServerAddr, ACallbackExe: string;
  APrompt: Boolean = True); overload;
procedure CheckAndUpdate(const AProductName, AUserID, AUserName, APassword,
  ATransdate, AAccountID, AAccountName, ACompanyID, ACompanyName, AServerUrl, AServerPort,
  ACallbackExe: string; APrompt: Boolean = True); overload;


var
  GCU: TClientUpdate;
  GCUProgress:TOnProgress;
  HideMenu:THideMenu;

implementation

uses uRptCaller, Main, QueryReport, ComServ,QueryPanelboard, TlHelp32, ShellAPI;

// For Client AutoUpdate, Added by gh, 2013.05.23
function GetInstanceCount(const AProcessName, AProcessPath: string): Integer;
var
  hSnapshotPe, hSnapshotMe: THandle;
  lppe: TProcessEntry32;
  lpme: TModuleEntry32;
  bFounded: Boolean;
begin
  Result := 0;
  hSnapshotPe := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshotPe = INVALID_HANDLE_VALUE then Exit;
  lppe.dwSize := SizeOf(TProcessEntry32);
  bFounded := Process32First(hSnapshotPe, lppe);
  while bFounded do
  begin
    if SameText(ExtractFileName(lppe.szExeFile), AProcessName) then
    begin
      if AProcessPath = '' then
        Inc(Result)
      else
      begin
        hSnapshotMe := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, lppe.th32ProcessID);
        if hSnapshotMe = INVALID_HANDLE_VALUE then Exit;
        lpme.dwSize := SizeOf(TModuleEntry32);
        if Module32First(hSnapshotMe, lpme) then
          if SameText(AProcessPath, ExtractFilePath(StrPas(@lpme.szExePath[0]))) then
            Inc(Result);
        CloseHandle(hSnapshotMe);
      end;
    end;
    bFounded := Process32Next(hSnapshotPe, lppe);
  end;
  CloseHandle(hSnapshotPe);
end;

// For Client AutoUpdate, Added by gh, 2013.05.23
procedure CheckAndUpdate(const AProductName, AServerAddr, ACallbackExe: string;
  APrompt: Boolean = True);
begin
  CheckAndUpdate(AProductName, '', '', '', '', '', '', '', '',
    AServerAddr, '', ACallbackExe, APrompt);
end;

// For Client AutoUpdate, Added by gh, 2013.05.23
procedure CheckAndUpdate(const
  AProductName,             // ģ������
  AUserID,                  // ����ԱID
  AUserName,                // ����Ա����
  APassword,                // ����
  ATransdate,               // ҵ������
  AAccountID,               // ���׺�
  AAccountName,             // ��������
  ACompanyID,               // ��λ����
  ACompanyName,             // ��λ����
  AServerUrl,               // ��������ַ
  AServerPort,              // �˿ں�
  ACallbackExe: string;     // �ص��������ƣ�����·����
  APrompt: Boolean = True); // �Ƿ���ʾ��ʾ��Ϣ
const
  cUpdateMod = 'SYSUPDATER';
  cUpdaterName = 'SysUpdater.exe';
  cCaption = '����';
  cPromptInfo = '��⵽�°汾����ȷ����ʼ���¡�';
  cUpdateParams = '"%s" "%s" "%s" "%s" "%s" "%s" "%s" "%s" "%s" "%s" "%s" "%s"';
var
  UpdateExe, UpdateParams: string;
begin
  if AProductName <> 'SYS' then GszServerComputer := AServerUrl;
  with TslUIR9_IMPL.Create(ExtractFileDir(Application.ExeName)) do
  try
    CheckUpdate(cUpdateMod, False);
    UpdateExe := ExtractFilePath(Application.ExeName) + cUpdaterName;
    if (GetInstanceCount(ExtractFileName(Application.ExeName), ExtractFilePath(Application.ExeName)) = 1) and
       CheckUpdate(AProductName, True) and FileExists(UpdateExe) then
    begin
      if APrompt then
        if (Application.MessageBox(cPromptInfo, cCaption, MB_OKCANCEL + MB_ICONQUESTION) <> IDOK) then
          Exit;

      UpdateParams := Format(cUpdateParams,
        [AProductName, AUserID, AUserName, APassword, ATransdate, AAccountID, AAccountName,
        ACompanyID, ACompanyName, AServerUrl, AServerPort, ACallbackExe]);
      UpdateParams := StringReplace(UpdateParams, '""', '" "', [rfReplaceAll, rfIgnoreCase]);
      ShellExecute(0, 'open', PChar(UpdateExe), PChar(UpdateParams), nil, SW_SHOWNORMAL);
      //chengjf 2016-04-25 �˳�ʱɾ���û�״̬���������µ�¼ʱ���ܵ�¼
      TControlLogin.DelOperState(IntToStr(GCzy.ID));
      Application.Terminate;
    end;
  finally
    Free;
  end;
end;

{ TUIR9_IMPL }

function TUIR9_IMPL.CallDll(sGnflMc: string): Integer; //�������ܲ˵�ʱ����
var
  ShowForm: TShowForm;
  vParams: string;
  iResult:Integer;
  sCurBplName:string;
  function CreateAnyiClient:Boolean;
  begin
    Result := False;
    if AnyiClient1=nil then begin
       AnyiClient1 := TAnyiClient.create(nil);
       InitModeEncrypt(AnyiClient1);
    end;
    
    if not CheckRemoteAnyiServer(AnyiClient1) then
       Exit;       
    Result := True;//û�д���Ҳ����True    
  end;

  function InitRepEncrypt(pbIsCusReport:Boolean):Boolean;
  //�򿪵ķ�bpl��ģ��ʱ����Ҫ����������м��ܴ��� lzn
  begin
    Result := False;
    Pub_GLobal.GszVersion:= GetGszAnyiByModeName(FsModeName);
    rMainSub.GsStartModName := FsModeName;
    rMainSub.GsActiveModName := FsModeName;
    rMainSub.GsPriModName := rMainSub.GsCurModName;     //��¼��һ�����õ�ģ��
    rMainSub.GsPriReportModName := rMainSub.GsCurModName;
    rMainSub.GsCurModName := FsModeName;    //��ǰ���򿪵�ģ��
    rMainSub.GsCurBplName := FsBPLName;
    bIsCusReport := pbIsCusReport;
    Result := CreateAnyiClient;
    if not Result then FreeAndnil(AnyiClient1);

  end;
begin
  Result := -1;
  if not FileExists(FLibPath) and (FLibPath <> '') and
    ((FExeType=etBPL) or
     (FExeType=etDLL) or
     (FExeType=etExe)
     ) then begin
       ShowMessage('��ȡģ���ļ�ʧ�ܣ������¼���ԭ�����飺'+#13#10+
                   '1.��������Ŀ¼��ȱ��"'+FLibPath+'"�ļ�,�����ӷ��������º���ʹ�ñ�����'+#13#10+
                   '2.GL_GNFL��ȱ�����ģ���ļ�������'+#13#10+
                   '3.����δ��ȷ��Ϣ������ϵͳ����Ա��ϵ');
       Exit;
  end;

  if (FExeType = etBpl)or(FExeType=etGE) then
  begin //���ڰ��ļ� //�����
    if FBPL_Handle = 0 then
       FBPL_Handle := LoadPackage(FLibPath);
    @ShowForm := GetProcAddress(FBPL_Handle, 'ShowForm');
    if Assigned(ShowForm) then
    begin
      rMainSub.GsStartModName := FsModeName;
      rMainSub.GsActiveModName := FsModeName;
      //��ǰ��������ģ�飬���︳ֵ����Ҫ��Ϊ����ShowForm������Global_Mode.create����
      rMainSub.GsCurBplName := FsBPLName;
      sCurBplName := FsBPLName;
      rMainSub.bShow := False;
      try
        Global_Mode := ShowForm(sGnflMc, False);
        Result := 1;
        //zhengjy 20151103 ԭ������������ģ�飬ͨ��showForm���ú�Ӧ�õ���ClientWndProc
        //  �Ĺ���UpdateList������ rMainSub.bShow ����Ϊtrue������֪��ʲôԭ�������ģ��δ���ã���ʱ����
        if (Global_Mode<>nil) and (sGnflMc<>'') then
          rMainSub.bShow :=true;

        if (Global_Mode<>nil) and Global_Mode.FbDBProcess then //Ҫ���¸����´�����Ϣ
           FormMain.UpdateDBSY(True,Global_Mode.FsModeName);
      except
        //�����쳣���޷��ͷż���
      end;
      if (not rMainSub.bShow) then begin // Showmodal�����ͷż��ܣ����ڵ������ǣ���һ��showmodal���壬���رպ��Զ�����һ��show���壬��ʱ����Ҳ�ͷ��ˣ���Ҫ������Ľ����ģ��ļ����¼�������򿪼���
         rMainSub.GsCurBplName := sCurBplName; //��ǰ���رյ�bpl����
         FormMain.FreeEncrypt(FsModeName);
      end;
      rMainSub.bShow := False;
    end;
  end else
  {���ļ�}
  if FExeType = etExe then
  begin
    vParams := GetParms;

    WinExec(PChar(FLibPath + ' ' + vParams), SW_SHOWNORMAL);
    Result := 1;
  end else
  {�򿪵��ӱ���}
  if FExeType = etReport then
  begin
    GProSign := 'AQR';
    GProSeries := 'G';
    GNotEncrypt := '0';
    GszVersion := 'AQR';
    rMainSub.GsStartModName := FsModeName;
    rMainSub.GsActiveModName := FsModeName;  
    OpenRpt(GszGSDM, GszZTH, GszKJND, GszYWRQ, sGnflMc);
  end else
  if FExeType = etCustomRpt then
  begin
    GProSign := 'BKA';
    GProSeries := 'G';
    GNotEncrypt := '0';
    if not InitRepEncrypt(True) then Exit;
    //zhengjy 2014-05-21 ��Ԥ������ģ����Ԥ��ִ�з���ģ�鹦�ܺϲ�����ʹ��ͬһ�����ܡ�
    if (sGnflMc='Ԥ������') and (FsModeName='BKA') then
    begin
      if FBPL_Handle = 0 then
        FBPL_Handle := LoadPackage(FLibPath+'GE.BPL');
      @ShowForm := GetProcAddress(FBPL_Handle, 'ShowForm');
      if Assigned(ShowForm) then
      begin
        rMainSub.GsStartModName := FsModeName;
        rMainSub.GsActiveModName := FsModeName;
        //��ǰ��������ģ�飬���︳ֵ����Ҫ��Ϊ����ShowForm������Global_Mode.create����
        rMainSub.GsCurBplName := FsBPLName;
        sCurBplName := FsBPLName;
        rMainSub.bShow := False;
        try
          Global_Mode := ShowForm(sGnflMc, False);
          Result := 1;
          if (Global_Mode<>nil) and Global_Mode.FbDBProcess then //Ҫ���¸����´�����Ϣ
             FormMain.UpdateDBSY(True,Global_Mode.FsModeName);
        except
          //�����쳣���޷��ͷż���
        end;
        if (not rMainSub.bShow) then begin // Showmodal�����ͷż��ܣ����ڵ������ǣ���һ��showmodal���壬���رպ��Զ�����һ��show���壬��ʱ����Ҳ�ͷ��ˣ���Ҫ������Ľ����ģ��ļ����¼�������򿪼���
           rMainSub.GsCurBplName := sCurBplName; //��ǰ���رյ�bpl����
           FormMain.FreeEncrypt(FsModeName);
        end;
        rMainSub.bShow := False;
      end;
      if AnyiClient1=nil then iresult :=0
      else iresult :=-1;
    end else
      iResult:= TQueryReport.OpenReport(iff(sGnflMc='������', '', sGnflMc), '',  sGnflMc<>'������');
    if iResult=0 then begin     //����0�ǵ��˷�,1�ǵ����ǣ�2-3�ǲ��ܴ�
    end else if iResult=1 then begin //�����ǣ�����ر���Ϣ�ᴥ�������¼��ܿ����ѱ��ͷţ�������Ҫ���´����¼���(ע���������Զ��ͷ�����һ���Զ��屨����ģ�����������)
       CreateAnyiClient
    end else if iResult=2 then begin //���ܴ򿪣����ͷ���ǰ�����ļ�������
         if rMainSub.GsPriReportModName<>FsModeName then
            FreeAndnil(AnyiClient1);
    end else if iResult=3 then  //������ģ����ˣ����Բ��ܴ򿪣����ͷ���ǰ�����ļ�������
         FreeAndnil(AnyiClient1);
  end else
  if FExeType = etMIDS then //added by guozy 2012-02-28
  begin
    GProSign := 'MIDS';
    GProSeries := 'G';
    GNotEncrypt := '0';
    if not InitRepEncrypt(True) then Exit;
    if not FileExists(FLibPath) then  //��Ԥ����Ĺ��ܣ��Ǵ����ݿ��ж�̬�򿪵Ĺ���
    begin
      iResult:= TQueryPanelboard.OpenPanelboard(sGnflMc);
      exit;
    end;
    if FBPL_Handle = 0 then
       FBPL_Handle := LoadPackage(FLibPath);
    if FBPL_Handle = 0 then exit;
    @ShowForm := GetProcAddress(FBPL_Handle, 'ShowForm');
    if Assigned(ShowForm) then
    begin
      rMainSub.GsStartModName := FsModeName;
      rMainSub.GsActiveModName := FsModeName;
      //��ǰ��������ģ�飬���︳ֵ����Ҫ��Ϊ����ShowForm������Global_Mode.create����
      rMainSub.GsCurBplName := FsBPLName;
      sCurBplName := FsBPLName;
      rMainSub.bShow := False;
      try
        Global_Mode := ShowForm(sGnflMc, False);
        Result := 1;
        if (Global_Mode<>nil) and Global_Mode.FbDBProcess then //Ҫ���¸����´�����Ϣ
           FormMain.UpdateDBSY(True,Global_Mode.FsModeName);
      except
        //�����쳣���޷��ͷż���
      end;
      if (not rMainSub.bShow) then begin // Showmodal�����ͷż��ܣ����ڵ������ǣ���һ��showmodal���壬���رպ��Զ�����һ��show���壬��ʱ����Ҳ�ͷ��ˣ���Ҫ������Ľ����ģ��ļ����¼�������򿪼���
         rMainSub.GsCurBplName := sCurBplName; //��ǰ���رյ�bpl����
         FormMain.FreeEncrypt(FsModeName);
      end;
      rMainSub.bShow := False;
    end;
  end else if ((FExeType = etAPT) or (FExeType = etAPP)) then begin
    if FExeType = etAPT then
      GProSign := 'APT'
    else
      GProSign := 'APP';
      GProSeries := 'G';
      GNotEncrypt := '0';
    //Pub_GLobal.GszVersion:= GetGszAnyiByModeName(FsModeName);
    //CreateAnyiClient;
    if (sGnflMc='ƾ֤ģ��') or (sGnflMc='ƾ֤�ɼ�') or (sGnflMc='ƾ֤�ӿ�') or (sGnflMc='����ͬ��') then begin
       if not InitRepEncrypt(False) then  //���飺APTģ��ļ��ܣ��ڸ��Ե�ģ���п���,����������5�������⣬����ע�͵� 2013.07.15
          Exit;
    end;
    GAPTConnectEncrypt:=True;
  end;         
  (*else if FExeType = etGE then
  begin
    //GProSign := 'GE'; if sGnflMc='Ԥ������' then begin
    if FBPL_Handle = 0 then
       FBPL_Handle := LoadPackage(FLibPath);
    @ShowForm := GetProcAddress(FBPL_Handle, 'ShowForm');
    if Assigned(ShowForm) then
    begin
      rMainSub.GsStartModName := FsModeName;
      rMainSub.GsActiveModName := FsModeName;  //rMainSub.GsPriReportModName := FsModeName;
      rMainSub.bShow := False;
      try      
        Global_Mode := ShowForm(sGnflMc, False);
      except
        //�����쳣���޷��ͷż���
      end;      
      Result := 1;
      if (not rMainSub.bShow) then // Showmodal�����ͷż��ܣ����ڵ������ǣ���һ��showmodal���壬���رպ��Զ�����һ��show���壬��ʱ����Ҳ�ͷ��ˣ���Ҫ������Ľ����ģ��ļ����¼�������򿪼���
         FormMain.FreeEncrypt(FsModeName);      
    end;
    (*end else begin
       //�ڱ�������Ǻͷ�ʱ������ر���Ϣ�ᴥ�������¼��ܿ����ѱ��ͷţ�������Ҫ���´����¼���
       if not InitEncrypt(True) then Exit;
       iResult := TQueryReport.OpenReport(sGnflMc, '',  false);
       if iResult=0 then begin
          //if rMainSub.GsPriReportModName<>FsModeName then
          //   FreeAndnil(AnyiClient1);
       end else if iResult=1 then begin
          CreateAnyiClient;  //�ڱ�������Ǻͷ�ʱ������ر���Ϣ�ᴥ�������¼��ܿ����ѱ��ͷţ�������Ҫ���´����¼���
       end else if iResult=2 then  //���ܴ򿪣����ͷ���ǰ�����ļ������ӣ�����Ҫ�ͷ��Ѵ򿪵ĸ�ģ��ļ���
          if rMainSub.GsPriReportModName<>FsModeName then
             FreeAndnil(AnyiClient1);
    end;  *)
//  end; 

end;

function TUIR9_IMPL.CloseDLL: Integer;
begin
  Result := -1;
  FreeAndNil(Anyiclient1);
  //if not FIsBPL then Exit;
  (*try
    if rMainSub.bFreeBpl then begin
      if FBPL_Handle<>0 then begin
         UnloadPackage(FBPL_Handle);  //�ͷŰ��Ժ���ټ��ذ����ᵼ��,��SingletonSet��Ԫ�ĳ�����ֵΪ�գ��Լ���������
         FBPL_Handle := 0;
      end;
    end else begin  //���ͷŰ�������ڹر�������ʱ����ִ��ÿ��ģ���CloseDLL�������������ͷ�ģ�鼰����
      if Assigned(Global_Mode) then
         FreeAndNil(Global_Mode);
    end;
  except
  end;
  Global_Mode := nil;
  Result :=1;  *)
end;

constructor TUIR9_IMPL.Create(LibPath: PChar; psModeName: string);
begin
  inherited Create;
  FLibPath := StrPas(LibPath);
  if Uppercase(ExtractFileExt(FLibPath)) = '.BPL' then
    FExeType := etBPL
  else if Uppercase(ExtractFileExt(FLibPath)) = '.EXE' then
    FExeType := etEXE
  else if Uppercase(ExtractFileExt(FLibPath)) = '.DLL' then
    FExeType := etDLL
  {���ӱ���򿪷�ʽ}
  else if (Uppercase(ExtractFileExt(FLibPath)) = '.CLL') and (psModeName = 'AQR') then
    FExeType := etReport
  else if psModeName = 'APT' then
    FExeType := etAPT
  else if psModeName = 'APP' then
    FExeType := etAPP
  else
    FExeType := etNone;
  {hch �Զ��屨��ģʽ}
  if (psModeName = 'BKA') then
    FExeType := etCustomRpt;
  if (psModeName = 'MIDS') then   //added by guozy 2012-02-17
    FExeType := etExe;  //MIDS;  // Modified by guozy 2013/6/19
  //if (psModeName = 'GE') then FExeType := etGE;
  FBPL_Handle := 0;
  FsModeName := psModeName;
  Global_Mode := nil;
end;

function TUIR9_IMPL.GetParms: string;
var
  DBParams:String;
begin
  Result := Result + ' "' + GCzy.name + '"';
  Result := Result + ' "' + TString.EncryptSTR(GCzy.Password) + '"';
  Result := Result + ' "' + GszYWRQ + '"';
  if GszZth <> '' then
    Result := Result + ' "' + GszZth + '"'
  else
    Result := Result + ' " "';
  if GszZTMC <> '' then
    Result := Result + ' "' + GszZTMC + '"'
  else
    Result := Result + ' " "';
  if GszGSDM <> '' then
    Result := Result + ' "' + GszGSDM + '"'
  else
    Result := Result + ' " "';
  if GszHSDWMC <> '' then
    Result := Result + ' "' + GszHSDWMC + '"'
  else
    Result := Result + ' " "';
  Result := Result + ' "' + GszServerComputer + '"';
  Result := Result + ' "' + GszServerPort + '"';

  if gsSingleMode = '1' then
  begin
    with TStringList.Create do
    begin
      Values['ServerName'] := GsServerName;
      Values['DatabaseName'] := GsDatabaseName;
      Values['UserName'] := GsUserName;
      Values['Password'] := gsPassWord;
      DBParams := StringReplace(Text,#13#10,'&',[rfReplaceAll]);
      Free;
    end;
    Result := Result + ' "'+DBParams+'"';
    Result := Result + ' "AUTO"'
  end
  else
  begin
    Result := Result + ' "0"';
    Result := Result + ' "' + GszConType + '"';
  end;
  if GDBType = MSSQL then
    Result := Result + ' "MSSQL"'
  else
    Result := Result + ' "ORACLE"';  
end;

{ TslUIR9_IMPL }

constructor TslUIR9_IMPL.Create(AppPath: string);
begin
  inherited Create;
  FslUIR9 := TStringList.Create;
  FDllFile := TDllFile.Create;
  FDllFile.ReadIniFile(AppPath + cR9_FILECONFIG);
  FAppPath := AppPath;
end;

function TslUIR9_IMPL.ActiveForm(psModeName: string): Boolean;
var
  i: Integer;
  FUIR9_IMPL: TUIR9_IMPL;
  ShowForm: TShowForm;
  Global_Mode : TPublicMod;
begin
  Result := False;
  for i := 0 to FslUIR9.Count - 1 do
  begin
    FUIR9_IMPL := TUIR9_IMPL(FslUIR9.Objects[i]);

    if (FUIR9_IMPL <> nil) and (FUIR9_IMPL.FExeType = etBPL)
      and (FUIR9_IMPL.FBPL_Handle <> 0)
      and (FUIR9_IMPL.FsModeName = psModeName) then
    begin
      @ShowForm := GetProcAddress(FUIR9_IMPL.FBPL_Handle, 'ShowForm');
      if Assigned(ShowForm) then
      begin
        rMainSub.GsActiveModName := psModeName;
        Global_Mode := ShowForm('', True);
        Result := True;
        if (Global_Mode<>nil) and Global_Mode.FbDBProcess then //Ҫ���¸����´�����Ϣ
           FormMain.UpdateDBSY(True,Global_Mode.FsModeName);        
      end;
    end;
  end;
end;

function TslUIR9_IMPL.CreateUIR9(psModuleName, sGnflExec: string): TUIR9_IMPL;
var
  i: integer;
  FUIR9_IMPL: TUIR9_IMPL;
  sPathFile:string;
  bExist:Boolean;
  BPL_Handle_Temp: HMODULE;  
begin
  FUIR9_IMPL := nil;
  Result := nil;

  if (sGnflExec = '')
    //and (psModuleName<>'MIDS')   //added by guozy 2012-02-27
    and (psModuleName<>'BKA')
    and (psModuleName<>'AQR')
     then
  begin //��������ʶ��bpl�ļ���ʽ
    sGnflExec := FDllFile.GetDllName(psModuleName);
    if  (Trim(sGnflExec) = '') then
      Exit;
  end;

  //==��Ϊ���ܴ�������ģ�飬����һ��BPL�ļ�������Ҫ��ģ����������
  bExist := False;
  BPL_Handle_Temp := 0;
  //zhengjy 2014-05-21 ��Ԥ������ģ����Ԥ��ִ�з���ģ�鹦�ܺϲ�����ʹ��ͬһ������
  if (psModuleName = 'BKA')  then    sPathFile :=FAppPath
  else
    sPathFile := FAppPath + sGnflExec;
  for i:=0 to FslUIR9.Count-1 do begin
      if (FslUIR9[i]=sPathFile) then begin   //bpl�Ѿ��򿪹�
         BPL_Handle_Temp := TUIR9_IMPL(FslUIR9.Objects[i]).FBPL_Handle;

         if (TUIR9_IMPL(FslUIR9.Objects[i]).FsModeName=psModuleName) then begin
            bExist := True;
            Break;
         end;
      end;
  end;

  //i := FslUIR9.IndexOf(FAppPath + sGnflExec); if i < 0 then
  if not bExist then begin
    //zhengjy 2014-05-21 ��Ԥ������ģ����Ԥ��ִ�з���ģ�鹦�ܺϲ�����ʹ��ͬһ������
    if (psModuleName = 'BKA')  then
    begin
      FUIR9_IMPL := TUIR9_IMPL.Create(PChar(FAppPath), psModuleName);
      FUIR9_IMPL.FsBPLName := ''; //FUIR9_IMPL.FR9_DLLHandle:=0;
      FslUIR9.AddObject(FAppPath, FUIR9_IMPL);
    end else begin
      FUIR9_IMPL := TUIR9_IMPL.Create(PChar(FAppPath + sGnflExec), psModuleName);
      FUIR9_IMPL.FsBPLName := sGnflExec; //FUIR9_IMPL.FR9_DLLHandle:=0;
      FslUIR9.AddObject(FAppPath + sGnflExec, FUIR9_IMPL);
    end;
    if BPL_Handle_Temp<>0 then //��bpl�Ѿ��򿪹������ȡ����
       FUIR9_IMPL.FBPL_Handle := BPL_Handle_Temp;
    Result := FUIR9_IMPL;
    FUIR9_IMPL := nil;
    {hch ֻ��G�汾�������ظ��²���}
    if (GpsSeries = psR9i) and (GsSingleMode='0') then
    begin
      try
        if GCU = nil then
        begin
          GCU := TClientUpdate.Create(FServerURL);
          GCU.FAppPath := ExtractFilePath(Application.ExeName);
        end;
      except
        on e: exception do
        begin
        
        end;
      end;
      if (GCU<>nil) and GCU.Check(psModuleName) then
        GCU.Update;
    end;
  end
  else
    Result := TUIR9_IMPL(FslUIR9.Objects[i]);
end;

procedure TslUIR9_IMPL.DeleteUIR9(psModuleName: string; DLLHandle: HWND); //�ú�����ֻ������ж�ؼ���֮�ã���Ҫд�������룬by �����Ƽ��ܵ����޸� 2011.11.14
var
  i: integer;
  FUIR9_IMPL: TUIR9_IMPL;
  sBPLFile: string;
begin //if not rMainSub.bFreeBpl then begin  exit; end;
  for i := 0 to FslUIR9.Count - 1 do
  begin //ж��ģ�飺Ŀǰ���ͷŰ���ֻ�ͷż���
    FUIR9_IMPL := TUIR9_IMPL(FslUIR9.Objects[i]);
    if (FUIR9_IMPL.FsModeName = psModuleName) then
    begin
    //modified by chengjf 20120912 ��Ƽ��ܲ������⴦��
//      if GetISXCZB and (FUIR9_IMPL.FsBPLName<>rMainSub.GsCurBplName) then //ģ����ͬ��bpl��ͬ���ͷ�
//         Continue;
         
      if (FUIR9_IMPL.Global_Mode <> nil) {or (FUIR9_IMPL.FsModeName='APT')} then
         FUIR9_IMPL.Global_Mode.FreeEncrypt;

      if FUIR9_IMPL.Anyiclient1<>nil then begin
         try
           FreeAndNil(FUIR9_IMPL.Anyiclient1);
         except
         end;  
      end;

      Break;
    end;
  end;
  (*if psModuleName = '' then begin   //���ڹر�ģ��ʱ���Ѳ��ͷŰ��ˣ������´�����ɾ
     for i := 0 to FslUIR9.Count - 1 do begin
       FUIR9_IMPL := TUIR9_IMPL(FslUIR9.Objects[i]);
       if (FUIR9_IMPL<>nil) and (FUIR9_IMPL.FR9_DLLHandle = DLLHandle) then begin
          try
            FUIR9_IMPL.CloseDLL;
          except
          end;
          try
            FreeAndNil(FUIR9_IMPL);
          except
          end;
          FslUIR9.Objects[i] := nil;
          FslUIR9.Delete(i);
          FUIR9_IMPL := nil;
       end;
     end;
   end else begin
  FUIR9_IMPL := nil;
  if FUIR9_IMPL.sBPLName='' then
       sBPLFile := FDllFile.GetDllName(psModuleName)   //�ӱ����ļ�ȡ
  else sBPLFile := FUIR9_IMPL.sBPLName;

  i := FslUIR9.IndexOf(FAppPath + sBPLFile);
  if i >= 0 then begin
    FUIR9_IMPL := TUIR9_IMPL(FslUIR9.Objects[i]);

    if FUIR9_IMPL <> nil then begin
      try
        FUIR9_IMPL.CloseDLL;
      except
      end;
      try
        FreeAndNil(FUIR9_IMPL);
      except
      end;
    end;
    FslUIR9.Objects[i] := nil;
    FslUIR9.Delete(i);
    FUIR9_IMPL := nil;
  end;  *)
end;

destructor TslUIR9_IMPL.Destroy;
var
  i: integer;
  FUIR9_IMPL: TUIR9_IMPL;
begin
  try
    if FslUIR9.Count > 0 then
    begin
      for i := FslUIR9.Count - 1 downto 0 do
      begin
        FUIR9_IMPL := TUIR9_IMPL(FslUIR9.Objects[i]);
        FUIR9_IMPL.CloseDLL;
        FreeAndNil(FUIR9_IMPL);
        FslUIR9.Objects[i] := nil;
        FUIR9_IMPL := nil;
      end;
    end;
    if Assigned(FslUIR9) then
      FreeAndNil(FslUIR9);
    if Assigned(FDllFile) then
      FreeAndNil(FDllFile);
  except
  end;
  inherited;
end;

function TslUIR9_IMPL.GetValue(const ModuleName: string): TUIR9_IMPL;
var
  i: Integer;
  sBPLFile,sPathFile: string;
  bExist:Boolean;
begin
  result := nil;
  sBPLFile := '';
  for i := 0 to FslUIR9.Count - 1 do
  begin
    if TUIR9_IMPL(FslUIR9.Objects[i]).FsModeName = ModuleName then
       sBPLFile := TUIR9_IMPL(FslUIR9.Objects[i]).FsBPLName;
  end;

  if sBPLFile = '' then
  begin //������R9_FILECONFIG�ļ��������ڵ�����
    sBPLFile := FDllFile.GetDllName(ModuleName);
  end;

  if sBPLFile = '' then
     exit;

  bExist := False;
  sPathFile := FAppPath + sBPLFile;
  for i:=0 to FslUIR9.Count-1 do begin
      if (FslUIR9[i]=sPathFile) then begin   //bpl�Ѿ��򿪹�
         if (TUIR9_IMPL(FslUIR9.Objects[i]).FsModeName=ModuleName) then begin
            bExist := True;
            Break;
         end;
      end;
  end;

  //i := FslUIR9.IndexOf(FAppPath + sBPLFile); if i >= 0 then
  if bExist then
     Result := TUIR9_IMPL(FslUIR9.Objects[i]);
end;

procedure TslUIR9_IMPL.SetServerURL(const Value: string);
begin
  FServerURL := Value;
end;

procedure TslUIR9_IMPL.SetValue(const ModuleName: string; const Value: TUIR9_IMPL);
var
  I: integer;
  sBPLFile,sPathFile: string;
  bExist:Boolean;
begin
  sBPLFile := FDllFile.GetDllName(ModuleName);
  if sBPLFile = '' then
     exit;

  bExist := False;
  sPathFile := FAppPath + sBPLFile;
  for i:=0 to FslUIR9.Count-1 do begin
      if (FslUIR9[i]=sPathFile) then begin   //bpl�Ѿ��򿪹�
         if (TUIR9_IMPL(FslUIR9.Objects[i]).FsModeName=ModuleName) then begin
            bExist := True;
            Break;
         end;
      end;
  end;
       
  //I := FslUIR9.IndexOf(FAppPath + sBPLFile); if I < 0 then
  if not bExist then
     FslUIR9.AddObject(FAppPath + sBPLFile, Value);
end;

// For Client AutoUpdate, Added by gh, 2013.05.23
function TslUIR9_IMPL.CheckUpdate(const ModName: string; CheckOnly: Boolean): Boolean;
begin
  Result := False;
  if (GpsSeries <> psR9i) or (ModName = '') then Exit;
  with TClientUpdate.Create(FServerURL) do
  try
    FAppPath := ExtractFilePath(Application.ExeName);
    Result := Check(ModName);
    if Result and not CheckOnly then Update;
  finally
    Free;
  end;
end;

{ TDllFile }

constructor TDllFile.Create;
begin
  inherited Create;
  if not Assigned(FslFile) then
    FslFile := TStringList.Create;
end;

destructor TDllFile.destroy;
begin
  if Assigned(FslFile) then
    FreeAndNil(FslFile);
  inherited;
end;

function TDllFile.GetDllName(GszVersion: string): string;
begin
  Result := FslFile.Values[GszVersion];
end;

function TDllFile.ReadIniFile(FilePath: string): Integer;
var
  iniFile: TiniFile;
  i: integer;
begin
  if not FileExists(FilePath) then
  begin
    Result := -1; //�ļ�·��������
    Exit;
  end;
  iniFile := TIniFile.Create(FilePath);
  IniFile.ReadSectionValues('R9_FILECONFIG', FslFile);
end;

{ TMergerMenu }

function TMergerMenu.AddChildMenuItem(AMenuItem,
  ParentMenuItem: TMenuItem): Boolean;
var
  i, iPos: Integer;
  sItem, sParent: string;
  NewMenu, FParentMenuItem: TMenuItem;
begin
  Result := False;
  if AMenuItem = nil then
    exit;
  FParentMenuItem := ParentMenuItem;
  if AMenuItem.Count > 0 then
  begin
    if not FindMenuItem(AMenuItem.Caption) then
    begin
      NewMenu := TMenuItem.Create(FOwner);
      with NewMenu do
      begin
        Caption := AMenuItem.Caption;
        MenuIndex := AMenuItem.MenuIndex;
        GroupIndex := AMenuItem.GroupIndex;
      end;
      ParentMenuItem.Add(NewMenu);
      FParentMenuItem := NewMenu;
    end;
    for i := 0 to AMenuItem.Count - 1 do
      AddChildMenuItem(AMenuItem.Items[i], FParentMenuItem);
  end
  else
  begin
    NewMenu := TMenuItem.Create(FOwner);
    with NewMenu do
    begin
      Caption := AMenuItem.Caption;
      ShortCut := AMenuItem.ShortCut;
      OnClick := FOnClick;
      MenuIndex := AMenuItem.MenuIndex;
      GroupIndex := AMenuItem.GroupIndex;
    end;
    FParentMenuItem.Add(NewMenu);
  end;
end;

constructor TMergerMenu.Create(Owner: TControl; MainMenu: TMainMenu);
var
  i: Integer;
begin
  inherited create;
  FDesMenu := MainMenu;
  FOwner := Owner;
  FSlMenu := TStringList.Create;
  for i := 0 to FDesMenu.Items.Count - 1 do
    FSlMenu.Add(FDesMenu.Items[i].Name + FDesMenu.Items[i].Caption);
end;

destructor TMergerMenu.destroy;
begin
  FSurMenu := nil;
  FDesMenu := nil;
  if Assigned(FSlMenu) then
    FreeAndNil(FSlMenu);
  inherited;
end;

function TMergerMenu.FindMenuCaption(sCaption: string;
  AMenuItem: TMenuItem): Boolean;
var
  i: Integer;
begin
  result := False;
  if AMenuItem.Count > 0 then
  begin
    if sCaption = AMenuItem.Caption then
    begin
      result := true;
      exit;
    end;
    for i := 0 to AMenuItem.Count - 1 do
      FindMenuCaption(sCaption, AMenuItem.Items[i]);
  end;
end;
//�����Ʋ��Ҳ˵�����Ƿ����

function TMergerMenu.FindMenuItem(sCaption: string): boolean;
var
  i: Integer;
begin
  for i := 0 to FDesMenu.Items.Count - 1 do
  begin
    if FDesMenu.Items[i].Caption = sCaption then
    begin
      result := true;
      exit;
    end;
    result := FindMenuCaption(sCaption, FDesMenu.Items[i]);
  end;
end;

function TMergerMenu.MergerMenu(SurMenu: TMainMenu; OverWrite: Boolean = False): boolean;
var
  i: integer;
  NewMenu: TMenuItem;
begin
  if OverWrite then
    FDesMenu.Items.Clear
  else
    RecoverMenu;
  FSurMenu := SurMenu;
  for i := 0 to FSurMenu.Items.Count - 1 do
  begin
    if FSurMenu.Items = nil then
      Exit;
    NewMenu := TMenuItem.Create(FOwner);
    with NewMenu do
    begin
      Caption := FSurMenu.Items[i].Caption;
      MenuIndex := FSurMenu.Items[i].MenuIndex;
      GroupIndex := FSurMenu.Items[i].GroupIndex;
    end;
    if OverWrite then
      FDesMenu.Items.Add(NewMenu)
    else
      FDesMenu.Items.Insert(i + 1, NewMenu);
    AddChildMenuItem(FSurMenu.Items[i], NewMenu);
  end;
end;

procedure TMergerMenu.RecoverMenu;
  function FindMenuItemExist(MenuName: string): Boolean;
  begin
    result := false;
    if FSlMenu.IndexOf(MenuName) >= 0 then
      Result := True;
  end;
var
  i: Integer;
begin
  for i := FDesMenu.Items.Count - 1 downto 0 do
  begin
    if not FindMenuItemExist(FDesMenu.Items[i].Name + FDesMenu.Items[i].Caption) then
    begin
      FDesMenu.Items[i].Clear;
      FDesMenu.Items.Delete(i);
    end;
  end;
end;
{ TClientUpdate }

function TClientUpdate.Check(ModName: string): Boolean;
var
  ServerUpInfo, ClientUpInfo: TList;
begin
  if FServerURL = '' then
  begin
    Result := False;
    Exit;
  end;
  ServerUpInfo := TList.Create;
  ClientUpInfo := TList.Create;
  try
    FUpFileLst.Clear;
    //�����ͻ��˸����ļ��ͷ������˸����ļ������бȽϣ�Ѱ����Ҫ���µ��ļ���
    ExtractFile(ServerUpInfo, IXMLS, ModName);
    ExtractFile(ClientUpInfo, IXMLC, ModName);
    //�ҳ���Ҫ���µ�ģ��
    FindDiff(ServerUpInfo, ClientUpInfo, FUpFileLst, FAppPath, FIsSetupBDE);
  finally
    ClientUpInfo.Free;
    ServerUpInfo.Free;
  end;
  FModName := ModName;
  Result := FUpFileLst.Count > 0;
end;

function loadXMLStream(const xmlStream: TStream): IXMLDOMDocument;
var
  sts: TStrings;
begin
  sts := TStringList.Create;
  try
    Result := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
    sts.LoadFromStream(xmlStream);
    Result.loadXML(sts.text);
  finally
    sts.Free;
  end;
end;

function loadXMLFile(const XmlFileName: string): IXMLDOMDocument;
begin
  Result := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  Result.load(XmlFileName);
end;

function IsSetupBDE: Boolean;
var
  aRegIni: TRegIniFile;
  RegValue: string;
begin
  aRegIni := TRegIniFile.Create;
  try
    RegValue := '';
    aRegIni.RootKey := HKEY_LOCAL_MACHINE;
    RegValue := aRegIni.ReadString('\Software\Borland\BLW32', 'BLAPIPATH', '');
    Result := RegValue <> '';
  except
    Result := False;
  end;
end;

function getNodeAttr(node: IXMLDOMNode; const attrName,
  defRet: string): string;
var
  attrNode: IXMLDOMNode;
begin
  Result := defRet;
  if node = nil then
    exit;
  attrNode := node.attributes.getNamedItem(attrName);
  if attrNode = nil then
    exit;
  Result := attrNode.text;
end;

constructor TClientUpdate.Create(ServerURL: string); // DSL
var
  sWinPath: array[1..255] of char;
  ServerUpInfo, ClientUpInfo: TList;
  xmlNode: IXMLDOMNode;
  sPathFile,sPathFileOld:string;
  bpath,bPathOld:Boolean;
  OldXmlFile, NewXmlFile: string;
begin
  //�������¶���
  FUpFileLst := TList.Create;
  //�����ַ������������XML�ĵ�
  FServerURL := ServerURL;
  FIsSetupBDE := IsSetupBDE;

  GetSystemDirectory(@sWinPath, 255);
  FClientXMLPath := Trim(sWinPath);
  FillChar(sWinPath,255,#0);
  GetWindowsDirectory(@sWinPath, 255);
  FWindowsPath := Trim(sWinPath);

 // �����ɰ汾�������ļ�, Added by gh, 2013.05.23
  OldXmlFile := FClientXMLPath + '\' + GetHttpURL(GszServerComputer) + cAutoXML;
  NewXmlFile := FClientXMLPath + '\' + GetClientXmlFileName;
  if FileExists(OldXmlFile) and not FileExists(NewXmlFile) then
    RenameFile(OldXmlFile, NewXmlFile);

  //����������ļ��������ļ������浽�ͻ���
  bpath := False; bPathOld:= False;
  
  sPathFile := FClientXMLPath + '\' + GetClientXmlFileName;
  bpath := FileExists(sPathFile);

  //sPathOld := FClientXMLPath + '\' + GetHttpURL(GszServerComputer) + cAutoXML; bPathOld := FileExists(sPathOld);
  if not bpath then begin //if not FileExists(FClientXMLPath + '\' + GetHttpURL(GszServerComputer) + cAutoXML) then
    if Pos('http://', lowercase(GszServerComputer)) > 0 then
    begin
      if FServerURL = '' then
         FServerURL := StringReplace(GszServerComputer, 'Proxy', '', []);   //
      IXMLC := LoadFile(cAutoXML);
      IXMLC.save(sPathFile);  //IXMLC.save(FClientXMLPath + '\' + GetHttpURL(GszServerComputer) + cAutoXML);
    end;
  end else begin
    IXMLC := loadXMLFile(sPathFile); //IXMLC := loadXMLFile(FClientXMLPath + '\' + GetHttpURL(GszServerComputer) + cAutoXML);    
  end;

  //������ݵ�URLΪ��
  if ServerURL = '' then
  begin
    FServerURL := GetHttpURLPort(GszServerComputer);//2011.12.5 hy
    if FServerURL = '' then
    begin
    xmlNode := IXMLC.selectSingleNode('data/DataSource');
    if xmlnode <> nil then
    begin
      if getNodeAttr(xmlNode, 'ServerURL', '') <> '' then
        FServerURL := getNodeAttr(xmlNode, 'ServerURL', '');
    end;
    if FServerURL = '' then
      FServerURL := StringReplace(GszServerComputer, 'Proxy', '', []);
    end;
  end;

  IXMLS := LoadFile(sAutoXML);
end;

destructor TClientUpdate.Destroy;
begin
  //�ͷŶ���
  FUpFileLst.Free;
  IXMLS := nil;
  IXMLC := nil;
end;

procedure TClientUpdate.ExtractFile(var lst: TList; I: IXMLDOMDocument;
  FProductName: string);
var
  Node: IXMLDOMNode;
  Nodelst: IXMLDOMNodeList;
  UpInfo: TClientInfo;
  iCount: integer;
begin
  try
    Node := I.selectSingleNode('data/' + FProductName);
  except
  end;

  if Node <> nil then
  begin
    if Node.hasChildNodes then
      Nodelst := Node.childNodes
    else
      Exit;
    Node := Nodelst.nextNode;
    while Node <> nil do
    begin
      UpInfo := TClientInfo.Create;
      UpInfo.NodeId := Node.nodeName;
      UpInfo.IsReplace := False;
      UpInfo.IsRegister := False;
      for iCount := 0 to Node.attributes.length - 1 do
      begin
        if uppercase(Node.attributes[iCount].nodeName) = uppercase('SetupPath') then
          UpInfo.SetupPath := Node.attributes[iCount].NodeValue;
        if uppercase(Node.attributes[iCount].nodeName) = uppercase('Version') then
          UpInfo.Version := Node.attributes[iCount].NodeValue;
        if uppercase(Node.attributes[iCount].nodeName) = uppercase('fileName') then
          UpInfo.fileName := Node.attributes[iCount].NodeValue;
        if uppercase(Node.attributes[iCount].nodeName) = uppercase('IsReplace') then
          UpInfo.IsReplace := Node.attributes[iCount].NodeValue = '1';
        if uppercase(Node.attributes[iCount].nodeName) = uppercase('IsRegister') then
          UpInfo.IsRegister := Node.attributes[iCount].NodeValue = '1';
        if uppercase(Node.attributes[iCount].nodeName) = uppercase('Script') then
          UpInfo.Script := Node.attributes[iCount].NodeValue;
        if uppercase(Node.attributes[iCount].nodeName) = uppercase('AutoRun') then
          UpInfo.AutoRun := Node.attributes[iCount].NodeValue;
      end;
      lst.Add(UpInfo);
      Node := Nodelst.nextNode;
    end;
  end;
end;

procedure TClientUpdate.FindDiff(slst, clst: TList; var uplst: TList;
  FDefaultPath: string; FIsSetupBDE: Boolean);
var
  iCount, jCount: integer;
  find: Boolean;
  function Exist(fileName, SetPath: string): Boolean;
  var
    sPath: string;
  begin
    //����SetPath·����֧��\client\�ļ��з�ʽ  Modified by chengjf 2016-06-21
    //sPath := FDefaultPath;
    sPath := ExpandFileName(FDefaultPath + '\..') + SetPath;

    //if sPath[length(sPath)] = '\' then
      sPath := StringReplace(sPath, '\\', '\', []);
    //else
      //sPath := sPath;
    //�ļ�
    if Pos('.', fileName) > 0 then
    begin
      if uppercase(SetPath) = uppercase('#System32') then
        Result := FileExists(FClientXMLPath + '\' + fileName)
      else if uppercase(SetPath) = uppercase('#windows') then
        Result := FileExists(FWindowsPath + '\' + fileName)
      else if uppercase(SetPath) = uppercase('#BDE') then
        Result := FIsSetupBDE
      else
        Result := fileExists(sPath + '\' + fileName);
    end
      //�ļ���
    else
    begin
      if uppercase(SetPath) = uppercase('#System32') then
      begin
        Result := DirectoryExists(FClientXMLPath + '\' + fileName);
      end
      else if uppercase(SetPath) = uppercase('#windows') then
        Result := DirectoryExists(FWindowsPath + '\' + fileName)
      else
        Result := DirectoryExists(sPath + '\' + fileName);
    end;
  end;
begin
  for iCount := 0 to slst.Count - 1 do
  begin
    find := False;
    for jCount := 0 to clst.Count - 1 do
    begin
      if Uppercase(TClientInfo(slst[iCount]).NodeId) = Uppercase(TClientInfo(clst[jCount]).NodeId) then
      begin
        if (TClientInfo(slst[iCount]).Version > TClientInfo(clst[jCount]).Version)
          and TClientInfo(slst[iCount]).IsReplace then
        begin
          uplst.Add(slst[iCount]);
        end;
        if not Exist(TClientInfo(slst[iCount]).NodeId, TClientInfo(slst[iCount]).SetupPath) then
          uplst.Add(slst[iCount]);
        find := True;
        break;
      end;
    end;
    if not find then
      uplst.Add(slst[iCount]);
  end;
end;

function TClientUpdate.findNode(Nodes: TList; NodeId: string): integer;
var
  iCount: integer;
begin
  Result := -1;
  for iCount := 0 to Nodes.Count - 1 do
  begin
    if Uppercase(TClientInfo(Nodes[iCount]).NodeId) = Uppercase(NodeId) then
    begin
      result := iCount;
      break;
    end;
  end;
end;

procedure TClientUpdate.SetAppPath(const Value: string);
begin
  FAppPath := Value;
end;

function TClientUpdate.DownFile(Afile: string): Boolean;
var
  FHTTP: THTTPFile;
  tmpStream: TMemoryStream;
  tempURL: string;
begin
  try
    if (FServerURL[length(FServerURL)] = '/') then
      tempURL := FServerURL + 'clientfile/' + Afile
    else
      tempURL := FServerURL + '/clientfile/' + Afile;

    // ������ 2011.08.30 �������ֿ���û�IdHTTP�����ļ�������ΪHTTPFile���ط�ʽ��
    tmpStream := TMemoryStream.Create;
    try
      FHTTP := THTTPFile.Create;
      try
        FHTTP.GetURLFile(tempURL, tmpStream);
      finally
        FHTTP.Free;
      end;

      if not DirectoryExists(cTempPath) then
        ForceDirectories(cTempPath);

      tmpStream.Position := 0;
      tmpStream.SaveToFile(cTempPath + '\' + AFile);

    finally
      tmpStream.Free;
    end;
  except
    on E: Exception do
    begin
      MessageDlg('�ļ� "' + tempURL + '" �޷����ء�������Ϣ��' + #13#10 +
                 E.Message + #13#10#13#10 +
                 '�����ļ��Ƿ���ڣ��������Ƿ���ͨ��',
                 mtInformation, [mbOK], 0);
    end;
  end;
end;

function TClientUpdate.unzipFile(Aunzip: TVCLUnZip; AunzipFile, Afolder: string; IsReplace: Boolean): Boolean;
var
  sztemp: string;
  i: Integer;
  path: string;
begin
  Result := False;
  with Aunzip do
  begin
    DestDir := Afolder;
    RootDir := Afolder;
    if IsReplace then
      OverwriteMode := Always
    else
      OverwriteMode := ifNewer;
    RecreateDirs := True;
    ZipName := AunzipFile;
    DoAll := True;
    ReplaceReadOnly := True;
    i := 0;
    try
      UnZip;
    except
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

// For Client AutoUpdate, Added by gh, 2013.05.23
function TClientUpdate.GetClientXmlFileName: string;  // DSL
const
  cXmsFile = '%s_%s_%s';

  function GetPort(AURL: string): string;
  begin
    if Pos(UpperCase('http://'), Uppercase(AURL)) > 0 then
    begin
      Result := StringReplace(AURL, 'http://', '', [rfIgnoreCase]);
      Result := TString.LeftStrBySp(Result, '/');
      Result := TString.RightStrBySp(Result, ':');
    end;
  end;

begin
  Result := Format(cXmsFile, [GetHttpURL(GszServerComputer), GetPort(GszServerComputer), cAutoXML]);
end;

function WinExecAndWait(FileName: string; Visibility: integer): Thandle;
var
  zAppName: array[0..512] of char;
  zCurDir: array[0..255] of char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, Sizeof(StartupInfo), #0);
  StartupInfo.cb := Sizeof(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil, zAppName, nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
    nil, nil, StartupInfo, ProcessInfo) then
  begin
    Result := 0;
    exit;
  end
  else
  begin
    WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
  end;
end;

procedure setNodeAttr(node: IXMLDOMNode; const attrName,
  value: string);
var
  attrNode: IXMLDOMNode;
begin
  attrNode := node.attributes.getNamedItem(attrName);
  if attrNode = nil then
    exit;
  attrNode.text := value;
end;

function TClientUpdate.Update: Boolean;
var
  i: Integer;
  isaddpro, szproname, szfilename, szurl, szversion, soversion, szsetuppath, szscript, tempRoot: string;
  szmainfilePath, szmainfile: string;
  root, pnodec, fnodec, xmlNodeAtrr, childNode, xmlNode: IXMLDOMNode;
  System32Path: string;
  RegisterLst: TStringList;
  //hch �Ƿ����BDE��װ
  IsHaveBDE: Boolean;
  BDEFileName: string;
  {������Ŀ¼}
  FMainFile:String;
  dispName: string;
  szpro: string;
  VCLUnZip1: TVCLUnZip;
  procedure SetAttr(node, Attr, Value: string);
  var
    FRoot, FNode, FAttr: IXMLDOMNode;
  begin
    FRoot := IXMLC.selectSingleNode('data/' + szpro);
    FNode := IXMLC.selectSingleNode('data/' + szpro + '/' + node);
    if FNode = nil then
    begin
      FNode := IXMLC.createElement(node);
      pnodec.appendChild(FNode);
    end;
    FAttr := FNode.attributes.getNamedItem(Attr);
    if FAttr = nil then
    begin
      FAttr := IXMLC.createAttribute(Attr);
      FNode.attributes.setNamedItem(FAttr);
    end;
    FAttr.Text := Value;
  end;

  procedure UpOtherNode;
  var
    FRoot, FChild, FAttr: IXMLDOMNode;
    Index: integer;
  begin
    FRoot := IXMLC.selectSingleNode('data');
    FRoot := FRoot.Get_firstChild;
    while FRoot <> nil do
    begin
      if FRoot.hasChildNodes then
      begin
        FChild := FRoot.Get_firstChild;
        while FChild <> nil do
        begin
          Index := FindNode(FUpFileLst, FChild.nodeName);
          if index >= 0 then
          begin
            FAttr := FChild.attributes.getNamedItem('version');
            if FAttr <> nil then
              FAttr.nodeValue := TClientInfo(FUpFileLst[index]).version;
          end;
          FChild := FChild.nextSibling;
        end;
      end;
      FRoot := FRoot.nextSibling;
    end;
  end;
begin
  IsHaveBDE := False;
  System32Path := FClientXMLPath;
  RegisterLst := TStringList.Create;

  xmlNode := IXMLS.selectSingleNode('data/' + FModName);
  FMainfile := getNodeAttr(xmlNode, 'mainfile', FModName+'.exe');

  {���ظ���}
  for i := 0 to FUpFileLst.Count - 1 do
  begin
    if FIsSetupBDE and (TClientInfo(FUpFileLst[i]).setuppath = '#BDE') then
      continue
    else
    begin
      if (TClientInfo(FUpFileLst[i]).setuppath = '#BDE') then
        BDEFileName := cTempPath + '\' + TClientInfo(FUpFileLst[i]).fileName;
      DownFile(TClientInfo(FUpFileLst[i]).fileName);
      if Assigned(GCUProgress) then
        GCUProgress((i+1) * 50 div FUpFileLst.Count);
    end;
    szfilename := TClientInfo(FUpFileLst[i]).fileName;
    szscript := TClientInfo(FUpFileLst[i]).script;
  end;

  VCLUnZip1 := TVCLUnZip.Create(nil);
  for i := 0 to FUpFileLst.Count - 1 do
  begin
    szpro := FModName;
    szfilename := TClientInfo(FUpFileLst[i]).FileName;
    szsetuppath := TClientInfo(FUpFileLst[i]).setuppath;
    szversion := TClientInfo(FUpFileLst[i]).version;
    szscript := TClientInfo(FUpFileLst[i]).script;

    //����szsetuppath·����֧��\client\�ļ��з�ʽ  Modified by chengjf 2016-06-21
    //TempRoot := FAppPath;
    TempRoot := ExpandFileName(FAppPath + '\..') + szsetuppath;
    if (TClientInfo(FUpFileLst[i]).setuppath <> '#System32')
      and (TClientInfo(FUpFileLst[i]).setuppath <> '#BDE')
      and (TClientInfo(FUpFileLst[i]).setuppath <> '#windows') then
    begin
      if not DirectoryExists(TempRoot) then
        ForceDirectories(TempRoot);
    end;

    if TClientInfo(FUpFileLst[i]).setuppath = '#System32' then
    begin
      unzipFile(VCLUnZip1, cTempPath + '\' + szfilename,
        System32Path, TClientInfo(FUpFileLst[i]).IsReplace); //����
      if TClientInfo(FUpFileLst[i]).IsRegister then
      begin
        RegisterLst.Add(System32Path + '\' + StringReplace(szfilename, '.zip', '', [rfIgnoreCase]));
      end;
    end
    else if TClientInfo(FUpFileLst[i]).setuppath = '#windows' then
    begin
      unzipFile(VCLUnZip1, cTempPath + '\' + szfilename,
        FwindowsPath, TClientInfo(FUpFileLst[i]).IsReplace); //����
      if TClientInfo(FUpFileLst[i]).IsRegister then
      begin
        RegisterLst.Add(FwindowsPath + '\' + StringReplace(szfilename, '.zip', '', [rfIgnoreCase]));
      end;
    end
    else if TClientInfo(FUpFileLst[i]).setuppath = '#BDE' then
    begin
      IsHaveBDE := True;
      if not FIsSetupBDE then
        unzipFile(VCLUnZip1, cTempPath + '\' + szfilename, cTempPath, False); //����
    end
    else
    begin
      unzipFile(VCLUnZip1, cTempPath + '\' + szfilename, TempRoot, TClientInfo(FUpFileLst[i]).IsReplace); //����
      if TClientInfo(FUpFileLst[i]).IsRegister then
      begin
        RegisterLst.Add(TempRoot + '\' + StringReplace(szfilename, '.zip', '', [rfIgnoreCase]));
      end;
    end;
    if Uppercase(StringReplace(szfilename,'.zip','',[])) = Uppercase(FMainfile) then
    begin
      szmainfilePath :=tempRoot + IFF(tempRoot[length(tempRoot)]='\','', '\') + FMainfile;
      dispName :=  szscript;
    end;    
    //����Ƿ���Ҫ���б��ص�exe����
    if (TClientInfo(FUpFileLst[i]).AutoRun <> '') then
    begin
      if TClientInfo(FUpFileLst[i]).setuppath = '#System32' then
        szfilename := StringReplace(TClientInfo(FUpFileLst[i]).AutoRun, '#System32', System32Path, [rfIgnoreCase])
      else
      begin
        if TClientInfo(FUpFileLst[i]).AutoRun[1] = '\' then
          szfilename := TempRoot + TClientInfo(FUpFileLst[i]).AutoRun
        else
          szfilename := TempRoot + '\' + TClientInfo(FUpFileLst[i]).AutoRun;
      end;
      if (fileExists(szFileName)) then
      begin
        WinExecAndWait(szFileName, SW_NORMAL);
      end;
    end;
    if Assigned(GCUProgress) then
      GCUProgress(50 + (i+1) * 50 div FUpFileLst.Count);
  end;

  //������ɺ󣬸������ñ��������ļ�
  IXMLC := loadXMLFile(FClientXMLPath + '\' + GetClientXmlFileName);    // DSL
  root := IXMLC.Get_documentElement;
  //��װ����λ��
  pnodec := root.selectSingleNode('setup');
  if pnodec = nil then
  begin
    pnodec := IXMLC.createElement('setup');
    root.appendChild(pnodec);
  end;

  pnodec := root.selectSingleNode('DataSource');
  if pnodec = nil then
  begin
    pnodec := IXMLC.createElement('DataSource');
    root.appendChild(pnodec);
    xmlNodeAtrr := IXMLC.createAttribute('DatabaseType');
    pnodec.attributes.setNamedItem(xmlNodeAtrr);
  end;
  setNodeAttr(pnodec, 'DatabaseType', FDatabaseType);

  pnodec := root.selectSingleNode(szpro);
  //��ʼ�����س���
  if pNodec = nil then
  begin
    pnodec := IXMLC.createElement(szpro);
    root.appendChild(pnodec);
    xmlNodeAtrr := IXMLC.createAttribute('name');
    pnodec.attributes.setNamedItem(xmlNodeAtrr);
    xmlNodeAtrr.Set_nodeValue(dispName);
    xmlNodeAtrr := IXMLC.createAttribute('mainfile');
    pnodec.attributes.setNamedItem(xmlNodeAtrr);
    xmlNodeAtrr.Set_nodeValue(szmainfilePath);
  end
  else
  begin
    if szmainfilePath <> '' then
      setNodeAttr(pnodec, 'mainfile', szmainfilePath);
  end;
  //���½ڵ㣬���ÿһ���ڵ������
  for i := 0 to FUpFileLst.Count - 1 do
  begin
    SetAttr(TClientInfo(FUpFileLst[i]).NodeId, 'version', TClientInfo(FUpFileLst[i]).Version);
    SetAttr(TClientInfo(FUpFileLst[i]).NodeId, 'setupPath', TClientInfo(FUpFileLst[i]).setupPath);
    SetAttr(TClientInfo(FUpFileLst[i]).NodeId, 'script', TClientInfo(FUpFileLst[i]).script);
  end;
  //�����Ѿ���ģ��Ľڵ������ڵ����ݣ��������ظ�����
  UpOtherNode;

  IXMLC.Save(FClientXMLPath + '\' + GetClientXmlFileName);   // DSL
  try
    if RegisterLst.Count > 0 then
    begin
      for i := 0 to RegisterLst.Count - 1 do
      begin
        RegisterLst[i] := 'Regsvr32 /s "' + RegisterLst[i] + ' " ';
        WinExec(pchar(RegisterLst[i]), SW_HIDE);
      end;
    end;
  finally
    RegisterLst.free;
  end;
  WinExec(pchar('RD /S /Q "' + cTempPath + '"'), SW_NORMAL);
  VCLUnZip1.Free;
  //�ȴ���װBDE�ļ�
  if (not FIsSetupBDE) and IsHaveBDE then
  begin
    BDEFileName := StringReplace(BDEFileName, '.zip', '', [rfIgnoreCase]);
    if BDEFileName <> '' then
      WinExecAndWait(BDEFileName, SW_NORMAL);
  end;
  if Assigned(GCUProgress) then
    GCUProgress(100);
  Result := True;
end;

procedure TClientUpdate.SetDatabaseType(const Value: string);
begin
  FDatabaseType := Value;
end;

function TClientUpdate.LoadFile(AFileName: string): IXMLDOMDocument;
var
  Source: TMemoryStream;
  FHTTP : THTTPFile;
begin
  Source := TMemoryStream.Create;
  Result := nil;
  try
    if FServerURL <> '' then
    begin
      FHTTP := THTTPFile.Create;
      try
        if FServerURL[length(FServerURL)] = '/' then
          FHTTP.GetURLFile(FServerURL + AFileName, Source)
        else
          FHTTP.GetURLFile(FServerURL + '/' + AFileName, Source);
      finally
        FHTTP.Free;
      end;

      Source.Position := 0;
      if Source.Size > 0 then
        Result := loadXMLStream(Source);
    end;
  finally
    Source.Free;
  end;
end;

function TClientUpdate.GetHttpURL(AURL: string): string;
begin
  //  http://192.168.99.100:
  if Pos(Uppercase('http://'), Uppercase(AURL)) > 0 then
  begin
    Result := StringReplace(AURL, 'http://', '', [rfIgnoreCase]);
    Result := TString.LeftStrBySp(Result, ':');
  end
  else
    Result := AURL;
end;


function TClientUpdate.GetHttpURLPort(AURL: string): string;  //DSL
begin
  //  http://192.168.99.100:
  if Pos(Uppercase('http://'), Uppercase(AURL)) > 0 then
  begin
    Result := StringReplace(AURL, 'http://', '', [rfIgnoreCase]);
    Result := TString.LeftStrBySp(Result, '/');
    Result := 'http://' + Result;
  end
  else
    Result := AURL;
end;
{ THideMenu }

constructor THideMenu.Create;
begin
  FHideList := THashedStringList.Create;
end;

destructor THideMenu.Destroy;
begin
  FHideList.Free;
  inherited;
end;

procedure THideMenu.Init(AGSDM, AKJND:String);
var
  Cds:TClientDataSet;
begin
  FHideList.Clear;
  {����}
  InitCM(AGSDM, AKJND);
  {ȫ��Ԥ��}
  InitGBG(AGSDM, AKJND);
  {ָ�����}
  InitFBI(AGSDM, AKJND);
  {Զ������}
  InitYBC(AGSDM, AKJND);
  {�������}
  InitFBS(AGSDM, AKJND);  
  {�����ʲ�}
  initFA(AGSDM, AKJND);
  {����}
  InitPA(AGSDM, AKJND);
  {����}
  InitGL(AGSDM, AKJND);
  {Ʊ��}
  InitCHQ(AGSDM, AKJND);
  {��˰}
  InitNTMF(AGSDM, AKJND);
  {�ʽ�}
  InitBM(AGSDM, AKJND);
  {ȫ��Ԥ��ϵ��}
  InitGBI(AGSDM, AKJND);
  InitGBS(AGSDM, AKJND);
end;

procedure THideMenu.InitFast(AGSDM, AKJND, AModCode: string);
begin
  if SameText(AModCode, 'CM') then
    InitCM(AGSDM, AKJND);

  {ȫ��Ԥ��}
  if SameText(AModCode, 'GBG') then
    InitGBG(AGSDM, AKJND);

  {ָ�����}
  if SameText(AModCode, 'FBI') then
    InitFBI(AGSDM, AKJND);

  {�����ʲ�}
  if SameText(AModCode, 'FA') then
    InitFA(AGSDM, AKJND);

  {����}
  if SameText(AModCode, 'PA') then
    InitPA(AGSDM, AKJND);

  {����}
  if SameText(AModCode, 'GL') then
    InitGL(AGSDM, AKJND);

  {Ʊ��}
  if SameText(AModCode, 'CHQ') then
    InitCHQ(AGSDM, AKJND);

  {��˰}
  if SameText(AModCode, 'NTMF') then
    InitNTMF(AGSDM, AKJND);

  {�ʽ�}
  if SameText(AModCode, 'BM') then
    InitBM(AGSDM, AKJND);

end;

procedure THideMenu.InitFastTree(AGSDM, AKJND: string;tv: TTreeView);
  function FindLevel0Node(tv: TTreeView; aName: string): Boolean;
  var
    iCount: integer;
  begin
    Result := False;//nil;
    for iCount := 0 to tv.Items.Count - 1 do
    begin
      if tv.Items[iCount].Level = 0 then
      begin
        if (Pos(aName, tv.Items[iCount].Text) > 0) then
        begin
          Result := True; //tv.Items[iCount];
          break;
        end;
      end;
    end;
  end;  
begin
  if FindLevel0Node(tv,'����') then
     InitCM(AGSDM, AKJND);

  {ȫ��Ԥ��}
  if FindLevel0Node(tv,'ȫ��Ԥ��') then
    InitGBG(AGSDM, AKJND);

  {ָ�����}
  if FindLevel0Node(tv,'ָ�����') then  begin
    InitFBI(AGSDM, AKJND);
    InitGBI(AGSDM, AKJND);
  end;

  {Ԥ�����}
  if FindLevel0Node(tv,'Ԥ�����') then  begin
    InitGBS(AGSDM, AKJND);
  end;

  {�����ʲ�}
  if FindLevel0Node(tv,'�ʲ�') then
    InitFA(AGSDM, AKJND);

  {����}
  if FindLevel0Node(tv,'����') then
    InitPA(AGSDM, AKJND);

  {����}
  if FindLevel0Node(tv,'����') or FindLevel0Node(tv,'��Ԥ��') or FindLevel0Node(tv,'����') then
    InitGL(AGSDM, AKJND);

  {Ʊ��}
  if FindLevel0Node(tv,'Ʊ��') then
    InitCHQ(AGSDM, AKJND);

  {��˰}
  if FindLevel0Node(tv,'��˰') then
    InitNTMF(AGSDM, AKJND);

  {�ʽ�}
  if FindLevel0Node(tv,'�ʽ�') then
    InitBM(AGSDM, AKJND);
end;

procedure THideMenu.InitCM(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  {1.CM ��ȡ���ɵĲ��������в˵�����ʾ}
  Cds := DataModulePub.GetCdsBySQL('Select ztkz from CM_ZTCS where GSDM = '''+ AGSDM+''' and ztbh='''+gszzth+'''');
  try
    if copy(Cds.FieldByName('ztkz').Asstring, 1, 1) = '0' then
    begin
      FHideList.Values['0603'] := '������';
      FHideList.Values['060301'] := '�Ǽǳ�����';
      FHideList.Values['060302'] := '�ս�';
      FHideList.Values['060303'] := 'ȡ���ս�';
      FHideList.Values['060304'] := '�ֽ��ռ���';
      FHideList.Values['060305'] := '�����ռ���';
    end;
  finally
    Cds.Free;
  end;
end;
procedure THideMenu.InitCHQ(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE FROM PJ_PJCS WHERE  gsdm = '''+ AGSDM +''' and KJND='''+AKJND+''' and rtrim(CSDM)=''QYPJPH''');
  try
    if (not Cds.FindFirst) or
    ( Cds.FieldByName('CSVALUE').Asstring  <> '1' ) then
    begin
      FHideList.Values['180202'] := 'Ʊ�����Ŷ���';
    end;
  finally
    Cds.Free;
  end;
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE FROM PJ_PJCS WHERE  gsdm = '''+ AGSDM +''' and KJND='''+AKJND+''' and rtrim(CSDM)=''CHQ_PJLYZGSP''');
  try
    if (not Cds.FindFirst) or 
    ( Cds.FieldByName('CSVALUE').Asstring  <> '1' )then
    begin
      FHideList.Values['180305'] := 'Ʊ������';
    end;
  finally
    Cds.Free;
  end;
  
end;
procedure THideMenu.InitNTMF(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
  tmpother3,szAutoTZSNo:string;
begin
   tmpother3:='';
   szAutoTZSNo:='';
   if GDBtype=ORACLE then  begin
      FHideList.Values['200310'] := '��ѯ��������֪ͨ�������Ϣ';
      FHideList.Values['200506'] := '����MQ��������Ϣ��ѯ������';
      FHideList.Values['201106'] := '��ѯ��������֪ͨ�������Ϣ';
   end;
   Cds := DataModulePub.GetCdsBySQL('select * from nt_hsdw where gsdm=''' + AGSDM + ''' and KJND='''+ AKJND + '''');
  try
    tmpother3:=Cds.FieldByName('Other3').Asstring;
    if Copy(tmpother3,6,1)<>'1' then
    begin
      FHideList.Values['201201'] := '��ת֪ͨ��';
      FHideList.Values['2012'] := '��ת����';
    end;

    tmpother3:=Cds.FieldByName('OtherZT').Asstring;
    szAutoTZSNo := copy(tmpother3, pos('1[', tmpother3) + 2,pos(']1', tmpother3) - pos('1[', tmpother3) - 2);
    if szAutoTZSNo<>'1' then
    begin
      FHideList.Values['200205'] := '����Ʊ�ݱ༭';
      FHideList.Values['200206'] := '��ԱƱ�ݷ���༭';
    end;
   finally
    Cds.Free;
  end;
  if szAutoTZSNo='1' then
  begin
      Cds := DataModulePub.GetCdsBySQL('select count(*) icount from nt_NTMCS where  gsdm=''' + AGSDM + ''' and KJND=''' +AKJND +
             ''' and (rtrim(CSDM)=''NTPJSYR'' or rtrim(CSDM)=''NTPJSYRDW'') and CsValue=''1'' ');
      try
        if Cds.FieldByName('icount').AsInteger<1 then
        begin
           FHideList.Values['200206'] := '��ԱƱ�ݷ���༭';
        end;
      finally
        Cds.Free;
      end;
  end;
  Cds := DataModulePub.GetCdsBySQL('select CsValue from nt_NTMCS where  gsdm=''' + AGSDM + ''' and KJND=''' +AKJND +
         ''' and (rtrim(CSDM)=''NTMTZSZDZF''  )  ');
  try
    if (not Cds.FindFirst) or (Cds.FieldByName('CSVALUE').Asstring  <> '1') then
    begin
       FHideList.Values['200504'] := 'δ�ɿ�֪ͨ��';
    end;
  finally
    Cds.Free;
  end;
end;
procedure THideMenu.InitFBI(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
  blCSZBLRKCS:Boolean;
begin

  {1.FBI ��ȡ��ָ��Ĳ���--ָ�꼶�ι������в˵�����ʾ}
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FBI_CSZBLRKCS'' ');
  blCSZBLRKCS:=(Cds.FieldByName('CSVALUE').Asstring  = '1');
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FBI_ZBGLJC'' ');
  try
    if Cds.FieldByName('CSVALUE').Asstring  = '1' then
    begin
      FHideList.Values['0903'] := '��ָ�����';
      FHideList.Values['090301'] := '��ָ�����';
      FHideList.Values['090302'] := '��ָ��Ǽǲ�';
      FHideList.Values['090303'] := '��ָ������Ǽǲ�';
      FHideList.Values['090304'] := '��ָ�����';
      FHideList.Values['090305'] := '��ָ���´�';
      
      FHideList.Values['090801'] := '��ָ����ϸ��';
      FHideList.Values['090802'] := '��ָ����ܱ�';
      FHideList.Values['090803'] := '��ָ�������ϸ��';
      FHideList.Values['090804'] := '��ָ��ִ�б�';
      

      FHideList.Values['0904'] := '�ƴ���ָ�����';
      FHideList.Values['090401'] := '�ƴ���ָ�����';
      FHideList.Values['090402'] := '�ƴ���ָ��Ǽǲ�';
      FHideList.Values['090403'] := '�ƴ���ָ������Ǽǲ�';
      FHideList.Values['090404'] := '�ƴ���ָ�����';
      FHideList.Values['090405'] := '�ƴ���ָ���´�';      
      FHideList.Values['090406'] := '����������ָ��';  
      
      FHideList.Values['090805'] := '�ƴ���ָ����ϸ��';
      FHideList.Values['090806'] := '�ƴ���ָ����ܱ�';
      FHideList.Values['090807'] := '�ƴ���ָ�������ϸ��';
      FHideList.Values['090808'] := '�ƴ���ָ��ִ�б�';      
                      
      FHideList.Values['090510'] := '�������ɿƴ���ָ��';  
      
    end;
    if Cds.FieldByName('CSVALUE').Asstring  = '2' then
    begin
      if (not GetISXCZB) and (not blCSZBLRKCS) then begin  //U8����
          FHideList.Values['0904'] := '�ƴ���ָ�����';
          FHideList.Values['090401'] := '�ƴ���ָ�����';
          FHideList.Values['090402'] := '�ƴ���ָ��Ǽǲ�';
          FHideList.Values['090403'] := '�ƴ���ָ������Ǽǲ�';
          FHideList.Values['090404'] := '�ƴ���ָ�����';
          FHideList.Values['090405'] := '�ƴ���ָ���´�';

          FHideList.Values['090805'] := '�ƴ���ָ����ϸ��';
          FHideList.Values['090806'] := '�ƴ���ָ����ܱ�';
          FHideList.Values['090807'] := '�ƴ���ָ�������ϸ��';
          FHideList.Values['090808'] := '�ƴ���ָ��ִ�б�';

          FHideList.Values['090510'] := '�������ɿƴ���ָ��';
      end else begin              //U8�������
          FHideList.Values['0903'] := '��ָ�����';
          FHideList.Values['090301'] := '��ָ�����';
          FHideList.Values['090302'] := '��ָ��Ǽǲ�';
          FHideList.Values['090303'] := '��ָ������Ǽǲ�';
          FHideList.Values['090304'] := '��ָ�����';
          FHideList.Values['090305'] := '��ָ���´�';

          FHideList.Values['090801'] := '��ָ����ϸ��';
          FHideList.Values['090802'] := '��ָ����ܱ�';
          FHideList.Values['090803'] := '��ָ�������ϸ��';
          FHideList.Values['090804'] := '��ָ��ִ�б�';
 
          FHideList.Values['090406'] := '����������ָ��';
      end;

//      FHideList.Values['0903'] := '��ָ�����';
//      FHideList.Values['090301'] := '��ָ�����';
//      FHideList.Values['090302'] := '��ָ��Ǽǲ�';
//      FHideList.Values['090303'] := '��ָ������Ǽǲ�';
//      FHideList.Values['090304'] := '��ָ�����';
//      FHideList.Values['090305'] := '��ָ���´�';
//
//      FHideList.Values['090801'] := '��ָ����ϸ��';
//      FHideList.Values['090802'] := '��ָ����ܱ�';
//      FHideList.Values['090803'] := '��ָ�������ϸ��';
//      FHideList.Values['090804'] := '��ָ��ִ�б�';
//
//      FHideList.Values['090406'] := '����������ָ��';
    end;
  finally
    Cds.Free;
  end;
  {2.FBI ��ȡ��ָ��Ĳ���--ָ�굥�ʸ��ٿ��ƣ����в˵�����ʾ}
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FBI_ZBDBGZKZ'' ');
  try
    if Cds.FieldByName('CSVALUE').Asstring  = '0' then
    begin
      FHideList.Values['090507'] := 'ָ����';   
    end;    
  finally
    Cds.Free;
  end;
end;

//Զ�̹������ء�����
procedure THideMenu.InitYBC(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  {1.YBC ��ȡ��ר�����--�Ƿ����򣬽��в˵�����ʾ}
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FCP_DFXM'' ');
  try
    if Trim(Cds.FieldByName('CSVALUE').Asstring)  = '����' then
    begin
      // ���ز������빦��
      FHideList.Values['110201'] := '�����������';
      FHideList.Values['110202'] := '��������Ǽǲ�';
      FHideList.Values['110205'] := '�����������';
      FHideList.Values['110206'] := '����ƾ֤�Ǽǲ�';
      //����֧������
      FHideList.Values['1104'] := '֧������';
      FHideList.Values['110401'] := '֧���������';
      FHideList.Values['110402'] := '֧������Ǽǲ�';
      FHideList.Values['110403'] := '��Ȩ֧��ƾ֤����';
      FHideList.Values['110404'] := '֧��ƾ֤����¼��';
      FHideList.Values['110405'] := '��Ȩ֧��ƾ֤�Ǽǲ�';
      FHideList.Values['110406'] := 'ֱ��֧��ƾ֤�Ǽǲ�';
      FHideList.Values['110407'] := '����ֱ��֧��������';
      FHideList.Values['110408'] := '����ֱ��֧������������';
      FHideList.Values['110409'] := '֧��ƾ֤����';
      FHideList.Values['110410'] := '֧���������';    
    end else begin //������������������
      FHideList.Values['110209'] := '�������뵥����';
      FHideList.Values['110210'] := '�������뵥�ϴ�';
      FHideList.Values['110211'] := '�������뵥����';
      FHideList.Values['110528'] := '���������������ڳ�ʱͳ��';
      FHideList.Values['110529'] := 'Ԥ��ִ��������ܱ�';
      FHideList.Values['110530'] := 'Ԥ��ִ�е�λ�����';
      FHideList.Values['110531'] := 'Ԥ����Ŀ��ϸ��';
    end ; 
  finally
    Cds.Free;
  end;
end ;

//�������ϵͳ�������أ�����
procedure THideMenu.InitFBS(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  {1.FBS ��ȡ��ר�����--�Ƿ����򣬽��в˵�����ʾ}
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FCP_DFXM'' ');
  try
    if Trim(Cds.FieldByName('CSVALUE').Asstring)  = '����' then
    begin
      //���ز���ƾ֤����
      FHideList.Values['160301'] := '�����������';
      FHideList.Values['160302'] := '����������Ч';
      FHideList.Values['160303'] := '�����������ɲ���ƾ֤';
      FHideList.Values['160304'] := '���������ѯ';
      FHideList.Values['160305'] := '����ƾ֤����';
      FHideList.Values['160306'] := '����ƾ֤����¼��';
      FHideList.Values['160307'] := '����ƾ֤�Ǽǲ�';
      FHideList.Values['160308'] := '���ܲ���ƾ֤';
    end else begin //������������������
      FHideList.Values['160315'] := 'ָ���Զ������ÿ�ƻ�';
      FHideList.Values['160316'] := '�����ÿ�ƻ�����';
      FHideList.Values['160317'] := '����Ǽ�';
      FHideList.Values['160318'] := '�������';
      FHideList.Values['160319'] := '�������뵥���ɲ��';
    end ; 
  finally
    Cds.Free;
  end;
end ;
procedure THideMenu.initFA(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  Cds := DataModulePub.GetCdsBySQL('Select * from FA_ZTCS where GSDM = '''+ AGSDM+'''');
  try
    // Modified by Luxu 2012-12-11 
    if Trim(Cds.FieldByName('DWTYPE').AsString)='2' then
    begin
      FHideList.Values['040109']:='ƾ֤ģ������';
      FHideList.Values['580102']:='�������뵥����';
      FHideList.Values['580301']:='�������뵥����';
      FHideList.Values['040206']:='��Ƭ����';
      FHideList.Values['040205']:='ԭʼ�ʲ���Ƭ����';
      FHideList.Values['580201']:='�䶯���뵥����';
      FHideList.Values['040304']:='�䶯������';
      FHideList.Values['040306']:='�ʲ���Ƭ�����䶯';
      FHideList.Values['040901']:='���õ�����';
      FHideList.Values['040501']:='�������뵥����';
      FHideList.Values['040601']:='����������뵥����';
      FHideList.Values['040701']:='�������뵥����';
      FHideList.Values['040801']:='�������뵥����';
      FHideList.Values['041001']:='�̵��';
      // Modified by Luxu 20130716 ��Ʋ���ʾ�̵�˵�����Ϊ��ʾ����û����������⣬����ȡ��������ơ�
      //if (GszRelease = '�������') and (GszEdition = 'G') then // added by Luxu 20120910 ���G�����ܵ�λ���й��ܲ˵���ʾ����
      //  FHideList.Values['0410']:='�ʲ��̵�';
      FHideList.Values['580401']:='�������뵥����';
      FHideList.Values['041101']:='�۾ɼ���';
      FHideList.Values['041102']:='�۾ɵǼǲ�';
      FHideList.Values['041103']:='�۾ɷ����';
      FHideList.Values['041104']:='��ĩ����';
      FHideList.Values['041105']:='ƾ֤����';
      FHideList.Values['041106']:='ƾ֤��';
      FHideList.Values['041108']:='������';
      FHideList.Values['580104']:='��Ƭ����';
      FHideList.Values['580203']:='�䶯������';
      FHideList.Values['580403']:='���õ�����';
    end
    else
    begin
      if GpsSeries=psR9 then
      begin
        FHideList.Values['5803']:='�ʲ�����'; // added by Luxu 20120514 ��Ȼ�ӽڵ㲻��ʾ�����ڵ�Ҳ����ʾ
        FHideList.Values['580301']:='�������뵥����';
        FHideList.Values['580302']:='�������뵥�Ǽǲ�';
      end;
      FHideList.Values['040114']:='���������·�';
      FHideList.Values['0413']:='�ۺϲ�ѯ';
      FHideList.Values['041301']:='��λ�ʲ�����ͳ�Ʊ�';
      FHideList.Values['041302']:='��λ�ʲ����Ż���ͳ�Ʊ�';
      FHideList.Values['041303']:='��λ�ʲ�������ͳ�Ʊ�';
      FHideList.Values['041304']:='��λ�ʲ���Ƭ����һ����';
      FHideList.Values['041305']:='����ʲ�����ͳ�Ʊ�';
      FHideList.Values['041002']:='�̵㱨��';
      Cds := DataModulePub.GetCdsBySQL('Select * from pubModSetup where isstart=''1'' and GSDM = '''+ AGSDM+''' and ModName = ''FAQC'' ');
      if Trim(Cds.FieldByName('BZ').AsString)='1' then
      begin
        FHideList.Values['040103']:='���Ŷ�Ӧ�۾ɿ�Ŀ����';
        FHideList.Values['041101']:='�۾ɼ���';
        FHideList.Values['041102']:='�۾ɵǼǲ�';
        FHideList.Values['041103']:='�۾ɷ����';
        FHideList.Values['041107']:='�۾�Ԥ��';
        FHideList.Values['041230']:='�ۼ��۾��������ͳ�Ʊ�';
        FHideList.Values['041231']:='�����۾����ͳ�Ʊ�';
        FHideList.Values['041229']:='����۾ɼ������ͳ�Ʊ�';
        FHideList.Values['041225']:='�۾�һ����';
        FHideList.Values['041226']:='�۾ɼ�����ϸ��';
        FHideList.Values['041227']:='�۾ɼ��Ჿ����ϸ��';
        FHideList.Values['041215']:='�ۼ�ƽ��ͳ�Ʊ�';
        FHideList.Values['041228']:='����ʱ��ͳ�Ʊ�';
        //FHideList.Values['']:='';
      end;
    end;
    if not ( TPower.GetPower('37019') or TPower.GetPower('37020'))  then//�����ʲ�����Ա �䶯Ȩ�޹������ײ����£������½Աû�����ײ����Ĳ��Ļ�༭Ȩ�ޣ������ظù��ܵ�
      FHideList.Values['0400']:='ϵͳ����';
  finally
    Cds.Free;
  end;
end;
//����ϵͳ����ʾ�˵���ʼ
procedure THideMenu.InitPA(AGSDM, AKJND:String);
var
  Cds:TClientDataSet;
begin

  Cds := DataModulePub.GetCdsBySQL( 'select * from pubmodsetup where gsdm='''+ AGSDM+'''' +' and modname=''PAAC''  ');
  try
    if Cds.FieldByName('IsStart').AsString='1' then  //����ͳ��
    begin 
      Cds := DataModulePub.GetCdsBySQL('Select * from GZ_Ztcs where GSDM = '''+ AGSDM+'''');

      if UpperCase(Cds.FieldByName('BBLX').AsString)='F' then  //���ܵ�λ
      begin
       // FHideList.Values['050110']:='���Ź�����Ŀ����';
       // FHideList.Values['050207']:='�����ϴ�';
      end
      else                                                     //���㵥λ
      begin
        FHideList.Values['050101']:='���幤�����';
        FHideList.Values['050111']:='�������뾭�ÿ�Ŀ��Ӧ��ϵ';
        FHideList.Values['050113']:='֧��ģ������';
        //FHideList.Values['050202']:='�̳���������'; //2012-10-17 mengjin ZWR900067869 Ԥ�㵥λ��¼��ʾ�ò˵�
        FHideList.Values['050206']:='�����·�';
        FHideList.Values['050208']:='���ݽ���';
        FHideList.Values['050209']:='�����������';
        FHideList.Values['050308']:='����֧��ƾ֤';
        FHideList.Values['050309']:='���ɲ���ƾ֤';
        FHideList.Values['050310']:='������������ƾ֤';
        FHideList.Values['050211']:='��������'; // 2013-07-11 mengjin ��Ԥ�㵥λ���ɼ�

        Gqx[ord(GZXGSDY_Edit)] := False;     //�����ʽ����
        Gqx[ord(GZZYLX_Edit)]  := False;     //ְԱ��������
        Gqx[ord(GZGTSFF_Edit)] := False;     //��������˰˰������
        Gqx[ord(GZGZXM_Edit)]  := False;     //������Ŀ����
      end;
    end else    //���ʹ���ϵͳ
    begin
      Cds := DataModulePub.GetCdsBySQL( 'select * from pubmodsetup where gsdm='''+ AGSDM+'''' +' and modname=''PA''  ');
      if Cds.FieldByName('IsStart').AsString='1' then
      begin

      end;
    end;
  finally
    Cds.Free;
  end;

end;

procedure THideMenu.InitGBG(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  {GBG}
  Cds := DataModulePub.GetCdsBySQL('select SXZ from DWYS_ZTCS where SXBH=''QYSQKZ'' and GSDM=' + QuotedStr(AGSDM) + ' and YSND=''-1''');
  try
    if Trim(Cds.FieldByName('SXZ').AsString) = '0' then  //�º�ģʽ
    begin
      FHideList.Values['3103']   := 'Ԥ��ִ��';
      FHideList.Values['310301'] := '�ÿ����';
      FHideList.Values['310302'] := '�ÿ�Ǽǲ�';
    end;
  finally
    Cds.Free;
  end;
end;

//�ʽ�ϵͳ����ʾ�˵���ʼ
procedure THideMenu.InitBM(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  {GBG}
  Cds := DataModulePub.GetCdsBySQL('select pzsjhz from zj_xxb where gsdm=' + QuotedStr(AGSDM));
  try
    if Trim(Cds.FieldByName('pzsjhz').AsString) = '1' then  //�������İ�
    begin
      FHideList.Values['070104']   := '�ڲ������˻���Ӧ��';
      FHideList.Values['0703'] := '���������';
      FHideList.Values['070301'] := '���д��';
      FHideList.Values['070302'] := '�ڲ����';
      FHideList.Values['070303'] := '�ڲ���赥';
      FHideList.Values['070304'] := '���д���𻹿';
      FHideList.Values['070305'] := '���д�����Ϣ���';
      FHideList.Values['070306'] := '�ڲ�����𻹿';
      FHideList.Values['070307'] := '�ڲ�������Ϣ���';
      FHideList.Values['070308'] := '�ڲ������Ϣ���';
      FHideList.Values['070309'] := '�ڲ���豾�𻹿';
      FHideList.Values['070906'] := '����̨��';
      FHideList.Values['070907'] := '������Ϣ��';
      FHideList.Values['0710'] := '����ƻ�';
      FHideList.Values['071001'] := '����ƻ�';
      FHideList.Values['071002'] := '����ִ���������';
    end
    else begin    //�ڲ����а�
      FHideList.Values['071503']   := '�Ӹ�������λ����������˻��ĵ��ս�������';
    end;
  finally
    Cds.Free;
  end;
end;

class function THideMenu.IsHide(AGSDM, AKJND, AMenuCode: String): Boolean;
begin
  if not Assigned(HideMenu) then
    HideMenu := THideMenu.Create;
    
  {��ͬ�ĵ�λ��¼����Ҫ���³�ʼ��}
  if (HideMenu.FGSDM <> AGSDM) or (HideMenu.FKJND <> AKJND) then
  begin
    HideMenu.Init(AGSDM, AKJND);
    HideMenu.FGSDM := AGSDM;
    HideMenu.FKJND := AKJND;
  end;
  Result := HideMenu.FHideList.IndexOfName(AMenuCode) >= 0;
end;

class procedure THideMenu.Refresh;
begin
  if not Assigned(HideMenu) then
    HideMenu := THideMenu.Create;
  HideMenu.FGSDM := '';
  HideMenu.FKJND := '';
end;

procedure THideMenu.InitGL(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  Cds := DataModulePub.GetCdsBySQL('Select ztlb from GL_ZTCS where ZTBH<>'''+CSysDWDM+''' and HSDWDM = '''+ AGSDM+'''');
  try
    {����������Ҫ���ص�����}
    if Trim(Cds.FieldByName('ztlb').AsString) = '0' then
    begin
      FHideList.Values['0314']   := '�������ݹ���';
      FHideList.Values['031401'] := '�趨��λ';
      FHideList.Values['031402'] := '��λ��������';
      FHideList.Values['031403'] := '����������������';
      FHideList.Values['031404'] := '���ܷ�����';
    end;
  finally
    Cds.Free;
  end;
  //zhougf 2011.11.7
  if GDbType = ORACLE then
  begin
    FHideList.Values['030709'] := 'Ԥ�����ʽ���֧���ܱ�';
    FHideList.Values['030710'] := 'Ԥ�����ʽ�λ��ϸ��';
  end;
end;

function GetLongPathName(Src, Dest: PChar; cch:DWord): DWord; stdcall; external 'Kernel32.dll' name 'GetLongPathNameA';

function ShortPathToLongPath(const AShortName: string): string;
var
  sz: array[0..MAX_PATH - 1] of Char;
begin
  FillChar(sz, SizeOf(sz), 0);
  GetLongPathName(PChar(AShortName), sz, MAX_PATH);
  Result := string(sz);
end;

procedure THideMenu.InitGBI(AGSDM, AKJND: String);
var
  vZBJC: Integer;
  vSQL: String;
  blQYYKJH, blQYZBPF, blQYJHPF: Boolean;
begin
  blQYYKJH := TPubModSetup.IsStart(AGSDM,'GCP');
  with DataModulePub.ClientDataSetTmp do
  begin
    vSQL := 'select * from GBI_ZTCS where gsdm='''+AGSDM+''' and kjnd='''+Copy(GszYWRQ, 1, 4)+'''';
    POpenSql(DataModulePub.ClientDataSetTmp,vSQL);
    if RecordCount > 0 then
    begin
      First;
      while not Eof do
      begin
        if FieldByName('CSDM').AsString = 'ZBJC' then//ָ�꼶��
        begin
          vZBJC := StrToIntDef(Trim(FieldByName('CSZ').AsString),1);
        end;
        if FieldByName('CSDM').AsString = 'ZBQYPF' then//ָ����������
        begin
          blQYZBPF := FieldByName('CSZ').AsString = '1';
        end;
        if FieldByName('CSDM').AsString = 'JHQYPF' then//�ƻ���������
        begin
          blQYJHPF := FieldByName('CSZ').AsString = '1';
        end;
        if FieldByName('CSDM').AsString = 'BBLX' then//�汾����
        begin
          if FieldByName('CSZ').AsString = '0' then
            GiBBMode := ZGDWB
          else
            GiBBMode := JCDWB;
        end;
        Next;
      end;
    end;
  end;
  case GiBBMode of
    ZGDWB://���ܵ�λ
    begin
      //���ܵ�λ������ϸָ�깦��
      FHideList.Values['620209'] := '��ϸָ�����';
      FHideList.Values['620210'] := '��ϸָ�����';
      FHideList.Values['620211'] := '��ϸָ������';
      FHideList.Values['620212'] := '��ϸָ��Ǽǲ�';
      FHideList.Values['620218'] := '��ϸָ�����';
      FHideList.Values['620219'] := '��ϸָ������Ǽǲ�';
      FHideList.Values['620305'] := '��ϸָ������';
      FHideList.Values['620306'] := '��ϸָ����ϸ��';
      FHideList.Values['620307'] := '��ϸָ��ִ�������';
      FHideList.Values['620308'] := '��ϸָ��ͳ�Ʊ�';

      FHideList.Values['620230'] := '��ϸָ����';
      FHideList.Values['620231'] := '��ϸָ�����Ǽǲ�';
      FHideList.Values['620240'] := '��ϸָ�����';
      FHideList.Values['620241'] := '��ϸָ������ǼǱ�';

      Case vZBJC of//һ��ָ��
        1:
        begin
          FHideList.Values['620201'] := '��ָ�����';
          FHideList.Values['620202'] := '��ָ�����';
          FHideList.Values['620203'] := '��ָ������';
          FHideList.Values['620204'] := '��ָ��Ǽǲ�';
          FHideList.Values['620214'] := '��ָ�����';
          FHideList.Values['620215'] := '��ָ������Ǽǲ�';
          FHideList.Values['620301'] := '��ָ������';
          FHideList.Values['620302'] := '��ָ����ϸ��';

          if not blQYZBPF then
          begin
            FHideList.Values['620207'] := '��λָ������';
          end;
        end;
        2:
        begin
          if not blQYZBPF then
          begin
            FHideList.Values['620203'] := '��ָ������';
            FHideList.Values['620207'] := '��λָ������';
          end;
        end;
      end;
      //���ܵ�λû���ÿ�ƻ��´�
      FHideList.Values['620220'] := '�ÿ�ƻ��´�';
      //���ܵ�λû��ָ����ƹ���
      FHideList.Values['620213'] := 'ָ����ƹ���';
    end;
    JCDWB://���㵥λ
    begin
      //���㵥λ������ָ�깦��
      FHideList.Values['620201'] := '��ָ�����';
      FHideList.Values['620202'] := '��ָ�����';
      FHideList.Values['620203'] := '��ָ������';
      FHideList.Values['620204'] := '��ָ��Ǽǲ�';
      FHideList.Values['620214'] := '��ָ�����';
      FHideList.Values['620215'] := '��ָ������Ǽǲ�';
      FHideList.Values['620301'] := '��ָ������';
      FHideList.Values['620302'] := '��ָ����ϸ��';

      Case vZBJC of//һ��ָ��
        1:
        begin
          FHideList.Values['620205'] := '��λָ�����';
          FHideList.Values['620206'] := '��λָ�����';
          FHideList.Values['620207'] := '��λָ������';
          FHideList.Values['620208'] := '��λָ��Ǽǲ�';
          FHideList.Values['620216'] := '��λָ�����';
          FHideList.Values['620217'] := '��λָ������Ǽǲ�';
          FHideList.Values['620303'] := '��λָ������';
          FHideList.Values['620304'] := '��λָ����ϸ��';
          if not blQYZBPF then
          begin
            FHideList.Values['620211'] := '��ϸָ������';
          end;
        end;
        2:
        begin
          if not blQYZBPF then
          begin
            FHideList.Values['620207'] := '��λָ������';
            FHideList.Values['620211'] := '��ϸָ������';
          end;
        end;
      end;
      if not blQYYKJH then//���û�������ÿ�ƻ�
        FHideList.Values['620220'] := '�ÿ�ƻ��´�'
      else
      begin
        if not blQYJHPF then//�ÿ�ƻ���������
          FHideList.Values['630103'] := '�ÿ�ƻ�����';
      end;
    end;
  end;
end;

procedure THideMenu.InitGBS(AGSDM, AKJND: String);
var
  vZBJC: Integer;
  vSQL: String;
begin
  with DataModulePub.ClientDataSetTmp do
  begin
    vSQL := 'select * from GBI_ZTCS where gsdm='''+AGSDM+''' and kjnd='''+Copy(GszYWRQ, 1, 4)+'''';
    POpenSql(DataModulePub.ClientDataSetTmp,vSQL);
    if RecordCount > 0 then
    begin
      First;
      while not Eof do
      begin
        if FieldByName('CSDM').AsString = 'ZBJC' then//ָ�꼶��
        begin
          vZBJC := StrToIntDef(Trim(FieldByName('CSZ').AsString),1);
        end;

        if FieldByName('CSDM').AsString = 'BBLX' then//�汾����
        begin
          if FieldByName('CSZ').AsString = '0' then
            GiBBMode := ZGDWB
          else
            GiBBMode := JCDWB;
        end;
        Next;
      end;
    end;
  end;

  // Ԥ�����
  if (GiBBMode = ZGDWB) then
  begin
    FHideList.Values['6106'] := 'ָ������';
    FHideList.Values['610601'] := 'ָ������';
  end;
end;


{ TRegCheck }
function GetRegFileName(AName:String):String;
var
  iCount:integer;
  Reg:TRegistry;
  GUID:TGUID;
  CLSID:String;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CLASSES_ROOT;
    try
      GUID := ProgIDToClassID(AName);
      CLSID := GUIDToString(GUID);
      if CLSID <> '' then
      begin
        Reg.OpenKey('CLSID\'+CLSID+'\InProcServer32', false);
        Result := Reg.ReadString('');
  //      ExtractShortPathName
        Result := ShortPathToLongPath(Result);
      end;
    except
      Result := '';
    end;
    Reg.CloseKey;
  finally
    Reg.Free;
  end;
end;

function GetPath(S: string): string;
var
  buff: array[0..255] of char;
  SystemPath: string;
begin
  Result := Uppercase(S);
  Result := StringReplace(Result, uppercase('[Client]'), ExtractFilePath(Application.ExeName), []);
  GetSysteMDIrectory(buff, 255); //ȡ��system32��Ŀ¼
  SystemPath := buff;
  SystemPath := SystemPath + '\';
  Result := StringReplace(Result, uppercase('[System32]'), SystemPath, []);
  GetWindowsDirectory(buff, 255);
  SystemPath := buff;
  SystemPath := SystemPath + '\';
  Result := StringReplace(Result, uppercase('[Windows]'), SystemPath, []);
end;

class procedure TRegCheck.CheckReg(AName, APath: String);
var
  AFileName:String;
begin
  AFileName := UpperCase(GetPath(APath));
  if UpperCase(GetRegFileName(AName)) <> AFileName then
  begin
    try
      if FileExists(AFileName) then
        WinExecAndWait('RegSvr32 /S "'+AFileName+'"', SW_NORMAL);
    except

    end;
  end;
end;

{ TPubIntf }
function BplExecute(vBpl, vParams:WideString):Boolean; //ά����ZWR900035882
var
  vFile:String;
  FHandle:integer;
  Execute:TExecute;
  ModCode:String;
begin
  Result := False;
  vFile := ExtractFilePath(Application.ExeName)+vBpl;
  ModCode := TString.LeftStrBySp(vBpl, '.');
  
  //hch ����ⲿ�����ļ������ڣ�������»�����ʾ
  if (GpsSeries = psR9i) and (GsSingleMode='0') then
  begin
    if (GCU<>nil) and GCU.Check(ModCode) then
      GCU.Update;
  end;

  if not FileExists(vFile) then
  begin
  	Application.MessageBox(PChar('�ļ�"'+vFile+'"�����ڣ� ����������'),
    	'ϵͳ��ʾ', MB_ICONWarning + MB_OK);
  	Exit;	
  end;
  FHandle := LoadPackage(vFile);
  if FHandle <> 0 then
  begin
    @Execute := GetProcAddress(FHandle, 'Execute');
    if Assigned(Execute) then
      result:= Execute(vParams);
  end;
end;

{ TPubIntf }

function TPubIntf.Execute(vAction, vParams: WideString): Boolean;
var
  FR9_IMPL: TUIR9_IMPL; //��̬�������
  i:Integer;
  vGSDMS:string;
  vQueryParams:String;
begin
  {���µ�¼}
  if UpperCase(vAction) = 'LOGIN' then
  begin
    if Assigned(FormMain) then
      FormMain.ActLoginExecute(nil);
  end
  else if UpperCase(vAction) = 'RPT' then
  begin
    if Pos('GSDM=', vParams)> 0 then
    begin
      with TStringList.Create do
      begin
        Text := vParams;
        vGSDMS := Values['GSDM'];
        vQueryParams:= Values['QueryParams'];
        OpenRpt(vGSDMS, GszZTH, GszKJND, GszYWRQ, Values['RPTID'], vQueryParams);
        Free;
      end;
    end
    else
    begin
      if pos('QueryParams=', vParams)>0 then
      begin
        with TStringList.Create do
        begin
          Text := vParams;
          OpenRpt(GszGSDM, GszZTH, GszKJND, GszYWRQ, Values['QueryParams'], Values['QueryParams']);
          Free;
        end;
      end
      else
        OpenRpt(GszGSDM, GszZTH, GszKJND, GszYWRQ, vParams)  
    end;
  end
  //ά����ZWR900035882 ִ���������ù��� zhougf 2012.4.11
  else if UpperCase(TString.LeftStrBySp(vAction)) = 'EXECUTE' then
  begin
    result:= BplExecute(TString.RightStrBySp(vAction), vParams);
  end
  {ִ��ģ��Ĺ��ܵ���}
  else if UpperCase(vAction) <> '' then
  begin
    FR9_IMPL := FormMain.FslUIR9_IMPL.CreateUIR9(vAction, '');
    FR9_IMPL.CallDll(vParams);
  end;
  
end;

initialization
{$INCLUDE SPS_SYS.inc}

  TRegCheck.CheckReg('Borland.Midas_DSBase.1', '[Client]Midas.dll'); 
  TRegCheck.CheckReg('R9iApp.R9ServerDM', '[Client]App.dll');
  TRegCheck.CheckReg('Cell.Cell50Ctrl.ZW', '[Client]CellCtrl5.ocx');
  TRegCheck.CheckReg('UFDBRPTVWR9.UFDBRPTVWR9_V1', '[Client]UFDBRPTVWR9.ocx');
  TRegCheck.CheckReg('RptCell.TRpt_CellX', '[Client]RptCell.dll');
  {hch}
  GIPub := TPubIntf.Create;
  //hch ���ӹ��ʽӿ���, ��Ҫ�����������ж��壬Ȼ���ڹ�����ʹ�á�
  TAutoObjectFactory.Create(ComServer, TSalaryFormula, CLASS_SalaryFormula,
    ciMultiInstance, tmApartment);
finalization
  GIPub := nil;
  
end.




