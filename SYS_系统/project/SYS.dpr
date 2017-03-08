program SYS;
  //----------------------------------------------------------------------------
  // 使用FastMM替换Delphi默认的内存管理器，提高内存分配效率及对大内存块的处理能力
  // 注意：1、FastMM4Options.inc里的编译选项是针对U8的最优配置，不要随意改动
  //       2、FastMM4单元必须作为整个项目的第一个引用单元
  // Added by gh, 2013.05.28
uses
  FastMM4 in '..\src\FastMM4.pas',
  FastMM4Messages in '..\src\FastMM4Messages.pas',
  Forms,
  Pub_Global,
  Pub_Res,
  DataModuleMain,
  Pub_Function,
  Main in '..\Src\Main.pas' {FormMain},
  UIR9_IMPL in '..\Src\UIR9_IMPL.pas',
  WindowsList in '..\src\WindowsList.pas',
  BackGroundUnit in '..\src\BackGroundUnit.pas' {FormBackGround},
  PLAT_Utils in '..\src\PLAT_Utils.pas',
  PLAT_AdvInterfacedObject in '..\src\PLAT_AdvInterfacedObject.pas',
  PLAT_AdvUnknownInterface in '..\src\PLAT_AdvUnknownInterface.pas',
  PLAT_buttons in '..\src\PLAT_buttons.pas',
  PLAT_ChangeIcons in '..\src\PLAT_ChangeIcons.pas' {FormChangeIcon},
  PLAT_DocumentLink in '..\src\PLAT_DocumentLink.pas',
  PLAT_EditorLawRules in '..\src\PLAT_EditorLawRules.pas' {FormLawRuleEditor},
  PLAT_GroupLink in '..\src\PLAT_GroupLink.pas',
  PLAT_HtmlLink in '..\src\PLAT_HtmlLink.pas',
  PLAT_LawRuleClass in '..\src\PLAT_LawRuleClass.pas',
  PLAT_LawRuleDBManager in '..\src\PLAT_LawRuleDBManager.pas',
  PLAT_LawRuleFactory in '..\src\PLAT_LawRuleFactory.pas',
  PLAT_LawRuleInterface in '..\src\PLAT_LawRuleInterface.pas',
  PLAT_LawRuleManager in '..\src\PLAT_LawRuleManager.pas',
  PLAT_LinkProperty in '..\src\PLAT_LinkProperty.pas' {FormLinkProperty},
  PLAT_OracleLawRuleDBManager in '..\src\PLAT_OracleLawRuleDBManager.pas',
  PLAT_PlatFunctionLink in '..\src\PLAT_PlatFunctionLink.pas',
  PLAT_QuickLink in '..\src\PLAT_QuickLink.pas',
  PLAT_QuickLinker in '..\src\PLAT_QuickLinker.pas',
  PLAT_QuickLinkFactory in '..\src\PLAT_QuickLinkFactory.pas',
  PLAT_R9FunctionLink in '..\src\PLAT_R9FunctionLink.pas',
  PLAT_R9MenuFunctionLink in '..\src\PLAT_R9MenuFunctionLink.pas',
  PLAT_R9SubSystemIntf in '..\src\PLAT_R9SubSystemIntf.pas',
  PLAT_R9SubSystemInvoker in '..\src\PLAT_R9SubSystemInvoker.pas',
  PLAT_R9SystemFactory in '..\src\PLAT_R9SystemFactory.pas',
  PLAT_RegisterFunctionLink in '..\src\PLAT_RegisterFunctionLink.pas',
  PLAT_SelectLawRule in '..\src\PLAT_SelectLawRule.pas' {FormSelectLawRule},
  PLAT_SQLLawRuleDBManager in '..\src\PLAT_SQLLawRuleDBManager.pas',
  PLAT_TreeFuncNodeLink in '..\src\PLAT_TreeFuncNodeLink.pas',
  About in '..\src\About.pas' {FormAbout},
  ChgPassword in '..\src\ChgPassword.pas' {FormChgPassword},
  DataSyncDownload in '..\src\DataSyncDownload.pas' {frmDownloadData},
  LoginHint in '..\src\LoginHint.pas' {FormLoginHint},
  LoginSelectCZY in '..\src\LoginSelectCZY.pas' {frmSelectCZY},
  Login in '..\src\Login.pas' {FormLogin},
  SetGS in '..\src\SetGS.pas' {FormSetGS},
  MenuBox in '..\src\MenuBox.pas',
  uRptCaller in '..\src\uRptCaller.pas' {frmRptCaller},
  SYS_TLB in 'SYS_TLB.pas',
  SetKJND in '..\src\SetKJND.pas' {FormSetKJND},
  ChgUsername in '..\src\ChgUsername.pas' {FormXGMC},
  UUserStatus in '..\src\UUserStatus.pas' {FrmUserState},
  ULockForm in '..\src\ULockForm.pas' {frmLockForm};

{$R *.tlb}

{$R *.RES}
{$R uac.RES}
begin
  GProSign := 'SYS';         //产品标识
  GszVersion := 'SYS';
  GNotEncrypt := '1';
  GProSeries := 'T';
  GszGSORDW := '单位';
  {2011.05.25 确定产品编译的版本和系列名称}
  {$INCLUDE Version.inc}
  {2011.05.25 调试时候使用，给予默认功能}
  if GszRelease = '' then
  begin
    GszRelease := '政府财务';
    GszEdition := 'G';    
  end;
  //ShowMessage(GszRelease);

  GpsSeries := IFF((GszEdition='G')  or (GszEdition='E' ) , psR9i, psR9);
  Pub_Res.Res_InitGlobal; //hch 初始化Res变量
  Application.CreateForm(TDataModulePub, DataModulePub);
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormBackGround, FormBackGround);
  Application.CreateForm(TFormXGMC, FormXGMC);
  ApplicationRun();  //FormMain.AfterLoginInitData;  Application.Run;
end.
