object frmRptCaller: TfrmRptCaller
  Left = 599
  Top = 117
  Width = 843
  Height = 545
  Caption = #25253#34920
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = MainMenuDLZ
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Splitter1: TSplitter
    Left = 169
    Top = 44
    Width = 4
    Height = 447
  end
  object SpeedBarDLZ: TSpeedBar
    Left = 0
    Top = 0
    Width = 835
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
    object SpeedbarSectionFile: TSpeedbarSection
      Caption = 'File'
    end
    object SpeedbarSectionEdit: TSpeedbarSection
      Caption = 'Edit'
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
      ImageIndex = 0
      Spacing = 1
      Left = 43
      Top = 3
      Visible = True
      OnClick = SpeedItemPrintClick
      SectionName = 'File'
    end
    object SpeedItemReFresh: TSpeedItem
      BtnCaption = #21047#26032
      BtnGrayedInactive = True
      Caption = #21047#26032
      Hint = #21047#26032'|'
      ImageIndex = 5
      Spacing = 1
      Left = 83
      Top = 3
      Visible = True
      OnClick = SpeedItemReFreshClick
      SectionName = 'Edit'
    end
    object btnExport: TSpeedItem
      BtnCaption = #23548#20986
      BtnGrayedInactive = True
      Caption = #23548#20986
      Hint = #23548#20986'|'
      Spacing = 1
      Left = 131
      Top = 3
      Visible = True
      OnClick = btnExportClick
      SectionName = 'Edit'
    end
    object btnLinkSearch: TSpeedItem
      BtnCaption = #32852#26597
      BtnGrayedInactive = True
      Caption = #32852#26597
      Hint = #32852#26597'|'
      Spacing = 1
      Left = 179
      Top = 3
      Visible = True
      OnClick = miLinkSearchClick
      SectionName = 'Edit'
    end
    object SpeedItemHelp: TSpeedItem
      BtnCaption = #24110#21161
      BtnGrayedInactive = True
      Caption = #25171#24320#24110#21161#25991#20214
      Hint = #25171#24320#24110#21161#25991#20214'|'
      ImageIndex = 10
      Spacing = 1
      Left = 123
      Top = 3
      SectionName = 'Help'
    end
    object SpeedItemExit: TSpeedItem
      BtnCaption = #36864#20986
      BtnGrayedInactive = True
      Caption = #36864#20986
      Hint = #36864#20986'|'
      ImageIndex = 11
      Spacing = 1
      Left = 227
      Top = 3
      Visible = True
      OnClick = SpeedItemExitClick
      SectionName = 'Exit'
    end
  end
  object pg: TPageControl
    Left = 0
    Top = 44
    Width = 169
    Height = 447
    ActivePage = tbsPeriod
    Align = alLeft
    TabOrder = 1
    Visible = False
    object tbsUnits: TTabSheet
      Caption = #21333#20301
      object tvUnit: TTreeView
        Left = 0
        Top = 0
        Width = 161
        Height = 420
        Align = alClient
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnDblClick = tvUnitDblClick
      end
    end
    object tbsPeriod: TTabSheet
      Caption = #26399#38388
      ImageIndex = 1
      object tvPeriod: TTreeView
        Left = 0
        Top = 0
        Width = 161
        Height = 420
        Align = alClient
        Indent = 19
        ReadOnly = True
        TabOrder = 0
        OnDblClick = tvPeriodDblClick
      end
    end
  end
  object MainMenuDLZ: TMainMenu
    Left = 128
    Top = 112
    object MFile: TMenuItem
      Caption = #25991#20214'(&F)'
      GroupIndex = 10
      object MPreview: TMenuItem
        Bitmap.Data = {
          4E010000424D4E01000000000000760000002800000012000000120000000100
          040000000000D800000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
          77777700000077777777777777777700000070000000000007700700000070FF
          FFFFFFFF07000700000070FFFFFFF00008007700000070FFFFFF087780877700
          000070FFFFF0877E88077700000070FFFFF0777787077700000070FFFFF07E77
          87077700000070FFFFF08EE788077700000070FFFFFF087780777700000070FF
          FFFFF00007777700000070FFFFFFFFFF07777700000070FFFFFFF00007777700
          000070FFFFFFF07077777700000070FFFFFFF007777777000000700000000077
          777777000000777777777777777777000000}
        Caption = #25171#21360#39044#35272'(&R)'
        ImageIndex = 0
        ShortCut = 16466
        OnClick = MPreviewClick
      end
      object MPrint: TMenuItem
        Bitmap.Data = {
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
        Caption = #25171#21360'(&P)'
        ImageIndex = 1
        ShortCut = 16464
        OnClick = MPrintClick
      end
      object N1: TMenuItem
        Caption = #25171#21360#20840#37096
        OnClick = N1Click
      end
      object miExport: TMenuItem
        Caption = #23548#20986#20840#37096
        OnClick = miExportClick
      end
      object MBDataOut: TMenuItem
        Caption = '-'
      end
      object MExit: TMenuItem
        Bitmap.Data = {
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
        Caption = #36864#20986'(&X)'
        ImageIndex = 11
        ShortCut = 16472
        OnClick = MExitClick
      end
    end
    object MRun: TMenuItem
      Caption = #25191#34892'(&R)'
      GroupIndex = 10
      object MReFresh: TMenuItem
        Caption = #21047#26032'(&R)'
        ImageIndex = 5
        ShortCut = 116
        OnClick = MReFreshClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miHide: TMenuItem
        Caption = #38544#34255#31354#34892
        OnClick = miHideClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object miCalcImm: TMenuItem
        Caption = #25171#24320#31435#21363#35745#31639
        Checked = True
        OnClick = miCalcImmClick
      end
      object miRowNo: TMenuItem
        Caption = #26174#31034#34892#26631
        OnClick = miRowNoClick
      end
      object miColNo: TMenuItem
        Caption = #26174#31034#21015#26631
        OnClick = miColNoClick
      end
      object miRowShow: TMenuItem
        Caption = #34892#26174#31034
        Checked = True
        OnClick = miRowShowClick
      end
      object miReadOnly: TMenuItem
        Caption = #21482#35835
        Checked = True
        OnClick = miReadOnlyClick
      end
      object miLinkSearch: TMenuItem
        Caption = #25253#34920#32852#26597
        OnClick = miLinkSearchClick
      end
      object miKJQJ: TMenuItem
        Caption = #26399#38388
        OnClick = miKJQJClick
      end
    end
  end
  object sg: TSaveDialog
    FileName = 'file'
    Filter = 
      'Excel (*.xls)|*.XLS|'#25991#26412#25991#20214' (*.txt)|*.TXT|'#32593#39029' (*.htm)|*.HTM|'#20998#38548#31526' (*.c' +
      'sv)|*.CSV|Rtf'#25991#26723' (*.rtf)|*.RTF'
    Left = 114
    Top = 230
  end
  object fs: TFormStorage
    Options = []
    StoredProps.Strings = (
      'miColNo.Checked'
      'miRowNo.Checked'
      'miRowShow.Checked'
      'miCalcImm.Checked'
      'miKJQJ.Checked')
    StoredValues = <>
    Left = 120
    Top = 152
  end
end
