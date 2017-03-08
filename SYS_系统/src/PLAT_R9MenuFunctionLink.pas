unit PLAT_R9MenuFunctionLink;
interface
uses PLAT_R9FunctionLink,Sysutils,Classes;

type TR9MenuFunctionLink=Class(TR9FunctionLink)
private
    FMenuCaption:String;
public
    procedure Execute;override;
    procedure LoadFromStream(Stream:TStream);override;
    procedure SaveToStream(Stream:TStream);override;
end;

implementation
uses PLAT_utils,PLAT_R9SystemFactory;

{ TR9MenuFunctionLink }

procedure TR9MenuFunctionLink.Execute;
begin
    inherited;
    FIntfSystem.ExeMenuItem (PChar(FMenuCaption));
end;

procedure TR9MenuFunctionLink.LoadFromStream(Stream: TStream);
var szData:String;
begin
    inherited;
    TUtils.LoadStringFromStream (Stream,szData);
    TUtils.LoadStringFromStream (Stream,FAppletFileName);
    TUtils.LoadStringFromStream(Stream,FSubSystemName);

    Tutils.LoadStringFromStream (Stream,FCaption);
    TUtils.LoadStringFromStream(Stream,FDescription);
    Stream.Read(FLeft,SizeOf(FLeft));
    Stream.Read (FTop,SizeOf(FTop));

    TUtils.LoadStringFromStream(Stream,szData);
    FMenuCaption:=szData;
    FIntfSystem:=TR9SystemFactory.GetInstance.GetSubSysByName (FSubSystemName ,FAppletFileName );


end;




procedure TR9MenuFunctionLink.SaveToStream(Stream: TStream);
var
    i:Integer;
    szData:String;
begin
    szData:=self.ClassName ;

    TUtils.SaveStringToStream (Stream,szData);
    TUtils.SaveStringToStream (Stream,FAppletFileName);
    TUtils.SaveStringToStream(Stream,FSubSystemName);
    //pub start
    Tutils.SaveStringToStream (Stream,FCaption);
    TUtils.SaveStringToStream(Stream,FDescription);
    Stream.Write(FLeft,SizeOf(FLeft));
    Stream.Write (FTop,SizeOf(FTop));
    //pub start

    TUtils.SaveStringToStream(Stream,FMenuCaption);


end;




end.
