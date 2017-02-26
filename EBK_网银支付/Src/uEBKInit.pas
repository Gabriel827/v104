unit uEBKInit;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   Pub_Function, Pub_Global, uPub, Pub_Power, DBClient, ComObj, DB,  CMidasCon;

type
  TEBK = class(TPublicMod)
  Private
  public

    //以下是继承的方法
    procedure InitProject; override;
    function ActiveInitPub:Boolean;override;    //激活窗体时需要重新赋值一次,该函数是初始化各个模块都要用的一些公共变量
    function CheckRun:Boolean;override;         //能否运行该模块，模块运行之前需要初始化的变量也放这
    function InitAccount:Boolean;override;      //模块初始化，私有变量执行一次
    function CloseMode:Boolean;override;        //关闭已运行的模块
    procedure GatherModeVar;override;
  end;
  //对外部衔接的一个接口
  TDataIntf = class(TInterfacedObject, IInvoke)
    function ReisterFunction(FunID:WideString; IEF: IExternalFunction):Boolean;safecall;
    function POpenSQL(var Dst: TClientDataSet; SQL: WideString): Boolean; Safecall;
    function PExecSQL(SQL:WideString):Boolean; safecall;
    function GetDataBySQL(SQL:WideString):OleVariant; safecall;
    function ReisterForm(FunID: WideString; Form: TForm): Boolean; Safecall;
    //function GetPower(const GNID: WideString): Boolean; Safecall;
    function GetPower(GNID: string): Boolean; Safecall;
    function UpdateVersion(ATableName: string): Boolean; Safecall;
    function Print(ASign, ASQL: string): Boolean; Overload; Safecall;
    function PrintA(ASign, ASQL: string): Boolean; Overload; Safecall;
    function PrintSet(ASign, ASQL: string): Boolean; Overload; Safecall;
    function Print(ASign: string; V: OleVariant): Boolean; Overload; Safecall;
    function PrintSet(ASign: string; V: OleVariant): Boolean; Overload; Safecall;
    function PrintDataA(const ASign: WideString; vData: OleVariant; const IsShowDlg: Boolean): Boolean; Safecall;
    class function PrintGridEh(const ASign: WideString; vData, vDBColumns, vPageHead,
      vPageFooter, vColumnFooter: OleVariant;
      ColumnWidth: WideString; vShowDlg: Boolean; vParams: string = ''): Boolean; Safecall;
    function SetRichEdit(const ASign: WideString; const Cnt: WideString): WideString;
    function RefreshSkin(AForm: TForm): Boolean; Safecall;
    class procedure EnterSession_CAA;
    class procedure LeaveSession_CAA;
    class procedure SetComponentsColor(AForm: TForm; bshape: Boolean = True;
          IsXpMenu: Boolean = true;XPMenuOnly:boolean=false);
    function GetSJQX(szKZLX, szDM: string):string;
    function GetConnection: TCMidasConnection; Safecall;
  end;
function ShowForm(GNID:String; bActiveForm:Boolean):TPublicMod; stdcall;

var
  Global_EBK:TEBK;

implementation

uses WYZFNotePad, Pub_WYZF, DataModuleMain, uEBK_Params, WYZF, uEBK_IMPBM,
  uEBK_ImportExcel, SFZL, JGXX, YHDQ, YHHH, YHJK, YHJKPZ, uQryzhye,
  zhqry_mx, uEBK_IMPOER, uEBK_IMPOERPA;

function TDataIntf.PExecSQL(SQL:WideString):Boolean;
begin
  try
    Pub_Function.PExecSQL(SQL);
    Result := True;
  except
    on e :Exception do
    begin
      Result := False;
      raise ;
    end;
  end;
end;

function TDataIntf.ReisterFunction(FunID:WideString; IEF: IExternalFunction):Boolean;safecall;
begin
  //
end;

function TDataIntf.GetDataBySQL(SQL:WideString):OleVariant; safecall;
var
  cds:TClientDataSet;
begin
  try
    cds := TClientDataSet.Create(nil);
    try
      Pub_Function.POpenSQL(cds, SQL);
      Result := cds.Data;
    finally
      cds.Free;
    end;
  except
    on e :Exception do
    begin
      raise;
    end;
  end;
end;
function TDataIntf.POpenSQL(var Dst: TClientDataSet;  SQL:WideString):Boolean;
begin
  try
    try
      Pub_Function.POpenSQL(TClientDataSet(Dst), SQL);
    finally

    end;
  except
    on e :Exception do
    begin
      raise;
    end;
  end;
end;

function GetServerHost: string;
var
  szTemp: string;
begin
  Result := '';
  szTemp := GszServerComputer;
  szTemp := Copy(szTemp, 8, Length(szTemp) - 7);
  if Pos(':', szTemp) > 0 then
  begin
    Result := Copy(szTemp, 1, Pos(':', szTemp) - 1);
  end
  else if Pos('/', szTemp) > 0 then
  begin
    Result := Copy(szTemp, 1, Pos('/', szTemp) - 1);
  end;
end;

function GetServerPort: string;
var
  szTemp: string;
begin
  Result := '';
  szTemp := GszServerComputer;
  szTemp := Copy(szTemp, 8, Length(szTemp) - 7);
  if Pos(':', szTemp) > 0 then
  begin
    szTemp := Copy(szTemp, Pos(':', szTemp) + 1, Length(szTemp));
    if Pos('/', szTemp) > 0 then
    begin
      Result := Copy(szTemp, 1, Pos('/', szTemp) - 1);
    end
    else
      Result := szTemp;
  end;
  if Result = '' then
    Result := '80';
end;

function TDataIntf.GetPower(GNID: string): Boolean; 
begin
  Result := TPower.GetPower(GNID);
end;

function TDataIntf.PrintSet(ASign, ASQL: string): Boolean;
begin
  Result := TPrintObj.PrintSet(ASign, ASQL, GEnv);
end;

procedure InitPrint(var PrintObj: OleVariant; vParams: string = '');
var
  i: integer;
begin
  PrintObj := CreateOleObject('PrintOCX.UFPrintCTL');
  if DataModulePub.MidasConnectionPub.ConnectType = ctHTTP then
    PrintObj.InitConn('CONTYPE=HTTP&HOST=' + GetServerHost + '&PORT=' + GetServerPort)
  else if DataModulePub.MidasConnectionPub.ConnectType = ctDCOM then
  begin
    if GpsSeries = psR9 then
      PrintObj.InitConn('CONTYPE=DCOM&SERVERNAME=' + GsServerName + '&DatabaseName=' + GszDBNAME
        + '&Username=' + GsUserName + '&DBName=' + GszDBNAME + '&Password=' + GsPassword + '&DBType=' + IFF(GDBType =
          MSSQL, 'MSSQL', 'ORACLE'))
    else
      PrintObj.InitConn('CONTYPE=DCOM&SERVERNAME=' + GsServerName + '&DatabaseName=' + GsDatabaseName
        + '&Username=' + GsUserName + '&DBName=' + GszDBNAME + '&Password=' + GsPassword + '&DBType=' + IFF(GDBType =
          MSSQL, 'MSSQL', 'ORACLE'));
  end;
  PrintObj.AddParams('DBTYPE', IFF(GDbType = MSSQL, 'MSSQL', 'ORACLE'));
  PrintObj.AddParams('MOD', 'SCS');
  PrintObj.AddParams('GSDM', GszGSDM);
  PrintObj.AddParams('ZTH', GszZTH);
  PrintObj.AddParams('操作员编码', GCzy.CzyCode);
  PrintObj.AddParams('操作员', GCzy.name);
  PrintObj.AddParams('单位代码', GszGSDM);
  PrintObj.AddParams('单位名称', GszHSDWMC);
  with TStringList.Create do
  begin
    Text := vParams;
    for i := 0 to Count - 1 do
    begin
      PrintObj.AddParams(Names[i], ValueFromIndex[i]);
    end;
    Free;
  end;
end;

function TDataIntf.PrintDataA(const ASign: WideString; vData: OleVariant; const IsShowDlg: Boolean): Boolean; Safecall;
var
  PrintObj: OleVariant;
  cds: TClientDataSet;
begin
  try
    InitPrint(PrintObj);
    Cds := TClientDataSet.Create(nil);
    Cds.Data := vData;
    Result := PrintObj.PrintDataA(ASign, Cds.Data, IFF(IsShowDlg, '1', '0'));
  finally
    Cds.Free;
  end;
end;

function TDataIntf.PrintSet(ASign: string; V: OleVariant): Boolean;
var
  PrintObj: OleVariant;
  cds: TClientDataSet;
begin
  try
    InitPrint(PrintObj);
    Cds := TClientDataSet.Create(nil);
    Cds.Data := v;
    Result := PrintObj.PrintSetData(ASign, Cds.Data);
  finally
    Cds.Free;
  end;
end;

function TDataIntf.PrintA(ASign, ASQL: string): Boolean; Safecall;
var
  PrintObj: OleVariant;
  cds: TClientDataSet;
begin
  try
    InitPrint(PrintObj);
    Result := PrintObj.PrintA(ASign, ASQL);
  finally

  end;
end;

function TDataIntf.Print(ASign, ASQL: string): Boolean;
var
  PrintObj: OleVariant;
  cds: TClientDataSet;
begin
  try
    InitPrint(PrintObj);
    Result := PrintObj.Print(ASign, ASQL);
  finally

  end;
end;

function TDataIntf.Print(ASign: string; V: OleVariant): Boolean;
var
  PrintObj: OleVariant;
  Cds: TClientDataSet;
  SQLtxt :string;
begin
  SQLtxt := 'Select 1 from PUB_RMINFO where RPT_MOD=''SCS'' and RPT_USE=' + QuotedStr(ASign) +
       ' and GSDM=' + QuotedStr(TApp.ENV('GSDM')) + ' and rpt_cnt is not null';

  with TDB.GetCds(SQLtxt) do
  begin
    try
      if recordcount = 0 then
      begin                                 
        Application.MessageBox('无打印模板，请设置！', '系统提示', MB_ICONWarning + MB_OK);
        Result := False;
        exit;
      end;
    finally
      Free;
    end;
  end;

  
  try
    //传递数据集合进行显示打印，
    //数据集合可以是多个数据集合，多维数组集合    
    InitPrint(PrintObj);
    Cds := TClientDataSet.Create(nil);
    Cds.Data := V;
    Result := PrintObj.PrintData(ASign, Cds.Data);
  finally
    Cds.free;
  end;
end;

function TDataIntf.RefreshSkin(AForm: TForm): Boolean; Safecall;
begin
  SetXPMenu(AForm);
  Result := True;
end;

function TDataIntf.UpdateVersion(ATableName: string): Boolean; Safecall;
begin
  PUpdatePubBaseVersion(ATableName, TApp.ENV('GSDM'));
  Result := True;
end;

function TDataIntf.SetRichEdit(const ASign: WideString; const Cnt: WideString): WideString;
var
  PrintObj: OleVariant;
  Cds: TClientDataSet;
begin
  Cds := TClientDataSet.Create(nil);
  try
    //传递数据集合进行显示打印，
    //数据集合可以是多个数据集合，多维数组集合
    InitPrint(PrintObj);
    Result := PrintObj.SetRichEdit(ASign, Cnt);
  finally
    Cds.free;
  end;

end;

class function TDataIntf.PrintGridEh(const ASign: WideString; vData, vDBColumns, vPageHead,
      vPageFooter, vColumnFooter: OleVariant;
      ColumnWidth: WideString; vShowDlg: Boolean; vParams: string = ''): Boolean; Safecall;
var
  PrintObj: OleVariant;
begin
  try
    //传递数据集合进行显示打印，
    //数据集合可以是多个数据集合，多维数组集合
    InitPrint(PrintObj, vParams);
    Result := PrintObj.PrintDBGrid(ASign, vData, vDBColumns, vPageHead,
      vPageFooter, vColumnFooter, ColumnWidth, vShowDlg);
  finally

  end;
end;

class procedure TDataIntf.SetComponentsColor(AForm: TForm; bshape: Boolean = True;
          IsXpMenu: Boolean = true;XPMenuOnly:boolean=false);
begin
  Pub_Function.SetComponentsColor(AForm, bshape, IsXpMenu, XPMenuOnly);
end;


class procedure TDataIntf.EnterSession_CAA;
begin
  EnterSession;
end;

class procedure TDataIntf.LeaveSession_CAA;
begin
  LeaveSession;
end;

function TDataIntf.GetSJQX(szKZLX, szDM: string):string;
begin
  result := PSJQX(szKZLX, szDM);
end;
{ TEBK }
function ShowForm(GNID:String; bActiveForm:Boolean):TPublicMod; stdcall;
begin
  try
    if Global_EBK = nil then            //首次打开模块窗体
    begin
       Global_EBK := TEBK.Create;
       GEBKParams := DataModulePub.GetCdsBySQL('Select * from EBK_ZTCS where GSDM='+QuotedStr(GszGSDM)
        +' and KJND='+QuotedStr(GszKJND));
       GEnv := TStringList.Create;
       GEnv.Values['GSDM'] := GszGSDM;
       GEnv.Values['ZTH'] := GszZTH;
       GEnv.Values['KJND'] := GszKJND;
    end;
    Result:= Global_EBK;

    if not ShowFormInit(Result, bActiveForm) then Exit;
    if GNID = '账套参数设置'   then LoadParams;
    if GNID = '网银支付单录入' then LoadWYZF(GszGSDM, GszKJND, GszKJQJ, GCzy.ID, '', '', nil, True);
    if GNID = '网银支付登记薄' then LoadWYZFNotePad;
    if GNID = 'excel数据引入' then LoadImortFrmExcel;
    if GNID = '网上报销引入' then LoadImpOER;
    if GNID = '资金数据引入' then LoadImpBM;
    if GNID = '薪资数据引入' then LoadImpPA;
    if GNID = '省份资料' then LoadSFZL;
    if GNID = '银行机构' then LoadJGXX;
    if GNID = '银行地区' then LoadYHDQ;
    if GNID = '银行行号' then LoadYHHH;
    if GNID = '银行接口' then LoadYHJK;
    if GNID = '银行接口配置' then LoadYHJKPZ;
    if GNID = '账户余额查询' then LoadFormQryZHYE;
    if GNID = '账户明细查询' then LoadFormZHQry_MX;

  finally

  end;
end;


function TEBK.ActiveInitPub: Boolean;
begin
  Result := inherited ActiveInitPub;
end;

function TEBK.CheckRun: Boolean;
var
  CurrKjnd, szInfo: string;
begin
  Result := False;
  if not inherited CheckRun then
    Exit;

  Result := True;
end;

function TEBK.CloseMode: Boolean;
begin
  inherited CloseMode;
  Result := True;
end;

procedure TEBK.GatherModeVar;
begin
  inherited;

end;

function TEBK.InitAccount: Boolean;
begin
  Result := False;

  //
  Result := True;
end;

procedure TEBK.InitProject;
begin
  inherited;
  GProSign := 'EBK';       //产品标识
  GsProductSign := 'EBK';  //权限标识
  GNotEncrypt := '0';      //是否软加密
  GProSeries:='G';         //系列标识
  Application.HelpFile := GExePath + 'help\' + 'EBK.HLP';
end;

exports
  ShowForm;

function TDataIntf.ReisterForm(FunID: WideString; Form: TForm): Boolean;
begin

end;

function TDataIntf.GetConnection: TCMidasConnection;
begin
	
end;

initialization
  GIInvoke := TDataIntf.Create;

finalization
  if GIInvoke <> nil then
    Pointer(GIInvoke) := nil;

end.
