unit PLAT_HtmlLink;

interface
uses PLAT_QuickLink,Classes,PLAT_utils,Sysutils;
type
THtmlLink=class(TQuickLink)
    private
        FHref:String;
        FHead: String;
        procedure SetHRef(const Value: String);
        procedure SetHead(const Value: String);
        
        procedure WebBrowserDocumentComplete(Sender: TObject;
          const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowserTitleChange(Sender: TObject;
      const Text: WideString);
    procedure WebBrowserBeforeNavigate2(Sender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    public
        procedure Execute;override;
        procedure LoadFromStream(Stream:TStream);override;
        procedure SaveToStream(Stream:TStream);override;
        property  HRef:String read FHRef write SetHRef;
        property  Head:String read FHead write SetHead;
        constructor Create( Head,Href: String);
end;


implementation

uses ShellAPI,Forms,Windows,comctrls,shdocvw,Controls;
{ THtmlLink }

procedure THtmlLink.Execute;
var Sheet:TTabSheet;
bs:TWebBrowser;
begin
    {
    Sheet:=TTabSheet.Create (Application.MainForm);
    Sheet.PageControl :=FormMain.PageControl1;
    Sheet.Parent:=FormMain.PageControl1;
    Sheet.Align :=alClient;
    Sheet.Caption:=Head;
     }


    bs:=TWebBrowser.Create(Application.MainForm);
    Sheet.InsertControl (bs);
    bs.Align :=alClient;
    bs.Navigate(WideString(HRef));
    bs.OnTitleChange := WebBrowserTitleChange;
    bs.OnDocumentComplete := WebBrowserDocumentComplete;
    with (Sheet.Parent as TPageControl)   do
    begin
        ActivePageIndex :=PageCount -1;
    end;


  //ShellExecute( Application.handle,'OPEN',PChar(DocumentName),'','',SW_SHOWMAXIMIZED	);
end;

procedure THtmlLink.LoadFromStream(Stream:TStream);
var szData:String;
begin
    inherited;
    TUtils.LoadStringFromStream (Stream,szData);

    //Pub
    Tutils.LoadStringFromStream (Stream,FCaption);
    TUtils.LoadStringFromStream(Stream,FDescription);
    Stream.Read(FLeft,SizeOf(FLeft));
    Stream.Read (FTop,SizeOf(FTop));

    TUtils.LoadStringFromStream(Stream,FHead);
    TUtils.LoadStringFromStream(Stream,FHref);


end;

procedure THtmlLink.SaveToStream(Stream:TStream);
var i:Integer;
szData:String;
begin
    szData:=self.ClassName ;
    TUtils.SaveStringToStream (Stream,szData);

    //pub start
    Tutils.SaveStringToStream (Stream,FCaption);
    TUtils.SaveStringToStream(Stream,FDescription);
    Stream.Write(FLeft,SizeOf(FLeft));
    Stream.Write (FTop,SizeOf(FTop));
    //pub start

    TUtils.SaveStringToStream(Stream,FHead);
    TUtils.SaveStringToStream(Stream,FHref);


end;



procedure THtmlLink.SetHead(const Value: String);
begin
  FHead := Value;
end;

procedure THtmlLink.SetHRef(const Value: String);
begin
    FHRef:=Value;
end;




procedure THtmlLink.WebBrowserDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
    (Sender as TWebBrowser).OnBeforeNavigate2 :=WebBrowserBeforeNavigate2;
    (Sender as TWebBrowser).OnDocumentComplete:=nil;
end;

procedure THtmlLink.WebBrowserTitleChange(Sender: TObject;
  const Text: WideString);
begin

    ((Sender as TWinControl).Parent as TTabSheet).Caption:=Text;

end;


procedure THtmlLink.WebBrowserBeforeNavigate2(Sender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var htmllink:THtmlLink;
begin
     if uppercase(URL)=uppercase(ExtractFilePath(application.exename)+'Client.htm') then exit;
    if Pos('GRPREQUEST',Uppercase(URL)) >0then
    begin
        //ExecuteGRPRequest(ExtractFileName(URL));
        Cancel:=true;
    end
    else
    begin
        With THtmlLink.Create(Headers,URL) do
        begin
            Execute;
        end;
        Cancel:=true;
    end;
end;

constructor THtmlLink.Create(Head,Href : String);
begin
    self.FHref:=Href;
    self.FHead :=Head;
end;

end.
