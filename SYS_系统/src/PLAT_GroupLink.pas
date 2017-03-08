unit PLAT_GroupLink;

interface
uses Classes, PLAT_QuickLink, Sysutils, Windows, Menus, PLAT_Utils, Forms;
type
  TGroupLink = class(TQuickLink)
  private
    FItems: TList;
    FOpened: Boolean;
    PopupMenu: TPopupMenu;
    procedure ToMenuItems(mi: TMenuItem);
    procedure RefreshPopupMenu;
    procedure MenuItemClick(Sender: TObject);
    procedure SetOpened(const Value: Boolean);
    function TrimMenuCaption(str: string): string;

  public

    constructor Create;
    destructor Destory;
    procedure Execute; override;
    function GetLink(Index: Integer): TQuickLink;
    function GetCount: Integer;
    function FindLink(ACaption: string): TQuickLink;
    procedure Insert(index: Integer; Item: TQuickLink);
    procedure Delete(Index: Integer);
    procedure Clear;

    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromStream(Stream: Tstream); override;

    procedure FromMenuItems(mi: TMenuItem);
    property Opened: Boolean read FOpened write SetOpened;
  end;

implementation

{ TGroupLink }
uses PLAT_QuickLinkFactory, PLAT_PlatFunctionLink;

procedure TGroupLink.Clear;
var
  i: Integer;
begin
  for i := FItems.Count - 1 downto 0 do
  begin
    Delete(i);
  end;

end;

constructor TGroupLink.Create;
begin
  FItems := TList.Create;
  PopupMenu := TPopupMenu.Create(Application);

end;

procedure TGroupLink.Delete(Index: Integer);
begin
  GetLink(index).Free;
  FItems.Delete(index);
end;

destructor TGroupLink.Destory;
var
  i: Integer;
begin
  PopupMenu.free;
  Clear;
  FItems.Free;

end;

procedure TGroupLink.Execute;
var
  pt: TPoint;
begin
  GetCursorPos(pt);
  RefreshPopupMenu;
  if PopupMenu.Items.Count = 0 then
    exit;
  PopupMenu.Popup(pt.x, pt.y);

end;

function TGroupLink.GetLink(Index: Integer): TQuickLink;
begin
  if (index < 0) or (index >= FItems.Count) then
    raise Exception.CreateFmt('不存在的索引号%d', [Index]);
  Result := FItems[index];

end;

procedure TGroupLink.Insert(index: Integer; Item: TQuickLink);
begin
  FItems.Insert(index, Item);

end;

procedure TGroupLink.LoadFromStream(Stream: Tstream);
var
  i: Integer;
  szData: string;
  objCount: Integer;
begin

  TUtils.LoadStringFromStream(Stream, szData);
  Stream.Read(objCount, sizeOf(ObjCount));
  Clear;

  //Pub
  Tutils.LoadStringFromStream(Stream, FCaption);
  TUtils.LoadStringFromStream(Stream, FDescription);
  Stream.Read(FLeft, SizeOf(FLeft));
  Stream.Read(FTop, SizeOf(FTop));
  //Pub

  for i := 0 to ObjCount - 1 do
  begin
    Insert(i, TQuickLinkFactory.GetInstance.CreateQuickLinkFromStream(stream));

  end;

end;

procedure TGroupLink.RefreshPopupMenu;
begin

end;

procedure TGroupLink.SaveToStream(Stream: TStream);
var
  i: Integer;
  szData: string;
begin
  szData := self.ClassName;
  TUtils.SaveStringToStream(Stream, szData);
  i := FItems.Count;
  Stream.Write(i, SizeOf(i));

  //pub start
  Tutils.SaveStringToStream(Stream, FCaption);
  TUtils.SaveStringToStream(Stream, FDescription);
  Stream.Write(FLeft, SizeOf(FLeft));
  Stream.Write(FTop, SizeOf(FTop));
  //pub start

  for i := 0 to FItems.Count - 1 do
  begin
    GetLink(i).SaveToStream(Stream);
  end;

end;

procedure TGroupLink.ToMenuItems(mi: TMenuItem);
var
  i: Integer;
  miAdd: TMenuItem;
begin
  mi.Clear;
  for i := 0 to FItems.Count - 1 do
  begin
    miAdd := TMenuItem.Create(Application);
    miAdd.Caption := GetLink(i).Caption;
    if GetLink(i) is TGroupLink then
    begin
      (GetLink(i) as TGroupLink).ToMenuItems(miAdd);
    end
    else
    begin
      mi.Tag := Integer(GetLink(i));
      mi.OnClick := MenuItemClick;
    end;
    mi.Insert(mi.Count, miAdd);

  end;

end;

procedure TGroupLink.MenuItemClick(Sender: TObject);
begin
  TQuickLink((Sender as TMenuItem).Tag).Execute;

end;

function TGroupLink.GetCount: Integer;
begin
  Result := self.FItems.Count;
end;

procedure TGroupLink.SetOpened(const Value: Boolean);
begin
  FOpened := Value;
end;

procedure TGroupLink.FromMenuItems(mi: TMenuItem);
var
  i: Integer;
  ALink: TQuickLink;
begin
  Clear;
  Caption := trimMenuCaption(mi.Caption);
  for i := 0 to mi.Count - 1 do
  begin
    if mi[i].Caption = '-' then
      continue;
    if mi[i].Count = 0 then
    begin
      ALink := TQuickLinkFactory.GetInstance.CreateQuickLink('TPlatFunctionLink');
      ALink.Caption := TrimMenuCaption(mi[i].Caption);
      (ALink as TPlatFunctionLink).MenuItem := mi[i];
    end
    else
    begin
      ALink := TQuickLinkFactory.GetInstance.CreateQuickLink('TGroupLink');
      (ALink as TGroupLink).FromMenuItems(mi[i]);
    end;
    self.Insert(GetCount, ALink);
  end;
end;

function TGroupLink.TrimMenuCaption(str: string): string;
//功能(&C) ->功能
var
  i: integer;
begin
  i := Pos('(&', str);
  if i <> 0 then
  begin
    Result := Copy(str, 1, i - 1);
  end
  else
    Result := str;
end;

function TGroupLink.FindLink(ACaption: string): TQuickLink;
var
  i: Integer;
  ALink: TQuickLink;
begin
  Result := nil;
  if Caption = ACaption then
  begin
    Result := self;
    exit;
  end;
  for i := 0 to GetCount - 1 do
  begin
    if GetLink(i) is TGroupLink then
    begin
      ALink := (GetLink(i) as TGroupLink).FindLink(ACaption);
      if ALink <> nil then
      begin
        Result := ALink;
        Exit;
      end;
    end
    else if (GetLink(i)).Caption = ACaption then
    begin
      Result := GetLink(i);
      exit;
    end
    else
      Result := nil;
  end;

end;

end.
