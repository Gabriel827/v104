unit ChgPassword;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Mask, LggExchanger,AnyiCoder, RzTabs, DB,
  DBClient;

type
  TFormChgPassword = class(TForm)
    Image1: TImage;
    LggExchanger1: TLggExchanger;
    rzpgPassword: TRzPageControl;
    rztbPassword: TRzTabSheet;
    rztbUkey: TRzTabSheet;
    grpChangePassword: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edtOldPWD: TEdit;
    edtNewPwd: TEdit;
    edtConfirmPWD: TEdit;
    GroupBoxUser: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    MaskEditOldPassword: TMaskEdit;
    MaskEditNewPassword: TMaskEdit;
    MaskEditRePassword: TMaskEdit;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    Button1: TButton;
    btnUKYes: TButton;
    Image2: TImage;
    Image3: TImage;
    ClientDataSetCZY: TClientDataSet;
    CheckBoxPass: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnUKYesClick(Sender: TObject);
  private
    { Private declarations }
    iCZJLNo: integer;
    function GetUkeyCode: string;
  public
    { Public declarations }
  end;

var
  FormChgPassword: TFormChgPassword;

procedure ChangePassWord(FillOldPass: boolean = false);

implementation

uses Pub_Message, DataModuleMain, Pub_Global, Pub_Function,UKeyInfo;

{$R *.DFM}

function TFormChgPassword.GetUkeyCode: string;
var
  UK:TUKeyInfo;
begin
  Result :='';
  UK :=TUKeyInfo.InitUKeyInstance;
  UK.UKPasswordLogin :=false;
  try
    Result :=UK.UKeyCode;
  finally
    if Assigned(UK) then FreeAndNil(UK);
  end
end;

procedure ChangePassWord(FillOldPass: boolean);
begin
  Application.CreateForm(TFormChgPassword, FormChgPassword);
  SetComponentsColor(FormChgPassword);
  if FillOldPass then
    FormChgPassword.MaskEditOldPassword.Text := GCzy.Password; //added zhouyunlu 支持登陆界面改密码时，自动填充登陆时的密码（仅限于登陆时）
  FormChgPassword.ShowModal;
end;

procedure TFormChgPassword.FormCreate(Sender: TObject);
begin
  iCZJLNo := PWriteNewCZJL(self.Caption);
end;

procedure TFormChgPassword.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  PWriteEndCZJL(iCZJLNo);
  Action := caFree;
end;

procedure TFormChgPassword.ButtonCancelClick(Sender: TObject);
begin
  close;
end;

procedure TFormChgPassword.ButtonOkClick(Sender: TObject);
var
  szSql: string;
  tmpCZY, tmpPassword, tmpPassCode,skeyPass,sDecode: string;
  bSucceed:Boolean;
begin
  //ORACLE中将口令修改为空后，就无法再进入系统了，也无法进行口令的修改，所以新口令不能为空。
  if MaskEditNewPassword.Text = '' then
  begin
    SysMessage('新口令不能为空，请重新输入。', 'ChgPassword_01_CW', [mbOK]);
    MaskEditNewPassword.SetFocus;
    exit;
  end;

  if MaskEditNewPassword.Text <> MaskEditRePassword.Text then
  begin
    SysMessage('确认口令与指定新口令不符，请重新输入。', 'ChgPassword_01_CW', [mbOK]);
    MaskEditNewPassword.SetFocus;
    exit;
  end;

  with DataModulePub do
  begin
    szSql := 'Select ID, name, GroupID,Password from gl_czy ' +
      'where (name=''' + GCzy.Name + ''') and (type=''1'') and id=' + IntToStr(GCzy.id);
    ClientDataSetPub.Close;
    POpenSql(ClientDataSetPub, szSql);
    try
    except
      SysMessage('打开数据表出错，请退出重试。', 'Pub_01_CW', [mbOK]);
      ClientDataSetPub.Close;
      exit;
    end;
    if not ClientDataSetPub.FindFirst then
    begin
      ClientDataSetPub.Close;
      SysMessage('没有找到相应的操作员', 'ChgPassword_02_CW', [mbOK]);
      MaskEditOldPassword.SetFocus;
      exit;
    end;

    //判断旧密码是否正确
    tmpPassCode := Trim(ClientDataSetPub.FieldByName('password').asString); //密码去掉空格 lzn 2005.10.21
    tmpCZY := GCzy.Name;
    sDecode := TAnyiCoder.Decode(tmpPassCode,sKeyPass,bSucceed); //尝试解密

    if (bSucceed and (MaskEditOldPassword.text=sDecode)) or
      ((not bSucceed) and (tmpPassCode = MaskEditOldPassword.Text)) then

    else begin      //if tmpPassword <> MaskEditOldPassword.Text then
      ClientDataSetPub.Close;
      SysMessage('原口令输入错误，请重新输入。', 'ChgPassword_02_CW', [mbOK]);
      MaskEditOldPassword.SetFocus;
      exit;
    end;

    {
      zhengjy 2014-10-11 广西需求基础卫生版本，密码强度控制
    }
    if (GblEncryType>0) and (Length(Trim(MaskEditNewPassword.Text))<8) then
    begin
      SysMessage('密码长度必须8位以上（包括8位）', 'ChgPassword_02_CW', [mbOK]);
      Exit;
    end;
    case GblEncryType of
      1:begin  //验证符合一种的可能
        if not (TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeOne)
           or TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeTwo)
           or TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeThree)) then
        begin
          SysMessage('密码由字母、数字和特殊字符组成。密码必须符合其中一种组合', 'ChgPassword_02_CW', [mbOK]);
          Exit;
        end;
      end;
      2:begin
        if not ((TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeOne)
                 and TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeTwo))
           or (TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeOne)
                 and TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeThree))
           or (TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeTwo)
                 and TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeThree))) then
        begin
          SysMessage('密码由字母、数字和特殊字符组成。密码必须符合其中二种组合', 'ChgPassword_02_CW', [mbOK]);
          Exit;
        end;
      end;
      3:begin
        if not (TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeOne)
           and  TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeTwo)
           and  TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeThree)) then
        begin
          SysMessage('密码由字母、数字和特殊字符组成。密码必须符合其中三种组合', 'ChgPassword_02_CW', [mbOK]);
          Exit;
        end;
      end;
      else begin

      end;
    end;

    //加密密码处理
    tmpPassCode := Trim(MaskEditNewPassword.Text);
    // bSucceed then      //tmpPassCode := jiami128(tmpCZY, MaskEditNewPassword.Text) + jiami128(GszZth, GszDbName)
    //维护单20160914143347，系统管理员支持密码加密 Modified by chengjf 2016-09-20 
    if CheckBoxPass.Checked then
       tmpPassCode:= TAnyiCoder.Encode(tmpPassCode,sKeypass);
      
    szSql := '';
    if Gdbtype = Oracle then
      szSql := 'begin ';
    szSql := szSql + 'update gl_czy set password=''' + tmpPassCode +
      ''' where (name=''' + GCzy.Name + ''') and (type=''1'') and id=' + IntToStr(GCzy.id);
    if Gdbtype = Oracle then //修改后的密码需要提交 lzn
      szSql := szsql + ';commit;end;';
    try
      PExecSql(szSql);
      SysMessage('修改成功! 请记住新密码!', 'Pub_01_YB', [mbOK]);
    except
      SysMessage('打开数据表出错，请退出重试。', 'Pub_01_CW', [mbOK]);
      exit;
    end;
    GCzy.Password := MaskEditNewPassword.Text;
  end;
  Close;
end;

procedure TFormChgPassword.FormShow(Sender: TObject);
var
  BlnRet:Boolean;
  sSQL,tmpPassCode,skeyPass,sDecode:string;
  bSucceed:Boolean;
begin
  BlnRet :=False;
  sSQL :='select loginUKey,password from gl_czy where id=' + IntToStr(GCzy.id);
  POpenSql(DataModulePub.ClientDataSetTmp,sSQL);
  if DataModulePub.ClientDataSetTmp.RecordCount>0 then
  begin
    BlnRet :=DataModulePub.ClientDataSetTmp.fieldbyName('loginUKey').AsString='1';
    //维护单20160914143347，系统管理员支持密码加密 Modified by chengjf 2016-09-20 
    tmpPassCode := DataModulePub.ClientDataSetTmp.fieldbyName('password').AsString;
    if GCzy.id = 1 then
    begin
      CheckBoxPass.Visible := True;
      sDecode := TAnyiCoder.Decode(tmpPassCode,sKeyPass,bSucceed);
      if bSucceed then
        CheckBoxPass.Checked := True;
    end;
  end;
  //此逻辑用于控制 当前用户没有启用U盾时，则只显示登陆密码变更项。如果启用，则出现登陆密码变理和U盾密码变更两项。
  if BlnRet then
  begin
    rzpgPassword.Visible:=true;
    rzpgPassword.Align :=alClient;
  end else begin
    rzpgPassword.Visible :=false;
    GroupBoxUser.Parent :=Self;
    GroupBoxUser.Visible :=true;
    GroupBoxUser.Refresh;
  end;
end;

procedure TFormChgPassword.btnUKYesClick(Sender: TObject);
var
  UK:TUKeyInfo;
begin
  //
//  if Trim(EditUser_ID.Text)='' then begin
//    ShowMessage('请保存操作员后，再变更U盾密钥！');
//  end;
//  if not chkUKey.Checked then begin
//    ShowMessage('请勾选"启用网银U盾"后，再变更U盾密钥！');
//    exit;
//  end;
//  if edtNewPwd.Text<>edtConfirmPWD.Text then begin
//    edtNewPwd.Text :='';
//    edtConfirmPWD.Text:='';
//    edtNewPwd.SetFocus;
//    ShowMessage('请保存操作员后，再变更U盾密钥！');
//    exit;
//  end;
  POpenSql(ClientDataSetCZY,'select * from gl_czy where id=' + IntToStr(GCzy.id));
  if ClientDataSetCZY.RecordCount<=0 then
  begin
    ShowMessage('没有此操作员的信息，无法更改U盾密码');
    exit;
  end;

  //验证用户是否写入U盾信息中
  if ClientDataSetCZY.FieldByName('LoginUkeyCode').AsString<>'' then
  begin
    if ClientDataSetCZY.FieldByName('LoginUkeyCode').AsString<>GetUkeyCode then
    begin
      ShowMessage('用户已绑定U盾，此U盾不是绑定的U盾。'+
        'U盾序列码：'+ClientDataSetCZY.FieldByName('LoginUkeyCode').AsString);
    end;
  end;

  UK :=TUKeyInfo.InitUKeyInstance;
  UK.UKPasswordLogin :=false;
  try
    if trim(UK.Key[IntToStr(GCzy.id)])<>trim(edtOldPWD.Text) then
    begin
      edtOldPWD.Text :='';
      edtOldPWD.SetFocus;
      ShowMessage('密码不正确，请重新输入！');
      UK.Free;
      exit;
    end;

    if UK.ChangPass(IntToStr(GCzy.id),trim(edtOldPWD.Text),trim(edtNewPwd.Text)) then begin
      ShowMessage('变更U盾密钥成功！');
    end else begin
      ShowMessage('变更U盾密钥失败！');
    end;
  finally
    UK.Free;
  end;
end;

end.
