unit ChgUsername;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormXGMC = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    lbl1: TLabel;
    edtNewMC: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormXGMC: TFormXGMC;

procedure ChangeUsername;

implementation

uses Pub_Function, Pub_Global, Pub_Message;

{$R *.dfm}

procedure ChangeUsername;
begin
  if GCzy.id = 1 then
  begin
    SysMessage('�����޸�ϵͳ����Ա�����ơ�', 'ChgPassword_01_CW', [mbOK]);
    exit;
  end;
  Application.CreateForm(TFormXGMC, FormXGMC);
  SetComponentsColor(FormXGMC);
  FormXGMC.ShowModal;
end;

procedure TFormXGMC.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormXGMC.btnOkClick(Sender: TObject);
var
  szSql: string;
begin
  if Trim(edtNewMC.Text) = '' then
  begin
    SysMessage('�����Ʋ���Ϊ�գ����������롣', 'ChgPassword_01_CW', [mbOK]);
    edtNewMC.SetFocus;
    exit;
  end;

  szSql := '';
  if Gdbtype = Oracle then
    szSql := 'begin ';
  szSql := szSql + 'update gl_czy set name='''+ Trim(edtNewMC.Text) +
    ''' where id=' + IntToStr(GCzy.id);
  if Gdbtype = Oracle then //�޸ĺ��������Ҫ�ύ lzn
    szSql := szsql + ';commit;end;';
  try
    PExecSql(szSql);
    SysMessage('�޸ĳɹ�!', 'Pub_01_YB', [mbOK]);
  except
    SysMessage('�����ݱ�������˳����ԡ�', 'Pub_01_CW', [mbOK]);
    exit;
  end;
  GCzy.name := Trim(edtNewMC.Text);

  Close;
end;

procedure TFormXGMC.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
