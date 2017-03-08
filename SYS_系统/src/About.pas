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
//function GetModeNamebyGszAnyi(s:string):string; //���ݼ��ܱ�ʶ��ȡģ����

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
  LbVDate.Caption := FormatDateTime('yyyy"��"mm"��"dd"��"', iDate);
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
       lbRegOwner.Caption := 'δ�Ǽ�'
  else lbRegOwner.Caption :=  GAnyiLicenseInfo.UN;

  if GNOJMVer_CusName<>'' then
     lbRegOwner.Caption := GNOJMVer_CusName;

  if GAnyiLicenseInfo.IsConnected then begin
     lbRegCompany1.Caption := '�����Ч�ڣ�';
     if (GAnyiLicenseInfo.VD='0')or((Trim(GAnyiLicenseInfo.VD)='')) then
          lbRegCompany.Caption := '����'
     else lbRegCompany.Caption := FormatDateTime('yyyy"��"m"��"d"��"', StrToInt(GAnyiLicenseInfo.VD));
  end else begin
     lbRegCompany1.Caption := '��ʾ��Ч�ڣ�';
     lbRegCompany.Caption :=  FormatDateTime('yyyy"��"m"��"d"��"', StrToDate(AI_DEMO_DATE));
  end;
  if GNOJMVer_CusName<>'' then begin
     lbRegCompany1.Caption := 'ʹ����Ч�ڣ�';
  end;

end;

procedure TFormAbout.imgMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sTs: string;
begin
  sTs := '';
  if (ssCtrl in Shift) then begin // Ctrl + MouseButton       Lzn    //if GProSign = 'GL' Then begin //by mxl ע��
    if Application.MainForm.FindComponent('MFJZ') is TMenuItem then
      TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible := not TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible;
    if Application.MainForm.FindComponent('MNSJHF') is TMenuItem then
      TMenuItem(Application.MainForm.FindComponent('MNSJHF')).Visible := not TMenuItem(Application.MainForm.FindComponent('MNSJHF')).Visible;

    if (GProSign = 'GL') or (GProSign = 'BM') or (GProSign = 'FA') then
    begin //caiyf 040927 �����ʽ𷴼�����ʾ CAISL 2004.10.28 �̶��ʲ���������ʾ��
      if TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible then
      begin
        if application.FindComponent('FormPZNotePad') <> nil then
          sTs := 'ע�⣺���ȹرյ�ǰ�򿪵�ƾ֤��,�ٴ�ƾ֤��,���ܴ򿪷����˹��ܲ˵�' + #13#13;

        if Application.FindComponent('FormPZ') <> nil then
          sTs := sTs + 'ע�⣺���ȹرյ�ǰ�򿪵�ƾ֤,�ٴ�ƾ֤,���ܴ򿪷����˹��ܲ˵�' + #13#13;
        if GProSign='BM' then      // Added by chengjf 2008-4-7 16:19:48
             Sysmessage(sTs + '��������ع����ѿ���!!!', 'AOther_YB', [mbok])
        else Sysmessage(sTs + '�����˺ͷ����˵���ع����ѿ���!!!', 'AOther_YB', [mbok]);
      end
      else
        if GProSign='BM' then      // Added by chengjf 2008-4-7 16:19:48
             Sysmessage('��������ع����ѹر�!!!', 'AOther_YB', [mbok])
        else Sysmessage('�����˺ͷ����˵���ع����ѹر�!!!', 'AOther_YB', [mbok]);
    end;
    
    {���ʲ���}
    if (GProSign = 'PA') then
    begin
      if TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible then begin
        Sysmessage(sTs + '�����˹����ѿ���!!!', 'AOther_YB', [mbok]);
      end else
        Sysmessage('�����˹����ѹر�!!!', 'AOther_YB', [mbok]);
    end;
    
    {���ɲ���}
    if (GProSign = 'CM') then
    begin
      if TMenuItem(Application.MainForm.FindComponent('MFJZ')).Visible then
      begin
        Sysmessage(sTs + '�����˺ͷ����˵���ع����ѿ���!!!', 'AOther_YB', [mbok]);
      end
      else
        Sysmessage('�����˺ͷ����˵���ع����ѹر�!!!', 'AOther_YB', [mbok]);
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

(*function GetModeNamebyGszAnyi(s:string):string; //���ݼ��ܱ�ʶ��ȡģ����
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

      bDemo := PTreeRec(items[i].Data)^.bDemo; //bDemo :=Pos('��ʾ',sMenuName)>0;
      sGszVersion := GetGszAnyiByModeName(PTreeRec(items[i].Data)^.sModCode);
    
      sMenuName := Items[i].Text;
      iPos := Pos('[',sMenuName);
      if iPos > 0 then
         sMenuName := Copy(sMenuName,1,iPos-1);

      //��Ʒ����    ����ʾ�� ���ܱ�ʶ  �汾ϵ�б�ʶ  ��ʾ��ֹ����   �ļ�����
      //������ϵͳ   ��     GALG      �������� G     20111203      20110418
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
         sGProSeries := Copy(GNOJMVer_info,Pos(';',GNOJMVer_info)+1,Length(GNOJMVer_info)-Pos(';',GNOJMVer_info))+'��';
         sDemoDate := AI_DEMO_DATE; //GNOJMVer_InDate;
      end else
      begin
         sGszVersion := GetGszAnyiByModeName(sModeName);
         if (sGszVersion = '') then
             sGszVersion := sModeName;
         sDemo:='��ʾ��';
         sDemoDate := AI_DEMO_DATE;
         sHangye := GszRelease;
         sGProSeries := GszEdition+'��';
      end;

      if Trim(PTreeRec(items[i].Data)^.sGnflExec)='' then
         sFileDate := '' //�е�ģ��û��bpl
      else begin
        if FileExists(sPathFile) then
             sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(sPathFile)))
        else sFileDate := '<�ļ�������>';
      end;

      TempListItem:=ListView1.Items.Add;
      TempListItem.Caption:=sMenuName;//GAnyiLicenseInfo.AEncryptSt[j].sModeText;
      TempListItem.SubItems.Append(sGszVersion);
      TempListItem.SubItems.Append(sDemo);

      // ������ 2011.06.20 "����"����ʾ"G��"����
      if (Pos('����', GProSeriesName) > 1)  or (GszEdition='����') then
        TempListItem.SubItems.Append(sHangye)
      else
        TempListItem.SubItems.Append(sHangye+'('+sGProSeries+')');

      TempListItem.SubItems.Append(sFileDate);
    end;

    //����ģ��
    sPathFile := ExtractFileDir(Application.ExeName)+'\R9Public.bpl';
    if FileExists(sPathFile) then
         sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(sPathFile)))
    else sFileDate := '<�ļ�������>';

    sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(Application.ExeName)));
    TempListItem:=ListView1.Items.Add;
    TempListItem.Caption:='����ģ��';
    TempListItem.SubItems.Append('PUB');
    TempListItem.SubItems.Append(' ');
    TempListItem.SubItems.Append(' ');
    TempListItem.SubItems.Append(sFileDate);
  
    //����Ǽ���ģ��
    bADDCZ := False;
    for i:= 0 to Items.count-1 do begin
      if items[i].Data=nil then Continue;

      if (not bADDCZ) then begin //������������
        sGnScripts := PTreeRec(items[i].Data)^.sGnScripts;
        if (sGnScripts='BASCZ') then begin
          sPathFile := ExtractFileDir(Application.ExeName)+'\BASCZ.bpl';
          if FileExists(sPathFile) then
               sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(sPathFile)))
          else sFileDate := '<�ļ�������>';

          sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(sPathFile)));
          TempListItem:=ListView1.Items.Add;
          TempListItem.Caption:='�����������ݹ���';
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
      else sFileDate := '<�ļ�������>';
      TempListItem:=ListView1.Items.Add;
      TempListItem.Caption:=sMenuName;
      TempListItem.SubItems.Append(sModeName);
      TempListItem.SubItems.Append(' ');
      TempListItem.SubItems.Append(' ');
      TempListItem.SubItems.Append(sFileDate);
    end;

    ListMode.Free;

    //ϵͳ����̨
    sFileDate := FormatDateTime('yyyy-mm-dd hh:nn', FileDateToDateTime(FileAge(Application.ExeName)));
    TempListItem:=ListView1.Items.Add;
    TempListItem.Caption:='ϵͳ����̨';
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

