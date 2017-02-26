unit PubBankFunc;

interface

uses
  Forms, MSXML2_TLB, DBClient, DB, Classes, HTTPApp, IdHTTP, ComObj, Sysutils, IniFiles, dialogs;

function getYHXXValue(Ayhdm, AKeyvalue: string; var AYhmc: string): string;
function SendRequest(AIdHTTP: TIdHTTP; URL: string; XMLStr: widestring): widestring;

function getYE(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhhh, Ayhzh: string): extended;
function getYE2(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhhh, Ayhzh, Ayhmc: string; ADate: TDateTime): extended;
function getMX(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhhh, Ayhzh, Ayhmc, ADateB, ADateE: string): OleVariant;

function fDoZZ(AIdHTTP: TIdHTTP; AUsage, AUrl, AFromKHYH, AFromYhhh, AFromYhmc, AFromYhzh, AFromZhmc, AFromKhdq, AToKhyh, AToYhhh, AToYhmc, AToYhzh, AToZhmc, AToKhdq, AFkr, ASkr: string; AJe: extended; isTC: string; var sBankuqno, sBusiuqno, sHeadbusiuqno, sMsg, sReturn: string): string;
function getZFZT(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhzh, Ayhmc: string; ABankuqno, ABusiuqno, AHeadbusiuqno: string): string;

function fDoDFDK(AIdHTTP: TIdHTTP; AUsage, AUrl, AFromKHYH, AFromYhhh, AFromYhmc, AFromYhzh, AFromZhmc, AFromKhdq, AFromYhwd, AToKhyh, AToYhhh, AToYhmc, AToYhzh, AToZhmc, AToKhdq, AFkr, ASkr: string; AJe: extended; isTC: string; var sBankuqno, sBusiuqno, sHeadbusiuqno, sMsg, sReturn: string): string;
function getDFDKZT(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhzh, Ayhmc, ATkhyh: string; ABankuqno, ABusiuqno, AHeadbusiuqno: string): string;

function GetUFBankUrl:string;

function GetYHHB(AYHMC:string):string;
implementation

uses Pub_Message;

function GetYHHB(AYHMC:string):string;
begin
  if (Pos('�й�����', AYHMC) > 0) or (Pos('����', AYHMC) > 0) then
    Result := '�й�����'
  else if (Pos('�й�ũҵ����', AYHMC) > 0) or (Pos('ũ��', AYHMC) > 0) or (Pos('ũҵ����', AYHMC) > 0) then
    Result := '�й�ũҵ����'
  else if (Pos('�й���������', AYHMC) > 0) or (Pos('����', AYHMC) > 0) or (Pos('��������', AYHMC) > 0) then
    Result := '�й���������'
  else if (Pos('�й���������', AYHMC) > 0) or (Pos('����', AYHMC) > 0) or (Pos('��������', AYHMC) > 0) then
    Result := '�й���������'
  else
    Result := AYHMC;
end;

function GetUFBankUrl:string;
var
  UFBANKList:TStrings;
begin
  result := '';
  try
    UFBANKList := TStringList.Create;
    try
      UFBANKList.Clear;
      if FileExists(ExtractFilePath(Application.ExeName) + 'UFBANK') then
        UFBANKList.LoadFromFile(ExtractFilePath(Application.ExeName) + 'UFBANK');
      if UFBANKList.Count > 0 then
        result := UFBANKList.Strings[0]
      else
        result := 'http://10.105.160.7:8101/ufbank/ufbank.asp?client=com';
    except
    end;
  finally
    UFBANKList.Free;
  end;
end;

function getYHXXValue(Ayhdm, AKeyvalue: string; var AYhmc: string): string;
var
  szIniFileName: string;
  FIniFile: TIniFile;
  sectionList: TStringList;
  i: integer;
begin
  result := '';

  szIniFileName := ExtractFilePath(Application.EXEName) + '\R9i_BAM_YHXX.INI';
  if not fileexists(szIniFileName) then exit;

  sectionList := TStringList.Create;

  FIniFile := TIniFile.Create(szIniFileName);
  FIniFile.ReadSections(sectionList);
  for i := 0 to sectionList.Count - 1 do
  begin
    FIniFile.ReadSections(sectionList);
    if Pos(FIniFile.ReadString(sectionList.Strings[i], 'YJDM', ''), Ayhdm) = 1 then
    begin
      AYhmc := sectionList.Strings[i];
      result := FIniFile.ReadString(sectionList.Strings[i], AKeyvalue, '');
      break;
    end;
  end;

  sectionList.Free;
  FIniFile.Free;
end;

//����ĺ���ʵ�ִ�����������Ϣ�Ĺ��ܣ�XMLStr������Ĵ���AidHttp��һ��TIdHTTP�Ŀؼ�����

function SendRequest(AIdHTTP: TIdHTTP; URL: string; XMLStr: widestring): widestring;
var
  Content: string;
  strList, strList2: TStrings;
begin
  strList := TStringList.Create;
  strList2 := TStringList.Create;
  try
    content := 'reqData=' + httpencode(XMLStr);
    content := content + '&signData=' + httpencode('');
    content := content + '&userIP=' + httpencode('127.0.0.1');
    content := content + '&srcFlag=' + httpencode('Dom');
    strList.Text := content;
    AIdHTTP.Request.ContentLength := Length(strList.text);
    //
    strList2.Text := XMLStr;
    strList2.SaveToFile('c:\wylog.txt');
    //
    result := AIdHTTP.Post(URL, strList);
  finally
    strList.Free;
    strList2.Free;
  end;
end;

function getYE(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhhh, Ayhzh: string): extended;
var
  szXML_input, szXML_out: widestring;
  tmpXMLFile: IXMLDOMDocument;
  dataNode, rowNode: IXMLDOMNode;
begin
  result := 0;
  if AUrl = '' then exit;
  if Akhyh = '' then exit;
  if Ayhzh = '' then exit;

  if Akhyh = '�й�����' then
  begin
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="cb" func="ye" roottag="input" version="nc57"> ' +
      '<row account_num="' + Ayhzh + '" branchid="' + Ayhhh + '"  newpackageid="' + FormatDateTime('yyyymmddhhnn', Now) + '" reqreserved1="0" espdate="" /> ' +
      '</data> ';
  end;
  if Akhyh = '�й���������' then
  begin
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="icbcpb" func="ye" roottag="input" version="nc57"> ' +
      '<row account_num="' + Ayhzh + '" account_cur= "�����" newpackageid="' + FormatDateTime('yyyymmddhhnnsszzz', Now) + '" /> ' +
      '</data> ';
  end;

  try
    szXML_out := SendRequest(AIdHTTP, AUrl, szXML_input);
  except
    szXML_out := '';
  end;
  if szXML_out = '' then Exit;

  tmpXMLFile := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  tmpXMLFile.loadXML(szXML_out);
  dataNode := tmpXMLFile.Get_documentElement;

  if Akhyh = '�й�����' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='Gb2312'?>
    <data bank="cb" func="ye" type="" roottag="output" version="ufbank50">
      <row account_num="270060152443" accnam="" c_ccynbr="CNY" retcode="" errmsg="" acc_balance="" balance="0" usable_balance="0" acct_property="" userid="" RepReserved1="" RepReserved2="" tranflag="0" trandesc=""/>
    </data>
    }
  end;

  if Akhyh = '�й���������' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='gb2312'?>
    <data bank="icbcpb" func="ye" type="" roottag="output" version="ufbank50">
      <row account_num="0302011229300026074" accnam="" c_ccynbr="001" retCode="0" errmsg="" acc_balance="157982.87" balance="157961.87" usable_balance="157961.87" acct_property="004" userid="" represerved1="" represerved2="" tranflag="0" trandesc=""/>
    </data>
    }
  end;

  rowNode := dataNode.selectSingleNode('row');
  if rowNode = nil then Exit;

  if rowNode.attributes.getNamedItem('balance') <> nil then
    result := strtofloat(string(rowNode.attributes.getNamedItem('balance').Get_nodeValue));
end;

function getYE2(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhhh, Ayhzh, Ayhmc: string; ADate: TDateTime): extended;
var
  szXML_input, szXML_out: widestring;
  tmpXMLFile: IXMLDOMDocument;
  dataNode, rowNode: IXMLDOMNode;
  ADateStr: string;
begin
  result := 0;
  if AUrl = '' then exit;
  if Akhyh = '' then exit;
  if Ayhzh = '' then exit;
  ADateStr := FormatDateTime('YYYY-MM-DD', ADate);
  if Akhyh = '�й�����' then
  begin
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="cb" func="ye" roottag="input" version="nc57"> ' +
//      '<row account_num="' + Ayhzh + '" branchid="' + Ayhhh + '"  newpackageid="' + FormatDateTime('yyyymmddhhnn', Now) + '" reqreserved1="0" espdate="' + ADateStr + '" /> ' +
      '<row account_num="' + Ayhzh + '" branchid="' + Ayhhh + '"  newpackageid="' + FormatDateTime('yyyymmddhhnn', Now) + '" reqreserved1="0" /> ' +
      '</data> ';
  end;
  if Akhyh = '�й���������' then
  begin
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="icbcpb" func="ye" roottag="input" version="nc57"> ' +
//      '<row account_num="' + Ayhzh + '" account_cur= "�����" newpackageid="' + FormatDateTime('yyyymmddhhnnsszzz', Now) + '" espdate="' + ADateStr + '" /> ' +
      '<row account_num="' + Ayhzh + '" account_cur= "�����" newpackageid="' + FormatDateTime('yyyymmddhhnnsszzz', Now) + '" /> ' +
      '</data> ';
  end;
  // Added By cheyf 2011/12/07
  // <--begin-->
  if Akhyh = '�й���������' then // ��������
  begin
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="ccbn" func="ye" roottag="input" version="nc57"> ' +
//      '<row account_num="' + Ayhzh + '" newpackageid="' + FormatDateTime('yyyymmddhhnnsszzz', Now) + '" espdate="' + ADateStr + '" /> ' +
      '<row account_num="' + Ayhzh + '" newpackageid="' + FormatDateTime('yyyymmddhhnnsszzz', Now) + '" /> ' +
      '</data> ';
  end;
//  if Akhyh = '�й�ũҵ����' then // ũ��
//  begin
//    szXML_input := '<?xml version="1.0" encoding="GBK"?> '
//      + '<data bank="cmen" banktype="00012" func="ye" roottag="input" type="type" version="nc5.5"> '
//    //+ '<row account_num="'+Ayhzh+'" branch= "'+Ayhmc+'" espdate="'+ADateStr+'" /> '
//    + '<row account_num="' + Ayhzh + '" branch= "' + Ayhmc + '" /> '
//      + '</data> ';
//  end;
  if Akhyh = '�й�ũҵ����' then // ũ��ר��
  begin
    szXML_input := '<?xml version="1.0" encoding="GBK"?> '
      + '<data bank="cme" banktype="00012" func="ye" roottag="input" type="type" version="nc5.5"> '
    //+ '<row account_num="'+Ayhzh+'" branch= "'+Ayhmc+'" espdate="'+ADateStr+'" /> '
    + '<row account_num="' + Ayhzh + '" branch= "' + Ayhmc + '" /> '
      + '</data> ';
  end;
  // <--end-->

  try
    szXML_out := SendRequest(AIdHTTP, AUrl, szXML_input);
  except
    szXML_out := '';
  end;
  //ShowMessage(szXML_input);
  //ShowMessage(szXML_out);
  if szXML_out = '' then Exit;

  tmpXMLFile := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  tmpXMLFile.loadXML(szXML_out);
  dataNode := tmpXMLFile.Get_documentElement;

  if Akhyh = '�й�����' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='Gb2312'?>
    <data bank="cb" func="ye" type="" roottag="output" version="ufbank50">
      <row account_num="270060152443" accnam="" c_ccynbr="CNY" retcode="" errmsg="" acc_balance="" balance="0" usable_balance="0" acct_property="" userid="" RepReserved1="" RepReserved2="" tranflag="0" trandesc=""/>
    </data>
    }
  end;

  if Akhyh = '�й���������' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='gb2312'?>
    <data bank="icbcpb" func="ye" type="" roottag="output" version="ufbank50">
      <row account_num="0302011229300026074" accnam="" c_ccynbr="001" retCode="0" errmsg="" acc_balance="157982.87" balance="157961.87" usable_balance="157961.87" acct_property="004" userid="" represerved1="" represerved2="" tranflag="0" trandesc=""/>
    </data>
    }
  end;

  rowNode := dataNode.selectSingleNode('row');
  if rowNode = nil then Exit;

  if rowNode.attributes.getNamedItem('balance') <> nil then
    result := strtofloat(string(rowNode.attributes.getNamedItem('balance').Get_nodeValue));
end;


function getMX(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhhh, Ayhzh, Ayhmc, ADateB, ADateE: string): OleVariant;
var
  sTranFlag: string;
  szXML_input, szXML_out: widestring;
  tmpXMLFile: IXMLDOMDocument;
  dataNode, rowNode: IXMLDOMNode;
  i, iiCount: integer;
  tmpcds: TClientDataset;
  area_code:string;
  AList:TStrings;
  procedure doCreateDataSet;
  begin
    tmpcds := TClientDataset.Create(nil);

    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'XH';
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'trans_type'; //ҵ������
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'trans_date'; //��������
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'trans_time'; //����ʱ��
    end;

    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'check_num'; //ƾ֤��
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'trans_abstr'; //ժҪ
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'nusage'; //��;
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'dbtdwmc'; //������λ����
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'dbtacc'; //�����˺�
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
//      DataType := ftString; Size := 100; Name := 'dbtbalance'; //�������
      DataType := ftFloat; Name := 'dbtbalance';
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'crtdwmc'; //�շ���λ����
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'crtacc'; //�շ��˺�
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
//      DataType := ftString; Size := 100; Name := 'crtbalance'; //�շ����
      DataType := ftFloat; Name := 'crtbalance';
    end;

    with tmpcds.FieldDefs.AddFieldDef do
    begin
      DataType := ftString; Size := 100; Name := 'amount_sign'; //�����־
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
//      DataType := ftString; Size := 100; Name := 'trsamt'; //���׽��
      DataType := ftFloat; Name := 'trsamt';
    end;
    with tmpcds.FieldDefs.AddFieldDef do
    begin
//      DataType := ftString; Size := 100; Name := 'usable_balance'; //�������
      DataType := ftFloat; Name := 'usable_balance'; //�������
    end;

    tmpcds.CreateDataSet;
  end;
begin
  doCreateDataSet;
  result := tmpcds.data;
//  AList := TStringList.Create;
//  AList.LoadFromFile('C:\123.txt');

  if AUrl = '' then exit;
  if Akhyh = '' then exit;
  if Ayhzh = '' then exit;

  if Akhyh = '�й�����' then
  begin
    szXML_input := '<?xml version="1.0" encoding="GB2312"?> ' +
      '<data bank="cb" func="mx" roottag="input" type="type" version="nc5.5"> ' +
      '<row account_num="' + Ayhzh + '" branchid="' + Ayhhh + '" begin_date="' + ADateB + '" end_date="' + ADateE + '" ></row> ' +
      '</data> ';
  end;

  if Akhyh = '�й���������' then
  begin
    area_code := '1914';//����
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="icbcpb" func="mx" type="type" roottag="input" version="nc57"> ' +
      '<row newpackageid="' + FormatDateTime('yyyymmddhhnnsszzz', Now) + '"  area_code="'+area_code+'" account_num="' + Ayhzh + '" begin_date="' + ADateB + '" end_date="' + ADateE + '"  /> ' +
      '</data> ';
  end;

  // Added By cheyf 2011/12/07
  // <--begin-->
  if Akhyh = '�й���������' then //����
  begin
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="ccbn" func="mx" type="type" roottag="input" version="nc57"> ' +
      '<row newpackageid="' + FormatDateTime('yyyymmddhhnnsszzz', Now) + '" account_num="' + Ayhzh + '" begin_date="' + ADateB + '" end_date="' + ADateE + '"  /> ' +
      '</data> ';
  end;

  {if Akhyh = '�й�ũҵ����' then // ũ�й���
  begin
    szXML_input := '<?xml version="1.0" encoding="GB2312"?> '
      + '<data bank="cmen" func="mx" type="" roottag="input" version="nc55"> '
      + '<row bbknbr="' + Ayhmc + '" account_num="' + Ayhzh + '" begin_date="' + ADateB + '" end_date="' + ADateE + '"  /> '
      + '</data> ';
  end; }
  if Akhyh = '�й�ũҵ����' then // ũ��ר��
  begin
    Ayhmc := '����ʡ����';
    szXML_input := '<?xml version="1.0" encoding="GB2312"?> '
      + '<data bank="cme" func="mx" type="" roottag="input" version="nc55"> '
      + '<row bbknbr="' + Ayhmc + '" account_num="' + Ayhzh + '" begin_date="' + ADateB + '" end_date="' + ADateE + '"  /> '
      + '</data> ';
  end;
  // <--end-->

  try
    szXML_out := SendRequest(AIdHTTP, AUrl, szXML_input);
  except
    szXML_out := '';
  end;
//  szXML_out := AList.Text;
  //ShowMessage(szXML_input);
  //ShowMessage(szXML_out);
  if szXML_out = '' then Exit;

  tmpXMLFile := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  tmpXMLFile.loadXML(szXML_out);

  dataNode := tmpXMLFile.Get_documentElement;
  if dataNode = nil then Exit;

  if Akhyh = '�й�����' then
  begin
    //����������ʽ
    {
      <?xml version="1.0" encoding="Gb2312"?>
      <data bank="cb" func="mx" type="" roottag="output" version="ufbank50">
        <row retcode="" errmsg="" trans_date="2012-02-11" trans_time="16:37:18" dbtacc="268760152444" crtacc="271360152446" dbtdwmc="������������в�����ҵ��" crtdwmc="������������в�����ҵ��" crtbalance="" dbtbalance="49590845.23" curacc="268760152444" grpacc="" trsamt="200" check_num="50019937702" trans_abstr="OBSS000338823464GIRO020094221017//����" c_ccynbr="CNY" nusage="����" trans_type="" xyflag="" represerved1="" represerved2="500199377022012-02-11" tranflag="0" trandesc=""/>
        <row retcode="" errmsg="" trans_date="2012-02-05" trans_time="09:36:01" dbtacc="" crtacc="268760152444" dbtdwmc="" crtdwmc="������������в�����ҵ��" crtbalance="227190.23" dbtbalance="" curacc="268760152444" grpacc="" trsamt="127123.23" check_num="50002471993" trans_abstr="" c_ccynbr="CNY" nusage="" trans_type="" xyflag="" represerved1="" represerved2="500024719932012-02-05" tranflag="0" trandesc=""/>
      </data>
    }
  end;

  if Akhyh = '�й���������' then
  begin
    //����������ʽ
    {
      <?xml version='1.0' encoding='gb2312'?>
      <data bank="icbcpb" func="mx" type="" roottag="output" version="ufbank50">
        <row curacc="0302009129300087524" retcode="B0116" errmsg="���ս�����ϸ:û�з��������ļ�¼" tranflag="1" trandesc="���ս�����ϸ:û�з��������ļ�¼"/>
        <row account_num="0302009129300087524" retcode="" errmsg="" trans_date="2011-09-20" trans_time="" check_num="7341587" trans_abstr="ʵʱ����" c_ccynbr="RMB" curpage="" pagecount="" curacc="0302009129300087524" grpacc="" nusage="����" trans_type="" xyflag="" dbtdwmc="����" crtdwmc="�����в����˻���" represerved1="" represerved2="203020091293000875242011-09-20-10.07.56.765717" tranflag="0" trandesc="" dbtacc="9558810302121923377" crtacc="0302009129300087524" crtbalance="6.13" dbtbalance="" trsamt="0.01"/>
      </data>
    }
  end;

  rowNode := dataNode.selectSingleNode('row');
  if rowNode = nil then Exit;

  iiCount := 0;
  while rowNode <> nil do
  begin
    sTranFlag := '';
    if rowNode.attributes.getNamedItem('tranflag') <> nil then
      sTranFlag := string(rowNode.attributes.getNamedItem('tranflag').Get_nodeValue);

    if sTranFlag <> '0' then
    begin
      rowNode := rowNode.Get_nextSibling;
      continue;
    end;

    tmpcds.Append;
    iiCount := iiCount + 1;
    tmpcds.FieldByName('XH').AsInteger := iiCount;

    for i := 0 to rowNode.attributes.length - 1 do
    begin
      try
        if tmpcds.FieldDefs.IndexOf(rowNode.attributes[i].nodename) <> -1 then
        tmpcds.FieldByName(rowNode.attributes[i].nodename).AsString := rowNode.attributes.getNamedItem(rowNode.attributes[i].nodename).Get_nodeValue;
//        if rowNode.attributes[i].nodename = 'amount_sign' then
//          ShowMessage(rowNode.attributes[i].nodename+' '+rowNode.attributes.getNamedItem(rowNode.attributes[i].nodename).Get_nodeValue);
      except
      end;
    end;
    tmpcds.Post;

    rowNode := rowNode.Get_nextSibling;
  end;

  result := tmpcds.data;
  tmpcds.Free;
end;

function fDoZZ(AIdHTTP: TIdHTTP; AUsage, AUrl, AFromKHYH, AFromYhhh, AFromYhmc, AFromYhzh, AFromZhmc, AFromKhdq, AToKhyh, AToYhhh, AToYhmc, AToYhzh, AToZhmc, AToKhdq, AFkr, ASkr: string; AJe: extended; isTC: string; var sBankuqno, sBusiuqno, sHeadbusiuqno, sMsg, sReturn: string): string;
var
  szXML_input, szXML_out: widestring;
  tmpXMLFile: IXMLDOMDocument;
  dataNode, rowNode: IXMLDOMNode;
  issamebank, issamecity, sfkhdq: string;
begin
  Result := 'ʧ��';

  if AUrl = '' then exit;
  if AFromKHYH = '' then exit;
  if AFromYhzh = '' then exit;

  if AFromKHYH = '�й�����' then
  begin
    szXML_input := '<?xml version="1.0" encoding="GB2312"?> ' +
      '<data bank="cb" banktype="00003" dealtype="online" func="zf" roottag="input" type="type" version="nc5.5"> ' +
      '<row trsamt="' + floattostr(AJe) + '" dbtacc="' + AFromYhzh + '" crtacc="' + AToYhzh + '" crtnam="' + AToZhmc + '" ' +
      'crtbnk="' + AToYhmc + '" outbranchid="' + AFromYhhh + '" inbranchid="' + AToYhhh + '" stipflag="1" nusage="' + AUsage + '" ' +
      'newpackageid="' + FormatDateTime('yymmddhhnnss', Now) + '" > ' +
      '</row>' +
      '</data> ';

      //'crtbnk="'+AToYhmc+'" outbranchid="'+AFromYhzh+'" inbranchid="'+AToYhhh+'" stipflag="1" crtcity="���"  crtpvc="���" nusage="����" '+
      //'newpackageid="020094221817" reqreserved2="40202" issamecity="1" c_ccynbr="001" outacctname="�������" > '+
  end;
  if AFromKHYH = '�й���������' then
  begin
    szXML_input := '<?xml version="1.0" encoding="GB2312"?> ' +
      '<data bank="icbcpb" banktype="00003" dealtype="online" func="zf" roottag="input" type="type" version="nc5.5"> ' +
      '<row trsamt="' + floattostr(AJe) + '" dbtacc="' + AFromYhzh + '" crtacc="' + AToYhzh + '" crtnam="' + AToZhmc + '" ' +
      'crtbnk="' + AToYhmc + '" outbranchid="' + AFromYhhh + '" inbranchid="' + AToYhhh + '" stipflag="1" nusage="' + AUsage + '" ' +
      'newpackageid="' + FormatDateTime('yymmddhhnnss', Now) + '" > ' +
      '</row>' +
      '</data> ';
  end;
  // Added By cheyf 2011/12/07
  // <--begin-->
  if AFromKHYH = '�й���������0' then
  begin
    szXML_input := '<?xml version="1.0" encoding="GB2312"?> ' +
      '<data bank="ccbn" banktype="00003" dealtype="online" func="zf" roottag="input" type="type" version="nc5.5"> ' +
      '<row trsamt="' + floattostr(AJe) + '" c_ccynbr="01" dbtacc="' + AFromYhzh + '" crtacc="' + AToYhzh + '" crtnam="' + AToZhmc + '" ' +
      'crtbnk="' + AToYhmc + '" outbranchid="' + AFromYhhh + '" indepid="" inbranchid="' + AToYhhh + '" busnar="��" nusage="' + AUsage + '" ' +
      'newpackageid="' + FormatDateTime('yymmddhhnnss', Now) + '" > ' +
      '</row>' +
      '</data> ';
  end;
  if AFromKHYH = '�й�ũҵ����' then
  begin
    if AFromKHYH = AToKhyh then issamebank := '1'
    else issamebank := '0';
    issamecity := isTC;
    {// ͬ�����
    <?xml version="1.0" encoding="GB2312"?>
<data bank="cmen" banktype="00006" dealtype="online" func="zf" roottag="input" type="type" version="nc5.5">
<row crtacc="313101040009910" crtbnk="�ϲ���ɽ֧��" crtnam="����ʡ��·��е���̾�" dbtacc="391701040002396" issamebank="1" issamecity="0" newpackageid="916533300011" c_dbtbbk="����" d_dbtbbk="����" busnar="���Է��÷���" trsamt="1.00"></row>
</data>

    }

    szXML_input := '<?xml version="1.0" encoding="GB2312"?> ' +
      '<data bank="cmen" banktype="00006" dealtype="online" func="zf" roottag="input" type="type" version="nc5.5"> ' +
      '<row issamebank="' + issamebank + '" issamecity="' + issamecity + '" d_dbtbbk="' + AToKhdq + '" trsamt="' + floattostr(AJe) + '" dbtacc="' + AFromYhzh + '" c_dbtbbk="' + AFromKhdq + '" crtacc="' + AToYhzh + '" crtnam="' + ASkr + '" ' +
      'crtbnk="' + AToYhmc + '" outacctname="' + AFkr + '" outbranchid="' + AFromYhhh + '" inbranchid="' + AToYhhh + '" busnar="' + AUsage + '" nusage="' + AUsage + '" ' +
      //'crtbnk="' + AToYhmc + '" busnar="' + AUsage + '" nusage="' + AUsage + '" urgencyflag="1" ' +
      'newpackageid="' + FormatDateTime('yymmddhhnnss', Now) + '" > ' +
      '</row>' +
      '</data> ';
  end;
  // <--end-->
  try
    szXML_out := SendRequest(AIdHTTP, AUrl, szXML_input);
  except
    szXML_out := '';
  end;
  //ShowMessage(szXML_input);
  //ShowMessage(szXML_out);
  if szXML_out = '' then Exit;
  sReturn := szXML_out;
  tmpXMLFile := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  tmpXMLFile.loadXML(szXML_out);
  dataNode := tmpXMLFile.Get_documentElement;

  if AFromKHYH = '�й�����' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='GBK'?>
    <data bank="cb" func="zf" type="" roottag="output" version="ufbank50">
      <row retcode="B001" errmsg="�ɹ�����!" transfer_type="" userid="" busiuniqueno="020094221017" bankuniqueno="338823464" tranflag="0" trandesc="�ɹ�����!"/>
    </data>
    }
  end;

  if AFromKHYH = '�й���������' then
  begin
  end;

  rowNode := dataNode.selectSingleNode('row');
  if rowNode = nil then Exit;

  if rowNode.attributes.getNamedItem('tranflag') <> nil then
    result := string(rowNode.attributes.getNamedItem('tranflag').Get_nodeValue);
  if Result = '0' then
    Result := '�ɹ�'
  else if Result = '1' then
    Result := 'ʧ��'
  else if Result = '2' then
    Result := '״̬����';
  // Added By cheyf 2011/12/07
  // <--begin-->
  if rowNode.attributes.getNamedItem('bankuniqueno') <> nil then
    sBankuqno := string(rowNode.attributes.getNamedItem('bankuniqueno').Get_nodeValue);
  if rowNode.attributes.getNamedItem('busiuniqueno') <> nil then
    sBusiuqno := string(rowNode.attributes.getNamedItem('busiuniqueno').Get_nodeValue);
  if rowNode.attributes.getNamedItem('headbusiuniqueno') <> nil then
    sHeadbusiuqno := string(rowNode.attributes.getNamedItem('headbusiuniqueno').Get_nodeValue);

  if rowNode.attributes.getNamedItem('errmsg') <> nil then
    sMsg := string(rowNode.attributes.getNamedItem('errmsg').Get_nodeValue);
  // <--end-->
end;

function getZFZT(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhzh, Ayhmc: string; ABankuqno, ABusiuqno, AHeadbusiuqno: string): string;
var
  szXML_input, szXML_out: widestring;
  tmpXMLFile: IXMLDOMDocument;
  dataNode, rowNode: IXMLDOMNode;
begin
  result := '';
  if AUrl = '' then exit;
  if Akhyh = '' then exit;
  if Ayhzh = '' then exit;

  if Akhyh = '�й�����' then
  begin
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="cb" func="zfcx" type="" roottag="input" version="u870" dealtype="online" filetype="xml"> ' +
      '<row newpackageid="' + FormatDateTime('yymmddhhnnss', Now) + '" bankuniqueno="' + ABankuqno + '" busiuniqueno="' + ABusiuqno + '" /> ' +
      '</data> ';
  end;
  if Akhyh = '�й���������' then
  begin
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="icbcpb" func="zfcx" type="" roottag="input" version="u870" dealtype="online" filetype="xml"> ' +
      '<row newpackageid="' + FormatDateTime('yymmddhhnnss', Now) + '" bankuniqueno="' + ABankuqno + '" busiuniqueno="' + ABusiuqno + '" /> ' +
      '</data> ';
  end;
  if Akhyh = '�й���������' then
  begin
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> ' +
      '<data bank="ccbn" func="zfcx" type="" roottag="input" version="u870" dealtype="online" filetype="xml"> ' +
      '<row newpackageid="' + FormatDateTime('yymmddhhnnss', Now) + '" busiuniqueno="' + ABusiuqno + '" /> ' +
      '</data> ';
  end;
  if Akhyh = '�й�ũҵ����' then
  begin
    {
    <?xml version="1.0" encoding="GBK"?>
<data bank="cmen" banktype="00005" func="zfcx" roottag="input" type="type" version="nc5.5">
<row busiuniqueno="916533300011" dbtacc="391701040002396" branch="����ʡ����"></row></data>
    }
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> '
      + '<data bank="cmen" banktype="00005" func="zfcx" type="type" roottag="input" version="nc5.5"> '
      + '<row busiuniqueno="' + ABusiuqno + '" dbtacc="' + Ayhzh + '" branch="' + Ayhmc + '" /> '
      + '</data> ';
  end;

  try
    szXML_out := SendRequest(AIdHTTP, AUrl, szXML_input);
  except
    szXML_out := '';
  end;
  //ShowMessage(szXML_input);
  //ShowMessage(szXML_out);
  // �������
  {
  szXML_out := '<?xml version="1.0" encoding="GB2312"?>'
  +'<data bank="cb" func="zfcx" type="" roottag="output" version="ufbank50">'
  +'<row account_num="" tranflag="0" retcode="B001" errmsg="ok" trantype="B001" tranmsg="���з�����Ϣ��B001 ok" busiuniqueno="020094221017" bankuniqueno="338823464" trandesc="ok" represerved1="" represerved2=""/></data>';
  }
  //
  if szXML_out = '' then Exit;

  tmpXMLFile := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  tmpXMLFile.loadXML(szXML_out);
  dataNode := tmpXMLFile.Get_documentElement;

  if Akhyh = '�й�����' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='Gb2312'?>
    <data bank="cb" func="ye" type="" roottag="output" version="ufbank50">
      <row account_num="270060152443" accnam="" c_ccynbr="CNY" retcode="" errmsg="" acc_balance="" balance="0" usable_balance="0" acct_property="" userid="" RepReserved1="" RepReserved2="" tranflag="0" trandesc=""/>
    </data>
    }
  end;

  if Akhyh = '�й���������' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='gb2312'?>
    <data bank="icbcpb" func="ye" type="" roottag="output" version="ufbank50">
      <row account_num="0302011229300026074" accnam="" c_ccynbr="001" retCode="0" errmsg="" acc_balance="157982.87" balance="157961.87" usable_balance="157961.87" acct_property="004" userid="" represerved1="" represerved2="" tranflag="0" trandesc=""/>
    </data>
    }
  end;

  rowNode := dataNode.selectSingleNode('row');
  if rowNode = nil then Exit;

  if rowNode.attributes.getNamedItem('tranflag') <> nil then
  begin
    result := string(rowNode.attributes.getNamedItem('tranflag').Get_nodeValue);
    if Result = '0' then
      Result := '�ɹ�'
    else if Result = '1' then
      Result := 'ʧ��'
    else if Result = '2' then
      Result := '״̬����';
  end;
end;

function fDoDFDK(AIdHTTP: TIdHTTP; AUsage, AUrl, AFromKHYH, AFromYhhh, AFromYhmc, AFromYhzh, AFromZhmc, AFromKhdq, AFromYhwd, AToKhyh, AToYhhh, AToYhmc, AToYhzh, AToZhmc, AToKhdq, AFkr, ASkr: string; AJe: extended; isTC: string; var sBankuqno, sBusiuqno, sHeadbusiuqno, sMsg, sReturn: string): string;
var
  szXML_input, szXML_out: widestring;
  tmpXMLFile: IXMLDOMDocument;
  dataNode, rowNode: IXMLDOMNode;
  issamebank, issamecity, sfkhdq: string;
begin
  Result := 'ʧ��';

  if AUrl = '' then exit;
  if AFromKHYH = '' then exit;
  if AFromYhzh = '' then exit;

  if AFromKHYH = '�й�����' then
  begin
  end;
  if AFromKHYH = '�й���������' then
  begin

  end;

  if AFromKHYH = '�й���������' then
  begin

  end;
  if AFromKHYH = '�й�ũҵ����' then
  begin
    if AFromKHYH <> AToKhyh then issamebank := '����'
    else issamebank := 'ͬ��';
    {<?xml version="1.0" encoding="GB2312"?>
<data bank="cmen" banktype="00006" dealtype="online" func="dfdk" roottag="input" type="type" dbtacc="313101040009910" outacctname="����ʡ��·��е���̾�" bbknbr="����" version="nc5.5">
<row crtacc="6228480920971847917"
 childpackageid="916533300020" crtaccname="����" rec_area_name="����" crtbankname="ũ���ϲ�����֧��"
trsamt="10.00" nusage="���Ը����˻�ʹ��" busnar="���Ը����˻�ʹ��"></row></data>

    }
    szXML_input := '<?xml version="1.0" encoding="GB2312"?> '
      + '<data bank="cmen" banktype="00006" dealtype="online" func="dfdk" roottag="input" type="type" dbtacc="' + AFromYhzh + '" outacctname="' + AFromZhmc + '" bbknbr="' + AFromYhwd + '" version="nc5.5"> '
      + '<row crtacc="' + AToYhzh + '" childpackageid="' + FormatDateTime('yymmddhhnnss', Now) + '" crtaccname="' + AToZhmc + '" rec_area_name="' + AToKhdq + '" crtbankname="' + AToYhmc + '" crtaccbkn="' + AToYhhh + '" '
      + 'trsamt="' + floattostr(AJe) + '" nusage="' + AUsage + '" busnar="' + AUsage + '" issamebank="' + issamebank + '"></row> '
      + '</data>'
  end;

  try
    szXML_out := SendRequest(AIdHTTP, AUrl, szXML_input);
  except
    szXML_out := '';
  end;
  //ShowMessage(szXML_input);
  //ShowMessage(szXML_out);
  if szXML_out = '' then Exit;
  sReturn := szXML_out;
  tmpXMLFile := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  tmpXMLFile.loadXML(szXML_out);
  dataNode := tmpXMLFile.Get_documentElement;

  if AFromKHYH = '�й�����' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='GBK'?>
    <data bank="cb" func="zf" type="" roottag="output" version="ufbank50">
      <row retcode="B001" errmsg="�ɹ�����!" transfer_type="" userid="" busiuniqueno="020094221017" bankuniqueno="338823464" tranflag="0" trandesc="�ɹ�����!"/>
    </data>
    }
  end;

  if AFromKHYH = '�й���������' then
  begin
  end;

  rowNode := dataNode.selectSingleNode('row');
  if rowNode = nil then Exit;

  if rowNode.attributes.getNamedItem('tranflag') <> nil then
    result := string(rowNode.attributes.getNamedItem('tranflag').Get_nodeValue);
  if Result = '0' then
    Result := '�ɹ�'
  else if Result = '1' then
    Result := 'ʧ��'
  else if Result = '2' then
    Result := '״̬����';
  // Added By cheyf 2011/12/07
  // <--begin-->
  if rowNode.attributes.getNamedItem('bankuniqueno') <> nil then
    sBankuqno := string(rowNode.attributes.getNamedItem('bankuniqueno').Get_nodeValue);
  if rowNode.attributes.getNamedItem('busiuniqueno') <> nil then
    sBusiuqno := string(rowNode.attributes.getNamedItem('busiuniqueno').Get_nodeValue);
  if rowNode.attributes.getNamedItem('headbusiuniqueno') <> nil then
    sHeadbusiuqno := string(rowNode.attributes.getNamedItem('headbusiuniqueno').Get_nodeValue);

  if rowNode.attributes.getNamedItem('errmsg') <> nil then
    sMsg := string(rowNode.attributes.getNamedItem('errmsg').Get_nodeValue);
  // <--end-->
end;

function getDFDKZT(AIdHTTP: TIdHTTP; AUrl, Akhyh, Ayhzh, Ayhmc, ATkhyh: string; ABankuqno, ABusiuqno, AHeadbusiuqno: string): string;
var
  szXML_input, szXML_out: widestring;
  tmpXMLFile: IXMLDOMDocument;
  dataNode, rowNode: IXMLDOMNode;
  issamebank: string;
begin
  result := '';
  if AUrl = '' then exit;
  if Akhyh = '' then exit;
  if Ayhzh = '' then exit;

  if Akhyh = '�й�����' then
  begin

  end;
  if Akhyh = '�й���������' then
  begin

  end;
  if Akhyh = '�й���������' then
  begin
    {szXML_input:='<?xml version="1.0" encoding = "gb2312"?> '+
      '<data bank="ccbn" func="zfcx" type="" roottag="input" version="u870" dealtype="online" filetype="xml"> '+
        '<row newpackageid="'+FormatDateTime('yymmddhhnnss',Now)+'" busiuniqueno="'+ABusiuqno+'" /> '+
      '</data> ';}
  end;
  if Akhyh = '�й�ũҵ����' then
  begin
    if Akhyh <> ATkhyh then
      issamebank := '0'
    else
      issamebank := '1';
    szXML_input := '<?xml version="1.0" encoding = "gb2312"?> '
      + '<data bank="cmen" banktype="00005" func="dfdkcx" type="type" roottag="input" version="nc5.5"> '
      + '<row newpackageid="' + FormatDateTime('yymmddhhnnss', Now) + '" busiuniqueno="' + AHeadbusiuqno + '" childbusiuniqueno="' + ABusiuqno + '" dbtacc="' + Ayhzh + '" reqreserved1="' + issamebank + '" /> '
      + '</data> ';
  end;

  try
    szXML_out := SendRequest(AIdHTTP, AUrl, szXML_input);
  except
    szXML_out := '';
  end;
  //ShowMessage(szXML_input);
  //ShowMessage(szXML_out);
  // �������
  {
  szXML_out := '<?xml version="1.0" encoding="GB2312"?>'
  +'<data bank="cb" func="zfcx" type="" roottag="output" version="ufbank50">'
  +'<row account_num="" tranflag="0" retcode="B001" errmsg="ok" trantype="B001" tranmsg="���з�����Ϣ��B001 ok" busiuniqueno="020094221017" bankuniqueno="338823464" trandesc="ok" represerved1="" represerved2=""/></data>';
  }
  //
  if szXML_out = '' then Exit;

  tmpXMLFile := CreateOleObject('Microsoft.XMLDOM') as IXMLDomDocument;
  tmpXMLFile.loadXML(szXML_out);
  dataNode := tmpXMLFile.Get_documentElement;

  if Akhyh = '�й�����' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='Gb2312'?>
    <data bank="cb" func="ye" type="" roottag="output" version="ufbank50">
      <row account_num="270060152443" accnam="" c_ccynbr="CNY" retcode="" errmsg="" acc_balance="" balance="0" usable_balance="0" acct_property="" userid="" RepReserved1="" RepReserved2="" tranflag="0" trandesc=""/>
    </data>
    }
  end;

  if Akhyh = '�й���������' then
  begin
    //����������ʽ
    {
    <?xml version='1.0' encoding='gb2312'?>
    <data bank="icbcpb" func="ye" type="" roottag="output" version="ufbank50">
      <row account_num="0302011229300026074" accnam="" c_ccynbr="001" retCode="0" errmsg="" acc_balance="157982.87" balance="157961.87" usable_balance="157961.87" acct_property="004" userid="" represerved1="" represerved2="" tranflag="0" trandesc=""/>
    </data>
    }
  end;

  rowNode := dataNode.selectSingleNode('row');
  if rowNode = nil then Exit;

  if rowNode.attributes.getNamedItem('tranflag') <> nil then
  begin
    result := string(rowNode.attributes.getNamedItem('tranflag').Get_nodeValue);
    if Result = '0' then
      Result := '�ɹ�'
    else if Result = '1' then
      Result := 'ʧ��'
    else if Result = '2' then
      Result := '״̬����';
  end;
end;

end.

