unit uEBK_Params;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls, Mask, SMaskEdit;

type
  TEBKCSSZfrm = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBoxYSzq: TGroupBox;
    Label12: TLabel;
    lbl1: TLabel;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    edtDFYH: TSMaskEdit;
    edtGRZH: TEdit;
    Label1: TLabel;
    edtFKR: TSMaskEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCity: TSMaskEdit;
    edtProvice: TComboBox;
    Label5: TLabel;
    edtYHHB: TSMaskEdit;
    procedure edtDFYHButtonClick(Sender: TObject);
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFKRButtonClick(Sender: TObject);
    procedure edtCityButtonClick(Sender: TObject);
    procedure edtYHHBButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Init;
  end;

function LoadParams:Boolean;

implementation

{$R *.dfm}
uses
  ListSelectDM, Pub_Function, Pub_Global, Pub_WYZF, DataModuleMain,
  uSelectFromData;
function LoadParams:Boolean;
var
  EBKCSSZfrm: TEBKCSSZfrm;
begin
  EBKCSSZfrm:=TEBKCSSZfrm.Create(nil);
  try
    EBKCSSZfrm.ShowModal;
  finally
    EBKCSSZfrm.Free;
  end;
end;

procedure TEBKCSSZfrm.edtDFYHButtonClick(Sender: TObject);
var
  vSelect:variant;
begin
  vSelect := ListViewSelectDM('slDFYH',
    '(gsdm=''' + PGetGSDM + ''') and (kjnd=''' + gszkjnd + ''')', False);
  if VarIsArray(vSelect) then
  begin
    edtDFYH.Text := vSelect[0] + ' ' +  PGetMC('ZB_YHZL',
        'YHDM', vSelect[0], 'YHMC', 'KJND='''+GszKJND+'''  and GSDM=''' + PGetGSDM + '''');
  end;
end;

procedure TEBKCSSZfrm.BitBtnOKClick(Sender: TObject);
begin
  if edtDFYH.Text <> '' then
  begin
    SaveParams('MRYH', edtDFYH.Text);
  end;

  if edtGRZH.Text <> '' then
  begin
    SaveParams('MRZH', edtGRZH.Text);
  end;

  if edtFKR.Text <> '' then
  begin
    SaveParams('FKR', edtFKR.Text);
  end;

  if edtProvice.Text <> '' then
  begin
    SaveParams('PROVINCE', edtProvice.Text);
  end;

  if edtCity.Text <> '' then
  begin
    SaveParams('CITY', edtCity.Text);
  end;
  
  if edtYHHB.Text <> '' then
  begin
    SaveParams('YHHB', edtYHHB.Text);
  end;

  if GEBKParams.ChangeCount > 0 then
  begin
    with GetSQLByDelta(GEBKParams, 'EBK_ZTCS', 'GSDM;KJND;CSMC') do
    begin
      PExecSQL(Text);
      Free;
      GEBKParams.MergeChangeLog;
    end;
  end;
  Close;
end;

procedure TEBKCSSZfrm.Init;
begin
  if GEBKParams.Active then
  begin
    if GEBKParams.Locate('CSMC', 'MRYH', []) then    
      edtDFYH.Text := GEBKParams.FieldByName('CSZ').AsString;

    if GEBKParams.Locate('CSMC', 'MRZH', []) then
      edtGRZH.Text := GEBKParams.FieldByName('CSZ').AsString;

    if GEBKParams.Locate('CSMC', 'FKR', []) then
      edtFKR.Text := GEBKParams.FieldByName('CSZ').AsString;
      
    if GEBKParams.Locate('CSMC', 'PROVINCE', []) then
      edtProvice.Text := GEBKParams.FieldByName('CSZ').AsString;
      
    if GEBKParams.Locate('CSMC', 'CITY', []) then
      edtCity.Text := GEBKParams.FieldByName('CSZ').AsString;
      
    if GEBKParams.Locate('CSMC', 'YHHB', []) then
      edtYHHB.Text := GEBKParams.FieldByName('CSZ').AsString;
  end;
end;

procedure TEBKCSSZfrm.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TEBKCSSZfrm.FormCreate(Sender: TObject);
begin
  Init;
end;

procedure TEBKCSSZfrm.edtFKRButtonClick(Sender: TObject);
var
  VarTemp: Variant;
  szSQL: string;
  szZHDM, szZHMC, szYHZH, szTemp: string;
  iPos: Integer;
  szTJ: string;
begin
  VarTemp := ListViewSelectDM('slSZDWYH', szTJ, False, '', True);
  if VarType(VarTemp) = varinteger then
  begin
    if (VarTemp = 0) or (VarTemp = -1) then
      exit;
  end
  else
  begin
    szTemp := VarTemp[0];
    if szTemp <> '' then
    begin
      szSQL := 'Select YHZHMC, YHZH, YHDM, YHNAME from pubszdwzh yh WHERE yh.gsdm = '+QuotedStr(GszGSDM)
      +' and YHBH= ''' + szTemp + '''';
      with DataModulePub.ClientDataSetTmp do
      begin
        Close;
        POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
        if FindFirst then
        begin
          edtFKR.Text := szTemp+' '+FieldByName('YHZHMC').AsString;
          edtDFYH.Text := FieldByName('YHDM').AsString +' '+FieldByName('YHNAME').AsString;
          edtGRZH.Text := FieldByName('YHZH').AsString;
        end;
        Close;
      end;
    end;
  end;
end;

procedure TEBKCSSZfrm.edtCityButtonClick(Sender: TObject);
var
  SelVar:Variant;
  szSQL:String;
begin
  szSQL :='Select AREACODE, AREA_NAME from ebk_areacode '+iff(edtProvice.Text='', '', ' where PROVINCE='+QuotedStr(edtProvice.Text));
  SelVar := SelectLst(szSQL, 'AREACODE, AREA_NAME', False, '');
  if VarIsArray(SelVar) then
    edtCity.Text := SelVar[0][0]+' '+ SelVar[0][1];
end;

procedure TEBKCSSZfrm.edtYHHBButtonClick(Sender: TObject);
var
  SelVar:Variant;
  szSQL:String;
begin
  szSQL :='select DEPID, DEP_NAME from EBK_DEPID';
  SelVar := SelectLst(szSQL, 'DEPID, DEP_NAME', False, '');
  if VarIsArray(SelVar) then
    edtYHHB.Text := SelVar[0][0]+' '+ SelVar[0][1];
  //
end;

end.
