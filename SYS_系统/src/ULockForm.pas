unit ULockForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBClient, ExtCtrls;

type
  TfrmLockForm = class(TForm)
    Label1: TLabel;
    edtPassword: TEdit;
    btnYes: TButton;
    ClientDataSetTmp: TClientDataSet;
    tmrLockForm: TTimer;
    procedure btnYesClick(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure tmrLockFormTimer(Sender: TObject);
  private
    { Private declarations }
    icwcs : integer;        //错误次数
  public
    { Public declarations }
  end;

var
  frmLockForm: TfrmLockForm;

implementation

uses
   Pub_Function,Pub_Global,AnyiCoder,Pub_Message;
{$R *.dfm}

procedure TfrmLockForm.btnYesClick(Sender: TObject);
var
  tmpPassCode,sDecode,sKeyPass:string;
  bSucceed:Boolean;
begin
  //
  POpenSql(ClientDataSetTmp,'select * from gl_czy where id='+IntToStr(GCzy.ID));
  tmpPassCode := Trim(ClientDataSetTmp.FieldByName('password').asString);
  sDecode := TAnyiCoder.Decode(tmpPassCode,sKeyPass,bSucceed); //尝试解密
  GCzyMMJM := bsucceed;   //解密是否成功，成功则表示该密码加密了
  if (GCzyMMJM and (sDecode=Trim(edtPassword.Text)))
         or ((not GCzyMMJM) and ((tmpPassCode = edtPassword.Text)) and (tmpPassCode <> ''))  then
  begin
    Self.Close;
  end else begin
    //输入次数超出后，限制登陆10分钟 Added by chengjf 2015-06-24
    inc(icwcs);
    if icwcs=GblInputCount then
    begin
      SysMessage('密码输入错误已达到'+inttostr(icwcs)+'次，将禁止登陆10分钟！', '_JG', [mbOk]);
      icwcs := 0;
      edtPassword.Enabled := False;
      btnYes.Enabled := False;
      tmrLockForm.Interval := 600000;
      tmrLockForm.Enabled := True;
      Exit;
    end;
    SysMessage('密码错误，请重新输入！', '_JG', [mbOk]);
    edtPassword.SetFocus;
  end;
end;

procedure TfrmLockForm.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btnYes.Click;
end;

procedure TfrmLockForm.tmrLockFormTimer(Sender: TObject);
begin
  edtPassword.Enabled := True;
  btnYes.Enabled := True;
  tmrLockForm.Enabled := False;
end;

end.
