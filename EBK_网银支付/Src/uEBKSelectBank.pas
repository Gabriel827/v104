unit uEBKSelectBank;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGridEh, DBClient, ExtCtrls, DB;

type
  TfrmSelectBank = class(TForm)
    Label1: TLabel;
    cmbProvice: TComboBox;
    cmbCity: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    cmbBank: TComboBox;
    edtFilter: TEdit;
    Label4: TLabel;
    btnSearch: TButton;
    Panel1: TPanel;
    grdWY: TDBGridEh;
    cdsWY: TClientDataSet;
    dsWY: TDataSource;
    btnOK: TButton;
    procedure btnSearchClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbProviceChange(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    FDEPID: String;
    procedure SetDEPID(const Value: String);
    { Private declarations }
  public
    { Public declarations }
    property DEPID:String read FDEPID write SetDEPID;
  end;

var
  frmSelectBank: TfrmSelectBank;
  GEBKParams: TClientDataSet;
implementation
uses
  Pub_Function, DateUtils, DataModuleMain, Pub_Global;
{$R *.dfm}

procedure TfrmSelectBank.btnSearchClick(Sender: TObject);
var
  vSQL:String;
begin
  if cmbBank.ItemIndex < 0 then
  begin
    Application.MessageBox('请选择银行！','系统提示', MB_ICONWarning + MB_OK);
    cmbBank.SetFocus;
    Exit;
  end;
  if cmbProvice.ItemIndex < 0 then
  begin
    if Trim(edtFilter.Text) = '' then
    begin
      Application.MessageBox('请输入模糊信息进行查找！','系统提示', MB_ICONWarning + MB_OK);
      cmbProvice.SetFocus;
      Exit;
    end;
  end;

  if cmbProvice.ItemIndex < 0 then
    vSQL := 'Select BANK_CODE, BANK_NAME from EBK_BANKINFO Where DEPID='+QuotedStr(TString.LeftStrBySp(cmbBank.Text))
      +IFF(edtFilter.text='', '', ' and BANK_NAME like '+QuotedStr('%'+edtFilter.text+'%'))
  else
    vSQL := 'Select BANK_CODE, BANK_NAME from EBK_BANKINFO Where DEPID='+QuotedStr(TString.LeftStrBySp(cmbBank.Text))
      +IFF(cmbCity.ItemIndex >=0 ,' and AREACODE='+QuotedStr(TString.LeftStrBySp(cmbCity.Text))
      ,' and AREACODE  in (Select AREACODE from EBK_AREACODE where PROVID='+QuotedStr(TString.LeftStrBySp(cmbProvice.Text))+')')
      +IFF(edtFilter.text='', '', ' and BANK_NAME like '+QuotedStr('%'+edtFilter.text+'%'));
  POpenSQL(cdsWY, vSQL);
end;

procedure TfrmSelectBank.FormCreate(Sender: TObject);
begin
  grdWY.FixedColor := Self.Color;
  with DataModulePub.GetCdsBySQL('SELECT DEPID, DEP_NAME FROM EBK_DEPID') do
  begin
    cmbBank.Items.Clear;
    while not eof do
    begin
      cmbBank.Items.Add(FieldByName('DEPID').AsString+' '+FieldByName('DEP_NAME').AsString);
      Next;
    end;
  end;
  if cmbProvice.ItemIndex > 0 then
    cmbProviceChange(nil);
end;

function ReadParams(CSMC: string): string;
begin
  Result := '';
  if GEBKParams = nil then
    GEBKParams := DataModulePub.GetCdsBySQL('Select * from EBK_ZTCS where GSDM=' + QuotedStr(GszGSDM)
      + ' and KJND=' + QuotedStr(GszKJND));
  if GEBKParams.Locate('CSMC', CSMC, []) then
    Result := GEBKParams.FieldByName('CSZ').AsString;
end;

procedure TfrmSelectBank.cmbProviceChange(Sender: TObject);
var
  DefCity:string;
begin
  //查询省市的结果
  with DataModulePub.GetCdsBySQL('SELECT AREACODE, AREA_NAME FROM EBK_AREACODE WHERE PROVID='
    +QuotedStr(TString.LeftStrBySp(cmbProvice.Text))) do
  begin
    cmbCity.Clear;
    while not eof do
    begin
      cmbCity.Items.Add(FieldByName('AREACODE').AsString+' '+FieldByName('AREA_NAME').AsString);
      Next;      
    end;
    DefCity := ReadParams('CITY');
    if cmbCity.Items.IndexOf(DefCity) > 0 then
      cmbCity.ItemIndex := cmbCity.Items.IndexOf(DefCity);
  end;
end;

procedure TfrmSelectBank.btnOKClick(Sender: TObject);
begin
  if not cdsWY.Active then Exit;
  if cdsWY.RecordCount = 0 then
  begin
    Application.MessageBox('无数据， 请重新查询！', '系统提示', MB_ICONWarning+MB_OK);
    Exit;
  end;
  ModalResult := mrOK;
end;

procedure TfrmSelectBank.SetDEPID(const Value: String);
begin
  FDEPID := Value;
  if cmbBank.Items.IndexOf(Value)>=0 then
    cmbBank.ItemIndex := cmbBank.Items.IndexOf(Value);
end;

end.
