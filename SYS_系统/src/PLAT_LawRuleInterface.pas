unit PLAT_LawRuleInterface;

interface
uses Classes, shdocvw, PLAT_AdvUnknownInterface;
type
  ILawRule = interface(IAdvUnknown)

    procedure Execute;

    function GetName: string;
    function GetTitle: string;
    function GetAuthor: string;
    function GetKeyWords: string;
    function GetAbstract: string;
    function GetCreator: string;
    function GetCreateTime: string;
    function GetModifier: string;
    function GetModifierTime: string;
    function GetGroupName: string;
    function GetInMenu: Boolean;

    function GetRelatedLawRules: TList;
    procedure RelatedWith(ALawRule: ILawRule);
    procedure UnRelatedWith(ALawRule: ILawRule);
    function ProductHTML: string;
    function ProductHTMLTiny: string;
    function IsModified: boolean;
    procedure RefreshRelations(Strs: TStringList);
    procedure Open(bs: TWebBrowser);
    procedure Save;
    procedure Config;
    function GetFileExt: string;
    procedure Delete;

  end;

implementation

end.
