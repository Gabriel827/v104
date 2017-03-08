object frmLockForm: TfrmLockForm
  Left = 486
  Top = 221
  Width = 339
  Height = 151
  BorderIcons = []
  Caption = #38145#23631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 30
    Top = 34
    Width = 36
    Height = 13
    Caption = #23494#30721#65306
  end
  object edtPassword: TEdit
    Left = 70
    Top = 29
    Width = 221
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    OnKeyPress = edtPasswordKeyPress
  end
  object btnYes: TButton
    Left = 216
    Top = 64
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 1
    OnClick = btnYesClick
  end
  object ClientDataSetTmp: TClientDataSet
    Aggregates = <>
    Params = <>
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 141
    Top = 51
  end
  object tmrLockForm: TTimer
    Enabled = False
    Interval = 1000000
    OnTimer = tmrLockFormTimer
    Left = 37
    Top = 59
  end
end
