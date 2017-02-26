object ImpBM_EBKFrm: TImpBM_EBKFrm
  Left = 124
  Top = 244
  BorderStyle = bsDialog
  Caption = #23548#20837#36164#37329#25968#25454
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
    Height = 69
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 17
      Width = 60
      Height = 12
      Caption = #21333#25454#31867#22411#65306
    end
    object Label3: TLabel
      Left = 256
      Top = 17
      Width = 60
      Height = 12
      Caption = #32467#31639#26041#24335#65306
    end
    object Label1: TLabel
      Left = 16
      Top = 42
      Width = 60
      Height = 12
      Caption = #24320#22987#26085#26399#65306
    end
    object Label4: TLabel
      Left = 256
      Top = 44
      Width = 60
      Height = 12
      Caption = #32467#26463#26085#26399#65306
    end
    object Label27: TLabel
      Left = 494
      Top = 16
      Width = 60
      Height = 12
      Caption = #19994#21153#31867#22411#65306
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object cmbDJLX: TComboBox
      Left = 75
      Top = 13
      Width = 169
      Height = 20
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 12
      TabOrder = 0
    end
    object BitBtnOk: TBitBtn
      Left = 568
      Top = 36
      Width = 70
      Height = 22
      Caption = #23548#20837'(&O)'
      TabOrder = 1
      OnClick = BitBtnOkClick
    end
    object BitBtnCancel: TBitBtn
      Left = 643
      Top = 36
      Width = 70
      Height = 22
      Caption = #20851#38381'(&C)'
      TabOrder = 2
      OnClick = BitBtnCancelClick
    end
    object ComboBoxYWLX: TComboBox
      Left = 317
      Top = 13
      Width = 160
      Height = 20
      Style = csDropDownList
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      ItemHeight = 12
      TabOrder = 3
    end
    object btnSearch: TBitBtn
      Left = 494
      Top = 36
      Width = 70
      Height = 22
      Caption = #26597#35810'(&S)'
      Default = True
      TabOrder = 4
      OnClick = btnSearchClick
    end
    object dtStart: TDateTimePicker
      Left = 75
      Top = 40
      Width = 169
      Height = 20
      Date = 41255.922570011570000000
      Time = 41255.922570011570000000
      DateFormat = dfLong
      TabOrder = 5
    end
    object dtEnd: TDateTimePicker
      Left = 317
      Top = 39
      Width = 161
      Height = 20
      Date = 41255.922570011570000000
      Time = 41255.922570011570000000
      DateFormat = dfLong
      TabOrder = 6
    end
    object ComboBoxJKLX: TComboBox
      Left = 564
      Top = 12
      Width = 158
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
  end
  object grd: TDBGridEh
    Left = 0
    Top = 69
    Width = 778
    Height = 360
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
    FrozenCols = 1
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
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
        Footers = <>
        KeyList.Strings = (
          '1'
          '0')
      end
      item
        EditButtons = <>
        FieldName = 'jsdywbh'
        Footers = <>
        ReadOnly = True
        Title.Caption = #21333#25454#32534#21495
        Width = 99
      end
      item
        EditButtons = <>
        FieldName = 'ywrq'
        Footers = <>
        ReadOnly = True
        Title.Caption = #21333#25454#26085#26399
        Width = 118
      end
      item
        EditButtons = <>
        FieldName = 'JE'
        Footers = <>
        ReadOnly = True
        Title.Caption = #37329#39069
        Width = 97
      end
      item
        EditButtons = <>
        FieldName = 'wldwmc'
        Footers = <>
        Title.Caption = #25910#27454#20154
        Width = 111
      end
      item
        EditButtons = <>
        FieldName = 'wlzh'
        Footers = <>
        Title.Caption = #25910#27454#38134#34892#36134#25143
        Width = 134
      end
      item
        EditButtons = <>
        FieldName = 'skhyh'
        Footers = <>
        Title.Caption = #25910#27454#24320#25143#38134#34892
        Width = 119
      end
      item
        EditButtons = <>
        FieldName = 'ZY'
        Footers = <>
        ReadOnly = True
        Title.Caption = #25688#35201
        Width = 121
      end>
  end
  object cbAll: TCheckBox
    Left = 14
    Top = 72
    Width = 63
    Height = 14
    Caption = #36873#25321
    TabOrder = 2
    OnClick = cbAllClick
  end
  object fs: TFormStorage
    Options = []
    StoredProps.Strings = (
      'ComboBoxYWLX.Text')
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
