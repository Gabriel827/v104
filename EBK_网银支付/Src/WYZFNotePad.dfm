object FormWYZFNotePad: TFormWYZFNotePad
  Left = 170
  Top = 97
  Width = 974
  Height = 526
  Caption = #32593#38134#25903#20184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTitle: TPanel
    Left = 0
    Top = 48
    Width = 958
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblTitle: TRxLabel
      Left = 8
      Top = 9
      Width = 149
      Height = 20
      Caption = #32593#38134#25903#20184#30331#35760#34180
      Font.Charset = GB2312_CHARSET
      Font.Color = 10576962
      Font.Height = -20
      Font.Name = #26999#20307'_GB2312'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 88
    Width = 958
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object LabelQZRQ: TLabel
      Left = 11
      Top = 53
      Width = 52
      Height = 13
      Caption = #36215#27490#26085#26399
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label1: TLabel
      Left = 184
      Top = 53
      Width = 9
      Height = 13
      Alignment = taRightJustify
      Caption = '---'
    end
    object Label3: TLabel
      Left = 321
      Top = 53
      Width = 52
      Height = 13
      Caption = #32467#31639#26041#24335
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label2: TLabel
      Left = 780
      Top = 53
      Width = 48
      Height = 13
      Caption = #35760#24405#25968#65306
    end
    object LabelCount: TLabel
      Left = 840
      Top = 50
      Width = 26
      Height = 16
      Caption = '-----'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label26: TLabel
      Left = 538
      Top = 51
      Width = 60
      Height = 13
      Caption = #25968#25454#26469#28304#65306
    end
    object DateTimePickerFrom: TDateTimePicker
      Left = 70
      Top = 49
      Width = 110
      Height = 20
      Date = 36057.000000000000000000
      Time = 36057.000000000000000000
      DateFormat = dfLong
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 0
      OnExit = DateTimePickerFromExit
    end
    object DateTimePickerTo: TDateTimePicker
      Left = 199
      Top = 49
      Width = 110
      Height = 20
      Date = 36057.000000000000000000
      Time = 36057.000000000000000000
      DateFormat = dfLong
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 1
      OnExit = DateTimePickerFromExit
    end
    object ComboBoxYWLX: TComboBox
      Left = 378
      Top = 49
      Width = 150
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        #20840#37096
        #36716#36134#25903#31080
        #30005#27719
        #29616#37329#25903#31080)
    end
    object GroupBox1: TGroupBox
      Left = 16
      Top = 1
      Width = 441
      Height = 41
      Caption = #36215#27490#26085#26399#31867#22411
      TabOrder = 3
      object RB_YWRQ: TRadioButton
        Left = 24
        Top = 16
        Width = 81
        Height = 17
        Caption = #19994#21153#26085#26399
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object RB_ZXSJ: TRadioButton
        Left = 128
        Top = 16
        Width = 73
        Height = 17
        Caption = #25191#34892#26085#26399
        TabOrder = 1
      end
      object RB_CLSJ: TRadioButton
        Left = 232
        Top = 16
        Width = 113
        Height = 17
        Caption = #21463#29702#26102#38388
        TabOrder = 2
      end
      object RB_ZFSJ: TRadioButton
        Left = 336
        Top = 16
        Width = 97
        Height = 17
        Caption = #25903#20184#26085#26399
        TabOrder = 3
      end
    end
    object ComboBoxSJLY: TComboBox
      Left = 608
      Top = 49
      Width = 158
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        #20840#37096
        #36716#36134#25903#31080
        #30005#27719
        #29616#37329#25903#31080)
    end
  end
  object SpeedBarPZNotePad: TSpeedBar
    Left = 0
    Top = 0
    Width = 958
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
    TabOrder = 2
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
      Left = 3
      Top = 3
      Visible = True
      OnClick = SpeedItem_insertClick
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
    object btnExport: TSpeedItem
      BtnCaption = #36755#20986
      BtnGrayedInactive = True
      Caption = #36755#20986
      Hint = #36755#20986'|'
      Spacing = 1
      Left = 299
      Top = 3
      Visible = True
      OnClick = btnExportClick
      SectionName = 'Edit'
    end
    object btnZF: TSpeedItem
      BtnCaption = #20316#24223
      BtnGrayedInactive = True
      Caption = #20316#24223
      Enabled = False
      Hint = #20316#24223'|'
      Spacing = 1
      Left = 347
      Top = 3
      Visible = True
      OnClick = btnZFClick
      SectionName = 'Edit'
    end
    object btnDel: TSpeedItem
      BtnCaption = #21024#38500
      BtnGrayedInactive = True
      Caption = #21024#38500
      Enabled = False
      Hint = #21024#38500'|'
      Spacing = 1
      Left = 395
      Top = 3
      Visible = True
      OnClick = btnDelClick
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
      Visible = True
      OnClick = SpeedItem_FilterClick
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
      Visible = True
      OnClick = SpeedItem_NoFilterClick
      SectionName = 'Run'
    end
    object btnSelect: TSpeedItem
      BtnCaption = #20840#36873
      BtnGrayedInactive = True
      Caption = #20840#36873
      Hint = #20840#36873'|'
      Spacing = 1
      Left = 67
      Top = 3
      Visible = True
      OnClick = btnSelectClick
      SectionName = 'Run'
    end
    object btnSH: TSpeedItem
      BtnCaption = #23457#26680
      BtnGrayedInactive = True
      Caption = #23457#26680
      Hint = #23457#26680'|'
      Spacing = 1
      Left = 243
      Top = 3
      Visible = True
      OnClick = btnSHClick
      SectionName = 'Run'
    end
    object btnImport: TSpeedItem
      BtnCaption = #23548#20837
      BtnGrayedInactive = True
      Caption = #23548#20837
      DropDownMenu = pmImport
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
      Visible = True
      SectionName = 'Help'
    end
    object SpeedItem1: TSpeedItem
      BtnCaption = #36864#20986
      BtnGrayedInactive = True
      Caption = 'SpeedItemExit'
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
  object TabSetDJZT: TTabSet
    Left = 0
    Top = 467
    Width = 958
    Height = 21
    Align = alBottom
    BackgroundColor = 13160660
    DitherBackground = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    SelectedColor = clYellow
    Tabs.Strings = (
      #25152#26377#21333#25454
      #26410#23457#26680' '
      #24050#21021#23457
      #24050#22797#23457
      #24050#25191#34892
      #24050#25903#20184' '
      #25903#20184#22833#36133
      #24050#20316#24223)
    TabIndex = 0
    OnChange = TabSetDJZTChange
  end
  object THDBGridWYZF: TTHDBGrid
    Left = 0
    Top = 169
    Width = 958
    Height = 298
    ReadOnly = True
    DblEqual = True
    PassReadonly = True
    HeaderHeight = 50
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
    DataSource = DataSourceWYZF
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgKeyAppend, dgKeyInsert]
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = THDBGridWYZFDblClick
    ShowLock = True
    RowsHeight = 18
    Col = 1
    Row = 1
  end
  object ClientDataSetWYZF: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ProviderPub'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 96
    Top = 216
  end
  object DataSourceWYZF: TDataSource
    DataSet = ClientDataSetWYZF
    Left = 96
    Top = 272
  end
  object THFilterWYZF: TTHFilter
    GridCols = <
      item
        Width = 80
        Caption = #32534#21495
        AutoEnter = False
        ColName = 'ZFID'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #19994#21153#26085#26399
        AutoEnter = False
        ColName = 'YWRQ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #19994#21153#31867#22411
        AutoEnter = False
        ColName = 'YWLX'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #20973#35777#21495
        AutoEnter = False
        ColName = 'PZH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #20184#27454#26041'.'#36134#25143
        AutoEnter = False
        ColName = 'FKFZH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #20184#27454#26041'.'#21517#31216
        AutoEnter = False
        ColName = 'FKFMC'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #20184#27454#26041'.'#38134#34892#36134#21495
        AutoEnter = False
        ColName = 'FYHZH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #20184#27454#26041'.'#36134#25143#21517#31216
        AutoEnter = False
        ColName = 'FZHMC'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #20184#27454#26041'.'#24320#25143#38134#34892
        AutoEnter = False
        ColName = 'FKHYH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #20184#27454#26041'.'#38134#34892#34892#21495
        AutoEnter = False
        ColName = 'FYHHH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #20184#27454#26041'.'#38134#34892#34892#21035
        AutoEnter = False
        ColName = 'FYHHB'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #20184#27454#26041'.'#24320#25143#22320#21306
        AutoEnter = False
        ColName = 'FKHDQ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #25910#27454#26041'.'#36134#25143
        AutoEnter = False
        ColName = 'SKFZH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #25910#27454#26041'.'#21517#31216
        AutoEnter = False
        ColName = 'SKFMC'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #25910#27454#26041'.'#38134#34892#36134#21495
        AutoEnter = False
        ColName = 'SYHZH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #25910#27454#26041'.'#36134#25143#21517#31216
        AutoEnter = False
        ColName = 'SZHMC'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #25910#27454#26041'.'#24320#25143#38134#34892
        AutoEnter = False
        ColName = 'SKHYH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #25910#27454#26041'.'#38134#34892#34892#21495
        AutoEnter = False
        ColName = 'SYHHH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #25910#27454#26041'.'#24320#25143#22320#21306
        AutoEnter = False
        ColName = 'SKHDQ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 150
        Caption = #25688#35201
        AutoEnter = False
        ColName = 'ZY'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Alignment = taRightJustify
        Width = 100
        Caption = #37329#39069
        AutoEnter = False
        ColName = 'JE'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpCurrency
        DataTypeApp = daNone
        DataWidth = 20
        DataDec = 2
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 66
        Caption = #29366#24577
        AutoEnter = False
        ColName = 'DJSTATUS'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #24405#20837#20154
        AutoEnter = False
        ColName = 'LRR'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #24405#20837#26102#38388
        AutoEnter = False
        ColName = 'LRSJ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #23457#26680#20154
        AutoEnter = False
        ColName = 'SHR'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #23457#26680#26102#38388
        AutoEnter = False
        ColName = 'SHSJ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #21021#23457#20154
        AutoEnter = False
        ColName = 'SHR1'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #21021#23457#26102#38388
        AutoEnter = False
        ColName = 'SHSJ1'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #22797#23457#20154
        AutoEnter = False
        ColName = 'SHR2'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #22797#23457#26102#38388
        AutoEnter = False
        ColName = 'SHSJ2'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #25191#34892#20154
        AutoEnter = False
        ColName = 'ZXR'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #25191#34892#26102#38388
        AutoEnter = False
        ColName = 'ZXSJ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #21463#29702#26102#38388
        AutoEnter = False
        ColName = 'CLSJ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 100
        Caption = #22788#29702#20449#24687
        AutoEnter = False
        ColName = 'CLXX'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #21463#29702#29366#24577
        AutoEnter = False
        ColName = 'SLZT'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #21407#25903#20184#20132#26131#27969#27700#21495
        AutoEnter = False
        ColName = 'BUSIUQNO'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Microsoft YaHei UI'
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Microsoft YaHei UI'
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #25903#20184#26102#38388
        AutoEnter = False
        ColName = 'ZFSJ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #25903#20184#29366#24577
        AutoEnter = False
        ColName = 'ZFZT'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 100
        Caption = #25903#20184#20449#24687
        AutoEnter = False
        ColName = 'ZFXX'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #21407#21333#25454#32534#21495
        AutoEnter = False
        ColName = 'YDJBH'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #21407#21333#25454#26085#26399
        AutoEnter = False
        ColName = 'YDJSJ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #23457#26680#27969#33410#28857'.'#24050#25191#34892
        AutoEnter = False
        ColName = 'CurSHJDMC'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #23457#26680#27969#33410#28857'.'#24453#25191#34892
        AutoEnter = False
        ColName = 'NextSHJDMC'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #24494#36719#38597#40657
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #38134#34892#21807#19968#21495
        AutoEnter = False
        ColName = 'BANKUQNO'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Microsoft YaHei UI'
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Microsoft YaHei UI'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #20027#20132#26131#27969#27700#21495
        AutoEnter = False
        ColName = 'HEADBUSIUQNO'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpString
        DataTypeApp = daNone
        DataWidth = 0
        DataDec = 0
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Microsoft YaHei UI'
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Microsoft YaHei UI'
        TitleFont.Style = []
      end>
    UseOnFilterRecord = False
    GridItems = <>
    LeftCols = 2
    UseFormName = False
    OnFilter = THFilterWYZFFilter
    Left = 96
    Top = 336
  end
  object pmImport: TPopupMenu
    Left = 224
    Top = 208
    object miOER: TMenuItem
      Caption = #25253#38144#21333
    end
    object miSalary: TMenuItem
      Caption = #34218#36164
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miExcel: TMenuItem
      Caption = 'Excel'#25991#20214
      OnClick = miExcelClick
    end
  end
  object ExpandPrint1: TExpandPrint
    ASPrint = SPrint
    APrintEmpty = False
    APrintEmptySet = False
    Left = 336
    Top = 214
  end
  object SPrint: TSPrint
    OtherItems = <
      item
        AutoFontSize = False
        Left = 20
        Top = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -24
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptTitle
        Caption = #39033#30446#36164#26009
      end
      item
        AutoFontSize = False
        Left = 0
        Top = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptPageNumber
      end
      item
        AutoFontSize = False
        Left = 0
        Top = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptDate
        Caption = #25171#21360#26102#38388#65306
      end
      item
        AutoFontSize = False
        Left = 0
        Top = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptPrintMan
        Caption = #25171#21360#20154#65306
      end
      item
        AutoFontSize = False
        Left = 0
        Top = 0
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptCompany
        Caption = #21333#20301#65306
      end>
    ColumnItems = <
      item
        AutoFontSize = True
        Alignment = paLeft
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        CaptionFont.Charset = DEFAULT_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -11
        CaptionFont.Name = 'MS Sans Serif'
        CaptionFont.Style = []
        Width = 64
      end>
    Grid = THDBGridWYZF
    GridTop = 169
    HelpContext = 0
    Page.Columns = 1
    Page.Orientation = poPortrait
    Page.PaperSize = A4
    Page.Values = (
      100.000000000000000000
      2970.000000000000000000
      100.000000000000000000
      2100.000000000000000000
      100.000000000000000000
      100.000000000000000000
      0.000000000000000000)
    Units = MM
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    WordOffsetX = 3
    WordOffsetY = 3
    OffsetLeft = 0
    OffsetTop = 0
    PrintRowCount = 48
    PrintIfEmpty = False
    ReportTitle = #39033#30446#20195#30721
    SnapToGrid = False
    ShowProgress = False
    AutoPosition = False
    FixedCols = 0
    TDEnabled = False
    Left = 304
    Top = 296
  end
end
