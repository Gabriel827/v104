unit PLAT_DocumentLink;

interface
uses sysutils, classes, PLAT_QuickLink, PLAT_Utils;
type
  TDocumentLink = class(TQuickLink)
  private
    FDocumentName: string;
    procedure SetDocumentName(const Value: string);
  public
    constructor Create(FileName: string);
    procedure Execute; override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure UpdateLinker(Linker: TObject); override;

    property DocumentName: string read FDocumentName write SetDocumentName;
  end;

implementation

uses ShellAPI, Forms, Windows, graphics, PLAT_QuickLinker;
{ TDocumentLink }

constructor TDocumentLink.Create(FileName: string);
var
  FileTag: string;
  Ext: string;
  ico: HIcon;
  lpiIcon: Word;
begin
  inherited Create();
  DocumentName := FileName;
  {
  FileTag:=ExtractFileName(FileName);
  Ext:=ExtractFileExt(FileName);
  FileTag:=StringReplace(FileTag,Ext,'',[rfReplaceAll]);
  Caption:=FileTag;
  Ico:=ExtractAssociatedIcon(hInstance,Pchar(FileName),lpiIcon);
  self.Icon:=ico;
  }
end;

procedure TDocumentLink.Execute;
begin
  ShellExecute(Application.handle, 'OPEN', PChar(DocumentName), '', '', SW_SHOWMAXIMIZED);
end;

procedure TDocumentLink.LoadFromStream(Stream: TStream);
var
  szData: string;
begin
  inherited;
  TUtils.LoadStringFromStream(Stream, szData);

  //Pub
  Tutils.LoadStringFromStream(Stream, FCaption);
  TUtils.LoadStringFromStream(Stream, FDescription);
  Stream.Read(FLeft, SizeOf(FLeft));
  Stream.Read(FTop, SizeOf(FTop));

  TUtils.LoadStringFromStream(Stream, FDocumentName);
  SetDocumentName(FDocumentName);

end;

procedure TDocumentLink.SaveToStream(Stream: TStream);
var
  i: Integer;
  szData: string;
begin
  szData := self.ClassName;
  TUtils.SaveStringToStream(Stream, szData);

  //pub start
  Tutils.SaveStringToStream(Stream, FCaption);
  TUtils.SaveStringToStream(Stream, FDescription);
  Stream.Write(FLeft, SizeOf(FLeft));
  Stream.Write(FTop, SizeOf(FTop));
  //pub start

  TUtils.SaveStringToStream(Stream, DocumentName);

end;

procedure TDocumentLink.SetDocumentName(const Value: string);
var
  FileTag: string;
  ext: string;
  ico: HICON;
  lpiIcon: Word;
begin
  if Value = '' then
    exit;
  FDocumentName := Value;
  FileTag := ExtractFileName(Value);
  Ext := ExtractFileExt(Value);
  FileTag := StringReplace(FileTag, Ext, '', [rfReplaceAll]);
  Caption := FileTag;
  Ico := ExtractAssociatedIcon(hInstance, Pchar(FDocumentName), lpiIcon);
  self.Icon := ico;
end;

procedure TDocumentLink.UpdateLinker(Linker: TObject);
var
  FLinker: TQuickLinker;
  ico: TIcon;
begin
  inherited;
  if Linker is TQuickLinker then
    FLinker := Linker as TQuickLinker;

  FLinker.Glyph.Width := 32;
  FLinker.Glyph.Height := 32;
  ico := TIcon.Create;
  ico.Handle := Icon;
  //FLinker.Glyph.Canvas.Brush.Color:=clBackGround;
  //FLinker.Glyph.Canvas.FillRect(Rect(0,0,31,31));
  FLinker.Glyph.Canvas.Draw(0, 0, ico);
  FLinker.ChangeIconItem.Visible := false;
  ico.Free;
end;

end.
