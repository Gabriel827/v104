unit PLAT_PlatFunctionLink;

interface
uses Menus, Classes, PLAT_QuickLink;
type
  TPlatFunctionLink = class(TQuickLink)
  private
    FPopupMenu: TPopupMenu;
    FMenuItem: TMenuItem;
    procedure SetMenuItem(const Value: TMenuItem);
    function FindMenuItem(szData: string): TMenuItem;
    procedure RefreshPopupMenu;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute; override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;

  end;

implementation

{ TPlatFunctionLink }
uses PLAT_Utils, Windows, Forms;

procedure TPlatFunctionLink.Execute;
var
  pt: TPoint;
begin
  inherited;
  if MenuItem.Count = 0 then
    MenuItem.Click
  else
  begin
    GetCursorPos(pt);
    RefreshPopupMenu;
    FPopupMenu.Popup(pt.x, pt.y);

  end;

end;

procedure TPLatFunctionLink.RefreshPopupMenu;
begin
  FPopupMenu.Items.Clear;
  FPopupMenu.Items.Add(MenuItem);
end;

function TPlatFunctionLink.FindMenuItem(szData: string): TMenuItem;
begin
  Result := Application.MainForm.FindComponent(szData) as TMenuItem;
end;

procedure TPlatFunctionLink.LoadFromStream(Stream: TStream);
var
  szData: string;
begin
  inherited;
  TUtils.LoadStringFromStream(Stream, szData);

  Tutils.LoadStringFromStream(Stream, FCaption);
  TUtils.LoadStringFromStream(Stream, FDescription);
  Stream.Read(FLeft, SizeOf(FLeft));
  Stream.Read(FTop, SizeOf(FTop));

  TUtils.LoadStringFromStream(Stream, szData);
  FMenuItem := FindMenuItem(szData);

end;

procedure TPlatFunctionLink.SaveToStream(Stream: TStream);
var
  i: Integer;
  szData: string;
begin
  szData := self.ClassName;
  TUtils.SaveStringToStream(Stream, szData);

  //pub start
  Tutils.SaveStringToStream(Stream, FCaption);
  TUtils.SaveStringToStream(Stream, FDescription);
  Stream.Write(FLeft, SizeOf(FLeft));
  Stream.Write(FTop, SizeOf(FTop));
  //pub start

  TUtils.SaveStringToStream(Stream, MenuItem.Name);

end;

procedure TPlatFunctionLink.SetMenuItem(const Value: TMenuItem);
begin
  FMenuItem := Value;
end;

constructor TPlatFunctionLink.Create;
begin
  FPopupMenu := TPopupMenu.Create(Forms.Application);
end;

destructor TPlatFunctionLink.Destroy;
begin
  FpopupMenu.Free;
  inherited;
end;

end.
