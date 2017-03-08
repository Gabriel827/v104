unit PLAT_EditorLawRules;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, Pub_Message;

type
  TFormLawRuleEditor = class(TForm)
    Label1: TLabel;
    edtLRName: TEdit;
    Label2: TLabel;
    edtLRTitle: TEdit;
    Label3: TLabel;
    edtLRAuthor: TEdit;
    Label4: TLabel;
    edtLRKeyWords: TEdit;
    Label5: TLabel;
    edtLRAbstract: TEdit;
    Label6: TLabel;
    LRFileName: TFilenameEdit;
    Button1: TButton;
    Button2: TButton;
    ComboBoxGroupItems: TComboBox;
    Label7: TLabel;
    CheckBoxInMenu: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function CheckValid: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLawRuleEditor: TFormLawRuleEditor;

implementation
uses PLAT_LawRuleFactory, PLAT_LAWRuleInterface;

{$R *.DFM}

function TFormLawRuleEditor.CheckValid(): boolean;
begin
  if self.edtLRName.text = '' then
  begin
    Result := false;
    SysMessage('请输入名称！', '_JG', [mbok]);
    exit;
  end;
  if self.edtLRTitle.text = '' then
  begin
    Result := false;
    SysMessage('请输入标题！', '_JG', [mbok]);
    exit;
  end;

  LRFileName.text := (StringReplace(LRFileName.text, '"', '', [rfReplaceAll]));
  if edtLRName.Enabled and (TLawRuleFactory.GetInstance.FindLawRule(edtLRName.Text)) then
  begin
    Result := false;
    SysMessage(edtLRName.Text + '已经存在', '_JG', [mbok]);
    exit;

  end;

  if self.LRFileName.text = '' then
  begin
    Result := true;
    exit;
  end;

  if FileExists(LRFileName.text) then
    Result := true
  else
  begin
    Result := false;
    SysMessage('不存在的文件' + LRFileName.text, '_JG', [mbok]);
  end;
end;

procedure TFormLawRuleEditor.Button1Click(Sender: TObject);
var
  lr: ILawRule;
begin

  if CheckValid() then
  begin
    if edtLRName.Enabled then
      lr := TLawRuleFactory.GetInstance.GetLawRule(edtLRName.text, edtLRTitle.text, edtLRAuthor.Text, edtLRKeyWords.text, edtLrAbstract.text, LRFileName.text, ComboboxGroupItems.Text, CheckBoxInMenu.Checked);
    self.ModalResult := mrOK;
  end;

end;

procedure TFormLawRuleEditor.FormCreate(Sender: TObject);
var
  strs: TStringList;
begin
  strs := TStringList.Create();
  TLawRuleFactory.GetInstance.GetGroupItems(strs);
  ComboboxGroupItems.Clear;
  ComboboxGroupItems.Items.addstrings(strs);

  strs.Free;
  //if GbDFZB Then
     CheckBoxInMenu.Visible := False;
end;

end.
