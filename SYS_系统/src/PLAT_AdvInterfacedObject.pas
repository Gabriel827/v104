unit PLAT_AdvInterfacedObject;

interface
type
  TAdvInterfacedObject = class(TObject, IUnknown)
  public
    function MySelf: TObject;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  end;

implementation

{ TAdvInterfacedObject }

function TAdvInterfacedObject.MySelf: TObject;
begin
  Result := self;
end;

function TAdvInterfacedObject._AddRef: Integer;
begin

end;

function TAdvInterfacedObject._Release: Integer;
begin
  Result := 1;
end;

function TAdvInterfacedObject.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin

end;

end.
