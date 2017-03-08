unit PLAT_SelectLawRule;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, DBGrids, Db, DBClient, StdCtrls;

type
  TFormSelectLawRule = class(TForm)
    Panel1: TPanel;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGrid: TDBGrid;
    ButtonOK: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    bIsSelect: Boolean;
  end;

var
  FormSelectLawRule: TFormSelectLawRule;

implementation

{$R *.DFM}

procedure TFormSelectLawRule.FormShow(Sender: TObject);
var
  i: Integer;
begin
  with DBGrid do
  begin
    for i := 0 to DBGrid.Columns.Count - 1 do
    begin
      if Uppercase(DBGrid.Columns[i].Title.Caption) = 'LRNAME' then
        DBGrid.Columns[i].Title.Caption := '名称'
      else if Uppercase(DBGrid.Columns[i].Title.Caption) = 'LRTITLE' then
        DBGrid.Columns[i].Title.Caption := '主题'
      else if Uppercase(DBGrid.Columns[i].Title.Caption) = 'LRAUTHOR' then
        DBGrid.Columns[i].Title.Caption := '作者'
      else if Uppercase(DBGrid.Columns[i].Title.Caption) = 'LRKEYWORDS' then
        DBGrid.Columns[i].Title.Caption := '关键字'
      else if Uppercase(DBGrid.Columns[i].Title.Caption) = 'LRABSTRACT' then
        DBGrid.Columns[i].Title.Caption := '摘要'
      else
        DBGrid.Columns[i].Visible := false;
    end;
  end;
  bIsSelect := False;
end;

procedure TFormSelectLawRule.DBGridDblClick(Sender: TObject);
begin
  ButtonOK.Click;
end;

procedure TFormSelectLawRule.Button2Click(Sender: TObject);
begin
  bIsSelect := False;
end;

procedure TFormSelectLawRule.ButtonOKClick(Sender: TObject);
begin
  bIsSelect := True;
end;

end.
