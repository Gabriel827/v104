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
    //�����¼�����
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
    iAddOrEdit:Integer ;  //���������޸�0����1�޸�
    blneedSaved: Boolean ; //�Ƿ���Ҫ����
    szTreeFilter:string;
    szCtrlFilter:string;
    szPrintTitle:String;
    szCznr :string;
    szDQ :string;
    szJG :string;
    procedure SetGNFalse;//���ù��ܲ�����
    //����
    procedure OpenDBTree(szSQL:string='';szField:string='';szFieldName:string='';szRule:string='');virtual;
    procedure OpenDBJGXXTree(szSQL:string='';szField:string='';szFieldName:string='';szRule:string='');virtual;
    //�򿪱�
    procedure OpenDBGrid(szSQL:string='');virtual;
    //����Filter�ؼ�
    procedure SetTHFilter;virtual;
    //�������а�ť����
    procedure SetBtnEnabled;
    //�������а�ť������
    procedure SetBtnDisabled;
    //���ݰ�ť״̬����������ť״̬
    procedure SetBtnStatus(Sender:TObject);
    //���ò��ҿؼ��Ĵ��������
    procedure SetFinderField(szCode:string='';szName:string='');
    //ִ��ɸѡ
    procedure PDoFilter;
    //�ָ��Ƿ���Ч
    Procedure PSetNoFilterBtnStatus ;
    //���ÿ���״̬
    procedure PSetStateOfContrl(szLX:string);virtual;
    //�����ֶγ���
    Procedure PGetFieldLength(Sender:Tobject;szTableName,szFieldName:String);
    //ɾ��ѯ��
    function AskIfDel: Boolean;
    //ɾ������
    Function FDeleteData(szTableName,szFieldName,szFieldValue:String;szWhere:String=''):Boolean ;
    //ִ���޷���ֵ�����ݲ���
    function ExeEditSql(dbTmp:TClientDataSet;szSQL:String):Boolean;
    //ִ���з���ֵ�����ݲ���
    function ExeQuerySql(dbTmp:TClientDataSet;szSQL:String):Boolean;
    //��ý���
    Procedure PSetFocus(Sender:TWinControl) ;
    //���������ַ��Ƿ�Ϸ����Ƿ���0��9��A-Z;a-z
    Function  CheckInStr(InStr:string):Boolean ;
  end;
  
  TBankHH_Imp = class(TImport)
    DEPID:TClientDataSet;
    AREA:TClientDataSet;
  public
    //�������ݼ��
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
    //���û����Ȩ���ɲ���
    if not TPower.GetPower(GN_YHHH_Read) then
    begin
      SysMessage('û�в���Ȩ�ޡ�', AOther_JG, [mbOk]);
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
              Items[0].Text :='��λ:' + GszDwMcOfPrint
          else
              Items[0].Text :='��λ:' + GszHSDWMC ;
          Items[1].Text := '��ӡ��:'+Gczy.name ;
          Items[2].Text := '��ӡ����:';
         end;
    end ;

    //����
    if (Sender=N_Add) or (Sender=SpeedItemAdd) then begin
        PSetStateOfContrl('CLEAR');
        PSetStateOfContrl('NOTREADONLY');
        PSetFocus(EditDM) ;
        iAddOrEdit := 0 ;
    //ɾ��
    end
    else if (Sender=N_Delete) or (Sender=SpeedItemDelete) then begin
        if not DeleteData then Exit ;
        ShowData ;
        iAddOrEdit := 1 ;
        RefreshGridData;
        ShowData;
   //�޸�
    end
    else if (Sender=N_Edit)   or (Sender=SpeedItemEdit)   then begin
        iAddOrEdit := 1 ;
        PSetStateOfContrl('NOTREADONLY') ;
        EditDM.ReadOnly := True ;
    //����
    end
    else if (Sender=N_Save)   or (Sender=SpeedItemSave)   then begin
        szDM := Trim(EditDM.Text) ;
        if not CheckData then Exit ;
        if not SaveData  then Exit ;
        blneedSaved := False;  //����Ҫ����
        PSetStateOfContrl('READONLY');
        iAddOrEdit := 1 ;
        RefreshGridData;
        //TreeNode := DBTreeJCZL.NodeFind(szDM) ;
        //DBTreeJCZL.FullCollapse ;
        //DBTreeJCZL.Items[0].Expanded := True;
        //if TreeNode<>nil then TreeNode.Selected := True ;
        ClientDataSetJCZLGrid.Locate('BANK_CODE',szDM,[]) ;
    //ȡ��
    end
    else if (Sender=N_Cancel) or (Sender=SpeedItemCancel) then begin
        PSetStateOfContrl('READONLY');
        ShowData ;
        blneedSaved := False;  //����Ҫ����
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
        SysMessage('%1����Ϊ�գ����������룡','_YB',[mbOk],'����');
        PSetFocus( EditDM ) ;
        exit;
    end;
    if szMC = '' then begin
        SysMessage('%1����Ϊ�գ����������룡','_YB',[mbOk],'����');
        PSetFocus( EditMC ) ;
        exit;
    end;
    if not CheckInStr(szDM) then
    begin
        SysMessage('����Ϊ�Ƿ��ַ���','_YB',[mbOk],'����');
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

    if iAddOrEdit=0 then begin  //��������
        szSQL := ' Insert into EBK_BANKINFO( DEPID,AREACODE,BANK_CODE,BANK_NAME) values ( '
               + '''' + szJG      + ''', '
               + '''' + szDQ      + ''', '
               + '''' + szDM      + ''', '
               + '''' + szMC      + ''')' ;
    end else begin              //�޸ı���
        szSQL :=  ' Update EBK_BANKINFO set '
               + '  BANK_NAME=''' + szMC   + ''' '
               + ' Where BANK_CODE=''' + szDM + ''' ' ;
    end;

    Result := ExeEditSql(ClientDataSetSave,szSQL) ;
    if not Result then begin
        SysMessage('����ʧ�ܣ����Ժ����ԣ�','_YB',[mbOk]);
    end;
end;

function TFormYHHH.AskIfDel: Boolean;
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

//ɾ������
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
         SysMessage('ɾ��ʧ�ܣ����Ժ����ԣ�','_YB',[mbOK]) ;
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
    //�򿪱�
    if szSQL = '' then  Exit;
    with ClientDataSetJCZLGrid do
    begin
        try
            Close;
            Filter := '';
            POpenSQL(ClientDataSetJCZLGrid, szSQL);
        except
            SysMessage('�����ݿⷢ���������','_JG',[mbOK]);
            Close;
            Exit;
        end;
    end;
end;


procedure TFormYHHH.OpenDBTree(szSQL, szField, szFieldName,szRule : string);
begin
    //����
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
            SysMessage('�����ݿⷢ���������','_JG',[mbOK]);
            Close;
            Exit;
        end;
    end;
    DBTreeJCZL.FullCollapse ;
    DBTreeJCZL.Items[0].Expanded := false;
end;

procedure TFormYHHH.OpenDBJGXXTree(szSQL, szField, szFieldName,szRule : string);
begin
    //����
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
            SysMessage('�����ݿⷢ���������','_JG',[mbOK]);
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
        case SysMessage('���������ѷ����仯���˳�ǰ�Ƿ񱣴棿','_XW',
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
     //��������
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
        case SysMessage('���������ѷ����仯���˳�ǰ�Ƿ񱣴棿','_XW',
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
     //��������
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
    
    szPrintTitle := '�����к�����' ;
    with THFilterJCZL.GridCols do
    begin
        Clear;
        Add;
        Items[Count-1].Caption := '�����к�';
        Items[Count-1].ColName := 'BANK_CODE';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '��������';
        Items[Count-1].ColName := 'BANK_NAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '��������';
        Items[Count-1].ColName := 'DEPID';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '��������';
        Items[Count-1].ColName := 'DEP_NAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '��������';
        Items[Count-1].ColName := 'AREACODE';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '��������';
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
    //���û����Ȩ�༭���ܲ�����
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
        Items[0].Text := '��λ:'   + GszDwMcOfPrint;
        Items[1].Text := '��ӡ��:' + Gczy.name ;
        Items[2].Text := '��ӡ����:';
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

//�����ֶγ���
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
            SysMessage('��ȡ���ݷ����������������' ,'_JG',[mbOK]);
            exit;
        end;
        if Sender is TEdit then
        begin
            TEdit(Sender).MaxLength := FieldByName('length').AsInteger;
            TEdit(Sender).Hint := '��������󳤶�Ϊ'+IntToStr(FieldByName('length').AsInteger);
        end;
        if Sender is TSMaskEdit then
        begin
            TSMaskEdit(Sender).MaxLength := FieldByName('length').AsInteger;
            TSMaskEdit(Sender).Hint := '��������󳤶�Ϊ'+IntToStr(FieldByName('length').AsInteger);
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

//���ÿ���״̬
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
    //�������������10λ
    if EditMC.ReadOnly then Exit ;
    blneedSaved:=True;     //��Ҫ����
    if Sender=EditMC then
    begin
        PStrToPy(EditMC.text,VStrPy);
    end;
end;


procedure TFormYHHH.SetGNFalse;
begin
    N_Add.Enabled           := False ;  //����
    SpeedItemAdd.Enabled    := False ;
    N_Delete.Enabled        := False ;  //ɾ��
    SpeedItemDelete.Enabled := False ;
    N_Edit.Enabled          := False ;  //�޸�
    SpeedItemEdit.Enabled   := False ;
    N_Save.Enabled          := False ;  //����
    SpeedItemSave.Enabled   := False ;
    N_Cancel.Enabled        := False ;  //ȡ��
    SpeedItemCancel.Enabled := False ;
    N_XFSFMX.Enabled        := False ;  //�޸��Ƿ���ϸ����
    N_XFDQJC.Enabled        := False ;  //�޸���ǰ��������
    N_XFZLZJM.Enabled        := False ;   //�޸�����������
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

//ִ���޷���ֵ�����ݲ���
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
//ִ���з���ֵ�����ݲ���
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

//��ý���
Procedure TFormYHHH.PSetFocus(Sender:TWinControl) ;
begin
  try
    if Sender.Enabled then Sender.SetFocus ;
  except
  end;
end;

//���������ַ��Ƿ�Ϸ����Ƿ���0��9��A-Z;a-z
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
  //������Ŀ��
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
  //��ѯ���а༶���԰༶����У����߸���
  cdsData.First;
  ErrLists := TStringList.Create;
  ErrLists.Clear;
  while not cdsData.eof do
  begin
    //��Ŀ���ж�    
    if cdsData.FieldByName('DEPID').AsString = '' then
      ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, ������Ų�����Ϊ�գ����ܵ��롣')
    else
    begin
      szBANKNAME := cdsData.FieldByName('DEPID').AsString;
      if not DEPID.Locate('DEPID', szBANKNAME, [loCaseInsensitive]) then
        ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, �������'+szBANKNAME+'�����ڣ����顣')
    end;
    
    if cdsData.FieldByName('AREACODE').AsString = '' then
      ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��,������Ų�����Ϊ�գ����ܵ��롣')
    else
    begin
      szBANKNAME := cdsData.FieldByName('AREACODE').AsString;
      if not AREA.Locate('AREACODE', szBANKNAME, [loCaseInsensitive]) then
        ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, �������'+szBANKNAME+'�����ڣ����顣')
    end;

    if cdsData.FieldByName('BANK_CODE').AsString = '' then
    begin
      ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, ���кŲ�����Ϊ�գ����ܵ��롣');
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
      ErrLists.Add('��' + IntToStr(cdsData.RecNo + 1) + '��, �������Ʋ�����Ϊ�գ����ܵ��롣');
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
  AddValue('�������', 'C','DEPID', 20);
  AddValue('�������', 'C','AREACODE', 20);
  AddValue('���к�', 'C','BANK_CODE', 20);
  AddValue('��������', 'C','BANK_NAME', 50);
end;

function TBankHH_Imp.Save: Boolean;
begin
 inherited Save;
end;

end.
