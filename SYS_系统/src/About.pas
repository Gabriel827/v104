unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RxGIF, RXCtrls, Buttons, registry, LggExchanger, menus,
  jpeg, XPMenu, Tgrids2, ComCtrls;

type
  TFormAbout = class(TForm)
    Label5: TLabel;
    LbVSign: TLabel;
    LbVDate: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    LbAnyiCorpC: TRxLabel;
    LbProName: TLabel;
    Label1: TLabel;
    lbRegOwner1: TLabel;
    lbRegCompany1: TLabel;
    LabelClose: TLabel;
    LbProNameAdd: TLabel;
    img: TImage;
    LabelSeries: TLabel;
    imgAbout: TImage;
    LbProNameAdd2: TLabel;
    CloseBtn: TButton;
    THStringGridAbout: TTHStringGrid;
    ListView1: TListView;
    lbRegOwner: TLabel;
    lbRegCompany: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgAboutClick(Sender: TObject);
  private
    { Private declarations }
    FPlatformID: DWord;
    procedure GetRegInfo;
    procedure SetModeDemoInfo;
  public
    { Public declarations }
    FRegister: TRegistry;
  end;

var
  FormAbout: TFormAbout;
procedure GetAbout;
procedure SetLayeredAttribs(W: TWinControl; Alpha: Byte);
//function GetModeNamebyGszAnyi(s:string):string; //根据加密标识获取模块名

implementation

uses Pub_Res, Pub_Global, Pub_Message, Pub_Function, Pub_ProInfo, Main;

{$R *.DFM}

procedure GetAbout;
begin
  FormAbout := TFormAbout.Create(Application);
  FormAbout.ShowModal;
end;

procedure TFormAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormAbout.FormCreate(Sender: TObject);
var
  iDate: Double;
begin
  img.Picture.Icon := Application.Icon;
 (* if (GSpecialVersion <> '') and (GSpecialGProName <> '') then
  begin
    if not GHideSpecialGProName then
      LbProName.Caption := GSpecialGProName
    else
      LbProName.Caption := '';
    LbProNameAdd.Caption := GProName;
    if GHideSpecialVersion then
      LbProNameAdd2.Visible := False;
    LbProNameAdd2.Caption := GSpecialVersion;
    LbProNameAdd2.Left := LbProNameAdd.Left;
    LbProNameAdd2.Top := LbProNameAdd.Top + LbProNameAdd.Height + 3;
    LabelSeries.Visible := False;
  end
  else
  begin
    LbProNameAdd2.Visible := False;
    LbProName.Caption := GProName;
    LbProNameAdd.Caption := GProVerXS;

  end;

  LbVSign.Caption := GetProVerSionScript(GDbType, GProSign, GProSeries,
    GProVersion, GszVersion, True);
  LabelSeries.Caption := LoadStrRes(CRES_SeriesCaption);
  GetRegInfo;
  iDate := FileDateToDateTime(FileAge(Application.ExeName));
  LbVDate.Caption := FormatDateTime('yyyy"年"mm"月"dd"日"', iDate);
  *)

  GetRegInfo;

  LabelSeries.Top := LbProName.Top;
  LabelSeries.Left := LbProName.Left + LbProName.Width + 8;

  ClientWidth := imgAbout.Width - 1;
  ClientHeight := imgAbout.Height - 1;
end;

procedure TFormAbout.GetRegInfo;
const
  WIN95_KEY = '\SOFTWARE\Microsoft\Windows\CurrentVersion';
  WINNT_KEY = '\SOFTWARE\Microsoft\Windows NT\CurrentVersion';
var
  VersionKey: PChar;
  OSVersion: TOSVersionInfo;
begin
  OSVersion.dwOSVersionInfoSize := SizeOf(OSVersion);
  if GetVersionEx(OSVersion) then
  begin
    FPlatformID := OSVersion.dwPlatformID;
  end;

  case FPlatformID of
    VER_PLATFORM_WIN32_WINDOWS: VersionKey := WIN95_KEY;
    VER_PLATFORM_WIN32_NT: VersionKey := WINNT_KEY;
  else
    VersionKey := nil;
  end;

  if (GAnyiLicenseInfo.UN='0')or(GAnyiLicenseInfo.UN='') then
       lbRegOwner.Caption := '未登记'
  else lbRegOwner.Caption :=  GAnyiLicenseInfo.UN;

  if GNOJMVer_CusName<>'' then
     lbRegOwner.Caption := GNOJMVer_CusName;

  if GAnyiLicenseInfo.IsConnected then begin
     lbRegCompany1.Caption := '许可有效期：';
     if (GAnyiLicenseInfo.VD='0')or((Trim(GAnyiLicenseInfo.VD)='')) then
          lbRegCompany.Caption := '永久'
     else lbRegCompany.Caption := FormatDateTime('yyyy"年"m"月"d"日"', StrToInt(GAnyiLicenseInfo.VD));
  end else begin
     lbRegCompany1.Caption := '演示有效期：';
     lbRegCompany.Caption :=  FormatDateTime('yyyy"年"m"月"d"日"', StrToDate(AI_DEMO_DATE));
  end;
  if GNOJMVer_CusName<>'' then begin
     lbRegCompany1.Caption := '使用有效期：';
  end;

end;

procedure TFormAbout.imgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sTs: string;
begin
  sTs := '';
  if (ssCtrl in Shift) then begin // Ctrl + MouseButton       Lzn    //if GProSign = 'GL' Then begin //by mxl 注释
    if Application.MainForm.FindComponent('MFJZ') is TMenuItem then
      TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible := not TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible;
    if Application.MainForm.FindComponent('MNSJHF') is TMenuItem then
      TMenuItem(Application.MainForm.FindComponent('MNSJHF')).Visible := not TMenuItem(Application.MainForm.FindComponent('MNSJHF')).Visible;

    if (GProSign = 'GL') or (GProSign = 'BM') or (GProSign = 'FA') then
    begin //caiyf 040927 增加资金反记账提示 CAISL 2004.10.28 固定资产反记账提示。
      if TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible then
      begin
        if application.FindComponent('FormPZNotePad') <> nil then
          sTs := '注意：请先关闭当前打开的凭证箱,再打开凭证箱,才能打开反记账功能菜单' + #13#13;

        if Application.FindComponent('FormPZ') <> nil then
          sTs := sTs + '注意：请先关闭当前打开的凭证,再打开凭证,才能打开反记账功能菜单' + #13#13;
        if GProSign='BM' then      // Added by chengjf 2008-4-7 16:19:48
             Sysmessage(sTs + '反记账相关功能已开启!!!', 'AOther_YB', [mbok])
        else Sysmessage(sTs + '反结账和反记账等相关功能已开启!!!', 'AOther_YB', [mbok]);
      end
      else
        if GProSign='BM' then      // Added by chengjf 2008-4-7 16:19:48
             Sysmessage('反记账相关功能已关闭!!!', 'AOther_YB', [mbok])
        else Sysmessage('反结账和反记账等相关功能已关闭!!!', 'AOther_YB', [mbok]);
    end;
    
    {工资部分}
    if (GProSign = 'PA') then
    begin
      if TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible then begin
        Sysmessage(sTs + '反结账功能已开启!!!', 'AOther_YB', [mbok]);
      end else
        Sysmessage('反结账功能已关闭!!!', 'AOther_YB', [mbok]);
    end;
    
    {出纳部分}
    if (GProSign = 'CM') then
    begin
      if TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible then
      begin
        Sysmessage(sTs + '反结账和反记账等相关功能已开启!!!', 'AOther_YB', [mbok]);
      end
      else
        Sysmessage('反结账和反记账等相关功能已关闭!!!', 'AOther_YB', [mbok]);
    end;
  end;

  if GProSign = 'FBS' then
    if (ssShift in Shift) and (ssCtrl in Shift) and (ssAlt in Shift) then
    begin
      if Application.MainForm.FindComponent('NWHSZ') is TMenuItem then
        TMenuItem(Application.MainForm.FindComponent('NWHSZ')).Visible := not TMenuItem(Application.MainForm.FindComponent('NWHSZ')).Visible;
      if Application.MainForm.FindComponent('NZBLYSZ') is TMenuItem then
        TMenuItem(Application.MainForm.FindComponent('NZBLYSZ')).Visible := not TMenuItem(Application.MainForm.FindComponent('NZBLYSZ')).Visible;
      if Application.MainForm.FindComponent('NDZKSZ') is TMenuItem then
        TMenuItem(Application.MainForm.FindComponent('NDZKSZ')).Visible := not TMenuItem(Application.MainForm.FindComponent('NDZKSZ')).Visible;
      if Application.MainForm.FindComponent('NJFLXSZ') is TMenuItem then
        TMenuItem(Application.MainForm.FindComponent('NJFLXSZ')).Visible := not TMenuItem(Application.MainForm.FindComponent('NJFLXSZ')).Visible;
      if Application.MainForm.FindComponent('NYSKMSZ') is TMenuItem then
        TMenuItem(Application.MainForm.FindComponent('NYSKMSZ')).Visible := not TMenuItem(Application.MainForm.FindComponent('NYSKMSZ')).Visible;
      if Application.MainForm.FindComponent('NSZDWSZ') is TMenuItem then
        TMenuItem(Application.MainForm.FindComponent('NSZDWSZ')).Visible := not TMenuItem(Application.MainForm.FindComponent('NSZDWSZ')).Visible;
    end;

end;

procedure TFormAbout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close
  else if (Key = Ord('C')) and (ssAlt in Shift) then
    Close;
  Key := 0;
end;

procedure TFormAbout.CloseBtnClick(Sender: TObject);
begin
  close;
end;

procedure TFormAbout.FormShow(Sender: TObject);
begin
  SetXPMenu(Self);
  ResImgReplace(self);
  SetModeDemoInfo;
end;

procedure TFormAbout.imgAboutClick(Sender: TObject);
begin
  close;
end;

(*function GetModeNamebyGszAnyi(s:string):string; //根据加密标识获取模块名
begin
  Result := '';
  if s=GszAnyi_GLNPG then begin
     Result := 'GL';
  end else if s=GszAnyi_GALG then begin
     Result := 'GAL';
  end else if s=GszAnyi_PAG then begin
     Result := 'PA';
  end else if s=GszAnyi_PAACG then begin
     Result := 'PAAC';
  end else if s=GszAnyi_FAQCG then begin
     Result := 'FAQC';
  end else if s=GszAnyi_AQR then begin
     Result := 'AQR';
  end else if s=GszAnyi_BMG then begin
     Result := 'BM';
  end else if s=GszAnyi_CMG then begin
     Result := 'CM';
  end else if s=GszAnyi_BGG then begin
     Result := 'BG';
  end else if s=GszAnyi_GBGG then begin
     Result := 'GBG';
  end else if s=GszAnyi_IGBGG then begin
     Result := 'IGBG';
  end else if s=GszAnyi_CHQG then begin
     Result := 'CHQ';
  end;
end;  *)

procedure TFormAbout.SetModeDemoInfo;
var
  i,j,iRow,iPos:Integer;
  ListMode:TStrings;
  sModeName,sMenuName,sPathFile,sFileDate,sDemo,sGszVersion,sDemoDate,sHangye,sGProSeries,sGnScripts:string;
  bDemo,bHave,bADDCZ:Boolean;
  LabelTemp : TLabel;
  TempListItem: TListItem;
  TmpInfo: TAnyiProductInfo;
  sPublicPath:string;
begin
  ListMode:=TStringList.create;
  ListView1.Items.Clear;
  sPublicPath := ExtractFileDir(Application.ExeName)+'\R9Public.bpl';

  with FormMain.TreeViewFunc do begin
    for i:= 0 to Items.count-1 do begin
      if items[i].Level<>0 then Continue;
      if items[i].Data=nil then Continue;
      sModeName := PTreeRec(items[i].Data)^.sModCode;
      if not PGetNeedEncryptMode(sModeName) then
         continue;
      if ListMode.IndexOf(sModeName)>=0 then
         Continue;

      ListMode.Add(sModeName);
      sPathFile := ExtractFileDir(Application.ExeName)+'\'+PTreeRec(items[i].Data)^.sGnflExec;

      bDemo := PTreeRec(items[i].Data)^.bDemo; //bDemo :=Pos('演示',sMenuName)>0;
      sGszVersion := GetGszAnyiByModeName(PTreeRec(items[i].Data)^.sModCode);
    
      sMenuName := Items[i].Text;
      iPos := Pos('[',sMenuName);
      if iPos > 0 then
         sMenuName := Copy(sMenuName,1,iPos-1);

      //产品名称    否演示版 加密标识  版本系列标识  演示终止日期   文件日期
      //账务处理系统   是     GALG      政府财务 G     20111203      20110418
      if GAnyiLicenseInfo.FindProduct(sGszVersion, TmpInfo) then
      begin
         sGszVersion := TmpInfo.FShortName;
         sDemo := TmpInfo.FVersion;
         sHangye := TmpInfo.FIndustry;
         sGProSeries := TmpInfo.FProSeries;
         sDemoDate := '';
      end else if GNOJMVer_CusName<>'' then begin
         sGszVersion := GetGszAnyiByModeName(sModeName);
         sDemo := 'V10.1';
         sHangye := Copy(GNOJMVer_info,1,Pos(';',GNOJMVer_info)-1);
         sGProSeries := Copy(GNOJMVer_info,Pos(';',GNOJMVer_info)+1,Length(GNOJMVer_info)-Pos(';',GNOJMVer_info))+'版';
         sDemoDate := AI_DEMO_DATE; //GNOJMVer_InDate;
      end else
      begin
         sGszVersion := GetGszAnyiByModeName(sModeName);
         if (sGszVersion = '') then
             sGszVersion := sModeName;
         sDemo:='演示版';
         sDemoDate := AI_DEMO_DATE;
         sHangye := GszRelease;
         sGProSeries := GszEdition+'版';
      end;

      if Trim(PTreeRec(items[i].Data)^.sGnflExec)='' then
         sFileDate := '' //有的模块没有bpl
      else begin
        if FileExists(sPathFile) then
             sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(sPathFile)))
        else sFileDate := '<文件不存在>';
      end;

      TempListItem:=ListView1.Items.Add;
      TempListItem.Caption:=sMenuName;//GAnyiLicenseInfo.AEncryptSt[j].sModeText;
      TempListItem.SubItems.Append(sGszVersion);
      TempListItem.SubItems.Append(sDemo);

      // 崔立国 2011.06.20 "财政"不显示"G版"字样
      if (Pos('财政', GProSeriesName) > 1)  or (GszEdition='精华') then
        TempListItem.SubItems.Append(sHangye)
      else
        TempListItem.SubItems.Append(sHangye+'('+sGProSeries+')');

      TempListItem.SubItems.Append(sFileDate);
    end;

    //公共模块
    sPathFile := ExtractFileDir(Application.ExeName)+'\R9Public.bpl';
    if FileExists(sPathFile) then
         sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(sPathFile)))
    else sFileDate := '<文件不存在>';

    sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(Application.ExeName)));
    TempListItem:=ListView1.Items.Add;
    TempListItem.Caption:='公共模块';
    TempListItem.SubItems.Append('PUB');
    TempListItem.SubItems.Append(' ');
    TempListItem.SubItems.Append(' ');
    TempListItem.SubItems.Append(sFileDate);
  
    //处理非加密模块
    bADDCZ := False;
    for i:= 0 to Items.count-1 do begin
      if items[i].Data=nil then Continue;

      if (not bADDCZ) then begin //财政基础资料
        sGnScripts := PTreeRec(items[i].Data)^.sGnScripts;
        if (sGnScripts='BASCZ') then begin
          sPathFile := ExtractFileDir(Application.ExeName)+'\BASCZ.bpl';
          if FileExists(sPathFile) then
               sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(sPathFile)))
          else sFileDate := '<文件不存在>';

          sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(sPathFile)));
          TempListItem:=ListView1.Items.Add;
          TempListItem.Caption:='财政基础数据管理';
          TempListItem.SubItems.Append('BASCZ');
          TempListItem.SubItems.Append(' ');
          TempListItem.SubItems.Append(' ');
          TempListItem.SubItems.Append(sFileDate);
          bADDCZ := True;
        end;
      end;
      if items[i].Level<>0 then Continue;

      sModeName := PTreeRec(items[i].Data)^.sModCode;
      if ListMode.IndexOf(sModeName)>=0 then
         Continue;
      if PGetNeedEncryptMode(sModeName) then
         continue;
      sPathFile := ExtractFileDir(Application.ExeName)+'\'+PTreeRec(items[i].Data)^.sGnflExec;
      ListMode.Add(sModeName);

      sMenuName := Items[i].Text;
      if FileExists(sPathFile) then
           sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(sPathFile)))
      else sFileDate := '<文件不存在>';
      TempListItem:=ListView1.Items.Add;
      TempListItem.Caption:=sMenuName;
      TempListItem.SubItems.Append(sModeName);
      TempListItem.SubItems.Append(' ');
      TempListItem.SubItems.Append(' ');
      TempListItem.SubItems.Append(sFileDate);
    end;

    ListMode.Free;

    //系统控制台
    sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(Application.ExeName)));
    TempListItem:=ListView1.Items.Add;
    TempListItem.Caption:='系统控制台';
    TempListItem.SubItems.Append('SYS');
    TempListItem.SubItems.Append(' ');
    TempListItem.SubItems.Append(' ');
    TempListItem.SubItems.Append(sFileDate);
  end;

end;

procedure SetLayeredAttribs(W: TWinControl; Alpha: Byte);
const
  WS_EX_LAYERED = $00080000;
var
  FormStyle: Integer;
begin
  if W.HandleAllocated then
  begin
    W.ParentWindow := GetDesktopWindow;
    Windows.SetParent(W.Handle, GetDesktopWindow);
    FormStyle := GetWindowLong(W.Handle, GWL_EXSTYLE);
    SetWindowLong(W.Handle, GWL_EXSTYLE, FormStyle or WS_EX_LAYERED or WS_EX_TOOLWINDOW);
    SetLayeredWindowAttributes(W.Handle, 0, Alpha, 2);
    w.BringToFront;
  end;
end; 


end.

