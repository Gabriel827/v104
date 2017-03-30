object FormWYZF: TFormWYZF
  Left = 290
  Top = 4
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #32593#38134#25903#20184
  ClientHeight = 662
  ClientWidth = 932
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenuWYZF
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblZFZT: TLabel
    Left = 8
    Top = 296
    Width = 3
    Height = 13
    Visible = False
  end
  object SpeedBarWYZF: TSpeedBar
    Left = 0
    Top = 0
    Width = 932
    Height = 46
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Pitch = fpVariable
    Font.Style = []
    BoundLines = [blTop, blBottom, blLeft, blRight]
    Options = [sbAllowDrag, sbAllowResize, sbFlatBtns, sbGrayedBtns, sbTransparentBtns]
    BtnOffsetHorz = 3
    BtnOffsetVert = 3
    BtnWidth = 40
    BtnHeight = 40
    BevelOuter = bvNone
    TabOrder = 0
    InternalVer = 1
    object SpeedbarSection1: TSpeedbarSection
      Caption = 'File'
    end
    object SpeedbarSection5: TSpeedbarSection
      Caption = 'Edit'
    end
    object SpeedbarSection2: TSpeedbarSection
      Caption = 'Run'
    end
    object SpeedbarSection3: TSpeedbarSection
      Caption = 'Help'
    end
    object SpeedbarSection4: TSpeedbarSection
      Caption = 'Exit'
    end
    object SpeedItem_Print: TSpeedItem
      BtnCaption = #25171#21360
      BtnGrayedInactive = True
      Caption = #25171#21360
      Hint = #25171#21360'|'
      ImageIndex = 1
      Spacing = 1
      Left = 3
      Top = 3
      Visible = True
      OnClick = SpeedItem_PrintClick
      SectionName = 'File'
    end
    object SpeedItem_insert: TSpeedItem
      BtnCaption = #22686#21152
      BtnGrayedInactive = True
      Caption = #22686#21152
      Enabled = False
      Hint = #22686#21152
      ImageIndex = 2
      Spacing = 1
      Left = 35
      Top = 3
      Visible = True
      OnClick = SpeedItem_insertClick
      SectionName = 'Edit'
    end
    object SpeedItem_Edit: TSpeedItem
      BtnCaption = #20462#25913
      BtnGrayedInactive = True
      Caption = #20462#25913
      Hint = #20462#25913'|'
      Spacing = 1
      Left = 75
      Top = 3
      Visible = True
      OnClick = SpeedItem_EditClick
      SectionName = 'Edit'
    end
    object SpeedItem_copy: TSpeedItem
      BtnCaption = #22797#21046
      BtnGrayedInactive = True
      Caption = #22797#21046
      Hint = '|'
      ImageIndex = 16
      Spacing = 1
      Left = 115
      Top = 3
      OnClick = SpeedItem_copyClick
      SectionName = 'Edit'
    end
    object SpeedItem_Save: TSpeedItem
      BtnCaption = #20445#23384
      BtnGrayedInactive = True
      Caption = #20445#23384
      Hint = #20445#23384
      ImageIndex = 15
      Spacing = 1
      Left = 147
      Top = 3
      Visible = True
      OnClick = SpeedItem_SaveClick
      SectionName = 'Edit'
    end
    object SpeedItem_Cancel: TSpeedItem
      BtnCaption = #21462#28040
      BtnGrayedInactive = True
      Caption = #21462#28040
      Hint = #21462#28040'|'
      Spacing = 1
      Left = 195
      Top = 3
      Visible = True
      OnClick = SpeedItem_CancelClick
      SectionName = 'Edit'
    end
    object SpeedItem_SSSH: TSpeedItem
      BtnCaption = #36865#23457
      BtnGrayedInactive = True
      Caption = #23457#26680
      Hint = #23457#26680'|'
      Spacing = 1
      Left = 523
      Top = 3
      Visible = True
      OnClick = SpeedItem_SSSHClick
      SectionName = 'Edit'
    end
    object SpeedItem_CheckNew: TSpeedItem
      BtnCaption = #23457#26680
      BtnGrayedInactive = True
      Caption = #23457#26680
      Hint = #23457#26680'|'
      Spacing = 1
      Left = 563
      Top = 3
      Visible = True
      OnClick = SpeedItem_CheckNewClick
      SectionName = 'Edit'
    end
    object SpeedItem_Check: TSpeedItem
      BtnCaption = #21021#23457
      BtnGrayedInactive = True
      Caption = #21021#23457
      Hint = #21021#23457'|'
      ImageIndex = 20
      Spacing = 1
      Left = 395
      Top = 3
      Visible = True
      OnClick = SpeedItem_CheckClick
      SectionName = 'Edit'
    end
    object SpeedItem_Check2: TSpeedItem
      BtnCaption = #22797#23457
      BtnGrayedInactive = True
      Caption = #22797#23457
      Hint = #22797#23457'|'
      ImageIndex = 20
      Spacing = 1
      Left = 419
      Top = 3
      Visible = True
      OnClick = SpeedItem_Check2Click
      SectionName = 'Edit'
    end
    object SpeedItem_do: TSpeedItem
      BtnCaption = #25191#34892
      BtnGrayedInactive = True
      Caption = #25191#34892
      Hint = #25191#34892'|'
      Spacing = 1
      Left = 619
      Top = 3
      Visible = True
      OnClick = SpeedItem_doClick
      SectionName = 'Edit'
    end
    object btnNewZF: TSpeedItem
      BtnCaption = #29983#25104
      BtnGrayedInactive = True
      Caption = #29983#25104
      Hint = #29983#25104'|'
      Spacing = 1
      Left = 475
      Top = 3
      Visible = True
      OnClick = btnNewZFClick
      SectionName = 'Edit'
    end
    object SpeedItem_First: TSpeedItem
      BtnCaption = #39318#24352
      BtnGrayedInactive = True
      Caption = 'SpeedItem_First'
      Hint = #31532#19968#20010
      ImageIndex = 8
      Spacing = 1
      Left = 235
      Top = 3
      Visible = True
      OnClick = SpeedItem_FirstClick
      SectionName = 'Run'
    end
    object SpeedItem_Prior: TSpeedItem
      BtnCaption = #19978#24352
      BtnGrayedInactive = True
      Caption = 'SpeedItem_Prior'
      Hint = #21069#19968#20010
      ImageIndex = 9
      Spacing = 1
      Left = 275
      Top = 3
      Visible = True
      OnClick = SpeedItem_PriorClick
      SectionName = 'Run'
    end
    object SpeedItem_Next: TSpeedItem
      BtnCaption = #19979#24352
      BtnGrayedInactive = True
      Caption = 'SpeedItem_Next'
      Hint = #19979#19968#20010
      ImageIndex = 10
      Spacing = 1
      Left = 315
      Top = 3
      Visible = True
      OnClick = SpeedItem_NextClick
      SectionName = 'Run'
    end
    object SpeedItem_Last: TSpeedItem
      BtnCaption = #26411#24352
      BtnGrayedInactive = True
      Caption = 'SpeedItem_Last'
      Hint = #26368#21518#19968#20010
      ImageIndex = 11
      Spacing = 1
      Left = 355
      Top = 3
      Visible = True
      OnClick = SpeedItem_LastClick
      SectionName = 'Run'
    end
    object SpeedItem_Help: TSpeedItem
      BtnCaption = #24110#21161
      BtnGrayedInactive = True
      Caption = #25171#24320#24110#21161#25991#20214
      Hint = #25171#24320#24110#21161#25991#20214'|'
      ImageIndex = 12
      Spacing = 1
      Left = 419
      Top = 3
      SectionName = 'Help'
    end
    object SpeedItem_Exit: TSpeedItem
      BtnCaption = #36864#20986
      BtnGrayedInactive = True
      Caption = 'SpeedItem_Exit'
      Hint = #36864#20986
      ImageIndex = 13
      Spacing = 1
      Left = 659
      Top = 3
      Visible = True
      OnClick = SpeedItem_ExitClick
      SectionName = 'Exit'
    end
  end
  object PanelOther: TPanel
    Left = 0
    Top = 630
    Width = 932
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label222: TLabel
      Left = 441
      Top = 11
      Width = 42
      Height = 14
      Caption = #22797#23457#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label111: TLabel
      Left = 297
      Top = 11
      Width = 42
      Height = 14
      Caption = #21021#23457#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label000: TLabel
      Left = 39
      Top = 11
      Width = 42
      Height = 14
      Caption = #24405#20837#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object LabelSHR1: TLabel
      Left = 346
      Top = 11
      Width = 7
      Height = 14
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object LabelSHR2: TLabel
      Left = 490
      Top = 11
      Width = 7
      Height = 14
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object LabelLRR: TLabel
      Left = 81
      Top = 11
      Width = 7
      Height = 14
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label333: TLabel
      Left = 657
      Top = 11
      Width = 42
      Height = 14
      Caption = #25191#34892#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object LabelZXR: TLabel
      Left = 698
      Top = 11
      Width = 7
      Height = 14
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object LabelSHR: TLabel
      Left = 186
      Top = 11
      Width = 42
      Height = 14
      Caption = #23457#26680#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
  end
  object PanelTitle: TPanel
    Left = 0
    Top = 46
    Width = 932
    Height = 116
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label20: TLabel
      Left = 514
      Top = 11
      Width = 70
      Height = 14
      Caption = #19994#21153#32534#21495#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label22: TLabel
      Left = 257
      Top = 75
      Width = 70
      Height = 14
      Caption = #19994#21153#26085#26399#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabelTitle: TLabel
      Left = 382
      Top = 7
      Width = 100
      Height = 24
      Alignment = taCenter
      Caption = #32593#38134#25903#20184
      Color = clMaroon
      Font.Charset = GB2312_CHARSET
      Font.Color = clNavy
      Font.Height = -24
      Font.Name = #26999#20307'_GB2312'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object THBDJZT: TTHBevel
      Left = 584
      Top = 38
      Width = 137
      Height = 25
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      Color = clRed
      LineWidth = 1
      Style = bsLine
    end
    object Label21: TLabel
      Left = 758
      Top = 9
      Width = 70
      Height = 14
      Caption = #19994#21153#38134#34892#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label23: TLabel
      Left = 16
      Top = 74
      Width = 70
      Height = 14
      Caption = #32467#31639#26041#24335#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object LabelYDJBH: TLabel
      Left = 573
      Top = 75
      Width = 90
      Height = 14
      Caption = #21407#22987#21333#25454#21495#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clRed
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelBANKUQNO: TLabel
      Left = 269
      Top = 101
      Width = 90
      Height = 14
      Caption = #38134#34892#21807#19968#21495#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object LabelBUSIUQNO: TLabel
      Left = 17
      Top = 101
      Width = 135
      Height = 14
      Caption = #21407#25903#20184#20132#26131#27969#27700#21495#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelHEADBUSIUQNO: TLabel
      Left = 365
      Top = 101
      Width = 105
      Height = 14
      Caption = #20027#20132#26131#27969#27700#21495#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object LabelZFSJ: TLabel
      Left = 589
      Top = 101
      Width = 75
      Height = 14
      Caption = #25903#20184#26102#38388#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlue
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label26: TLabel
      Left = 18
      Top = 49
      Width = 70
      Height = 14
      Caption = #25968#25454#26469#28304#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object edtZFID: TEdit
      Left = 584
      Top = 7
      Width = 158
      Height = 22
      TabStop = False
      Color = clWhite
      Enabled = False
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Visible = False
    end
    object DateYWRQ: TDateTimePicker
      Left = 328
      Top = 71
      Width = 158
      Height = 22
      Date = 36054.633869328700000000
      Time = 36054.633869328700000000
      DateFormat = dfLong
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ParentFont = False
      TabOrder = 1
    end
    object ComboBoxYWYH: TComboBox
      Left = 816
      Top = 5
      Width = 41
      Height = 22
      Style = csDropDownList
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 2
      Visible = False
      Items.Strings = (
        #20013#22269#24314#35774#38134#34892
        #20013#22269#24037#21830#38134#34892
        #20013#22269#20892#19994#38134#34892
        #20013#22269#38134#34892
        '')
    end
    object ComboBoxYWLX: TComboBox
      Left = 88
      Top = 71
      Width = 158
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      OnChange = ComboBoxYWLXChange
      Items.Strings = (
        #20840#37096
        #36716#36134#25903#31080
        #30005#27719
        #29616#37329#25903#31080)
    end
    object ComboBoxSJLY: TComboBox
      Left = 88
      Top = 46
      Width = 158
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      TabOrder = 4
      Items.Strings = (
        #20840#37096
        #36716#36134#25903#31080
        #30005#27719
        #29616#37329#25903#31080)
    end
  end
  object PanelDJXX: TPanel
    Left = 0
    Top = 162
    Width = 932
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object GroupBox1: TGroupBox
      Left = 16
      Top = 4
      Width = 809
      Height = 48
      Caption = #38134#34892#21453#39304#20449#24687
      TabOrder = 0
      object Label24: TLabel
        Left = 22
        Top = 24
        Width = 71
        Height = 13
        AutoSize = False
        Caption = #21463#29702#20449#24687#65306
      end
      object Label25: TLabel
        Left = 408
        Top = 24
        Width = 79
        Height = 13
        AutoSize = False
        Caption = #25903#20184#20449#24687#65306
      end
      object edtCLXX: TEdit
        Left = 101
        Top = 17
        Width = 281
        Height = 22
        TabStop = False
        Color = clMenu
        Enabled = False
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtZFXX: TEdit
        Left = 494
        Top = 17
        Width = 294
        Height = 22
        TabStop = False
        Color = clMenu
        Enabled = False
        Font.Charset = GB2312_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = #23435#20307
        Font.Style = []
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object pc: TPageControl
    Left = 0
    Top = 227
    Width = 932
    Height = 403
    ActivePage = tsAll
    Align = alClient
    TabOrder = 4
    object tsAll: TTabSheet
      Caption = #25903#20184#26126#32454
      object grd: TDBGridEh
        Left = 0
        Top = 0
        Width = 924
        Height = 354
        Align = alClient
        AllowedOperations = [alopUpdateEh]
        DataSource = ds
        EditActions = [geaCopyEh, geaSelectAllEh]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -11
        FooterFont.Name = 'MS Sans Serif'
        FooterFont.Style = []
        FooterRowCount = 1
        Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
        ParentFont = False
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -15
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnEditButtonClick = grdEditButtonClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'ZFID'
            Footers = <>
            Title.Caption = #32534#21495
            Width = 98
          end
          item
            EditButtons = <>
            FieldName = 'SZHMC'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Caption = #36134#25143#21517#31216
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'SYHHH'
            Footer.ValueType = fvtCount
            Footers = <>
            Title.Caption = #38134#34892#34892#21495
            Width = 107
          end
          item
            ButtonStyle = cbsEllipsis
            EditButtons = <>
            FieldName = 'SKHYH'
            Footers = <>
            Title.Caption = #24320#25143#38134#34892
            Width = 214
          end
          item
            EditButtons = <>
            FieldName = 'SYHZH'
            Footers = <>
            Title.Caption = #38134#34892#36134#21495
            Width = 146
          end
          item
            EditButtons = <>
            FieldName = 'ZY'
            Footers = <>
            Title.Caption = #25688#35201
            Width = 124
          end
          item
            DisplayFormat = '#,##0.00'
            EditButtons = <>
            FieldName = 'JE'
            Footer.DisplayFormat = '#,##0.00'
            Footer.FieldName = 'JE'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Caption = #37329#39069
            Width = 117
          end
          item
            EditButtons = <>
            FieldName = 'USEOF_CODE'
            Footers = <>
            Title.Caption = #29992#36884#32534#21495
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'USEOF_DESC'
            Footers = <>
            Title.Caption = #29992#36884#21517#31216
            Width = 90
          end
          item
            EditButtons = <>
            FieldName = 'SLZT'
            Footers = <>
            Title.Caption = #21463#29702#29366#24577
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'ZFZT'
            Footers = <>
            Title.Caption = #25903#20184#29366#24577
            Width = 89
          end
          item
            EditButtons = <>
            FieldName = 'ZFXX'
            Footers = <>
            Title.Caption = #25903#20184#20449#24687
            Width = 107
          end>
      end
      object tsState: TTabSet
        Left = 0
        Top = 354
        Width = 924
        Height = 21
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Tabs.Strings = (
          #20840#37096
          #25903#20184#25104#21151
          #25903#20184#22833#36133)
        TabIndex = 0
        OnChange = tsStateChange
      end
    end
    object tsZFXX: TTabSheet
      Caption = #25903#20184#20449#24687
      ImageIndex = 1
      object PanelWYZF: TPanel
        Left = 0
        Top = 0
        Width = 924
        Height = 375
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object grpYHZH: TGroupBox
          Left = 15
          Top = 2
          Width = 810
          Height = 99
          Caption = #20184#27454#26041#20449#24687
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 23
            Top = 44
            Width = 70
            Height = 14
            Caption = #38134#34892#36134#21495#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label2: TLabel
            Left = 411
            Top = 20
            Width = 70
            Height = 14
            Caption = #36134#25143#21517#31216#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label3: TLabel
            Left = 411
            Top = 45
            Width = 70
            Height = 14
            Caption = #24320#25143#38134#34892#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 37
            Top = 68
            Width = 56
            Height = 14
            Caption = #26426#26500#21495#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object LabelMC: TLabel
            Left = 627
            Top = 116
            Width = 70
            Height = 14
            Caption = #38134#34892#34892#21035#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object Label12: TLabel
            Left = 411
            Top = 70
            Width = 70
            Height = 14
            Caption = #24320#25143#22320#21306#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label14: TLabel
            Left = 37
            Top = 20
            Width = 56
            Height = 14
            Caption = #20184#27454#26041#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label15: TLabel
            Left = 642
            Top = 142
            Width = 60
            Height = 12
            Caption = #38134#34892#32593#28857#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object edtYHZH: TSMaskEdit
            Left = 102
            Top = 44
            Width = 280
            Height = 22
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            LBCanUse = True
            Alignment = taLeftJustify
            DataTypePro = dpString
            DataWidth = 0
            DataDec = 0
            LoadButton = True
            OnButtonClick = edtYHZHButtonClick
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
          end
          object edtYHHH: TEdit
            Left = 102
            Top = 69
            Width = 280
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 4
          end
          object edtZHMC: TEdit
            Left = 494
            Top = 17
            Width = 296
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 2
          end
          object edtKHYH: TEdit
            Left = 494
            Top = 42
            Width = 296
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 3
          end
          object edtKHDQ: TEdit
            Left = 494
            Top = 66
            Width = 296
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 6
          end
          object edtFKR: TSMaskEdit
            Left = 242
            Top = 25
            Width = 80
            Height = 22
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            LBCanUse = True
            Alignment = taLeftJustify
            DataTypePro = dpString
            DataWidth = 0
            DataDec = 0
            LoadButton = True
            OnButtonClick = edtFKRButtonClick
            ParentFont = False
            TabOrder = 0
            Visible = False
          end
          object edtYHWD: TEdit
            Left = 701
            Top = 137
            Width = 60
            Height = 23
            TabOrder = 7
            Visible = False
          end
          object edtYHHB: TComboBox
            Left = 702
            Top = 111
            Width = 59
            Height = 23
            Style = csDropDownList
            ItemHeight = 15
            TabOrder = 5
            Visible = False
            Items.Strings = (
              #20013#22269#24037#21830#38134#34892
              #20013#22269#20892#19994#38134#34892
              #20013#22269#38134#34892
              #20013#22269#24314#35774#38134#34892)
          end
          object edtFKRMC: TSMaskEdit
            Left = 102
            Top = 17
            Width = 280
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            LBCanUse = True
            Alignment = taLeftJustify
            DataTypePro = dpString
            DataWidth = 0
            DataDec = 0
            LoadButton = False
            ParentFont = False
            TabOrder = 8
          end
        end
        object GroupBox2: TGroupBox
          Left = 14
          Top = 104
          Width = 811
          Height = 176
          Caption = #25910#27454#26041#20449#24687
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object Label9: TLabel
            Left = 440
            Top = 116
            Width = 42
            Height = 14
            Caption = #34892#21495#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clDefault
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label8: TLabel
            Left = 47
            Top = 84
            Width = 42
            Height = 14
            Caption = #30465#20221#65306
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label18: TLabel
            Left = 440
            Top = 84
            Width = 42
            Height = 14
            Caption = #22478#24066#65306
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label19: TLabel
            Left = 47
            Top = 115
            Width = 42
            Height = 14
            Caption = #38134#34892#65306
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 33
            Top = 20
            Width = 56
            Height = 14
            Caption = #25910#27454#26041#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label6: TLabel
            Left = 412
            Top = 20
            Width = 70
            Height = 14
            Caption = #36134#25143#21517#31216#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clDefault
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label5: TLabel
            Left = 19
            Top = 52
            Width = 70
            Height = 14
            Caption = #38134#34892#36134#21495#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clBtnText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label7: TLabel
            Left = 412
            Top = 52
            Width = 70
            Height = 14
            Caption = #24320#25143#38134#34892#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clDefault
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label13: TLabel
            Left = 19
            Top = 148
            Width = 70
            Height = 14
            Caption = #24320#25143#22320#21306#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label16: TLabel
            Left = 538
            Top = 154
            Width = 60
            Height = 12
            Caption = #38134#34892#32593#28857#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object edtYHHB2: TSMaskEdit
            Left = 496
            Top = 112
            Width = 299
            Height = 22
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            LBCanUse = True
            Alignment = taLeftJustify
            DataTypePro = dpString
            DataWidth = 0
            DataDec = 0
            LoadButton = True
            OnButtonClick = edtYHHB2ButtonClick
            ParentFont = False
            TabOrder = 0
          end
          object CB_PROVINCE: TComboBox
            Left = 104
            Top = 79
            Width = 281
            Height = 23
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 1
            OnChange = CB_PROVINCEChange
          end
          object CB_CITY: TComboBox
            Left = 496
            Top = 79
            Width = 297
            Height = 23
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 2
            OnChange = CB_CITYChange
          end
          object CB_DEPID: TComboBox
            Left = 104
            Top = 112
            Width = 281
            Height = 23
            Style = csDropDownList
            ItemHeight = 0
            TabOrder = 3
            OnChange = CB_DEPIDChange
          end
          object edtSKRMC: TSMaskEdit
            Left = 103
            Top = 19
            Width = 281
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            LBCanUse = True
            Alignment = taLeftJustify
            DataTypePro = dpString
            DataWidth = 0
            DataDec = 0
            LoadButton = False
            ParentFont = False
            TabOrder = 4
          end
          object edtSKR: TSMaskEdit
            Left = 121
            Top = 20
            Width = 40
            Height = 22
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            LBCanUse = True
            Alignment = taLeftJustify
            DataTypePro = dpString
            DataWidth = 0
            DataDec = 0
            LoadButton = True
            OnButtonClick = edtSKRButtonClick
            ParentFont = False
            TabOrder = 5
            Visible = False
          end
          object edtZHMC2: TSMaskEdit
            Left = 495
            Top = 17
            Width = 299
            Height = 22
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            LBCanUse = True
            Alignment = taLeftJustify
            DataTypePro = dpString
            DataWidth = 0
            DataDec = 0
            LoadButton = False
            OnButtonClick = edtZHMC2ButtonClick
            ParentFont = False
            TabOrder = 6
          end
          object edtYHZH2: TSMaskEdit
            Left = 104
            Top = 46
            Width = 280
            Height = 22
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            LBCanUse = True
            Alignment = taLeftJustify
            DataTypePro = dpString
            DataWidth = 0
            DataDec = 0
            LoadButton = True
            OnButtonClick = edtYHZH2ButtonClick
            ParentFont = False
            TabOrder = 7
          end
          object edtKHYH2: TEdit
            Left = 495
            Top = 46
            Width = 299
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 8
          end
          object edtKHDQ2: TEdit
            Left = 103
            Top = 146
            Width = 280
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 9
          end
          object edtYHWD2: TEdit
            Left = 597
            Top = 146
            Width = 36
            Height = 23
            TabOrder = 10
            Visible = False
          end
        end
        object GroupBox3: TGroupBox
          Left = 14
          Top = 279
          Width = 810
          Height = 80
          TabOrder = 2
          object Label17: TLabel
            Left = 19
            Top = 20
            Width = 70
            Height = 14
            Caption = #25688'    '#35201#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 19
            Top = 46
            Width = 70
            Height = 14
            Caption = #37329'    '#39069#65306
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object edtZY: TEdit
            Left = 102
            Top = 16
            Width = 690
            Height = 22
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnKeyPress = edtZYKeyPress
          end
          object edtJE: TCurrencyEdit
            Left = 102
            Top = 42
            Width = 280
            Height = 21
            AutoSize = False
            DisplayFormat = ',0.00;-,0.00'
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 1
          end
          object rgYWLX: TRadioGroup
            Left = 465
            Top = 33
            Width = 160
            Height = 35
            Caption = #19994#21153#31867#22411
            Columns = 2
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = #23435#20307
            Font.Style = []
            ItemIndex = 0
            Items.Strings = (
              #25903#20184#27719#20817
              #20195#21457#20195#25187)
            ParentFont = False
            TabOrder = 2
            Visible = False
          end
          object edtYDJBH: TEdit
            Left = 683
            Top = 29
            Width = 120
            Height = 22
            TabStop = False
            Color = clWhite
            Enabled = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
            Visible = False
          end
          object edtYDJSJ: TEdit
            Left = 683
            Top = 53
            Width = 120
            Height = 22
            TabStop = False
            Color = clWhite
            Enabled = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -14
            Font.Name = #23435#20307
            Font.Style = []
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            Visible = False
          end
        end
      end
    end
  end
  object ClientDataSetWYZF00: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ProviderPub'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 784
    Top = 72
  end
  object ClientDataSetTmp: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ProviderPub'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 720
    Top = 8
  end
  object MainMenuWYZF: TMainMenu
    AutoHotkeys = maManual
    Left = 832
    Top = 16
    object MFile: TMenuItem
      Caption = #25991#20214'(&F)'
      GroupIndex = 9
      object MPrint: TMenuItem
        Caption = #25171#21360'(&P)'
        ImageIndex = 1
        ShortCut = 16464
        OnClick = MPrintClick
      end
      object MPrintSetup: TMenuItem
        Caption = #25171#21360#39029#38754#35774#32622
        OnClick = MPrintSetupClick
      end
      object MDataTo: TMenuItem
        Caption = #25968#25454#36755#20986'(&O)'
        Enabled = False
        Visible = False
      end
      object MLExit: TMenuItem
        Caption = '-'
      end
      object MExit: TMenuItem
        Caption = #36864#20986'(&X)'
        ImageIndex = 13
        ShortCut = 16472
        OnClick = SpeedItem_ExitClick
      end
    end
    object MRun: TMenuItem
      Caption = #25191#34892'(&R)'
      GroupIndex = 9
      object M_Add: TMenuItem
        Caption = #22686#21152'(&A)'
        ImageIndex = 2
        ShortCut = 16449
        Visible = False
        OnClick = SpeedItem_insertClick
      end
      object M_modify: TMenuItem
        Caption = #20462#25913'(&E)'
        Enabled = False
        ShortCut = 16453
        Visible = False
      end
      object M_save: TMenuItem
        Caption = #20445#23384'(&S)'
        Enabled = False
        ShortCut = 16467
        Visible = False
        OnClick = SpeedItem_SaveClick
      end
      object MLWLDW: TMenuItem
        Caption = '-'
        Enabled = False
        Visible = False
      end
      object M_ZF: TMenuItem
        Caption = #20316#24223
        Enabled = False
        ImageIndex = 18
        OnClick = M_ZFClick
      end
      object M_HY: TMenuItem
        Caption = #36824#21407
        Enabled = False
        OnClick = M_HYClick
      end
      object M_Delete: TMenuItem
        Caption = #21024#38500
        Enabled = False
        OnClick = M_DeleteClick
      end
      object N1: TMenuItem
        Caption = '-'
        Visible = False
      end
      object M_SH: TMenuItem
        Caption = #23457#26680'(&C)'
        Enabled = False
        ImageIndex = 20
        Visible = False
      end
      object M_XS: TMenuItem
        Caption = #28040#23457
        Enabled = False
        ImageIndex = 21
        Visible = False
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object M_QXZX: TMenuItem
        Caption = #21462#28040#25191#34892
        OnClick = M_QXZXClick
      end
      object M_CXZX: TMenuItem
        Caption = #37325#26032#25191#34892
        OnClick = M_CXZXClick
      end
    end
  end
  object cdsGroup: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ProviderPub'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 96
    Top = 328
  end
  object ds: TDataSource
    DataSet = cdsGroup
    Left = 140
    Top = 387
  end
  object cdsZFD: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ProviderPub'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 112
    Top = 536
  end
end
