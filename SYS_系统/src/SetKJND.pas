unit SetKJND;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, LggExchanger, SpinZW,ComCtrls;

type
  TFormSetKJND = class(TForm)
    ButtonOK: TButton;
    ButtonCancel: TButton;
    LabelKJND: TLabel;
    SpinEditKJND: TSpinEditZW;
    LggExchanger1: TLggExchanger;
    ListViewKjnd: TListView;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListViewKjndDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSetKJND: TFormSetKJND;  //procedure LoadSNJCZL;          //复制基础资料到上年度

implementation

uses Pub_Global,Pub_Function, DataModuleMain,Pub_Message, Main;
{$R *.DFM}

procedure TFormSetKJND.FormCreate(Sender: TObject);
var
  TempItem:TListItem;
begin
  ListViewKjnd.Items.Clear;
  with DataModulePub.ClientDataSetPub do begin
    POpenSQL(DataModulePub.ClientDataSetPub, 'Select distinct KJND from GL_ztcs where KJND<''9999'' and KJND<>''' + GszKJND + ''' order by KJND');
    if FindFirst then begin
       While not Eof do begin
         TempItem:=ListViewKjnd.Items.add;
         TempItem.Caption:=FieldByName('KJND').AsString;
         Next;
       end;
       (*if Trim(GszGsdm311)<>'' then begin  // lzn 2005.02.24
          TempItem:=ListViewKjnd.Items.add;
          TempItem.Caption:= '取消对历史数据的查询';
       end;*)
    end else begin
       TempItem:=ListViewKjnd.Items.add;
       TempItem.Caption:='当前账套未做年结，无其他年度数据';
       ButtonOK.Enabled := False;
    end;    
  end;
end;

procedure TFormSetKJND.ButtonOKClick(Sender: TObject);
begin
  if ListViewKjnd.Selected <> nil then begin
     GszGSDM311 := ListViewKjnd.Selected.Caption;
     try
       if Trim(GszGsdm311)<>'' then begin
          StrToInt(GszGSDM311);
          //if Gszkjnd_First=GszGSDM311 then
          //   GszGSDM311:=''; //相当于取消查询其他年度
          ModalResult := mrOk;
       end;
     except
       GszGSDM311:='';
     end;
  end;
end;

procedure TFormSetKJND.ButtonCancelClick(Sender: TObject);
begin
    Close;
end;

procedure TFormSetKJND.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action:=caFree;
end;


procedure TFormSetKJND.ListViewKjndDblClick(Sender: TObject);
begin
  if ButtonOK.enabled Then
     ButtonOKClick(nil);
end;

end.
