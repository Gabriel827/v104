unit UKeyInfo;

interface
uses
  Classes, SysUtils, ComObj, Windows, ActiveX, ExtCtrls, Math, SenseUK, UFrmUkLogin, Sense4Dev;

type

  TUKeyInfo = class
  Private
    FKeyInfo: TStringList;
    FMaxSize: Integer;
    //输入密码次数记录
    FInputAccount: Integer;
    //记录是否密码验证通过
    FUKConnect: Boolean;
    //记录是否需要输入密码验证登陆
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
    //可用于Delphi与Com方法调用
    constructor create;
    destructor detroy;
    //读U盘锁信息
    function ReadUKInfo: String; Virtual; Stdcall;
    function Get_KeyName(i: SYSINT): WideString; Stdcall;
    function Get_Key(const name: WideString): WideString; Stdcall;
    procedure Set_Key(const name: WideString; const value: WideString); Stdcall;
    //删除U盘锁对应名称的信息值
    function DelKey(const Name: WideString): WordBool; Stdcall;
    //获得U盘锁的信息数量
    function KeyCount: SYSINT; Stdcall;
    //读取UK所有字符信息
    function KeyAllText: WideString; Stdcall;
    //将信息保存到U盘锁
    function Save: String; Virtual; Stdcall;
    //清除U盘锁信息
    function Clear: String; Virtual; Stdcall;
    //变更密码
    function ChangPass(const Key, OldName, NewName: WideString): WordBool; Stdcall;
    //UK密码验证登陆方法
    function LoginUK(const Key, PassWord: WideString): WordBool; Stdcall;
    //UK退出方法
    function LoginOutUK: WordBool; Stdcall;

    function UKIsExists(var Letter: Char): Boolean;
    procedure KeyClear;

    //下面方法用于delphi调用
    //获得Key的名称
    property KeyName[i: integer]: WideString Read Get_KeyName;
    //保存U盘锁对应名称的信息值
    property Key[const name: WideString]: WideString Read Get_Key Write Set_Key;
    //是否进行UK加密验证
    property UKPasswordLogin: Boolean Read FUKPasswordLogin Write SetUKPasswordLogin;
    //property Password :String read FPassword write SetPassword;
    property UKConnect: Boolean Read FUKConnect;
    property InputAccount: Integer Read FInputAccount;
    //获得U盾唯一序列号
    property UKeyCode: string Read ReadUKeyCode Write SetUkeyCode;
    //主键ID号
    property UKeyID: string Read FKeyID Write FKeyID;
    //获得UKey实例
    class function InitUKeyInstance: TUKeyInfo;
    property Error:String read FError write SetError;
  end;

  TSense_UKeyInfo = class(TUKeyInfo)
  Public
    //读U盘锁信息
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
    //读U盘锁信息
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
  FMaxSize := 20; //最大5M
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
  //讯信息
  if Trim(ReadUKInfo) <> '' then
    Exit;
  iIndex := FKeyInfo.IndexOfName(Name);
  if iIndex >= 0 then
    FKeyInfo.Delete(iIndex);
  //保存信息
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
  //获得U盘盘符
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
  //获得U盘盘符
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
  //密内容
  if FKeyInfo.Text = '' then
    ReadUKInfo;
  //不输入密码验证登陆
  if not FUKPasswordLogin then
  begin
    FUKConnect := true;
    exit;
  end;
  //未读到UK
  if not UKIsExists(Letter) then
  begin
    FUKConnect := False;
    FInputAccount := 0;
    exit;
  end;
  while (not FUKConnect) and (FInputAccount < 3) do
  begin
    sPassword := InputPassword;
    if sPassword = '@@@取消@@@' then
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
  //获得U盘盘符
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
  //获得U盘盘符
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  try
    if not UKIsExists(Letter) then
    begin
      Result := 'U盘锁末插入或末读到U盘锁信息错误!';
      Exit;
    end;
    FKeyInfo.Clear;
    StrPCopy(@Buffer[0], FKeyInfo.Text);
    if not UKHiddenAreaWrite(Letter, 0, @Buffer[0], Length(Buffer)) then
      Result := '写U盘锁数据失败！';
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
      Result := '错误:U盘锁未插入或未读到U盘锁信息!';
      Exit;
    end;
    if not UKHiddenAreaRead(Letter, 0, @Buffer[0], Length(Buffer)) then
      Result := '错误:写U盘锁数据失败！';
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
  //大于隐藏区大小，则不允许保存
  if Length(FKeyInfo.Text) > FMaxSize then
  begin
    Result := '错误:超出保存的最大值' + IntToStr(FMaxSize div 1024) + 'M';
    Exit;
  end;
  //获得U盘盘符
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  try
    if not UKIsExists(Letter) then
    begin
      Result := '错误:U盘锁未插入或未读到U盘锁信息!';
      Exit;
    end;
    //增加密码
    //FKeyInfo.Values['UserPassword']:=FPassword;
    StrPCopy(@Buffer[0], FKeyInfo.Text);
    if not UKHiddenAreaWrite(Letter, 0, @Buffer[0], Length(Buffer)) then
      Result := '错误:写U盘锁数据失败！';
  finally
    Buffer := nil;
  end;
end;

function TUKeyInfo.CheckUK: WideString;
begin
  Result := '';
  if FUKPasswordLogin and not FUKConnect then
    result := 'UK密码验证失败，不允许操作！';

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
  //获得UKey实例，后期用于扩展，通过配置文件读取具体实例化UKey的厂商
  sUKeyName := 'SENSE4'; //默认深思,可以读配置文件或数据库
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
  //未读到UK
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
  //获得U盘盘符
  Letter := ' ';
  SetLength(Buffer, FMaxSize);
  try
    if not UKIsExists(Letter) then
    begin
      Result := 'U盘锁末插入或末读到U盘锁信息错误!';
      Exit;
    end;
    FKeyInfo.Clear;
    StrPCopy(@Buffer[0], FKeyInfo.Text);
    if not UKHiddenAreaWrite(Letter, 0, @Buffer[0], Length(Buffer)) then
      Result := '写U盘锁数据失败！';
  finally
    Buffer := nil;
  end;
end;//*************************************************
// 结构体定义
//*************************************************
Type
  Input_Package = record  // 读写文件指令结构定义  
    tag:    byte;         // 标志位，表示读/写    
    pktLen: byte;         // 保留
    fid:    ushort;       // 文件id
    offset: ushort;       // 读写偏移量
    len: byte;         // 数据buff的长度
    buff:   array[0..242] of byte;
  end;

  Output_Package = record         // 加密锁返回数据格式定义
    tag:    byte;                 // 标志位，表示读/写
    len:    byte;                 // 数据buff的长度
    buff:   array[0..247] of byte;// 若为读取指令则包含读取数据内容
  end;
          
//*************************************************
// 常量定义
//*************************************************
const
  devID = '123';            // 设备ID，用于在同时存在多把锁时，寻找指定设备ID的加密锁
  S4_EXE_FILE_ID = 'ef21';     // 锁内读写文件程序ID
  S4_OBJ_FILE_ID = 'bf21';     // 锁内被读写数据文件ID
  S4_OBJ_FILE_ID_HEX = $bf21;  // 数据文件ID，16进制数格式
  CMD_UPDATE = 01;        // 写
  CMD_READ   = 02;        // 读

//*************************************************
// 写数据文件
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
  // 列举锁
  //-------------------------------
  // 获取设备数量
  S4Enum(nil, size);
  if (size = 0) then           // if
  begin
    FError := '没有找到锁';
    result := false;                 
    exit;
  end;                         // if end

  count := floor(Integer(size) / SizeOf(SENSE4_CONTEXT));
  SetLength(ctxList, count);

  ret := S4Enum(@ctxList[0], size);
  if (ret <> S4_SUCCESS) then   // if
  begin
    FError := '列举锁失败 ' + IntToHex(ret, 8);
    result := false;             
    exit;
  end;                          // if end
                                            
  //-------------------------------
  // 遍历各个加密锁
  // 寻找设备ID为 bID 的加密锁
  //-------------------------------
  hasFound := false;
  bID := devID;
  for ctxIndex := 0 to count - 1 do
    if CompareMem(@ctxList[ctxIndex].bID[0], PByte(bID), Length(bID)) then  // 将bID静态类型转换为Byte指针，用以Memory Compare
    begin
      hasFound := true;
      break;
    end;

  if not hasFound then
  begin
    FError := '没有找到指定设备ID的加密锁';
    result := false;       
    exit;
  end;
  
  //-------------------------------
  // 打开找到的指定设备ID锁
  //-------------------------------
  ret := S4Open(@ctxList[ctxIndex]);
  if (ret <> S4_SUCCESS) then
  begin
    FError := '打开锁失败 ' + IntToHex(ret, 8);
    result := false;         
    exit;
  end;

  //-------------------------------
  // 切换当前操作目录
  //-------------------------------
  ret := S4ChangeDir(@ctxList[ctxIndex], '\');
  if (ret <> S4_SUCCESS) then
  begin
    S4Close(@ctxList[ctxIndex]);
    FError := '切换目录失败 ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // 验证用户PIN码
  //-------------------------------
  userPin := '12345678';
  ret := S4VerifyPin(@ctxList[ctxIndex], PChar(userPin), 8, S4_USER_PIN);
  if (ret <> S4_SUCCESS) then
  begin                    
    S4Close(@ctxList[ctxIndex]);
    FError := '验证PIN码失败 ' + IntToHex(ret, 8);
    result := false;     
    exit;
  end;
                 
  //-------------------------------
  // 执行锁内程序
  //-------------------------------
  input.tag := CMD_UPDATE;
  input.pktLen := len + 5;  // 5 为 input->,fileID,offset,len5个字段的长度，len + 7为pktLen之后个字段长度，即包括input->buff中的有效部分
  input.fid := S4_OBJ_FILE_ID_HEX;
  input.offset := offset;
  input.len := len;
  for i := 0 to len do
    input.buff[i] := updateBuff[i];
  ret := S4Execute(@ctxList[ctxIndex], S4_EXE_FILE_ID, PChar(@input), SizeOf(input), PChar(@output), SizeOf(output), size);
  if (ret <> S4_SUCCESS) then
  begin                  
    S4Close(@ctxList[ctxIndex]);
    FError := '执行失败 ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // 关闭锁
  //-------------------------------
  S4Close(@ctxList[ctxIndex]);
  result := true;
end;



//*************************************************
// 读数据文件
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
  // 列举锁
  //-------------------------------
  // 获取设备数量
  S4Enum(nil, size);
  if (size = 0) then           // if
  begin
    FError:='没有找到锁';
    result := false;
    exit;
  end;                         // if end

  count := floor(Integer(size) / SizeOf(SENSE4_CONTEXT));
  SetLength(ctxList, count);

  ret := S4Enum(@ctxList[0], size);
  if (ret <> S4_SUCCESS) then   // if
  begin
    FError:='列举锁失败 ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;                          // if end

  //-------------------------------
  // 遍历各个加密锁
  // 寻找设备ID为 '123' 的加密锁
  //-------------------------------
  hasFound := false;
  bID := devID;
  for ctxIndex := 0 to count - 1 do
    if CompareMem(@ctxList[ctxIndex].bID[0], PByte(bID), Length(bID)) then  // 将bID静态类型转换为Byte指针，用以Memory Compare
    begin
      hasFound := true;
      break;
    end;

  if not hasFound then
  begin
    FError:='没有找到指定设备ID的加密锁';
    result := false;
    exit;
  end;

  //-------------------------------
  // 打开找到的指定设备ID锁
  //-------------------------------
  ret := S4Open(@ctxList[ctxIndex]);
  if (ret <> S4_SUCCESS) then
  begin
    FError:='打开锁失败 ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // 切换当前操作目录
  //-------------------------------
  ret := S4ChangeDir(@ctxList[ctxIndex], '\');
  if (ret <> S4_SUCCESS) then
  begin
    S4Close(@ctxList[ctxIndex]);
    FError:='切换目录失败 ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // 验证用户PIN码
  //-------------------------------
  userPin := '12345678';
  ret := S4VerifyPin(@ctxList[ctxIndex], PChar(userPin), 8, S4_USER_PIN);
  if (ret <> S4_SUCCESS) then
  begin
    S4Close(@ctxList[ctxIndex]);
    FError:='验证PIN码失败 ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //-------------------------------
  // 执行锁内程序
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
    FError:='执行失败 ' + IntToHex(ret, 8);
    result := false;
    exit;
  end;

  //SetLength(readBuff, 250);
  for i := 0 to len-1 do
    readBuff[i] := output.buff[i];

  //-------------------------------
  // 关闭锁
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
      Result := '错误:' + FError;
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
  //大于隐藏区大小，则不允许保存
  if Length(FKeyInfo.Text) > FMaxSize then
  begin
    Result := '错误:超出保存的最大值' + IntToStr(FMaxSize div 1024) + 'M';
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

