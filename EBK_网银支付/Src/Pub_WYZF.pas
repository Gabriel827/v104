unit Pub_WYZF;

interface

uses Classes, StdCtrls, DBClient, Pub_Message;

type
  //单据状态
  TWYZF_Bill_Status = (
    djWSHH, //未审核 
    djSSH, //已送审
    djSHH, //已审核
    djTH, //退回
    djHS, //收回
    djHY, //已还原
    djZX, //已执行
    djZF //作废
    );
  //单据操作类型
  TWYZF_Bill_Action = (
    baSave, //单据保存
    baSS, //单据送审
    baSH, //单据审核
    baXS, //单据销审
    baTH, //单据退回
    baHS, //单据收回
    baZF, //单据作废
    baHY, //单据还原
    baSC, //单据删除
    baZX, //单据执行
    baFZX, //单据反执行
    baNOUKEY //UKey验证不通过
    );

  //单据操作结果
  TWYZF_Bill_ActResult = (barPASS, //通过
    barBack, //退回
    barBInit //退回编制人
    );
    
  //单据审核结构
  TWYZF_Bill_SHJG = record
    DJLXID: string; //单据类型ID
    DJLXBM: string; //单据类型编码
    DJLXMC: string; //单据类型名称
    DJID: string; //单据ID
    DJFlowCode: string; //单据审核流程
    DJFlowName: string; //单据审核流程名
    DJCurrSHJD: Integer; //单据当前审核节点
    DJCurrSHJDName: string; //单据当前审核节点名称
    DJNextSHJD: Integer; //单据下一审核节点
    DJNextSHJDName: string; //单据下一审核节点名称
    SrcDJCurrSHJD: Integer; //保存单据当前审核节点
    SrcDJCurrSHJDName: string; //保存单据当前审核节点名称
    SrcDJNextSHJD: Integer; //保存单据下一审核节点
    SrcDJNextSHJDName: string; //保存单据下一审核节点名
    DJSHYJ: string; //单据审核意见
    DJSHJG: TWYZF_Bill_ActResult; //单据操作结果
    DJJE: Extended; //单据金额
  end;

  TWYZFRec = record
    ZFID: string;
    YWND: string;
    YWRQ: string;
    YWLXDM: string;
    YWLXMC: string;
    YWYH: string;
    // 支付信息
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
    ZXSJ: string;  // Added by guozy 2013/4/19 星期五 14:46:42
    ZFSJ: string;  // Added by guozy 2013/4/19 星期五 14:46:46
    //
    SFTH:string;
    DJStatus: TWYZF_Bill_Status; //单据状态
    SHFlow: string; //审核流程
    CurSHJD: Integer; //当前审核节点
    NextSHJD: Integer; //下一审核节点
    CurSHJDMC: string; //当前审核节点
    NextSHJDMC: string; //下一审核节点
    SBANKUQNO: string;  //银行唯一号
    SBUSIUQNO: string;  //原支付交易流水号
    SHEADBUSIUQNO: string;  //主交易流水号
    SDEPID: string;  //收款银行机构号
    CLXX: string;  //受理反馈信息
    ZFXX: string;  //支付反馈信息
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
  GN_WYZF_SGSB: string = '73012';    //手工失败
  GN_WYZF_SGCG: string = '73013';    //手工成功
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
  // 不用了
  GN_WYZF_SH1: string = '1';
  GN_WYZF_SH2: string = '2';


var
  bWYZFQYSHL: Boolean;
  GEBKParams:TClientDataSet;
  GszJSFSDM, GszJSFSMC, GszJSFS_XJZP: widestring;
  GszModCode, gszModName: string;
  GszTypeCode, gszTypeName: string;  //没有全部
  GszTypeCode2, gszTypeName2: string;  //有全部
  GszGroupCode, gszGroupName: string;
  GEBK_BankAcc:Integer=0;     //记录ebk_yhjk的银行数量
  GEBK_BankAccount:Integer=10000000;     //记录加密的银行数量  
  function PWriteYHCzrz(ACznr: string): integer;
  function PGetCzySHQX(ACzyID: Integer; ASHFlow: string; ACurrSHJD: Integer): Boolean;
  function PSetBillAct(AZT: TWYZF_Bill_Action; ADJID: string; AYWLXDM: string; AGROUPID:String; var ASHJG: TWYZF_Bill_SHJG): Boolean;
  function SaveParams(CSMC, CSZ:String):Boolean;
  function ReadParams(CSMC:String):String;
  procedure InitJSFS;
  procedure InitModeCodeAndName(Acbb:TComboBox);
  procedure InitTypeCodeAndName(Acbb:TComboBox);   //没有全部
  procedure InitTypeCodeAndName2(Acbb:TComboBox);  //有全部
  procedure InitGroupCodeAndName(Acbb:TComboBox);
  procedure InitBankCbb(Acbb:TComboBox);
  procedure InitBankForYHZL(Acbb:TComboBox);
  procedure InitYHZHCbb(Acbb:TComboBox);
  function getJSFSDM(aIndex: integer): string;
  function getJSFSMC(aIndex: integer): string;
  function getModCode(aIndex: integer): string;
  function getModName(aIndex: integer): string;
  function getTypeCode(aIndex: integer): string;   //没有全部
  function getTypeCode2(aIndex: integer): string;  //有全部
  function getTypeName(aIndex: integer): string;
  function getGroupCode(aIndex: integer): string;
  function getSJLYIndex(aModCode: string): Integer;
  function getJKLXIndex(aTypeCode: string): Integer;
  function getGroupIndex(aGroupCode: string): Integer;
  function getJSFSMCIndex(aJSFSDM: string): Integer;
  function currJSFSIsXJZP(aIndex: Integer): string;
  function getNewLSH(sGSDM, sKJND, sYWLXDM: string): string;
  //获得是否进先UKey验证
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
    if RecordCount > 0 then //存在则表示当前操作员在此节点有审核权限
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
    if RecordCount > 0 then //存在则表示当前操作员在此节点有审核权限
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
  currTime: string;  // Added by guozy 2013/4/22 星期一 7:59:23
  szYWLX: string;  // Added by guozy 2013/4/22 星期一 7:59:38
  // 判断节点是否符合条件
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

  //查找单据对应的审核流程信息
  vSQL := 'select * from pubworkflow'
    + ' where gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''' and BizCode=''WYZF'''
    + ' and ISSTART=''是''';
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
      ASHJG.DJLXMC := '网银支付';
    end;
  end;
  if ASHJG.DJFlowCode = '' then
  begin
    SysMessage('当前单据类型没有启用审核流程，请启用审核流程后再进行操作。', '_YB', [Pub_Message.mbOK]);
    Exit;
  end;

  case ASHJG.DJSHJG of
    barPASS: szType := '通过';
    //barBack: szType := '不通过';
    barBack: szType := '退回到上一步';
    barBInit: szType := '退回到编制人';
  end;

  case AZT of
    baSS: //送审
      begin
      //查找审核流程的节点信息
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
            //送审操作的当前审核节点是-9
              ASHJG.DJCurrSHJD := -9;
              ASHJG.DJCurrSHJDName := '送审';
            //送审操作的下一审核节点是审核流程的开始节点
              if RecordCount = 1 then
              begin
//              if not IsValidWFNode(ASHJG.DJLXID, ASHJG.DJID, FieldByName('NodeCondition').AsString) then
//              begin
//                SysMessage('当前审核流程存在问题，请修改审核流程后再进行操作。','_YB',[Pub_Message.mbOK]);
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

      //生成更新语句
        vSQL := 'Update EBK_ZFXX Set DJZT=''1''' //单据已送审
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
    baHS: //收回
      begin
      //判断当前单据是否已经有人审核了，如果有，则不允许收回
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
              SysMessage('当前单据已作废，不能收回。', '_YB', [Pub_Message.mbOK]);
              Exit;
            end
            else if szDJZT = '0' then
            begin
              SysMessage('当前单据未送审，不能收回。', '_YB', [Pub_Message.mbOK]);
              Exit;
            end
            else if (szDJZT = '2') or (szDJZT = '3') then
            begin
              SysMessage('当前单据已审核，不能收回。', '_YB', [Pub_Message.mbOK]);
              Exit;
            end;

            ASHJG.DJCurrSHJD := FieldByName('CurSHJD').AsInteger;
            ASHJG.DJNextSHJD := FieldByName('NextSHJD').AsInteger;
            ASHJG.DJNextSHJDName := '收回';
          end
          else
          begin
            SysMessage('当前单据未找到。', '_YB', [Pub_Message.mbOK]);
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

      //生成更新语句
        vSQL := 'Update EBK_ZFXX Set DJZT=''0''' //单据未送审
          + ',FlowCode=''''' //清空审核流程
          + ',CurSHJD=0' //审核节点信息与单据保存时一样
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
    baSH: //审核
      begin
      //查找审核流程的节点信息
      //要查找当前审核节点的下一节点，存储到ASHJG.DJNextSHJD中
      //只要查找大于当前审核节点的第一个节点，就是下一审核节点
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
              if FieldByName('IsEnd').AsString = '是' then //如果是结束节点，则节点序号固定为999
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
          //当前节点和下一节点都是999时，表示审核流程要结束了
            if (ASHJG.DJCurrSHJD = ASHJG.DJNextSHJD) and (ASHJG.DJNextSHJD = 999) then
            begin
              ASHJG.DJNextSHJD := -1;
              ASHJG.DJNextSHJDName := '结束';
            end;
          end
          else
          begin
            SysMessage('查找审核流程信息失败!', '_YB', [Pub_Message.mbOK]);
            Exit;
          end;
        end;

      //生成更新语句
        vSQL := 'Update EBK_ZFXX Set DJZT=''2''' //单据已审核
          + ',FlowCode=''' + ASHJG.DJFlowCode + '''' //审核流程
          + ',CurSHJD=' + IntToStr(ASHJG.DJCurrSHJD) //当前审核节点
          + ',NextSHJD=' + IntToStr(ASHJG.DJNextSHJD) //下一审核节点
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
    baXS: //销审
      begin
      //查找审核流的节点信息
      //销审是要查找当前审核节点的上一节点
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
              ASHJG.DJCurrSHJDName := '送审';
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
                ASHJG.DJCurrSHJDName := '送审';
              end;
            end;
          end
          else
          begin
            SysMessage('查找审核流程信息失败!', '_YB', [Pub_Message.mbOK]);
            Exit;
          end;
        end;
      //生成更新语句
        if szFlag = '1' then //销审到送审后状态了
        begin
          vSQL := 'Update EBK_ZFXX Set DJZT=''1''' //单据已送审
            + ',FlowCode=''' + ASHJG.DJFlowCode + '''' //审核流程
            + ',CurSHJD=-9' //当前审核节点
            + ',NextSHJD=' + IntToStr(ASHJG.DJNextSHJD) //下一审核节点
            + ',SHID=' + IntToStr(GCzy.ID)
            + ',SHR=''' + GCzy.name + ''''
            + ',SHSJ=''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ''''
            + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
            + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))
            + ' and ywlxdm=' + QuotedStr(AYWLXDM);
        end
        else
        begin
          vSQL := 'Update EBK_ZFXX Set DJZT=''2''' //单据已审核
            + ',FlowCode=''' + ASHJG.DJFlowCode + '''' //审核流程
            + ',CurSHJD=' + IntToStr(ASHJG.DJCurrSHJD) //当前审核节点
            + ',NextSHJD=' + IntToStr(ASHJG.DJNextSHJD) //下一审核节点
            + ',SHID=' + IntToStr(GCzy.ID)
            + ',SHR=''' + GCzy.name + ''''
            + ',SHSJ=''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ''''
            + ' where gsdm=''' + GszGSDM + ''' and KJND=''' + GszKJND + ''''
            + IFF(AGROUPID='',  ' and Zfid=' + QuotedStr(ASHJG.DJID), ' and GROUPID=' + QuotedStr(AGROUPID))
            + ' and ywlxdm=' + QuotedStr(AYWLXDM);       // Added by guozy 2013/4/28 星期日 11:00:34
        end;
        try
          PExecSql(vSQL);
        except
          exit;
        end;
      end;
    baTH: //退回，直接退回到编制人
      begin
        if ASHJG.DJCurrSHJD = -9 then
          ASHJG.DJCurrSHJDName := '送审'
        else
        begin
        //查找审核流的节点信息
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
              SysMessage('查找审核流程信息失败!', '_YB', [Pub_Message.mbOK]);
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
              SysMessage('查找审核流程信息失败!', '_YB', [Pub_Message.mbOK]);
              Exit;
            end;
          end;
        end;
      //生成更新语句
        vSQL := 'Update EBK_ZFXX Set DJZT=''0''' //单据未送审
          + ',FlowCode=''''' //清空审核流程
          + ',CurSHJD=0' //审核节点信息与单据保存时一样
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
      //要检查当前单据是否已经审核完成
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
              SysMessage('当前单据已作废，不能支付。', '_YB', [Pub_Message.mbOK]);
              Exit;
            end
            else if szDJZT = '0' then
            begin
              SysMessage('当前单据未送审，不能支付。', '_YB', [Pub_Message.mbOK]);
              Exit;
            end
            else if (szDJZT = '2') then
            begin
              //单据还未审核结束，不允许支付
              if not ((FieldByName('CurSHJD').AsInteger = 999) and (FieldByName('NextSHJD').AsInteger = -1)) then
              begin
                SysMessage('当前单据还未审核完，不能支付。', '_YB', [Pub_Message.mbOK]);
                Exit;
              end;
            end;
          end
          else
          begin
            SysMessage('当前单据未找到。', '_YB', [Pub_Message.mbOK]);
            Exit;
          end;
          szYWLX := Trim(FieldByName('ywlx').AsString);
          if ((szYWLX = '转账支票') or (szYWLX = '转账支票')) then begin
            //支付只更新单据状态，不涉及审核流程
            vSQL := 'Update EBK_ZFXX Set DJZT=''3'',' //单据已执行
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
          end else if (szYWLX = '现金支票') then begin
            //支付只更新单据状态，不涉及审核流程
            //不经过网银直接置位已支付
            currTime := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
            vSQL := 'Update EBK_ZFXX Set DJZT=''3'',' //单据已执行
              + ' ZXID = ' + IntToStr(GCzy.ID) + ','
              + ' ZXR = ''' + GCzy.name + ''','
              + ' zfzt = ''支付成功'', '
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

    baFZX: // 反支付
      begin
      //要检查当前单据
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
              SysMessage('当前单据未支付，不能取消支付。', '_YB', [Pub_Message.mbOK]);
              Exit;
            end;
          end
          else
          begin
            SysMessage('当前单据未找到。', '_YB', [Pub_Message.mbOK]);
            Exit;
          end;
        end;
      //
        vSQL := 'Update EBK_ZFXX Set DJZT=''2'',' //单据已审核
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

  //生成审核日志
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
  GszModCode := '全部';
  gszModName := '全部';
  Acbb.Items.Add('全部');
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

//银行接口类型
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

//银行接口类型（包含全部）
procedure InitTypeCodeAndName2(Acbb:TComboBox);
var
  sSql: string;
begin
  Acbb.Items.Clear;
  sSql := ' select * from EBK_YHJKLX WHERE JKSYFS LIKE ''%wyzf%'' ';
  if dataModulepub = nil then exit;
  GszTypeCode2 := '全部';
  gszTypeName2 := '全部';
  Acbb.Items.Add('全部');
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
  GszGroupCode := '全部';
  gszGroupName := '全部';
  Acbb.Items.Add('全部');
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


