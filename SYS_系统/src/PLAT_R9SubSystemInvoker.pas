unit PLAT_R9SubSystemInvoker;


interface
uses Sysutils,Menus,ComObj,PLAT_R9SubSystemIntf,Windows,Forms,PLAT_AdvInterfacedObject;
type
TGetAppletIcon=function:Integer;stdcall;
TLoadApplication=procedure (ShellApplication:Integer);stdcall;
TFreeApplication=procedure;stdcall;
TGetMainMenu=function :TMenuItem ;Stdcall;
TExeMenuItem=Procedure(MenuCaption:PChar);stdcall;
TGetApplicationTitle=procedure(szTitleName:PChar;var iCount:Integer);stdcall;

TR9SubSystemInvoker=Class(TAdvInterfacedObject,IR9SubSystem)
private
    FExecuteGetAppletIcon:TGetAppletIcon;
    FExecuteLoadApplication:TLoadApplication;
    FExecuteFreeApplication:TFreeApplication;
    FExecuteGetMainMenu:TGetMainMenu;
    FExecuteExeMenuItem:TExeMenuItem;
    FExecuteGetApplicationTitle:TGetApplicationTitle;
    HModule:THandle;
public
    Constructor Create(FileName:String);
    Destructor  Destory;
    function  GetAppletIcon:Integer;
    procedure LoadApplication(ShellApplication:Integer);
    procedure FreeApplication;
    function  GetMainMenu:TMenuItem;
    procedure ExeMenuItem(MenuCaption:PChar);
    function  GetApplicationTitle:String;
    procedure ExecuteRigisterFunction(FunctionName,ParameterNames,ParameterValues:String);

end;
implementation





{ TR9SubSystemInvoker }

constructor TR9SubSystemInvoker.Create(FileName: String);
begin
    hModule:=LoadLibrary(PChar(FileName));
    if hModule=0 then
        RaiseLastWin32Error;
    //@FExecuteGetAppletIcon:=GetProcAddress(hModule,'GetAppletIcon');
    //if @FExecuteGetAppletIcon=nil then
    //    RaiseLastWin32Error;
    @FExecuteLoadApplication:=GetProcAddress(hModule,'LoadApplication');
    if @FExecuteLoadApplication=nil then
        RaiseLastWin32Error;

    @FExecuteFreeApplication:=GetProcAddress(hModule,'FreeApplication');
    if @FExecuteFreeApplication=nil then
        RaiseLastWin32Error;

    @FExecuteGetMainMenu:=GetProcAddress(hModule,'GetMainMenu');
    if @FExecuteGetMainMenu=nil then
        RaiseLastWin32Error;

    @FExecuteExeMenuItem:=GetProcAddress(hModule,'ExeMenuItem');
    if @FExecuteExeMenuItem=nil then
        RaiseLastWin32Error;

    @FExecuteGetApplicationTitle:=GetProcAddress(hModule,'GetApplicationTitle');
    if @FExecuteGetApplicationTitle=nil then
        RaiseLastWin32Error;

    FExecuteLoadApplication(Integer(Application));


end;

destructor TR9SubSystemInvoker.Destory;
begin
    //FreeApplication();
    //FreeLibrary(hModule);

end;

procedure TR9SubSystemInvoker.ExecuteRigisterFunction(FunctionName,
  ParameterNames, ParameterValues: String);
begin
    //hehe
end;

procedure TR9SubSystemInvoker.ExeMenuItem(MenuCaption: PChar);
begin
    FExecuteExeMenuItem(MenuCaption);

end;

procedure TR9SubSystemInvoker.FreeApplication;
begin
    FExecuteFreeApplication();

end;

function TR9SubSystemInvoker.GetAppletIcon: Integer;
begin
    Result:=FExecuteGetAppletIcon();
end;

function TR9SubSystemInvoker.GetApplicationTitle: String;
var
str:String;
n:Integer;
begin
    SetLength(str,255);
    FExecuteGetApplicationTitle(PChar(str),n);
    Result:=Copy(str,1,n);
    Application.Title:=Result;


end;

function TR9SubSystemInvoker.GetMainMenu: TMenuItem;
begin
    Result:=FExecuteGetMainMenu();

end;

procedure TR9SubSystemInvoker.LoadApplication(ShellApplication: Integer);
begin
    FExecuteLoadApplication(Integer(Application));

end;

end.
