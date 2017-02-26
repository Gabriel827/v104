unit YHHH;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, ExpandPrint, SPrint2, Finder, Menus, THFilters, ImgList, Db,
  DBClient, RXSplit, StdCtrls, Buttons, Mask, SMaskEdit, ComCtrls,
  THExtCtrls, Tgrids2, THDBGrids, RXCtrls, DBTree, ExtCtrls, SpeedBar,
  FormPrint, HFExpandPrint, jpeg,RXSpin, uDev_ClassBaseInfo, uDev_BaseImport;

type
  TFormYHHH = class(TForm)
    PanelFirst: TPanel;
    PanelTop: TPanel;
    PanelLeftMain: TPanel;
    DBTreeJCZL: TDBTree;
    PanelTitle: TPanel;
    RxLabelTitle: TRxLabel;
    PanelMain: TPanel;
    THDBGridJCZL: TTHDBGrid;
    PanelRightTop: TPanel;
    GroupBoxYHDQ: TGroupBox;
    LabelDM: TLabel;
    LabelMC: TLabel;
    RxLabelDep: TLabel;
    RxLabelPeople: TLabel;
    EditDM: TEdit;
    EditMC: TEdit;
    PanelButton: TPanel;
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
    THBevelSYZT: TTHBevel;
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
    DBTreeJGXX: TDBTree;
    ClientDataSetJGXXTree: TClientDataSet;
    DataSourceJGXXTree: TDataSource;
    btnImport: TSpeedItem;
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
    procedure DBTreeJGXXChange(Sender: TObject; Node: TTreeNode);
    procedure DBTreeJCZLChange(Sender: TObject; Node: TTreeNode);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    //公用事件处理
    procedure SpeedItemClick(Sender: TObject);
    procedure FinderJCZLFound(Sender: TObject);
    procedure THFilterJCZLFilter(Sender: TObject; AFilter: String);
    procedure EditPXHKeyPress(Sender: TObject; var Key: Char);
    procedure EditMCChange(Sender: TObject);
    procedure EditDMKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ClientDataSetYHDQGridAfterScroll(DataSet: TDataSet);
    procedure btnImportClick(Sender: TObject);
  private
    { Private declarations }
     Function  DeleteData:Boolean;
     procedure ShowData;
     procedure RefreshData;
     procedure RefreshGridData;
     Function  CheckData: Boolean;
     function  SaveData: Boolean;
  public
    { Public declarations }
    iCZJLNo:integer;
    iAddOrEdit:Integer ;  //新增还是修改0新增1修改
    blneedSaved: Boolean ; //是否需要保存
    szTreeFilter:string;
    szCtrlFilter:string;
    szPrintTitle:String;
    szCznr :string;
    szDQ :string;
    szJG :string;
    procedure SetGNFalse;//设置功能不可用
    //打开树
    procedure OpenDBTree(szSQL:string='';szField:string='';szFieldName:string='';szRule:string='');virtual;
    procedure OpenDBJGXXTree(szSQL:string='';szField:string='';szFieldName:string='';szRule:string='');virtual;
    //打开表
    procedure OpenDBGrid(szSQL:string='');virtual;
    //设置Filter控件
    procedure SetTHFilter;virtual;
    //设置所有按钮可用
    procedure SetBtnEnabled;
    //设置所有按钮不可用
    procedure SetBtnDisabled;
    //根据按钮状态设置其它按钮状态
    procedure SetBtnStatus(Sender:TObject);
    //设置查找控件的代码和名称
    procedure SetFinderField(szCode:string='';szName:string='');
    //执行筛选
    procedure PDoFilter;
    //恢复是否有效
    Procedure PSetNoFilterBtnStatus ;
    //设置控制状态
    procedure PSetStateOfContrl(szLX:string);virtual;
    //返回字段长度
    Procedure PGetFieldLength(Sender:Tobject;szTableName,szFieldName:String);
    //删除询问
    function AskIfDel: Boolean;
    //删除数据
    Function FDeleteData(szTableName,szFieldName,szFieldValue:String;szWhere:String=''):Boolean ;
    //执行无返回值的数据操作
    function ExeEditSql(dbTmp:TClientDataSet;szSQL:String):Boolean;
    //执行有返回值的数据操作
    function ExeQuerySql(dbTmp:TClientDataSet;szSQL:String):Boolean;
    //获得焦点
    Procedure PSetFocus(Sender:TWinControl) ;
    //检查输入的字符是否合法，是否是0－9；A-Z;a-z
    Function  CheckInStr(InStr:string):Boolean ;
  end;
  
  TBankHH_Imp = class(TImport)
    DEPID:TClientDataSet;
    AREA:TClientDataSet;
  public
    //基础数据检查
    constructor Create;
    function Check: Boolean; override;
    function Save: Boolean; override;
  end;
var
  FormYHHH: TFormYHHH;
  procedure LoadYHHH;

implementation

uses Pub_Function, Pub_Message, Pub_Global, ListSelectDM, Pub_WYZF, Pub_power, DataModuleMain;

{$R *.DFM}

procedure LoadYHHH;
begin
    //添加没有授权不可查阅
    if not TPower.GetPower(GN_YHHH_Read) then
    begin
      SysMessage('没有查阅权限。', AOther_JG, [mbOk]);
      Exit;
    end;
    if Application.FindComponent('FormYHHH')=nil then
        Application.CreateForm(TFormYHHH,FormYHHH);
    FormYHHH.Show;
end;


procedure TFormYHHH.SpeedBarDblClick(Sender: TObject);
begin
    PAllowButtonCaption(Speedbar);
end;

procedure TFormYHHH.SpeedItemClick(Sender: TObject);
var
    TreeNode:TTreeNode ;
    szDM:String ;
begin
    if (Sender=N_Preview) or (Sender=SpeedItemPreview)
        or (Sender=N_Print) or (Sender=SpeedItemPrint) then
    begin
         FormPrintJCZL.GridTop :=150;
         with FormPrintJCZL,FormPrintJCZL.OtherItems do
         begin
          if GszDwMcOfPrint<>'' then
              Items[0].Text :='单位:' + GszDwMcOfPrint
          else
              Items[0].Text :='单位:' + GszHSDWMC ;
          Items[1].Text := '打印人:'+Gczy.name ;
          Items[2].Text := '打印日期:';
         end;
    end ;

    //新增
    if (Sender=N_Add) or (Sender=SpeedItemAdd) then begin
        PSetStateOfContrl('CLEAR');
        PSetStateOfContrl('NOTREADONLY');
        PSetFocus(EditDM) ;
        iAddOrEdit := 0 ;
    //删除
    end
    else if (Sender=N_Delete) or (Sender=SpeedItemDelete) then begin
        if not DeleteData then Exit ;
        ShowData ;
        iAddOrEdit := 1 ;
        RefreshGridData;
        ShowData;
   //修改
    end
    else if (Sender=N_Edit)   or (Sender=SpeedItemEdit)   then begin
        iAddOrEdit := 1 ;
        PSetStateOfContrl('NOTREADONLY') ;
        EditDM.ReadOnly := True ;
    //保存
    end
    else if (Sender=N_Save)   or (Sender=SpeedItemSave)   then begin
        szDM := Trim(EditDM.Text) ;
        if not CheckData then Exit ;
        if not SaveData  then Exit ;
        blneedSaved := False;  //不需要保存
        PSetStateOfContrl('READONLY');
        iAddOrEdit := 1 ;
        RefreshGridData;
        //TreeNode := DBTreeJCZL.NodeFind(szDM) ;
        //DBTreeJCZL.FullCollapse ;
        //DBTreeJCZL.Items[0].Expanded := True;
        //if TreeNode<>nil then TreeNode.Selected := True ;
        ClientDataSetJCZLGrid.Locate('BANK_CODE',szDM,[]) ;
    //取消
    end
    else if (Sender=N_Cancel) or (Sender=SpeedItemCancel) then begin
        PSetStateOfContrl('READONLY');
        ShowData ;
        blneedSaved := False;  //不需要保存
        iAddOrEdit := 1 ;
    end
    else if (Sender=N_Refresh) or (Sender=SpeedItemRefresh) then begin
        RefreshData;
        TreeNode := DBTreeJCZL.NodeFind(szDM) ;
        DBTreeJCZL.FullCollapse ;
        DBTreeJCZL.Items[0].Expanded := True;
        if TreeNode<>nil then TreeNode.Selected := True ;
    end;
    
    if (Sender=SpeedItemExit) or (Sender=N_Exit) then
    begin
        Close
    end
    else if Sender=N_Preview then
    begin
         if FormPrintJCZL.PrintSetup then
            FormPrintJCZL.Preview;
    end
    else if Sender=SpeedItemPreview then
    begin
        FormPrintJCZL.Preview;
    end
    else if Sender=N_Print then
    begin
        if FormPrintJCZL.PrintSetUp then
            FormPrintJCZL.Print;
    end
    else if Sender=SpeedItemPrint then
    begin
        FormPrintJCZL.Print;
    end
    else if (Sender=SpeedItemFind) or (Sender=N_Find) then
    begin
        FinderJCZL.DataSet := ClientDataSetJCZLTree;
        FinderJCZL.Execute;
    end
    else if Sender=N_Export then
    begin
        HFExpandPrintJCZL.Execute;
    end
    else if (Sender=N_DOFilter) or (Sender=SpeedItemFilter) then
    begin
        THFilterJCZL.ExecFilter;
    end
    else if (Sender=N_NoFilter) or (Sender=SpeedItemNoFilter) then
    begin
        THFilterJCZL.RestoreFilter;
//        szCtrlFilter := '';
//        PDoFilter;
    end ;
    SetBtnStatus(Sender);

    //PSetNoFilterBtnStatus;
end;

function TFormYHHH.CheckData: Boolean;
var
    szDM,szMC : String;
begin
    Result := False ;
    szDM     := Trim(EditDM.Text) ;
    szMC     := Trim(EditMC.Text) ;
    if szDM = '' then begin
        SysMessage('%1不能为空，请重新输入！','_YB',[mbOk],'代码');
        PSetFocus( EditDM ) ;
        exit;
    end;
    if szMC = '' then begin
        SysMessage('%1不能为空，请重新输入！','_YB',[mbOk],'名称');
        PSetFocus( EditMC ) ;
        exit;
    end;
    if not CheckInStr(szDM) then
    begin
        SysMessage('代码为非法字符。','_YB',[mbOk],'代码');
        PSetFocus( EditDM ) ;
        exit;
    end;
    Result := True ;
end;

function TFormYHHH.SaveData: Boolean;
var
    szSQL:String;
    szDM,szMC :String ;
begin
    szDM     := Trim(EditDM.Text) ;
    szMC     := Trim(EditMC.Text) ;

    if iAddOrEdit=0 then begin  //新增保存
        szSQL := ' Insert into EBK_BANKINFO( DEPID,AREACODE,BANK_CODE,BANK_NAME) values ( '
               + '''' + szJG      + ''', '
               + '''' + szDQ      + ''', '
               + '''' + szDM      + ''', '
               + '''' + szMC      + ''')' ;
    end else begin              //修改保存
        szSQL :=  ' Update EBK_BANKINFO set '
               + '  BANK_NAME=''' + szMC   + ''' '
               + ' Where BANK_CODE=''' + szDM + ''' ' ;
    end;

    Result := ExeEditSql(ClientDataSetSave,szSQL) ;
    if not Result then begin
        SysMessage('存盘失败，请稍候重试！','_YB',[mbOk]);
    end;
end;

function TFormYHHH.AskIfDel: Boolean;
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

//删除数据
Function TFormYHHH.FDeleteData(szTableName,szFieldName,szFieldValue:String;szWhere:String=''):Boolean ;
var
    szSQL: String ;
begin
    szSQL := ' delete from ' + szTableName +
             ' where ' + szFieldName + '=''' + szFieldValue + ''' ' ;
    if szWhere<>'' then
        szSQL:=szSQL + ' and ' + szWhere ;
    Result := ExeEditSql(DataModulePub.ClientDataSetPub,szSQL) ;
    if not Result then
         SysMessage('删除失败，请稍后重试！','_YB',[mbOK]) ;
end;

Function  TFormYHHH.DeleteData:Boolean;
var
    szDM:String ;
begin
    Result := False ;
    szDM := Trim(EditDM.Text) ;
    if not AskIfDEL then Exit ;
    if not FDeleteData('EBK_BANKINFO','BANK_CODE',Trim(szDM)) then Exit ;
    Result := True ;
end;

procedure TFormYHHH.ShowData;
begin
    With ClientDataSetJCZLGrid do begin
        EditDM.Text  := FieldByName('BANK_CODE').asstring ;
        EditMC.Text  := FieldByName('BANK_NAME').asstring ;
    end;
end;

procedure TFormYHHH.RefreshData;
var
    szSQL,szSQL1,szSQL2:string;
begin
    szSQL := 'select * from EBK_BANKINFO WHERE 1=2';
    if ORACLE=GDbType then
      szSQL1 := 'select * from (select areacode,provid,areacode as code, area_name from EBK_AREACODE union all select provid as areacode,provid,SUBSTR(min(areacode), 0, 2) as code,province as area_name from EBK_AREACODE group by provid, province) a order by provid,code '
    else
      szSQL1 := 'select * from (select areacode,provid,areacode code,area_name from EBK_AREACODE union all select provid areacode,provid,SUBSTRING(min(areacode), 0, 2) code,province area_name from EBK_AREACODE group by provid, province) a order by provid,code ';
    szSQL2 := 'select * from ebk_depid';
    OpenDBTree(szSQL1,'areacode','AREA_NAME','2-2');
    OpenDBJGXXTree(szSQL2,'depid','dep_name','3');
    OpenDBGrid(szSQL);
    szJG := '';
    szDQ := '';
end;

procedure TFormYHHH.RefreshGridData;
var
    szSQL:string;
begin
    szSQL := 'select a.*,b.dep_name,c.area_name from EBK_BANKINFO a,ebk_depid b,EBK_AREACODE c WHERE a.depid=b.depid and a.areacode=c.areacode and a.DEPID='''+szJG+''' and a.areacode='''+szDQ+'''';
    OpenDBGrid(szSQL);
end;

procedure TFormYHHH.FormClose(Sender: TObject;
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
    FormYHHH := nil;
end;

procedure TFormYHHH.SpeedItemAddClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemAdd);
end;

procedure TFormYHHH.SpeedItemCancelClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemCancel);
end;

procedure TFormYHHH.SpeedItemDeleteClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemDelete);
end;

procedure TFormYHHH.SpeedItemEditClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemEdit);
end;

procedure TFormYHHH.SpeedItemExitClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemExit);
end;

procedure TFormYHHH.SpeedItemFilterClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemFilter);
end;

procedure TFormYHHH.SpeedItemFindClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemFind);
end;

procedure TFormYHHH.SpeedItemHelpClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemHelp);
end;

procedure TFormYHHH.SpeedItemNoFilterClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemNoFilter);
end;

procedure TFormYHHH.SpeedItemPreviewClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemPreview);
end;

procedure TFormYHHH.SpeedItemPrintClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemPrint);
end;

procedure TFormYHHH.SpeedItemRefreshClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemRefresh);
end;

procedure TFormYHHH.SpeedItemSaveClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemSave);
end;

procedure TFormYHHH.ClientDataSetYHDQGridAfterScroll(DataSet: TDataSet);
begin
    SpeedItemClick(N_Cancel);
end;

procedure TFormYHHH.EditMCKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    ACtrl:TWinControl;
begin
    if Key=13 then
    begin
        ACtrl := FindNextControl(TWinControl(Sender),True, True, False);
        if ACtrl <> nil then
            ACtrl.SetFocus;
    end;
end;

procedure TFormYHHH.OpenDBGrid(szSQL:string);
begin
    //打开表
    if szSQL = '' then  Exit;
    with ClientDataSetJCZLGrid do
    begin
        try
            Close;
            Filter := '';
            POpenSQL(ClientDataSetJCZLGrid, szSQL);
        except
            SysMessage('打开数据库发生意外错误。','_JG',[mbOK]);
            Close;
            Exit;
        end;
    end;
end;


procedure TFormYHHH.OpenDBTree(szSQL, szField, szFieldName,szRule : string);
begin
    //打开树
    if (szSQL='') or (szField='') or (szFieldName='') then
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
            SysMessage('打开数据库发生意外错误。','_JG',[mbOK]);
            Close;
            Exit;
        end;
    end;
    DBTreeJCZL.FullCollapse ;
    DBTreeJCZL.Items[0].Expanded := false;
end;

procedure TFormYHHH.OpenDBJGXXTree(szSQL, szField, szFieldName,szRule : string);
begin
    //打开树
    if (szSQL='') or (szField='') or (szFieldName='') then
        Exit
    else
    begin
        DBTreeJGXX.DataField := szField;
        DBTreeJGXX.FieldCodeName := szFieldName;
        DBTreeJGXX.FieldCodeRule := szRule;
    end;
    with ClientDataSetJGXXTree do
    begin
        try
            POpenSQL(ClientDataSetJGXXTree, szSQL);
        except
            SysMessage('打开数据库发生意外错误。','_JG',[mbOK]);
            Close;
            Exit;
        end;
    end;
    DBTreeJGXX.FullCollapse ;
    DBTreeJGXX.Items[0].Expanded := false;
end;

procedure TFormYHHH.THDBGridJCZLHeaderDblClick(ACol: Integer;
  var CanLock: Boolean; AShift: TShiftState);
begin
    CanLock := True;
end;

procedure TFormYHHH.DBTreeJCZLChange(Sender: TObject; Node: TTreeNode);
var
    szTemp:string;
begin
    if blneedSaved then
    begin
        case SysMessage('资料内容已发生变化，退出前是否保存？','_XW',
              [mbYes,mbNo,mbCancel]) of
        mrYes:
            begin
                SpeedItemClick(SpeedItemSave);
                if blneedSaved then exit;
            end;
        mrNo : blneedSaved:=False;
        else  Exit;
        end
    end;
     //表随树动
    if DBTreeJCZL.Selected=nil then
        Exit;
    szTemp := DBTreeJCZL.Selected.Text;
    szTemp := Format('%.4d', [strtoint(copy(szTemp,1,pos(' ',szTemp)-1))]);
    szDQ := szTemp;

    RefreshGridData;
end;

procedure TFormYHHH.DBTreeJGXXChange(Sender: TObject; Node: TTreeNode);
var
    szTemp:string;
begin
    if blneedSaved then
    begin
        case SysMessage('资料内容已发生变化，退出前是否保存？','_XW',
              [mbYes,mbNo,mbCancel]) of
        mrYes:
            begin
                SpeedItemClick(SpeedItemSave);
                if blneedSaved then exit;
            end;
        mrNo : blneedSaved:=False;
        else  Exit;
        end
    end;
     //表随树动
    if DBTreeJGXX.Selected=nil then
        Exit;
    szTemp := DBTreeJGXX.Selected.Text;
    szTemp := Format('%.3d', [strtoint(copy(szTemp,1,pos(' ',szTemp)-1))]);
    szJG := szTemp;

    RefreshGridData;
end;

procedure TFormYHHH.FormCreate(Sender: TObject);
begin
    iCZJLNo := PWriteNewCzjl(self.Caption);
    SpeedBar.Wallpaper.Bitmap.Handle := LoadBitmap(hInstance, 'BACKGROUND');
    szTreeFilter := '';
    szCtrlFilter := '';
    FormPrintJCZL.ShowZero :=True ;
    SetTHFilter;
    SetFinderField('BANK_CODE','BANK_NAME');
    PGetFieldLength(EditDM,'EBK_BANKINFO','BANK_CODE');
    PGetFieldLength(EditMC,'EBK_BANKINFO','BANK_NAME');

end;

procedure TFormYHHH.SetTHFilter;
begin
    THFilterJCZL.THDBGridPad := THDBGridJCZL;
    
    szPrintTitle := '银行行号资料' ;
    with THFilterJCZL.GridCols do
    begin
        Clear;
        Add;
        Items[Count-1].Caption := '银行行号';
        Items[Count-1].ColName := 'BANK_CODE';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '银行名称';
        Items[Count-1].ColName := 'BANK_NAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '机构代码';
        Items[Count-1].ColName := 'DEPID';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '机构名称';
        Items[Count-1].ColName := 'DEP_NAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '地区代码';
        Items[Count-1].ColName := 'AREACODE';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '地区名称';
        Items[Count-1].ColName := 'AREA_NAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
    end;
    THFilterJCZL.InitColumns;
end;

procedure TFormYHHH.SetBtnEnabled;
var
    i:integer;
begin
    for i:=0 to self.ComponentCount-1 do
    begin
        if self.Components[i] is TSpeedItem then begin
            if (self.Components[i] as TSpeedItem).tag=0 then
                (self.Components[i] as TSpeedItem).Enabled := True ;
        end else if self.Components[i] is TMenuItem then begin
            if (self.Components[i] as TMenuItem).tag=0 then
                (self.Components[i] as TMenuItem).Enabled := True;
        end ;
    end;
    //添加没有授权编辑功能不可用
    if not TPower.GetPower(GN_YHHH_Edit) then
    begin
      SetGNFalse;
    end;
end;


procedure TFormYHHH.SetBtnDisabled;
var
    i:integer;
begin
    for i:=0 to self.ComponentCount-1 do
    begin
        if self.Components[i] is TSpeedItem then begin
            if (self.Components[i] as TSpeedItem).tag=0 then
                (self.Components[i] as TSpeedItem).Enabled := False ;
        end else if (self.Components[i] is TMenuItem) then begin
            if (self.Components[i] as TMenuItem).tag=0 then
                (self.Components[i] as TMenuItem).Enabled := False;
        end ;
    end;
    MFile.Enabled := True;
    MRun.Enabled := True;

end;

procedure TFormYHHH.SetBtnStatus(Sender: TObject);
begin
    if (Sender=SpeedItemRefresh) or (Sender=N_Refresh) then
    begin
        SetBtnEnabled;
        SpeedItemSave.Enabled := False;
        SpeedItemCancel.Enabled := False;
        N_Save.Enabled := False;
        N_Cancel.Enabled := False;
    end
    else if (Sender=SpeedItemAdd) or (Sender=N_Add)
            or (Sender=SpeedItemEdit) or (Sender=N_Edit) then
    begin
        SetBtnDisabled;
        SpeedItemSave.Enabled := True;
        SpeedItemCancel.Enabled := True;
        N_Save.Enabled := True;
        N_Cancel.Enabled := True;
    end
    else if (Sender=SpeedItemSave) or (Sender=N_Save)
            or (Sender=SpeedItemCancel) or (Sender=N_Cancel) then
    begin
        SetBtnEnabled;
        SpeedItemSave.Enabled := False;
        SpeedItemCancel.Enabled := False;
        N_Save.Enabled := False;
        N_Cancel.Enabled := False;
    end  ;
    if DBTreeJCZL.Items.Count = 1 then
    begin
         SpeedItemDelete.Enabled:=False;
         N_Delete.Enabled:=False;
         SpeedItemEdit.Enabled:=False;
         N_Edit.Enabled:=False;
    end;
    
end;

procedure TFormYHHH.FormShow(Sender: TObject);
begin
    SetComponentsColor(self);
    SpeedItemRefresh.Click;
    with FormPrintJCZL,FormPrintJCZL.OtherItems do
    begin
        Items[0].Text := '单位:'   + GszDwMcOfPrint;
        Items[1].Text := '打印人:' + Gczy.name ;
        Items[2].Text := '打印日期:';
        Items[4].Text := szPrintTitle
    end;
end;

procedure TFormYHHH.FinderJCZLFound(Sender: TObject);
var
    szTemp:string;
begin
    try
        szTemp := ClientDataSetJCZLTree.FieldByName(FinderJCZL.CodeFldName).asstring;
        DBTreeJCZL.NodeFind(szTemp).Selected := True;
    except
    end;
end;

procedure TFormYHHH.SetFinderField(szCode, szName: string);
begin
    if (szCode='') or (szName='') then
        Exit
    else
    begin
        FinderJCZL.CodeFldName := szCode;
        FinderJCZL.NameFldName := szName;
    end;
end;

//返回字段长度
Procedure  TFormYHHH.PGetFieldLength(Sender:Tobject;szTableName,szFieldName:String);
begin
    with DataModulePub.ClientDataSetTmp do
    begin
        try
            Close;
            if GDbType = MSSQL then
            begin
                POpenSQL(DataModulePub.ClientDataSetTmp, 'select length from syscolumns WHERE ID=object_id('''+szTableName+''') AND NAME='''+szFieldName+'''');
            end
            else
            begin
                POpenSQL(DataModulePub.ClientDataSetTmp, 'select DATA_LENGTH length from user_tab_columns where table_name=upper('''+szTableName+''') and column_name=upper('''+szFieldName+''')');
            end;
        except
            Close;
            SysMessage('获取数据发生意外错误，请重试' ,'_JG',[mbOK]);
            exit;
        end;
        if Sender is TEdit then
        begin
            TEdit(Sender).MaxLength := FieldByName('length').AsInteger;
            TEdit(Sender).Hint := '可输入最大长度为'+IntToStr(FieldByName('length').AsInteger);
        end;
        if Sender is TSMaskEdit then
        begin
            TSMaskEdit(Sender).MaxLength := FieldByName('length').AsInteger;
            TSMaskEdit(Sender).Hint := '可输入最大长度为'+IntToStr(FieldByName('length').AsInteger);
        end;
        close;
    end ;
end;

procedure TFormYHHH.THFilterJCZLFilter(Sender: TObject;
  AFilter: String);
begin
//    szCtrlFilter := AFilter;
    PDoFilter;
end;

procedure TFormYHHH.PDoFilter;
var
    szTemp:string;
begin
    szTemp := szTreeFilter;
    if trim(szTemp)='' then
        if szCtrlFilter<>'' then
            szTemp := szCtrlFilter
        else
            szTemp := ''
    else
        if szCtrlFilter<>'' then
            szTemp := szTemp+' and '+szCtrlFilter
        else
            szTemp := szTemp+'';
    ClientDataSetJCZLGrid.Filtered := False;
    ClientDataSetJCZLGrid.Filter := szTemp;
    ClientDataSetJCZLGrid.Filtered := True;
end;

procedure TFormYHHH.PSetNoFilterBtnStatus;
begin
    N_NoFilter.Enabled := (szCtrlFilter<>'') ;
    SpeedItemNoFilter.Enabled := (szCtrlFilter<>'') ;
end;

procedure TFormYHHH.EditPXHKeyPress(Sender: TObject; var Key: Char);
begin
    if ( not (Key in  ['0'..'9']) ) and
       ( ord(key)<>8 ) then Key:=#0 ;
end;

//设置控制状态
procedure TFormYHHH.PSetStateOfContrl(szLX:string);
var
    i:Integer ;
begin
    if UpperCase(szLX)='CLEAR' then begin
        For i:=0 to ComponentCount-1 do  begin
            if (Components[i] is TEdit) then
                TEdit(Components[i]).Text:='' ;
            if (Components[i] is TSMaskEdit) then
                TSMaskEdit(Components[i]).Text:='' ;
            if (Components[i] is TCheckBox) then
                TCheckBox(Components[i]).Checked:= False;
            if (Components[i] is TComBoBox) then
                TComboBox(Components[i]).Text:='';
            if (Components[i] is TMemo) then
                TMemo(Components[i]).Text:='' ;
            if (Components[i] is TRxSpinEdit) then
                TRxSpinEdit(Components[i]).Text:='1' ;
        end;
        THBevelSYZT.Visible := False ;
    end else if UpperCase(szLX)='READONLY' then begin
        For i:=0 to ComponentCount-1 do  begin
            if (Components[i] is TEdit) then
                TEdit(Components[i]).ReadOnly  := True;
            if (Components[i] is TSMaskEdit) then
            begin
                TSMaskEdit(Components[i]).ReadOnly  := True;
                TSMaskEdit(Components[i]).LoadButton := False;
            end;
            if (Components[i] is TCheckBox) then
                TCheckBox(Components[i]).Enabled:= False;
            if (Components[i] is TComBoBox) then
                TComboBox(Components[i]).Enabled:= False;
            if (Components[i] is TMemo) then
                TMemo(Components[i]).ReadOnly  := True;
            if (Components[i] is TRxSpinEdit) then
                TRxSpinEdit(Components[i]).ReadOnly  := True;
            if (Components[i] is TDateTimePicker) then
                TDateTimePicker(Components[i]).Enabled  := False;
            if (Components[i] is TGroupBox) then
                TGroupBox(Components[i]).Enabled  := false;
        end;
    end else if Uppercase(szLX)='DJREADONLY' then begin
        For i:=0 to ComponentCount-1 do  begin
            if (Components[i] is TEdit) then
                TEdit(Components[i]).ReadOnly  := True;
            if (Components[i] is TSMaskEdit) then
            begin
                TSMaskEdit(Components[i]).ReadOnly  := True;
                TSMaskEdit(Components[i]).LoadButton := False;
            end;
            if (Components[i] is TCheckBox) then
                TCheckBox(Components[i]).Enabled:= False;
            if (Components[i] is TComBoBox) then
                TComboBox(Components[i]).Enabled:= False;
            if (Components[i] is TMemo) then
                TMemo(Components[i]).ReadOnly  := True;
            if (Components[i] is TRxSpinEdit) then
                TRxSpinEdit(Components[i]).ReadOnly  := True;
            if (Components[i] is TDateTimePicker) then
                TDateTimePicker(Components[i]).Enabled  := False;
            if (Components[i] is TGroupBox) then
                TGroupBox(Components[i]).Enabled  := TRUE;
            if (Components[i] is TTabSheet) then
                TTabSheet(Components[i]).Enabled  := TRUE;
        end;
    end else if Uppercase(szLX)='NOTREADONLY' then begin
        For i:=0 to ComponentCount-1 do  begin
            if (Components[i] is TEdit) then
                TEdit(Components[i]).ReadOnly  := False;
            if (Components[i] is TSMaskEdit) then
            begin
                TSMaskEdit(Components[i]).ReadOnly  := False;
                TSMaskEdit(Components[i]).LoadButton := True;
            end;
            if (Components[i] is TCheckBox) then
                TCheckBox(Components[i]).Enabled:= True;
            if (Components[i] is TComBoBox) then
                TComboBox(Components[i]).Enabled:= True;
            if (Components[i] is TMemo) then
                TMemo(Components[i]).ReadOnly  := False;
            if (Components[i] is TRxSpinEdit) then
                TRxSpinEdit(Components[i]).ReadOnly  := False;
            if (Components[i] is TDateTimePicker) then
                TDateTimePicker(Components[i]).Enabled  := True;
            if (Components[i] is TGroupBox) then
                TGroupBox(Components[i]).Enabled  := true;
            if (Components[i] is TTabSheet) then
                TTabSheet(Components[i]).Enabled  := TRUE;
        end;
    end;
end;

procedure TFormYHHH.EditMCChange(Sender: TObject);
var
    VStrPy:string;
begin
    //助记码最多允许10位
    if EditMC.ReadOnly then Exit ;
    blneedSaved:=True;     //需要保存
    if Sender=EditMC then
    begin
        PStrToPy(EditMC.text,VStrPy);
    end;
end;


procedure TFormYHHH.SetGNFalse;
begin
    N_Add.Enabled           := False ;  //增加
    SpeedItemAdd.Enabled    := False ;
    N_Delete.Enabled        := False ;  //删除
    SpeedItemDelete.Enabled := False ;
    N_Edit.Enabled          := False ;  //修改
    SpeedItemEdit.Enabled   := False ;
    N_Save.Enabled          := False ;  //保存
    SpeedItemSave.Enabled   := False ;
    N_Cancel.Enabled        := False ;  //取消
    SpeedItemCancel.Enabled := False ;
    N_XFSFMX.Enabled        := False ;  //修复是否明细属性
    N_XFDQJC.Enabled        := False ;  //修复当前级次属性
    N_XFZLZJM.Enabled        := False ;   //修复助记码属性
end;

procedure TFormYHHH.EditDMKeyPress(Sender: TObject; var Key: Char);
begin
    if (ord(key)=8) or ((ord(key)>=48) and (ord(key)<=57)) or ((ord(key)>=65) and (ord(key)<=90)) or ((ord(key)>=97) and (ord(key)<=122)) then
    else
        key:=chr(0);
end;

procedure TFormYHHH.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    PWriteEndCzjl(iCZJLNo);
end;

//执行无返回值的数据操作
function TFormYHHH.ExeEditSql(dbTmp:TClientDataSet;szSQL:String):Boolean;
var
    i:Integer ;
begin
    with dbTmp do //ClientDataSetPubSave
    begin
        Try
            Close ;
            For i:=0 to Params.Count-1 do begin
                Params[i].Clear ;
            end;
            PExecSQL(dbTmp, szSQl);
            if GDbType=ORACLE THEN
            begin
                close;
                PExecSQL(dbTmp, 'commit');
            end;
            Close ;
            Result := True ;
        Except
            close ;
            Result := False ;
        end;
        CommandText := '';
    end;
end;
//执行有返回值的数据操作
function TFormYHHH.ExeQuerySql(dbTmp:TClientDataSet;szSQL:String):Boolean;
var
    i:Integer ;
begin
    with dbTmp do
    begin
        Try
            Close;
            For i:=0 to Params.Count-1 do begin
                Params[i].Clear ;
            end;
            POpenSQL(dbTmp, szSQL);
            Result := True ;
        Except
            Close ;
            Result := False ;
        end;
    end;
end;

//获得焦点
Procedure TFormYHHH.PSetFocus(Sender:TWinControl) ;
begin
  try
    if Sender.Enabled then Sender.SetFocus ;
  except
  end;
end;

//检查输入的字符是否合法，是否是0－9；A-Z;a-z
Function  TFormYHHH.CheckInStr(InStr:string):Boolean ;
var
    i,iCharOrd:integer;
begin
    Result:=False;
    for i:=1 to Length(InStr)-1 do
    begin
         iCharOrd:=Ord(InStr[i]);
         if ((iCharOrd>=48) and (iCharOrd<=57)) or (( iCharOrd>=65 ) and (iCharOrd<=90)) or (( iCharOrd>=97 ) and (iCharOrd<=122)) then
         else
         begin
            exit;
         end;
    end;
    Result:=True;
end;

procedure TFormYHHH.btnImportClick(Sender: TObject);
var
  BankHH_Imp: TBankHH_Imp;
begin
  //导入项目，
  try
    BankHH_Imp := TBankHH_Imp.Create;
    LoadImortFrmFile(BankHH_Imp);
    SpeedItemRefreshClick(nil);
  finally
    BankHH_Imp.Free;
  end;
end;

{ TBankHH_Imp }

function TBankHH_Imp.Check: Boolean;
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
    if cdsData.FieldByName('DEPID').AsString = '' then
      ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 机构编号不允许为空，不能导入。')
    else
    begin
      szBANKNAME := cdsData.FieldByName('DEPID').AsString;
      if not DEPID.Locate('DEPID', szBANKNAME, [loCaseInsensitive]) then
        ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 机构编号'+szBANKNAME+'不存在，请检查。')
    end;
    
    if cdsData.FieldByName('AREACODE').AsString = '' then
      ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行,地区编号不允许为空，不能导入。')
    else
    begin
      szBANKNAME := cdsData.FieldByName('AREACODE').AsString;
      if not AREA.Locate('AREACODE', szBANKNAME, [loCaseInsensitive]) then
        ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 地区编号'+szBANKNAME+'不存在，请检查。')
    end;

    if cdsData.FieldByName('BANK_CODE').AsString = '' then
    begin
      ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 联行号不允许为空，不能导入。');
    end
    else
    begin
      with DataModulePub.GetCdsBySQL('Select BANK_CODE from EBK_BANKINFO where BANK_CODE='
        +QuotedStr(cdsData.FieldByName('BANK_CODE').AsString)) do
      begin
        if RecordCount > 0 then
        begin
          cdsData.Delete;
          Continue;
        end;
      end;
    end;
    if cdsData.FieldByName('BANK_NAME').AsString = '' then
    begin
      ErrLists.Add('第' + IntToStr(cdsData.RecNo + 1) + '行, 银行名称不允许为空，不能导入。');
    end;
    cdsData.Next;
  end;
  Result := ErrLists.Count = 0;
  Error := ErrLists.Text;
  ErrLists.Free;
end;

constructor TBankHH_Imp.Create;
begin
  DEPID := DataModulePub.GetCdsBySQL('select DEPID, DEP_NAME, ZJM from EBK_DEPID');
  AREA := DataModulePub.GetCdsBySQL('select AREACODE from EBK_AREACODE');
  inherited Create('EBK_BANKINFO', 'BANK_CODE');
  AddValue('机构编号', 'C','DEPID', 20);
  AddValue('地区编号', 'C','AREACODE', 20);
  AddValue('联行号', 'C','BANK_CODE', 20);
  AddValue('银行名称', 'C','BANK_NAME', 50);
end;

function TBankHH_Imp.Save: Boolean;
begin
 inherited Save;
end;

end.
