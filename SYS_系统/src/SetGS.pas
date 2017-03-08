unit SetGS;

interface

uses
  Windows, Messages, SysUtils,Variants, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, SMaskEdit, ExtCtrls, LggExchanger, ComCtrls;

type
  TFormSetGS = class(TForm)
    Label1: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    BitBtnHelp: TBitBtn;
    Image1: TImage;
    LggExchanger1: TLggExchanger;
    LabelZTCode: TLabel;
    SMaskEditZTCodeValue: TSMaskEdit;
    LabelZTName: TLabel;
    LabelDWNameValue: TLabel;
    LabelDWName: TLabel;
    LabelDWCode: TLabel;
    SMaskEditDWCodeValue: TSMaskEdit;
    LabelZTNameValue: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    DateTimePickerBusinessDate: TDateTimePicker;
    procedure SMaskEditDWCodeValueButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnOKClick(Sender: TObject);
    procedure SMaskEditDWCodeValueExit(Sender: TObject);
    procedure SMaskEditDWCodeValueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SMaskEditZTCodeValueButtonClick(Sender: TObject);
    procedure SMaskEditZTCodeValueExit(Sender: TObject);
  private
    FGSMC: string;
    FGSDM: string;
    FZTH: string;
    FZTMC: string;
    FYWRQ: string;
    procedure SetGSDM(const Value: string);
    procedure SetGSMC(const Value: string);
    procedure SetZTH(const Value: string);
    procedure SetZTMC(const Value: string);
    function GetTreeDM(str: string; bDM: Boolean): string; //���ش��������
    function GSDMIsMX(gsdm: string): Boolean;
    procedure SetYWRQ(const Value: string); //2008.3.29 hy �жϹ�˾�����Ƿ���ϸ
  public
    { Public declarations }
    property GSDM: string read FGSDM write SetGSDM;
    property GSMC: string read FGSMC write SetGSMC;
    property ZTH: string read FZTH write SetZTH;
    property ZTMC: string read FZTMC write SetZTMC;
    property YWRQ:string read FYWRQ write SetYWRQ;
  end;

var
  FormSetGS: TFormSetGS;

implementation

uses Pub_Global, Pub_Function, Pub_Power, Pub_Message,
  ListSelectDM, DataModuleMain,Registry,dbclient, TreeSelectDM;

{$R *.DFM}

procedure TFormSetGS.SMaskEditDWCodeValueButtonClick(Sender: TObject);
var
  szGS, szTemp,szsql,TempKjnd,szTmpZth,szTmpZtmc,TempKjnd_bak,GszGSFJ_Bak,SQL_TEMP: string;
  FKJND,FHSDWDM,FHSDWMC :string;
  PRegister:TRegistry;
  function IsDWDMExist(KJND,DWDM:string):Boolean;
  var
    cds:TClientDataSet;
  begin
    cds :=TClientDataSet.Create(nil);
    try
      cds.RemoteServer := DataModulePub.MidasConnectionPub;
      cds.ProviderName := 'DataSetProviderData';
      POpenSql(cds,'select count(*) res from pubgszl where KJND='+Quotedstr(KJND)+' and gsdm='+QuotedStr(DWDM));
      if Cds.Fields[0].asInteger>0 then result :=true
      else Result :=false;
    finally
      if Assigned(Cds) then FreeAndNil(Cds);
    end;
  end;
begin
  //2009.12.9 hy �����˾��������׺�û��ֵ����ʹ��ҵ�����ڵõ�������
  //����й�˾��������׺ţ���Ӧ�ô�pubkjqj�в�ѯ������
  if (GszGSDM = '') or (GszZTH = '') then
       TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date), 1, 4)
  else TempKjnd := PGetKjnd(PGetPickerDate(DateTimePickerBusinessDate));

  if TempKjnd = '' then
     TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date), 1, 4);

 (*  szSQL := ' KJND='''+TempKJND+''' and gsdm in (Select b.gsdm from (select GSDM, GSMC from pubgszl where kjnd=''' + TempKJND
    +'''  and ' + PSJQX('G', 'gsdm') + ') a, pubgszl b  where b.KJND='''+TempKJND+''' and '
    +'  a.gsdm like b.gsdm'+GSQLStrADDChar+'''%'')'; *)

  szSQL := ' KJND='''+TempKJND+''' and ' + PSJQX('G', 'gsdm');
  try
    TempKjnd_Bak := GszKJND;
    GszGSFJ_Bak := GszGSFJ;

    GszKJND := TempKjnd;      //�ı���ȫ�ֱ�������DBTreeSelectDM��ʹ��
    if GszKJND<>TempKjnd_Bak then begin
      SQL_TEMP := 'select * from gl_ztcs where hsdwdm=''' + CSysDWDM + ''' and ztbh=''' + CSysZTH + ''' and kjnd=''' + GszKJND + ''' ';
      POpenSql(DataModulePub.ClientDataSetTmp, SQL_TEMP);
      GszGSFJ := DataModulePub.ClientDataSetTmp.FieldByName('gsbmfa').asstring;
    end;   
    szGS := DBTreeSelectDM('slGS',szsql,'',False,True);
   {szsql:='(kjnd=''' + GszKJND + ''') and (gsdm in (select b.gsdm from pubgszl a, pubgszl b where a.gsdm like b.gsdm';
    szsql:=szsql+ GSQLStrADDChar + '''%'' and a.kjnd=''' + GszKJND + ''' and b.kjnd=''' + GszKJND + ''' ';
    szsql:=szsql+ ' group by b.gsdm having count(b.gsdm)>1) or ' + PSJQX('G', 'gsdm') + ') ';
    szGS := DBTreeSelectDM('slGS',szsql); }
    if szGS <> SMaskEditDWCodeValue.Text then
    begin
      SMaskEditZTCodeValue.Text := '';
      LabelZTNameValue.Caption := '';
    end;
    if szGS <> CSysDWDM then
      SMaskEditDWCodeValue.Text := szGS
    else
      SMaskEditDWCodeValue.Text;
    LabelDWNameValue.Caption := '';
    szTemp := trim(SMaskEditDWCodeValue.Text);
    if szTemp <> '' then
    begin
      szTemp := PGetMC('PubGszl', 'gsdm', szTemp, 'gsmc',' kjnd=''' + GszKJND + ''' ');
      if szTemp <> '' then
        LabelDWNameValue.Caption := szTemp;
      if SMaskEditZTCodeValue.Visible then
      begin
        //2010.2.5 hy ά����201002039938��ѡ���˵�λ���Զ�������һ������
        if GDbType = ORACLE then
        begin
          //2010.2.24 hy ά����2010022410252��ԭ����oracle�汾û�д���
          szSQL := 'select ztbh,ztmc from (select * from gl_ztcs where hsdwdm='''+Trim(SMaskEditDWCodeValue.Text)+''' and kjnd='''+GszKJND+''''
            + ' and (hsdwdm<>'''+CSysDWDM+''' and ztbh<>+'''+CSysZTH+''') order by ztbh) WHERE ROWNUM<=1 and ' + PSJQX('ZT', 'ztbh');
        end
        else
        begin
          szSQL := 'select top 1 ztbh,ztmc from gl_ztcs where hsdwdm='''+Trim(SMaskEditDWCodeValue.Text)+''' and kjnd='''+GszKJND
            +''' and (hsdwdm<>'''+CSysDWDM+''' and ztbh<>+'''+CSysZTH+''') and ' + PSJQX('ZT', 'ztbh');
        end;
        with DataModulePub.ClientDataSetData do
        begin
          POpenSql(DataModulePub.ClientDataSetData,szSQL);
          if RecordCount > 0 then
          begin
            szTmpZth := FieldByName('ztbh').AsString;
            szTmpZtmc := FieldByName('ztmc').AsString;
            SMaskEditZTCodeValue.Text := szTmpZth;
            LabelZTNameValue.Caption := szTmpZtmc;
          end;
        end;
      end;
    end;
  finally
    GszKJND := TempKjnd_bak;
    GszGSFJ := GszGSFJ_Bak;
  end;    
end;

procedure TFormSetGS.SMaskEditDWCodeValueExit(Sender: TObject);
var
  szTemp, szSQL: string;
  szTmpZth, szTmpZtmc, TempKjnd:String;
begin
  szTemp := trim(SMaskEditDWCodeValue.Text);
  if szTemp <> '' then
  begin
    //2009.12.9 hy �����˾��������׺�û��ֵ����ʹ��ҵ�����ڵõ�������
    //����й�˾��������׺ţ���Ӧ�ô�pubkjqj�в�ѯ������
    if (GszGSDM = '') or (GszZTH = '') then
         TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date), 1, 4)
    else TempKjnd := PGetKjnd(PGetPickerDate(DateTimePickerBusinessDate));

    if TempKjnd = '' then
       TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date), 1, 4);
    szTemp := PGetMC('PubGszl', 'gsdm', szTemp, 'gsmc',' kjnd=''' + TempKjnd + ''' and ' + PSJQX('G', 'gsdm')); //--���ӵ�λ����Ȩ�޿���
    LabelDWNameValue.Caption := szTemp;
    if szTemp='' then begin
       SMaskEditDWCodeValue.Text:='';
       SysMessage('û�иõ�λ������û�иõ�λ������Ȩ�ޡ�','_YB',[mbOK]);
    end;
    //hch 2012.04.24 ����ת�ƽ�����������
    if SMaskEditZTCodeValue.Visible and (SMaskEditZTCodeValue.Text='') then
    begin
      //2010.2.5 hy ά����201002039938��ѡ���˵�λ���Զ�������һ������
      if GDbType = ORACLE then
      begin
        //2010.2.24 hy ά����2010022410252��ԭ����oracle�汾û�д���
        szSQL := 'select ztbh,ztmc from (select * from gl_ztcs where hsdwdm='''+Trim(SMaskEditDWCodeValue.Text)+''' and kjnd='''+TempKjnd+''''
          + ' and (hsdwdm<>'''+CSysDWDM+''' and ztbh<>+'''+CSysZTH+''') order by ztbh) WHERE ROWNUM<=1 and ' + PSJQX('ZT', 'ztbh');
      end
      else
      begin
        szSQL := 'select top 1 ztbh,ztmc from gl_ztcs where hsdwdm='''+Trim(SMaskEditDWCodeValue.Text)+''' and kjnd='''+TempKjnd
          +''' and (hsdwdm<>'''+CSysDWDM+''' and ztbh<>+'''+CSysZTH+''') and ' + PSJQX('ZT', 'ztbh');
      end;
      with DataModulePub.ClientDataSetData do
      begin
        POpenSql(DataModulePub.ClientDataSetData,szSQL);
        if RecordCount > 0 then
        begin
          szTmpZth := FieldByName('ztbh').AsString;
          szTmpZtmc := FieldByName('ztmc').AsString;
          SMaskEditZTCodeValue.Text := szTmpZth;
          LabelZTNameValue.Caption := szTmpZtmc;
        end;
      end;
    end;
  end else begin
    LabelDWNameValue.Caption := '';
    SMaskEditZTCodeValue.Text := '';
    LabelZTNameValue.Caption := '';    
  end;
end;

procedure TFormSetGS.BitBtnOKClick(Sender: TObject);
var
  szGSDM, szsql: string;
begin
  if Sender = BitBtnOK then
  begin
    szGSDM := SMaskEditDWCodeValue.Text;
    {if GProSign = 'FA' then
    begin
      szsql:= 'select * from gl_czy ' + //�Ƕ������Ա
                          ' where (Upper(ID) = ' + IntToStr(GCzy.ID) + ')' +
                          '  and (type = ''1'') and (syzt <> ''2'')';
      with DataModulePub do
      begin
        POpenSql(ClientDataSetTmp, szsql);
        if (GCzy.ID<>0) and (GCzy.ID<>1) then
        begin
          if Trim(ClientDataSetTmp.FieldByName('gsdm').AsString)<> Trim(SMaskEditDWCodeValue.Text) then
          begin
            SysMessage('��ѡ�����Ա������λ: '  +ClientDataSetTmp.FieldByName('gsdm').AsString + ' ��¼!', 'AOther_XW', [mbOk]);
            Exit;
          end;
        end;
      end;
    end; }

   // if (GProSign <> 'GL') and (GProSign <> 'IDA') and (GProSign <> 'BKA') and
   //    (GProSign <> 'GE') and (GProsign <> 'SA')  and (GProsign <> 'SYS') then begin //������ģ��Ҫ�ж��Ƿ�Ϊ��ϸ��λ������ϸ��λ�������¼
    if szGSDM<>'' then begin
       if (not GSDMIsMX(szGSDM)) then begin
          SysMessage('����ϸ��λ�������¼��', 'AOther_XW', [mbOk]);
          Exit;
       end;
    end;

    if szGSDM='' then begin
      if not (SysMessage('ȷ�����趨��λ������'+#13+'�������޷�ʹ��ҵ��ģ��Ĺ���', 'AOther_XW', [mbOk, mbCancel])=mrOk) then  //if not (SysMessage('ȷ�����趨��λ���ף�'+#13+'ϵͳ��ʹ��ϵͳ����Ļ�����Ϣ�������ع���', 'AOther_XW', [mbOk, mbCancel])=mrOk) then
         Exit;
      //if GProsign='SYS' then begin
      SetGSDMNull;
      FGsdm := '';
      FGsmc := '';
      //end else begin
      //FGsdm := CSysDWDM;
      //FGsmc := 'ϵͳ����';
      //end;*)
      FZth := '';
      FZtmc := '';
    end
    else
    begin
      if LabelDWNameValue.Caption = '' then
      begin
        SysMessage('ָ����λ�����ڣ����ܽ���ǰ��λ�趨Ϊ' + SMaskEditDWCodeValue.Text, 'AOther_JG', [mbOk]);
        exit;
      end
      else
      begin
        if SMaskEditZTCodeValue.Text = '' then
        begin
          {if not (SysMessage('ȷ����' + #13 +
            '��ǰ��λ�趨Ϊ:' + LabelDWNameValue.Caption + '��' + #13 +
            'û���趨���ף�������ʹ�÷����״������ع���', 'AOther_XW', [mbOk, mbCancel]) = mrOk) then
            exit;   }
          FGsdm := SMaskEditDWCodeValue.Text;
          FGsmc := LabelDWNameValue.Caption;          //if GProsign='SYS' then begin
          GszZth:='';   //���׺����
          GszZTMC:='';
          FZth := '';
          FZtmc := '';
        end
        else
        begin
          if LabelZTNameValue.Caption = '' then
          begin
            SysMessage('ָ�����ײ����ڣ����ܽ���ǰ�����趨Ϊ' + SMaskEditZTCodeValue.Text, 'AOther_JG', [mbOk]);
            exit;
          end
          else
          begin
            FGsdm := SMaskEditDWCodeValue.Text;
            FGsmc := LabelDWNameValue.Caption;
            FZth := SMaskEditZTCodeValue.Text;
            FZtmc := LabelZTNameValue.Caption;
          end;
        end;
      end;
    end;
    FYWRQ := formatDateTime('yyyymmdd', DateTimePickerBusinessDate.Date);
    ModalResult := mrOk;
  end
  else if Sender = BitBtnHelp then
  begin
    GetHelp(Self, '', False);
  end
  else if Sender = BitBtnCancel then
  begin
    Close;
  end;
end;

procedure TFormSetGS.SMaskEditDWCodeValueKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 27 then // Esc
    Close
  else if Key = 112 then
    BitBtnOKClick(BitBtnHelp)
  else if Key = 13 then
  begin
    BitBtnOK.SetFocus;
    BitBtnOKClick(BitBtnOK);
  end;
end;

procedure TFormSetGS.FormShow(Sender: TObject);
begin
  SetComponentsColor(Self);
  if GszHSDWDM <> CSysDWDM then
  begin
    SMaskEditDWCodeValue.Text := GszHSDWDM;
    LabelDWNameValue.Caption := GszHSDWMC;
  end
  else
  begin
    SMaskEditDWCodeValue.Text := '';
    LabelDWNameValue.Caption := '';
  end;
  
  try
    //if ((GszRelease='DEMO') or (GNotEncrypt='1')) and (GszVersion<>'SA') and (GszVersion<>'SYS') then
    if not GAnyiLicenseInfo.IsConnected then
       DateTimePickerBusinessDate.MaxDate := TString.StrToDate(AI_DEMO_DATE);

    if (GszYWRQ<>'') and (length(GszYWRQ)=8) then
         DateTimePickerBusinessDate.Date := TString.StrToDate(copy(GszYWRQ, 1, 4)+'-'+copy(GszYWRQ, 5, 2)+'-'+copy(GszYWRQ, 7, 2))
    else DateTimePickerBusinessDate.Date := Date;

    SMaskEditZTCodeValue.Text := GszZTH;
    LabelZTNameValue.Caption := GszZTMC;
  finally
  end;
  
  if CompareText(LabelDWNameValue.Caption,'undefined')=0 then
     LabelDWNameValue.Caption := '';

  if CompareText(LabelZTNameValue.Caption,'undefined')=0 then
     LabelZTNameValue.Caption := '';
end;

procedure TFormSetGS.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

function TFormSetGS.GetTreeDM(str: string; bDM: Boolean): string; //���ش��������
var
  i: Integer;
begin
  i := Pos('|', str);
  if bDM then
    Result := Trim(Copy(str, 1, i - 1))
  else
    Result := Trim(Copy(str, i + 1, length(str) - i));
  if Result = '' then
    Result := str;
end;

procedure TFormSetGS.SMaskEditZTCodeValueButtonClick(Sender: TObject);
var
  szTemp,szTemp1,TempKjnd: string;
  VarValue: Variant;
begin
  //edit by zys 2008-01-16 16:01:10 �޸�ԭ�򣺸�����Ҫ�޸�
  {if SMaskEditDWCodeValue.Text = '' then
    exit; //���Ϊ�գ���Ҫ�����õ�λ}
  {���أ��������ж��߼�����ҵ������Ϊ׼ chengjf 20161220
  // Added by miaopf 2008-4-21 17:31:56  ҵ��ʱ��͵�λ��
  if GszKJND<>'' then
    TempKjnd :=GszKJND
  else
    TempKjnd := PGetKjnd(PGetPickerDate(DateTimePickerBusinessDate));
  }
  // Modified by chengjf 2016-12-20
  //�����˾��������׺�û��ֵ����ʹ��ҵ�����ڵõ�������
  //����й�˾��������׺ţ���Ӧ�ô�pubkjqj�в�ѯ������
  if (GszGSDM = '') or (GszZTH = '') then
       TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date), 1, 4)
  else TempKjnd := PGetKjnd(PGetPickerDate(DateTimePickerBusinessDate));

  if TempKjnd = '' then
    TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date),1,4);
//function ListViewSelectDM(XZNR: ShortString; XZTJ: string; MultiSelectSymbol: Boolean; XZDM: ShortString = '';
//  ShowSymbol: Boolean = True; DataType: TDataType = dtAll; szType: string = ''; ShowAllHsdw: Boolean = False; XZND: string = ''): Variant;
  if SMaskEditDWCodeValue.Text <> '' then
    VarValue := ListViewSelectDM('slZT', '(KJND=''' + TempKjnd + ''') and (HSDWDM='''
      + SMaskEditDWCodeValue.Text + ''') and (ztbh<>''' + CSysZTH + ''') and ' + PSJQX('ZT', 'ztbh'), false,'',True,dtAll,'',False,TempKjnd)
  else
    VarValue := ListViewSelectDM('slZT', '(KJND=''' + TempKjnd + ''') and (HSDWDM<>'''
      + CSysDWDM + ''') and (ztbh<>''' + CSysZTH + ''') and ' + PSJQX('ZT', 'ztbh') + ' and ' + PSJQX('G', 'hsdwdm'), false,'',True,dtAll,'',False,TempKjnd); // ������ 2009.09.21 ���ӵ�λȨ�޹���������ά������200909166651 ��
  {
  if SMaskEditDWCodeValue.Text <> '' then
    VarValue := ListViewSelectDM('slZT', '(KJND=''' + GszKJND + ''') and (HSDWDM='''
      + SMaskEditDWCodeValue.Text + ''') and (ztbh<>''' + CSysZTH + ''') and ' + PSJQX('ZT', 'ztbh'), false)
  else
    VarValue := ListViewSelectDM('slZT', '(KJND=''' + GszKJND + ''') and (HSDWDM<>'''
      + CSysDWDM + ''') and (ztbh<>''' + CSysZTH + ''') and ' + PSJQX('ZT', 'ztbh'), false);
  }
  if (VarType(VarValue)=varShortInt) or (VarType(VarValue)=varInteger) then
  begin
    if (VarValue = 0) or (VarValue = -1) or (VarValue = 255) then
      Exit;
  end
  else
  begin
    szTemp := VarValue[0];
  end;
  //edit by zys 2008-01-16 16:18:15 �޸�ԭ�򣺸�����Ҫ�޸�

  szTemp1 := GetTreeDM(szTemp, True);
  szTemp := GetTreeDM(szTemp, False);
  if SMaskEditDWCodeValue.Text = '' then
  begin
    SMaskEditDWCodeValue.Text := szTemp1;
    LabelDWNameValue.Caption := '';
    szTemp1 := trim(SMaskEditDWCodeValue.Text);
    if szTemp1 <> '' then
    begin
      szTemp1 := PGetMC('PubGszl', 'gsdm', szTemp1, 'gsmc',' kjnd=''' + TempKjnd + ''' ');
      if szTemp1 <> '' then
        LabelDWNameValue.Caption := szTemp1;
    end;
  end;

  SMaskEditZTCodeValue.Text := szTemp;
  LabelZTNameValue.Caption := '';
  szTemp := trim(SMaskEditZTCodeValue.Text);
  if szTemp <> '' then
  begin
    // Added by miaopf 2008-4-21 17:32:54
    //szTemp := PGetMC('GL_ZTCS', 'ztbh', szTemp, 'ztmc', 'hsdwdm=''' + SMaskEditDWCodeValue.Text + ''' and kjnd = ''' + GszKJND + ''' ', True);
    szTemp := PGetMC('GL_ZTCS', 'ztbh', szTemp, 'ztmc', 'hsdwdm=''' + SMaskEditDWCodeValue.Text + ''' and kjnd = ''' + TempKjnd + ''' ', True);
    if szTemp <> '' then
      LabelZTNameValue.Caption := szTemp;
  end;
end;

procedure TFormSetGS.SMaskEditZTCodeValueExit(Sender: TObject);
var
  szTemp,szTemp1,TempKjnd: string;
begin
  //�����˾��������׺�û��ֵ����ʹ��ҵ�����ڵõ�������
  //����й�˾��������׺ţ���Ӧ�ô�pubkjqj�в�ѯ������
  if (GszGSDM = '') or (GszZTH = '') then
       TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date), 1, 4)
  else TempKjnd := PGetKjnd(PGetPickerDate(DateTimePickerBusinessDate));
  if TempKjnd = '' then
    TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date),1,4);
  szTemp := trim(SMaskEditZTCodeValue.Text);
  //edit by zys 2008-01-16 16:50:42 �޸�ԭ�����ӵ�λ����
  if szTemp <> '' then
  begin
    szTemp1 := 'select hsdwdm from GL_ZTCS where ztbh = ''' + SMaskEditZTCodeValue.Text + '''';
    if Trim(SMaskEditDWCodeValue.Text) <> '' then
      szTemp1 := szTemp1 + ' and hsdwdm=''' + SMaskEditDWCodeValue.Text + '''';
    //2008.3.12 hy ����kjnd�ֶ�
    szTemp1 := szTemp1 + ' and kjnd=''' + TempKjnd + '''';
    POpenSql(DataModulePub.ClientDataSetPub, szTemp1);
    if DataModulePub.ClientDataSetPub.recordcount > 1 then
    begin
      SysMessage('��ѡ��λ', 'AOther_JG', [mbOk]);
    end
    else if DataModulePub.ClientDataSetPub.recordcount = 1 then
    begin
      SMaskEditDWCodeValue.Text := DataModulePub.ClientDataSetPub.fields[0].asstring;
      LabelDWNameValue.Caption := '';
      szTemp1 := trim(SMaskEditDWCodeValue.Text);
      if szTemp1 <> '' then
      begin
        szTemp1 := PGetMC('PubGszl', 'gsdm', szTemp1, 'gsmc',' kjnd=''' + TempKjnd + ''' ');
        if szTemp1 <> '' then
          LabelDWNameValue.Caption := szTemp1;
      end;
    end;
    LabelZTNameValue.Caption := szTemp;
  end;

  if szTemp <> '' then
  begin
    szTemp := PGetMC('GL_ZTCS', 'ztbh', szTemp, 'ztmc', 'hsdwdm=''' + SMaskEditDWCodeValue.Text + ''' and kjnd = ''' + TempKjnd + '''', True);
    LabelZTNameValue.Caption := szTemp;
  end
  else
    LabelZTNameValue.Caption := '';
end;
//2008.3.29 hy �жϹ�˾�����Ƿ���ϸ����

function TFormSetGS.GSDMIsMX(gsdm: string): Boolean;
var
  SqlStr: string;
begin
  Result := False;
  if Trim(gsdm) = '' then
  begin
    Result := False;
    Exit;
  end;
  SqlStr := 'select gsdm from pubgszl where rtrim(gsdm) like ''' + Trim(gsdm) + '%'''
    + ' and rtrim(gsdm) <> ''' + Trim(gsdm) + ''' and kjnd=''' + GszKJND + '''';
  with DataModulePub.ClientDataSetPub do
  begin
    Close;
    POpenSql(DataModulePub.ClientDataSetPub, SqlStr);
    try
      if FindFirst then
        Result := False
      else
        Result := True;
    except
      Result := False;
    end;
  end;
end;

procedure TFormSetGS.SetGSDM(const Value: string);
begin
  FGSDM := Value;
end;

procedure TFormSetGS.SetGSMC(const Value: string);
begin
  FGSMC := Value;
end;

procedure TFormSetGS.SetZTH(const Value: string);
begin
  FZTH := Value;
end;

procedure TFormSetGS.SetZTMC(const Value: string);
begin
  FZTMC := Value;
end;

procedure TFormSetGS.SetYWRQ(const Value: string);
begin
  FYWRQ := Value;
end;

end.
