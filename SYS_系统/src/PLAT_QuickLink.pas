unit PLAT_QuickLink;
//����һ��������,��Ҫʵ����

interface
uses windows, Graphics, Classes, buttons;
type
  TQuickLink = class
  protected
    FLeft: Integer;
    FTop: Integer;
    FCaption: string;
    FDescription: string;
    FIcon: HIcon;
    FPNodeCaption: string; //������¼��ǰ�����ϼ����ı�����Ϣ  Hany an  2006.01.13
    FPModCode: string; // ������ 2011.11.10 �������浱ǰ��ݷ�ʽ��Ӧ�˵���ģ�����ơ�
  private
    procedure SetCaption(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetIcon(const Value: HIcon);
    procedure SetLeft(const Value: Integer);
    procedure SetTop(const Value: Integer);
  public
    procedure Execute; virtual; abstract;
    procedure LoadFromStream(stream: TStream); virtual; abstract;
    procedure SaveToStream(Stream: TStream); virtual; abstract;
    procedure UpdateLinker(Linker: TObject); virtual;
    property Caption: string read FCaption write SetCaption;
    property Icon: HIcon read FIcon write SetIcon;
    property Description: string read FDescription write SetDescription;
    property Left: Integer read FLeft write SetLeft;
    property Top: Integer read FTop write SetTop;
    //������¼��ǰ�����ϼ����ı�����Ϣ��һ������  Hany an  2006.01.13
    property PNodeCaption: string read FPNodeCaption write FPNodeCaption;
    // ������ 2011.11.10 �������浱ǰ��ݷ�ʽ��Ӧ�˵���ģ�����ơ�
    property PModCode: string read FPModCode write FPModCode;

  end;

implementation

{ TQuickLink }
uses PLAT_QuickLinker;

procedure TQuickLink.SetCaption(const Value: string);
begin
  FCaption := Value;
end;

procedure TQuickLink.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure TQuickLink.SetIcon(const Value: HIcon);
begin
  FIcon := Value;
end;

procedure TQuickLink.SetLeft(const Value: Integer);
begin
  FLeft := Value;
end;

procedure TQuickLink.SetTop(const Value: Integer);
begin
  FTop := Value;
end;

procedure TQuickLink.UpdateLinker(Linker: TObject);
begin
  if Linker is TQuickLinker then
    with (Linker as TQuickLinker) do
    begin
      //Bryan, 2004-12-15���ⲿͳһ���д���
      {if Length(self.Caption)>8 then
      begin
          Caption:=Copy(self.Caption,1,8) + #13#10 + Copy(self.Caption,9,MaxInt);
      end
      else}
      Caption := self.Caption;

    end;
end;

end.
