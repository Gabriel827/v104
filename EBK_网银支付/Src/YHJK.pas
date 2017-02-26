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
    //�����¼�����
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
    iAddOrEdit:Integer ;  //���������޸�0����1�޸�
    blneedSaved: Boolean ; //�Ƿ���Ҫ����
    szTreeFilter:string;
    szCtrlFilter:string;
    szPrintTitle:String;
    szCznr :string;
    procedure SetGNFalse;//���ù��ܲ�����
    //����
    procedure OpenDBTree(szSQL:string='';szField:string='';szFieldName:string='';szRule:string='');virtual;
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
    //����Ƿ��ѱ�ʹ��
    function isUsed: Boolean;
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
    function GetIntfText(Intf:String):String;
    //���ݲ�������ʹ��״̬
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
    //���û����Ȩ���ɲ���
    if not TPower.GetPower(GN_YHJK_Read) then
    begin
      SysMessage('û�в���Ȩ�ޡ�', AOther_JG, [mbOk]);
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
        RefreshData;
   //�޸�
    end
    else if (Sender=N_Edit)   or (Sender=SpeedItemEdit)   then begin
        iAddOrEdit := 1 ;
        if CheckBoxDJ.Checked then begin
            PSetStateOfContrl('DJREADONLY')
        end else begin
            PSetStateOfContrl('NOTREADONLY') ;
        end ;
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
        RefreshData;
        TreeNode := DBTreeJCZL.NodeFind(szDM) ;
        DBTreeJCZL.FullCollapse ;
        DBTreeJCZL.Items[0].Expanded := True;
        if TreeNode<>nil then TreeNode.Selected := True ;
        ClientDataSetJCZLGrid.Locate('AREACODE',szDM,[]) ;
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

function TFormYHJK.CheckData: Boolean;
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

    if iAddOrEdit=0 then begin  //��������
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
    end else begin              //�޸ı���
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
        SysMessage('����ʧ�ܣ����Ժ����ԣ�','_YB',[mbOk]);
    end;
end;

function TFormYHJK.AskIfDel: Boolean;
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

//ɾ������
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
         SysMessage('ɾ��ʧ�ܣ����Ժ����ԣ�','_YB',[mbOK]) ;
end;

Function  TFormYHJK.DeleteData:Boolean;
var
    szDM:String ;
begin
    Result := False ;
    szDM := Trim(EditDM.Text) ;
    if not AskIfDEL then Exit ;
    if isUsed then begin  //�ж��Ƿ���ʹ����
      SysMessage('�������ӿ���ʹ�ã�����ɾ����','_YB',[mbOk]);
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
        SysMessage('�ü�¼�ѱ����ᣬ�����޸Ľ�����ᣬ��������޸������','_YB',[mbOk]);
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


procedure TFormYHJK.OpenDBTree(szSQL, szField, szFieldName,szRule : string);
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
    
    szPrintTitle := '������������' ;
    with THFilterJCZL.GridCols do
    begin
        Clear;
        Add;
        Items[Count-1].Caption := '�����ӿڴ���';
        Items[Count-1].ColName := 'YH_INTF';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 120;
        Add;
        Items[Count-1].Caption := '����';
        Items[Count-1].ColName := 'JKNAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '��������';
        Items[Count-1].ColName := 'DEP_NAME';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '��ϸ��ַ';
        Items[Count-1].ColName := 'ADDR_MX';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '����ַ';
        Items[Count-1].ColName := 'ADDR_YE';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '֧����ַ';
        Items[Count-1].ColName := 'ADDR_ZF';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '���۵�ַ';
        Items[Count-1].ColName := 'ADDR_DK';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 180;
        Add;
        Items[Count-1].Caption := '���нӿڱ�ʶ';
        Items[Count-1].ColName := 'BANKID';
        Items[Count-1].DataType := ftString;
        Items[Count-1].Width := 90;
        Add;
        Items[Count-1].Caption := 'ʱ����';
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
    //���û����Ȩ�༭���ܲ�����
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
        Items[0].Text := '��λ:'   + GszDwMcOfPrint;
        Items[1].Text := '��ӡ��:' + Gczy.name ;
        Items[2].Text := '��ӡ����:';
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

//�����ֶγ���
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

//���ÿ���״̬
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
    //�������������10λ
    if EditMC.ReadOnly then Exit ;
    blneedSaved:=True;     //��Ҫ����
    if Sender=EditMC then
    begin
        PStrToPy(EditMC.text,VStrPy);
    end;
end;


procedure TFormYHJK.SetGNFalse;
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

//ִ���޷���ֵ�����ݲ���
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
//ִ���з���ֵ�����ݲ���
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

//��ý���
Procedure TFormYHJK.PSetFocus(Sender:TWinControl) ;
begin
  try
    if Sender.Enabled then Sender.SetFocus ;
  except
  end;
end;

//���������ַ��Ƿ�Ϸ����Ƿ���0��9��A-Z;a-z
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

//���ݲ�������ʹ��״̬
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
