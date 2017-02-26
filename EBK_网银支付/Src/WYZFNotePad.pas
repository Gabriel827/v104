unit WYZFNotePad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tgrids2, RXCtrls, ExtCtrls, SpeedBar, StdCtrls, THDBGrids, DB,
  DBClient, Tabs, ComCtrls, THFilters, Menus, SPrint2, ExpandPrint;

type
  TFormWYZFNotePad = class(TForm)
    PanelTitle: TPanel;
    lblTitle: TRxLabel;
    pnlTop: TPanel;
    ClientDataSetWYZF: TClientDataSet;
    SpeedBarPZNotePad: TSpeedBar;
    SpeedbarSection5: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    SpeedbarSection4: TSpeedbarSection;
    SpeedItem_insert: TSpeedItem;
    SpeedItem_Preview: TSpeedItem;
    SpeedItem_Print: TSpeedItem;
    SpeedItem_Refresh: TSpeedItem;
    SpeedItem_Filter: TSpeedItem;
    SpeedItem_NoFilter: TSpeedItem;
    SpeedItem_auditing: TSpeedItem;
    SpeedItem_counter_auditing: TSpeedItem;
    SpeedItem_cancellation: TSpeedItem;
    SpeedItem_revert: TSpeedItem;
    SpeedItem_delete: TSpeedItem;
    SpeedItemHelp: TSpeedItem;
    SpeedItem1: TSpeedItem;
    TabSetDJZT: TTabSet;
    THDBGridWYZF: TTHDBGrid;
    LabelQZRQ: TLabel;
    DateTimePickerFrom: TDateTimePicker;
    Label1: TLabel;
    DateTimePickerTo: TDateTimePicker;
    Label3: TLabel;
    ComboBoxYWLX: TComboBox;
    DataSourceWYZF: TDataSource;
    THFilterWYZF: TTHFilter;
    btnImport: TSpeedItem;
    pmImport: TPopupMenu;
    miOER: TMenuItem;
    miSalary: TMenuItem;
    N3: TMenuItem;
    miExcel: TMenuItem;
    Label2: TLabel;
    LabelCount: TLabel;
    GroupBox1: TGroupBox;
    RB_YWRQ: TRadioButton;
    RB_ZXSJ: TRadioButton;
    RB_CLSJ: TRadioButton;
    RB_ZFSJ: TRadioButton;
    Label26: TLabel;
    ComboBoxSJLY: TComboBox;
    btnSH: TSpeedItem;
    btnSelect: TSpeedItem;
    ExpandPrint1: TExpandPrint;
    SPrint: TSPrint;
    btnExport: TSpeedItem;
    btnZF: TSpeedItem;
    btnDel: TSpeedItem;
    procedure SpeedItem1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedItem_insertClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure THDBGridWYZFDblClick(Sender: TObject);
    procedure SpeedItem_RefreshClick(Sender: TObject);
    procedure TabSetDJZTChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure THFilterWYZFFilter(Sender: TObject; AFilter: string);
    procedure SpeedItem_FilterClick(Sender: TObject);
    procedure SpeedItem_NoFilterClick(Sender: TObject);
    procedure DateTimePickerFromExit(Sender: TObject);
    procedure miExcelClick(Sender: TObject);
    procedure btnSHClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnZFClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
  Private
    function DoWYZFZFHY(AZFID: string; AZFHY: Integer): Boolean;
    function DoWYZFDel(AZFID: string): Boolean;
    { Private declarations }
  Public
    { Public declarations }
    procedure LoadWYZFData(AZTIndex: Integer = 0);
  end;

var
  FormWYZFNotePad: TFormWYZFNotePad;
procedure LoadWYZFNotePad;

implementation

uses Pub_Global, Pub_Function, WYZF, Pub_WYZF, Pub_power, Pub_message,
  uEBK_IMPBM, uEBK_ImportExcel, WYZF_DJSH;

{$R *.dfm}

procedure LoadWYZFNotePad;
var
  i: Integer;
begin
  bWYZFQYSHL := True;
  if not TPower.GetPower(GN_WYZFDJB_Read) then
  begin
    SysMessage('û�в���Ȩ�ޡ�', AOther_JG, [mbOk]);
    Exit;
  end;
  with Application.MainForm do
  begin
    // �����λ�����Ѵ򿪣�����ô��ڣ������ȴ�������ʾ
    i := 0; //��ظ���ֵ
    if MDIChildCount > 0 then
      for i := 0 to MDIChildCount - 1 do
        if MDIChildren[i].Caption = '����֧��' then
          break;
    if i >= MDIChildCount then
    begin
      Application.CreateForm(TFormWYZFNotePad, FormWYZFNotePad);
      FormWYZFNotePad.Show;
    end
    else
    begin
      if MDIChildren[i].WindowState = wsMinimized then
        MDIChildren[i].WindowState := wsNormal;
      MDIChildren[i].Show;
    end;
  end;

end;

procedure TFormWYZFNotePad.SpeedItem1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormWYZFNotePad.FormShow(Sender: TObject);
begin
  InitModeCodeAndName(ComboBoxSJLY);
  ComboBoxSJLY.ItemIndex := 0;//getSJLYIndex('EBK');
  InitJSFS;
  ComboBoxYWLX.Items.CommaText := 'ȫ��,' + GszJSFSMC;
  ComboBoxYWLX.ItemIndex := 0;
  SetComponentsColor(self);
  DateTimePickerFrom.Date := Trunc(Now);
  DateTimePickerTo.Date := Trunc(Now + 1);
  if not bWYZFQYSHL then
  begin
    TabSetDJZT.Tabs.Clear;
    TabSetDJZT.Tabs.Add('���е���');
    TabSetDJZT.Tabs.Add('δ���');
    TabSetDJZT.Tabs.Add('�ѳ���');
    TabSetDJZT.Tabs.Add('�Ѹ���');
    TabSetDJZT.Tabs.Add('��ִ��');
    TabSetDJZT.Tabs.Add('��֧��');
    TabSetDJZT.Tabs.Add('֧��ʧ��');
    TabSetDJZT.Tabs.Add('������');
  end
  else
  begin
    TabSetDJZT.Tabs.Clear;
    TabSetDJZT.Tabs.Add('���е���');
    TabSetDJZT.Tabs.Add('δ����');
    TabSetDJZT.Tabs.Add('�����');
    TabSetDJZT.Tabs.Add('�����');
    TabSetDJZT.Tabs.Add('��ִ��');
    TabSetDJZT.Tabs.Add('��֧��');
    TabSetDJZT.Tabs.Add('֧��ʧ��');
    TabSetDJZT.Tabs.Add('������');
  end;
  THFilterWYZF.THDBGridPad := THDBGridWYZF;
  THFilterWYZF.InitColumns;
  if not bWYZFQYSHL then
  begin
    THDBGridWYZF.ShowCol('SHR1');
    THDBGridWYZF.ShowCol('SHSJ1');
    THDBGridWYZF.ShowCol('SHR2');
    THDBGridWYZF.ShowCol('SHSJ2');
    THDBGridWYZF.HideCol('SHR');
    THDBGridWYZF.HideCol('SHSJ');
  end
  else
  begin
    THDBGridWYZF.HideCol('SHR1');
    THDBGridWYZF.HideCol('SHSJ1');
    THDBGridWYZF.HideCol('SHR2');
    THDBGridWYZF.HideCol('SHSJ2');
    THDBGridWYZF.ShowCol('SHR');
    THDBGridWYZF.ShowCol('SHSJ');
  end;
  //SpeedItem_insert.Enabled := TPower.GetPower(GN_WYZF_Edit);  // Modified by guozy 2013/4/1 ����һ 11:15:24
  TabSetDJZT.TabIndex := 1;
  LoadWYZFData(1);
end;

procedure TFormWYZFNotePad.SpeedItem_insertClick(Sender: TObject);
begin
  if GszKJQJ = '' then
    GszKJQJ := Copy(GszYWRQ, 5, 2); // Added by guozy 2013/3/30 ������ 19:26:00
  LoadWYZF(GszGSDM, GszKJND, GszKJQJ, GCzy.ID, '', '', ClientDataSetWYZF, true);
  //LoadWYZFData(TabSetDJZT.TabIndex);
end;

procedure TFormWYZFNotePad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormWYZFNotePad.THDBGridWYZFDblClick(Sender: TObject);
var
  AZFID: string;
  AYWLXDM: string;
begin
  if ClientDataSetWYZF.RecordCount > 0 then
  begin
    AZFID := ClientDataSetWYZF.FieldByName('ZFID').AsString;
    AYWLXDM := ClientDataSetWYZF.FieldByName('YWLXDM').AsString;
    if GszKJQJ = '' then
      GszKJQJ := Copy(GszYWRQ, 5, 2); // Added by guozy 2013/3/30 ������ 19:26:00
    LoadWYZF(GszGSDM, GszKJND, GszKJQJ, GCzy.ID, AYWLXDM, AZFID, ClientDataSetWYZF, True);
    LoadWYZFData(TabSetDJZT.TabIndex);
    ClientDataSetWYZF.Locate('ZFID', AZFID, [loCaseInsensitive]);
  end;
end;

procedure TFormWYZFNotePad.LoadWYZFData(AZTIndex: Integer = 0);
var
  szSQL: string;
begin
  if DateTimePickerFrom.Date > DateTimePickerTo.Date then
  begin
    SysMessage('���ڷ�Χ����ȷ��', AOther_JG, [mbOk]);
    Exit;
  end;
  szSQL := 'select zfxx.*, PZML.PZH, PZML.KJQJ,'
    + '(case when zfxx.curshjd=0 then ''¼��'' when zfxx.curshjd=-9 then ''����'' else wfnd1.nodename end) as curshjdmc, '
    + '(case when zfxx.nextshjd=-1 then ''����'' when zfxx.nextshjd=-9 then ''����'' else wfnd2.nodename end) as nextshjdmc'
    + ', (case'
    + ' when djzt=-1 then ''����'' '
    + ' when djzt=0 then ''δ����'' '
    + ' when djzt>=1 and djzt<=2 and not (curshjd = 999 and nextshjd = -1) then ''�����'' '
    + ' when djzt=2 and (curshjd = 999 and nextshjd = -1) then ''�����'' '
    + ' when djzt=''3'' and (zfzt is null or zfzt='''') then ''��ִ��'' '
    + ' when djzt=''3'' and zfzt = ''֧���ɹ�'' then ''��֧��'' '
    + ' end) as djStatus'
    + ' from EBK_ZFXX zfxx'
    + ' left join ('
    + 'select wf.gsdm, wf.kjnd, wf.flowcode, nd.nodeseq, nd.nodename from pubworkflow wf '
    + ' left join pubwfnode nd on wf.gsdm = nd.gsdm and wf.kjnd = nd.kjnd '
    + ' and nd.flowcode = wf.flowcode '
    + ') wfnd1 '
    + ' on  wfnd1.gsdm = zfxx.gsdm'
    + ' and wfnd1.kjnd = zfxx.KJND'
    + ' and wfnd1.flowcode = zfxx.flowcode '
    + ' and wfnd1.nodeseq = zfxx.curshjd '
    + ' left join ('
    + 'select wf.gsdm, wf.kjnd, wf.flowcode, nd.nodeseq, nd.nodename from pubworkflow wf '
    + ' left join pubwfnode nd on wf.gsdm = nd.gsdm and wf.kjnd = nd.kjnd '
    + ' and nd.flowcode = wf.flowcode '
    + ') wfnd2 '
    + ' on  wfnd2.gsdm = zfxx.gsdm'
    + ' and wfnd2.kjnd = zfxx.KJND'
    + ' and wfnd2.flowcode = zfxx.flowcode'
    + ' and wfnd2.nodeseq = zfxx.nextshjd'
    + ' left join gl_pzml pzml on pzml.IDPZH= left(isnull(zfxx.YDJBH+''#'',''''), '
    +' charindex(''#'', isnull(zfxx.YDJBH+''#'',''''))-1) and PZML.GSDM='+QuotedStr(GszGSDM);
  szSQL := 'select * from (' + szSQL + ') yhzfxx '
    + ' where gsdm = ''' + GszGSDM + ''''
    + ' and KJND = ''' + GszKJND + '''';
  if RB_YWRQ.Checked then
  begin
    szSQL := szSQL + ' and ywrq >= ''' + FormatDateTime('yyyymmdd', DateTimePickerFrom.Date) + ''''
      + ' and ywrq <= ''' + FormatDateTime('yyyymmdd', DateTimePickerTo.Date) + '''';
  end
  else if RB_ZXSJ.Checked then
  begin
    szSQL := szSQL + ' and ZXSJ >= ''' + FormatDateTime('yyyy-mm-dd', DateTimePickerFrom.Date) + ''''
      + ' and ZXSJ <= ''' + FormatDateTime('yyyy-mm-dd', DateTimePickerTo.Date) + '''';
  end
  else if RB_CLSJ.Checked then
  begin
    szSQL := szSQL + ' and CLSJ >= ''' + FormatDateTime('yyyy-mm-dd', DateTimePickerFrom.Date) + ''''
      + ' and CLSJ <= ''' + FormatDateTime('yyyy-mm-dd', DateTimePickerTo.Date) + '''';
  end
  else if RB_ZFSJ.Checked then
  begin
    szSQL := szSQL + ' and ZFSJ >= ''' + FormatDateTime('yyyy-mm-dd', DateTimePickerFrom.Date) + ''''
      + ' and ZFSJ <= ''' + FormatDateTime('yyyy-mm-dd', DateTimePickerTo.Date) + '''';
  end;
  if (ComboBoxYWLX.Text <> 'ȫ��') then
    szSQL := szSQL + ' and ltrim(rtrim(ywlxdm)) = ''' + getJSFSDM(ComboBoxYWLX.ItemIndex - 1) + '''';
  if (ComboBoxSJLY.Text <> 'ȫ��') then
    szSQL := szSQL + ' and ltrim(rtrim(modcode)) = ''' + getModCode(ComboBoxSJLY.ItemIndex) + '''';
  if not bWYZFQYSHL then
  begin
    case AZTIndex of
      0: szSQL := szSQL + ' and djzt <> -2 ';
      1: szSQL := szSQL + ' and djzt = 0 ';
      2: szSQL := szSQL + ' and djzt = 1 and (zfzt is null or zfzt='''' or zfzt not like ''֧��%'') ';
      3: szSQL := szSQL + ' and djzt = 2 and (zfzt is null or zfzt='''' or zfzt not like ''֧��%'') ';
      4: szSQL := szSQL + ' and djzt = 3 and (zfzt is null or zfzt='''')';
      5: szSQL := szSQL + ' and djzt = 3 and zfzt = ''֧���ɹ�'' ';
      6: szSQL := szSQL + ' and djzt = -1 ';
    end;
  end
  else
  begin
    case AZTIndex of
      0: szSQL := szSQL + ' and djzt <> -2 ';
      1: szSQL := szSQL + ' and djzt = 0 ';
      2: szSQL := szSQL +
        ' and djzt >= 1 and djzt <= 2 and (not (curshjd = 999 and nextshjd = -1)) and (zfzt is null or zfzt='''' or zfzt not like ''֧��%'') ';
      3: szSQL := szSQL +
        ' and djzt = 2 and (curshjd = 999 and nextshjd = -1) and (zfzt is null or zfzt='''' or zfzt not like ''֧��%'') ';
      4: szSQL := szSQL + ' and djzt = 3 and (zfzt is null or zfzt='''')';
      5: szSQL := szSQL + ' and djzt = 3 and zfzt = ''֧���ɹ�'' ';
      6: szSQL := szSQL + ' and djzt = 3 and zfzt = ''֧��ʧ��'' ';
      7: szSQL := szSQL + ' and djzt = -1 ';
    end;
  end;

  szSQL := szSQL + ' order by ywrq,zfid ';
  try
    POpenSql(ClientDataSetWYZF, szSQL);
  except

  end;
  ClientDataSetWYZF.Last;
  ClientDataSetWYZF.First;
  LabelCount.Caption := '';
  LabelCount.Caption := IntToStr(ClientDataSetWYZF.RecordCount); // Added by guozy 2013/4/18 ������ 8:11:07

end;

procedure TFormWYZFNotePad.SpeedItem_RefreshClick(Sender: TObject);
begin
  THDBGridWYZF.SetFocus;
  LoadWYZFData(TabSetDJZT.TabIndex);
end;

procedure TFormWYZFNotePad.TabSetDJZTChange(Sender: TObject;
  NewTab: Integer; var AllowChange: Boolean);
begin
  LoadWYZFData(NewTab);
  btnDel.Enabled := True;
  case NewTab of
  1:
  begin
    btnZF.Enabled := True;
    btnDel.Enabled := False;
  end;
  7:
  begin
    btnDel.Enabled := True;
    btnZF.Enabled := False;
  end;
  else
    btnZF.Enabled := False;
    btnDel.Enabled := False;
  end;
end;

procedure TFormWYZFNotePad.THFilterWYZFFilter(Sender: TObject;
  AFilter: string);
begin
  ClientDataSetWYZF.Filter := AFilter;
  ClientDataSetWYZF.Filtered := True;
end;

procedure TFormWYZFNotePad.SpeedItem_FilterClick(Sender: TObject);
begin
  THFilterWYZF.ExecFilter;
  SpeedItem_NoFilter.Enabled := True;
  ClientDataSetWYZF.Last;
  ClientDataSetWYZF.First;
  LabelCount.Caption := '';
  LabelCount.Caption := IntToStr(ClientDataSetWYZF.RecordCount); // Added by guozy 2013/4/18 ������ 8:11:07
end;

procedure TFormWYZFNotePad.SpeedItem_NoFilterClick(Sender: TObject);
begin
  THFilterWYZF.RestoreFilter;
  ClientDataSetWYZF.Filter := '';
  ClientDataSetWYZF.Filtered := True;
  SpeedItem_NoFilter.Enabled := False;
  ClientDataSetWYZF.Last;
  ClientDataSetWYZF.First;
  LabelCount.Caption := '';
  LabelCount.Caption := IntToStr(ClientDataSetWYZF.RecordCount); // Added by guozy 2013/4/18 ������ 8:11:07
end;

procedure TFormWYZFNotePad.DateTimePickerFromExit(Sender: TObject);
begin
  if DateTimePickerFrom.Date > DateTimePickerTo.Date then
  begin
    SysMessage('���ڷ�Χ����ȷ��', AOther_JG, [mbOk]);
  end;
end;

procedure TFormWYZFNotePad.miExcelClick(Sender: TObject);
begin
  LoadImortFrmExcel;
end;

procedure TFormWYZFNotePad.btnSHClick(Sender: TObject);
var
  szSHYJ, szSHCZ: string;
  ABillAction: TWYZF_Bill_Action;
  AWYZFXXRec: TWYZFRec;
  ASHJG: TWYZF_Bill_SHJG;
  vJE: Extended;
  szCLYJ: string; //���ݴ������
  ADJLXID: string;
  ADJID: string;
  AZFID, AGroupID: string;
  AGroupLst: TStringList;
  BK: TBookmarkList;
  iCount: integer;
  bFirst:Boolean;
begin
  if (not TPower.GetPower(GN_WYZF_SH)) and (not TPower.GetPower(GN_WYZF_XS))
    and (not TPower.GetPower(GN_WYZF_TH)) then
  begin
    SysMessage('û����ˡ������˻�Ȩ�ޡ�', AOther_JG, [mbOk]);
    Exit;
  end;
  AGroupLst := TStringList.Create;
  bFirst := True;
  if THDBGridWYZF.SelectedRows.Count = 0 then
    THDBGridWYZF.SelectedRows.CurrentRowSelected := True;

    
  BK := THDBGridWYZF.SelectedRows;
  with ClientDataSetWYZF do
  begin
    for iCount := 0 to BK.Count-1 do
    begin
      ClientDataSetWYZF.GotoBookmark(Pointer(BK[iCount]));
      AWYZFXXRec.ZFID := FieldByName('ZFID').AsString;
      AWYZFXXRec.YWND := FieldByName('KJND').AsString;
      AWYZFXXRec.YWRQ := FieldByName('YWRQ').AsString;
      AWYZFXXRec.YWLXDM := FieldByName('YWLXDM').AsString;
      AWYZFXXRec.YWLXMC := FieldByName('YWLX').AsString;
      AWYZFXXRec.YWYH := FieldByName('YWYH').AsString;
      AWYZFXXRec.FKFZH := FieldByName('FKFZH').AsString;
      AWYZFXXRec.FKFMC := FieldByName('FKFMC').AsString;
      AWYZFXXRec.CLXX := FieldByName('CLXX').AsString;
      AWYZFXXRec.ZFXX := FieldByName('ZFXX').AsString;
      AWYZFXXRec.FYHZH := FieldByName('FYHZH').AsString;
      AWYZFXXRec.FZHMC := FieldByName('FZHMC').AsString;
      AWYZFXXRec.FKHYH := FieldByName('FKHYH').AsString;
      AWYZFXXRec.FYHHH := FieldByName('FYHHH').AsString;
      AWYZFXXRec.FYHHB := FieldByName('FYHHB').AsString;
      AWYZFXXRec.FKHDQ := FieldByName('FKHDQ').AsString;
      AWYZFXXRec.SKFZH := FieldByName('SKFZH').AsString;
      AWYZFXXRec.SKFMC := FieldByName('SKFMC').AsString;
      AWYZFXXRec.SYHZH := FieldByName('SYHZH').AsString;
      AWYZFXXRec.SZHMC := FieldByName('SZHMC').AsString;
      AWYZFXXRec.SKHYH := FieldByName('SKHYH').AsString;
      AWYZFXXRec.SYHHH := FieldByName('SYHHH').AsString;
      AWYZFXXRec.SYHHB := FieldByName('SYHHB').AsString;
      AWYZFXXRec.SKHDQ := FieldByName('SKHDQ').AsString;
      AWYZFXXRec.ZY := FieldByName('ZY').AsString;
      AWYZFXXRec.JE := FieldByName('JE').AsFloat;
      AWYZFXXRec.TCBZ := FieldByName('TCBZ').AsString;
      AWYZFXXRec.GROUPID := FieldByName('GROUPID').AsString;
      AWYZFXXRec.LRID := FieldByName('LRID').AsInteger;
      AWYZFXXRec.LRSJ := FieldByName('LRSJ').AsString;
      AWYZFXXRec.SHID1 := FieldByName('SHID1').AsInteger;
      AWYZFXXRec.SHID2 := FieldByName('SHID2').AsInteger;
      AWYZFXXRec.DJZT := FieldByName('DJZT').AsInteger;
      AWYZFXXRec.CLZT := FieldByName('CLZT').AsString;
      AWYZFXXRec.SLZT := FieldByName('SLZT').AsString;
      AWYZFXXRec.ZFZT := FieldByName('ZFZT').AsString;
      AWYZFXXRec.YDJBH := FieldByName('YDJBH').AsString;
      AWYZFXXRec.YDJSJ := FieldByName('YDJSJ').AsString;
      AWYZFXXRec.ZXSJ := FieldByName('ZXSJ').AsString; // Added by guozy 2013/4/19 ������ 14:44:48
      AWYZFXXRec.ZFSJ := FieldByName('ZFSJ').AsString; // Added by guozy 2013/4/19 ������ 14:44:48

      AWYZFXXRec.SBANKUQNO := FieldByName('BANKUQNO').AsString; // Added by guozy 2013/4/18 ������ 8:58:54
      AWYZFXXRec.SBUSIUQNO := FieldByName('BUSIUQNO').AsString; // Added by guozy 2013/4/18 ������ 8:58:59
      AWYZFXXRec.SHEADBUSIUQNO := FieldByName('HEADBUSIUQNO').AsString; // Added by guozy 2013/4/18 ������ 8:59:03

      if not bWYZFQYSHL then
      begin
      end
      else
      begin
        AWYZFXXRec.SHFlow := FieldByName('FlowCode').AsString;
        AWYZFXXRec.CurSHJD := FieldByName('CurSHJD').AsInteger;
        AWYZFXXRec.NextSHJD := FieldByName('NextSHJD').AsInteger;
        AWYZFXXRec.CurSHJDMC := FieldByName('CurSHJD').AsString;
        AWYZFXXRec.NextSHJDMC := FieldByName('NextSHJD').AsString;
        if AWYZFXXRec.DJZT = -1 then
          AWYZFXXRec.DJStatus := djZF
        else if AWYZFXXRec.DJZT = 0 then
          AWYZFXXRec.DJStatus := djWSHH
        else if AWYZFXXRec.DJZT = 1 then
        begin
          AWYZFXXRec.DJStatus := djSSH
        end
        else if AWYZFXXRec.DJZT = 2 then
          AWYZFXXRec.DJStatus := djSHH
        else if AWYZFXXRec.DJZT = 3 then
          AWYZFXXRec.DJStatus := djZX
        else
          AWYZFXXRec.DJStatus := djWSHH;
        if (AWYZFXXRec.DJStatus = djWSHH) and (AWYZFXXRec.SFTH = '1') then
          AWYZFXXRec.DJStatus := djTH;
      end;

      //�����ʾ add by gengzhuo 20130926
      if (AWYZFXXRec.DJZT = 1) and (AWYZFXXRec.SLZT = '����ʧ��') and (AWYZFXXRec.CLXX = '������Ϣ�ѱ��۸�') then
      begin
        SysMessage('���ڼ�����Ϣ�ѱ��۸ģ�ֻ���ջ����', AOther_JG, [mbOk]);
        Exit;
      end;
      //zhengjy ������˵�Ukey��֤
      if bFirst then
        if not LoadWYZFDJSH(AWYZFXXRec, szSHYJ, ABillAction) then
          Exit;
      bFirst := False;
      begin
        if ABillAction = baSH then
        begin
          if not TPower.GetPower(GN_WYZF_SH) then
          begin
            SysMessage('û�����Ȩ�ޡ�', AOther_JG, [mbOk]);
            Exit;
          end;
          if ClientDataSetWYZF.fieldbyname('FYHZH').asstring = '' then
          begin
            SysMessage('�����˺Ų�����Ϊ�ա�', AOther_JG, [mbOk]);
            Exit;
          end; //�����˺�
          if ClientDataSetWYZF.fieldbyname('SYHZH').asstring = '' then
          begin
            SysMessage('�շ��˺Ų�����Ϊ�ա�', AOther_JG, [mbOk]);
            Exit;
          end;

          if ClientDataSetWYZF.fieldbyname('SZHMC').asstring = '' then
          begin
            SysMessage('�շ����Ʋ�����Ϊ�ա�', AOther_JG, [mbOk]);
            Exit;
          end;

          if ClientDataSetWYZF.fieldbyname('SKHYH').asstring = '' then
          begin
            SysMessage('�շ����������Ʋ�����Ϊ�ա�', AOther_JG, [mbOk]);
            Exit;
          end;
          if ClientDataSetWYZF.fieldbyname('SDEPID').asstring = '' then
          begin
            SysMessage('�շ�������Ų�����Ϊ�ա�', AOther_JG, [mbOk]);
            Exit;
          end;
        end
        else if ABillAction = baXS then
        begin
          if not TPower.GetPower(GN_WYZF_XS) then
          begin
            SysMessage('û������Ȩ�ޡ�', AOther_JG, [mbOk]);
            Exit;
          end;
        end
        else if ABillAction = baTH then
        begin
          if not TPower.GetPower(GN_WYZF_TH) then
          begin
            SysMessage('û���˻�Ȩ�ޡ�', AOther_JG, [mbOk]);
            Exit;
          end;
        end
        else if ABillAction = baNOUKEY then
        begin
          Exit;
        end;
        if AGroupLst.IndexOf(AWYZFXXRec.GROUPID) < 0 then
          AGroupLst.Add(AWYZFXXRec.GROUPID)
        else
        begin
          Continue;
        end;
        ADJLXID := '0';
        ADJID := AWYZFXXRec.ZFID;
        vJE := AWYZFXXRec.JE;
        case ABillAction of
          baSave:
            begin
            end;
          baSS: //����
            begin
              //
              ASHJG.DJLXID := ADJLXID;
              ASHJG.DJSHJG := barPASS;
              ASHJG.DJSHYJ := '����';
              ASHJG.DJJE := vJE;
              if PSetBillAct(ABillAction, ADJID, AWYZFXXRec.YWLXDM, AWYZFXXRec.GROUPID, ASHJG) then
              begin

              end;
            end;
          baSH: //���
            begin
              szCLYJ := szSHYJ;
              ASHJG.DJLXID := ADJLXID;
              ASHJG.DJSHJG := barPASS;
              ASHJG.DJSHYJ := szCLYJ;
              ASHJG.DJJE := vJE;
              //���ݵ�������Ϣ����ֵ���������Ϣ�����ʱ����ǰ��˽ڵ��ǵ����ϼ�¼����һ��˽ڵ�
              ASHJG.DJCurrSHJD := AWYZFXXRec.NextSHJD;
              if PSetBillAct(ABillAction, ADJID, AWYZFXXRec.YWLXDM, AWYZFXXRec.GROUPID, ASHJG) then
              begin

              end;
            end;
          baXS: //����
            begin
              szCLYJ := szSHYJ;
              ASHJG.DJLXID := ADJLXID;
              ASHJG.DJSHJG := barBack;
              ASHJG.DJSHYJ := szCLYJ;
              ASHJG.DJJE := vJE;
              ASHJG.DJCurrSHJD := AWYZFXXRec.CurSHJD;
              ASHJG.DJNextSHJD := AWYZFXXRec.NextSHJD;
              if PSetBillAct(ABillAction, ADJID, AWYZFXXRec.YWLXDM, AWYZFXXRec.GROUPID, ASHJG) then
              begin

              end;
            end;
          baTH: //�˻�
            begin
              szCLYJ := szSHYJ;
              ASHJG.DJLXID := ADJLXID;
              ASHJG.DJSHJG := barBInit;
              ASHJG.DJSHYJ := szCLYJ;
              ASHJG.DJJE := vJE;
              ASHJG.DJCurrSHJD := AWYZFXXRec.CurSHJD;
              ASHJG.DJNextSHJD := AWYZFXXRec.NextSHJD;
              if PSetBillAct(ABillAction, ADJID, AWYZFXXRec.YWLXDM, AWYZFXXRec.GROUPID, ASHJG) then
              begin

              end;
            end;
          baHS: //�ջ�
            begin
              ASHJG.DJLXID := ADJLXID;
              ASHJG.DJSHJG := barPASS;
              ASHJG.DJSHYJ := '�ջ�';
              ASHJG.DJJE := vJE;
              if PSetBillAct(ABillAction, ADJID, AWYZFXXRec.YWLXDM, AWYZFXXRec.GROUPID, ASHJG) then
              begin

              end;
            end;
          baZF: //����
            begin
            end;
          baHY: //��ԭ
            begin
            end;
          baSC: //ɾ��
            begin
            end;
          baZX:
            begin
              ASHJG.DJLXID := ADJLXID;
              ASHJG.DJSHJG := barPASS;
              ASHJG.DJSHYJ := 'ִ��';
              ASHJG.DJJE := vJE;
              if PSetBillAct(ABillAction, ADJID, AWYZFXXRec.YWLXDM, AWYZFXXRec.GROUPID, ASHJG) then
              begin

              end;
            end;
          // ��ִ��
          baFZX:
            begin
              if not ((AWYZFXXRec.DJZT = 3) and (AWYZFXXRec.SLZT = '����ɹ�') and (AWYZFXXRec.ZFZT = '֧��ʧ��')) then
              begin
                SysMessage('ֻ���Ѿ�ִ�С�����ɹ���֧��ʧ�ܵĵ��ۿ���ȡ��ִ�У�', AOther_JG, [mbOk]);
                Exit;
              end;
              ASHJG.DJLXID := ADJLXID;
              ASHJG.DJSHJG := barPASS;
              ASHJG.DJSHYJ := 'ȡ��ִ��';
              ASHJG.DJJE := vJE;
              if PSetBillAct(ABillAction, ADJID, AWYZFXXRec.YWLXDM, AWYZFXXRec.GROUPID, ASHJG) then
              begin

              end;
            end;
        end;
        szSHCZ := '';
        if ABillAction = baSH then
          szSHCZ := '���'
        else if ABillAction = baXS then
          szSHCZ := '�˻���һ��'
        else if ABillAction = baTH then
          szSHCZ := '�˻ص�������';
        PWriteYHCzrz('��ˣ�' + szSHCZ + ' ' + AWYZFXXRec.YWLXDM + '-' + AWYZFXXRec.ZFID);
      end;
    end;
    SpeedItem_RefreshClick(nil);
  end;
end;

procedure TFormWYZFNotePad.btnSelectClick(Sender: TObject);
begin
  ClientDataSetWYZF.First;
  while not ClientDataSetWYZF.eof do
  begin
    THDBGridWYZF.SelectedRows.CurrentRowSelected := True;
    ClientDataSetWYZF.Next;
  end;
end;

procedure TFormWYZFNotePad.btnExportClick(Sender: TObject);
begin
  ExpandPrint1.Execute;
end;

function TFormWYZFNotePad.DoWYZFZFHY(AZFID: string; AZFHY: Integer): Boolean;
var
  szSQL: string;
begin
  Result := False;
  try
    szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(AZFHY)
      + ' WHERE GSDM = ''' + GszGSDM + ''''
      + ' AND KJND = ''' + GszKJND + ''''
      + ' AND ZFID = ''' + AZFID + '''';
    PExecSQL(szSQL);
    with ClientDataSetWYZF do
    begin
      if Locate('zfid', VarArrayOf([AZFID]), []) then
      begin
        Edit;
        FieldByName('DJZT').AsInteger := AZFHY;
        Post;
      end;
    end;
    Result := True;
  except
    SysMessage('����ʧ�ܡ�', AOther_JG, [mbOK]);
  end;
end;

procedure TFormWYZFNotePad.btnZFClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_Edit) then
  begin
    SysMessage('û�б༭Ȩ�ޡ�', AOther_JG, [mbOk]);
    Exit;
  end;
  if not TPower.GetPower(GN_WYZF_ZF) then
  begin
    SysMessage('û������Ȩ�ޡ�', AOther_JG, [mbOk]);
    Exit;
  end;
  if DoWYZFZFHY(ClientDataSetWYZF.FieldByName('ZFID').AsString, -1) then
  begin
    SpeedItem_RefreshClick(nil);
    PWriteYHCzrz('���ϣ�' + ClientDataSetWYZF.FieldByName('ZFID').AsString);
  end;
end;
function TFormWYZFNotePad.DoWYZFDel(AZFID: string): Boolean;
var
  szSQL: string;
begin
  Result := False;
  try
    szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(-2) // -2 ��ʾɾ��
    + ' WHERE GSDM = ''' + GszGSDM + ''''
      + ' AND KJND = ''' + GszKJND + ''''
      + ' AND ZFID = ''' + AZFID + '''';
    PExecSQL(szSQL);
    with ClientDataSetWYZF do
    begin
      if Locate('zfid', VarArrayOf([AZFID]), []) then
        Delete;
    end;
    Result := True;
  except
    SysMessage('����ʧ�ܡ�', AOther_JG, [mbOK]);
  end;
end;

procedure TFormWYZFNotePad.btnDelClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_Edit) then
  begin
    SysMessage('û�б༭Ȩ�ޡ�', AOther_JG, [mbOk]);
    Exit;
  end;
  if not TPower.GetPower(GN_WYZF_ZF) then
  begin
    SysMessage('û��ɾ��Ȩ�ޡ�', AOther_JG, [mbOk]);
    Exit;
  end;
  if (ClientDataSetWYZF.FieldByName('ZFZT').AsString = '֧���ɹ�')
    or (ClientDataSetWYZF.FieldByName('ZFZT').AsString = '֧��״̬����') then
  begin
    SysMessage('֧���ɹ���֧��״̬�����ĵ��ݲ�����ɾ����', AOther_JG, [mbOk]);
    Exit;
  end;
  if (ClientDataSetWYZF.FieldByName('SLZT').AsString = '����ɹ�') then
  begin
    SysMessage('�����Ѿ�����ɹ���������ɾ����', AOther_JG, [mbOk]);
    Exit;
  end;
  if DoWYZFDel(ClientDataSetWYZF.FieldByName('ZFID').AsString) then
  begin
    PWriteYHCzrz('ɾ����-' + ClientDataSetWYZF.FieldByName('ZFID').AsString);
  end;
end;

end.

