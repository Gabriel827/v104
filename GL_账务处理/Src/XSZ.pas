{
     文件名：XSZ.Pas
     程序：
     功能：该文件对应序时账窗口FormXSZ;序时账查询
     用法：

     最后一次修改日期：
     提交日期：
     修改记录：增加按自定义辅项查找功能及显示分录明细功能 lzn 2005.04.05
}
unit XSZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,Graphics, Controls, Forms, Dialogs,
  StdCtrls, THExtCtrls, Hemibtn, THDBGrids, Menus, SpeedBar,
  ExtCtrls, Gradpan, RXCtrls, Buttons, ComCtrls, Spin, Db, DBClient, Grids,
  DBGrids, ImgList, THFilters, Tgrids2, SPrint2, THComCtrls, LggExchanger,
  ExpandPrint, jpeg, Placemnt;

type
  TFormXSZ = class(TForm)
    PopupMenuZB: TPopupMenu;
    NMXZ: TMenuItem;
    NYEB: TMenuItem;
    THFilterXSZ: TTHFilter;
    NPZ: TMenuItem;
    DataSourceXSZ: TDataSource;
    ClientDataSetXSZ: TClientDataSet;
    PopupMenuXSZ: TPopupMenu;
    NConfig: TMenuItem;
    NDoFilter: TMenuItem;
    MainMenuXSZ: TMainMenu;
    MFile: TMenuItem;
    MPreview: TMenuItem;
    MPrint: TMenuItem;
    MDataOut: TMenuItem;
    MBDataOut: TMenuItem;
    MExit: TMenuItem;
    MRun: TMenuItem;
    MZFCX: TMenuItem;
    MBLFCX: TMenuItem;
    MConfig: TMenuItem;
    MFilter: TMenuItem;
    MDoFIlter: TMenuItem;
    MUnDoFilter: TMenuItem;
    MReFresh: TMenuItem;
    MBFilter: TMenuItem;
    MSetup: TMenuItem;
    ImageListBar: TImageList;
    PanelZB: TPanel;
    PanelMain: TPanel;
    PanelTop: TPanel;
    THBevelBottomLine: TTHBevel;
    PanelRight: TPanel;
    PanelBottom: TPanel;
    LabelQZFW: TLabel;
    LabelFrom: TLabel;
    LabelSJ: TLabel;
    LabelTo: TLabel;
    LabelTitle: TLabel;
    THDBGridXSZ: TTHDBGrid;
    NZZ: TMenuItem;
    MMXZ: TMenuItem;
    MYEB: TMenuItem;
    MZZ: TMenuItem;
    MPZ: TMenuItem;
    SPrintXSZ: TSPrint;
    NUnDoFilter: TMenuItem;
    NRefresh: TMenuItem;
    LggExchanger1: TLggExchanger;
    ExpandPrint1: TExpandPrint;
    MShowSJKmmc: TMenuItem;
    MShowSLHJ: TMenuItem;
    CheckBoxAutoWidth: TCheckBox;
    N1: TMenuItem;
    NZKMX: TMenuItem;
    NSSMX: TMenuItem;
    PanelLeft: TPanel;
    SpeedBarXSZ: TSpeedBar;
    SpeedbarSectionFile: TSpeedbarSection;
    SpeedbarSectionEdit: TSpeedbarSection;
    SpeedbarSectionRun: TSpeedbarSection;
    SpeedbarSectionHelp: TSpeedbarSection;
    SpeedbarSectionExit: TSpeedbarSection;
    SpeedItemPreview: TSpeedItem;
    SpeedItemPrint: TSpeedItem;
    SpeedItemConfig: TSpeedItem;
    SpeedItemFilter: TSpeedItem;
    SpeedItemUnFilter: TSpeedItem;
    SpeedItemReFresh: TSpeedItem;
    SpeedItemZB: TSpeedItem;
    SpeedItemHelp: TSpeedItem;
    SpeedItemExit: TSpeedItem;
    MClearFLCond: TMenuItem;
    FormStorageXSZ: TFormStorage;
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SpeedItemExitClick(Sender: TObject);
    procedure SpeedItemFilterClick(Sender: TObject);
    procedure THFilterXSZFilter(Sender: TObject; AFilter: string);
    procedure SpeedItemConfigClick(Sender: TObject);
    procedure MainMenuClick(Sender: TObject);
    procedure PopupMenuClick(Sender: TObject);
    procedure THDBGridXSZHeaderDblClick(ACol: Integer;
      var CanLock: Boolean; AShift: TShiftState);
    procedure SpeedBarXSZDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedBarXSZPosChanged(Sender: TObject);
    procedure PopupMenuZBClick(Sender: TObject);
    procedure SpeedItemPreviewClick(Sender: TObject);
    procedure SpeedItemPrintClick(Sender: TObject);
    procedure SpeedItemUnFilterClick(Sender: TObject);
    procedure SpeedItemReFreshClick(Sender: TObject);
    procedure SpeedItemHelpClick(Sender: TObject);
    procedure THDBGridXSZKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MShowSJKmmcClick(Sender: TObject);
    procedure MShowSLHJClick(Sender: TObject);
    procedure ClientDataSetXSZBeforeOpen(DataSet: TDataSet);
    procedure CheckBoxAutoWidthClick(Sender: TObject);
    procedure THDBGridXSZDblClick(Sender: TObject);
    procedure MClearFLCondClick(Sender: TObject);
  private
    { Private declarations }
    szName, szFzhs: string;
    iCZJLNo: integer;
    SqlTextCXFW, XSZFilter, sXSZZDYSQLCXFW: string;
    cdsYHKMJSFS: TClientDataSet;
    bTempXSZspred: Boolean;
    procedure PSetQx;
    function GenSQL: string;
    //weibc 2016-11-22 20161008160321 去掉数据集中重复记录
    procedure DelRepeatRec(var cds: TClientDataSet; fld: string);
  public
    { Public declarations }
  end;

var
  FormXSZ: TFormXSZ;
procedure LoadXSZ;

implementation

uses  PublicMainGL, Pub_Global, Pub_Function,  Pub_Power, Pub_Message, DataModuleMain,
  SDCXFW, PublicLook, ZBLib, Mxz_All, zz_All, PubClass_GL, uGLInit;

{$R *.DFM}

procedure LoadXSZ;
var
  i: integer;
begin
  //TM201106030001 by zhougf
  if Global_GL.FsModeName='IDA' then
  begin
      if (not Gqx[ord(IDA_XSZ)]) then
      begin
        SysMessage('对不起！已经超出了您的使用权限', 'Pub_05_JG', [mbOk]);
        Exit;
      end;
  end else begin
      if (not Gqx[ord(XSZ_Read)]) then
      begin
        SysMessage('对不起！已经超出了您的使用权限', 'Pub_05_JG', [mbOk]);
        Exit;
      end;
  end;

  with Application.MainForm do
  begin
    // 如果序时账已打开，激活该窗口，否则先创建后显示
    i:=0; //务必赋初值
    if MDIChildCount>0 then
    for i := 0 to MDIChildCount - 1 do
      if uppercase(MDIChildren[i].name) = 'FORMXSZ' then
      begin
        MDIChildren[i].BringToFront;
        break;
      end;
    if i >= MDIChildCount then
    begin
      Application.CreateForm(TFormXSZ, FormXSZ);
      FormXSZ.Show;
    end
    else
    begin
      if MDIChildren[i].WindowState = wsMinimized then
      begin
        MDIChildren[i].WindowState := wsNormal;
        MDIChildren[i].SetFocus;
      end; // else MDIChildren[i].BringToFront;
    end;
    PRegisterWin(FormXSZ.Caption, 'MW_XSZ', True);
  end;
end;

procedure TFormXSZ.FormResize(Sender: TObject);
var
  iWidth, iHeight: integer;
begin
  // 在程序中首先加上如下一段程序及上述四个变量
  {if (SpeedBarXSZ.Align = alTop) or (SpeedBarXSZ.Align = alBottom) then
  begin
      iWidth := 0;
      iHeight := SpeedBarXSZ.BtnWidth + 4;
  end else begin
      iWidth := SpeedBarXSZ.BtnWidth + 4;
      iHeight := 0;
  end;

  if (SpeedBarXSZ.Align = alLeft) then begin
      PanelZB.Left   := 5 + iWidth;
      PanelZB.Top    := 4;
  end else if SpeedBarXSZ.Align = alTop then begin
      PanelZB.Left   := 5;
      PanelZB.Top    := SpeedBarXSZ.BtnWidth + 4 + 4;
  end else if (SpeedBarXSZ.Align = alRight) or (SpeedBarXSZ.Align = alBottom) then begin
      PanelZB.Left   := 5;
      PanelZB.Top    := 4;
  end;

  // 账页的大小
  PanelZB.Width  := Width - 20 - iWidth;
  PanelZB.Height := ClientHeight - 10 - iHeight;
  // 表格外框的上下两条线
  THBevelTop.Width    := PanelRight.Left - THBevelTop.Left + 3;
  THBevelBottom.Width := THBevelTop.Width;
  // 标题位置
  LabelTitle.Left := (PanelTop.Width -LabelTitle.Width + ShapePageEdge.Width) div 2;
  // 标题下画线的位置,长度
  THBevelBottomLine.Left := LabelTitle.Left;
  THBevelBottomLine.Top := LabelTitle.Top + LabelTitle.Height + 3;
  THBevelBottomLine.Width := LabelTitle.Width;
  //页中最下方链环的位置 ImageM4, ImageM3
  ImageM4.Top := PanelLeft.Height - 45;
  ImageM3.Top := PanelLeft.Height - 100;
      // 确定页链环中间两环的位置,根据比例来决定 2/7, 3/7, 2/7
      iHeight := (ImageM4.Top - 2 * ImageM4.Height ) div 7;
      ImageM2.Top := iHeight * 2;
      ImageM3.Top := ImageM4.Top - ImageM3.Height - iHeight * 2;    }
end;

procedure TFormXSZ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormStorageXSZ.SaveFormPlacement;
  PWriteEndCzjl(iCZJLNo);
  PRegisterWin(Caption, 'MW_XSZ', False);
  ClientDataSetXSZ.Close;

  //黄委专版 Added by 刘敏,2005.1.13
  if (Pos('黄委专版', GSpecialVersion) > 0) then
  begin
    cdsYHKMJSFS.Free;
  end;

  Action := caFree;
end;

procedure TFormXSZ.FormCreate(Sender: TObject);
var
  i, iLength: integer;
  bLoop: Boolean;
  SqlText, TempString: string;
  DateFrom, DateTo: TDate;
  TempGridCol: TGridCol;
  dbJFHJ, dbDFHJ: Extended;
  dbJFSL, dbDFSL: Extended;
begin
  FormStorageXSZ.RestoreFormPlacement;
  PSetClientDataSetProvider(self);
  iCZJLNo := PWriteNewCzjl('序时账');

  if (GszVersion = GszAnyi_GALG) or (GszVersion = GszAnyi_GAL) then
  begin // lzn
    MShowSLHJ.Visible := False;
    MShowSLHJ.Checked := False;
    with THFilterXSZ do
    begin
      GridCols.Items[ColByName('WBDM')].Destroy; //GridCols[THFilterXSZ.ColByName('WBDM')].Destroy;
      GridCols.Items[ColByName('HL')].Destroy;
      GridCols.Items[ColByName('SL')].Destroy;
      GridCols.Items[ColByName('WBJE')].Destroy;
    end;
  end;

  PSetQx;
  FormResize(nil);

  //R93 Add 对于没有设定会计期间的业务日期登录账薄会出现异常，增加提示
  if not PCheckYWRQ then
  begin
    Close;
    Exit;
  end;

  if GLJXZB then
    MDataOut.Visible := False;
  if GblPRTAnyiMark = True then
    SprintXSZ.Option := SprintXSZ.Option + [AnyiMark]
  else
    SprintXSZ.Option := SprintXSZ.Option - [AnyiMark];

  if GZtType = ztTotal then
  begin
    TempGridCol := THFilterXSZ.GridCols.Add;
    TempGridCol.Caption := PGetPrgString('GSDM', '单位代码');
    TempGridCol.ColName := 'GSDM';
    TempGridCol.Width := 60;

    TempGridCol := THFilterXSZ.GridCols.Add;
    TempGridCol.Caption := PGetPrgString('GSMC', '单位名称');
    TempGridCol.ColName := 'GSMC';
    TempGridCol.Width := 80;
  end;

  //总预算版
  try
      for i := 4 to gztcs_gl.GDFX.count - 1 do
      begin
        THFilterXSZ.GridCols[THFilterXSZ.ColByName('FZDM' + Inttostr(i))].Caption := gztcs_gl.GDFX[i].sFXname;
        THFilterXSZ.GridCols[THFilterXSZ.ColByName('FZDM' + Inttostr(i) + 'MC')].Caption := gztcs_gl.GDFX[i].sFXName+'名称';
      end;
  except
  end;

  if (GLVersion < 11.86) and (GLVersion > 11.84) then
  begin
    bLoop := True;
    i := 0;
    with THFilterXSZ do
    begin
      while bLoop do
      begin
        //if (GridCols[i].ColName='BMDM') or
        //   (GridCols[i].ColName='BMMC') or
        //   (GridCols[i].ColName='XMDM') or
        //   (GridCols[i].ColName='XMMC') or
        //   (GridCols[i].ColName='GRWLDM') or
        //   (GridCols[i].ColName='GRWLMC') or // 放开限制 总预算也有这些核算 Lzn 20060508
        if (GridCols[i].ColName = 'FZSM1') or
          (GridCols[i].ColName = 'FZSM2') or
          (GridCols[i].ColName = 'FZSM3') or
          (GridCols[i].ColName = 'FZSM4') or
          (GridCols[i].ColName = 'FZSM5') or
          (GridCols[i].ColName = 'FZSM6') or
          (GridCols[i].ColName = 'FZSM7') or
          (GridCols[i].ColName = 'FZSM8') or
          (GridCols[i].ColName = 'FZSM9') or
          (GridCols[i].ColName = 'WBDM') or
          (GridCols[i].ColName = 'HL') or
          (GridCols[i].ColName = 'DJ') or
          (GridCols[i].ColName = 'SL') or
          (GridCols[i].ColName = 'WBJE') then
        begin
          GridCols[i].Free;
          i := 0;
        end;
        i := i + 1;
        if i = GridCols.Count - 1 then
          bLoop := False;
      end;
    end;

  end
  else
  begin
    if GszVersion = 'GLS' then
    begin
      bLoop := True;
      i := 0;
      with THFilterXSZ do
      begin
        while bLoop do
        begin
          if (GridCols[i].ColName = 'GRWLDM') or
            (GridCols[i].ColName = 'GRWLMC') or
            (GridCols[i].ColName = 'FZSM1') or
            (GridCols[i].ColName = 'FZSM2') or
            (GridCols[i].ColName = 'FZSM3') or
            (GridCols[i].ColName = 'FZSM4') or
            (GridCols[i].ColName = 'FZSM5') or
            (GridCols[i].ColName = 'FZSM6') or
            (GridCols[i].ColName = 'FZSM7') or
            (GridCols[i].ColName = 'FZSM8') or
            (GridCols[i].ColName = 'FZSM9') then
          begin
            GridCols[i].Free;
            i := 0;
          end;

          i := i + 1;
          if i = GridCols.Count - 1 then
            bLoop := False;
        end;
      end;
    end;

    for i := 0 to THFilterXSZ.GridCols.Count - 1 do
    begin
      if THFilterXSZ.GridCols[i].ColName = 'HL' then
      begin
        THFilterXSZ.GridCols[i].DataDec := GiHLXS;
        Continue;
      end;

      if THFilterXSZ.GridCols[i].ColName = 'DJ' then
      begin
        THFilterXSZ.GridCols[i].DataDec := GiDJXS;
        Continue;
      end;
      if THFilterXSZ.GridCols[i].ColName = 'SL' then
      begin
        THFilterXSZ.GridCols[i].DataDec := GiSLXS;
        Continue;
      end;
      if THFilterXSZ.GridCols[i].ColName = 'WBJE' then
      begin
        THFilterXSZ.GridCols[i].DataDec := GiWBXS;
        Continue;
      end;
      if THFilterXSZ.GridCols[i].ColName = 'JE' then
      begin
        THFilterXSZ.GridCols[i].DataDec := GiBWBXS;
        Continue;
      end;
      if THFilterXSZ.GridCols[i].ColName = 'MXJE' then
      begin
        THFilterXSZ.GridCols[i].DataDec := GiBWBXS;
        Continue;
      end;
    end;
  end;

  //黄委专版 Added by 刘敏,2005.1.13
  if (Pos('黄委专版', GSpecialVersion) > 0) then
  begin
  end
  else
  begin
    bLoop := True;
    i := 0;
    with THFilterXSZ do
    begin
      while bLoop do
      begin
        if (GridCols[i].ColName = 'JSFS') then
        begin
          GridCols[i].Free;
          i := 0;
        end;
        i := i + 1;
        if i = GridCols.Count - 1 then
          bLoop := False;
      end;
    end;
  end;

  THFilterXSZ.THDBGridPad := THDBGridXSZ;
  THFilterXSZ.InitColumns;
  DateFrom := StrToDate(Copy(GszYWRQ, 1, 4) + '-' + Copy(GszYWRQ, 5, 2) + '-' + Copy(GszYWRQ, 7, 2));
  DateTo := DateFrom;

  XSZFilter := '';
  // Modified by haojj 2014-10-21 维护单号：ZWR900210088 选项控制是否清空分录条件
  //SqlTextCXFW := GetXSZFW(DateFrom, DateTo, sXSZZDYSQLCXFW);
  SqlTextCXFW := GetXSZFW(DateFrom, DateTo, sXSZZDYSQLCXFW, MClearFLCond.Checked);
  if SqlTextCXFW = '' then
  begin
    Close;
    Exit;
  end;

  //黄委专版 Added by 刘敏,2005.1.13
  if (Pos('黄委专版', GSpecialVersion) > 0) then
  begin
    cdsYHKMJSFS := TClientDataSet.Create(self);
    with DataModulePub do
    begin
      ClientDataSetPub.Close;
      //POpenSql(ClientDataSetPub, 'select * from gl_jsgx where ZTH=''' + GszZth + ''' and gsdm=''' + GszGSDM
      //  + ''' and kjnd=''' + GszKJND + ''' and jsdhFrom=1 order by yhzh,jsdhdm');
      //基础资料整合 by zhougf 2011.4.29
      POpenSql(ClientDataSetPub, 'select * from ZB_JSFS where gsdm=''' + GszGSDM
        + ''' and kjnd=''' + GszKJND + ''' order by jsfsdm');
      cdsYHKMJSFS.data := ClientDataSetPub.Data;
    end;
  end;

  TempString := FormatSysDate(DateFrom);
  LabelFrom.Caption := Copy(TempString, 1, 4) + '-' + Copy(TempString, 5, 2) + '-' + Copy(TempString, 7, 2);
  TempString := FormatSysDate(DateTo);
  ;
  LabelTo.Caption := Copy(TempString, 1, 4) + '-' + Copy(TempString, 5, 2) + '-' + Copy(TempString, 7, 2);
  ClientDataSetXSZ.Filter := '';

  Sqltext := GenSQL; //获取SQL

  ClientDataSetXSZ.Close;
  POpenSql(ClientDataSetXSZ, SqlText);
  DelRepeatRec(ClientDataSetXSZ, 'Temp1');

  dbJFHJ := 0;
  dbDFHJ := 0;
  dbJFSL := 0;
  dbDFSL := 0;

  if ClientDataSetXSZ.FindFirst then
  begin
    with ClientDataSetXSZ do
    begin
      repeat
        //R93新增，带出上级科目名称
        if MShowSJKmmc.Checked then
        begin
          szName := PGetPassName(FieldByName('kmdm').AsString, 'K', True, szFzhs);
          Edit;
          FieldByName('kmmc').AsString := szName;
        end;

        if FieldByName('JDBZ').AsString = '借' then
          dbJFHJ := dbJFHJ + FieldByName('JE').AsFLoat
        else
          dbDFHJ := dbDFHJ + FieldByName('JE').AsFloat;

        //R93新增，增加数量合计行
        if MShowSLHJ.Checked then
        begin
          if FieldByName('JDBZ').AsString = '借' then
            dbJFSL := dbJFSL + FieldByName('SL').AsFLoat
          else
            dbDFSL := dbDFSL + FieldByName('SL').AsFloat;
        end;

        //黄委专版 Added by 刘敏,2005.1.14
        if (Pos('黄委专版', GSpecialVersion) > 0) then
        begin
          if FieldByName('KMLB').AsString = '0' then
          begin
            //cdsYHKMJSFS.Filter := 'yhzh=''' + FieldByName('KMDM').AsString + '''';
            //cdsYHKMJSFS.Filtered := True;
            if cdsYHKMJSFS.FindFirst then //该科目有银行结算方式
              while not cdsYHKMJSFS.Eof do
              begin
                iLength := length(cdsYHKMJSFS.FieldByName('jsfsdm').AsString);
                if Copy(FieldByName('SPZ').AsString, 1, iLength) = cdsYHKMJSFS.FieldByName('jsfsdm').AsString then
                begin
                  Edit;
                  FieldByName('JSFS').AsString := cdsYHKMJSFS.FieldByName('jsfsmc').AsString;
                  FieldByName('SPZ').AsString := Copy(FieldByName('SPZ').AsString, iLength + 1, Length(FieldByName('SPZ').AsString) - iLength);
                  Break;
                end;
                if not cdsYHKMJSFS.FindNext then
                  break;
              end;
            Edit;
            FieldByName('SPZ').AsString := Trim(FieldByName('SPZ').AsString);
          end;
        end;
      until not FindNext;

      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('J', '借');
      //  FieldByName('ZY').AsString:=PGetPrgString('YHDZ_JFHJ','借方合计');
      FieldByName('JE').AsFloat := dbJFHJ;
      FieldByName('SL').AsFloat := dbJFSL;

      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('D', '贷');
      // FieldByName('ZY').AsString:=PGetPrgString('YHDZ_DFHJ','贷方合计');
      FieldByName('JE').AsFloat := dbDFHJ;
      FieldByName('SL').AsFloat := dbDFSL;
      FindFirst;
    end;
  end;

  if CheckBoxAutoWidth.Checked then
    THDBGridXSZ.AutoGridColWidth(-1);
end;

procedure TFormXSZ.PsetQx;
begin
  SpeedItemPreview.Visible := False;
  SpeeditemPrint.Visible := False;
  MPreview.Visible := False;
  MPrint.Visible := False;
  MDataOut.Visible := False;
  MBDataOut.Visible := False;

  SpeedItemZB.Visible := False;
  MZFCX.Visible := False;
  MMXZ.Visible := False;
  MZZ.Visible := False;
  MPZ.Visible := False;
  NMXZ.Visible := False;
  NZZ.Visible := False;
  NPZ.Visible := False;

  if GQX[ord(PZ_Read)] then
  begin
    SpeedItemZB.Visible := True;
    MZFCX.Visible := True;
    MPZ.Visible := True;
    NPZ.Visible := True;
  end;

  if GQX[ord(KMMXZ_Read)] then
  begin
    SpeedItemZB.Visible := True;
    MZFCX.Visible := True;
    MMXZ.Visible := True;
    NMXZ.Visible := True;
  end;

  if GQX[ord(KMZZ_Read)] then
  begin
    SpeedItemZB.Visible := True;
    MZFCX.Visible := True;
    MZZ.Visible := True;
    NZZ.Visible := True;
  end;

  if GQx[ord(XSZ_DataOut)] then
  begin
    SpeedItemPreview.Visible := True;
    SpeeditemPrint.Visible := True;
    MPreview.Visible := True;
    MPrint.Visible := True;
    MDataOut.Visible := True;
    MBDataOut.Visible := True;
  end;
end;

procedure TFormXSZ.SpeedItemExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFormXSZ.SpeedItemFilterClick(Sender: TObject);
begin
  THFilterXSZ.ExecFilter;
end;

procedure TFormXSZ.THFilterXSZFilter(Sender: TObject; AFilter: string);
var
  dbJFHJ, dbDFHJ: Extended;
  dbJFSL, dbDFSL: Extended;
  szZY, szKJQJ, szPZLY, szPZH: string;
  iFLH: integer;
begin
  szZY := ClientDataSetXSZ.FieldByName('ZY').AsString;
  szKJQJ := ClientDataSetXSZ.FieldByName('KJQJ').AsString;
  szPZLY := ClientDataSetXSZ.FieldByName('PZLY').AsString;
  szPZH := ClientDataSetXSZ.FieldByName('PZH').AsString;
  iFLH := ClientDataSetXSZ.FieldByName('FLH').AsInteger;

  XSZFilter := AFilter;

  if XSZFilter = '' then
    ClientDataSetXSZ.Filter := ''
  else
    ClientDataSetXSZ.Filter := '(' + XSZFilter + ') or (KJQJ=''' + PGetPrgString('HJ', '合计') + ''')';

  if ClientDataSetXSZ.Locate('KJQJ', PGetPrgString('HJ', '合计'), []) then
    ClientDataSetXSZ.Delete;
  if ClientDataSetXSZ.Locate('KJQJ', PGetPrgString('HJ', '合计'), []) then
    ClientDataSetXSZ.Delete;

  dbJFHJ := 0;
  dbDFHJ := 0;
  dbJFSL := 0;
  dbDFSL := 0;

  if ClientDataSetXSZ.FindFirst then
  begin
    with ClientDataSetXSZ do
    begin
      repeat
        //R93新增，带出上级科目名称
        if MShowSJKmmc.Checked then
        begin
          szName := PGetPassName(FieldByName('kmdm').AsString, 'K', True, szFzhs);
          Edit;
          FieldByName('kmmc').AsString := szName;
        end;

        if FieldByName('JDBZ').AsString = '借' then
          dbJFHJ := dbJFHJ + FieldByName('JE').AsFLoat
        else
          dbDFHJ := dbDFHJ + FieldByName('JE').AsFloat;

        //R93新增，增加数量合计行
        if MShowSLHJ.Checked then
        begin
          if FieldByName('JDBZ').AsString = '借' then
            dbJFSL := dbJFSL + FieldByName('SL').AsFLoat
          else
            dbDFSL := dbDFSL + FieldByName('SL').AsFloat;
        end;
      until not FindNext;

      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('J', '借');
      //  FieldByName('ZY').AsString:=PGetPrgString('YHDZ_JFHJ','借方合计');
      FieldByName('JE').AsFloat := dbJFHJ;
      FieldByName('SL').AsFloat := dbJFSL;

      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('D', '贷');
      // FieldByName('ZY').AsString:=PGetPrgString('YHDZ_DFHJ','贷方合计');
      FieldByName('JE').AsFloat := dbDFHJ;
      FieldByName('SL').AsFloat := dbDFSL;
      FindFirst;
      {
      if (szZY=PGetPrgString('YHDZ_JFHJ','借方合计')) or (szZY=PGetPrgString('YHDZ_DFHJ','贷方合计')) then begin
          if not Locate('ZY',szZY,[]) then FindFirst;
      end else begin
          if not Locate('KJQJ;PZLY;PZH;FLH',VarArrayOf([szKJQJ,szPZLY,szPZH,iFLH]),[]) then
              FindFirst;
      end; }
    end;
  end;
end;

procedure TFormXSZ.SpeedItemConfigClick(Sender: TObject);
var
  SqlText, TempString: string;
  dbJFHJ, dbDFHJ: Extended;
  dbJFSL, dbDFSL: Extended;
  DateFrom, DateTo: TDate;
  szZY, szKJQJ, szPZLY, szPZH: string;
  iFLH, iLength: integer;
begin
  szZY := ClientDataSetXSZ.FieldByName('ZY').AsString;
  szKJQJ := ClientDataSetXSZ.FieldByName('KJQJ').AsString;
  szPZLY := ClientDataSetXSZ.FieldByName('PZLY').AsString;
  szPZH := ClientDataSetXSZ.FieldByName('PZH').AsString;
  iFLH := ClientDataSetXSZ.FieldByName('FLH').AsInteger;

  DateFrom := StrToDate(LabelFrom.Caption);
  DateTo := StrToDate(LabelTo.Caption);
  // Modified by haojj 2014-10-21 维护单号：ZWR900210088 选项控制是否清空分录条件
  //SqlText := GetXSZFW(DateFrom, DateTo, sXSZZDYSQLCXFW);
  SqlText := GetXSZFW(DateFrom, DateTo, sXSZZDYSQLCXFW, MClearFLCond.Checked);
  if SqlText = '' then
    Exit
  else
    SqlTextCXFW := SqlText;
  TempString := ForMatSysDate(DateFrom);
  LabelFrom.Caption := Copy(TempString, 1, 4) + '-' + Copy(TempString, 5, 2) + '-' + Copy(TempString, 7, 2);
  TempString := FormatSysDate(DateTo);
  ;
  LabelTo.Caption := Copy(TempString, 1, 4) + '-' + Copy(TempString, 5, 2) + '-' + Copy(TempString, 7, 2);

  Sqltext := GenSQL; //获取SQL

  ClientDataSetXSZ.Close;
  POpenSql(ClientDataSetXSZ, SqlText);
  DelRepeatRec(ClientDataSetXSZ, 'Temp1');

  dbJFHJ := 0;
  dbDFHJ := 0;
  dbJFSL := 0;
  dbDFSL := 0;

  if ClientDataSetXSZ.FindFirst then
  begin
    with ClientDataSetXSZ do
    begin
      repeat
        //R93新增，带出上级科目名称
        if MShowSJKmmc.Checked then
        begin
          szName := PGetPassName(FieldByName('kmdm').AsString, 'K', True, szFzhs);
          Edit;
          FieldByName('kmmc').AsString := szName;
        end;

        if FieldByName('JDBZ').AsString = '借' then
          dbJFHJ := dbJFHJ + FieldByName('JE').AsFLoat
        else
          dbDFHJ := dbDFHJ + FieldByName('JE').AsFloat;

        //R93新增，增加数量合计行
        if MShowSLHJ.Checked then
        begin
          if FieldByName('JDBZ').AsString = '借' then
            dbJFSL := dbJFSL + FieldByName('SL').AsFLoat
          else
            dbDFSL := dbDFSL + FieldByName('SL').AsFloat;
        end;
        //黄委专版 Added by 刘敏,2005.1.14
        if (Pos('黄委专版', GSpecialVersion) > 0) then
        begin
          if FieldByName('KMLB').AsString = '0' then
          begin
            //cdsYHKMJSFS.Filter := 'yhzh=''' + FieldByName('KMDM').AsString + '''';
            //cdsYHKMJSFS.Filtered := True;
            if cdsYHKMJSFS.FindFirst then //该科目有银行结算方式
              while not cdsYHKMJSFS.Eof do
              begin
                iLength := length(cdsYHKMJSFS.FieldByName('jsfsdm').AsString);
                if Copy(FieldByName('SPZ').AsString, 1, iLength) = cdsYHKMJSFS.FieldByName('jsfsdm').AsString then
                begin
                  Edit;
                  FieldByName('JSFS').AsString := cdsYHKMJSFS.FieldByName('jsfsmc').AsString;
                  FieldByName('SPZ').AsString := Copy(FieldByName('SPZ').AsString, iLength + 1, Length(FieldByName('SPZ').AsString) - iLength);
                  Break;
                end;
                if not cdsYHKMJSFS.FindNext then
                  break;
              end;
            Edit;
            FieldByName('SPZ').AsString := Trim(FieldByName('SPZ').AsString);
          end;
        end;
      until not FindNext;

      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('J', '借');
      //  FieldByName('ZY').AsString:=PGetPrgString('YHDZ_JFHJ','借方合计');
      FieldByName('JE').AsFloat := dbJFHJ;
      FieldByName('SL').AsFloat := dbJFSL;

      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('D', '贷');
      // FieldByName('ZY').AsString:=PGetPrgString('YHDZ_DFHJ','贷方合计');
      FieldByName('JE').AsFloat := dbDFHJ;
      FieldByName('SL').AsFloat := dbDFSL;

      FindFirst;
      {
      if (szZY=PGetPrgString('YHDZ_JFHJ','借方合计')) or (szZY=PGetPrgString('YHDZ_DFHJ','贷方合计')) then begin
          if not Locate('ZY',szZY,[]) then
              FindFirst;
      end else begin
          if not Locate('KJQJ;PZLY;PZH;FLH',VarArrayOf([szKJQJ,szPZLY,szPZH,iFLH]),[]) then
              FindFirst;
      end;  }
    end;
  end;
  if CheckBoxAutoWidth.Checked then
    THDBGridXSZ.AutoGridColWidth(-1); // lzn
end;

procedure TFormXSZ.MainMenuClick(Sender: TObject);
begin
  if Sender = MExit then
    SpeedItemExitClick(nil)
  else if Sender = MPreview then
  begin
    if SprintXSZ.PrintSetUp then
      SpeedItemPreviewClick(nil);
  end
  else if Sender = MPrint then
  begin
    if SPrintXSZ.PrintSetup then
      SpeedItemPrintClick(nil);
  end
  else if Sender = MDataOut then
    ExpandPrint1.Execute
  else if Sender = MMXZ then
    PopupMenuZBClick(NMXZ)
  else if Sender = MYEB then
    PopupMenuZBClick(NYEB)
  else if Sender = MZZ then
    PopupMenuZBClick(NZZ)
  else if Sender = MPZ then
    PopupMenuZBClick(NPZ)
  else if Sender = MConfig then
    SpeedItemConfigClick(nil)
  else if Sender = MDoFilter then
    SpeedItemFilterClick(nil)
  else if Sender = MUnDoFilter then
    SpeedItemUnFilterClick(nil)
  else if Sender = MReFresh then
    SpeedItemReFreshClick(nil);
end;

procedure TFormXSZ.PopupMenuClick(Sender: TObject);
begin
  if (sender = NZKMX) and (not NZKMX.Checked) then
  begin
    bXSZspred := True;
    NZKMX.Checked := True;
    NSSMX.Checked := False;
    SpeedItemReFreshClick(nil);
  end
  else if (sender = NSSMX) and (not NSSMX.Checked) then
  begin
    bXSZspred := False;
    NSSMX.Checked := True;
    NZKMX.Checked := False;
    SpeedItemReFreshClick(nil);
  end
  else if Sender = NConfig then
    SpeedItemConfigClick(nil)
  else if Sender = NDoFilter then
    SpeedItemFilterClick(nil)
  else if Sender = NUnDoFilter then
    SpeedItemUnFilterClick(nil)
  else if Sender = NRefresh then
    SpeedItemReFreshClick(nil);
end;

procedure TFormXSZ.THDBGridXSZHeaderDblClick(ACol: Integer;
  var CanLock: Boolean; AShift: TShiftState);
begin
  CanLock := True;
end;

procedure TFormXSZ.SpeedBarXSZDblClick(Sender: TObject);
begin
  PAllowButtonCaption(SpeedBarXSZ);
  FormResize(nil);
end;

procedure TFormXSZ.FormShow(Sender: TObject);
begin
  // Form显示时,调入Button区的墙纸
  SetComponentsColor(Self);
  CheckBoxAutoWidthClick(nil);  
end;

procedure TFormXSZ.SpeedBarXSZPosChanged(Sender: TObject);
begin
  FormResize(nil);
end;

procedure TFormXSZ.PopupMenuZBClick(Sender: TObject);
var
  KMDM, GSDM, KJQJ, PZLY, PZH, ZY, szSql: string;
  FLH: integer;
  zbfm: TZbfmfa;
begin
  if ClientDataSetXSZ.RecordCount < 1 then
    Exit;
  ZY := ClientDataSetXSZ.FieldByName('ZY').AsString;
  //if (Trim(ZY)=PGetPrgString('YHDZ_JFHJ','借方合计')) or (Trim(ZY)=PGetPrgString('YHDZ_DFHJ','贷方合计')) then Exit;

  KMDM := Trim(ClientDataSetXSZ.FieldByName('KMDM').AsString);
  KJQJ := ClientDataSetXSZ.FieldByName('KJQJ').AsString;
  if (Trim(KJQJ) = PGetPrgString('HJ', '合计')) then
    Exit;

  PZLY := ClientDataSetXSZ.FieldByName('PZLY').AsString;
  if GDbType = ORACLE then
  begin
    if trim(PZLY) = '' then
      PZLY := '_';
  end;
  PZH := ClientDataSetXSZ.FieldByName('PZH').AsString;
  FLH := ClientDataSetXSZ.FieldByName('FLH').AsInteger;

  if Sender = NMXZ then
  begin
    //        PLookMXZ(KMDM,'','0','','',KJQJ,KJQJ,KJQJ,PZLY,PZH,FLH,False);
    zbfm := TZbfmfa.Create(ztMxz, '');
    zbfm.Kjnd := Copy(Kjqj, 1, 4);
    zbfm.KjndTo := Copy(Kjqj, 1, 4);
    zbfm.KjqjFrom := Copy(kjqj, 5, 2);
    zbfm.KjqjTo := Copy(kjqj, 5, 2);
    zbfm.Kmdm := kmdm;
    szSql := 'select kmdm dm from gl_kmxx'
      + ' where kmdm like ''' + kmdm + '%'' '
      + '   and ZTH=''' + GszZth + ''' and gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''''
      + '   and ' + PSJQX('K', 'KMDM');
    with DataModulePub.ClientDataSetPub do
    begin
      close;
      POpenSql(DataModulePub.ClientDataSetPub, szSql);
      if findfirst then
        repeat
          zbfm.slKmdm.add(FieldByName('dm').asstring);
        until not findNext;
    end;
    zbfm.ReBuildHash;
    //        with LcZBCS do
    //        begin
    //            ZBLX := 'MXZ';
    //            ZKLX := 'K';
    //            blLC := True;
    //            strZBGS := '0';
    //            blInclusion := False;
    //            szKjqjFrom := KJQJ;
    //            szKjqjTo := KJQJ;
    //            LCDM[1] := kmdm;
    //            LCSql[1] :='select kmdm dm from gl_kmxx'
    //                      +' where kmdm like '''+Lcdm[1]+'%'' '
    //                      +'   and gsdm='''+GszGSDM+''''
    //                      +'   and '+PSJQX('K','KMDM');
    //            LCDM[2] := '';
    //            LCSql[2] := '';
    //            LCDM[3] := '';
    //            LCSql[3] := '';
    //        end;
    //        LoadZB(LcZBCS);
    loadMxz(zbfm);
  end
  else if Sender = NYEB then
  begin

  end
  else if Sender = NZZ then
  begin
    //        PLookZZ(KMDM,'','0','','',KJQJ,False);
    zbfm := TZbfmfa.Create(ztZz, '');
    zbfm.Kjnd := Copy(Kjqj, 1, 4);
    zbfm.KjndTo := Copy(Kjqj, 1, 4);
    zbfm.KjqjFrom := Copy(kjqj, 5, 2);
    zbfm.KjqjTo := Copy(kjqj, 5, 2);
    zbfm.Kmdm := kmdm;
    szSql := 'select kmdm dm from gl_kmxx'
      + ' where kmdm like ''' + kmdm + '%'' '
      + '   and ZTH=''' + GszZth + ''' and gsdm=''' + GszGSDM + ''' and kjnd=''' + GszKJND + ''''
      + '   and ' + PSJQX('K', 'KMDM');
    with DataModulePub.ClientDataSetPub do
    begin
      close;
      POpenSql(DataModulePub.ClientDataSetPub, szSql);
      if findfirst then
        repeat
          zbfm.slKmdm.add(FieldByName('dm').asstring);
        until not findNext;
    end;
    zbfm.ReBuildHash;
    LoadZZ(zbfm);
    //        with LcZBCS do
    //        begin
    //            ZBLX := 'ZZ';
    //            ZKLX := 'K';
    //            blLC := True;
    //            strZBGS := '0';
    //            blInclusion := False;
    //            szKjqjFrom := KJQJ;
    //            szKjqjTo := KJQJ;
    //            LCDM[1] := kmdm;
    //            LCSql[1] :='select kmdm dm from gl_kmxx'
    //                      +' where kmdm like '''+Lcdm[1]+'%'' '
    //                      +'   and gsdm='''+GszGSDM+''''
    //                      +'   and '+PSJQX('K','KMDM');
    //            LCDM[2] := '';
    //            LCSql[2] := '';
    //            LCDM[3] := '';
    //            LCSql[3] := '';
    //        end;
    //        LoadZB(LcZBCS);
  end
  else if Sender = NPZ then
  begin
    if GZTType = ztTotal then
    begin
      GSDM := Trim(ClientDataSetXSZ.FieldByName('GSDM').AsString);
      //Oracle用
      if GDbType = ORACLE then
      begin
        if GSDM = '' then
          GSDM := '_';
      end;
      if GszGSDM = GSDM then
        PLookPZ(PZLY, KJQJ, PZH, FLH)
      else if PSetGSDM(GSDM) then
        PLookPZ(PZLY, KJQJ, PZH, FLH);
    end
    else
      PLookPZ(PZLY, KJQJ, PZH, FLH);
  end;
end;

procedure TFormXSZ.SpeedItemPreviewClick(Sender: TObject);
var
  szTemp: string;
  iPos: integer;
begin
  //---------------------begin added by wangzh 20080807
  if ClientDataSetXSZ.RecordCount = 0 then
  begin
    Application.MessageBox('没有数据，不能预览', PChar(Application.Title), MB_OK +
      MB_ICONINFORMATION);
    Exit;
  end;
  //----------------------end;

  SprintXSZ.OtherItems[3].Text := GCzy.Name;
  //2008.3.25 hy 单位名称后面加上账套名称和账套号
  //2008.4.18 hy 修改为根据系统参数来确定打印名称
  SprintXSZ.OtherItems[2].Text := GetDWPrintCapiton;
  //SprintXSZ.OtherItems[4].Text := GszHSDWMC + ' ' + GszZTMC; // + '(' + GszZTH + ')';

  if (GszLanguage = '中文') or (not GblOtherDblLgg) then
  begin
    SprintXSZ.OtherItems[5].Text := LabelQZFW.Caption + ': ' + LabelFrom.Caption + ' ' + LabelSJ.Caption + ' ' + LabelTo.Caption;
  end
  else
  begin
    szTemp := LabelQZFW.Caption;
    iPos := Pos(':', szTemp);
    if iPos = Length(szTemp) then
      Delete(szTemp, iPos, 1);

    SprintXSZ.OtherItems[5].Text := '起止范围' + '(' + szTemp + '): ' + LabelFrom.Caption + ' ' + LabelSJ.Caption + ' ' + LabelTo.Caption;
  end;

  SPrintXSZ.PrePare;
  SPrintXSZ.Preview;
end;

procedure TFormXSZ.SpeedItemPrintClick(Sender: TObject);
var
  szTemp: string;
  iPos: integer;
begin
  SprintXSZ.OtherItems[3].Text := GCzy.Name;
  //2008.4.1 hy 增加账套名称
  //2008.4.18 hy 修改为根据系统参数来确定打印名称
  SprintXSZ.OtherItems[2].Text := GetDWPrintCapiton;  
  //SprintXSZ.OtherItems[4].Text := GszHSDWMC + ' ' + GszZTMC;

  if (GszLanguage = '中文') or (not GblOtherDblLgg) then
  begin
    SprintXSZ.OtherItems[5].Text := LabelQZFW.Caption + ' ' + LabelFrom.Caption + ' ' + LabelSJ.Caption + ' ' + LabelTo.Caption;
  end
  else
  begin
    szTemp := LabelQZFW.Caption;
    iPos := Pos(':', szTemp);
    if iPos = Length(szTemp) then
      Delete(szTemp, iPos, 1);

    SprintXSZ.OtherItems[5].Text := '起止范围' + '(' + szTemp + '): ' + LabelFrom.Caption + ' ' + LabelSJ.Caption + ' ' + LabelTo.Caption;
  end;

  SPrintXSZ.PrePare;
  SPrintXSZ.Print;
end;

procedure TFormXSZ.SpeedItemUnFilterClick(Sender: TObject);
var
  dbJFHJ, dbDFHJ: Extended;
  dbJFSL, dbDFSL: Extended;
  szZY, szKJQJ, szPZLY, szPZH: string;
  iFLH: integer;
begin
  szZY := ClientDataSetXSZ.FieldByName('ZY').AsString;
  szKJQJ := ClientDataSetXSZ.FieldByName('KJQJ').AsString;
  szPZLY := ClientDataSetXSZ.FieldByName('PZLY').AsString;
  szPZH := ClientDataSetXSZ.FieldByName('PZH').AsString;
  iFLH := ClientDataSetXSZ.FieldByName('FLH').AsInteger;

  XSZFilter := '';
  ClientDataSetXSZ.Filter := '';
  if ClientDataSetXSZ.Locate('KJQJ', PGetPrgString('HJ', '合计'), []) then
    ClientDataSetXSZ.Delete;
  if ClientDataSetXSZ.Locate('KJQJ', PGetPrgString('HJ', '合计'), []) then
    ClientDataSetXSZ.Delete;

  dbJFHJ := 0;
  dbDFHJ := 0;
  dbJFSL := 0;
  dbDFSL := 0;

  if ClientDataSetXSZ.FindFirst then
  begin
    with ClientDataSetXSZ do
    begin
      repeat
        //R93新增，带出上级科目名称
        if MShowSJKmmc.Checked then
        begin
          szName := PGetPassName(FieldByName('kmdm').AsString, 'K', True, szFzhs);
          Edit;
          FieldByName('kmmc').AsString := szName;
        end;

        if FieldByName('JDBZ').AsString = '借' then
          dbJFHJ := dbJFHJ + FieldByName('JE').AsFLoat
        else
          dbDFHJ := dbDFHJ + FieldByName('JE').AsFloat;

        //R93新增，增加数量合计行
        if MShowSLHJ.Checked then
        begin
          if FieldByName('JDBZ').AsString = '借' then
            dbJFSL := dbJFSL + FieldByName('SL').AsFLoat
          else
            dbDFSL := dbDFSL + FieldByName('SL').AsFloat;
        end;

      until not FindNext;

      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('J', '借');
      //  FieldByName('ZY').AsString:=PGetPrgString('YHDZ_JFHJ','借方合计');
      FieldByName('JE').AsFloat := dbJFHJ;
      FieldByName('SL').AsFloat := dbJFSL;

      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('D', '贷');
      // FieldByName('ZY').AsString:=PGetPrgString('YHDZ_DFHJ','贷方合计');
      FieldByName('JE').AsFloat := dbDFHJ;
      FieldByName('SL').AsFloat := dbDFSL;

      FindFirst;
      {
      if (szZY=PGetPrgString('YHDZ_JFHJ','借方合计')) or (szZY=PGetPrgString('YHDZ_DFHJ','贷方合计')) then begin
          if not Locate('ZY',szZY,[]) then
              FindFirst;
      end else begin
          if not Locate('KJQJ;PZLY;PZH;FLH',VarArrayOf([szKJQJ,szPZLY,szPZH,iFLH]),[]) then
              FindFirst;
      end;  }
    end;
  end;
end;

procedure TFormXSZ.SpeedItemReFreshClick(Sender: TObject);
var
  SqlText: string;
  dbJFHJ, dbDFHJ: Extended;
  dbJFSL, dbDFSL: Extended;
  szZY, szKJQJ, szPZLY, szPZH: string;
  iFLH, iLength: integer;
begin
  szZY := ClientDataSetXSZ.FieldByName('ZY').AsString;
  szKJQJ := ClientDataSetXSZ.FieldByName('KJQJ').AsString;
  szPZLY := ClientDataSetXSZ.FieldByName('PZLY').AsString;
  szPZH := ClientDataSetXSZ.FieldByName('PZH').AsString;
  iFLH := ClientDataSetXSZ.FieldByName('FLH').AsInteger;

  Sqltext := GenSQL; //获取SQL

  ClientDataSetXSZ.Close;
  POpenSql(ClientDataSetXSZ, SqlText);
  DelRepeatRec(ClientDataSetXSZ, 'Temp1');

  dbJFHJ := 0;
  dbDFHJ := 0;
  dbJFSL := 0;
  dbDFSL := 0;

  if ClientDataSetXSZ.FindFirst then
  begin
    with ClientDataSetXSZ do
    begin
      repeat
        //R93新增，带出上级科目名称
        if MShowSJKmmc.Checked then
        begin
          szName := PGetPassName(FieldByName('kmdm').AsString, 'K', True, szFzhs);
          Edit;
          FieldByName('kmmc').AsString := szName;
        end;

        if FieldByName('JDBZ').AsString = '借' then
          dbJFHJ := dbJFHJ + FieldByName('JE').AsFLoat
        else
          dbDFHJ := dbDFHJ + FieldByName('JE').AsFloat;

        //R93新增，增加数量合计行
        if MShowSLHJ.Checked then
        begin
          if FieldByName('JDBZ').AsString = '借' then
            dbJFSL := dbJFSL + FieldByName('SL').AsFLoat
          else
            dbDFSL := dbDFSL + FieldByName('SL').AsFloat;
        end;
        //黄委专版 Added by 刘敏,2005.1.14
        if (Pos('黄委专版', GSpecialVersion) > 0) then
        begin
          if FieldByName('KMLB').AsString = '0' then
          begin
            //cdsYHKMJSFS.Filter := 'yhzh=''' + FieldByName('KMDM').AsString + '''';
            //cdsYHKMJSFS.Filtered := True;
            if cdsYHKMJSFS.FindFirst then //该科目有银行结算方式
              while not cdsYHKMJSFS.Eof do
              begin
                iLength := length(cdsYHKMJSFS.FieldByName('jsfsdm').AsString);
                if Copy(FieldByName('SPZ').AsString, 1, iLength) = cdsYHKMJSFS.FieldByName('jsfsdm').AsString then
                begin
                  Edit;
                  FieldByName('JSFS').AsString := cdsYHKMJSFS.FieldByName('jsfsmc').AsString;
                  FieldByName('SPZ').AsString := Copy(FieldByName('SPZ').AsString, iLength + 1, Length(FieldByName('SPZ').AsString) - iLength);
                  Break;
                end;
                if not cdsYHKMJSFS.FindNext then
                  break;
              end;
            Edit;
            FieldByName('SPZ').AsString := Trim(FieldByName('SPZ').AsString);
          end;
        end;
      until not FindNext;

      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('J', '借');
      //  FieldByName('ZY').AsString:=PGetPrgString('YHDZ_JFHJ','借方合计');
      FieldByName('JE').AsFloat := dbJFHJ;
      FieldByName('SL').AsFloat := dbJFSL;
      Append;
      FieldByName('kjqj').AsString := PGetPrgString('HJ', '合计');
      FieldByName('jdbz').AsString := PGetPrgString('D', '贷');
      // FieldByName('ZY').AsString:=PGetPrgString('YHDZ_DFHJ','贷方合计');
      FieldByName('JE').AsFloat := dbDFHJ;
      FieldByName('SL').AsFloat := dbDFSL;
      FindFirst;
      {
      if (szZY=PGetPrgString('YHDZ_JFHJ','借方合计')) or (szZY=PGetPrgString('YHDZ_DFHJ','贷方合计')) then begin
          if not Locate('ZY',szZY,[]) then
              FindFirst;
      end else begin
          if not Locate('KJQJ;PZLY;PZH;FLH',VarArrayOf([szKJQJ,szPZLY,szPZH,iFLH]),[]) then
              FindFirst;
      end;   }
    end;
  end;

  if CheckBoxAutoWidth.Checked then
    THDBGridXSZ.AutoGridColWidth(-1);
end;

procedure TFormXSZ.SpeedItemHelpClick(Sender: TObject);
begin
  if GProSign = 'IDA' then
  begin
    Application.HelpContext(9085)
  end
  else
  begin
    Application.HelpContext(2150)
  end;
end;

procedure TFormXSZ.THDBGridXSZKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 112 then
    SpeedItemHelpClick(SpeedItemHelp);
end;

procedure TFormXSZ.MShowSJKmmcClick(Sender: TObject);
begin
  MShowSJKmmc.Checked := not MShowSJKmmc.Checked;
  SpeedItemReFreshClick(nil);
end;

procedure TFormXSZ.MShowSLHJClick(Sender: TObject);
begin
  MShowSLHJ.Checked := not MShowSLHJ.Checked;
  SpeedItemReFreshClick(nil);
end;

procedure TFormXSZ.ClientDataSetXSZBeforeOpen(DataSet: TDataSet);
begin
  if (GDbType = ORACLE) and (ClientDataSetXSZ.Params.Count > 0) then
    ClientDataSetXSZ.Params.Clear;
end;

function TFormXSZ.GenSQL: string;
var
  Sqltext: string;
begin
  bTempXSZspred := bXSZspred or (Trim(sXSZZDYSQLCXFW) <> ''); //明细分录条件不为空 bTempXSZspred := True;

  //2014.1.2 hy 维护单ZWR900144975，优化效率，去掉了SQL语句中的Rtrim函数
  if GDbType = ORACLE then
  begin //为了支持低版本的Oracle 不使用Case语句,采用Union
    Sqltext := 'Select (nr.gsdm||nr.kjqj||nr.pzly||nr.pzh||To_Char(nr.flh)) Temp1,' +
      'decode(DataLength(Rtrim(ML.PZRQ)),8,' +
      'SubStr(ML.PZRQ,1,4)||''-''||SubStr(ML.PZRQ,5,2)||''-''||SubStr(ML.PZRQ,7,2),'' '') RQ,' +
      'decode(ML.ZT,''0'',''已作废'',''1'',''未审核'',' +
      '''2'',''已审核'',''3'',''已记账'',''错误凭证'') ZT,' + //无法处理错误凭证
    //'when (ML.ZT=''1'') and (ML.SHID=-2) then ''错误凭证'' else '''' end ZT,'+

    'NR.KJQJ,decode(rtrim(NR.PZLY),''_'','' '',NR.PZLY) PZLY,NR.FLH,LTrim(NR.PZH) PZH,NR.ZY,ltrim(NR.KMDM) KMDM,ltrim(KM.KMMC) KMMC,' +
      'NR.JDBZ,NR.SL,NR.WBJE,NR.JE,decode(rtrim(NR.WBDM),''_'','' '',NR.WBDM) WBDM,NR.HL,NR.DJ,NR.SPZ,NR.WLDRQ,NR.BMDM,NR.XMDM,' + //2011022816082 ADDED 'WLDRQ' BY ZHOUGF
      '(Select BMMC from PubBMXX BM where BM.GSDM=''' + GszGsdm + ''' and BM.BMDM=NR.BMDM) BMMC,' +
      '(Select XMMC from GL_XMZL XM where XM.GSDM=''' + GszGsdm + '''  and XM.XMDM=NR.XMDM) XMMC,';
    SqlText := SqlText +
      'nr.fzdm4,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGsdm + ''' and zl.fzdm=nr.fzdm4 and lbdm=''4'') fzdm4mc,' +
      'nr.fzdm5,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGsdm + ''' and zl.fzdm=nr.fzdm5 and lbdm=''5'') fzdm5mc,' +
      'nr.fzdm6,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGsdm + ''' and zl.fzdm=nr.fzdm6 and lbdm=''6'') fzdm6mc,' +
      'nr.fzdm7,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGsdm + ''' and zl.fzdm=nr.fzdm7 and lbdm=''7'') fzdm7mc,' +
      'nr.fzdm8,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGsdm + ''' and zl.fzdm=nr.fzdm8 and lbdm=''8'') fzdm8mc,' +
      'nr.fzdm9,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGsdm + ''' and zl.fzdm=nr.fzdm9 and lbdm=''9'') fzdm9mc,' +
      'nr.fzdm10,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGsdm + ''' and zl.fzdm=nr.fzdm10 and lbdm=''A'') fzdm10mc,' +

    'decode(InStr(KM.FZHS,'',2,''),0,'' '',NR.WLDM) GRWLDM,' +
      'decode(InStr(KM.FZHS,'',2,''),0,'' '',(Select ZYXM from PubZYXX where ZYDM=NR.WLDM and NR.kjqj like kjnd||''%'' and GSDM=''' + GszGsdm + ''')) GRWLMC,' +
      'decode(InStr(KM.FZHS,'',3,''),0,'' '',NR.WLDM) DWWLDM,' +
      'decode(InStr(KM.FZHS,'',3,''),0,'' '',(Select DWMC from PubKSZL where trim(DWDM)=trim(NR.WLDM) and NR.kjqj like kjnd||''%'' and GSDM=''' + GszGsdm + ''')) DWWLMC ';

    if bTempXSZspred then
    begin // lzn 2005.04.06
      SqlText := SqlText + ',(select lbmc from gl_fzxlb where lbdm=mx.mxlx and kjnd=''' + GszKJNd + ''' and gsdm=''' + GszGSDM + ''') MXLX,MX.FZDM,' +
        '(Select FZMC from gl_fzxzl FX where KJND=''' + GszKJND + ''' and GSDM=''' + GszGSDM + '''  and FX.FZDM=MX.FZDM and FX.LBDM=MX.mxlx) FZMC,' +
        ' mx.je mxje,mx.mxxh ';
    end;

    SqlText := SqlText + ',NR.FZSM1,NR.FZSM2,NR.FZSM3,NR.FZSM4,NR.FZSM5,NR.FZSM6,NR.FZSM7,NR.FZSM8,NR.FZSM9';
    if GZtType = ztTotal then
      SqlText := SqlText + ',ltrim(NR.GSDM) GSDM,(Select GSMC from PubGSZL GS where GS.GSDM=NR.GSDM and KJND='''+GszKJND+''') GSMC';

    //黄委专版 Added by 刘敏,2005.1.14
    if (Pos('黄委专版', GSpecialVersion) > 0) then
      SqlText := SqlText + ',''        '' JSFS,KM.KMLB ';
    SqlText := SqlText + ', ML.SRID, ML.SR ';  // Added by Cheyf 2014-06-23 ZWR900185845 增加制单人
    // Added by haojj 2014-10-21 维护单号：ZWR900210752 增加出纳列
    SqlText := SqlText + ',ML.CN ';
    // Added by haojj 2014-11-05 维护单号：ZWR900211808 增加借方金额与贷方金额列
    SqlText := SqlText + ',case nr.jdbz when ''借'' then nr.je else 0 end jfje ';
    SqlText := SqlText + ',case nr.jdbz when ''贷'' then nr.je else 0 end dfje ';   //20160111 weibc 20151225114234
    // Added by haojj 2015-03-26 维护单号：ZWR900242931 20150309092908 增加审核人
    SqlText := SqlText + ', ml.sh';
    SqlText := SqlText + ' from GL_PZML ML,GL_KMXX KM';
    if blDFKMDM then
      SqlText := SqlText + ',GL_PZNR NR1';
    SqlText := SqlText + ',GL_PZNR NR';

    if bTempXSZspred then //lzn
      SqlText := SqlText + ' Left outer join GL_PZFLMX MX on ' +
        ' MX.ZTH=NR.ZTH and MX.GSDM=NR.GSDM and MX.KJQJ=NR.KJQJ and MX.PZLY=NR.PZLY and MX.PZH=NR.PZH and MX.FLH=NR.FLH';

    SqlText := SqlText + ' where ML.ZTH=''' + GszZth + ''' and NR.ZTH=''' + GszZth + ''' and NR.GSDM=ML.GSDM and NR.KJQJ=ML.KJQJ and NR.PZLY=ML.PZLY';
    SqlText := SqlText + ' and NR.PZH=ML.PZH and KM.ZTH=''' + GszZth + ''' and KM.KMDM=NR.KMDM and km.gsdm=nr.gsdm and nr.kjqj like rtrim(km.kjnd)||''%'' and KM.GSDM=''' + GszGSDM + '''';

//    if bTempXSZspred then
//    begin //lzn
//      SqlText := SqlText + ' and MX.GSDM=NR.GSDM(+) and MX.KJQJ=NR.KJQJ(+) and MX.PZLY=NR.PZLY(+) and MX.PZH=NR.PZH(+) and MX.FLH=NR.FLH(+)';
//    end;

    if GZtType = ztTotal then
      //SqlText := SqlText + ' and NR.ZTH=''' + GszZth + ''' and NR.GSDM like ''' + GszGSDM + '%'''
      SqlText := SqlText + ' and NR.GSDM like ''' + GszHZCXGS + '%'''
    else
      SqlText := SqlText + ' and NR.ZTH=''' + GszZth + ''' and  NR.GSDM=''' + GszGSDM + '''';
    SqlText := SqlText + ' and ' + PSJQX('K', 'NR.KMDM');
    SqlText := SqlText + ' and ' + SqlTextCXFW;
    if bTempXSZspred then
      SqlText := SqlText + sXSZZDYSQLCXFW;

    SqlText := SqlText + ' order by nr.kjqj,nr.pzly,nr.pzh,nr.flh';
    if bTempXSZspred then // lzn 2005.04.06
      SqlText := SqlText + ', mx.mxlx,mx.mxxh,mx.fzdm';
  end
  else
  begin
    //Sqltext := 'Select distinct (nr.gsdm+nr.kjqj+nr.pzly+nr.pzh+str(nr.flh)) Temp1,';
    Sqltext := 'Select (nr.gsdm+nr.kjqj+nr.pzly+nr.pzh+str(nr.flh)) Temp1,';//2014.3.29 hy 维护单ZWR900166858，以前加distinct不知道什么意思，去掉，否则2008上报错
    Sqltext := Sqltext + '(Case when DataLength(Rtrim(ML.PZRQ))=8 then ';
    SqlText := SqlText + 'SubString(ML.PZRQ,1,4)+''-''+SubString(ML.PZRQ,5,2)+''-''+SubString(ML.PZRQ,7,2) ';
    SqlText := SqlText + 'else '''' end) RQ,';
    SqlText := SqlText + '(Case when ML.ZT=''0'' then ''已作废'' when ML.ZT=''1'' then ''未审核'' ';
    SqlText := SqlText + 'when ML.ZT=''2'' then ''已审核'' when ML.ZT=''3'' then ''已记账'' ';
    SqlText := SqlText + 'when (ML.ZT=''1'') and (ML.SHID=-2) then ''错误凭证'' else '''' end) ZT,';
    SqlText := SqlText + 'NR.KJQJ,NR.PZLY,NR.FLH,LTrim(NR.PZH) PZH,NR.ZY,ltrim(NR.KMDM) KMDM,ltrim(KM.KMMC) KMMC,';
    SqlText := SqlText + 'NR.JDBZ,NR.SL,NR.WBJE,NR.JE,NR.WBDM,NR.HL,NR.DJ,NR.SPZ,NR.WLDRQ,NR.BMDM,NR.XMDM,';
    SqlText := SqlText + '(Select BMMC from PubBMXX BM where GSDM=''' + GszGSDM + ''' and KJND='''+GszKJND+''' and  BM.BMDM=NR.BMDM and NR.BMDM<>'''') BMMC,';
    SqlText := SqlText + '(Select XMMC from GL_XMZL XM where GSDM=''' + GszGSDM + ''' and KJND='''+GszKJND+''' and XM.XMDM=NR.XMDM and NR.XMDM<>'''') XMMC,' +
      ' nr.zydm GRWLDM, (Select ZYXM from PubZYXX where KJND='''+GszKJND+''' and ZYDM=NR.ZYDM  and GSDM=''' + GszGSDM + ''' and NR.ZYDM<>'''') GRWLMC,' +
      ' NR.WLDM  DWWLDM,(Select DWMC from PubKSZL where KJND='''+GszKJND+''' and DWDM=NR.WLDM  and GSDM=''' + GszGSDM + ''' and NR.WLDM<>'''') DWWLMC,';
    SqlText := SqlText +
      'nr.fzdm4,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGSDM + '''  and zl.fzdm=nr.fzdm4 and lbdm=''4'' and NR.FZDM4<>'''') fzdm4mc,' +
      'nr.fzdm5,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGSDM + '''  and zl.fzdm=nr.fzdm5 and lbdm=''5'' and NR.FZDM5<>'''') fzdm5mc,' +
      'nr.fzdm6,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGSDM + '''  and zl.fzdm=nr.fzdm6 and lbdm=''6'' and NR.FZDM6<>'''') fzdm6mc,' +
      'nr.fzdm7,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGSDM + '''  and zl.fzdm=nr.fzdm7 and lbdm=''7'' and NR.FZDM7<>'''') fzdm7mc,' +
      'nr.fzdm8,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGSDM + '''  and zl.fzdm=nr.fzdm8 and lbdm=''8'' and NR.FZDM8<>'''') fzdm8mc,' +
      'nr.fzdm9,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGSDM + '''  and zl.fzdm=nr.fzdm9 and lbdm=''9'' and NR.FZDM9<>'''') fzdm9mc,' +
      'nr.fzdm10,(select fzmc from gl_fzxzl zl where KJND=''' + GszKJND + ''' and gsdm=''' + GszGSDM + ''' and zl.fzdm=nr.fzdm10 and lbdm=''A'' and NR.FZDM10<>'''') fzdm10mc ';

    (* SqlText:=SqlText+'case when Charindex('',2,'',KM.FZHS)>0 then NR.WLDM else '' '' end GRWLDM,';
    SqlText:=SqlText+'case when Charindex('',2,'',KM.FZHS)>0 then (Select ZYXM from PubZYXX where ZYDM=NR.WLDM and GSDM='''+GszGSDM+''') else '' '' end GRWLMC,';
    SqlText:=SqlText+'case when Charindex('',3,'',KM.FZHS)>0 then NR.WLDM else '' '' end DWWLDM,';
    SqlText:=SqlText+'case when Charindex('',3,'',KM.FZHS)>0 then (Select DWMC from PubKSZL where DWDM=NR.WLDM and GSDM='''+GszGSDM+''') else '' '' end DWWLMC'; *)

    if bTempXSZspred then
    begin // lzn 2005.04.06
      SqlText := SqlText + ',(select top 1 lbmc from gl_fzxlb where lbdm=mx.mxlx and kjnd=''' + GszKJND + ''' and gsdm=''' + GszGSDM + ''') mxlx,' + //   ',case mx.mxlx when ''4'' then '''+GFZHSName1+''' when ''5'' then '''+GFZHSName2+''' when ''6'' then '''+GFZHSName3+''' when ''7'' then '''+GFZHSName4+''' when ''X'' then ''现金流'' else '''' end mxlx,';           //if GblFX4IsYSKM Then    // lzn                SqlText:=SqlText+ ' case mx.mxlx when ''4'' Then substring(MX.FZDM,3,len(MX.FZDM)-2) else MX.FZDM end FZDM, '           else
        ' MX.FZDM,' +
        ' case mx.mxlx when ''X'' Then (Select XJMC from gl_xjllxm XJ where KJND=''' + GszKJND + ''' and GSDM=''' + GszGSDM + ''' and XJ.XJDM=MX.FZDM)' +
        ' else (Select FZMC from gl_fzxzl FX where GSDM=''' + GszGSDM + ''' and kjnd='''+GszKJND+''' and FX.FZDM=MX.FZDM and FX.LBDM=MX.mxlx) end FZMC,' +
        ' mx.je mxje,' +
        ' mx.mxxh ';
    end;

    SqlText := SqlText + ',NR.FZSM1,NR.FZSM2,NR.FZSM3,NR.FZSM4,NR.FZSM5,NR.FZSM6,NR.FZSM7,NR.FZSM8,NR.FZSM9';
    if GZtType = ztTotal then
      SqlText := SqlText + ',NR.GSDM GSDM,(Select GSMC from PubGSZL GS where GS.GSDM=NR.GSDM and KJND='''+GszKJND+''') GSMC';

    //黄委专版 Added by 刘敏,2005.1.14
    if (Pos('黄委专版', GSpecialVersion) > 0) then
      SqlText := SqlText + ',''        '' JSFS,KM.KMLB';
    SqlText := SqlText + ', ML.SRID, ML.SR ';  // Added by Cheyf 2014-06-23 ZWR900185845 增加制单人
    // Added by haojj 2014-10-21 维护单号：ZWR900210752 增加出纳列
    SqlText := SqlText + ',ML.CN ';
    // Added by haojj 2014-11-05 维护单号：ZWR900211808 增加借方金额与贷方金额列
    SqlText := SqlText + ',case nr.jdbz when ''借'' then nr.je else 0 end jfje ';
    SqlText := SqlText + ',case nr.jdbz when ''贷'' then nr.je else 0 end dfje ';  //20160111 weibc 20151225114234
    // Added by haojj 2015-03-26 维护单号：ZWR900242931 20150309092908 增加审核人
    SqlText := SqlText + ', ml.sh';
    SqlText := SqlText + ' from GL_PZML ML,GL_KMXX KM';
    if blDFKMDM then
      SqlText := SqlText + ',GL_PZNR NR1';

    SqlText := SqlText + ',GL_PZNR NR';

    if bTempXSZspred then //lzn
      SqlText := SqlText + ' Left outer join GL_PZFLMX MX on ' +
        ' MX.ZTH=NR.ZTH and MX.GSDM=NR.GSDM and MX.KJQJ=NR.KJQJ and MX.PZLY=NR.PZLY and MX.PZH=NR.PZH and MX.FLH=NR.FLH';

    SqlText := SqlText + ' where ML.ZTH=''' + GszZth + ''' and NR.GSDM=ML.GSDM and NR.KJQJ=ML.KJQJ and NR.PZLY=ML.PZLY';
    SqlText := SqlText + ' and NR.PZH=ML.PZH and KM.ZTH=''' + GszZth + ''' and KM.KMDM=NR.KMDM and KM.gsdm=nr.gsdm and nr.kjqj like km.kjnd+''%'' and KM.GSDM=''' + GszGSDM + '''';

    // if bTempXSZspred Then begin //lzn
    //     SqlText:=SqlText+' and MX.GSDM=NR.GSDM and MX.KJQJ=NR.KJQJ and MX.PZLY=NR.PZLY and MX.PZH=NR.PZH and MX.FLH=NR.FLH';
    // end;

    if GZtType = ztTotal then
      //SqlText := SqlText + ' and NR.ZTH=''' + GszZth + ''' and NR.GSDM like ''' + GszGSDM + '%'''
      SqlText := SqlText + ' and NR.GSDM like ''' + GszHZCXGS + '%'''
    else
      SqlText := SqlText + ' and NR.ZTH=''' + GszZth + ''' and NR.GSDM=''' + GszGSDM + '''';
    SqlText := SqlText + ' and ' + PSJQX('K', 'NR.KMDM');

    SqlText := SqlText + ' and ' + SqlTextCXFW;
    if bTempXSZspred then
      SqlText := SqlText + sXSZZDYSQLCXFW;
    if GetSQLVersion(DataModuleMain.DataModulePub.ClientDataSetPub) ='2000' then
      SqlText := SqlText + ' order by nr.kjqj,nr.pzly,nr.pzh,nr.flh'
    else if GetSQLVersion(DataModuleMain.DataModulePub.ClientDataSetPub) ='2005' then
      SqlText := SqlText + ' order by nr.kjqj,nr.pzly,nr.pzh,nr.flh'
    else if GetSQLVersion(DataModuleMain.DataModulePub.ClientDataSetPub) ='2008' then//2009.2.21 hy 加上对SQL 2008版本的判断
      SqlText := SqlText + ' order by nr.kjqj,nr.pzly,nr.pzh,nr.flh';

    if bTempXSZspred then // lzn 2005.04.06
      SqlText := SqlText + ',mx.mxlx,mx.mxxh,mx.fzdm';
  end;
  if bXSZspred then
  begin
    THDBGridXSZ.ShowCol('MXJE');
    THDBGridXSZ.ShowCol('FZMC');
    THDBGridXSZ.ShowCol('FZDM');
    THDBGridXSZ.ShowCol('MXLX');
    NZKMX.Checked := True;
    NSSMX.Checked := False;
  end
  else
  begin
    THDBGridXSZ.hideCol('MXLX');
    THDBGridXSZ.hideCol('FZDM');
    THDBGridXSZ.hideCol('FZMC');
    THDBGridXSZ.hideCol('MXJE');
    NZKMX.Checked := False;
    NSSMX.Checked := True;
  end;
  Result := Sqltext;
end;

procedure TFormXSZ.CheckBoxAutoWidthClick(Sender: TObject);
begin
  if CheckBoxAutoWidth.Checked then
    THDBGridXSZ.AutoGridColWidth(-1);
end;

procedure TFormXSZ.THDBGridXSZDblClick(Sender: TObject);
begin
  PopupMenuZBClick(NPZ);  // Added by Cheyf 2014-05-27 双击打开凭证
end;

procedure TFormXSZ.MClearFLCondClick(Sender: TObject);
begin
  // Added by haojj 2014-10-21 维护单号：ZWR900210088 以选项方式控制是否清空分录条件
  MClearFLCond.Checked := not MClearFLCond.Checked;
end;

procedure TFormXSZ.DelRepeatRec(var cds: TClientDataSet; fld: string);
var
  sList: TStringList;
  sTemp: string;
  oldNo: Integer;
begin

  sList:= TStringList.Create;
  try
    sList.Sorted:= True;
    cds.DisableControls;
    try
      cds.First;
      while not cds.Eof do
      begin
        sTemp:= cds.FieldByName(fld).AsString;
        if sList.IndexOf(sTemp)<0 then
        begin
          sList.Add(sTemp);
          cds.Next;
        end
        else
        begin
          oldNo:= cds.RecNo;
          cds.Delete;
          cds.RecNo:= oldNo;
        end;
      end;
      cds.MergeChangeLog;
    finally
      cds.EnableControls;
    end;
  finally
    FreeAndNil(sList);
  end;

end;

end.

