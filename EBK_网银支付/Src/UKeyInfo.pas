unit UKeyInfo;

interface
uses
  Classes, SysUtils, ComObj, Windows, ActiveX, ExtCtrls, Math, SenseUK, UFrmUkLogin, Sense4Dev;

type

  TUKeyInfo = class
  Private
    FKeyInfo: TStringList;
    FMaxSize: Integer;
    //�������������¼
    FInputAccount: Integer;
    //��¼�Ƿ�������֤ͨ��
    FUKConnect: Boolean;
    //��¼�Ƿ���Ҫ����������֤��½
    FUKPasswordLogin: Boolean;
    FPassword: string;
    FKeyID: string;
    FError:String;
    function CheckUK: WideString;
    procedure SetPassword(const Key, Value: string);
    function ReadUKeyCode: string;
    procedure SetUkeyCode(const Value: string);
    procedure SetUKPasswordLogin(const Value: Boolean);
    procedure CheckUKeyConnect(Sender: Tobject);
    procedure InputPasswordLogin(Sender: Tobject);
    procedure SetError(const Value: String);
  Public
    //������Delphi��Com��������
    constructor create;
    destructor detroy;
    //��U������Ϣ
    function ReadUKInfo: String; Virtual; Stdcall;
    function Get_KeyName(i: SYSINT): WideString; Stdcall;
    function Get_Key(const name: WideString): WideString; Stdcall;
    procedure Set_Key(const name: WideString; const value: WideString); Stdcall;
    //ɾ��U������Ӧ���Ƶ���Ϣֵ
    function DelKey(const Name: WideString): WordBool; Stdcall;
    //���U��������Ϣ����
    function KeyCount: SYSINT; Stdcall;
    //��ȡUK�����ַ���Ϣ
    function KeyAllText: WideString; Stdcall;
    //����Ϣ���浽U����
    function Save: String; Virtual; Stdcall;
    //���U������Ϣ
    function Clear: String; Virtual; Stdcall;
    //�������
    function ChangPass(const Key, OldName, NewName: WideString): WordBool; Stdcall;
    //UK������֤��½����
    function LoginUK(const Key, PassWord: WideString): WordBool; Stdcall;
    //UK�˳�����
    function LoginOutUK: WordBool; Stdcall;

    function UKIsExists(var Letter: Char): Boolean;
    procedure KeyClear;

    //���淽������delphi����
    //���Key������
    property KeyName[i: integer]: WideString Read Get_KeyName;
    //����U������Ӧ���Ƶ���Ϣֵ
    property Key[const name: WideString]: WideString Read Get_Key Write Set_Key;
    //�Ƿ����UK������֤
    property UKPasswordLogin: Boolean Read FUKPasswordLogin Write SetUKPasswordLogin;
    //property Password :String read FPassword write SetPassword;
    property UKConnect: Boolean Read FUKConnect;
    property InputAccount: Integer Read FInputAccount;
    //���U��Ψһ���к�
    property UKeyCode: string Read ReadUKeyCode Write SetUkeyCode;
    //����ID��
    property UKeyID: string Read FKeyID Write FKeyID;
    //���UKeyʵ��
    class function InitUKeyInstance: TUKeyInfo;
    property Error:String read FError write SetError;
  end;

  TSense_UKeyInfo = class(TUKeyInfo)
  Public
    //��U������Ϣ
    function ReadUKInfo: String; Override;
    function Save: String; Override;
    function Clear: String; Override;
  end;
  TSense4_UKeyInfo = class(TUKeyInfo)
  private
    function ReadLock(fileID, offset: ushort; len: byte;
      var readBuff: array of byte): boolean;
    function UpdateLock(fileID, offset: ushort; len: byte;
      var updateBuff: array of byte): boolean;
  Public
    //��U������Ϣ
    function ReadUKInfo: String; Override;
    function Save: String; Override;
    function Clear: String; Override;
  end;
implementation

{ TKeyInfo }
uses
  Pub_Function;

function TUKeyInfo.Clear: String;
begin
  Result := '';
end;

constructor TUKeyInfo.create;
begin
  inherited;
  FKeyInfo := TStringList.Create;
  FInputAccount := 0;
  FMaxSize := 20; //���5M
  FUKPasswordLogin := false;
  FUKConnect := False;
  {FTimer := TTimer.Create(nil);
  FTimer.Enabled := false;
  FTimer.OnTimer := CheckUKeyConnect;
  FTimer.Interval := 500; }
  try
    ReadUKInfo;
  except

  end;
end;

function TUKeyInfo.DelKey(const Name: WideString): WordBool; Stdcall;
var
  iIndex: Integer;
begin
  Result := False;
  //Ѷ��Ϣ
  if Trim(ReadUKInfo) <> '' then
    Exit;
  iIndex := FKeyInfo.IndexOfName(Name);
  if iIndex >= 0 then
    FKeyInfo.Delete(iIndex);
  //������Ϣ
  if Trim(Save) <> '' then
    Exit;
  Result := true;
end;

destructor TUKeyInfo.detroy;
begin
 { if Assigned(FTimer) then
  begin
    FTimer.Enabled := False;
    FreeAndNil(FTimer);
  end; }
  if Assigned(FKeyInfo) then
    FreeAndNil(FKeyInfo);
  FMaxSize := 0;
  inherited Destroy;
end;

function TUKeyInfo.KeyAllText: widestring;
begin
  Result := '';
  if Trim(ReadUKInfo) <> '' then
    exit;
  Result := FKeyInfo.Text;
end;

function TUKeyInfo.KeyCount: SYSINT;
begin
  Result := 0;
  if Trim(ReadUKInfo) <> '' then
    exit;
  Result := FKeyInfo.Count;
end;

function TUKeyInfo.Get_KeyName(i: SYSINT): WideString;
begin
  result := '';
  if FKeyInfo.Count >= i + 1 then
    Result := FKeyInfo.Names[i];
end;

function TUKeyInfo.ReadUKInfo: String;
begin
  result := '';
end;

function TUKeyInfo.Get_Key(const name: WideString): WideString;
begin
  Result := '';
  //if FKeyInfo.Text = '' then
    //ReadUKInfo;
  Result := FKeyInfo.Values[name];
end;

function TUKeyInfo.Save: String;
begin
  result := '';
end;

procedure TUKeyInfo.Set_Key(const name: WideString; const value: WideString);
begin
  //if FKeyInfo.Text = '' then
    //ReadUKInfo;
  FKeyInfo.Values[Name] := Value;
  if Trim(Save) <> '' then
    exit;
end;

function TUKeyInfo.ChangPass(const Key, OldName, NewName: WideString): WordBool;
var
  Ret: string;
  sOldName, sNewName: string;
begin
  Result := False;
  if not LoginUK(Key, OldName) then
  begin
    result := False;
    exit;
  end;
  SetPassword(Key, NewName);
  Ret := Save;
  if Ret <> '' then
    Result := false
  else
    result := true;
end;

function TUKeyInfo.LoginOutUK: WordBool;
var
  Letter: Char;
  Buffer: array of char;
begin
  Result := False;
  //���U���̷�
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  try
    if not UKGetRemovalLetter(@Letter) then
    begin
      Result := False;
      Exit;
    end;
    if not UKPassAreaLogout then
      Result := False
    else
      Result := true;
  finally
    Buffer := nil;
  end;
end;

function TUKeyInfo.LoginUK(const Key, PassWord: WideString): WordBool;
var
  Letter: Char;
  Buffer: array of char;
  sPassword: string;
begin
  Result := False;
  if Key = '' then
    exit;
  //���U���̷�
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  try
    sPassword := Password;
    if Trim(FKeyInfo.Values[Key]) <> Trim(sPassword) then
      Result := False
    else
      Result := true;
  finally
    Buffer := nil;
  end;
end;

procedure TUKeyInfo.InputPasswordLogin(Sender: Tobject);
var
  sPassword: string;
  Letter: char;
begin
  if not Assigned(FKeyInfo) then
    exit;
  //������
  if FKeyInfo.Text = '' then
    ReadUKInfo;
  //������������֤��½
  if not FUKPasswordLogin then
  begin
    FUKConnect := true;
    exit;
  end;
  //δ����UK
  if not UKIsExists(Letter) then
  begin
    FUKConnect := False;
    FInputAccount := 0;
    exit;
  end;
  while (not FUKConnect) and (FInputAccount < 3) do
  begin
    sPassword := InputPassword;
    if sPassword = '@@@ȡ��@@@' then
    begin
      FInputAccount := 3;
      FUKConnect := False;
    end
    else if LoginUK(FKeyID, sPassword) then
    begin
      FInputAccount := 0;
      FUKConnect := true;
    end
    else
    begin
      inc(FInputAccount);
      FUKConnect := False;
    end;
  end;
end;

function TUKeyInfo.UKIsExists(var Letter: Char): Boolean;
var
  Buffer: array of char;
  sOldName, sNewName: string;
begin
  Result := False;
  //���U���̷�
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  if not UKGetRemovalLetter(@Letter) then
    Result := False
  else
    result := true;
end;

{ TSense_UKeyInfo }

{ TSense_UKeyInfo }

function TSense_UKeyInfo.Clear: String;
var
  Letter: Char;
  Buffer: array of char;
begin
  Result := '';
  //���U���̷�
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  try
    if not UKIsExists(Letter) then
    begin
      Result := 'U����ĩ�����ĩ����U������Ϣ����!';
      Exit;
    end;
    FKeyInfo.Clear;
    StrPCopy(@Buffer[0], FKeyInfo.Text);
    if not UKHiddenAreaWrite(Letter, 0, @Buffer[0], Length(Buffer)) then
      Result := 'дU��������ʧ�ܣ�';
  finally
    Buffer := nil;
  end;
end;

function TSense_UKeyInfo.ReadUKInfo: String;
var
  Letter: char;
  Buffer: array of char;
begin
  Result := '';
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  try
    if not UKIsExists(Letter) then
    begin
      Result := '����:U����δ�����δ����U������Ϣ!';
      Exit;
    end;
    if not UKHiddenAreaRead(Letter, 0, @Buffer[0], Length(Buffer)) then
      Result := '����:дU��������ʧ�ܣ�';
    FKeyInfo.Text := StrPas(@Buffer[0]);
    //FPassword :=FKeyInfo.Values['UserPassword'];
  finally
    Buffer := nil;
  end;
end;

function TSense_UKeyInfo.Save: String;
var
  Letter: Char;
  Buffer: array of char;
begin
  inherited Save;
  Result := '';
  //������������С����������
  if Length(FKeyInfo.Text) > FMaxSize then
  begin
    Result := '����:������������ֵ' + IntToStr(FMaxSize div 1024) + 'M';
    Exit;
  end;
  //���U���̷�
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  try
    if not UKIsExists(Letter) then
    begin
      Result := '����:U����δ�����δ����U������Ϣ!';
      Exit;
    end;
    //��������
    //FKeyInfo.Values['UserPassword']:=FPassword;
    StrPCopy(@Buffer[0], FKeyInfo.Text);
    if not UKHiddenAreaWrite(Letter, 0, @Buffer[0], Length(Buffer)) then
      Result := '����:дU��������ʧ�ܣ�';
  finally
    Buffer := nil;
  end;
end;

function TUKeyInfo.CheckUK: WideString;
begin
  Result := '';
  if FUKPasswordLogin and not FUKConnect then
    result := 'UK������֤ʧ�ܣ������������';

end;

procedure TUKeyInfo.SetPassword(const Key, Value: string);
begin
  FKeyInfo.Values[Key] := Value;
end;

function TUKeyInfo.ReadUKeyCode: string;
begin
  if FKeyInfo.Values['UFGOV-UKEYCODE'] = '' then
  begin
    FKeyInfo.Values['UFGOV-UKEYCODE'] := GetGuid;
    SetUkeyCode(FKeyInfo.Values['UFGOV-UKEYCODE']);
    Result := FKeyInfo.Values['UFGOV-UKEYCODE'];
  end
  else
  begin
    Result := FKeyInfo.Values['UFGOV-UKEYCODE'];
  end;
end;

procedure TUKeyInfo.SetUkeyCode(const Value: string);
begin
  FKeyInfo.Values['UFGOV-UKEYCODE'] := value;
  if Save <> '' then
    FKeyInfo.Values['UFGOV-UKEYCODE'] := '';
end;

class function TUKeyInfo.InitUKeyInstance: TUKeyInfo;
var
  sUKeyName: string;
begin
  //���UKeyʵ��������������չ��ͨ�������ļ���ȡ����ʵ����UKey�ĳ���
  sUKeyName := 'SENSE4'; //Ĭ����˼,���Զ������ļ������ݿ�
  if sUKeyName = 'SENSE' then
    Result := TSense_UKeyInfo.create;
  if sUKeyName = 'SENSE4' then
    Result := TSense4_UKeyInfo.create;
end;

procedure TUKeyInfo.SetUKPasswordLogin(const Value: Boolean);
begin
  FUKPasswordLogin := Value;
end;

procedure TUKeyInfo.CheckUKeyConnect(Sender: Tobject);
var
  sPassword: string;
  Letter: char;
begin
  if not FUKConnect then
    Exit;
  //δ����UK
  if not UKIsExists(Letter) then
  begin
    FUKConnect := False;
    FInputAccount := 0;
    exit;
  end;
end;

{ TSense4_UKeyInfo }

function TSense4_UKeyInfo.Clear: String;
var
  Letter: Char;
  Buffer: array of char;
begin
  Result := '';
  //���U���̷�
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  try
    if not UKIsExists(Letter) then
    begin
      Result := 'U����ĩ�����ĩ����U������Ϣ����!';
      Exit;
    end;
    FKeyInfo.Clear;
    StrPCopy(@Buffer[0], FKeyInfo.Text);
    if not UKHiddenAreaWrite(Letter, 0, @Buffer[0], Length(Buffer)) then
      Result := 'дU��������ʧ�ܣ�';
  finally
    Buffer := nil;
  end;
end;//*************************************************
// �ṹ�嶨��
//*************************************************
Type
  Input_Package = record  // ��д�ļ�ָ��ṹ����  
    tag:    byte;         // ��־λ����ʾ��/д    
    pktLen: byte;         // ����
    fid:    ushort;       // �ļ�id
    offset: ushort;       // ��дƫ����
    len: byte;         // ����buff�ĳ���
    buff:   array[0..242] of byte;
  end;

  Output_Package = record         // �������������ݸ�ʽ����
    tag:    byte;                 // ��־λ����ʾ��/д
    len:    byte;                 // ����buff�ĳ���
    buff:   array[0..247] of byte;// ��Ϊ��ȡָ���������ȡ��������
  end;
          
//*************************************************
// ��������
//*************************************************
const
  devID = '123';            // �豸ID��������ͬʱ���ڶ����ʱ��Ѱ��ָ���豸ID�ļ�����
  S4_EXE_FILE_ID = 'ef21';     // ���ڶ�д�ļ�����ID
  S4_OBJ_FILE_ID = 'bf21';     // ���ڱ���д�����ļ�ID
  S4_OBJ_FILE_ID_HEX = $bf21;  // �����ļ�ID��16��������ʽ
  CMD_UPDATE = 01;        // д
  CMD_READ   = 02;        // ��

//*************************************************
// д�����ļ�
//*************************************************
function TSense4_UKeyInfo.UpdateLock(fileID:ushort; offset:ushort; len:byte; var updateBuff: array of byte) : boolean;
var
  ctxList: array of SENSE4_CONTEXT;
  ctxIndex:integer;
  size:    DWORD;
  ret :    DWORD;
  count:   integer;
  i:       integer;
  j:       integer;
  userPin: string;
  bID:   string;
  hasFound: boolean;
  input:    Input_Package;
  output:   Output_Package;
begin
  if (Length(updateBuff) < len) or (Length(updateBuff) > Length(output.buff)) then
  begin
    result := false;
    exit;
  end;
  //-------------------------------
  // �о���
  //-------------------------------
  // ��ȡ�豸����
  S4Enum(nil, size);
  if (size = 0) then           // if
  begin
    FError := 'û���ҵ���';
    result := false;                 
    exit;
  end;                         // if end

  count := floor(Integer(size) / SizeOf(SENSE4_CONTEXT));
  SetLength(ctxList, count);

  ret := S4Enum(@ctxList[0], size);
  if (ret <> S4_SUCCESS) then   // if
  begin
    FError := '�о���ʧ�� ' + IntToHex(ret, 8);
    result := false;             
    exit;
  end;                          // if end
                                            
  //-------------------------------
  // ��������������
  // Ѱ���豸IDΪ bID �ļ�����
  //-------------------------------
  hasFound := false;
  bID := devID;
  for ctxIndex := 0 to count - 1 do
    if CompareMem(@ctxList[ctxIndex].bID[0], PByte(bID), Length(bID)) then  // ��bID��̬����ת��ΪByteָ�룬����Memory Compare
    begin
      hasFound := true;
      break;
    end;

  if not hasFound then
  begin
    FError := 'û���ҵ�ָ���豸ID�ļ�����';
    result := false;       
    exit;
  end;
  
  //-------------------------------
  // ���ҵ���ָ���豸ID��
  //-------------------------------
  ret := S4Open(@ctxList[ctxIndex]);
  if (ret <> S4_SUCCESS) then
  begin
    FError := '����ʧ�� ' + IntToHex(ret, 8);
    result := false;         
    exit;
  end;

  //-------------------------------
  // �л���ǰ����Ŀ¼
  //-------------------------------
  ret := S4ChangeDir(@ctxList[ctxIndex], '\');
  if (ret <> S4_SUCCESS) then
  begin
    S4Close(@ctxList[ctxIndex]);
    FError := '�л�Ŀ¼ʧ�� ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // ��֤�û�PIN��
  //-------------------------------
  userPin := '12345678';
  ret := S4VerifyPin(@ctxList[ctxIndex], PChar(userPin), 8, S4_USER_PIN);
  if (ret <> S4_SUCCESS) then
  begin                    
    S4Close(@ctxList[ctxIndex]);
    FError := '��֤PIN��ʧ�� ' + IntToHex(ret, 8);
    result := false;     
    exit;
  end;
                 
  //-------------------------------
  // ִ�����ڳ���
  //-------------------------------
  input.tag := CMD_UPDATE;
  input.pktLen := len + 5;  // 5 Ϊ input->,fileID,offset,len5���ֶεĳ��ȣ�len + 7ΪpktLen֮����ֶγ��ȣ�������input->buff�е���Ч����
  input.fid := S4_OBJ_FILE_ID_HEX;
  input.offset := offset;
  input.len := len;
  for i := 0 to len do
    input.buff[i] := updateBuff[i];
  ret := S4Execute(@ctxList[ctxIndex], S4_EXE_FILE_ID, PChar(@input), SizeOf(input), PChar(@output), SizeOf(output), size);
  if (ret <> S4_SUCCESS) then
  begin                  
    S4Close(@ctxList[ctxIndex]);
    FError := 'ִ��ʧ�� ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // �ر���
  //-------------------------------
  S4Close(@ctxList[ctxIndex]);
  result := true;
end;



//*************************************************
// �������ļ�
//*************************************************
function TSense4_UKeyInfo.ReadLock(fileID:ushort; offset:ushort; len:byte; var readBuff: array of byte) : boolean;
var
  ctxList: array of SENSE4_CONTEXT;
  ctxIndex:   integer;
  size:    DWORD;
  ret :    DWORD;
  count:   integer;
  i:       integer;
  j:       integer;
  userPin: string;
  bID:     string;
  hasFound: boolean;
  input:    Input_Package;
  output:   Output_Package;
begin
  if Length(readBuff) < len then
  begin
    result := false;
    exit;
  end;
  //-------------------------------
  // �о���
  //-------------------------------
  // ��ȡ�豸����
  S4Enum(nil, size);
  if (size = 0) then           // if
  begin
    FError:='û���ҵ���';
    result := false;
    exit;
  end;                         // if end

  count := floor(Integer(size) / SizeOf(SENSE4_CONTEXT));
  SetLength(ctxList, count);

  ret := S4Enum(@ctxList[0], size);
  if (ret <> S4_SUCCESS) then   // if
  begin
    FError:='�о���ʧ�� ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;                          // if end

  //-------------------------------
  // ��������������
  // Ѱ���豸IDΪ '123' �ļ�����
  //-------------------------------
  hasFound := false;
  bID := devID;
  for ctxIndex := 0 to count - 1 do
    if CompareMem(@ctxList[ctxIndex].bID[0], PByte(bID), Length(bID)) then  // ��bID��̬����ת��ΪByteָ�룬����Memory Compare
    begin
      hasFound := true;
      break;
    end;

  if not hasFound then
  begin
    FError:='û���ҵ�ָ���豸ID�ļ�����';
    result := false;
    exit;
  end;

  //-------------------------------
  // ���ҵ���ָ���豸ID��
  //-------------------------------
  ret := S4Open(@ctxList[ctxIndex]);
  if (ret <> S4_SUCCESS) then
  begin
    FError:='����ʧ�� ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // �л���ǰ����Ŀ¼
  //-------------------------------
  ret := S4ChangeDir(@ctxList[ctxIndex], '\');
  if (ret <> S4_SUCCESS) then
  begin
    S4Close(@ctxList[ctxIndex]);
    FError:='�л�Ŀ¼ʧ�� ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // ��֤�û�PIN��
  //-------------------------------
  userPin := '12345678';
  ret := S4VerifyPin(@ctxList[ctxIndex], PChar(userPin), 8, S4_USER_PIN);
  if (ret <> S4_SUCCESS) then
  begin
    S4Close(@ctxList[ctxIndex]);
    FError:='��֤PIN��ʧ�� ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // ִ�����ڳ���
  //-------------------------------
  input.tag := CMD_READ;
  input.pktLen := 7;
  input.fid := S4_OBJ_FILE_ID_HEX;
  input.offset := offset;
  input.len := len;
  ret := S4Execute(@ctxList[ctxIndex], S4_EXE_FILE_ID, PChar(@input), SizeOf(input), PChar(@output), SizeOf(output), size);
  if (ret <> S4_SUCCESS) then
  begin
    S4Close(@ctxList[ctxIndex]);
    FError:='ִ��ʧ�� ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //SetLength(readBuff, 250);
  for i := 0 to len-1 do
    readBuff[i] := output.buff[i];

  //-------------------------------
  // �ر���
  //-------------------------------
  S4Close(@ctxList[ctxIndex]);
  result := true;
end;

function TSense4_UKeyInfo.ReadUKInfo: String;
var
  Buffer: array of byte;
  offset:integer;
  Len:integer;
  i:integer;
  S:String;
  R:Boolean;
begin
  try
    offset := 0;
    len := 20;
    SetLength(Buffer, len);
    FError := '';
    try
      R := ReadLock(S4_OBJ_FILE_ID_HEX, offset, len, Buffer);
    except
    
    end;
    if R then
    begin
      FKeyInfo.Clear;
      for i :=0 to Len-1 do
      begin
          S := S + chr(Buffer[i]);
      end;
      FKeyInfo.Text := S;
    end
    else
      Result := '����:' + FError;
  finally

  end;
end;

function TSense4_UKeyInfo.Save: String;
var
  Buffer: array of byte;
  S:String;
  iCount:integer;
begin
  inherited Save;
  Result := '';
  //������������С����������
  if Length(FKeyInfo.Text) > FMaxSize then
  begin
    Result := '����:������������ֵ' + IntToStr(FMaxSize div 1024) + 'M';
    Exit;
  end;
  SetLength(Buffer, 20);
  S := FKeyInfo.Text;
  for iCount := 1 to length(S) do
  begin
    Buffer[iCount-1] := ord(S[iCount]);
  end;
  
  try
    UpdateLock(S4_OBJ_FILE_ID_HEX, 0, 20, Buffer);
    Result := FError;
  finally

  end;
end;

procedure TUKeyInfo.KeyClear;
begin
  FKeyInfo.Clear;
end;

procedure TUKeyInfo.SetError(const Value: String);
begin
  FError := Value;
end;

end.

