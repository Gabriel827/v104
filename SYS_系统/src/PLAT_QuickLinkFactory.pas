unit PLAT_QuickLinkFactory;
//Design Pattern:Simple Factory

interface
uses PLAT_QuickLink, Classes, Sysutils, PLAT_Utils;
type
  TQuickLinkFactory = class
  private
    constructor Create;
  public
    class function GetInstance: TQuickLinkFactory;
    function CreateQuickLink(QuickLinkName: string): TQuickLink;
    function CreateQuickLinkFromStream(Stream: TStream): TQuickLink;
  end;
implementation

{ TQuickLinkFactory }
uses PLAT_GroupLink, PLAT_PLATFunctionLink, PLAT_TreeFuncNodeLink, PLAT_DocumentLink;
var
  Glob_QuickLinkFactory: TQuickLinkFactory;

constructor TQuickLinkFactory.Create;
begin
  inherited;
  //
end;

function TQuickLinkFactory.CreateQuickLink(
  QuickLinkName: string): TQuickLink;
begin
  if uppercase(QuickLinkName) = uppercase('TGroupLink') then
    Result := TGroupLink.Create
  else if uppercase(QuickLinkName) = uppercase('TPLATFunctionLink') then
    Result := TPLATFunctionLink.Create
  else if uppercase(QuickLinkName) = uppercase('TDocumentLink') then
    Result := TDocumentLink.Create('')
  else if uppercase(QuickLinkName) = uppercase('TTreeFuncNodeLink') then
    Result := TTreeFuncNodeLink.Create('')
  else

    raise Exception.create('unknown ClassName');
end;

function TQuickLinkFactory.CreateQuickLinkFromStream(
  Stream: TStream): TQuickLink;
var
  ClassName: string;
begin
  TUtils.PeekStringFromStream(Stream, ClassName);
  Result := CreateQuickLink(ClassName);
  Result.LoadFromStream(Stream);

end;

class function TQuickLinkFactory.GetInstance: TQuickLinkFactory;
begin
  if not Assigned(Glob_QuickLinkFactory) then
    Glob_QuickLinkFactory := TQuickLinkFactory.Create();
  Result := Glob_QuickLinkFactory;
end;

end.
