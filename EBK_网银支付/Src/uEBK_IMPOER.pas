{
     
}
unit uEBK_IMPOER;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ToolEdit, CurrEdit, Db, DBClient, Spin,
  LggExchanger, Placemnt, ExtCtrls, Grids, DBGridEh;

type
  TImpOER_EBKFrm = class(TForm)
    fs: TFormStorage;
    Panel1: TPanel;
    cmbDJLX: TComboBox;
    BitBtnOk: TBitBtn;
    BitBtnCancel: TBitBtn;
    Label2: TLabel;
    ComboBoxYWLX: TComboBox;
    Label3: TLabel;
    btnSearch: TBitBtn;
    dtStart: TDateTimePicker;
    Label1: TLabel;
    dtEnd: TDateTimePicker;
    Label4: TLabel;
    grd: TDBGridEh;
    cbAll: TCheckBox;
    dsData: TDataSource;
    cdsData: TClientDataSet;
    cdsZFXX: TClientDataSet;
    cdsYHXX: TClientDataSet;
    ClientDataSetTmp: TClientDataSet;
    Label27: TLabel;
    ComboBoxJKLX: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure cbAllClick(Sender: TObject);
    procedure grdDblClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnOkClick(Sender: TObject);
  private
    FIsImport: Boolean;
    { Private declarations }
    procedure Init;
    function GetNewID:String;
    procedure SetIsImport(const Value: Boolean);
    procedure GetYhInfo(bz, DM:String; var YHZH, KHH, YHHH:String);
    procedure GetYhMC(AName:String; var YHHH, YHMC:String);
  public
    { Public declarations }
    property IsImport:Boolean read FIsImport write SetIsImport;
  end;

var
  ImpOER_EBKFrm: TImpOER_EBKFrm;
  procedure LoadImpOER;

implementation

uses DataModuleMain, Pub_Global, Pub_Function, Pub_Message, Pub_WYZF;

{$R *.DFM}

procedure LoadImpOER;
begin
  //����������
  ImpOER_EBKFrm:=TImpOER_EBKFrm.Create(nil);
  try
    ImpOER_EBKFrm.ShowModal;
  finally
    ImpOER_EBKFrm.Free;
  end;
end;

procedure TImpOER_EBKFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TImpOER_EBKFrm.FormCreate(Sender: TObject);
begin
  PSetClientDataSetProvider(Self);
  Init;
  grd.FixedColor := Self.Color;
  InitJSFS;
  ComboBoxYWLX.Items.CommaText := GszJSFSMC;
  InitTypeCodeAndName(ComboBoxJKLX);
end;

procedure TImpOER_EBKFrm.Init;
var
  SQLTxt:String;
begin
  //��ʼ����������
  SQLTxt := 'Select DJLXID, DJLXMC from OER_DJLX where SYZT=2 and GSDM='+QuotedStr(GszGSDM)
    +' and KJND='+QuotedStr(GszKJND);
  with DataModulePub.GetCdsBySQL(SQLTxt) do
  begin
    cmbDJLX.Clear;
    cmbDJLX.Items.add('ȫ��');
    while not eof do
    begin
      cmbDJLX.Items.Add(FieldByName('DJLXID').AsString+' '+FieldByName('DJLXMC').AsString);
      Next;
    end;
    Free;
  end;
  cmbDJLX.ItemIndex := 0;
  //SQLTxt := 'Select  JSFSDM, JSFSMC from ZB_JSFS where XJBZ=0 and GSDM='+QuotedStr(GszGSDM)
    //+' and KJND='+QuotedStr(GszKJND);
  {SQLTxt := 'Select  JSFSDM, JSFSMC from ZB_JSFS where wyzf=''1'' and GSDM='+QuotedStr(GszGSDM)
    +' and KJND='+QuotedStr(GszKJND);
  with DataModulePub.GetCdsBySQL(SQLTxt) do
  begin
    cmbJSFS.Clear;
    while not eof do
    begin
      if FieldByName('JSFSMC').AsString = 'ת��' then
        cmbJSFS.Text := FieldByName('JSFSDM').AsString+' '+FieldByName('JSFSMC').AsString;
      cmbJSFS.Items.Add(FieldByName('JSFSDM').AsString+' '+FieldByName('JSFSMC').AsString);
      Next;
    end;
    Free;
  end; }
  SQLTxt := 'Select * from pubszdwzh where gsdm=''' + GszGSDM + ''''
        + ' and kjnd = ''' + GszKJND + '''';
  POpenSQL(cdsYHXX, SQLTxt);
  dtStart.Date := Date;
  dtEnd.Date := Date;
end;

procedure TImpOER_EBKFrm.btnSearchClick(Sender: TObject);
var
  SQLTxt:String;
begin
  if ComboBoxYWLX.ItemIndex = -1 then begin
    ShowMessage('����ѡ����㷽ʽ��');
    ComboBoxYWLX.SetFocus;
    exit;
  end;
  if ComboBoxJKLX.ItemIndex = -1 then begin
    ShowMessage('����ѡ��ҵ�����ͣ�');
    ComboBoxJKLX.SetFocus;
    exit;
  end;
  SQLTxt := ' Select 0 as SEL, DJLXID, DJBH, DJDate, JE, ZY, BMDM,  BMMC, GRDM, GRMC, XMDM, XMMC, CRerMC, SKR, YHZH, KHYH from OER_DJML'
    +' where '+IFF(cmbDJLX.ItemIndex=0, '', 'DJLXID='+QuotedStr(TString.LeftStrBySp(cmbDJLX.Text))+' and ')
    //+' JSFS like '+QuotedStr(TString.LeftStrBySp(cmbJSFS.Text)+'%')
    +' JSFS like '+QuotedStr(getJSFSDM(ComboBoxYWLX.ItemIndex)+'%')
    +' and DJDate>='+formatDateTime('yyyymmdd', dtStart.Date)
    +' and DJDate<='+formatDateTime('yyyymmdd', dtEnd.Date)
    +' and ZT=''3'''         
    +' and not Exists(Select 1 from EBK_ZFXX where DJZT>=0 and MODCODE=''OER'' and DJBH=YDJBH and YDJLX=DJLXID) ';
  POpenSQL(cdsData, SQLTxt);
  BitBtnOk.Enabled := True;
end;

procedure TImpOER_EBKFrm.cbAllClick(Sender: TObject);
begin
  if not cdsData.Active then Exit;
  cdsData.First;
  while not cdsData.eof do
  begin
    cdsData.Edit;
    cdsData.FieldByName('SEL').AsString := IFF(cbAll.Checked, '1', '0');
    cdsData.Next;
  end;
end;

procedure TImpOER_EBKFrm.grdDblClick(Sender: TObject);
begin
  if not cdsData.Active then Exit;
  cdsData.Edit;
  cdsData.FieldByName('SEL').AsString := IFF(cdsData.FieldByName('SEL').AsString='1', '0', '1');
  cdsData.Post;
end;

procedure TImpOER_EBKFrm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TImpOER_EBKFrm.BitBtnOkClick(Sender: TObject);
var
  szZfId:String;
  szSKYhzh, szKHYH, szYHHH:String;
  slSql: TStrings;
  haveData: Boolean;
begin
  //����������������
  cdsZFXX.Close;
  POpenSQL(cdsZFXX, 'Select * from EBK_ZFXX where 1=0');
  cdsData.DisableControls;
  haveData := false;
  try
    cdsData.Filtered := True;
    cdsData.Filter := 'SEL=''1''';
    szZfId := getNewLSH(GszGSDM, GszKJND, getJSFSDM(ComboBoxYWLX.ItemIndex));// GetNewID;
    with cdsZFXX do
    while not cdsData.Eof do
    begin
      haveData := true;
      Append;
      
      FieldByName('GSDM').AsString := GszGSDM;
      FieldByName('KJND').AsString := GszKJND;
      FieldByName('YWQJ').AsString := Copy(cdsData.FieldByName('DJDate').AsString,5,2);
      FieldByName('YWRQ').AsString := cdsData.FieldByName('DJDate').AsString;
      FieldByName('YWLX').AsString := getJSFSMC(ComboBoxYWLX.ItemIndex);
      FieldByName('YWLXDM').AsString := getJSFSDM(ComboBoxYWLX.ItemIndex);
      FieldByName('ZFID').AsString := szZfId;
      FieldByName('MODCODE').AsString := 'OER';
      FieldByName('MODNAME').AsString := '���ϱ���';

      //FieldByName('YWYH').AsString := szYwyh;
      FieldByName('FKFZH').AsString := TString.LeftStrBySp(ReadParams('FKR'));
      FieldByName('FKFMC').AsString := GszHSDWMC;
      FieldByName('FYHZH').AsString := ReadParams('MRZH');
      FieldByName('FZHMC').AsString := TString.RightStrBySp(ReadParams('FKR'));
      FieldByName('FKHYH').AsString := TString.RightStrBySp(ReadParams('MRYH'));

      //�����к���Ϣ
      if cdsYHXX.Locate('yhbh', TString.LeftStrBySp(ReadParams('FKR')), [] ) then
      begin
        FieldByName('FYHHH').AsString := cdsYHXX.FieldByName('yhhh').AsString;
        FieldByName('FYHHB').AsString := cdsYHXX.FieldByName('yhname').AsString;
        FieldByName('FKHDQ').AsString := cdsYHXX.FieldByName('yhaddr').AsString;
        FieldByName('FYHWD').AsString := cdsYHXX.FieldByName('yhaddr').AsString;
      end;
      FieldByName('JE').AsFloat := cdsData.FieldByName('JE').AsFloat;

      FieldByName('SKFZH').AsString := cdsData.FieldByName('GRDM').AsString;
      FieldByName('SKFMC').AsString := cdsData.FieldByName('SKR').AsString;
      FieldByName('SZHMC').AsString := cdsData.FieldByName('SKR').AsString;
      FieldByName('SYHZH').AsString := cdsData.FieldByName('YHZH').AsString;
      FieldByName('SKHYH').AsString := cdsData.FieldByName('KHYH').AsString;
      //�����������ƣ�ȡ�������к�
      GetYhMC(cdsData.FieldByName('KHYH').AsString, szYHHH, szKHYH);
      FieldByName('SYHHH').AsString := szYHHH;
      FieldByName('SYHMC').AsString :=szKHYH;

      FieldByName('SKHDQ').AsString := '';
      FieldByName('SYHWD').AsString := '';

      FieldByName('ZY').AsString := cdsData.FieldByName('ZY').AsString;
      FieldByName('TCBZ').AsString := 'ͬ��';
      FieldByName('LRID').AsString := IntToStr(GCZY.ID);
      FieldByName('LRR').AsString := GCZY.Name;
      FieldByName('LRSJ').AsString :=  FormatDateTime('YYYY-MM-DD HH:NN:SS', Now);
      FieldByName('DJZT').AsInteger := 0;
      FieldByName('SHID1').AsInteger := -1;
      FieldByName('SHID2').AsInteger := -1;
      FieldByName('YDJLX').AsString := cdsData.FieldByName('DJLXID').AsString;
      FieldByName('YDJBH').AsString := cdsData.FieldByName('DJBH').AsString;
      FieldByName('JKLXID').AsString := getTypeCode(ComboBoxJKLX.ItemIndex);;  // Added by guozy 2013/12/20 14:55:42
      Post;
      slSql := TStringList.Create;
      try
        slSql := GetSQLByDelta(cdsZFXX, 'EBK_ZFXX', 'GSDM;KJND;YWLXDM;ZFID;');
        if slSql.Text <> '' then
        begin
          PExecSQL(slSql.Text);
          //PExecSQL('commit');
          if cdsZFXX.LogChanges then
            cdsZFXX.MergeChangeLog;
        end;
      finally
        slSql.Free;
      end;
      cdsData.Next;
      szZfId := getNewLSH(GszGSDM, GszKJND, getJSFSDM(ComboBoxYWLX.ItemIndex));
      //szZfId := FloatToStr(StrToFloat(szZfId)+1);
    end;
    //cdsZFXX.ApplyUpdates(-1, 'EBK_ZFXX');
  finally
    cdsData.EnableControls;
  end;
  FIsImport := True;
  cdsData.Filtered := false;
  cdsData.Filter := '';
  if not haveData then begin
    Application.MessageBox('û�����ݿ��Ե��룡', 'ϵͳ��ʾ', MB_ICONWarning+MB_OK);
    exit;
  end;
  btnSearchClick(nil);
  Application.MessageBox('������ɣ�', 'ϵͳ��ʾ', MB_ICONWarning+MB_OK);
  BitBtnOk.Enabled := False;
end;

procedure TImpOER_EBKFrm.SetIsImport(const Value: Boolean);
begin
  FIsImport := Value;
end;

function TImpOER_EBKFrm.GetNewID: String;
var
  szZfId:String;
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

procedure TImpOER_EBKFrm.GetYhInfo(bz, DM: String; var YHZH, KHH, YHHH: String);
var
  szSQL:String;
begin
  if bz='GR' then
  szSQL := 'Select DFYH, GRZH, ZL.YHMC, ZL.YHHH from PUBZYXX ZY left join ZB_YHZL ZL on ZY.GSDM=ZL.GSDM and ZY.KJND=ZL.KJND '
    +' and ZL.YHDM=ZY.DFYH  where ZY.GSDM='+QuotedStr(GszGSDM)
    +' and ZY.KJND='+QuotedStr(GszKJND)+' and ZY.ZYDM='+QuotedStr(DM);
  with DataModulePub.GetCdsBySQL(szSQL)  do
  begin
    if not eof then
    begin
      YHZH := FieldByName('GRZH').AsString;
      KHH := FieldByName('YHMC').AsString;
      YHHH:= FieldByName('YHHH').AsString;
    end;
    Free;
  end;
end;

procedure TImpOER_EBKFrm.GetYhMC(AName: String; var YHHH, YHMC: String);
var
  szSQL:String;
begin
  //
  if AName='' then Exit;
  if (Pos('��������', AName)>0)
    or (Pos('����', AName) > 0)
    or (Pos('����', AName) > 0) then
  begin
    YHMC :=  '�й���������';
  end
  else if (Pos('ũҵ����', AName)>0) or
    (Pos('ũ��', AName) > 0) then
  begin
    YHMC :=  '�й�ũҵ���йɷ����޹�˾';
  end
  else if (Pos('�й�����', AName)>0) then
  begin
    YHMC :=  '�й���������';
  end
  else if (Pos('��������', AName)>0) or
    (Pos('����', AName) > 0) then
  begin
    YHMC :=  '�й��������йɷ����޹�˾����';
  end
  else if (Pos('��ͨ����', AName)>0) or
    (Pos('����', AName) > 0) then
  begin
    YHMC :=  '��ͨ����';
  end
  else if (Pos('��������', AName)>0) then
  begin
    YHMC :=  '�������йɷ����޹�˾';
  end
  else if (Pos('�������', AName)>0) then
  begin
    YHMC :=  '�й��������';
  end
  else if (Pos('��������', AName)>0) then
  begin
    YHMC :=  '�й���������';
  end
  else if (Pos('�㷢����', AName)>0) then
  begin
    YHMC :=  '�㷢���йɷ����޹�˾';
  end
  else if (Pos('��������', AName)>0)  or
    (Pos('����', AName) > 0) then
  begin
    YHMC :=  '�������йɷ����޹�˾';
  end
  else
    YHMC := Copy(AName, 1, 8);
  
  szSQL := 'Select * from EBK_BANKINFO where BANK_NAME like '+QuotedStr('%'+YHMC+'%');;
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

end.
