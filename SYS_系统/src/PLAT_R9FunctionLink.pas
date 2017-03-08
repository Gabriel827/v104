unit PLAT_R9FunctionLink;

interface
uses Sysutils,Classes,PLAT_QuickLink,PLAT_R9SubSystemIntf;
type TR9FunctionLink=class(TQuickLink)
protected
    FAppletFileName:String;
    FSubSystemName:String;

    FIntfSystem:IR9SubSystem;
end;

implementation

{ TR9FunctionLink }

end.
