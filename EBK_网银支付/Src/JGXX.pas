unit JGXX;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, ExpandPrint, SPrint2, Finder, Menus, THFilters, ImgList, Db,
  DBClient, RXSplit, StdCtrls, Buttons, Mask, SMaskEdit, ComCtrls,
  THExtCtrls, Tgrids2, THDBGrids, RXCtrls, DBTree, ExtCtrls, SpeedBar,
  FormPrint, HFExpandPrint, jpeg, RXSpin, Grids, uPub, uDev_ClassBaseInfo, uDev_BaseImport, DBGridEh;

type
  TFormJGXX = class(TForm)
    PanelFirst: TPanel;
    PanelTop: TPanel;
    PanelLeftMain: TPanel;
    DBTreeJCZL: TDBTree;
    PanelTitle: TPanel;
    RxLabelTitle: TRxLabel;
    PanelMain: TPanel;
    PanelRightTop: TPanel;
    GroupBoxJCZL: TGroupBox;
    LabelBS: TLabel;
    LabelMC: TLabel;
    RxLabelDep: TLabel;
    RxLabelPeople: TLabel;
    EditBS: TEdit;
    EditMC: TEdit;
    PanelLeft: TPanel;
    PanelRight: TPanel;
    PanelBottom: TPanel;
    RxSplitter1: TRxSplitter;
    ClientDataSetJCZLTree: TClientDataSet;
    DataSourceJCZLTree: TDataSource;
    DataSourceJCZL: TDataSource;
    ImageListTree: TImageList;
    THFilterJCZL: TTHFilter;
    ImageListBtn: TImageList;
    MainMenuJCZL: TMainMenu;
    MFile: TMenuItem;
    N_Preview: TMenuItem;
    N_Print: TMenuItem;
    N_Export: TMenuItem;
    N_Exit: TMenuItem;
    MRun: TMenuItem;
    N_Edit: TMenuItem;
    N_Delete: TMenuItem;
    N_Find: TMenuItem;
    N_Filter: TMenuItem;
    N_DoFilter: TMenuItem;
    N_NoFilter: TMenuItem;
    N_Refresh: TMenuItem;
    PopupMenuJCZL: TPopupMenu;
    FinderJCZL: TFinder;
    ClientDataSetSave: TClientDataSet;
    FormPrintJCZL: TFormPrint;
    HFExpandPrintJCZL: THFExpandPrint;
    ClientDataSetJCZLGrid: TClientDataSet;
    N_Save: TMenuItem;
    N_Cancel: TMenuItem;
    N_Add: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N_XF: TMenuItem;
    N_XFSFMX: TMenuItem;
    N_XFDQJC: TMenuItem;
    PanelSpeedBar: TPanel;
    PanelSpeedBarCenter: TPanel;
    SpeedBar: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection5: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    SpeedbarSection4: TSpeedbarSection;
    SpeedItemPreview: TSpeedItem;
    SpeedItemPrint: TSpeedItem;
    SpeedItemAdd: TSpeedItem;
    SpeedItemDelete: TSpeedItem;
    SpeedItemEdit: TSpeedItem;
    SpeedItemSave: TSpeedItem;
    SpeedItemCancel: TSpeedItem;
    SpeedItemFind: TSpeedItem;
    SpeedItemRefresh: TSpeedItem;
    SpeedItemFilter: TSpeedItem;
    SpeedItemNoFilter: TSpeedItem;
    SpeedItemHelp: TSpeedItem;
    SpeedItemExit: TSpeedItem;
    N_XFZLZJM: TMenuItem;
    N_XFYWDJ: TMenuItem;
    THBevelSYZT: TTHBevel;
    Label1: TLabel;
    edtDEFHH: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    THDBGridJCZL: TTHDBGrid;
    grdCardBIN: TDBGridEh;
    Panel4: TPanel;
    btnADD: TButton;
    btnDelete: TButton;
    btnSave: TButton;
    btnCancel: TButton;
    cdsCardBIN: TClientDataSet;
    dsCardBIN: TDataSource;
    Label2: TLabel;
    edtZJM: TEdit;
    btnImportBIN: TButton;
    btnImportDEP: TSpeedItem;
    procedure SpeedBarDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedItemAddClick(Sender: TObject);
    procedure SpeedItemCancelClick(Sender: TObject);
    procedure SpeedItemDeleteClick(Sender: TObject);
    procedure SpeedItemEditClick(Sender: TObject);
    procedure SpeedItemExitClick(Sender: TObject);
    procedure SpeedItemFilterClick(Sender: TObject);
    procedure SpeedItemFindClick(Sender: TObject);
    procedure SpeedItemHelpClick(Sender: TObject);
    procedure SpeedItemNoFilterClick(Sender: TObject);
    procedure SpeedItemPreviewClick(Sender: TObject);
    procedure SpeedItemPrintClick(Sender: TObject);
    procedure SpeedItemRefreshClick(Sender: TObject);
    procedure SpeedItemSaveClick(Sender: TObject);
    procedure EditMCKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure THDBGridJCZLHeaderDblClick(ACol: Integer;
      var CanLock: Boolean; AShift: TShiftState);
    procedure DBTreeJCZLChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    //�����¼�����
    procedure SpeedItemClick(Sender: TObject);
    procedure FinderJCZLFound(Sender: TObject);
    procedure THFilterJCZLFilter(Sender: TObject; AFilter: string);
    procedure EditPXHKeyPress(Sender: TObject; var Key: Char);
    procedure EditMCChange(Sender: TObject);
    procedure EditBSKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ClientDataSetJGXXGridAfterScroll(DataSet: TDataSet);
    procedure btnADDClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cdsCardBINAfterEdit(DataSet: TDataSet);
    procedure cdsCardBINNewRecord(DataSet: TDataSet);
    procedure btnImportBINClick(Sender: TObject);
    procedure btnImportDEPClick(Sender: TObject);
  Private
    { Private declarations }
    function DeleteData: Boolean;
    procedure ShowData;
    procedure RefreshData;
    function CheckData: Boolean;
    function SaveData: Boolean;
  Public
    { Public declarations }
    iCZJLNo: integer;
    iAddOrEdit: Integer; //���������޸�0����1�޸�
    blneedSaved: Boolean; //�Ƿ���Ҫ����
    szTreeFilter: string;
    szCtrlFilter: string;
    szPrintTitle: string;
    szCznr: string;
    procedure SetGNFalse; //���ù��ܲ�����
    //����
    procedure OpenDBTree(szSQL: string = ''; szField: string = ''; szFieldName: string = ''; szRule: string = '');
      Virtual;
    //�򿪱�
    procedure OpenDBGrid(szSQL: string = ''); Virtual;
    //����Filter�ؼ�
    procedure SetTHFilter; Virtual;
    //�������а�ť����
    procedure SetBtnEnabled;
    //�������а�ť������
    procedure SetBtnDisabled;
    //���ݰ�ť״̬����������ť״̬
    procedure SetBtnStatus(Sender: TObject);
    //���ò��ҿؼ��Ĵ��������
    procedure SetFinderField(szCode: string = ''; szName: string = '');
    //ִ��ɸѡ
    procedure PDoFilter;
    //�ָ��Ƿ���Ч
    procedure PSetNoFilterBtnStatus;
    //���ÿ���״̬
    procedure PSetStateOfContrl(szLX: string); Virtual;
    //�����ֶγ���
    procedure PGetFieldLength(Sender: Tobject; szTableName, szFieldName: string);
    //ɾ��ѯ��
    function AskIfDel: Boolean;
    //����Ƿ��ѱ�ʹ��
    function isUsed: Boolean;
    //ɾ������
    function FDeleteData(szTableName, szFieldName, szFieldValue: string; szWhere: string = ''): Boolean;
    //ִ���޷���ֵ�����ݲ���
    function ExeEditSql(dbTmp: TClientDataSet; szSQL: string): Boolean;
    //ִ���з���ֵ�����ݲ���
    function ExeQuerySql(dbTmp: TClientDataSet; szSQL: string): Boolean;
    //��ý���
    procedure PSetFocus(Sender: TWinControl);
    //���������ַ��Ƿ�Ϸ����Ƿ���0��9��A-Z;a-z
    function CheckInStr(InStr: string): Boolean;
    procedure BtnState(bSave:Boolean);
    function MsgBox_Question(Msg: string): Integer;
  end;
  TBankBin_Imp = class(TImport)
    DEPID:TClientDataSet;
  public
    //�������ݼ��
    constructor Create;
    function Check: Boolean; override;
    function Save: Boolean; override;
  end;
  TBankDEPID_Imp = class(TImport)
    DEPID:TClientDataSet;
  public
    //�������ݼ��
    constructor Create;
    function Check: Boolean; override;
    function Save: Boolean; override;
  end;
var
  FormJGXX: TFormJGXX;
procedure LoadJGXX;

implementation

uses Pub_Function, Pub_Message, Pub_Global, ListSelectDM, Pub_WYZF, Pub_power, DataModuleMain;

{$R *.DFM}

procedure LoadJGXX;
begin
  //���û����Ȩ���ɲ���
  if not TPower.GetPower(GN_JGXX_Read) then
  begin
    SysMessage('û�в���Ȩ�ޡ�', AOther_JG, [mbOk]);
    Exit;
  end;
  if Application.FindComponent('FormJGXX') = nil then
    Application.CreateForm(TFormJGXX, FormJGXX);
  FormJGXX.Show;
end;

procedure TFormJGXX.SpeedBarDblClick(Sender: TObject);
begin
  PAllowButtonCaption(Speedbar);
end;

procedure TFormJGXX.SpeedItemClick(Sender: TObject);
var
  TreeNode: TTreeNode;
  szBS: string;
begin
  if (Sender = N_Preview) or (Sender = SpeedItemPreview)
    or (Sender = N_Print) or (Sender = SpeedItemPrint) then
  begin
    FormPrintJCZL.GridTop := 150;
    with FormPrintJCZL, FormPrintJCZL.OtherItems do
    begin
      if GszDwMcOfPrint <> '' then
        Items[0].Text := '��λ:' + GszDwMcOfPrint
      else
        Items[0].Text := '��λ:' + GszHSDWMC;
      Items[1].Text := '��ӡ��:' + Gczy.name;
      Items[2].Text := '��ӡ����:';
    end;
  end;

  //����
  if (Sender = N_Add) or (Sender = SpeedItemAdd) then
  begin
    PSetStateOfContrl('CLEAR');
    PSetStateOfContrl('NOTREADONLY');
    PSetFocus(EditBS);
    iAddOrEdit := 0;
    //ɾ��
  end
  else if (Sender = N_Delete) or (Sender = SpeedItemDelete) then
  begin
    if not DeleteData then
      Exit;
    ShowData;
    iAddOrEdit := 1;
    RefreshData;
    //�޸�
  end
  else if (Sender = N_Edit) or (Sender = SpeedItemEdit) then
  begin
    iAddOrEdit := 1;
    PSetStateOfContrl('NOTREADONLY');
    EditBS.ReadOnly := True;
    //����
  end
  else if (Sender = N_Save) or (Sender = SpeedItemSave) then
  begin
    szBS := Trim(EditBS.Text);
    if not CheckData then
      Exit;
    if not SaveData then
      Exit;
    blneedSaved := False; //����Ҫ����
    PSetStateOfContrl('READONLY');
    iAddOrEdit := 1;
    RefreshData;
    TreeNode := DBTreeJCZL.NodeFind(szBS);
    DBTreeJCZL.FullCollapse;
    DBTreeJCZL.Items[0].Expanded := True;
    if TreeNode <> nil then
      TreeNode.Selected := True;
    ClientDataSetJCZLGrid.Locate('DEPID', szBS, []);
    //ȡ��
  end
  else if (Sender = N_Cancel) or (Sender = SpeedItemCancel) then
  begin
    PSetStateOfContrl('READONLY');
    ShowData;
    blneedSaved := False; //����Ҫ����
    iAddOrEdit := 1;
  end
  else if (Sender = N_Refresh) or (Sender = SpeedItemRefresh) then
  begin
    RefreshData;
    TreeNode := DBTreeJCZL.NodeFind(szBS);
    DBTreeJCZL.FullCollapse;
    DBTreeJCZL.Items[0].Expanded := True;
  end;

  if (Sender = SpeedItemExit) or (Sender = N_Exit) then
  begin
    Close
  end
  else if Sender = N_Preview then
  begin
    if FormPrintJCZL.PrintSetup then
      FormPrintJCZL.Preview;
  end
  else if Sender = SpeedItemPreview then
  begin
    FormPrintJCZL.Preview;
  end
  else if Sender = N_Print then
  begin
    if FormPrintJCZL.PrintSetUp then
      FormPrintJCZL.Print;
  end
  else if Sender = SpeedItemPrint then
  begin
    FormPrintJCZL.Print;
  end
  else if (Sender = SpeedItemFind) or (Sender = N_Find) then
  begin
    FinderJCZL.DataSet := ClientDataSetJCZLTree;
    FinderJCZL.Execute;
  end
  else if Sender = N_Export then
  begin
    HFExpandPrintJCZL.Execute;
  end
  else if (Sender = N_DOFilter) or (Sender = SpeedItemFilter) then
  begin
    THFilterJCZL.ExecFilter;
  end
  else if (Sender = N_NoFilter) or (Sender = SpeedItemNoFilter) then
  begin
    THFilterJCZL.RestoreFilter;
    //        szCtrlFilter := '';
    //        PDoFilter;
  end;
  SetBtnStatus(Sender);

  //PSetNoFilterBtnStatus;
end;

function TFormJGXX.CheckData: Boolean;
var
  szBS, szMC: string;
begin
  Result := False;
  szBS := Trim(EditBS.Text);
  szMC := Trim(EditMC.Text);
  if szBS = '' then
  begin
    SysMessage('%1����Ϊ�գ����������룡', '_YB', [mbOk], '����');
    PSetFocus(EditBS);
    exit;
  end;
  if szMC = '' then
  begin
    SysMessage('%1����Ϊ�գ����������룡', '_YB', [mbOk], '����');
    PSetFocus(EditMC);
    exit;
  end;
  if not CheckInStr(szBS) then
  begin
    SysMessage('����Ϊ�Ƿ��ַ���', '_YB', [mbOk], '����');
    PSetFocus(EditBS);
    exit;
  end;
  Result := True;
end;

function TFormJGXX.SaveData: Boolean;
var
  szSQL: string;
  szBS, szMC: string;
begin
  szBS := Trim(EditBS.Text);
  szMC := Trim(EditMC.Text);


  if iAddOrEdit = 0 then
  begin //��������
    szSQL := ' Insert into ebk_depid( depid,dep_name,ZJM,DEFBANKCODE) values ( '
      + '''' + szBS + ''', '+QuotedStr(edtZJM.Text)+','
      + '''' + szMC + ''','+QuotedStr(edtDEFHH.Text)+')';
  end
  else
  begin //�޸ı���
    szSQL := ' Update ebk_depid set '
      + '  dep_name=''' + szMC + ''',ZJM='+QuotedStr(edtZJM.Text)
      +',DEFBANKCODE= '+QuotedStr(edtDEFHH.Text)
      + ' Where depid=''' + szBS + ''' ';
  end;

  Result := ExeEditSql(ClientDataSetSave, szSQL);
  if not Result then
  begin
    SysMessage('����ʧ�ܣ����Ժ����ԣ�', '_YB', [mbOk]);
  end;
end;

function TFormJGXX.AskIfDel: Boolean;
begin
  if SysMessage('ɾ�����޷��ָ����Ƿ�ɾ����', '_JG', [mbYes, mbNo]) = mrYes then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

//�ж��Ƿ��Ѿ�ʹ��

function TFormJGXX.isUsed: Boolean;
var
  szSQL, szBS: string;
begin
  szBS := Trim(EditBS.Text);
  szSQL := 'select sum(a.n) as num from (select count(*) n from ebk_yhjk where depid = ''' + szBS +
    ''' union all select count(*) n from ebk_bankinfo where depid = ''' + szBS + ''') a';
  with DataModulePub.ClientDataSetTmp do
  begin
    Close;
    POpenSql(DataModulePub.ClientDataSetTmp, szSQL);
    if FindFirst then
      while not EOF do
      begin
        if FieldByName('num').asString = '0' then
        begin
          Result := False;
          break;
        end
        else
        begin
          Result := True;
          break;
        end;
      end;
    Close;
  end;
end;

//ɾ������

function TFormJGXX.FDeleteData(szTableName, szFieldName, szFieldValue: string; szWhere: string = ''): Boolean;
var
  szSQL: string;
begin
  szSQL := ' delete from ' + szTableName +
    ' where ' + szFieldName + '=''' + szFieldValue + ''' ';
  if szWhere <> '' then
    szSQL := szSQL + ' and ' + szWhere;
  Result := ExeEditSql(DataModulePub.ClientDataSetPub, szSQL);
  if not Result then
    SysMessage('ɾ��ʧ�ܣ����Ժ����ԣ�', '_YB', [mbOK]);
end;

function TFormJGXX.DeleteData: Boolean;
var
  szBS: string;
begin
  Result := False;
  szBS := Trim(EditBS.Text);
  if not AskIfDEL then
    Exit;
  if isUsed then
  begin //�ж��Ƿ���ʹ����
    SysMessage('�����л�����ʹ�ã�����ɾ����', '_YB', [mbOk]);
    Exit;
  end;
  if not FDeleteData('ebk_depid', 'depid', Trim(szBS)) then
    Exit;
  Result := True;
end;

procedure TFormJGXX.ShowData;
begin
  with ClientDataSetJCZLGrid do
  begin
    EditBS.Text := FieldByName('DEPID').asstring;
    EditMC.Text := FieldByName('DEP_NAME').asstring;
    edtZJM.Text := FieldByName('ZJM').AsString;
    edtDEFHH.Text := FieldByName('DEFBANKCODE').AsString;
  end;
end;

procedure TFormJGXX.RefreshData;
var
  szSQL: string;
begin
  szSQL := 'select * from ebk_depid order By depid ';
  OpenDBTree(szSQL, 'depid', 'dep_name', '3');
  OpenDBGrid(szSQL);
end;

procedure TFormJGXX.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  {    if blneedSaved then
      begin
          case SysMessage('���������ѷ����仯���˳�ǰ�Ƿ񱣴棿','_XW',
                [mbYes,mbNo,mbCancel]) of
          mrYes:
              begin
                  SpeedItemSaveClick(Sender);
                  if blneedSaved then
                    exit;
              end;
          mrNo : blneedSaved:=False;
          else
          Exit;
          end
      end;}
      //PWriteEndCzjl(iCZJLNo);
  Action := CaFree;
  FormJGXX := nil;
end;

procedure TFormJGXX.SpeedItemAddClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemAdd);
end;

procedure TFormJGXX.SpeedItemCancelClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemCancel);
end;

procedure TFormJGXX.SpeedItemDeleteClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemDelete);
end;

procedure TFormJGXX.SpeedItemEditClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemEdit);
end;

procedure TFormJGXX.SpeedItemExitClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemExit);
end;

procedure TFormJGXX.SpeedItemFilterClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemFilter);
end;

procedure TFormJGXX.SpeedItemFindClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemFind);
end;

procedure TFormJGXX.SpeedItemHelpClick(Sender: TObject);
begin
  ChangeHelp('EBK.hlp', 31);
end;

procedure TFormJGXX.SpeedItemNoFilterClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemNoFilter);
end;

procedure TFormJGXX.SpeedItemPreviewClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemPreview);
end;

procedure TFormJGXX.SpeedItemPrintClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemPrint);
end;

procedure TFormJGXX.SpeedItemRefreshClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemRefresh);
end;

procedure TFormJGXX.SpeedItemSaveClick(Sender: TObject);
begin
  SpeedItemClick(SpeedItemSave);
end;

procedure TFormJGXX.ClientDataSetJGXXGridAfterScroll(DataSet: TDataSet);
begin
  SpeedItemClick(N_Cancel);
  //ˢ�����еĿ�BIN��
  POpenSQL(cdsCardBIN, 'Select * from EBK_BANKBIN where DEPID = '+
    QuotedStr(DataSet.FieldByName('DEPID').AsString));
end;

procedure TFormJGXX.EditMCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ACtrl: TWinControl;
begin
  if Key = 13 then
  begin
    ACtrl := FindNextControl(TWinControl(Sender), True, True, False);
    if ACtrl <> nil then
      ACtrl.SetFocus;
  end;
end;

procedure TFormJGXX.OpenDBGrid(szSQL: string);
begin
  //�򿪱�
  if szSQL = '' then
    Exit;
  with ClientDataSetJCZLGrid do
  begin
    try
      Close;
      Filter := '';
      POpenSQL(ClientDataSetJCZLGrid, szSQL);
    except
      SysMessage('�����ݿⷢ���������', '_JG', [mbOK]);
      Close;
      Exit;
    end;
  end;
end;

procedure TFormJGXX.OpenDBTree(szSQL, szField, szFieldName, szRule: string);
begin
  //����
  if (szSQL = '') or (szField = '') or (szFieldName = '') then
    Exit
  else
  begin
    DBTreeJCZL.DataField := szField;
    DBTreeJCZL.FieldCodeName := szFieldName;
    DBTreeJCZL.FieldCodeRule := szRule;
  end;
  with ClientDataSetJCZLTree do
  begin
    try
      POpenSQL(ClientDataSetJCZLTree, szSQL);
    except
      SysMessage('�����ݿⷢ���������', '_JG', [mbOK]);
      Close;
      Exit;
    end;
  end;
  DBTreeJCZL.FullCollapse;
  DBTreeJCZL.Items[0].Expanded := True;
end;

procedure TFormJGXX.THDBGridJCZLHeaderDblClick(ACol: Integer;
  var CanLock: Boolean; AShift: TShiftState);
begin
  CanLock := True;
end;

procedure TFormJGXX.DBTreeJCZLChange(Sender: TObject; Node: TTreeNode);
var
  szTemp: string;
begin
  if blneedSaved then
  begin
    case SysMessage('���������ѷ����仯���˳�ǰ�Ƿ񱣴棿', '_XW',
      [mbYes, mbNo, mbCancel]) of
      mrYes:
        begin
          SpeedItemClick(SpeedItemSave);
          if blneedSaved then
            exit;
        end;
      mrNo: blneedSaved := False;
    else
      Exit;
    end
  end;
  //��������
  if DBTreeJCZL.Selected = nil then
    Exit;
  szTemp := DBTreeJCZL.Selected.Text;
  szTemp := copy(szTemp, 1, pos(' ', szTemp) - 1);
  if trim(szTemp) = '' then
    szTreeFilter := ''
  else
    szTreeFilter := DBTreeJCZL.DataField + ' like ''' + szTemp + '%''';
  PDoFilter;
  if DBTreeJCZL.Selected.Level = 0 then
    POpenSQL(cdsCardBIN, 'Select * from EBK_BANKBIN');
end;

procedure TFormJGXX.FormCreate(Sender: TObject);
begin
  iCZJLNo := PWriteNewCzjl(self.Caption);
  grdCardBIN.FixedColor := Self.Color;
  SpeedBar.Wallpaper.Bitmap.Handle := LoadBitmap(hInstance, 'BACKGROUND');
  szTreeFilter := '';
  szCtrlFilter := '';
  FormPrintJCZL.ShowZero := True;
  SetTHFilter;
  SetFinderField('DEPID', 'DEP_NAME');
  PGetFieldLength(EditBS, 'ebk_depid', 'DEPID');
  PGetFieldLength(EditMC, 'ebk_depid', 'DEP_NAME');
end;

procedure TFormJGXX.SetTHFilter;
begin
  THFilterJCZL.THDBGridPad := THDBGridJCZL;

  szPrintTitle := '������������';
  with THFilterJCZL.GridCols do
  begin
    Clear;
    Add;
    Items[Count - 1].Caption := '��������';
    Items[Count - 1].ColName := 'DEPID';
    Items[Count - 1].DataType := ftString;
    Items[Count - 1].Width := 120;
    Add;
    Items[Count - 1].Caption := '��������';
    Items[Count - 1].ColName := 'DEP_NAME';
    Items[Count - 1].DataType := ftString;
    Items[Count - 1].Width := 180;
  end;
  THFilterJCZL.InitColumns;
end;

procedure TFormJGXX.SetBtnEnabled;
var
  i: integer;
begin
  for i := 0 to self.ComponentCount - 1 do
  begin
    if self.Components[i] is TSpeedItem then
    begin
      if (self.Components[i] as TSpeedItem).tag = 0 then
        (self.Components[i] as TSpeedItem).Enabled := True;
    end
    else if self.Components[i] is TMenuItem then
    begin
      if (self.Components[i] as TMenuItem).tag = 0 then
        (self.Components[i] as TMenuItem).Enabled := True;
    end;
  end;
  //���û����Ȩ�༭���ܲ�����
  if not TPower.GetPower(GN_JGXX_Edit) then
  begin
    SetGNFalse;
  end;
end;

procedure TFormJGXX.SetBtnDisabled;
var
  i: integer;
begin
  for i := 0 to self.ComponentCount - 1 do
  begin
    if self.Components[i] is TSpeedItem then
    begin
      if (self.Components[i] as TSpeedItem).tag = 0 then
        (self.Components[i] as TSpeedItem).Enabled := False;
    end
    else if (self.Components[i] is TMenuItem) then
    begin
      if (self.Components[i] as TMenuItem).tag = 0 then
        (self.Components[i] as TMenuItem).Enabled := False;
    end;
  end;
  MFile.Enabled := True;
  MRun.Enabled := True;

end;

procedure TFormJGXX.SetBtnStatus(Sender: TObject);
begin
  if (Sender = SpeedItemRefresh) or (Sender = N_Refresh) then
  begin
    SetBtnEnabled;
    SpeedItemSave.Enabled := False;
    SpeedItemCancel.Enabled := False;
    N_Save.Enabled := False;
    N_Cancel.Enabled := False;
  end
  else if (Sender = SpeedItemAdd) or (Sender = N_Add)
    or (Sender = SpeedItemEdit) or (Sender = N_Edit) then
  begin
    SetBtnDisabled;
    SpeedItemSave.Enabled := True;
    SpeedItemCancel.Enabled := True;
    N_Save.Enabled := True;
    N_Cancel.Enabled := True;
  end
  else if (Sender = SpeedItemSave) or (Sender = N_Save)
    or (Sender = SpeedItemCancel) or (Sender = N_Cancel) then
  begin
    SetBtnEnabled;
    SpeedItemSave.Enabled := False;
    SpeedItemCancel.Enabled := False;
    N_Save.Enabled := False;
    N_Cancel.Enabled := False;
  end;
  if DBTreeJCZL.Items.Count = 1 then
  begin
    SpeedItemDelete.Enabled := False;
    N_Delete.Enabled := False;
    SpeedItemEdit.Enabled := False;
    N_Edit.Enabled := False;
  end;

end;

procedure TFormJGXX.FormShow(Sender: TObject);
begin
  SetComponentsColor(self);
  SpeedItemRefresh.Click;
  with FormPrintJCZL, FormPrintJCZL.OtherItems do
  begin
    Items[0].Text := '��λ:' + GszDwMcOfPrint;
    Items[1].Text := '��ӡ��:' + Gczy.name;
    Items[2].Text := '��ӡ����:';
    Items[4].Text := szPrintTitle
  end;
end;

procedure TFormJGXX.FinderJCZLFound(Sender: TObject);
var
  szTemp: string;
begin
  try
    szTemp := ClientDataSetJCZLTree.FieldByName(FinderJCZL.CodeFldName).asstring;
    DBTreeJCZL.NodeFind(szTemp).Selected := True;
  except
  end;
end;

procedure TFormJGXX.SetFinderField(szCode, szName: string);
begin
  if (szCode = '') or (szName = '') then
    Exit
  else
  begin
    FinderJCZL.CodeFldName := szCode;
    FinderJCZL.NameFldName := szName;
  end;
end;

//�����ֶγ���

procedure TFormJGXX.PGetFieldLength(Sender: Tobject; szTableName, szFieldName: string);
begin
  with DataModulePub.ClientDataSetTmp do
  begin
    try
      Close;
      if GDbType = MSSQL then
      begin
        POpenSQL(DataModulePub.ClientDataSetTmp, 'select length from syscolumns WHERE ID=object_id(''' + szTableName +
          ''') AND NAME=''' + szFieldName + '''');
      end
      else
      begin
        POpenSQL(DataModulePub.ClientDataSetTmp,
          'select DATA_LENGTH length from user_tab_columns where table_name=upper(''' + szTableName +
          ''') and column_name=upper(''' + szFieldName + ''')');
      end;
    except
      Close;
      SysMessage('��ȡ���ݷ����������������', '_JG', [mbOK]);
      exit;
    end;
    if Sender is TEdit then
    begin
      TEdit(Sender).MaxLength := FieldByName('length').AsInteger;
      TEdit(Sender).Hint := '��������󳤶�Ϊ' + IntToStr(FieldByName('length').AsInteger);
    end;
    if Sender is TSMaskEdit then
    begin
      TSMaskEdit(Sender).MaxLength := FieldByName('length').AsInteger;
      TSMaskEdit(Sender).Hint := '��������󳤶�Ϊ' + IntToStr(FieldByName('length').AsInteger);
    end;
    close;
  end;
end;

procedure TFormJGXX.THFilterJCZLFilter(Sender: TObject;
  AFilter: string);
begin
  //    szCtrlFilter := AFilter;
  PDoFilter;
end;

procedure TFormJGXX.PDoFilter;
var
  szTemp: string;
begin
  szTemp := szTreeFilter;
  if trim(szTemp) = '' then
    if szCtrlFilter <> '' then
      szTemp := szCtrlFilter
    else
      szTemp := ''
  else if szCtrlFilter <> '' then
    szTemp := szTemp + ' and ' + szCtrlFilter
  else
    szTemp := szTemp + '';
  ClientDataSetJCZLGrid.Filtered := False;
  ClientDataSetJCZLGrid.Filter := szTemp;
  ClientDataSetJCZLGrid.Filtered := True;
end;

procedure TFormJGXX.PSetNoFilterBtnStatus;
begin
  N_NoFilter.Enabled := (szCtrlFilter <> '');
  SpeedItemNoFilter.Enabled := (szCtrlFilter <> '');
end;

procedure TFormJGXX.EditPXHKeyPress(Sender: TObject; var Key: Char);
begin
  if (not (Key in ['0'..'9'])) and
    (ord(key) <> 8) then
    Key := #0;
end;

//���ÿ���״̬

procedure TFormJGXX.PSetStateOfContrl(szLX: string);
var
  i: Integer;
begin
  if UpperCase(szLX) = 'CLEAR' then
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TEdit) then
        TEdit(Components[i]).Text := '';
      if (Components[i] is TSMaskEdit) then
        TSMaskEdit(Components[i]).Text := '';
      if (Components[i] is TCheckBox) then
        TCheckBox(Components[i]).Checked := False;
      if (Components[i] is TComBoBox) then
        TComboBox(Components[i]).Text := '';
      if (Components[i] is TMemo) then
        TMemo(Components[i]).Text := '';
      if (Components[i] is TRxSpinEdit) then
        TRxSpinEdit(Components[i]).Text := '1';
    end;
    THBevelSYZT.Visible := False;
  end
  else if UpperCase(szLX) = 'READONLY' then
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TEdit) then
        TEdit(Components[i]).ReadOnly := True;
      if (Components[i] is TSMaskEdit) then
      begin
        TSMaskEdit(Components[i]).ReadOnly := True;
        TSMaskEdit(Components[i]).LoadButton := False;
      end;
      if (Components[i] is TCheckBox) then
        TCheckBox(Components[i]).Enabled := False;
      if (Components[i] is TComBoBox) then
        TComboBox(Components[i]).Enabled := False;
      if (Components[i] is TMemo) then
        TMemo(Components[i]).ReadOnly := True;
      if (Components[i] is TRxSpinEdit) then
        TRxSpinEdit(Components[i]).ReadOnly := True;
      if (Components[i] is TDateTimePicker) then
        TDateTimePicker(Components[i]).Enabled := False;
      if (Components[i] is TGroupBox) then
        TGroupBox(Components[i]).Enabled := false;
    end;
  end
  else if Uppercase(szLX) = 'DJREADONLY' then
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TEdit) then
        TEdit(Components[i]).ReadOnly := True;
      if (Components[i] is TSMaskEdit) then
      begin
        TSMaskEdit(Components[i]).ReadOnly := True;
        TSMaskEdit(Components[i]).LoadButton := False;
      end;
      if (Components[i] is TCheckBox) then
        TCheckBox(Components[i]).Enabled := False;
      if (Components[i] is TComBoBox) then
        TComboBox(Components[i]).Enabled := False;
      if (Components[i] is TMemo) then
        TMemo(Components[i]).ReadOnly := True;
      if (Components[i] is TRxSpinEdit) then
        TRxSpinEdit(Components[i]).ReadOnly := True;
      if (Components[i] is TDateTimePicker) then
        TDateTimePicker(Components[i]).Enabled := False;
      if (Components[i] is TGroupBox) then
        TGroupBox(Components[i]).Enabled := TRUE;
      if (Components[i] is TTabSheet) then
        TTabSheet(Components[i]).Enabled := TRUE;
    end;
  end
  else if Uppercase(szLX) = 'NOTREADONLY' then
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if (Components[i] is TEdit) then
        TEdit(Components[i]).ReadOnly := False;
      if (Components[i] is TSMaskEdit) then
      begin
        TSMaskEdit(Components[i]).ReadOnly := False;
        TSMaskEdit(Components[i]).LoadButton := True;
      end;
      if (Components[i] is TCheckBox) then
        TCheckBox(Components[i]).Enabled := True;
      if (Components[i] is TComBoBox) then
        TComboBox(Components[i]).Enabled := True;
      if (Components[i] is TMemo) then
        TMemo(Components[i]).ReadOnly := False;
      if (Components[i] is TRxSpinEdit) then
        TRxSpinEdit(Components[i]).ReadOnly := False;
      if (Components[i] is TDateTimePicker) then
        TDateTimePicker(Components[i]).Enabled := True;
      if (Components[i] is TGroupBox) then
        TGroupBox(Components[i]).Enabled := true;
      if (Components[i] is TTabSheet) then
        TTabSheet(Components[i]).Enabled := TRUE;
    end;
  end;
end;

procedure TFormJGXX.EditMCChange(Sender: TObject);
var
  VStrPy: string;
begin
  //�������������10λ
  if EditMC.ReadOnly then
    Exit;
  blneedSaved := True; //��Ҫ����
  if Sender = EditMC then
  begin
    PStrToPy(EditMC.text, VStrPy);
    edtZJM.Text := VStrPy;
  end;
end;

procedure TFormJGXX.SetGNFalse;
begin
  N_Add.Enabled := False; //����
  SpeedItemAdd.Enabled := False;
  N_Delete.Enabled := False; //ɾ��
  SpeedItemDelete.Enabled := False;
  N_Edit.Enabled := False; //�޸�
  SpeedItemEdit.Enabled := False;
  N_Save.Enabled := False; //����
  SpeedItemSave.Enabled := False;
  N_Cancel.Enabled := False; //ȡ��
  SpeedItemCancel.Enabled := False;
  N_XFSFMX.Enabled := False; //�޸��Ƿ���ϸ����
  N_XFDQJC.Enabled := False; //�޸���ǰ��������
  N_XFZLZJM.Enabled := False; //�޸�����������
end;

procedure TFormJGXX.EditBSKeyPress(Sender: TObject; var Key: Char);
begin
  if (ord(key) = 8) or ((ord(key) >= 48) and (ord(key) <= 57)) or ((ord(key) >= 65) and (ord(key) <= 90)) or ((ord(key)
    >= 97) and (ord(key) <= 122)) then
  else
    key := chr(0);
end;

procedure TFormJGXX.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  PWriteEndCzjl(iCZJLNo);
end;

//ִ���޷���ֵ�����ݲ���

function TFormJGXX.ExeEditSql(dbTmp: TClientDataSet; szSQL: string): Boolean;
var
  i: Integer;
begin
  with dbTmp do //ClientDataSetPubSave
  begin
    try
      Close;
      for i := 0 to Params.Count - 1 do
      begin
        Params[i].Clear;
      end;
      PExecSQL(dbTmp, szSQl);
      if GDbType = ORACLE then
      begin
        close;
        PExecSQL(dbTmp, 'commit');
      end;
      Close;
      Result := True;
    except
      close;
      Result := False;
    end;
    CommandText := '';
  end;
end;
//ִ���з���ֵ�����ݲ���

function TFormJGXX.ExeQuerySql(dbTmp: TClientDataSet; szSQL: string): Boolean;
var
  i: Integer;
begin
  with dbTmp do
  begin
    try
      Close;
      for i := 0 to Params.Count - 1 do
      begin
        Params[i].Clear;
      end;
      POpenSQL(dbTmp, szSQL);
      Result := True;
    except
      Close;
      Result := False;
    end;
  end;
end;

//��ý���

procedure TFormJGXX.PSetFocus(Sender: TWinControl);
begin
  try
    if Sender.Enabled then
      Sender.SetFocus;
  except
  end;
end;

//���������ַ��Ƿ�Ϸ����Ƿ���0��9��A-Z;a-z

function TFormJGXX.CheckInStr(InStr: string): Boolean;
var
  i, iCharOrd: integer;
begin
  Result := False;
  for i := 1 to Length(InStr) - 1 do
  begin
    iCharOrd := Ord(InStr[i]);
    if ((iCharOrd >= 48) and (iCharOrd <= 57)) or ((iCharOrd >= 65) and (iCharOrd <= 90)) or ((iCharOrd >= 97) and
      (iCharOrd <= 122)) then
    else
    begin
      exit;
    end;
  end;
  Result := True;
end;

procedure TFormJGXX.btnADDClick(Sender: TObject);
begin
  cdsCardBIN.Append;
  BtnState(True);
end;

procedure TFormJGXX.btnDeleteClick(Sender: TObject);
begin
  if MsgBox_Question('ȷ��ɾ��ѡ��ļ�¼��') = IDOK then
  begin
    if grdCardBIN.SelectedRows.Count = 0 then
      grdCardBIN.SelectedRows.CurrentRowSelected := True;
    grdCardBIN.SelectedRows.Delete;
    TDB.ApplyUpdate(cdsCardBIN.Delta, 'EBK_BANKBIN', 'BINCODE');
    if cdsCardBIN.ChangeCount > 0 then
      cdsCardBIN.MergeChangeLog;
  end;
end;

procedure TFormJGXX.btnSaveClick(Sender: TObject);
begin
  TDB.ApplyUpdate(cdsCardBIN.Delta, 'EBK_BANKBIN', 'BINCODE');
  if cdsCardBIN.ChangeCount > 0 then
    cdsCardBIN.MergeChangeLog;
  TApp.MsgBox_Info('����ɹ���');
  BtnState(False);
end;

procedure TFormJGXX.btnCancelClick(Sender: TObject);
begin
  cdsCardBIN.CancelUpdates;
  BtnState(False);
end;

procedure TFormJGXX.BtnState(bSave: Boolean);
begin
  btnADD.Enabled := not bSave;
  btnDelete.Enabled := not bSave;
  btnSave.Enabled := bSave;
  btnCancel.Enabled := bSave;
end;

procedure TFormJGXX.cdsCardBINAfterEdit(DataSet: TDataSet);
begin
  BtnState(True);
end;

procedure TFormJGXX.cdsCardBINNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('BANKNAME').AsString := ClientDataSetJCZLGrid.FieldByName('DEP_NAME').AsString;
  DataSet.FieldByName('DEPID').AsString := ClientDataSetJCZLGrid.FieldByName('DEPID').AsString;
end;

procedure TFormJGXX.btnImportBINClick(Sender: TObject);
var
  BankBin_Imp: TBankBin_Imp;
begin
  //������Ŀ��
  try
    BankBin_Imp := TBankBin_Imp.Create;
    LoadImortFrmFile(BankBin_Imp);
    ClientDataSetJGXXGridAfterScroll(ClientDataSetJCZLGrid);
  finally
    BankBin_Imp.Free;
  end;
end;

{ TBankBin_Imp }

function TBankBin_Imp.Check: Boolean;
var
  szBANKNAME:String;
  ErrLists:TStringList;
begin
  //��ѯ���а༶���԰༶����У����߸���
  cdsData.First;
  ErrLists := TStringList.Create;
  ErrLists.Clear;
  while not cdsData.eof do
  begin
    //��Ŀ���ж�    
    if cdsData.FieldByName('BANKNAME').AsString = '' then
      ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, �������Ʋ�����Ϊ�գ����ܵ��롣')
    else
    begin
      szBANKNAME := cdsData.FieldByName('BANKNAME').AsString;
      if DEPID.Locate('DEP_NAME', szBANKNAME, [loCaseInsensitive]) then
      begin
        cdsData.Edit;
        cdsData.FieldbyName('DEPID').AsString := DEPID.FieldByName('DEPID').AsString;
        cdsData.Post;
      end
      else
        ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, ��������'+szBANKNAME+'�����ڣ����顣')
    end;
    if cdsData.FieldByName('BINCODE').AsString = '' then
    begin
      ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, ��BIN������Ϊ�գ����ܵ��롣');
    end;
    cdsData.Next;
  end;
  Result := ErrLists.Count = 0;
  Error := ErrLists.Text;
  ErrLists.Free;
end;

constructor TBankBin_Imp.Create;
begin
  DEPID := DataModulePub.GetCdsBySQL('select DEPID, DEP_NAME, ZJM from EBK_DEPID');
  inherited Create('EBK_BANKBIN', 'BINCODE;DEPID');
  AddValue('��������', 'C','BANKNAME', 50);
  AddValue('����ID', 'C','DEPID', 20, '', False);
  AddValue('������', 'C','CARDTYPE', 20);
  AddValue('������', 'N','CARDLEN', 0);
  AddValue('��BIN', 'C','BINCODE', 20);
  AddValue('���к�', 'C','DEFBANK', 20);
end;

function TBankBin_Imp.Save: Boolean;
begin
  inherited Save;
end;

procedure TFormJGXX.btnImportDEPClick(Sender: TObject);
var
  BankDEPID_Imp: TBankDEPID_Imp;
begin
  //������Ŀ��
  try
    BankDEPID_Imp := TBankDEPID_Imp.Create;
    LoadImortFrmFile(BankDEPID_Imp);
    SpeedItemRefreshClick(nil);
  finally
    BankDEPID_Imp.Free;
  end;
end;

{ TBankDEPID_Imp }

function TBankDEPID_Imp.Check: Boolean;
var
  szBANKNAME, VStrPy:String;
  ErrLists:TStringList;
begin
  ErrLists := TStringList.Create;
  ErrLists.Clear;
  DEPID := DataModulePub.GetCdsBySQL('select DEPID, DEP_NAME, ZJM from EBK_DEPID');
  while not cdsData.eof do
  begin
    //��Ŀ���ж�
    if DEPID.Locate('DEPID', cdsData.FieldByName('DEPID').AsString, [loCaseInsensitive]) then
    begin
      cdsData.Delete;
      Continue;
    end;
    if cdsData.FieldByName('DEPID').AsString = '' then
    begin
      ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, ������Ų�����Ϊ�գ����ܵ��롣');
    end;
    if cdsData.FieldByName('DEP_NAME').AsString = '' then
    begin
      ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, �������Ʋ�����Ϊ�գ����ܵ��롣');
    end
    else
    begin
      PStrToPy(cdsData.FieldByName('DEP_NAME').AsString, VStrPy);
      cdsData.Edit;
      cdsData.FieldByName('ZJM').AsString := VStrPy;
      cdsData.Post;
    end;
    cdsData.Next;
  end;
  Result := ErrLists.Count = 0;
  Error := ErrLists.Text;
  ErrLists.Free;
end;

constructor TBankDEPID_Imp.Create;
begin
  inherited Create('EBK_DEPID', 'DEPID');
  AddValue('�������', 'C','DEPID', 20);
  AddValue('��������', 'C','DEP_NAME', 50);
end;

function TBankDEPID_Imp.Save: Boolean;
begin
  inherited Save;
end;

function TFormJGXX.MsgBox_Question(Msg: string): Integer;
begin
  Result := Application.MessageBox(PChar(Msg), 'ϵͳ��ʾ', MB_ICONQuestion + MB_OKCANCEL);
end;

end.

