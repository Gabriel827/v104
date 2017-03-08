unit PLAT_R9SystemFactory;

interface
uses Classes,PLAT_R9SubSystemIntf;

type TR9SystemFactory=class
private
    FItems:TStringList;
    constructor Create;
    Destructor  Destory;
public
    class Function GetInstance:TR9SystemFactory;
    function GetSubSysByName(Name:String;FileName:String):IR9SubSystem;


end;


implementation

uses Sysutils ,PLAT_R9SubSystemInvoker,Forms  ;
var Glob_R9SystemFactory :TR9SystemFactory;


{ TR9SystemFactory }

constructor TR9SystemFactory.Create;
begin
    if not Assigned(Glob_R9SystemFactory) then
    begin
        FItems:=TStringList.Create;
    end;

end;

destructor TR9SystemFactory.Destory;
begin
    if Assigned(Glob_R9SystemFactory) then
        Glob_R9SystemFactory.FItems.Free;
    Glob_R9SystemFactory.Free;

end;

class function TR9SystemFactory.GetInstance: TR9SystemFactory;
begin
    if not Assigned(Glob_R9SystemFactory) then
    begin
        Glob_R9SystemFactory:=TR9SystemFactory.Create();
    end;
    Result:=Glob_R9SystemFactory;


end;

function TR9SystemFactory.GetSubSysByName(Name: String;FileName:String): IR9SubSystem;
var
i:Integer;
sys:TR9SubSystemInvoker;
intf:IR9SubSystem;
begin
    if Name<>'' then
    begin
        for i:=0 to FItems.Count-1 do
        begin
            Intf:=TR9SubSystemInvoker(FItems.Objects[i]);
            if Intf.GetApplicationTitle =Name then
            begin
                Result:=Intf;
                Exit;
            end;

        end;
        Raise Exception.Create('没有创建的子系统'+Name);


    end
    else
    begin
        for i:=0 to FItems.Count-1 do
        begin
            if Uppercase(ExtractFileName(FItems[i]))=uppercase(ExtractFileDir(FileName)) then
            begin
                Result:=TR9SubSystemInvoker(FItems.Objects[i]);
                Exit;
            end;

        end;
        Sys:=TR9SubSystemInvoker.Create(ExtractFilePath(application.exename)+'\'+FileName);
        FItems.AddObject(ExtractFilePath(application.exename)+'\'+FileName ,Sys);


    end;


end;

end.
