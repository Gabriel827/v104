unit uRptCaller;

interface               

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Pub_Global, Pub_Function, DataModuleMain, Menus, SpeedBar,
  ExtCtrls, OleCtnrs, ComCtrls, AxCtrls, DBClient, OleCtrls, RptCell_TLB,
  Pub_Power,  Placemnt;
const
  cRptGUID = '{3A3C6391-6E9B-46B0-87F5-C5D18F805B9D}';
type
  PReportTree = ^TReportTree;
  TReportTree = record
    Cata_Code: string;
    Cata_Name: string;
    Cata_Parent: string;
    Level: integer;
    IsCata: Boolean;
    Rpt_Rt_Id: integer; //目录时为0
    Rpt_Rt_Code: string;
    Rpt_Rt_Name: string;
    Child: TList;
  end;

  TfrmRptCaller = class(TForm)
    SpeedBarDLZ: TSpeedBar;
    SpeedbarSectionFile: TSpeedbarSection;
    SpeedbarSectionEdit: TSpeedbarSection;
    SpeedbarSectionHelp: TSpeedbarSection;
    SpeedbarSectionExit: TSpeedbarSection;
    SpeedItemPreview: TSpeedItem;
    SpeedItemPrint: TSpeedItem;
    SpeedItemReFresh: TSpeedItem;
    SpeedItemHelp: TSpeedItem;
    SpeedItemExit: TSpeedItem;
    MainMenuDLZ: TMainMenu;
    MFile: TMenuItem;
    MPreview: TMenuItem;
    MPrint: TMenuItem;
    MBDataOut: TMenuItem;
    MExit: TMenuItem;
    MRun: TMenuItem;
    MReFresh: TMenuItem;
    pg: TPageControl;
    tbsUnits: TTabSheet;
    tbsPeriod: TTabSheet;
    tvUnit: TTreeView;
    tvPeriod: TTreeView;
    N1: TMenuItem;
    btnExport: TSpeedItem;
    miExport: TMenuItem;
    sg: TSaveDialog;
    N2: TMenuItem;
    miHide: TMenuItem;
    N3: TMenuItem;
    miRowNo: TMenuItem;
    miColNo: TMenuItem;
    miRowShow: TMenuItem;
    fs: TFormStorage;
    miReadOnly: TMenuItem;
    Splitter1: TSplitter;
    miLinkSearch: TMenuItem;
    btnLinkSearch: TSpeedItem;
    miCalcImm: TMenuItem;
    miKJQJ: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MPreviewClick(Sender: TObject);
    procedure MPrintClick(Sender: TObject);
    procedure MExitClick(Sender: TObject);
    procedure MReFreshClick(Sender: TObject);
    procedure SpeedItemPreviewClick(Sender: TObject);
    procedure SpeedItemPrintClick(Sender: TObject);
    procedure SpeedItemReFreshClick(Sender: TObject);
    procedure SpeedItemExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvPeriodDblClick(Sender: TObject);
    procedure tvUnitDblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure miExportClick(Sender: TObject);
    procedure miHideClick(Sender: TObject);
    procedure miRowNoClick(Sender: TObject);
    procedure miColNoClick(Sender: TObject);
    procedure miRowShowClick(Sender: TObject);
    procedure miReadOnlyClick(Sender: TObject);
    procedure miLinkSearchClick(Sender: TObject);
    procedure miCalcImmClick(Sender: TObject);
    procedure miKJQJClick(Sender: TObject);
  private
    FRptCode: string;
    FKJND: string;
    FGSDM: string;
    FZTH: string;
    FYWRQ: string;
    FRpt_Cell: TTRpt_CellX;
    FIsShowUnit: Boolean;
    FIsShowPeriod: Boolean;
    FRpt_Rt_Code: string;
    FPeriod: TClientDataSet;
    FParams: String;
    FLinkParams:String;
    FQueryParams: String;
    procedure SetRptCode(const Value: string);
    procedure InitRpt;
    procedure SetGSDM(const Value: string);
    procedure SetKJND(const Value: string);
    procedure SetYWRQ(const Value: string);
    procedure SetZTH(const Value: string);
    function GetRptName: string;
    procedure SetIsShowPeriod(const Value: Boolean);
    procedure SetIsShowUnit(const Value: Boolean);
    procedure initRptShow;
    procedure SetParams(const Value: String);
    procedure SetQueryParams(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property RptCode: string read FRptCode write SetRptCode;
    property GSDM: string read FGSDM write SetGSDM;
    property ZTH: string read FZTH write SetZTH;
    property KJND: string read FKJND write SetKJND;
    property YWRQ: string read FYWRQ write SetYWRQ;
    property Params:String read FParams write SetParams;
    property QueryParams:String read FQueryParams write SetQueryParams;
    property IsShowUnit: Boolean read FIsShowUnit write SetIsShowUnit;
    property IsShowPeriod: Boolean read FIsShowPeriod write SetIsShowPeriod;
    function Calc:Boolean;
    class function GetRepTreeByUnitCode(tv: TTreeView; UnitCode,
      KZFX: string): Boolean;
  end;

  {hch 调用报表的数据库接口}
  //IDataIntface = interface
//    ['{DCA3E718-F31E-4780-B6DB-DDD345D764C5}']
//    function  OpenSQL(const SQL: WideString): OleVariant; safecall;
  //end; }

  TRptData = class(TInterfacedObject, IDataIntface)
  private
    { Private declarations }
  public
  protected
    { Protected declarations }
    function OpenSQL(const SQL: WideString): OleVariant; safecall;
    procedure ApplyUpdate(V: OleVariant; const Tbl: WideString); safecall;
  end;
function OpenRpt(AGSDM, AZTH, AKJND, AYWRQ: string; ARptID: string; QueryParams:String=''): Boolean;

function convertDate(ywrq: string):string;
function GetBYUseTimeQX(TblName: string=''): string;
function GetBBUseTimeQX(TblName: string=''):string;

var
  IRpt: IDataIntface;
implementation

uses ComObj;

{$R *.dfm}

function OpenRpt(AGSDM, AZTH, AKJND, AYWRQ: string;
  ARptID: string; QueryParams:String): Boolean;
var
  frmRptCaller: TFrmRptCaller;
  iCount: integer;
  sRptID: string;
begin
  //added by zhougf 2011.11.25
  if Pos('&', ARptID) > 0 then
  begin
    with TStringList.Create do
    begin
      Text := StringReplace(ARptID, '&', #13#10, [rfReplaceAll]);
      sRptID := Values['RptID'];
      Free;
    end;
  end
  else
  begin
    sRptID := ARptID;
  end;

  frmRptCaller := nil;
  for iCount := 0 to Application.ComponentCount - 1 do
  begin
    if Application.Components[iCount] is TfrmRptCaller then
    begin
      if TfrmRptCaller(Application.Components[iCount]).RptCode = sRptID then
      begin
        frmRptCaller := TfrmRptCaller(Application.Components[iCount]);
        break;
      end;
    end;
  end;

  if frmRptCaller = nil then
  begin
    frmRptCaller := TfrmRptCaller.Create(Application);
    frmRptCaller.FormStyle := fsMDIChild;
    frmRptCaller.GSDM := AGSDM;
    frmRptCaller.ZTH := AZTH;
    frmRptCaller.KJND := AKJND;
    frmRptCaller.YWRQ := AYWRQ;
    frmRptCaller.QueryParams := QueryParams;
    frmRptCaller.InitRpt;
    frmRptCaller.IsShowPeriod := frmRptCaller.miKJQJ.Checked;
    if Pos('&', ARptID) > 0 then
    begin
      with TStringList.Create do
      begin
        Text := StringReplace(ARptID, '&', #13#10, [rfReplaceAll]);
        frmRptCaller.IsShowUnit := Values['IsShowUnit'] = '1';
        frmRptCaller.IsShowPeriod := Values['IsShowPeriod'] = '1';
        frmRptCaller.RptCode := Values['RptID'];
        Free;
      end;
    end
    else
    begin
      frmRptCaller.IsShowUnit := False;
//      frmRptCaller.IsShowPeriod := False;      // 放开IsShowPeriod，显示期间。 wangpl  ZWR900115300
      frmRptCaller.RptCode := ARptID;
    end;
    //维护单ZWR900030666
    frmRptCaller.N1.Visible := frmRptCaller.IsShowUnit or frmRptCaller.IsShowPeriod;
    frmRptCaller.miExport.Visible := frmRptCaller.N1.Visible;
    frmRptCaller.initRptShow;
    if frmRptCaller.miCalcImm.Checked then
      frmRptCaller.Calc;
  end;
  frmRptCaller.Show;
end;
{ TRptData }

procedure TRptData.ApplyUpdate(V: OleVariant; const Tbl: WideString);
begin
  try
    DataModulePub.ClientDataSetPub.Close;
    DataModulePub.ClientDataSetPub.Data := V;
    DataModulePub.ClientDataSetPub.ApplyUpdates(-1, Tbl);
    //Result := S_OK;
  except
    //Result := S_False;
  end;
end;

function TRptData.OpenSQL(const SQL: WideString): OleVariant;
begin
  //打开SQL语句使用
  try
    POpenSQL(DataModulePub.ClientDataSetPub, SQL);
    Result := DataModulePub.ClientDataSetPub.Data;
  except

  end;
end;

class function TfrmRptCaller.GetRepTreeByUnitCode(tv: TTreeView; UnitCode, KZFX: string): Boolean;
var
  Cds: TClientDataSet;
  R: PReportTree;
  Treelst: TList;
  iCount: integer;
  szKZFX: string;
  YWRQ, SQL: string;
  AQRNode: TTreeNode;

  function FindRpt: TTreeNode;
  var
    i: integer;
  begin
    Result := nil;
    for i := 0 to tv.Items.Count - 1 do
    begin
      if (tv.Items[i].Level = 0) and (Pos('电子报表', tv.Items[i].Text) >= 1) then
      begin
        Result := tv.Items[i];
        Break;
      end;
    end
  end;
  //添加目录报表树的目录节点或者报表节点
  procedure AddChild();
  var
    iCount: integer;
  begin
    for iCount := 0 to Treelst.Count - 1 do
    begin
      if R^.IsCata and (R^.Cata_Parent = '') then
        Break;
      if (R^.IsCata and (R^.Cata_Parent = PReportTree(Treelst[iCount])^.Cata_Code))
        or (not R^.IsCata and (R^.Cata_Code = PReportTree(Treelst[iCount])^.Cata_Code)) then
      begin
        PReportTree(Treelst[iCount])^.Child.Add(R);
        break;
      end;
    end;
  end;

  procedure AddChildNode(ANode: TTreeNode; P: PReportTree);
  var
    i: integer;
    ParentNode: TTreeNode;
  begin
    ParentNode := ANode;
    for i := 0 to P.Child.Count - 1 do
    begin
      {hch 如果是childNode是CataLog，不再增加多级}
      if not PReportTree(P.Child[i])^.IsCata then
      begin
        ANode := tv.Items.AddChild(ParentNode,
          PReportTree(P.Child[i])^.Rpt_Rt_Name);
        ANode.Data := P.Child[i];
      end;
      if (PReportTree(P.Child[i])^.Child.Count > 0) then
        AddChildNode(ParentNode, PReportTree(P.Child[i]));
    end;
  end;

  procedure CreateTree;
  var
    i: integer;
    ANode: TTreeNode;
  begin
    //构造树
    //添加叶节点
    for i := Treelst.Count - 1 downto 0 do
    begin
      if PReportTree(Treelst[i])^.IsCata then
      begin
        if PReportTree(Treelst[i])^.Child.Count = 0 then
          TreeLst.Delete(i);
      end;
    end;
    for i := 0 to Treelst.Count - 1 do
    begin
      ANode := nil;
      if PReportTree(Treelst[i])^.IsCata and
        (PReportTree(Treelst[i])^.Cata_Parent = '') then
      begin
        ANode := Tv.Items.AddChild(AQRNode,
          PReportTree(Treelst[i])^.Cata_Name);
        ANode.Data := Treelst[i];
        if PReportTree(Treelst[i])^.Child.Count > 0 then
          AddChildNode(ANode, PReportTree(Treelst[i]));
      end;
    end;
  end;
  procedure RemoveAQRNode;
  var
    iCount: integer;
  begin
    for iCount := AQRNode.Count - 1 downto 0 do
    begin
      if not AQRNode.Item[iCount].HasChildren and (AQRNode.Item[iCount].Level = 1) then
      begin
        AQRNode.Item[iCount].Delete;
      end;
    end;
  end;
begin
  SQL := 'select Rpt_Rt_Code, Rpt_Cata_Code, Rpt_Rt_Id, Rpt_Rt_TabName, Rpt_SysFlag from Rpt_Report '
    + ' where GSDM=''%s'' and kjnd=''%s'' and ZTH=''%s'' and Exists(Select 1 from Rpt_Period_DTL D where  '
    + ' Rpt_Report.Rpt_Period_Code = D.Rpt_Period_Code and Rpt_Report.Rpt_Period_DetailNo = D.Rpt_Period_DetailNo '
    + ' and Rpt_Period_StartDate<=''%s'' and Rpt_Period_EndDate>=''%s'') and ' + PSJQX('BY', 'Rpt_Rt_Code')
    + ' and '+ GetBYUseTimeQX()  //20150828 weibc 10.3 增加表样使用权限
    + ' Order by Rpt_Rt_Code ';

  AQRNode := FindRpt;
  if AQRNode = nil then
    Exit;
  Treelst := nil;
  //目录报表树
  if KZFX = '1' then
    szKZFX := ' in '
  else if KZFX = '2' then
    szKZFX := ' not in '
  else
    exit;

  Cds := DataModulePub.GetCdsBySQL('Select * from  Rpt_Catalog order by Rpt_Cata_Name, Rpt_Cata_Code');
  with Cds do
  begin
    if not Assigned(Treelst) then
      Treelst := TList.Create;
    while not eof do
    begin
      if FieldByName('Rpt_Cata_SysFlag').AsString = '1' then
      begin
        Next;
        continue;
      end;
      if not Assigned(Treelst) then
        Treelst := TList.Create;
      New(R);
      R^.Child := TList.Create;
      R^.Cata_Code := FieldByName('Rpt_Cata_Code').AsString;
      R^.Cata_Name := FieldByName('Rpt_Cata_Name').AsString;
      R^.Cata_Parent := FieldByName('Rpt_Cata_Parent_Code').AsString;
      R^.IsCata := True;
      Treelst.Add(R);
      Next;
    end;
    //添加到别的子节点中
    for iCount := 0 to Treelst.Count - 1 do
    begin
      R := Treelst[iCount];
      AddChild;
    end;
    YWRQ := formatDateTime('yyyy-mm-dd', TString.StrToDate(GszYWRQ));
    Cds := DataModulePub.GetCdsBySQL(Format(SQL, [GszGSDM, GszKJND,
      GszZTH, YWRQ, YWRQ]));
    while not Eof do
    begin
      if not Assigned(Treelst) then
        Treelst := TList.Create;
      New(R);
      R^.Child := TList.Create;
      R^.Cata_Code := FieldByName('Rpt_Cata_Code').AsString;
      R^.IsCata := False;
      R^.Rpt_Rt_Id := FieldByName('Rpt_Rt_Id').AsInteger;
      R^.Rpt_Rt_Code := FieldByName('Rpt_Rt_Code').AsString;
      R^.Rpt_Rt_Name := FieldByName('Rpt_Rt_TabName').AsString;
      AddChild();
      Treelst.Add(R);
      Next;
    end;
  end;
  CreateTree;
  RemoveAQRNode;
end;

procedure TfrmRptCaller.FormCreate(Sender: TObject);
begin
  
  FRpt_Cell := TTRpt_CellX.Create(Self);
  FRpt_Cell.Align := alClient;
  FRpt_Cell.Parent := Self;
  tbsPeriod.TabVisible := False;
  tbsUnits.TabVisible := False;
  //显示期间。 wangpl  ZWR900115300
  //SetIsShowPeriod(TRUE);
end;

procedure TfrmRptCaller.InitRpt;
var
  vParams: string;
begin
  {创建数据对象}
  if IRpt = nil then
    IRpt := TRptData.Create;

  // FRptCell := CreateComObject(StringToGUID(cRptGUID));
  with TStringList.Create do
  begin
    if Pos(#8, FGSDM) > 0 then
      Values['GSDM'] := GszGSDM
    else
      Values['GSDM'] := FGSDM;
    Values['ZTH'] := FZTH;
    Values['KJND'] := FKJND;
    Values['YWRQ'] := FYWRQ;
    Values['QueryParams'] := FQueryParams;
    vParams := Text;
    Free;
  end;
  // TActiveXControl(TObject(FRptCell)).
  FRpt_Cell.InitCtl(IRpt, vParams);
  //Rpt_Cell.Parent := frmRptCaller;
  //Rpt_Cell.Align := alClient;
end;

procedure TfrmRptCaller.SetGSDM(const Value: string);
begin
  FGSDM := Value;
  //#8,#9作为分割符号
end;

procedure TfrmRptCaller.SetKJND(const Value: string);
begin
  FKJND := Value;
end;

procedure TfrmRptCaller.SetRptCode(const Value: string);
var
  Parent: TTreeNode;
  FKJND: string;
begin
  FRptCode := Value;
  FRpt_Cell.OpenRpt(StrToInt(Value));
  if Value <> '' then
  begin
    Caption := GetRptName;
    FLinkParams := DataModulePub.GetFldValue('Pub_ExterialFun', 'LinkParams', 'EFContent like ''%RptID='+Value+'%''', '');
    if FLinkParams <> '' then
    begin
      btnLinkSearch.Visible := True;
      miLinkSearch.Visible := True;
    end
    else
    begin
      btnLinkSearch.Visible := False;
      miLinkSearch.Visible := False;
    end;
  end;
  {取得报表的期间类型，然后根据期间类型初始化期间树}
  if not Assigned(FPeriod) and FIsShowPeriod then
  begin
    FPeriod := DataModulePub.GetCdsBySQL(' Select D.* from Rpt_Period_DTL D, Rpt_report R '
      + ' where D.Rpt_Period_Code = R.Rpt_Period_Code and R.Rpt_Rt_Id=' + Value +
      ' order by D.KJND, D.Rpt_Period_DetailNo');
    tvPeriod.Items.Clear;
    while not FPeriod.Eof do
    begin
      if FKJND <> FPeriod.FieldByName('KJND').AsString then
      begin
        FKJND := FPeriod.FieldByName('KJND').AsString;
        Parent := tvPeriod.Items.Add(nil, FKJND + '年');
      end;
      tvPeriod.Items.AddChildObject(Parent,
        FPeriod.FieldByName('Rpt_Period_Name').AsString,
        FPeriod.GetBookmark);
      FPeriod.Next;
    end;
  end;
  SetComponentsColor(Self);
end;

procedure TfrmRptCaller.SetYWRQ(const Value: string);
begin
  FYWRQ := Value;
end;

procedure TfrmRptCaller.SetZTH(const Value: string);
begin
  FZTH := Value;
end;

procedure TfrmRptCaller.MPreviewClick(Sender: TObject);
begin
  FRpt_Cell.PrintSet;
  FRpt_Cell.PrintPreview;
end;

procedure TfrmRptCaller.MPrintClick(Sender: TObject);
begin
  FRpt_Cell.PrintSet;
  FRpt_Cell.Print;
end;

procedure TfrmRptCaller.MExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRptCaller.MReFreshClick(Sender: TObject);
begin
  Calc;
end;

procedure TfrmRptCaller.SpeedItemPreviewClick(Sender: TObject);
begin
  FRpt_Cell.PrintPreview;
end;

procedure TfrmRptCaller.SpeedItemPrintClick(Sender: TObject);
begin
  FRpt_Cell.Print;
end;

procedure TfrmRptCaller.SpeedItemReFreshClick(Sender: TObject);
begin
  Calc;
end;

procedure TfrmRptCaller.SpeedItemExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRptCaller.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := cafree;
end;

function TfrmRptCaller.GetRptName: string;
begin
  Result := DataModulePub.GetFldValue('Rpt_Report', 'Rpt_Rt_TabName', 'Rpt_Rt_Id=' + FRptCode, '');
  FRpt_Rt_Code := DataModulePub.GetFldValue('Rpt_Report', 'Rpt_Rt_Code', 'Rpt_Rt_Id=' + FRptCode, '');
end;

procedure TfrmRptCaller.SetIsShowPeriod(const Value: Boolean);
begin
  FIsShowPeriod := Value;
  if Value then
  begin
    pg.Visible := True;
    tbsPeriod.TabVisible := True;
    pg.ActivePageIndex := 1;
  end;
end;

procedure TfrmRptCaller.SetIsShowUnit(const Value: Boolean);
var
  M: TMemoryStream;
begin
  FIsShowUnit := Value;
  if Value or (Pos(#8, FGSDM) > 0) then
  begin
    pg.Visible := True;
    tbsUnits.TabVisible := True;
    pg.ActivePageIndex := 0;
    {初始化单位的数据}
    if Pos(#8, FGSDM) > 0 then
    begin
      with TStringList.Create do
      begin
        Text := StringReplace(FGSDM, #8, #13#10, [rfReplaceAll]);
        M := TMemoryStream.Create;
        try
          SaveToStream(M);
          M.Position := 0;
          tvUnit.LoadFromStream(M);
        finally
          M.Free;
        end;
        Free;
      end;
    end;
  end;
end;

procedure TfrmRptCaller.tvPeriodDblClick(Sender: TObject);
var
  FRptID: string;
begin
  {打开报表，查找对应的ID}
  //FRpt_Rt_Code
  if tvPeriod.Selected.Data = nil then
    Exit;
  FPeriod.GotoBookmark(tvPeriod.Selected.Data);
  
  {增加FRptID查询时候的条件，增加GSDM做为约束。wangpl 2013.07.23}
  FRptID := DataModulePub.GetFldValue('Rpt_Report', 'Rpt_Rt_Id', 'Rpt_Rt_Code='
    + QuotedStr(FRpt_Rt_Code) + ' and Rpt_Period_DetailNo=' + FPeriod.FieldByName('Rpt_Period_DetailNo').AsString
    + ' and KJND=' + QuotedStr(FPeriod.FieldByName('KJND').AsString) + ' and GSDM=' + QuotedStr(GszGSDM)
    + ' and ZTH=' + QuotedStr(GszZTH)
    + ' and '+GetBBUseTimeQX, '');  // Modified by Cheyf 2014-12-22 ZWR900221307 增加ZTH条件   //20150828 weibc 报表使用权限

  if FRptID = '' then
  begin
    FRptID := DataModulePub.GetFldValue('Rpt_Report',
      'Rpt_Rt_Id',
      'Rpt_Rt_Code=' + QuotedStr(FRpt_Rt_Code) + ' and KJND=''9999''', '');
  end;
  FYWRQ := FormatDateTime('yyyymmdd', FPeriod.FieldByName('Rpt_Period_StartDate').AsDateTime);
  FKJND := FPeriod.FieldByName('KJND').AsString;
  if FRptID <> '' then
  begin
    InitRpt;
    RptCode := FRptID;
    if miCalcImm.Checked then
      Calc;
    InitRptShow;
  end;
end;

procedure TfrmRptCaller.tvUnitDblClick(Sender: TObject);
begin
  if tvUnit.Selected = nil then
    Exit;
  if tvUnit.Selected.HasChildren then
    Exit;
  if Pos(' ', tvUnit.Selected.Text) > 0 then
    FGSDM := TString.LeftStrBySp(tvUnit.Selected.Text)
  else
    FGSDM := tvUnit.Selected.Text;
  InitRpt;
  if miCalcImm.Checked then
    Calc;
  InitRptShow;
  if miHide.Checked then
    FRpt_Cell.HideCol;
end;

procedure TfrmRptCaller.N1Click(Sender: TObject);
var
  iCount: integer;
begin
  //维护单ZWR900030666
  if tbsUnits.TabVisible then
    for iCount := 0 to tvUnit.Items.Count - 1 do
    begin
      if not tvUnit.Items[iCount].HasChildren then
      begin
        tvUnit.Items[iCount].Selected := True;
        tvUnitDblClick(nil);
        SpeedItemPrintClick(nil);
      end;
    end;

  if tbsPeriod.TabVisible then
    for iCount := 0 to tvPeriod.Items.Count - 1 do
    begin
      if not tvPeriod.Items[iCount].HasChildren then
      begin
        tvPeriod.Items[iCount].Selected := True;
        tvPeriodDblClick(nil);
        SpeedItemPrintClick(nil);
      end;
    end
end;

procedure TfrmRptCaller.btnExportClick(Sender: TObject);
var
  AFileName: string;
  Ext: string;
begin
  //维护单ZWR900030666 只保留第一张Sheet zhougf 2012.3.22
  FRpt_Cell.Cell.DeleteSheet(1, FRpt_Cell.Cell.GetTotalSheets - 1);

  if (Sender = nil) and (tvUnit.Selected <> nil) then
    sg.FileName := Caption + '(' + tvUnit.Selected.Text + ')'
  else
    sg.FileName := Caption;

  if sg.Execute and (Sender <> nil) then
  begin
    case sg.FilterIndex of
      1:
        begin
          Ext := 'xls';
          FRpt_Cell.Cell.ExportExcelFile(sg.FileName + '.' + Ext);
        end;
      2:
        begin
          Ext := 'txt';
          FRpt_Cell.Cell.ExportTextFile(#8, sg.FileName + '.' + Ext, 0);
        end;
      3:
        begin
          Ext := 'htm';
          FRpt_Cell.Cell.ExportHtmlFile(sg.FileName + '.' + Ext)
        end;
    end
  end
  else
  begin
    case sg.FilterIndex of
      1:
        begin
          Ext := 'xls';
          FRpt_Cell.Cell.ExportExcelFile(sg.FileName + '.' + Ext);
        end;
      2:
        begin
          Ext := 'txt';
          FRpt_Cell.Cell.ExportTextFile(#8, sg.FileName + '.' + Ext, 0);
        end;
      3:
        begin
          Ext := 'htm';
          FRpt_Cell.Cell.ExportHtmlFile(sg.FileName + '.' + Ext)
        end;
    end;
  end;
end;

procedure TfrmRptCaller.miExportClick(Sender: TObject);
var
  iCount: integer;
  AFileName, Ext, sParent:String;
begin
  sg.FileName := Caption;
  if not sg.Execute then Exit;
  //维护单ZWR900030666
  if tbsUnits.TabVisible then
  begin
    sParent := '';
    for iCount := 0 to tvUnit.Items.Count - 1 do
    begin
      if not tvUnit.Items[iCount].HasChildren then
      begin
        tvUnit.Items[iCount].Selected := True;
        AFileName := sg.FileName + '('+ sParent + tvUnit.Items[iCount].Text+')';
        tvUnitDblClick(nil);
        FRpt_Cell.Cell.DeleteSheet(1, FRpt_Cell.Cell.GetTotalSheets - 1);
        case sg.FilterIndex of
          1:
            begin
              Ext := 'xls';
              AFileName := AFileName + '.' + Ext;
              FRpt_Cell.Cell.ExportExcelFile(AFileName);
            end;
          2:
            begin
              Ext := 'txt';
              AFileName := AFileName + '.' + Ext;
              FRpt_Cell.Cell.ExportTextFile(#8, AFileName, 0);
            end;
          3:
            begin
              Ext := 'htm';
              AFileName := AFileName + '.' + Ext;
              FRpt_Cell.Cell.ExportHtmlFile(AFileName)
            end;
        end;
      end
      else
        sParent := tvUnit.Items[iCount].Text;
    end;
   end;

   if tbsPeriod.TabVisible then
   begin
    sParent := '';
    for iCount := 0 to tvPeriod.Items.Count - 1 do
    begin
      if not tvPeriod.Items[iCount].HasChildren then
      begin
        tvPeriod.Items[iCount].Selected := True;
        AFileName := sg.FileName + '(' + sParent +tvPeriod.Items[iCount].Text+')';
        tvPeriodDblClick(nil);
        FRpt_Cell.Cell.DeleteSheet(1, FRpt_Cell.Cell.GetTotalSheets - 1);
        case sg.FilterIndex of
          1:
            begin
              Ext := 'xls';
              AFileName := AFileName + '.' + Ext;
              FRpt_Cell.Cell.ExportExcelFile(AFileName);
            end;
          2:
            begin
              Ext := 'txt';
              AFileName := AFileName + '.' + Ext;
              FRpt_Cell.Cell.ExportTextFile(#8, AFileName, 0);
            end;
          3:
            begin
              Ext := 'htm';
              AFileName := AFileName + '.' + Ext;
              FRpt_Cell.Cell.ExportHtmlFile(AFileName)
            end;
        end;
      end
      else
        sParent := tvPeriod.Items[iCount].Text;
    end;
  end;
end;

procedure TfrmRptCaller.miHideClick(Sender: TObject);
begin
  miHide.Checked := not miHide.Checked;
  if miHide.Checked then
    FRpt_Cell.HideCol;
end;

procedure TfrmRptCaller.miRowNoClick(Sender: TObject);
begin
  {}
  miRowNo.Checked := not miRowNo.Checked;
  if miRowNo.Checked then
    FRpt_Cell.Cell.SetRowUnhidden(0, 0)
  else
    FRpt_Cell.Cell.SetRowHidden(0, 0);
end;

procedure TfrmRptCaller.miColNoClick(Sender: TObject);
begin
  miColNo.Checked := not miColNo.Checked;
  if miColNo.Checked then
    FRpt_Cell.Cell.SetColUnhidden(0, 0)
  else
    FRpt_Cell.Cell.SetColHidden(0, 0);
end;

procedure TfrmRptCaller.miRowShowClick(Sender: TObject);
begin
  miRowShow.Checked := not miRowShow.Checked;
  if miRowShow.Checked then
    FRpt_Cell.Cell.SetSelectMode(0, 2)
  else
    FRpt_Cell.Cell.SetSelectMode(0, 1);
end;

procedure TfrmRptCaller.miReadOnlyClick(Sender: TObject);
begin
  miReadOnly.Checked := not miReadOnly.Checked;
  if miReadOnly.Checked then
    FRpt_Cell.Cell.WorkbookReadonly := True
  else
    FRpt_Cell.Cell.WorkbookReadonly := False;
end;

procedure TfrmRptCaller.initRptShow;
begin
  FRpt_Cell.OnDblClick := miLinkSearchClick;   
  if miRowNo.Checked then
    FRpt_Cell.Cell.SetRowUnhidden(0, 0)
  else
    FRpt_Cell.Cell.SetRowHidden(0, 0);

  if miRowShow.Checked then
    FRpt_Cell.Cell.SetSelectMode(0, 2)
  else
    FRpt_Cell.Cell.SetSelectMode(0, 1);

  if miColNo.Checked then
    FRpt_Cell.Cell.SetColUnhidden(0, 0)
  else
    FRpt_Cell.Cell.SetColHidden(0, 0);

  if miReadOnly.Checked then
    FRpt_Cell.Cell.WorkbookReadonly := True
  else
    FRpt_Cell.Cell.WorkbookReadonly := False;
end;

procedure TfrmRptCaller.miLinkSearchClick(Sender: TObject);
var
  Cds:TClientDataSet;
  vLinkAction, vParams, vGUID, vGNID, vFile:String;
  procedure ReplaceFld;
  var
    iCount:integer;
  begin
    for iCount:=0 to Cds.Fields.Count-1 do
    begin
      if Cds.Locate('GUID', vGUID, []) then
        vParams := StringReplace(vParams,'['+cds.Fields[iCount].FieldName+']',
          Cds.Fields[iCount].AsString,[rfReplaceAll, rfIgnoreCase]);
    end;
    // add by wangpl 2013.06.25
//    vParams := StringReplace(vParams,'[GSDM]', GszHSDWDM,[rfReplaceAll, rfIgnoreCase]);
//    vParams := StringReplace(vParams,'[ZTH]', GszZth,[rfReplaceAll, rfIgnoreCase]);
//    vParams := StringReplace(vParams,'[KJND]', GszKJND,[rfReplaceAll, rfIgnoreCase]);
  end;
  procedure ExtractParams;
  begin
    with TStringList.Create do
    begin
      Text := StringReplace(FLinkParams,';', #13#10, [rfReplaceAll]);
      vLinkAction := Values['ExeType'];
      vParams := Values['Params'];
      vGNID := Values['GNID'];
      vFile := Values['Path'];
      Free;
    end;
  end;
begin
  //报表联查，可以打开凭证，查找明细账等等功能
  Cds := TClientDataSet.Create(nil);
  Cds.Data := FRpt_Cell.Data;
  Cds.Active := True;
  vGUID := FRpt_Cell.Cell.GetCellNote(0, FRpt_Cell.Cell.GetCurrentRow, 0);
  if vGUID = '' then Exit;
  ExtractParams;
  ReplaceFld;
  Cds.Free;
  if vLinkAction = 'AQR' then
    GIPub.Execute('RPT', 'QueryParams='+vParams)
  else if vLinkAction = 'BPL' then
    GIPub.Execute(ExtractFileName(vFile), vParams)
  else if vLinkAction = 'DLL' then
    TPlugDev.Execute(vGNID, vParams);   
end;

procedure TfrmRptCaller.SetParams(const Value: String);
begin
  FParams := Value;
end;

procedure TfrmRptCaller.SetQueryParams(const Value: String);
begin
  FQueryParams := Value;
end;

function TfrmRptCaller.Calc: Boolean;
var
  R:Boolean;
begin
  //hch 增加计算的逻辑, 在只读前进行计算会导致复制粘贴失效。
  if Assigned(FRpt_Cell) then
  begin
    R := FRpt_Cell.Cell.WorkBookReadOnly;
    FRpt_Cell.Cell.WorkBookReadOnly := False;
    FRpt_Cell.Calc;
    FRpt_Cell.Cell.WorkBookReadOnly := R;
  end;
end;

procedure TfrmRptCaller.miCalcImmClick(Sender: TObject);
begin
  miCalcImm.Checked := not miCalcImm.Checked;
end;

procedure TfrmRptCaller.miKJQJClick(Sender: TObject);
begin
  miKJQJ.Checked := not miKJQJ.Checked;
  pg.Visible := miKJQJ.Checked;
  SetIsShowPeriod(pg.Visible);
end;
function convertDate(ywrq: string):string;
begin
  if Length(ywrq)=8 then
  begin
    Result:= Copy(ywrq, 1, 4)+'-'+Copy(ywrq, 5, 2)+'-'+Copy(ywrq, 7, 2);
  end
  else
    Result:= '-'
end;

//根据操作员权限, 确定是否显示表样
function GetBYUseTimeQX(TblName: string=''): string;
begin
//  if not TApp.GQX('AQR_BY_AllPeriod') then
  if not TPower.GetPower('25022') then
    Result:= ' (('+TblName+'Rpt_Rt_QSZZDateFlag=''0'') or '+
      '(('+TblName+'Rpt_Rt_QSZZDateFlag=''1'') and ('+ QuotedStr(ConvertDate(GszYWRQ)) +
      ' between '+TblName+'Rpt_Rt_QSDate and '+TblName+'Rpt_Rt_ZZDate))) '
  else
    Result:=' (1=1) ';
end;

//报表显示依然受期间控制
function GetBBUseTimeQX(TblName: string=''):string;   //TblName类似于  A.
begin
  Result:= ' '+TblName+'Rpt_Rt_Code in ('+
    'Select Rpt_Rt_Code from Rpt_Report where GSDM='+QuotedStr(CSysDWDM)
    +' and KJND='+QuotedStr(CSysKJND)+' and '+PSJQX('BY', 'Rpt_Rt_Code')
    +' and '
    + ' (('+TblName+'Rpt_Rt_QSZZDateFlag=''0'') or '
    + '(('+TblName+'Rpt_Rt_QSZZDateFlag=''1'') and ('+ QuotedStr(ConvertDate(GszYWRQ))
    + ' between '+TblName+'Rpt_Rt_QSDate and '+TblName+'Rpt_Rt_ZZDate))) '
    +') ';
end;

end.