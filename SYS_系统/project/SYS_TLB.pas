unit SYS_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 2017-03-28 21:29:54 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\R9Source\产品源代码\U8前台程序(V10.4)\src10.4.1\SYS_系统\project\SYS.tlb (1)
// LIBID: {1D4AC294-C656-4F01-8F42-48EC81CBC275}
// LCID: 0
// Helpfile: 
// HelpString: SYS Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SYSMajorVersion = 1;
  SYSMinorVersion = 0;

  LIBID_SYS: TGUID = '{1D4AC294-C656-4F01-8F42-48EC81CBC275}';

  IID_ISalaryFormula: TGUID = '{FE8D7B56-EF78-4B4C-99A4-834F65A5A1F2}';
  CLASS_SalaryFormula: TGUID = '{C03BE83C-171B-4257-B14F-4207EA80F652}';
  IID_ITest: TGUID = '{8D6EC108-306B-4602-9DC4-6C258581FC76}';
  CLASS_Test: TGUID = '{3335A8B8-CDD0-471D-B93A-71885B8A2C43}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ISalaryFormula = interface;
  ISalaryFormulaDisp = dispinterface;
  ITest = interface;
  ITestDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  SalaryFormula = ISalaryFormula;
  Test = ITest;


// *********************************************************************//
// Interface: ISalaryFormula
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FE8D7B56-EF78-4B4C-99A4-834F65A5A1F2}
// *********************************************************************//
  ISalaryFormula = interface(IDispatch)
    ['{FE8D7B56-EF78-4B4C-99A4-834F65A5A1F2}']
    procedure ShowMsg(const P: WideString); safecall;
    function LBQS(const ZYDM: WideString; const LBDM: WideString; const FFND: WideString; 
                  const FFCS: WideString; const GZXM: WideString): Double; safecall;
    function AVGYEAR(const ZYDM: WideString; const FFND: WideString; const GZXM: WideString): Double; safecall;
    function ZYGZ(const ZYDM: WideString; const FFCS: WideString; const GZX: WideString): Double; safecall;
    function MXS(const signOfFFCS: WideString): Double; safecall;
  end;

// *********************************************************************//
// DispIntf:  ISalaryFormulaDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FE8D7B56-EF78-4B4C-99A4-834F65A5A1F2}
// *********************************************************************//
  ISalaryFormulaDisp = dispinterface
    ['{FE8D7B56-EF78-4B4C-99A4-834F65A5A1F2}']
    procedure ShowMsg(const P: WideString); dispid 201;
    function LBQS(const ZYDM: WideString; const LBDM: WideString; const FFND: WideString; 
                  const FFCS: WideString; const GZXM: WideString): Double; dispid 202;
    function AVGYEAR(const ZYDM: WideString; const FFND: WideString; const GZXM: WideString): Double; dispid 203;
    function ZYGZ(const ZYDM: WideString; const FFCS: WideString; const GZX: WideString): Double; dispid 204;
    function MXS(const signOfFFCS: WideString): Double; dispid 205;
  end;

// *********************************************************************//
// Interface: ITest
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8D6EC108-306B-4602-9DC4-6C258581FC76}
// *********************************************************************//
  ITest = interface(IDispatch)
    ['{8D6EC108-306B-4602-9DC4-6C258581FC76}']
    procedure Tst; safecall;
    procedure TstA(const P: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  ITestDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {8D6EC108-306B-4602-9DC4-6C258581FC76}
// *********************************************************************//
  ITestDisp = dispinterface
    ['{8D6EC108-306B-4602-9DC4-6C258581FC76}']
    procedure Tst; dispid 201;
    procedure TstA(const P: WideString); dispid 202;
  end;

// *********************************************************************//
// The Class CoSalaryFormula provides a Create and CreateRemote method to          
// create instances of the default interface ISalaryFormula exposed by              
// the CoClass SalaryFormula. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSalaryFormula = class
    class function Create: ISalaryFormula;
    class function CreateRemote(const MachineName: string): ISalaryFormula;
  end;

// *********************************************************************//
// The Class CoTest provides a Create and CreateRemote method to          
// create instances of the default interface ITest exposed by              
// the CoClass Test. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTest = class
    class function Create: ITest;
    class function CreateRemote(const MachineName: string): ITest;
  end;

implementation

uses ComObj;

class function CoSalaryFormula.Create: ISalaryFormula;
begin
  Result := CreateComObject(CLASS_SalaryFormula) as ISalaryFormula;
end;

class function CoSalaryFormula.CreateRemote(const MachineName: string): ISalaryFormula;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SalaryFormula) as ISalaryFormula;
end;

class function CoTest.Create: ITest;
begin
  Result := CreateComObject(CLASS_Test) as ITest;
end;

class function CoTest.CreateRemote(const MachineName: string): ITest;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Test) as ITest;
end;

end.
