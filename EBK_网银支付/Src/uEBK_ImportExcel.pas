unit uEBK_ImportExcel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Variants, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, PageMngr, ExtCtrls, Mask, ToolEdit, RXSpin, Tgrids2,
  CheckLst, ComObj, OleServer, Buttons, Db, DBClient, jpeg, ADODB, Grids,
  DBGridEh;

type
  TFrmEBKImportExcel = class(TForm)
    Panel1: TPanel;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    PageControlmx: TPageControl;
    TabSheet6: TTabSheet;
    GroupBox5: TGroupBox;
    SpeedButton2: TSpeedButton;
    EditImportgzmxfn: TEdit;
    GroupBox6: TGroupBox;
    TabSheet7: TTabSheet;
    GroupBox7: TGroupBox;
    TabSheet8: TTabSheet;
    btnmxPrior: TButton;
    btnmxNext: TButton;
    btnmxExit: TButton;
    OpenDialogmx: TOpenDialog;
    TabSheet9: TTabSheet;
    GroupBox8: TGroupBox;
    Memomx: TMemo;
    GroupBox9: TGroupBox;
    Memojcjg: TMemo;
    Label4: TLabel;
    Labelmxdrts: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbl1: TLabel;
    con1: TADOConnection;
    tbl1: TADOTable;
    grd: TDBGridEh;
    dsRls: TDataSource;
    cdsData: TClientDataSet;
    btnSave: TButton;
    btnOpen: TButton;
    sd: TSaveDialog;
    OD: TOpenDialog;
    GroupBox1: TGroupBox;
    Label23: TLabel;
    ComboBoxYWLX: TComboBox;
    Label5: TLabel;
    cmbUseage: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton2Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure btnmxNextClick(Sender: TObject);
    procedure btnmxPriorClick(Sender: TObject);
    procedure btnmxExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure ComboBoxYWLXChange(Sender: TObject);
  Private
    { Private declarations }
    FFldCds:TClientDataSet;
    FFldRls:TClientDataSet;
    FDefaultBank, FDefaultBankHH:String;
    GzCount: integer; //��������
    procedure ChangeStepMX(nextstep: boolean);
    function ImPortExcelBeforeCheck(fname: string): boolean;
    function ImPortFromExcel(fname: string): Boolean;
    function GetExcelinfo(sfname: string): boolean;
    //�����ֶ��Լ��ֶ�����
    procedure InitFldsDef;
  public
    
  end;


const
  ExcelDBstr2003 =
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=%s;Extended Properties=Excel 8.0;Persist Security Info=False';
  ExcelDBstr2007 =
    'Provider=microsoft.ACE.oledb.12.0;Data Source=%s;Extended Properties=Excel 8.0;Persist Security Info=False';
  TblName = 'EBK_ZFXX';
var
  FrmEBKImportExcel: TFrmEBKImportExcel;
  blImport: boolean;

procedure LoadImortFrmExcel;


implementation

uses Pub_Global, Pub_Function, DataModuleMain, Pub_WYZF;

{$R *.DFM}

procedure LoadImortFrmExcel;
begin
  try
    FrmEBKImportExcel := TFrmEBKImportExcel.Create(nil);
    FrmEBKImportExcel.ShowModal;
  finally
    FrmEBKImportExcel.Free;
  end;
end;

procedure TFrmEBKImportExcel.FormCreate(Sender: TObject);
var
  sSql:String;
begin
  PSetClientDataSetProvider(self);
  InitJSFS;
  ComboBoxYWLX.Items.CommaText := GszJSFSMC;
  sSql := 'Select YHNAME, YHHH from pubszdwzh  where YHZH='+QuotedStr(ReadParams('MRZH'))
    +' and KJND='+QuotedStr(GszKJND);
  with DataModulePub.GetCdsBySQL(sSQL) do
  begin
    if RecordCount > 0 then
    begin
      FDefaultBank := FieldByName('YHNAME').AsString;
      FDefaultBankHH := FieldByName('YHHH').AsString;
    end;
    Free;
  end;
end;

procedure TFrmEBKImportExcel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action := cafree;
end;

procedure TFrmEBKImportExcel.SpeedButton2Click(Sender: TObject);
begin
  if OpenDialogmx.Execute then
    EditImportgzmxfn.text := OpenDialogmx.FileName;
end;

procedure TFrmEBKImportExcel.PageControl2Change(Sender: TObject);
begin
  ChangeStepMX(false);
end;

//��ϸ���벽�账�����

procedure TFrmEBKImportExcel.ChangeStepMX(nextstep: boolean);
var
  currentPage, nextpage, i: integer;
  Execstep, checkworksheet: boolean;
  szfname, sztargetfname, szexcelfname: string;
begin
  if ComboBoxYWLX.ItemIndex = -1 then begin
    messagedlg('����ָ�����㷽ʽ��',
      mtinformation, [mbok], 0);
    ComboBoxYWLX.SetFocus;
    exit;
  end;
  {if ComboBoxJKLX.ItemIndex = -1 then begin
    messagedlg('����ָ��ҵ�����ͣ�',
      mtinformation, [mbok], 0);
    ComboBoxJKLX.SetFocus;
    exit;
  end; }
  if (TString.RightStrBySp(ComboBoxYWLX.Text) = '����')
    or (TString.RightStrBySp(ComboBoxYWLX.Text) = '����') then
  begin
    if cmbUseage.ItemIndex  < 0 then
    begin
      Application.MessageBox('��ѡ����;��',  'ϵͳ��ʾ', MB_ICONWarning + MB_OK);
      cmbUseage.SetFocus;
      Exit;
    end;
  end;
  if PageControlmx.ActivePageIndex=0 then InitFldsDef;
  szfname := EditImportgzmxfn.text;
  currentPage := PageControlmx.ActivePageIndex;
  if nextstep then
    nextpage := currentPage + 1
  else
    nextpage := currentPage - 1;
  if nextpage = -1 then
    nextpage := 0;
  if nextpage = PageControlmx.PageCount then
    nextpage := PageControlmx.PageCount - 1;
  if not nextstep then
  begin
    Execstep := true;
  end
  else
  begin
    case currentpage of
      0:
        begin
          if not FileExists(szfname) then
          begin
            messagedlg('ָ����Excel�ļ� ' + szfname + ' �����ڣ�',
              mtinformation, [mbok], 0);
            Execstep := false;
            exit;
          end;
          Execstep := GetExcelinfo(szfname);
        end;
      1:
        begin
          if not FileExists(szfname) then
          begin
            messagedlg('ָ����Excel�ļ� ' + szfname + ' �����ڣ�',
              mtinformation, [mbok], 0);
            Execstep := false;
            exit;
          end;
          BtnmxNext.Enabled := false;
          PageControlmx.Pages[currentPage].Enabled := false;
          PageControlmx.Pages[nextpage].Enabled := true;
          PageControlmx.ActivePageIndex := nextpage;
          messagedlg('��ʼ������ȷ�Լ�飬��������ļ����ڴ�״̬����رգ�', mtinformation, [mbok], 0);
          if ImPortExcelBeforeCheck(szfname) = false then //������ȷ�Լ��δͨ��ʱ���ܵ���
          begin
            BtnmxNext.Enabled := false;
            messagedlg('������ȷ�Լ��δͨ�������޸ĺ����ԣ�',
              mtinformation, [mbok], 0);
            exit;
          end
          else
          begin
            Memojcjg.Lines.Add('������ȷ�Լ��ͨ�������Ե��룡');
            Execstep := true;
          end;
        end;
      2:
        begin
          if messagedlg('ȷ��Ҫ��ʼ������', mtConfirmation, [mbyes,
            mbcancel], 0) = mryes then
          begin
            Execstep := true;
            btnmxNext.Enabled := false;
            btnmxPrior.Enabled := false;
            btnmxExit.Enabled := false;
            try
              Memomx.Lines.Clear;
              if ImPortFromExcel(szfname) = True then
              begin
                //���ѵ�����ļ������Ϊ�ѵ���
                Memomx.Lines.Add('����ɹ�!');
                Memomx.Lines.Add('�Ѿ����������������ݵ���!');
                Memomx.Lines.Add('�ôε���һ��' + Inttostr(GzCount) + '������');
                blImport := true;
                if FileExists(szfname) then
                  RenameFile(szfname, extractfilepath(szfname) + '[' + DateToStr(Date) + '_�ѵ���]' +
                    extractfilename(szfname));
              end
              else
              begin
                Memomx.lines.add('����ʧ��.');
                Execstep := false;
              end;
            except
              on E: Exception do
              begin
                Memomx.lines.add('����ʧ�ܣ�������Ϣ���£�');
                Memomx.lines.add(e.message);
                messagedlg('����ʧ��,��ȷ��:'
                  + #13 + 'Excel�ļ�û�б���������ʹ��;Excel�ļ����ݸ�ʽ�淶;�ֶζ�Ӧ������ȷ', mtinformation,
                  [mbok], 0);
                Execstep := false;
              end;
            end;
            Execstep := true;
            BtnmxNext.Enabled := false;
            BtnmxPrior.Enabled := true;
            Btnmxexit.Enabled := true;
          end
          else
          begin
            Execstep := false;
            exit;
          end
        end;
      3:
        begin
        end;
    end;
  end;
  if Execstep then
  begin
    if nextpage = 0 then
    begin
      BtnmxPrior.Enabled := false;
      BtnmxNext.Enabled := true;
    end
    else if nextpage = PageControlmx.PageCount - 1 then
    begin
      BtnmxPrior.Enabled := true;
      BtnmxNext.Enabled := false;
      if PageControlmx.ActivePageIndex = 1 then
      begin
        Labelmxdrts.Visible := true;
        Labelmxdrts.Caption := '';
      end
      else
      begin
        Labelmxdrts.Visible := false;
      end;
    end
    else
    begin
      BtnmxPrior.Enabled := true;
      BtnmxNext.Enabled := true;
    end;
    PageControlmx.Pages[currentPage].Enabled := false;
    PageControlmx.Pages[nextpage].Enabled := true;
    PageControlmx.ActivePageIndex := nextpage;
  end;
end;

procedure TFrmEBKImportExcel.btnmxNextClick(Sender: TObject);
begin
  ChangeStepMX(true);
end;

procedure TFrmEBKImportExcel.btnmxPriorClick(Sender: TObject);
begin
  ChangeStepMx(false);
end;


function TFrmEBKImportExcel.ImPortExcelBeforeCheck(fname: string): boolean;
var
  szsql, szcolname: string;
  i:integer;

begin
  Memojcjg.Lines.Clear;
  Memojcjg.Lines.Add('���ڼ�飬���Եȣ�');
  result := true;
  try
    tbl1.Open;
    tbl1.First;
    while not tbl1.Eof do
    begin
      for i:=0 to tbl1.FieldCount-1 do
      begin
        if FFldRls.Locate('ExcelName', tbl1.Fields[i].FieldName, []) then
        begin
          if FFldCds.Locate('dbname', FFldRls.FieldByName('dbName').AsString,[]) then
          begin
            //�ֶ������ж�
            if FFldCds.FieldByName('type').AsString='N' then
            begin
              if Pos(',', tbl1.Fields[i].AsString)> 0 then
              begin
                tbl1.Edit;
                tbl1.Fields[i].AsString := StringReplace(tbl1.Fields[i].AsString
                ,',','',[rfReplaceAll]);
                tbl1.Post;
              end;

              try
                StrToFloat(tbl1.Fields[i].AsString)
              except
                Result := False;
                Memojcjg.lines.add('��' + IntToStr(Tbl1.RecNo + 1) +'�У���"'+tbl1.Fields[i].FieldName
                  +'"��'+tbl1.Fields[i].AsString+'������ֵ���ͣ�');
              end;
            end;
            //�ֶγ����ж�
            if FFldCds.FieldByName('type').AsString='C' then
            begin
              if Length(tbl1.Fields[i].AsString)> FFldCds.FieldByName('Length').AsInteger then
              begin
                Result := False;
                Memojcjg.lines.add('��' + IntToStr(Tbl1.RecNo + 1) +'�У���"'+tbl1.Fields[i].FieldName
                  +'"��'+tbl1.Fields[i].AsString+'���ȳ��������ƣ�'+FFldCds.FieldByName('Length').AsString+'��');
              end;
            end;
          end;
        end;
      end;
      tbl1.Next;
    end;
  except
    on e: Exception do
    begin
      result := false;
      Memojcjg.lines.add(e.Message);
    end;
  end;

end;

function GetNewID: String;
var
  szZfId:String;
begin
  with DataModulePub.ClientDataSetTmp do
  begin
    POpenSql(DataModulePub.ClientDataSetTmp,
      'select max(Zfid) as maxid from EBK_ZFXX where gsdm = ''' + GszGSDM + ''''
        + ' and KJND = ''' + GszKJND + ''''
        + ' and ywlx = ''ת��''');
    if FindFirst and (Trim(FieldByName('maxid').AsString) <> '') then
    begin
      if Length(FieldByName('maxid').AsString) >= 8 then
        szZfId := IntToStr(StrToInt(Copy(FieldByName('maxid').AsString, 5, 8)) + 1)
      else
        szZfId := '00000001';
      while Length(szZfId) < 8 do
      begin
        szZfId := '0' + szZfId;
      end;
    end
    else
      szZfId := '00000001';
    Result := GszKJND + szZfId;
    Close;
  end;
end;

function TFrmEBKImportExcel.ImPortFromExcel(fname: string): Boolean;
var
  str, szsql, szcolname: string;
  i, j: integer;
  szZfId:String;
  slSql: TStrings;
  GroupID:String;
begin
  result := False;
  //�ֶι�ϵȷ���� ��ӵ����ݼ�����
  POpenSQL(cdsData, 'Select * from '+TblName+' where 1=0');
  tbl1.Open;
  if (tbl1.IsEmpty) or (not tbl1.FindFirst) then begin
    ShowMessage('û�����ݿ��Ա����룡');
    exit;
  end;
  tbl1.First;
  GroupID:= GetGuid;
  szZfId := getNewLSH(GszGSDM, GszKJND, getJSFSDM(ComboBoxYWLX.ItemIndex));// GetNewID;
  while not tbl1.eof do
  begin
    CdsData.Append;

    CdsData.FieldByName('GROUPID').AsString := GroupID;
    inc(GzCount);
    for i:=0 to cdsData.Fields.Count-1 do
    begin
      //FFldRls�ǽ������б����ݼ�
      if FFldRls.Locate('dbName', cdsData.Fields[i].FieldName, []) then begin
        if FFldRls.FieldByName('ExcelName').AsString <> '' then
        begin
          CdsData.Fields[i].AsString :=  tbl1.FieldByName(FFldRls.FieldByName('ExcelName').AsString).AsString;
        end
      end
      else
      begin
        //FFldCds�Ǹ��ֶε�����ȱʡֵ����ʱ���ݼ�
        if FFldCds.Locate('dbName', cdsData.Fields[i].FieldName, []) then
        begin
          if FFldCds.FieldByName('DEFAULT').AsString<>'' then begin
            CdsData.Fields[i].AsString := FFldCds.FieldByName('DEFAULT').AsString;
          end else
            CdsData.Fields[i].AsString := '';
        end;
      end;
    end;
    CdsData.FieldByName('ZFID').AsString := szZfId;
    CdsData.FieldByName('USEOF_CODE').AsString := TString.LeftStrBySp(cmbUseage.Text);
    CdsData.FieldByName('USEOF_DESC').AsString := TString.RightStrBySp(cmbUseage.Text);

    CdsData.FieldByName('YDJBH').AsString := CdsData.FieldByName('GROUPID').AsString;
    CdsData.FieldByName('GSDM').AsString := GszGSDM;
    CdsData.FieldByName('KJND').AsString := GszKJND;
    CdsData.FieldByName('YWQJ').AsString := formatDateTime('yyyymm', Date);
    CdsData.FieldByName('YWRQ').AsString := formatDateTime('yyyymmdd', Date);//FCdsPZML.FieldByName('PZRQ').AsString;
    if ComboBoxYWLX.ItemIndex >= 0 then
    begin
      CdsData.FieldByName('YWLX').AsString := TString.RightStrBySp(ComboBoxYWLX.Text);
      CdsData.FieldByName('YWLXDM').AsString := TString.LeftStrBySp(ComboBoxYWLX.Text);
    end;
    //��������д���Э��ģ� ���뿪�����������С����������䱣��һ��
    if (Pos('����', CdsData.FieldByName('YWLX').AsString)>0)
      or (Pos('����', CdsData.FieldByName('YWLX').AsString)>0)
     then
    begin
      //���������ƺͿ�����
      CdsData.FieldByName('SKHDQ').AsString := ReadParams('CITY');
      CdsData.FieldByName('SDEPID').AsString := ReadParams('YHHB');
      CdsData.FieldByName('SDEPNAME').AsString := FDefaultBank;
      CdsData.FieldByName('SYHHH').AsString := FDefaultBankHH;
      CdsData.FieldByName('SYHMC').AsString := FDefaultBank;
    end;
    CdsData.FieldByName('FKFZH').AsString := TString.LeftStrBySp(ReadParams('FKR'));
    CdsData.FieldByName('FKFMC').AsString := TString.RightStrBySp(ReadParams('FKR'));
    CdsData.FieldByName('FYHZH').AsString := ReadParams('MRZH');
    CdsData.FieldByName('FZHMC').AsString := TString.RightStrBySp(ReadParams('FKR'));
    CdsData.FieldByName('FKHYH').AsString := TString.RightStrBySp(ReadParams('MRYH'));
    CdsData.FieldByName('FYHHB').AsString := TString.LeftStrBySp(ReadParams('YHHB'));
    CdsData.FieldByName('FKHDQ').AsString := ReadParams('CITY');
    CdsData.FieldByName('TCBZ').AsString := 'ͬ��';
    CdsData.FieldByName('YDJLX').AsString := 'EXCEL';
    CdsData.FieldByName('SKFMC').AsString :=  CdsData.FieldByName('SZHMC').AsString;
    //POpenSQL(DataModulePub.ClientDataSetTmp, 'select * from ebk_zfxx where ydjbh='''+CdsData.FieldByName('ydjbh').AsString+'''');
    //if DataModulePub.ClientDataSetTmp.FindFirst then begin
      //Memomx.Lines.Add('�Ѿ�����ԭʼ���ݺţ�'+CdsData.FieldByName('ydjbh').AsString);
    //end else
    begin
      Memomx.Lines.Add('������ˮ�ţ�'+szZfId);
      CdsData.Post;
      slSql := TStringList.Create;
      try
        slSql := GetSQLByDelta(CdsData, TblName, 'GSDM;KJND;YWLXDM;ZFID;');
        if slSql.Text <> '' then
        begin
          PExecSQL(slSql.Text);
          //PExecSQL('commit');
          if CdsData.LogChanges then
            CdsData.MergeChangeLog;
        end;
      finally
        slSql.Free;
      end;
      szZfId := getNewLSH(GszGSDM, GszKJND, getJSFSDM(ComboBoxYWLX.ItemIndex));
      //szZfId := FloatToStr(StrToFloat(szZfId)+1);
    end;
    tbl1.Next;
  end;
  //CdsData.ApplyUpdates(-1,  TblName);
  result := true;
end;

//ȡ����ֶ��б�

function TFrmEBKImportExcel.GetExcelinfo(sfname: string): boolean;
var
  I, j: integer;
  szcolname: string;
  tblist: TStringlist;

  ExcelApp: Variant;
  excelversion: single;
  ExcelDBstr: string;
  FileExt: string;
begin
  result := false;
  //���Excel�汾�����ݰ汾ȡ��Ӧ�������ַ���
  try
    ExcelApp := CreateOleObject('Excel.Application');
    excelversion := strtofloat(ExcelApp.Version);
    //if excelversion > 11.5 then
      //ExcelDBstr := ExcelDBstr2007
    //else
    begin
      FileExt := uppercase(ExtractFileExt(EditImportgzmxfn.Text));
      if FileExt = '.XLSX' then
      begin
        showmessage('�뽫�ļ�ת����Excel 2003��ʽ���ٵ��롣');
        result := false;
        exit;
      end;
      ExcelDBstr := ExcelDBstr2003;
    end;

    ExcelApp.quit;
    ExcelApp := NULL;
  except
    messagedlg('û�а�װExcel����', mterror, [mbok], 0);
    exit;
  end;

  con1.Connected := false;
  con1.ConnectionString := Format(ExcelDBstr, [EditImportgzmxfn.Text]);
  con1.Connected := true;
  tblist := TStringlist.Create;
  try
    con1.GetTableNames(tblist, false);
    if tblist.Count > 0 then
    begin
      tbl1.close;
      tbl1.TableName := tblist.Strings[0];
      tbl1.Open;
      for i:=0 to tbl1.FieldCount-1 do
      begin
        grd.Columns[2].PickList.Add(tbl1.Fields[i].FieldName);
        if FFldRls.Locate('name', tbl1.Fields[i].FieldName, []) then
        begin
          FFldRls.Edit;
          FFldRls.FieldByName('ExcelName').AsString := tbl1.Fields[i].FieldName;
          FFldRls.Post;
        end;
      end;
      result := true;
    end;
  finally
    tblist.free;
  end;
  tbl1.close;
  //���������ͬ�� �Զ�����ָ����
end;

procedure TFrmEBKImportExcel.btnmxExitClick(Sender: TObject);
begin
  close;
end;

procedure TFrmEBKImportExcel.InitFldsDef;
  procedure AddValue(AName, ATYPE, ADBName:String; ALength:integer; Dft:String=''; IsShow:Boolean=True);
  begin
    FFldCds.Append;
    FFldCds.FieldByName('Name').AsString := AName;
    FFldCds.FieldByName('TYPE').AsString := ATYPE;
    FFldCds.FieldByName('dbName').AsString := ADBName;
    FFldCds.FieldByName('Length').AsInteger := ALength;
    if ADBName = 'GSDM' then
    begin
      FFldCds.FieldByName('Default').AsString := GszGSDM;
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else if ADBName = 'KJND' then
    begin
      FFldCds.FieldByName('Default').AsString := GszKJND;
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else if ADBName = 'YWRQ' then
    begin
      FFldCds.FieldByName('Default').AsString := GszYWRQ;
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else if ADBName = 'YWQJ' then
    begin
      if GszKJQJ = '' then GszKJQJ := Copy(GszYWRQ,5,2);   // Added by guozy 2013/3/30 ������ 19:26:00
      FFldCds.FieldByName('Default').AsString := GszKJQJ;
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else if ADBName = 'YWLX' then
    begin
      //FFldCds.FieldByName('Default').AsString := 'ת��';
      FFldCds.FieldByName('Default').AsString :=  TString.RightStrBySp(ComboBoxYWLX.Text);
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else if ADBName = 'YWLXDM' then
    begin
      FFldCds.FieldByName('Default').AsString := TString.LeftStrBySp(ComboBoxYWLX.Text);
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else if ADBName = 'JKLXID' then
    begin
      //FFldCds.FieldByName('Default').AsString := getTypeCode(ComboBoxJKLX.ItemIndex);
      //ShowMessage(getTypeCode(ComboBoxJKLX.ItemIndex));
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else if ADBName='MODCODE' then
    begin
      FFldCds.FieldByName('Default').AsString := 'EXCEL';
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else if ADBName='MODNAME' then
    begin
      FFldCds.FieldByName('Default').AsString := 'Excel����';
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else
      FFldCds.FieldByName('Hide').AsString := IFF(IsShow, '0', '1');
      
    if Dft <> '' then
    begin
      FFldCds.FieldByName('Default').AsString := Dft;
      FFldCds.FieldByName('Hide').AsString := IFF(IsShow, '0', '1');   
    end;
    FFldCds.Post;
  end;
begin
  FFldCds := TClientDataSet.Create(Self);
  FFldCds.FieldDefs.Add('Name', ftString, 50);
  //c, n, i, d ����
  FFldCds.FieldDefs.Add('TYPE', ftString, 2);
  FFldCds.FieldDefs.Add('dbName', ftString, 50);
  FFldCds.FieldDefs.Add('Length', ftInteger);
  FFldCds.FieldDefs.Add('Default', ftString,50);
  FFldCds.FieldDefs.Add('Hide', ftString, 1);
  FFldCds.CreateDataSet;

  AddValue('��λ����', 'C', 'GSDM', 20);
  AddValue('������', 'C', 'KJND', 4);
  AddValue('ҵ���ڼ�', 'C', 'YWQJ', 6);
  AddValue('ҵ������', 'C', 'YWRQ', 8);
  AddValue('ҵ������', 'C', 'YWLX', 100);
  AddValue('ҵ�����ʹ���', 'C', 'YWLXDM', 20);
  AddValue('��Դģ�����', 'C', 'MODCODE', 20);
  AddValue('��Դģ������', 'C', 'MODNAME', 100);
  AddValue('�˻�����', 'C', 'SZHMC', 100);
  AddValue('�����˺�', 'C', 'SYHZH', 100);
  AddValue('ժҪ', 'C', 'ZY', 200);
  AddValue('���л���', 'C', 'SDEPID', 100);
  AddValue('��������', 'C', 'SKHYH', 100);
  AddValue('���к�', 'C', 'SYHHH', 100);
  AddValue('���', 'N', 'JE', 20);
  AddValue('���ID1', 'C', 'SHID1', 10, '-1', False);
  AddValue('���ID2', 'C', 'SHID2', 10, '-1', False);
  AddValue('����״̬', 'C', 'DJZT', 10, '0', False);
  AddValue('¼��ID', 'C', 'LRID', 10, IntToStr(GCZY.ID), False);
  AddValue('¼����', 'C', 'LRR', 10, GCZY.Name, False);
  AddValue('¼��ʱ��', 'C', 'LRSJ', 10, FormatDateTime('YYYY-MM-DD HH:NN:SS', Now), False);
  //
  FFldRls := TClientDataSet.Create(Self);
  FFldRls.FieldDefs.Add('Name', ftString, 50);
  FFldRls.FieldDefs.Add('dbName', ftString, 50);
  FFldRls.FieldDefs.Add('TYPE', ftString, 50);
  FFldRls.FieldDefs.Add('ExcelName', ftString, 50);
  FFldRls.CreateDataSet;
  FFldCds.First;
  while not FFldCds.eof do
  begin
    if FFldCds.FieldByName('Hide').AsString = '1' then
    begin
      FFldCds.Next;
      Continue;
    end;
    FFldRls.Append;
    FFldRls.FieldByName('Name').AsString := FFldCds.FieldByName('Name').AsString;
    FFldRls.FieldByName('DbName').AsString := FFldCds.FieldByName('dbName').AsString;
    FFldRls.FieldByName('TYPE').AsString := FFldCds.FieldByName('TYPE').AsString;
    FFldCds.Next;
  end;
  dsRls.DataSet := FFldRls;
end;

procedure TFrmEBKImportExcel.FormShow(Sender: TObject);
begin
  //��ϸҳ����
  PageControlmx.Pages[0].TabVisible := false;
  PageControlmx.Pages[1].TabVisible := false;
  PageControlmx.Pages[2].TabVisible := false;
  PageControlmx.Pages[3].TabVisible := false;
  PageControlmx.ActivePageIndex := 0;
  blImport := false;
end;

procedure TFrmEBKImportExcel.btnSaveClick(Sender: TObject);
begin
  if sd.Execute then
  begin
    if Pos('.', sd.FileName)<=0 then
      sd.FileName := sd.FileName + '.xml';
    FFldRls.SaveToFile(sd.FileName);
  end;
end;

procedure TFrmEBKImportExcel.btnOpenClick(Sender: TObject);
begin
  if OD.Execute then
  begin
    FFldRls.LoadFromFile(OD.FileName);
  end;
end;

procedure TFrmEBKImportExcel.ComboBoxYWLXChange(Sender: TObject);
begin
  InitFldsDef;
  //���ѡ����ת�ˣ� ��;���Բ���ѡ��
  //����Ǵ����� ��Ҫѡ����;
  //����Ǵ��ۣ� Ҳ��Ҫѡ����;
  if TString.RightStrBySp(ComboBoxYWLX.Text) = '����' then
  begin
    cmbUseage.Items.Clear;
    cmbUseage.Items.Add('00000008 ����');
    cmbUseage.Items.Add('00000009 ����');
    cmbUseage.Items.Add('00000006 ����');
    cmbUseage.Items.Add('00000007 ���÷�');
    cmbUseage.Items.Add('0000061 ����');
    cmbUseage.Items.Add('0000065 ����');
  end
  else if TString.RightStrBySp(ComboBoxYWLX.Text) = '����' then
  begin
    cmbUseage.Items.Clear;
    cmbUseage.Items.Add('00000082 ����ѧ��');
    cmbUseage.Items.Add('0000053 ����');
  end
  else
    cmbUseage.Items.Clear;
end;

end.

