unit uSelectFromData;

interface

uses
  Windows, Messages, SysUtils, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DBClient, DB,  Buttons, ExtCtrls, Grids, DBGrids,
  DBGridEh;

type
  TFrmSelectFromData = class(TForm)
    PanelTop: TPanel;
    LabelInput: TLabel;
    EditInput: TEdit;
    PanelRight: TPanel;
    BitBtnOK: TBitBtn;
    BitBtnCancel: TBitBtn;
    lvSelect: TListView;
    Label1: TLabel;
    grdSelect: TDBGridEh;
    ds: TDataSource;
    procedure BitBtnOKClick(Sender: TObject);
    procedure BitBtnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EditInputChange(Sender: TObject);
    procedure lvSelectColumnClick(Sender: TObject; Column: TListColumn);
  private
    FFld: String;
    FTbl: String;
    FSelected: Variant;
    FDataSet:TClientDataSet;
    FCap: String;
    FIsGrid:Boolean;
    procedure SetFld(const Value: String);
    procedure SetTbl(const Value: String);
    procedure SetSelected(const Value: Variant);
    procedure Refresh;
    procedure AddData;
    procedure DataSetFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure SetCap(const Value: String);
    procedure SetIsGrid(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
    property Tbl:String read FTbl write SetTbl;
    property Fld:String read FFld write SetFld;
    property Cap:String read FCap write SetCap;
    property IsGrid:Boolean read FIsGrid write SetIsGrid;
    property Selected:Variant read FSelected write SetSelected;
  end;

  function SelectLst(ATbl, AField:String; MultiSelectSymbol: Boolean = false; vCap:String=''): Variant; overload;
  function SelectLst(ACds:OleVariant; AField:String; MultiSelectSymbol: Boolean = false; vCap:String=''): Variant;overload;
  function SelectLstGrd(ACds:OleVariant; AField:String; MultiSelectSymbol: Boolean = false; vCap:String=''; vValue:String=''): Variant;overload;

implementation

uses
  DataModuleMain, Pub_Function, Pub_Power;

{$R *.dfm}
function SelectLstGrd(ACds:OleVariant; AField:String; MultiSelectSymbol: Boolean = false; vCap:String=''; vValue:String=''): Variant;overload;
var
  FrmSelectFromData: TFrmSelectFromData;
begin
  Result := VarNULL;
  FrmSelectFromData:=TFrmSelectFromData.Create(nil);
  try
    FrmSelectFromData.IsGrid := True;
    FrmSelectFromData.FDataSet := TClientDataSet.Create(nil);
    FrmSelectFromData.FDataSet.Data := ACds;
    FrmSelectFromData.ds.DataSet := FrmSelectFromData.FDataSet;
    FrmSelectFromData.FDataSet.Active := True;
    FrmSelectFromData.Fld := AField;
    FrmSelectFromData.Cap := vCap;
    if vValue <> '' then
      FrmSelectFromData.EditInput.Text := vValue;
    if MultiSelectSymbol then
      FrmSelectFromData.grdSelect.Options := FrmSelectFromData.grdSelect.Options + [dgMultiSelect];
    if FrmSelectFromData.ShowModal = mrOK then
    begin
      Result := FrmSelectFromData.Selected;
    end;
  finally
    FrmSelectFromData.Free;
  end;
end;

function SelectLst(ACds:OleVariant; AField:String; MultiSelectSymbol: Boolean = false; vCap:String=''): Variant;overload;
var
  FrmSelectFromData: TFrmSelectFromData;
begin
  Result := VarNULL;
  FrmSelectFromData:=TFrmSelectFromData.Create(nil);
  try
    FrmSelectFromData.IsGrid := False;
    FrmSelectFromData.FDataSet := TClientDataSet.Create(nil);
    FrmSelectFromData.FDataSet.Data := ACds;
    FrmSelectFromData.FDataSet.Active := True;
    FrmSelectFromData.Fld := AField;
    FrmSelectFromData.Cap := vCap;
    FrmSelectFromData.lvSelect.MultiSelect := MultiSelectSymbol;
    FrmSelectFromData.AddData;
    FrmSelectFromData.grdSelect.BringToFront;
    if FrmSelectFromData.ShowModal = mrOK then
    begin
      Result := FrmSelectFromData.Selected;
    end;
  finally
    FrmSelectFromData.Free;
  end;
end;

function SelectLst(ATbl, AField:String; MultiSelectSymbol: Boolean; vCap:String): Variant;
var
  FrmSelectFromData: TFrmSelectFromData;
begin
  Result := VarNULL;
  FrmSelectFromData:=TFrmSelectFromData.Create(nil);
  try
    FrmSelectFromData.IsGrid := False;
    FrmSelectFromData.Tbl := ATbl;
    FrmSelectFromData.Fld := AField;
    FrmSelectFromData.Cap := vCap;
    FrmSelectFromData.lvSelect.MultiSelect := MultiSelectSymbol;
    FrmSelectFromData.Refresh;
    if FrmSelectFromData.ShowModal = mrOK then
    begin
      Result := FrmSelectFromData.Selected;
    end;
  finally
    FrmSelectFromData.Free;
  end;
end;

{ TFrmSelectFromData }

procedure TFrmSelectFromData.SetFld(const Value: String);
begin
  FFld := Value;
  if FIsGrid then
  begin
    if grdSelect.Columns.Count >0 then
    begin
      grdSelect.Columns[0].Title.Caption := '´úÂë';
      grdSelect.Columns[0].Width := 120;
    end;
    if grdSelect.Columns.Count >1 then
    begin
      grdSelect.Columns[1].Title.Caption := 'Ãû³Æ';
      grdSelect.Columns[1].Width := 200;
    end;
  end;
end;

procedure TFrmSelectFromData.SetSelected(const Value: Variant);
begin
  FSelected := Value;
end;

procedure TFrmSelectFromData.SetTbl(const Value: String);
begin
  FTbl := Value;

end;

procedure TFrmSelectFromData.BitBtnOKClick(Sender: TObject);
var
  tpItem:TListItem;
  iCount, jCount:integer;
  V:variant;
begin
  if not FIsGrid then
  begin
    tpItem := lvSelect.Selected;
    try
      FSelected := VarArrayCreate([0, lvSelect.SelCount-1], varVariant);
    except
      on e:exception do
        showMessage(e.Message);
    end;
    jCount := 0;
    while tpItem <> nil do
    begin
      if tpItem.Data <> nil then
        FDataSet.GotoBookmark(tpItem.Data);
      V := VarArrayCreate([0, FDataSet.Fields.Count-1], varVariant);
      for iCount:=0 to FDataSet.Fields.Count-1 do
        V[iCount] := FDataSet.Fields[iCount].AsString;

      FSelected[jCount] := V;
      inc(jCount);
      if jCount > lvSelect.SelCount-1 then
        break;
      tpItem := lvSelect.GetNextItem(tpItem, sdBelow, [isSelected]);
    end;
  end
  else
  begin
    if grdSelect.SelectedRows.Count > 0 then
    begin
      FSelected := VarArrayCreate([0, grdSelect.SelectedRows.Count-1], varVariant);
      for jCount:=0 to grdSelect.SelectedRows.Count-1 do
      begin
        V := VarArrayCreate([0, FDataSet.Fields.Count-1], varVariant);
        FDataSet.GotoBookmark(Pointer(grdSelect.SelectedRows[jCount]));
        for iCount:=0 to FDataSet.Fields.Count-1 do
          V[iCount] := FDataSet.Fields[iCount].AsString;
         FSelected[jCount] := V;
      end;
    end
    else
    begin
      FSelected := VarArrayCreate([0, 0], varVariant);
      V := VarArrayCreate([0, FDataSet.Fields.Count-1], varVariant);
      for iCount:=0 to FDataSet.Fields.Count-1 do
        V[iCount] := FDataSet.Fields[iCount].AsString;
       FSelected[0] := V;
    end;  
  end;
  ModalResult := mrOK;
end;

procedure TFrmSelectFromData.BitBtnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmSelectFromData.Refresh;
var
  vSQL:String;
begin
  vSQL := 'Select '+Fld +' from ('+FTbl+') A';
  FDataSet := DataModulePub.GetCdsBySQL(vSQL);
  AddData;
end;

procedure TFrmSelectFromData.FormDestroy(Sender: TObject);
begin
  FDataSet.Free;
end;

procedure TFrmSelectFromData.AddData;
begin
  FDataSet.First;
  lvSelect.Items.Clear;
  if FDataSet.Fields.Count >=3 then
  begin
    with lvSelect.Columns.Add do
    begin
      Caption := FCap;
      Width := 100;
    end;
  end;
  if FDataSet.Fields.Count = 1 then
    lvSelect.Columns.Delete(1);

  while not FDataSet.eof do
  begin
    with lvSelect.Items.Add do
    begin
      Caption := FDataSet.Fields[0].AsString;
      if FDataSet.Fields.Count > 1 then
      begin
        SubItems.Add(FDataSet.Fields[1].AsString);
        if FDataSet.Fields.Count > 2 then
          SubItems.Add(FDataSet.Fields[2].AsString);
      end;
      Data := FDataSet.GetBookmark;
    end;
    if FDataSet.Fields.Count = 1 then
      lvSelect.Columns[0].width := 200;  
    FDataSet.Next;
  end;
end;

var
  FilterCdtn:String;
  
function IsIncludePY(vHZ: string): Boolean;
var
  vPY: string;
begin
  PStrToPy(vHZ, vPY);
  Result := (Pos(UpperCase(FilterCdtn), vPY) > 0) or (Pos(UpperCase(FilterCdtn), vHZ) > 0);
end;

procedure TFrmSelectFromData.EditInputChange(Sender: TObject);
begin
  FilterCdtn := EditInput.Text;
  FDataSet.Filtered := False;
  FDataSet.OnFilterRecord := DataSetFilterRecord;
  FDataSet.Filtered := True;
  if not FIsGrid then
    AddData;
end;

procedure TFrmSelectFromData.DataSetFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  vPY: string;
  iCount:integer;
begin
  if FilterCdtn <> '' then
  begin
    for iCount:=0 to DataSet.Fields.Count-1 do
    begin    
      if (DataSet.Fields[iCount] <> nil) then
        Accept := (Pos(UpperCase(FilterCdtn), UpperCase(DataSet.Fields[iCount].AsString)) > 0);
      if Accept then
        break;
    end;
  end;
end;
var
  SortType: array[0..2] of integer;
function CustomSortCaption(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
  if ParamSort = 0 then
    result := AnsiCompareStr(Item1.Caption, Item2.Caption)
  else if ParamSort = 1 then
    result := -AnsiCompareStr(Item1.Caption, Item2.Caption)
end;

function CustomSortSubItem1(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
  if ParamSort = 0 then
    result := AnsiCompareStr(Item1.SubItems.Strings[0], Item2.SubItems.Strings[0])
  else if ParamSort = 1 then
    result := -AnsiCompareStr(Item1.SubItems.Strings[0], Item2.SubItems.Strings[0])
end;

function CustomSortSubItem2(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall;
begin
  if ParamSort = 0 then
    result := AnsiCompareStr(Item1.SubItems.Strings[1], Item2.SubItems.Strings[1])
  else if ParamSort = 1 then
    result := -AnsiCompareStr(Item1.SubItems.Strings[1], Item2.SubItems.Strings[1])
end;

procedure TFrmSelectFromData.lvSelectColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if Column = lvSelect.Columns[0] then
  begin
    if SortType[0] = 0 then
      lvSelect.CustomSort(@CustomSortCaption, 0)
    else if SortType[0] = 1 then
      lvSelect.CustomSort(@CustomSortCaption, 1);
    SortType[0] := abs(SortType[0] - 1);
  end
  else if Column = lvSelect.Columns[1] then
  begin
    if SortType[1] = 0 then
      lvSelect.CustomSort(@CustomSortSubItem1, 0)
    else if SortType[1] = 1 then
      lvSelect.CustomSort(@CustomSortSubItem1, 1);
    SortType[1] := abs(SortType[1] - 1);
  end
  else if Column = lvSelect.Columns[2] then
  begin
    if SortType[2] = 0 then
      lvSelect.CustomSort(@CustomSortSubItem2, 0)
    else if SortType[2] = 1 then
      lvSelect.CustomSort(@CustomSortSubItem2, 1);
    SortType[2] := abs(SortType[2] - 1);
  end;
end;

procedure TFrmSelectFromData.SetCap(const Value: String);
begin
  FCap := Value;
end;

procedure TFrmSelectFromData.SetIsGrid(const Value: Boolean);
begin
  FIsGrid := Value;
  if FIsGrid then
    grdSelect.BringToFront
  else
    grdSelect.SendToBack;  
end;

end.
