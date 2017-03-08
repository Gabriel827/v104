unit PLAT_LawRuleDBManager;

interface
uses Classes, DBClient, PLAT_AdvUnknownInterface;
type
  ILawRuleDBManager = interface(IAdvUnKnown)
    procedure Insert(LawRuleName: string; LawRuleTitle: string; LawRuleAuthor: string; LawRuleKeyWords: string; LawRuleAbstract: string; LawRuleFileName: string; GroupName: string; AInMenu: Boolean);
    procedure UpdateClientDataset(ClientDataset: TClientDataset);
    procedure UpdateDB(LRName, LRTitle, LRAuthor, LRKeyWords, LRAbstract, LRGRoupName: string; LRInMenu: Boolean);
    procedure GetRelations(LRName: string; strs: TStringList);
    procedure Delete(KeyValue: string);
    procedure FetchFile(LDName, FileName: string);
    procedure CommitFile(LDName, FileName: string);
    procedure AddRelations(LRA, LRB: string);
    procedure DeleteRelations(LRA, LRB: string);
    procedure GetLawRuleByGroupName(GroupName: string; strs: TStringList);
    procedure GetGroupItems(strs: TStringList);

  end;

implementation

end.
