{

}
unit uEBK_IMPOERPA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ToolEdit, CurrEdit, Db, DBClient, Spin,
  LggExchanger, Placemnt, ExtCtrls, Grids, DBGridEh, SMaskEdit;

type
  TImpOER_EBKFrmPA = class(TForm)
    fs: TFormStorage;
    Panel1: TPanel;
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    cbFFCS: TComboBox;
    Label3: TLabel;
    btnSearch: TBitBtn;
    Label1: TLabel;
    grd: TDBGridEh;
    cbAll: TCheckBox;
    dsData: TDataSource;
    cdsData: TClientDataSet;
    cdsZFXX: TClientDataSet;
    cdsYHXX: TClientDataSet;
    ClientDataSetTmp: TClientDataSet;
    cbGZLB: TComboBox;
    Label7: TLabel;
    cbGZXM: TComboBox;
    Label2: TLabel;
    cbYH: TComboBox;
    Label23: TLabel;
    ComboBoxYWLX: TComboBox;
    edtPZH: TSMaskEdit;
    Label4: TLabel;
    Bevel1: TBevel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure cbAllClick(Sender: TObject);
    procedure grdDblClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnOkClick(Sender: TObject);
    procedure edtPZHButtonClick(Sender: TObject);
    procedure edtPZHKeyPress(Sender: TObject; var Key: Char);
  Private
    FIsImport: Boolean;
    FGZXM: TClientDataSet;
    FYHZL: TClientDataSet;
    { Private declarations }
    procedure Init;
    function GetNewID: string;
    procedure SetIsImport(const Value: Boolean);
    procedure GetYhInfo(bz, DM: string; var YHZH, KHH, YHHH: string);
    procedure GetYhMC(AName: string; var YHHH, YHMC: string);
  Public
    { Public declarations }
    property IsImport: Boolean Read FIsImport Write SetIsImport;
  end;

var
  ImpOER_EBKFrmPA: TImpOER_EBKFrmPA;
procedure LoadImpPA;

implementation

uses DataModuleMain, Pub_Global, Pub_Function, Pub_Message, Pub_WYZF,
  uSelectFromData;

{$R *.DFM}

procedure LoadImpPA;
begin
  //����������
  ImpOER_EBKFrmPA := TImpOER_EBKFrmPA.Create(nil);
  try
    ImpOER_EBKFrmPA.ShowModal;
  finally
    ImpOER_EBKFrmPA.Free;
  end;
end;

procedure TImpOER_EBKFrmPA.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TImpOER_EBKFrmPA.FormCreate(Sender: TObject);
var
  sSql: string;
begin
  PSetClientDataSetProvider(Self);
  Init;
  grd.FixedColor := Self.Color;
  sSql := 'select t.* from zb_jsfs t where t.wyzf=''1'' and t.gsdm=''' + GszGSDM + ''' and t.kjnd=''' + GszKJND + '''';
  POpenSQL(ClientDataSetTmp, sSql);
  ComboBoxYWLX.Clear;
  while not ClientDataSetTmp.eof do
  begin
    ComboBoxYWLX.Items.Add(ClientDataSetTmp.FieldByName('jsfsdm').AsString + ' '
      + ClientDataSetTmp.FieldByName('jsfsmc').AsString);
    ClientDataSetTmp.next;
  end;
end;

procedure TImpOER_EBKFrmPA.Init;
var
  SQLTxt: string;
begin
  //��ʼ����������
  //cbGZLB
  SQLTxt := 'Select lbdm, lbmc from gz_gzlb where GSDM=' + QuotedStr(GszGSDM);
  with DataModulePub.GetCdsBySQL(SQLTxt) do
  begin
    cbGZLB.Clear;
    cbGZLB.Items.add('ȫ��');
    while not eof do
    begin
      cbGZLB.Items.Add(FieldByName('lbdm').AsString + ' ' + FieldByName('lbmc').AsString);
      Next;
    end;
    Free;
  end;
  cbGZLB.ItemIndex := 0;
  SQLTxt := 'Select distinct ffcs from gz_gz where GSDM=' + QuotedStr(GszGSDM)
    + ' and havesh=1 and FFND=' + QuotedStr(GszKJND) + ' Order by ffcs';
  with DataModulePub.GetCdsBySQL(SQLTxt) do
  begin
    cbFFCS.Clear;
    while not eof do
    begin
      cbFFCS.Items.Add(FieldByName('ffcs').AsString);
      Next;
    end;
    Free;
  end;
  cbFFCS.ItemIndex := cbFFCS.Items.Count - 1;
  SQLTxt := ' Select gzdm, name, FieldName from gz_ysgzx where FIELDTYPE=''N'''
    + ' and ENABLED=''1'' and gsdm=''' + GszGSDM + '''';
  FGZXM := DataModulePub.GetCdsBySQL(SQLTxt);
  with FGZXM do
  begin
    cbGZXM.Clear;
    while not eof do
    begin
      cbGZXM.Items.Add(FieldByName('gzdm').AsString + ' ' + FieldByName('name').AsString);
      Next;
    end;
  end;
  cbGZXM.ItemIndex := cbGZXM.Items.IndexOf(fs.ReadString('GZXM', ''));
  SQLTxt := 'Select  YHDM, YHMC, YHHH from zb_yhzl where GSDM=' + QuotedStr(GszGSDM) + ' and KJND=' +
    QuotedStr(GszKJND);
  FYHZL := DataModulePub.GetCdsBySQL(SQLTxt);
  with FYHZL do
  begin
    cbYH.Clear;
    while not eof do
    begin
      cbYH.Items.Add(FieldByName('YHDM').AsString + ' ' + FieldByName('YHMC').AsString);
      Next;
    end;
  end;
  if cbYH.Items.Count > 0 then
    cbYH.ItemIndex := 0;
end;

procedure TImpOER_EBKFrmPA.btnSearchClick(Sender: TObject);
var
  SQLTxt: string;
  GZXM: string;
begin
  if cbGZXM.ItemIndex < 0 then
  begin
    Application.MessageBox('��ѡ������Ŀ��', 'ϵͳ��ʾ', MB_ICONWarning + MB_OK);
    Exit;
  end;
  if cbFFCS.ItemIndex < 0 then
  begin
    Application.MessageBox('���Ŵ���������Ϊ�գ�', 'ϵͳ��ʾ', MB_ICONWarning + MB_OK);
    Exit;
  end;
  FGZXM.Locate('gzdm', TString.LeftStrBySp(cbGZXM.Text), []);
  SQLTxt := 'Select 1 as SEL, FFCS, FFDATE, ZYDM, ZYXM, BMDM, BMMC, YHDM, GRZH, '
    + FGZXM.FieldByName('FieldName').AsString + ' as FFJE'
    + '  from gz_gz where 1=1 ' + IFF(cbGZLB.ItemIndex = 0, '', 'and  LBDM=' +
      QuotedStr(TString.LeftStrBySp(cbGZLB.Text)))
    + ' and GSDM=' + QuotedStr(GszGSDM) + ' and FFND=' + QuotedStr(GszKJND)
    + ' and FFCS=' + cbFFCS.Text
    + IFF(cbYH.Text = '', '', ' and YHDM=' + QuotedStr(TString.LeftStrBySp(cbYH.Text)));
  //+' and not Exists(Select 1 from EBK_ZFXX where DJZT>=0 and MODCODE=''OER'' and DJBH=YDJBH and YDJLX=DJLXID) ';
  POpenSQL(cdsData, SQLTxt);
  BitBtnOk.Enabled := True;
end;

procedure TImpOER_EBKFrmPA.cbAllClick(Sender: TObject);
begin
  if not cdsData.Active then
    Exit;
  cdsData.First;
  while not cdsData.eof do
  begin
    cdsData.Edit;
    cdsData.FieldByName('SEL').AsString := IFF(cbAll.Checked, '1', '0');
    cdsData.Next;
  end;
end;

procedure TImpOER_EBKFrmPA.grdDblClick(Sender: TObject);
begin
  if not cdsData.Active then
    Exit;
  cdsData.Edit;
  cdsData.FieldByName('SEL').AsString := IFF(cdsData.FieldByName('SEL').AsString = '1', '0', '1');
  cdsData.Post;
end;

procedure TImpOER_EBKFrmPA.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TImpOER_EBKFrmPA.BitBtnOkClick(Sender: TObject);
var
  szZfId: string;
  szSKYhzh, szKHYH, szYHHH, GROUPID: string;
  slSql: TStrings;
begin
  //����������������
  if edtPZH.Hint = '' then
  begin
    Application.MessageBox('��ѡ��ƾ֤��', 'ϵͳ��ʾ', MB_ICONWarning+MB_OK);
    Exit;  
  end;
  if ComboBoxYWLX.Text='' then
  begin
    Application.MessageBox('��ѡ��֧����ʽ��', 'ϵͳ��ʾ', MB_ICONWarning+MB_OK);
    Exit;  
  end;
  GROUPID := GetGuid;
  cdsZFXX.Close;
  POpenSQL(cdsZFXX, 'Select * from EBK_ZFXX where 1=0');
  cdsData.DisableControls;
  try
    cdsData.Filter := 'SEL=''1''';
    cdsData.Filtered := True;
    szZfId := getNewLSH(GszGSDM, GszKJND, '01'); // GetNewID;
    with cdsZFXX do
      while not cdsData.Eof do
      begin
        Append;
        FieldByName('GSDM').AsString := GszGSDM;
        FieldByName('KJND').AsString := GszKJND;
        FieldByName('GROUPID').AsString := GROUPID;
        FieldByName('YWQJ').AsString := Copy(FormatDateTime('YYYYMMDD', DATE), 5, 2);
        FieldByName('YWRQ').AsString := FormatDateTime('YYYYMMDD', DATE);

        FieldByName('YWLXDM').AsString := TString.LeftStrBySp(ComboBoxYWLX.Text);
        FieldByName('YWLX').AsString := TString.RightStrBySp(ComboBoxYWLX.Text);

        FieldByName('ZFID').AsString := szZfId;
        FieldByName('MODCODE').AsString := 'PA';
        FieldByName('MODNAME').AsString := '����';

        FieldByName('FKFZH').AsString := TString.LeftStrBySp(ReadParams('FKR'));
        FieldByName('FKFMC').AsString := TString.RightStrBySp(ReadParams('FKR'));
        FieldByName('FYHZH').AsString := ReadParams('MRZH');
        FieldByName('FZHMC').AsString := TString.LeftStrBySp(ReadParams('FKR'));
        FieldByName('FKHYH').AsString := ReadParams('MRYH');
        FieldByName('JE').AsFloat := cdsData.FieldByName('FFJE').AsFloat;
        FieldByName('SKFZH').AsString := cdsData.FieldByName('ZYDM').AsString;
        FieldByName('SKFMC').AsString := cdsData.FieldByName('ZYXM').AsString;

        FieldByName('SZHMC').AsString := cdsData.FieldByName('ZYXM').AsString;
        FieldByName('SYHZH').AsString := cdsData.FieldByName('GRZH').AsString;

        //�����������ƣ�ȡ�������к�
        FYHZL.Locate('YHDM', cdsData.FieldByName('YHDM').AsString, []);
        FieldByName('SYHHH').AsString := FYHZL.FieldByName('YHHH').AsString;
        FieldByName('SKHYH').AsString := FYHZL.FieldByName('YHMC').AsString;
        FieldByName('SYHMC').AsString := FYHZL.FieldByName('YHMC').AsString;
        FieldByName('SKHDQ').AsString := '';
        FieldByName('SYHWD').AsString := '';
        FieldByName('ZY').AsString := '����' + cbFFCS.Text + '��' + TString.RightStrBySp(cbGZXM.Text);
        FieldByName('TCBZ').AsString := 'ͬ��';
        FieldByName('LRID').AsString := IntToStr(GCZY.ID);
        FieldByName('LRR').AsString := GCZY.Name;
        FieldByName('LRSJ').AsString := FormatDateTime('YYYY-MM-DD HH:NN:SS', Now);
        FieldByName('DJZT').AsInteger := 0;
        FieldByName('SHID1').AsInteger := -1;
        FieldByName('SHID2').AsInteger := -1;
        FieldByName('YDJLX').AsString := '1';
        FieldByName('YDJBH').AsString := edtPZH.Hint;
        Post;
        cdsData.Next;
        szZfId := FloatToStr(StrToFloat(szZfId) + 1);
      end;
  finally
    cdsData.EnableControls;
  end;
  slSql := TStringList.Create;
  try
    slSql := GetSQLByDelta(cdsZFXX, 'EBK_ZFXX', 'GSDM;KJND;YWLXDM;ZFID;');
    if slSql.Text <> '' then
    begin
      PExecSQL(slSql.Text);
      if cdsZFXX.LogChanges then
        cdsZFXX.MergeChangeLog;
    end;
  finally
    slSql.Free;
  end;
  FIsImport := True;
  fs.WriteString('GZXM', cbGZXM.Text);
  cdsData.Filtered := false;
  cdsData.Filter := '';
  btnSearchClick(nil);
  Application.MessageBox('����ɹ���', 'ϵͳ��ʾ', MB_ICONWarning + MB_OK);
  BitBtnOk.Enabled := False;
end;

procedure TImpOER_EBKFrmPA.SetIsImport(const Value: Boolean);
begin
  FIsImport := Value;
end;

function TImpOER_EBKFrmPA.GetNewID: string;
var
  szZfId: string;
begin
  with ClientDataSetTmp do
  begin
    POpenSql(ClientDataSetTmp, 'select max(Zfid) as maxid from EBK_ZFXX where gsdm = ''' + GszGSDM + ''''
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

procedure TImpOER_EBKFrmPA.GetYhInfo(bz, DM: string; var YHZH, KHH, YHHH: string);
var
  szSQL: string;
begin
  if bz = 'GR' then
    szSQL := 'Select DFYH, GRZH, ZL.YHMC, ZL.YHHH from PUBZYXX ZY left join ZB_YHZL ZL on ZY.GSDM=ZL.GSDM and ZY.KJND=ZL.KJND '
      + ' and ZL.YHDM=ZY.DFYH  where ZY.GSDM=' + QuotedStr(GszGSDM)
      + ' and ZY.KJND=' + QuotedStr(GszKJND) + ' and ZY.ZYDM=' + QuotedStr(DM);
  with DataModulePub.GetCdsBySQL(szSQL) do
  begin
    if not eof then
    begin
      YHZH := FieldByName('GRZH').AsString;
      KHH := FieldByName('YHMC').AsString;
      YHHH := FieldByName('YHHH').AsString;
    end;
    Free;
  end;
end;

procedure TImpOER_EBKFrmPA.GetYhMC(AName: string; var YHHH, YHMC: string);
var
  szSQL: string;
begin
  //
  if AName = '' then
    Exit;
  if (Pos('��������', AName) > 0)
    or (Pos('����', AName) > 0)
    or (Pos('����', AName) > 0) then
  begin
    YHMC := '�й���������';
  end
  else if (Pos('ũҵ����', AName) > 0) or
    (Pos('ũ��', AName) > 0) then
  begin
    YHMC := '�й�ũҵ���йɷ����޹�˾';
  end
  else if (Pos('�й�����', AName) > 0) then
  begin
    YHMC := '�й���������';
  end
  else if (Pos('��������', AName) > 0) or
    (Pos('����', AName) > 0) then
  begin
    YHMC := '�й��������йɷ����޹�˾����';
  end
  else if (Pos('��ͨ����', AName) > 0) or
    (Pos('����', AName) > 0) then
  begin
    YHMC := '��ͨ����';
  end
  else if (Pos('��������', AName) > 0) then
  begin
    YHMC := '�������йɷ����޹�˾';
  end
  else if (Pos('�������', AName) > 0) then
  begin
    YHMC := '�й��������';
  end
  else if (Pos('��������', AName) > 0) then
  begin
    YHMC := '�й���������';
  end
  else if (Pos('�㷢����', AName) > 0) then
  begin
    YHMC := '�㷢���йɷ����޹�˾';
  end
  else if (Pos('��������', AName) > 0) or
    (Pos('����', AName) > 0) then
  begin
    YHMC := '�������йɷ����޹�˾';
  end
  else
    YHMC := Copy(AName, 1, 8);

  szSQL := 'Select * from EBK_BANKINFO where BANK_NAME like ' + QuotedStr('%' + YHMC + '%');
  ;
  with DataModulePub.GetCdsBySQL(szSQL) do
  begin
    if RecordCount = 1 then
    begin
      YHHH := FieldByName('BANK_CODE').AsString;
      YHMC := FieldByName('BANK_NAME').AsString;
    end;
    Free;
  end;
end;

procedure TImpOER_EBKFrmPA.edtPZHButtonClick(Sender: TObject);
var
  IDPZH: string;
  vCds: TClientDataSet;
  Select: Variant;
begin
  //
  vCds := DataModulePub.GetCdsBySQL('Select PZH, KJQJ, PZZY, IDPZH from GL_PZML where GSDM=' + QuotedStr(GszGSDM)
    + ' and KJQJ like ' + QuotedStr(GszKJND + '%'));
  Select := SelectLstGrd(vCds.Data, 'PZH,KJQJ,PZZY', False, '�ڼ�');
  if VarIsArray(Select) then
  begin
    if vCds.Locate('PZH;KJQJ',  VarArrayOf([Select[0][0] , Select[0][1]]), []) then
    begin
      edtPZH.Text := vCds.FieldByName('KJQJ').AsString+'|'+vCds.FieldByName('PZH').AsString
        +'|'+vCds.FieldByName('PZZY').AsString;
      edtPZH.Hint := vCds.FieldByName('IDPZH').AsString;
    end;
  end;
end;

procedure TImpOER_EBKFrmPA.edtPZHKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

end.

