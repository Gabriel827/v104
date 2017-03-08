unit PLAT_Utils;

interface
uses Classes, DBClient, menus, shdocvw;
type
  TUtils = class
  private
  public
    class procedure SaveStringToStream(Stream: TStream; const szData: string);
    class procedure LoadStringFromStream(Stream: TStream; var szData: string);
    class procedure PeekStringFromStream(Stream: TStream; var szData: string);
    class function GetRemoteServer: TCustomRemoteServer;
    class function GetTempDir: string;
    class function GetDatabaseName: string;
    class function GetSearchProviderName: string;
    class function GetUpdateProviderName: string;
    class function GetCurrentUser: string;
    class function GetLawRuleBrowser: TWebbrowser;
    class function GetLawRuleMenuItem: TMenuItem;
    class function GetProSign: string;
    class procedure ShowLawRule;

  end;

implementation

{ TUtils }
uses Windows, Pub_Global, DataModuleMain{$IFNDEF ocx}, BackGroundUnit{$ENDIF};

class function TUtils.GetDatabaseName: string;
begin
  if GDBType = Oracle then
  begin
    Result := 'ORACLE'

  end
  else
    Result := 'MSSQL';
end;

class procedure TUtils.ShowLawRule;
begin
{$IFNDEF ocx}
  BackGroundUnit.FormBackGround.ShowLawRule;
{$ENDIF}
end;

class function TUtils.GetSearchProviderName: string;
begin
  case GDBType of
    MSSQL: Result := GPubProviderOpenName;
    ORACLE:
      //if GProSign='BG' then
      //    Result:='DataSetProviderPubDynamic'
      //else
      Result := GPubProviderOpenName;

  end;

end;

class function TUtils.GetUpdateProviderName: string;
begin
  case GDBType of
    MSSQL: Result := 'DataSetProviderSaveHF';
    ORACLE: Result := 'DataSetProviderSaveHF';
  end;

end;

class function TUtils.GetRemoteServer: TCustomRemoteServer;
begin
  Result := DataModulePub.MidasConnectionPub;
end;

class function TUtils.GetLawRuleMenuItem: TMenuItem;
begin
end;

class function TUtils.GetTempDir: string;
var
  str: string;
  n: Integer;
begin
  n := 255;
  SetLength(str, n);
  GetTempPath(n, PChar(str));
  Result := string(PChar(str));

end;

class procedure TUtils.LoadStringFromStream(Stream: TStream;
  var szData: string);
var
  i: Integer;
begin
  Stream.Read(i, SizeOf(i));
  SetLength(szData, i);
  Stream.Read(szData[1], i);
end;

class procedure TUtils.PeekStringFromStream(Stream: TStream;
  var szData: string);
var
  i: Integer;
begin
  Stream.Read(i, SizeOf(i));
  SetLength(szData, i);
  Stream.Read(szData[1], i);
  Stream.Position := Stream.Position - i - SizeOf(i);

end;

class procedure TUtils.SaveStringToStream(Stream: TStream;
  const szData: string);
var
  i: Integer;
begin
  i := Length(szData);
  Stream.Write(i, sizeof(i));
  Stream.Write(szData[1], i);

end;

class function TUtils.GetCurrentUser: string;
begin
  Result := Pub_Global.GCzy.name;
end;

class function TUtils.GetLawRuleBrowser: TWebbrowser;
begin
  result := nil;
  Result := BackGroundUnit.FormBackGround.WebBrowserLawRules;
end;

class function TUtils.GetProSign: string;
begin
  Result := GProSign;
end;

end.
