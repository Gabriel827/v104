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
    GzCount: integer; //导入条数
    procedure ChangeStepMX(nextstep: boolean);
    function ImPortExcelBeforeCheck(fname: string): boolean;
    function ImPortFromExcel(fname: string): Boolean;
    function GetExcelinfo(sfname: string): boolean;
    //设置字段以及字段类型
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

//明细导入步骤处理过程

procedure TFrmEBKImportExcel.ChangeStepMX(nextstep: boolean);
var
  currentPage, nextpage, i: integer;
  Execstep, checkworksheet: boolean;
  szfname, sztargetfname, szexcelfname: string;
begin
  if ComboBoxYWLX.ItemIndex = -1 then begin
    messagedlg('必须指定结算方式！',
      mtinformation, [mbok], 0);
    ComboBoxYWLX.SetFocus;
    exit;
  end;
  {if ComboBoxJKLX.ItemIndex = -1 then begin
    messagedlg('必须指定业务类型！',
      mtinformation, [mbok], 0);
    ComboBoxJKLX.SetFocus;
    exit;
  end; }
  if (TString.RightStrBySp(ComboBoxYWLX.Text) = '代扣')
    or (TString.RightStrBySp(ComboBoxYWLX.Text) = '代发') then
  begin
    if cmbUseage.ItemIndex  < 0 then
    begin
      Application.MessageBox('请选择用途！',  '系统提示', MB_ICONWarning + MB_OK);
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
            messagedlg('指定的Excel文件 ' + szfname + ' 不存在！',
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
            messagedlg('指定的Excel文件 ' + szfname + ' 不存在！',
              mtinformation, [mbok], 0);
            Execstep := false;
            exit;
          end;
          BtnmxNext.Enabled := false;
          PageControlmx.Pages[currentPage].Enabled := false;
          PageControlmx.Pages[nextpage].Enabled := true;
          PageControlmx.ActivePageIndex := nextpage;
          messagedlg('开始数据正确性检查，如果导入文件处于打开状态，请关闭！', mtinformation, [mbok], 0);
          if ImPortExcelBeforeCheck(szfname) = false then //数据正确性检查未通过时不能导入
          begin
            BtnmxNext.Enabled := false;
            messagedlg('数据正确性检查未通过，请修改后再试！',
              mtinformation, [mbok], 0);
            exit;
          end
          else
          begin
            Memojcjg.Lines.Add('数据正确性检查通过，可以导入！');
            Execstep := true;
          end;
        end;
      2:
        begin
          if messagedlg('确认要开始导入吗？', mtConfirmation, [mbyes,
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
                //将已导入的文件名标记为已导入
                Memomx.Lines.Add('导入成功!');
                Memomx.Lines.Add('已经将符合条件的数据导入!');
                Memomx.Lines.Add('该次导入一共' + Inttostr(GzCount) + '条数据');
                blImport := true;
                if FileExists(szfname) then
                  RenameFile(szfname, extractfilepath(szfname) + '[' + DateToStr(Date) + '_已导入]' +
                    extractfilename(szfname));
              end
              else
              begin
                Memomx.lines.add('导入失败.');
                Execstep := false;
              end;
            except
              on E: Exception do
              begin
                Memomx.lines.add('导入失败，错误信息如下：');
                Memomx.lines.add(e.message);
                messagedlg('导入失败,请确保:'
                  + #13 + 'Excel文件没有被其它程序使用;Excel文件数据格式规范;字段对应设置正确', mtinformation,
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
  Memojcjg.Lines.Add('正在检查，请稍等！');
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
            //字段类型判断
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
                Memojcjg.lines.add('第' + IntToStr(Tbl1.RecNo + 1) +'行，列"'+tbl1.Fields[i].FieldName
                  +'"，'+tbl1.Fields[i].AsString+'不是数值类型！');
              end;
            end;
            //字段长度判断
            if FFldCds.FieldByName('type').AsString='C' then
            begin
              if Length(tbl1.Fields[i].AsString)> FFldCds.FieldByName('Length').AsInteger then
              begin
                Result := False;
                Memojcjg.lines.add('第' + IntToStr(Tbl1.RecNo + 1) +'行，列"'+tbl1.Fields[i].FieldName
                  +'"，'+tbl1.Fields[i].AsString+'长度超过了限制，'+FFldCds.FieldByName('Length').AsString+'！');
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
        + ' and ywlx = ''转账''');
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
  //字段关系确定， 添加到数据集合中
  POpenSQL(cdsData, 'Select * from '+TblName+' where 1=0');
  tbl1.Open;
  if (tbl1.IsEmpty) or (not tbl1.FindFirst) then begin
    ShowMessage('没有数据可以被导入！');
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
      //FFldRls是界面上列表数据集
      if FFldRls.Locate('dbName', cdsData.Fields[i].FieldName, []) then begin
        if FFldRls.FieldByName('ExcelName').AsString <> '' then
        begin
          CdsData.Fields[i].AsString :=  tbl1.FieldByName(FFldRls.FieldByName('ExcelName').AsString).AsString;
        end
      end
      else
      begin
        //FFldCds是各字段的类型缺省值的临时数据集
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
    //如果是银行代发协议的， 必须开户地区、银行、开户行与其保持一致
    if (Pos('代发', CdsData.FieldByName('YWLX').AsString)>0)
      or (Pos('代扣', CdsData.FieldByName('YWLX').AsString)>0)
     then
    begin
      //开户行名称和开户行
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
    CdsData.FieldByName('TCBZ').AsString := '同城';
    CdsData.FieldByName('YDJLX').AsString := 'EXCEL';
    CdsData.FieldByName('SKFMC').AsString :=  CdsData.FieldByName('SZHMC').AsString;
    //POpenSQL(DataModulePub.ClientDataSetTmp, 'select * from ebk_zfxx where ydjbh='''+CdsData.FieldByName('ydjbh').AsString+'''');
    //if DataModulePub.ClientDataSetTmp.FindFirst then begin
      //Memomx.Lines.Add('已经存在原始单据号：'+CdsData.FieldByName('ydjbh').AsString);
    //end else
    begin
      Memomx.Lines.Add('导入流水号：'+szZfId);
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

//取表的字段列表

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
  //检查Excel版本，根据版本取相应的连接字符串
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
        showmessage('请将文件转换成Excel 2003格式后再导入。');
        result := false;
        exit;
      end;
      ExcelDBstr := ExcelDBstr2003;
    end;

    ExcelApp.quit;
    ExcelApp := NULL;
  except
    messagedlg('没有安装Excel程序！', mterror, [mbok], 0);
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
  //如果名称相同， 自动进行指定。
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
      if GszKJQJ = '' then GszKJQJ := Copy(GszYWRQ,5,2);   // Added by guozy 2013/3/30 星期六 19:26:00
      FFldCds.FieldByName('Default').AsString := GszKJQJ;
      FFldCds.FieldByName('Hide').AsString := '1';
    end
    else if ADBName = 'YWLX' then
    begin
      //FFldCds.FieldByName('Default').AsString := '转账';
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
      FFldCds.FieldByName('Default').AsString := 'Excel数据';
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
  //c, n, i, d 类型
  FFldCds.FieldDefs.Add('TYPE', ftString, 2);
  FFldCds.FieldDefs.Add('dbName', ftString, 50);
  FFldCds.FieldDefs.Add('Length', ftInteger);
  FFldCds.FieldDefs.Add('Default', ftString,50);
  FFldCds.FieldDefs.Add('Hide', ftString, 1);
  FFldCds.CreateDataSet;

  AddValue('单位代码', 'C', 'GSDM', 20);
  AddValue('会计年度', 'C', 'KJND', 4);
  AddValue('业务期间', 'C', 'YWQJ', 6);
  AddValue('业务日期', 'C', 'YWRQ', 8);
  AddValue('业务类型', 'C', 'YWLX', 100);
  AddValue('业务类型代码', 'C', 'YWLXDM', 20);
  AddValue('来源模块代码', 'C', 'MODCODE', 20);
  AddValue('来源模块名称', 'C', 'MODNAME', 100);
  AddValue('账户名称', 'C', 'SZHMC', 100);
  AddValue('银行账号', 'C', 'SYHZH', 100);
  AddValue('摘要', 'C', 'ZY', 200);
  AddValue('银行机构', 'C', 'SDEPID', 100);
  AddValue('开户银行', 'C', 'SKHYH', 100);
  AddValue('联行号', 'C', 'SYHHH', 100);
  AddValue('金额', 'N', 'JE', 20);
  AddValue('审核ID1', 'C', 'SHID1', 10, '-1', False);
  AddValue('审核ID2', 'C', 'SHID2', 10, '-1', False);
  AddValue('单据状态', 'C', 'DJZT', 10, '0', False);
  AddValue('录入ID', 'C', 'LRID', 10, IntToStr(GCZY.ID), False);
  AddValue('录入人', 'C', 'LRR', 10, GCZY.Name, False);
  AddValue('录入时间', 'C', 'LRSJ', 10, FormatDateTime('YYYY-MM-DD HH:NN:SS', Now), False);
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
  //明细页设置
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
  //如果选择了转账， 用途可以不用选择，
  //如果是代发， 需要选择用途
  //如果是代扣， 也需要选择用途
  if TString.RightStrBySp(ComboBoxYWLX.Text) = '代发' then
  begin
    cmbUseage.Items.Clear;
    cmbUseage.Items.Add('00000008 工资');
    cmbUseage.Items.Add('00000009 奖金');
    cmbUseage.Items.Add('00000006 报销');
    cmbUseage.Items.Add('00000007 差旅费');
    cmbUseage.Items.Add('0000061 津贴');
    cmbUseage.Items.Add('0000065 补贴');
  end
  else if TString.RightStrBySp(ComboBoxYWLX.Text) = '代扣' then
  begin
    cmbUseage.Items.Clear;
    cmbUseage.Items.Add('00000082 代收学费');
    cmbUseage.Items.Add('0000053 其它');
  end
  else
    cmbUseage.Items.Clear;
end;

end.

