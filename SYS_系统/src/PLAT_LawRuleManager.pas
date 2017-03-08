unit PLAT_LawRuleManager;

interface

uses menus, classes, PLAT_LawRuleClass;
type
  TLawRuleManager = class
  private
    procedure NewRule;
    procedure Refresh;
    procedure Open(szParam: string);
    procedure Config;
    procedure Delete;
    procedure Select;
    procedure GotoStart;
    procedure AddNewRelations;
    procedure RefreshRelations;
    procedure DeleteRelation(szParam: string);
    procedure AllLawRulesClick(Sender: TObject);
    procedure RefreshClick(Sender: TObject);
    procedure LawRulesItemClick(Sender: TObject);
    procedure Define;
  public
    procedure RefreshMenu(Mi: TMenuItem; GroupName: string);
    class function GetInstance: TLawRuleManager;
    procedure Execute(var szCommandName: string);
  end;
implementation
uses sysutils, Windows, forms, Dialogs, Controls, Pub_Message, PLAT_Utils, PLAT_EditorLawRules, PLAT_LawRuleInterface, PLAT_LawRuleFactory;
{ TLawRuleManager }
var
  Glob_LawRuleManager: TLawRuleManager;

procedure TLawRuleManager.AddNewRelations;
var
  lr: ILawRule;
  str: string;
  current: ILawRule;
begin
  str := TLawRuleFactory.GetInstance.SelectLawRule;
  if str = '' then
    exit;
  Current := TLawRuleFactory.GetInstance.GetCurrent;
  lr := TLawRuleFactory.GetInstance.GetLawRule(str);
  TLawRuleFactory.GetInstance.Relate(Current, lr);
  Current.Open(TUtils.GetLawRuleBrowser());

end;

procedure TLawRuleManager.Config;
var
  obj: ILawRule;
begin
  obj := TLawRuleFactory.GetInstance.GetCurrent;
  if obj = nil then
    exit;
  obj.Config;
end;

procedure TLawRuleManager.Delete;

var
  obj: ILawRule;

  objName: string;
begin
  obj := TLawRuleFactory.GetInstance.GetInstance.GetCurrent;
  if obj = nil then
    exit;
  ObjName := obj.GetName;
  Obj := nil;

  if SysMessage('您确定要删除该政策法规[' + ObjName + ']吗？', '_XW', [mbYes, mbNo]) = mrYes then
  begin
    TLawRuleFactory.GetInstance.GetInstance.DeleteLawRule(objName);
    GotoStart;
  end;

end;

procedure TLawRuleManager.DeleteRelation(szParam: string);
var
  Current, lr: ILawRule;
begin
  Current := TLawRuleFactory.getInstance.GetCurrent;
  if Current = nil then
    exit;
  lr := TLawRuleFactory.getInstance.GetLawRule(szParam);
  TLawRuleFactory.GetInstance.UnRelate(Current, lr);
  Current.Open(TUtils.GetLawRuleBrowser());

end;

procedure TLawRuleManager.Execute(var szCommandName: string);
var
  szParam: string;
  ipos1, iPos2: Integer;
begin
  iPos1 := Pos('(', szCommandName);
  iPos2 := Pos(')', szCommandName);
  if (iPos1 <> 0) and (iPos2 <> 0) then
  begin
    szParam := Copy(szCommandName, iPos1 + 1, iPos2 - iPos1 - 1);
    szCommandName := Copy(szCommandName, 1, iPos1 - 1);
  end
  else
    szParam := '';

  if szCommandName = 'NEWRULE' then
    NewRule
  else if szCommandName = 'REFRESH' then
    Refresh
  else if szCommandName = 'OPEN' then
    Open(szParam)
  else if szCommandName = 'CONFIG' then
    Config
  else if szCommandName = 'DELETE' then
    Delete
  else if szCommandName = 'SELECT' then
    Select
  else if szCommandName = 'CLOSE' then
    GotoStart
  else if szCommandName = uppercase('AddNewRelations') then
    AddNewRelations
  else if szCommandName = uppercase('RelationsRefresh') then
    RefreshRelations
  else if szCommandName = uppercase('DeleteRelation') then
    DeleteRelation(szParam);

end;

class function TLawRuleManager.GetInstance: TLawRuleManager;
begin

  if Assigned(Glob_LawRuleManager) then
    Result := Glob_LawRuleManager
  else
  begin
    Glob_LawRuleManager := TLawRuleManager.Create();
  end;

end;

procedure TLawRuleManager.GotoStart;
begin
  if FileExists(ExtractFilePath(application.exename) + 'DeskTop\LawRules.htm') then
    TUtils.GetLawRuleBrowser.Navigate(ExtractFilePath(application.exename) + 'DeskTop\LawRules.htm')
  else
    TUtils.GetLawRuleBrowser.Navigate('http://www.ufgov.com.cn');

end;

procedure TLawRuleManager.NewRule;
var
  frm: TFormLawRuleEditor;
  lr: ILawRule;
begin
  frm := TFormlawRuleEditor.Create(application);
  if frm.ShowModal() = IDOK then
  begin
    lr := TLawRuleFactory.GetInstance.GetLawRule(frm.edtLRName.text);
    lr.Open(TUtils.GetLawRuleBrowser());
  end;

  frm.Free;

end;

procedure TLawRuleManager.Open(szParam: string);
var
  obj: ILawRule;

begin
  if szParam = '' then
  begin
    obj := TLawRuleFactory.GetInstance.GetCurrent;
    if obj = nil then
      exit;
    obj.Execute;
  end
  else
  begin
    TUtils.ShowLawRule;
    Application.ProcessMessages;
    Obj := TLawRuleFactory.GetInstance.GetLawRule(szParam);
    if obj = nil then
      exit;
    obj.Open(TUtils.GetLawRuleBrowser());

  end;

end;

procedure TLawRuleManager.Refresh;
var
  obj: ILawRule;

begin
  obj := TLawRuleFactory.GetInstance.GetCurrent;
  if obj = nil then
    exit;
  obj.Open(TUtils.GetLawRuleBrowser());
end;

procedure TLawRuleManager.RefreshRelations;
var
  obj: ILawRule;
begin
  obj := TLawRuleFactory.GetInstance.GetCurrent;
  if obj = nil then
    exit;
  TLawRuleFactory.GetInstance.RefreshRelations(obj);
  obj.Open(TUtils.GetLawRuleBrowser());

end;

procedure TLawRuleManager.Select;
var
  str: string;
  obj: ILawRule;
begin
  with TLawRuleFactory.getInstance do
  begin
    str := SelectLawRule;
    if str <> '' then
      Open(str);
  end;

end;

procedure TLawRuleManager.RefreshMenu(Mi: TMenuItem; GroupName: string);
var
  strs: TStringList;
  i: Integer;
  AMi: TMenuItem;
begin
  Mi.AutoHotkeys := maManual;
  strs := TStringList.Create();
  TLawRuleFactory.GetInstance.GetLawRuleByGroupName(GroupName, strs);
  mi.Clear;
  mi.Caption := '政策法规';

  AMi := TMenuItem.Create(nil);
  AMi.Caption := '所有政策法规';
  AMi.OnClick := self.AllLawRulesClick;
  AMi.AutoHotkeys := maManual;
  Mi.Add(AMi);

  AMi := TMenuItem.Create(nil);
  AMi.Caption := '-';
  Mi.Add(AMi);

  for i := 0 to Strs.Count - 1 do
  begin
    AMi := TMenuItem.Create(nil);
    AMi.Caption := strs[i];
    AMi.OnClick := self.LawRulesItemClick;
    AMi.AutoHotkeys := maManual;
    Mi.Add(AMi);

  end;

  AMi := TMenuItem.Create(nil);
  AMi.Caption := '-';
  Mi.Add(AMi);

  AMi := TMenuItem.Create(nil);
  AMi.Caption := '刷新';
  AMi.AutoHotkeys := maManual;
  AMi.OnClick := self.RefreshClick;
  Mi.Add(AMi);

  strs.Free;

end;

procedure TLawRuleManager.AllLawRulesClick(Sender: TObject);
begin
  Select;
end;

procedure TLawRuleManager.LawRulesItemClick(Sender: TObject);

begin
  if Sender is TMenuItem then
  begin
    Open((Sender as TMenuItem).Caption);
  end;
end;

procedure TLawRuleManager.RefreshClick(Sender: TObject);
begin
  RefreshMenu(TUtils.GetLawRuleMenuItem(), Tutils.GetProSign());

end;

procedure TLawRuleManager.Define;
begin
  //
end;

end.
