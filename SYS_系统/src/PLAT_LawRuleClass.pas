unit PLAT_LawRuleClass;

interface
uses sysutils, Classes, shdocvw, HTTPProd, PLAT_LawRuleInterface, PLAT_Utils, PLAT_AdvInterfacedObject;
type
  TLawRule = class(TAdvInterfacedObject, ILawRule)
  private
    FTagID: Integer;
    FName: string;
    FTitle: string;
    FAuthor: string;
    FKeyWords: string;
    FAbstract: string;
    FCreator: string;
    FCreateTime: string;
    FModifier: string;
    FFileExt: string;
    FModifierTime: string;
    FGroupName: string;
    FInMenu: Boolean;
    FModified: Boolean;
    FRelations: TList;
    procedure PageProducerFullHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings;
      var ReplaceText: string);
    procedure PageProducerTinyHTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings;
      var ReplaceText: string);
    procedure FetchFile(FileName: string);
    procedure CommitFile(FileName: string);

  public

    constructor Create(AName: string;
      ATitle: string;
      AAuthor: string;
      AKeyWords: string;
      AAbstract: string;
      ACreator: string;
      ACreateTime: string;
      AModifier: string;
      AFileExt: string;
      AModifierTime: string;
      AGroupName: string;
      AInMenu: Boolean
      );
    destructor Destory;

    procedure Execute;
    function GetName: string;
    function GetTitle: string;
    function GetAuthor: string;
    function GetKeyWords: string;
    function GetAbstract: string;
    function GetGroupName: string;
    function GetInMenu: Boolean;
    function GetCreator: string;
    function GetCreateTime: string;
    function GetModifier: string;
    function GetFileExt: string;
    function GetModifierTime: string;
    function GetRelatedLawRules: TList;
    procedure RelatedWith(ALawRule: ILawRule);
    procedure UnRelatedWith(ALawRule: ILawRule);
    function ProductHTML: string;
    function ProductHTMLTiny: string;
    function IsModified: boolean;
    procedure Open(bs: TWebBrowser);
    procedure Save;
    procedure Config;
    procedure Delete;
    procedure RefreshRelations(Strs: TStringList);

  end;

implementation

{ TLawRule }
uses shellapi, forms, Windows, PLAT_LawRuleFactory,
  PLAT_EditorLawRules;

procedure TLawRule.Config;
var
  frm: TFormLawRuleEditor;
  lr: ILawRule;
begin
  frm := TFormlawRuleEditor.Create(application);
  frm.edtLRName.Enabled := false;
  frm.edtLRName.Text := self.GetName;
  frm.edtLRTitle.Text := self.GetTitle;
  frm.edtLRAuthor.text := self.GetAuthor;
  frm.edtLRKeyWords.text := self.GetKeyWords;
  frm.edtLRAbstract.text := self.GetAbstract;
  frm.ComboboxGroupItems.ItemIndex := frm.ComboboxGroupItems.Items.IndexOf(self.GetGroupName);
  frm.CheckBoxInMenu.Checked := self.GetInMenu;
  //frm.LRfilename.Text:=self.GetModifier;
  if frm.ShowModal() = IDOK then
  begin
    FTitle := frm.edtLRTitle.Text;
    FAuthor := frm.edtLRAuthor.text;
    FKeyWords := frm.edtLRKeyWords.text;
    FAbstract := frm.edtLRAbstract.text;
    FGroupName := frm.ComboBoxGroupItems.Text;
    FInMenu := frm.CheckBoxInMenu.Checked;
    if frm.LRfilename.Text <> '' then
    begin
      CommitFile(frm.LRFileName.Text);
    end;
    Save();
    self.Open(TUtils.GetLawRuleBrowser());
  end;

  frm.Free;

end;

constructor TLawRule.Create(AName, ATitle, AAuthor, AKeyWords, AAbstract,
  ACreator, ACreateTime, AModifier, AFileExt, AModifierTime: string; AGroupName: string; AInMenu: boolean);
begin
  FName := AName;
  FTitle := ATitle;
  FAuthor := AAuthor;
  FKeyWords := AKeyWords;
  FABstract := AAbstract;
  FCreator := ACreator;
  FCreateTime := ACreateTime;
  FModifier := AModifier;
  FFileExt := AFileExt;
  FModifierTime := AModifierTime;
  FGroupName := AGRoupName;
  FInMenu := AInMenu;
  FModified := False;
  FRelations := TList.Create;

end;

procedure TLawRule.Execute;
var
  FileName: string;
begin
  if FFileExt = '' then
    exit;
  FileName := Tutils.GetTempDir + self.FName + self.FFileExt;
  FetchFile(FileName);
  ShellExecute(application.handle, 'open', PChar(FileName), nil, nil, SW_MAXIMIZE);

end;

procedure TLawRule.FetchFile(FileName: string);
begin
  TLawRuleFactory.GetInstance.FetchFile(self.GetName, FileName);
end;

function TLawRule.GetAbstract: string;
begin
  Result := FAbstract;
end;

function TLawRule.GetAuthor: string;
begin
  Result := FAuthor;

end;

function TLawRule.GetCreator: string;
begin
  Result := FCreator;

end;

function TLawRule.GetFileExt: string;
begin
  Result := FFileExt;

end;

function TLawRule.GetKeyWords: string;
begin
  Result := FKeyWords;

end;

function TLawRule.GetModifierTime: string;
begin
  Result :=
    Copy(FModifierTime, 1, 4) + '-' +
    Copy(FModifierTime, 5, 2) + '-' +
    Copy(FModifierTime, 7, 2) + ' ' +
    Copy(FModifierTime, 9, 2) + ':' +
    Copy(FModifierTime, 11, 2) + ':' +
    Copy(FModifierTime, 13, 2)

end;

function TLawRule.GetModifier: string;
begin
  Result := FModifier;

end;

function TLawRule.GetName: string;
begin
  Result := FName;

end;

function TLawRule.GetRelatedLawRules: TList;
begin
  Result := FRelations;
end;

function TLawRule.GetTitle: string;
begin
  Result := FTitle;

end;

function TLawRule.IsModified: boolean;
begin
  Result := FModified;

end;

procedure TLawRule.Open(bs: TWebBrowser);
var
  Strs: TSTringList;
  FileName: string;

begin
  strs := TstringList.Create;
  strs.Clear;
  strs.Add(ProductHTML);
  FileName := Tutils.GetTempDir + 'temp.html';
  strs.SaveToFile(FileName);
  strs.free;
  bs.Navigate(FileName);
end;

function TLawRule.ProductHTML: string;
var
  str: string;
begin
  with TLawRuleFactory.GetInstance.GetPageProducerFull do
  begin
    OnHTMLTag := PageProducerFullHTMLTag;
    Result := Content;
    OnHTMLTag := nil;
  end;

end;

function TLawRule.ProductHTMLTiny: string;
begin
  with TLawRuleFactory.GetInstance.GetPageProducerItem do
  begin
    OnHTMLTag := self.PageProducerTinyHTMLTag;
    Result := Content;
    OnHTMLTag := nil;
  end;

end;

procedure TLawRule.RelatedWith(ALawRule: ILawRule);
var
  i: Integer;
  obj: TLawRule;
begin
  for i := 0 to FRelations.Count - 1 do
  begin
    obj := TLawRule(FRelations[i]);
    obj.FTagID := i + 1;

    if uppercase(obj.GetName()) = uppercase(AlawRule.GetName()) then
    begin
      exit;
    end;

  end;
  FRelations.Add(AlawRule.Myself);

end;

procedure TLawRule.Save;
begin
  TLawRuleFactory.GetInstance.UpdateLawRule(self);
end;

procedure TLawRule.UnRelatedWith(ALawRule: ILawRule);
var
  i: Integer;
  obj: ILawRule;
begin
  for i := 0 to FRelations.Count - 1 do
  begin
    obj := TLawRule(FRelations[i]);
    if uppercase(obj.GetName()) = uppercase(AlawRule.GetName()) then
    begin
      FRelations.Delete(i);
      exit;
    end;

  end;

end;

function TLawRule.GetCreateTime: string;
var
  DateTime: TDateTime;
begin
  Result :=
    Copy(FCreateTime, 1, 4) + '-' +
    Copy(FCreateTime, 5, 2) + '-' +
    Copy(FCreateTime, 7, 2) + ' ' +
    Copy(FCreateTime, 9, 2) + ':' +
    Copy(FCreateTime, 11, 2) + ':' +
    Copy(FCreateTime, 13, 2)

end;

procedure TLawRule.PageProducerTinyHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
  if uppercase(TagString) = 'ID' then
    ReplaceText := inttostr(FTagID)
  else if uppercase(TagString) = 'ITEMSUBJECT' then
    ReplaceText := self.FName
  else if uppercase(TagString) = 'ITEMTITLE' then
    ReplaceText := self.FTitle;

end;

procedure TLawRule.PageProducerFullHTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: Integer;
  obj: ILawRule;
begin
  if uppercase(TagString) = 'RELATEDITEMS' then
  begin
    ReplaceText := '';
    TLawRuleFactory.GetInstance.RefreshRelations(self);
    for i := 0 to FRelations.Count - 1 do
    begin
      obj := TLawRule(FRelations[i]);
      TLawRule(FRelations[i]).FTagID := i + 1;
      ReplaceText := ReplaceText + obj.ProductHTMLTiny;
    end;
  end
  else if uppercase(TagString) = 'SUBJECT' then
    ReplaceText := self.FName
  else if uppercase(TagString) = 'TITLE' then
    ReplaceText := self.FTitle
  else if uppercase(TagString) = 'AUTHOR' then
    ReplaceText := self.FAuthor
  else if uppercase(TagString) = 'KEYWORD' then
    ReplaceText := self.FKeyWords
  else if uppercase(TagString) = 'ABSTRACT' then
    ReplaceText := self.FAbstract
  else if uppercase(TagString) = 'CREATOR' then
    ReplaceText := self.FCreator
  else if uppercase(TagString) = 'CREATETIME' then
    ReplaceText := self.GetCreateTime
  else if uppercase(TagString) = 'MODIFIER' then
    ReplaceText := self.FModifier
  else if uppercase(TagString) = 'MODIFYTIME' then
    ReplaceText := self.GetModifierTime;

  //ShowMessage(TagString);

end;

destructor TLawRule.Destory;
begin
  FRelations.Free;
end;

procedure TLawRule.CommitFile(FileName: string);

begin
  Self.FFileExt := ExtractFileExt(FileName);
  TLawRuleFactory.GetInstance.CommitFile(self.GetName, FileName);
end;

procedure TLawRule.Delete;
begin
  TLawRuleFactory.GetInstance.DeleteLawRule(GetName);
end;

procedure TLawRule.RefreshRelations(Strs: TStringList);
var
  i: Integer;
begin
  self.FRelations.Clear;
  for i := 0 to Strs.Count - 1 do
  begin
    self.RelatedWith(TLawRuleFactory.GetInstance.GetLawRule(strs[i]));
  end;

end;

function TLawRule.GetGroupName: string;
begin
  Result := FGroupname;
end;

function TLawRule.GetInMenu: Boolean;
begin
  Result := FInMenu;
end;

end.
