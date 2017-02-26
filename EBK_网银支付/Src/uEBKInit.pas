unit uEBKInit;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   Pub_Function, Pub_Global, uPub, Pub_Power, DBClient, ComObj, DB,  CMidasCon;

type
  TEBK = class(TPublicMod)
  Private
  public

    //�����Ǽ̳еķ���
    procedure InitProject; override;
    function ActiveInitPub:Boolean;override;    //�����ʱ��Ҫ���¸�ֵһ��,�ú����ǳ�ʼ������ģ�鶼Ҫ�õ�һЩ��������
    function CheckRun:Boolean;override;         //�ܷ����и�ģ�飬ģ������֮ǰ��Ҫ��ʼ���ı���Ҳ����
    function InitAccount:Boolean;override;      //ģ���ʼ����˽�б���ִ��һ��
    function CloseMode:Boolean;override;        //�ر������е�ģ��
    procedure GatherModeVar;override;
  end;
  //���ⲿ�νӵ�һ���ӿ�
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
  PrintObj.AddParams('����Ա����', GCzy.CzyCode);
  PrintObj.AddParams('����Ա', GCzy.name);
  PrintObj.AddParams('��λ����', GszGSDM);
  PrintObj.AddParams('��λ����', GszHSDWMC);
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
        Application.MessageBox('�޴�ӡģ�壬�����ã�', 'ϵͳ��ʾ', MB_ICONWarning + MB_OK);
        Result := False;
        exit;
      end;
    finally
      Free;
    end;
  end;

  
  try
    //�������ݼ��Ͻ�����ʾ��ӡ��
    //���ݼ��Ͽ����Ƕ�����ݼ��ϣ���ά���鼯��    
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
    //�������ݼ��Ͻ�����ʾ��ӡ��
    //���ݼ��Ͽ����Ƕ�����ݼ��ϣ���ά���鼯��
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
    //�������ݼ��Ͻ�����ʾ��ӡ��
    //���ݼ��Ͽ����Ƕ�����ݼ��ϣ���ά���鼯��
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
    if Global_EBK = nil then            //�״δ�ģ�鴰��
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
    if GNID = '���ײ�������'   then LoadParams;
    if GNID = '����֧����¼��' then LoadWYZF(GszGSDM, GszKJND, GszKJQJ, GCzy.ID, '', '', nil, True);
    if GNID = '����֧���ǼǱ�' then LoadWYZFNotePad;
    if GNID = 'excel��������' then LoadImortFrmExcel;
    if GNID = '���ϱ�������' then LoadImpOER;
    if GNID = '�ʽ���������' then LoadImpBM;
    if GNID = 'н����������' then LoadImpPA;
    if GNID = 'ʡ������' then LoadSFZL;
    if GNID = '���л���' then LoadJGXX;
    if GNID = '���е���' then LoadYHDQ;
    if GNID = '�����к�' then LoadYHHH;
    if GNID = '���нӿ�' then LoadYHJK;
    if GNID = '���нӿ�����' then LoadYHJKPZ;
    if GNID = '�˻�����ѯ' then LoadFormQryZHYE;
    if GNID = '�˻���ϸ��ѯ' then LoadFormZHQry_MX;

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
  GProSign := 'EBK';       //��Ʒ��ʶ
  GsProductSign := 'EBK';  //Ȩ�ޱ�ʶ
  GNotEncrypt := '0';      //�Ƿ������
  GProSeries:='G';         //ϵ�б�ʶ
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
