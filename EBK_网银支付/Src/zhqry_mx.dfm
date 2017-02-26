object FormZHQry_MX: TFormZHQry_MX
  Left = 345
  Top = 117
  Width = 818
  Height = 566
  Caption = #36134#25143#20132#26131#26126#32454#20449#24687#26597#35810
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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object SpeedBarBM: TSpeedBar
    Left = 0
    Top = 0
    Width = 802
    Height = 52
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
    BtnHeight = 38
    BevelOuter = bvNone
    TabOrder = 0
    InternalVer = 1
    object SpeedbarSectionFile: TSpeedbarSection
      Caption = 'File'
    end
    object SpeedbarSectionEdit: TSpeedbarSection
      Caption = 'Edit'
    end
    object SpeedbarSectionRun: TSpeedbarSection
      Caption = 'Run'
    end
    object SpeedbarSectionExit: TSpeedbarSection
      Caption = 'Exit'
    end
    object SpeedItemPreview: TSpeedItem
      BtnCaption = #39044#35272
      BtnGrayedInactive = True
      Caption = #25171#21360#39044#35272
      Hint = #25171#21360#39044#35272
      ImageIndex = 0
      Spacing = 1
      Left = 3
      Top = 3
      SectionName = 'File'
    end
    object SpeedItemPrint: TSpeedItem
      BtnCaption = #25171#21360
      BtnGrayedInactive = True
      Caption = #25171#21360
      Hint = #25171#21360
      ImageIndex = 1
      Spacing = 1
      Left = 43
      Top = 3
      SectionName = 'File'
    end
    object SpeedItemExport: TSpeedItem
      BtnCaption = #36755#20986
      BtnGrayedInactive = True
      Caption = #36755#20986
      Hint = #36755#20986'|'
      Spacing = 1
      Left = 51
      Top = 3
      Visible = True
      OnClick = SpeedItemExportClick
      SectionName = 'Edit'
    end
    object btnNETSearch: TSpeedItem
      BtnCaption = #32593#38134#26597#35810
      BtnGrayedInactive = True
      Caption = #32593#38134#26597#35810
      Hint = #32593#38134#26597#35810'|'
      Spacing = 1
      Left = 147
      Top = 3
      Visible = True
      OnClick = btnNETSearchClick
      SectionName = 'Edit'
    end
    object SpeedItemRefresh: TSpeedItem
      BtnCaption = #21047#26032
      BtnGrayedInactive = True
      Caption = #21047#26032#25968#25454
      Hint = #21047#26032#25968#25454'|'
      ImageIndex = 5
      Spacing = 1
      Left = 11
      Top = 3
      Visible = True
      OnClick = SpeedItemRefreshClick
      SectionName = 'Run'
    end
    object SpeedItem1: TSpeedItem
      BtnCaption = #31579#36873
      BtnGrayedInactive = True
      Caption = #31579#36873
      Hint = #31579#36873'|'
      Spacing = 1
      Left = 91
      Top = 3
      Visible = True
      OnClick = SpeedItem1Click
      SectionName = 'Run'
    end
    object SpeedItemExit: TSpeedItem
      BtnCaption = #36864#20986
      BtnGrayedInactive = True
      Caption = #36864#20986
      Hint = #36864#20986
      ImageIndex = 9
      Spacing = 1
      Left = 251
      Top = 3
      Visible = True
      OnClick = SpeedItemExitClick
      SectionName = 'Exit'
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 88
    Width = 802
    Height = 62
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 395
      Top = 14
      Width = 234
      Height = 12
      Caption = #20132#26131#26102#38388#65306'                           --'
    end
    object lblRecordcount: TLabel
      Left = 9
      Top = 38
      Width = 56
      Height = 14
      Caption = #35760#24405#25968#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbljfhjje: TLabel
      Left = 189
      Top = 38
      Width = 98
      Height = 14
      Caption = #20511#26041#21512#35745#37329#39069#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object lbldfhjje: TLabel
      Left = 434
      Top = 38
      Width = 98
      Height = 14
      Caption = #36151#26041#21512#35745#37329#39069#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label19: TLabel
      Left = 20
      Top = 13
      Width = 70
      Height = 14
      Caption = #38134#34892#36134#25143#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object DateTimePickerB: TDateTimePicker
      Left = 455
      Top = 10
      Width = 157
      Height = 20
      Date = 40753.655210312500000000
      Time = 40753.655210312500000000
      DateFormat = dfLong
      TabOrder = 0
      OnChange = DateTimePickerBChange
    end
    object DateTimePickerE: TDateTimePicker
      Left = 634
      Top = 10
      Width = 157
      Height = 20
      Date = 40753.655210312500000000
      Time = 40753.655210312500000000
      DateFormat = dfLong
      TabOrder = 1
      OnChange = DateTimePickerBChange
    end
    object grp1: TGroupBox
      Left = 844
      Top = 3
      Width = 137
      Height = 50
      Caption = #21047#26032#25968#25454#26469#28304
      TabOrder = 2
      Visible = False
      object rbFromLocal: TRadioButton
        Left = 16
        Top = 19
        Width = 48
        Height = 17
        Caption = #26412#22320
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object rbFromBank: TRadioButton
        Left = 77
        Top = 19
        Width = 47
        Height = 17
        Caption = #38134#34892
        TabOrder = 1
      end
    end
    object CEJFHJJE: TCurrencyEdit
      Left = 284
      Top = 39
      Width = 143
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      DisplayFormat = ',0.00;-,0.00'
      Enabled = False
      TabOrder = 3
    end
    object CEDJHJJE: TCurrencyEdit
      Left = 531
      Top = 39
      Width = 161
      Height = 17
      AutoSize = False
      BorderStyle = bsNone
      DisplayFormat = ',0.00;-,0.00'
      Enabled = False
      TabOrder = 4
    end
    object EDRecordCount: TEdit
      Left = 64
      Top = 38
      Width = 113
      Height = 16
      BiDiMode = bdRightToLeft
      BorderStyle = bsNone
      Enabled = False
      ParentBiDiMode = False
      TabOrder = 5
    end
    object cbbYH: TComboBox
      Left = 86
      Top = 10
      Width = 299
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 6
      OnChange = cbbYHChange
    end
  end
  object THDBGridData: TTHDBGrid
    Left = 0
    Top = 253
    Width = 802
    Height = 275
    ReadOnly = False
    DblEqual = True
    PassReadonly = True
    HeaderHeight = 26
    RowCount = 2
    AutoNext = False
    HighlightTextColor = clBlue
    PopAllowUpdown = False
    DefColor = clWhite
    DefColorPerRows = 2
    GridTail = False
    GridTailColor = clBlack
    GridTailHeight = 20
    Align = alClient
    DataSource = dsYHZH
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgKeyAppend, dgKeyInsert]
    TabOrder = 2
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    ShowLock = False
    RowsHeight = 18
    Col = 1
    Row = 1
  end
  object PanelTitle: TPanel
    Left = 0
    Top = 52
    Width = 802
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object lblTitle: TRxLabel
      Left = 2
      Top = 11
      Width = 170
      Height = 20
      Caption = #36134#25143#20132#26131#26126#32454#26597#35810
      Font.Charset = GB2312_CHARSET
      Font.Color = 10576962
      Font.Height = -20
      Font.Name = #26999#20307'_GB2312'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 150
    Width = 802
    Height = 103
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
    DesignSize = (
      802
      103)
    object GroupBox1: TGroupBox
      Left = 17
      Top = 5
      Width = 688
      Height = 88
      Anchors = [akLeft, akTop, akBottom]
      Caption = #21015#34920#31579#36873#26465#20214
      TabOrder = 0
      object Label11: TLabel
        Left = 159
        Top = 27
        Width = 60
        Height = 12
        Alignment = taRightJustify
        Caption = #21457#29983#39069#20174#65306
      end
      object Label12: TLabel
        Left = 23
        Top = 59
        Width = 84
        Height = 12
        Alignment = taRightJustify
        Caption = #20184#26041#21333#20301#21517#31216#65306
      end
      object Label2: TLabel
        Left = 332
        Top = 59
        Width = 84
        Height = 12
        Alignment = taRightJustify
        Caption = #25910#26041#21333#20301#21517#31216#65306
      end
      object lbl1: TLabel
        Left = 45
        Top = 27
        Width = 60
        Height = 12
        Alignment = taRightJustify
        Caption = #20511#36151#26041#21521#65306
      end
      object lbl2: TLabel
        Left = 396
        Top = 27
        Width = 24
        Height = 12
        Alignment = taRightJustify
        Caption = #21040#65306
      end
      object Label3: TLabel
        Left = 531
        Top = 27
        Width = 120
        Height = 12
        Alignment = taRightJustify
        Caption = #27880#65306#38646#20026#31354#20540#65292#21363#19981#38480
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object ED_FFDWMC: TEdit
        Left = 105
        Top = 53
        Width = 216
        Height = 20
        TabOrder = 0
      end
      object ED_SFDWMC: TEdit
        Left = 419
        Top = 53
        Width = 234
        Height = 20
        TabOrder = 1
      end
      object CB_JDFX: TComboBox
        Left = 105
        Top = 23
        Width = 45
        Height = 20
        Style = csDropDownList
        ItemHeight = 12
        TabOrder = 2
        Items.Strings = (
          #20511
          #36151)
      end
      object ED_JEFrom: TCurrencyEdit
        Left = 216
        Top = 23
        Width = 104
        Height = 22
        AutoSize = False
        DisplayFormat = ',0.00;-,0.00'
        TabOrder = 3
      end
      object ED_JETo: TCurrencyEdit
        Left = 418
        Top = 23
        Width = 122
        Height = 22
        AutoSize = False
        DisplayFormat = ',0.00;-,0.00'
        TabOrder = 4
      end
    end
    object Button1: TButton
      Left = 712
      Top = 64
      Width = 65
      Height = 25
      Caption = #31579#36873#21015#34920
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object cdsYHZH: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 360
  end
  object dsYHZH: TDataSource
    DataSet = cdsYHZH
    Left = 200
    Top = 296
  end
  object IdHTTP: TIdHTTP
    AuthRetries = 0
    AuthProxyRetries = 0
    AllowCookies = False
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLanguage = 'GBK'
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentRangeInstanceLength = 0
    Request.ContentType = 'application/x-www-form-urlencoded'
    Request.CustomHeaders.Strings = (
      'contentName="reqData"')
    Request.Accept = 'text/html, */*'
    Request.AcceptCharSet = 'GBK'
    Request.AcceptEncoding = 'gzip, deflate'
    Request.BasicAuthentication = True
    Request.UserAgent = 'HTTP Transparent'
    HTTPOptions = []
    Left = 592
    Top = 29
  end
  object HFExpandPrint1: THFExpandPrint
    ASprint = FormPrint1
    Left = 464
    Top = 432
  end
  object FormPrint1: TFormPrint
    OtherItems = <>
    ColumnItems = <>
    Grid = THDBGridData
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
    Left = 520
    Top = 349
  end
  object THFilterZH: TTHFilter
    GridCols = <
      item
        Width = 50
        Caption = #20132#26131#26085#26399
        AutoEnter = False
        ColName = 'trans_date'
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
        Caption = #20132#26131#26102#38388
        AutoEnter = False
        ColName = 'trans_time'
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
        ColName = 'check_num'
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
        Caption = #25688#35201
        AutoEnter = False
        ColName = 'trans_abstr'
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
        Caption = #29992#36884
        AutoEnter = False
        ColName = 'nusage'
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
        Caption = #20184#27454#26041#21517#31216
        AutoEnter = False
        ColName = 'dbtdwmc'
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
        Caption = #20184#26041#36134#21495
        AutoEnter = False
        ColName = 'dbtacc'
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
        Caption = #25910#27454#26041#21517#31216
        AutoEnter = False
        ColName = 'crtdwmc'
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
        Caption = #25910#26041#36134#21495
        AutoEnter = False
        ColName = 'crtacc'
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
        Caption = #20511#36151
        AutoEnter = False
        ColName = 'JD'
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
        Caption = #20511#26041#21457#29983#39069
        AutoEnter = False
        ColName = 'jfje'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpCurrency
        DataTypeApp = daNone
        DataWidth = 100
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
        Alignment = taRightJustify
        Width = 100
        Caption = #36151#26041#21457#29983#39069
        AutoEnter = False
        ColName = 'dfje'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpCurrency
        DataTypeApp = daNone
        DataWidth = 100
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
        Alignment = taRightJustify
        Width = 150
        Caption = #36134#25143#20313#39069
        AutoEnter = False
        ColName = 'YE'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftUnknown
        DataTypePro = dpCurrency
        DataTypeApp = daNone
        DataWidth = 150
        DataDec = 2
        LoadButton = False
        Sortable = True
        ColColor = clBlack
        CheckBox = False
        PopDateAllowed = False
        PopComboBoxAllowed = False
        CalcMode = ccUser
        CodeIndent = '  '
        ShowZero = True
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
        Caption = #19994#21153#31181#31867
        AutoEnter = False
        ColName = 'trans_type'
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
      end>
    UseOnFilterRecord = False
    GridItems = <>
    LeftCols = 2
    UseFormName = False
    OnFilter = THFilterZHFilter
    Left = 288
    Top = 280
  end
  object cdsTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 400
  end
end
