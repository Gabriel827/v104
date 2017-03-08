unit PLAT_RegisterFunctionLink;


interface
uses PLAT_R9FunctionLink,Sysutils,Classes;
type TRegisterFunctionLink=Class(TR9FunctionLink)
private
    FFunctionName:String;
    FParameterNames:String;
    FParameterValues:string;
public
    procedure Execute;override;
    procedure LoadFromStream(Stream:TStream);override;
    procedure SaveToStream(Stream:TStream);override;

end;

implementation

{ TRegisterFunctionLink }
uses PLAT_Utils,PLAT_R9SystemFactory;

procedure TRegisterFunctionLink.Execute;
begin
    inherited;
    self.FIntfSystem.ExecuteRigisterFunction(FFunctionName,FParameterNames,FParameterValues);
end;

procedure TRegisterFunctionLink.LoadFromStream(Stream: TStream);
var
szData:String;
begin
    inherited;
    TUtils.LoadStringFromStream (Stream,szData);

    Tutils.LoadStringFromStream (Stream,FCaption);
    TUtils.LoadStringFromStream(Stream,FDescription);
    Stream.Read(FLeft,SizeOf(FLeft));
    Stream.Read (FTop,SizeOf(FTop));

    TUtils.LoadStringFromStream(Stream,FSubSystemName );
    TUtils.LoadStringFromStream (Stream,FAppletFileName);
    TUtils.LoadStringFromStream(Stream,FFunctionName);
    TUtils.LoadStringFromStream(Stream,FParameterNames);
    TUtils.LoadStringFromStream(Stream,FParameterValues);

end;

procedure TRegisterFunctionLink.SaveToStream(Stream: TStream);
var
szData:String;
begin
    inherited;
    szData:=self.ClassName ;
    TUtils.SaveStringToStream (Stream,szData);

    //pub start
    Tutils.SaveStringToStream (Stream,FCaption);
    TUtils.SaveStringToStream(Stream,FDescription);
    Stream.Write(FLeft,SizeOf(FLeft));
    Stream.Write (FTop,SizeOf(FTop));
    //pub start

    TUtils.SaveStringToStream(Stream,FSubSystemName );
    TUtils.SaveStringToStream (Stream,FAppletFileName);
    TUtils.SaveStringToStream(Stream,FFunctionName);
    TUtils.SaveStringToStream(Stream,FParameterNames);
    TUtils.SaveStringToStream(Stream,FParameterValues);
    FIntfSystem:=TR9SystemFactory.GetInstance.GetSubSysByName (FSubSystemName ,FAppletFileName );





end;

end.
