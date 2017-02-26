object EBKCSSZfrm: TEBKCSSZfrm
  Left = 498
  Top = 126
  BorderStyle = bsDialog
  Caption = #21442#25968#35774#32622
  ClientHeight = 370
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object PageControl1: TPageControl
    Left = 16
    Top = 16
    Width = 473
    Height = 313
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #22522#26412#35774#32622
      object GroupBoxYSzq: TGroupBox
        Left = 14
        Top = 14
        Width = 379
        Height = 155
        Caption = #40664#35748#25903#20184#36134#25143
        TabOrder = 0
        object Label12: TLabel
          Left = 12
          Top = 49
          Width = 60
          Height = 12
          Alignment = taRightJustify
          Caption = #20184#27454#38134#34892#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object lbl1: TLabel
          Left = 12
          Top = 75
          Width = 60
          Height = 12
          Caption = #20184#27454#24080#21495#65306
        end
        object Label1: TLabel
          Left = 24
          Top = 24
          Width = 48
          Height = 12
          Alignment = taRightJustify
          Caption = #20184#27454#26041#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 12
          Top = 103
          Width = 60
          Height = 12
          Caption = #24320#25143#22320#21306#65306
        end
        object Label3: TLabel
          Left = 160
          Top = 103
          Width = 12
          Height = 12
          Caption = #30465
        end
        object Label4: TLabel
          Left = 272
          Top = 103
          Width = 12
          Height = 12
          Caption = #24066
        end
        object Label5: TLabel
          Left = 12
          Top = 129
          Width = 60
          Height = 12
          Alignment = taRightJustify
          Caption = #38134#34892#34892#21035#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object edtDFYH: TSMaskEdit
          Left = 75
          Top = 45
          Width = 194
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          LBCanUse = True
          Alignment = taLeftJustify
          DataTypePro = dpString
          DataWidth = 0
          DataDec = 0
          LoadButton = True
          OnButtonClick = edtDFYHButtonClick
          TabOrder = 0
        end
        object edtGRZH: TEdit
          Left = 75
          Top = 71
          Width = 194
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          TabOrder = 1
          Text = ' '
        end
        object edtFKR: TSMaskEdit
          Left = 75
          Top = 19
          Width = 194
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          LBCanUse = True
          Alignment = taLeftJustify
          DataTypePro = dpString
          DataWidth = 0
          DataDec = 0
          LoadButton = True
          OnButtonClick = edtFKRButtonClick
          TabOrder = 2
        end
        object edtCity: TSMaskEdit
          Left = 176
          Top = 99
          Width = 93
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          LBCanUse = True
          Alignment = taLeftJustify
          DataTypePro = dpString
          DataWidth = 0
          DataDec = 0
          LoadButton = True
          OnButtonClick = edtCityButtonClick
          TabOrder = 3
        end
        object edtProvice: TComboBox
          Left = 75
          Top = 99
          Width = 82
          Height = 20
          DropDownCount = 20
          ItemHeight = 12
          TabOrder = 4
          Items.Strings = (
            #21271#20140#24066
            #22825#27941#24066
            #27827#21271#30465
            #23665#35199#30465
            #20869#33945#21476#33258#27835#21306
            #36797#23425#30465
            #21513#26519#30465
            #40657#40857#27743#30465
            #19978#28023#24066
            #27743#33487#30465
            #27743#33487#30465
            #27993#27743#30465
            #23433#24509#30465
            #31119#24314#30465
            #27743#35199#30465
            #23665#19996#30465
            #27827#21335#30465
            #28246#21271#30465
            #28246#21335#30465
            #24191#19996#30465
            #24191#35199
            #28023#21335#30465
            #22235#24029#30465
            #37325#24198#24066
            #36149#24030#30465
            #20113#21335#30465
            #35199#34255
            #38485#35199#30465
            #29976#32899#30465
            #38738#28023#30465
            #23425#22799
            #26032#30086
            #20854#20182#30465#20221#25110#22320#21306)
        end
        object edtYHHB: TSMaskEdit
          Left = 75
          Top = 125
          Width = 194
          Height = 20
          ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
          LBCanUse = True
          Alignment = taLeftJustify
          DataTypePro = dpString
          DataWidth = 0
          DataDec = 0
          LoadButton = True
          OnButtonClick = edtYHHBButtonClick
          TabOrder = 5
        end
      end
    end
  end
  object BitBtnOK: TBitBtn
    Left = 333
    Top = 335
    Width = 75
    Height = 25
    Hint = #30830#35748#35774#32622
    Caption = #20445#23384'(&S)'
    Default = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = BitBtnOKClick
    NumGlyphs = 2
  end
  object BitBtnCancel: TBitBtn
    Left = 414
    Top = 335
    Width = 75
    Height = 25
    Hint = #21462#28040#36864#20986
    Cancel = True
    Caption = #36864#20986'(&E)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = BitBtnCancelClick
    NumGlyphs = 2
  end
end
