unit GBI_TZD;

interface

uses
  Windows, Messages, SysUtils, Variants,Classes, Graphics, Controls, Forms, Dialogs,
  RxCalc, Tgrids2, ExtCtrls, Mask, SMaskEdit, Spin, ComCtrls, StdCtrls,
  THExtCtrls, RXCtrls, Menus, ImgList, SpeedBar, Pub_Power, Pub_Message, PublicGBI,
  Pub_YS, DBClient, DataModuleMain, Pub_Global, Pub_Function, ListSelectDM,
  ActnList, Db, ListSelectYSBZ, SPrint2, FormPrint, THDBGrids, Placemnt, THComCtrls,
  HFExpandPrint, uBAS_BaseImport, Buttons;

type
  TZBTZRec = class
    ZBID:Integer;
    SJZBID:Integer;
    TZJE:Extended;
  end;
  TZBTZList = class(TList)
    procedure AddRec(AZBTZRec:TZBTZRec);
    function GetTZJE(ASJZBID:Integer):Extended;
  end;

  //ly add ZWR900180682  ���ӷ�¼�����˹���
  TGBI_TZD_FL_JE_QUERY = class
  public
    IsEnabled: Boolean;    //�Ƿ����÷�¼��ѯ��
    StartJE:   Extended;   //��ʼ���
    EnabledEndJE: Boolean; //�Ƿ����ý�ֹ���
    EndJE:     Extended;   //��ֹ���
    constructor Create;    //����
  end;
  
  
  //���롢����
  TTZD_Imp = class(TImport)
    FCdsSQB:TClientDataSet;
  private
    FGrid: TTHStringGrid;
    FZBLB: TZBLB;
    //��ȡ��һ�������
    function GetFirstOperRow: Integer;
    function GetYLField: string;
    //��ȡָ��ID�б�
    function GetZBIDList: string;
    //�Ƿ�������
    function HasData: Boolean;
    //��ȡָ�����
    function GetZBDM: TClientDataSet;
    //��ȡZBLB
    function GetZBLB: string;
  public
    constructor Create(AGrid: TTHStringGrid; AZBLB: TZBLB);
    function Check: Boolean; override;
    function Save: Boolean; override;
  published
    property Grid: TTHStringGrid read FGrid write FGrid;
    property ZBLB: TZBLB read FZBLB write FZBLB;
  end;
  
  
  TFormNoteItemTZ = class(TForm)
    SpeedBarXJSFPad: TSpeedBar;
    SpeedbarSection5: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection4: TSpeedbarSection;
    SpeedItemNew: TSpeedItem;
    SpeedItemSave: TSpeedItem;
    SpeedItemAudit: TSpeedItem;
    SpeedItemPreview: TSpeedItem;
    SpeedItemPrint: TSpeedItem;
    SpeedItemFirst: TSpeedItem;
    SpeedItemPrior: TSpeedItem;
    SpeedItemNext: TSpeedItem;
    SpeedItemLast: TSpeedItem;
    SpeedItemHelp: TSpeedItem;
    SpeedItemExit: TSpeedItem;
    ImageList1: TImageList;
    MainMenuPz: TMainMenu;
    FileMenu: TMenuItem;
    NPreview: TMenuItem;
    NPrint: TMenuItem;
    MExit: TMenuItem;
    EditMenu: TMenuItem;
    NNew: TMenuItem;
    NSave: TMenuItem;
    N1: TMenuItem;
    NAudit: TMenuItem;
    NUnAudit: TMenuItem;
    N5: TMenuItem;
    NZF: TMenuItem;
    NHY: TMenuItem;
    NDelete: TMenuItem;
    SrchMenu: TMenuItem;
    NFirst: TMenuItem;
    NPrior: TMenuItem;
    NNext: TMenuItem;
    NLast: TMenuItem;
    PanelClient: TPanel;
    RxLabelTitle: TRxLabel;
    THBevelZX: TTHBevel;
    PanelTop: TPanel;
    lblTZDH: TLabel;
    lblBZ: TLabel;
    lblTZRQ: TLabel;
    LabelSFSZYW: TLabel;
    lblFJS: TLabel;
    EditTZDH: TEdit;
    EditBZ: TEdit;
    DTPTZRQ: TDateTimePicker;
    seFJZS: TSpinEdit;
    PanelBottom: TPanel;
    LabelZD: TLabel;
    LabelSH: TLabel;
    LabelJZXM: TLabel;
    LabelSHXM: TLabel;
    LabelZDXM: TLabel;
    LabelPzxm: TLabel;
    PanelLeftSide: TPanel;
    PanelRightSide: TPanel;
    pnlMain: TPanel;
    Shape4: TTHBevel;
    Shape2: TTHBevel;
    Panel1: TPanel;
    THBevelUpLine: TTHBevel;
    THBevelBottomLine: TTHBevel;
    SpeedItem1: TSpeedItem;
    SpeedItem2: TSpeedItem;
    SpeedItem4: TSpeedItem;
    SpeedItem5: TSpeedItem;
    Panel2: TPanel;
    Label4: TLabel;
    pnlSub: TPanel;
    THStringGridTZDNR: TTHStringGrid;
    PanelHJ: TPanel;
    LabelSRHJ: TLabel;
    LabelZCHJ: TLabel;
    BevelDf: TBevel;
    BevelJf: TBevel;
    BevelHj: TBevel;
    Bevel1: TBevel;
    Label_DX: TLabel;
    LabelDX: TLabel;
    LabelHJJE: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ActionList: TActionList;
    actClose: TAction;
    actSave: TAction;
    N2: TMenuItem;
    actNew: TAction;
    actPreview: TAction;
    actPrint: TAction;
    actCheck: TAction;
    actUnCheck: TAction;
    lblTZDID: TLabel;
    edtTZDID: TEdit;
    actFirst: TAction;
    actPrious: TAction;
    actRubbit: TAction;
    actHY: TAction;
    actCancel: TAction;
    actNext: TAction;
    actLast: TAction;
    SIDelete: TSpeedItem;
    actDelete: TAction;
    PopupMenu: TPopupMenu;
    NAdd: TMenuItem;
    MenuItem1: TMenuItem;
    N7: TMenuItem;
    NCopy: TMenuItem;
    actHelp: TAction;
    N3: TMenuItem;
    SpeedItem3: TSpeedItem;
    actEdit: TAction;
    SpeedItem6: TSpeedItem;
    actAnnex: TAction;
    SIPL: TSpeedItem;
    actMultiSelect: TAction;
    FormPrint: TFormPrint;
    cdsTmp: TClientDataSet;
    lblSQR: TLabel;
    edtSQR: TSMaskEdit;
    Bevel2: TBevel;
    NprintNew: TMenuItem;
    NprintOld: TMenuItem;
    FormStorage1: TFormStorage;
    N4: TMenuItem;
    N6: TMenuItem;
    actFLJE: TAction;
    NInsert: TMenuItem;
    HFExpandPrintData: THFExpandPrint;
    FormPrintDataOut: TFormPrint;
    NDataOut: TMenuItem;
    SpeedItem7: TSpeedItem;
    actInput: TAction;
    actZero: TAction;
    N01: TMenuItem;
    N02: TMenuItem;
    btnRowAdd: TSpeedButton;
    btnRowDel: TSpeedButton;
    miZeroClear: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure THStringGridTZDNRLoadButtonClick(Sender: TObject);
    procedure THStringGridTZDNRKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actSaveExecute(Sender: TObject);
    procedure actPreviewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actCheckExecute(Sender: TObject);
    procedure actUnCheckExecute(Sender: TObject);
    procedure actRubbitExecute(Sender: TObject);
    procedure actHYExecute(Sender: TObject);
    procedure actFirstExecute(Sender: TObject);
    procedure actPriousExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actLastExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure THStringGridTZDNRSetEditText(Sender: TObject; ACol,ARow: Integer; const Value: String);
    procedure NAddClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure NCopyClick(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure EditTZDHKeyPress(Sender: TObject; var Key: Char);
    procedure NPrintClick(Sender: TObject);
    procedure actAnnexExecute(Sender: TObject);
    procedure actMultiSelectExecute(Sender: TObject);
    procedure FormPrintBeforePrintItems(Sender: TObject);
    procedure edtSQRButtonClick(Sender: TObject);
    procedure edtSQRExit(Sender: TObject);
    procedure NprintNewClick(Sender: TObject);
    procedure edtSQRKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditBZKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NprintOldClick(Sender: TObject);
    procedure actFLJEExecute(Sender: TObject);
    procedure THStringGridTZDNRDrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect; State: TGridDrawState);
    procedure NInsertClick(Sender: TObject);
    procedure NDataOutClick(Sender: TObject);
    procedure actInputExecute(Sender: TObject);
    procedure actZeroExecute(Sender: TObject);
    procedure miZeroClearClick(Sender: TObject);
  private
    FLJEQuery: TGBI_TZD_FL_JE_QUERY;
    AnnexData: OleVariant;//����������   һ������һ����¼
    FZBLB: TZBLB;
    FZBLBStr: String;
    FYSFADM: String;
    GYSFA : TYSFA;
    FDataStatus: TDataOperStatusExtend;
    TZDOper:String;
    procedure GetNrData(ATZDID: Integer);           //ͨ��Ŀ¼ID��ȡ��ϸ
    function DataCheck: Boolean;                    //���ݼ��
    procedure CalcTZHZB;
    procedure ClearData;
    procedure GetRecPos(vRecPos: TDataRecPos);
    procedure DoData;
    procedure ChangeZBYS(AIndex: Integer; var ASQL: string);   //AIndex=1 ���    AIndex=-1 ����
    procedure DoPrintSet;
    procedure DoFormPrintSet;


    function ZBDataCheck: Boolean;
    procedure SetZBLB(const Value: TZBLB);
    procedure SetDataStatus(const Value: TDataOperStatusExtend);
    procedure GetZBKYJE(AZBID: String; var AKYJE, ASJKYJE: Extended);
    procedure GetSJZBKYJE(AZBID: String; var AKYJE: Extended);
    function GetSJZBID(AZBID, AZBLB: String):String;
    procedure InitGrid;
    //��¼��λ
    procedure LocateFLJE;
    //����ϼ�
    procedure ShowDynHJ;
	function GetDJMLNRSQL(AZBLB: string; ATZDID:Integer):String;
    function HasSetZDYBB(const aPrintSign: string): Boolean;   //�Ƿ��������Զ��屨���ʽ
  public
    TZDMLCDS, TZDNRCDS: TClientDataSet;
    vZGDWDM: string;
    //�����ʹ�õ�ָ���Ƿ����ʹ��Ҫ��
    //AZT ֻ����ˣ����󼴿�   ������������ĿǰҲֻ���������漰��ָ��仯��״̬
    function GetUsedZBStatus(ATHGrid: TTHStringGrid; AYWRQ:string; var AAllowOper:Boolean): TStringList;
    procedure InitForm(AID: Integer=0);

    procedure GetData(AID: Integer);                //��ȡ������
    procedure PutData;                              //�����ݸ�ֵ��������
    property ZBLB: TZBLB read FZBLB write SetZBLB;
    property YSFADM: String read FYSFADM write FYSFADM;
    property DataStatus: TDataOperStatusExtend read FDataStatus write SetDataStatus;
    function DoCheckZBYE(var vErrorZB: String):Boolean;
  end;

var
  FormNoteItemTZ: TFormNoteItemTZ;
  function LoadNoteItemTZ(AID: Integer=0): Boolean;

implementation

uses GBI_DJFJ, StrUtils,GBI_ListSelectYSZBF, uFileDataCache, uSelectGBS, GBI_FLJE,
  Math, FZXTJ;

{$R *.DFM}

function LoadNoteItemTZ(AID: Integer=0): Boolean;
var
  i: integer;
begin
  Result := False;

  with Application.MainForm do
  begin
    // ����Զ��帨�������Ѵ򿪣�����ô��ڣ������ȴ�������ʾ
    i:=0; //��ظ���ֵ
    if MDIChildCount>0 then    
    for i := 0 to MDIChildCount - 1 do
      if uppercase(MDIChildren[i].name) = UpperCase('FormNoteItemTZ') then
      begin
        MDIChildren[i].BringToFront;
        break;
      end;

    if i >= MDIChildCount then
    begin
      if GszDwysYearJzBz = '1' then
        Application.MessageBox(PChar('�Ѿ���ת����ֻ������ѯ����ز������������κα༭������'), PChar('��ʾ'), MB_ICONINFORMATION+MB_OK);

      Application.CreateForm(TFormNoteItemTZ, FormNoteItemTZ);
      FormNoteItemTZ.InitForm(AID);
      FormNoteItemTZ.Show;
    end
    else
    begin
      if MDIChildren[i].WindowState = wsMinimized then
      begin
        MDIChildren[i].WindowState := wsNormal;
        MDIChildren[i].SetFocus;
      end;
    end;
  end;

  Result := True;
end;

{ TFormNoteItemTZ }
procedure TFormNoteItemTZ.FormCreate(Sender: TObject);
begin
  FLJEQuery := TGBI_TZD_FL_JE_QUERY.Create;

  TZDMLCDS := TClientDataSet.Create(nil);
  TZDNRCDS := TClientDataSet.Create(nil);

  DTPTZRQ.Date :=  StrToDate(
                              Copy(GszYWRQ, 1, 4)
                              + DateSeparator + Copy(GszYWRQ, 5, 2)
                              + DateSeparator + Copy(GszYWRQ, 7, 2)
                            );

  GYSFA := TYSFA.Create;
  // Added by Cheyf 2014-10-23
  vZGDWDM := DataModulePub.GetFldRecord('select GSDM from GBI_ZTCS where GSDM in(select GSDM from PubModSetup '
      + 'where IsStart=''1'' and ModName=''GBI'') and KJND='+QuotedStr(GszKJND)+' '
      + 'and CSDM=''BBLX'' and CSZ=''0''','');
end;


procedure TFormNoteItemTZ.InitForm(AID: Integer=0);
begin
  AnnexData := Null;

  InitGrid;
  THStringGridTZDNR.LoadFormat('');
  GetData(AID);
  PutData;

  DataStatus := doseBrowse;

  //�����µ�
  if GszDwysYearJzBz = '0' then
    if AID=0 then
      if ((FZBLB=zlZZB) and (TPower.GetPower('62037')))
         or ((FZBLB=zlDWZB) and (TPower.GetPower('62029')))
         or ((FZBLB=zlMXZB) and (TPower.GetPower('62021'))) then
        actNewExecute(actNew);
end;

procedure TFormNoteItemTZ.FormShow(Sender: TObject);
var
ss:string;
begin
  Bevel1.Width  := PanelHJ.Width+10;
  BevelHj.Width := PanelHJ.Width+10;
  SetComponentsColor(Self);
                          ss :=  FormStorage1.ReadString('Nprint.checked', '0');
  NprintOld.Checked := strtobool(FormStorage1.ReadString('Nprint.checked', '1'));
  Nprintnew.Checked := not  NprintOld.Checked ;

  edtSQR.SetFocus ;
end;

procedure TFormNoteItemTZ.FormDestroy(Sender: TObject);
begin
  TZDMLCDS.Free;
  TZDNRCDS.Free;
  GYSFA.Free;
  FLJEQuery.Free;
end;

procedure TFormNoteItemTZ.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormNoteItemTZ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormStorage1.WriteString('Nprint.checked', boolToStr(NprintOld.Checked ));   //ZWR900182080 huangyh 2014-6-5  

  if (DataStatus = doseInsert) or (DataStatus = doseUpdate) then
  begin
    case Application.MessageBox(PChar('������δ���棬��Ҫ������'), PChar('��ʾ'), MB_ICONQUESTION + MB_YESNOCANCEL + MB_DEFBUTTON1) of
    IDYES:
      begin
        actSaveExecute(actSave);
        Action := caNone;
        Exit;
      end;
    IDCANCEL:
      begin
        Action := caNone;
        Exit;
      end;
    end;
  end;
  Action := caFree;
end;

procedure TFormNoteItemTZ.ClearData;
begin
  DTPTZRQ.Date :=  StrToDate(
                              Copy(GszYWRQ, 1, 4)
                              + DateSeparator + Copy(GszYWRQ, 5, 2)
                              + DateSeparator + Copy(GszYWRQ, 7, 2)
                            );
  seFJZS.Value := 1;
  EditTZDH.Text := '';
  edtTZDID.Text := '';
  EditBZ.Text := '';
  edtSQR.Text := '';

  THStringGridTZDNR.RowCount := 2;
  THStringGridTZDNR.Rows[1].Clear;

  LabelDX.Caption := '������������������������������������������������������';
  LabelSRHJ.Caption := '0.00';
  LabelZCHJ.Caption := '0.00';

  LabelZDXM.Caption := '';
  LabelSHXM.Caption := '';

  AnnexData := null;
end;

function TFormNoteItemTZ.DataCheck: Boolean;
var
  i: Integer;
  vCode: string;
  HasSR, HasZC: Boolean;
  SRValue, ZCValue: Extended;
  tmpSRValue, tmpZCValue, tmpKYValue,tmpSJKYValue,tmpKYTZHValue: Extended;
  tmpZY: string;
  vSum : Integer;
  vSQL:string;
  AZBTZList:TZBTZList;
  AZBTZRec:TZBTZRec;
  vZBID:Integer;
begin
  Result := False;

  if edtSQR.Text = '' then
  begin
    Application.MessageBox(PChar('��ѡ�������ˣ�'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
    if edtSQR.CanFocus then
      edtSQR.SetFocus;
    Exit;
  end;

  if not GblZDBZTZDH then   //�ֶ�
  begin
    if Length(EditTZDH.Text) <> GiTZDHMRCD then
    begin
      Application.MessageBox(PChar('�������ŵ��ֶ�����λ��Ϊ' + IntToStr(GiTZDHMRCD) + 'λ��'), PChar('��ʾ'), MB_OK + MB_ICONWARNING);
      if EditTZDH.CanFocus then
        EditTZDH.SetFocus;
      Exit;
    end;

    //���ż��
    vSQL := 'select count(TZDID) as TZDNum from GBI_TZDML where GSDM=' + QuotedStr(GszGSDM)
                                                   + ' and KJND=' + QuotedStr(GszKJND)
                                                   + ' and TZDH=' + QuotedStr(EditTZDH.Text);
    if DataStatus = doseUpdate then
      if edtTZDID.Text <> '' then    //˵�����޸�
        vSQL := vSQL + ' and TZDID <> ' + edtTZDID.Text;

    cdsTmp.Data := DataModulePub.GetDataBySQL(vSQL);
    with cdsTmp do
    begin
      First;
      if FieldByName('TZDNum').AsInteger > 0 then
      begin
        Application.MessageBox(PChar('�������š�' + EditTZDH.Text + '���Ѿ����ڣ�'), PChar('��ʾ'), MB_OK + MB_ICONWARNING);
        Close;
        Exit;
      end;
      Close;
    end;
  end;
    if edtTZDID.Text <> '' then
    begin
      vSQL := 'select * from GBI_TZDML where GSDM=' + QuotedStr(GszGSDM)
                                                     + ' and KJND=' + QuotedStr(GszKJND)
                                                     + ' and DJLX=''TZD'' ' 
                                                     + ' and  zblb='''+FZBLBStr+''' and TZDH=' + QuotedStr(EditTZDH.Text);

      cdsTmp.Data := DataModulePub.GetDataBySQL(vSQL);
      with cdsTmp do
      begin
        First;
        if FieldByName('tzdzt').AsString <> '1' then
        begin
          Application.MessageBox(PChar('�������š�' + EditTZDH.Text + '��״̬�Ѿ��ı䣬�����޸ģ�'), PChar('��ʾ'), MB_OK + MB_ICONWARNING);
          Close;
          Exit;
        end;
        Close;
      end;
    end;

  with THStringGridTZDNR do
  begin
    //����Ƿ������ݣ����ݼ���Ǵ���󵽵�һ��(��ע��û��ѡ��ָ�������н������)
    vSum := RowCount-1;
    for i:=RowCount-1 downto 1 do
    begin
      GetCellValS(i, 'ZBDM', vCode);
      if Trim(vCode) = '' then
      begin
        vSum := vSum-1;
        Rows[i].Clear;
        if i>1 then
          THStringGridTZDNR.DeleteRow(i);
      end;
      if miZeroClear.checked then
      begin
        GetCellValF(i, 'TRJE', tmpSRValue);
        GetCellValF(i, 'TCJE', tmpZCValue);
        if (tmpSRValue=0) and (tmpZCValue=0) then
        begin
          Rows[i].Clear;
          if i>1 then
            THStringGridTZDNR.DeleteRow(i);
        end;
      end;
    end;

    if vSum = 0 then    //�Ƿ��м�¼
    begin
      Application.MessageBox(PChar('�������ݣ�'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
      Exit;
    end;

    //��ָ�����ĺϷ��Խ��м�飨�б��������ֶ����룩
    if not ZBDM_Check(THStringGridTZDNR, 'ZBDM') then
      Exit;

    //���롢֧��
    HasSR := False;
    HasZC := False;
    SRValue := 0;
    ZCValue := 0;
    AZBTZList := TZBTZList.Create;
    AZBTZList.Clear;
    try
    for i:=1 to RowCount-1 do
    begin
      GetCellValI(i, 'ZBID', vZBID);
      //��ע
      GetCellValS(i, 'TZZY', tmpZY);
      if tmpZY = '' then
      begin
        Application.MessageBox(PChar('��' + IntToStr(i) + '��δ����ժҪ��Ϣ��'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
        Exit;
      end;

      //����ֻ����������ģ�˫������Ĳ�����
      GetCellValF(i, 'TRJE', tmpSRValue);
      GetCellValF(i, 'TCJE', tmpZCValue);
      GetCellValF(i, 'SJKYJE', tmpSJKYValue);

      GetCellValF(i, 'KYJE', tmpKYValue);
      GetCellValF(i, 'ZBTZH', tmpKYTZHValue);
      if (GiZBGLJC = 2) and (FZBLB <> zlZZB) then
      begin
        AZBTZRec := TZBTZRec.Create;
        AZBTZRec.ZBID := vZBID;
        AZBTZRec.SJZBID := StrToInt(GetSJZBID(IntToStr(vZBID), FZBLBStr));
        GetSJZBKYJE(IntToStr(AZBTZRec.SJZBID),tmpSJKYValue);
        tmpSJKYValue := tmpSJKYValue - AZBTZList.GetTZJE(AZBTZRec.SJZBID);
        AZBTZRec.TZJE := tmpSRValue - tmpZCValue;
        AZBTZList.AddRec(AZBTZRec);
      end;
      if (GiZBGLJC = 2) then
      begin
        if (tmpSJKYValue<tmpSRValue) and  (FZBLBStr='MXZB') then
        begin
          Application.MessageBox(PChar('��������ϸָ�������λָ����ý����飡'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
          Exit;
        end;
      end;

      if (tmpSRValue > 0) and (tmpZCValue > 0) then
      begin
        Application.MessageBox(PChar('������ֻ�ܴ���ָ�굥���������ѡ��׷�ӻ���׷����'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
        Exit;
      end;
      //hch �����߼��жϣ����ָ�겻����֧�����߼� �����������ý��
      if tmpZCValue - tmpSRValue > ZeroValue8 then   //ly add ����ʱ������Ҫ������
        if DataModulePub.GetCountBySQL('Select 1 from GBI_ZBXMB where KJND='+QuotedStr(GszKJND) + ' and GSDM='+QuotedStr(GszGSDM)
          +' and ZBID='+IntToStr(vZBID)+' and CYSKZFS=0') >0 then
        begin
          if (tmpKYTZHValue < 0) then
          begin
            Application.MessageBox(PChar('�������������ý����飡'), PChar('��ʾ' ), MB_OK + MB_ICONSTOP);
            Exit;
          end;
        end;
      //hch �����������������ж�
    {  if (tmpZCValue > ZeroValue8) and ((tmpZCValue - tmpKYValue) > ZeroValue8) then
      begin
       Application.MessageBox(PChar('��' + IntToStr(i) + '��֧������ָ����ý�'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
       Exit;
      end; }

      if (not CheckDBSHJE(tmpSRValue)) or (not CheckDBSHJE(tmpZCValue)) then      //��鵥�������Ƿ񳬳�����Ա�Ľ��Ȩ��
      begin
        Application.MessageBox(PChar('�����У���' + IntToStr(i) + '�У�ָ���ȳ�������Ա��Ȩ�޷�Χ��'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
        Exit;
      end;

      HasSR := HasSR or (tmpSRValue <> 0);
      HasZC := HasZC or (tmpZCValue <> 0);

      SRValue := SRValue + tmpSRValue;
      ZCValue := ZCValue + tmpZCValue;
    end;
    finally
      for i := 0 to AZBTZList.Count - 1 do
        TZBTZRec(AZBTZList.Items[i]).Free;
      AZBTZList.Free;
    end;
    //���ȴ���  LY 2011042016605      > begin
    SRValue := StrToFloat(FloatToStr(SRValue));
    ZCValue := StrToFloat(FloatToStr(ZCValue));
    //                                > end
    if (SRValue > 0) and (ZCValue > 0)
      and (abs(SRValue - ZCValue) > 0.0001) then
    begin
      if Application.MessageBox(PChar('ָ��׷�ӡ�׷�����ȣ�����������'),
        PChar('ϵͳ��ʾ'), MB_YESNO + MB_ICONWarning) <> IDYES then
      begin
        Exit;
      end;
    end;
    if (SRValue=0) and (ZCValue=0) then
    begin
      Application.MessageBox(PChar('δ�����'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
      Exit;
    end;
  end;
  //���ָ�����Ƿ�����
  Result := ZBDataCheck;
end;

procedure TFormNoteItemTZ.GetData(AID: Integer);
var
  vSQL: string;
begin
  TZDMLCDS.Close;
  TZDNRCDS.Close;

  vSQL := 'select * from GBI_TZDML'
          + ' where GSDM=' + QuotedStr(GszGSDM)
          + ' and KJND=' + QuotedStr(GszKJND)
          + ' and ZBLB=' + QuotedStr(FZBLBStr)
          + ' and DJLX=''TZD'' ' 
          + ' order by TZDID';
  cdsTmp.Data := DataModulePub.GetDataBySQL(vSQL);
  if cdsTmp.Active then
  begin
    TZDMLCDS.Data := cdsTmp.Data;
    if TZDMLCDS.RecordCount > 0 then
    begin
      if AID > 0 then
      begin
        if not TZDMLCDS.Locate('TZDID', AID, []) then
          TZDMLCDS.First;
      end
      else
        TZDMLCDS.First;
    end;

    cdsTmp.Close;
  end;  
end;

procedure TFormNoteItemTZ.PutData;
var
  vIndex,i,iPos :  Integer;
  vValue, vZBID,szTemp,szZBDM,szZBDMtemp: string;
  vTRJE, vTCJE, vKYJE, vSJKYJE,vTRJEtemp,vTCJEtemp: Extended;
  szDXValue: ShortString;
begin
  ClearData;
  
  with TZDMLCDS do
  begin
    if Active then
    begin
      if RecordCount <= 0 then Exit;

      vValue := FieldByName('TZRQ').AsString;
      DTPTZRQ.Date := StrToDate(Copy(vValue, 1, 4) + DateSeparator + Copy(vValue, 5, 2) + DateSeparator + Copy(vValue, 7, 2));

      seFJZS.Value := FieldByName('FJZS').AsInteger;

      EditTZDH.Text := FieldByName('TZDH').AsString;

      edtTZDID.Text := FieldByName('TZDID').AsString;

      EditBZ.Text := FieldByName('BZ').AsString;

      edtSQR.Text := PShowStr(FieldByName('SQRID').AsString,FieldByName('SQR').AsString);

      LabelZDXM.Caption := FieldByName('ZDR').AsString;

      LabelSHXM.Caption := FieldByName('SHR').AsString;

      case FieldByName('TZDZT').AsInteger of
        2: //���
          THBevelZX.Caption := '�����';
        1: //����
          THBevelZX.Caption := 'δ���';
        0: //����
          THBevelZX.Caption := '������';
      end;
    end
    else
      Exit;
  end;

  GetNrData(TZDMLCDS.FieldByName('TZDID').AsInteger);



  with TZDNRCDS, THStringGridTZDNR do
    if Active then
      if RecordCount > 0 then
      begin
        First;
        vIndex := 0;
        GetCellValS(1, 'ZBDM', szZBDM);
        while not Eof do
        begin

          vIndex := vIndex + 1;
          RowCount := vIndex+1;
          Rows[RowCount-1].Clear;

          PutZBInfo(TZDNRCDS, vIndex, THStringGridTZDNR);

          GetCellValS(vIndex, 'ZBID', vZBID);
          GetZBKYJE(vZBID, vKYJE, vSJKYJE);
          GetCellValS(vIndex, 'ZBDM', szZBDM);

          if szZBDM <> szZBDMtemp then
          begin
            vTRJEtemp := 0;
            vTCJEtemp := 0;
          end;
          szZBDMtemp := szZBDM;
          SetCellValF(vIndex, 'KYJE', vKYJE);
          SetCellValF(vIndex, 'SJKYJE', vSJKYJE);

          SetCellValS(vIndex, 'TZZY', FieldByName('ZY').AsString);
          if FieldByName('SZSX').AsString = '1' then
          begin
            SetCellValF(vIndex, 'TRJE', FieldByName('JE').AsFloat);
            vTRJE := vTRJE + FieldByName('JE').AsFloat;
            vTRJEtemp := vTRJEtemp + FieldByName('JE').AsFloat;
            SetCellValF(vIndex, 'ZBTZH', vTRJE+vTRJEtemp);
          end
          else
          begin
            SetCellValF(vIndex, 'TCJE', FieldByName('JE').AsFloat);
            vTCJE := vTCJE + FieldByName('JE').AsFloat;
            vTCJEtemp := vTCJEtemp + FieldByName('JE').AsFloat;
            SetCellValF(vIndex, 'ZBTZH', vKYJE-vTCJEtemp);
          end;


          //THStringGridTZDNR.ro


          Next;
        end;
      end;

  LabelSRHJ.Caption := Format('%.2f', [vTRJE]);
  LabelZCHJ.Caption := Format('%.2f', [vTCJE]);
  //ָ�����ֻ�ܵ��������������� vTRJE+vTCJE
    szTemp := '              ' + AnyiFloatToStrF(vTRJE-vTCJE, ffFixed, 18, 2);
    iPos := pos('-', szTemp);
    if iPos > 0 then
      Delete(szTemp, iPos, 1);
    szTemp := copy(szTemp, length(szTemp) - 13, 14);
    szDXValue := '';
    for i := 1 to 14 do
    begin
      case szTemp[i] of
        ' ': szDXValue := szDXValue + '����';
        '0': szDXValue := szDXValue + '�㡡';
        '1': szDXValue := szDXValue + 'Ҽ��';
        '2': szDXValue := szDXValue + '����';
        '3': szDXValue := szDXValue + '����';
        '4': szDXValue := szDXValue + '����';
        '5': szDXValue := szDXValue + '�顡';
        '6': szDXValue := szDXValue + '½��';
        '7': szDXValue := szDXValue + '�⡡';
        '8': szDXValue := szDXValue + '�ơ�';
        '9': szDXValue := szDXValue + '����';
      end;
    end;
    LabelDX.Caption := szDXValue;
  //����
  AnnexData := Null;
end;

procedure TFormNoteItemTZ.THStringGridTZDNRLoadButtonClick(Sender: TObject);
var
  vColName: string;
  vZBYE: Extended;
  bYKJHKZ:Boolean;
begin
  with THStringGridTZDNR do
  begin
    vColName := GridCols[Col].ColName;
    if vColName = 'ZBDM' then  //ָ�����
    begin
      try
        bYKJHKZ :=GblYKJHKZ;        //��ֹ�ÿ�ƻ���������Ӱ���ѯ��Ӧ�ò�ָ��Ŀ��ý�ȥ�����´���ÿ�ƻ����  huanyh   2015-6-8
        GblYKJHKZ := false;
        cdsTmp.Data := TListSelectYSZBF.GetQueryCds(ZBLB, False, yfSR, nil, True);
      finally
        GblYKJHKZ := bYKJHKZ;
      end;  

      if cdsTmp.Active then
        if cdsTmp.RecordCount > 0 then
        begin
          PutZBInfo(cdsTmp, Row, THStringGridTZDNR);
          SetCellValF(Row,'KYJE',cdsTmp.FieldByName('KYJE').AsCurrency);
          if (GiZBGLJC = 2) and (FZBLB <> zlZZB) then//ָ�꼶��Ϊ2����ʱ�򣬲��õ��ϼ�����
          begin
            GetSJZBKYJE(cdsTmp.FieldByName('sjzbid').asstring,vZBYE);
            SetCellValF(Row,'SJKYJE',vZBYE);
          end;
        end;
      {with TListSelectYSZBF.Create(nil) do
      begin
        CurTZRQ := FormatDateTime('yyyyMMdd', DTPTZRQ.Date);
        ZBLB := Self.ZBLB;
        InitForm;
        if ShowModal = mrOK then
        begin
          PutZBInfo(ClientDataSet, Row, THStringGridTZDNR);
          //������
          with THStringGridTZDNR do
          begin
            SetCellValF(Row,'KYJE',ClientDataSet.FieldByName('KYJE').AsCurrency);
            SetCellValF(Row,'SJKYJE',ClientDataSet.FieldByName('SJKYJE').AsCurrency);
          end;
        end;
        Free;
      end; }
    end;
  end;
  //THStringGridTZDNR.AutoGridColWidth(-1);
end;

procedure TFormNoteItemTZ.THStringGridTZDNRKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  vZBID, vZBDM, vSQL, vKYSQL:String;
  vCds:TClientDataSet;
  vKYJE:double;
  vZY:String;
begin
  if Key = 13 then
  begin
    if Shift = [ssCtrl] then
    begin
      Key := 0;
      THStringGridTZDNR.GetCellValS(THStringGridTZDNR.Row, 'TZZY',  vZY);
      THStringGridTZDNR.RowCount := THStringGridTZDNR.RowCount+1;
      THStringGridTZDNR.Rows[THStringGridTZDNR.RowCount-1].Clear;
	  THStringGridTZDNR.SetCellValS(THStringGridTZDNR.RowCount-1, 'TZZY',  vZY);
    end;
    if THStringGridTZDNR.ColByName('ZBDM') = THStringGridTZDNR.Col then
    begin
      //ȡ��ָ�꣬ ����ָ�꣬ Ȼ��PutZBInfo
      THStringGridTZDNR.GetCellValS(THStringGridTZDNR.Row, 'ZBDM', vZBDM);
      if vZBDM <> '' then
      begin
        vSQL := 'Select * from GBI_ZBXMB where ZBDM = '+QuotedStr(vZBDM)
        +' and GSDM='+QuotedStr(GszGSDM)+' and KJND='+QuotedStr(GszKJND)
        +' AND ZBLB=' +QuotedStr(FZBLBStr);
        vCds := DataModulePub.GetCdsBySQL(vSQL);
        if vCds.RecordCount = 1 then
        begin
          PutZBInfo(vCds, THStringGridTZDNR.Row, THStringGridTZDNR);
          vZBID := vCds.FieldByName('ZBID').AsString;
          vKYSQL := TListSelectYSZBF.GetQueryKYJESql(vZBID,FZBLBStr);
          cdsTMP.Data := DataModulePub.GetDataBySQL(vKYSQL);
          THStringGridTZDNR.SetCellValF(THStringGridTZDNR.Row,'KYJE',cdsTmp.FieldByName('KYJE').AsCurrency);
          if GiZBGLJC = 2 then//ָ�꼶��Ϊ2����ʱ�򣬲��õ��ϼ�����
          begin
            THStringGridTZDNR.SetCellValF(THStringGridTZDNR.Row,'SJKYJE',cdsTmp.FieldByName('SJKYJE').AsFloat);
          end;
		  THStringGridTZDNR.AutoNext := True;
        end;
      end;
    end
	  else
      THStringGridTZDNR.AutoNext := True;
  end
  else if Key = VK_F5 then    //��¼����ѯ��λ
    LocateFLJE;
end;

procedure TFormNoteItemTZ.actSaveExecute(Sender: TObject);
var
  vSQL, cDate, cTime: string;
  vTZDID,vTZDH: string;
  vSubSQL: string;
  vSQR, vRQ:String;
  szMaxid,szTZDH:string;
  szMaxid2,szDWDM, vTZRQ:string;
  CdsTZDML, CdsTZDNR: TClientDataSet;
  i: Integer;
  function GetTZDNRSql(ATZDID:String): String;
  var
    i: Integer;
    vSZSX,vZY,vZBID: String;
    vJE: Extended;
  begin
    with THStringGridTZDNR do
    begin
      for i := 1 to RowCount -1 do
      begin
         //if Result <> '' then
         //  Result := Result + '; ';

         GetCellValS(i, 'TZZY', vZY);

         vSZSX := '1';
         GetCellValF(i, 'TRJE', vJE);
         if vJE = 0 then
         begin
           vSZSX := '-1';
           GetCellValF(i, 'TCJE', vJE);
         end;

         GetCellValS(i, 'ZBID', vZBID);

         if ATZDID <> '0' then
           Result := Result + 'insert into GBI_TZDNR(TZDID,GSDM,KJND,TZDFLH,ZBID,ZY,JE,SZSX) values('
                            + ATZDID + ', ' + QuotedStr(GszGSDM) + ',' + QuotedStr(GszKJND) + ', ' + IntToStr(i) + ', '
                            + vZBID + ', ' + QuotedStr(vZY) + ', ' + FloatToStr(vJE) + ', ' + vSZSX + '); '
         else
           Result := Result + 'insert into GBI_TZDNR(TZDID,GSDM,KJND,TZDFLH,ZBID,ZY,JE,SZSX) values('
                            + szmaxid + ','+QuotedStr(GszGSDM) + ',' + QuotedStr(GszKJND) + ', ' + IntToStr(i) + ', '
                            + vZBID + ', ' + QuotedStr(vZY) + ', ' + FloatToStr(vJE) + ', ' + vSZSX + '); ';
      end;
    end;
  end;
begin
  if DataCheck then
  begin
    if GsTZDHZDBHRQ ='1' then
      vRQ := GszYWRQ
    else if GsTZDHZDBHRQ ='2' then
      vRQ := LeftStr(GszYWRQ, 6)
    else if GsTZDHZDBHRQ ='3' then
      vRQ := LeftStr(GszYWRQ, 4);
    vTZDID := edtTZDID.Text;
    vTZDH :=EditTZDH.Text;
    if GblZDBZTZDH then
    begin
      vTZDH := '00000000001';
      if Length(vTZDH) > 5 then
        vTZDH := RightStr(vTZDH,5);
    end;

    if GDbType = MSSQL then
    begin
      szMaxid := '@MaxID';
      szTZDH := '@TZDH';
    end
    else
    begin
      szMaxid := 'MaxID';
      szTZDH := 'TZDH';
    end;

    case DataStatus of
      doseInsert:  //����
      begin
        if GDbType = MSSQL then
        begin
          if not GblZDBZTZDH then
          vSQL := ''
            + 'declare @MaxID integer '       //������ID
            + 'declare @TZDH varchar(13) '    //�������� ��13����Ϊ������ +5λ��ˮ�ţ���Ҫ13λ
            + 'declare @TZDLSH varchar(10) '  //��������ˮ��
            + 'declare @iCount integer '      //�жϵ����Ƿ��е�����,��������ˮ���ǰ�������ˮ��
            + 'begin '
            + '  begin tran '
            + '  select @maxid=isnull(MAX(TZDID),0)+1 from GBI_TZDML '
            + '  select @TZDH = '''+vTZDH+''''

          else
          vSQL := ''
            + 'declare @MaxID integer '       //������ID
            + 'declare @TZDH varchar(13) '    //�������� ��13����Ϊ������ +5λ��ˮ�ţ���Ҫ13λ
            + 'declare @TZDLSH varchar(10) '  //��������ˮ��
            + 'declare @iCount integer '      //�жϵ����Ƿ��е�����,��������ˮ���ǰ�������ˮ��
            + 'begin '
            + '  begin tran '
            + '  select @maxid=isnull(MAX(TZDID),0)+1 from GBI_TZDML '
            + '  select @iCount=Count(*) from GBI_TZDML where gsdm='''+GszGSDM+''' '
            + '         and kjnd='''+GszKJND+''' and DJLX=''TZD'' and tzdh like '''+vRQ+'%'' '
            + '  if @iCount=0 '
            + '  begin '
            //+ '    select @TZDH = '''+vRQ+'''+''00001'''
            + '    select @TZDH = '''+vRQ+'''+'''+vTZDH+''''
            + '  end '
            + '  else '
            + '  begin '
            + '    select @TZDLSH = Convert(varchar(5), Convert(int, right(max(rtrim(tzdh)), 5)) + 1) '
            + '      from gbi_tzdml where gsdm='''+GszGSDM+''' and kjnd='''+GszKJND+''' and DJLX=''TZD'' and tzdh like '''+vRQ+'%'' '
            //Add
            + '     if @TZDLSH is null select @TZDLSH=''1'' '
            + '    select @TZDH='''+vRQ+'''+right(''000000000''+ @TZDLSH, 5) '
            + '  end ';
        end
        else
        begin   //oracle
         if not GblZDBZTZDH then
          vSQL := 'begin '
            + ' declare  '
            + ' MaxID integer; '   //������ID
            + ' TZDH varchar2(13); '    //�������� ��13����Ϊ������ +5λ��ˮ�ţ���Ҫ13λ
            + ' TZDLSH varchar2(10); '  //��������ˮ��
            + ' iCount integer; '      //�жϵ����Ƿ��е�����,��������ˮ���ǰ�������ˮ��
            + 'begin '
            + '  select nvl(MAX(TZDID),0)+1 into MaxID from GBI_TZDML; '
            //+ '  TZDH := '''+vTZDH+''';'
            + ' select ''' + vTZDH + ''' into TZDH from dual; '
          else
          vSQL := 'begin '
            + ' declare'
            + ' MaxID integer; '       //������ID
            + ' TZDH varchar2(13); '    //�������� ��13����Ϊ������ +5λ��ˮ�ţ���Ҫ13λ
            + ' TZDLSH varchar2(10); '  //��������ˮ��
            + ' iCount integer; '      //�жϵ����Ƿ��е�����,��������ˮ���ǰ�������ˮ��
            + ' begin '
            + '  select nvl(MAX(TZDID),0)+1 into MaxID from GBI_TZDML; '
            + '  select Count(*) into iCount from GBI_TZDML where gsdm='''+GszGSDM+''' '
            + '         and kjnd='''+GszKJND+''' and DJLX=''TZD'' and tzdh like '''+vRQ+'%''; '
            + '  if iCount=0 then'
            //+ '    TZDH := '''+vRQ+'''||'''+vTZDH+''';'
            + '  select '''+vRQ+'''||'''+vTZDH+''' into TZDH from dual; '
            + '  else'
            + '    begin'
            + '      select to_number( substr(max(rtrim(tzdh)),-5) )+1  into  TZDLSH '   //ZWR900220877 20140-12-8 huangyh
            + '      from gbi_tzdml where gsdm='''+GszGSDM+''' and kjnd='''+GszKJND+''' and DJLX=''TZD'' and tzdh like '''+vRQ+'%''; '
            //+ '      if TZDLSH=null then  TZDLSH:=''1''; end if;'
            + '      if TZDLSH is null then  select ''1'' into TZDLSH from dual; end if;'
            //+ '      TZDH:='+vRQ+'||SUBSTR(''000000000''|| TZDLSH,LENGTH(''000000000''|| TZDLSH)-5, 5); '
            + '      select ''' +vRQ+'''||SUBSTR(''000000000''||TZDLSH, -5) into TZDH from dual; '  //ZWR900220877 20140-12-8 huangyh
            + '    end; '
            + '  end if; '
        end;

        if Pos('[', edtSQR.Text)>0 then
          vSQR := GetTypeValue(edtSQR.Text, gdtCode)
        else
          vSQR := '-1';

        PGetDbServerDateTime(cDate, cTime);
        if GZDRQQYWRQ then cDate := GszYWRQ;

        //������Ϣ
        if GblZDBZTZDH then
        begin
          vSQL := vSQL + ' insert into GBI_TZDML(DJLX,TZDID,GSDM,KJND,TZDH,TZDZT,TZRQ,ZBLB,BZ,FJZS,SQRID,SQR,ZDRID,ZDR,ZDRQ,SHRID,ZFRID) '
            + 'Values (''TZD'','+szmaxid+','''+GszGSDM+''','''+GszKJND+''','+szTZDH+',''1'','''+FormatDateTime('yyyymmdd', DTPTZRQ.Date)+''','''+FZBLBStr+''','
            + ''''+EditBZ.Text+''','+IntToStr(seFJZS.Value)+','+QuotedStr(vSQR)+','
            + ''''+GetTypeValue(edtSQR.Text, gdtName)+''','+IntToStr(GCzy.ID)+','''+GCzy.name+''','''+cDate+''',-1,-1); ';
        end
        else
        begin
          vSQL := vSQL + ' insert into GBI_TZDML(DJLX,TZDID,GSDM,KJND,TZDH,TZDZT,TZRQ,ZBLB,BZ,FJZS,SQRID,SQR,ZDRID,ZDR,ZDRQ,SHRID,ZFRID) '
            + 'Values (''TZD'','+szmaxid+','''+GszGSDM+''','''+GszKJND+''','+szTZDH+',''1'','''+FormatDateTime('yyyymmdd', DTPTZRQ.Date)+''','''+FZBLBStr+''','
            + ''''+EditBZ.Text+''','+IntToStr(seFJZS.Value)+','+QuotedStr(vSQR)+','
            + ''''+GetTypeValue(edtSQR.Text, gdtName)+''','+IntToStr(GCzy.ID)+','''+GCzy.name+''','''+GszYWRQ+''',-1,-1); ';
        end;

        vSubSQL := GetTZDNRSql('0');
        vSQL := vSQL + vSubSQL;

        if GDbType = ORACLE then
        begin
          vSQL := vSQL + '  commit;';
          vSQL := vSQL + '  open :pRecCur for select MaxID tzdid from dual;';
        //  vSQL := vSQL + 'EXCEPTION';
        //  vSQL := vSQL + '  WHEN OTHERS THEN  ' ;
        //  vSQL := vSQL + ' open :pRecCur for select -1 as tzdid from dual;';     // DBMS_OUTPUT.PUT_LINE('''');';//
          vSQL := vSQL + ' end;';
          vSQL := vSQL + 'end;';
        end
        else
          vSQL := vSQL + 'if @@ERROR <> 0 begin rollback tran select -1 as tzdid end else begin commit tran select @MaxID as tzdid end end ';

        POpenSql(DataModulePub.ClientDataSetTmp,vSQL);
        vTZDID := DataModulePub.ClientDataSetTmp.FieldByName('tzdid').AsString;
      end;
      doseUpdate:  //����
      begin
        //�����ǰ������
        if GDbType = MSSQL then
           vSQL := 'begin tran '
        else
           vSQL := 'begin ';
        vSQL := vSQL + ' delete from GBI_TZDNR where TZDID = '+vTZDID+';';

        if Pos('[', edtSQR.Text)>0 then
          vSQR := GetTypeValue(edtSQR.Text, gdtCode)
        else
          vSQR := '-1';

        vSQL := vSQL + 'update GBI_TZDML set SQRID='+QuotedStr(vSQR)+', SQR=''' + GetTypeValue(edtSQR.Text, gdtName)+''', TZRQ='''+FormatDateTime('yyyymmdd', DTPTZRQ.Date)+''','
          +'BZ='''+EditBZ.Text+''',FJZS='+IntToStr(seFJZS.Value)+' where TZDID='+vTZDID+';';

        vSubSQL := GetTZDNRSql(vTZDID);

        vSQL := vSQL + vSubSQL;
        if GDbType = MSSQL then
           vSQL := vSQL + ' if @@ERROR <> 0 rollback tran else commit tran '
        else
           vSQL := vSQL + ' commit; end; ';

        PExecSql(vSQL);      
      end;
    end;
    
    if GiBBMode = ZGDWB then
    if FZBLB = zlDWZB then
    begin
      szMaxid2 := '';       
      if vZGDWDM <> '' then
      begin
        vTZRQ := FormatDateTime('yyyymmdd', DTPTZRQ.Date);
        vTZDH := DataModulePub.GetFldValue('GBI_TZDML', 'TZDH', 'TZDID='+vTZDID, '');
        if GiBBMode = JCDWB then
          szMaxid2 := DataModulePub.GetFldValue('GBI_TZDML', 'TZDID', 'TZDH=''' + vTZDH + ''''
                                       + ' and GSDM<>' + QuotedStr(GszGSDM)
                                       + ' and KJND=' + QuotedStr(GszKJND)
                                       + ' and TZRQ=' + QuotedStr(vTZRQ)
                                       + ' and TZDZT in (0,1)', '');
                                       
        vSQL := 'delete from GBI_TZDNR where TZDID in (select TZDID from GBI_TZDML where TZDH=''' + vTZDH + ''''
                                                       + ' and GSDM<>' + QuotedStr(GszGSDM)
                                                       + ' and KJND=' + QuotedStr(GszKJND)
                                                       + ' and TZRQ=' + QuotedStr(vTZRQ)
                                                       + ' and ZBLB=''DWZB'' '
                                                       + ' and TZDZT in (0,1) '
                                                       + ' and SJLY is not null ' + ')'
                                         + ' and GSDM<>' + QuotedStr(GszGSDM) + ' and KJND=' + QuotedStr(GszKJND)
            + '; '
            + 'delete from GBI_TZDML where TZDH=''' + vTZDH + ''''
                                       + ' and GSDM<>' + QuotedStr(GszGSDM)
                                       + ' and KJND=' + QuotedStr(GszKJND)
                                       + ' and TZRQ=' + QuotedStr(vTZRQ)
                                       + ' and ZBLB=''DWZB'' '
                                       + ' and TZDZT in (0,1) '
                                       + ' and SJLY is not null ';
        PExecSql(vSQL);
      
        CdsTZDML := TClientDataSet.Create(nil);
        CdsTZDNR := TClientDataSet.Create(nil);

        vSQL := 'Select * from GBI_TZDML where TZDID=' + vTZDID;
        CdsTZDML := DataModulePub.GetCdsBySQL(vSQL);
        if GiBBMode = ZGDWB then
          vSQL := 'Select NR.*, ZB.YSDWDM, ZB2.ZBID AS ZBID2 from GBI_TZDNR NR '
                + ' Left join GBI_ZBXMB ZB on ZB.GSDM=NR.GSDM and ZB.KJND=NR.KJND and ZB.ZBLB=''DWZB'' and ZB.ZBID=NR.ZBID '
                + ' Left join GBI_ZBXMB ZB2 on ZB2.GSDM=ZB.YSDWDM and ZB2.KJND=ZB.KJND and ZB2.ZBLB=''DWZB'' and ZB2.SJZBID=ZB.ZBID '
                + ' where NR.TZDID=' + vTZDID + ' order by ZB.YSDWDM '
        else
          vSQL := 'Select NR.*, ZB2.ZBID AS ZBID2 from GBI_TZDNR NR '
                + ' Left join GBI_ZBXMB ZB on ZB.GSDM=NR.GSDM and ZB.KJND=NR.KJND and ZB.ZBLB=''DWZB'' and ZB.ZBID=NR.ZBID '
                + ' Left join GBI_ZBXMB ZB2 on ZB2.GSDM=''' + vZGDWDM + ''' and ZB2.KJND=ZB.KJND and ZB2.ZBLB=''DWZB'' and ZB2.ZBID=ZB.SJZBID '
                + ' where NR.TZDID=' + vTZDID;
        CdsTZDNR := DataModulePub.GetCdsBySQL(vSQL);

        szDWDM := '';
        vSQL := '';
        vSubSQL := '';
        if GiBBMode = ZGDWB then
        begin
          CdsTZDNR.First;
          while not CdsTZDNR.Eof do
          begin
            if szDWDM <> CdsTZDNR.FieldByName('YSDWDM').AsString then
            begin
              if szDWDM <> '' then
              begin
                if vSubSQL <> '' then
                begin
                  vSubSQL := vSubSQL + ' insert into GBI_TZDML(DJLX,TZDID,GSDM,KJND,TZDH,TZDZT,TZRQ,ZBLB,BZ,FJZS,SQRID,SQR,ZDRID,ZDR,ZDRQ,SHRID,ZFRID,SJLY) '
                    + 'Values (''TZD'','+szmaxid2+','''+szDWDM+''','''+GszKJND+''','+vTZDH+',''1'','''+CdsTZDML.FieldByName('TZRQ').AsString+''','''+CdsTZDML.FieldByName('ZBLB').AsString+''','
                    + ''''+CdsTZDML.FieldByName('BZ').AsString+''','+CdsTZDML.FieldByName('FJZS').AsString+','''+CdsTZDML.FieldByName('SQRID').AsString+''','
                    + ''''+CdsTZDML.FieldByName('SQR').AsString+''','+CdsTZDML.FieldByName('ZDRID').AsString+','''+CdsTZDML.FieldByName('ZDR').AsString+''','''+CdsTZDML.FieldByName('ZDRQ').AsString+''',-1,-1,1); ';
                  vSQL := vSQL + vSubSQL;
                  PExecSql(vSQL);
                end;
              end;
              vSQL := '';
              vSubSQL := '';
              szDWDM := CdsTZDNR.FieldByName('YSDWDM').AsString;
              szmaxid2 := DataModulePub.GetFldValue('GBI_TZDML', 'MAX(TZDID)+1', '', 1);
              i := 1;               
            end
            else
            begin
        
            end;
            if CdsTZDNR.FieldByName('ZBID2').AsString <> '' then
            vSubSQL := vSubSQL + 'insert into GBI_TZDNR(TZDID,GSDM,KJND,TZDFLH,ZBID,ZY,JE,SZSX) values('
                                + szmaxid2 + ', ' + QuotedStr(szDWDM) + ',' + QuotedStr(GszKJND) + ', ' + IntToStr(i) + ', '
                                + CdsTZDNR.FieldByName('ZBID2').AsString + ', ' + QuotedStr(CdsTZDNR.FieldByName('ZY').AsString) + ', '
                                + FloatToStr(CdsTZDNR.FieldByName('JE').AsFloat) + ', ' + CdsTZDNR.FieldByName('SZSX').AsString + '); ';
            Inc(i);
            CdsTZDNR.Next;
          end;
          if vSubSQL <> '' then
          begin
            vSubSQL := vSubSQL + ' insert into GBI_TZDML(DJLX,TZDID,GSDM,KJND,TZDH,TZDZT,TZRQ,ZBLB,BZ,FJZS,SQRID,SQR,ZDRID,ZDR,ZDRQ,SHRID,ZFRID,SJLY) '
                  + 'Values (''TZD'','+szmaxid2+','''+szDWDM+''','''+GszKJND+''','+vTZDH+',''1'','''+CdsTZDML.FieldByName('TZRQ').AsString+''','''+CdsTZDML.FieldByName('ZBLB').AsString+''','
                  + ''''+CdsTZDML.FieldByName('BZ').AsString+''','+CdsTZDML.FieldByName('FJZS').AsString+','''+CdsTZDML.FieldByName('SQRID').AsString+''','
                  + ''''+CdsTZDML.FieldByName('SQR').AsString+''','+CdsTZDML.FieldByName('ZDRID').AsString+','''+CdsTZDML.FieldByName('ZDR').AsString+''','''+CdsTZDML.FieldByName('ZDRQ').AsString+''',-1,-1,1); ';
            vSQL := vSQL + vSubSQL;
            PExecSql(vSQL);
          end;
        end
        else
        begin
          CdsTZDNR.First;
          while not CdsTZDNR.Eof do
          begin
            szDWDM := vZGDWDM;
            if szMaxid2 = '' then
              szmaxid2 := DataModulePub.GetFldValue('GBI_TZDML', 'MAX(TZDID)+1', '', 1);
            i := 1;
            if CdsTZDNR.FieldByName('ZBID2').AsString <> '' then
            vSubSQL := vSubSQL + 'insert into GBI_TZDNR(TZDID,GSDM,KJND,TZDFLH,ZBID,ZY,JE,SZSX) values('
                                + szmaxid2 + ', ' + QuotedStr(szDWDM) + ',' + QuotedStr(GszKJND) + ', ' + IntToStr(i) + ', '
                                + CdsTZDNR.FieldByName('ZBID2').AsString + ', ' + QuotedStr(CdsTZDNR.FieldByName('ZY').AsString) + ', '
                                + FloatToStr(CdsTZDNR.FieldByName('JE').AsFloat) + ', ' + CdsTZDNR.FieldByName('SZSX').AsString + '); ';
            Inc(i);
            CdsTZDNR.Next;
          end;
          if vSubSQL <> '' then
          begin
            vSubSQL := vSubSQL + ' insert into GBI_TZDML(DJLX,TZDID,GSDM,KJND,TZDH,TZDZT,TZRQ,ZBLB,BZ,FJZS,SQRID,SQR,ZDRID,ZDR,ZDRQ,SHRID,ZFRID,SJLY) '
                  + 'Values (''TZD'','+szmaxid2+','''+szDWDM+''','''+GszKJND+''','+vTZDH+',''1'','''+CdsTZDML.FieldByName('TZRQ').AsString+''','''+CdsTZDML.FieldByName('ZBLB').AsString+''','
                  + ''''+CdsTZDML.FieldByName('BZ').AsString+''','+CdsTZDML.FieldByName('FJZS').AsString+','''+CdsTZDML.FieldByName('SQRID').AsString+''','
                  + ''''+CdsTZDML.FieldByName('SQR').AsString+''','+CdsTZDML.FieldByName('ZDRID').AsString+','''+CdsTZDML.FieldByName('ZDR').AsString+''','''+CdsTZDML.FieldByName('ZDRQ').AsString+''',-1,-1,2); ';
            vSQL := vSQL + vSubSQL;
            PExecSql(vSQL);
          end;        
        end;
      end;
    end;
    SaveAnnex(StrToInt(vTZDID), DJ_TZD, AnnexData);

    GetData(StrToInt(vTZDID));
    PutData;
    DataStatus := doseBrowse;
  end;
end;

procedure TFormNoteItemTZ.actPreviewExecute(Sender: TObject);
begin
  if NprintNew.Checked then
  begin
    if HasSetZDYBB('GBI_TZD_' + FZBLBStr) then
    begin
      try
        TPrintObj.Print('GBI_TZD_' + FZBLBStr, GetDJMLNRSQL(FZBLBStr, StrToIntDef(edtTZDID.Text, 0))) ;
      except
        SysMessage('����ʧ�ܣ������ԡ�', '_JG', [mbOK]);
      end;
    end
    else
      SysMessage('���Ƚ��д�ӡ���ã�', '_JG', [mbOK]);
  end
  else
  if  NprintOld.Checked then
  begin
    DoFormPrintSet;
    FormPrint.Prepare;
    FormPrint.Preview;
  end;

end;

procedure TFormNoteItemTZ.actPrintExecute(Sender: TObject);
begin
  if NprintNew.Checked then
  begin
    if HasSetZDYBB('GBI_TZD_' + FZBLBStr) then
    begin
      try
        //TPrintObj.Print('GBI_TZD_' + FZBLBStr, GetDJMLNRSQL(FZBLBStr, StrToIntDef(edtTZDID.Text, 0))) ;
        TPrintObj.PrintA('GBI_TZD_' + FZBLBStr, GetDJMLNRSQL(FZBLBStr, StrToIntDef(edtTZDID.Text, 0)), 'GBI') ;
      except
        SysMessage('����ʧ�ܣ������ԡ�', '_JG', [mbOK]);
      end;
    end
    else
      SysMessage('���Ƚ��д�ӡ���ã�', '_JG', [mbOK]);
  end
  else
  if  NprintOld.Checked then
  begin
    DoFormPrintSet;
    FormPrint.Prepare;
    FormPrint.Print;
  end;
end;

procedure TFormNoteItemTZ.actNewExecute(Sender: TObject);
begin
  ClearData;
  DataStatus := doseInsert;
  edtSQR.SetFocus ;    // ZWR900169282 huangyh 2014-4-24
end;

procedure TFormNoteItemTZ.actCancelExecute(Sender: TObject);
begin
  ClearData;
  PutData;
  DataStatus := doseBrowse;  
end;

procedure TFormNoteItemTZ.actCheckExecute(Sender: TObject);
var
  AZBDM: string;
  bDOTZ: Boolean;
begin
  {if not GblSHZJDJ and (LabelZDXM.Caption = GCzy.name) then
  begin
    Application.MessageBox(PChar('�Ƶ��˺�����˲���Ϊͬһ�ˣ���ֹ��˲�����'), PChar('��ʾ'), MB_OK + MB_ICONWARNING);
    Exit;
  end;}
  TZDOper := '���';
  bDOTZ := False;
  try
    //���ָ�����Ƿ����� 
    if ZBDataCheck then
    begin
      DataStatus := doseCheck;
      DoData;  //���
      bDOTZ := True;
    end;
    if bDOTZ then
      if not DoCheckZBYE(AZBDM) then  //�ټ��һ��ָ�����
      begin
        TZDOper := '����';
        DataStatus := doseUnCheck;
        DoData;  //���
        Application.MessageBox(PChar('ָ��'+AZBDM+'���ý��㣬������������'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
      end;
  finally
    TZDOper := '';
  end;
end;

procedure TFormNoteItemTZ.actUnCheckExecute(Sender: TObject);
begin
  {if (not GbCanUndo_Others_SH) and (not CanUndo('TZD', 'XS', TZDMLCDS.fieldbyname('TZDID').AsInteger, GCzy.ID)) then
  begin
    SysMessage('����������������˵ĵ��ݣ�', 'GBG_98_TZD', [mbOk]);
    Exit;
  end;}

  with TZDMLCDS do
  begin
    if FieldByName('IDPZH').AsString <> '' then
    begin
      Application.MessageBox(PChar('�õ������Ѿ�����ƾ֤��'), PChar('��ʾ'), MB_OK + MB_ICONWARNING);
      Exit;
    end;
  end;
  TZDOper := '����';
  try
    //���ָ�����Ƿ�����
    if ZBDataCheck then
    begin
      DataStatus := doseUnCheck;
      DoData;  //����
    end;
  finally
    TZDOper := '';
  end;
end;

procedure TFormNoteItemTZ.actRubbitExecute(Sender: TObject);
begin
  DataStatus := doseInvalid;
  DoData;  //����
end;

procedure TFormNoteItemTZ.actHYExecute(Sender: TObject);
begin
  DataStatus := doseRestore;
  DoData;  //��ԭ
end;

procedure TFormNoteItemTZ.actFirstExecute(Sender: TObject);
begin
  GetRecPos(drpFirst);
end;

procedure TFormNoteItemTZ.actPriousExecute(Sender: TObject);
begin
  GetRecPos(drpPrior);
end;

procedure TFormNoteItemTZ.actNextExecute(Sender: TObject);
begin
  GetRecPos(drpNext);
end;

procedure TFormNoteItemTZ.actLastExecute(Sender: TObject);
begin
  GetRecPos(drpLast);
end;

procedure TFormNoteItemTZ.DoData;
var
  vSQL, cDate, cTime: string;
  vTZDID,VZBID: string;
  vZT: string;
  vJE,vKYJE, vSJKYJE: Extended;
  vTZDH, VTZRQ: string;
  vTZSQL, vTZSQL2, vZBSQL: string;
begin
  with TZDMLCDS do
    if Active then
    begin
      vTZDID := FieldByName('TZDID').AsString;
      cdsTmp.Data  := DataModulePub.GetDataBySQL('select * from GBI_TZDnr where gsdm='''+GszGSDM+''' and kjnd='''+GszKJND+''' and tzdid='''+vTZDID+'''');
      vZBID := cdsTmp.fieldbyname('zbid').asstring;
      GetZBKYJE(vZBID, vKYJE, vSJKYJE);
      vJE    := cdsTmp.FieldByName('je').AsFloat;
      //ly update ZWR900213552
      if (DataStatus=doseRestore) and (vJE > vKYJE) and (cdsTmp.FieldByName('je').AsInteger = -1) then   //ֻ�Ե������ֽ��м��
      //if (DataStatus=doseRestore) and (vJE > vKYJE) then
      begin
        Application.MessageBox(PChar('ָ��ID'+vZBID+'���ý��㣬���ܻ�ԭ������'), PChar('��ʾ'), MB_OK + MB_ICONSTOP);
        Exit;
      end;
      PGetDbServerDateTime(cDate, cTime);
      
      case DataStatus of
        doseCheck:          //���
        begin
          if GSHRQQYWRQ then cDate := GszYWRQ;
          vZT := 'TZDZT=2, SHRID=' + IntToStr(GCzy.ID) + ', SHR=' + QuotedStr(GCzy.name) + ', SHRQ=' + QuotedStr(cDate);
        end;
        doseUnCheck:        //����
        vZT := 'TZDZT=1, SHRID=0, SHR='''', SHRQ=''''';
        doseInvalid:         //����
        begin
          vZT := 'TZDZT=0, ZFRID=' + IntToStr(GCzy.ID) + ', ZFR=' + QuotedStr(GCzy.name) + ', ZFRQ=' + QuotedStr(cDate);
        end;
        doseRestore:         //��ԭ
        vZT := 'TZDZT=1, ZFRID=0, ZFR='''', ZFRQ=''''';
      end;
      vTZSQL := '';
      vSQL := 'update GBI_TZDML set ' + vZT
              + ' where TZDID=' + vTZDID
              + ' and GSDM=' + QuotedStr(GszGSDM)
              + ' and KJND=' + QuotedStr(GszKJND);
      //PExecSql(vSQL);
      vTZSQL := vSQL + GszDbFgf;

      vTZSQL2 := '';
      if (GiBBMode = ZGDWB) {or (GiBBMode = JCDWB)} then
      begin
        if ZBLB = zlDWZB then
        begin
          vTZDH := FieldByName('TZDH').AsString;
          vTZRQ := FieldByName('TZRQ').AsString;
          vSQL := 'update GBI_TZDML set ' + vZT
                + ' where TZDID in (select TZDID from GBI_TZDML where TZDH=''' + vTZDH + ''''
                                 + ' and GSDM<>' + QuotedStr(GszGSDM)
                                 + ' and KJND=' + QuotedStr(GszKJND)
                                 + ' and TZRQ=' + QuotedStr(vTZRQ)
                                 + ' and ZBLB=''DWZB'' '
                                 + ' and SJLY is not null '+ ')'
                + ' and GSDM<>' + QuotedStr(GszGSDM)
                + ' and KJND=' + QuotedStr(GszKJND)
                + ' and TZRQ=' + QuotedStr(vTZRQ)
                + ' and ZBLB=''DWZB'' '
                + ' and SJLY is not null ';
          //PExecSql(vSQL);
          vTZSQL2 := vSQL + GszDbFgf;
        end;
      end;

      case DataStatus of
        doseCheck:   ChangeZBYS(1, vZBSQL);          //���
        doseUnCheck: ChangeZBYS(-1, vZBSQL);         //����
      end;

      vSQL := vTZSQL + vTZSQL2 + vZBSQL;  // Modified by Cheyf 2015-01-10 ��������SQL����һ��ִ��
      PExecSql(vSQL);

      GetData(StrToInt(vTZDID));
      PutData;
      DataStatus := doseBrowse;
    end;
end;

procedure TFormNoteItemTZ.GetNrData(ATZDID: Integer);
var
  vSQL: string;
begin
  vSQL := 'select TZDNR.ZY, TZDNR.JE, TZDNR.SZSX, XMB.*'

          + ',TZDNR.TZDFLH'
          + ' from GBI_TZDNR TZDNR, (select ZBID,GSDM,KJND,ZBDM,YSFADM,YSFAMC,'
          + 'JFLXDM,JFLXMC,YSDWDM,YSDWMC,BMDM,BMMC,XMDM,XMMC,ZYDM,ZYMC,'
          + 'GNKMDM,GNKMMC,JJKMDM,JJKMMC,ZJLYDM,ZJLYMC,ZJXZDM,ZJXZMC,'
          + 'ZFFSDM,ZFFSMC,JSFSDM,JSFSMC,ZBLYDM,ZBLYMC,XMFLDM,XMFLMC,WHDM,WHMC,'
          + 'FZ6DM,FZ6MC,FZ7DM,FZ7MC,FZ8DM,FZ8MC,FZ9DM,FZ9MC,FZADM,FZAMC'
          + ' from GBI_ZBXMB where GSDM=' + QuotedStr(GszGSDM) + ' and KJND='
          + QuotedStr(GszKJND) + ' and ZBLB=' + QuotedStr(FZBLBStr)+') XMB'
          + ' where TZDNR.TZDID=' + IntToStr(ATZDID) + ' and TZDNR.GSDM='
          + QuotedStr(GszGSDM) + ' and TZDNR.KJND=' + QuotedStr(GszKJND)
          + ' and TZDNR.ZBID=XMB.ZBID'
          + ' order by TZDNR.TZDFLH';

  cdsTmp.Data := DataModulePub.GetDataBySQL(vSQL);
  if cdsTmp.Active then
  begin
    TZDNRCDS.Data := cdsTmp.Data;
    cdsTmp.Close;
  end;
end;

procedure TFormNoteItemTZ.GetRecPos(vRecPos: TDataRecPos);
begin
  with TZDMLCDS do
    if Active then
      if RecordCount > 0 then
        case vRecPos of
        drpFirst: First;
        drpPrior: Prior;
        drpNext : Next;
        drpLast : Last;
        end;
  PutData;
  DataStatus := doseBrowse;
end;


procedure TFormNoteItemTZ.ChangeZBYS(AIndex: Integer; var ASQL: string);
var
  vSQL, vSQL2, vNull: string;
  i: Integer;
  vTRJE, vTCJE: Extended;
  vValue: string;
  vZBDM, vZBDM2, vZBDMStr: string;
  vQJ, vOperQJ, vYWRQ: string;
  vBool: Boolean;
  vDWDM: string;
  vZBID: Integer;
begin
  ASQL := '';
  if GDbType = MSSQL then
    vNull := 'isnull'
  else
    vNull := 'nvl';
  with THStringGridTZDNR do
  begin
    vSQL := '';
    vSQL2 := '';
    //��ȡ�����ڼ�
    vYWRQ := FormatDateTime('yyyymmdd', DTPTZRQ.Date);
    vBool := GetCurQJ(vYWRQ, vQJ, vOperQJ);
    if not vBool then Exit;
    vZBDMStr := '';
    for i:=1 to RowCount-1 do
    begin
      GetCellValF(i, 'TRJE', vTRJE);
      GetCellValF(i, 'TCJE', vTCJE);
      GetCellValS(i, 'ZBDM', vZBDM);
      if Pos(vZBDM+'|', vZBDMStr) > 0 then  //�ĳɴӵ��������㣬ͬһָ���ֻ����һ��
        Continue;
      vValue := FloatToStr((vTRJE - vTCJE) * AIndex);

      if vSQL <> '' then
        vSQL := vSQL + '; ';

      //vSQL := vSQL + 'update GBI_ZBXMB Set YE = YE + ' + vValue;
      // Modified by Cheyf 2015-12-10 ����Ϊͨ������������
      vSQL := vSQL + 'update GBI_ZBXMB Set YE = JE - NCYSY + '
        + vNull + '('
        + '(Select Sum(SZSX*JE) TZJE from GBI_TZDNR '
        + ' where TZDID in (select TZDID from GBI_TZDML where GSDM=' + QuotedStr(GszGSDM) + ' and KJND=' + QuotedStr(GszKJND)
        + ' and ZBLB=' + QuotedStr(FZBLBStr) + ' and TZDZT = 2)'
        + ' and GSDM=' + QuotedStr(GszGSDM) + ' and KJND=' + QuotedStr(GszKJND)+' and ZBID=GBI_ZBXMB.ZBID)'+',0)';

      vSQL := vSQL
              + ' where GSDM=' + QuotedStr(GszGSDM)
              + ' and KJND=' + QuotedStr(GszKJND)
              + ' and ZBDM=' + QuotedStr(vZBDM)
              + ' and ZBLB=' + QuotedStr(FZBLBStr)
              + ' and ZBID in ('
              +                 'select ZBID from GBI_ZBXMB'
              +                  ' where GSDM=' + QuotedStr(GszGSDM)
              +                  ' and KJND=' + QuotedStr(GszKJND)
              +                  ' and ZBDM=' + QuotedStr(vZBDM)
              +                  ' and ZBLB=' + QuotedStr(FZBLBStr)
              +               ')';

      if (GiBBMode = ZGDWB) {or (GiBBMode = JCDWB)}then
      begin
        if ZBLB = zlDWZB then
        begin
          if GiBBMode = JCDWB then
          begin
            vDWDM := vZGDWDM;
            vZBID := DataModulePub.GetFldValue('GBI_ZBXMB', 'SJZBID', 'GSDM=' + QuotedStr(GszGSDM)
                  + ' and KJND=' + QuotedStr(GszKJND)
                  + ' and ZBDM=' + QuotedStr(vZBDM)
                  + ' and ZBLB=' + QuotedStr(FZBLBStr), '');
            vZBDM2 := DataModulePub.GetFldValue('GBI_ZBXMB', 'ZBDM', 'GSDM=' + QuotedStr(vDWDM)
                  + ' and KJND=' + QuotedStr(GszKJND)
                  + ' and ZBID=' + IntToStr(vZBID)
                  + ' and ZBLB=' + QuotedStr(FZBLBStr), '');
          end
          else
          begin
            vDWDM := DataModulePub.GetFldValue('GBI_ZBXMB', 'YSDWDM', 'GSDM=' + QuotedStr(GszGSDM)
                  + ' and KJND=' + QuotedStr(GszKJND)
                  + ' and ZBDM=' + QuotedStr(vZBDM)
                  + ' and ZBLB=' + QuotedStr(FZBLBStr), '');
            vZBID := DataModulePub.GetFldValue('GBI_ZBXMB', 'ZBID', 'GSDM=' + QuotedStr(GszGSDM)
                  + ' and KJND=' + QuotedStr(GszKJND)
                  + ' and ZBDM=' + QuotedStr(vZBDM)
                  + ' and ZBLB=' + QuotedStr(FZBLBStr), '');
            vZBDM2 := DataModulePub.GetFldValue('GBI_ZBXMB', 'ZBDM', 'GSDM=' + QuotedStr(vDWDM)
                  + ' and KJND=' + QuotedStr(GszKJND)
                  + ' and SJZBID=' + IntToStr(vZBID)
                  + ' and ZBLB=' + QuotedStr(FZBLBStr), '');
          end;
          if vZBDM2 <> '' then
          begin
            if vSQL2 <> '' then
              vSQL2 := vSQL2 + '; ';

            //vSQL2 := vSQL2 + 'update GBI_ZBXMB Set YE = YE + ' + vValue;
            // Modified by Cheyf 2015-12-10 ����Ϊͨ������������
            vSQL2 := vSQL2 + 'update GBI_ZBXMB Set YE = JE - NCYSY + '
              + vNull + '('
              + '(Select Sum(SZSX*JE) TZJE from GBI_TZDNR '
              + ' where TZDID in (select TZDID from GBI_TZDML where GSDM=' + QuotedStr(vDWDM) + ' and KJND=' + QuotedStr(GszKJND)
              + ' and ZBLB=' + QuotedStr(FZBLBStr) + ' and TZDZT = 2)'
              + ' and GSDM=' + QuotedStr(vDWDM) + ' and KJND=' + QuotedStr(GszKJND)+' and ZBID=GBI_ZBXMB.ZBID)'+',0)';

            vSQL2 := vSQL2
                    + ' where GSDM=' + QuotedStr(vDWDM)
                    + ' and KJND=' + QuotedStr(GszKJND)
                    + ' and ZBDM=' + QuotedStr(vZBDM2)
                    + ' and ZBLB=' + QuotedStr(FZBLBStr)
                    + ' and ZBID in ('
                    +                 'select ZBID from GBI_ZBXMB'
                    +                  ' where GSDM=' + QuotedStr(vDWDM)
                    +                  ' and KJND=' + QuotedStr(GszKJND)
                    +                  ' and ZBDM=' + QuotedStr(vZBDM2)
                    +                  ' and ZBLB=' + QuotedStr(FZBLBStr)
                    +               ')';
          end;
        end;
      end;
      vZBDMStr := vZBDMStr + vZBDM+'|';
    end;

    {if vSQL <> '' then
      PExecSql(vSQL);
    if vSQL2 <> '' then
      PExecSql(vSQL2);}
    if vSQL <> '' then  // Modified by Cheyf 2015-01-10 ��ֱ��ִ�У���Ϊ����SQL
      ASQL := vSQL + GszDbFgf;
    if vSQL2 <> '' then
      ASQL := ASQL + vSQL2 + GszDbFgf;
  end;
end;

procedure TFormNoteItemTZ.actDeleteExecute(Sender: TObject);
var
  vSQL, vTZDH, vTZRQ: string;
begin
  vTZDH := TZDMLCDS.FieldByName('TZDH').AsString;
  vTZRQ := TZDMLCDS.FieldByName('TZRQ').AsString;
  //ɾ��
  vSQL := 'delete from GBI_TZDNR where TZDID in (select TZDID from GBI_TZDML where TZDID=' + TZDMLCDS.FieldByName('TZDID').AsString
                                                     + ' and GSDM=' + QuotedStr(GszGSDM)
                                                     + ' and KJND=' + QuotedStr(GszKJND)
                                                     + ' and TZDZT in (0,1) )'
                                       + ' and GSDM=' + QuotedStr(GszGSDM) + ' and KJND=' + QuotedStr(GszKJND)
          + '; '
          + 'delete from GBI_TZDML where TZDID=' + TZDMLCDS.FieldByName('TZDID').AsString
                                     + ' and GSDM=' + QuotedStr(GszGSDM)
                                     + ' and KJND=' + QuotedStr(GszKJND)
                                     + ' and TZDZT in (0,1)';   //����ɾ�������ϻ���δ��˵�����
  PExecSql(vSQL);
  if (GiBBMode = ZGDWB) {or (GiBBMode = JCDWB)} then
  begin
    if ZBLB = zlDWZB then
    begin
      vSQL := 'delete from GBI_TZDNR where TZDID in (select TZDID from GBI_TZDML where TZDH=''' + vTZDH + ''''
                                                         + ' and GSDM<>' + QuotedStr(GszGSDM)
                                                         + ' and KJND=' + QuotedStr(GszKJND)
                                                         + ' and TZRQ=' + QuotedStr(vTZRQ)
                                                         + ' and ZBLB=''DWZB'' '
                                                         + ' and TZDZT in (0,1) '
                                                         + ' and SJLY is not null ' + ')'
                                           + ' and GSDM<>' + QuotedStr(GszGSDM) + ' and KJND=' + QuotedStr(GszKJND)
              + '; '
              + 'delete from GBI_TZDML where TZDH=''' + vTZDH + ''''
                                         + ' and GSDM<>' + QuotedStr(GszGSDM)
                                         + ' and KJND=' + QuotedStr(GszKJND)
                                         + ' and TZRQ=' + QuotedStr(vTZRQ)
                                         + ' and ZBLB=''DWZB'' '
                                         + ' and TZDZT in (0,1)'
                                         + ' and SJLY is not null';
      PExecSql(vSQL);
    end;
  end;

  GetData(0);
  PutData;
  DataStatus := doseBrowse;
end;

procedure TFormNoteItemTZ.THStringGridTZDNRSetEditText(Sender: TObject; ACol, ARow: Integer; const Value: String);
begin
  with THStringGridTZDNR do
    if (ACol = ColByName('TRJE'))
       or (ACol = ColByName('TCJE')) then
    begin
      CalcTZHZB;
    end;
end;

procedure TFormNoteItemTZ.DoPrintSet;
var
  i: Integer;
  vFJZS: string;
begin
  with FormPrint do
  begin
    ReportTitle := RxLabelTitle.Caption;
    Grid := nil;
    Grid := THStringGridTZDNR;

    //huangyh 2012-4-18 ZWR900037469  ZWR900037407  ��ӱ�����:ҳ�� �Ƶ��� �����
    OtherItems[1].Text := GCzy.Name;            //����Ա����
    OtherItems[2].Text := GszYWRQ;              //ҵ������
    OtherItems[3].Text := trim(EditBZ.Text)  ;  // ��ע    ZWR900182080  huangyh 2014-06-04

    //caption���
    OtherItems[3].Caption := '��ע��';
    OtherItems[3].Font.Size := IFF(Length(EditBZ.Text) > 24, 6, 9);


    OtherItems[5].Text := EditTZDH.Text;        //��������
    OtherItems[6].Text := LabelZDXM.Caption  ;  //�Ƶ���
    OtherItems[7].Text := LabelSHXM.Caption  ;  //�����
    OtherItems[8].Text := FormatDateTime('yyyy-MM-dd', DTPTZRQ.Date);   //��������
    //yxd ZWR900134968 ���������ˡ���������
    if Trim(edtSQR.Text) <> '' then
      OtherItems[9].Text := GetTypeValue(edtSQR.Text, gdtName)
    else
      OtherItems[9].Text := '';        //������
   //��������ڶ���Ĵ��� yxd   
    vFJZS := seFJZS.Text;
    if Length(seFJZS.Text)<10 then
      for i := Length(seFJZS.Text) to 10-1 do
        vFJZS := ' ' + vFJZS;

    OtherItems[10].Text := vFJZS;       //��������
  end;
end;

function TFormNoteItemTZ.GetUsedZBStatus(ATHGrid: TTHStringGrid; AYWRQ:string; var AAllowOper:Boolean): TStringList;
type
  TTmpZBInfo = record
  ZBDM: string;
  TRJE  : Extended;
  TCJE  : Extended;
  end;
  PTmpZBInfo = array of TTmpZBInfo;

var
  TmpZBInfo : PTmpZBInfo;
  i, vRow: Integer;
  vFindExists, bNeedJudge: Boolean;

  tmpZBDMList: string;
  tmpCDS: TClientDataSet;
  vSQL: string;
  tmpZBAllowUsedStatus: TZBAllowUsedStatus;
  tmpJE, AJE: Extended;
  ZBCheckRes: Boolean;
  tmpZBDM,tmpZBZT: string;
  CellTRJE, CellTCJE: Extended;

  JEInfo, QJInfo: string;   //ָ����Ϣ�� �ڼ���Ϣ
  AKJQJ, AYSQJ: string;    //����ڼ䡢Ԥ���ڼ�

  AIndex: Integer;     //��������
  vSJZBYE, vTRJE, vTCJE:Extended;
begin
  Result := TStringList.Create;
  Result.Clear;

  AAllowOper := GetCurQJ(FormatDateTime('yyyymmdd', DTPTZRQ.Date),AKJQJ,AYSQJ);   //Ĭ��������ͨ������

  if not AAllowOper then
    Exit;

  if ATHGrid <> nil then
    with ATHGrid do
      if RowCount > 1 then
      begin
        SetLength(TmpZBInfo, 0);
        for vRow := 1 to RowCount - 1 do
        begin
          vFindExists := False;

          GetCellValS(vRow, 'ZBDM', tmpZBDM);
          GetCellValF(vRow, 'TRJE', CellTRJE);
          GetCellValF(vRow, 'TCJE', CellTCJE);

          if tmpZBDM = '' then
            Continue;

          if High(PTmpZBInfo) >= 0 then
          begin
            for i:= Low(TmpZBInfo) to High(TmpZBInfo) do
            begin
              if tmpZBDM = TmpZBInfo[i].ZBDM then
              begin
                if CellTRJE <> 0 then
                  TmpZBInfo[i].TRJE := TmpZBInfo[i].TRJE + CellTRJE;

                if CellTCJE <> 0 then
                  TmpZBInfo[i].TCJE := TmpZBInfo[i].TCJE + CellTCJE;

                vFindExists := True;
                Break;
              end;
            end;
          end;

          if not vFindExists then
          begin
            SetLength(TmpZBInfo, High(TmpZBInfo) + 2);
            with TmpZBInfo[High(TmpZBInfo)] do
            begin
              ZBDM := tmpZBDM;
              TRJE := 0;
              TCJE := 0;

              if CellTRJE <> 0 then
                TRJE := TRJE + CellTRJE;

              if CellTCJE <> 0 then
                TCJE := TCJE + CellTCJE;
            end;
          end;

          Next;
        end;
      end;

  if GblQYZBPF then
    tmpZBZT := '3'
  else
    tmpZBZT := '2';

  //���ݼ��
  if High(TmpZBInfo) >= 0 then
  begin
    tmpZBDMList := '';
    for i := Low(TmpZBInfo) to High(TmpZBInfo) do
    begin
      //���Ȼ�ȡZBID
      if tmpZBDMList <> '' then
        tmpZBDMList := tmpZBDMList + ',';

      tmpZBDMList := tmpZBDMList + QuotedStr(TmpZBInfo[i].ZBDM);
    end;

    if tmpZBDMList <> '' then
    begin
      if (FZBLBStr='DWZB') and (GiBBMode = JCDWB) // Modified by Cheyf 2016-02-22 ����+����浥λģʽ
      and (DataModulePub.GetCountBySQL('Select * from GBI_ZTCS where Kjnd='''+GszKJND+''' and CSDM=''BBLX'' and CSZ=''0'' ') > 0) then
      vSQL := 'select XMB.ZBID, XMB.ZBDM, XMB0.SJZBID '
                + ' from GBI_ZBXMB XMB'
                + ' left join GBI_ZBXMB XMB0 on XMB0.GSDM<>XMB.GSDM and XMB0.YSDWDM=XMB.GSDM and XMB0.KJND=XMB.KJND and XMB0.ZBLB=XMB.ZBLB and XMB0.ZBID=XMB.SJZBID'
                + ' where XMB.GSDM=' + QuotedStr(GszGSDM)
                + ' and XMB.KJND=' + QuotedStr(GszKJND)
                + ' and XMB.ZT='''+tmpZBZT+''''
                + ' and XMB.ZBLB='''+FZBLBStr+''''
                + ' and XMB.ZBDM in (' + tmpZBDMList + ')'
      else
      vSQL := 'select XMB.ZBID, XMB.ZBDM, XMB.SJZBID '
                + ' from GBI_ZBXMB XMB'
                + ' where XMB.GSDM=' + QuotedStr(GszGSDM)
                + ' and XMB.KJND=' + QuotedStr(GszKJND)
                + ' and XMB.ZT='''+tmpZBZT+''''
                + ' and XMB.ZBLB='''+FZBLBStr+''''
                + ' and XMB.ZBDM in (' + tmpZBDMList + ')';
      cdsTmp.Data := DataModulePub.GetDataBySQL(vSQL);
      if cdsTmp.Active then
      begin
        tmpCDS := TClientDataSet.Create(nil);
        with tmpCDS do
        begin
          Data := cdsTmp.Data;
          cdsTmp.Close;

          if Active and (RecordCount > 0) then
          begin
            AIndex := 0;
              
            for i := Low(TmpZBInfo) to High(TmpZBInfo) do
            begin
              bNeedJudge := False;
              if Locate('ZBDM', TmpZBInfo[i].ZBDM, []) then
              begin
                tmpJE := 0;
                case DataStatus of
                  doseInsert,doseUpdate:
                  begin
                    tmpJE  := TmpZBInfo[i].TCJE;
                    JEInfo := '�洢';
                    if tmpJE > ZeroValue8 then
                      bNeedJudge := True;
                  end;
                  // ��������
                  {doseCheck:
                  begin
                    tmpJE  := TmpZBInfo[i].TCJE;
                    JEInfo := '���';
                    if tmpJE > ZeroValue8 then
                      bNeedJudge := True;                  
                  end;
                  doseUnCheck:
                  begin
                    tmpJE := TmpZBInfo[i].TRJE;
                    JEInfo := '����';
                    bNeedJudge := True;
                  end;}
                end;
                // Added by Cheyf 2013-06-09 ZWR900109410
                // ����ʱ ��׷�ӽ���Ҫ�ж�ָ������Ƿ���
                if TZDOper = '����' then
                begin
                  JEInfo := '����';
                  tmpJE := 0;
                  bNeedJudge := False;
                  if TmpZBInfo[i].TRJE > ZeroValue8 then
                  begin
                    tmpJE := TmpZBInfo[i].TRJE;
                    bNeedJudge := True;
                  end;
                end
                // ���ʱ ��׷������Ҫ�ж�ָ������Ƿ���
                else if TZDOper = '���' then
                begin
                  JEInfo := '���';
                  tmpJE := 0;
                  bNeedJudge := False;
                  if TmpZBInfo[i].TCJE > ZeroValue8 then
                  begin
                    tmpJE := TmpZBInfo[i].TCJE;
                    bNeedJudge := True;
                  end;
                end;
                JEInfo := '��ǰ' + JEInfo + 'ָ������' + FormatCurr(',0.00', tmpJE) + '��'; //��ǰ��������ָ���ָ�����������ʾ��Ϣ

                // ���ʱ ��׷�ӽ���Ҫ�ж��ϼ�ָ������Ƿ���
                if TZDOper = '���' then
                  if TmpZBInfo[i].TRJE > ZeroValue8 then
                  begin
                    if FieldByName('SJZBID').AsInteger > 0 then
                    begin
                      JEInfo := '���';
                      GetSJZBKYJE(FieldByName('SJZBID').asstring,vSJZBYE);
                      if TmpZBInfo[i].TRJE - vSJZBYE > ZeroValue8 then
                      begin
                        JEInfo := '��ǰ' + JEInfo + 'ָ������' + FormatCurr(',0.00', TmpZBInfo[i].TRJE) + '��';
                        AIndex := AIndex + 1;
                        Result.Add(IntToStr(AIndex) + '��������ָ������ϼ�ָ�꡾'+IntToStr(FieldByName('SJZBID').AsInteger)+'�����ý�' + JEInfo);
                        AAllowOper := False;
                        Exit;
                      end;
                    end;
                  end;
                // �����ʱ ��׷������Ҫ�ж��ϼ�ָ������Ƿ���
                if TZDOper = '����' then
                begin
                  if (TmpZBInfo[i].TCJE > ZeroValue8) or (TmpZBInfo[i].TRJE < ZeroValue8) then
                  begin
                    vTCJE := IFF(TmpZBInfo[i].TCJE > ZeroValue8, TmpZBInfo[i].TCJE, -TmpZBInfo[i].TRJE);
                    if FieldByName('SJZBID').AsInteger > 0 then
                    begin
                      JEInfo := '����';
                      GetSJZBKYJE(FieldByName('SJZBID').asstring,vSJZBYE);
                      if vTCJE - vSJZBYE > ZeroValue8 then
                      begin
                        JEInfo := '��ǰ' + JEInfo + 'ָ������' + FormatCurr(',0.00', vTCJE) + '��';
                        AIndex := AIndex + 1;
                        Result.Add(IntToStr(AIndex) + '��������ָ������ϼ�ָ�꡾'+IntToStr(FieldByName('SJZBID').AsInteger)+'�����ý�' + JEInfo);
                        AAllowOper := False;
                        Exit;
                      end;
                    end;
                  end;
                end;

                if bNeedJudge then
                begin
                  ZBCheckRes := TListSelectYSZBF.ZBIsAllowUsed(cdsTmp, FieldByName('ZBID').AsInteger
                                     , GszGSDM, GszKJND, AYWRQ, FZBLBStr, tmpJE, False, True, tmpZBAllowUsedStatus, AJE);
                  {//���⴦����һ��ָ�����׷������׷��ʱ���жϼ��ٶ�ʱӦ�ô���׷����ȥ׷��
                  tmpJE := TmpZBInfo[i].TCJE - TmpZBInfo[i].TRJE;
                  if tmpJE < -1*ZeroValue8 then
                    tmpJE := 0;
                  //��׷��������׷�ӽ��ʱ�����жϣ������ж�
                  if tmpJE > 0 then
                    ZBCheckRes := TListSelectYSZBF.ZBIsAllowUsed(cdsTmp, FieldByName('ZBID').AsInteger
                                     , GszGSDM, GszKJND, AYWRQ, FZBLBStr, tmpJE, tmpZBAllowUsedStatus, AJE)
                  else
                    ZBCheckRes := True;}
                end
                else //���ڵ����Ľ�������
                begin
                  ZBCheckRes := True;
                end;

                if not ZBCheckRes then
                begin
                  case tmpZBAllowUsedStatus of
                  ausNoEnough:
                    begin
                      AIndex := AIndex + 1;
                      if AJE = 0 then
                        Result.Add(IntToStr(AIndex) + '��ָ����롾' + TmpZBInfo[i].ZBDM + '��' + QJInfo + '���޿���ָ�꣬' + JEInfo)
                      else
                        Result.Add(IntToStr(AIndex) + '��ָ����롾' + TmpZBInfo[i].ZBDM + '��' + QJInfo + '�������㣬��������' + FormatCurr(',0.00', AJE) + '����' + JEInfo);
                      AAllowOper := False;
                    end;

                  ausNoFindZB:
                    begin
                      AIndex := AIndex + 1;
                      Result.Add(IntToStr(AIndex) + '��ָ����롾' + TmpZBInfo[i].ZBDM + '����鷢���������');
                      AAllowOper := False;
                    end;
                  end;
                end
                else
                begin
                  case tmpZBAllowUsedStatus of
                  ausNoEnoughButCanUse:
                    begin
                      AIndex := AIndex + 1;
                      if AJE = 0 then
                        Result.Add(IntToStr(AIndex) + '��ָ����롾' + TmpZBInfo[i].ZBDM + '��' + QJInfo + '���޿���ָ�꣬���ɼ���ʹ�ã�' + JEInfo)
                      else
                        Result.Add(IntToStr(AIndex) + '��ָ����롾' + TmpZBInfo[i].ZBDM + '��' + QJInfo +'Ԥ�����ֻ�С�' + FormatCurr(',0.00', AJE) + '�������ɼ���ʹ�ã�' + JEInfo);
                    end;
                  end;
                end;
              end
              else
              begin
                AIndex := AIndex + 1;
                Result.Add(IntToStr(AIndex) + '��ָ����롾' + TmpZBInfo[i].ZBDM + '���������ָ����ܡ������ڡ����ߡ�δ��ˡ����ߡ��Ѷ��᡿');
                AAllowOper := False;
              end;
            end;
          end;
          Free;
        end;
      end;
    end;
  end;
end;

procedure TFormNoteItemTZ.NAddClick(Sender: TObject);
var
  vZY:String;
begin
  //20170305
  THStringGridTZDNR.GetCellValS(THStringGridTZDNR.Row, 'TZZY',  vZY);
  if (vZY='') and (EditBZ.Text <> '') then
  	vZY := EditBZ.Text;
  GridOper(THStringGridTZDNR, gotAdd);
  THStringGridTZDNR.SetCellValS(THStringGridTZDNR.RowCount-1, 'TZZY',  vZY);
end;

procedure TFormNoteItemTZ.NInsertClick(Sender: TObject);
var
  vZY:String;
begin
  //20170305
  THStringGridTZDNR.GetCellValS(THStringGridTZDNR.Row, 'TZZY',  vZY);
  with THStringGridTZDNR do
  begin
    AddRow(Row);
    Rows[Row].Clear;
    if (vZY='') and (EditBZ.Text <> '') then
  		vZY := EditBZ.Text;
    THStringGridTZDNR.SetCellValS(Row, 'TZZY',  vZY);
  end;
end;

procedure TFormNoteItemTZ.MenuItem1Click(Sender: TObject);
begin
  GridOper(THStringGridTZDNR, gotDelete);
  //RefreshKYZB;
end;

procedure TFormNoteItemTZ.NCopyClick(Sender: TObject);
begin
  GridOper(THStringGridTZDNR, gotCopy);
  //RefreshKYZB;
end;

function TFormNoteItemTZ.ZBDataCheck: Boolean;
begin
  Result := False;
  //���ָ�����Ƿ�����

  {if not GbCanUndo_Others_SH and (AZT = tosUnCheck) and (LabelSHXM.Caption <> GCzy.name) then
  begin
    Application.MessageBox(PChar('����˺������˱���Ϊͬһ�ˣ���ֹ���������'), PChar('��ʾ'), MB_OK + MB_ICONWARNING);
    Exit;
  end;}

  with TStringList.Create do
  begin
    Assign(GetUsedZBStatus(THStringGridTZDNR, FormatDateTime('yyyymmdd', DTPTZRQ.Date), Result));
    if Count > 0 then
      Application.MessageBox(PChar(Text), PChar('��ʾ'), MB_OK + MB_ICONWARNING);
    Free;
  end;
end;

procedure TFormNoteItemTZ.actHelpExecute(Sender: TObject);
begin
  Application.HelpContext(55);
end;

procedure TFormNoteItemTZ.actEditExecute(Sender: TObject);
begin
  DataStatus := doseUpdate;
  CalcTZHZB;
end;

procedure TFormNoteItemTZ.EditTZDHKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', 'a'..'z', 'A'..'Z', #8, #13]) then
    Key := #0;
end;

procedure TFormNoteItemTZ.NPrintClick(Sender: TObject);
begin
  if HasSetZDYBB('GBI_TZD_' + FZBLBStr) then
  begin
    try
      TPrintObj.Print('GBI_TZD_' + FZBLBStr, GetDJMLNRSQL(FZBLBStr, StrToIntDef(edtTZDID.Text, 0))) ;
    except
      SysMessage('����ʧ�ܣ������ԡ�', '_JG', [mbOK]);
    end;
  end
  else
  begin
    DoFormPrintSet;
    if FormPrint.PrintSetup then
    begin
      FormPrint.Prepare;
      FormPrint.Print ;
    end;
  end;
end;

procedure TFormNoteItemTZ.actAnnexExecute(Sender: TObject);
begin
  //����
  with TfrmFilesF.Create(nil) do
  begin
    PutData(edtTZDID.Text, DJ_TZD, DataStatus = doseInsert, RxLabelTitle.Caption, EditTZDH.Text, AnnexData);
    ShowModal;
    if DataStatus = doseInsert then
      AnnexData := dsMain.Data;
    Free;
  end;
end;

procedure TFormNoteItemTZ.actMultiSelectExecute(Sender: TObject);
var
  j: Integer;
  tempBookMark : TbookMark;
  vZBID :String;
  bfbje: Extended;  //�ٷֱȽ��
  vZY:String;
begin
  with TGBI_ListSelectYSZBF.Create(nil) do
  begin  
    if Sender = actMultiSelect then
    begin
      gridZB.Options := gridZB.Options + [dgMultiSelect];
      pnlSelect.Visible := True;
    end;
    FSelZBLB := FZBLB;
    FSelZBLBStr := FZBLBStr;
    CurTZRQ := FormatDateTime('yyyyMMdd', DTPTZRQ.Date);
    InitForm;
    THStringGridTZDNR.GetCellValS(THStringGridTZDNR.Row, 'TZZY', vZY);
    //20170305
    if (vZY='') and (EditBZ.Text <> '') then
    	vZY := EditBZ.Text;
    if ShowModal = mrOK then
    begin
      for j := 1 to gridZB.SelectedRows.Count do
      begin
        bfbje :=0;
        THStringGridTZDNR.GetCellValS(THStringGridTZDNR.Row, 'ZBID', vZBID);
        if (vZBID <> '') or (j > 1) then
          THStringGridTZDNR.RowCount := Self.THStringGridTZDNR.RowCount + 1
        else
          THStringGridTZDNR.RowCount := Self.THStringGridTZDNR.RowCount;

        ClientDataSet.Bookmark := gridZB.SelectedRows.Items[j-1];
        TempBookmark := ClientDataSet.GetBookmark;
        ClientDataSet.GotoBookmark(TempBookmark);

        Self.THStringGridTZDNR.SetCellVals(Self.THStringGridTZDNR.RowCount-1,'SJKYJE','');

        Self.THStringGridTZDNR.SetCellValF(Self.THStringGridTZDNR.RowCount-1,'KYJE',
           ClientDataSet.FieldByName('KYJE').AsCurrency);

        if edtBfb.Value>0 then    //ZWR900141352 huangyh 2013-12-30
          bfbje := (edtBfb.Value * ClientDataSet.FieldByName('KYJE').AsCurrency)/100;

        if rbTZ.Checked then   //����
        begin
          Self.THStringGridTZDNR.SetCellValF(Self.THStringGridTZDNR.RowCount-1, 'TRJE', bfbje);
          Self.THStringGridTZDNR.SetCellValS(Self.THStringGridTZDNR.RowCount-1, 'TCJE', '');
        end else
        begin
          Self.THStringGridTZDNR.SetCellValF(Self.THStringGridTZDNR.RowCount-1, 'TCJE', bfbje);
          Self.THStringGridTZDNR.SetCellValS(Self.THStringGridTZDNR.RowCount-1, 'TRJE', '');
        end;

        Self.THStringGridTZDNR.SetCellValS(Self.THStringGridTZDNR.RowCount-1, 'TZZY', vZY);    //ά����:20120223195628  hyh 2012-3-5 ��ʼ��������¼�е�����
       // Self.THStringGridTZDNR.SetCellValS(Self.THStringGridTZDNR.RowCount-1, 'TRJE', '');
       // Self.THStringGridTZDNR.SetCellValS(Self.THStringGridTZDNR.RowCount-1, 'TCJE', '');

        PutZBInfo(ClientDataSet, Self.THStringGridTZDNR.RowCount-1, THStringGridTZDNR);
            
        ClientDataSet.FreeBookmark(TempBookmark);
      end;
      CalcTZHZB;
    end;
    Free;
  end;

  //RefreshKYZB;
end;

procedure TFormNoteItemTZ.DoFormPrintSet;
begin
  DoPrintSet;
end;

procedure TFormNoteItemTZ.FormPrintBeforePrintItems(Sender: TObject);
begin
  DoFormPrintSet;
end;
       
procedure TFormNoteItemTZ.SetZBLB(const Value: TZBLB);
begin
  FZBLB := Value;
  case FZBLB of
    zlZZB:
    begin
      Self.Caption := '��ָ�������';
      RxLabelTitle.Caption := '��ָ�������';
      FZBLBStr := 'ZZB';
    end;
    zlDWZB:
    begin
      Self.Caption := '��λָ�������';
      RxLabelTitle.Caption := '��λָ�������';
      FZBLBStr := 'DWZB';
    end;
    zlMXZB:
    begin
      Self.Caption := '��ϸָ�������';
      RxLabelTitle.Caption := '��ϸָ�������';
      FZBLBStr := 'MXZB';
    end;
  end;
  FormPrint.OtherItems[4].Caption := RxLabelTitle.Caption;
end;

procedure TFormNoteItemTZ.CalcTZHZB;
var
  vTRJE, vTCJE, vKYJE, vTZH: Extended;
  i: Integer;
begin
  with THStringGridTZDNR do
  begin
    for i := 1 to RowCount -1 do
    begin
      vTRJE := 0;
      vTCJE := 0;
      vKYJE := 0;
      GetCellValF(i,'TRJE',vTRJE);
      GetCellValF(i,'TCJE',vTCJE);
      GetCellValF(i,'KYJE',vKYJE);

      vTZH := vKYJE + vTRJE - vTCJE;

      SetCellValF(i,'ZBTZH',vTZH);
    end;

    ShowDynHJ;
  end;
end;

procedure TFormNoteItemTZ.SetDataStatus(const Value: TDataOperStatusExtend);
var
  vBool: Boolean;
  HasData: Boolean;
  vFirst, vPrious, vNext, vLast: Boolean;
  tmpZTStatus: TTZDStatus;
  //��ťȨ��
  bQXNew, bQXUpdate, bQXSH, bQXXS, bQXZF, bQXHY, bQXDelete: Boolean;
begin
  FDataStatus := Value;

  vBool := (FDataStatus = doseInsert) or (FDataStatus = doseUpdate);

  actFLJE.Enabled := not vBool;

  DTPTZRQ.Enabled := vBool;

  seFJZS.Enabled := vBool;

  edtSQR.Enabled := vBool;

  EditTZDH.Enabled := vBool;
  if EditTZDH.Enabled then
    EditTZDH.MaxLength := GiTZDHMRCD
  else
    EditTZDH.MaxLength := 0;

  EditTZDH.ReadOnly := GblZDBZTZDH and vBool;
  if EditTZDH.ReadOnly then
    EditTZDH.Color := clBtnFace
  else
    EditTZDH.Color := clWhite;

  edtTZDID.Enabled := vBool;
  EditBZ.Enabled := vBool;

  THStringGridTZDNR.ReadOnly := not vBool;

  HasData := False;
  vFirst := False;
  vPrious := False;
  vNext := False;
  vLast := False;

  tmpZTStatus := tosBrowse;  //��ǰ��ʾ�ļ�¼״̬
  with TZDMLCDS do
    if Active then
    begin
      HasData := RecordCount>0;
      if HasData then
      begin
        vFirst := Bof;
        vPrious := not Bof;
        vNext := not Eof;
        vLast := Eof;

        case FieldByName('TZDZT').AsInteger of
        0: tmpZTStatus := tosRubbit;             //������
        1: tmpZTStatus := tosUnCheck;            //δ���
        2: tmpZTStatus := tosCheck;              //�����
        end;
      end;
    end;

  with THStringGridTZDNR do
    if vBool then
    begin
      ShowCol('KYJE');
      ShowCol('SJKYJE');
      ShowCol('ZBTZH');
      MoveColumn(ColByName('SJKYJE'), 2);      
      MoveColumn(ColByName('KYJE'), 4);
      MoveColumn(ColByName('ZBTZH'), 6);
    end
    else
    begin
      HideCol('KYJE');
      HideCol('SJKYJE');
      HideCol('ZBTZH');
    end;

  THBevelZX.Visible := (not vBool) and HasData;

  if vBool
     or
     (TZDMLCDS.Active and (TZDMLCDS.RecordCount>0) and (TZDMLCDS.FieldByName('TZDZT').AsInteger=1))
  then
    THStringGridTZDNR.PopupMenu := PopupMenu
  else
    THStringGridTZDNR.PopupMenu := nil;
    
  //����Ȩ��
  bQXNew    := ((FZBLB=zlZZB) and (TPower.GetPower('62037')))
               or ((FZBLB=zlDWZB) and (TPower.GetPower('62029')))
               or ((FZBLB=zlMXZB) and (TPower.GetPower('62021')));
  bQXUpdate := ((FZBLB=zlZZB) and (TPower.GetPower('62038')))
               or ((FZBLB=zlDWZB) and (TPower.GetPower('62030')))
               or ((FZBLB=zlMXZB) and (TPower.GetPower('62022')));
  bQXSH     := ((FZBLB=zlZZB) and (TPower.GetPower('62039')))
               or ((FZBLB=zlDWZB) and (TPower.GetPower('62031')))
               or ((FZBLB=zlMXZB) and (TPower.GetPower('62023')));
  bQXXS     := ((FZBLB=zlZZB) and (TPower.GetPower('62040')))
               or ((FZBLB=zlDWZB) and (TPower.GetPower('62032')))
               or ((FZBLB=zlMXZB) and (TPower.GetPower('62024')));
  bQXZF     := ((FZBLB=zlZZB) and (TPower.GetPower('62041')))
               or ((FZBLB=zlDWZB) and (TPower.GetPower('62033')))
               or ((FZBLB=zlMXZB) and (TPower.GetPower('62025')));
  bQXHY     := ((FZBLB=zlZZB) and (TPower.GetPower('62042')))
               or ((FZBLB=zlDWZB) and (TPower.GetPower('62034')))
               or ((FZBLB=zlMXZB) and (TPower.GetPower('62026')));
  bQXDelete := ((FZBLB=zlZZB) and (TPower.GetPower('62043')))
               or ((FZBLB=zlDWZB) and (TPower.GetPower('62035')))
               or ((FZBLB=zlMXZB) and (TPower.GetPower('62027')));

  actPreview.Enabled     := not vBool;
  actPrint.Enabled       := not vBool;
  actNew.Enabled         := (not vBool) and (GszDwysYearJzBz = '0') and bQXNew;
  actEdit.Enabled        := (not vBool) and (GszDwysYearJzBz = '0') and (tmpZTStatus=tosUnCheck) and bQXUpdate;
  actMultiSelect.Enabled := vBool and (GszDwysYearJzBz = '0') and bQXUpdate;
  actSave.Enabled        := vBool and (GszDwysYearJzBz = '0') and (bQXNew or bQXUpdate);
  actCancel.Enabled      := vBool and (GszDwysYearJzBz = '0') and (bQXNew or bQXUpdate);
  actInput.Enabled       := vBool and (GszDwysYearJzBz = '0') and (bQXNew or bQXUpdate);

  actCheck.Enabled      := (not vBool) and (GszDwysYearJzBz = '0') and HasData and (tmpZTStatus=tosUnCheck) and bQXSH;
  actUnCheck.Enabled    := (not vBool) and (GszDwysYearJzBz = '0') and HasData and (tmpZTStatus=tosCheck) and bQXXS;
  actRubbit.Enabled     := (not vBool) and (GszDwysYearJzBz = '0') and HasData and (tmpZTStatus=tosUnCheck) and bQXZF;
  actHY.Enabled         := (not vBool) and (GszDwysYearJzBz = '0') and HasData and (tmpZTStatus=tosRubbit) and bQXHY;
  actDelete.Enabled     := (not vBool) and (GszDwysYearJzBz = '0') and HasData and (tmpZTStatus=tosRubbit) and bQXDelete;

  actFirst.Enabled      := (not vBool) and HasData and (not vFirst);
  actPrious.Enabled     := (not vBool) and HasData and vPrious;
  actNext.Enabled       := (not vBool) and HasData and vNext;
  actLast.Enabled       := (not vBool) and HasData and (not vLast);
end;

{procedure TFormNoteItemTZ.edtSQRButtonClick(Sender: TObject);
var
  vHasChange: Boolean;
  SelValue: string;
begin
  SelValue := GetQXData('ZY', False, GiJCZLXZFS, vHasChange, TSMaskEdit(Sender));    //����
  if vHasChange then
    edtSQR.Text := SelValue;
end;}
procedure TFormNoteItemTZ.edtSQRButtonClick(Sender: TObject);
var
  vCds:TClientDataSet;
  szSQL:String;
  SelVar:variant;  
begin
  //hch �Ż�ѡ��ĸ�������
  vCds := DataModulePub.GetCds;
  try
    szSQL := 'Select ZYDM, ZYXM, ZJM from PUBZYXX where GSDM='+QuotedStr(GszGSDM)
      +' and KJND='+QuotedStr(GszKJND);
    GFileDataCache.GetCacheDataBySQL(vCds, szSQL, 'PUBZYXX');
    SelVar := SelectLstGrd(vCds.Data, 'ZYDM, ZYXM, ZJM', False, '', edtSQR.Text);
    if VarIsArray(SelVar) then
    begin
      edtSQR.Text := SelVar[0][0]+'['+SelVar[0][1]+']';
    end;
    Exit;
  finally
    vCds.Free;
  end;
end;

procedure TFormNoteItemTZ.GetZBKYJE(AZBID: String; var AKYJE,
  ASJKYJE: Extended);
var
  vSQL: String;
begin
  if AZBID <> '' then
  begin
    vSQL := TListSelectYSZBF.GetQueryKYJESql(AZBID, FZBLBStr);
    with DataModulePub.ClientDataSetTmp do
    begin
      POPenSql(DataModulePub.ClientDataSetTmp, vSQL);
      if RecordCount > 0 then
      begin
        AKYJE := FieldByName('KYJE').AsCurrency;
        ASJKYJE := FieldByName('SJKYJE').AsCurrency;
      end
      else
      begin
        AKYJE := 0.00;
        ASJKYJE := 0.00;
      end;
    end;
  end
  else
  begin
    AKYJE := 0.00;
    ASJKYJE := 0.00;
  end;
end;

procedure TFormNoteItemTZ.InitGrid;
var
  vSQL: String;
begin
  CreateGridColumn(THStringGridTZDNR, 'YSFA','Ԥ�㷽��', 100, 0, 0, False, True, False);
  CreateGridColumn(THStringGridTZDNR, 'ZBID','ָ��ID', 200, 20, 0, False, True, False);
  vSQL := 'select distinct YSLX, YSMC from GBI_FAQYYS where GSDM='''+GszGSDM+''' and KJND='''+GszKJND+''' '
    +'and ZBLB='''+FZBLBStr+''' ';
  cdsTmp.Data := DataModulePub.GetDataBySQL(vSQL);
  if cdsTmp.Active and (cdsTmp.RecordCount > 0) then
  begin
    cdsTmp.First;
    while not cdsTmp.Eof do
    begin
      CreateGridColumn(THStringGridTZDNR, cdsTmp.FieldByName('YSLX').AsString,
        cdsTmp.FieldByName('YSMC').AsString, 100, 0, 0, False, {False}True, False);
      cdsTmp.Next;
    end;
  end;
  THStringGridTZDNR.HideCol('ZBID');
end;

procedure TFormNoteItemTZ.edtSQRExit(Sender: TObject);
begin
  //
end;

procedure TFormNoteItemTZ.GetSJZBKYJE(AZBID: String; var AKYJE: Extended);
var
  vSQL, vGSDM: String;
begin
  if AZBID <> '' then
  begin
    if FZBLBStr = 'MXZB' then
      vSQL := TListSelectYSZBF.GetQueryKYJESql(AZBID, 'DWZB')
    else if FZBLBStr = 'DWZB' then
    begin
      try
        vGSDM := GszGSDM;
        if (GiBBMode=JCDWB) and (vZGDWDM<>'') then  // Modified by Cheyf 2016-02-22 ��ָ�겻�ܰ����㵥λ�����
          GszGSDM := vZGDWDM;
        vSQL := TListSelectYSZBF.GetQueryKYJESql(AZBID, 'ZZB');
      finally
        GszGSDM := vGSDM;
      end;
    end
    else
      AKYJE := 0.00;
    with DataModulePub.ClientDataSetTmp do
    begin
      POPenSql(DataModulePub.ClientDataSetTmp, vSQL);
      if RecordCount > 0 then
      begin
        AKYJE := FieldByName('KYJE').AsCurrency;
      end
      else
      begin
        AKYJE := 0.00;
      end;
    end;
  end
  else
    AKYJE := 0.00;
end;

function TFormNoteItemTZ.GetSJZBID(AZBID, AZBLB: String): String;
var
  vSQL: String;
begin
  Result := '0';
  vSQL := 'select SJZBID from GBI_ZBXMB'
                + ' where GSDM=' + QuotedStr(GszGSDM)
                + ' and KJND=' + QuotedStr(GszKJND)
                + ' and ZBLB=' + QuotedStr(AZBLB)
                + ' and ZBID =' + QuotedStr(AZBID);
  with DataModulePub.ClientDataSetTmp do
  begin
    POpenSql(DataModulePub.ClientDataSetTmp, vSQL);
    if RecordCount > 0 then
    begin
      Result := FieldByName('SJZBID').AsString;
    end;
  end;
end;

function TFormNoteItemTZ.HasSetZDYBB(const aPrintSign: string): Boolean;
var
  vSQL: string;
begin
  Result := False;

  vSQL := 'select count(*) as CNT from PUB_RMINFO where RPT_MOD=''GBI'' and RPT_USE=' + QuotedStr(aPrintSign) + ' and GSDM=' + QuotedStr(GszGSDM);
  POpenSql(DataModulePub.ClientDataSetTmp,vSQL);
  with DataModulePub.ClientDataSetTmp do
  begin
    if FieldByName('CNT').AsInteger > 0 then
      Result := True;
    Close;
  end;  
end;

function TFormNoteItemTZ.GetDJMLNRSQL(AZBLB: string;
  ATZDID: Integer): String;
begin
  if GDbType = MSSQL then
  begin
  Result := 'EXEC GBISP_TZDMLNR '
  + '''' + GszGSDM + ''','
  + '''' + GszKJND + ''','
  + '''' + AZBLB + ''','
  + IntToStr(ATZDID);
  Result := 'SET NOCOUNT ON;   ' + Result + ';   SET NOCOUNT OFF; ';
  end
  else if GDbType = ORACLE then
  begin
    Result := 'begin GBISP_TZDMLNR('
    + '''' + GszGSDM + ''','
    + '''' + GszKJND + ''','
    + '''' + AZBLB + ''','
    + IntToStr(ATZDID) + ','
    + ':pRecCur' + ');'
    + 'end;'; 
  end;
end;

function TFormNoteItemTZ.DoCheckZBYE(var vErrorZB: String): Boolean;
var
  AZBDM, AZBID: string;
  AZBYE, ASJYE, ATCJE: Extended;
  iRow: Integer;
  CdsZB: TClientDataSet;
begin
  Result := True;
  vErrorZB := '';
  //��ȡָ�곬����Ʒ�ʽ
  CdsZB := DataModulePub.GetCdsBySQL('Select ZBID, CYSKZFS from GBI_ZBXMB where GSDM='+QuotedStr(GszGSDM)
        + ' and KJND='+QuotedStr(GszKJND)
        + ' and ZBLB='+QuotedStr(FZBLBStr)
        + ' and ZBID in (Select ZBID from GBI_TZDNR where GSDM='+QuotedStr(GszGSDM)
        + ' and KJND='+QuotedStr(GszKJND)
        + ' and TZDID='+edtTZDID.Text
        + ')');
  with THStringGridTZDNR do
  begin
    for iRow := 1 to RowCount - 1 do
    begin
      GetCellValS(iRow, 'ZBID', AZBID);
      GetCellValS(iRow, 'ZBDM', AZBDM);
      GetCellValF(iRow, 'KYJE', AZBYE);
      if AZBYE >= 0 then
        GetZBKYJE(AZBID, AZBYE, ASJYE);
      GetCellValF(iRow, 'TCJE', ATCJE);
      if AZBDM <> '' then
      begin
        CdsZB.Filtered := False;
        CdsZB.Filter := '';
        if (AZBYE < 0) and (ATCJE > 0) then
        begin
          if CdsZB.Locate('ZBID', AZBID, []) then
          begin
            if CdsZB.FieldByName('CYSKZFS').AsInteger = 0 then
            begin
              vErrorZB := AZBDM;
              Result := False;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;
  CdsZB.Free;
end;

procedure TFormNoteItemTZ.LocateFLJE;
var
  bSearch: Boolean;
  i: Integer;
  //�н��
  rowJE, fJ, fD: Extended;
  //������
  iJCol, iDCol, curCol: Integer;
  iFoundRow, iFoundCol: Integer;
  iStartRow: Integer;
begin
  //�Ƿ���в�ѯ������
  bSearch := FLJEQuery.IsEnabled;
  if not bSearch then
    with TfrmGBIFLJEQuery.Create(nil, FLJEQuery) do
      bSearch := (ShowModal = mrOK) and FLJEQuery.IsEnabled;
  //�����Ҫ��������ô��ʼ����
  if bSearch then
  with THStringGridTZDNR do
  begin
    //�ȼ�������������λ��
    iJCol := ColByName('TRJE');
    iDCol := ColByName('TCJE');
    iFoundRow := 0;
    iFoundCol := 0;
    iStartRow := Row + IfThen((Col < iJCol) and (Col < iDCol), 0, 1);
    for i := iStartRow to RowCount - 1 do
    begin
      GetCellValF(i, 'TRJE', fJ);
      GetCellValF(i, 'TCJE', fD);
      curCol := IfThen(fJ = 0.00, iDCol, iJCol);
      rowJE  := IfThen(fJ = 0.00, fD, fJ);
      if FLJEQuery.EnabledEndJE then
      begin
        if (FLJEQuery.StartJE <= rowJE) and (rowJE <= FLJEQuery.EndJE) then
        begin
          iFoundRow := i;
          iFoundCol := curCol;
          Break;
        end;
      end
      else if Abs(rowJE - FLJEQuery.StartJE) < 0.0001 then
        begin
          iFoundRow := i;
          iFoundCol := curCol;
          Break;
        end;
    end;

    if iFoundRow = 0 then
      Application.MessageBox(PChar('�Ѿ�û�����������Ľ�'), PChar('��ʾ'), MB_ICONWARNING + MB_OK)
    else
    begin
      Col := curCol;
      Row := iFoundRow;
    end;
  end;
end;

procedure TFormNoteItemTZ.ShowDynHJ;
var
  fTRSumJE, fTCSumJE, fTRJE, fTCJE: Extended;
  i: Integer;
begin
  fTRSumJE := 0.00;
  fTCSumJE := 0.00;
  with THStringGridTZDNR do
    for i := 1 to RowCount - 1 do
    begin
      GetCellValF(i, 'TRJE', fTRJE);
      GetCellValF(i, 'TCJE', fTCJE);
      fTRSumJE := fTRSumJE + fTRJE;
      fTCSumJE := fTCSumJE + fTCJE;
    end;
  LabelSRHJ.Caption := Format('%.2f', [fTRSumJE]);
  LabelZCHJ.Caption := Format('%.2f', [fTCSumJE]);
end;

{ TZBTZList }

procedure TZBTZList.AddRec(AZBTZRec: TZBTZRec);
begin
  Self.Add(AZBTZRec);
end;

function TZBTZList.GetTZJE(ASJZBID: Integer): Extended;
var
  i:Integer;
begin
  Result := 0;
  for i := 0 to Count - 1 do
  begin
    if TZBTZRec(Items[i]).SJZBID = ASJZBID then
      Result := TZBTZRec(Items[i]).TZJE;
  end;
end;

procedure TFormNoteItemTZ.NprintNewClick(Sender: TObject);
begin
  NprintNew.Checked :=true;
  try
    TPrintObj.PrintSet('GBI_TZD_' + FZBLBStr, GetDJMLNRSQL(FZBLBStr, StrToIntDef(edtTZDID.Text, 0)));
  except
    SysMessage('����ʧ�ܣ������ԡ�', '_JG', [mbOK]);
  end;
end;

procedure TFormNoteItemTZ.edtSQRKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  vSQR:string;
  szsql:string;
begin
  if Key = 13 then       // ZWR900169282 huangyh 2014-4-24
  begin
    if Pos('[', edtSQR.Text)>0 then
       vSQR := GetTypeValue(edtSQR.Text, gdtCode)
    else
       vSQR := edtSQR.Text;
       
    //����¼��ְԱ�������Ϣ��ѯְԱ�����ֻ��һ��ֱ�ӵ���һ��Ŀ��д�����ʱ����ѡ����
    if vSQR<>''then
    begin
      szsql := format('Select ZYDM, ZYXM from PUBZYXX where GSDM=''%s'' and KJND=''%s'' and (zydm like ''%s%s'' or zyxm like ''%s%s'') '
                  ,[GszGSDM,GszKJND,vSQR,'%',vSQR,'%']);
      popensql(cdstmp,szsql);
      if cdstmp.RecordCount=1 then
      begin
        edtSQR.Text := cdstmp.fieldbyname('ZYDM').asstring +'['+cdstmp.fieldbyname('ZYXM').asstring+']';
        EditBZ.SetFocus ;
      end
      else
      if cdstmp.RecordCount=0 then   //û��ƥ��ʱ�����ʾȫ����ѡ��
      begin
        edtSQR.Text :='';
        edtsqr.OnButtonClick(Sender);
      end else
        edtsqr.OnButtonClick(Sender);
    end
    else
      edtsqr.OnButtonClick(Sender);

  end;
end;

procedure TFormNoteItemTZ.EditBZKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then          // ZWR900169282 huangyh 2014-4-24
    THStringGridTZDNR.SetFocus ;
end;

procedure TFormNoteItemTZ.NprintOldClick(Sender: TObject);
begin
  NprintOld.Checked :=true;

    DoFormPrintSet;
    if FormPrint.PrintSetup then
    begin
  //    FormPrint.Prepare;
  //    FormPrint.Print ;
    end;
end;

{ TGBI_TZD_FL_JE_QUERY }

constructor TGBI_TZD_FL_JE_QUERY.Create;
begin
  inherited;
  IsEnabled    := False;
  StartJE      := 0.00;
  EnabledEndJE := False;
  EndJE        := 0.00;
end;

procedure TFormNoteItemTZ.actFLJEExecute(Sender: TObject);
begin
  //��¼����ѯ
  with TfrmGBIFLJEQuery.Create(nil, FLJEQuery) do
    if ShowModal = mrOK then
      LocateFLJE;
end;

procedure TFormNoteItemTZ.THStringGridTZDNRDrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect; State: TGridDrawState);
var
  r:TRect;
  sColor, sCellValue:string;
  fJ, fD, fJE: Extended;
begin
//  if (Row > 0) and FLJEQuery.IsEnabled and (not (FDataStatus in [doseInsert, doseUpdate])) then
//  begin
//    rect := (Sender as TTHStringGrid).CellRect(Col,Row);
//
//    with (Sender as TTHStringGrid) do
//    begin
//      GetCellValF(Row, GridCols.Items[Col].ColName, fJ);
//      GetCellValF(Row, GridCols.Items[Col].ColName, fD);
//      fJE := IfThen(fJ = 0.00, fD, fJ);
//
//      with (Sender as TTHStringGrid).Canvas do
//      begin
//        Brush.Color := clRed;
//        FillRect(rect);
//        SetRect(r,Rect.Left+2,Rect.Top+1,Rect.Right-2,Rect.Bottom-1);
//        //sCellValue := (Sender as TTHStringGrid).Cols[Col][row];
//        GetCellValS(Row, GridCols.Items[Col].ColName, sCellValue);
//        // DT_CENTER:ˮƽ����   DT_SINGLELINE  DT_VCENTER����ֱ����  DT_WORD_ELLIPSIS��ʡ�Ժ�
//        case (Sender as TTHStringGrid).GridCols[Col].DataTypePro of
//        dpDecimal:  DrawText(Handle,PAnsiChar(sCellValue),-1,R,DT_SINGLELINE or DT_RIGHT or DT_VCENTER);
//        dpOrderNo:  DrawText(Handle,PAnsiChar(sCellValue),-1,R,DT_SINGLELINE or DT_CENTER or DT_VCENTER);
//        else        DrawText(Handle,PAnsiChar(sCellValue),-1,R,DT_SINGLELINE or DT_VCENTER);
//        end;
//      end;
//    end;
//  end;
end;

procedure TFormNoteItemTZ.NDataOutClick(Sender: TObject);
begin
  FormPrintDataOut.Grid := THStringGridTZDNR;
  FormPrintDataOut.OtherItems[0].Text := GszGSDM + ' ' + GszHSDWMC;
  FormPrintDataOut.OtherItems[1].Text := GszKJND;
  HFExpandPrintData.Execute;
end;

{ TTZD_Imp }

function TTZD_Imp.Check: Boolean;
var
  sIDList: string;
  sSQL: string;
begin
  Result := inherited Check;
  //������е�ָ��ID�Ƿ񶼴��ڣ�
  sIDList := GetZBIDList;
  if sIDList <> '' then
  begin
    sSQL := 'select ZBID.* from (' + sIDList + ') ZBID'
            + ' where not exists(select 1 from GBI_ZBXMB xmb'
                             + ' where GSDM=' + QuotedStr(GszGSDM)
                             + ' and KJND=' + QuotedStr(GszKJND)
                             + ' and ZBLB=' + QuotedStr(GetZBLB)
                             + ' and xmb.ZBID=ZBID.ZBID'
                             + ')';
    with DataModulePub.ClientDataSetTmp do
      try
        POpenSql(DataModulePub.ClientDataSetTmp, sSQL);
        Result := RecordCount = 0;
        while not Eof do
        begin
          ErrLists.Add('ָ��' + FieldByName('ZBID').AsString + '�����ڣ���ɾ�������±༭');
          Next;
        end;
        Close;
        if not Result then
          Exit;
      finally
        Close;
      end;
  end;
  Result := True;
end;

constructor TTZD_Imp.Create(AGrid: TTHStringGrid; AZBLB: TZBLB);
begin
  inherited Create('GBI_TZDNR', 'TZDID', '0.00 as TZS, 0.00 as TJS, ' + GetYLField + ' as TZZY');
  FGrid := AGrid;
  FZBLB := AZBLB;
  AddValue('��λ����', 'C','GSDM', 20, GszGSDM, False);
  AddValue('���', 'C','KJND', 4, GszKJND, False);
  AddValue('ժҪ', 'C','TZZY', 200);
  AddValue('ָ��ID', 'C','ZBID', 30);
  AddValue('����', 'N','TZS', 20);
  AddValue('����', 'N','TJS', 20);
end;

function TTZD_Imp.GetFirstOperRow: Integer;
var
  iRow: Integer;
  tmpZBDM: string;
begin
  Result := 0;
  if Assigned(FGrid) then
    with FGrid do
    begin
      iRow := RowCount - 1;   //ֻ������һ��
      GetCellValS(iRow, 'ZBDM', tmpZBDM);
      if tmpZBDM = '' then
        Result := iRow;
    end;
end;

function TTZD_Imp.GetYLField: string;
begin
  Result := 'cast('''' as varchar' + IFF(GDbType=ORACLE, '2', '') + '(200))';
end;

function TTZD_Imp.GetZBDM: TClientDataSet;
var
  sSQL: string;
begin
  sSQL := 'select ZBID.*, xmb.ZBDM from (' + GetZBIDList + ') zbid'
            + ', (select ZBID,ZBDM from GBI_ZBXMB xmb'
                  + ' where GSDM=' + QuotedStr(GszGSDM)
                  + ' and KJND=' + QuotedStr(GszKJND)
                  + ' and ZBLB=' + QuotedStr(GetZBLB)
                  + ') xmb'
            + ' where zbid.ZBID=xmb.ZBID';
  Result := TClientDataSet.Create(nil);
  with Result do
    try
      POpenSql(Result, sSQL);
    finally
    end;
end;

function TTZD_Imp.GetZBIDList: string;
begin
  Result := '';
  with cdsData do
    if Active then
    begin
      FindFirst;
      while not Eof do
      begin
        Result := Result
                  + IFF(Result <> '', ' union ', '')
                  + 'select ''' + FieldByName('ZBID').AsString + ''' as ZBID' + IFF(GDbType = ORACLE, ' from dual', '');
        Next;
      end;
      FindFirst;
    end;
end;

function TTZD_Imp.GetZBLB: string;
begin
  Result := CONST_ZBLB_FLAG[Ord(FZBLB)];
end;

function TTZD_Imp.HasData: Boolean;
begin
  Result := False;
  with cdsData do
    if Active then
    begin
      Result := RecordCount > 0;
      FindFirst;
    end;
end;

function TTZD_Imp.Save: Boolean;
var
  iFirstRow, iBeginRow: Integer;
  cdsZBDM: TClientDataSet;
  sZBID, sZBDM: string;
  sKeyWord: Word;
begin
  //��ʼ��
  Result := False;
  if HasData then
  begin
    iFirstRow := GetFirstOperRow;
    if iFirstRow = 0 then      //û�п��ÿ���
    begin
      FGrid.RowCount := FGrid.RowCount + 1;
      iFirstRow := FGrid.RowCount - 1;
    end;
    FGrid.RowCount := FGrid.RowCount + cdsData.RecordCount - 1;
    with cdsData do
    begin
      FindFirst;
      cdsZBDM := GetZBDM;
      sKeyWord := 13;
      iBeginRow := iFirstRow;
      while not Eof do
      begin
        sZBID := FieldByName('ZBID').AsString;
        cdsZBDM.Locate('ZBID', VarArrayOf([sZBID]), [loCaseInsensitive, loPartialKey]);
        sZBDM := cdsZBDM.FieldByName('ZBDM').AsString;

        FGrid.Rows[iFirstRow].Clear;
        FGrid.SetCellValS(iFirstRow, 'ZBDM', sZBDM);
        FGrid.Col := FGrid.ColByName('ZBDM');
        FGrid.Row := iFirstRow;
        FGrid.OnKeyDown(FGrid, sKeyWord, []);

        //���ժҪ
        FGrid.SetCellValS(iFirstRow, 'TZZY', FieldByName('TZZY').AsString);
        //�����
        FGrid.SetCellValF(iFirstRow, 'TRJE', FieldByName('TZS').AsFloat);
        FGrid.SetCellValF(iFirstRow, 'TCJE', FieldByName('TJS').AsFloat);
        FGrid.Col := FGrid.ColByName('TCJE');
        FGrid.OnSetEditText(FGrid, FGrid.Col, iFirstRow, FieldByName('TJS').AsString);

        iFirstRow := iFirstRow + 1;
        Next;
      end;
      FGrid.Row := iBeginRow;
      cdsZBDM.Close;
      cdsZBDM.Free;
    end;
  end;
  //���շ���
  Result := True;
end;

procedure TFormNoteItemTZ.actInputExecute(Sender: TObject);
var
  TZDImp: TTZD_Imp;
begin
  //������Ŀ��
  try
    TZDImp := TTZD_Imp.Create(THStringGridTZDNR, FZBLB);
    LoadImortFrmFile(TZDImp);
  finally
    TZDImp.Free;
  end;
end;

procedure TFormNoteItemTZ.actZeroExecute(Sender: TObject);
var
  iRow: Integer;
  fValue: Extended;
begin
  //�жϵ�ǰ״̬
  if DataStatus in [doseInsert, doseUpdate] then
    if Application.MessageBox(PChar('ȷ����Ҫ��0������'), PChar('��ʾ'), MB_ICONQUESTION + MB_OKCANCEL) = IDOK then
      with THStringGridTZDNR do
      begin
        for iRow := 1 to RowCount - 1 do
        begin
          GetCellValF(iRow, 'KYJE', fValue);
          SetCellValF(iRow, 'TCJE', fValue);
        end;
        CalcTZHZB;
      end;
end;

procedure TFormNoteItemTZ.miZeroClearClick(Sender: TObject);
begin
	miZeroClear.Checked := not miZeroClear.Checked;
end;

end.

