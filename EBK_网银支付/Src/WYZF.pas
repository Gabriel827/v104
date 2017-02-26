unit WYZF;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, SMaskEdit, Buttons, IdBaseComponent, ExtCtrls, variants, SpeedBar,
  ComCtrls, THExtCtrls, DB, DBClient, ComObj, ToolEdit, CurrEdit, Menus, Pub_WYZF,
  Grids, DBGridEh, Tabs;

type
  TWYZFOper = (OpBrowse, OpAdd, OpEdit, OpCheck, OpUnCheck);
  TFormWYZF = class(TForm)
    lblZFZT: TLabel;
    SpeedBarWYZF: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection5: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    SpeedbarSection4: TSpeedbarSection;
    SpeedItem_Print: TSpeedItem;
    SpeedItem_First: TSpeedItem;
    SpeedItem_Prior: TSpeedItem;
    SpeedItem_Next: TSpeedItem;
    SpeedItem_Last: TSpeedItem;
    SpeedItem_insert: TSpeedItem;
    SpeedItem_Check: TSpeedItem;
    SpeedItem_Save: TSpeedItem;
    SpeedItem_Help: TSpeedItem;
    SpeedItem_Exit: TSpeedItem;
    PanelTitle: TPanel;
    Label20: TLabel;
    Label22: TLabel;
    LabelTitle: TLabel;
    THBDJZT: TTHBevel;
    edtZFID: TEdit;
    DateYWRQ: TDateTimePicker;
    PanelOther: TPanel;
    SpeedItem_copy: TSpeedItem;
    ComboBoxYWYH: TComboBox;
    Label21: TLabel;
    Label23: TLabel;
    Label222: TLabel;
    Label111: TLabel;
    Label000: TLabel;
    LabelSHR1: TLabel;
    LabelSHR2: TLabel;
    LabelLRR: TLabel;
    ClientDataSetTmp: TClientDataSet;
    SpeedItem_Edit: TSpeedItem;
    SpeedItem_Cancel: TSpeedItem;
    MainMenuWYZF: TMainMenu;
    MFile: TMenuItem;
    MPrint: TMenuItem;
    MDataTo: TMenuItem;
    MLExit: TMenuItem;
    MExit: TMenuItem;
    MRun: TMenuItem;
    M_Add: TMenuItem;
    M_modify: TMenuItem;
    M_save: TMenuItem;
    MLWLDW: TMenuItem;
    M_ZF: TMenuItem;
    M_SH: TMenuItem;
    M_XS: TMenuItem;
    M_Delete: TMenuItem;
    N1: TMenuItem;
    M_HY: TMenuItem;
    ClientDataSetWYZF00: TClientDataSet;
    SpeedItem_do: TSpeedItem;
    SpeedItem_Check2: TSpeedItem;
    Label333: TLabel;
    LabelZXR: TLabel;
    N2: TMenuItem;
    M_QXZX: TMenuItem;
    SpeedItem_CheckNew: TSpeedItem;
    SpeedItem_SSSH: TSpeedItem;
    LabelSHR: TLabel;
    MPrintSetup: TMenuItem;
    LabelYDJBH: TLabel;
    LabelBANKUQNO: TLabel;
    LabelBUSIUQNO: TLabel;
    LabelHEADBUSIUQNO: TLabel;
    LabelZFSJ: TLabel;
    ComboBoxYWLX: TComboBox;
    PanelDJXX: TPanel;
    GroupBox1: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    edtCLXX: TEdit;
    edtZFXX: TEdit;
    M_CXZX: TMenuItem;
    Label26: TLabel;
    ComboBoxSJLY: TComboBox;
    pc: TPageControl;
    tsAll: TTabSheet;
    tsZFXX: TTabSheet;
    PanelWYZF: TPanel;
    grpYHZH: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabelMC: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtYHZH: TSMaskEdit;
    edtYHHH: TEdit;
    edtZHMC: TEdit;
    edtKHYH: TEdit;
    edtKHDQ: TEdit;
    edtFKR: TSMaskEdit;
    edtYHWD: TEdit;
    edtYHHB: TComboBox;
    edtFKRMC: TSMaskEdit;
    GroupBox2: TGroupBox;
    Label9: TLabel;
    Label8: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    edtYHHB2: TSMaskEdit;
    CB_PROVINCE: TComboBox;
    CB_CITY: TComboBox;
    CB_DEPID: TComboBox;
    edtSKRMC: TSMaskEdit;
    edtSKR: TSMaskEdit;
    edtZHMC2: TSMaskEdit;
    edtYHZH2: TSMaskEdit;
    edtKHYH2: TEdit;
    edtKHDQ2: TEdit;
    edtYHWD2: TEdit;
    GroupBox3: TGroupBox;
    Label17: TLabel;
    Label10: TLabel;
    edtZY: TEdit;
    edtJE: TCurrencyEdit;
    rgYWLX: TRadioGroup;
    edtYDJBH: TEdit;
    edtYDJSJ: TEdit;
    grd: TDBGridEh;
    cdsGroup: TClientDataSet;
    ds: TDataSource;
    btnNewZF: TSpeedItem;
    cdsZFD: TClientDataSet;
    tsState: TTabSet;
    procedure FormCreate(Sender: TObject);
    procedure edtYHZH2ButtonClick(Sender: TObject);
    procedure edtYHZHButtonClick(Sender: TObject);
    procedure SpeedItem_ExitClick(Sender: TObject);
    procedure SpeedItem_SaveClick(Sender: TObject);
    procedure SpeedItem_insertClick(Sender: TObject);
    procedure SpeedItem_copyClick(Sender: TObject);
    procedure SpeedItem_EditClick(Sender: TObject);
    procedure SpeedItem_CancelClick(Sender: TObject);
    procedure SpeedItem_CheckClick(Sender: TObject);
    procedure M_ZFClick(Sender: TObject);
    procedure M_HYClick(Sender: TObject);
    procedure M_DeleteClick(Sender: TObject);
    procedure SpeedItem_Check2Click(Sender: TObject);
    procedure SpeedItem_doClick(Sender: TObject);

    procedure SpeedItem_FirstClick(Sender: TObject);
    procedure SpeedItem_PriorClick(Sender: TObject);
    procedure SpeedItem_NextClick(Sender: TObject);
    procedure SpeedItem_LastClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtFKRButtonClick(Sender: TObject);
    procedure edtSKRButtonClick(Sender: TObject);
    procedure edtZYKeyPress(Sender: TObject; var Key: Char);
    procedure M_QXZXClick(Sender: TObject);
    procedure SpeedItem_CheckNewClick(Sender: TObject);
    procedure SpeedItem_SSSHClick(Sender: TObject);
    procedure edtYHHB2ButtonClick(Sender: TObject);
    procedure edtZHMC2ButtonClick(Sender: TObject);
    procedure MPrintSetupClick(Sender: TObject);
    procedure MPrintClick(Sender: TObject);
    procedure SpeedItem_PrintClick(Sender: TObject);
    procedure CB_PROVINCEChange(Sender: TObject);
    procedure CB_CITYChange(Sender: TObject);
    procedure CB_DEPIDChange(Sender: TObject);
    procedure ComboBoxYWLXChange(Sender: TObject);
    procedure M_CXZXClick(Sender: TObject);
    procedure btnNewZFClick(Sender: TObject);
    procedure tsStateChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
  Private
    { Private declarations }
    FormHeight, DJXXHeight: Integer;
    ISGROUP: Boolean;
    AGSDM, AYWND, AYWQJ, AYWYH, AYWLXDM, ADJBH, AWYZFID, AWYZFXGNR: string;
    ACzy: Integer;
    ClientDataSetWYZF: TClientDataSet;

    procedure SetDJNavStatus;
    procedure SetDJEditStatus(bCanEdit: Boolean);
    procedure SetDJCheckStatus;
    procedure SetDJStatus;
    procedure NavWYZFDJ(Sender: TObject);
    procedure SetFKF;
    function GetSQL: string;
    procedure Print;
    function CheckUKey: Boolean;
  Public
    { Public declarations }
    WYZFOper: TWYZFOper;
    AWYZFXXRec: TWYZFRec;
    CurWYZFAction: TWYZF_Bill_Action;
    procedure InitForm;
    procedure ClearWYZFXX;
    procedure ClearWYZFXXRec;
    procedure LoadWYZFXX(AZFID, ACurrYWLXDM: string; CdsWYZFData: TClientDataSet = nil); Overload;
    procedure LoadWYZFXX(AZFRec: TWYZFRec); Overload;
    procedure LoadWYZFRec(AZFID: string; CdsData: TClientDataSet = nil);
    procedure LoadWYZFSHLXX(AZFID: string; ASHJD: Integer);
    procedure UpdateWYZFXX(AZFID: string; CdsData: TClientDataSet);
    function SaveWYZFData: Boolean;
    function DoWYZFSH(AZFID: string; ASHZT: Integer; ASHLX: Integer; ASHID: Integer = -1; ASHR: string = ''; ASHSJ:
      string = ''): Boolean;
    function DoWYZFZX(AZFID: string; AZXZT: Integer; AGROUPID: string; AZXID: Integer = -1; AZXR: string = ''; AZXSJ:
      string = ''; AIsCXZX: Boolean = false): Boolean;
    function DoWYZFZFHY(AZFID: string; AZFHY: Integer): Boolean;
    function DoWYZFDel(AZFID: string): Boolean;
    // 审核流程的操作
    procedure DoWYZFAction(AWYZFRec: TWYZFRec; AZT: TWYZF_Bill_ACTION; ACLYJ: string = '');
    function DJCheck: Boolean;
    procedure getOthersFromSYHHH(SYHHH: string);
    procedure initProvince;
    procedure initCity;
    procedure initDepID;
    procedure initValue;
    procedure SaveNewYHHH(SYhhhAndName: string);
    function CheckZH(YHZF: string): Boolean;
    function GetPZH(AIDPZH: string): string;
  end;

var
  FormWYZF: TFormWYZF;
  bZFOK: Boolean;
  szSkr, szToYhzh, szZfid, szZfzt: string;

procedure LoadWYZF(AGSDM, AYWND, AYWQJ: string; ACZY: Integer; AYWLXDM: string; AZFID: string; ACdsData: TClientDataSet
  = nil; bQYSHL: Boolean = False);
implementation

uses pub_message, Pub_Global, pub_function, Pub_Power, ListSelectDM,
  DataModuleMain, PubBankFunc, WYZF_DJSH, DateUtils, uSelectFromData,
  WYZFNotePad; // uSelectGBS,

{$R *.DFM}

procedure LoadWYZF(AGSDM, AYWND, AYWQJ: string; ACZY: Integer; AYWLXDM: string; AZFID: string; ACdsData: TClientDataSet
  = nil; bQYSHL: Boolean = False);
var
  AZFRec: TWYZFRec;
begin
  if not TPower.GetPower(GN_WYZF_Read) then
  begin
    SysMessage('没有查阅权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  if not Assigned(FormWYZF) then
    Application.CreateForm(TFormWYZF, FormWYZF);
  if GszKJQJ = '' then
    GszKJQJ := Copy(GszYWRQ, 5, 2); // Added by guozy 2013/3/30 星期六 19:26:00
  if AYWQJ = '' then
    AYWQJ := GszKJQJ;
  FormWYZF.AGSDM := AGSDM;
  FormWYZF.AYWND := AYWND;
  FormWYZF.AYWQJ := AYWQJ;
  FormWYZF.AYWLXDM := AYWLXDM;
  FormWYZF.AWYZFID := AZFID;
  FormWYZF.ACzy := ACZY;
  with FormWYZF do
  begin
    InitForm;
    ComboBoxYWLX.ItemIndex := getJSFSMCIndex(AYWLXDM);
    if ACdsData <> nil then
      ClientDataSetWYZF := ACdsData;
    ClearWYZFXX;
    ClearWYZFXXRec;
    if (1 = 1) then
    begin
      if AZFID = '' then
      begin
        WYZFOper := OpAdd;
        InitModeCodeAndName(ComboBoxSJLY);
        ComboBoxSJLY.ItemIndex := getSJLYIndex('EBK');
        LabelLRR.Caption := IntToStr(ACZY) + ' ' + GCzy.name;
        SetDJEditStatus(True);
        SetDJCheckStatus;
        initProvince;
        initDepID;
        initValue;
        ISGROUP := False;
        pc.ActivePageIndex := 1;
        tsAll.TabVisible := False;
        tsZFXX.TabVisible := True;
      end
      else if AZFID <> '' then
      begin
        WYZFOper := OpBrowse;
        LoadWYZFXX(AZFID, AYWLXDM, ClientDataSetWYZF);
        SetDJStatus;
      end;
    end
    else if AYWLXDM = '' then
    begin
      if AZFID = '' then
      begin
        WYZFOper := OpAdd;
        LabelLRR.Caption := IntToStr(GCzy.ID) + ' ' + GCzy.name;
        LoadWYZFXX(AZFRec);
        SetDJStatus;
      end
      else if AZFID <> '' then
      begin
        WYZFOper := OpBrowse;
        LoadWYZFXX(AZFID, AYWLXDM, ClientDataSetWYZF);
        SetDJStatus;
      end;
    end;
    ShowModal;
  end;
end;

procedure TFormWYZF.FormCreate(Sender: TObject);
begin
  InitJSFS;
  ComboBoxYWLX.Items.CommaText := GszJSFSMC;
  InitModeCodeAndName(ComboBoxSJLY);
  //FormHeight := Self.Height;
  //DJXXHeight := Self.PanelDJXX.Height;
  grd.FixedColor := Self.Color;
  edtZFID.Text := '';
  edtFKR.Text := '';
  edtYHZH.Text := '';
  edtZHMC.Text := '';
  edtKHYH.Text := '';
  edtYHHH.Text := '';
  edtYHHB.Text := '';
  edtYHHB.ItemIndex := -1;
  edtKHDQ.Text := '';
  edtYHWD.Text := '';
  edtJE.Text := '';
  edtSKR.Text := '';
  edtYHZH2.Text := '';
  edtZHMC2.Text := '';
  edtKHYH2.Text := '';
  //edtYHHH2.Text := '';

  edtYHHB2.Text := '';
  CB_PROVINCE.ItemIndex := -1;
  CB_CITY.ItemIndex := -1;
  CB_DEPID.ItemIndex := -1;

  edtKHDQ2.Text := '';
  edtYHWD2.Text := '';
  edtZY.Text := '';
  LabelYDJBH.Caption := '原单据编号：'; // Added by guozy 2013/3/31 星期日 16:37:22
  LabelBANKUQNO.Caption := '银行唯一号：'; // Added by guozy 2013/4/18 星期四 8:45:40
  LabelBUSIUQNO.Caption := '原支付交易流水号：'; // Added by guozy 2013/4/18 星期四 8:45:40
  LabelHEADBUSIUQNO.Caption := '主交易流水号：'; // Added by guozy 2013/4/18 星期四 8:45:40
end;

procedure TFormWYZF.edtYHZH2ButtonClick(Sender: TObject);
var
  VarTemp: Variant;
  szSQL: string;
  szZHDM, szZHMC, szYHZH, szTemp: string;
  iPos: Integer;
  szTJ: string;
begin
  //  if edtYHZH2.Text <> '' then
  //    szTemp := Trim(edtYHZH2.Text);
  //  if szTemp <> '' then
  //    szTJ := '(yhzh like ''' + szTemp + '%'' or yhzhmc like ''%' + szTemp + '%'')';
  szTJ := ' (pubszdwzh.wyzf=''1'') ';
  VarTemp := ListViewSelectDMC('slYHZH', szTJ, False);
  if VarType(VarTemp) = varinteger then
  begin
    if (VarTemp = 0) or (VarTemp = -1) then
      exit;
  end
  else
  begin
    szYHZH := VarTemp[0, 0];
    szZHMC := VarTemp[0, 1];
    edtYHZH2.Text := szYHZH;
    edtZHMC2.Text := szZHMC;
    if szYHZH <> '' then
    begin
      szSQL := 'select * from pubszdwzh '
        + ' where gsdm=''' + GszGSDM + ''''
        + ' and kjnd = ''' + GszKJND + ''''
        //+ ' and yhbh = ''' + szZHDM + ''''
      + ' and yhzh = ''' + szYHZH + '''';

      with DataModulePub.ClientDataSetTmp do
      begin
        Close;
        POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
        if FindFirst then
        begin
          edtZHMC2.Text := FieldByName('yhzhmc').AsString;
          edtKHYH2.Text := FieldByName('yhname').AsString;
          //edtYHHB2.Text := FieldByName('SYHHH').AsString+' '+FieldByName('SYHMC').AsString;
          edtKHDQ2.Text := FieldByName('yhaddr').AsString;
          edtYHWD2.Text := FieldByName('yhaddr').AsString;
        end;
        Close;
      end;
    end;
  end;
end;

procedure TFormWYZF.edtYHZHButtonClick(Sender: TObject);
var
  VarTemp: Variant;
  szSQL: string;
  szZHDM, szZHMC, szYHZH, szTemp: string;
  iPos: Integer;
  szTJ: string;
begin
  //  if edtYHZH.Text <> '' then
  //    szTemp := Trim(edtYHZH.Text);
  //  if szTemp <> '' then
  //    szTJ := '(yhzh like ''' + szTemp + '%'' or yhzhmc like ''%' + szTemp + '%'')';
  //  szTJ :=  ' (pubszdwzh.wyzf=''1'') ';
  VarTemp := ListViewSelectDMC('slYHZH', szTJ, False);
  if VarType(VarTemp) = varinteger then
  begin
    if (VarTemp = 0) or (VarTemp = -1) then
      exit;
  end
  else
  begin
    szYHZH := VarTemp[0, 0];
    szZHMC := VarTemp[0, 1];
    edtYHZH.Text := szYHZH;
    edtZHMC.Text := szZHMC;
    if szYHZH <> '' then
    begin
      szSQL := 'select * from pubszdwzh '
        + ' where gsdm=''' + GszGSDM + ''''
        + ' and kjnd = ''' + GszKJND + ''''
        //+ ' and yhbh = ''' + szZHDM + ''''
      + ' and yhzh = ''' + szYHZH + '''';
      with DataModulePub.ClientDataSetTmp do
      begin
        Close;
        POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
        if FindFirst then
        begin
          edtZHMC.Text := FieldByName('yhzhmc').AsString;
          edtKHYH.Text := FieldByName('yhname').AsString;
          edtYHHH.Text := FieldByName('yhhh').AsString;
          //edtYHHB.Text := GetYHHB(FieldByName('yhname').AsString);
          edtYHHB.ItemIndex := edtYHHB.Items.IndexOf(GetYHHB(FieldByName('yhname').AsString));
          edtKHDQ.Text := FieldByName('yhaddr').AsString;
          edtYHWD.Text := FieldByName('yhaddr').AsString;
        end;
        Close;
      end;
      {szSQL := 'select zhdm,zhmc from zj_zhdy where gsdm=''' + GszGSDM + ''''
        + ' and yhzh = ''' + szYHZH + '''';
      with DataModulePub.ClientDataSetTmp do
      begin
        Close;
        POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
        if FindFirst then
        begin
          edtFKR.Text := FieldByName('zhdm').AsString;
          edtFKRMC.Text := FieldByName('zhmc').AsString;
        end;
        Close;
      end; }
    end;
  end;
end;

procedure TFormWYZF.SpeedItem_ExitClick(Sender: TObject);
begin
  Close;
end;

function copyCds(FrmDst, ToDst: TClientDataSet): Boolean;
var
  iCount: integer;
begin
  for iCount := 0 to ToDst.Fields.Count - 1 do
  begin
    if FrmDst.FindField(ToDst.Fields[iCount].FieldName) <> nil then
    begin
      ToDst.FieldByName(ToDst.Fields[iCount].FieldName).Value :=
        FrmDst.FindField(ToDst.Fields[iCount].FieldName).Value;
    end;
  end;
end;

function TFormWYZF.SaveWYZFData: Boolean;
var
  szSQL: string;
  szZfId, szYwrq, szYwyh, szYwlxMC, szYwlxdm, szFkr, szSkr, szZY, szUrl, szFKKhYh, szFKYhhh, szFKYhzh, szFKZhmc,
    szSKKhYh, szSKYhhh, szSKYhmc, szSKYhzh, szSKZhmc, szFKKhdq, szSKKhdq, szFKYhwd, szSKYhwd, szFkzh, szSkzh, szFkmc,
    szSkmc, szFKYhhb, szSKYhhb: string;
  szSKDepid: string;
  fJe: Extended;
  szTC: string;
  szLRID, szLRR, szLRSJ: string;
  szYDJBH, szYDJSJ: string;
  sBANKUQNO, sBUSIUQNO, sHEADBUSIUQNO: string;
  IsNew: Boolean;
  szModCode, szModName: string;
  function GetXGNR(ANR, AOldNR, ANewNR: string): string;
  begin
    Result := '';
    if AOldNR <> ANewNR then
      Result := ANR + AOldNR + '->' + ANewNR + ';';
  end;
begin
  Result := False;
  if AWYZFXXRec.GROUPID <> '' then
  begin
    //设置保存数据， 如果有GroupID， 则需要根据这个进行修改保存
    cdsGroup.DisableControls;
    if cdsGroup.State in [dsEdit] then
      cdsGroup.Post;
    POpenSQL(cdsZFD, 'Select * from EBK_ZFXX where GROUPID=' + QuotedStr(AWYZFXXRec.GROUPID));
    cdsGroup.First;
    while not cdsGroup.Eof do
    begin
      if cdsZFD.Locate('ZFID', cdsGroup.FieldByName('ZFID').AsString, []) then
        cdsZFD.Edit;
      copyCds(cdsGroup, cdsZFD);

      cdsZFD.FieldByName('YWLXDM').AsString := getJSFSDM(ComboBoxYWLX.ItemIndex);
      cdsZFD.FieldByName('YWLX').AsString := ComboBoxYWLX.Text;
      if cdsZFD.FieldByName('YWLXDM').AsString = '02' then
      begin
        cdsZFD.FieldByName('USEOF_CODE').AsString := '00000009';
        cdsZFD.FieldByName('USEOF_DESC').AsString := '奖金';
      end;
      cdsZFD.Post;
      cdsGroup.Next;
    end;
    cdsZFD.ApplyUpdates(-1, 'EBK_ZFXX');
    cdsGroup.EnableControls;
    AWYZFID := cdsGroup.FieldByName('ZFID').AsString;
    SysMessage('保存成功。', '_YB', [mbOK]);
    Result := True;
    Exit;
  end;
  //if (Trim(LabelYWLX.Caption)<>'现金支票') and (Trim(CB_DEPID.Text)='') then begin
  if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) <> '1') and (Trim(CB_DEPID.Text) = '') then
  begin
    if CB_DEPID.Enabled then
      CB_DEPID.SetFocus;
    SysMessage('收款银行不能为空！', AOther_JG, [mbOk]);
    Exit;
  end;

  //if (Trim(LabelYWLX.Caption)<>'现金支票') and (Trim(edtYHHB2.Text)='') then begin
  if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) <> '1') and (Trim(edtYHHB2.Text) = '') then
  begin
    if CB_PROVINCE.Enabled then
      CB_PROVINCE.SetFocus;
    SysMessage('收款银行行号不能为空！', AOther_JG, [mbOk]);
    Exit;
  end;
  szZfId := Trim(edtZFID.Text);
  szYwrq := FormatDateTime('YYYYMMDD', DateYWRQ.Date);
  szYwyh := Trim(ComboBoxYWYH.Text);
  szYwlxdm := getJSFSDM(ComboBoxYWLX.ItemIndex);
  szYwlxMC := ComboBoxYWLX.Text;
  //szUrl := FormWYZF.sUrl;
  szFkr := Trim(edtFKR.Text) + ' ' + Trim(edtFKRMC.Text);
  szFkzh := Trim(edtFKR.Text);
  szFkmc := Trim(edtFKRMC.Text);

  szFKKhyh := Trim(edtKHYH.Text);
  szFKYhhh := Trim(edtYHHH.Text);
  szFKYhzh := Trim(edtYHZH.Text);
  //if pos('-',szFKYhzh) > 0 then
  //szFKYhzh := Copy(szFKYhzh,pos('-',szFKYhzh),length(szFKYhzh));
  szFKZhmc := Trim(edtZHMC.Text);
  szFKKhdq := Trim(edtKHDQ.Text);

  szFKYhwd := Trim(edtYHWD.Text);
  //if szFKYhwd = '' then         // Modified by guozy 2013/3/30 星期六 19:22:06
    //szFKYhwd := '湖南省分行';
  fJe := 0;
  if Trim(edtJE.Text) <> '' then
  try
    fJe := StrToFloat(Trim(edtJE.Text));
  except
    SysMessage('付款金额输入错误。', AOther_JG, [mbOk]);
    Exit;
  end;

  szSkr := Trim(edtSKR.Text) + ' ' + Trim(edtSKRMC.Text);
  szSkzh := Trim(edtSKR.Text);
  szSkmc := Trim(edtSKRMC.Text);

  szSKKhyh := Trim(edtKHYH2.Text);
  szSKDepid := TString.LeftStrBySp(CB_DEPID.Text);
  szSKYhhh := TString.LeftStrBySp(edtYHHB2.Text); //  edtYHHH2.Text);
  szSKYhmc := TString.RightStrBySp(edtYHHB2.Text);

  szSKYhzh := Trim(edtYHZH2.Text);
  szSKZhmc := Trim(edtZHMC2.Text);
  szSKKhdq := Trim(edtKHDQ2.Text);
  szSKYhwd := Trim(edtYHWD2.Text);
  szZY := Trim(edtZY.Text);
  if TString.LeftStrBySp(CB_CITY.Text) = '1930' then
  begin
    szTC := '同城';
  end
  else
  begin
    szTC := '异地';
  end;

  szLRR := LabelLRR.Caption;
  szLRID := Copy(szLRR, 1, Pos(' ', szLRR) - 1);
  szLRR := Copy(szLRR, Pos(' ', szLRR) + 1, Length(szLRR) - Pos(' ', szLRR));
  if szLRID = '' then
    szLRID := IntToStr(GCzy.ID);
  szLRSJ := FormatDateTime('YYYY-MM-DD HH:NN:SS', Now);
  szYDJBH := Trim(edtYDJBH.Text);
  szYDJSJ := Trim(edtYDJSJ.Text);
  szModCode := getModCode(ComboBoxSJLY.ItemIndex);
  szModName := getModName(ComboBoxSJLY.ItemIndex);
  {if szYwyh = '' then
   begin
     SysMessage('请输入业务银行。', AOther_JG, [mbOk]);
     Exit;
   end;     }
 //  if szFkzh = '' then
 //  begin
 //    SysMessage('请输入付款方。', AOther_JG, [mbOk]);
 //    Exit;
 //  end;
  if szFKYhzh = '' then
  begin
    SysMessage('请输入付款方银行账号。', AOther_JG, [mbOk]);
    Exit;
  end;
  if szFKZhmc = '' then
  begin
    SysMessage('请输入付款方账户名称。', AOther_JG, [mbOk]);
    Exit;
  end;
  if szFKKhyh = '' then
  begin
    SysMessage('请输入付款方开户银行。', AOther_JG, [mbOk]);
    Exit;
  end;
  //  if szFKYhhh = '' then
  //  begin
  //    SysMessage('请输入付款方银行行号。', AOther_JG, [mbOk]);
  //    Exit;
  //  end;
    {if szFKYhhb = '' then
    begin
      SysMessage('请输入付款方银行行别。', AOther_JG, [mbOk]);
      Exit;
    end;  }
  //  if szFKKhdq = '' then
  //  begin
  //    SysMessage('请输入付款方开户地区。', AOther_JG, [mbOk]);
  //    Exit;
  //  end;

  //  if szSkzh = '' then
  //  begin
  //    SysMessage('请输入收款方。', AOther_JG, [mbOk]);
  //    Exit;
  //  end;
  if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) <> '1') then
  begin
    if szSKYhzh = '' then
    begin
      SysMessage('请输入收款方银行账号。', AOther_JG, [mbOk]);
      Exit;
    end;
    if szSKZhmc = '' then
    begin
      SysMessage('请输入收款方账户名称。', AOther_JG, [mbOk]);
      Exit;
    end;
    if szSKKhyh = '' then
    begin
      SysMessage('请输入收款方开户银行。', AOther_JG, [mbOk]);
      Exit;
    end;
  end;
  //  if szSKYhhh = '' then
  //  begin
  //    SysMessage('请输入收款方银行行号。', AOther_JG, [mbOk]);
  //    Exit;
  //  end;
  //  if szSKYhhb = '' then
  //  begin
  //    SysMessage('请输入收款方银行行别。', AOther_JG, [mbOk]);
  //    Exit;
  //  end;
  //  if szSKKhdq = '' then
  //  begin
  //    SysMessage('请输入收款方开户地区。', AOther_JG, [mbOk]);
  //    Exit;
  //  end;
  if fJe <= 0 then
  begin
    SysMessage('请输入付款金额。', AOther_JG, [mbOk]);
    Exit;
  end;
  if WYZFOper = OpEdit then
  begin
    AWYZFXGNR := '';
    AWYZFXGNR := AWYZFXGNR + GetXGNR('业务日期：', AWYZFXXRec.YWRQ, szYwrq);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('业务银行：', AWYZFXXRec.YWYH, szYwyh);

    AWYZFXGNR := AWYZFXGNR + GetXGNR('付方账户：', AWYZFXXRec.FKFZH, szFkzh);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('付方名称：', AWYZFXXRec.FKFMC, szFkmc);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('付方银行账号：', AWYZFXXRec.FYHZH, szFKYhzh);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('付方账户名称：', AWYZFXXRec.FZHMC, szFKZhmc);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('付方开户银行：', AWYZFXXRec.FKHYH, szFKKhYh);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('付方银行行号：', AWYZFXXRec.FYHHH, szFKYhhh);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('付方银行行别：', AWYZFXXRec.FYHHB, szFKYhhb);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('付方开户地区：', AWYZFXXRec.FKHDQ, szFKKhdq);

    AWYZFXGNR := AWYZFXGNR + GetXGNR('收方账户：', AWYZFXXRec.SKFZH, szSkzh);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('收方名称：', AWYZFXXRec.SKFMC, szSkmc);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('收方银行账号：', AWYZFXXRec.SYHZH, szSKYhzh);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('收方账户名称：', AWYZFXXRec.SZHMC, szSKZhmc);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('收方开户银行：', AWYZFXXRec.SKHYH, szSKKhYh);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('收方银行行号：', AWYZFXXRec.SYHHH, szSKYhhh);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('收方银行行别：', AWYZFXXRec.SYHMC, szSKYhmc);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('收方开户地区：', AWYZFXXRec.SKHDQ, szSKKhdq);

    AWYZFXGNR := AWYZFXGNR + GetXGNR('摘要：', AWYZFXXRec.ZY, szZY);
    AWYZFXGNR := AWYZFXGNR + GetXGNR('付款金额：', FormatFloat('0.00', AWYZFXXRec.JE), FormatFloat('0.00', fJe));
    AWYZFXGNR := AWYZFXGNR + GetXGNR('同城标志：', AWYZFXXRec.TCBZ, szTC);

  end;
  try
    if szZfId = '' then
    begin
      IsNew := True;
      szZfId := getNewLSH(AGSDM, AYWND, szYwlxdm);
    end
    else
    begin
      IsNew := False;
      szZfId := AWYZFID;
    end;

    if szZfId = '' then
    begin
      SysMessage('保存失败。', AOther_JG, [mbOK]);
      Exit;
    end;
  except
    SysMessage('保存失败。', AOther_JG, [mbOK]);
    Exit;
  end;
  try
    szSQL := '';
    if not IsNew then
      szSQL := 'DELETE FROM EBK_ZFXX '
        + ' WHERE GSDM = ''' + AGSDM + ''''
        + ' AND KJND = ''' + AYWND + ''''
        + ' AND YWLXDM = ''' + AYWLXDM + ''''
        + ' AND ZFID = ''' + szZfId + ''' ';
    if GDbType = ORACLE then
      szSQL := szSQL + IFF(szSQL <> '', ';', '');
    szSQL := szSQL +
      'INSERT INTO EBK_ZFXX(GSDM, KJND, YWQJ, YWRQ, YWLX, ZFID, YWYH, FKFZH, FKFMC, FYHZH, FZHMC, FKHYH, FYHHH, FYHHB, FYHWD, FKHDQ, SKFZH, SKFMC, SYHZH, SZHMC, SKHYH, SYHHH, SYHMC, SYHWD, SKHDQ,'
      + ' TCBZ, ZY, JE, YWSJ, LRID, LRR, LRSJ, DJZT, YDJBH, YDJSJ, CLSJ, CLZT, SDEPID, YWLXDM, Modcode, modname, KSZF) '
      + ' VALUES ('
      + '''' + AGSDM + ''',''' + AYWND + ''',''' + AYWQJ + ''',''' + szYwrq + ''',''' + szYwlxMC + ''',''' + szZfId +
      ''',''' + szYwyh + ''','''
      + szFkzh + ''',''' + szFkmc + ''',''' + szFKYhzh + ''',''' + szFKZhmc + ''',''' + szFKKhYh + ''',''' + szFKYhhh +
      ''',''' + szFKYhhb + ''',''' + szFKYhwd + ''',''' + szFKKhdq + ''','''
      + szSkzh + ''',''' + szSkmc + ''',''' + szSkYhzh + ''',''' + szSkZhmc + ''',''' + szSkKhYh + ''',''' + szSkYhhh +
      ''',''' + szSKYhmc + ''',''' + szSkYhwd + ''',''' + szSkKhdq + ''','''
      + szTC + ''',''' + szZY + ''',''' + FormatFloat('0.00', fJe) + ''',''' + szYwrq + ''','''
      + szLRID + ''',''' + szLRR + ''',''' + szLRSJ + ''',''' + '0' + ''','''
      + szYDJBH + ''',''' + szYDJSJ + ''','''
      + ''',''' + '0' + ''',''' + szSKDepid + ''',''' + AYWLXDM + ''','
      + '''' + szModCode + ''','
      + '''' + szModname + ''','
      + '''0'''
      + ')';
    if GDbType = ORACLE then
      szSQL := szSQL + IFF(szSQL <> '', ';', '');
    PExecSQL(szSQL);
    Result := True;
    if (ClientDataSetWYZF <> nil) and ClientDataSetWYZF.Active then
    begin
      with ClientDataSetWYZF do
      begin
        if IsNew then
          Append
        else
          Edit;
        FieldByName('GSDM').AsString := AGSDM;
        FieldByName('KJND').AsString := AYWND;
        FieldByName('YWRQ').AsString := szYwrq;
        FieldByName('YWLX').AsString := szYwlxMC;
        FieldByName('ZFID').AsString := szZfId;
        FieldByName('YWYH').AsString := szYwyh;
        FieldByName('FKFZH').AsString := szFkzh;
        FieldByName('FKFMC').AsString := szFkmc;
        FieldByName('FYHZH').AsString := szFKYhzh;
        FieldByName('FZHMC').AsString := szFKZhmc;
        FieldByName('FKHYH').AsString := szFKKhYh;
        FieldByName('FYHHH').AsString := szFKYhhh;
        FieldByName('FYHHB').AsString := szFKYhhb;
        FieldByName('FKHDQ').AsString := szFKKhdq;
        FieldByName('FYHWD').AsString := szFKYhwd;
        FieldByName('JE').AsFloat := fJe;
        FieldByName('SKFZH').AsString := szSkzh;
        FieldByName('SKFMC').AsString := szSkmc;
        FieldByName('SYHZH').AsString := szSKYhzh;
        FieldByName('SZHMC').AsString := szSKZhmc;
        FieldByName('SKHYH').AsString := szSKKhYh;
        FieldByName('SYHHH').AsString := szSKYhhh;
        FieldByName('SYHHB').AsString := szSKYhhb;
        FieldByName('SYHMC').AsString := szSKYhmc;
        FieldByName('SKHDQ').AsString := szSKKhdq;
        FieldByName('SYHWD').AsString := szSKYhwd;
        FieldByName('ZY').AsString := szZY;
        FieldByName('TCBZ').AsString := szTC;
        FieldByName('LRID').AsString := szLRID;
        FieldByName('LRR').AsString := szLRR;
        FieldByName('LRSJ').AsString := szLRSJ;
        FieldByName('DJZT').AsInteger := 0;
        FieldByName('SHID1').AsInteger := -1;
        FieldByName('SHID2').AsInteger := -1;

        FieldByName('YDJBH').AsString := szYDJBH;
        FieldByName('YDJSJ').AsString := szYDJSJ;
        FieldByName('SDEPID').AsString := szSKDepid;
        Post;
      end;
    end;
    edtZFID.Text := szZfId;
    LabelYDJBH.Caption := '原单据编号：' + szYDJBH; // Added by guozy 2013/3/31 星期日 16:38:07
    if ClientDataSetWYZF <> nil then
    begin
      if ClientDataSetWYZF.FieldByName('MODCODE').AsString = 'GL' then
      begin
        LabelYDJBH.Caption := '原单据编号：' + GetPZH(szYDJBH);
      end;
    end;
    LabelBANKUQNO.Caption := '银行唯一号：' + sBANKUQNO; // Added by guozy 2013/4/18 星期四 8:45:40
    LabelBUSIUQNO.Caption := '原支付交易流水号：' + sBUSIUQNO; // Added by guozy 2013/4/18 星期四 8:45:40
    LabelHEADBUSIUQNO.Caption := '主交易流水号：' + sHEADBUSIUQNO; // Added by guozy 2013/4/18 星期四 8:45:40
    AWYZFID := szZfId;
    SaveNewYHHH(Trim(edtYHHB2.Text));
    SysMessage('保存成功。', '_YB', [mbOK]);
  except
    Result := False;
    SysMessage('保存失败。', AOther_JG, [mbOK]);
  end;
end;

procedure TFormWYZF.SpeedItem_SaveClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_Edit) then
  begin
    SysMessage('没有编辑权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  if SaveWYZFData then
  begin
    AWYZFID := edtZFID.Text;
    if WYZFOper = OpAdd then
    begin
      PWriteYHCzrz('新增：' + AYWLXDM + '-' + AWYZFID);
      SpeedItem_insertClick(nil);
    end
    else
    begin
      PWriteYHCzrz('修改：' + AYWLXDM + '-' + AWYZFID + ' ' + AWYZFXGNR);
      if ISGROUP then
        LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), nil)
      else
        LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF);
      SetDJStatus;
      WYZFOper := OpBrowse;
    end;
  end;
end;

procedure TFormWYZF.ClearWYZFXX;
begin
  //DateYWRQ.Date := Now;
  PSetPickerDate(DateYWRQ, GszYWRQ);
  ComboBoxYWYH.Text := '';
  ComboBoxYWYH.ItemIndex := -1;
  edtZFID.Text := '';
  LabelYDJBH.Caption := '原单据编号：'; // Added by guozy 2013/3/31 星期日 16:38:48
  LabelBANKUQNO.Caption := '银行唯一号：'; // Added by guozy 2013/4/18 星期四 8:45:40
  LabelBUSIUQNO.Caption := '原支付交易流水号：'; // Added by guozy 2013/4/18 星期四 8:45:40
  LabelHEADBUSIUQNO.Caption := '主交易流水号：'; // Added by guozy 2013/4/18 星期四 8:45:40

  edtFKR.Text := '';
  edtFKRMC.Text := '';
  edtCLXX.text := '';
  edtZFXX.Text := '';
  edtYHZH.Text := '';
  edtZHMC.Text := '';
  edtKHYH.Text := '';
  edtYHHH.Text := '';
  edtYHHB.Text := '';
  edtKHDQ.Text := '';
  edtYHWD.Text := '';
  edtJE.Text := '';
  edtSKR.Text := '';
  edtSKRMC.Text := '';
  edtYHZH2.Text := '';
  edtZHMC2.Text := '';
  edtKHYH2.Text := '';
  //edtYHHH2.Text := '';
  edtYHHB2.Text := '';
  CB_PROVINCE.ItemIndex := -1;
  CB_CITY.ItemIndex := -1;
  CB_DEPID.ItemIndex := -1;

  edtKHDQ2.Text := '';
  edtYHWD2.Text := '';
  edtZY.Text := '';

  LabelLRR.Caption := '';
  LabelSHR1.Caption := '';
  LabelSHR2.Caption := '';
  LabelZXR.Caption := '';
  THBDJZT.Caption := '';
  THBDJZT.Visible := THBDJZT.Caption <> '';
  LabelZFSJ.Caption := ''; // Added by guozy 2013/4/19 星期五 14:30:30
  LabelZFSJ.Visible := THBDJZT.Visible; // Added by guozy 2013/4/19 星期五 14:30:36

  edtYDJBH.Text := '';
  edtYDJSJ.Text := '';
  LabelSHR.Caption := '审核：';
  //ClearWYZFXXRec;
end;

procedure TFormWYZF.SpeedItem_insertClick(Sender: TObject);
var
  FKR: string;
begin
  if not TPower.GetPower(GN_WYZF_Edit) then
  begin
    SysMessage('没有编辑权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  WYZFOper := OpAdd;
  AWYZFID := '';
  ClearWYZFXX;
  PSetPickerDate(DateYWRQ, GszYWRQ);
  LabelLRR.Caption := IntToStr(GCzy.ID) + ' ' + GCzy.name;
  AWYZFXXRec.YWND := AYWND;
  AWYZFXXRec.YWLXDM := AYWLXDM;
  AWYZFXXRec.YWLXMC := ComboBoxYWLX.Text;
  ComboBoxSJLY.ItemIndex := getSJLYIndex('EBK');
  SetDJEditStatus(True);
  initProvince;
  initDepID;
end;

procedure TFormWYZF.SpeedItem_copyClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_Edit) then
  begin
    SysMessage('没有编辑权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  WYZFOper := OpAdd;
  AWYZFID := '';
  edtZFID.Text := '';
  LabelYDJBH.Caption := '原单据编号：'; // Added by guozy 2013/3/31 星期日 16:39:05
  LabelBANKUQNO.Caption := '银行唯一号：'; // Added by guozy 2013/4/18 星期四 8:45:40
  LabelBUSIUQNO.Caption := '原支付交易流水号：'; // Added by guozy 2013/4/18 星期四 8:45:40
  LabelHEADBUSIUQNO.Caption := '主交易流水号：'; // Added by guozy 2013/4/18 星期四 8:45:40
  edtJE.Text := '';
  PSetPickerDate(DateYWRQ, GszYWRQ);
  LabelLRR.Caption := IntToStr(GCzy.ID) + ' ' + GCzy.name;
  LabelSHR1.Caption := '';
  LabelSHR2.Caption := '';
  LabelZXR.Caption := '';
  ClearWYZFXXRec;
  AWYZFXXRec.YWND := AYWND;
  AWYZFXXRec.YWLXDM := AYWLXDM;
  AWYZFXXRec.YWLXMC := ComboBoxYWLX.Text;
  SetDJEditStatus(True);
end;

procedure TFormWYZF.LoadWYZFXX(AZFID, ACurrYWLXDM: string; CdsWYZFData: TClientDataSet = nil);
var
  CdsTemp: TClientDataSet;
  szSQL, sIDPZH: string;
begin
  ClearWYZFXX;
  if CdsWYZFData = nil then
  begin
    CdsTemp := DataModulePub.GetCds;
    //  szSQL := 'select * from EBK_ZFXX where gsdm = ''' + AGSDM + ''''
    //    + ' and ywlx = ''' + AYWLX + ''''
    //    + ' and zfid = ''' + AZFID + ''''
    szSQL := 'select zfxx.*, '
      + '(case when zfxx.curshjd=0 then ''录入'' when zfxx.curshjd=-9 then ''送审'' else wfnd1.nodename end) as curshjdmc, '
      + '(case when zfxx.nextshjd=-1 then ''结束'' when zfxx.nextshjd=-9 then ''送审'' else wfnd2.nodename end) as nextshjdmc'
      + ', (case'
      + ' when djzt=-1 then ''作废'' '
      + ' when djzt=0 then ''未送审'' '
      + ' when djzt>=1 and djzt<=2 and not (curshjd = 999 and nextshjd = -1) then ''审核中'' '
      + ' when djzt=2 and (curshjd = 999 and nextshjd = -1) then ''已审核'' '
      + ' when djzt=''3'' then ''已执行'' '
      + ' when djzt=''3'' and zfzt = ''成功'' then ''已支付'' '
      + ' end) as djStatus'
      + ' from EBK_ZFXX zfxx'
      + ' left join ('
      + 'select wf.gsdm, wf.kjnd, wf.flowcode, nd.nodeseq, nd.nodename from pubworkflow wf '
      + ' left join pubwfnode nd on wf.gsdm = nd.gsdm and wf.kjnd = nd.kjnd '
      + ' and nd.flowcode = wf.flowcode '
      + ') wfnd1 '
      + ' on  wfnd1.gsdm = zfxx.gsdm'
      + ' and wfnd1.kjnd = zfxx.KJND'
      + ' and wfnd1.flowcode = zfxx.flowcode '
      + ' and wfnd1.nodeseq = zfxx.curshjd '
      + ' left join ('
      + 'select wf.gsdm, wf.kjnd, wf.flowcode, nd.nodeseq, nd.nodename from pubworkflow wf '
      + ' left join pubwfnode nd on wf.gsdm = nd.gsdm and wf.kjnd = nd.kjnd '
      + ' and nd.flowcode = wf.flowcode '
      + ') wfnd2 '
      + ' on  wfnd2.gsdm = zfxx.gsdm'
      + ' and wfnd2.kjnd = zfxx.KJND'
      + ' and wfnd2.flowcode = zfxx.flowcode'
      + ' and wfnd2.nodeseq = zfxx.nextshjd';
    szSQL := 'select * from (' + szSQL + ') yhzfxx '
      + ' where gsdm = ''' + GszGSDM + ''''
      + ' and ywlxdm = ''' + ACurrYWLXDM + ''''
      + ' and zfid = ''' + AZFID + '''';
    POpenSql(CdsTemp, szSQL);
  end
  else
  begin
    CdsTemp := TClientDataSet.Create(nil);
    CdsTemp.Data := CdsWYZFData.Data;
  end;
  with CdsTemp do
  begin
    if Locate('ywlxdm;zfid', VarArrayOf([ACurrYWLXDM, AZFID]), []) then
    begin
      if FieldByName('YWRQ').AsString <> '' then
        PSetPickerDate(DateYWRQ, FieldByName('YWRQ').AsString);
      //ComboBoxYWYH.Text := FieldByName('YWYH').AsString;
      ComboBoxYWLX.ItemIndex := getJSFSMCIndex(ACurrYWLXDM);
      //if ACurrYWLX='现金支票' then PanelDJXX.Visible := False
      if currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '1' then
        PanelDJXX.Visible := False
      else
        PanelDJXX.Visible := True;

      ComboBoxYWYH.ItemIndex := ComboBoxYWYH.Items.IndexOf(FieldByName('YWYH').AsString);
      edtZFID.Text := FieldByName('ZFID').AsString;
      LabelYDJBH.Caption := '原单据编号：' + FieldByName('ydjbh').AsString; // Added by guozy 2013/3/31 星期日 16:40:20
      if FieldByName('MODCODE').AsString = 'GL' then
      begin
        LabelYDJBH.Caption := '原单据编号：' + GetPZH(FieldByName('ydjbh').AsString);
      end;
      LabelBANKUQNO.Caption := '银行唯一号：' + FieldByName('BANKUQNO').AsString;
      // Added by guozy 2013/4/18 星期四 8:45:40
      LabelBUSIUQNO.Caption := '原支付交易流水号：' + FieldByName('BUSIUQNO').AsString;
      // Added by guozy 2013/4/18 星期四 8:45:40
      LabelHEADBUSIUQNO.Caption := '主交易流水号：' + FieldByName('HEADBUSIUQNO').AsString;
      // Added by guozy 2013/4/18 星期四 8:45:40

      edtFKR.Text := FieldByName('FKFZH').AsString;
      edtFKRMC.Text := FieldByName('FKFMC').AsString;
      edtCLXX.Text := FieldByName('CLXX').AsString;
      edtZFXX.Text := FieldByName('ZFXX').AsString;
      edtYHZH.Text := FieldByName('FYHZH').AsString;
      edtZHMC.Text := FieldByName('FZHMC').AsString;
      edtKHYH.Text := FieldByName('FKHYH').AsString;
      edtYHHH.Text := FieldByName('FYHHH').AsString;
      //edtYHHB.Text := FieldByName('FYHHB').AsString;
      edtYHHB.ItemIndex := edtYHHB.Items.IndexOf(FieldByName('FYHHB').AsString);
      edtKHDQ.Text := FieldByName('FKHDQ').AsString;
      edtYHWD.Text := FieldByName('FYHWD').AsString;
      edtJE.Text := FieldByName('JE').AsString;
      edtSKR.Text := FieldByName('SKFZH').AsString;
      edtSKRMC.Text := FieldByName('SKFMC').AsString;
      edtYHZH2.Text := FieldByName('SYHZH').AsString;
      edtZHMC2.Text := FieldByName('SZHMC').AsString;
      edtKHYH2.Text := FieldByName('SKHYH').AsString;
      edtYHHB2.Text := FieldByName('SYHHH').AsString + ' ' + FieldByName('SYHMC').AsString;
      getOthersFromSYHHH(FieldByName('SYHHH').AsString);
      edtKHDQ2.Text := FieldByName('SKHDQ').AsString;
      edtYHWD2.Text := FieldByName('SYHWD').AsString;
      edtZY.Text := FieldByName('ZY').AsString;
      ComboBoxSJLY.ItemIndex := getSJLYIndex(FieldByName('ModCode').AsString);
      LabelLRR.Caption := FieldByName('LRID').AsString + ' ' + FieldByName('LRR').AsString;
      if bWYZFQYSHL then // 打开修改时的审批人（审批人字段放入初审）和执行人 modify by gengzhuo
      begin
        if FieldByName('DJZT').AsInteger >= 1 then
        begin
          if FieldByName('SHID').AsInteger > 0 then
            LabelSHR1.Caption := FieldByName('SHID').AsString + ' ' + FieldByName('SHR').AsString;
        end;
        if FieldByName('DJZT').AsInteger >= 2 then
        begin
          if FieldByName('SHID2').AsInteger > 0 then
            LabelSHR2.Caption := FieldByName('SHID2').AsString + ' ' + FieldByName('SHR2').AsString;
        end;
        if FieldByName('DJZT').AsInteger = 3 then
        begin
          if FieldByName('ZXID').AsInteger > 0 then
            LabelZXR.Caption := FieldByName('ZXID').AsString + ' ' + FieldByName('ZXR').AsString;
        end;
      end;
      edtYDJBH.Text := FieldByName('YDJBH').AsString;
      edtYDJSJ.Text := FieldByName('YDJSJ').AsString;
      //
      LoadWYZFRec(FieldByName('ZFID').AsString, nil);
      LoadWYZFSHLXX(AWYZFXXRec.ZFID, AWYZFXXRec.CurSHJD);
      //
      {AWYZFXXRec.ZFID := FieldByName('ZFID').AsString;
      AWYZFXXRec.YWND := FieldByName('YWND').AsString;
      AWYZFXXRec.YWRQ := FieldByName('YWRQ').AsString;
      AWYZFXXRec.YWLX := FieldByName('YWLX').AsString;
      AWYZFXXRec.YWYH := FieldByName('YWYH').AsString;
      //
      AWYZFXXRec.FKFZH := FieldByName('FKFZH').AsString;
      AWYZFXXRec.FKFMC := FieldByName('FKFMC').AsString;
      AWYZFXXRec.FYHZH := FieldByName('FYHZH').AsString;
      AWYZFXXRec.FZHMC := FieldByName('FZHMC').AsString;
      AWYZFXXRec.FKHYH := FieldByName('FKHYH').AsString;
      AWYZFXXRec.FYHHH := FieldByName('FYHHH').AsString;
      AWYZFXXRec.FYHHB := FieldByName('FYHHB').AsString;
      AWYZFXXRec.FKHDQ := FieldByName('FKHDQ').AsString;
      AWYZFXXRec.SKFZH := FieldByName('SKFZH').AsString;
      AWYZFXXRec.SKFMC := FieldByName('SKFMC').AsString;
      AWYZFXXRec.SYHZH := FieldByName('SYHZH').AsString;
      AWYZFXXRec.SZHMC := FieldByName('SZHMC').AsString;
      AWYZFXXRec.SKHYH := FieldByName('SKHYH').AsString;
      AWYZFXXRec.SYHHH := FieldByName('SYHHH').AsString;
      AWYZFXXRec.SYHHB := FieldByName('SYHHB').AsString;
      AWYZFXXRec.SKHDQ := FieldByName('SKHDQ').AsString;
      AWYZFXXRec.ZY := FieldByName('ZY').AsString;
      AWYZFXXRec.JE := FieldByName('JE').AsFloat;
      AWYZFXXRec.TCBZ := FieldByName('TCBZ').AsString;
      //
      AWYZFXXRec.LRID := FieldByName('LRID').AsInteger;
      AWYZFXXRec.LRSJ := FieldByName('LRSJ').AsString;
      AWYZFXXRec.SHID1 := FieldByName('SHID1').AsInteger;
      AWYZFXXRec.SHID2 := FieldByName('SHID2').AsInteger;
      AWYZFXXRec.DJZT := FieldByName('DJZT').AsInteger;
      AWYZFXXRec.CLZT := FieldByName('CLZT').AsString;
      AWYZFXXRec.SLZT := FieldByName('SLZT').AsString;
      AWYZFXXRec.ZFZT := FieldByName('ZFZT').AsString;
      AWYZFXXRec.YDJBH := FieldByName('YDJBH').AsString;
      AWYZFXXRec.YDJSJ := FieldByName('YDJSJ').AsString;
      if not bWYZFQYSHL then
      begin
        if AWYZFXXRec.DJZT = -1 then
          THBevelZT.Caption := '已作废'
        else if AWYZFXXRec.DJZT = 0 then
          THBevelZT.Caption := '未审核'
        else if AWYZFXXRec.DJZT = 1 then
        begin
          THBevelZT.Caption := '已初审';
        end
        else if AWYZFXXRec.DJZT = 2 then
        begin
          THBevelZT.Caption := '已复审';
        end
        else if AWYZFXXRec.DJZT = 3 then
        begin
          THBevelZT.Caption := '已执行';
          if AWYZFXXRec.SLZT <> '' then
            THBevelZT.Caption := AWYZFXXRec.SLZT;
          if AWYZFXXRec.ZFZT <> '' then
            THBevelZT.Caption := AWYZFXXRec.ZFZT;
        end;
        THBevelZT.Visible := THBevelZT.Caption <> '';
      end
      else
      begin
        AWYZFXXRec.SHFlow := FieldByName('FlowCode').AsString;
        AWYZFXXRec.CurSHJD := FieldByName('CurSHJD').AsInteger;
        AWYZFXXRec.NextSHJD := FieldByName('NextSHJD').AsInteger;
        AWYZFXXRec.CurSHJDMC := FieldByName('CurSHJD').AsString;
        AWYZFXXRec.NextSHJDMC := FieldByName('NextSHJD').AsString;
        if AWYZFXXRec.DJZT = -1 then
          AWYZFXXRec.DJStatus := djZF
        else if AWYZFXXRec.DJZT = 0 then
          AWYZFXXRec.DJStatus := djWSHH
        else if AWYZFXXRec.DJZT = 1 then
        begin
          AWYZFXXRec.DJStatus := djSSH
        end
        else if AWYZFXXRec.DJZT = 2 then
        begin
          AWYZFXXRec.DJStatus := djSHH
        end
        else if AWYZFXXRec.DJZT = 3 then
          AWYZFXXRec.DJStatus := djZX
        else
          AWYZFXXRec.DJStatus := djWSHH;
        if (AWYZFXXRec.DJStatus = djWSHH) and (AWYZFXXRec.SFTH = '1') then
          AWYZFXXRec.DJStatus := djTH;

        if AWYZFXXRec.DJStatus = djZF then
          THBevelZT.Caption := '已作废'
        else if AWYZFXXRec.DJStatus = djWSHH then
          THBevelZT.Caption := '未送审'
        else if AWYZFXXRec.DJStatus = djSSH then
          THBevelZT.Caption := '审核中'
        else if AWYZFXXRec.DJStatus = djSHH then
        begin
          if (AWYZFXXRec.CurSHJD = 999) and (AWYZFXXRec.NextSHJD = -1) then
            THBevelZT.Caption := '已审核'
          else
            THBevelZT.Caption := '审核中';
        end
        else if AWYZFXXRec.DJStatus = djZX then
          THBevelZT.Caption := '已执行';

        if AWYZFXXRec.SLZT <> '' then
          THBevelZT.Caption := AWYZFXXRec.SLZT;
        if AWYZFXXRec.ZFZT <> '' then
          THBevelZT.Caption := AWYZFXXRec.ZFZT;
        THBevelZT.Visible := THBevelZT.Caption <> '';
      end;}
    end;
  end;
  AWYZFID := AWYZFXXRec.ZFID;
  AYWYH := AWYZFXXRec.YWYH;
  THBDJZT.Visible := THBDJZT.Caption <> '';
  //hch 判断支付数据， 如果支付数据有GroupID的话， 则显示tsAll
  if AWYZFXXRec.GROUPID <> '' then
  begin
    ISGROUP := True;
    POpenSQL(cdsGroup,
      'Select * from EBK_ZFXX where GROUPID='
      + QuotedStr(AWYZFXXRec.GROUPID));
    pc.ActivePageIndex := 0;
    tsAll.TabVisible := True;
    tsZFXX.TabVisible := False;
  end
  else
  begin
    ISGROUP := False;
    pc.ActivePageIndex := 1;
    tsAll.TabVisible := False;
    tsZFXX.TabVisible := True;
  end;
  CdsTemp.Free;
  SetDJStatus;
end;

procedure TFormWYZF.SpeedItem_EditClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_Edit) then
  begin
    SysMessage('没有编辑权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  WYZFOper := OpEdit;
  SetDJEditStatus(True);
  //initDepID;
end;

procedure TFormWYZF.SpeedItem_CancelClick(Sender: TObject);
begin
  if AWYZFID <> '' then
    LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF)
  else
    ClearWYZFXX;
  SetDJStatus;
  WYZFOper := OpBrowse;
end;

procedure TFormWYZF.SetDJEditStatus(bCanEdit: Boolean);
begin
  PanelTitle.Enabled := False;
  PanelWYZF.Enabled := False;
  PanelDJXX.Enabled := False;
  ComboBoxYWLX.Enabled := false;
  //and (getModCode(ComboBoxSJLY.ItemIndex)='EBK')
  if TPower.GetPower(GN_WYZF_Edit) then
  begin
    //if AYWLXDM = '其他' then
    if 1 <> 1 then
    begin
      PanelTitle.Enabled := False;
      PanelWYZF.Enabled := False;
      PanelDJXX.Enabled := False;
      SpeedItem_insert.Enabled := False;
      SpeedItem_copy.Enabled := False;
      SpeedItem_Edit.Enabled := False;
      SpeedItem_Save.Enabled := False;
      SpeedItem_Cancel.Enabled := False;

      M_ZF.Enabled := False;
      M_HY.Enabled := False;
      M_Delete.Enabled := False;
      if AWYZFXXRec.DJZT = 0 then
        M_ZF.Enabled := True;
      if AWYZFXXRec.DJZT = -1 then
        M_HY.Enabled := True;
      if AWYZFXXRec.DJZT = -1 then
        M_Delete.Enabled := True;
    end
      //else if (AYWLX = '转账支票') or (AYWLX = '电汇') or (AYWLX = '现金支票') then
    else if 1 = 1 then
    begin
      //SpeedItem_insert.Enabled := True;   // Modified by guozy 2013/3/31 星期日 21:53:53

      SpeedItem_copy.Enabled := True;
      if AWYZFXXRec.DJZT = -999 then
      begin
        ComboBoxYWLX.Enabled := bCanEdit;
        PanelTitle.Enabled := bCanEdit; // Modified by guozy 2013/3/31 星期日 21:54:29
        PanelWYZF.Enabled := bCanEdit; // Modified by guozy 2013/3/31 星期日 21:54:40
        SpeedItem_Edit.Enabled := False;
        SpeedItem_Save.Enabled := bCanEdit;
        SpeedItem_Cancel.Enabled := bCanEdit;
        SpeedItem_copy.Enabled := False;
      end
      else if AWYZFXXRec.DJZT = 0 then
      begin
        ComboBoxYWLX.Enabled := bCanEdit;
        PanelTitle.Enabled := bCanEdit; // Modified by guozy 2013/3/31 星期日 21:54:48
        PanelWYZF.Enabled := bCanEdit; // Modified by guozy 2013/3/31 星期日 21:54:58
        SpeedItem_Edit.Enabled := not bCanEdit;
        SpeedItem_Save.Enabled := bCanEdit;
        SpeedItem_Print.Enabled := not bCanEdit;
        SpeedItem_Cancel.Enabled := bCanEdit;
        SpeedItem_copy.Enabled := not SpeedItem_Save.Enabled;
      end
      else
      begin
        PanelTitle.Enabled := False;
        PanelWYZF.Enabled := False;
        PanelDJXX.Enabled := False;
        SpeedItem_Edit.Enabled := False;
        SpeedItem_Save.Enabled := False;
        SpeedItem_Cancel.Enabled := False;
        SpeedItem_Print.Enabled := True;
      end;
      grd.ReadOnly := not bCanEdit;
      M_ZF.Enabled := False;
      M_HY.Enabled := False;
      M_Delete.Enabled := False;
      if AWYZFXXRec.DJZT = 0 then
        M_ZF.Enabled := True;
      if AWYZFXXRec.DJZT = -1 then
        M_HY.Enabled := True;
      if AWYZFXXRec.DJZT = -1 then
        M_Delete.Enabled := True;
    end;
  end
  else
  begin
    grd.ReadOnly := True;
    PanelTitle.Enabled := False;
    PanelWYZF.Enabled := False;
    PanelDJXX.Enabled := False;
    SpeedItem_insert.Enabled := False;
    SpeedItem_Edit.Enabled := False;
    SpeedItem_copy.Enabled := False;
    SpeedItem_Save.Enabled := False;
    SpeedItem_Print.Enabled := True;
    SpeedItem_Cancel.Enabled := False;
    M_ZF.Enabled := False;
    M_HY.Enabled := False;
    M_Delete.Enabled := False;
  end;
  //添加权限校验
  begin
    if not TPower.GetPower(GN_WYZF_Edit) then
    begin
      SpeedItem_insert.Enabled := False;
      SpeedItem_Edit.Enabled := False;
      SpeedItem_copy.Enabled := False;
      SpeedItem_Save.Enabled := False;
    end;
    if not TPower.GetPower(GN_WYZF_SH) then
    begin
      SpeedItem_SSSH.Enabled := False;
      SpeedItem_Check.Enabled := False;
      SpeedItem_CheckNew.Enabled := False;
      SpeedItem_Check2.Enabled := False;
      M_SH.Enabled := False;
    end;
    if not TPower.GetPower(GN_WYZF_XS) then
    begin
      M_XS.Enabled := False;
    end;
    if not TPower.GetPower(GN_WYZF_ZF) then
    begin
      M_ZF.Enabled := False;
    end;
    if not TPower.GetPower(GN_WYZF_HY) then
    begin
      M_HY.Enabled := False;
    end;
    if not TPower.GetPower(GN_WYZF_ZX) then
    begin
      SpeedItem_do.Enabled := False;
    end;
    if not TPower.GetPower(GN_WYZF_QXZX) then
    begin
      M_QXZX.Enabled := False;
    end;
    if not TPower.GetPower(GN_WYZF_CXZX) then
    begin
      M_CXZX.Enabled := False;
    end;
  end;
end;

function TFormWYZF.DoWYZFSH(AZFID: string; ASHZT: Integer; ASHLX: Integer; ASHID: Integer = -1; ASHR: string = '';
  ASHSJ: string = ''): Boolean;
var
  szSQL: string;
begin
  Result := False;
  try
    if ASHLX = 1 then // 初审
    begin
      szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(ASHZT) + ','
        + ' SHID1 = ' + IntToStr(ASHID) + ','
        + ' SHR1 = ''' + ASHR + ''','
        + ' SHSJ1 = ''' + ASHSJ + ''''
        + ' WHERE GSDM = ''' + AGSDM + ''''
        + ' AND KJND = ''' + AYWND + ''''
        + ' AND YWLXDM = ''' + AYWLXDM + ''''
        + ' AND ZFID = ''' + AZFID + '''';
    end
    else if ASHLX = 2 then // 复审
    begin
      szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(ASHZT) + ','
        + ' SHID2 = ' + IntToStr(ASHID) + ','
        + ' SHR2 = ''' + ASHR + ''','
        + ' SHSJ2 = ''' + ASHSJ + ''''
        + ' WHERE GSDM = ''' + AGSDM + ''''
        + ' AND KJND = ''' + AYWND + ''''
        + ' AND YWLXDM = ''' + AYWLXDM + ''''
        + ' AND ZFID = ''' + AZFID + '''';
    end;
    PExecSQL(szSQL);
    with ClientDataSetWYZF do
    begin
      if Locate('ywlxdm;zfid', VarArrayOf([AYWLXDM, AZFID]), []) then
      begin
        Edit;
        FieldByName('DJZT').AsInteger := ASHZT;
        if ASHLX = 1 then
        begin
          FieldByName('SHID1').AsInteger := ASHID;
          FieldByName('SHR1').AsString := ASHR;
          FieldByName('SHSJ1').AsString := ASHSJ;
        end
        else if ASHLX = 2 then
        begin
          FieldByName('SHID2').AsInteger := ASHID;
          FieldByName('SHR2').AsString := ASHR;
          FieldByName('SHSJ2').AsString := ASHSJ;
        end;
        Post;
      end;
    end;
    Result := True;
    //SysMessage('操作成功。', AOther_JG, [mbOK]);
  except
    SysMessage('操作失败。', AOther_JG, [mbOK]);
  end;
end;

procedure TFormWYZF.SpeedItem_CheckClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_SH1) then
  begin
    SysMessage('没有审核权限。', AOther_JG, [mbOk]);
    Exit;
  end
  else
  begin
    //if (Trim(LabelYWLX.Caption)<>'现金支票') and (Trim(CB_DEPID.Text)='') then begin
    if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) <> '1') and (Trim(CB_DEPID.Text) = '') then
    begin
      if CB_DEPID.Enabled then
        CB_DEPID.SetFocus;
      SysMessage('收款银行不能为空！', AOther_JG, [mbOk]);
      Exit;
    end;

    //if (Trim(LabelYWLX.Caption)<>'现金支票') and (Trim(edtYHHB2.Text)='') then begin
    if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) <> '1') and (Trim(edtYHHB2.Text) = '') then
    begin
      if CB_PROVINCE.Enabled then
        CB_PROVINCE.SetFocus;
      SysMessage('收款银行行号不能为空！', AOther_JG, [mbOk]);
      Exit;
    end;

  end;
  if SpeedItem_Check.Caption = '初审' then
  begin
    if DoWYZFSH(AWYZFID, 1, 1, GCzy.ID, GCzy.name, FormatDateTime('YYYY-MM-DD HH:NN:SS', Now)) then
    begin
      PWriteYHCzrz('初审：' + AYWLXDM + '-' + AWYZFID);
      LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF);
      SetDJStatus;
      WYZFOper := OpBrowse;
    end;
  end
  else if SpeedItem_Check.Caption = '消审' then
  begin
    if DoWYZFSH(AWYZFID, 0, 1) then
    begin
      PWriteYHCzrz('消审（初审）：' + AWYZFID);
      LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF);
      SetDJStatus;
      WYZFOper := OpBrowse;
    end;
  end;

end;

procedure TFormWYZF.SetDJCheckStatus;
begin
  SpeedItem_Check.Visible := False;
  SpeedItem_Check2.Visible := False;
  SpeedItem_SSSH.Visible := False;
  SpeedItem_CheckNew.Visible := False;

  if not bWYZFQYSHL then
  begin
    SpeedItem_Check.Visible := True;
    SpeedItem_Check2.Visible := True;
    SpeedItem_do.Visible := True;
    SpeedItem_Check.Caption := '';
    SpeedItem_Check.BtnCaption := '';
    SpeedItem_Check2.Caption := '';
    SpeedItem_Check2.BtnCaption := '';
    SpeedItem_do.Caption := '执行';
    SpeedItem_do.BtnCaption := '执行';
    //if (AYWLX = '转账支票') or (AYWLX = '电汇') or (AYWLX = '现金支票') then
    if (AYWLXDM <> '') then
    begin
      SpeedItem_Check.Visible := True;
      SpeedItem_Check2.Visible := True;
      if AWYZFXXRec.DJZT = 3 then
      begin
        SpeedItem_Check.Caption := '';
        SpeedItem_Check.BtnCaption := '';
        SpeedItem_Check2.Caption := '';
        SpeedItem_Check2.BtnCaption := '';
        SpeedItem_Check.Enabled := False;
        SpeedItem_Check2.Enabled := False;
      end
      else if AWYZFXXRec.DJZT = 2 then
      begin
        SpeedItem_Check.Caption := '';
        SpeedItem_Check.BtnCaption := '';
        SpeedItem_Check2.Caption := '消审';
        SpeedItem_Check2.BtnCaption := '消审';
        SpeedItem_Check.Enabled := False;
        SpeedItem_Check2.Enabled := True;

      end
      else if AWYZFXXRec.DJZT = 1 then
      begin
        SpeedItem_Check.Caption := '消审';
        SpeedItem_Check.BtnCaption := '消审';
        SpeedItem_Check2.Caption := '复审';
        SpeedItem_Check2.BtnCaption := '复审';
        SpeedItem_Check.Enabled := True;
        SpeedItem_Check2.Enabled := True;
      end
      else if AWYZFXXRec.DJZT = 0 then
      begin
        SpeedItem_Check.Caption := '初审';
        SpeedItem_Check.BtnCaption := '初审';
        SpeedItem_Check2.Caption := '';
        SpeedItem_Check2.BtnCaption := '';
        SpeedItem_Check.Enabled := True;
        SpeedItem_Check2.Enabled := False;
      end
      else if AWYZFXXRec.DJZT = -1 then
      begin
        SpeedItem_Check.Caption := '';
        SpeedItem_Check.BtnCaption := '';
        SpeedItem_Check2.Caption := '';
        SpeedItem_Check2.BtnCaption := '';
        SpeedItem_Check.Enabled := False;
        SpeedItem_Check2.Enabled := False;
      end
      else if AWYZFXXRec.DJZT = -999 then
      begin
        SpeedItem_Check.Caption := '';
        SpeedItem_Check.BtnCaption := '';
        SpeedItem_Check2.Caption := '';
        SpeedItem_Check2.BtnCaption := '';
        SpeedItem_Check.Enabled := False;
        SpeedItem_Check2.Enabled := False;
      end;

      SpeedItem_do.Visible := True;
      SpeedItem_do.Enabled := AWYZFXXRec.DJZT = 2;
    end
      //else if AYWLX = '其他' then
    else if AYWLXDM = '' then
    begin
      SpeedItem_Check.Caption := '';
      SpeedItem_Check.BtnCaption := '';
      SpeedItem_Check2.Caption := '';
      SpeedItem_Check2.BtnCaption := '';
      SpeedItem_Check.Enabled := False;
      SpeedItem_Check2.Enabled := False;
      SpeedItem_do.Visible := True;

      SpeedItem_do.Enabled := AWYZFXXRec.DJZT = 2;
    end;
    if not TPower.GetPower(GN_WYZF_SH1) then
    begin
      SpeedItem_Check.Enabled := False;
    end;
    if not TPower.GetPower(GN_WYZF_SH2) then
    begin
      SpeedItem_Check2.Enabled := False;
    end;
  end
  else
  begin
    SpeedItem_SSSH.Visible := True;
    SpeedItem_CheckNew.Visible := True;
    SpeedItem_do.Visible := True;

    SpeedItem_do.Caption := '执行';
    SpeedItem_do.BtnCaption := '执行';
    //if (AYWLX = '转账支票') or (AYWLX = '电汇') or (AYWLX = '现金支票') then
    if (1 = 1) then
    begin
      if AWYZFXXRec.DJStatus = djZX then
      begin
        SpeedItem_SSSH.Enabled := False;
        SpeedItem_SSSH.Caption := '收回';
        SpeedItem_SSSH.BtnCaption := '收回';
        SpeedItem_CheckNew.Enabled := False;
      end
      else if AWYZFXXRec.DJStatus = djSSH then
      begin
        SpeedItem_SSSH.Enabled := True;
        SpeedItem_SSSH.Caption := '收回';
        SpeedItem_SSSH.BtnCaption := '收回';
        SpeedItem_CheckNew.Enabled := True;
      end
      else if AWYZFXXRec.DJStatus = djSHH then
      begin
        SpeedItem_SSSH.Enabled := False;
        SpeedItem_SSSH.Caption := '收回';
        SpeedItem_SSSH.BtnCaption := '收回';
        SpeedItem_CheckNew.Enabled := True;
      end
      else if AWYZFXXRec.DJStatus = djWSHH then
      begin
        SpeedItem_SSSH.Enabled := True;
        SpeedItem_SSSH.Caption := '送审';
        SpeedItem_SSSH.BtnCaption := '送审';
        SpeedItem_CheckNew.Enabled := False;
      end
      else if AWYZFXXRec.DJStatus = djZF then
      begin
        SpeedItem_SSSH.Enabled := False;
        SpeedItem_SSSH.Caption := '送审';
        SpeedItem_SSSH.BtnCaption := '送审';
        SpeedItem_CheckNew.Enabled := False;
      end;

      SpeedItem_do.Visible := True;
      SpeedItem_do.Enabled := (AWYZFXXRec.DJStatus = djSHH)
        and (AWYZFXXRec.CurSHJD = 999) and (AWYZFXXRec.NextSHJD = -1);
    end
      //else if AYWLX = '其他' then
    else if (1 <> 1) then
    begin
      SpeedItem_Check.Caption := '';
      SpeedItem_Check.BtnCaption := '';
      SpeedItem_Check2.Caption := '';
      SpeedItem_Check2.BtnCaption := '';
      SpeedItem_Check.Enabled := False;
      SpeedItem_Check2.Enabled := False;
      SpeedItem_do.Visible := True;

      SpeedItem_do.Enabled := AWYZFXXRec.DJZT = 2;
    end;
    if not TPower.GetPower(GN_WYZF_SH1) then
    begin
      SpeedItem_Check.Enabled := False;
    end;
    if not TPower.GetPower(GN_WYZF_SH2) then
    begin
      SpeedItem_Check2.Enabled := False;
    end;
  end;
  if not TPower.GetPower(GN_WYZF_ZX) then
  begin
    SpeedItem_do.Enabled := False;
  end;
  // 取消执行和重新执行
  M_QXZX.Enabled := False;
  M_CXZX.Enabled := False;
  //加密验证失败的受理失败 add by gengzhuo 20130926
  if (AWYZFXXRec.DJZT = 3) and ((AWYZFXXRec.SLZT = '受理失败')
    or (AWYZFXXRec.SLZT = '受理状态不明')
    or (AWYZFXXRec.CLXX = '加密信息已被篡改')) then
  begin
    M_QXZX.Enabled := True;
  end;
  if (AWYZFXXRec.DJZT = 3) and (AWYZFXXRec.SLZT = '受理成功') and (AWYZFXXRec.ZFZT = '支付失败') then
  begin
    M_QXZX.Enabled := True;
    M_CXZX.Enabled := True;
  end;
  if (AWYZFXXRec.DJZT = 3) and (AWYZFXXRec.SLZT = '') and (AWYZFXXRec.ZFZT = '') then
  begin
    M_QXZX.Enabled := True;
  end;
end;

procedure TFormWYZF.ClearWYZFXXRec;
begin
  AWYZFXXRec.ZFID := '';
  AWYZFXXRec.YWND := '';
  AWYZFXXRec.YWRQ := '';
  AWYZFXXRec.YWLXDM := '';
  AWYZFXXRec.YWLXMC := '';
  AWYZFXXRec.YWYH := '';
  AWYZFXXRec.FKFZH := '';
  AWYZFXXRec.FKFMC := '';
  AWYZFXXRec.FYHZH := '';
  AWYZFXXRec.FZHMC := '';
  AWYZFXXRec.FKHYH := '';
  AWYZFXXRec.FYHHH := '';
  AWYZFXXRec.FYHHB := '';
  AWYZFXXRec.FKHDQ := '';
  AWYZFXXRec.SKFZH := '';
  AWYZFXXRec.SKFMC := '';
  AWYZFXXRec.SYHZH := '';
  AWYZFXXRec.SZHMC := '';
  AWYZFXXRec.SKHYH := '';
  AWYZFXXRec.SYHHH := '';
  AWYZFXXRec.SYHHB := '';
  AWYZFXXRec.SKHDQ := '';
  AWYZFXXRec.ZY := '';
  AWYZFXXRec.JE := 0;
  AWYZFXXRec.TCBZ := '';

  AWYZFXXRec.LRID := -1;
  AWYZFXXRec.LRSJ := '';
  AWYZFXXRec.SHID1 := -1;
  AWYZFXXRec.SHID2 := -1;
  AWYZFXXRec.DJZT := -999;
  AWYZFXXRec.CLZT := '';
  AWYZFXXRec.SLZT := '';
  AWYZFXXRec.ZFZT := '';
  AWYZFXXRec.YDJBH := '';
  AWYZFXXRec.YDJSJ := '';
  AWYZFXXRec.ZXSJ := ''; // Added by guozy 2013/4/19 星期五 14:43:49
  AWYZFXXRec.ZFSJ := ''; // Added by guozy 2013/4/19 星期五 14:43:49
  AWYZFXXRec.SFTH := '';

  AWYZFXXRec.SHFlow := '';
  AWYZFXXRec.CurSHJD := -999;
  AWYZFXXRec.NextSHJD := -999;
  AWYZFXXRec.CurSHJDMC := '';
  AWYZFXXRec.NextSHJDMC := '';
  AWYZFXXRec.SBANKUQNO := ''; // Added by guozy 2013/4/18 星期四 8:55:49
  AWYZFXXRec.SBUSIUQNO := ''; // Added by guozy 2013/4/18 星期四 8:55:49
  AWYZFXXRec.SHEADBUSIUQNO := ''; // Added by guozy 2013/4/18 星期四 8:55:49
end;

function TFormWYZF.DoWYZFDel(AZFID: string): Boolean;
var
  szSQL: string;
begin
  Result := False;
  try
    //    szSQL := 'DELETE FROM EBK_ZFXX '
    //      + ' WHERE GSDM = ''' + AGSDM + ''''
    //      + ' AND KJND = ''' + AYWND + ''''
    //      + ' AND YWLX = ''' + AYWLX + ''''
    //      + ' AND ZFID = ''' + AZFID + '''';
    szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(-2) // -2 标示删除
    + ' WHERE GSDM = ''' + AGSDM + ''''
      + ' AND KJND = ''' + AYWND + ''''
      + ' AND YWLXDM = ''' + AYWLXDM + ''''
      + ' AND ZFID = ''' + AZFID + '''';
    PExecSQL(szSQL);
    with ClientDataSetWYZF do
    begin
      if Locate('ywlxdm;zfid', VarArrayOf([AYWLXDM, AZFID]), []) then
        Delete;
    end;
    Result := True;
    //SysMessage('操作成功。', AOther_JG, [mbOK]);
  except
    SysMessage('操作失败。', AOther_JG, [mbOK]);
  end;
end;

function TFormWYZF.DoWYZFZFHY(AZFID: string; AZFHY: Integer): Boolean;
var
  szSQL: string;
begin
  Result := False;
  try
    szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(AZFHY)
      + ' WHERE GSDM = ''' + AGSDM + ''''
      + ' AND KJND = ''' + AYWND + ''''
      + ' AND YWLXDM = ''' + AYWLXDM + ''''
      + ' AND ZFID = ''' + AZFID + '''';
    PExecSQL(szSQL);
    with ClientDataSetWYZF do
    begin
      if Locate('ywlxdm;zfid', VarArrayOf([AYWLXDM, AZFID]), []) then
      begin
        Edit;
        FieldByName('DJZT').AsInteger := AZFHY;
        Post;
      end;
    end;
    Result := True;
    //SysMessage('操作成功。', AOther_JG, [mbOK]);
  except
    SysMessage('操作失败。', AOther_JG, [mbOK]);
  end;
end;

procedure TFormWYZF.M_ZFClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_Edit) then
  begin
    SysMessage('没有编辑权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  if not TPower.GetPower(GN_WYZF_ZF) then
  begin
    SysMessage('没有作废权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  if DoWYZFZFHY(AWYZFID, -1) then
  begin
    PWriteYHCzrz('作废：' + AYWLXDM + '-' + AWYZFID);
    LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF);
    SetDJStatus;
    WYZFOper := OpBrowse;
  end;
end;

procedure TFormWYZF.M_HYClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_Edit) then
  begin
    SysMessage('没有编辑权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  if not TPower.GetPower(GN_WYZF_HY) then
  begin
    SysMessage('没有还原权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  if DoWYZFZFHY(AWYZFID, 0) then
  begin
    PWriteYHCzrz('还原：' + AYWLXDM + '-' + AWYZFID);
    LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF);
    SetDJStatus;
    WYZFOper := OpBrowse;
  end;
end;

procedure TFormWYZF.M_DeleteClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_Edit) then
  begin
    SysMessage('没有编辑权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  if not TPower.GetPower(GN_WYZF_ZF) then
  begin
    SysMessage('没有删除权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  if (AWYZFXXRec.ZFZT = '支付成功') or (AWYZFXXRec.ZFZT = '支付状态不明') then
  begin
    SysMessage('支付成功或支付状态不明的单据不允许删除。', AOther_JG, [mbOk]);
    Exit;
  end;
  if (AWYZFXXRec.SLZT = '受理成功') and (AWYZFXXRec.ZFZT <> '支付失败') then
  begin
    SysMessage('单据已经受理成功，不允许删除。', AOther_JG, [mbOk]);
    Exit;
  end;
  if DoWYZFDel(AWYZFID) then
  begin
    PWriteYHCzrz('删除：' + AYWLXDM + '-' + AWYZFID);
    ClearWYZFXX;
    SetDJStatus;
  end;
end;

procedure TFormWYZF.SetDJStatus;
begin
  SetDJEditStatus(False);
  SetDJCheckStatus;
  SetDJNavStatus;
end;

function TFormWYZF.DoWYZFZX(AZFID: string; AZXZT: Integer; AGROUPID: string; AZXID: Integer = -1; AZXR: string = '';
  AZXSJ: string = ''; AIsCXZX: Boolean = false): Boolean;
var
  szSQL: string;
begin
  Result := False;
  try
    if AZXZT = 3 then // 执行
    begin
      //if (AYWLX = '转账支票') or (AYWLX = '电汇') then begin
      if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '0') then
      begin
        if AIsCXZX then
        begin //重新执行
          szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(AZXZT) + ','
            + ' ZXID = ' + IntToStr(AZXID) + ','
            + ' ZXR = ''' + AZXR + ''','
            + ' SLZT = '''','
            + ' ZFZT = '''','
            + ' CLXX = '''','
            + ' ZFXX = '''','
            + ' NEWPACKAGEID = ''' + getNewLSH(AGSDM, AYWND, AYWLXDM) + ''','
            + ' ZXSJ = ''' + AZXSJ + ''','
            + ' KSZF = ''0'''
            + ' WHERE GSDM = ''' + AGSDM + ''''
            + ' AND KJND = ''' + AYWND + ''''
            + ' AND YWLXDM = ''' + AYWLXDM + ''''
            + IFF(AGROUPID = '', ' and Zfid=' + QuotedStr(AZFID), ' and GROUPID=' + QuotedStr(AGROUPID));
        end
        else
        begin
          szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(AZXZT) + ','
            + ' ZXID = ' + IntToStr(AZXID) + ','
            + ' ZXR = ''' + AZXR + ''','
            + ' NEWPACKAGEID = ''' + AZFID + ''','
            + ' ZXSJ = ''' + AZXSJ + ''''
            + ' WHERE GSDM = ''' + AGSDM + ''''
            + ' AND KJND = ''' + AYWND + ''''
            + ' AND YWLXDM = ''' + AYWLXDM + ''''
            + ' AND SLZT IS NULL'
            + ' AND ZFZT IS NULL'
            + IFF(AGROUPID = '', ' and Zfid=' + QuotedStr(AZFID), ' and GROUPID=' + QuotedStr(AGROUPID));
        end;
        //end else if (AYWLX = '现金支票') then begin
      end
      else if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '1') then
      begin
        szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(AZXZT) + ','
          + ' ZXID = ' + IntToStr(AZXID) + ','
          + ' ZXR = ''' + AZXR + ''','
          + ' zfzt = ''支付成功'', '
          + ' ZXSJ = ''' + AZXSJ + ''','
          + ' ZFSJ = ''' + AZXSJ + ''' '
          + ' WHERE GSDM = ''' + AGSDM + ''''
          + ' AND KJND = ''' + AYWND + ''''
          + ' AND YWLXDM = ''' + AYWLXDM + ''''
          + IFF(AGROUPID = '', ' and Zfid=' + QuotedStr(AZFID), ' and GROUPID=' + QuotedStr(AGROUPID));
      end;
    end
    else if AZXZT = 2 then
    begin
      //if (AYWLX = '转账支票') or (AYWLX = '电汇') or (AYWLX = '现金支票') then
      if (1 = 1) then
        szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(AZXZT) + ','
          + ' ZXID = ' + IntToStr(AZXID) + ','
          + ' ZXR = ''' + AZXR + ''','
          + ' SLZT = NULL,'
          + ' ZXSJ = ''' + AZXSJ + ''''
          + ' WHERE GSDM = ''' + AGSDM + ''''
          + ' AND KJND = ''' + AYWND + ''''
          + ' AND YWLXDM = ''' + AYWLXDM + ''''
          + IFF(AGROUPID = '', ' and Zfid=' + QuotedStr(AZFID), ' and GROUPID=' + QuotedStr(AGROUPID))
          //else if AYWLX = '其他' then
      else if 1 <> 1 then
        szSQL := 'UPDATE EBK_ZFXX SET DJZT = ' + IntToStr(0) + ','
          + ' ZXID = ' + IntToStr(AZXID) + ','
          + ' ZXR = ''' + AZXR + ''','
          + ' ZXSJ = ''' + AZXSJ + ''''
          + ' WHERE GSDM = ''' + AGSDM + ''''
          + ' AND KJND = ''' + AYWND + ''''
          + ' AND YWLXDM = ''' + AYWLXDM + ''''
          + IFF(AGROUPID = '', ' and Zfid=' + QuotedStr(AZFID), ' and GROUPID=' + QuotedStr(AGROUPID))
    end;
    if szSQL <> '' then
      PExecSQL(szSQL)
    else
    begin
      SysMessage('操作失败。', AOther_JG, [mbOK]);
      exit;
    end;
    if (ClientDataSetWYZF <> nil) and (ClientDataSetWYZF.Active) then
    begin
      with ClientDataSetWYZF do
      begin
        if Locate('ywlxdm;zfid', VarArrayOf([AYWLXDM, AZFID]), []) then
        begin
          Edit;
          //if (AYWLX = '转账支票') or (AYWLX = '电汇') or (AYWLX = '现金支票') then
          if (1 = 1) then
            FieldByName('DJZT').AsInteger := AZXZT
          else
            FieldByName('DJZT').AsInteger := 0;
          FieldByName('ZXID').AsInteger := AZXID;
          FieldByName('ZXR').AsString := AZXR;
          FieldByName('ZXSJ').AsString := AZXSJ;
          Post;
        end;
      end;
    end;
    Result := True;
    SysMessage('操作成功。', AOther_JG, [mbOK]);
  except
    SysMessage('操作失败。', AOther_JG, [mbOK]);
  end;
end;

procedure TFormWYZF.SpeedItem_Check2Click(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_SH2) then
  begin
    SysMessage('没有审核权限。', AOther_JG, [mbOk]);
    Exit;
  end
  else
  begin
    //if (Trim(LabelYWLX.Caption)<>'现金支票') and (Trim(CB_DEPID.Text)='') then begin
    if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '0') and (Trim(CB_DEPID.Text) = '') then
    begin
      if CB_DEPID.Enabled then
        CB_DEPID.SetFocus;
      SysMessage('收款银行不能为空！', AOther_JG, [mbOk]);
      Exit;
    end;

    //if (Trim(LabelYWLX.Caption)<>'现金支票') and (Trim(edtYHHB2.Text)='') then begin
    if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '0') and (Trim(edtYHHB2.Text) = '') then
    begin
      if CB_PROVINCE.Enabled then
        CB_PROVINCE.SetFocus;
      SysMessage('收款银行行号不能为空！', AOther_JG, [mbOk]);
      Exit;
    end;
  end;
  if SpeedItem_Check2.Caption = '复审' then
  begin
    if DoWYZFSH(AWYZFID, 2, 2, GCzy.ID, GCzy.name, FormatDateTime('YYYY-MM-DD HH:NN:SS', Now)) then
    begin
      PWriteYHCzrz('复审：' + AYWLXDM + '-' + AWYZFID);
      LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF);
      SetDJStatus;
      WYZFOper := OpBrowse;
    end;
  end
  else if SpeedItem_Check2.Caption = '消审' then
  begin
    if DoWYZFSH(AWYZFID, 1, 2) then
    begin
      PWriteYHCzrz('消审（复审）：' + AYWLXDM + '-' + AWYZFID);
      LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF);
      SetDJStatus;
      WYZFOper := OpBrowse;
    end;
  end;
end;

procedure TFormWYZF.SpeedItem_doClick(Sender: TObject);
var
  bCanZX: Boolean;
begin
  if not TPower.GetPower(GN_WYZF_ZX) then
  begin
    SysMessage('没有执行权限。', AOther_JG, [mbOk]);
    Exit;
  end
  else
  begin

    if currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '1' then
    begin
      if MessageBox(Self.Handle, '现金支票类型的单据执行后将直接进入已支付环节，不能退回，确定要执行吗?',
        '确认消息', MB_YESNO) = IDNo then
        Exit;
    end;
  end;
  bCanZX := False;
  //if AYWLX = '其他' then
  if 1 <> 1 then
  begin
    bCanZX := SaveWYZFData;
    if bCanZX then
    begin
      AWYZFID := edtZFID.Text;
      PWriteYHCzrz('新增：' + AYWLXDM + '-' + AWYZFID);
      LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.itemindex), ClientDataSetWYZF);
    end;
  end
  else if (1 = 1) then
  begin
    bCanZX := True;
  end;
  if bCanZX then
  begin
    if DoWYZFZX(AWYZFID, 3, AWYZFXXRec.GROUPID, GCzy.ID, GCzy.name, FormatDateTime('YYYY-MM-DD HH:NN:SS', Now)) then
    begin
      PWriteYHCzrz('执行：' + AYWLXDM + '-' + AWYZFID);
      LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.itemindex), ClientDataSetWYZF);
      SetDJStatus;
      WYZFOper := OpBrowse;
    end;
  end;
end;

procedure TFormWYZF.SetDJNavStatus;
begin

  SpeedItem_First.Enabled := False;
  SpeedItem_Prior.Enabled := False;
  SpeedItem_Next.Enabled := False;
  SpeedItem_Last.Enabled := False;
  if ClientDataSetWYZF <> nil then
  begin
    with ClientDataSetWYZF do
    begin
      if Active then
      begin
        if Bof or (RecNo = 1) then
        begin
          SpeedItem_First.Enabled := False;
          SpeedItem_Prior.Enabled := False;
        end
        else
        begin
          SpeedItem_First.Enabled := True and not ISGROUP;
          SpeedItem_First.Visible := not ISGROUP;
          SpeedItem_Prior.Enabled := True and not ISGROUP;
          SpeedItem_Prior.Visible := not ISGROUP;
        end;
        if Eof or (RecNo = RecordCount) then
        begin
          SpeedItem_Next.Enabled := False;
          SpeedItem_Last.Enabled := False;
        end
        else
        begin
          SpeedItem_Next.Enabled := True and not ISGROUP;
          SpeedItem_Last.Enabled := True and not ISGROUP;
          SpeedItem_Next.Visible := not ISGROUP;
          SpeedItem_Last.Visible := not ISGROUP;
        end;
      end;
    end;
  end;

end;

procedure TFormWYZF.NavWYZFDJ(Sender: TObject);
begin
  if (ClientDataSetWYZF <> nil) and ClientDataSetWYZF.Active then
  begin
    with ClientDataSetWYZF do
    begin
      if Sender = SpeedItem_First then
      begin // 首张
        if not Bof then
        begin
          ClearWYZFXX;
          First;
          //LoadWYZFXX(FieldByName('ZFID').AsString, Trim(FieldByName('YWLX').AsString), ClientDataSetWYZF);
          AYWLXDM := trim(ClientDataSetWYZF.FieldByName('YWLXDM').AsString);
          AWYZFID := FieldByName('ZFID').AsString;
          //LoadWYZFRec(FieldByName('ZFID').AsString,ClientDataSetWYZF);
          LoadWYZF(GszGSDM, GszKJND, GszKJQJ, GCzy.ID, AYWLXDM, AWYZFID, ClientDataSetWYZF, True);
          //LoadWYZFXX(AWYZFXXRec);
        end;
      end
      else if Sender = SpeedItem_Prior then
      begin // 上张
        if not Bof then
        begin
          ClearWYZFXX;
          Prior;
          //LoadWYZFXX(FieldByName('ZFID').AsString, Trim(FieldByName('YWLX').AsString), ClientDataSetWYZF);
          AYWLXDM := trim(ClientDataSetWYZF.FieldByName('YWLXDM').AsString);
          AWYZFID := FieldByName('ZFID').AsString;
          //LoadWYZFRec(FieldByName('ZFID').AsString,ClientDataSetWYZF);
          LoadWYZF(GszGSDM, GszKJND, GszKJQJ, GCzy.ID, AYWLXDM, AWYZFID, ClientDataSetWYZF, True);
          //LoadWYZFXX(AWYZFXXRec);
        end;
      end
      else if Sender = SpeedItem_Next then
      begin // 下张
        if not Eof then
        begin
          ClearWYZFXX;
          Next;
          //LoadWYZFXX(FieldByName('ZFID').AsString,Trim(FieldByName('YWLX').AsString), ClientDataSetWYZF);
          AYWLXDM := trim(ClientDataSetWYZF.FieldByName('YWLXDM').AsString);
          AWYZFID := FieldByName('ZFID').AsString;
          //LoadWYZFRec(FieldByName('ZFID').AsString,ClientDataSetWYZF);
          LoadWYZF(GszGSDM, GszKJND, GszKJQJ, GCzy.ID, AYWLXDM, AWYZFID, ClientDataSetWYZF, True);
          //LoadWYZFXX(AWYZFXXRec);
        end;
      end
      else if Sender = SpeedItem_Last then
      begin // 末张
        if not Eof then
        begin
          ClearWYZFXX;
          Last;
          //LoadWYZFXX(FieldByName('ZFID').AsString,Trim(FieldByName('YWLX').AsString), ClientDataSetWYZF);
          AYWLXDM := trim(ClientDataSetWYZF.FieldByName('YWLXDM').AsString);
          AWYZFID := FieldByName('ZFID').AsString;
          //LoadWYZFRec(FieldByName('ZFID').AsString,ClientDataSetWYZF);
          LoadWYZF(GszGSDM, GszKJND, GszKJQJ, GCzy.ID, AYWLXDM, AWYZFID, ClientDataSetWYZF, True);
          //LoadWYZFXX(AWYZFXXRec);
        end;
      end;
    end;
    SetDJStatus;
  end;
end;

procedure TFormWYZF.SpeedItem_FirstClick(Sender: TObject);
begin
  NavWYZFDJ(SpeedItem_First);
end;

procedure TFormWYZF.SpeedItem_PriorClick(Sender: TObject);
begin
  NavWYZFDJ(SpeedItem_Prior);
end;

procedure TFormWYZF.SpeedItem_NextClick(Sender: TObject);
begin
  NavWYZFDJ(SpeedItem_Next);
end;

procedure TFormWYZF.SpeedItem_LastClick(Sender: TObject);
begin
  NavWYZFDJ(SpeedItem_Last);
end;

procedure TFormWYZF.LoadWYZFXX(AZFRec: TWYZFRec);
begin
  ClearWYZFXX;

  PSetPickerDate(DateYWRQ, AZFRec.YWRQ);
  //ComboBoxYWYH.Text := AZFRec.YWYH;
  ComboBoxYWYH.ItemIndex := ComboBoxYWYH.Items.IndexOf(AZFRec.YWYH);
  edtZFID.Text := AZFRec.ZFID;
  LabelYDJBH.Caption := '原单据编号：' + AZFRec.YDJBH; // Added by guozy 2013/3/31 星期日 16:41:21
  if AZFRec.MODCODE = 'GL' then
  begin
    LabelYDJBH.Caption := '原单据编号：' + GetPZH(AZFRec.YDJBH);
  end;
  LabelBANKUQNO.Caption := '银行唯一号：' + AZFRec.SBANKUQNO; // Added by guozy 2013/4/18 星期四 8:45:40
  LabelBUSIUQNO.Caption := '原支付交易流水号：' + AZFRec.SBUSIUQNO; // Added by guozy 2013/4/18 星期四 8:45:40
  LabelHEADBUSIUQNO.Caption := '主交易流水号：' + AZFRec.SHEADBUSIUQNO; // Added by guozy 2013/4/18 星期四 8:45:40
  ComboBoxYWLX.ItemIndex := getJSFSMCIndex(AYWLXDM);
  //if AYWLX = '现金支票' then PanelDJXX.Visible := False
  if currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '1' then
    PanelDJXX.Visible := False
  else
    PanelDJXX.Visible := true;
  THBDJZT.Visible := THBDJZT.Caption <> '';
  edtFKR.Text := AZFRec.FKFZH;
  edtFKRMC.Text := AZFRec.FKFMC;
  edtCLXX.Text := AZFRec.CLXX;
  edtZFXX.Text := AZFRec.ZFXX;
  edtYHZH.Text := AZFRec.FYHZH;
  edtZHMC.Text := AZFRec.FZHMC;
  edtKHYH.Text := AZFRec.FKHYH;
  edtYHHH.Text := AZFRec.FYHHH;
  //edtYHHB.Text := AZFRec.FYHHB;
  edtYHHB.ItemIndex := edtYHHB.Items.IndexOf(AZFRec.FYHHB);
  edtKHDQ.Text := AZFRec.FKHDQ;
  edtYHWD.Text := AZFRec.FYHWD;

  edtSKR.Text := AZFRec.SKFZH;
  edtSKRMC.Text := AZFRec.SKFMC;
  edtYHZH2.Text := AZFRec.SYHZH;
  edtZHMC2.Text := AZFRec.SZHMC;
  edtKHYH2.Text := AZFRec.SKHYH;
  edtYHHB2.Text := AZFRec.SYHHH + ' ' + AZFRec.SYHMC;
  getOthersFromSYHHH(AZFRec.SYHHH);
  edtKHDQ2.Text := AZFRec.SKHDQ;
  edtYHWD2.Text := AZFRec.SYHWD;
  edtJE.Text := FormatFloat('0.00', AZFRec.JE);
  edtZY.Text := AZFRec.ZY;

  //LabelLRR.Caption := IntToStr(AZFRec.LRID);
  LabelLRR.Caption := IntToStr(GCzy.ID) + ' ' + GCzy.name;
  LabelSHR1.Caption := '';
  LabelSHR2.Caption := '';
  LabelZXR.Caption := '';
  THBDJZT.Visible := False;
  LabelZFSJ.Visible := false; // Added by guozy 2013/4/19 星期五 14:30:59
  edtYDJBH.Text := AZFRec.YDJBH;
  edtYDJSJ.Text := AZFRec.YDJSJ;

  //
  ClearWYZFXXRec;
  AWYZFXXRec.ZFID := AZFRec.ZFID;
  AWYZFXXRec.YWND := AZFRec.YWND;
  AWYZFXXRec.YWRQ := AZFRec.YWRQ;
  AWYZFXXRec.YWLXDM := AZFRec.YWLXDM;
  AWYZFXXRec.YWLXMC := AZFRec.YWLXMC;
  AWYZFXXRec.YWYH := AZFRec.YWYH;

  AWYZFXXRec.FKFZH := AZFRec.FKFZH;
  AWYZFXXRec.FKFMC := AZFRec.FKFMC;
  AWYZFXXRec.CLXX := AZFRec.CLXX;
  AWYZFXXRec.ZFXX := AZFRec.ZFXX;
  AWYZFXXRec.FYHZH := AZFRec.FYHZH;
  AWYZFXXRec.FZHMC := AZFRec.FZHMC;
  AWYZFXXRec.FKHYH := AZFRec.FKHYH;
  AWYZFXXRec.FYHHH := AZFRec.FYHHH;
  AWYZFXXRec.FYHHB := AZFRec.FYHHB;
  AWYZFXXRec.FKHDQ := AZFRec.FKHDQ;
  AWYZFXXRec.SKFZH := AZFRec.SKFZH;
  AWYZFXXRec.SKFMC := AZFRec.SKFMC;
  AWYZFXXRec.SYHZH := AZFRec.SYHZH;
  AWYZFXXRec.SZHMC := AZFRec.SZHMC;
  AWYZFXXRec.SKHYH := AZFRec.SKHYH;
  AWYZFXXRec.SYHHH := AZFRec.SYHHH;
  AWYZFXXRec.SYHHB := AZFRec.SYHHB;
  AWYZFXXRec.SKHDQ := AZFRec.SKHDQ;
  AWYZFXXRec.ZY := AZFRec.ZY;
  AWYZFXXRec.JE := AZFRec.JE;
  AWYZFXXRec.TCBZ := AZFRec.TCBZ;

  AWYZFXXRec.LRID := AZFRec.LRID;
  AWYZFXXRec.LRSJ := '';
  AWYZFXXRec.SHID1 := -1;
  AWYZFXXRec.SHID2 := -1;
  AWYZFXXRec.DJZT := AZFRec.DJZT;
  AWYZFXXRec.CLZT := AZFRec.CLZT;
  AWYZFXXRec.SLZT := AZFRec.SLZT;
  AWYZFXXRec.ZFZT := AZFRec.ZFZT;
  AWYZFXXRec.YDJBH := AZFRec.YDJBH;
  AWYZFXXRec.YDJSJ := AZFRec.YDJSJ;
  AWYZFXXRec.ZXSJ := AZFRec.ZXSJ; // Added by guozy 2013/4/19 星期五 14:44:26
  AWYZFXXRec.ZFSJ := AZFRec.ZFSJ; // Added by guozy 2013/4/19 星期五 14:44:26
  AWYZFXXRec.SBANKUQNO := AZFRec.SBANKUQNO; // Added by guozy 2013/4/18 星期四 8:57:10
  AWYZFXXRec.SBUSIUQNO := AZFRec.SBUSIUQNO; // Added by guozy 2013/4/18 星期四 8:57:37
  AWYZFXXRec.SHEADBUSIUQNO := AZFRec.SHEADBUSIUQNO; // Added by guozy 2013/4/18 星期四 8:57:45

  //
  AWYZFID := AWYZFXXRec.ZFID;
  AYWYH := AWYZFXXRec.YWYH;
end;

procedure TFormWYZF.FormShow(Sender: TObject);
begin
  SetComponentsColor(self);
end;

procedure TFormWYZF.edtFKRButtonClick(Sender: TObject);
var
  VarTemp: Variant;
  szSQL: string;
  szZHDM, szZHMC, szYHZH, szTemp: string;
  iPos: Integer;
  szTJ: string;
begin
  //  if edtFKR.Text <> '' then
  //    szTemp := Trim(edtFKR.Text);
  //  if szTemp <> '' then
  //    szTJ := '(zhdm like ''' + szTemp + '%'' or zhmc like ''%' + szTemp + '%'')';
  //  VarTemp := ListViewSelectDM('slZJZH', szTJ, False, '', True);
  //  if VarType(VarTemp) = varinteger then
  //  begin
  //    if (VarTemp = 0) or (VarTemp = -1) then
  //      exit;
  //  end
  //  else
  //  begin
  //    szTemp := VarTemp[0];
  //    if szTemp <> '' then
  //    begin
  //      iPos := Pos(' ', szTemp);
  //      if iPos > 0 then
  //      begin
  //        szZHDM := Trim(Copy(szTemp, 1, iPos - 1));
  //        szTemp := Trim(Copy(szTemp, iPos + 1, Length(szTemp)));
  //        szZHMC := szTemp;
  //      end;
  //      edtFKR.Text := szZHDM;
  //      edtFKRMC.Text := szZHMC;
  //      if szZHDM <> '' then
  //      begin
  //        szSQL := 'select zj.zhdm,zj.zhmc,zj.yhzh,yh.yhzhmc,yh.yhname,yh.yhhh,yh.yhaddr from zj_zhdy zj '
  //          + ' left join pubszdwzh yh'
  //          + ' on (yh.gsdm = zj.gsdm'
  //          + ' and yh.kjnd = ''' + GszKJND + ''''
  //          + ' and yh.yhzh = zj.yhzh)'
  //          + ' where yh.gsdm = ''' + GszGSDM + ''''
  //          + ' and zj.zhdm = ''' + szZHDM + '''';
  //        with DataModulePub.ClientDataSetTmp do
  //        begin
  //          Close;
  //          POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
  //          if FindFirst then
  //          begin
  //            edtYHZH.Text := FieldByName('yhzh').AsString;
  //            edtZHMC.Text := FieldByName('yhzhmc').AsString;
  //            edtKHYH.Text := FieldByName('yhname').AsString;
  //            edtYHHH.Text := FieldByName('yhhh').AsString;
  //            edtYHHB.Text := GetYHHB(FieldByName('yhname').AsString);
  //            edtKHDQ.Text := FieldByName('yhaddr').AsString;
  //            edtYHWD.Text := FieldByName('yhaddr').AsString;
  //          end;
  //          Close;
  //        end;
  //      end;
  //    end;
  //  end;
end;

procedure TFormWYZF.edtSKRButtonClick(Sender: TObject);
var
  VarTemp: Variant;
  szSQL: string;
  szZHDM, szZHMC, szYHZH, szTemp: string;
  iPos: Integer;
  szTJ: string;
begin
  //  if edtSKR.Text <> '' then
  //    szTemp := Trim(edtSKR.Text);
  //  if szTemp <> '' then
  //    szTJ := '(zhdm like ''' + szTemp + '%'' or zhmc like ''%' + szTemp + '%'')';
  //  VarTemp := ListViewSelectDM('slZJZH', szTJ, False, '', True);
  //  if VarType(VarTemp) = varinteger then
  //  begin
  //    if (VarTemp = 0) or (VarTemp = -1) then
  //      exit;
  //  end
  //  else
  //  begin
  //    szTemp := VarTemp[0];
  //    if szTemp <> '' then
  //    begin
  //      iPos := Pos(' ', szTemp);
  //      if iPos > 0 then
  //      begin
  //        szZHDM := Trim(Copy(szTemp, 1, iPos - 1));
  //        szTemp := Trim(Copy(szTemp, iPos + 1, Length(szTemp)));
  //        szZHMC := szTemp;
  //      end;
  //      edtSKR.Text := szZHDM;
  //      edtSKRMC.Text := szZHMC;
  //      if szZHDM <> '' then
  //      begin
  //        szSQL := 'select zj.zhdm,zj.zhmc,zj.yhzh,yh.yhzhmc,yh.yhname,yh.yhhh,yh.yhaddr from zj_zhdy zj '
  //          + ' left join pubszdwzh yh'
  //          + ' on (yh.gsdm = zj.gsdm'
  //          + ' and yh.kjnd = ''' + GszKJND + ''''
  //          + ' and yh.yhzh = zj.yhzh)'
  //          + ' where yh.gsdm = ''' + GszGSDM + ''''
  //          + ' and zj.zhdm = ''' + szZHDM + '''';
  //        with DataModulePub.ClientDataSetTmp do
  //        begin
  //          Close;
  //          POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
  //          if FindFirst then
  //          begin
  //            edtYHZH2.Text := FieldByName('yhzh').AsString;
  //            edtZHMC2.Text := FieldByName('yhzhmc').AsString;
  //            edtKHYH2.Text := FieldByName('yhname').AsString;
  //            //edtYHHH2.Text := FieldByName('yhhh').AsString;
  //            edtYHHB2.Text := GetYHHB(FieldByName('yhname').AsString);
  //            edtKHDQ2.Text := FieldByName('yhaddr').AsString;
  //            edtYHWD2.Text := FieldByName('yhaddr').AsString;
  //          end;
  //          Close;
  //        end;
  //      end;
  //    end;
  //  end;
end;

procedure TFormWYZF.edtZYKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    edtJE.SetFocus;
  end;
end;

procedure TFormWYZF.M_QXZXClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_ZX) then
  begin
    SysMessage('没有执行权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  cdsGroup.First;
  while not cdsGroup.eof do
  begin
    if cdsGroup.FieldByName('SLZT').AsString = '受理成功' then
    begin
      SysMessage('单据已经受理成功，不允许取消执行。', AOther_JG, [mbOk]);
      Exit;
    end
    else if cdsGroup.FieldByName('SLZT').AsString = '支付成功' then
    begin
      SysMessage('单据已经支付成功，不允许取消执行。', AOther_JG, [mbOk]);
      Exit;
    end;
    cdsGroup.Next;
  end;

  //取消执行
  if (AWYZFXXRec.ZFZT <> '支付失败') then
  begin
    if AWYZFXXRec.ZFZT = '支付成功' then
    begin
      SysMessage('单据已经支付成功，不允许取消执行。', AOther_JG, [mbOk]);
      Exit;
    end;
    if AWYZFXXRec.SLZT = '受理成功' then
    begin
      SysMessage('单据已经受理成功，不允许取消执行。', AOther_JG, [mbOk]);
      Exit;
    end;
  end;
  if AWYZFXXRec.DJZT = 3 then
  begin
    if DoWYZFZX(AWYZFID, 2, AWYZFXXRec.GROUPID, -1, '', '') then
    begin
      PWriteYHCzrz('取消执行：' + AYWLXDM + '-' + AWYZFID);
      FormWYZFNotePad.SpeedItem_RefreshClick(nil);
      LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF);
      SetDJStatus;
      WYZFOper := OpBrowse;
    end;
  end;
end;

procedure TFormWYZF.SpeedItem_CheckNewClick(Sender: TObject);
var
  szSHYJ, szSHCZ: string;
  ABillAction: TWYZF_Bill_Action;
begin
  if (not TPower.GetPower(GN_WYZF_SH)) and (not TPower.GetPower(GN_WYZF_XS))
    and (not TPower.GetPower(GN_WYZF_TH)) then
  begin
    SysMessage('没有审核、消审、退回权限。', AOther_JG, [mbOk]);
    Exit;
  end;

  //添加提示 add by gengzhuo 20130926
  if (AWYZFXXRec.DJZT = 1) and (AWYZFXXRec.SLZT = '受理失败') and (AWYZFXXRec.CLXX = '加密信息已被篡改') then
  begin
    SysMessage('由于加密信息已被篡改，只能收回审核', AOther_JG, [mbOk]);
    Exit;
  end;

  //zhengjy 增加审核的Ukey验证

  if LoadWYZFDJSH(AWYZFXXRec, szSHYJ, ABillAction) then
  begin
    if ABillAction = baSH then
    begin
      if not TPower.GetPower(GN_WYZF_SH) then
      begin
        SysMessage('没有审核权限。', AOther_JG, [mbOk]);
        Exit;
      end;
    end
    else if ABillAction = baXS then
    begin
      if not TPower.GetPower(GN_WYZF_XS) then
      begin
        SysMessage('没有消审权限。', AOther_JG, [mbOk]);
        Exit;
      end;
    end
    else if ABillAction = baTH then
    begin
      if not TPower.GetPower(GN_WYZF_TH) then
      begin
        SysMessage('没有退回权限。', AOther_JG, [mbOk]);
        Exit;
      end;
    end
    else if ABillAction = baNOUKEY then
    begin
      Exit;
    end;
    DoWYZFAction(AWYZFXXRec, ABillAction, szSHYJ);
    UpdateWYZFXX(AWYZFXXRec.ZFID, ClientDataSetWYZF);
    //LoadWYZFRec(AWYZFXXRec.ZFID);
    SetDJStatus;
    WYZFOper := OpBrowse;
    LoadWYZFSHLXX(AWYZFXXRec.ZFID, AWYZFXXRec.CurSHJD);

    szSHCZ := '';
    if ABillAction = baSH then
      szSHCZ := '审核'
    else if ABillAction = baXS then
      szSHCZ := '退回上一步'
    else if ABillAction = baTH then
      szSHCZ := '退回到编制人';
    PWriteYHCzrz('审核：' + szSHCZ + ' ' + AYWLXDM + '-' + AWYZFID);
  end;
end;

procedure TFormWYZF.DoWYZFAction(AWYZFRec: TWYZFRec; AZT: TWYZF_Bill_ACTION; ACLYJ: string);
var
  ASHJG: TWYZF_Bill_SHJG;
  vJE: Extended;
  szCLYJ: string; //单据处理意见
  ADJLXID: string;
  ADJID: string;
begin
  CurWYZFAction := AZT;
  ADJLXID := '0';
  ADJID := AWYZFRec.ZFID;
  vJE := AWYZFRec.JE;
  case AZT of
    baSave:
      begin
      end;
    baSS: //送审
      begin
        //
        if SysMessage('您确定要送审当前单据吗？', '_XW', [mbYes, mbNo]) <> mrYes then
          Exit;
        ASHJG.DJLXID := ADJLXID;
        ASHJG.DJSHJG := barPASS;
        ASHJG.DJSHYJ := '送审';
        ASHJG.DJJE := vJE;
        if PSetBillAct(AZT, ADJID, AWYZFRec.YWLXDM, AWYZFRec.GROUPID, ASHJG) then
        begin

        end;
      end;
    baSH: //审核
      begin
        szCLYJ := ACLYJ;
        ASHJG.DJLXID := ADJLXID;
        ASHJG.DJSHJG := barPASS;
        ASHJG.DJSHYJ := szCLYJ;
        ASHJG.DJJE := vJE;
        //根据单据主信息，赋值审核流程信息，审核时，当前审核节点是单据上记录的下一审核节点
        ASHJG.DJCurrSHJD := AWYZFRec.NextSHJD;
        if PSetBillAct(AZT, ADJID, AWYZFRec.YWLXDM, AWYZFRec.GROUPID, ASHJG) then
        begin

        end;
      end;
    baXS: //销审
      begin
        szCLYJ := ACLYJ;
        ASHJG.DJLXID := ADJLXID;
        ASHJG.DJSHJG := barBack;
        ASHJG.DJSHYJ := szCLYJ;
        ASHJG.DJJE := vJE;
        ASHJG.DJCurrSHJD := AWYZFRec.CurSHJD;
        ASHJG.DJNextSHJD := AWYZFRec.NextSHJD;
        if PSetBillAct(AZT, ADJID, AWYZFRec.YWLXDM, AWYZFRec.GROUPID, ASHJG) then
        begin

        end;
      end;
    baTH: //退回
      begin
        szCLYJ := ACLYJ;
        ASHJG.DJLXID := ADJLXID;
        ASHJG.DJSHJG := barBInit;
        ASHJG.DJSHYJ := szCLYJ;
        ASHJG.DJJE := vJE;
        ASHJG.DJCurrSHJD := AWYZFRec.CurSHJD;
        ASHJG.DJNextSHJD := AWYZFRec.NextSHJD;
        if PSetBillAct(AZT, ADJID, AWYZFRec.YWLXDM, AWYZFRec.GROUPID, ASHJG) then
        begin

        end;
      end;
    baHS: //收回
      begin
        if SysMessage('您确定要收回当前单据吗？', '_XW', [mbYes, mbNo]) <> mrYes then
          Exit;

        ASHJG.DJLXID := ADJLXID;
        ASHJG.DJSHJG := barPASS;
        ASHJG.DJSHYJ := '收回';
        ASHJG.DJJE := vJE;
        if PSetBillAct(AZT, ADJID, AWYZFRec.YWLXDM, AWYZFRec.GROUPID, ASHJG) then
        begin

        end;
      end;
    baZF: //作废
      begin
      end;
    baHY: //还原
      begin
      end;
    baSC: //删除
      begin
      end;
    baZX:
      begin
        if SysMessage('您确定要付讫当前单据吗？', '_XW', [mbYes, mbNo]) <> mrYes then
          Exit;

        ASHJG.DJLXID := ADJLXID;
        ASHJG.DJSHJG := barPASS;
        ASHJG.DJSHYJ := '执行';
        ASHJG.DJJE := vJE;
        if PSetBillAct(AZT, ADJID, AWYZFRec.YWLXDM, AWYZFRec.GROUPID, ASHJG) then
        begin

        end;
      end;
    // 反执行
    baFZX:
      begin
        if not ((AWYZFRec.DJZT = 3) and (AWYZFRec.SLZT = '受理成功') and (AWYZFRec.ZFZT = '支付失败')) then
        begin
          SysMessage('只有已经执行、受理成功、支付失败的单价可以取消执行！', AOther_JG, [mbOk]);
          Exit;
        end;

        if SysMessage('您确定要取消执行当前单据吗？', '_XW', [mbYes, mbNo]) <> mrYes then
          Exit;

        ASHJG.DJLXID := ADJLXID;
        ASHJG.DJSHJG := barPASS;
        ASHJG.DJSHYJ := '取消执行';
        ASHJG.DJJE := vJE;
        if PSetBillAct(AZT, ADJID, AWYZFRec.YWLXDM, AWYZFRec.GROUPID, ASHJG) then
        begin

        end;
      end;
  end;
end;

procedure TFormWYZF.SpeedItem_SSSHClick(Sender: TObject);
var
  ABillAction: TWYZF_Bill_Action;
  szSHCZ: string;
  function IsNumber(S: string): Boolean;
  var
    iCount: integer;
  begin
    Result := True;
    for iCount := 1 to length(S) do
    begin
      if not (S[iCount] in ['0'..'9']) then
      begin
        Result := False;
        break;
      end;
    end;
  end;
begin
  if SpeedItem_SSSH.Caption = '送审' then
  begin
    if (getModCode(ComboBoxSJLY.ItemIndex) = 'EBK') and (edtKHYH2.Text = '') then
    begin
      SysMessage('收款银行不能为空！', AOther_JG, [mbOk]);
      Exit;
    end;
    if (CheckZH(edtYHZH.Text)) then
    begin
      SysMessage('付款账户不在账户信息中！', AOther_JG, [mbOk]);
      Exit;
    end;

    //添加提示 add by gengzhuo 20130926
    if (AWYZFXXRec.DJZT = 0) and (AWYZFXXRec.SLZT = '受理失败') and (AWYZFXXRec.CLXX = '加密信息已被篡改') then
    begin
      SysMessage('由于加密信息已被篡改，只能重新修改保存', AOther_JG, [mbOk]);
      Exit;
    end;
    //检查支付明细里面， 有没有卡号不正确的数据
    if cdsGroup.FieldByName('GROUPID').AsString <> '' then
    begin
      cdsGroup.First;
      while not cdsGroup.Eof do
      begin
        if not IsNumber(cdsGroup.FieldByName('SYHZH').AsString) then
        begin
          Application.MessageBox('银行账号必须全部为数字，请检查', '系统提示', MB_ICONWarning + MB_OK);
          Exit;
        end;
        cdsGroup.Next;
      end;
      cdsGroup.First;
    end;
    ABillAction := baSS;
    if not DJCheck then
      Exit;
  end
  else if SpeedItem_SSSH.Caption = '收回' then
    ABillAction := baHS;
  DoWYZFAction(AWYZFXXRec, ABillAction);
  UpdateWYZFXX(AWYZFXXRec.ZFID, ClientDataSetWYZF);
  SetDJStatus;
  WYZFOper := OpBrowse;
  szSHCZ := '';
  if ABillAction = baSS then
    szSHCZ := '送审'
  else if ABillAction = baHS then
    szSHCZ := '收回';
  PWriteYHCzrz(szSHCZ + '：' + AYWLXDM + '-' + AWYZFID);
end;

procedure TFormWYZF.LoadWYZFRec(AZFID: string; CdsData: TClientDataSet = nil);
var
  CdsTemp: TClientDataSet;
  szSQL: string;
begin
  ClearWYZFXXRec;
  if CdsData = nil then
  begin
    CdsTemp := DataModulePub.GetCds;
    //  szSQL := 'select * from EBK_ZFXX where gsdm = ''' + AGSDM + ''''
    //    + ' and ywlx = ''' + AYWLX + ''''
    //    + ' and zfid = ''' + AZFID + ''''
    szSQL := 'select zfxx.*, '
      + '(case when zfxx.curshjd=0 then ''录入'' when zfxx.curshjd=-9 then ''送审'' else wfnd1.nodename end) as curshjdmc, '
      + '(case when zfxx.nextshjd=-1 then ''结束'' when zfxx.nextshjd=-9 then ''送审'' else wfnd2.nodename end) as nextshjdmc'
      + ', (case'
      + ' when djzt=-1 then ''作废'' '
      + ' when djzt=0 then ''未送审'' '
      + ' when djzt>=1 and djzt<=2 and not (curshjd = 999 and nextshjd = -1) then ''审核中'' '
      + ' when djzt=2 and (curshjd = 999 and nextshjd = -1) then ''已审核'' '
      + ' when djzt=''3'' then ''已执行'' '
      + ' when djzt=''3'' and zfzt = ''成功'' then ''已支付'' '
      + ' end) as djStatus'
      + ' from EBK_ZFXX zfxx'
      + ' left join ('
      + 'select wf.gsdm, wf.kjnd, wf.flowcode, nd.nodeseq, nd.nodename from pubworkflow wf '
      + ' left join pubwfnode nd on wf.gsdm = nd.gsdm and wf.kjnd = nd.kjnd '
      + ' and nd.flowcode = wf.flowcode '
      + ') wfnd1 '
      + ' on  wfnd1.gsdm = zfxx.gsdm'
      + ' and wfnd1.kjnd = zfxx.KJND'
      + ' and wfnd1.flowcode = zfxx.flowcode '
      + ' and wfnd1.nodeseq = zfxx.curshjd '
      + ' left join ('
      + 'select wf.gsdm, wf.kjnd, wf.flowcode, nd.nodeseq, nd.nodename from pubworkflow wf '
      + ' left join pubwfnode nd on wf.gsdm = nd.gsdm and wf.kjnd = nd.kjnd '
      + ' and nd.flowcode = wf.flowcode '
      + ') wfnd2 '
      + ' on  wfnd2.gsdm = zfxx.gsdm'
      + ' and wfnd2.kjnd = zfxx.KJND'
      + ' and wfnd2.flowcode = zfxx.flowcode'
      + ' and wfnd2.nodeseq = zfxx.nextshjd';
    szSQL := 'select * from (' + szSQL + ') yhzfxx '
      + ' where gsdm = ''' + GszGSDM + ''''
      + ' and ywlxdm = ''' + AYWLXDM + ''''
      + ' and zfid = ''' + AZFID + '''';

    POpenSql(CdsTemp, szSQL);
  end
  else
  begin
    CdsTemp := TClientDataSet.Create(nil);
    CdsTemp.Data := CdsData.Data;
  end;
  with CdsTemp do
  begin
    if RecordCount > 0 then
      if Locate('ywlxdm;zfid', VarArrayOf([AYWLXDM, AZFID]), []) then
      begin
        AWYZFXXRec.ZFID := FieldByName('ZFID').AsString;
        AWYZFXXRec.YWND := FieldByName('KJND').AsString;
        AWYZFXXRec.YWRQ := FieldByName('YWRQ').AsString;
        AWYZFXXRec.YWLXDM := FieldByName('YWLXDM').AsString;
        AWYZFXXRec.YWLXMC := FieldByName('YWLX').AsString;
        AWYZFXXRec.YWYH := FieldByName('YWYH').AsString;
        //
        AWYZFXXRec.FKFZH := FieldByName('FKFZH').AsString;
        AWYZFXXRec.FKFMC := FieldByName('FKFMC').AsString;
        AWYZFXXRec.CLXX := FieldByName('CLXX').AsString;
        AWYZFXXRec.ZFXX := FieldByName('ZFXX').AsString;
        AWYZFXXRec.FYHZH := FieldByName('FYHZH').AsString;
        AWYZFXXRec.FZHMC := FieldByName('FZHMC').AsString;
        AWYZFXXRec.FKHYH := FieldByName('FKHYH').AsString;
        AWYZFXXRec.FYHHH := FieldByName('FYHHH').AsString;
        AWYZFXXRec.FYHHB := FieldByName('FYHHB').AsString;
        AWYZFXXRec.FKHDQ := FieldByName('FKHDQ').AsString;
        AWYZFXXRec.SKFZH := FieldByName('SKFZH').AsString;
        AWYZFXXRec.SKFMC := FieldByName('SKFMC').AsString;
        AWYZFXXRec.SYHZH := FieldByName('SYHZH').AsString;
        AWYZFXXRec.SZHMC := FieldByName('SZHMC').AsString;
        AWYZFXXRec.SKHYH := FieldByName('SKHYH').AsString;
        AWYZFXXRec.SYHHH := FieldByName('SYHHH').AsString;
        AWYZFXXRec.SYHHB := FieldByName('SYHHB').AsString;
        AWYZFXXRec.SKHDQ := FieldByName('SKHDQ').AsString;
        AWYZFXXRec.ZY := FieldByName('ZY').AsString;
        AWYZFXXRec.JE := FieldByName('JE').AsFloat;
        AWYZFXXRec.TCBZ := FieldByName('TCBZ').AsString;
        AWYZFXXRec.GROUPID := FieldByName('GROUPID').AsString;
        //
        AWYZFXXRec.LRID := FieldByName('LRID').AsInteger;
        AWYZFXXRec.LRSJ := FieldByName('LRSJ').AsString;
        AWYZFXXRec.SHID1 := FieldByName('SHID1').AsInteger;
        AWYZFXXRec.SHID2 := FieldByName('SHID2').AsInteger;
        AWYZFXXRec.DJZT := FieldByName('DJZT').AsInteger;
        AWYZFXXRec.CLZT := FieldByName('CLZT').AsString;
        AWYZFXXRec.SLZT := FieldByName('SLZT').AsString;
        AWYZFXXRec.ZFZT := FieldByName('ZFZT').AsString;
        AWYZFXXRec.YDJBH := FieldByName('YDJBH').AsString;
        AWYZFXXRec.YDJSJ := FieldByName('YDJSJ').AsString;
        AWYZFXXRec.ZXSJ := FieldByName('ZXSJ').AsString; // Added by guozy 2013/4/19 星期五 14:44:48
        AWYZFXXRec.ZFSJ := FieldByName('ZFSJ').AsString; // Added by guozy 2013/4/19 星期五 14:44:48

        AWYZFXXRec.SBANKUQNO := FieldByName('BANKUQNO').AsString; // Added by guozy 2013/4/18 星期四 8:58:54
        AWYZFXXRec.SBUSIUQNO := FieldByName('BUSIUQNO').AsString; // Added by guozy 2013/4/18 星期四 8:58:59
        AWYZFXXRec.SHEADBUSIUQNO := FieldByName('HEADBUSIUQNO').AsString; // Added by guozy 2013/4/18 星期四 8:59:03

        if not bWYZFQYSHL then
        begin
          if AWYZFXXRec.DJZT = -1 then
            THBDJZT.Caption := '已作废'
          else if AWYZFXXRec.DJZT = 0 then
            THBDJZT.Caption := '未审核'
          else if AWYZFXXRec.DJZT = 1 then
          begin
            THBDJZT.Caption := '已初审';
          end
          else if AWYZFXXRec.DJZT = 2 then
          begin
            THBDJZT.Caption := '已复审';
          end
          else if AWYZFXXRec.DJZT = 3 then
          begin
            THBDJZT.Caption := '已执行';
            if AWYZFXXRec.SLZT <> '' then
            begin
              THBDJZT.Caption := AWYZFXXRec.SLZT;
            end;
            if AWYZFXXRec.ZFZT <> '' then
            begin
              THBDJZT.Caption := AWYZFXXRec.ZFZT;
            end;
          end;
          THBDJZT.Visible := THBDJZT.Caption <> '';

          if THBDJZT.Visible and (THBDJZT.Caption = '支付成功') then
          begin
            LabelZFSJ.Visible := true;
            LabelZFSJ.Caption := '支付时间：' + FieldByName('ZFSJ').AsString;
          end
          else
            LabelZFSJ.Visible := false;
        end
        else
        begin
          AWYZFXXRec.SHFlow := FieldByName('FlowCode').AsString;
          AWYZFXXRec.CurSHJD := FieldByName('CurSHJD').AsInteger;
          AWYZFXXRec.NextSHJD := FieldByName('NextSHJD').AsInteger;
          AWYZFXXRec.CurSHJDMC := FieldByName('CurSHJD').AsString;
          AWYZFXXRec.NextSHJDMC := FieldByName('NextSHJD').AsString;
          if AWYZFXXRec.DJZT = -1 then
            AWYZFXXRec.DJStatus := djZF
          else if AWYZFXXRec.DJZT = 0 then
            AWYZFXXRec.DJStatus := djWSHH
          else if AWYZFXXRec.DJZT = 1 then
          begin
            AWYZFXXRec.DJStatus := djSSH
          end
          else if AWYZFXXRec.DJZT = 2 then
            AWYZFXXRec.DJStatus := djSHH
          else if AWYZFXXRec.DJZT = 3 then
            AWYZFXXRec.DJStatus := djZX
          else
            AWYZFXXRec.DJStatus := djWSHH;
          if (AWYZFXXRec.DJStatus = djWSHH) and (AWYZFXXRec.SFTH = '1') then
            AWYZFXXRec.DJStatus := djTH;

          if AWYZFXXRec.DJStatus = djZF then
            THBDJZT.Caption := '已作废'
          else if AWYZFXXRec.DJStatus = djWSHH then
            THBDJZT.Caption := '未送审'
          else if AWYZFXXRec.DJStatus = djSSH then
            THBDJZT.Caption := '审核中'
          else if AWYZFXXRec.DJStatus = djSHH then
          begin
            if (AWYZFXXRec.CurSHJD = 999) and (AWYZFXXRec.NextSHJD = -1) then
              THBDJZT.Caption := '已审核'
            else
              THBDJZT.Caption := '审核中';
          end
          else if AWYZFXXRec.DJStatus = djZX then
            THBDJZT.Caption := '已执行';
          if AWYZFXXRec.SLZT <> '' then
            THBDJZT.Caption := AWYZFXXRec.SLZT;
          if AWYZFXXRec.ZFZT <> '' then
            THBDJZT.Caption := AWYZFXXRec.ZFZT;
          THBDJZT.Visible := THBDJZT.Caption <> '';
          if THBDJZT.Visible and (THBDJZT.Caption = '支付成功') then
          begin
            LabelZFSJ.Visible := true;
            LabelZFSJ.Caption := '支付时间：' + AWYZFXXRec.ZFSJ;
          end
          else
            LabelZFSJ.Visible := false;
        end;
      end;
  end;
  AWYZFID := AWYZFXXRec.ZFID;
  AYWYH := AWYZFXXRec.YWYH;
  CdsTemp.Free;
end;

procedure TFormWYZF.LoadWYZFSHLXX(AZFID: string; ASHJD: Integer);
var
  CdsTemp: TClientDataSet;
  szSQL, szFlowSQL, szAuditSQL: string;
begin
  LabelSHR.Caption := '审核：';
  CdsTemp := DataModulePub.GetCds;
  szFlowSQL := 'select Flow.*, Node.Nodeseq, Node.Nodename'
    + ' from'
    + ' (select * from PUBWORKFLOW'
    + ' where GSDM=' + QuotedStr(GszGSDM)
    + ' and KJND=' + QuotedStr(GszKJND)
    + ' and ModName=''WYZF'' '
    + ' and BIZCODE=''WYZF'' '
    + ' and ISSTART=''是'') Flow'
    + ', (select * from PUBWFNODE'
    + ' where GSDM=' + QuotedStr(GszGSDM)
    + ' and KJND=' + QuotedStr(GszKJND)
    + ') Node'
    + ' where Flow.FlowCode = Node.FlowCode';

  szAuditSQL := 'select AuditorId, Auditor, Nodeseq, AType from PubAuditLog'
    + ' where GSDM=' + QuotedStr(GszGSDM)
    + ' and KJND=' + QuotedStr(GszKJND)
    + ' and ModName = ''WYZF'' '
    + ' and BillName=' + QuotedStr('网银支付')
    + ' and BillID=' + QuotedStr(AZFID)
    + ' and LogID in ('
    + ' select Max(LogID) from PubAuditLog '
    + ' where GSDM=' + QuotedStr(GszGSDM)
    + ' and KJND=' + QuotedStr(GszKJND)
    + ' and ModName = ''WYZF'' '
    + ' and BillName=' + QuotedStr('网银支付')
    + ' and BILLID = ' + QuotedStr(AZFID)
    + ' and AType = ''通过'' '
    + ' and Nodeseq <= ' + IntToStr(ASHJD)
    + ' Group by Nodeseq '
    + ')';
  szSQL := 'select FlowNode.*,AuditLog.AuditorId, AuditLog.Auditor'
    + ' from (' + szFlowSQL + ') FlowNode'
    + ' left join (' + szAuditSQL + ') AuditLog'
    + ' on AuditLog.Nodeseq = FlowNode.Nodeseq'
    //+ ' and FlowNode.Nodeseq <= ' + IntToStr(ASHJD)
  + ' order by FlowNode.Nodeseq ';

  POpenSql(CdsTemp, szSQL);
  if CdsTemp.RecordCount > 0 then
  begin
    CdsTemp.First;
    while not CdsTemp.Eof do
    begin
      if CdsTemp.FieldByName('Auditor').AsString <> '' then
        LabelSHR.Caption := LabelSHR.Caption + '   ' + CdsTemp.FieldByName('AuditorId').AsString
          + ' ' + CdsTemp.FieldByName('Auditor').AsString;
      CdsTemp.Next;
    end;
  end;
  CdsTemp.Free;
end;

procedure TFormWYZF.InitForm;
begin
  //Height := FormHeight - DJXXHeight;
  //if Trim(LabelYWLX.Caption)='现金支票' then PanelDJXX.Visible := False
  if currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '1' then
    PanelDJXX.Visible := False
  else
    PanelDJXX.Visible := true;
  SpeedItem_SSSH.Visible := bWYZFQYSHL;
  SpeedItem_CheckNew.Visible := bWYZFQYSHL;
  SpeedItem_Check.Visible := not bWYZFQYSHL;
  SpeedItem_Check.Visible := not bWYZFQYSHL;

  Label111.Visible := bWYZFQYSHL;
  Label222.Visible := not bWYZFQYSHL;
  LabelSHR.Visible := not bWYZFQYSHL;
end;

procedure TFormWYZF.UpdateWYZFXX(AZFID: string; CdsData: TClientDataSet);
var
  CdsTemp: TClientDataSet;
  szSQL: string;
begin
  CdsTemp := DataModulePub.GetCds;
  szSQL := 'select zfxx.*, '
    + '(case when zfxx.curshjd=0 then ''录入'' when zfxx.curshjd=-9 then ''送审'' else wfnd1.nodename end) as curshjdmc, '
    + '(case when zfxx.nextshjd=-1 then ''结束'' when zfxx.nextshjd=-9 then ''送审'' else wfnd2.nodename end) as nextshjdmc'
    + ', (case'
    + ' when djzt=-1 then ''作废'' '
    + ' when djzt=0 then ''未送审'' '
    + ' when djzt>=1 and djzt<=2 and not (curshjd = 999 and nextshjd = -1) then ''审核中'' '
    + ' when djzt=2 and (curshjd = 999 and nextshjd = -1) then ''已审核'' '
    + ' when djzt=''3'' then ''已执行'' '
    + ' when djzt=''3'' and zfzt = ''成功'' then ''已支付'' '
    + ' end) as djStatus'
    + ' from EBK_ZFXX zfxx'
    + ' left join ('
    + 'select wf.gsdm, wf.kjnd, wf.flowcode, nd.nodeseq, nd.nodename from pubworkflow wf '
    + ' left join pubwfnode nd on wf.gsdm = nd.gsdm and wf.kjnd = nd.kjnd '
    + ' and nd.flowcode = wf.flowcode '
    + ') wfnd1 '
    + ' on  wfnd1.gsdm = zfxx.gsdm'
    + ' and wfnd1.kjnd = zfxx.KJND'
    + ' and wfnd1.flowcode = zfxx.flowcode '
    + ' and wfnd1.nodeseq = zfxx.curshjd '
    + ' left join ('
    + 'select wf.gsdm, wf.kjnd, wf.flowcode, nd.nodeseq, nd.nodename from pubworkflow wf '
    + ' left join pubwfnode nd on wf.gsdm = nd.gsdm and wf.kjnd = nd.kjnd '
    + ' and nd.flowcode = wf.flowcode '
    + ') wfnd2 '
    + ' on  wfnd2.gsdm = zfxx.gsdm'
    + ' and wfnd2.kjnd = zfxx.KJND'
    + ' and wfnd2.flowcode = zfxx.flowcode'
    + ' and wfnd2.nodeseq = zfxx.nextshjd';
  szSQL := 'select * from (' + szSQL + ') yhzfxx '
    + ' where gsdm = ''' + GszGSDM + ''''
    + ' and ywlxdm = ''' + AYWLXDM + ''''
    + ' and zfid = ''' + AZFID + '''';

  POpenSql(CdsTemp, szSQL);
  if CdsTemp.RecordCount = 0 then
    Exit;

  ClearWYZFXX;
  with CdsTemp do
  begin
    if FieldByName('YWRQ').AsString <> '' then
      PSetPickerDate(DateYWRQ, FieldByName('YWRQ').AsString);
    //ComboBoxYWYH.Text := FieldByName('YWYH').AsString;
    ComboBoxYWYH.ItemIndex := ComboBoxYWYH.Items.IndexOf(FieldByName('YWYH').AsString);
    edtZFID.Text := FieldByName('ZFID').AsString;
    LabelYDJBH.Caption := '原单据编号：' + FieldByName('ydjbh').AsString; // Added by guozy 2013/3/31 星期日 16:42:16
    if FieldByName('MODCODE').AsString = 'GL' then
    begin
      LabelYDJBH.Caption := '原单据编号：' + GetPZH(FieldByName('ydjbh').AsString);
    end;
    LabelBANKUQNO.Caption := '银行唯一号：' + FieldByName('BANKUQNO').AsString;
    // Added by guozy 2013/4/18 星期四 8:45:40
    LabelBUSIUQNO.Caption := '原支付交易流水号：' + FieldByName('BUSIUQNO').AsString;
    // Added by guozy 2013/4/18 星期四 8:45:40
    LabelHEADBUSIUQNO.Caption := '主交易流水号：' + FieldByName('HEADBUSIUQNO').AsString;
    // Added by guozy 2013/4/18 星期四 8:45:40

    edtFKR.Text := FieldByName('FKFZH').AsString;
    edtFKRMC.Text := FieldByName('FKFMC').AsString;
    edtCLXX.Text := FieldByName('CLXX').AsString;
    edtZFXX.Text := FieldByName('ZFXX').AsString;
    edtYHZH.Text := FieldByName('FYHZH').AsString;
    edtZHMC.Text := FieldByName('FZHMC').AsString;
    edtKHYH.Text := FieldByName('FKHYH').AsString;
    edtYHHH.Text := FieldByName('FYHHH').AsString;
    edtYHHB.ItemIndex := edtYHHB.Items.IndexOf(FieldByName('FYHHB').AsString);
    edtKHDQ.Text := FieldByName('FKHDQ').AsString;
    edtYHWD.Text := FieldByName('FYHWD').AsString;
    edtJE.Text := FieldByName('JE').AsString;
    edtSKR.Text := FieldByName('SKFZH').AsString;
    edtSKRMC.Text := FieldByName('SKFMC').AsString;
    edtYHZH2.Text := FieldByName('SYHZH').AsString;
    edtZHMC2.Text := FieldByName('SZHMC').AsString;
    edtKHYH2.Text := FieldByName('SKHYH').AsString;
    edtYHHB2.Text := FieldByName('SYHHH').AsString + ' ' + FieldByName('SYHMC').AsString;
    getOthersFromSYHHH(FieldByName('SYHHH').AsString);
    edtKHDQ2.Text := FieldByName('SKHDQ').AsString;
    edtYHWD2.Text := FieldByName('SYHWD').AsString;
    edtZY.Text := FieldByName('ZY').AsString;

    LabelLRR.Caption := FieldByName('LRID').AsString + ' ' + FieldByName('LRR').AsString;
    if not bWYZFQYSHL then
    begin
      if FieldByName('DJZT').AsInteger >= 1 then
      begin
        if FieldByName('SHID1').AsInteger > 0 then
          LabelSHR1.Caption := FieldByName('SHID1').AsString + ' ' + FieldByName('SHR1').AsString;
      end;
      if FieldByName('DJZT').AsInteger >= 2 then
      begin
        if FieldByName('SHID2').AsInteger > 0 then
          LabelSHR2.Caption := FieldByName('SHID2').AsString + ' ' + FieldByName('SHR2').AsString;
      end;
      if FieldByName('DJZT').AsInteger = 3 then
      begin
        if FieldByName('ZXID').AsInteger > 0 then
          LabelZXR.Caption := FieldByName('ZXID').AsString + ' ' + FieldByName('ZXR').AsString;
      end;
    end;
    edtYDJBH.Text := FieldByName('YDJBH').AsString;
    edtYDJSJ.Text := FieldByName('YDJSJ').AsString;
    LabelZFSJ.Caption := FieldByName('ZFSJ').AsString;
    if CdsData.Locate('ywlxdm;zfid', VarArrayOf([AYWLXDM, AZFID]), []) then
    begin
      CdsData.Edit;
      CdsData.FieldByName('DJZT').AsInteger := FieldByName('DJZT').AsInteger;
      CdsData.FieldByName('djStatus').AsString := FieldByName('djStatus').AsString;
      CdsData.FieldByName('FlowCode').AsString := FieldByName('FlowCode').AsString;
      CdsData.FieldByName('CurSHJD').AsInteger := FieldByName('CurSHJD').AsInteger;
      CdsData.FieldByName('NextSHJD').AsInteger := FieldByName('NextSHJD').AsInteger;
      CdsData.FieldByName('CurSHJDMC').AsString := FieldByName('CurSHJDMC').AsString;
      CdsData.FieldByName('NextSHJDMC').AsString := FieldByName('NextSHJDMC').AsString;

      CdsData.FieldByName('SHID').AsInteger := FieldByName('SHID').AsInteger;
      CdsData.FieldByName('SHR').AsString := FieldByName('SHR').AsString;
      CdsData.FieldByName('SHSJ').AsString := FieldByName('SHSJ').AsString;
      CdsData.Post;
    end;
    //
    LoadWYZFRec(AZFID, CdsTemp);
    LoadWYZFSHLXX(AWYZFXXRec.ZFID, AWYZFXXRec.CurSHJD);
  end;
  AWYZFID := AWYZFXXRec.ZFID;
  AYWYH := AWYZFXXRec.YWYH;
  CdsTemp.Free;
end;

procedure TFormWYZF.SetFKF;
var
  VarTemp: Variant;
  szSQL: string;
  szZHDM, szZHMC, szYHZH, szTemp: string;
  iPos: Integer;
  szTJ: string;
begin
  szTemp := Trim(edtFKR.Text);
  if szTemp <> '' then
  begin
    szSQL := 'select yh.yhzh, yh.yhzhmc, yh.yhname, yh.yhhh, yh.yhaddr from  pubszdwzh yh'
      + ' where yh.gsdm = ''' + GszGSDM + ''''
      + ' and yh.YHBH = ''' + szTemp + '''';
    with DataModulePub.ClientDataSetTmp do
    begin
      Close;
      POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
      if FindFirst then
      begin
        edtYHZH.Text := FieldByName('yhzh').AsString;
        edtZHMC.Text := FieldByName('yhzhmc').AsString;
        edtKHYH.Text := FieldByName('yhname').AsString;
        edtYHHH.Text := FieldByName('yhhh').AsString;
        edtYHHB.Text := GetYHHB(FieldByName('yhname').AsString);
        edtKHDQ.Text := FieldByName('yhaddr').AsString;
        edtYHWD.Text := FieldByName('yhaddr').AsString;
      end;
      Close;
    end;
  end;
end;

procedure TFormWYZF.edtYHHB2ButtonClick(Sender: TObject);
var
  vSelect: Variant;
  vSQL: string;
  sDEPID: string;
  sAREACODE: string;
begin
  if CB_PROVINCE.Text = '' then
  begin
    SysMessage('省份不能为空！', AOther_JG, [mbOk]);
    if CB_PROVINCE.Enabled and CB_PROVINCE.Visible then
      CB_PROVINCE.SetFocus;
    Exit;
  end;
  if CB_CITY.Text = '' then
  begin
    SysMessage('城市不能为空！', AOther_JG, [mbOk]);
    if CB_CITY.Enabled and CB_CITY.Visible then
      CB_CITY.SetFocus;
    Exit;
  end;
  if CB_DEPID.Text = '' then
  begin
    SysMessage('银行不能为空！', AOther_JG, [mbOk]);
    if CB_DEPID.Enabled and CB_DEPID.Visible then
      CB_DEPID.SetFocus;
    Exit;
  end;
  sDEPID := Copy(CB_DEPID.Text, 1, Pos(' ', CB_DEPID.Text) - 1);
  sAREACODE := Copy(CB_CITY.Text, 1, Pos(' ', CB_CITY.Text) - 1);
  vSQL := 'Select BANK_CODE, BANK_NAME from EBK_BANKINFO where '
    + ' (DEPID=' + QuotedStr(Trim(sDEPID)) + ')'
    + ' and (AREACODE=' + QuotedStr(Trim(sAREACODE)) + ')'
    + ' and (BANK_CODE like ' + QuotedStr('%' + Trim(TString.LeftStrBySp(edtYHHB2.Text)) + '%')
    + ' or BANK_NAME like ' + QuotedStr('%' + trim(TString.LeftStrBySp(edtYHHB2.Text)) + '%') + ')';
  vSelect := SelectLst(vSQL, 'BANK_CODE, BANK_NAME');
  if VarIsArray(vSelect) then
  begin
    edtYHHB2.Text := vSelect[0][0] + ' ' + vSelect[0][1];
  end;
end;

procedure TFormWYZF.edtZHMC2ButtonClick(Sender: TObject);
var
  SelVar: Variant;
  szSQL: string;
begin
  SelVar := SelectLst('Select Distinct SKR from OER_DJML where (SKR<>'''' or SKR is not null) and GSDM='
    + QuotedStr(GszGSDM) + ' and (SKR like ' + QuotedStr('%' + edtZHMC2.Text + '%') + ')', 'SKR', False, '');
  if VarIsArray(SelVar) then
  begin
    edtZHMC2.Text := SelVar[0][0];
    if edtZHMC2.Text <> '' then
    begin
      szSQL := 'Select YHZH, KHYH from OER_DJML where GSDM=' + QuotedStr(GszGSDM)
        + ' and SKR=' + QuotedStr(edtZHMC2.Text) + ' and YHZH is not null and KHYH is not null '
        //取最近的一次帐号
      + ' order by DJDate Desc ';
      with ClientDataSetTmp do
      begin
        POpenSql(ClientDataSetTmp, szSQL);
        if RecordCount > 0 then
        begin
          edtKHYH2.Text := FieldByName('KHYH').AsString;
          edtYHZH2.Text := FieldByName('YHZH').AsString;
        end;
      end;
    end;
  end;
end;

function TFormWYZF.DJCheck: Boolean;
begin
  Result := False;
  //if (Trim(LabelYWLX.Caption) <> '现金支票') and (edtZHMC2.Text = '') then
  if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '0') and (edtZHMC2.Text = '') then
  begin
    SysMessage('账户名称不允许为空。', AOther_JG, [mbOk]);
    Exit;
  end;
  //if (Trim(LabelYWLX.Caption) <> '现金支票') and (edtYHZH2.Text = '') then
  if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '0') and (edtYHZH2.Text = '') then
  begin
    SysMessage('银行帐号不允许为空！', AOther_JG, [mbOk]);
    Exit;
  end
    //else if (Trim(LabelYWLX.Caption) <> '现金支票') and (Length(edtYHZH2.Text)<5) then
  else if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '0') and (Length(edtYHZH2.Text) < 5) then
  begin
    SysMessage('银行帐号太短，请检查！', AOther_JG, [mbOk]);
    Exit;
  end;

  //if (Trim(LabelYWLX.Caption) <> '现金支票') and (edtKHYH2.Text = '') then
  if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '0') and (edtKHYH2.Text = '') then
  begin
    SysMessage('开户银行不允许为空！', AOther_JG, [mbOk]);
    Exit;
  end
    //else if (Trim(LabelYWLX.Caption) <> '现金支票') and (Length(edtKHYH2.Text)<3) then
  else if (currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '0') and (Length(edtKHYH2.Text) < 3) then
  begin
    SysMessage('开户银行名称太短，请检查！', AOther_JG, [mbOk]);
    Exit;
  end;
  //if Trim(LabelYWLX.Caption) <> '现金支票' then begin
  if currJSFSIsXJZP(ComboBoxYWLX.ItemIndex) = '0' then
  begin
    if edtYHHB2.Text = '' then
    begin
      SysMessage('收款银行行号不允许为空！', AOther_JG, [mbOk]);
      Exit;
    end
    else if Pos(' ', edtYHHB2.Text) < 0 then
    begin
      SysMessage('收款银行行号不合法，请重新选择！', AOther_JG, [mbOk]);
      Exit;
    end;
  end;
  Result := True;
end;

function TFormWYZF.GetSQL: string;
begin
  Result := 'Select KJND 年度, YWRQ 业务日期, ZFID 支付单号, YDJBH 原始单据号, BUSIUQNO 支付流水号,'
    + 'FKFZH 付方账户,FKFMC 付方名称,FYHZH 付方银行账号,FZHMC 付方账户名称,'
    + 'FKHYH 付方开户银行,FYHHH 付方银行行号, FKHDQ 付方开户地区, '
    + 'SKFZH 收方账户, SKFMC 收方名称,  '
    + 'SYHZH 收方银行账号, SZHMC 收方账户名称, SKHYH 收方开户银行, '
    + 'SYHHH 收方银行行号, SYHHB 收方银行行别, SKHDQ 收方开户地区, '
    + 'ZY 摘要, JE 付款金额, TCBZ 同城标志, SHID1 审核1,'
    + 'SHID2 审核2, DJZT 单据状态, SLZT 受理状态, ZFZT 支付状态, '
    + 'LRID 录入ID, LRR 录入人, LRR 录入时间'
    + ' from EBK_ZFXX where ZFID=' + QuotedStr(AWYZFID);
end;

function GetServerHost: string;
var
  szTemp: string;
begin
  Result := '';
  szTemp := GszServerComputer;
  szTemp := Copy(szTemp, 8, Length(szTemp) - 7);
  if Pos(':', szTemp) > 0 then
  begin
    Result := Copy(szTemp, 1, Pos(':', szTemp) - 1);
  end;
end;

function GetServerPort: string;
var
  szTemp: string;
begin
  Result := '';
  szTemp := GszServerComputer;
  szTemp := Copy(szTemp, 8, Length(szTemp) - 7);
  if Pos(':', szTemp) > 0 then
  begin
    szTemp := Copy(szTemp, Pos(':', szTemp) + 1, Length(szTemp));
    if Pos('/', szTemp) > 0 then
    begin
      Result := Copy(szTemp, 1, Pos('/', szTemp) - 1);
    end
    else
      Result := szTemp;
  end;
end;

procedure TFormWYZF.MPrintSetupClick(Sender: TObject);
var
  PrintObj: OleVariant;
begin
  try
    PrintObj := CreateOleObject('PrintOCX.UFPrintCTL');
    PrintObj.InitConn('CONTYPE=HTTP&HOST=' + GetServerHost + '&PORT=' + GetServerPort);
    PrintObj.AddParams('DBTYPE', IFF(GDbType = MSSQL, 'MSSQL', 'ORACLE'));
    PrintObj.AddParams('MOD', 'EBK');
    PrintObj.AddParams('USERNAME', GCzy.name);
    PrintObj.PrintDesign('ZFD', GetSQL);
  except
    SysMessage('操作失败，请重试。', '_JG', [mbOK]);
  end;
end;

procedure TFormWYZF.Print;
var
  PrintObj: OleVariant;
begin
  try
    PrintObj := CreateOleObject('PrintOCX.UFPrintCTL');
    PrintObj.InitConn('CONTYPE=HTTP&HOST=' + GetServerHost + '&PORT=' + GetServerPort);
    PrintObj.AddParams('DBTYPE', IFF(GDbType = MSSQL, 'MSSQL', 'ORACLE'));
    PrintObj.AddParams('MOD', 'EBK');
    PrintObj.AddParams('USERNAME', GCzy.name);
    PrintObj.Print('ZFD', GetSQL);
  except
    SysMessage('操作失败，请重试。', '_JG', [mbOK]);
  end;
end;

procedure TFormWYZF.MPrintClick(Sender: TObject);
begin
  Print;
end;

procedure TFormWYZF.SpeedItem_PrintClick(Sender: TObject);
begin
  Print;
end;

procedure TFormWYZF.getOthersFromSYHHH(SYHHH: string);
var
  szSql: string;
  sCurrDepid, sCurrAreaCode: string;
  sProvinceID: string;
  i: integer;
begin
  initProvince;
  szSQL := 'select * from EBK_BANKINFO where BANK_CODE=''' + SYHHH + ''' order by bank_code ';
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
    begin
      sCurrDepid := FieldByName('Depid').AsString;
      sCurrAreaCode := FieldByName('AreaCode').AsString;
    end;
    Close;
  end;
  szSQL := 'select * from EBK_AREACODE where AREACODE=''' + sCurrAreaCode + '''';
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
    begin
      sProvinceID := Trim(FieldByName('PROVID').AsString);
    end;
    Close;
  end;
  //CB_PROVINCE.ItemIndex := CB_PROVINCE.Items.IndexOf(sProvince);
  for i := 0 to CB_PROVINCE.Items.Count - 1 do
  begin
    if sProvinceID = TString.LeftStrBySp(CB_PROVINCE.Items.Strings[i]) then
    begin
      CB_PROVINCE.ItemIndex := i;
      Break;
    end;
  end;

  initCity;
  for i := 0 to CB_CITY.Items.Count - 1 do
  begin
    if sCurrAreaCode = TString.LeftStrBySp(CB_CITY.Items.Strings[i]) then
    begin
      CB_CITY.ItemIndex := i;
      Break;
    end;
  end;
  initDepID;
  for i := 0 to CB_DEPID.Items.Count - 1 do
  begin
    if sCurrDepid = TString.LeftStrBySp(CB_DEPID.Items.Strings[i]) then
    begin
      CB_DEPID.ItemIndex := i;
      Break;
    end;
  end;

end;

procedure TFormWYZF.initProvince;
var
  szSql: string;
begin
  CB_PROVINCE.Items.Clear;
  szSQL := 'select * from ebk_province order by provid ';
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
    begin
      while not Eof do
      begin
        CB_PROVINCE.Items.Add(FieldByName('provid').AsString + ' ' + FieldByName('PROVINCE').AsString);
        Next;
      end;
    end;
    Close;
  end;
end;

procedure TFormWYZF.initCity;
var
  szSql: string;
begin
  if CB_PROVINCE.ItemIndex = -1 then
    exit;
  CB_CITY.Items.Clear;
  szSQL := 'select AREACODE, AREA_NAME from EBK_AREACODE where PROVID = ' +
    QuotedStr(Trim(TString.LeftStrBySp(CB_PROVINCE.Text))) + ' order by areacode';
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
    begin
      while not Eof do
      begin
        CB_CITY.Items.Add(FieldByName('AREACODE').AsString + ' ' + FieldByName('AREA_NAME').AsString);
        Next;
      end;
      //CB_CITY.ItemIndex := CB_CITY.Items.IndexOf('1930 乌海市');
    end;
    Close;
  end;
end;

procedure TFormWYZF.initDepID;
var
  szSql: string;
begin
  //if CB_PROVINCE.ItemIndex = -1 then exit;
  //if CB_CITY.ItemIndex = -1 then exit;
  CB_DEPID.Items.Clear;
  szSQL := 'select DEPID, DEP_NAME from EBK_DEPID order by depid ';
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
    begin
      while not Eof do
      begin
        CB_DEPID.Items.Add(FieldByName('DEPID').AsString + ' ' + FieldByName('DEP_NAME').AsString);
        Next;
      end;
    end;
    Close;
  end;
end;

procedure TFormWYZF.CB_PROVINCEChange(Sender: TObject);
begin
  CB_CITY.Items.Clear;
  CB_CITY.ItemIndex := -1;
  CB_DEPID.ItemIndex := -1;
  edtYHHB2.Text := '';
  initCity;
end;

procedure TFormWYZF.CB_CITYChange(Sender: TObject);
begin
  CB_DEPID.ItemIndex := -1;
  edtYHHB2.Text := '';
end;

procedure TFormWYZF.CB_DEPIDChange(Sender: TObject);
var
  szSQL: string;
begin
  edtYHHB2.Text := '';
  szSQL := 'Select BANK_CODE, BANK_NAME from EBK_BANKINFO where '
    + ' (DEPID=' + QuotedStr(Trim(TString.LeftStrBySp(CB_DEPID.Text))) + ')'
    + ' and (AREACODE=' + QuotedStr(Trim(TString.LeftStrBySp(CB_CITY.Text))) + ')';
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
    begin
      if recordcount = 1 then
      begin
        edtYHHB2.Text := FieldByName('BANK_CODE').AsString + ' ' + FieldByName('BANK_NAME').AsString
      end;
    end;
    Close;
  end;

end;

procedure TFormWYZF.SaveNewYHHH(SYhhhAndName: string);
var
  szSQL: string;
  sCurrDepID: string;
  sCurrAreaCode: string;
  sCurrBankCode, sCurrBankName: string;
begin
  edtYHHB2.Text := '';
  szSQL := 'Select BANK_CODE, BANK_NAME from EBK_BANKINFO where '
    + ' BANK_CODE =' + QuotedStr(Trim(TString.LeftStrBySp(SYhhhAndName)));
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
    begin
      Close;
      exit;
    end;
    Close;
  end;
  sCurrDepID := Trim(TString.LeftStrBySp(CB_DEPID.Text));
  sCurrAreaCode := Trim(TString.LeftStrBySp(CB_CITY.Text));
  sCurrBankCode := Trim(TString.LeftStrBySp(SYhhhAndName));
  sCurrBankName := Trim(TString.RightStrBySp(SYhhhAndName));
  if (sCurrBankCode = '') then
  begin
    exit;
  end;
  try
    szSQL := ' INSERT INTO EBK_BANKINFO(DEPID,AREACODE,BANK_CODE, BANK_NAME) '
      + ' values(' + QuotedStr(sCurrDepID) + ','
      + QuotedStr(sCurrAreaCode) + ','
      + QuotedStr(sCurrBankCode) + ','
      + QuotedStr(sCurrBankName) + ')';
    PExecSQL(szSQL);
  except
    on e: Exception do
    begin
      SysMessage('保存失败。' + e.Message, AOther_JG, [mbOK]);
    end;
  end;

end;

procedure TFormWYZF.ComboBoxYWLXChange(Sender: TObject);
begin
  AYWLXDM := getJSFSDM(ComboBoxYWLX.ItemIndex);
end;

procedure TFormWYZF.M_CXZXClick(Sender: TObject);
begin
  if not TPower.GetPower(GN_WYZF_ZX) then
  begin
    SysMessage('没有执行权限。', AOther_JG, [mbOk]);
    Exit;
  end;
  cdsGroup.First;
  while not cdsGroup.eof do
  begin
    if cdsGroup.FieldByName('SLZT').AsString = '受理成功' then
    begin
      SysMessage('单据已经受理成功，不允许取消执行。', AOther_JG, [mbOk]);
      Exit;
    end
    else if cdsGroup.FieldByName('SLZT').AsString = '支付成功' then
    begin
      SysMessage('单据已经支付成功，不允许取消执行。', AOther_JG, [mbOk]);
      Exit;
    end;
    cdsGroup.Next;
  end;
  //重新执行
  if (AWYZFXXRec.ZFZT <> '支付失败') then
  begin
    if AWYZFXXRec.ZFZT = '支付成功' then
    begin
      SysMessage('单据已经支付成功，不允许重新执行。', AOther_JG, [mbOk]);
      Exit;
    end;
    if AWYZFXXRec.SLZT = '受理成功' then
    begin
      SysMessage('单据已经受理成功，不允许重新执行。', AOther_JG, [mbOk]);
      Exit;
    end;
  end;
  if AWYZFXXRec.DJZT = 3 then
  begin
    if DoWYZFZX(AWYZFID, 3, AWYZFXXRec.GROUPID, -1, '', '', true) then
    begin
      PWriteYHCzrz('重新执行：' + AYWLXDM + '-' + AWYZFID);
      FormWYZFNotePad.SpeedItem_RefreshClick(nil);
      LoadWYZFXX(AWYZFID, getJSFSDM(ComboBoxYWLX.ItemIndex), ClientDataSetWYZF);
      SetDJStatus;
      WYZFOper := OpBrowse;
    end;
  end;
end;

//赋初始值  ADD BY GENGZHUO 20130926

procedure TFormWYZF.initValue;
var
  szSql: string;
begin
  edtFKRMC.Text := GszHSDWMC;
  edtZHMC.Text := TString.RightStrBySp(ReadParams('FKR'));
  edtYHZH.Text := ReadParams('MRZH');
  szSQL := 'select YHNAME,YHHH from PUBSZDWZH where YHZH = ''' + ReadParams('MRZH') + '''';
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
    begin
      while not Eof do
      begin
        edtKHYH.Text := FieldByName('YHNAME').AsString;
        edtYHHH.Text := FieldByName('YHHH').AsString;
        Next;
      end;
    end;
    Close;
  end;
end;

//校验付款账户是否存在  ADD BY GENGZHUO 20130926

function TFormWYZF.CheckZH(YHZF: string): Boolean;
var
  szSql: string;
begin
  Result := True;
  szSQL := 'select YHZHMC from PUBSZDWZH where YHZH = ''' + YHZF + '''';
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSQL(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
    begin
      while not Eof do
      begin
        Result := False;
        Next;
      end;
    end;
    Close;
  end;
end;

//引入生成加密文件的函数  ADD BY GENGZHUO 20130926
//function EncodeString(Text: Pchar):PChar;stdcall;External 'SPS.dll';

//MD5字段存入 ADD BY GENGZHUO 20130926

function TFormWYZF.CheckUKey: Boolean;
begin
  Result := false;
end;

function TFormWYZF.GetPZH(AIDPZH: string): string;
var
  sIDPZH: string;
begin
  sIDPZH := TString.LeftStrBySp(AIDPZH, '#');
  with DataModulePub.GetCdsBySQL('Select PZH, PZRQ from GL_PZML where IDPZH=' + QuotedStr(sIDPZH)) do
  begin
    if RecordCount > 0 then
      Result := FieldByName('PZRQ').AsString + '_' + FieldByName('PZH').AsString;
    Free;
  end;
end;

procedure TFormWYZF.btnNewZFClick(Sender: TObject);
var
  IsHave: Boolean;
  szZfId, sGroupID: string;

begin
  //支付失败后， 重新生成新单进行支付
  cdsGroup.First;
  IsHave := False;
  while not cdsGroup.eof do
  begin
    if (cdsGroup.FieldByName('SLZT').AsString = '受理失败')
      or (cdsGroup.FieldByName('SLZT').AsString = '受理状态不明') then
    begin
      IsHave := True;
      break;
    end;
    if cdsGroup.FieldByName('ZFZT').AsString = '支付失败' then
    begin
      IsHave := True;
      break;
    end;
    cdsGroup.Next;
  end;
  if not IsHave then
  begin
    SysMessage('不存在支付失败的数据，不允许再次生成支付单！', AOther_JG, [mbOK]);
    Exit;
  end;
  //
  //cdsZFD
  POpenSQL(cdsZFD, 'Select * from EBK_ZFXX where 1=0');
  cdsGroup.First;
  IsHave := False;
  sGroupID := GetGuid;
  szZfId := getNewLSH(AGSDM, AYWND, '');
  //重新取得支付ID
  while not cdsGroup.eof do
  begin
    if (cdsGroup.FieldByName('SLZT').AsString = '受理失败')
      or (cdsGroup.FieldByName('SLZT').AsString = '受理状态不明')
      or (cdsGroup.FieldByName('ZFZT').AsString = '支付失败') then
    begin
      cdsZFD.Append;
      copyCds(cdsGroup, cdsZFD);
      cdsZFD.FieldByName('GroupID').AsString := sGroupID;
      cdsZFD.FieldByName('ZFID').AsString := szZfId;
      szZfId := FloatToStr(StrToFloat(szZfId) + 1);
      cdsZFD.FieldByName('LRID').AsString := IntToStr(GCzy.ID);
      cdsZFD.FieldByName('LRR').AsString := GCzy.name;
      cdsZFD.FieldByName('LRSJ').AsString := FormatDateTime('YYYY-MM-DD HH:NN:SS', Now);
      cdsZFD.FieldByName('NewPackageID').AsString := '';
      cdsZFD.Post;
    end;
    cdsGroup.Next;
  end;
  cdsZFD.ApplyUpdates(-1, 'EBK_ZFXX');
  PExecSQL('Update EBK_ZFXX set ZFZT=NULL, SLZT=NULL, DJZT=0, SHID=NULL, SHR=NULL, SHSJ=NULL, '
    + 'ZXID=NULL, ZXR=NULL, ZXSJ=NULL, CLSJ=NULL, BUSIUQNO=NULL, ZFSJ=NULL, FLOWCODE=NULL, '
    + 'CurSHJD=0, NextSHJD=-9 where GROUPID=' + QuotedStr(sGroupID));
  cdsZFD.First;
  LoadWYZFXX(cdsZFD.FieldByName('ZFID').AsString, cdsZFD.FieldByName('YWLXDM').AsString, nil);
end;

procedure TFormWYZF.tsStateChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  vFilter:String;
begin
  if not cdsGroup.Active then Exit;
  case NewTab of
    0:vFilter := '';
    1:vFilter := 'ZFZT=''支付成功''';
    2:vFilter := 'SLZT=''受理成功'' and ZFZT<>''支付成功''';
  end;
  cdsGroup.Filter := vFilter;
  cdsGroup.Filtered := True;
end;

end.

