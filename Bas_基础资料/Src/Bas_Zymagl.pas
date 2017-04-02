unit Bas_Zymagl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Tgrids2, THDBGrids, ExtCtrls, Db, DBClient, THFilters;

type
  TBas_PwdFrm = class(TForm)
    Panel1: TPanel;
    Button3: TButton;
    cdszyxx: TClientDataSet;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Label1: TLabel;
    THDBGrid1: TTHDBGrid;
    GroupBox1: TGroupBox;
    Button1: TButton;
    edtInitPassword: TEdit;
    THFilterZYXX: TTHFilter;
    Button2: TButton;
    Button4: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Editquery: TEdit;
    btnsearch: TButton;
    EditNewpass: TEdit;
    EditNewPass2: TEdit;
    btnMoid: TButton;
    RadioButtonCSMM: TRadioButton;
    GroupBox3: TGroupBox;
    rbAll: TRadioButton;
    rbNo: TRadioButton;
    RadioButtonSFZMM: TRadioButton;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnsearchClick(Sender: TObject);
    procedure cdszyxxAfterScroll(DataSet: TDataSet);
    procedure Button3Click(Sender: TObject);
    procedure btnMoidClick(Sender: TObject);
    procedure EditqueryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure THFilterZYXXFilter(Sender: TObject; AFilter: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Bas_PwdFrm: TBas_PwdFrm;

  procedure LoadZymagl();

implementation
uses Pub_Function,Pub_Global,Pub_Power;

{$R *.DFM}
procedure LoadZymagl();
begin
  try
    Bas_PwdFrm:= TBas_PwdFrm.Create (nil);
    Bas_PwdFrm.ShowModal ;
  finally
    freeandnil(Bas_PwdFrm);
  end;
end;

procedure TBas_PwdFrm.FormCreate(Sender: TObject);
var
 szsql:string;
begin
  PSetClientDataSetProvider(self);
  szsql := format('select BM.BMDM, BM.BMMC, ZYDM, ZYXM from PUBZYXX ZY left join PUBBMXX BM on ZY.GSDM=BM.GSDM and ZY.KJND=BM.KJND and ZY.BMDM=BM.BMDM '
    +' where ZY.gsdm=''%s'' and ZY.kjnd=''%s'' ',[gszgsdm, gszkjnd]);
  szsql := szsql + ' and ' + PSJQX('ZY','zydm'); // 2012-11-20 mengjin
  popensql(cdszyxx, szsql);
end;

procedure TBas_PwdFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cdszyxx.close;
end;

procedure TBas_PwdFrm.btnsearchClick(Sender: TObject);
var
  str: string;
begin
  str := trim(Editquery.Text );
  if str <>'' then
  begin
    cdszyxx.Filtered :=false;
    cdszyxx.Filter :='zydm like ''%'+str+ '%'' or zyxm like ''%' +str+'%''';
    cdszyxx.Filtered :=true;
  end
  else
  begin
    cdszyxx.Filtered :=false;
  end
end;

procedure TBas_PwdFrm.cdszyxxAfterScroll(DataSet: TDataSet);
begin
  EditNewpass.Text :='';
  EditNewpass2.Text :='';
end;

procedure TBas_PwdFrm.Button3Click(Sender: TObject);
begin
  close;
end;

procedure TBas_PwdFrm.btnMoidClick(Sender: TObject);
begin
  if   EditNewpass.Text <> EditNewpass2.Text then
  begin
    showmessage('两次密码输入不相同，请重新输入！');
    exit;
  end;
  PExecSQL('Update PUBZYXX set password='+QuotedStr(EditNewpass.Text)+' where zydm='
    +QuotedStr(cdszyxx.FieldByName('zydm').AsString)+' and GSDM='+QuotedStr(GszGSDM)
    +' and KJND=' + QuotedStr(GszKJND));
  showmessage('修改成功！');
end;

procedure TBas_PwdFrm.EditqueryKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then btnsearch.OnClick (sender);
end;

procedure TBas_PwdFrm.Button1Click(Sender: TObject);
var
  cdtn,szSQL:String;
begin
  //初始化密码

  if (RadioButtonCSMM.Checked) and (edtInitPassword.Text='') then
  begin
    showmessage('请输入初始化密码！');
    edtInitPassword.SetFocus;
    exit;
  end;
  if rbNo.Checked then
    cdtn := '(password='''' or password is null)';
  if Application.MessageBox('确定要初始化密码吗？',  '系统提示', MB_ICONQuestion + MB_YesNo)=IDYES then
  begin
    //20160530084519 add by chengjf 20160602 支持密码初始化为身份证后六位
    if RadioButtonCSMM.Checked then
      szSQL := 'Update PUBZYXX set Password='+QuotedStr(edtInitPassword.Text)+' where GSDM='+QuotedStr(GszGSDM)
        +IFF(cdtn='', '', ' and '+cdtn)
    else if RadioButtonSFZMM.Checked then
      szSQL := 'Update PUBZYXX set Password=right(sfzh,6) where GSDM='+QuotedStr(GszGSDM)
        +IFF(cdtn='', '', ' and '+cdtn);
    PExecSQL(szSQL);
     Application.MessageBox('初始密码完成！',  '系统提示', MB_ICONInformation+MB_OK);
  end;
end;

procedure TBas_PwdFrm.Button2Click(Sender: TObject);
begin
  THFilterZYXX.UseLikeEx := True;
  THFilterZYXX.ExecFilter;
  cdszyxx.Filter := THFilterZYXX.CurFilter;
  cdszyxx.Filtered := True;
end;

procedure TBas_PwdFrm.Button4Click(Sender: TObject);
begin
  THFilterZYXX.RestoreFilter;
  cdszyxx.Filtered := False;
end;

procedure TBas_PwdFrm.THFilterZYXXFilter(Sender: TObject; AFilter: String);
begin
 // cdszyxx.Filter := AFilter;
 // cdszyxx.Filtered := True;
end;

end.

