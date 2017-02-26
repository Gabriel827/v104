unit uQryzhye;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SpeedBar, ExtCtrls, RXCtrls, Tgrids2, THDBGrids, StdCtrls,
  ComCtrls, DB, DBClient, HFExpandPrint, FormPrint;

type
  TFormQryZHYE = class(TForm)
    SpeedBarPZNotePad: TSpeedBar;
    SpeedbarSection5: TSpeedbarSection;
    SpeedbarSection2: TSpeedbarSection;
    SpeedbarSection1: TSpeedbarSection;
    SpeedbarSection3: TSpeedbarSection;
    SpeedbarSection4: TSpeedbarSection;
    SpeedItem_insert: TSpeedItem;
    SpeedItem_Preview: TSpeedItem;
    SpeedItem_Print: TSpeedItem;
    SpeedItem_Refresh: TSpeedItem;
    SpeedItem_Filter: TSpeedItem;
    SpeedItem_NoFilter: TSpeedItem;
    btnImport: TSpeedItem;
    SpeedItem_auditing: TSpeedItem;
    SpeedItem_counter_auditing: TSpeedItem;
    SpeedItem_cancellation: TSpeedItem;
    SpeedItem_revert: TSpeedItem;
    SpeedItem_delete: TSpeedItem;
    SpeedItemHelp: TSpeedItem;
    SpeedItem1: TSpeedItem;
    PanelTitle: TPanel;
    lblTitle: TRxLabel;
    Panel1: TPanel;
    THDBGridYEB: TTHDBGrid;
    Label19: TLabel;
    cbbYH: TComboBox;
    Label1: TLabel;
    dtpDate: TDateTimePicker;
    spdtmMX: TSpeedItem;
    spdtmExp: TSpeedItem;
    dsYEB: TDataSource;
    cdsYEB: TClientDataSet;
    HFExpandPrint1: THFExpandPrint;
    FormPrint1: TFormPrint;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedItem1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedItem_RefreshClick(Sender: TObject);
    procedure spdtmMXClick(Sender: TObject);
    procedure THDBGridYEBDblClick(Sender: TObject);
    procedure spdtmExpClick(Sender: TObject);
    procedure SpeedItemHelpClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitZHYE;
  public
    { Public declarations }
  end;

var
  FormQryZHYE: TFormQryZHYE;
  procedure LoadFormQryZHYE;
implementation
uses Pub_Global,Pub_Power,Pub_Function,Pub_WYZF,zhqry_mx,pub_message;
{$R *.dfm}
procedure LoadFormQryZHYE;
var
  i: Integer;
begin
  
  if not TPower.GetPower(GN_ZHYECX_Read) then
  begin
    SysMessage('没有查阅权限。', AOther_JG, [mbOk]);
    Exit;
  end;

  
  with Application.MainForm do
  begin
    // 如果单位定义已打开，激活该窗口，否则先创建后显示
    i := 0; //务必赋初值
    if MDIChildCount > 0 then
      for i := 0 to MDIChildCount - 1 do
        if MDIChildren[i].Caption = '账户余额查询' then
          break;
    if i >= MDIChildCount then
    begin
      Application.CreateForm(TFormQryZHYE, FormQryZHYE);
      FormQryZHYE.Show;
    end
    else
    begin
      if MDIChildren[i].WindowState = wsMinimized then
        MDIChildren[i].WindowState := wsNormal;
      MDIChildren[i].Show;
    end;
  end;

end;

procedure TFormQryZHYE.FormShow(Sender: TObject);
begin
  SetComponentsColor(self);
end;

procedure TFormQryZHYE.FormCreate(Sender: TObject);
begin
  InitBankForYHZL(cbbYH);
  dtpDate.DateTime := Now;
end;

procedure TFormQryZHYE.SpeedItem1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormQryZHYE.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormQryZHYE.InitZHYE;
var
  sSQL,sYHDM,sCXRQ:string;
begin
  sYHDM := '';
  if cbbYH.Text <> '' then
  begin
    sYHDM := FGetSubS(cbbYH.Text,'BOF',' ');
  end;
  sCXRQ := FormatDateTime('yyyy-mm-dd',dtpDate.DateTime);
  sSQL := 'Select zh.*,ye.TRANS_DATE cxrq, case when YE.CRTBALANCE IS null then YE.DBTBALANCE else YE.CRTBALANCE end yhye, '
    +' YE.TRANS_TIME cxsj '
    +' from pubszdwzh zh '
    +' left join zb_yhzl zl on ltrim(rtrim(zh.yhdm)) = ltrim(rtrim(zl.yhdm)) and zh.gsdm = zl.gsdm and zh.kjnd = zl.kjnd '
    +' left join (Select Top 1 * from ebk_NETCOLLECT where TRANS_DATE=' + QuotedStr(sCXRQ)+' order by Trans_date Desc, Trans_time Desc) ye '
    +' on ye.gsdm=zh.gsdm and ye.CURACC=zh.yhzh '
    +' where ZH.SYZT = ''0'' and ZH.KJND='+QuotedStr(GszKJND) 
    +' and zl.yh_intf is not null ';
  if sYHDM <> '' then
    sSQL := sSQL + ' and zh.yhdm=' + QuotedStr(sYHDM);
  POpenSql(cdsYEB,sSQL);
  spdtmMX.Enabled := cdsYEB.RecordCount > 0;
  //THDBGridYEB.AutoGridColWidth(-1);
end;

procedure TFormQryZHYE.SpeedItem_RefreshClick(Sender: TObject);
begin
  InitZHYE;
end;

procedure TFormQryZHYE.spdtmMXClick(Sender: TObject);
begin
  LoadFormZHQry_MX(cdsYEB.FieldByName('yhname').AsString,cdsYEB.FieldByName('yhhh').AsString,cdsYEB.FieldByName('yhzh').AsString,cdsYEB.FieldByName('yhzhmc').AsString);
end;

procedure TFormQryZHYE.THDBGridYEBDblClick(Sender: TObject);
begin
  spdtmMXClick(nil);
end;

procedure TFormQryZHYE.spdtmExpClick(Sender: TObject);
begin
  HFExpandPrint1.Execute;
end;

procedure TFormQryZHYE.SpeedItemHelpClick(Sender: TObject);
begin
  ChangeHelp('EBK.hlp',51);
end;

end.
