object FormXSZ: TFormXSZ
  Left = 360
  Top = 165
  Width = 826
  Height = 467
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = #24207#26102#36134#65288#32508#21512#26597#35810#65289
  Color = clGray
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenuXSZ
  OldCreateOrder = False
  Position = poDefaultPosOnly
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = THDBGridXSZKeyDown
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PanelZB: TPanel
    Left = 0
    Top = 44
    Width = 810
    Height = 365
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelZB'
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object PanelMain: TPanel
      Left = 0
      Top = 0
      Width = 810
      Height = 365
      Align = alClient
      BevelOuter = bvNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object PanelTop: TPanel
        Left = 0
        Top = 0
        Width = 810
        Height = 73
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object THBevelBottomLine: TTHBevel
          Left = 184
          Top = 32
          Width = 221
          Height = 3
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Color = clGray
          LineWidth = 1
          Shape = bsDoubleLine
          Style = bsLine
        end
        object LabelQZFW: TLabel
          Left = 12
          Top = 50
          Width = 60
          Height = 12
          Alignment = taRightJustify
          Caption = #36215#27490#33539#22260#65306
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object LabelFrom: TLabel
          Left = 78
          Top = 50
          Width = 54
          Height = 12
          Caption = 'LabelFrom'
        end
        object LabelSJ: TLabel
          Left = 140
          Top = 50
          Width = 30
          Height = 12
          Caption = '-----'
          Font.Charset = GB2312_CHARSET
          Font.Color = clNavy
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object LabelTo: TLabel
          Left = 180
          Top = 50
          Width = 42
          Height = 12
          Caption = 'LabelTo'
        end
        object LabelTitle: TLabel
          Left = 189
          Top = 8
          Width = 216
          Height = 24
          Caption = #24207#26102#36134#65288#32508#21512#26597#35810#65289
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlue
          Font.Height = -24
          Font.Name = #26999#20307'_GB2312'
          Font.Style = []
          ParentFont = False
        end
        object CheckBoxAutoWidth: TCheckBox
          Left = 449
          Top = 48
          Width = 82
          Height = 17
          Caption = #26368#21512#36866#21015#23485
          Font.Charset = GB2312_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = CheckBoxAutoWidthClick
        end
      end
      object PanelRight: TPanel
        Left = 798
        Top = 73
        Width = 12
        Height = 285
        Align = alRight
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 3
      end
      object PanelBottom: TPanel
        Left = 0
        Top = 358
        Width = 810
        Height = 7
        Align = alBottom
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 4
      end
      object THDBGridXSZ: TTHDBGrid
        Left = 10
        Top = 73
        Width = 788
        Height = 285
        Ctl3D = False
        ReadOnly = True
        DblEqual = True
        PassReadonly = True
        BKColor = clWhite
        HeaderHeight = 34
        RowCount = 2
        AutoNext = False
        HeaderColor = clInfoBk
        OnHeaderDblClick = THDBGridXSZHeaderDblClick
        HighLightColor = clHighlight
        HighlightTextColor = clHighlightText
        PopAllowUpdown = False
        DefColor = clInfoBk
        DefColorPerRows = 1
        GridTail = False
        GridTailColor = clBlack
        GridTailHeight = 20
        Align = alClient
        DataSource = DataSourceXSZ
        FixedColor = clWhite
        ImeName = #20013#25991' ('#31616#20307') - '#21152#21152#36755#20837#27861'4.0'
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        PopupMenu = PopupMenuXSZ
        TabOrder = 2
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnDblClick = THDBGridXSZDblClick
        OnKeyDown = THDBGridXSZKeyDown
        Ctl3DThickNess = 0
        ShowLock = True
        RowsHeight = 18
        LineColor = clSilver
        Col = 1
        Row = 1
      end
      object PanelLeft: TPanel
        Left = 0
        Top = 73
        Width = 10
        Height = 285
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 1
      end
    end
  end
  object SpeedBarXSZ: TSpeedBar
    Left = 0
    Top = 0
    Width = 810
    Height = 44
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
    Images = ImageListBar
    BevelOuter = bvNone
    TabOrder = 0
    OnPosChanged = SpeedBarXSZPosChanged
    OnDblClick = SpeedBarXSZDblClick
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
    object SpeedbarSectionHelp: TSpeedbarSection
      Caption = 'Help'
    end
    object SpeedbarSectionExit: TSpeedbarSection
      Caption = 'Exit'
    end
    object SpeedItemPreview: TSpeedItem
      BtnCaption = #39044#35272
      BtnGrayedInactive = True
      Caption = #25171#21360#39044#35272
      Hint = #25171#21360#39044#35272'|'
      ImageIndex = 0
      Spacing = 1
      Left = 3
      Top = 3
      Visible = True
      OnClick = SpeedItemPreviewClick
      SectionName = 'File'
    end
    object SpeedItemPrint: TSpeedItem
      BtnCaption = #25171#21360
      BtnGrayedInactive = True
      Caption = #25171#21360
      Hint = #25171#21360'|'
      ImageIndex = 1
      Spacing = 1
      Left = 43
      Top = 3
      Visible = True
      OnClick = SpeedItemPrintClick
      SectionName = 'File'
    end
    object SpeedItemConfig: TSpeedItem
      BtnCaption = #35774#32622
      BtnGrayedInactive = True
      Caption = #35774#32622#26597#35810#33539#22260
      Hint = #35774#32622#26597#35810#33539#22260'|'
      ImageIndex = 2
      Spacing = 1
      Left = 91
      Top = 3
      Visible = True
      OnClick = SpeedItemConfigClick
      SectionName = 'Edit'
    end
    object SpeedItemFilter: TSpeedItem
      BtnCaption = #31579#36873
      BtnGrayedInactive = True
      Caption = #31579#36873
      Hint = #31579#36873'|'
      ImageIndex = 3
      Spacing = 1
      Left = 131
      Top = 3
      Visible = True
      OnClick = SpeedItemFilterClick
      SectionName = 'Edit'
    end
    object SpeedItemUnFilter: TSpeedItem
      BtnCaption = #24674#22797
      BtnGrayedInactive = True
      Caption = #21462#28040#31579#36873
      Hint = #21462#28040#31579#36873'|'
      ImageIndex = 4
      Spacing = 1
      Left = 171
      Top = 3
      Visible = True
      OnClick = SpeedItemUnFilterClick
      SectionName = 'Edit'
    end
    object SpeedItemReFresh: TSpeedItem
      BtnCaption = #21047#26032
      BtnGrayedInactive = True
      Caption = #21047#26032
      Hint = #21047#26032'|'
      ImageIndex = 5
      Spacing = 1
      Left = 211
      Top = 3
      Visible = True
      OnClick = SpeedItemReFreshClick
      SectionName = 'Edit'
    end
    object SpeedItemZB: TSpeedItem
      BtnCaption = #36134#31807
      BtnGrayedInactive = True
      Caption = #36873#25321#32852#26597#36134#31807#31181#31867
      DropDownMenu = PopupMenuZB
      Hint = #36873#25321#32852#26597#36134#31807#31181#31867'|'
      ImageIndex = 6
      Spacing = 1
      Left = 259
      Top = 3
      Visible = True
      SectionName = 'Run'
    end
    object SpeedItemHelp: TSpeedItem
      BtnCaption = #24110#21161
      BtnGrayedInactive = True
      Caption = #25171#24320#24110#21161#25991#20214
      Hint = #25171#24320#24110#21161#25991#20214'|'
      ImageIndex = 7
      Spacing = 1
      Left = 307
      Top = 3
      Visible = True
      OnClick = SpeedItemHelpClick
      SectionName = 'Help'
    end
    object SpeedItemExit: TSpeedItem
      BtnCaption = #36864#20986
      BtnGrayedInactive = True
      Caption = #36864#20986
      Hint = #36864#20986'|'
      ImageIndex = 8
      Spacing = 1
      Left = 355
      Top = 3
      Visible = True
      OnClick = SpeedItemExitClick
      SectionName = 'Exit'
    end
  end
  object PopupMenuZB: TPopupMenu
    Left = 345
    Top = 48
    object NMXZ: TMenuItem
      Caption = #26126#32454#36134
      OnClick = PopupMenuZBClick
    end
    object NYEB: TMenuItem
      Caption = #20313#39069#34920
      Visible = False
      OnClick = PopupMenuZBClick
    end
    object NZZ: TMenuItem
      Caption = #24635#36134
      OnClick = PopupMenuZBClick
    end
    object NPZ: TMenuItem
      Caption = #20973#35777
      OnClick = PopupMenuZBClick
    end
  end
  object THFilterXSZ: TTHFilter
    GridCols = <
      item
        Width = 50
        Caption = #20250#35745#26399#38388
        AutoEnter = False
        ColName = 'KJQJ'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #20973#35777#26085#26399
        AutoEnter = False
        ColName = 'RQ'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #20973#35777#26469#28304
        AutoEnter = False
        ColName = 'PZLY'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #32467#31639#26041#24335
        AutoEnter = False
        ColName = 'JSFS'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #21407#22987#20973#35777#21495
        AutoEnter = False
        ColName = 'SPZ'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #21333#25454#26085#26399
        AutoEnter = False
        ColName = 'WLDRQ'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
      item
        Width = 100
        Caption = #25688#35201' '
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #20973#35777#29366#24577
        AutoEnter = False
        ColName = 'ZT'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
      item
        Width = 60
        Caption = #31185#30446#20195#30721
        AutoEnter = False
        ColName = 'KMDM'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 120
        Caption = #31185#30446#21517#31216
        AutoEnter = False
        ColName = 'KMMC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #37096#38376#20195#30721
        AutoEnter = False
        ColName = 'BMDM'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #37096#38376#21517#31216
        AutoEnter = False
        ColName = 'BMMC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #39033#30446#20195#30721
        AutoEnter = False
        ColName = 'XMDM'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #39033#30446#21517#31216
        AutoEnter = False
        ColName = 'XMMC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #20010#20154#24448#26469#20195#30721
        AutoEnter = False
        ColName = 'GRWLDM'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #20010#20154#24448#26469#21517#31216
        AutoEnter = False
        ColName = 'GRWLMC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #21333#20301#24448#26469#20195#30721
        AutoEnter = False
        ColName = 'DWWLDM'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #21333#20301#24448#26469#21517#31216
        AutoEnter = False
        ColName = 'DWWLMC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'4'#20195#30721
        AutoEnter = False
        ColName = 'FZDM4'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'4'#21517#31216
        AutoEnter = False
        ColName = 'FZDM4MC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'5'#20195#30721
        AutoEnter = False
        ColName = 'FZDM5'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'5'#21517#31216
        AutoEnter = False
        ColName = 'FZDM5MC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'6'#20195#30721
        AutoEnter = False
        ColName = 'FZDM6'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'6'#21517#31216
        AutoEnter = False
        ColName = 'FZDM6MC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'7'#20195#30721
        AutoEnter = False
        ColName = 'FZDM7'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'7'#21517#31216
        AutoEnter = False
        ColName = 'FZDM7MC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'8'#20195#30721
        AutoEnter = False
        ColName = 'FZDM8'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'8'#21517#31216
        AutoEnter = False
        ColName = 'FZDM8MC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'9'#20195#30721
        AutoEnter = False
        ColName = 'FZDM9'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'9'#21517#31216
        AutoEnter = False
        ColName = 'FZDM9MC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'10'#20195#30721
        AutoEnter = False
        ColName = 'FZDM10'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #22266#23450'10'#21517#31216
        AutoEnter = False
        ColName = 'FZDM10MC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#21161#35828#26126#19968
        AutoEnter = False
        ColName = 'FZSM1'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#21161#35828#26126#20108
        AutoEnter = False
        ColName = 'FZSM2'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#21161#35828#26126#19977
        AutoEnter = False
        ColName = 'FZSM3'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#21161#35828#26126#22235
        AutoEnter = False
        ColName = 'FZSM4'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#21161#35828#26126#20116
        AutoEnter = False
        ColName = 'FZSM5'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#21161#35828#26126#20845
        AutoEnter = False
        ColName = 'FZSM6'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#21161#35828#26126#19971
        AutoEnter = False
        ColName = 'FZSM7'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#21161#35828#26126#20843
        AutoEnter = False
        ColName = 'FZSM8'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#21161#35828#26126#20061
        AutoEnter = False
        ColName = 'FZSM9'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #24065#31181
        AutoEnter = False
        ColName = 'WBDM'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Alignment = taCenter
        Width = 30
        Caption = #26041';'#21521
        AutoEnter = False
        ColName = 'JDBZ'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Alignment = taRightJustify
        Width = 50
        Caption = #27719#29575
        AutoEnter = False
        ColName = 'HL'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftString
        DataTypePro = dpDecimal
        DataTypeApp = daNone
        DataWidth = 16
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Alignment = taRightJustify
        Width = 50
        Caption = #21333#20215
        AutoEnter = False
        ColName = 'DJ'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftString
        DataTypePro = dpDecimal
        DataTypeApp = daNone
        DataWidth = 16
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Alignment = taRightJustify
        Width = 50
        Caption = #25968#37327
        AutoEnter = False
        ColName = 'SL'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftString
        DataTypePro = dpDecimal
        DataTypeApp = daNone
        DataWidth = 16
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Alignment = taRightJustify
        Width = 50
        Caption = #22806#24065#37329#39069
        AutoEnter = False
        ColName = 'WBJE'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftString
        DataTypePro = dpDecimal
        DataTypeApp = daNone
        DataWidth = 16
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Alignment = taRightJustify
        Width = 50
        Caption = #37329#39069
        AutoEnter = False
        ColName = 'JE'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftString
        DataTypePro = dpDecimal
        DataTypeApp = daNone
        DataWidth = 16
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
      item
        Alignment = taRightJustify
        Width = 50
        Caption = #37329#39069'.'#20511#26041
        AutoEnter = False
        ColName = 'JFJE'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftString
        DataTypePro = dpCurrency
        DataTypeApp = daNone
        DataWidth = 16
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
      item
        Alignment = taRightJustify
        Width = 50
        Caption = #37329#39069'.'#36151#26041
        AutoEnter = False
        ColName = 'DFJE'
        ImeMode = imDisable
        ReadOnly = False
        DataType = ftString
        DataTypePro = dpCurrency
        DataTypeApp = daNone
        DataWidth = 16
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#39033#31867#22411
        AutoEnter = False
        ColName = 'MXLX'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#39033#20195#30721
        AutoEnter = False
        ColName = 'FZDM'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #36741#39033#21517#31216
        AutoEnter = False
        ColName = 'FZMC'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Alignment = taRightJustify
        Width = 50
        Caption = #26126#32454#37329#39069
        AutoEnter = False
        ColName = 'MXJE'
        ImeMode = imDisable
        ReadOnly = True
        DataType = ftString
        DataTypePro = dpDecimal
        DataTypeApp = daNone
        DataWidth = 16
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #21046#21333#20154
        AutoEnter = False
        ColName = 'sr'
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
        Caption = #20986#32435
        AutoEnter = False
        ColName = 'CN'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #23457#26680#20154
        AutoEnter = False
        ColName = 'SH'
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
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
      end>
    UseOnFilterRecord = False
    GridItems = <>
    LeftCols = 2
    UseFormName = False
    OnFilter = THFilterXSZFilter
    Left = 168
    Top = 152
  end
  object DataSourceXSZ: TDataSource
    DataSet = ClientDataSetXSZ
    Left = 368
    Top = 176
  end
  object ClientDataSetXSZ: TClientDataSet
    Aggregates = <>
    Filtered = True
    Params = <>
    ProviderName = 'DataSetProviderZB1'
    BeforeOpen = ClientDataSetXSZBeforeOpen
    Left = 312
    Top = 152
  end
  object PopupMenuXSZ: TPopupMenu
    Left = 256
    Top = 176
    object NZKMX: TMenuItem
      Caption = #23637#24320#20998#24405#26126#32454
      OnClick = PopupMenuClick
    end
    object NSSMX: TMenuItem
      Caption = #25910#32553#20998#24405#26126#32454
      OnClick = PopupMenuClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object NConfig: TMenuItem
      Caption = #35774#32622#33539#22260'(&C)'
      OnClick = PopupMenuClick
    end
    object NDoFilter: TMenuItem
      Caption = #31579#36873#36873#39033'(&F)'
      OnClick = PopupMenuClick
    end
    object NUnDoFilter: TMenuItem
      Caption = #21462#28040#31579#36873'(&N)'
      OnClick = PopupMenuClick
    end
    object NRefresh: TMenuItem
      Caption = #21047#26032'(&R)'
      OnClick = PopupMenuClick
    end
  end
  object MainMenuXSZ: TMainMenu
    Images = ImageListBar
    Left = 464
    Top = 8
    object MFile: TMenuItem
      Caption = #25991#20214'(&F)'
      GroupIndex = 10
      object MPreview: TMenuItem
        Caption = #25171#21360#39044#35272'(&R)'
        ImageIndex = 0
        ShortCut = 16466
        OnClick = MainMenuClick
      end
      object MPrint: TMenuItem
        Caption = #25171#21360'(&P)'
        ImageIndex = 1
        ShortCut = 16464
        OnClick = MainMenuClick
      end
      object MDataOut: TMenuItem
        Caption = #25968#25454#36755#20986'(&O)'
        OnClick = MainMenuClick
      end
      object MBDataOut: TMenuItem
        Caption = '-'
        OnClick = MainMenuClick
      end
      object MExit: TMenuItem
        Caption = #36864#20986'(&X)'
        ImageIndex = 11
        ShortCut = 16472
        OnClick = MainMenuClick
      end
    end
    object MRun: TMenuItem
      Caption = #25191#34892'(&R)'
      GroupIndex = 10
      object MZFCX: TMenuItem
        Caption = #36134#35777#32852#26597'(&B)'
        ImageIndex = 6
        object MMXZ: TMenuItem
          Caption = #26126#32454#36134
          ShortCut = 16507
          OnClick = MainMenuClick
        end
        object MYEB: TMenuItem
          Caption = #20313#39069#34920
          Visible = False
          OnClick = MainMenuClick
        end
        object MZZ: TMenuItem
          Caption = #24635#36134
          ShortCut = 16506
          OnClick = MainMenuClick
        end
        object MPZ: TMenuItem
          Caption = #20973#35777
          ShortCut = 16503
          OnClick = MainMenuClick
        end
      end
      object MBLFCX: TMenuItem
        Caption = '-'
      end
      object MConfig: TMenuItem
        Caption = #35774#32622#33539#22260'(&C)'
        ImageIndex = 2
        OnClick = MainMenuClick
      end
      object MFilter: TMenuItem
        Caption = #31579#36873'(&F)'
        object MDoFIlter: TMenuItem
          Caption = #31579#36873#36873#39033'(&F)'
          ImageIndex = 3
          OnClick = MainMenuClick
        end
        object MUnDoFilter: TMenuItem
          Caption = #21462#28040#31579#36873'(&N)'
          ImageIndex = 4
          OnClick = MainMenuClick
        end
      end
      object MReFresh: TMenuItem
        Caption = #21047#26032'(&R)'
        ImageIndex = 5
        ShortCut = 116
        OnClick = MainMenuClick
      end
      object MBFilter: TMenuItem
        Caption = '-'
      end
      object MShowSJKmmc: TMenuItem
        Caption = #33258#21160#24102#20986#19978#32423#31185#30446#21517#31216
        OnClick = MShowSJKmmcClick
      end
      object MShowSLHJ: TMenuItem
        Caption = #26174#31034#25968#37327#21512#35745
        OnClick = MShowSLHJClick
      end
      object MSetup: TMenuItem
        Caption = #35774#32622'(&O)'
        Visible = False
      end
      object TMenuItem
        Caption = '-'
      end
      object MClearFLCond: TMenuItem
        Caption = #28165#31354#20998#24405#26465#20214
        Checked = True
        OnClick = MClearFLCondClick
      end
    end
  end
  object ImageListBar: TImageList
    Left = 532
    Top = 8
    Bitmap = {
      494C010109000A00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD0000000000BDBDBD000000
      0000BDBDBD00BDBDBD00BDBDBD0000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD000000000000000000BDBDBD00000000000000000000000000000000000000
      0000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD0000000000BDBDBD000000
      0000BDBDBD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD0000000000000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD0000000000BDBDBD00BDBDBD0000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD0000000000BDBDBD00BDBDBD0000000000BDBDBD0000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000000000000000000000000000
      0000848400000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD0000000000BDBD
      BD00BDBDBD00BDBDBD00BDBDBD0000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD0000000000BDBDBD00BDBDBD00BDBDBD000000000000000000000000008484
      0000848400000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000
      00007B7B7B007B7B7B007B7B7B00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B000000000000000000000000008484
      00008484000000000000FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000
      00007B7B00007B7B7B007B7B7B007B7B7B00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000000000000000000000008484
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      000084000000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD0000000000BDBD
      BD007B7B7B007B7B7B00BDBDBD007B7B7B00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000000000000000000000008484
      00008484000000000000FFFFFF00FFFFFF000000000000000000000000008400
      000084000000000000000000000000000000FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD0000000000BDBDBD000000
      00007B7B7B007B7B7B00FFFF0000FFFF00007B7B7B00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000000000000000000000008484
      00008484000000000000FFFFFF00FFFFFF000000000000000000000000008400
      000084000000840000008400000000000000000000000000000000000000BDBD
      BD007B7B00007B7B7B00BDBDBD00BDBDBD00FFFF00007B7B7B00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD0000000000BDBDBD00000000000000
      00007B7B00007B7B7B00BDBDBD00FFFF00000000000000000000000000008484
      00008484000000000000FFFFFF00FFFFFF000000000000000000840000008400
      000084000000840000008400000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD0000000000BDBDBD0000000000BDBDBD000000
      00007B7B7B007B7B7B00BDBDBD00BDBDBD00FFFF0000FFFF00007B7B7B00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B000000000000000000000000008484
      00008484000000000000FFFFFF00FFFFFF000000000000000000000000008400
      000084000000840000008400000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000BDBDBD0000000000BDBDBD0000000000BDBD
      BD007B7B00007B7B7B00BDBDBD00BDBDBD00BDBDBD00FFFF0000FFFF00007B7B
      7B00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00000000000000000000000000000000008484
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD0000000000000000000000000000000000BDBDBD007B00
      00007B7B7B007B7B7B00BDBDBD00BDBDBD00BDBDBD00BDBDBD00FFFF00007B7B
      7B00BDBDBD00BDBDBD00BDBDBD00BDBDBD00000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD007B7B7B00FFFFFF00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF00000000000000FFFFFF0000000000FF0000000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF0000000000000000000000FFFFFF0000000000FFFFFF0000000000FF00
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FF000000000000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF000000FF0000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000FF0000000000000000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF0000FFFF000000FF000000FF00FFFFFF0000FFFF00FFFF
      FF00FFFFFF000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF0000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FF00000000000000000000000000000000000000FFFF
      FF00FFFFFF0000FFFF00FFFFFF000000FF000000FF0000FFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FF0000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0084848400FFFFFF0000FFFF0000FF
      FF00000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF0000FFFF00FFFFFF000000FF000000000000FFFF00FFFFFF00FFFF
      FF00000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF000000FF000000FF000000000000FFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000000000000000000000FF
      FF0000000000000000000000000000FFFF000000FF000000FF00000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000FF000000FF0000FF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0000FFFF000000FF000000FF00FFFFFF0000FFFF000000FF000000FF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000FFFF000000FF000000FF000000FF000000FF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B00007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B00007B7B7B007B7B7B007B7B
      7B00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B00000000007B7B
      7B00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000008484840000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B00007B7B7B00FFFF00007B7B
      7B00000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000848484000000000000000000FFFF00008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B00FFFF0000FFFF
      00007B7B7B000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B00007B7B7B0000000000FFFF
      00007B7B7B007B7B7B0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000000000000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B00007B7B7B00000000000000
      0000FFFF00007B7B7B0000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF000000000084848400FFFF0000FFFF0000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B00000000000000
      0000FFFF0000FFFF00007B7B7B00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000008484840000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000007B0000007B000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B00007B7B7B00000000000000
      000000000000FFFF00007B7B7B00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B0000007B000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B00007B7B7B00000000000000
      000000000000FFFF0000FFFF00007B7B7B000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B0000007B000000000000000000000000000000000000000000
      00000000000000000000000000007B0000007B7B7B007B7B7B00000000000000
      00000000000000000000FFFF00007B7B7B000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B0000007B000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B0000007B000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FBFF000000000000
      F3FF000000000000E3FF000000000000800F000000000000C07F000000000000
      C077000000000000C067000000000000C061000000000000C041000000000000
      C061000000000000C067000000000000C07F000000000000C07F000000000000
      FFFF000000000000FFFF000000000000FFFFFE3FFFFFFFFFFFFFF9CFFE3FFC1F
      FFFFF7F7F81FC141FFFFF7FBF40FDE39FFFFEFFFE007C001FFE7EFFF8003C001
      C1F3EFFF4001E003C3FBEFFB0000E003C7FBEFF30000E083CBFBEFE38001E007
      DCF3F7C3C003E007FF07F7F3E00FE007FFFFF9CBF07FE00FFFFFFE3FF8FFF01F
      FFFFFFFFFFFFF81FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE1FFFFFFFFFFFFFFE1F
      8019E00F801FFE0F8011DFF7801FFD2F8067BE23801FFC0F80C7BE2B801FFA07
      81F7800D801FF4238177BFF5801FF1338027C009809FEA31806FE0159149E039
      801FE0038AB1D538801FE00F8579C23C805FF007FDF18000803FF807FE09FFFF
      807FFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object SPrintXSZ: TSPrint
    OtherItems = <
      item
        AutoFontSize = False
        Left = 0
        Top = 0
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -24
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        DataType = ptTitle
        Caption = #24207#26102#36134#65288#32508#21512#26597#35810#65289
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
        DataType = ptCompany
        Caption = #21333#20301':'
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
        Caption = #25171#21360#20154':'
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
        Caption = #25171#21360#26085#26399':'
      end
      item
        AutoFontSize = False
        Left = 0
        Top = 77
        Font.Charset = GB2312_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptNormal
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
        CaptionFont.Charset = GB2312_CHARSET
        CaptionFont.Color = clWindowText
        CaptionFont.Height = -12
        CaptionFont.Name = #23435#20307
        CaptionFont.Style = []
        Width = 64
      end>
    Grid = THDBGridXSZ
    GridTop = 100
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
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    WordOffsetX = 3
    WordOffsetY = 3
    OffsetLeft = 0
    OffsetTop = 0
    PrintRowCount = 47
    PrintIfEmpty = False
    ReportTitle = #24207#26102#36134#65288#32508#21512#26597#35810#65289
    SnapToGrid = False
    ShowProgress = False
    FixedCols = 1
    TDEnabled = False
    Left = 208
    Top = 136
  end
  object LggExchanger1: TLggExchanger
    AllowDblLgg = True
    Form = Owner
    Options = [aoFormCaption, aoMenuItem, aoLabel, aoBitBtn, aoCheckBox, aoRadioButton, aoSpeedItem, aoPanel, aoGroupBox, aoRadioGroup, aoTHStringGrid, aoTHDBGrid, aoTabSet, aoPageControl, aoComboBox, aoStatusBar, aoTHBevel, aoListView]
    TextFileName = 'alang_x1.txt'
    Left = 8
    Top = 40
  end
  object ExpandPrint1: TExpandPrint
    ASPrint = SPrintXSZ
    APrintEmpty = False
    APrintEmptySet = False
    Left = 48
    Top = 40
  end
  object FormStorageXSZ: TFormStorage
    StoredProps.Strings = (
      'MClearFLCond.Checked')
    StoredValues = <>
    Left = 72
    Top = 224
  end
end
