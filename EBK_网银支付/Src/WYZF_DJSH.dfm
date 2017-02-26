object FrmWYZF_DJSH: TFrmWYZF_DJSH
  Left = 396
  Top = 235
  BorderStyle = bsDialog
  Caption = #21333#25454#23457#26680
  ClientHeight = 258
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 12
  object pnlClient: TPanel
    Left = 0
    Top = 17
    Width = 538
    Height = 241
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Bevel1: TBevel
      Left = 11
      Top = 190
      Width = 513
      Height = 3
    end
    object BitBtnOK: TBitBtn
      Left = 136
      Top = 204
      Width = 75
      Height = 25
      Caption = #30830#23450
      Default = True
      TabOrder = 0
      OnClick = BitBtnOKClick
    end
    object BitBtnCancel: TBitBtn
      Left = 316
      Top = 204
      Width = 75
      Height = 25
      Caption = #21462#28040
      TabOrder = 1
      OnClick = BitBtnCancelClick
    end
    object pnlInfo: TPanel
      Left = 20
      Top = 8
      Width = 496
      Height = 174
      BevelInner = bvLowered
      TabOrder = 2
      object Label1: TLabel
        Left = 2
        Top = 2
        Width = 492
        Height = 14
        Align = alTop
        Caption = #21150#29702#24847#35265#65306
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object MemoYJ: TMemo
        Left = 2
        Top = 16
        Width = 492
        Height = 116
        Align = alClient
        Lines.Strings = (
          #36890#36807)
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object grpSH: TGroupBox
        Left = 2
        Top = 132
        Width = 492
        Height = 40
        Align = alBottom
        TabOrder = 1
        object RadioButtonTG: TRadioButton
          Left = 60
          Top = 14
          Width = 108
          Height = 17
          Caption = #36890#36807
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = RadioButtonTGClick
        end
        object RadioButtonTHSYB: TRadioButton
          Left = 192
          Top = 14
          Width = 108
          Height = 17
          Caption = #36864#22238#21040#19978#19968#27493
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = RadioButtonTGClick
        end
        object RadioButtonTHBZR: TRadioButton
          Left = 324
          Top = 14
          Width = 108
          Height = 17
          Caption = #36864#22238#21040#32534#21046#20154
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -14
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = RadioButtonTGClick
        end
      end
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 538
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
  end
end
