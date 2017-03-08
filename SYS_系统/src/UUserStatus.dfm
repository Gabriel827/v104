object FrmUserState: TFrmUserState
  Left = 323
  Top = 165
  Width = 979
  Height = 563
  Caption = #25805#20316#21592#29366#24577#26597#35810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenuCZRZ
  OldCreateOrder = False
  Position = poDefaultPosOnly
  Scaled = False
  Visible = True
  WindowState = wsMinimized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RxLabelTitle: TRxLabel
    Left = 12
    Top = 7
    Width = 86
    Height = 20
    Caption = #25805#20316#26085#24535
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -20
    Font.Name = #26999#20307'_GB2312'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
  end
  object SpeedBarCzrz: TSpeedBar
    Left = 0
    Top = 0
    Width = 963
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
    BevelOuter = bvNone
    TabOrder = 0
    InternalVer = 1
    object SpeedbarSection1: TSpeedbarSection
      Caption = 'File'
    end
    object SpeedbarSection4: TSpeedbarSection
      Caption = 'Exit'
    end
    object spdtmUnLock: TSpeedItem
      BtnCaption = #35299#38145
      BtnGrayedInactive = True
      Caption = #35299#38145
      Hint = #35299#38145'|'
      ImageIndex = 0
      Spacing = 1
      Left = 3
      Top = 3
      Visible = True
      OnClick = spdtmUnLockClick
      SectionName = 'File'
    end
    object SpeedItemExit: TSpeedItem
      BtnCaption = #36864#20986
      BtnGrayedInactive = True
      Caption = #36864#20986
      Hint = #36864#20986
      ImageIndex = 9
      Spacing = 1
      Left = 43
      Top = 3
      Visible = True
      OnClick = SpeedItemExitClick
      SectionName = 'Exit'
    end
  end
  object PanelSpace: TPanel
    Left = 0
    Top = 44
    Width = 963
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object RxLabel1: TRxLabel
      Left = 12
      Top = 6
      Width = 149
      Height = 20
      Caption = #25805#20316#21592#29366#24577#26597#35810
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -20
      Font.Name = #26999#20307'_GB2312'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
  end
  object PanelZB: TPanel
    Left = 0
    Top = 79
    Width = 963
    Height = 426
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object PanelLeft: TPanel
      Left = 0
      Top = 0
      Width = 5
      Height = 415
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
    end
    object THDBGridUserState: TTHDBGrid
      Left = 5
      Top = 0
      Width = 952
      Height = 415
      ReadOnly = True
      DblEqual = True
      PassReadonly = True
      BKColor = clWhite
      HeaderHeight = 50
      RowCount = 2
      AutoNext = True
      HeaderColor = clBtnFace
      HighLightColor = clHighlight
      HighlightTextColor = clHighlightText
      PopAllowUpdown = False
      DefColor = clInfoBk
      DefColorPerRows = 1
      GridTail = False
      GridTailColor = clBlack
      GridTailHeight = 20
      Align = alClient
      DataSource = DataSourceCZRZ
      ImeName = #20013#25991' ('#31616#20307') - '#25340#38899#21152#21152
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgKeyAppend, dgKeyInsert]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Ctl3DThickNess = 2
      ShowLock = True
      RowsHeight = 18
      LineColor = clBtnFace
      Col = 1
      Row = 1
    end
    object PanelBottom: TPanel
      Left = 0
      Top = 415
      Width = 963
      Height = 11
      Align = alBottom
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 3
    end
    object PanelRight: TPanel
      Left = 957
      Top = 0
      Width = 6
      Height = 415
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
    end
  end
  object MainMenuCZRZ: TMainMenu
    Left = 336
    Top = 53
    object MFile: TMenuItem
      Caption = #25991#20214'(&F)'
      GroupIndex = 10
      object mniUnLock: TMenuItem
        Caption = #35299#38145
        ImageIndex = 0
        ShortCut = 16466
        OnClick = mniUnLockClick
      end
      object MLExit: TMenuItem
        Caption = '-'
      end
      object MExit: TMenuItem
        Caption = #36864#20986'(&X)'
        ImageIndex = 9
        ShortCut = 16472
        OnClick = MExitClick
      end
    end
  end
  object dsOperStatus: TClientDataSet
    Aggregates = <>
    Filtered = True
    Params = <>
    ProviderName = 'DataSetProviderCZRZ'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 192
    Top = 51
  end
  object DataSourceCZRZ: TDataSource
    DataSet = dsOperStatus
    Left = 242
    Top = 52
  end
  object THFilterUserState: TTHFilter
    GridCols = <
      item
        Width = 50
        Caption = #25805#20316#21592#21517#31216
        AutoEnter = False
        ColName = 'OperName'
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
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 100
        Caption = #30331#38470#24037#20316#31449
        AutoEnter = False
        ColName = 'station'
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
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 100
        Caption = #30331#38470#29366#24577
        AutoEnter = False
        ColName = 'LoginOperState'
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
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #30331#38470#26102#38388
        AutoEnter = False
        ColName = 'LoginOperTime'
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
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #38145#23450#29366#24577
        AutoEnter = False
        ColName = 'OperState'
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
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end
      item
        Width = 50
        Caption = #30331#38470#27425#25968
        AutoEnter = False
        ColName = 'ReLoginCount'
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
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end>
    UseOnFilterRecord = False
    GridItems = <>
    LeftCols = 2
    UseFormName = False
    Left = 285
    Top = 48
  end
end
