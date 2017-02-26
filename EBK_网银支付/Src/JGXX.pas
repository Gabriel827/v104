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
    //公用事件处理
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
    iAddOrEdit: Integer; //新增还是修改0新增1修改
    blneedSaved: Boolean; //是否需要保存
    szTreeFilter: string;
    szCtrlFilter: string;
    szPrintTitle: string;
    szCznr: string;
    procedure SetGNFalse; //设置功能不可用
    //打开树
    procedure OpenDBTree(szSQL: string = ''; szField: string = ''; szFieldName: string = ''; szRule: string = '');
      Virtual;
    //打开表
    procedure OpenDBGrid(szSQL: string = ''); Virtual;
    //设置Filter控件
    procedure SetTHFilter; Virtual;
    //设置所有按钮可用
    procedure SetBtnEnabled;
    //设置所有按钮不可用
    procedure SetBtnDisabled;
    //根据按钮状态设置其它按钮状态
    procedure SetBtnStatus(Sender: TObject);
    //设置查找控件的代码和名称
    procedure SetFinderField(szCode: string = ''; szName: string = '');
    //执行筛选
    procedure PDoFilter;
    //恢复是否有效
    procedure PSetNoFilterBtnStatus;
    //设置控制状态
    procedure PSetStateOfContrl(szLX: string); Virtual;
    //返回字段长度
    procedure PGetFieldLength(Sender: Tobject; szTableName, szFieldName: string);
    //删除询问
    function AskIfDel: Boolean;
    //检查是否已被使用
    function isUsed: Boolean;
    //删除数据
    function FDeleteData(szTableName, szFieldName, szFieldValue: string; szWhere: string = ''): Boolean;
    //执行无返回值的数据操作
    function ExeEditSql(dbTmp: TClientDataSet; szSQL: string): Boolean;
    //执行有返回值的数据操作
    function ExeQuerySql(dbTmp: TClientDataSet; szSQL: string): Boolean;
    //获得焦点
    procedure PSetFocus(Sender: TWinControl);
    //检查输入的字符是否合法，是否是0－9；A-Z;a-z
    function CheckInStr(InStr: string): Boolean;
    procedure BtnState(bSave:Boolean);
    function MsgBox_Question(Msg: string): Integer;
  end;
  TBankBin_Imp = class(TImport)
    DEPID:TClientDataSet;
  public
    //基础数据检查
    constructor Create;
    function Check: Boolean; override;
    function Save: Boolean; override;
  end;
  TBankDEPID_Imp = class(TImport)
    DEPID:TClientDataSet;
  public
    //基础数据检查
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
  //添加没有授权不可查阅
  if not TPower.GetPower(GN_JGXX_Read) then
  begin
    SysMessage('没有查阅权限。', AOther_JG, [mbOk]);
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
        Items[0].Text := '单位:' + GszDwMcOfPrint
      else
        Items[0].Text := '单位:' + GszHSDWMC;
      Items[1].Text := '打印人:' + Gczy.name;
      Items[2].Text := '打印日期:';
    end;
  end;

  //新增
  if (Sender = N_Add) or (Sender = SpeedItemAdd) then
  begin
    PSetStateOfContrl('CLEAR');
    PSetStateOfContrl('NOTREADONLY');
    PSetFocus(EditBS);
    iAddOrEdit := 0;
    //删除
  end
  else if (Sender = N_Delete) or (Sender = SpeedItemDelete) then
  begin
    if not DeleteData then
      Exit;
    ShowData;
    iAddOrEdit := 1;
    RefreshData;
    //修改
  end
  else if (Sender = N_Edit) or (Sender = SpeedItemEdit) then
  begin
    iAddOrEdit := 1;
    PSetStateOfContrl('NOTREADONLY');
    EditBS.ReadOnly := True;
    //保存
  end
  else if (Sender = N_Save) or (Sender = SpeedItemSave) then
  begin
    szBS := Trim(EditBS.Text);
    if not CheckData then
      Exit;
    if not SaveData then
      Exit;
    blneedSaved := False; //不需要保存
    PSetStateOfContrl('READONLY');
    iAddOrEdit := 1;
    RefreshData;
    TreeNode := DBTreeJCZL.NodeFind(szBS);
    DBTreeJCZL.FullCollapse;
    DBTreeJCZL.Items[0].Expanded := True;
    if TreeNode <> nil then
      TreeNode.Selected := True;
    ClientDataSetJCZLGrid.Locate('DEPID', szBS, []);
    //取消
  end
  else if (Sender = N_Cancel) or (Sender = SpeedItemCancel) then
  begin
    PSetStateOfContrl('READONLY');
    ShowData;
    blneedSaved := False; //不需要保存
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
    SysMessage('%1不能为空，请重新输入！', '_YB', [mbOk], '代码');
    PSetFocus(EditBS);
    exit;
  end;
  if szMC = '' then
  begin
    SysMessage('%1不能为空，请重新输入！', '_YB', [mbOk], '名称');
    PSetFocus(EditMC);
    exit;
  end;
  if not CheckInStr(szBS) then
  begin
    SysMessage('代码为非法字符。', '_YB', [mbOk], '代码');
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
  begin //新增保存
    szSQL := ' Insert into ebk_depid( depid,dep_name,ZJM,DEFBANKCODE) values ( '
      + '''' + szBS + ''', '+QuotedStr(edtZJM.Text)+','
      + '''' + szMC + ''','+QuotedStr(edtDEFHH.Text)+')';
  end
  else
  begin //修改保存
    szSQL := ' Update ebk_depid set '
      + '  dep_name=''' + szMC + ''',ZJM='+QuotedStr(edtZJM.Text)
      +',DEFBANKCODE= '+QuotedStr(edtDEFHH.Text)
      + ' Where depid=''' + szBS + ''' ';
  end;

  Result := ExeEditSql(ClientDataSetSave, szSQL);
  if not Result then
  begin
    SysMessage('存盘失败，请稍候重试！', '_YB', [mbOk]);
  end;
end;

function TFormJGXX.AskIfDel: Boolean;
begin
  if SysMessage('删除后将无法恢复，是否删除？', '_JG', [mbYes, mbNo]) = mrYes then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
  end;
end;

//判断是否已经使用

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

//删除数据

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
    SysMessage('删除失败，请稍后重试！', '_YB', [mbOK]);
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
  begin //判断是否已使用了
    SysMessage('该银行机构已使用，不能删除！', '_YB', [mbOk]);
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
          case SysMessage('资料内容已发生变化，退出前是否保存？','_XW',
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
  //刷新银行的卡BIN号
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
  //打开表
  if szSQL = '' then
    Exit;
  with ClientDataSetJCZLGrid do
  begin
    try
      Close;
      Filter := '';
      POpenSQL(ClientDataSetJCZLGrid, szSQL);
    except
      SysMessage('打开数据库发生意外错误。', '_JG', [mbOK]);
      Close;
      Exit;
    end;
  end;
end;

procedure TFormJGXX.OpenDBTree(szSQL, szField, szFieldName, szRule: string);
begin
  //打开树
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
      SysMessage('打开数据库发生意外错误。', '_JG', [mbOK]);
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
    case SysMessage('资料内容已发生变化，退出前是否保存？', '_XW',
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
  //表随树动
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

  szPrintTitle := '机构代码资料';
  with THFilterJCZL.GridCols do
  begin
    Clear;
    Add;
    Items[Count - 1].Caption := '机构代码';
    Items[Count - 1].ColName := 'DEPID';
    Items[Count - 1].DataType := ftString;
    Items[Count - 1].Width := 120;
    Add;
    Items[Count - 1].Caption := '机构名称';
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
  //添加没有授权编辑功能不可用
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
    Items[0].Text := '单位:' + GszDwMcOfPrint;
    Items[1].Text := '打印人:' + Gczy.name;
    Items[2].Text := '打印日期:';
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

//返回字段长度

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
      SysMessage('获取数据发生意外错误，请重试', '_JG', [mbOK]);
      exit;
    end;
    if Sender is TEdit then
    begin
      TEdit(Sender).MaxLength := FieldByName('length').AsInteger;
      TEdit(Sender).Hint := '可输入最大长度为' + IntToStr(FieldByName('length').AsInteger);
    end;
    if Sender is TSMaskEdit then
    begin
      TSMaskEdit(Sender).MaxLength := FieldByName('length').AsInteger;
      TSMaskEdit(Sender).Hint := '可输入最大长度为' + IntToStr(FieldByName('length').AsInteger);
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

//设置控制状态

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
  //助记码最多允许10位
  if EditMC.ReadOnly then
    Exit;
  blneedSaved := True; //需要保存
  if Sender = EditMC then
  begin
    PStrToPy(EditMC.text, VStrPy);
    edtZJM.Text := VStrPy;
  end;
end;

procedure TFormJGXX.SetGNFalse;
begin
  N_Add.Enabled := False; //增加
  SpeedItemAdd.Enabled := False;
  N_Delete.Enabled := False; //删除
  SpeedItemDelete.Enabled := False;
  N_Edit.Enabled := False; //修改
  SpeedItemEdit.Enabled := False;
  N_Save.Enabled := False; //保存
  SpeedItemSave.Enabled := False;
  N_Cancel.Enabled := False; //取消
  SpeedItemCancel.Enabled := False;
  N_XFSFMX.Enabled := False; //修复是否明细属性
  N_XFDQJC.Enabled := False; //修复当前级次属性
  N_XFZLZJM.Enabled := False; //修复助记码属性
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

//执行无返回值的数据操作

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
//执行有返回值的数据操作

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

//获得焦点

procedure TFormJGXX.PSetFocus(Sender: TWinControl);
begin
  try
    if Sender.Enabled then
      Sender.SetFocus;
  except
  end;
end;

//检查输入的字符是否合法，是否是0－9；A-Z;a-z

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
  if MsgBox_Question('确定删除选择的记录吗？') = IDOK then
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
  TApp.MsgBox_Info('保存成功！');
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
  //导入项目，
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
  //查询所有班级，对班级进行校验或者更新
  cdsData.First;
  ErrLists := TStringList.Create;
  ErrLists.Clear;
  while not cdsData.eof do
  begin
    //项目的判断    
    if cdsData.FieldByName('BANKNAME').AsString = '' then
      ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 银行名称不允许为空，不能导入。')
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
        ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 银行名称'+szBANKNAME+'不存在，请检查。')
    end;
    if cdsData.FieldByName('BINCODE').AsString = '' then
    begin
      ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 卡BIN不允许为空，不能导入。');
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
  AddValue('银行名称', 'C','BANKNAME', 50);
  AddValue('银行ID', 'C','DEPID', 20, '', False);
  AddValue('卡类型', 'C','CARDTYPE', 20);
  AddValue('卡长度', 'N','CARDLEN', 0);
  AddValue('卡BIN', 'C','BINCODE', 20);
  AddValue('联行号', 'C','DEFBANK', 20);
end;

function TBankBin_Imp.Save: Boolean;
begin
  inherited Save;
end;

procedure TFormJGXX.btnImportDEPClick(Sender: TObject);
var
  BankDEPID_Imp: TBankDEPID_Imp;
begin
  //导入项目，
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
    //项目的判断
    if DEPID.Locate('DEPID', cdsData.FieldByName('DEPID').AsString, [loCaseInsensitive]) then
    begin
      cdsData.Delete;
      Continue;
    end;
    if cdsData.FieldByName('DEPID').AsString = '' then
    begin
      ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 机构编号不允许为空，不能导入。');
    end;
    if cdsData.FieldByName('DEP_NAME').AsString = '' then
    begin
      ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 机构名称不允许为空，不能导入。');
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
  AddValue('机构编号', 'C','DEPID', 20);
  AddValue('银行名称', 'C','DEP_NAME', 50);
end;

function TBankDEPID_Imp.Save: Boolean;
begin
  inherited Save;
end;

function TFormJGXX.MsgBox_Question(Msg: string): Integer;
begin
  Result := Application.MessageBox(PChar(Msg), '系统提示', MB_ICONQuestion + MB_OKCANCEL);
end;

end.

