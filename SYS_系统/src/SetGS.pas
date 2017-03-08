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
    function GetTreeDM(str: string; bDM: Boolean): string; //返回代码或名称
    function GSDMIsMX(gsdm: string): Boolean;
    procedure SetYWRQ(const Value: string); //2008.3.29 hy 判断公司代码是否明细
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
  //2009.12.9 hy 如果公司代码和账套号没有值，则使用业务日期得到会计年度
  //如果有公司代码和账套号，则应该从pubkjqj中查询会计年度
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

    GszKJND := TempKjnd;      //改变下全局变量，在DBTreeSelectDM中使用
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
        //2010.2.5 hy 维护单201002039938，选择了单位后，自动带出第一个账套
        if GDbType = ORACLE then
        begin
          //2010.2.24 hy 维护单2010022410252，原来的oracle版本没有处理
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
    //2009.12.9 hy 如果公司代码和账套号没有值，则使用业务日期得到会计年度
    //如果有公司代码和账套号，则应该从pubkjqj中查询会计年度
    if (GszGSDM = '') or (GszZTH = '') then
         TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date), 1, 4)
    else TempKjnd := PGetKjnd(PGetPickerDate(DateTimePickerBusinessDate));

    if TempKjnd = '' then
       TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date), 1, 4);
    szTemp := PGetMC('PubGszl', 'gsdm', szTemp, 'gsmc',' kjnd=''' + TempKjnd + ''' and ' + PSJQX('G', 'gsdm')); //--增加单位数据权限控制
    LabelDWNameValue.Caption := szTemp;
    if szTemp='' then begin
       SMaskEditDWCodeValue.Text:='';
       SysMessage('没有该单位，或您没有该单位的数据权限。','_YB',[mbOK]);
    end;
    //hch 2012.04.24 增加转移焦点填入账套
    if SMaskEditZTCodeValue.Visible and (SMaskEditZTCodeValue.Text='') then
    begin
      //2010.2.5 hy 维护单201002039938，选择了单位后，自动带出第一个账套
      if GDbType = ORACLE then
      begin
        //2010.2.24 hy 维护单2010022410252，原来的oracle版本没有处理
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
      szsql:= 'select * from gl_czy ' + //非冻结操作员
                          ' where (Upper(ID) = ' + IntToStr(GCzy.ID) + ')' +
                          '  and (type = ''1'') and (syzt <> ''2'')';
      with DataModulePub do
      begin
        POpenSql(ClientDataSetTmp, szsql);
        if (GCzy.ID<>0) and (GCzy.ID<>1) then
        begin
          if Trim(ClientDataSetTmp.FieldByName('gsdm').AsString)<> Trim(SMaskEditDWCodeValue.Text) then
          begin
            SysMessage('请选择操作员所属单位: '  +ClientDataSetTmp.FieldByName('gsdm').AsString + ' 登录!', 'AOther_XW', [mbOk]);
            Exit;
          end;
        end;
      end;
    end; }

   // if (GProSign <> 'GL') and (GProSign <> 'IDA') and (GProSign <> 'BKA') and
   //    (GProSign <> 'GE') and (GProsign <> 'SA')  and (GProsign <> 'SYS') then begin //非总帐模块要判断是否为明细单位，非明细单位不允许登录
    if szGSDM<>'' then begin
       if (not GSDMIsMX(szGSDM)) then begin
          SysMessage('非明细单位不允许登录！', 'AOther_XW', [mbOk]);
          Exit;
       end;
    end;

    if szGSDM='' then begin
      if not (SysMessage('确定不设定单位账套吗？'+#13+'这样将无法使用业务模块的功能', 'AOther_XW', [mbOk, mbCancel])=mrOk) then  //if not (SysMessage('确定不设定单位账套？'+#13+'系统将使用系统级别的基础信息处理的相关功能', 'AOther_XW', [mbOk, mbCancel])=mrOk) then
         Exit;
      //if GProsign='SYS' then begin
      SetGSDMNull;
      FGsdm := '';
      FGsmc := '';
      //end else begin
      //FGsdm := CSysDWDM;
      //FGsmc := '系统级别';
      //end;*)
      FZth := '';
      FZtmc := '';
    end
    else
    begin
      if LabelDWNameValue.Caption = '' then
      begin
        SysMessage('指定单位不存在，不能将当前单位设定为' + SMaskEditDWCodeValue.Text, 'AOther_JG', [mbOk]);
        exit;
      end
      else
      begin
        if SMaskEditZTCodeValue.Text = '' then
        begin
          {if not (SysMessage('确定将' + #13 +
            '当前单位设定为:' + LabelDWNameValue.Caption + '？' + #13 +
            '没有设定账套，将不能使用分账套处理的相关功能', 'AOther_XW', [mbOk, mbCancel]) = mrOk) then
            exit;   }
          FGsdm := SMaskEditDWCodeValue.Text;
          FGsmc := LabelDWNameValue.Caption;          //if GProsign='SYS' then begin
          GszZth:='';   //账套号清空
          GszZTMC:='';
          FZth := '';
          FZtmc := '';
        end
        else
        begin
          if LabelZTNameValue.Caption = '' then
          begin
            SysMessage('指定账套不存在，不能将当前账套设定为' + SMaskEditZTCodeValue.Text, 'AOther_JG', [mbOk]);
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

function TFormSetGS.GetTreeDM(str: string; bDM: Boolean): string; //返回代码或名称
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
  //edit by zys 2008-01-16 16:01:10 修改原因：根据需要修改
  {if SMaskEditDWCodeValue.Text = '' then
    exit; //如果为空，需要先设置单位}
  {隐藏，用下面判断逻辑，以业务日期为准 chengjf 20161220
  // Added by miaopf 2008-4-21 17:31:56  业务时间和单位绑定
  if GszKJND<>'' then
    TempKjnd :=GszKJND
  else
    TempKjnd := PGetKjnd(PGetPickerDate(DateTimePickerBusinessDate));
  }
  // Modified by chengjf 2016-12-20
  //如果公司代码和账套号没有值，则使用业务日期得到会计年度
  //如果有公司代码和账套号，则应该从pubkjqj中查询会计年度
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
      + CSysDWDM + ''') and (ztbh<>''' + CSysZTH + ''') and ' + PSJQX('ZT', 'ztbh') + ' and ' + PSJQX('G', 'hsdwdm'), false,'',True,dtAll,'',False,TempKjnd); // 崔立国 2009.09.21 增加单位权限过滤条件。维护单：200909166651 。
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
  //edit by zys 2008-01-16 16:18:15 修改原因：根据需要修改

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
  //如果公司代码和账套号没有值，则使用业务日期得到会计年度
  //如果有公司代码和账套号，则应该从pubkjqj中查询会计年度
  if (GszGSDM = '') or (GszZTH = '') then
       TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date), 1, 4)
  else TempKjnd := PGetKjnd(PGetPickerDate(DateTimePickerBusinessDate));
  if TempKjnd = '' then
    TempKjnd := Copy(DateTimeToStr(DateTimePickerBusinessDate.Date),1,4);
  szTemp := trim(SMaskEditZTCodeValue.Text);
  //edit by zys 2008-01-16 16:50:42 修改原因：增加单位代码
  if szTemp <> '' then
  begin
    szTemp1 := 'select hsdwdm from GL_ZTCS where ztbh = ''' + SMaskEditZTCodeValue.Text + '''';
    if Trim(SMaskEditDWCodeValue.Text) <> '' then
      szTemp1 := szTemp1 + ' and hsdwdm=''' + SMaskEditDWCodeValue.Text + '''';
    //2008.3.12 hy 加上kjnd字段
    szTemp1 := szTemp1 + ' and kjnd=''' + TempKjnd + '''';
    POpenSql(DataModulePub.ClientDataSetPub, szTemp1);
    if DataModulePub.ClientDataSetPub.recordcount > 1 then
    begin
      SysMessage('请选择单位', 'AOther_JG', [mbOk]);
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
//2008.3.29 hy 判断公司代码是否明细代码

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
