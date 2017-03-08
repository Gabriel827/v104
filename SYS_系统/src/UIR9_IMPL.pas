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
  {显示过程}
  TOnProgress = procedure (Rate:integer) of object;
  {菜单合并管理类}
  TMergerMenu = class
  private
    FOnClick: TNotifyEvent;
    FOwner: TComponent;
    FSurMenu, FDesMenu: TMainMenu;
    FMenuInsBeg, FMenuInsEnd: integer;
    FSlMenu: TStringList;
    //恢复主菜单相关内容
    procedure RecoverMenu;
    //增加菜单的结点菜单
    function AddChildMenuItem(AMenuItem, ParentMenuItem: TMenuItem): Boolean;
    //查找节点菜单内容是否存在
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
    FBPL_Handle: HMODULE; //Bpl句柄
    FDLLForm: LongWord;
    FLibPath: string;
  public //FR9_DLLHandle: THandle;   //当前窗体句柄
    FsBPLName: string; //bpl的名称
    FsModeName: string; //对应模块的名称
    bIsCusReport:Boolean;      //是否是报表类的加密
    Global_Mode: TPublicMod; //当前模块对应的对象
    FExeType: TExecType;
    Anyiclient1: TAnyiClient; //报表类产品用的加密，其他有BPL的产品不用这个加密
    function CallDll(sGnflMc: string): Integer;
    function CloseDLL: Integer;
    function GetParms: string;
    constructor Create(LibPath: PChar; psModeName: string);
  end;

  TDllFile = class //该对象主要是读取本地bpl配置文件，没其他用途了
  private
    FslFile: TStringList; //bpl文件列表
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
    FslUIR9: TStringList; //bpl文件全路径，以及 FUIR9_IMPL对象  ，每个bpl就创建一个TUIR9_IMPL对象，不是每个模块一个对象，因为可能一个模块调用多个不同的bpl文件
    constructor Create(AppPath: string);
    destructor Destroy; override;

    // For Client AutoUpdate, Added by gh, 2013.05.23
    function CheckUpdate(const ModName: string; CheckOnly: Boolean): Boolean;

    function CreateUIR9(psModuleName, sGnflExec: string): TUIR9_IMPL;
    function ActiveForm(psModeName: string): Boolean; // 激活模块 FormHandle:HWND;
    procedure DeleteUIR9(psModuleName: string; DLLHandle: HWND);
    property Values[const ModuleName: string]: TUIR9_IMPL read GetValue write SetValue;
    property ServerURL: string read FServerURL write FServerURL;
  end;

  //客户端更新文件类
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
  //客户端更新类， hch 2011-03-07
  TClientUpdate = class
  private
    //服务器地址，客户端XML存放路径
    FServerURL, FClientXMLPath, FWindowsPath: string;
    //主程序存放地址
    FAppPath: string;
    //是否安装BDE
    FIsSetupBDE: Boolean;
    //更新文件列表
    FUpFileLst: TList;
    IXMLS, IXMLC: IXMLDOMDocument;
    FModName: string;
    FDatabaseType: string;

    //解析XML文件，获取产品列表
    procedure ExtractFile(var lst: TList; I: IXMLDOMDocument; FProductName: string);
    //判断XML文件是否有更新，更新文件
    procedure FindDiff(slst, clst: TList; var uplst: TList; FDefaultPath: string; FIsSetupBDE: Boolean);
    //查找Node节点
    function findNode(Nodes: TList; NodeId: string): integer;
    //设置程序应用地址
    procedure SetAppPath(const Value: string);
    //下载文件
    function downFile(Afile: string): Boolean;
    //解压文件
    function unzipFile(Aunzip: TVCLUnZip; AunzipFile, Afolder: string; IsReplace: Boolean): Boolean;
    function LoadFile(AFileName: string): IXMLDOMDocument;
    procedure SetDatabaseType(const Value: string);
    function GetHttpURL(AURL: string): string;
    function GetHttpURLPort(AURL: string): string;//返回带端口号的URL地址 //2011.12.5 hy DSL
 
    // For Client AutoUpdate, Added by gh, 2013.05.23
    function GetClientXmlFileName: string;         // DSL
  public
    //创建
    constructor Create(ServerURL: string);
    //释放
    destructor Destroy; override;
    //Check，更新检查， 检查模块文件是否需要更新，然后下载
    //自动更新下载, 解压，需要记录是否进行检查，如果已经更新过，就不需要重新下载更新
    function Check(ModName: string): Boolean;
    //更新
    function Update: Boolean;
    property AppPath: string read FAppPath write SetAppPath;
    property DatabaseType: string read FDatabaseType write SetDatabaseType;
  end;
  {hch 2011.05.19}
  {实现主要的功能：}
  {1：根据模块隐藏其中的内容}
  {2：能够动态显示或者隐藏菜单的内容}
  THideMenu = class
    {保存所有不需要显示的菜单}
    FHideList:THashedStringList;
    {更换年度后，自动获取是否显示菜单}
    FGSDM, FKJND:String;
    {初始化模块中不需要显示的菜单}
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
  {hch 检查注册组件是否正确， 如果不正确重新注册}
  TRegCheck = class
  public
    class procedure CheckReg(AName, APath:String);
  end;
  {实现主程序接口的调用}
  TPubIntf = class(TInterfacedObject, IPub)
  public
    function Execute(vAction, vParams:WideString):Boolean;
  end;

// 获得AProcessName进程运行的实例数，For Client AutoUpdate, Added by gh, 2013.05.23
// AProcessPath为空时计算所有目录下的所有实例，否则只计算运行目录为AProcessPath的实例数
function GetInstanceCount(const AProcessName, AProcessPath: string): Integer;
// 检测并更新主程序（SYS, IM etc.）, For Client AutoUpdate, Added by gh, 2013.05.23
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
  AProductName,             // 模块名称
  AUserID,                  // 操作员ID
  AUserName,                // 操作员名称
  APassword,                // 密码
  ATransdate,               // 业务日期
  AAccountID,               // 帐套号
  AAccountName,             // 帐套名称
  ACompanyID,               // 单位代码
  ACompanyName,             // 单位名称
  AServerUrl,               // 服务器地址
  AServerPort,              // 端口号
  ACallbackExe: string;     // 回调程序名称（完整路径）
  APrompt: Boolean = True); // 是否显示提示信息
const
  cUpdateMod = 'SYSUPDATER';
  cUpdaterName = 'SysUpdater.exe';
  cCaption = '更新';
  cPromptInfo = '检测到新版本，按确定开始更新。';
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
      //chengjf 2016-04-25 退出时删除用户状态，否则重新登录时不能登录
      TControlLogin.DelOperState(IntToStr(GCzy.ID));
      Application.Terminate;
    end;
  finally
    Free;
  end;
end;

{ TUIR9_IMPL }

function TUIR9_IMPL.CallDll(sGnflMc: string): Integer; //单击功能菜单时调用
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
    Result := True;//没有创建也返回True    
  end;

  function InitRepEncrypt(pbIsCusReport:Boolean):Boolean;
  //打开的非bpl的模块时，需要单独对其进行加密处理 lzn
  begin
    Result := False;
    Pub_GLobal.GszVersion:= GetGszAnyiByModeName(FsModeName);
    rMainSub.GsStartModName := FsModeName;
    rMainSub.GsActiveModName := FsModeName;
    rMainSub.GsPriModName := rMainSub.GsCurModName;     //记录上一个调用的模块
    rMainSub.GsPriReportModName := rMainSub.GsCurModName;
    rMainSub.GsCurModName := FsModeName;    //当前正打开的模块
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
       ShowMessage('获取模块文件失败，有以下几个原因，请检查：'+#13#10+
                   '1.程序运行目录下缺少"'+FLibPath+'"文件,请连接服务器更新后再使用本功能'+#13#10+
                   '2.GL_GNFL表缺少相关模块文件名描述'+#13#10+
                   '3.其它未明确信息，请与系统管理员联系');
       Exit;
  end;

  if (FExeType = etBpl)or(FExeType=etGE) then
  begin //存在包文件 //导入包
    if FBPL_Handle = 0 then
       FBPL_Handle := LoadPackage(FLibPath);
    @ShowForm := GetProcAddress(FBPL_Handle, 'ShowForm');
    if Assigned(ShowForm) then
    begin
      rMainSub.GsStartModName := FsModeName;
      rMainSub.GsActiveModName := FsModeName;
      //当前正启动的模块，这里赋值，主要是为了在ShowForm函数的Global_Mode.create里用
      rMainSub.GsCurBplName := FsBPLName;
      sCurBplName := FsBPLName;
      rMainSub.bShow := False;
      try
        Global_Mode := ShowForm(sGnflMc, False);
        Result := 1;
        //zhengjy 20151103 原因：网报和物资模块，通过showForm调用后，应该调用ClientWndProc
        //  的过程UpdateList方法将 rMainSub.bShow 设置为true，但不知道什么原因此两个模块未调用，临时处理。
        if (Global_Mode<>nil) and (sGnflMc<>'') then
          rMainSub.bShow :=true;

        if (Global_Mode<>nil) and Global_Mode.FbDBProcess then //要重新更新下待办信息
           FormMain.UpdateDBSY(True,Global_Mode.FsModeName);
      except
        //产生异常后无法释放加密
      end;
      if (not rMainSub.bShow) then begin // Showmodal窗体释放加密，存在的问题是，打开一个showmodal窗体，但关闭后，自动打开了一个show窗体，这时加密也释放了，需要再另外的进入该模块的激活事件里继续打开加密
         rMainSub.GsCurBplName := sCurBplName; //当前正关闭的bpl名字
         FormMain.FreeEncrypt(FsModeName);
      end;
      rMainSub.bShow := False;
    end;
  end else
  {打开文件}
  if FExeType = etExe then
  begin
    vParams := GetParms;

    WinExec(PChar(FLibPath + ' ' + vParams), SW_SHOWNORMAL);
    Result := 1;
  end else
  {打开电子报表}
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
    //zhengjy 2014-05-21 将预警定义模块与预算执行分析模块功能合并，并使用同一个加密。
    if (sGnflMc='预警定义') and (FsModeName='BKA') then
    begin
      if FBPL_Handle = 0 then
        FBPL_Handle := LoadPackage(FLibPath+'GE.BPL');
      @ShowForm := GetProcAddress(FBPL_Handle, 'ShowForm');
      if Assigned(ShowForm) then
      begin
        rMainSub.GsStartModName := FsModeName;
        rMainSub.GsActiveModName := FsModeName;
        //当前正启动的模块，这里赋值，主要是为了在ShowForm函数的Global_Mode.create里用
        rMainSub.GsCurBplName := FsBPLName;
        sCurBplName := FsBPLName;
        rMainSub.bShow := False;
        try
          Global_Mode := ShowForm(sGnflMc, False);
          Result := 1;
          if (Global_Mode<>nil) and Global_Mode.FbDBProcess then //要重新更新下待办信息
             FormMain.UpdateDBSY(True,Global_Mode.FsModeName);
        except
          //产生异常后无法释放加密
        end;
        if (not rMainSub.bShow) then begin // Showmodal窗体释放加密，存在的问题是，打开一个showmodal窗体，但关闭后，自动打开了一个show窗体，这时加密也释放了，需要再另外的进入该模块的激活事件里继续打开加密
           rMainSub.GsCurBplName := sCurBplName; //当前正关闭的bpl名字
           FormMain.FreeEncrypt(FsModeName);
        end;
        rMainSub.bShow := False;
      end;
      if AnyiClient1=nil then iresult :=0
      else iresult :=-1;
    end else
      iResult:= TQueryReport.OpenReport(iff(sGnflMc='报表定义', '', sGnflMc), '',  sGnflMc<>'报表定义');
    if iResult=0 then begin     //返回0是点了否,1是点了是，2-3是不能打开
    end else if iResult=1 then begin //点了是，窗体关闭消息会触发，导致加密可能已被释放，这里需要重新创建下加密(注意这里已自动释放了上一个自定义报表类模块的其他加密)
       CreateAnyiClient
    end else if iResult=2 then begin //不能打开，则释放先前创建的加密连接
         if rMainSub.GsPriReportModName<>FsModeName then
            FreeAndnil(AnyiClient1);
    end else if iResult=3 then  //被其他模块打开了，所以不能打开，则释放先前创建的加密连接
         FreeAndnil(AnyiClient1);
  end else
  if FExeType = etMIDS then //added by guozy 2012-02-28
  begin
    GProSign := 'MIDS';
    GProSeries := 'G';
    GNotEncrypt := '0';
    if not InitRepEncrypt(True) then Exit;
    if not FileExists(FLibPath) then  //非预定义的功能，是从数据库中动态打开的功能
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
      //当前正启动的模块，这里赋值，主要是为了在ShowForm函数的Global_Mode.create里用
      rMainSub.GsCurBplName := FsBPLName;
      sCurBplName := FsBPLName;
      rMainSub.bShow := False;
      try
        Global_Mode := ShowForm(sGnflMc, False);
        Result := 1;
        if (Global_Mode<>nil) and Global_Mode.FbDBProcess then //要重新更新下待办信息
           FormMain.UpdateDBSY(True,Global_Mode.FsModeName);
      except
        //产生异常后无法释放加密
      end;
      if (not rMainSub.bShow) then begin // Showmodal窗体释放加密，存在的问题是，打开一个showmodal窗体，但关闭后，自动打开了一个show窗体，这时加密也释放了，需要再另外的进入该模块的激活事件里继续打开加密
         rMainSub.GsCurBplName := sCurBplName; //当前正关闭的bpl名字
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
    if (sGnflMc='凭证模板') or (sGnflMc='凭证采集') or (sGnflMc='凭证接口') or (sGnflMc='数据同步') then begin
       if not InitRepEncrypt(False) then  //提议：APT模块的加密，在各自的模块中控制,但除了上面5个功能外，这里注释掉 2013.07.15
          Exit;
    end;
    GAPTConnectEncrypt:=True;
  end;         
  (*else if FExeType = etGE then
  begin
    //GProSign := 'GE'; if sGnflMc='预警定义' then begin
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
        //产生异常后无法释放加密
      end;      
      Result := 1;
      if (not rMainSub.bShow) then // Showmodal窗体释放加密，存在的问题是，打开一个showmodal窗体，但关闭后，自动打开了一个show窗体，这时加密也释放了，需要再另外的进入该模块的激活事件里继续打开加密
         FormMain.FreeEncrypt(FsModeName);      
    end;
    (*end else begin
       //在报表窗体点是和否时，窗体关闭消息会触发，导致加密可能已被释放，这里需要重新创建下加密
       if not InitEncrypt(True) then Exit;
       iResult := TQueryReport.OpenReport(sGnflMc, '',  false);
       if iResult=0 then begin
          //if rMainSub.GsPriReportModName<>FsModeName then
          //   FreeAndnil(AnyiClient1);
       end else if iResult=1 then begin
          CreateAnyiClient;  //在报表窗体点是和否时，窗体关闭消息会触发，导致加密可能已被释放，这里需要重新创建下加密
       end else if iResult=2 then  //不能打开，则释放先前创建的加密连接，但不要释放已打开的该模块的加盟
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
         UnloadPackage(FBPL_Handle);  //释放包以后会再加载包，会导致,如SingletonSet单元的常量赋值为空，以及其他错误
         FBPL_Handle := 0;
      end;
    end else begin  //不释放包，则会在关闭主程序时，会执行每个模块的CloseDLL函数，这里再释放模块及加密
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
  {电子报表打开方式}
  else if (Uppercase(ExtractFileExt(FLibPath)) = '.CLL') and (psModeName = 'AQR') then
    FExeType := etReport
  else if psModeName = 'APT' then
    FExeType := etAPT
  else if psModeName = 'APP' then
    FExeType := etAPP
  else
    FExeType := etNone;
  {hch 自定义报表模式}
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
        if (Global_Mode<>nil) and Global_Mode.FbDBProcess then //要重新更新下待办信息
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
  begin //保留两种识别bpl文件方式
    sGnflExec := FDllFile.GetDllName(psModuleName);
    if  (Trim(sGnflExec) = '') then
      Exit;
  end;

  //==因为可能存在两个模块，共用一个BPL文件，所以要按模块名来区分
  bExist := False;
  BPL_Handle_Temp := 0;
  //zhengjy 2014-05-21 将预警定义模块与预算执行分析模块功能合并，并使用同一个加密
  if (psModuleName = 'BKA')  then    sPathFile :=FAppPath
  else
    sPathFile := FAppPath + sGnflExec;
  for i:=0 to FslUIR9.Count-1 do begin
      if (FslUIR9[i]=sPathFile) then begin   //bpl已经打开过
         BPL_Handle_Temp := TUIR9_IMPL(FslUIR9.Objects[i]).FBPL_Handle;

         if (TUIR9_IMPL(FslUIR9.Objects[i]).FsModeName=psModuleName) then begin
            bExist := True;
            Break;
         end;
      end;
  end;

  //i := FslUIR9.IndexOf(FAppPath + sGnflExec); if i < 0 then
  if not bExist then begin
    //zhengjy 2014-05-21 将预警定义模块与预算执行分析模块功能合并，并使用同一个加密
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
    if BPL_Handle_Temp<>0 then //该bpl已经打开过，则获取其句柄
       FUIR9_IMPL.FBPL_Handle := BPL_Handle_Temp;
    Result := FUIR9_IMPL;
    FUIR9_IMPL := nil;
    {hch 只有G版本进行下载更新操作}
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

procedure TslUIR9_IMPL.DeleteUIR9(psModuleName: string; DLLHandle: HWND); //该函数，只能用来卸载加密之用，不要写其他代码，by 针对乡财加密调整修改 2011.11.14
var
  i: integer;
  FUIR9_IMPL: TUIR9_IMPL;
  sBPLFile: string;
begin //if not rMainSub.bFreeBpl then begin  exit; end;
  for i := 0 to FslUIR9.Count - 1 do
  begin //卸载模块：目前不释放包，只释放加密
    FUIR9_IMPL := TUIR9_IMPL(FslUIR9.Objects[i]);
    if (FUIR9_IMPL.FsModeName = psModuleName) then
    begin
    //modified by chengjf 20120912 乡财加密不再特殊处理
//      if GetISXCZB and (FUIR9_IMPL.FsBPLName<>rMainSub.GsCurBplName) then //模块相同，bpl相同才释放
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
  (*if psModuleName = '' then begin   //现在关闭模块时，已不释放包了，但以下代码勿删
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
       sBPLFile := FDllFile.GetDllName(psModuleName)   //从本地文件取
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
  begin //保留从R9_FILECONFIG文件读，用于调试用
    sBPLFile := FDllFile.GetDllName(ModuleName);
  end;

  if sBPLFile = '' then
     exit;

  bExist := False;
  sPathFile := FAppPath + sBPLFile;
  for i:=0 to FslUIR9.Count-1 do begin
      if (FslUIR9[i]=sPathFile) then begin   //bpl已经打开过
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
      if (FslUIR9[i]=sPathFile) then begin   //bpl已经打开过
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
    Result := -1; //文件路径不存在
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
//按名称查找菜单结点是否存在

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
    //解析客户端更新文件和服务器端更新文件，进行比较，寻找需要更新的文件。
    ExtractFile(ServerUpInfo, IXMLS, ModName);
    ExtractFile(ClientUpInfo, IXMLC, ModName);
    //找出需要更新的模块
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
  //创建更新对象
  FUpFileLst := TList.Create;
  //服务地址，服务器下载XML文档
  FServerURL := ServerURL;
  FIsSetupBDE := IsSetupBDE;

  GetSystemDirectory(@sWinPath, 255);
  FClientXMLPath := Trim(sWinPath);
  FillChar(sWinPath,255,#0);
  GetWindowsDirectory(@sWinPath, 255);
  FWindowsPath := Trim(sWinPath);

 // 升级旧版本的配置文件, Added by gh, 2013.05.23
  OldXmlFile := FClientXMLPath + '\' + GetHttpURL(GszServerComputer) + cAutoXML;
  NewXmlFile := FClientXMLPath + '\' + GetClientXmlFileName;
  if FileExists(OldXmlFile) and not FileExists(NewXmlFile) then
    RenameFile(OldXmlFile, NewXmlFile);

  //如果不存在文件，下载文件，保存到客户端
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

  //如果传递的URL为空
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
  //释放对象
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
    //加入SetPath路径，支持\client\文件夹方式  Modified by chengjf 2016-06-21
    //sPath := FDefaultPath;
    sPath := ExpandFileName(FDefaultPath + '\..') + SetPath;

    //if sPath[length(sPath)] = '\' then
      sPath := StringReplace(sPath, '\\', '\', []);
    //else
      //sPath := sPath;
    //文件
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
      //文件夹
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

    // 崔立国 2011.08.30 江西部分宽带用户IdHTTP下载文件出错，改为HTTPFile下载方式。
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
      MessageDlg('文件 "' + tempURL + '" 无法下载。错误信息：' + #13#10 +
                 E.Message + #13#10#13#10 +
                 '请检查文件是否存在，或网络是否连通。',
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
  //hch 是否包含BDE安装
  IsHaveBDE: Boolean;
  BDEFileName: string;
  {主程序目录}
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

  {下载更新}
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

    //加入szsetuppath路径，支持\client\文件夹方式  Modified by chengjf 2016-06-21
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
        System32Path, TClientInfo(FUpFileLst[i]).IsReplace); //更新
      if TClientInfo(FUpFileLst[i]).IsRegister then
      begin
        RegisterLst.Add(System32Path + '\' + StringReplace(szfilename, '.zip', '', [rfIgnoreCase]));
      end;
    end
    else if TClientInfo(FUpFileLst[i]).setuppath = '#windows' then
    begin
      unzipFile(VCLUnZip1, cTempPath + '\' + szfilename,
        FwindowsPath, TClientInfo(FUpFileLst[i]).IsReplace); //更新
      if TClientInfo(FUpFileLst[i]).IsRegister then
      begin
        RegisterLst.Add(FwindowsPath + '\' + StringReplace(szfilename, '.zip', '', [rfIgnoreCase]));
      end;
    end
    else if TClientInfo(FUpFileLst[i]).setuppath = '#BDE' then
    begin
      IsHaveBDE := True;
      if not FIsSetupBDE then
        unzipFile(VCLUnZip1, cTempPath + '\' + szfilename, cTempPath, False); //更新
    end
    else
    begin
      unzipFile(VCLUnZip1, cTempPath + '\' + szfilename, TempRoot, TClientInfo(FUpFileLst[i]).IsReplace); //更新
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
    //检查是否需要运行本地的exe程序
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

  //更新完成后，更新配置本地配置文件
  IXMLC := loadXMLFile(FClientXMLPath + '\' + GetClientXmlFileName);    // DSL
  root := IXMLC.Get_documentElement;
  //安装配置位置
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
  //初始化本地程序
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
  //更新节点，添加每一个节点的内容
  for i := 0 to FUpFileLst.Count - 1 do
  begin
    SetAttr(TClientInfo(FUpFileLst[i]).NodeId, 'version', TClientInfo(FUpFileLst[i]).Version);
    SetAttr(TClientInfo(FUpFileLst[i]).NodeId, 'setupPath', TClientInfo(FUpFileLst[i]).setupPath);
    SetAttr(TClientInfo(FUpFileLst[i]).NodeId, 'script', TClientInfo(FUpFileLst[i]).script);
  end;
  //对于已经有模块的节点更新其节点内容，不至于重复下载
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
  //等待安装BDE文件
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
  {出纳}
  InitCM(AGSDM, AKJND);
  {全面预算}
  InitGBG(AGSDM, AKJND);
  {指标管理}
  InitFBI(AGSDM, AKJND);
  {远程申请}
  InitYBC(AGSDM, AKJND);
  {拨款管理}
  InitFBS(AGSDM, AKJND);  
  {国有资产}
  initFA(AGSDM, AKJND);
  {工资}
  InitPA(AGSDM, AKJND);
  {账务}
  InitGL(AGSDM, AKJND);
  {票据}
  InitCHQ(AGSDM, AKJND);
  {非税}
  InitNTMF(AGSDM, AKJND);
  {资金}
  InitBM(AGSDM, AKJND);
  {全面预算系列}
  InitGBI(AGSDM, AKJND);
  InitGBS(AGSDM, AKJND);
end;

procedure THideMenu.InitFast(AGSDM, AKJND, AModCode: string);
begin
  if SameText(AModCode, 'CM') then
    InitCM(AGSDM, AKJND);

  {全面预算}
  if SameText(AModCode, 'GBG') then
    InitGBG(AGSDM, AKJND);

  {指标管理}
  if SameText(AModCode, 'FBI') then
    InitFBI(AGSDM, AKJND);

  {国有资产}
  if SameText(AModCode, 'FA') then
    InitFA(AGSDM, AKJND);

  {工资}
  if SameText(AModCode, 'PA') then
    InitPA(AGSDM, AKJND);

  {账务}
  if SameText(AModCode, 'GL') then
    InitGL(AGSDM, AKJND);

  {票据}
  if SameText(AModCode, 'CHQ') then
    InitCHQ(AGSDM, AKJND);

  {非税}
  if SameText(AModCode, 'NTMF') then
    InitNTMF(AGSDM, AKJND);

  {资金}
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
  if FindLevel0Node(tv,'出纳') then
     InitCM(AGSDM, AKJND);

  {全面预算}
  if FindLevel0Node(tv,'全面预算') then
    InitGBG(AGSDM, AKJND);

  {指标管理}
  if FindLevel0Node(tv,'指标管理') then  begin
    InitFBI(AGSDM, AKJND);
    InitGBI(AGSDM, AKJND);
  end;

  {预算编制}
  if FindLevel0Node(tv,'预算编制') then  begin
    InitGBS(AGSDM, AKJND);
  end;

  {国有资产}
  if FindLevel0Node(tv,'资产') then
    InitFA(AGSDM, AKJND);

  {工资}
  if FindLevel0Node(tv,'工资') then
    InitPA(AGSDM, AKJND);

  {账务}
  if FindLevel0Node(tv,'账务') or FindLevel0Node(tv,'总预算') or FindLevel0Node(tv,'总账') then
    InitGL(AGSDM, AKJND);

  {票据}
  if FindLevel0Node(tv,'票据') then
    InitCHQ(AGSDM, AKJND);

  {非税}
  if FindLevel0Node(tv,'非税') then
    InitNTMF(AGSDM, AKJND);

  {资金}
  if FindLevel0Node(tv,'资金') then
    InitBM(AGSDM, AKJND);
end;

procedure THideMenu.InitCM(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  {1.CM 获取出纳的参数，进行菜单的显示}
  Cds := DataModulePub.GetCdsBySQL('Select ztkz from CM_ZTCS where GSDM = '''+ AGSDM+''' and ztbh='''+gszzth+'''');
  try
    if copy(Cds.FieldByName('ztkz').Asstring, 1, 1) = '0' then
    begin
      FHideList.Values['0603'] := '出纳账';
      FHideList.Values['060301'] := '登记出纳账';
      FHideList.Values['060302'] := '日结';
      FHideList.Values['060303'] := '取消日结';
      FHideList.Values['060304'] := '现金日记账';
      FHideList.Values['060305'] := '银行日记账';
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
      FHideList.Values['180202'] := '票据批号定义';
    end;
  finally
    Cds.Free;
  end;
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE FROM PJ_PJCS WHERE  gsdm = '''+ AGSDM +''' and KJND='''+AKJND+''' and rtrim(CSDM)=''CHQ_PJLYZGSP''');
  try
    if (not Cds.FindFirst) or 
    ( Cds.FieldByName('CSVALUE').Asstring  <> '1' )then
    begin
      FHideList.Values['180305'] := '票据审批';
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
      FHideList.Values['200310'] := '查询接收银行通知书汇总信息';
      FHideList.Values['200506'] := '财政MQ服务器消息查询及发送';
      FHideList.Values['201106'] := '查询接收银行通知书汇总信息';
   end;
   Cds := DataModulePub.GetCdsBySQL('select * from nt_hsdw where gsdm=''' + AGSDM + ''' and KJND='''+ AKJND + '''');
  try
    tmpother3:=Cds.FieldByName('Other3').Asstring;
    if Copy(tmpother3,6,1)<>'1' then
    begin
      FHideList.Values['201201'] := '结转通知书';
      FHideList.Values['2012'] := '结转管理';
    end;

    tmpother3:=Cds.FieldByName('OtherZT').Asstring;
    szAutoTZSNo := copy(tmpother3, pos('1[', tmpother3) + 2,pos(']1', tmpother3) - pos('1[', tmpother3) - 2);
    if szAutoTZSNo<>'1' then
    begin
      FHideList.Values['200205'] := '领用票据编辑';
      FHideList.Values['200206'] := '人员票据分配编辑';
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
           FHideList.Values['200206'] := '人员票据分配编辑';
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
       FHideList.Values['200504'] := '未缴款通知书';
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

  {1.FBI 获取的指标的参数--指标级次管理，进行菜单的显示}
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FBI_CSZBLRKCS'' ');
  blCSZBLRKCS:=(Cds.FieldByName('CSVALUE').Asstring  = '1');
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FBI_ZBGLJC'' ');
  try
    if Cds.FieldByName('CSVALUE').Asstring  = '1' then
    begin
      FHideList.Values['0903'] := '总指标管理';
      FHideList.Values['090301'] := '总指标编制';
      FHideList.Values['090302'] := '总指标登记簿';
      FHideList.Values['090303'] := '总指标调整登记簿';
      FHideList.Values['090304'] := '总指标审核';
      FHideList.Values['090305'] := '总指标下达';
      
      FHideList.Values['090801'] := '总指标明细表';
      FHideList.Values['090802'] := '总指标汇总表';
      FHideList.Values['090803'] := '总指标调整明细表';
      FHideList.Values['090804'] := '总指标执行表';
      

      FHideList.Values['0904'] := '科处室指标管理';
      FHideList.Values['090401'] := '科处室指标编制';
      FHideList.Values['090402'] := '科处室指标登记簿';
      FHideList.Values['090403'] := '科处室指标调整登记簿';
      FHideList.Values['090404'] := '科处室指标审核';
      FHideList.Values['090405'] := '科处室指标下达';      
      FHideList.Values['090406'] := '汇总生成总指标';  
      
      FHideList.Values['090805'] := '科处室指标明细表';
      FHideList.Values['090806'] := '科处室指标汇总表';
      FHideList.Values['090807'] := '科处室指标调整明细表';
      FHideList.Values['090808'] := '科处室指标执行表';      
                      
      FHideList.Values['090510'] := '汇总生成科处室指标';  
      
    end;
    if Cds.FieldByName('CSVALUE').Asstring  = '2' then
    begin
      if (not GetISXCZB) and (not blCSZBLRKCS) then begin  //U8财政
          FHideList.Values['0904'] := '科处室指标管理';
          FHideList.Values['090401'] := '科处室指标编制';
          FHideList.Values['090402'] := '科处室指标登记簿';
          FHideList.Values['090403'] := '科处室指标调整登记簿';
          FHideList.Values['090404'] := '科处室指标审核';
          FHideList.Values['090405'] := '科处室指标下达';

          FHideList.Values['090805'] := '科处室指标明细表';
          FHideList.Values['090806'] := '科处室指标汇总表';
          FHideList.Values['090807'] := '科处室指标调整明细表';
          FHideList.Values['090808'] := '科处室指标执行表';

          FHideList.Values['090510'] := '汇总生成科处室指标';
      end else begin              //U8乡镇财政
          FHideList.Values['0903'] := '总指标管理';
          FHideList.Values['090301'] := '总指标编制';
          FHideList.Values['090302'] := '总指标登记簿';
          FHideList.Values['090303'] := '总指标调整登记簿';
          FHideList.Values['090304'] := '总指标审核';
          FHideList.Values['090305'] := '总指标下达';

          FHideList.Values['090801'] := '总指标明细表';
          FHideList.Values['090802'] := '总指标汇总表';
          FHideList.Values['090803'] := '总指标调整明细表';
          FHideList.Values['090804'] := '总指标执行表';
 
          FHideList.Values['090406'] := '汇总生成总指标';
      end;

//      FHideList.Values['0903'] := '总指标管理';
//      FHideList.Values['090301'] := '总指标编制';
//      FHideList.Values['090302'] := '总指标登记簿';
//      FHideList.Values['090303'] := '总指标调整登记簿';
//      FHideList.Values['090304'] := '总指标审核';
//      FHideList.Values['090305'] := '总指标下达';
//
//      FHideList.Values['090801'] := '总指标明细表';
//      FHideList.Values['090802'] := '总指标汇总表';
//      FHideList.Values['090803'] := '总指标调整明细表';
//      FHideList.Values['090804'] := '总指标执行表';
//
//      FHideList.Values['090406'] := '汇总生成总指标';
    end;
  finally
    Cds.Free;
  end;
  {2.FBI 获取的指标的参数--指标单笔跟踪控制，进行菜单的显示}
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FBI_ZBDBGZKZ'' ');
  try
    if Cds.FieldByName('CSVALUE').Asstring  = '0' then
    begin
      FHideList.Values['090507'] := '指标变更';   
    end;    
  finally
    Cds.Free;
  end;
end;

//远程功能隐藏、区分
procedure THideMenu.InitYBC(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  {1.YBC 获取的专版参数--是否乡镇，进行菜单的显示}
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FCP_DFXM'' ');
  try
    if Trim(Cds.FieldByName('CSVALUE').Asstring)  = '乡镇' then
    begin
      // 隐藏拨款申请功能
      FHideList.Values['110201'] := '拨款申请编制';
      FHideList.Values['110202'] := '拨款申请登记簿';
      FHideList.Values['110205'] := '拨款申请审核';
      FHideList.Values['110206'] := '拨款凭证登记簿';
      //隐藏支付功能
      FHideList.Values['1104'] := '支付管理';
      FHideList.Values['110401'] := '支付申请编制';
      FHideList.Values['110402'] := '支付申请登记簿';
      FHideList.Values['110403'] := '授权支付凭证编制';
      FHideList.Values['110404'] := '支付凭证成批录入';
      FHideList.Values['110405'] := '授权支付凭证登记簿';
      FHideList.Values['110406'] := '直接支付凭证登记簿';
      FHideList.Values['110407'] := '财政直接支付申请书';
      FHideList.Values['110408'] := '财政直接支付汇总申请书';
      FHideList.Values['110409'] := '支付凭证汇总';
      FHideList.Values['110410'] := '支付申请审核';    
    end else begin //不是乡镇，隐藏乡镇功能
      FHideList.Values['110209'] := '拨款申请单编制';
      FHideList.Values['110210'] := '拨款申请单上传';
      FHideList.Values['110211'] := '拨款申请单审批';
      FHideList.Values['110528'] := '拨款申请审批环节超时统计';
      FHideList.Values['110529'] := '预算执行情况汇总表';
      FHideList.Values['110530'] := '预算执行单位情况表';
      FHideList.Values['110531'] := '预算项目明细账';
    end ; 
  finally
    Cds.Free;
  end;
end ;

//拨款管理系统功能隐藏，区分
procedure THideMenu.InitFBS(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  {1.FBS 获取的专版参数--是否乡镇，进行菜单的显示}
  Cds := DataModulePub.GetCdsBySQL('Select CSVALUE from ZB_ZTCS where GSDM = '''+ AGSDM +''' AND KJND = '''+ AKJND + ''' AND CSDM = ''FCP_DFXM'' ');
  try
    if Trim(Cds.FieldByName('CSVALUE').Asstring)  = '乡镇' then
    begin
      //隐藏拨款凭证功能
      FHideList.Values['160301'] := '拨款申请审核';
      FHideList.Values['160302'] := '拨款申请生效';
      FHideList.Values['160303'] := '拨款申请生成拨款凭证';
      FHideList.Values['160304'] := '拨款申请查询';
      FHideList.Values['160305'] := '拨款凭证编制';
      FHideList.Values['160306'] := '拨款凭证成批录入';
      FHideList.Values['160307'] := '拨款凭证登记簿';
      FHideList.Values['160308'] := '汇总拨款凭证';
    end else begin //不是乡镇，隐藏乡镇功能
      FHideList.Values['160315'] := '指标自动生成用款计划';
      FHideList.Values['160316'] := '分月用款计划处理';
      FHideList.Values['160317'] := '拨款单登记';
      FHideList.Values['160318'] := '拨款单处理';
      FHideList.Values['160319'] := '拨款申请单生成拨款单';
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
      FHideList.Values['040109']:='凭证模板设置';
      FHideList.Values['580102']:='配置申请单编制';
      FHideList.Values['580301']:='调剂申请单编制';
      FHideList.Values['040206']:='卡片编制';
      FHideList.Values['040205']:='原始资产卡片编制';
      FHideList.Values['580201']:='变动申请单编制';
      FHideList.Values['040304']:='变动单编制';
      FHideList.Values['040306']:='资产卡片批量变动';
      FHideList.Values['040901']:='处置单编制';
      FHideList.Values['040501']:='担保申请单编制';
      FHideList.Values['040601']:='出租出借申请单编制';
      FHideList.Values['040701']:='评估申请单编制';
      FHideList.Values['040801']:='收益申请单编制';
      FHideList.Values['041001']:='盘点表';
      // Modified by Luxu 20130716 乡财不显示盘点菜单，因为显示错误？没发现这个问题，所以取消这个控制。
      //if (GszRelease = '乡镇财政') and (GszEdition = 'G') then // added by Luxu 20120910 乡财G版主管单位版中功能菜单显示错误。
      //  FHideList.Values['0410']:='资产盘点';
      FHideList.Values['580401']:='处置申请单编制';
      FHideList.Values['041101']:='折旧计算';
      FHideList.Values['041102']:='折旧登记簿';
      FHideList.Values['041103']:='折旧分配表';
      FHideList.Values['041104']:='月末结账';
      FHideList.Values['041105']:='凭证编制';
      FHideList.Values['041106']:='凭证箱';
      FHideList.Values['041108']:='反结账';
      FHideList.Values['580104']:='卡片生成';
      FHideList.Values['580203']:='变动单生成';
      FHideList.Values['580403']:='处置单生成';
    end
    else
    begin
      if GpsSeries=psR9 then
      begin
        FHideList.Values['5803']:='资产调剂'; // added by Luxu 20120514 既然子节点不显示，主节点也不显示
        FHideList.Values['580301']:='调剂申请单编制';
        FHideList.Values['580302']:='调剂申请单登记簿';
      end;
      FHideList.Values['040114']:='基础资料下发';
      FHideList.Values['0413']:='综合查询';
      FHideList.Values['041301']:='单位资产汇总统计表';
      FHideList.Values['041302']:='单位资产部门汇总统计表';
      FHideList.Values['041303']:='单位资产类别汇总统计表';
      FHideList.Values['041304']:='单位资产卡片汇总一览表';
      FHideList.Values['041305']:='类别资产汇总统计表';
      FHideList.Values['041002']:='盘点报告';
      Cds := DataModulePub.GetCdsBySQL('Select * from pubModSetup where isstart=''1'' and GSDM = '''+ AGSDM+''' and ModName = ''FAQC'' ');
      if Trim(Cds.FieldByName('BZ').AsString)='1' then
      begin
        FHideList.Values['040103']:='部门对应折旧科目设置';
        FHideList.Values['041101']:='折旧计算';
        FHideList.Values['041102']:='折旧登记簿';
        FHideList.Values['041103']:='折旧分配表';
        FHideList.Values['041107']:='折旧预测';
        FHideList.Values['041230']:='累计折旧增减情况统计表';
        FHideList.Values['041231']:='部门折旧情况统计表';
        FHideList.Values['041229']:='完成折旧计提情况统计表';
        FHideList.Values['041225']:='折旧一览表';
        FHideList.Values['041226']:='折旧计提明细表';
        FHideList.Values['041227']:='折旧计提部门明细表';
        FHideList.Values['041215']:='累计平均统计表';
        FHideList.Values['041228']:='计提时间统计表';
        //FHideList.Values['']:='';
      end;
    end;
    if not ( TPower.GetPower('37019') or TPower.GetPower('37020'))  then//部门资产管理员 变动权限挂在帐套参数下，如果登陆员没有帐套参数的查阅或编辑权限，则隐藏该功能点
      FHideList.Values['0400']:='系统设置';
  finally
    Cds.Free;
  end;
end;
//工资系统不显示菜单初始
procedure THideMenu.InitPA(AGSDM, AKJND:String);
var
  Cds:TClientDataSet;
begin

  Cds := DataModulePub.GetCdsBySQL( 'select * from pubmodsetup where gsdm='''+ AGSDM+'''' +' and modname=''PAAC''  ');
  try
    if Cds.FieldByName('IsStart').AsString='1' then  //工资统发
    begin 
      Cds := DataModulePub.GetCdsBySQL('Select * from GZ_Ztcs where GSDM = '''+ AGSDM+'''');

      if UpperCase(Cds.FieldByName('BBLX').AsString)='F' then  //主管单位
      begin
       // FHideList.Values['050110']:='部门工资项目设置';
       // FHideList.Values['050207']:='工资上传';
      end
      else                                                     //基层单位
      begin
        FHideList.Values['050101']:='定义工资类别';
        FHideList.Values['050111']:='工资项与经济科目对应关系';
        FHideList.Values['050113']:='支付模板设置';
        //FHideList.Values['050202']:='继承上月数据'; //2012-10-17 mengjin ZWR900067869 预算单位登录显示该菜单
        FHideList.Values['050206']:='数据下发';
        FHideList.Values['050208']:='数据接收';
        FHideList.Values['050209']:='工资数据审核';
        FHideList.Values['050308']:='生成支付凭证';
        FHideList.Values['050309']:='生成拨款凭证';
        FHideList.Values['050310']:='生成其它拨款凭证';
        FHideList.Values['050211']:='财政代编'; // 2013-07-11 mengjin 对预算单位不可见

        Gqx[ord(GZXGSDY_Edit)] := False;     //工资项公式设置
        Gqx[ord(GZZYLX_Edit)]  := False;     //职员类型设置
        Gqx[ord(GZGTSFF_Edit)] := False;     //个人所得税税率设置
        Gqx[ord(GZGZXM_Edit)]  := False;     //工资项目设置
      end;
    end else    //工资管理系统
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
    if Trim(Cds.FieldByName('SXZ').AsString) = '0' then  //事后模式
    begin
      FHideList.Values['3103']   := '预算执行';
      FHideList.Values['310301'] := '用款单编制';
      FHideList.Values['310302'] := '用款单登记簿';
    end;
  finally
    Cds.Free;
  end;
end;

//资金系统不显示菜单初始
procedure THideMenu.InitBM(AGSDM, AKJND: String);
var
  Cds:TClientDataSet;
begin
  {GBG}
  Cds := DataModulePub.GetCdsBySQL('select pzsjhz from zj_xxb where gsdm=' + QuotedStr(AGSDM));
  try
    if Trim(Cds.FieldByName('pzsjhz').AsString) = '1' then  //核算中心版
    begin
      FHideList.Values['070104']   := '内部银行账户对应表';
      FHideList.Values['0703'] := '贷还款管理';
      FHideList.Values['070301'] := '银行贷款单';
      FHideList.Values['070302'] := '内部贷款单';
      FHideList.Values['070303'] := '内部拆借单';
      FHideList.Values['070304'] := '银行贷款本金还款单';
      FHideList.Values['070305'] := '银行贷款利息还款单';
      FHideList.Values['070306'] := '内部贷款本金还款单';
      FHideList.Values['070307'] := '内部贷款利息还款单';
      FHideList.Values['070308'] := '内部拆借利息还款单';
      FHideList.Values['070309'] := '内部拆借本金还款单';
      FHideList.Values['070906'] := '贷款台账';
      FHideList.Values['070907'] := '贷款利息表';
      FHideList.Values['0710'] := '贷款计划';
      FHideList.Values['071001'] := '贷款计划';
      FHideList.Values['071002'] := '贷款执行情况分析';
    end
    else begin    //内部银行版
      FHideList.Values['071503']   := '从各开户单位账套引入各账户的当日结算数据';
    end;
  finally
    Cds.Free;
  end;
end;

class function THideMenu.IsHide(AGSDM, AKJND, AMenuCode: String): Boolean;
begin
  if not Assigned(HideMenu) then
    HideMenu := THideMenu.Create;
    
  {不同的单位登录，需要重新初始化}
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
    {汇总账套需要隐藏的内容}
    if Trim(Cds.FieldByName('ztlb').AsString) = '0' then
    begin
      FHideList.Values['0314']   := '汇总数据管理';
      FHideList.Values['031401'] := '设定单位';
      FHideList.Values['031402'] := '单位资料设置';
      FHideList.Values['031403'] := '汇总数据引入引出';
      FHideList.Values['031404'] := '汇总分析表';
    end;
  finally
    Cds.Free;
  end;
  //zhougf 2011.11.7
  if GDbType = ORACLE then
  begin
    FHideList.Values['030709'] := '预算外资金收支汇总表';
    FHideList.Values['030710'] := '预算外资金单位明细账';
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
        if FieldByName('CSDM').AsString = 'ZBJC' then//指标级次
        begin
          vZBJC := StrToIntDef(Trim(FieldByName('CSZ').AsString),1);
        end;
        if FieldByName('CSDM').AsString = 'ZBQYPF' then//指标启用批复
        begin
          blQYZBPF := FieldByName('CSZ').AsString = '1';
        end;
        if FieldByName('CSDM').AsString = 'JHQYPF' then//计划启用批复
        begin
          blQYJHPF := FieldByName('CSZ').AsString = '1';
        end;
        if FieldByName('CSDM').AsString = 'BBLX' then//版本类型
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
    ZGDWB://主管单位
    begin
      //主管单位屏蔽明细指标功能
      FHideList.Values['620209'] := '明细指标编制';
      FHideList.Values['620210'] := '明细指标审核';
      FHideList.Values['620211'] := '明细指标批复';
      FHideList.Values['620212'] := '明细指标登记簿';
      FHideList.Values['620218'] := '明细指标调整';
      FHideList.Values['620219'] := '明细指标调整登记簿';
      FHideList.Values['620305'] := '明细指标余额表';
      FHideList.Values['620306'] := '明细指标明细账';
      FHideList.Values['620307'] := '明细指标执行情况表';
      FHideList.Values['620308'] := '明细指标统计表';

      FHideList.Values['620230'] := '明细指标变更';
      FHideList.Values['620231'] := '明细指标变更登记簿';
      FHideList.Values['620240'] := '明细指标调剂';
      FHideList.Values['620241'] := '明细指标调剂登记薄';

      Case vZBJC of//一级指标
        1:
        begin
          FHideList.Values['620201'] := '总指标编制';
          FHideList.Values['620202'] := '总指标审核';
          FHideList.Values['620203'] := '总指标批复';
          FHideList.Values['620204'] := '总指标登记簿';
          FHideList.Values['620214'] := '总指标调整';
          FHideList.Values['620215'] := '总指标调整登记簿';
          FHideList.Values['620301'] := '总指标余额表';
          FHideList.Values['620302'] := '总指标明细账';

          if not blQYZBPF then
          begin
            FHideList.Values['620207'] := '单位指标批复';
          end;
        end;
        2:
        begin
          if not blQYZBPF then
          begin
            FHideList.Values['620203'] := '总指标批复';
            FHideList.Values['620207'] := '单位指标批复';
          end;
        end;
      end;
      //主管单位没有用款计划下达
      FHideList.Values['620220'] := '用款计划下达';
      //主管单位没有指标控制规则
      FHideList.Values['620213'] := '指标控制规则';
    end;
    JCDWB://基层单位
    begin
      //基层单位屏蔽总指标功能
      FHideList.Values['620201'] := '总指标编制';
      FHideList.Values['620202'] := '总指标审核';
      FHideList.Values['620203'] := '总指标批复';
      FHideList.Values['620204'] := '总指标登记簿';
      FHideList.Values['620214'] := '总指标调整';
      FHideList.Values['620215'] := '总指标调整登记簿';
      FHideList.Values['620301'] := '总指标余额表';
      FHideList.Values['620302'] := '总指标明细账';

      Case vZBJC of//一级指标
        1:
        begin
          FHideList.Values['620205'] := '单位指标编制';
          FHideList.Values['620206'] := '单位指标审核';
          FHideList.Values['620207'] := '单位指标批复';
          FHideList.Values['620208'] := '单位指标登记簿';
          FHideList.Values['620216'] := '单位指标调整';
          FHideList.Values['620217'] := '单位指标调整登记簿';
          FHideList.Values['620303'] := '单位指标余额表';
          FHideList.Values['620304'] := '单位指标明细账';
          if not blQYZBPF then
          begin
            FHideList.Values['620211'] := '明细指标批复';
          end;
        end;
        2:
        begin
          if not blQYZBPF then
          begin
            FHideList.Values['620207'] := '单位指标批复';
            FHideList.Values['620211'] := '明细指标批复';
          end;
        end;
      end;
      if not blQYYKJH then//如果没有启用用款计划
        FHideList.Values['620220'] := '用款计划下达'
      else
      begin
        if not blQYJHPF then//用款计划启用批复
          FHideList.Values['630103'] := '用款计划批复';
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
        if FieldByName('CSDM').AsString = 'ZBJC' then//指标级次
        begin
          vZBJC := StrToIntDef(Trim(FieldByName('CSZ').AsString),1);
        end;

        if FieldByName('CSDM').AsString = 'BBLX' then//版本类型
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

  // 预算编制
  if (GiBBMode = ZGDWB) then
  begin
    FHideList.Values['6106'] := '指标生成';
    FHideList.Values['610601'] := '指标生成';
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
  GetSysteMDIrectory(buff, 255); //取得system32的目录
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
function BplExecute(vBpl, vParams:WideString):Boolean; //维护单ZWR900035882
var
  vFile:String;
  FHandle:integer;
  Execute:TExecute;
  ModCode:String;
begin
  Result := False;
  vFile := ExtractFilePath(Application.ExeName)+vBpl;
  ModCode := TString.LeftStrBySp(vBpl, '.');
  
  //hch 检查外部调用文件不存在，给予更新或者提示
  if (GpsSeries = psR9i) and (GsSingleMode='0') then
  begin
    if (GCU<>nil) and GCU.Check(ModCode) then
      GCU.Update;
  end;

  if not FileExists(vFile) then
  begin
  	Application.MessageBox(PChar('文件"'+vFile+'"不存在， 请重新下载'),
    	'系统提示', MB_ICONWarning + MB_OK);
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
  FR9_IMPL: TUIR9_IMPL; //动态库控制类
  i:Integer;
  vGSDMS:string;
  vQueryParams:String;
begin
  {重新登录}
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
  //维护单ZWR900035882 执行其他调用功能 zhougf 2012.4.11
  else if UpperCase(TString.LeftStrBySp(vAction)) = 'EXECUTE' then
  begin
    result:= BplExecute(TString.RightStrBySp(vAction), vParams);
  end
  {执行模块的功能调用}
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
  //hch 增加工资接口类, 需要在宿主程序中定义，然后在工资中使用。
  TAutoObjectFactory.Create(ComServer, TSalaryFormula, CLASS_SalaryFormula,
    ciMultiInstance, tmApartment);
finalization
  GIPub := nil;
  
end.




