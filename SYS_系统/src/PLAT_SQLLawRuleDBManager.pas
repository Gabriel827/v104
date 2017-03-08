unit PLAT_SQLLawRuleDBManager;

interface
uses dialogs, sysutils, Classes, DBClient, Plat_LawRuleDBManager, PLAT_AdvInterfacedObject;
type
  TSQLLawRuleDBManager = class(TAdvInterfacedObject, ILawRuleDBManager)
    FClientDataset: TClientDataset;
  public
    constructor Create();
    procedure Insert(LawRuleName: string; LawRuleTitle: string; LawRuleAuthor: string; LawRuleKeyWords: string; LawRuleAbstract: string; LawRuleFileName: string; GroupName: string; AInMenu: Boolean);
    procedure UpdateClientDataset(ClientDataset: TClientDataset);
    //procedure UpdateDB(ClientDataset:TClientDataset;LRName:String);
    procedure UpdateDB(LRName, LRTitle, LRAuthor, LRKeyWords, LRAbstract, LRGroupName: string; LRInMenu: Boolean);

    procedure Delete(KeyValue: string);
    procedure FetchFile(LRName, FileName: string);
    procedure CommitFile(LRName, FileName: string);
    procedure GetRelations(LRName: string; strs: TStringList);
    procedure AddRelations(LRA, LRB: string);
    procedure DeleteRelations(LRA, LRB: string);
    procedure GetLawRuleByGroupName(GroupName: string; strs: TStringList);
    procedure GetGroupItems(strs: TStringList);

  end;

implementation

uses DB, PLAT_Utils, DatamoduleMain, Pub_Function;
{ TSQLLawRuleDBManager }

procedure TSQLLawRuleDBManager.AddRelations(LRA, LRB: string);
begin
  FClientDataset.Close;
  POpenSql(FClientDataset, 'select * from PT_LRRELATIONS where (LRA=''' + LRA + ''' and LRB=''' + LRB + ''') or (LRA=''' + LRB + ''' and LRB=''' + LRA + ''') ');
  if FClientDataset.RecordCount > 0 then
    exit
  else
  begin
    FClientDataset.Insert;
    FClientDataset.FieldByName('LRA').AsString := LRA;
    FClientDataset.FieldByName('LRB').AsString := LRB;
    FClientDataset.Post;
    //        DataModulePub.MidasConnectionPub.appServer.SetTableName('PT_LRRELATIONS');

    FClientDataset.ApplyUpdates(0, 'PT_LRRELATIONS');
  end;

end;

procedure TSQLLawRuleDBManager.CommitFile(LRName, FileName: string);
begin
  FClientDataset.Close;
  POpenSql(FClientDataset, 'select * from PT_LAWRULES where LRName=''' + LRName + '''');
  if FClientDataset.RecordCount = 0 then
    raise Exception.Create('不存在的记录');
  FClientDataset.First;
  FClientDataset.edit;
  FClientDataset.FieldByName('LRModifier').AsString := TUtils.GetCurrentUser;
  FClientDataset.FieldByName('LRModifiedTime').AsString := FormatDateTime('YYYYMMDDhhmmss', Now());
  FClientDataset.FieldByName('LRDocType').AsString := ExtractFileExt(FileName);
  TBlobField(FClientDataset.FieldByName('LRDocument')).LoadFromFile(FileName);
  FClientDataset.Post;

  //    DataModulePub.MidasConnectionPub.appServer.SetTableName('PT_LAWRULES');

  FClientDataset.ApplyUpdates(0, 'PT_LAWRULES');

end;

constructor TSQLLawRuleDBManager.Create;
begin
  FClientDataset := TClientDataset.Create(nil);
  FClientDataset.ProviderName := Tutils.GetSearchProviderName;
  FClientdataset.RemoteServer := TUtils.GetRemoteServer;
  FClientDataset.FetchOnDemand := true;
end;

procedure TSQLLawRuleDBManager.Delete(KeyValue: string);
begin
  FClientDataset.Close;
  POpenSql(FClientDataset, 'select * from PT_LAWRULES where LRName=''' + KeyValue + '''');
  FClientDataset.delete;

  //    DataModulePub.MidasConnectionPub.appServer.SetTableName('PT_LAWRULES');

  FClientDataset.ApplyUpdates(0, 'PT_LAWRULES');

end;

procedure TSQLLawRuleDBManager.DeleteRelations(LRA, LRB: string);
begin
  FClientDataset.Close;
  POpenSql(FClientDataset, 'select * from PT_LRRELATIONS where (LRA=''' + LRA + ''' and LRB=''' + LRB + ''') or (LRA=''' + LRB + ''' and LRB=''' + LRA + ''') ');
  if FClientDataset.RecordCount = 0 then
    exit
  else
  begin
    FClientDataset.First;
    FClientDataset.DElete;

    //        DataModulePub.MidasConnectionPub.appServer.SetTableName('PT_LRRELATIONS');

    FClientDataset.ApplyUpdates(0, 'PT_LRRELATIONS');
  end;

end;

procedure TSQLLawRuleDBManager.FetchFile(LRName, FileName: string);
begin
  FClientDataset.Close;
  POpenSql(FClientDataset, 'select * from PT_LAWRULES where LRName=''' + LRName + '''');
  if FClientDataset.RecordCount = 0 then
    raise Exception.Create('不存在的记录');
  FClientDataset.First;
  TBlobField(FClientDataset.FieldByName('LRDocument')).SaveToFile(FileName);
end;

procedure TSQLLawRuleDBManager.GetGroupItems(strs: TStringList);
const
  ASQL = 'select * from PT_GroupItems ';
begin
  FClientDataset.Close;
  POpenSql(FClientDataset, ASQL);
  strs.Clear;
  if FClientDataset.RecordCount = 0 then
    exit;
  FClientDataset.First;

  while not FClientDataset.Eof do
  begin
    strs.Add(FClientDataset.FieldBYName('ItemName').AsString);
    FClientDataset.Next;
  end;
end;

procedure TSQLLawRuleDBManager.GetLawRuleByGroupName(GroupName: string;
  strs: TStringList);
const
  ASQL = 'select * from PT_lawrules,PT_GroupItems where PT_Lawrules.LRGroupName=PT_GroupItems.ItemName and Itemcode=''%s'' and LRINMENU=1';

begin
  FClientDataset.Close;
  POpenSql(FClientDataset, Format(ASQL, [Groupname]));
  strs.Clear;
  if FClientDataset.RecordCount = 0 then
    exit;
  FClientDataset.First;

  while not FClientDataset.Eof do
  begin
    strs.Add(FClientDataset.FieldBYName('LRName').AsString);
    FClientDataset.Next;
  end;
end;

procedure TSQLLawRuleDBManager.GetRelations(LRName: string; strs: TStringList);
begin
  FClientDataset.Close;
  POpenSql(FClientDataset, 'select * from PT_LRRELATIONS where LRA=''' + LRName + ''' or LRB=''' + LRName + '''');
  if FClientdataset.RecordCount = 0 then
    exit;
  FClientDataset.First;
  while not FClientDataset.Eof do
  begin
    if LRname = FClientDataset.FieldByName('LRA').AsString then
    begin
      if strs.IndexOf(FClientDataset.FieldByName('LRB').AsString) = -1 then
      begin
        strs.Add(FClientDataset.FieldByName('LRB').AsString);
      end;

    end
    else
    begin
      if strs.IndexOf(FClientDataset.FieldByName('LRA').AsString) = -1 then
      begin
        strs.Add(FClientDataset.FieldByName('LRA').AsString);
      end;

    end;
    FClientDataset.Next;
  end;

end;

procedure TSQLLawRuleDBManager.Insert(LawRuleName, LawRuleTitle,
  LawRuleAuthor, LawRuleKeyWords, LawRuleAbstract,
  LawRuleFileName: string; GroupName: string; AInMenu: Boolean);
var
 sSQL : string;  
begin
  {
      FClientDataset.Close;
      FClientDataset.DataRequest ('select * from Pt_lrrelations where 1=2');
      FClientDataset.Open;
      FClientDataset.Insert;
      FClientDataset.FieldByName('LRA').AsString:='sdfasdf';
      FClientDataset.FieldByName('LRB').AsString:='LawRuleTitle';
      FClientDAtaset.Post;
      DataModulePub.MidasConnectionPub.appServer.SetTableName('PT_LRRELATIONS');

      FclientDataset.ApplyUpdates (0);
      exit;

  }
  FClientDataset.Close;
  POpenSql(FClientDataset, 'select LRName,LRTitle,LRAuthor, LRKeyWords,LRAbstract,LRCreateBy, LRCreateTime ,LRModifier, LRModifiedTime,LRGroupName,LRINMENU from PT_LAWRULES where 1=2');
  FClientDataset.append;
  FClientDataset.FieldByName('LRName').AsString := LawRuleName;
  FClientDataset.FieldByName('LRTitle').AsString := LawRuleTitle;
  FClientDataset.FieldByName('LRAuthor').AsString := LawRuleAuthor;
  FClientDataset.FieldByName('LRKeyWords').AsString := LawRuleKeyWords;
  FClientDataset.FieldByName('LRAbstract').AsString := LawRuleAbstract;
  FClientDataset.FieldByName('LRGRoupName').AsString := GroupName;
  //FClientDataset.FieldByName('LRINMENU').AsBoolean := AInMenu;
  if AInMenu Then // Lzn
       FClientDataset.FieldByName('LRINMENU').AsInteger := 1
  else FClientDataset.FieldByName('LRINMENU').AsInteger := 0;

  {
  if  LawRuleFileName<>'' then
  begin
      (FClientDataset.FieldByName('LRDocument') as TBlobField).LoadFromFile(LawRuleFileName);
      FClientDataset.FieldByName('LRDoctype').AsString:=ExtractFileExt(LawRuleFileName);
  end;
  }
  FClientDataset.FieldByName('LRCreateBy').AsString := Tutils.GetCurrentUser();
  FClientDataset.FieldByName('LRCreateTime').AsString := FormatDateTime('YYYYMMDDhhmmss', now());
  FClientDataset.FieldByName('LRModifier').AsString := Tutils.GetCurrentUser();
  FClientDataset.FieldByName('LRModifiedTime').AsString := FormatDateTime('YYYYMMDDhhmmss', now());
  FClientDataset.Post;

  //    DataModulePub.MidasConnectionPub.appServer.SetTableName('PT_LAWRULES');
  FclientDataset.ApplyUpdates(0, 'PT_LAWRULES');

  if LawRuleFileName <> '' then
  begin
    FClientDataset.Close;
    POpenSql(FClientDataset, 'select LRNAME,LRDOCUMENT,LRDOCTYPE from PT_LAWRULES where LRName=''' + LawRuleName + '''');
    if FClientDataset.recordcount = 0 then
      raise Exception.Create('数据库无记录');
    FClientDataset.First;
    FClientDataset.Edit;
    (FClientDataset.FieldByName('LRDOCUMENT') as TBlobField).LoadFromFile(LawRuleFileName);

    FClientDataset.FieldByName('LRDOCTYPE').AsString := ExtractFileExt(LawRuleFileName);
    FClientDataset.Post;

    //        DataModulePub.MidasConnectionPub.appServer.SetTableName('PT_LAWRULES');

    FclientDataset.ApplyUpdates(0, 'PT_LAWRULES');

  end;

end;

procedure TSQLLawRuleDBManager.UpdateClientDataset(
  ClientDataset: TClientDataset);
begin
  try
    ClientDataset.Close; // 要先关闭，以免报错 Lzn 
    ClientDataset.ProviderName := TUtils.GetSearchProviderName;
    ClientDataset.RemoteServer := TUtils.GetRemoteServer;
    ClientDataset.Close;
  except;
  end;
  POpenSql(ClientDataset, 'select lrname,lrtitle,lrauthor,lrkeywords,lrabstract,lrcreateby,lrcreateTime,lrmodifier,lrmodifiedtime,lrdoctype,LRGroupName,LRInMenu from PT_LAWRULES');

end;

procedure TSQLLawRuleDBManager.UpdateDB(LRName, LRTitle, LRAuthor,
  LRKeyWords, LRAbstract, LRGroupName: string; LRInMenu: Boolean);
begin
  FClientDataset.Close;
  POpenSql(FClientDataset, 'select * from PT_LAWRULES where LRName=''' + LRName + '''');

  if FClientDataset.RecordCount = 0 then
    raise Exception.Create('不存在的记录');
  FClientDataset.First;
  FClientDataset.edit;
  FClientDataset.FieldByName('LRName').AsString := LRName;
  FClientDataset.FieldByName('LRTitle').AsString := LRTitle;
  FClientDataset.FieldByName('LRAuthor').AsString := LRAuthor;
  FClientDataset.FieldByName('LRKeyWords').AsString := LRKeyWords;
  FClientDataset.FieldByName('LRAbstract').AsString := LRAbstract;
  FClientDataset.FieldByName('LRGroupName').AsString := LRGroupName;
  FClientDataset.FieldByName('LRINMENU').AsBoolean := LRInMenu;

  FClientDataset.Post;

  FClientDataset.ApplyUpdates(0, 'PT_LAWRULES');

end;

end.
