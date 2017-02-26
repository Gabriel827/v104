object FormJGXX: TFormJGXX
  Left = 352
  Top = 172
  Width = 668
  Height = 545
  Caption = #38134#34892#26426#26500
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = MainMenuJCZL
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object PanelFirst: TPanel
    Left = 0
    Top = 52
    Width = 652
    Height = 435
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object PanelTop: TPanel
      Left = 0
      Top = 0
      Width = 652
      Height = 6
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
    end
    object PanelLeftMain: TPanel
      Left = 3
      Top = 6
      Width = 187
      Height = 423
      Align = alLeft
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 2
      object DBTreeJCZL: TDBTree
        Left = 0
        Top = 44
        Width = 187
        Height = 379
        Align = alClient
        HideSelection = False
        Images = ImageListTree
        Indent = 19
        ParentShowHint = False
        ReadOnly = True
        RightClickSelect = True
        ShowHint = False
        SortType = stBoth
        TabOrder = 1
        ToolTips = False
        OnChange = DBTreeJCZLChange
        DataSource = DataSourceJCZLTree
        RootName = #25152#26377
      end
      object PanelTitle: TPanel
        Left = 0
        Top = 0
        Width = 187
        Height = 44
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object RxLabelTitle: TRxLabel
          Left = 4
          Top = 3
          Width = 86
          Height = 20
          Caption = #38134#34892#26426#26500
          Font.Charset = GB2312_CHARSET
          Font.Color = 10576962
          Font.Height = -20
          Font.Name = #26999#20307'_GB2312'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
        end
      end
    end
    object PanelMain: TPanel
      Left = 193
      Top = 6
      Width = 456
      Height = 423
      Align = alClient
      BevelOuter = bvNone
      Caption = 'PanelMain'
      TabOrder = 3
      object PanelRightTop: TPanel
        Left = 0
        Top = 0
        Width = 456
        Height = 105
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object GroupBoxJCZL: TGroupBox
          Left = 0
          Top = 0
          Width = 456
          Height = 105
          Align = alClient
          Caption = ' '#24403#21069#38134#34892#26426#26500#20449#24687'(&A)'
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object LabelBS: TLabel
            Left = 24
            Top = 21
            Width = 48
            Height = 12
            Alignment = taRightJustify
            Caption = #26426#26500#20195#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object LabelMC: TLabel
            Left = 163
            Top = 21
            Width = 48
            Height = 12
            Alignment = taRightJustify
            Caption = #26426#26500#21517#31216
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RxLabelDep: TLabel
            Left = 199
            Top = 134
            Width = 6
            Height = 12
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object RxLabelPeople: TLabel
            Left = 198
            Top = 159
            Width = 6
            Height = 12
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object THBevelSYZT: TTHBevel
            Left = 370
            Top = 74
            Width = 50
            Height = 19
            Caption = #24050#20351#29992
            Font.Charset = GB2312_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            Color = clRed
            LineWidth = 1
            Style = bsLine
            Visible = False
          end
          object Label1: TLabel
            Left = 25
            Top = 78
            Width = 48
            Height = 12
            Alignment = taRightJustify
            Caption = #40664#35748#34892#21495
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
            Visible = False
          end
          object Label2: TLabel
            Left = 37
            Top = 50
            Width = 36
            Height = 12
            Alignment = taRightJustify
            Caption = #21161#35760#30721
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = #23435#20307
            Font.Style = []
            ParentFont = False
          end
          object EditBS: TEdit
            Left = 77
            Top = 17
            Width = 76
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            MaxLength = 12
            TabOrder = 0
            OnKeyDown = EditMCKeyDown
            OnKeyPress = EditBSKeyPress
          end
          object EditMC: TEdit
            Left = 216
            Top = 17
            Width = 204
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            ReadOnly = True
            TabOrder = 1
            OnChange = EditMCChange
            OnKeyDown = EditMCKeyDown
          end
          object edtDEFHH: TEdit
            Left = 77
            Top = 74
            Width = 290
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            ReadOnly = True
            TabOrder = 2
            Visible = False
          end
          object edtZJM: TEdit
            Left = 77
            Top = 46
            Width = 343
            Height = 20
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            ReadOnly = True
            TabOrder = 3
          end
        end
      end
      object PageControl1: TPageControl
        Left = 0
        Top = 105
        Width = 456
        Height = 318
        ActivePage = TabSheet2
        Align = alClient
        TabOrder = 1
        object TabSheet1: TTabSheet
          Caption = #38134#34892
          object THDBGridJCZL: TTHDBGrid
            Left = 0
            Top = 0
            Width = 448
            Height = 291
            ReadOnly = True
            DblEqual = True
            PassReadonly = True
            BKColor = clWhite
            HeaderHeight = 36
            RowCount = 2
            AutoNext = False
            HeaderColor = clBtnFace
            OnHeaderDblClick = THDBGridJCZLHeaderDblClick
            HighLightColor = clHighlight
            HighlightTextColor = clHighlightText
            PopAllowUpdown = False
            DefColor = clInfoBk
            DefColorPerRows = 1
            GridTail = False
            GridTailColor = clBlack
            GridTailHeight = 20
            Align = alClient
            DataSource = DataSourceJCZL
            ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            Ctl3DThickNess = 2
            ShowLock = True
            RowsHeight = 18
            LineColor = clBtnFace
            Col = 1
            Row = 1
          end
        end
        object TabSheet2: TTabSheet
          Caption = #21345'BIN'
          ImageIndex = 1
          object grdCardBIN: TDBGridEh
            Left = 0
            Top = 29
            Width = 448
            Height = 262
            Align = alClient
            AllowedSelections = [gstRecordBookmarks, gstRectangle, gstAll]
            DataSource = dsCardBIN
            EditActions = [geaCopyEh, geaPasteEh]
            Flat = True
            FooterColor = clWindow
            FooterFont.Charset = GB2312_CHARSET
            FooterFont.Color = clWindowText
            FooterFont.Height = -12
            FooterFont.Name = #23435#20307
            FooterFont.Style = []
            Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
            OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghIncSearch, dghDblClickOptimizeColWidth, dghDialogFind]
            TabOrder = 0
            TitleFont.Charset = GB2312_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -12
            TitleFont.Name = #23435#20307
            TitleFont.Style = []
            Columns = <
              item
                EditButtons = <>
                FieldName = 'BINCODE'
                Footers = <>
                Title.Caption = #21345'BIN'
                Width = 116
              end
              item
                EditButtons = <>
                FieldName = 'CARDTYPE'
                Footers = <>
                Title.Caption = #21345#31867#22411
                Width = 133
              end
              item
                EditButtons = <>
                FieldName = 'CARDLEN'
                Footers = <>
                Title.Caption = #21345#21495#38271#24230
                Width = 89
              end
              item
                EditButtons = <>
                FieldName = 'DEFBANK'
                Footers = <>
                Title.Caption = #32852#34892#21495
                Width = 89
              end>
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 448
            Height = 29
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object btnADD: TButton
              Left = 1
              Top = 2
              Width = 49
              Height = 25
              Caption = #28155#21152
              TabOrder = 0
              OnClick = btnADDClick
            end
            object btnDelete: TButton
              Left = 55
              Top = 2
              Width = 49
              Height = 25
              Caption = #21024#38500
              TabOrder = 1
              OnClick = btnDeleteClick
            end
            object btnSave: TButton
              Left = 111
              Top = 2
              Width = 49
              Height = 25
              Caption = #20445#23384
              Enabled = False
              TabOrder = 2
              OnClick = btnSaveClick
            end
            object btnCancel: TButton
              Left = 168
              Top = 2
              Width = 49
              Height = 25
              Caption = #21462#28040
              Enabled = False
              TabOrder = 3
              OnClick = btnCancelClick
            end
            object btnImportBIN: TButton
              Left = 229
              Top = 2
              Width = 49
              Height = 25
              Caption = #23548#20837
              TabOrder = 4
              OnClick = btnImportBINClick
            end
          end
        end
      end
    end
    object PanelLeft: TPanel
      Left = 0
      Top = 6
      Width = 3
      Height = 423
      Align = alLeft
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 1
    end
    object PanelRight: TPanel
      Left = 649
      Top = 6
      Width = 3
      Height = 423
      Align = alRight
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 4
    end
    object PanelBottom: TPanel
      Left = 0
      Top = 429
      Width = 652
      Height = 6
      Align = alBottom
      BevelOuter = bvNone
      Caption = ' '
      TabOrder = 6
    end
    object RxSplitter1: TRxSplitter
      Left = 190
      Top = 6
      Width = 3
      Height = 423
      ControlFirst = PanelLeftMain
      Align = alLeft
      BevelOuter = bvNone
    end
  end
  object PanelSpeedBar: TPanel
    Left = 0
    Top = 0
    Width = 652
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object PanelSpeedBarCenter: TPanel
      Left = 0
      Top = 0
      Width = 652
      Height = 52
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object SpeedBar: TSpeedBar
        Left = 0
        Top = 0
        Width = 652
        Height = 48
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
        Images = ImageListBtn
        BevelOuter = bvNone
        TabOrder = 0
        OnDblClick = SpeedBarDblClick
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
        object SpeedItemPreview: TSpeedItem
          BtnCaption = #39044#35272
          BtnGrayedInactive = True
          Caption = #39044#35272
          Hint = #39044#35272
          ImageIndex = 0
          Spacing = -2
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
          Hint = #25171#21360
          ImageIndex = 1
          Spacing = -2
          Left = 43
          Top = 3
          Visible = True
          OnClick = SpeedItemPrintClick
          SectionName = 'File'
        end
        object SpeedItemAdd: TSpeedItem
          BtnCaption = #22686#21152
          BtnGrayedInactive = True
          Caption = #22686#21152
          Hint = #22686#21152
          ImageIndex = 6
          Spacing = -2
          Left = 83
          Top = 3
          Visible = True
          OnClick = SpeedItemAddClick
          SectionName = 'Edit'
        end
        object SpeedItemDelete: TSpeedItem
          BtnCaption = #21024#38500
          BtnGrayedInactive = True
          Caption = #21024#38500
          Hint = #21024#38500
          ImageIndex = 7
          Spacing = -2
          Left = 123
          Top = 3
          Visible = True
          OnClick = SpeedItemDeleteClick
          SectionName = 'Edit'
        end
        object SpeedItemEdit: TSpeedItem
          BtnCaption = #20462#25913
          BtnGrayedInactive = True
          Caption = #20462#25913
          Hint = #20462#25913
          ImageIndex = 13
          Spacing = 1
          Left = 163
          Top = 3
          Visible = True
          OnClick = SpeedItemEditClick
          SectionName = 'Edit'
        end
        object SpeedItemSave: TSpeedItem
          BtnCaption = #20445#23384
          BtnGrayedInactive = True
          Caption = #20445#23384
          Hint = #20445#23384
          ImageIndex = 12
          Margin = 0
          Spacing = 0
          Left = 203
          Top = 3
          Visible = True
          OnClick = SpeedItemSaveClick
          SectionName = 'Edit'
        end
        object SpeedItemCancel: TSpeedItem
          BtnCaption = #21462#28040
          BtnGrayedInactive = True
          Caption = #21462#28040
          Hint = #21462#28040
          ImageIndex = 4
          Spacing = -2
          Left = 243
          Top = 3
          Visible = True
          OnClick = SpeedItemCancelClick
          SectionName = 'Edit'
        end
        object btnImportDEP: TSpeedItem
          BtnCaption = #23548#20837
          BtnGrayedInactive = True
          Caption = #23548#20837
          Hint = #23548#20837'|'
          Spacing = 1
          Left = 283
          Top = 3
          Visible = True
          OnClick = btnImportDEPClick
          SectionName = 'Edit'
        end
        object SpeedItemFind: TSpeedItem
          BtnCaption = #26597#25214
          BtnGrayedInactive = True
          Caption = #26597#25214
          Hint = #26597#25214
          ImageIndex = 2
          Spacing = -2
          Left = 323
          Top = 3
          Visible = True
          OnClick = SpeedItemFindClick
          SectionName = 'Run'
        end
        object SpeedItemRefresh: TSpeedItem
          BtnCaption = #21047#26032
          BtnGrayedInactive = True
          Caption = #21047#26032
          Hint = #21047#26032
          ImageIndex = 5
          Spacing = -2
          Left = 363
          Top = 3
          Visible = True
          OnClick = SpeedItemRefreshClick
          SectionName = 'Run'
        end
        object SpeedItemFilter: TSpeedItem
          BtnCaption = #31579#36873
          BtnGrayedInactive = True
          Caption = #31579#36873
          Hint = #31579#36873
          ImageIndex = 3
          Spacing = 1
          Left = 411
          Top = 3
          Visible = True
          OnClick = SpeedItemFilterClick
          SectionName = 'Run'
        end
        object SpeedItemNoFilter: TSpeedItem
          BtnCaption = #24674#22797
          BtnGrayedInactive = True
          Caption = #24674#22797
          Hint = #24674#22797
          ImageIndex = 4
          Spacing = 1
          Left = 451
          Top = 3
          Visible = True
          OnClick = SpeedItemNoFilterClick
          SectionName = 'Run'
        end
        object SpeedItemHelp: TSpeedItem
          Tag = 1
          BtnCaption = #24110#21161
          BtnGrayedInactive = True
          Caption = #25171#24320#24110#21161#25991#20214
          Hint = #25171#24320#24110#21161#25991#20214
          ImageIndex = 8
          Spacing = -2
          Left = 491
          Top = 3
          Visible = True
          OnClick = SpeedItemHelpClick
          SectionName = 'Help'
        end
        object SpeedItemExit: TSpeedItem
          Tag = 1
          BtnCaption = #36864#20986
          BtnGrayedInactive = True
          Caption = #36864#20986
          Hint = #36864#20986
          ImageIndex = 9
          Spacing = -2
          Left = 531
          Top = 3
          Visible = True
          OnClick = SpeedItemExitClick
          SectionName = 'Exit'
        end
      end
    end
  end
  object ClientDataSetJCZLTree: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'xmdm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'gsdm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'xmmc'
        Attributes = [faFixed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'zjm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ksrq'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'jsrq'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'bmdm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'bm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ren'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'zy'
        Attributes = [faFixed]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'syzt'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Jlr_ID'
        DataType = ftSmallint
      end
      item
        Name = 'Jl_RQ'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Xgr_ID'
        DataType = ftSmallint
      end
      item
        Name = 'Xg_RQ'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Sjly'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end>
    IndexDefs = <>
    Params = <
      item
        DataType = ftString
        Name = 'gsdm'
        ParamType = ptInput
      end>
    ProviderName = 'DataSetProviderSearchXDF'
    RemoteServer = DataModulePub.MidasConnectionPub
    StoreDefs = True
    Left = 64
    Top = 179
  end
  object DataSourceJCZLTree: TDataSource
    DataSet = ClientDataSetJCZLTree
    Left = 72
    Top = 227
  end
  object DataSourceJCZL: TDataSource
    DataSet = ClientDataSetJCZLGrid
    Left = 112
    Top = 355
  end
  object ImageListTree: TImageList
    Left = 128
    Top = 280
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000007B7B00007B
      7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF0000000000007B
      7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF000000
      0000007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B
      7B00007B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD00BDBD
      BD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBDBD00BDBD
      BD00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF0000000000007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B
      7B00007B7B00007B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B0000007B0000007B0000007B00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000
      00000000000000000000000000000000000000000000FFFFFF0000FFFF00FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B0000007B0000007B0000007B00000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF000000000000FFFF000000000000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      000000FFFF000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B0000007B0000007B0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDBDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF000000000000FFFF0000000000000000000000000000000000000000000000
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
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFF001FFFFF0000
      FFFF000FFFFF0000FFFF0007C00F0000C0070003DFEF000080070001DFEF0000
      95570000D86F0000AAA7001FDFEF00009557001FD86F0000AAA7001FDFEF0000
      95578FF1D88F0000800FFFF9DF8F0000CAFFFF75DF9F0000E1FFFF8FC03F0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object THFilterJCZL: TTHFilter
    GridCols = <>
    DatasetFilter = ClientDataSetJCZLGrid
    UseOnFilterRecord = True
    GridItems = <>
    LeftCols = 2
    UseFormName = False
    OnFilter = THFilterJCZLFilter
    Left = 232
    Top = 234
  end
  object ImageListBtn: TImageList
    Height = 22
    Width = 22
    Left = 152
    Top = 69
    Bitmap = {
      494C01010F001300040016001600FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000580000006E00000001002000000000004097
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B00007B7B00000000000000000000000000000000000000
      000000000000000000000000000000000000007B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B00007B7B00000000000000000000000000000000000000
      000000000000000000000000000000000000007B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF000000000000000000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B00007B7B00000000000000000000000000000000000000
      000000000000000000000000000000000000007B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFF0000FFFF0000FFFF0000FFFF0000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF0000000000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B00007B7B00000000000000000000000000000000000000
      000000000000000000000000000000000000007B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000000000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      8400000084000000840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B00007B7B00007B7B00007B7B00007B7B00007B7B00007B
      7B00007B7B00007B7B00007B7B00007B7B00007B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      00000000000000FFFF000000000000000000000000000000000000000000FFFF
      FF0000FFFF00FFFFFF0000FFFF0000000000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000008484000000840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B00007B7B00000000000000000000000000000000000000
      0000000000000000000000000000007B7B00007B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000000000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000008484000000840000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000007B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF0000000000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      00000084840000008400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000007B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF00000000000000000000FF
      FF00FFFFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000008484000000840000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000007B7B0000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF00000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000007B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000007B7B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000008484840000000000848484000000000084848400000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484008484
      8400848484008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400000000008484840000000000848484000000000084848400000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400000000000000000000000000000000000000
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
      00000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FF000000FF000000FF000000FF000000FF000000FF000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B0000007B0000007B0000007B0000007B0000007B0000007B00
      00007B0000007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B007B0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00000000007B7B7B007B7B7B0000000000FFFFFF007B7B
      7B00FFFFFF00000000007B7B7B007B7B7B0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000007B007B0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007B7B
      7B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      00007B7B00007B7B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000FF00FF000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7B7B0000000000FFFFFF00FFFFFF00FFFFFF0000FFFF000000FF000000
      FF00FFFFFF0000FFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      00007B7B00007B7B000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF0000FFFF00FFFFFF000000FF000000
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      00007B7B00000000000000000000FFFFFF00FFFFFF0000000000000000000000
      000000000000000000007B000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF007B00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B000000000000FFFF00FFFFFF0000FFFF00FFFFFF007B7B
      7B00FFFFFF0000FFFF00FFFFFF0000FFFF00000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      00007B7B00007B7B000000000000FFFFFF00FFFFFF0000000000000000000000
      0000000000007B0000007B000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000007B000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00000000000000000000000000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000FFFFFF0000FFFF00FFFFFF000000FF000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF00000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      00007B7B00007B7B000000000000FFFFFF00FFFFFF0000000000000000000000
      00007B0000007B0000007B0000007B0000007B00000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B000000FFFFFF000000000000000000FFFFFF007B0000007B00
      00007B0000007B00000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000007B7B00007B7B00000000000000
      00000000000000000000FFFF0000FFFF0000FFFF000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF00FFFFFF0000FFFF000000FF000000
      FF000000000000FFFF00FFFFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      00007B7B00007B7B000000000000FFFFFF00FFFFFF0000000000000000007B00
      00007B0000007B0000007B0000007B0000007B00000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000007B000000FFFFFF00FFFFFF00FFFFFF00FFFFFF007B000000FFFF
      FF007B0000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFF0000FFFF000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF0000000000000000000000000000FFFF000000
      FF000000FF0000000000000000000000000000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      00007B7B00007B7B000000000000FFFFFF00FFFFFF0000000000000000000000
      00007B0000007B0000007B0000007B0000007B00000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF007B000000FFFFFF00FFFFFF00FFFFFF00FFFFFF007B0000007B00
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF000000FF000000FF00FFFFFF0000FFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      00007B7B000000000000FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000007B0000007B000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000000000000000000FFFF
      FF00000000007B0000007B0000007B0000007B0000007B0000007B0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF000000FF000000FF0000FFFF00FFFF
      FF000000FF000000FF0000FFFF00FFFFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000007B000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000FFFF000000FF000000FF00FFFFFF0000FF
      FF000000FF000000FF00FFFFFF0000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF00000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000FFFF000000FF000000FF000000
      FF000000FF00FFFFFF0000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      000000000000007B000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000007B00000000000000000000000000000000000000000000000000000000
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
      000000000000000000000000FF00000000000000000000000000000000000000
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
      000000000000000000000000FF0000007B000000000000000000000000000000
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
      000000000000000000000000FF0000007B000000000000000000000000000000
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
      000000000000000000000000FF0000007B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF0000007B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF0000007B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000007B000000
      7B0000007B0000007B0000007B0000007B0000007B0000007B0000007B000000
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF0000007B0000007B0000007B0000007B
      0000007B0000007B0000007B0000007B0000007B0000007B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000007B000000
      7B0000007B0000007B0000007B0000007B0000007B0000007B0000007B000000
      7B00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF0000007B0000007B0000007B0000007B
      0000007B0000007B0000007B0000007B0000007B0000007B0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF0000007B00000000000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000FF000000FF000000FF000000FF000000FF
      000000FF000000FF000000FF000000FF000000FF000000FF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF0000007B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF0000007B000000000000000000000000000000
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
      000000000000000000000000FF0000007B000000000000000000000000000000
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
      000000000000000000000000FF0000007B000000000000000000000000000000
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
      000000000000000000000000FF000000FF000000FF0000000000000000000000
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
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848400008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      00000000000000000000000000007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B0000000000000000007B7B7B00000000007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000FFFF0000FFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848400008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B000000
      000000000000FFFF00007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007B7B7B007B7B7B007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848400008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      000000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFF
      000000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484000084848400FFFF0000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B7B00FFFF
      0000FFFF0000000000007B7B7B007B7B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484840084848400FFFF0000FFFF00008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000007B7B
      7B0000000000000000007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848400008484840000000000FFFF00008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF000000
      000000000000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084840000848484000000000000000000FFFF000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400848484000000000000000000FFFF0000FFFF0000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484000084848400000000000000000000000000FFFF0000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008484000084848400000000000000000000000000FFFF0000FFFF00008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000848484008484840000000000000000000000000000000000FFFF00008484
      8400848484000000000000000000000000000000000000000000000000000000
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
      28000000580000006E0000000100010000000000280500000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FFFFFFFFFFFFFFFF
      C0000000FFFFFFFFFFFFFFFFC0000000FFFFFFFFFFFFFFFFC0000000FFFFFFC0
      1FFFFFFFC0000000F8003FBFEFFF80FFC0000000F0063FA0027F007FC0000000
      F0063FBF007F007FC0000000F0063FA0007F007FC0000000F0003FB0007F006F
      C0000000F0003FA0007F1067C0000000F0003FB8007F1003C0000000F1FE3FA0
      007F1001C0000000F1FE3FBE007F1003C0000000F1FE3FA003FF1867C0000000
      F1FE3FBF8FFF006FC0000000F1FE3F9547FF007FC0000000F1FEBFC003FF007F
      C0000000F0003FC011FF007FC0000000FFFFFFAABBFF80FFC0000000FFFFFFFF
      FFFFFFFFC0000000FFFFFFFFFFFFFFFFC0000000FFFFFFFFFFFFFFFFC0000000
      FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFF
      FFFFFF00FF83FFFDFFFFFFFFFFF38F00F0281FF9FFFFFFFFFFE00F00F3C79FF1
      FFFFF803FF800F00F0001FE1FFFFF803FF800F00F0001F8003FFF803FF800F00
      F0001FC03FFE0003FF800F00F8003FC03DFE0003FF800F00F8003FC039FE0003
      FE000F00F8103FC0307E0003FC000F00F8007FC0207E0007FC007F00F8007FC0
      307E000FFE03FF00F8007FC039FE001FFF1FFF00F8007FC03DFE01FFFFE1FF00
      FC00FFC03FFE03FFFFC1FF00FE01FFC03FFE07FFFF81FF00FF03FFFFFFFFFFFF
      FF83FF00FFFFFFFFFFFFFFFFFFC7FF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFF
      FFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00
      FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFE3FFFFC7F
      FFFFFF00FFFFFFF9CFFFFC7FFFFFFF00FFFFFFF7F7FFFC7FFFFFFF00FFFFFFF7
      FBFFFC7FFFFFFF00FFFCFFEFFFFFFC7FFFFFFF00F83E7FEFFFFFE007FF001F00
      F87F7FEFFFFFC007FE001F00F8FF7FEFFBFFC007FE001F00F97F7FEFF3FFC00F
      FE003F00FB9E7FEFE3FFFC7FFFFFFF00FFE0FFF7C3FFFC7FFFFFFF00FFFFFFF7
      F3FFFC7FFFFFFF00FFFFFFF9CBFFFC7FFFFFFF00FFFFFFFE3FFFFC7FFFFFFF00
      FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFF
      FFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFF
      FFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF00
      E0019FE003FFFFFFFFFFFF00E0011FDFF5FE0F83FFE1FF00E0003F8002FE0F83
      FFE1FF00E00C7FBF18FE0F83FFE1FF00E0187FBF1AFE0203FFE0FF00E03D7F80
      037E0003FFD2FF00E02D7FBFF57E0403FFC0FF00E0047FC00A7E0403FFA07F00
      E00CFFE0057F0007FF423F00E001FFF000FF820FFF133F00E001FFF003FF820F
      FEA31F00E001FFF803FFC71FFE039F00E00BFFF801FFC71FFD538F00E007FFFC
      01FFC71FFC23C700E00FFFFFFFFFFFFFF8000700FFFFFFFFFFFFFFFFFFFFFF00
      FFFFFFFFFFFFFFFFFFFFFF00FFFFFFFFFFFFFFFFFFFFFF000000000000000000
      0000000000000000000000000000}
  end
  object MainMenuJCZL: TMainMenu
    Images = ImageListBtn
    Left = 40
    Top = 336
    object MFile: TMenuItem
      Caption = #25991#20214'(&F)'
      GroupIndex = 10
      object N_Preview: TMenuItem
        Caption = #25171#21360#39044#35272'(&R)'
        ImageIndex = 0
        ShortCut = 16466
        OnClick = SpeedItemClick
      end
      object N_Print: TMenuItem
        Caption = #25171#21360'(&P)'
        ImageIndex = 1
        ShortCut = 16464
        OnClick = SpeedItemClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object N_Export: TMenuItem
        Caption = #25968#25454#36755#20986'(&O)'
        ImageIndex = 14
        OnClick = SpeedItemClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object N_Exit: TMenuItem
        Tag = 1
        Caption = #36864#20986'(&X)'
        ImageIndex = 9
        ShortCut = 16465
        OnClick = SpeedItemClick
      end
    end
    object MRun: TMenuItem
      Caption = #25191#34892'(&R)'
      GroupIndex = 10
      object N_Add: TMenuItem
        Caption = #22686#21152'(&A)'
        ImageIndex = 6
        ShortCut = 16449
        OnClick = SpeedItemClick
      end
      object N_Delete: TMenuItem
        Caption = #21024#38500'(&D)'
        ImageIndex = 7
        ShortCut = 16452
        OnClick = SpeedItemClick
      end
      object N_Edit: TMenuItem
        Caption = #20462#25913'(&E)'
        ImageIndex = 13
        OnClick = SpeedItemClick
      end
      object N_Save: TMenuItem
        Caption = #20445#23384'(&S)'
        ImageIndex = 12
        ShortCut = 16467
        OnClick = SpeedItemClick
      end
      object N_Cancel: TMenuItem
        Caption = #21462#28040'(&C)'
        ImageIndex = 4
        OnClick = SpeedItemClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object N_Find: TMenuItem
        Caption = #26597#25214'(&L)'
        ImageIndex = 2
        ShortCut = 16454
        OnClick = SpeedItemClick
      end
      object N_Refresh: TMenuItem
        Caption = #21047#26032'(&R)'
        ImageIndex = 5
        ShortCut = 116
        OnClick = SpeedItemClick
      end
      object N_Filter: TMenuItem
        Caption = #31579#36873'(&F)'
        object N_DoFilter: TMenuItem
          Caption = #31579#36873#36873#39033'(&F)'
          ImageIndex = 3
          OnClick = SpeedItemClick
        end
        object N_NoFilter: TMenuItem
          Caption = #21462#28040#31579#36873'(&N)'
          ImageIndex = 4
          OnClick = SpeedItemClick
        end
      end
      object N_XF: TMenuItem
        Caption = '-'
        Visible = False
      end
      object N_XFSFMX: TMenuItem
        Caption = #20462#22797#36164#26009#26126#32454#23646#24615'(&M)'
        Visible = False
      end
      object N_XFDQJC: TMenuItem
        Caption = #20462#22797#36164#26009#32423#27425#23646#24615'(&J)'
        Visible = False
      end
      object N_XFZLZJM: TMenuItem
        Caption = #20462#22797#36164#26009#21161#35760#30721#23646#24615
        Visible = False
      end
      object N_XFYWDJ: TMenuItem
        Caption = #20462#22797#19994#21153#21333#25454#36164#26009#21517#31216
        Visible = False
      end
    end
  end
  object PopupMenuJCZL: TPopupMenu
    Images = ImageListBtn
    Left = 40
    Top = 280
  end
  object FinderJCZL: TFinder
    Caption = #26597#25214#22522#30784#36164#26009
    OnFound = FinderJCZLFound
    Left = 136
    Top = 164
  end
  object ClientDataSetSave: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProviderSaveXDF'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 80
    Top = 304
  end
  object FormPrintJCZL: TFormPrint
    OtherItems = <
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptCompany
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptPrintMan
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptDate
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
        DataType = ptPageNumber
      end
      item
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #26999#20307'_GB2312'
        Font.Style = []
        DataType = ptTitle
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
      end
      item
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #23435#20307
        Font.Style = []
      end>
    ColumnItems = <>
    Grid = THDBGridJCZL
    GridLeft = 17
    GridTop = 251
    HelpContext = 0
    Orientation = poPortrait
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    WordOffsetX = 3
    WordOffsetY = 3
    Option = [PrintGridFirstLine, PrintGridLine, ThickFrame, ThinFrame, AnyiMark, fullwidth, PrintOneOther]
    OffsetLeft = 0
    OffsetTop = 0
    PrintRowCount = 34
    PrintIfEmpty = False
    SnapToGrid = False
    ShowProgress = False
    Zoom = 0
    FixedCols = 0
    PrintSum = False
    PrintSumEndRow = False
    ExclusionRecord = 0
    CalcFilterColID = 0
    Left = 27
    Top = 116
  end
  object HFExpandPrintJCZL: THFExpandPrint
    ASprint = FormPrintJCZL
    Left = 99
    Top = 108
  end
  object ClientDataSetJCZLGrid: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'xmdm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'gsdm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'xmmc'
        Attributes = [faFixed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'zjm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ksrq'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'jsrq'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'bmdm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'bm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ren'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'zy'
        Attributes = [faFixed]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'syzt'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Jlr_ID'
        DataType = ftSmallint
      end
      item
        Name = 'Jl_RQ'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Xgr_ID'
        DataType = ftSmallint
      end
      item
        Name = 'Xg_RQ'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Sjly'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end>
    IndexDefs = <>
    Params = <
      item
        DataType = ftString
        Name = 'gsdm'
        ParamType = ptInput
      end>
    ProviderName = 'DataSetProviderPubStatic'
    RemoteServer = DataModulePub.MidasConnectionPub
    StoreDefs = True
    AfterScroll = ClientDataSetJGXXGridAfterScroll
    Left = 144
    Top = 235
  end
  object cdsCardBIN: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'xmdm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'gsdm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'xmmc'
        Attributes = [faFixed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'zjm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'ksrq'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'jsrq'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'bmdm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end
      item
        Name = 'bm'
        Attributes = [faFixed]
        DataType = ftString
        Size = 20
      end
      item
        Name = 'ren'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'zy'
        Attributes = [faFixed]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'syzt'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Jlr_ID'
        DataType = ftSmallint
      end
      item
        Name = 'Jl_RQ'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Xgr_ID'
        DataType = ftSmallint
      end
      item
        Name = 'Xg_RQ'
        Attributes = [faFixed]
        DataType = ftString
        Size = 8
      end
      item
        Name = 'Sjly'
        Attributes = [faFixed]
        DataType = ftString
        Size = 12
      end>
    IndexDefs = <>
    Params = <
      item
        DataType = ftString
        Name = 'gsdm'
        ParamType = ptInput
      end>
    ProviderName = 'DataSetProviderPubStatic'
    RemoteServer = DataModulePub.MidasConnectionPub
    StoreDefs = True
    AfterEdit = cdsCardBINAfterEdit
    OnNewRecord = cdsCardBINNewRecord
    Left = 240
    Top = 395
  end
  object dsCardBIN: TDataSource
    DataSet = cdsCardBIN
    Left = 304
    Top = 395
  end
end
