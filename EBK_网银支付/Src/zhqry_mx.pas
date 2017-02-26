unit zhqry_mx;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, SpeedBar, ExtCtrls, Tgrids2, THDBGrids, Db, DBClient, ComCtrls,
  StdCtrls, Buttons, Mask, ToolEdit, CurrEdit, RXCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, THComCtrls, FHPrint,
  FormPrint, HFExpandPrint, RzEdit, THFilters;

type
  TFormZHQry_MX = class(TForm)
    SpeedBarBM: TSpeedBar;
    SpeedbarSectionFile: TSpeedbarSection;
    SpeedbarSectionEdit: TSpeedbarSection;
    SpeedbarSectionRun: TSpeedbarSection;
    SpeedbarSectionExit: TSpeedbarSection;
    SpeedItemPreview: TSpeedItem;
    SpeedItemPrint: TSpeedItem;
    SpeedItemRefresh: TSpeedItem;
    SpeedItemExit: TSpeedItem;
    pnlTop: TPanel;
    THDBGridData: TTHDBGrid;
    cdsYHZH: TClientDataSet;
    dsYHZH: TDataSource;
    Label1: TLabel;
    DateTimePickerB: TDateTimePicker;
    DateTimePickerE: TDateTimePicker;
    PanelTitle: TPanel;
    lblTitle: TRxLabel;
    IdHTTP: TIdHTTP;
    SpeedItemExport: TSpeedItem;
    HFExpandPrint1: THFExpandPrint;
    FormPrint1: TFormPrint;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Button1: TButton;
    Label2: TLabel;
    ED_FFDWMC: TEdit;
    ED_SFDWMC: TEdit;
    THFilterZH: TTHFilter;
    grp1: TGroupBox;
    rbFromLocal: TRadioButton;
    rbFromBank: TRadioButton;
    cdsTemp: TClientDataSet;
    lblRecordcount: TLabel;
    CB_JDFX: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    ED_JEFrom: TCurrencyEdit;
    ED_JETo: TCurrencyEdit;
    Label3: TLabel;
    lbljfhjje: TLabel;
    lbldfhjje: TLabel;
    CEJFHJJE: TCurrencyEdit;
    CEDJHJJE: TCurrencyEdit;
    EDRecordCount: TEdit;
    SpeedItem1: TSpeedItem;
    Label19: TLabel;
    cbbYH: TComboBox;
    btnNETSearch: TSpeedItem;
    procedure FormCreate(Sender: TObject);
    procedure SpeedItemRefreshClick(Sender: TObject);
    procedure SpeedItemExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedItemExportClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DateTimePickerBChange(Sender: TObject);
    procedure SpeedItem1Click(Sender: TObject);
    procedure cbbYHChange(Sender: TObject);
    procedure THFilterZHFilter(Sender: TObject; AFilter: String);
    procedure btnNETSearchClick(Sender: TObject);
  private
    { Private declarations }
    sKHYH,sYHHH,sYHZH,sZHMC:string;

    //初始化表头
    procedure InitGrid;

    procedure RefreshCdsYHZH;
    procedure getCurrentHeji;
  public
    { Public declarations }
  end;

var
  FormZHQry_MX: TFormZHQry_MX;

  procedure LoadFormZHQry_MX(AKHYH,AYHHH,AYHZH,AZHMC:string);overload;
  procedure LoadFormZHQry_MX;overload;

implementation

uses PubClass_GL,Pub_Function,Pub_Global,TreeSelectDM,
  Pub_Message, DataModuleMain,Pub_WYZF;

{$R *.DFM}
procedure LoadFormZHQry_MX;overload;
begin
  LoadFormZHQry_MX('','','','');
end;

procedure LoadFormZHQry_MX(AKHYH,AYHHH,AYHZH,AZHMC:string);
begin
  if Application.FindComponent('FormZHQry_MX') = nil then
    Application.CreateForm(TFormZHQry_MX,FormZHQry_MX);

  with FormZHQry_MX do begin
    cbbYH.OnChange := nil;
    InitYHZHCbb(cbbYH);
    cbbYH.OnChange := cbbYHChange;
    
    sKHYH := AKHYH;
    sYHHH := AYHHH;
    sYHZH := AYHZH;
    sZHMC := AZHMC;
    //sYHZH := '15001726650050001213';
    if sYHZH <> '' then
    begin
      cbbYH.ItemIndex := cbbYH.Items.IndexOf(sYHZH + ' ' + sZHMC);
      lblTitle.Caption := '账户['+AYHZH+' '+AZHMC+']交易明细查询';
    end
    else
    begin
      lblTitle.Caption := '账户明细查询';
    end;
    DateTimePickerB.DateTime := Now;
    DateTimePickerE.DateTime := Now;

    RefreshCdsYHZH;
    Show;
  end;
end;

procedure TFormZHQry_MX.FormCreate(Sender: TObject);
begin
  EDRecordCount.Text := '';
  CEJFHJJE.Text := '';
  CEDJHJJE.Text := '';
  PSetClientDataSetProvider(self);
  InitGrid;
end;

procedure TFormZHQry_MX.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  IdHTTP.Destroy;
  Action := caFree;
end;

procedure TFormZHQry_MX.InitGrid;
begin
  THFilterZH.THDBGridPad := THDBGridData;
  THFilterZH.InitColumns;
end;


procedure TFormZHQry_MX.RefreshCdsYHZH;
var
  sDateB,sDateE:string;
  currnewpackageid: string;
  currFileName: string;
  szSQL: string;
  HaveNewData: boolean;
begin
  THDBGridData.SetFocus;
  cdsYHZH.DisableControls;
  HaveNewData := false;
  currFileName := ExtractFileDir(Application.ExeName)+'\' + sYHZH + '.cds';
  try
    sDateB := FormatDateTime('yyyy-mm-dd',DateTimePickerB.DateTime);
    sDateE := FormatDateTime('yyyy-mm-dd',DateTimePickerE.DateTime);
    cdsYHZH.Active:=False;
    currnewpackageid :=FormatDateTime('yyyymmddhhnnsszzz',Now);
    szSQL := 'select *, case when CRTBALANCE IS null then ''贷'' else ''借'' end JD, '
      +' case when CRTBALANCE IS null then DBTBALANCE else CRTBALANCE end YE, '
      + 'case when CRTBALANCE IS null then 0 else TRSAMT end JFJE, '
      + '  case when CRTBALANCE IS null then TRSAMT else 0 end DFJE from ebk_netcollect';
    szSQL := szSql + ' where CURACC=''' + sYHZH + '''';
    szSQL := szSql + ' and TRANS_DATE>=''' + sDateB + '''';
    szSQL := szSql + ' and TRANS_DATE<=''' + sDateE + '''';
    szSQL := szSql + ' order by trans_date, TRANS_TIME ';
    POpenSql(cdsYHZH,szSQL);
    getCurrentHeji;
  except

  end;
  cdsYHZH.EnableControls;
  THDBGridData.AutoGridColWidth(-1);
end;

procedure TFormZHQry_MX.SpeedItemRefreshClick(Sender: TObject);
begin
  cdsYHZH.Filtered := false;
  cdsYHZH.Filter := '';
  CB_JDFX.ItemIndex := 0;
  ED_JEFrom.text := '';
  ED_JETo.text := '';
  ED_FFDWMC.Text := '';
  ED_SFDWMC.Text := '';
  if not (cbbYH.Text = '') then
    sYHZH := TString.LeftStrBySp(cbbYH.Text);
  RefreshCdsYHZH;
end;


procedure TFormZHQry_MX.SpeedItemExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormZHQry_MX.SpeedItemExportClick(Sender: TObject);
begin
  HFExpandPrint1.Execute;
end;

procedure TFormZHQry_MX.Button1Click(Sender: TObject);
var
  currFilterStr: string;
begin
  currFilterStr := '';
  try
    if trim(ED_JEFrom.text) <> '' then strtofloat(trim(ED_JEFrom.text))     //added by guozy 20120425
  except
    showmessage('筛选发生额开始值必须是数字！');
    ED_JEFrom.SetFocus;
    exit;
  end;
  try
    if trim(ED_JETo.text) <> '' then strtofloat(trim(ED_JETo.text))
  except
    showmessage('筛选发生额结束值必须是数字！');
    ED_JETo.SetFocus;
    exit;
  end;
  if (trim(ED_JEFrom.text) <> '') and (trim(ED_JETo.text) <> '') then begin
    if Ed_JEFrom.Value >= ED_JETo.value then begin
      showmessage('筛选发生额结束值不能小于开始值！');
      Ed_JEFrom.SetFocus;
      exit;
    end;
  end;


  if CB_JDFX.ItemIndex=0 then begin  //借
    if trim(ED_JEFrom.text) <> '' then begin
      currFilterStr := currFilterStr + ' and (jfje >= ' + trim(ED_JEFrom.text)+')';
    end;
    if trim(ED_JETo.text) <> '' then begin
      currFilterStr := currFilterStr + ' and (jfje <= ' + trim(ED_JETo.text)+')';
    end;
  end else begin                     //贷
    if trim(ED_JEFrom.text) <> '' then begin
      currFilterStr := currFilterStr + ' and (dfje >= ' + trim(ED_JEFrom.text)+')';
    end;
    if trim(ED_JETo.text) <> '' then begin
      currFilterStr := currFilterStr + ' and (dfje <= ' + trim(ED_JETo.text)+')';
    end;
  end;
  if trim(ED_FFDWMC.text) <> '' then begin
    currFilterStr := currFilterStr + ' and (dbtdwmc like ''%' + trim(ED_FFDWMC.text) + '%'')';
  end;
  if trim(ED_SFDWMC.text) <> '' then begin
    currFilterStr := currFilterStr + ' and (crtdwmc like ''%' + trim(ED_SFDWMC.text) + '%'')';
  end;
  if pos(' and ', currFilterStr)=1 then begin
    currFilterStr := copy(currFilterStr,6,length(currFilterStr)-5);
  end;
  if trim(currFilterStr)<>'' then begin
    cdsYHZH.Filter := trim(currFilterStr);
    cdsYHZH.Filtered := true;
  end else begin
    cdsYHZH.Filter := '';
    cdsYHZH.Filtered := false;
  end;
  getCurrentHeji;
  THDBGridData.AutoGridColWidth(-1);
end;

procedure TFormZHQry_MX.getCurrentHeji;
var
  currJfhjje, currDfhjje: real;
begin
  if not cdsYHZH.IsEmpty then begin
    cdsYHZH.DisableControls;
    currJfhjje := 0;
    currDfhjje := 0;
    cdsYHZH.First;
    while not cdsYHZH.Eof do begin
      if cdsYHZH.fieldByName('AMOUNT_SIGN').AsString = '借' then begin
        currJfhjje := currJfhjje + cdsYHZH.fieldByName('jfje').AsCurrency;
      end else if cdsYHZH.fieldByName('AMOUNT_SIGN').AsString = '贷' then begin
        currDfhjje := currDfhjje + cdsYHZH.fieldByName('dfje').AsCurrency;
      end;
      cdsYHZH.Next;
    end;
    cdsYHZH.EnableControls;
    EDRecordCount.Text := inttostr(cdsYHZH.RecordCount);
    CEJFHJJE.Text := floattostr(currJfhjje);
    CEDJHJJE.Text := floattostr(currDfhjje);
  end;
end;

procedure TFormZHQry_MX.DateTimePickerBChange(Sender: TObject);
begin
  if DateTimePickerB.DateTime > DateTimePickerE.DateTime then begin
    if DateTimePickerB.Focused then begin
      DateTimePickerE.DateTime := DateTimePickerB.DateTime;
    end;
    if DateTimePickerE.Focused then begin
      DateTimePickerB.DateTime := DateTimePickerE.DateTime;
    end;
  end;
end;

procedure TFormZHQry_MX.SpeedItem1Click(Sender: TObject);
begin
  THFilterZH.ExecFilter;
end;

procedure TFormZHQry_MX.cbbYHChange(Sender: TObject);
begin
  SpeedItemRefreshClick(nil);
end;

procedure TFormZHQry_MX.THFilterZHFilter(Sender: TObject; AFilter: String);
begin
  cdsYHZH.Filter := AFilter;
  cdsYHZH.Filtered := True;
end;

procedure TFormZHQry_MX.btnNETSearchClick(Sender: TObject);
var
  vStart, vEndDate:String;
begin
  //确定查询开始到结束时间的数据吗？
  vStart := FormatDateTime('yyyymmdd', DateTimePickerB.Date);
  vEndDate := FormatDateTime('yyyymmdd', DateTimePickerE.Date);
  if Application.MessageBox(PChar('确定要提交查询"'+vStart+'-'+vEndDate+'"之间的数据请求吗？'),
    '系统提示',MB_ICONQuestion + MB_YESNO) = IDYES then
  begin
    //网银明细查询
    GEBKParams := DataModulePub.GetCdsBySQL('Select * from EBK_ZTCS where GSDM='+QuotedStr(GszGSDM)
    	+' and KJND='+QuotedStr(GszKJND));
    SaveParams('WYMXCX', vStart + '-' + vEndDate);
    if GEBKParams.ChangeCount > 0 then
    begin
      with GetSQLByDelta(GEBKParams, 'EBK_ZTCS', 'GSDM;KJND;CSMC') do
      begin
        PExecSQL(Text);
        Free;
        GEBKParams.MergeChangeLog;
      end;
    end;    
    Showmessage('查询请求提交成功，根据后台服务查询时间，等待查询结果！');
  end;
end;

end.
