object ImpOER_EBKFrmPA: TImpOER_EBKFrmPA
  Left = 378
  Top = 170
  BorderStyle = bsDialog
  Caption = #23548#20837#24037#36164#12289#20854#20182#34218#36164#25910#20837#25968#25454
  ClientHeight = 429
  ClientWidth = 778
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 778
    Height = 91
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label3: TLabel
      Left = 271
      Top = 14
      Width = 60
      Height = 12
      Caption = #21457#25918#27425#25968#65306
    end
    object Label1: TLabel
      Left = 13
      Top = 40
      Width = 60
      Height = 12
      Caption = #21457#25918#39033#30446#65306
    end
    object Label7: TLabel
      Left = 15
      Top = 14
      Width = 60
      Height = 12
      Caption = #24037#36164#31867#21035#65306
    end
    object Label2: TLabel
      Left = 270
      Top = 40
      Width = 60
      Height = 12
      Caption = #21457#25918#38134#34892#65306
    end
    object Label23: TLabel
      Left = 7
      Top = 70
      Width = 65
      Height = 13
      Alignment = taCenter
      Caption = #25903#20184#26041#24335#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 294
      Top = 71
      Width = 36
      Height = 12
      Caption = #20973#35777#65306
    end
    object Bevel1: TBevel
      Left = -1
      Top = 62
      Width = 779
      Height = 2
    end
    object BitBtnOk: TBitBtn
      Left = 527
      Top = 67
      Width = 70
      Height = 22
      Caption = #23548#20837'(&O)'
      TabOrder = 0
      OnClick = BitBtnOkClick
    end
    object BitBtnCancel: TBitBtn
      Left = 602
      Top = 67
      Width = 70
      Height = 22
      Caption = #20851#38381'(&C)'
      TabOrder = 1
      OnClick = BitBtnCancelClick
    end
    object cbFFCS: TComboBox
      Left = 334
      Top = 10
      Width = 187
      Height = 20
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 12
      TabOrder = 2
    end
    object btnSearch: TBitBtn
      Left = 528
      Top = 37
      Width = 70
      Height = 22
      Caption = #26597#35810'(&S)'
      Default = True
      TabOrder = 3
      OnClick = btnSearchClick
    end
    object cbGZLB: TComboBox
      Left = 73
      Top = 10
      Width = 185
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 4
    end
    object cbGZXM: TComboBox
      Left = 73
      Top = 37
      Width = 185
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 5
    end
    object cbYH: TComboBox
      Left = 334
      Top = 37
      Width = 188
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 6
    end
    object ComboBoxYWLX: TComboBox
      Left = 72
      Top = 68
      Width = 184
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 7
      Items.Strings = (
        #20840#37096
        #36716#36134#25903#31080
        #30005#27719
        #29616#37329#25903#31080)
    end
    object edtPZH: TSMaskEdit
      Left = 333
      Top = 67
      Width = 188
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#21152#21152#36755#20837#27861'4.0'
      LBCanUse = True
      Alignment = taLeftJustify
      DataTypePro = dpString
      DataWidth = 0
      DataDec = 0
      LoadButton = True
      OnButtonClick = edtPZHButtonClick
      ParentShowHint = False
      ShowHint = False
      TabOrder = 8
      OnDblClick = edtPZHButtonClick
      OnKeyPress = edtPZHKeyPress
    end
  end
  object grd: TDBGridEh
    Left = 0
    Top = 91
    Width = 778
    Height = 338
    Align = alClient
    AllowedOperations = [alopInsertEh, alopAppendEh]
    DataSource = dsData
    EditActions = [geaCopyEh]
    FooterColor = clWindow
    FooterFont.Charset = GB2312_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -12
    FooterFont.Name = #23435#20307
    FooterFont.Style = []
    FooterRowCount = 1
    FrozenCols = 1
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    SumList.Active = True
    TabOrder = 1
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDblClick = grdDblClick
    Columns = <
      item
        Checkboxes = True
        EditButtons = <>
        FieldName = 'SEL'
        Footer.Value = #21512#35745
        Footer.ValueType = fvtStaticText
        Footers = <>
        KeyList.Strings = (
          '1'
          '0')
        Width = 65
      end
      item
        EditButtons = <>
        FieldName = 'ZYDM'
        Footer.FieldName = 'ZYDM'
        Footer.ValueType = fvtCount
        Footers = <>
        ReadOnly = True
        Title.Caption = #32844#21592#20195#30721
        Width = 76
      end
      item
        EditButtons = <>
        FieldName = 'ZYXM'
        Footers = <>
        Title.Caption = #32844#21592#21517#31216
        Width = 83
      end
      item
        EditButtons = <>
        FieldName = 'BMDM'
        Footers = <>
        Title.Caption = #37096#38376#20195#30721
        Width = 88
      end
      item
        EditButtons = <>
        FieldName = 'BMMC'
        Footers = <>
        Title.Caption = #37096#38376#21517#31216
        Width = 124
      end
      item
        EditButtons = <>
        FieldName = 'GRZH'
        Footers = <>
        ReadOnly = True
        Title.Caption = #38134#34892#36134#21495
        Width = 218
      end
      item
        DisplayFormat = '#,##0.00'
        EditButtons = <>
        FieldName = 'FFJE'
        Footer.DisplayFormat = '#,##0.00'
        Footer.FieldName = 'FFJE'
        Footer.ValueType = fvtSum
        Footers = <>
        ReadOnly = True
        Title.Caption = #21457#25918#37329#39069
        Width = 84
      end>
  end
  object cbAll: TCheckBox
    Left = 14
    Top = 93
    Width = 62
    Height = 13
    Caption = #36873#25321
    TabOrder = 2
    OnClick = cbAllClick
  end
  object fs: TFormStorage
    Options = []
    StoredProps.Strings = (
      'cbFFCS.Text')
    StoredValues = <>
    Left = 672
    Top = 96
  end
  object dsData: TDataSource
    DataSet = cdsData
    Left = 192
    Top = 240
  end
  object cdsData: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 232
  end
  object cdsZFXX: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 240
  end
  object cdsYHXX: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 296
  end
  object ClientDataSetTmp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 640
    Top = 288
  end
end
