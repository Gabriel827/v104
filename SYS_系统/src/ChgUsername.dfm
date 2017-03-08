object FormXGMC: TFormXGMC
  Left = 449
  Top = 302
  BorderStyle = bsDialog
  Caption = #26356#25913#25805#20316#21592#21517#31216
  ClientHeight = 110
  ClientWidth = 235
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 24
    Width = 50
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #26032#21517#31216
  end
  object btnOk: TButton
    Left = 24
    Top = 61
    Width = 75
    Height = 25
    Caption = #30830#23450'(&O)'
    TabOrder = 1
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 136
    Top = 61
    Width = 75
    Height = 25
    Caption = #21462#28040'(&C)'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object edtNewMC: TEdit
    Left = 64
    Top = 20
    Width = 145
    Height = 21
    ImeName = #20013#25991' - QQ'#25340#38899#36755#20837#27861
    TabOrder = 0
  end
end
