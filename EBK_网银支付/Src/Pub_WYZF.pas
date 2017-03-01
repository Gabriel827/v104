unit Pub_WYZF;

interface

uses Classes, StdCtrls, DBClient, Pub_Message;

type
  //����״̬
  TWYZF_Bill_Status = (
    djWSHH, //δ��� 
    djSSH, //������
    djSHH, //�����
    djTH, //�˻�
    djHS, //�ջ�
    djHY, //�ѻ�ԭ
    djZX, //��ִ��
    djZF //����
    );
  //���ݲ�������
  TWYZF_Bill_Action = (
    baSave, //���ݱ���
    baSS, //��������
    baSH, //�������
    baXS, //��������
    baTH, //�����˻�
    baHS, //�����ջ�
    baZF, //��������
    baHY, //���ݻ�ԭ
    baSC, //����ɾ��
    baZX, //����ִ��
    baFZX, //���ݷ�ִ��
    baNOUKEY //UKey��֤��ͨ��
    );

  //���ݲ������
  TWYZF_Bill_ActResult = (barPASS, //ͨ��
    barBack, //�˻�
    barBInit //�˻ر�����
    );
    
  //������˽ṹ
  TWYZF_Bill_SHJG = record
    DJLXID: string; //��������ID
    DJLXBM: string; //�������ͱ���
    DJLXMC: string; //������������
    DJID: string; //����ID
    DJFlowCode: string; //�����������
    DJFlowName: string; //�������������
    DJCurrSHJD: Integer; //���ݵ�ǰ��˽ڵ�
    DJCurrSHJDName: string; //���ݵ�ǰ��˽ڵ�����
    DJNextSHJD: Integer; //������һ��˽ڵ�
    DJNextSHJDName: string; //������һ��˽ڵ�����
    SrcDJCurrSHJD: Integer; //���浥�ݵ�ǰ��˽ڵ�
    SrcDJCurrSHJDName: string; //���浥�ݵ�ǰ��˽ڵ�����
    SrcDJNextSHJD: Integer; //���浥����һ��˽ڵ�
    SrcDJNextSHJDName: string; //���浥����һ��˽ڵ���
    DJSHYJ: string; //����������
    DJSHJG: TWYZF_Bill_ActResult; //���ݲ������
    DJJE: Extended; //���ݽ��
  end;

  TWYZFRec = record
    ZFID: string;
    YWND: string;
    YWRQ: string;
    YWLXDM: string;
    YWLXMC: string;
    YWYH: string;
    // ֧����Ϣ
    FKFZH: string;
    FKFMC: string;
    FYHZH: string;
    FZHMC: string;
    FKHYH: string;
    FYHHH: string;
    FYHHB: string;
    FYHWD: string;
    FKHDQ: string;
    SKFZH: string;
    SKFMC: string;
    SYHZH: string;
    SZHMC: string;
    SKHYH: string;
    SYHHH: string;
    SYHHB: string;
    SYHMC: string;
    SYHWD: string;
    SKHDQ: string;
    TCBZ: string;
    ZY: string;
    JE: Extended;
    //
    DJZT: Integer;
    LRID: Integer;
    LRSJ: string;
    SHID1: Integer;
    SHID2: Integer;
    CLZT: string;
    SLZT: string;
    ZFZT: string;
    YDJBH: string;
    YDJSJ: string;
    ZXSJ: string;  // Added by guozy 2013/4/19 ������ 14:46:42
    ZFSJ: string;  // Added by guozy 2013/4/19 ������ 14:46:46
    //
    SFTH:string;
    DJStatus: TWYZF_Bill_Status; //����״̬
    SHFlow: string; //�������
    CurSHJD: Integer; //��ǰ��˽ڵ�
    NextSHJD: Integer; //��һ��˽ڵ�
    CurSHJDMC: string; //��ǰ��˽ڵ�
    NextSHJDMC: string; //��һ��˽ڵ�
    SBANKUQNO: string;  //����Ψһ��
    SBUSIUQNO: string;  //ԭ֧��������ˮ��
    SHEADBUSIUQNO: string;  //��������ˮ��
    SDEPID: string;  //�տ����л�����
    CLXX: string;  //��������Ϣ
    ZFXX: string;  //֧��������Ϣ
    MODCODE: string;
    MODNAME: string;
    GROUPID:String;
  end;
const
  GN_WYZF_Read: string = '73001';
  GN_WYZF_NEW: string = '73002';
  GN_WYZF_Edit: string = '73003';
  GN_WYZF_SH: string = '73004';
  GN_WYZF_XS: string = '73005';
  GN_WYZF_TH: string = '73006';
  GN_WYZF_ZF: string = '73007';
  GN_WYZF_HY: string = '73008';
  GN_WYZF_ZX: string = '73009';
  GN_WYZF_QXZX: string = '73010';
  GN_WYZF_CXZX: string = '73011';
  GN_WYZF_SGSB: string = '73012';    //�ֹ�ʧ��
  GN_WYZF_SGCG: string = '73013';    //�ֹ��ɹ�
  GN_WYZFDJB_Read: string = '73016';
  GN_ZTCSSZ_Edit: string = '73021';
  GN_ZTCSSZ_Read: string = '73022';
  GN_JGXX_Edit: string = '73031';
  GN_JGXX_Read: string = '73032';
  GN_SFZL_Edit: string = '73033';
  GN_SFZL_Read: string = '73034';
  GN_YHDQ_Edit: string = '73035';
  GN_YHDQ_Read: string = '73036';
  GN_YHHH_Edit: string = '73037';
  GN_YHHH_Read: string = '73038';
  GN_YHJK_Edit: string = '73039';
  GN_YHJK_Read: string = '73040';
  GN_YHJKPZ_Edit: string = '73041';
  GN_YHJKPZ_Read: string = '73042';
  GN_ZHYECX_Read: string = '73061';
  GN_ZHMXCX_Read: string = '73062';
  GN_EXCEL_YR: string = '73081';
  GN_WSBX_YR: string = '73082';
  GN_XZSJ_YR: string = '73083';
  GN_ZJSJ_YR: string = '73084';
  // ������
  GN_WYZF_SH1: string = '1';
  GN_WYZF_SH2: string = '2';


var
  bWYZFQYSHL: Boolean;
  GEBKParams:TClientDataSet;
  GszJSFSDM, GszJSFSMC, GszJSFS_XJZP: widestring;
  GszModCode, gszModName: string;
  GszTypeCode, gszTypeName: string;  //û��ȫ��
  GszTypeCode2, gszTypeName2: string;  //��ȫ��
  GszGroupCode, gszGroupName: string;
  GEBK_BankAcc:Integer=0;     //��¼ebk_yhjk����������
  GEBK_BankAccount:Integer=10000000;     //��¼���ܵ���������  
  function PWriteYHCzrz(ACznr: string): integer;
  function PGetCzySHQX(ACzyID: Integer; ASHFlow: string; ACurrSHJD: Integer): Boolean;
  function PSetBillAct(AZT: TWYZF_Bill_Action; ADJID: string; AYWLXDM: string; AGROUPID:String; var ASHJG: TWYZF_Bill_SHJG): Boolean;
  function SaveParams(CSMC, CSZ:String):Boolean;
  function ReadParams(CSMC:String):String;
  procedure InitJSFS;
  procedure InitModeCodeAndName(Acbb:TComboBox);
  procedure InitTypeCodeAndName(Acbb:TComboBox);   //û��ȫ��
  procedure InitTypeCodeAndName2(Acbb:TComboBox);  //��ȫ��
  procedure InitGroupCodeAndName(Acbb:TComboBox);
  procedure InitBankCbb(Acbb:TComboBox);
  procedure InitBankForYHZL(Acbb:TComboBox);
  procedure InitYHZHCbb(Acbb:TComboBox);
  function getJSFSDM(aIndex: integer): string;
  function getJSFSMC(aIndex: integer): string;
  function getModCode(aIndex: integer): string;
  function getModName(aIndex: integer): string;
  function getTypeCode(aIndex: integer): string;   //û��ȫ��
  function getTypeCode2(aIndex: integer): string;  //��ȫ��
  function getTypeName(aIndex: integer): string;
  function getGroupCode(aIndex: integer): string;
  function getSJLYIndex(aModCode: string): Integer;
  function getJKLXIndex(aTypeCode: string): Integer;
  function getGroupIndex(aGroupCode: string): Integer;
  function getJSFSMCIndex(aJSFSDM: string): Integer;
  function currJSFSIsXJZP(aIndex: Integer): string;
  function getNewLSH(sGSDM, sKJND, sYWLXDM: string): string;
  //����Ƿ����UKey��֤
  function UKeyCheck(ACzyID: Integer; ASHFlow: string; ACurrSHJD: Integer): Boolean;

implementation

uses Pub_Global, pub_function, DataModuleMain, SysUtils;

function UKeyCheck(ACzyID: Integer; ASHFlow: string; ACurrSHJD: Integer): Boolean;
var
  vSQL: string;
begin
  Result := False;
  vSQL := 'select AuditorID,UKEYENABLED from PubNodeAuditor where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND
    + ''' and FlowCode=''' + ASHFlow + ''' and NodeSeq=' + IntToStr(ACurrSHJD) + ' and AuditorID=' + IntToStr(ACzyID);
  with DataModulePub.ClientDataSetTmp do
  begin
    POpenSql(DataModulePub.ClientDataSetTmp, vSQL);
    if RecordCount > 0 then //�������ʾ��ǰ����Ա�ڴ˽ڵ������Ȩ��
    begin
      if (FieldByName('AuditorID').AsInteger = ACzyID) and  (FieldByName('UKEYENABLED').asString = '1') then
        Result := True;
    end;
  end;
end;

function PWriteYHCzrz(ACznr: string): integer;
var
  szStation, szMsg, szsql, szCzy: string;
  CdsCzrz: TClientDataSet;
begin
  result := -1;
  szStation := GStation;
  if pos('.', szStation) > 0 then
    szStation := copy(szStation, 1, pos('.', szStation) - 1);
  szStation := szStation + '_' + GIPAddress;
  szCzy := IntToStr(GCzy.ID) + ' ' + GCzy.Name;
  try
    CdsCzrz := DataModulePub.GetCds;
    if GDbType = ORACLE then
    begin
      szsql := 'begin ' +
        'declare szNewNo int; ' +
        'begin ' +
        'select NVL(max(no)+1,1) into szNewNo from EBK_czrz where station=''' + szStation + '''; ' +
        'insert into EBK_czrz(station, no, name, "date", zwrq, qssj, zzsj, cznr) ' +
        ' values (''' + szStation + ''',szNewNo,''' + szCzy + ''', to_char(sysdate,''YYYYMMDD''),''' + GszYWRQ + ''', to_char(sysdate,''hh24:mi:ss''), '' '',''' + ACznr + ''');commit; ' +
        'open :pRecCur for select szNewNo NewNo from dual; ' +
        'end;end;';
    end
    else
    begin
      szsql := 'declare @NewNo int'#10 +
        'select @NewNo=max(no)+1 from EBK_czrz where station=''' + szStation + ''''#10 +
        'if @NewNo is Null select @NewNo=1'#10 +
        'insert EBK_czrz(station, no, name, date, zwrq, qssj, zzsj, cznr)' +
        ' values (''' + szStation + ''',@NewNo,''' + szCzy + ''', convert(char(8),getdate(),112),''' + GszYWRQ +
        ''', convert(char(8),getdate(),108),'' '',''' + ACznr + ''')'#10 +
        'select NewNo=@NewNo';
    end;

    try
      POpenSQL(CdsCzrz, szsql);
    except
    end;
    Result := CdsCzrz.FieldByName('NewNo').asInteger;
    CdsCzrz.Close;
  finally
    FreeAndNil(CdsCzrz);
  end;

end;

function PGetCzySHQX(ACzyID: Integer; ASHFlow: string; ACurrSHJD: Integer): Boolean;
var
  vSQL: string;
begin
  Result := False;
  vSQL := 'select AuditorID from PubNodeAuditor where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND
    + ''' and FlowCode=''' + ASHFlow + ''' and NodeSeq=' + IntToStr(ACurrSHJD) + ' and AuditorID=' + IntToStr(ACzyID);
  with DataModulePub.ClientDataSetTmp do
  begin
    POpenSql(DataModulePub.ClientDataSetTmp, vSQL);
    if RecordCount > 0 then //�������ʾ��ǰ����Ա�ڴ˽ڵ������Ȩ��
    begin
      if FieldByName('AuditorID').AsInteger = ACzyID then
        Result := True;
    end;
  end;
end;

function PSetBillAct(AZT: TWYZF_Bill_ACTION; ADJID: string; AYWLXDM: string; AGROUPID:String; var ASHJG: TWYZF_Bill_SHJG): Boolean;
var
  vSQL, vLogSQL, szSHXHSQL: string;
  szType, szDJZT, szFlag: string;
  ClientDataSetTmp: TClientDataSet;
  bFindNode: Boolean;
  currTime: string;  // Added by guozy 2013/4/22 ����һ 7:59:23
  szYWLX: string;  // Added by guozy 2013/4/22 ����һ 7:59:38
  // �жϽڵ��Ƿ��������
  function IsValidWFNode(ADJLX, ADJID, ATJ: string): Boolean;
  var
    vSQL: string;
    CdsData: TClientDataSet;
  begin
    Result := True;
    if Trim(ATJ) <> '' then
    begin
      vSQL := 'select Zfid from EBK_ZFXX where gsdm = ''' + GszGSDM + ''''
        + ' and KJND = ''' + GszKJND + ''''
        + ' and Zfid = ''' + ADJID + ''''
        + ' and ' + ATJ;
      CdsData := DataModulePub.GetCdsBySQL(vSQL);
      if not CdsData.IsEmpty then
        Result := True
      else
        Result := False;
    end;
  end;
begin
  Result := False;
  ClientDataSetTmp := TClientDataSet.Create(nil);
  ClientDataSetTmp.RemoteServer := DataModulePub.MidasConnectionPub;
  ClientDataSetTmp.ProviderName := 'DataSetProviderData';

  //���ҵ��ݶ�Ӧ�����������Ϣ
  vSQL := 'select * from pubworkflow'
    + ' where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''' and BizCode=''WYZF'''
    + ' and ISSTART=''��''';
  with ClientDataSetTmp do
  begin
    POpenSql(ClientDataSetTmp, vSQL);
    if RecordCount > 0 then
    begin
      ASHJG.DJID := ADJID;
      //ASHJG.DJLXID := 0;
      ASHJG.DJFlowCode := FieldByName('flowcode').AsString;
      ASHJG.DJFlowName := FieldByName('flowname').AsString;
      ASHJG.DJLXBM := 'WYZF';
      ASHJG.DJLXMC := '����֧��';
    end;
  end;
  if ASHJG.DJFlowCode = '' then
  begin
    SysMessage('��ǰ��������û������������̣�������������̺��ٽ��в�����', '_YB', [Pub_Message.mbOK]);
    Exit;
  end;

  case ASHJG.DJSHJG of
    barPASS: szType := 'ͨ��';
    //barBack: szType := '��ͨ��';
    barBack: szType := '�˻ص���һ��';
    barBInit: szType := '�˻ص�������';
  end;

  case AZT of
    baSS: //����
      begin
      //����������̵Ľڵ���Ϣ
        vSQL := 'select * from pubwfnode where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''''
          + ' and flowcode=''' + ASHJG.DJFlowCode + ''''
          + ' order by NodeSeq ';
        with ClientDataSetTmp do
        begin
          POpenSql(ClientDataSetTmp, vSQL);
          if RecordCount > 0 then
          begin
            First;
            while not Eof do
            begin
            //��������ĵ�ǰ��˽ڵ���-9
              ASHJG.DJCurrSHJD := -9;
              ASHJG.DJCurrSHJDName := '����';
            //�����������һ��˽ڵ���������̵Ŀ�ʼ�ڵ�
              if RecordCount = 1 then
              begin
//              if not IsValidWFNode(ASHJG.DJLXID, ASHJG.DJID, FieldByName('NodeCondition').AsString) then
//              begin
//                SysMessage('��ǰ������̴������⣬���޸�������̺��ٽ��в�����','_YB',[Pub_Message.mbOK]);
//              end
//              else
                begin
                  ASHJG.DJNextSHJD := FieldByName('NodeSeq').AsInteger;
                  ASHJG.DJNextSHJDName := FieldByName('NodeName').AsString;
                end;
              end
              else
              begin
                if IsValidWFNode(ASHJG.DJLXID, ASHJG.DJID, FieldByName('NodeCondition').AsString) then
                begin
                  ASHJG.DJNextSHJD := FieldByName('NodeSeq').AsInteger;
                  ASHJG.DJNextSHJDName := FieldByName('NodeName').AsString;
                  Break;
                end;
              end;
              Next;
            end;
          end;
        end;

      //���ɸ������
        vSQL := 'Update EBK_ZFXX Set DJZT=''1''' //����������
          + ',FlowCode=''' + ASHJG.DJFlowCode + ''''
          + ',CurSHJD=' + IntToStr(ASHJG.DJCurrSHJD)
          + ',NextSHJD=' + IntToStr(ASHJG.DJNextSHJD)
          + ',SHID=' + IntToStr(GCzy.ID)
          + ',SHR=''' + GCzy.name + ''''
          + ',SHSJ=''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ''''
          + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
          + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))
          + ' and ywlxdm=' + QuotedStr(AYWLXDM);
        try
          PExecSql(vSQL);
        except
          exit;
        end;
      end;
    baHS: //�ջ�
      begin
      //�жϵ�ǰ�����Ƿ��Ѿ���������ˣ�����У��������ջ�
        vSQL := 'select DJZT,CurSHJD,NextSHJD from EBK_ZFXX where gsdm=''' + GszGSDM + ''''
          + ' and KJND=''' + GszKJND + ''''
          + ' and Zfid=' + QuotedStr(ASHJG.DJID);
        with ClientDataSetTmp do
        begin
          POpenSql(ClientDataSetTmp, vSQL);
          if RecordCount > 0 then
          begin
            szDJZT := FieldByName('DJZT').AsString;
            if szDJZT = '-1' then
            begin
              SysMessage('��ǰ���������ϣ������ջء�', '_YB', [Pub_Message.mbOK]);
              Exit;
            end
            else if szDJZT = '0' then
            begin
              SysMessage('��ǰ����δ���󣬲����ջء�', '_YB', [Pub_Message.mbOK]);
              Exit;
            end
            else if (szDJZT = '2') or (szDJZT = '3') then
            begin
              SysMessage('��ǰ��������ˣ������ջء�', '_YB', [Pub_Message.mbOK]);
              Exit;
            end;

            ASHJG.DJCurrSHJD := FieldByName('CurSHJD').AsInteger;
            ASHJG.DJNextSHJD := FieldByName('NextSHJD').AsInteger;
            ASHJG.DJNextSHJDName := '�ջ�';
          end
          else
          begin
            SysMessage('��ǰ����δ�ҵ���', '_YB', [Pub_Message.mbOK]);
            Exit;
          end;
        end;
        vSQL := 'select nodename from pubwfnode where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''''
          + ' and flowcode=''' + ASHJG.DJFlowCode + ''' and nodeseq =' + IntToStr(ASHJG.DJCurrSHJD)
          + ' order by nodeseq';
        with ClientDataSetTmp do
        begin
          POpenSql(ClientDataSetTmp, vSQL);
          if RecordCount > 0 then
          begin
            ASHJG.DJCurrSHJDName := FieldByName('NodeName').AsString;
          end;
        end;

      //���ɸ������
        vSQL := 'Update EBK_ZFXX Set DJZT=''0''' //����δ����
          + ',FlowCode=''''' //����������
          + ',CurSHJD=0' //��˽ڵ���Ϣ�뵥�ݱ���ʱһ��
          + ',NextSHJD=-9'
          + ',SHID=' + IntToStr(GCzy.ID)
          + ',SHR=''' + GCzy.name + ''''
          + ',SHSJ=''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ''''
          + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
          + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))
          + ' and ywlxdm=' + QuotedStr(AYWLXDM);
        try
          PExecSql(vSQL);
        except
          exit;
        end;
      end;
    baSH: //���
      begin
      //����������̵Ľڵ���Ϣ
      //Ҫ���ҵ�ǰ��˽ڵ����һ�ڵ㣬�洢��ASHJG.DJNextSHJD��
      //ֻҪ���Ҵ��ڵ�ǰ��˽ڵ�ĵ�һ���ڵ㣬������һ��˽ڵ�
        vSQL := 'select * from pubwfnode where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''''
          + ' and flowcode=''' + ASHJG.DJFlowCode + ''' and nodeseq >=' + IntToStr(ASHJG.DJCurrSHJD)
          + ' order by nodeseq';
        with ClientDataSetTmp do
        begin
          POpenSql(ClientDataSetTmp, vSQL);
          if RecordCount > 0 then
          begin
            First;
            while not Eof do
            begin
              if ASHJG.DJCurrSHJD = FieldByName('NodeSeq').AsInteger then
              begin
                ASHJG.DJCurrSHJDName := FieldByName('NodeName').AsString;
              end;
              if FieldByName('IsEnd').AsString = '��' then //����ǽ����ڵ㣬��ڵ���Ź̶�Ϊ999
              begin
                ASHJG.DJNextSHJD := FieldByName('NodeSeq').AsInteger;
                ASHJG.DJNextSHJDName := FieldByName('NodeName').AsString;
              end
              else if FieldByName('NodeSeq').AsInteger > ASHJG.DJCurrSHJD then
              begin
                if IsValidWFNode(ASHJG.DJLXID, ASHJG.DJID, FieldByName('NodeCondition').AsString) then
                begin
                  ASHJG.DJNextSHJD := FieldByName('NodeSeq').AsInteger;
                  ASHJG.DJNextSHJDName := FieldByName('NodeName').AsString;
                  Break;
                end;
              end;
              Next;
            end;
          //��ǰ�ڵ����һ�ڵ㶼��999ʱ����ʾ�������Ҫ������
            if (ASHJG.DJCurrSHJD = ASHJG.DJNextSHJD) and (ASHJG.DJNextSHJD = 999) then
            begin
              ASHJG.DJNextSHJD := -1;
              ASHJG.DJNextSHJDName := '����';
            end;
          end
          else
          begin
            SysMessage('�������������Ϣʧ��!', '_YB', [Pub_Message.mbOK]);
            Exit;
          end;
        end;

      //���ɸ������
        vSQL := 'Update EBK_ZFXX Set DJZT=''2''' //���������
          + ',FlowCode=''' + ASHJG.DJFlowCode + '''' //�������
          + ',CurSHJD=' + IntToStr(ASHJG.DJCurrSHJD) //��ǰ��˽ڵ�
          + ',NextSHJD=' + IntToStr(ASHJG.DJNextSHJD) //��һ��˽ڵ�
          + ',SHID=' + IntToStr(GCzy.ID)
          + ',SHR=''' + GCzy.name + ''''
          + ',SHSJ=''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ''''
          + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
          + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))

          + ' and ywlxdm=' + QuotedStr(AYWLXDM);
        try
          PExecSql(vSQL);
        except
          exit;
        end;
      end;
    baXS: //����
      begin
      //����������Ľڵ���Ϣ
      //������Ҫ���ҵ�ǰ��˽ڵ����һ�ڵ�
        vSQL := 'select * from pubwfnode where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''''
          + ' and flowcode=''' + ASHJG.DJFlowCode + ''' and nodeseq <=' + IntToStr(ASHJG.DJCurrSHJD)
          + ' order by nodeseq';
        with ClientDataSetTmp do
        begin
          POpenSql(ClientDataSetTmp, vSQL);
          if RecordCount > 0 then
          begin
            ASHJG.DJNextSHJD := ASHJG.DJCurrSHJD;
            if RecordCount = 1 then
            begin
              szFlag := '1';
              ASHJG.DJCurrSHJD := -9;
              ASHJG.DJCurrSHJDName := '����';
              ASHJG.DJNextSHJD := FieldByName('NodeSeq').AsInteger;
              ASHJG.DJNextSHJDName := FieldByName('NodeName').AsString;
            end
            else
            begin
              Last;
              bFindNode := False;
              while not Bof do
              begin
                if ASHJG.DJNextSHJD = FieldByName('NodeSeq').AsInteger then
                begin
                  ASHJG.DJNextSHJDName := FieldByName('NodeName').AsString;
                end;
                if FieldByName('NodeSeq').AsInteger < ASHJG.DJCurrSHJD then
                begin
                  if IsValidWFNode(ASHJG.DJLXID, ASHJG.DJID, FieldByName('NodeCondition').AsString) then
                  begin
                    ASHJG.DJCurrSHJD := FieldByName('NodeSeq').AsInteger;
                    ASHJG.DJCurrSHJDName := FieldByName('NodeName').AsString;
                    bFindNode := True;
                    Break;
                  end;
                end;
                Prior;
              end;
              if not bFindNode then
              begin
                szFlag := '1';
                ASHJG.DJCurrSHJD := -9;
                ASHJG.DJCurrSHJDName := '����';
              end;
            end;
          end
          else
          begin
            SysMessage('�������������Ϣʧ��!', '_YB', [Pub_Message.mbOK]);
            Exit;
          end;
        end;
      //���ɸ������
        if szFlag = '1' then //���������״̬��
        begin
          vSQL := 'Update EBK_ZFXX Set DJZT=''1''' //����������
            + ',FlowCode=''' + ASHJG.DJFlowCode + '''' //�������
            + ',CurSHJD=-9' //��ǰ��˽ڵ�
            + ',NextSHJD=' + IntToStr(ASHJG.DJNextSHJD) //��һ��˽ڵ�
            + ',SHID=' + IntToStr(GCzy.ID)
            + ',SHR=''' + GCzy.name + ''''
            + ',SHSJ=''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ''''
            + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
            + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))
            + ' and ywlxdm=' + QuotedStr(AYWLXDM);
        end
        else
        begin
          vSQL := 'Update EBK_ZFXX Set DJZT=''2''' //���������
            + ',FlowCode=''' + ASHJG.DJFlowCode + '''' //�������
            + ',CurSHJD=' + IntToStr(ASHJG.DJCurrSHJD) //��ǰ��˽ڵ�
            + ',NextSHJD=' + IntToStr(ASHJG.DJNextSHJD) //��һ��˽ڵ�
            + ',SHID=' + IntToStr(GCzy.ID)
            + ',SHR=''' + GCzy.name + ''''
            + ',SHSJ=''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ''''
            + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
            + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))
            + ' and ywlxdm=' + QuotedStr(AYWLXDM);       // Added by guozy 2013/4/28 ������ 11:00:34
        end;
        try
          PExecSql(vSQL);
        except
          exit;
        end;
      end;
    baTH: //�˻أ�ֱ���˻ص�������
      begin
        if ASHJG.DJCurrSHJD = -9 then
          ASHJG.DJCurrSHJDName := '����'
        else
        begin
        //����������Ľڵ���Ϣ
          vSQL := 'select * from pubwfnode where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''''
            + ' and flowcode=''' + ASHJG.DJFlowCode + ''' and nodeseq =' + IntToStr(ASHJG.DJCurrSHJD)
            + ' order by nodeseq desc';
          with ClientDataSetTmp do
          begin
            POpenSql(ClientDataSetTmp, vSQL);
            if RecordCount > 0 then
            begin
              ASHJG.DJCurrSHJDName := FieldByName('NodeName').AsString;
            end
            else
            begin
              SysMessage('�������������Ϣʧ��!', '_YB', [Pub_Message.mbOK]);
              Exit;
            end;
          end;
        end;
        if ASHJG.DJNextSHJD > 0 then
        begin
          vSQL := 'select * from pubwfnode where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''''
            + ' and flowcode=''' + ASHJG.DJFlowCode + ''' and nodeseq =' + IntToStr(ASHJG.DJNextSHJD)
            + ' order by nodeseq desc';
          with ClientDataSetTmp do
          begin
            POpenSql(ClientDataSetTmp, vSQL);
            if RecordCount > 0 then
            begin
              ASHJG.DJNextSHJDName := FieldByName('NodeName').AsString;
            end
            else
            begin
              SysMessage('�������������Ϣʧ��!', '_YB', [Pub_Message.mbOK]);
              Exit;
            end;
          end;
        end;
      //���ɸ������
        vSQL := 'Update EBK_ZFXX Set DJZT=''0''' //����δ����
          + ',FlowCode=''''' //����������
          + ',CurSHJD=0' //��˽ڵ���Ϣ�뵥�ݱ���ʱһ��
          + ',NextSHJD=-9'
          + ',SHID=' + IntToStr(GCzy.ID)
          + ',SHR=''' + GCzy.name + ''''
          + ',SHSJ=''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ''''
          + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
          + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))

          + ' and ywlxdm=' + QuotedStr(AYWLXDM);
        try
          PExecSql(vSQL);
        except
          exit;
        end;
      end;
    baZX:
      begin
      //Ҫ��鵱ǰ�����Ƿ��Ѿ�������
        vSQL := 'select DJZT,CurSHJD,NextSHJD,ywlx from EBK_ZFXX where gsdm=''' + GszGSDM + ''''
          + ' and KJND=''' + GszKJND + ''''
          + ' and Zfid=' + QuotedStr(ASHJG.DJID);
        with ClientDataSetTmp do
        begin
          POpenSql(ClientDataSetTmp, vSQL);
          if RecordCount > 0 then
          begin
            szDJZT := FieldByName('DJZT').AsString;
            if szDJZT = '-1' then
            begin
              SysMessage('��ǰ���������ϣ�����֧����', '_YB', [Pub_Message.mbOK]);
              Exit;
            end
            else if szDJZT = '0' then
            begin
              SysMessage('��ǰ����δ���󣬲���֧����', '_YB', [Pub_Message.mbOK]);
              Exit;
            end
            else if (szDJZT = '2') then
            begin
              //���ݻ�δ��˽�����������֧��
              if not ((FieldByName('CurSHJD').AsInteger = 999) and (FieldByName('NextSHJD').AsInteger = -1)) then
              begin
                SysMessage('��ǰ���ݻ�δ����꣬����֧����', '_YB', [Pub_Message.mbOK]);
                Exit;
              end;
            end;
          end
          else
          begin
            SysMessage('��ǰ����δ�ҵ���', '_YB', [Pub_Message.mbOK]);
            Exit;
          end;
          szYWLX := Trim(FieldByName('ywlx').AsString);
          if ((szYWLX = 'ת��֧Ʊ') or (szYWLX = 'ת��֧Ʊ')) then begin
            //֧��ֻ���µ���״̬�����漰�������
            vSQL := 'Update EBK_ZFXX Set DJZT=''3'',' //������ִ��
              + ' ZXID = ' + IntToStr(GCzy.ID) + ','
              + ' ZXR = ''' + GCzy.name + ''','
              + ' ZXSJ = ''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ''''
              + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
              + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))
              + ' and ywlxdm=' + QuotedStr(AYWLXDM);
            try
              PExecSql(vSQL);
            except
              exit;
            end;
          end else if (szYWLX = '�ֽ�֧Ʊ') then begin
            //֧��ֻ���µ���״̬�����漰�������
            //����������ֱ����λ��֧��
            currTime := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
            vSQL := 'Update EBK_ZFXX Set DJZT=''3'',' //������ִ��
              + ' ZXID = ' + IntToStr(GCzy.ID) + ','
              + ' ZXR = ''' + GCzy.name + ''','
              + ' zfzt = ''֧���ɹ�'', '
              + ' ZXSJ = ''' + currTime + ''','
              + ' ZFSJ = ''' + currTime + ''' '
              + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
              + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))
              + ' and ywlxdm=' + QuotedStr(AYWLXDM);
            try
              PExecSql(vSQL);
            except
              exit;
            end;
          end;
        end;
      end;

    baFZX: // ��֧��
      begin
      //Ҫ��鵱ǰ����
        vSQL := 'select DJZT,CurSHJD,NextSHJD from EBK_ZFXX where gsdm=''' + GszGSDM + ''''
          + ' and KJND=''' + GszKJND + ''''
          + ' and Zfid=' + QuotedStr(ASHJG.DJID);
        with ClientDataSetTmp do
        begin
          POpenSql(ClientDataSetTmp, vSQL);
          if RecordCount > 0 then
          begin
            szDJZT := FieldByName('DJZT').AsString;
            if szDJZT <> '3' then
            begin
              SysMessage('��ǰ����δ֧��������ȡ��֧����', '_YB', [Pub_Message.mbOK]);
              Exit;
            end;
          end
          else
          begin
            SysMessage('��ǰ����δ�ҵ���', '_YB', [Pub_Message.mbOK]);
            Exit;
          end;
        end;
      //
        vSQL := 'Update EBK_ZFXX Set DJZT=''2'',' //���������
          + ' ZXID = -1,'
          + ' ZXR = '''','
          + ' ZXSJ = '''' '
          + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
          + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))
          + ' and ywlxdm=' + QuotedStr(AYWLXDM);
        try
          PExecSql(vSQL);
        except
          exit;
        end;
      end;
  end;

  //���������־
  if GDbType = MSSQL then
  begin
    vLogSQL := ' Begin Transaction ' +
      ' declare @ierrCount int ' +
      ' declare @SHXH      int ' +
      ' select  @ierrcount=0 ';
    szSHXHSQL := '@SHXH + 1';
  end
  else if GDbType = ORACLE then
  begin
    vLogSQL := 'begin ' +
      ' declare ' +
      '  ierrCount smallint; ' +
      '  iSHXH     smallint; ' +
      ' begin ' +
      ' begin ';
    szSHXHSQL := '(iSHXH+1)';
  end;
  if GDbType = MSSQL then
  begin
    vLogSQL := vLogSQL + '' +
      ' select  @SHXH=Max(LOGID) ' +
      ' from PUBAUDITLOG ' +
      ' where Gsdm=''' + GszGSDM + ''' ' +
      '   and kjnd=''' + GszKJND + ''' ';
    vLogSQL := vLogSQL + ' if @SHXH is null select @SHXH=0 ';
  end
  else if GDbType = ORACLE then
  begin
    vLogSQL := vLogSQL + '' +
      ' select  Max(LOGID) into iSHXH ' +
      ' from PUBAUDITLOG ' +
      ' where Gsdm=''' + GszGSDM + ''' ' +
      '   and kjnd=''' + GszKJND + ''' ';
    vLogSQL := vLogSQL + '; ' +
      ' if iSHXH is null then select 0 into iSHXH from dual; end if;  ';
  end;

  vLogSQL := vLogSQL + ' insert into PUBAUDITLOG( ' +
    '   Gsdm,Kjnd,LOGID,BILLID,BILLNAME,FLOWCODE,FLOWNAME,MODNAME,BIZNAME,NODESEQ,NODENAME,AUDITORID,AUDITOR,ADATETIME,REMARK,ATYPE,AMT)' +
    '   values( ' +
    '''' + GszGSDM + ''', ' +
    '''' + GszKJND + ''', ' +
    '' + szSHXHSQL + ', ' +
    '''' + ASHJG.DJID + ''', ' +
    '''' + ASHJG.DJLXMC + ''',' +
    '''' + ASHJG.DJFlowCode + ''', ' +
    '''' + ASHJG.DJFlowName + ''',' +
    '''WYZF'',' +
    '''' + ASHJG.DJLXMC + ''',' +
    '' + IntToStr(ASHJG.DJCurrSHJD) + ',' +
    '''' + ASHJG.DJCurrSHJDName + ''',' +
    '' + inttostr(GCzy.id) + ',' +
    '''' + GCzy.name + ''', ' +
    '''' + GszYWRQ + FormatDateTime('hhmmss', Now) + ''', ' +
    '''' + ASHJG.DJSHYJ + ''',' +
    '''' + szType + ''',' +
    '' + FloatToStr(ASHJG.DJJE)
    + ')' + GszDbFgf;
  if GDbType = MSSQL then
  begin
    vLogSQL := vLogSQL + '  if @ierrCount= 0  begin ' +
      '   Select Res=' + szSHXHSQL +
      '    commit transaction end ' +
      ' else  ' +
      ' begin ' +
      '    select Res=0 rollback transaction ' +
      ' end ';
  end
  else if GDbType = ORACLE then
  begin
    vLogSQL := vLogSQL + '    commit; ' +
      '    select ' + szSHXHSQL + ' into ierrCount from dual ; ' +
      '  Exception ' +
      '    when others then ' +
      '      RollBack; ' +
      '      select 0 into ierrCount from dual ; ' +
      '  end ; ' +
      '  Open :pRecCur for ' +
      '    select ierrCount RES from dual; ' +
      ' end; ' +
      ' end; ';
  end;

  with ClientDataSetTmp do
  begin
    try
      POpenSQL(ClientDataSetTmp, vLogSQL);
    except
      Close;
      //Screen.Cursor := crDefault ;
      abort;
      Exit;
    end;
    if findfirst then
    begin
      if fieldbyname('RES').asinteger = 0 then
      begin
        //Screen.Cursor := crDefault ;
        abort;
        Exit;
      end
      else
      begin
        Result := True;
      end;
    end;
  end;
end;

function SaveParams(CSMC, CSZ:String):Boolean;
begin
  if GEBKParams.Locate('CSMC', CSMC, []) then
    GEBKParams.Edit
  else
  begin
    GEBKParams.Append;
    GEBKParams.FieldByName('GSDM').AsString := GszGSDM;
    GEBKParams.FieldByName('KJND').AsString := GszKJND;
    GEBKParams.FieldByName('CSMC').AsString := CSMC;
  end;
  GEBKParams.FieldByName('CSZ').AsString := CSZ;
  GEBKParams.Post;
end;

function ReadParams(CSMC:String):String;
begin
  Result := '';
  if GEBKParams.Locate('CSMC', CSMC, []) then
    Result := GEBKParams.FieldByName('CSZ').AsString;
end;

procedure InitJSFS;
var
  sSql: string;
begin
  sSql := 'select t.* from zb_jsfs t where t.wyzf=''1'' and t.gsdm='''+gszGsdm + ''' and t.kjnd=''' + GszKJND + '''';
  GszJSFSDM := '';
  GszJSFSMC := '';
  GszJSFS_XJZP := '';
  if dataModulepub = nil then exit;
  with dataModulepub.ClientDataSetTmp do
  begin
    POpenSql(dataModulepub.ClientDataSetTmp, sSQL);
    if FindFirst then begin
      first;
      while not Eof do begin
        if GszJSFSDM <> '' then begin
          GszJSFSDM := GszJSFSDM + ',';
          GszJSFSMC := GszJSFSMC + ',';
          GszJSFS_XJZP := GszJSFS_XJZP + ',';
        end;
        GszJSFSDM := GszJSFSDM + FieldbyName('JSFSDM').AsString;
        GszJSFSMC := GszJSFSMC + FieldbyName('JSFSMC').AsString;
        //if (FieldByName('WYXJZP').IsNull) or (FieldByName('WYXJZP').AsString<>'1') then begin
        //  GszJSFSMC := GszJSFSMC + '0';
        //end else
        if FieldByName('WYXJZP').AsString='1' then begin
          GszJSFS_XJZP := GszJSFS_XJZP + '1';
        end else begin
          GszJSFS_XJZP := GszJSFS_XJZP + '0';
        end;
        next;
      end;
    end;
  end;
end;


procedure InitModeCodeAndName(Acbb:TComboBox);
var
  sSql: string;
begin
  Acbb.Items.Clear;
  sSql := ' select * from ebk_srmklx ';
  if dataModulepub = nil then exit;
  GszModCode := 'ȫ��';
  gszModName := 'ȫ��';
  Acbb.Items.Add('ȫ��');
  with dataModulepub.ClientDataSetTmp do
  begin
    POpenSql(dataModulepub.ClientDataSetTmp, sSQL);
    if FindFirst then begin
      first;
      while not Eof do begin
        if GszModCode <> '' then begin
          GszModCode := GszModCode + ',';
          gszModName := gszModName + ',';
        end;
        GszModCode := GszModCode + FieldbyName('ModCode').AsString;
        gszModName := gszModName + FieldbyName('ModName').AsString;
        Acbb.Items.Add(FieldByName('ModCode').AsString+' '+FieldByName('ModName').AsString);
        next;
      end;
    end;
  end;
end;

//���нӿ�����
procedure InitTypeCodeAndName(Acbb:TComboBox);
var
  sSql: string;
begin
  Acbb.Items.Clear;
  sSql := ' select * from EBK_YHJKLX WHERE JKSYFS LIKE ''%wyzf%'' ';
  if dataModulepub = nil then exit;
  with dataModulepub.ClientDataSetTmp do
  begin
    POpenSql(dataModulepub.ClientDataSetTmp, sSQL);
    if FindFirst then begin
      first;
      while not Eof do begin
        if GszTypeCode <> '' then begin
          GszTypeCode := GszTypeCode + ',';
          gszTypeName := gszTypeName + ',';
        end;
        GszTypeCode := GszTypeCode + FieldbyName('JKLXID').AsString;
        gszTypeName := gszTypeName + FieldbyName('JKLXNAME').AsString;
        Acbb.Items.Add(FieldByName('JKLXID').AsString+' '+FieldByName('JKLXNAME').AsString);
        next;
      end;
    end;
  end;
end;

//���нӿ����ͣ�����ȫ����
procedure InitTypeCodeAndName2(Acbb:TComboBox);
var
  sSql: string;
begin
  Acbb.Items.Clear;
  sSql := ' select * from EBK_YHJKLX WHERE JKSYFS LIKE ''%wyzf%'' ';
  if dataModulepub = nil then exit;
  GszTypeCode2 := 'ȫ��';
  gszTypeName2 := 'ȫ��';
  Acbb.Items.Add('ȫ��');
  with dataModulepub.ClientDataSetTmp do
  begin
    POpenSql(dataModulepub.ClientDataSetTmp, sSQL);
    if FindFirst then begin
      first;
      while not Eof do begin
        if GszTypeCode2 <> '' then begin
          GszTypeCode2 := GszTypeCode2 + ',';
          gszTypeName2 := gszTypeName2 + ',';
        end;
        GszTypeCode2 := GszTypeCode2 + FieldbyName('JKLXID').AsString;
        gszTypeName2 := gszTypeName2 + FieldbyName('JKLXNAME').AsString;
        Acbb.Items.Add(FieldByName('JKLXID').AsString+' '+FieldByName('JKLXNAME').AsString);
        next;
      end;
    end;
  end;
end;


procedure InitGroupCodeAndName(Acbb:TComboBox);
var
  sSql: string;
begin
  Acbb.Items.Clear;
  sSql := ' select distinct GroupID,GroupName from EBK_ZFXX where GroupID is not null ';
  if dataModulepub = nil then exit;
  GszGroupCode := 'ȫ��';
  gszGroupName := 'ȫ��';
  Acbb.Items.Add('ȫ��');
  with dataModulepub.ClientDataSetTmp do
  begin
    POpenSql(dataModulepub.ClientDataSetTmp, sSQL);
    if FindFirst then begin
      first;
      while not Eof do begin
        if GszGroupCode <> '' then begin
          GszGroupCode := GszGroupCode + ',';
          gszGroupName := gszGroupName + ',';
        end;
        GszGroupCode := GszGroupCode + FieldbyName('GroupID').AsString;
        gszGroupName := gszGroupName + FieldbyName('GroupName').AsString;
        Acbb.Items.Add(FieldByName('GroupID').AsString+' '+FieldByName('GroupName').AsString);
        next;
      end;
    end;
  end;
end;

procedure InitBankCbb(Acbb:TComboBox);
var
  sSql: string;
begin

  Acbb.Items.Clear;
  sSQL := 'select DEPID, DEP_NAME from EBK_DEPID order by depid ';
  POpenSQL(DataModulePub.ClientDataSetTmp, sSQL);

  with DataModulePub.ClientDataSetTmp do
  begin
    if FindFirst then
    begin
      while not Eof do
      begin
        Acbb.Items.Add(FieldByName('DEPID').AsString+' '+FieldByName('DEP_NAME').AsString);
        Next;
      end;
    end;
    Close;
  end;
end;

procedure InitBankForYHZL(Acbb:TComboBox);
var
  sSql: string;
begin

  Acbb.Items.Clear;
  sSQL := 'select YHDM, YHMC from ZB_YHZL WHERE GSDM = '''+GszHSDWDM+''' and KJND = '''+GszKJND+''' order by YHDM ';
  POpenSQL(DataModulePub.ClientDataSetTmp, sSQL);

  with DataModulePub.ClientDataSetTmp do
  begin
    if FindFirst then
    begin
      while not Eof do
      begin
        Acbb.Items.Add(FieldByName('YHDM').AsString+' '+FieldByName('YHMC').AsString);
        Next;
      end;
    end;
    Close;
  end;
end;

procedure InitYHZHCbb(Acbb:TComboBox);
var
  sSql: string;
begin

  Acbb.Items.Clear;
  sSQL := 'select zh.yhzh,zh.yhzhmc from pubszdwzh zh where zh.gsdm='+QuotedStr(GszGSDM)+' and zh.kjnd='+QuotedStr(GszKJND);
  sSql := sSql + ' and zh.wyzf=''1'' ';

  POpenSQL(DataModulePub.ClientDataSetTmp, sSQL);

  with DataModulePub.ClientDataSetTmp do
  begin
    if FindFirst then
    begin
      while not Eof do
      begin
        Acbb.Items.Add(FieldByName('yhzh').AsString+' '+FieldByName('yhzhmc').AsString);
        Next;
      end;
    end;
    Close;
  end;
end;

function getJSFSDM(aIndex: integer): string;
var
  slJSFSDM: TStringList;
  resultStr: string;
begin
  if aIndex < 0 then begin
    Result := '';
    Exit;
  end;
  slJSFSDM := TStringList.Create;
  slJSFSDM.CommaText := GszJSFSDM;
  resultStr := slJSFSDM.Strings[aIndex];
  slJSFSDM.Free;
  Result := resultStr;
end;

function getJSFSMC(aIndex: integer): string;
var
  slJSFSMC: TStringList;
  resultStr: string;
begin
  if aIndex < 0 then begin
    Result := '';
    Exit;
  end;
  slJSFSMC := TStringList.Create;
  slJSFSMC.CommaText := GszJSFSMC;
  resultStr := slJSFSMC.Strings[aIndex];
  slJSFSMC.Free;
  Result := resultStr;
end;


function getModCode(aIndex: integer): string;
var
  slModCode: TStringList;
  resultStr: string;
begin
  if aIndex < 0 then begin
    Result := '';
    Exit;
  end;
  slModCode := TStringList.Create;
  slModCode.CommaText := GszModCode;
  resultStr := slModCode.Strings[aIndex];
  slModCode.Free;
  Result := resultStr;
end;

function getModName(aIndex: integer): string;
var
  slModName: TStringList;
  resultStr: string;
begin
  if aIndex < 0 then begin
    Result := '';
    Exit;
  end;
  slModName := TStringList.Create;
  slModName.CommaText := gszModName;
  resultStr := slModName.Strings[aIndex];
  slModName.Free;
  Result := resultStr;
end;

function getSJLYIndex(aModCode: string): Integer;
var
  slModCode: TStringList;
  resultInt: Integer;
begin
  if aModCode = '' then begin
    Result := -1;
    exit;
  end;
  slModCode := TStringList.Create;
  slModCode.CommaText := GszModCode;
  resultInt := slModCode.IndexOf(aModCode);
  slModCode.Free;
  Result := resultInt;
end;

function getJKLXIndex(aTypeCode: string): Integer;
var
  slTypeCode: TStringList;
  resultInt: Integer;
begin
  if aTypeCode = '' then begin
    Result := -1;
    exit;
  end;
  slTypeCode := TStringList.Create;
  slTypeCode.CommaText := GszTypeCode;
  resultInt := slTypeCode.IndexOf(aTypeCode);
  slTypeCode.Free;
  Result := resultInt;
end;

function getGroupIndex(aGroupCode: string): Integer;
var
  slGroupCode: TStringList;
  resultInt: Integer;
begin
  if aGroupCode = '' then begin
    Result := -1;
    exit;
  end;
  slGroupCode := TStringList.Create;
  slGroupCode.CommaText := GszGroupCode;
  resultInt := slGroupCode.IndexOf(aGroupCode);
  slGroupCode.Free;
  Result := resultInt;
end;

function getTypeCode(aIndex: integer): string;
var
  slTypeCode: TStringList;
  resultStr: string;
begin
  if aIndex < 0 then begin
    Result := '';
    Exit;
  end;
  slTypeCode := TStringList.Create;
  slTypeCode.CommaText := GszTypeCode;
  resultStr := slTypeCode.Strings[aIndex];
  slTypeCode.Free;
  Result := resultStr;
end;

function getTypeCode2(aIndex: integer): string;
var
  slTypeCode: TStringList;
  resultStr: string;
begin
  if aIndex < 0 then begin
    Result := '';
    Exit;
  end;
  slTypeCode := TStringList.Create;
  slTypeCode.CommaText := GszTypeCode2;
  resultStr := slTypeCode.Strings[aIndex];
  slTypeCode.Free;
  Result := resultStr;
end;


function getTypeName(aIndex: integer): string;
var
  slTypeName: TStringList;
  resultStr: string;
begin
  if aIndex < 0 then begin
    Result := '';
    Exit;
  end;
  slTypeName := TStringList.Create;
  slTypeName.CommaText := gszTypeName;
  resultStr := slTypeName.Strings[aIndex];
  slTypeName.Free;
  Result := resultStr;
end;

function getGroupCode(aIndex: integer): string;
var
  slGroupCode: TStringList;
  resultStr: string;
begin
  if aIndex < 0 then begin
    Result := '';
    Exit;
  end;
  slGroupCode := TStringList.Create;
  slGroupCode.CommaText := GszGroupCode;
  resultStr := slGroupCode.Strings[aIndex];
  slGroupCode.Free;
  Result := resultStr;
end;

function getJSFSMCIndex(aJSFSDM: string): Integer;
var
  slJSFSDM: TStringList;
  resultInt: Integer;
begin
  if aJSFSDM = '' then begin
    Result := -1;
    exit;
  end;
  slJSFSDM := TStringList.Create;
  slJSFSDM.CommaText := GszJSFSDM;
  resultInt := slJSFSDM.IndexOf(aJSFSDM);
  slJSFSDM.Free;
  Result := resultInt;
end;

function currJSFSIsXJZP(aIndex: Integer): string;
var
  slJSFS_XJZP: TStringList;
  resultStr: string;
begin
  if aIndex < 0 then begin
    Result := '0';
    Exit;
  end;
  slJSFS_XJZP := TStringList.Create;
  slJSFS_XJZP.CommaText := GszJSFS_XJZP;
  resultStr := slJSFS_XJZP.Strings[aIndex];
  slJSFS_XJZP.Free;
  Result := resultStr;
end;


function getNewLSH(sGSDM, sKJND, sYWLXDM: string): string;
var
  tmpID: string;
begin
  tmpID := '';
  with DataModulePub.ClientDataSetTmp do
  begin
    POpenSql(DataModulePub.ClientDataSetTmp, 'select max(a.Zfid) as maxid from '
      + ' (select t.zfid from ebk_zfxx t '
      + '   where t.gsdm = ''' + sGSDM + ''''
      + '   and t.KJND = ''' + sKJND + ''''
      //+ '   and t.ywlxdm = ''' + sYWLXDM + ''''
      + ' union '
      + ' select t.newpackageid from ebk_zfxx t'
      + '   where t.gsdm = ''' + sGSDM + ''''
      + '   and t.KJND = ''' + sKJND + ''''
      //+ '   and t.ywlxdm = ''' + sYWLXDM + ''''
      + ' ) a ');
    if FindFirst and (Trim(FieldByName('maxid').AsString) <> '') then
    begin
      if Length(FieldByName('maxid').AsString) >= 8 then
        tmpID := IntToStr(StrToInt(Copy(FieldByName('maxid').AsString, 5, 8)) + 1)
      else
        tmpID := '00000001';
      while Length(tmpID) < 8 do
      begin
        tmpID := '0' + tmpID;
      end;
    end
    else
      tmpID := '00000001';
    tmpID := sKJND + tmpID;
    Close;
  end;
  Result := tmpID;
end;


initialization
  
finalization
  GEBKParams.Free;
end.


