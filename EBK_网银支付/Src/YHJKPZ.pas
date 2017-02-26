unit YHJKPZ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, ExpandPrint, SPrint2, Finder, Menus, THFilters, ImgList, Db,
  DBClient, RXSplit, StdCtrls, Buttons, Mask, SMaskEdit, ComCtrls,
  THExtCtrls, Tgrids2, THDBGrids, RXCtrls, DBTree, ExtCtrls, SpeedBar,
  FormPrint, HFExpandPrint, jpeg,RXSpin;

type
  TFormYHJKPZ = class(TForm)
    PanelFirst: TPanel;
    PanelTop: TPanel;
    PanelLeftMain: TPanel;
    PanelTitle: TPanel;
    RxLabelTitle: TRxLabel;
    PanelMain: TPanel;
    THDBGridJCZL: TTHDBGrid;
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
    DataSourceJCZL: TDataSource;
    THFilterJCZL: TTHFilter;
    THFilterYHJK: TTHFilter;
    THFilterJKPZ: TTHFilter;
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
    Panel1: TPanel;
    ClientDataSetJCZLTree: TClientDataSet;
    Panel2: TPanel;
    Panel4: TPanel;
    THDBGridYHJK: TTHDBGrid;
    THDBGridJKPZ: TTHDBGrid;
    Panel3: TPanel;
    Button1: TButton;
    ClientDataSetYHJKGrid: TClientDataSet;
    ClientDataSetJKPZGrid: TClientDataSet;
    DataSourceYHJK: TDataSource;
    DataSourceJKPZ: TDataSource;
    EditSX: TEdit;
    EditGL: TEdit;
    EditQS: TEdit;
    PanelButton: TPanel;
    THBevelSYZT: TTHBevel;
    LableSX: TLabel;
    LabelQS: TLabel;
    LabelGL: TLabel;
    Label1: TLabel;
    EditSXMC: TEdit;
    LabelSXMS: TLabel;
    EditSXMS: TEdit;
    LabelSXLX: TLabel;
    LabelNBZDM: TLabel;
    EditSXLX: TEdit;
    EditNBZDM: TEdit;
    EditLX: TComboBox;
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
    procedure THFilterJKPZFilter(Sender: TObject; AFilter: String);
    procedure EditPXHKeyPress(Sender: TObject; var Key: Char);
    procedure EditMCChange(Sender: TObject);
    procedure EditBSKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ClientDataSetGridAfterScroll(DataSet: TDataSet);
    procedure ClientDataSetYHJKGridAfterScroll(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure EditLXChange(Sender: TObject);
  private
    { Private declarations }
     Function  DeleteData:Boolean;
     procedure ShowData;
     procedure ShowYHJKData;
     procedure RefreshData;
     procedure RefreshYHJKData;
     Function  CheckData: Boolean;
     function  SaveData: Boolean;
     function  SaveSelectData(selectAttrid: string): Boolean;
  public
    { Public declarations }
    iCZJLNo:integer;
    iAddOrEdit:Integer ;  //新增还是修改0新增1修改
    blneedSaved: Boolean ; //是否需要保存
    szTreeFilter:string;
    szCtrlFilter:string;
    szPrintTitle:String;
    szCznr :string;
    procedure SetGNFalse;//设置功能不可用
    //打开表
    procedure OpenDBGrid(szSQL:string='');virtual;
    procedure OpenDBGridYH(szSQLYH:string='');virtual;
    procedure OpenDBGridJK(szSQLJK:string='');virtual;
    //设置Filter控件
    procedure SetTHFilter;virtual;
    procedure SetTHYHFilter;virtual;
    procedure SetTHJKFilter;virtual;
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
    Function FDeleteData(szTableName,szFieldName,szFieldValue,szFieldName2,szFieldValue2,szFieldName3,szFieldValue3:String;szWhere:String=''):Boolean ;
    //执行无返回值的数据操作
    function ExeEditSql(dbTmp:TClientDataSet;szSQL:String):Boolean;
    //执行有返回值的数据操作
    function ExeQuerySql(dbTmp:TClientDataSet;szSQL:String):Boolean;
    //获得焦点
    Procedure PSetFocus(Sender:TWinControl) ;
    //检查输入的字符是否合法，是否是0－9；A-Z;a-z
    Function  CheckInStr(InStr:string):Boolean ;
    function  GetIntfText(Intf:String):String;
  end;

var
  FormYHJKPZ: TFormYHJKPZ;
  procedure LoadYHJKPZ;

implementation

uses Pub_Function, Pub_Message, Pub_Global, ListSelectDM, Pub_WYZF, Pub_power, DataModuleMain;

{$R *.DFM}

procedure LoadYHJKPZ;
begin
    //添加没有授权不可查阅
    if not TPower.GetPower(GN_YHJKPZ_Read) then
    begin
      SysMessage('没有查阅权限。', AOther_JG, [mbOk]);
      Exit;
    end;
    if Application.FindComponent('FormYHJKPZ')=nil then
        Application.CreateForm(TFormYHJKPZ,FormYHJKPZ);
    FormYHJKPZ.Show;
end;


procedure TFormYHJKPZ.SpeedBarDblClick(Sender: TObject);
begin
    PAllowButtonCaption(Speedbar);
end;

procedure TFormYHJKPZ.SpeedItemClick(Sender: TObject);
var
    TreeNode:TTreeNode ;
    szBS:String ;
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
        PSetFocus(EditBS) ;
        iAddOrEdit := 0 ;
    //删除
    end
    else if (Sender=N_Delete) or (Sender=SpeedItemDelete) then begin
        if not DeleteData then Exit ;
        ShowData ;
        iAddOrEdit := 1 ;
        RefreshData;
        RefreshYHJKData;
   //修改
    end
    else if (Sender=N_Edit)   or (Sender=SpeedItemEdit)   then begin
        iAddOrEdit := 1 ;
        PSetStateOfContrl('NOTREADONLY') ;
        EditBS.ReadOnly := True ;
        EditMC.ReadOnly := True ;
        EditSXMC.ReadOnly := True ;
        EditSXMS.ReadOnly := True ;
        EditSXLX.ReadOnly := True ;
        EditNBZDM.ReadOnly := True ;
    //保存
    end
    else if (Sender=N_Save)   or (Sender=SpeedItemSave)   then begin
        szBS := Trim(EditBS.Text) ;
        if not CheckData then Exit ;
        if not SaveData  then Exit ;
        blneedSaved := False;  //不需要保存
        PSetStateOfContrl('READONLY');
        iAddOrEdit := 1 ;
        RefreshYHJKData;
        ClientDataSetJCZLGrid.Locate('YH_INTF',szBS,[]) ;
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

function TFormYHJKPZ.CheckData: Boolean;
var
    szBS,szMC : String;
begin
    Result := False ;
    szBS     := Trim(EditBS.Text) ;
    szMC     := Trim(EditMC.Text) ;
    if szBS = '' then begin
        SysMessage('%1不能为空，请重新输入！','_YB',[mbOk],'代码');
        PSetFocus( EditBS ) ;
        exit;
    end;
    if szMC = '' then begin
        SysMessage('%1不能为空，请重新输入！','_YB',[mbOk],'名称');
        PSetFocus( EditMC ) ;
        exit;
    end;
    if not CheckInStr(szBS) then
    begin
        SysMessage('代码为非法字符。','_YB',[mbOk],'代码');
        PSetFocus( EditBS ) ;
        exit;
    end;
    Result := True ;
end;

function TFormYHJKPZ.SaveData: Boolean;
var
    szSQL:String;
    szBS,szMC,szSX,szGL,szQS,szLX :String ;
begin
    szBS     := Trim(EditBS.Text) ;
    szMC     := Trim(EditMC.Text) ;
    szSX     := Trim(EditSX.Text) ;
    szGL     := Trim(EditGL.Text) ;
    szQS     := Trim(EditQS.Text) ;
    szLX     := TString.LeftStrBySp(EditLX.text);

    if iAddOrEdit=0 then begin  //新增保存
        szSQL := ' Insert into ebk_yhjkpz( YH_INTF,ATTRID,ATTRRANGE,RELATION,DEFAULTVL,INTFTYPE) values ( '
               + '''' + szBS      + ''', '
               + '''' + szMC      + ''', '
               + '''' + szSX      + ''', '
               + '''' + szGL      + ''', '
               + '''' + szQS      + ''', '
               + '''' + szLX      + ''')' ;
    end else begin              //修改保存
        szSQL :=  ' Update ebk_yhjkpz set '
               + '  ATTRRANGE=''' + szSX   + ''', '
               + '  RELATION=''' + szGL   + ''', '
               + '  DEFAULTVL=''' + szQS   + '''  '
               + ' Where YH_INTF=''' + szBS + ''' AND ATTRID=''' +szMC +''' AND INTFTYPE=''' +szLX+ '''' ;
    end;

    Result := ExeEditSql(ClientDataSetSave,szSQL) ;
    if not Result then begin
        SysMessage('存盘失败，请稍候重试！','_YB',[mbOk]);
    end;
end;

function TFormYHJKPZ.AskIfDel: Boolean;
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
Function TFormYHJKPZ.FDeleteData(szTableName,szFieldName,szFieldValue,szFieldName2,szFieldValue2,szFieldName3,szFieldValue3:String;szWhere:String=''):Boolean ;
var
    szSQL: String ;
begin
    szSQL := ' delete from ' + szTableName +
             ' where ' + szFieldName + '=''' + szFieldValue + ''' and ' + szFieldName2 + ' =''' + szFieldValue2 + ''' and ' + szFieldName3 + ' =''' + szFieldValue3 + ''' ' ;
    if szWhere<>'' then
        szSQL:=szSQL + ' and ' + szWhere ;
    Result := ExeEditSql(DataModulePub.ClientDataSetPub,szSQL) ;
    if not Result then
         SysMessage('删除失败，请稍后重试！','_YB',[mbOK]) ;
end;

Function  TFormYHJKPZ.DeleteData:Boolean;
var
    szBS:String;
    szMC:String;
    szLX:string;
begin
    Result := False ;
    szBS := Trim(EditBS.Text) ;
    szMC := Trim(EditMC.Text) ;
    szLX := TString.LeftStrBySp(EditLX.text);
    if not AskIfDEL then Exit ;
    if not FDeleteData('ebk_yhjkpz','ATTRID',Trim(szMC),'YH_INTF',Trim(szBS),'INTFTYPE',Trim(szLX)) then Exit ;
    Result := True ;
end;

procedure TFormYHJKPZ.ShowData;
begin
    With ClientDataSetYHJKGrid do begin
        EditBS.Text  := FieldByName('YH_INTF').asstring ;
    end;
    With ClientDataSetJCZLGrid do begin
        EditMC.Text  := FieldByName('ATTRID').asstring ;
        EditSX.Text  := FieldByName('ATTRRANGE').asstring ;
        EditSXMC.Text  := FieldByName('ATTRNAME').asstring ;
        EditQS.Text  := FieldByName('DEFAULTVL').asstring ;
        EditGL.Text  := FieldByName('RELATION').asstring ;
        EditSXMS.Text  := FieldByName('ATTRDESC').asstring ;
        EditSXLX.Text  := FieldByName('ATTRTYPE').asstring ;
        EditNBZDM.Text  := FieldByName('ZFXXFIELD').asstring ;
    end;
end;

procedure TFormYHJKPZ.ShowYHJKData;
begin
    RefreshYHJKData;
    With ClientDataSetJCZLGrid do begin
        EditMC.Text  := FieldByName('ATTRID').asstring ;
        EditSX.Text  := FieldByName('ATTRRANGE').asstring ;
        EditSXMC.Text  := FieldByName('ATTRNAME').asstring ;
        EditQS.Text  := FieldByName('DEFAULTVL').asstring ;
        EditGL.Text  := FieldByName('RELATION').asstring ;
        EditSXMS.Text  := FieldByName('ATTRDESC').asstring ;
        EditSXLX.Text  := FieldByName('ATTRTYPE').asstring ;
        EditNBZDM.Text  := FieldByName('ZFXXFIELD').asstring ;
    end;
end;

procedure TFormYHJKPZ.RefreshData;
var
    szSQL:string;
    szSQLYH:string;
    szSQLJK:string;
begin
    if FormYHJKPZ.EditLX.Text='' then FormYHJKPZ.EditLX.Text := 'zf 支付汇兑';
    szSQL := 'select a.*,b.jkname,c.attrname,c.attrdesc,c.attrtype,c.zfxxfield from ebk_yhjkpz a,ebk_yhjk b,ebk_yhjksx c where a.yh_intf=b.yh_intf and a.attrid=c.attrid and a.yh_intf='''+EditBS.Text+''' and c.intftype=a.intftype and c.intftype='''+TString.LeftStrBySp(EditLX.Text)+'''' ;
    szSQLYH := 'select yh_intf,jkname from EBK_YHJK order by yh_intf';
    szSQLJK := 'select ATTRID,ATTRNAME from ebk_yhjksx where ltrim(rtrim(ATTRID)) not in (select attrid from ebk_yhjkpz where yh_intf='''+EditBS.Text+''' and intftype='''+TString.LeftStrBySp(EditLX.Text)+''') and intftype='''+TString.LeftStrBySp(EditLX.Text)+'''';
    OpenDBGrid(szSQL);
    OpenDBGridYH(szSQLYH);
    OpenDBGridJK(szSQLJK);
end;

procedure TFormYHJKPZ.RefreshYHJKData;
var
    szSQL:string;
    szSQLJK:string;
begin
    szSQL := 'select a.*,b.jkname,c.attrname,c.attrdesc,c.attrtype,c.zfxxfield from ebk_yhjkpz a,ebk_yhjk b,ebk_yhjksx c where a.yh_intf=b.yh_intf and a.attrid=c.attrid and a.yh_intf='''+EditBS.Text+''' and c.intftype=a.intftype and c.intftype='''+TString.LeftStrBySp(EditLX.Text)+'''' ;
    szSQLJK := 'select ATTRID,ATTRNAME from ebk_yhjksx where ltrim(rtrim(ATTRID)) not in (select attrid from ebk_yhjkpz where yh_intf='''+EditBS.Text+''' and intftype='''+TString.LeftStrBySp(EditLX.Text)+''') and intftype='''+TString.LeftStrBySp(EditLX.Text)+'''';
    OpenDBGrid(szSQL);
    OpenDBGridJK(szSQLJK);
end;


procedure TFormYHJKPZ.FormClose(Sender: TObject;
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
    FormYHJKPZ := nil;
end;

procedure TFormYHJKPZ.SpeedItemAddClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemAdd);
end;

procedure TFormYHJKPZ.SpeedItemCancelClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemCancel);
end;

procedure TFormYHJKPZ.SpeedItemDeleteClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemDelete);
end;

procedure TFormYHJKPZ.SpeedItemEditClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemEdit);
end;

procedure TFormYHJKPZ.SpeedItemExitClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemExit);
end;

procedure TFormYHJKPZ.SpeedItemFilterClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemFilter);
end;

procedure TFormYHJKPZ.SpeedItemFindClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemFind);
end;

procedure TFormYHJKPZ.SpeedItemHelpClick(Sender: TObject);
begin
    ChangeHelp('EBK.hlp',36);
end;

procedure TFormYHJKPZ.SpeedItemNoFilterClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemNoFilter);
end;

procedure TFormYHJKPZ.SpeedItemPreviewClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemPreview);
end;

procedure TFormYHJKPZ.SpeedItemPrintClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemPrint);
end;

procedure TFormYHJKPZ.SpeedItemRefreshClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemRefresh);
    ShowYHJKData;
end;

procedure TFormYHJKPZ.SpeedItemSaveClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemSave);
end;

procedure TFormYHJKPZ.ClientDataSetGridAfterScroll(DataSet: TDataSet);
begin
    SpeedItemClick(N_Cancel);
end;

procedure TFormYHJKPZ.ClientDataSetYHJKGridAfterScroll(DataSet: TDataSet);
begin
    SpeedItemClick(N_Cancel);
    ShowYHJKData;
end;

procedure TFormYHJKPZ.EditMCKeyDown(Sender: TObject; var Key: Word;
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

procedure TFormYHJKPZ.OpenDBGrid(szSQL:string);
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

procedure TFormYHJKPZ.OpenDBGridYH(szSQLYH:string);
begin
    //打开表
    if szSQLYH = '' then  Exit;
    with ClientDataSetYHJKGrid do
    begin
        try
            Close;
            Filter := '';
            POpenSQL(ClientDataSetYHJKGrid, szSQLYH);
        except
            SysMessage('打开数据库发生意外错误。','_JG',[mbOK]);
            Close;
            Exit;
        end;
    end;
end;

procedure TFormYHJKPZ.OpenDBGridJK(szSQLJK:string);
begin
    //打开表
    if szSQLJK = '' then  Exit;
    with ClientDataSetJKPZGrid do
    begin
        try
            Close;
            Filter := '';
            POpenSQL(ClientDataSetJKPZGrid, szSQLJK);
        except
            SysMessage('打开数据库发生意外错误。','_JG',[mbOK]);
            Close;
            Exit;
        end;
    end;
end;

procedure TFormYHJKPZ.THDBGridJCZLHeaderDblClick(ACol: Integer;
  var CanLock: Boolean; AShift: TShiftState);
begin
    CanLock := True;
end;

procedure TFormYHJKPZ.DBTreeJCZLChange(Sender: TObject; Node: TTreeNode);
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
    PDoFilter;
end;

procedure TFormYHJKPZ.FormCreate(Sender: TObject);
begin
    iCZJLNo := PWriteNewCzjl(self.Caption);
    SpeedBar.Wallpaper.Bitmap.Handle := LoadBitmap(hInstance, 'BACKGROUND');
    szTreeFilter := '';
    szCtrlFilter := '';
    FormPrintJCZL.ShowZero :=True ;
    SetTHFilter;
    SetTHYHFilter;
    SetTHJKFilter;
    SetFinderField('YH_INTF','ATTRID');
    PGetFieldLength(EditBS,'ebk_yhjkpz','YH_INTF');
    PGetFieldLength(EditMC,'ebk_yhjkpz','ATTRID');

    with DataModulePub.ClientDataSetTmp do
    begin
      EditLX.Clear;
      Close;
      POpenSql(DataModulePub.ClientDataSetTmp, 'select JKLXID,JKLXNAME from EBK_YHJKLX');
      if FindFirst then
        while not EOF do
        begin
         EditLX.Items.Add(FieldByName('JKLXID').asString + ' ' +
           FieldByName('JKLXNAME').asString);
         if not FindNext then
           break;
        end;
      Close;
    end;
end;

procedure TFormYHJKPZ.SetTHFilter;
begin
    THFilterJCZL.THDBGridPad := THDBGridJCZL;

    szPrintTitle := '银行接口配置资料' ;
    with THFilterJCZL.GridCols do
    begin
        Clear;
        Add;
        Items[Count-1].Caption := '银行接口';
        Items[Count-1].ColName := 'YH_INTF';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '银行接口名称';
        Items[Count-1].ColName := 'JKNAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '属性标识';
        Items[Count-1].ColName := 'ATTRID';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '属性名称';
        Items[Count-1].ColName := 'ATTRNAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '属性范围';
        Items[Count-1].ColName := 'ATTRRANGE';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '关联';
        Items[Count-1].ColName := 'RELATION';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '缺省值';
        Items[Count-1].ColName := 'DEFAULTVL';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '属性描述';
        Items[Count-1].ColName := 'ATTRDESC';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '属性类型';
        Items[Count-1].ColName := 'ATTRTYPE';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '内部字段名';
        Items[Count-1].ColName := 'ZFXXFIELD';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
    end;
    THFilterJCZL.InitColumns;
end;

procedure TFormYHJKPZ.SetTHYHFilter;
begin
    THFilterYHJK.THDBGridPad := THDBGridYHJK;

    szPrintTitle := '银行接口资料' ;

    with THFilterYHJK.GridCols do
    begin
        Clear;
        Add;
        Items[Count-1].Caption := '银行接口';
        Items[Count-1].ColName := 'YH_INTF';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '银行接口名称';
        Items[Count-1].ColName := 'JKNAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
    end;
    THFilterYHJK.InitColumns;

end;

procedure TFormYHJKPZ.SetTHJKFilter;
begin
    THFilterJKPZ.THDBGridPad := THDBGridJKPZ;

    szPrintTitle := '属性资料' ;

    with THFilterJKPZ.GridCols do
    begin
        Clear;
        Add;
        Items[Count-1].Caption := '属性标识';
        Items[Count-1].ColName := 'ATTRID';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '属性名称';
        Items[Count-1].ColName := 'ATTRNAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
    end;
    THFilterJKPZ.InitColumns;
end;

procedure TFormYHJKPZ.SetBtnEnabled;
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
    if not TPower.GetPower(GN_YHJKPZ_Edit) then
    begin
      SetGNFalse;
    end;
end;


procedure TFormYHJKPZ.SetBtnDisabled;
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

procedure TFormYHJKPZ.SetBtnStatus(Sender: TObject);
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
end;

procedure TFormYHJKPZ.FormShow(Sender: TObject);
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

procedure TFormYHJKPZ.FinderJCZLFound(Sender: TObject);
var
    szTemp:string;
begin
    try
        szTemp := ClientDataSetJCZLTree.FieldByName(FinderJCZL.CodeFldName).asstring;
    except
    end;
end;

procedure TFormYHJKPZ.SetFinderField(szCode, szName: string);
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
Procedure  TFormYHJKPZ.PGetFieldLength(Sender:Tobject;szTableName,szFieldName:String);
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

procedure TFormYHJKPZ.THFilterJKPZFilter(Sender: TObject;
  AFilter: String);
begin
//    szCtrlFilter := AFilter;
    PDoFilter;
end;

procedure TFormYHJKPZ.PDoFilter;
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

procedure TFormYHJKPZ.PSetNoFilterBtnStatus;
begin
    N_NoFilter.Enabled := (szCtrlFilter<>'') ;
    SpeedItemNoFilter.Enabled := (szCtrlFilter<>'') ;
end;

procedure TFormYHJKPZ.EditPXHKeyPress(Sender: TObject; var Key: Char);
begin
    if ( not (Key in  ['0'..'9']) ) and
       ( ord(key)<>8 ) then Key:=#0 ;
end;

//设置控制状态
procedure TFormYHJKPZ.PSetStateOfContrl(szLX:string);
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
//            if (Components[i] is TComBoBox) then
//                TComboBox(Components[i]).Text:='';
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
//            if (Components[i] is TComBoBox) then
//                TComboBox(Components[i]).Enabled:= False;
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
//            if (Components[i] is TComBoBox) then
//                TComboBox(Components[i]).Enabled:= False;
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
//            if (Components[i] is TComBoBox) then
//                TComboBox(Components[i]).Enabled:= True;
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

procedure TFormYHJKPZ.EditMCChange(Sender: TObject);
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


procedure TFormYHJKPZ.SetGNFalse;
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
end;

procedure TFormYHJKPZ.EditBSKeyPress(Sender: TObject; var Key: Char);
begin
    if (ord(key)=8) or ((ord(key)>=48) and (ord(key)<=57)) or ((ord(key)>=65) and (ord(key)<=90)) or ((ord(key)>=97) and (ord(key)<=122)) then
    else
        key:=chr(0);
end;

procedure TFormYHJKPZ.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    PWriteEndCzjl(iCZJLNo);
end;

//执行无返回值的数据操作
function TFormYHJKPZ.ExeEditSql(dbTmp:TClientDataSet;szSQL:String):Boolean;
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
function TFormYHJKPZ.ExeQuerySql(dbTmp:TClientDataSet;szSQL:String):Boolean;
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
Procedure TFormYHJKPZ.PSetFocus(Sender:TWinControl) ;
begin
  try
    if Sender.Enabled then Sender.SetFocus ;
  except
  end;
end;

//检查输入的字符是否合法，是否是0－9；A-Z;a-z
Function  TFormYHJKPZ.CheckInStr(InStr:string):Boolean ;
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

//多选银行接口配置存储
procedure TFormYHJKPZ.Button1Click(Sender: TObject);
var
      tmpTableName: string;
      i,j:integer;
      s:string;
begin
    begin
      tmpTableName := '';
      if THDBGridJKPZ.DataSource.DataSet.IsEmpty then exit;
      if THDBGridJKPZ.SelectedRows=nil then begin
        ShowMessage('THDBGridJKPZ.SelectedRows为nil');
        exit;
      end;

      if (THDBGridJKPZ.SelectedRows<>nil) and (THDBGridJKPZ.SelectedRows.count = 0)  then begin
        showmessage('请首先选择<银行接口配置信息>！');
        exit;
      end;
      if THDBGridJKPZ.SelectedRows.Count>0 then
        THDBGridJKPZ.DataSource.DataSet.DisableControls;
        with THDBGridJKPZ.DataSource.DataSet do
          for i:=0 to THDBGridJKPZ.SelectedRows.Count-1 do
          begin
            THDBGridJKPZ.DataSource.DataSet.GotoBookmark(pointer(THDBGridJKPZ.SelectedRows.Items[i]));
            tmpTableName := trim(THDBGridJKPZ.DataSource.DataSet.FieldByName('ATTRID').AsString);
//            ShowMessage(tmpTableName);
            SaveSelectData(tmpTableName);
          end;
        THDBGridJKPZ.DataSource.DataSet.EnableControls;

    end;
    RefreshYHJKData;
end;

//银行接口配置储存
function TFormYHJKPZ.SaveSelectData(selectAttrid:String): Boolean;
var
    szSQL:String;
    szBS:string;
    szLX:string;
begin
    szBS  := Trim(EditBS.Text) ;
    szLX  := TString.LeftStrBySp(EditLX.text);
    szSQL := ' Insert into ebk_yhjkpz( YH_INTF,ATTRID,INTFTYPE) values ( '
               + '''' + szBS      + ''', '
               + '''' + selectAttrid      + ''', '
               + '''' + szLX      + ''')' ;
    Result := ExeEditSql(ClientDataSetSave,szSQL) ;
    if not Result then begin
        SysMessage('存盘失败，请稍候重试！','_YB',[mbOk]);
    end;
end;

function TFormYHJKPZ.GetIntfText(Intf: String): String;
var
  i:integer;
begin
  for i:=0 to EditLX.Items.Count-1 do
  begin
    if UpperCase(intf) = UpperCase(TString.LeftStrBySp(EditLX.Items[i])) then
    begin
      Result := EditLX.Items[i];
    end;
  end;
end;

procedure TFormYHJKPZ.EditLXChange(Sender: TObject);
begin
    SpeedItemClick(N_Cancel);
    ShowYHJKData;
end;

end.
