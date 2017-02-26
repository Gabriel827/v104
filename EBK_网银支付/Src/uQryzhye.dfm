object FormQryZHYE: TFormQryZHYE
  Left = 473
  Top = 45
  Width = 870
  Height = 500
  Caption = #36134#25143#20313#39069#26597#35810
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object SpeedBarPZNotePad: TSpeedBar
    Left = 0
    Top = 0
    Width = 854
    Height = 48
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Pitch = fpVariable
    Font.Style = []
    BoundLines = [blTop, blBottom, blLeft, blRight]
    Options = [sbAllowDrag, sbFlatBtns, sbGrayedBtns, sbTransparentBtns]
    BtnOffsetHorz = 3
    BtnOffsetVert = 3
    BtnWidth = 40
    BtnHeight = 42
    BevelOuter = bvNone
    TabOrder = 0
    InternalVer = 1
    object SpeedbarSection5: TSpeedbarSection
      Caption = 'Edit'
    end
    object SpeedbarSection2: TSpeedbarSection
      Caption = 'Run'
    end
    object SpeedbarSection1: TSpeedbarSection
      Caption = 'Exec'
    end
    object SpeedbarSection3: TSpeedbarSection
      Caption = 'Help'
    end
    object SpeedbarSection4: TSpeedbarSection
      Caption = 'Exit'
    end
    object SpeedItem_insert: TSpeedItem
      BtnCaption = #26032#21333
      BtnGrayedInactive = True
      Caption = 'SpeedItem_insert'
      Enabled = False
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D8000000CE0E0000D80E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        777777000000777777777B777777B700000077BB7888BB8888BB77000000777B
        0000000000B77700000077770FFFFFFFF0877700000077770FFFFFFFF0877700
        000077770FFFFFFFF0877700000077770FFFFFFFF087770000007BBB0FFFFFFF
        F0BB7700000077BB0FFFFFFFF0BBB700000077770FFFF0000077770000007777
        0FFFF0FF07777700000077770FFFF0F0B7777700000077770FFFF007BB777700
        0000777B000000777BB77700000077BB7777BB7777BB770000007B777777B777
        7777B7000000777777777777777777000000}
      Hint = #21046#20316#19968#24352#26032#30340#21333#25454
      Spacing = 1
      Left = 51
      Top = 3
      SectionName = 'Edit'
    end
    object SpeedItem_Preview: TSpeedItem
      BtnCaption = #39044#35272
      BtnGrayedInactive = True
      Caption = 'SpeedItem_Preview'
      Hint = #21333#25454#39044#35272'|'
      ImageIndex = 0
      Spacing = 1
      Left = 43
      Top = 3
      SectionName = 'Edit'
    end
    object SpeedItem_Print: TSpeedItem
      BtnCaption = #25171#21360
      BtnGrayedInactive = True
      Caption = 'SpeedItem_Print'
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777770000007777777777777777770000007770000000000077770000007707
        7777777707077700000070000000000000707700000070777777BBB770007700
        0000707777778887707077000000700000000000007707000000707777777777
        0707070000007700000000007070070000007770FFFFFFFF0707070000007777
        0F00000F00007700000077770FFFFFFFF07777000000777770F00000F0777700
        0000777770FFFFFFFF0777000000777777000000000777000000777777777777
        777777000000777777777777777777000000}
      Hint = #21333#25454#25171#21360
      Spacing = 1
      Left = 83
      Top = 3
      SectionName = 'Edit'
    end
    object SpeedItem_Refresh: TSpeedItem
      BtnCaption = #21047#26032
      BtnGrayedInactive = True
      Caption = #21047#26032#25968#25454
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777770000007777777777777777770000007777777000777777770000007777
        7007770077777700000077770777777707777700000077770777777770777700
        0000777077777777777777000000777077777777777777000000777077777777
        7777770000007770777777777077770000007770777777770077770000007770
        7777777000777700000077770777770000777700000077770777777700777700
        0000777770077700707777000000777777700077777777000000777777777777
        777777000000777777777777777777000000}
      Hint = #21047#26032#25968#25454
      Spacing = 1
      Left = 123
      Top = 3
      Visible = True
      OnClick = SpeedItem_RefreshClick
      SectionName = 'Run'
    end
    object SpeedItem_Filter: TSpeedItem
      BtnCaption = #31579#36873
      BtnGrayedInactive = True
      Caption = #32452#21512#26465#20214#31579#36873
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D8000000CE0E0000D80E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777770000007777777068877777770000007777777088877777770000007777
        7770688777777700000077777770688877777700000077777707887877777700
        00007777770068E87777770000007777707088EE87777700000077770700687E
        887777000000777700076877E87777000000777070708877EE87770000007770
        000068777E87770000007707070768777EE87700000077000074887777E88700
        0000700000000000000007000000777777777777777777000000777777777777
        777777000000777777777777777777000000}
      Hint = #32452#21512#26465#20214#31579#36873'|'
      Spacing = 1
      Left = 163
      Top = 3
      SectionName = 'Run'
    end
    object SpeedItem_NoFilter: TSpeedItem
      BtnCaption = #24674#22797
      BtnGrayedInactive = True
      Caption = #21462#28040#31579#36873#32467#26524
      Enabled = False
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000CE0E0000D80E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888888888888888888888888888888888888888888888888888888888
        8888888888888887088888000008888807888800008888888088880008888888
        8088880080888888808888088800888807888888888800007888888888888888
        8888888888888888888888888888888888888888888888888888}
      Hint = #21462#28040#31579#36873#32467#26524'|'
      Spacing = 1
      Left = 203
      Top = 3
      SectionName = 'Run'
    end
    object spdtmMX: TSpeedItem
      BtnCaption = #26126#32454
      BtnGrayedInactive = True
      Caption = #26126#32454
      Enabled = False
      Hint = #26126#32454'|'
      Spacing = 1
      Left = 3
      Top = 3
      Visible = True
      OnClick = spdtmMXClick
      SectionName = 'Run'
    end
    object spdtmExp: TSpeedItem
      BtnCaption = #36755#20986
      BtnGrayedInactive = True
      Caption = #36755#20986
      Hint = #36755#20986'|'
      Spacing = 1
      Left = 3
      Top = 3
      Visible = True
      OnClick = spdtmExpClick
      SectionName = 'Run'
    end
    object btnImport: TSpeedItem
      BtnCaption = #23548#20837
      BtnGrayedInactive = True
      Caption = #23548#20837
      Enabled = False
      Hint = #23548#20837'|'
      Spacing = 1
      Left = 3
      Top = 3
      SectionName = 'Exec'
    end
    object SpeedItem_auditing: TSpeedItem
      BtnCaption = #23457#26680
      BtnGrayedInactive = True
      Caption = #23457#26680
      Enabled = False
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777770000007770000000000007770000007770FFFFFFFFFF07770000007770
        FFFFFFFFFF07770000007770FFF0FFFFFF07770000007770FF010FFFFF077700
        00007770F01710FFFF0777000000777001FFF10FFF07770000007770FFFFFF10
        FF07770000007770FFFFFFF10F07770000007770FFFFFFFF1F07770000007770
        FFFFFFFFFF07770000007770FFFFFFF00007770000007770FFFFFFF0F0777700
        00007770FFFFFFF0077777000000777000000000777777000000777777777777
        777777000000777777777777777777000000}
      Hint = #23457#26680#26410#23457#21333#25454
      Spacing = 1
      Left = 243
      Top = 3
      SectionName = 'Exec'
    end
    object SpeedItem_counter_auditing: TSpeedItem
      BtnCaption = #38144#23457
      BtnGrayedInactive = True
      Caption = #38144#23457
      Enabled = False
      Hint = #38144#23457#24050#23457#21333#25454
      ImageIndex = 14
      Spacing = -2
      Left = 323
      Top = 3
      SectionName = 'Exec'
    end
    object SpeedItem_cancellation: TSpeedItem
      BtnCaption = #20316#24223
      BtnGrayedInactive = True
      Caption = #20316#24223
      Enabled = False
      Hint = #20316#24223#26410#23457#21333#25454'|'
      ImageIndex = 8
      Spacing = -2
      Left = 283
      Top = 3
      SectionName = 'Exec'
    end
    object SpeedItem_revert: TSpeedItem
      BtnCaption = #36824#21407
      BtnGrayedInactive = True
      Caption = #36824#21407
      Enabled = False
      Hint = #36824#21407#20316#24223#21333#25454'|'
      ImageIndex = 13
      Spacing = -2
      Left = 363
      Top = 3
      SectionName = 'Exec'
    end
    object SpeedItem_delete: TSpeedItem
      BtnCaption = #21024#38500
      BtnGrayedInactive = True
      Caption = #21024#38500
      Enabled = False
      Hint = #21024#38500#20316#24223#21333#25454'|'
      ImageIndex = 7
      Spacing = -2
      Left = 403
      Top = 3
      SectionName = 'Exec'
    end
    object SpeedItemHelp: TSpeedItem
      BtnCaption = #24110#21161
      BtnGrayedInactive = True
      Caption = #25171#24320#24110#21161#25991#20214
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777770000007777777CCCCC77777700000077CCCCCC707CCCCCC70000007700
        77770807777007000000770F0880F8F0880F070000007780FFFFF8FFFFF08700
        00007780FFFB99FBFFF0870000007770FFBF99BFBFF07700000077780BFBF8FB
        FB087700000077780FBF97BFBF0877000000777B0BFB990BFB0777000000777F
        B000B99000B777000000777BFBFBFB99FBF777000000777FBF99BF99BFB77700
        00007777FB99FB99FB777700000077777FB9999FB77777000000777777FBFBFB
        777777000000777777777777777777000000}
      Hint = #25171#24320#24110#21161#25991#20214'|'
      Spacing = 1
      Left = 443
      Top = 3
      SectionName = 'Help'
    end
    object SpeedItem1: TSpeedItem
      BtnCaption = #36864#20986
      BtnGrayedInactive = True
      Caption = #36864#20986
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000012000000120000000100
        040000000000D800000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777770000007777770777777777770000007777700777777777770000007777
        0607777777777700000077706607777777777700000070066600000000777700
        00007706660FF0777777770000007706600FF0777747770000007706660FF077
        7447770000007706660FF0774444470000007706660FF0744444470000007706
        660FF077444447000000770660FFF07774477700000077060FFFF07777477700
        00007700FFFFF077777777000000770000000077777777000000777777777777
        777777000000777777777777777777000000}
      Hint = #36864#20986#21333#25454#30331#35760#31807
      Spacing = 1
      Left = 483
      Top = 3
      Visible = True
      OnClick = SpeedItem1Click
      SectionName = 'Exit'
    end
  end
  object PanelTitle: TPanel
    Left = 0
    Top = 48
    Width = 854
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblTitle: TRxLabel
      Left = 8
      Top = 9
      Width = 128
      Height = 20
      Caption = #36134#25143#20313#39069#26597#35810
      Font.Charset = GB2312_CHARSET
      Font.Color = 10576962
      Font.Height = -20
      Font.Name = #26999#20307'_GB2312'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 88
    Width = 854
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label19: TLabel
      Left = 20
      Top = 13
      Width = 70
      Height = 14
      Caption = #24320#25143#38134#34892#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 372
      Top = 13
      Width = 42
      Height = 14
      Caption = #26085#26399#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object cbbYH: TComboBox
      Left = 86
      Top = 10
      Width = 265
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 0
    end
    object dtpDate: TDateTimePicker
      Left = 408
      Top = 10
      Width = 129
      Height = 20
      Date = 41477.597899837960000000
      Time = 41477.597899837960000000
      TabOrder = 1
    end
  end
  object THDBGridYEB: TTHDBGrid
    Left = 0
    Top = 129
    Width = 854
    Height = 333
    ReadOnly = True
    DblEqual = True
    PassReadonly = True
    HeaderHeight = 26
    RowCount = 2
    AutoNext = False
    HighlightTextColor = clBlue
    PopAllowUpdown = False
    DefColor = clWhite
    DefColorPerRows = 2
    QuickRowSelect = False
    GridTail = False
    GridTailColor = clBlack
    GridTailHeight = 20
    Align = alClient
    DataSource = dsYEB
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgKeyAppend, dgKeyInsert]
    TabOrder = 3
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDblClick = THDBGridYEBDblClick
    ShowLock = True
    RowsHeight = 18
    Col = 1
    Row = 1
    Columns = <
      item
        FieldName = 'YHNAME'
        Title.Caption = #38134#34892#21517#31216
        DataTypePro = dpString
        DataTypeApp = daNone
        MaxColWidth = 0
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = False
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
      end
      item
        FieldName = 'YHZH'
        Title.Caption = #38134#34892#36134#21495
        DataTypePro = dpString
        DataTypeApp = daNone
        MaxColWidth = 0
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = False
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
      end
      item
        FieldName = 'YHZHMC'
        Title.Caption = #36134#21495#21517#31216
        Width = 116
        DataTypePro = dpString
        DataTypeApp = daNone
        MaxColWidth = 0
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = False
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
      end
      item
        FieldName = 'YHYE'
        Title.Caption = #36134#25143#20313#39069
        Width = 129
        DataTypePro = dpDecimal
        DataTypeApp = daNone
        MaxColWidth = 0
        DataWidth = 0
        DataDec = 2
        LoadButton = False
        Sortable = False
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
      end
      item
        FieldName = 'CXSJ'
        Title.Caption = #26597#35810#26102#38388
        DataTypePro = dpString
        DataTypeApp = daNone
        MaxColWidth = 0
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = False
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
      end>
  end
  object dsYEB: TDataSource
    DataSet = cdsYEB
    Left = 424
    Top = 240
  end
  object cdsYEB: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 536
    Top = 240
  end
  object HFExpandPrint1: THFExpandPrint
    ASprint = FormPrint1
    Left = 184
    Top = 224
  end
  object FormPrint1: TFormPrint
    OtherItems = <>
    ColumnItems = <>
    Grid = THDBGridYEB
    GridLeft = 0
    GridTop = 137
    HelpContext = 0
    Orientation = poPortrait
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    WordOffsetX = 3
    WordOffsetY = 3
    Option = [PrintGridFirstLine, PrintGridLine, ThickFrame, ThinFrame, AnyiMark, PrintOneOther]
    OffsetLeft = 0
    OffsetTop = 0
    PrintRowCount = 40
    PrintIfEmpty = False
    SnapToGrid = False
    ShowProgress = False
    Zoom = 0
    FixedCols = 0
    PrintSum = False
    PrintSumEndRow = False
    ExclusionRecord = 0
    CalcFilterColID = 0
    Left = 488
    Top = 165
  end
end
