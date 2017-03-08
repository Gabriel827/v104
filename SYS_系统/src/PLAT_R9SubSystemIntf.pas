unit PLAT_R9SubSystemIntf;

interface
uses Menus,PLAT_AdvUnknownInterface;

Type IR9SubSystem=interface(IAdvUnknown)
function  GetAppletIcon:Integer;
procedure LoadApplication(ShellApplication:Integer);
procedure FreeApplication;
function  GetMainMenu:TMenuItem;
procedure ExeMenuItem(MenuCaption:PChar);
function  GetApplicationTitle:String;
procedure ExecuteRigisterFunction(FunctionName,ParameterNames,ParameterValues:String);


end;
implementation

end.
