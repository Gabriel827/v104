unit PLAT_TreeFuncNodeLink;

interface
uses Menus, Classes, Comctrls, PLAT_QuickLink;
type
  TTreeFuncNodeLink = class(TQuickLink)
  private
    FPopupMenu: TPopupMenu;
    FMenuItem: TMenuItem;
    FNodeLevel: Integer;

    procedure SetMenuItem(const Value: TMenuItem);
    function FindTreeNode: TTreeNode; overload;
    function FindTreeNode(szText: string): TTreeNode; overload;

    procedure RefreshPopupMenu;

    procedure AddMenuItemsFromNode(mi: TMenuItem; Node: TTreeNode);
    function FindTreeNode(TreeNode: TTreeNode; szText: string): TTreeNode; overload;
    procedure MenuItemClick(Sender: TObject);
    procedure SetNodeLevel(const Value: Integer);
  public
    ImageIndex: Integer;
    constructor Create(NodeText: string);
    destructor Destroy; override;
    procedure Execute; override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure UpdateLinker(Linker: TObject); override;
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
    property NodeLevel: Integer read FNodeLevel write SetNodeLevel;
  end;

implementation

{ TPlatFunctionLink }
uses PLAT_Utils, Windows, Forms, Dialogs, Sysutils, Main;

procedure TTreeFuncNodeLink.Execute;
var
  pt: TPoint;

begin
  with TFormMain(Application.MainForm).TreeViewFunc do
  begin
    Selected := self.FindTreeNode;
    if Selected = nil then
      exit;
    if Selected.Count = 0 then
      TFormMain(Application.MainForm).FuncTreeClick

    else
    begin
      GetCursorPos(pt);
      RefreshPopupMenu;
      FPopupMenu.Popup(pt.x, pt.y);
    end;
  end;

end;

procedure TTreeFuncNodeLink.RefreshPopupMenu;
var
  Node: TTreeNode;
begin
  FPopupMenu.Items.Clear;
  NOde := FindTreeNode;
  self.AddMenuItemsFromNode(FPopupMenu.Items, Node);
end;

procedure TTreeFuncNodeLink.AddMenuItemsFromNode(mi: TMenuItem; Node: TTreeNode);
var
  i: Integer;
  aMi: TMenuItem;
begin

  mi.Caption := node.Text;
  for i := 0 to Node.Count - 1 do
  begin
    Ami := TMenuItem.Create(Forms.application);
    AddMenuItemsFromNode(Ami, Node.Item[i]);
    if AMi.Count = 0 then
      Ami.OnClick := MenuItemClick;
    mi.Add(Ami);

  end;

  {for i:=0 to Mi.Count-1 do
  begin
      if mi[i].Caption='-' then continue;
      ANode:=TreeViewFunc.Items.AddChild (Node,TrimMenuCaption(mi[i].Caption));
      AddMenuItems(mi[i],ANode);

  end;
  }

end;

procedure TTreeFuncNodeLink.LoadFromStream(Stream: TStream);
var
  szData: string;
begin
  TUtils.LoadStringFromStream(Stream, szData);
  Tutils.LoadStringFromStream(Stream, FCaption);
  TUtils.LoadStringFromStream(Stream, FDescription);
  TUtils.LoadStringFromStream(Stream, FPNodeCaption); //加入一个上级结点标题的串
  TUtils.LoadStringFromStream(Stream, FPModCode);
  Stream.Read(FLeft, SizeOf(FLeft));
  Stream.Read(FTop, SizeOf(FTop));
  Stream.Read(FNodeLevel, SizeOf(FNodeLevel));

  //FMenuItem:=FindMenuItem(szData);
end;

procedure TTreeFuncNodeLink.SaveToStream(Stream: TStream);
var
  i: Integer;
  szData: string;
begin
  try
    szData := self.ClassName;
    TUtils.SaveStringToStream(Stream, szData);
    //pub start
    Tutils.SaveStringToStream(Stream, FCaption);
    TUtils.SaveStringToStream(Stream, FDescription);
    TUtils.SaveStringToStream(Stream, FPNodeCaption); //加入一个上级结点标题的串
    TUtils.SaveStringToStream(Stream, FPModCode);
    Stream.Write(FLeft, SizeOf(FLeft));
    Stream.Write(FTop, SizeOf(FTop));
    //pub start
    Stream.Write(FNodeLevel, SizeOf(FNodeLevel));
  except

  end;
end;

procedure TTreeFuncNodeLink.SetMenuItem(const Value: TMenuItem);
begin
  FMenuItem := Value;
end;

constructor TTreeFuncNodeLink.Create(NodeText: string);
begin
  inherited Create();
  self.Caption := NodeText;
  self.ImageIndex := ImageIndex;
  FPopupMenu := TPopupMenu.Create(Forms.Application);
  FPopupMenu.AutoHotkeys := maManual;

end;

destructor TTreeFuncNodeLink.Destroy;
begin
  FpopupMenu.Free;
  inherited;
end;

function TTreeFuncNodeLink.FindTreeNode: TTreeNode;
var
  i: Integer;
  treeNode: TTreeNode;
begin
  Result := nil;
  for i := 0 to TFormMain(Application.MainForm).TreeViewFunc.Items.Count - 1 do
  begin
    TreeNode := TFormMain(Application.MainForm).TreeViewFunc.Items[i];
    //为了处理菜单重名的问题而加的处理  Hany an  2006.01.14
    if TreeNode.Parent = nil then
    begin
      // 崔立国 2011.11.10 先检查当前快捷方式所属模块菜单是否已经初始化，如果没有则先初始化再查找。
      if SameText(PTreeRec(TreeNode.Data)^.sModCode, FPModCode) then
      begin
        // 崔立国 2011.11.10 先检查当前快捷方式所属模块菜单是否已经初始化，如果没有则先初始化再查找。
        TFormMain(Application.MainForm).InitModSubTreeNodeAndMenuBox(TreeNode);

        if (TreeNode.Text = Caption) and (treeNode.Level = FNodeLevel) then
        begin
          Result := Treenode;
          Break;
        end
        else
          Result := FindTreeNode(TreeNode, Caption);
      end;
    end
    else
    begin
      //and (treeNode.Level = FNodeLevel)  暂时屏蔽功能
      if (TreeNode.Text = Trim(Caption)) and
        (FPNodeCaption = TreeNode.Parent.Text) then
      begin
        Result := Treenode;
        Break;
      end
      else
        Result := FindTreeNode(TreeNode, Caption);
    end;
    if Result <> nil then
      break;
  end;
end;

function TTreeFuncNodeLink.FindTreeNode(TreeNode: TTreeNode; szText: string): TTreeNode;
var
  i: Integer;
  AtreeNode: TTreeNode;
begin
  Result := nil;
  for i := 0 to TreeNode.Count - 1 do
  begin
    ATreeNode := TreeNode[i];
    // Bryan 20040901
    if (ATreeNode.Text = szText) and (not ATreeNode.HasChildren) {and (treeNode.Level = FNodeLevel)} then
    begin
      Result := ATreenode;
      break;
    end
    else
      Result := FindTreeNode(ATreeNode, szText);

    if Result <> nil then
      break;
  end;
end;

procedure TTreeFuncNodeLink.MenuItemClick(Sender: TObject);
var
  szCaption: string;
begin
  if (Sender is TMenuItem) then
  begin
    szCaption := (Sender as TMenuItem).Caption;
    TFormMain(Application.MainForm).TreeViewFunc.Selected := FindTreeNode(szCaption);
    TFormMain(Application.MainForm).FuncTreeClick

  end;
end;

function TTreeFuncNodeLink.FindTreeNode(szText: string): TTreeNode;
var
  i: integer;
var
  TreeNode: TTreeNode;
begin
  Result := nil;
  for i := 0 to TFormMain(Application.MainForm).TreeViewFunc.Items.Count - 1 do
  begin
    TreeNode := TFormMain(Application.MainForm).TreeViewFunc.Items[i];
    if TreeNode.Text = szText then
    begin
      Result := Treenode;
      break;
    end
    else
      Result := FindTreeNode(TreeNode, szText);
    if Result <> nil then
      break;
  end;
end;

procedure TTreeFuncNodeLink.UpdateLinker(Linker: TObject);
begin
  inherited;

end;

procedure TTreeFuncNodeLink.SetNodeLevel(const Value: Integer);
begin
  FNodeLevel := Value;
end;

end.
