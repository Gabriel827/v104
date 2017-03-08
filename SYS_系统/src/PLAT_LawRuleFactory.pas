unit PLAT_LawRuleFactory;

interface
uses sysutils, contnrs, Dialogs, Classes, dbclient, httpapp, PLAT_LawRuleDBManager, PLAT_LawRuleInterface, PLAT_LawRuleClass,HTTPProd;
type
  TLawRuleFactory = class

  private
    FDBManager: ILawRuleDbManager;
    FCurrent: ILawRule;
    FClientDataset: TClientDataset;
    FDBType: string;
    FList: TList;
    FPageProducerFull: TPageProducer;
    FPageProducerItem: TPageProducer;

  public
    destructor Destroy; override;
    class function GetInstance(ADBType: string): TLawRuleFactory; overload;
    class function GetInstance(): TLawRuleFactory; overload;
    function GetPageProducerFull: TPageProducer;
    function GetPageProducerItem: TPageProducer;
    procedure DeleteLawRule(LawRuleName: string);
    function GetLawRule(LawRuleName: string): ILawRule; overload;
    function FindLawRule(LawRuleName: string): Boolean;
    function GetLawRule(LawRuleName, LawRuleTitle, LawRuleAuthor,
      LawRuleKeyWords, LawRuleAbstract, LawRuleFileName: string; GroupName: string; InMenu: Boolean): ILawRule; overload;
    procedure UpdateLawRule(ALawRule: ILawRule); overload;
    procedure FetchFile(LRName: string; FileName: string);
    procedure CommitFile(LRName: string; FileName: string);
    procedure Relate(LRa, LRB: ILawRule);
    procedure UnRelate(LRa, Lrb: ILawRule);
    function GetCurrent: ILawRule;
    function SelectLawRule: string;
    procedure RefreshRelations(lr: ILawRule);
    procedure DeleteCurrent();
    procedure GetLawRuleByGroupName(GroupName: string; strs: TStringList);
    procedure GetGroupItems(strs: TStringList);

  end;

implementation
uses Windows, Forms, DB, PLAT_utils, PLAT_SelectLawRule, PLAT_SQLLawRuleDBManager, PLAT_ORACLELawRuleDBManager;
var
  Glob_LawRuleFactory: TLawRuleFactory;

  { TLawRuleFactory }

procedure TLawRuleFactory.DeleteLawRule(LawRuleName: string);
var
  i, j: Integer;
  obj: TLawRule;
  LRA, LRB: string;
  li: TList;
begin

  FCurrent := nil;
  for i := 0 to FList.Count - 1 do
  begin
    obj := TLawRule(FList[i]);
    if uppercase(obj.getName) = uppercase(LawRuleName) then
    begin
      RefreshRelations(obj);
      li := obj.GetRelatedLawRules;
      for j := 0 to li.Count - 1 do
      begin
        FDBManager.DeleteRelations(obj.GetName, TLawRule(li[j]).GetName);
      end;
      Flist.Delete(i);
      FDBManager.Delete(LawRuleName);
      break;
    end;
  end;

end;

class function TLawRuleFactory.GetInstance(
  ADBType: string): TLawRuleFactory;
var
  ExePath: string;
begin
  if Assigned(Glob_lawRuleFactory) then
  begin
    if uppercase(Glob_LawRuleFactory.FDBType) <> uppercase(ADBType) then
      raise Exception.CreateFmt('数据库类型已经设置为%s,不能设置为%s', [Glob_LawRuleFactory.FDBType, ADBType]);
    Result := Glob_LawRuleFactory;
  end
  else
  begin

    Glob_LawRuleFactory := TLawRuleFactory.Create();
    with Glob_LawRuleFactory do
    begin
      FDBType := ADBType;
      if FDBType = 'MSSQL' then
        FDBManager := TSQLLawRuleDBManager.Create()
      else
        FDBManager := TOracleLawRuleDBManager.Create();
      FClientDataset := TClientDataset.Create(nil);
      FList := TObjectList.Create();
      FPageProducerFull := TPageProducer.Create(nil);
      FPageProducerItem := TPageProducer.Create(nil);
      ExePath := ExtractFilePath(Application.exename);

      if FileExists(ExePath + 'DeskTop\Full.html') then
        FPageProducerFull.HTMLDoc.LoadFromFile(ExePath + 'DeskTop\Full.html')
      else
        FPageProducerFull.HTMLDoc.Text := 'File Not Found' + ExePath + 'DeskTop\Full.html';

      if FileExists(ExePath + 'DeskTop\ITEM.html') then
        FPageProducerItem.HTMLDoc.LoadFromFile(ExePath + 'DeskTop\Item.html')
      else
        FPageProducerItem.HTMLDoc.Text := 'File Not Found' + ExePath + 'DeskTop\ITEM.html';
      FDBManager.UpdateClientDataset(FClientDataset);
    end;
    Result := Glob_LawRuleFactory;

  end;

end;

destructor TLawRuleFactory.Destroy;
var
  i: Integer;
begin
  for i := FLIst.count - 1 downto 0 do
  begin
    TLawRule(FList[i]).Free;
    Flist.Delete(i);
  end;
  FClientDataset.Free;
  FList.Free;
  inherited;
end;

class function TLawRuleFactory.GetInstance: TLawRuleFactory;
begin
  Result := GetInstance(TUtils.GetDatabaseName);

end;

procedure TLawRuleFactory.RefreshRelations(lr: ILawRule);
var
  StrList: TStringList;
  Current: ILawRule;
begin
  Current := GetCurrent;
  strList := TStringList.Create();
  FDBManager.getRelations(lr.GetName, strList);

  lr.RefreshRelations(strList);
  strList.Free;
  FCurrent := Current;

end;

function TLawRuleFactory.GetLawRule(LawRuleName: string; LawRuleTitle: string; LawRuleAuthor: string; LawRuleKeyWords: string; LawRuleAbstract: string; LawRuleFileName: string; GroupName: string; InMenu: boolean): ILawRule;
var
  i: Integer;
  obj: TLawRule;
  b: Boolean;
begin
  if FClientDataset.FieldByName('LRINMENU').DataType = ftBoolean then
    b := FClientDataset.FieldByName('LRINMENU').AsBoolean
  else
  begin
    if FClientDataset.FieldByName('LRINMENU').AsInteger <> 0 then
      B := true
    else
      B := false;
  end;

  for i := 0 to FList.Count - 1 do
  begin
    //obj:=TLawRule(FList.Items[FList.Count -1]);
    obj := TLawRule(FList.Items[i]);

    if uppercase(obj.GetName) = uppercase(LawRuleName) then
    begin
      Result := obj;
      FCurrent := Result;
      exit;
    end;

  end;

  if not FClientDataset.Locate('LRName', LawRuleName, []) then
  begin
    FDBManager.Insert(LawRuleName, LawRuleTitle, LawRuleAuthor, LawRuleKeyWords, LawRuleAbstract, LawRuleFileName, GroupName, InMenu);
    FDBManager.UpdateClientDataset(FClientDataset);
    FClientDataset.Locate('LRName', LawRuleName, []);
  end;
  Obj := TLawRule.Create(
    FClientDataset.FieldByName('LRName').AsString,
    FClientDataset.FieldByName('LRTITLE').AsString,
    FClientDataset.FieldByName('LRAUTHOR').AsString,
    FClientDataset.FieldByName('LRKEYWORDS').AsString,
    FClientDataset.FieldByName('LRABSTRACT').AsString,
    FClientDataset.FieldByName('LRCREATEBY').AsString,
    FClientDataset.FieldByName('LRCREATETIME').AsString,
    FClientDataset.FieldByName('LRMODIFIER').AsString,
    FClientDataset.FieldByName('LRDOCTYPE').AsString,
    FClientDataset.FieldByName('LRMODIFIEDTIME').AsString,
    FClientDataset.FieldByName('LRGROUPNAME').AsString,
    b

    );
  FList.Add(Obj);

  Result := Obj;
  FCurrent := REsult;
end;

procedure TLawRuleFactory.UpdateLawRule(ALawRule: ILawRule);
begin
  FDBManager.UpdateDB(ALawRule.GetName, ALawRule.GetTitle, ALawRule.GetAuthor, ALawRule.GetKeyWords, ALawRule.GetAbstract, ALawRule.GetGroupName, ALawRule.GetInMenu);
end;

function TLawRuleFactory.GetPageProducerFull: TPageProducer;
begin
  Result := self.FPageProducerFull;
end;

function TLawRuleFactory.GetPageProducerItem: TPageProducer;
begin
  Result := self.FPageProducerItem;

end;

function TLawRuleFactory.GetLawRule(LawRuleName: string): ILawRule;
begin
  Result := GetLawRule(LawRuleName, 'Title', 'Author', 'KeyWords', 'Abstract', '', '', False);
end;

function TLawRuleFactory.GetCurrent: ILawRule;
begin
  Result := FCurrent;
end;

procedure TLawRuleFactory.FetchFile(LRName, FileName: string);
begin
  FDBManager.FetchFile(LRName, FileName);

end;

procedure TLawRuleFactory.CommitFile(LRName, FileName: string);
begin
  FDBManager.CommitFile(LRName, FileName);

end;

function TLawRuleFactory.SelectLawRule: string;
var
  frm: TFormSelectLawRule;
begin
  try
    frm := TFormSelectlawRule.Create(application);
    FDBManager.UpdateClientDataset(FClientDataset);
    frm.ClientDataSet1.data := self.FClientDataset.data;
    if frm.ShowModal = IDOK then
    begin
      if frm.bIsSelect then
        Result := frm.ClientDataset1.FieldByname('LRName').AsString
      else
        Result := '';
    end;
    frm.Free;
  except
  end;
end;

procedure TLawRuleFactory.Relate(LRa, LRB: ILawRule);
begin
  if LRA.GetName = LRB.GetName then
    exit;
  FDBManager.AddRelations(LRA.getName, LRB.GetName);
  //self.RefreshRelations (LRB);
  //self.RefreshRelations (LRA);
  self.FCurrent := LRA;
end;

procedure TLawRuleFactory.UnRelate(LRa, Lrb: ILawRule);
begin
  if lra = nil then
    exit;
  if lrb = nil then
    exit;
  if LRA.GetName = LRB.GetName then
    exit;
  FDBManager.DeleteRelations(LRA.getName, LRB.GetName);
  self.FCurrent := LRA;

end;

function TLawRuleFactory.FindLawRule(LawRuleName: string): Boolean;
begin
  FDBManager.UpdateClientDataset(FClientDataset);
  if FClientDataset.Locate('LRName', LawRuleName, []) then
    Result := true
  else
    Result := false;

end;

procedure TLawRuleFactory.DeleteCurrent;
begin
  {
  if FCurrent<>nil then
  begin

  end;
  }
end;

procedure TLawRuleFactory.GetLawRuleByGroupName(GroupName: string;
  strs: TStringList);
begin
  FDBManager.GetLawRuleByGroupName(GroupName, strs);
end;

procedure TLawRuleFactory.GetGroupItems(strs: TStringList);
begin
  FDBManager.GetGroupItems(strs);
end;

end.
