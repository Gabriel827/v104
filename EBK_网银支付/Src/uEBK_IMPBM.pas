{
     
}
unit uEBK_IMPBM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Mask, ToolEdit, CurrEdit, Db, DBClient, Spin,
  LggExchanger, Placemnt, ExtCtrls, Grids, DBGridEh;

type
  TImpBM_EBKFrm = class(TForm)
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
    //function GetNewID:String;
    procedure SetIsImport(const Value: Boolean);
    procedure GetYhInfo(bz, DM:String; var YHZH, KHH, YHHH:String);
    procedure GetYhMC(AName:String; var YHHH, YHMC:String);
  public
    { Public declarations }
    property IsImport:Boolean read FIsImport write SetIsImport;
  end;

var
  ImpBM_EBKFrm: TImpBM_EBKFrm;
  procedure LoadImpBM;

implementation

uses DataModuleMain, Pub_Global, Pub_Function, Pub_Message, Pub_WYZF,
  uEBK_ImportExcel;

{$R *.DFM}

procedure LoadImpBM;
begin
  //����������
  ImpBM_EBKFrm:=TImpBM_EBKFrm.Create(nil);
  try
    ImpBM_EBKFrm.ShowModal;
  finally
    ImpBM_EBKFrm.Free;
  end;
end;

procedure TImpBM_EBKFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TImpBM_EBKFrm.FormCreate(Sender: TObject);
begin
  PSetClientDataSetProvider(Self);
  Init;
  grd.FixedColor := Self.Color;
  InitJSFS;
  ComboBoxYWLX.Items.CommaText := GszJSFSMC;  
  InitTypeCodeAndName(ComboBoxJKLX);
end;

procedure TImpBM_EBKFrm.Init;
var
  SQLTxt:String;
begin
  //��ʼ����������
  cmbDJLX.Items.Add('14 ������㵥');
  cmbDJLX.ItemIndex := 0;

  SQLTxt := 'Select * from pubszdwzh where gsdm=''' + GszGSDM + ''''
        + ' and kjnd = ''' + GszKJND + '''';
  POpenSQL(cdsYHXX, SQLTxt);
  dtStart.Date := Date;
  dtEnd.Date := Date;
end;

procedure TImpBM_EBKFrm.btnSearchClick(Sender: TObject);
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
  end;  {SQLTxt := ' Select 0 as SEL, DJLXID, DJBH, DJDate, JE, ZY, BMDM,  BMMC, GRDM, GRMC, XMDM, XMMC, CRerMC, SKR, YHZH, KHYH from OER_DJML'
    +' where '+IFF(cmbDJLX.ItemIndex=0, '', 'DJLXID='+QuotedStr(TString.LeftStrBySp(cmbDJLX.Text))+' and ')
    //+' JSFS like '+QuotedStr(TString.LeftStrBySp(cmbJSFS.Text)+'%')
    +' JSFS like '+QuotedStr(getJSFSDM(ComboBoxYWLX.ItemIndex)+'%')
    +' and DJDate>='+formatDateTime('yyyymmdd', dtStart.Date)
    +' and DJDate<='+formatDateTime('yyyymmdd', dtEnd.Date)
    +' and ZT=''3'''         
    +' and not Exists(Select 1 from EBK_ZFXX where DJZT>=0 and MODCODE=''OER'' and DJBH=YDJBH and YDJLX=DJLXID) ';}
  SQLTxt := ' select 0 as SEL,  '
          + '  a.jsdywbh, ' //1
          + '  a.je, '            //2
          + '  a.ywrq, '          //3
          + '  a.jsfs, '          //4
          + '  a.zy, '            //5
          + '  a.skzhdm  fkzh, '  //6 �����˺�
          + '  e.dwmc, '          //7 ��������
          + '  c.yhzhmc  fzhmc, ' //8 �����˻�����
          + '  c.yhname  fkhyh, '   //9   ��������� ͨ�����ֶε�ֵȡZB_YHZL���е�YH_INTFֵ
          + '  c.yhhh  fyhhh, ' //10    ���������к�
          + '  ''''  fkhdq, '     //11   ���������
          + '  a.wlzh, '          //12 �տ��˻�
          + '  a.wldwmc, '        //13 �տ�����
          + '  a.wldwmc szhmc, '  //14 �տ��˻�����
          + '  a.wlyh skhyh, '    //15   �տ������     --��Ӧ����������
          + '  '''' syhhh, '      //b.yhhh   syhhh, --16   �տ������к�   --��Ӧ������
          + '  '''' skhdq, '      //17   �տ������
          + '  a.fkrmc '          //18   �����ֽ�֧Ʊ�ġ��տ����Ϣ�����ʽ���㵥�Ƕ�Ӧ���ڲ�����
          + '  from zj_jsb a, PUBSZDWZH c, pubkszl e '
          + '  where a.gsdm = ' + QuotedStr(GszGSDM)
          + '  and a.gsdm = c.gsdm '
          + '  and ltrim(rtrim(a.jsfs))='+QuotedStr(getJSFSMC(ComboBoxYWLX.ItemIndex))
          + '  and Jsdywbh like '+QuotedStr(TString.LeftStrBySp(cmbDJLX.Text)+'%')
          + '  and rtrim(a.skzhdm) = rtrim(c.yhzh) '
          + '  and a.gsdm = e.gsdm '
          + '  and ltrim(rtrim(c.sydwdm)) = ltrim(rtrim(e.dwdm)) '
          + '  and a.ywrq>='+QuotedStr(formatDateTime('yyyymmdd', dtStart.Date))
          + '  and a.ywrq<='+QuotedStr(formatDateTime('yyyymmdd', dtEnd.Date))
          + '  and djzt = 0 '
          + '  and sfbz = ''2'' '
          + '  and shid <> -1 '
          + '  and c.kjnd=e.kjnd '
          + '  and c.kjnd ='''+ GszKJND + ''' '
          + '  and not Exists(select 1 from ebk_zfxx where gsdm=a.gsdm and djzt>-1 and ltrim(rtrim(a.jsdywbh))=ltrim(rtrim(ydjbh))) ';
  POpenSQL(cdsData, SQLTxt);
  BitBtnOk.Enabled := True;
end;

procedure TImpBM_EBKFrm.cbAllClick(Sender: TObject);
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

procedure TImpBM_EBKFrm.grdDblClick(Sender: TObject);
begin
  if not cdsData.Active then Exit;
  cdsData.Edit;
  cdsData.FieldByName('SEL').AsString := IFF(cdsData.FieldByName('SEL').AsString='1', '0', '1');
  cdsData.Post;
end;

procedure TImpBM_EBKFrm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TImpBM_EBKFrm.BitBtnOkClick(Sender: TObject);
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
      FieldByName('YWQJ').AsString := Copy(cdsData.FieldByName('ywrq').AsString,5,2);
      FieldByName('YWRQ').AsString := cdsData.FieldByName('ywrq').AsString;
      FieldByName('YWLX').AsString := getJSFSMC(ComboBoxYWLX.ItemIndex);
      FieldByName('YWLXDM').AsString := getJSFSDM(ComboBoxYWLX.ItemIndex);
      FieldByName('ZFID').AsString := szZfId;
      FieldByName('MODCODE').AsString := 'BM';
      FieldByName('MODNAME').AsString := '�ʽ�ϵͳ';
      //FieldByName('YWYH').AsString := szYwyh;
      FieldByName('FKFZH').AsString := cdsData.FieldByName('fkzh').AsString;  //fkzh, --6 �����˺�
      FieldByName('FKFMC').AsString := cdsData.FieldByName('dwmc').AsString;   //dwmc, --7 ��������
      FieldByName('FYHZH').AsString := cdsData.FieldByName('fkzh').AsString;       //fkzh, --6 �����˺�
      FieldByName('FZHMC').AsString := cdsData.FieldByName('fzhmc').AsString;    //fzhmc, -- 8 �����˻�����
      FieldByName('FKHYH').AsString := cdsData.FieldByName('fkhyh').AsString;   //fkhyh, --9   ��������� ͨ�����ֶε�ֵȡZB_YHZL���е�YH_INTFֵ

      FieldByName('FYHHH').AsString := cdsData.FieldByName('fyhhh').AsString;   //fyhhh, --10    ���������к�
      FieldByName('FYHHB').AsString := '';
      FieldByName('FKHDQ').AsString := cdsData.FieldByName('fkhdq').AsString;    //fkhdq, --11   ���������
      FieldByName('FYHWD').AsString := '';
      FieldByName('JE').AsFloat := cdsData.FieldByName('JE').AsFloat;     //je, --2

      FieldByName('SKFZH').AsString := cdsData.FieldByName('wlzh').AsString;    //wlzh, --12 �տ��˻�
      FieldByName('SKFMC').AsString := cdsData.FieldByName('wldwmc').AsString;     //wldwmc, --13 �տ����� 
      FieldByName('SZHMC').AsString := cdsData.FieldByName('szhmc').AsString;       //szhmc, --14 �տ��˻�����
      FieldByName('SYHZH').AsString := cdsData.FieldByName('wlzh').AsString;    //wlzh, --12 �տ��˻�
      FieldByName('SKHYH').AsString := cdsData.FieldByName('skhyh').AsString;  //skhyh, --15   �տ������     --��Ӧ����������
      //�����������ƣ�ȡ�������к�
      GetYhMC(cdsData.FieldByName('skhyh').AsString, szYHHH, szKHYH);
      FieldByName('SYHHH').AsString := szYHHH;
      FieldByName('SYHMC').AsString :=szKHYH;

      FieldByName('SKHDQ').AsString := '';
      FieldByName('SYHWD').AsString := '';

      FieldByName('ZY').AsString := cdsData.FieldByName('ZY').AsString; //zy, --5
      FieldByName('TCBZ').AsString := 'ͬ��';
      FieldByName('LRID').AsString := IntToStr(GCZY.ID);
      FieldByName('LRR').AsString := GCZY.Name;
      FieldByName('LRSJ').AsString :=  FormatDateTime('YYYY-MM-DD HH:NN:SS', Now);
      FieldByName('DJZT').AsInteger := 0;
      FieldByName('SHID1').AsInteger := -1;
      FieldByName('SHID2').AsInteger := -1;
      FieldByName('YDJLX').AsString := TString.LeftStrBySp(cmbDJLX.Text);
      FieldByName('YDJBH').AsString := cdsData.FieldByName('jsdywbh').AsString;     //a.jsdywbh, --1
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
  end;  btnSearchClick(nil);
  Application.MessageBox('����ɹ���', 'ϵͳ��ʾ', MB_ICONWarning+MB_OK);
  BitBtnOk.Enabled := False;
end;

procedure TImpBM_EBKFrm.SetIsImport(const Value: Boolean);
begin
  FIsImport := Value;
end;

{function TImpBM_EBKFrm.GetNewID: String;
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
end; }

procedure TImpBM_EBKFrm.GetYhInfo(bz, DM: String; var YHZH, KHH, YHHH: String);
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

procedure TImpBM_EBKFrm.GetYhMC(AName: String; var YHHH, YHMC: String);
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
