unit LoginSelectCZY;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, ComCtrls, Tgrids2;

type
  TfrmSelectCZY = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    THStringGrid1: TTHStringGrid;
    procedure THStringGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
    procedure AddCZYNames(const CZYNames: TStrings);
  public
    { Public declarations }
  end;

function SelectLoginCZY(const CZYNames: TStrings; var CZYID: string): Boolean;

implementation

{$R *.DFM}

function SelectLoginCZY(const CZYNames: TStrings; var CZYID: string): Boolean;
var
  frmSelectCZY: TfrmSelectCZY;
begin
  frmSelectCZY := TfrmSelectCZY.Create(nil);
  try
    frmSelectCZY.AddCZYNames(CZYNames);
    frmSelectCZY.ShowModal;
    Result := (frmSelectCZY.ModalResult = mrOK);
    if Result then
      CZYID := frmSelectCZY.THStringGrid1.Cells[0, frmSelectCZY.THStringGrid1.Row]
    else
      CZYID := '0';
  finally
    frmSelectCZY.Free;
  end;  
end;

{ TfrmSelectCZY }

procedure TfrmSelectCZY.AddCZYNames(const CZYNames: TStrings);
var
  i,ipos: Integer;
  s:string;
begin
  THStringGrid1.RowCount := CZYNames.Count + 1;
  for i := 0 to CZYNames.Count - 1 do
  begin
    s := CZYNames[i];
    ipos := Pos('|',CZYNames[i]);
    //s:=Copy(s,1,ipos-1);
    THStringGrid1.Cells[0, i + 1] := Copy(s,1,ipos-1);
    s:=Copy(s,iPos+1,Length(s)-ipos);

    ipos := Pos('|',s);
    THStringGrid1.Cells[1, i + 1] := Copy(s,1,ipos-1);
    s:=Copy(s,iPos+1,Length(s)-ipos);

    THStringGrid1.Cells[2, i + 1] := s;
    //THStringGrid1.Cells[0, i + 1] := GetShortHint(CZYNames[i]);
    //THStringGrid1.Cells[1, i + 1] := GetLongHint(CZYNames[i]);
  end;
  if THStringGrid1.RowCount > 1 then
    THStringGrid1.Row := 1;
end;

procedure TfrmSelectCZY.THStringGrid1DblClick(Sender: TObject);
begin
  OKBtn.Click;
end;

end.
