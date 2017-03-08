unit UUserStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, SpeedBar, ExtCtrls, RXCtrls, DB, DBClient, Tgrids2,
  THDBGrids, THFilters;

type
  TFrmUserState = class(TForm)
    MainMenuCZRZ: TMainMenu;
    MFile: TMenuItem;
    mniUnLock: TMenuItem;
    MLExit: TMenuItem;
    MExit: TMenuItem;
    SpeedBarCzrz: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection4: TSpeedbarSection;
    spdtmUnLock: TSpeedItem;
    SpeedItemExit: TSpeedItem;
    RxLabelTitle: TRxLabel;
    PanelSpace: TPanel;
    RxLabel1: TRxLabel;
    PanelZB: TPanel;
    PanelLeft: TPanel;
    THDBGridUserState: TTHDBGrid;
    PanelBottom: TPanel;
    PanelRight: TPanel;
    dsOperStatus: TClientDataSet;
    DataSourceCZRZ: TDataSource;
    THFilterUserState: TTHFilter;
    procedure mniUnLockClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MExitClick(Sender: TObject);
    procedure spdtmUnLockClick(Sender: TObject);
    procedure SpeedItemExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure RefreshData;
  public
    { Public declarations }
  end;

var
  FrmUserState: TFrmUserState;
  procedure LoadUserState;

implementation

{$R *.dfm}

{ TFrmUserState }
uses
   Pub_Function,Pub_Message;

procedure LoadUserState;
var
  i: integer;
begin
  with Application.MainForm do
    begin
      i:=0; //��ظ���ֵ
      if MDIChildCount>0 then
        for i := 0 to MDIChildCount - 1 do
          if MDIChildren[i].Caption = '����Ա״̬��ѯ' then break;
          
      if i >= MDIChildCount then
        begin
          Application.CreateForm(TFrmUserState, FrmUserState);
          FrmUserState.Show;
        end
      else
        begin
          if MDIChildren[i].WindowState = wsMinimized then
            begin
              MDIChildren[i].WindowState := wsNormal;
              MDIChildren[i].SetFocus;
            end
          else
            MDIChildren[i].BringToFront;
          FrmUserState.Show;
        end;
    end;
end;

procedure TFrmUserState.RefreshData;
var
  sSQL:string;
begin
  sSQL :='select Operid,OperName,Station,ReLoginCount,'+
          'case OperState when 0 then ''δ����'' when 1 then ''����'' end OperState, '+
          'OperTime,LoginStation,'+
          'case LoginOperState when 2 then ''��½'' else ''δ��½''  end LoginOperState,'+   //2Ϊ��¼������Ϊδ��¼ modified by chengjf 20150407
          'LoginOperTime from gl_czyzt';
  try
    POpenSql(dsOperStatus,sSQL);
  except
    ShowMessage('�����ݱ����');
  end;
end;

procedure TFrmUserState.mniUnLockClick(Sender: TObject);
var
  sSQL :string;
begin
  if dsOperStatus.RecordCount<=0 then
  begin
    ShowMessage('��ѡ�������ٲ���');
    exit;
  end;
  if SysMessage('�Ƿ������ǰ����Ա��ȷ��������', 'CZRZ_51_JG', [mbYes, mbNo]) <> mrYes then
    Exit;
  sSQL :='delete from gl_czyzt where Operid='+dsOperStatus.FieldByName('OperID').AsString;
  try
    PExecSql(sSQL);
  except
    ShowMessage('����ʧ�ܣ������²�����');
    exit;
  end;
  RefreshData;
end;

procedure TFrmUserState.FormShow(Sender: TObject);
begin
  //���ô����пؼ�����ɫ����
  SetComponentsColor(self);
  THFilterUserState.THDBGridPad :=THDBGridUserState;
  THFilterUserState.InitColumns;
  RefreshData;
end;

procedure TFrmUserState.MExitClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFrmUserState.spdtmUnLockClick(Sender: TObject);
begin
  mniUnLockClick(nil);
end;

procedure TFrmUserState.SpeedItemExitClick(Sender: TObject);
begin
  MExitClick(nil);
end;

procedure TFrmUserState.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
