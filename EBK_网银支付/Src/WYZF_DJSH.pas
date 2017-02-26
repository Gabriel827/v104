unit WYZF_DJSH;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, PUB_WYZF, EBK_UKeyInfo;

type
  TFrmWYZF_DJSH = class(TForm)
    pnlClient: TPanel;
    Bevel1: TBevel;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    pnlInfo: TPanel;
    Label1: TLabel;
    MemoYJ: TMemo;
    pnlTop: TPanel;
    grpSH: TGroupBox;
    RadioButtonTG: TRadioButton;
    RadioButtonTHSYB: TRadioButton;
    RadioButtonTHBZR: TRadioButton;
    procedure BitBtnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure RadioButtonTGClick(Sender: TObject);
  private
    { Private declarations }
    FUK :TUKeyInfo;
  public
    { Public declarations }
  end;

var
  FrmWYZF_DJSH: TFrmWYZF_DJSH;

function LoadWYZFDJSH(ADJInfo: TWYZFRec; var szMemo: string; var ABillAction: TWYZF_Bill_Action): Boolean;

implementation

uses Pub_Message,Pub_Global,Pub_power;

{$R *.dfm}

function LoadWYZFDJSH(ADJInfo: TWYZFRec; var szMemo: string; var ABillAction: TWYZF_Bill_Action): Boolean;
var
  bCanSH:Boolean;
begin
  bCanSH := PGetCzySHQX(GCzy.ID, ADJInfo.SHFlow, ADJInfo.NextSHJD);
  if Application.FindComponent('FrmWYZF_DJSH') = nil then
    Application.CreateForm(TFrmWYZF_DJSH, FrmWYZF_DJSH);
  with FrmWYZF_DJSH do
  begin
    MemoYJ.Text := 'ͨ��';
    RadioButtonTG.Enabled := bCanSH and (ADJInfo.DJStatus in [djSSH,djSHH]) and (ADJInfo.CurSHJD <> 999);
    RadioButtonTHSYB.Enabled := (ADJInfo.DJStatus in [djSHH]) and (ADJInfo.NextSHJD <> -9);
    RadioButtonTHBZR.Enabled := (ADJInfo.DJStatus in [djSSH,djSHH]);
    //����˻�Ȩ��У��
    if not TPower.GetPower(GN_WYZF_TH) then
    begin
      RadioButtonTHSYB.Enabled := False;
      RadioButtonTHBZR.Enabled := False;
    end;
    if RadioButtonTG.Enabled then
      RadioButtonTG.Checked := True
    else if RadioButtonTHSYB.Enabled then
      RadioButtonTHSYB.Checked := True
    else if RadioButtonTHBZR.Enabled then
      RadioButtonTHBZR.Checked := True;

    if RadioButtonTG.Checked then
      MemoYJ.Text := 'ͨ��'
    else if RadioButtonTHSYB.Checked then
      MemoYJ.Text := '��ͨ��'
    else if RadioButtonTHBZR.Checked then
      MemoYJ.Text := '��ͨ��';

    //zhengjy ������˵�Ukey��֤
    if  RadioButtonTG.Checked then begin
      if UKeyCheck(GCzy.ID, ADJInfo.SHFlow, ADJInfo.NextSHJD)  then begin
        FUK :=TUKeyInfo.InitUKeyInstance;
        if FUK.Error = '' then
        begin
          if FUK.Get_KeyName(0) <> IntToStr(GCzy.ID) then
          begin
            Result :=true;
            ABillAction :=baNOUKEY;
            ShowMessage('���ǵ�ǰ����Ա��U�ܣ���������ˣ�');
            Close;
            Exit;
          end
        end
        else
        begin
          ShowMessage(FUK.Error);
          Result :=true;
          ABillAction :=baNOUKEY;
          Close;
          exit;
        end;
      end;
    end;

    ShowModal;
    szMemo := Trim(MemoYJ.Text);
    if RadioButtonTG.Checked then
      ABillAction := baSH
    else if RadioButtonTHSYB.Checked then
      ABillAction := baXS
    else if RadioButtonTHBZR.Checked then
      ABillAction := baTH;
    Result := (ModalResult = ID_OK);
    FreeAndNil(FrmWYZF_DJSH);
    //Close;
  end;
end;

{ TfmCLYJ }

procedure TFrmWYZF_DJSH.BitBtnOKClick(Sender: TObject);
begin
  if Trim(MemoYJ.Text) = '' then
  begin
    SysMessage('������д���������', '_JG', [mbOK]);
    Exit;
  end;
  if Length(Trim(MemoYJ.Text)) > 200 then
  begin
    SysMessage('����������ݹ��࣬����������100���ַ������������룡', '_JG', [mbOK]);
    Exit;
  end;
  ModalResult := ID_OK;
end;

procedure TFrmWYZF_DJSH.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := CaFree;
  if Assigned(FUK) then FreeAndNil(FUK);
end;

procedure TFrmWYZF_DJSH.BitBtnCancelClick(Sender: TObject);
begin
  ModalResult:= ID_Cancel;
end;

procedure TFrmWYZF_DJSH.RadioButtonTGClick(Sender: TObject);
begin
  if (MemoYJ.Text = 'ͨ��') or (MemoYJ.Text = '��ͨ��') then
  begin
    if RadioButtonTG.Checked then
      MemoYJ.Text := 'ͨ��'
    else if RadioButtonTHSYB.Checked then
      MemoYJ.Text := '��ͨ��'
    else if RadioButtonTHBZR.Checked then
      MemoYJ.Text := '��ͨ��';
  end;
end;

end.

