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
    FormChgPassword.MaskEditOldPassword.Text := GCzy.Password; //added zhouyunlu ֧�ֵ�½���������ʱ���Զ�����½ʱ�����루�����ڵ�½ʱ��
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
  //ORACLE�н������޸�Ϊ�պ󣬾��޷��ٽ���ϵͳ�ˣ�Ҳ�޷����п�����޸ģ������¿����Ϊ�ա�
  if MaskEditNewPassword.Text = '' then
  begin
    SysMessage('�¿����Ϊ�գ����������롣', 'ChgPassword_01_CW', [mbOK]);
    MaskEditNewPassword.SetFocus;
    exit;
  end;

  if MaskEditNewPassword.Text <> MaskEditRePassword.Text then
  begin
    SysMessage('ȷ�Ͽ�����ָ���¿���������������롣', 'ChgPassword_01_CW', [mbOK]);
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
      SysMessage('�����ݱ�������˳����ԡ�', 'Pub_01_CW', [mbOK]);
      ClientDataSetPub.Close;
      exit;
    end;
    if not ClientDataSetPub.FindFirst then
    begin
      ClientDataSetPub.Close;
      SysMessage('û���ҵ���Ӧ�Ĳ���Ա', 'ChgPassword_02_CW', [mbOK]);
      MaskEditOldPassword.SetFocus;
      exit;
    end;

    //�жϾ������Ƿ���ȷ
    tmpPassCode := Trim(ClientDataSetPub.FieldByName('password').asString); //����ȥ���ո� lzn 2005.10.21
    tmpCZY := GCzy.Name;
    sDecode := TAnyiCoder.Decode(tmpPassCode,sKeyPass,bSucceed); //���Խ���

    if (bSucceed and (MaskEditOldPassword.text=sDecode)) or
      ((not bSucceed) and (tmpPassCode = MaskEditOldPassword.Text)) then

    else begin      //if tmpPassword <> MaskEditOldPassword.Text then
      ClientDataSetPub.Close;
      SysMessage('ԭ��������������������롣', 'ChgPassword_02_CW', [mbOK]);
      MaskEditOldPassword.SetFocus;
      exit;
    end;

    {
      zhengjy 2014-10-11 ����������������汾������ǿ�ȿ���
    }
    if (GblEncryType>0) and (Length(Trim(MaskEditNewPassword.Text))<8) then
    begin
      SysMessage('���볤�ȱ���8λ���ϣ�����8λ��', 'ChgPassword_02_CW', [mbOK]);
      Exit;
    end;
    case GblEncryType of
      1:begin  //��֤����һ�ֵĿ���
        if not (TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeOne)
           or TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeTwo)
           or TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeThree)) then
        begin
          SysMessage('��������ĸ�����ֺ������ַ���ɡ���������������һ�����', 'ChgPassword_02_CW', [mbOK]);
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
          SysMessage('��������ĸ�����ֺ������ַ���ɡ��������������ж������', 'ChgPassword_02_CW', [mbOK]);
          Exit;
        end;
      end;
      3:begin
        if not (TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeOne)
           and  TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeTwo)
           and  TCheckType.CheckCharType(MaskEditNewPassword.Text,edCharTypeThree)) then
        begin
          SysMessage('��������ĸ�����ֺ������ַ���ɡ����������������������', 'ChgPassword_02_CW', [mbOK]);
          Exit;
        end;
      end;
      else begin

      end;
    end;

    //�������봦��
    tmpPassCode := Trim(MaskEditNewPassword.Text);
    // bSucceed then      //tmpPassCode := jiami128(tmpCZY, MaskEditNewPassword.Text) + jiami128(GszZth, GszDbName)
    //ά����20160914143347��ϵͳ����Ա֧��������� Modified by chengjf 2016-09-20 
    if CheckBoxPass.Checked then
       tmpPassCode:= TAnyiCoder.Encode(tmpPassCode,sKeypass);
      
    szSql := '';
    if Gdbtype = Oracle then
      szSql := 'begin ';
    szSql := szSql + 'update gl_czy set password=''' + tmpPassCode +
      ''' where (name=''' + GCzy.Name + ''') and (type=''1'') and id=' + IntToStr(GCzy.id);
    if Gdbtype = Oracle then //�޸ĺ��������Ҫ�ύ lzn
      szSql := szsql + ';commit;end;';
    try
      PExecSql(szSql);
      SysMessage('�޸ĳɹ�! ���ס������!', 'Pub_01_YB', [mbOK]);
    except
      SysMessage('�����ݱ�������˳����ԡ�', 'Pub_01_CW', [mbOK]);
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
    //ά����20160914143347��ϵͳ����Ա֧��������� Modified by chengjf 2016-09-20 
    tmpPassCode := DataModulePub.ClientDataSetTmp.fieldbyName('password').AsString;
    if GCzy.id = 1 then
    begin
      CheckBoxPass.Visible := True;
      sDecode := TAnyiCoder.Decode(tmpPassCode,sKeyPass,bSucceed);
      if bSucceed then
        CheckBoxPass.Checked := True;
    end;
  end;
  //���߼����ڿ��� ��ǰ�û�û������U��ʱ����ֻ��ʾ��½�������������ã�����ֵ�½��������U�����������
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
//    ShowMessage('�뱣�����Ա���ٱ��U����Կ��');
//  end;
//  if not chkUKey.Checked then begin
//    ShowMessage('�빴ѡ"��������U��"���ٱ��U����Կ��');
//    exit;
//  end;
//  if edtNewPwd.Text<>edtConfirmPWD.Text then begin
//    edtNewPwd.Text :='';
//    edtConfirmPWD.Text:='';
//    edtNewPwd.SetFocus;
//    ShowMessage('�뱣�����Ա���ٱ��U����Կ��');
//    exit;
//  end;
  POpenSql(ClientDataSetCZY,'select * from gl_czy where id=' + IntToStr(GCzy.id));
  if ClientDataSetCZY.RecordCount<=0 then
  begin
    ShowMessage('û�д˲���Ա����Ϣ���޷�����U������');
    exit;
  end;

  //��֤�û��Ƿ�д��U����Ϣ��
  if ClientDataSetCZY.FieldByName('LoginUkeyCode').AsString<>'' then
  begin
    if ClientDataSetCZY.FieldByName('LoginUkeyCode').AsString<>GetUkeyCode then
    begin
      ShowMessage('�û��Ѱ�U�ܣ���U�ܲ��ǰ󶨵�U�ܡ�'+
        'U�������룺'+ClientDataSetCZY.FieldByName('LoginUkeyCode').AsString);
    end;
  end;

  UK :=TUKeyInfo.InitUKeyInstance;
  UK.UKPasswordLogin :=false;
  try
    if trim(UK.Key[IntToStr(GCzy.id)])<>trim(edtOldPWD.Text) then
    begin
      edtOldPWD.Text :='';
      edtOldPWD.SetFocus;
      ShowMessage('���벻��ȷ�����������룡');
      UK.Free;
      exit;
    end;

    if UK.ChangPass(IntToStr(GCzy.id),trim(edtOldPWD.Text),trim(edtNewPwd.Text)) then begin
      ShowMessage('���U����Կ�ɹ���');
    end else begin
      ShowMessage('���U����Կʧ�ܣ�');
    end;
  finally
    UK.Free;
  end;
end;

end.
