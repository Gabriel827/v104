unit YHJK;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Placemnt, ExpandPrint, SPrint2, Finder, Menus, THFilters, ImgList, Db,
  DBClient, RXSplit, StdCtrls, Buttons, Mask, SMaskEdit, ComCtrls,
  THExtCtrls, Tgrids2, THDBGrids, RXCtrls, DBTree, ExtCtrls, SpeedBar,
  FormPrint, HFExpandPrint, jpeg,RXSpin;

type
  TFormYHJK = class(TForm)
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
    EditJG: TComboBox;
    Label1: TLabel;
    EditMXDZ: TEdit;
    EditYEDZ: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EditZFDZ: TEdit;
    Label4: TLabel;
    CheckBoxDJ: TCheckBox;
    THBevelSYZT: TTHBevel;
    Label5: TLabel;
    Label6: TLabel;
    EditYH: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    EditSJJG: TEdit;
    Label9: TLabel;
    EditDKDZ: TEdit;
    Label10: TLabel;
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
    procedure THFilterJCZLFilter(Sender: TObject; AFilter: String);
    procedure EditPXHKeyPress(Sender: TObject; var Key: Char);
    procedure EditMCChange(Sender: TObject);
    procedure EditDMKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ClientDataSetYHDQGridAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
     Function  DeleteData:Boolean;
     procedure ShowData;
     procedure RefreshData;
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
    procedure SetGNFalse;//设置功能不可用
    //打开树
    procedure OpenDBTree(szSQL:string='';szField:string='';szFieldName:string='';szRule:string='');virtual;
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
    //检查是否已被使用
    function isUsed: Boolean;
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
    function GetIntfText(Intf:String):String;
    //根据参数返回使用状态
    Function  FGetSyZt(blUsed,blFreezed:Boolean):String ;
  end;

var
  FormYHJK: TFormYHJK;
  procedure LoadYHJK;

implementation

uses Pub_Function, Pub_Message, Pub_Global, ListSelectDM, Pub_WYZF, Pub_power, DataModuleMain;

{$R *.DFM}

procedure LoadYHJK;
begin
    //添加没有授权不可查阅
    if not TPower.GetPower(GN_YHJK_Read) then
    begin
      SysMessage('没有查阅权限。', AOther_JG, [mbOk]);
      Exit;
    end;
    if Application.FindComponent('FormYHJK')=nil then
        Application.CreateForm(TFormYHJK,FormYHJK);
    FormYHJK.Show;
end;


procedure TFormYHJK.SpeedBarDblClick(Sender: TObject);
begin
    PAllowButtonCaption(Speedbar);
end;

procedure TFormYHJK.SpeedItemClick(Sender: TObject);
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
        RefreshData;
   //修改
    end
    else if (Sender=N_Edit)   or (Sender=SpeedItemEdit)   then begin
        iAddOrEdit := 1 ;
        if CheckBoxDJ.Checked then begin
            PSetStateOfContrl('DJREADONLY')
        end else begin
            PSetStateOfContrl('NOTREADONLY') ;
        end ;
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
        RefreshData;
        TreeNode := DBTreeJCZL.NodeFind(szDM) ;
        DBTreeJCZL.FullCollapse ;
        DBTreeJCZL.Items[0].Expanded := True;
        if TreeNode<>nil then TreeNode.Selected := True ;
        ClientDataSetJCZLGrid.Locate('AREACODE',szDM,[]) ;
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

function TFormYHJK.CheckData: Boolean;
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

function TFormYHJK.SaveData: Boolean;
var
    szSQL:String;
    szDM,szMC,szJG,szSYZT,szMXDZ,szYEDZ,szZFDZ,szDKDZ,szYH,szSJJG :String ;
begin
    szDM     := Trim(EditDM.Text);
    szMC     := Trim(EditMC.Text);
    szJG     := TString.LeftStrBySp(EditJG.text);
    szSYZT   := FGetSyZt(THBevelSYZT.Visible,CheckBoxDJ.Checked);
    szMXDZ   := Trim(EditMXDZ.Text);
    szYEDZ   := Trim(EditYEDZ.Text);
    szZFDZ   := Trim(EditZFDZ.Text);
    szDKDZ   := Trim(EditDKDZ.Text);
    szYH     := Trim(EditYH.Text);
    szSJJG   := Trim(EditSJJG.Text);

    if iAddOrEdit=0 then begin  //新增保存
        szSQL := ' Insert into EBK_YHJK( YH_INTF,JKNAME,SYZT,ADDR_MX,ADDR_YE,ADDR_ZF,ADDR_DK,DEPID,BANKID,SJJG) values ( '
               + '''' + szDM      + ''', '
               + '''' + szMC      + ''', '
               + '''' + szSYZT    + ''', '
               + '''' + szMXDZ    + ''', '
               + '''' + szYEDZ    + ''', '
               + '''' + szZFDZ    + ''', '
               + '''' + szDKDZ    + ''', '
               + '''' + szJG      + ''', '
               + '''' + szYH      + ''', '
               + '''' + szSJJG    + ''')' ;
    end else begin              //修改保存
        szSQL :=  ' Update EBK_YHJK set '
               + '  JKNAME=''' + szMC   + ''' '
               + '  ,SYZT=''' + szSYZT   + ''' '
               + '  ,ADDR_MX=''' + szMXDZ   + ''' '
               + '  ,ADDR_YE=''' + szYEDZ   + ''' '
               + '  ,ADDR_ZF=''' + szZFDZ   + ''' '
               + '  ,ADDR_DK=''' + szDKDZ   + ''' '
               + '  ,DEPID=''' + szJG   + ''' '
               + '  ,BANKID=''' + szYH   + ''' '
               + '  ,SJJG=''' + szSJJG   + ''' '
               + ' Where YH_INTF=''' + szDM + ''' ' ;
    end;

    Result := ExeEditSql(ClientDataSetSave,szSQL) ;
    if not Result then begin
        SysMessage('存盘失败，请稍候重试！','_YB',[mbOk]);
    end;
end;

function TFormYHJK.AskIfDel: Boolean;
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
function TFormYHJK.isUsed: Boolean;
var szSQL,szDM: string;
begin
    szDM  := Trim(EditDM.Text);
    szSQL := 'select count(*) as num from zb_yhzl where gsdm='''+GszHSDWDM+''' and yh_intf='''+szDM+'''';
    with DataModulePub.ClientDataSetTmp do
    begin
      Close;
      POpenSql(DataModulePub.ClientDataSetTmp, szSQL);
      if FindFirst then
        while not EOF do
        begin
          if FieldByName('num').asString = '0' then begin
            Result := False;
            break;
          end else begin
            Result := True;
            break;
          end;
        end;
      Close;
    end;
end;

//删除数据
Function TFormYHJK.FDeleteData(szTableName,szFieldName,szFieldValue:String;szWhere:String=''):Boolean ;
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

Function  TFormYHJK.DeleteData:Boolean;
var
    szDM:String ;
begin
    Result := False ;
    szDM := Trim(EditDM.Text) ;
    if not AskIfDEL then Exit ;
    if isUsed then begin  //判断是否已使用了
      SysMessage('该网银接口已使用，不能删除！','_YB',[mbOk]);
      Exit ;
    end;
    if not FDeleteData('EBK_YHJK','YH_INTF',Trim(szDM)) then Exit ;
    Result := True ;
end;

procedure TFormYHJK.ShowData;
begin
    With ClientDataSetJCZLGrid do begin
        EditDM.Text  := FieldByName('YH_INTF').asstring ;
        EditMC.Text  := FieldByName('JKNAME').asstring ;
        EditJG.text  := GetIntfText(FieldByName('DEPID').asstring);
        EditMXDZ.Text:= FieldByName('ADDR_MX').AsString ;
        EditYEDZ.Text:= FieldByName('ADDR_YE').AsString ;
        EditZFDZ.Text:= FieldByName('ADDR_ZF').AsString ;
        EditDKDZ.Text:= FieldByName('ADDR_DK').AsString ;
        EditYH.Text  := FieldByName('BANKID').AsString ;
        EditSJJG.Text:= FieldByName('SJJG').AsString ;
    end;
end;

procedure TFormYHJK.RefreshData;
var
    szSQL:string;
begin
    szSQL := 'select A.*,B.DEP_NAME from EBK_YHJK A,EBK_DEPID B WHERE A.DEPID=B.DEPID order By A.DEPID ' ;
    OpenDBTree(szSQL,'DEPID','JKNAME','3');
    OpenDBGrid(szSQL);
end;


procedure TFormYHJK.FormClose(Sender: TObject;
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
    FormYHJK := nil;
end;

procedure TFormYHJK.SpeedItemAddClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemAdd);
end;

procedure TFormYHJK.SpeedItemCancelClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemCancel);
end;

procedure TFormYHJK.SpeedItemDeleteClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemDelete);
end;

procedure TFormYHJK.SpeedItemEditClick(Sender: TObject);
begin
    if CheckBoxDJ.Checked then
        SysMessage('该记录已被冻结，请先修改解除冻结，保存后再修改其他项！','_YB',[mbOk]);
    SpeedItemClick(SpeedItemEdit);
end;

procedure TFormYHJK.SpeedItemExitClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemExit);
end;

procedure TFormYHJK.SpeedItemFilterClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemFilter);
end;

procedure TFormYHJK.SpeedItemFindClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemFind);
end;

procedure TFormYHJK.SpeedItemHelpClick(Sender: TObject);
begin
    ChangeHelp('EBK.hlp',35);
end;

procedure TFormYHJK.SpeedItemNoFilterClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemNoFilter);
end;

procedure TFormYHJK.SpeedItemPreviewClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemPreview);
end;

procedure TFormYHJK.SpeedItemPrintClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemPrint);
end;

procedure TFormYHJK.SpeedItemRefreshClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemRefresh);
end;

procedure TFormYHJK.SpeedItemSaveClick(Sender: TObject);
begin
    SpeedItemClick(SpeedItemSave);
end;

procedure TFormYHJK.ClientDataSetYHDQGridAfterScroll(DataSet: TDataSet);
begin
    SpeedItemClick(N_Cancel);
end;

procedure TFormYHJK.EditMCKeyDown(Sender: TObject; var Key: Word;
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

procedure TFormYHJK.OpenDBGrid(szSQL:string);
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


procedure TFormYHJK.OpenDBTree(szSQL, szField, szFieldName,szRule : string);
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
    DBTreeJCZL.Items[0].Expanded := True;
end;

procedure TFormYHJK.THDBGridJCZLHeaderDblClick(ACol: Integer;
  var CanLock: Boolean; AShift: TShiftState);
begin
    CanLock := True;
end;

procedure TFormYHJK.DBTreeJCZLChange(Sender: TObject; Node: TTreeNode);
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
    szTemp := copy(szTemp,1,pos(' ',szTemp)-1);
    if trim(szTemp)='' then
            szTreeFilter := ''
    else
        szTreeFilter := DBTreeJCZL.DataField+' like '''+szTemp+'%''';
    PDoFilter;
end;

procedure TFormYHJK.FormCreate(Sender: TObject);
begin
    iCZJLNo := PWriteNewCzjl(self.Caption);
    SpeedBar.Wallpaper.Bitmap.Handle := LoadBitmap(hInstance, 'BACKGROUND');
    szTreeFilter := '';
    szCtrlFilter := '';
    FormPrintJCZL.ShowZero :=True ;
    SetTHFilter;
    SetFinderField('YH_INTF','JKNAME');
    PGetFieldLength(EditDM,'EBK_YHJK','YH_INTF');
    PGetFieldLength(EditMC,'EBK_YHJK','JKNAME');

    with DataModulePub.ClientDataSetTmp do
    begin
      EditJG.Clear;
      Close;
      POpenSql(DataModulePub.ClientDataSetTmp, 'select * from ebk_depid order By depid');
      if FindFirst then
        while not EOF do
        begin
         EditJG.Items.Add(FieldByName('DEPID').asString + ' ' +
           FieldByName('DEP_NAME').asString);
         if not FindNext then
           break;
        end;
      Close;
    end;
end;

procedure TFormYHJK.SetTHFilter;
begin
    THFilterJCZL.THDBGridPad := THDBGridJCZL;
    
    szPrintTitle := '地区代码资料' ;
    with THFilterJCZL.GridCols do
    begin
        Clear;
        Add;
        Items[Count-1].Caption := '网银接口代码';
        Items[Count-1].ColName := 'YH_INTF';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '名称';
        Items[Count-1].ColName := 'JKNAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '机构名称';
        Items[Count-1].ColName := 'DEP_NAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '明细地址';
        Items[Count-1].ColName := 'ADDR_MX';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '余额地址';
        Items[Count-1].ColName := 'ADDR_YE';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '支付地址';
        Items[Count-1].ColName := 'ADDR_ZF';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '代扣地址';
        Items[Count-1].ColName := 'ADDR_DK';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '银行接口标识';
        Items[Count-1].ColName := 'BANKID';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 90;
        Add;
        Items[Count-1].Caption := '时间间隔';
        Items[Count-1].ColName := 'SJJG';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 90;
    end;
    THFilterJCZL.InitColumns;
end;

procedure TFormYHJK.SetBtnEnabled;
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
    if not TPower.GetPower(GN_YHJK_Edit) then
    begin
      SetGNFalse;
    end;
end;


procedure TFormYHJK.SetBtnDisabled;
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

procedure TFormYHJK.SetBtnStatus(Sender: TObject);
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

procedure TFormYHJK.FormShow(Sender: TObject);
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

procedure TFormYHJK.FinderJCZLFound(Sender: TObject);
var
    szTemp:string;
begin
    try
        szTemp := ClientDataSetJCZLTree.FieldByName(FinderJCZL.CodeFldName).asstring;
        DBTreeJCZL.NodeFind(szTemp).Selected := True;
    except
    end;
end;

procedure TFormYHJK.SetFinderField(szCode, szName: string);
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
Procedure  TFormYHJK.PGetFieldLength(Sender:Tobject;szTableName,szFieldName:String);
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

procedure TFormYHJK.THFilterJCZLFilter(Sender: TObject;
  AFilter: String);
begin
//    szCtrlFilter := AFilter;
    PDoFilter;
end;

procedure TFormYHJK.PDoFilter;
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

procedure TFormYHJK.PSetNoFilterBtnStatus;
begin
    N_NoFilter.Enabled := (szCtrlFilter<>'') ;
    SpeedItemNoFilter.Enabled := (szCtrlFilter<>'') ;
end;

procedure TFormYHJK.EditPXHKeyPress(Sender: TObject; var Key: Char);
begin
    if ( not (Key in  ['0'..'9']) ) and
       ( ord(key)<>8 ) then Key:=#0 ;
end;

//设置控制状态
procedure TFormYHJK.PSetStateOfContrl(szLX:string);
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
        CheckBoxDJ.Checked:=False;
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
        CheckBoxDJ.Enabled:=False;
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
        CheckBoxDJ.Enabled:=True;
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
        CheckBoxDJ.Enabled:=True;
    end;
end;

procedure TFormYHJK.EditMCChange(Sender: TObject);
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


procedure TFormYHJK.SetGNFalse;
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

procedure TFormYHJK.EditDMKeyPress(Sender: TObject; var Key: Char);
begin
    if (ord(key)=8) or ((ord(key)>=48) and (ord(key)<=57)) or ((ord(key)>=65) and (ord(key)<=90)) or ((ord(key)>=97) and (ord(key)<=122)) then
    else
        key:=chr(0);
end;

procedure TFormYHJK.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    PWriteEndCzjl(iCZJLNo);
end;

//执行无返回值的数据操作
function TFormYHJK.ExeEditSql(dbTmp:TClientDataSet;szSQL:String):Boolean;
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
function TFormYHJK.ExeQuerySql(dbTmp:TClientDataSet;szSQL:String):Boolean;
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
Procedure TFormYHJK.PSetFocus(Sender:TWinControl) ;
begin
  try
    if Sender.Enabled then Sender.SetFocus ;
  except
  end;
end;

//检查输入的字符是否合法，是否是0－9；A-Z;a-z
Function  TFormYHJK.CheckInStr(InStr:string):Boolean ;
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

function TFormYHJK.GetIntfText(Intf: String): String;
var
  i:integer;
begin
  for i:=0 to EditJG.Items.Count-1 do
  begin
    if UpperCase(intf) = UpperCase(TString.LeftStrBySp(EditJG.Items[i])) then
    begin
      Result := EditJG.Items[i];
    end;
  end;
end;

//根据参数返回使用状态
Function  TFormYHJK.FGetSyZt(blUsed,blFreezed:Boolean):String ;
begin
    if blUsed then begin
        if blFreezed then
            Result := '3'
        else
            Result := '1' ;
    end else begin
        if blFreezed then
            Result := '2'
        else
            Result := '0' ;
    end;
end;

end.
