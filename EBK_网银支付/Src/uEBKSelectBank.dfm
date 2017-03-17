object frmSelectBank: TfrmSelectBank
  Left = 385
  Top = 168
  Width = 484
  Height = 537
  Caption = #24320#25143#34892#36873#25321
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 16
    Width = 13
    Height = 13
    Caption = #30465
  end
  object Label2: TLabel
    Left = 212
    Top = 16
    Width = 13
    Height = 13
    Caption = #24066
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 26
    Height = 13
    Caption = #38134#34892
  end
  object Label4: TLabel
    Left = 200
    Top = 48
    Width = 26
    Height = 13
    Caption = #27169#31946
  end
  object cmbProvice: TComboBox
    Left = 48
    Top = 12
    Width = 145
    Height = 21
    ItemHeight = 13
    ItemIndex = 22
    TabOrder = 0
    Text = '51 '#22235#24029#30465
    OnChange = cmbProviceChange
    Items.Strings = (
      '11 '#21271#20140#24066
      '12 '#22825#27941#24066
      '13 '#27827#21271#30465
      '14 '#23665#35199#30465
      '15 '#20869#33945#21476#33258#27835#21306
      '21 '#36797#23425#30465
      '22 '#21513#26519#30465
      '23 '#40657#40857#27743#30465
      '31 '#19978#28023#24066
      '32 '#27743#33487#30465
      '33 '#27993#27743#30465
      '34 '#23433#24509#30465
      '35 '#31119#24314#30465
      '36 '#27743#35199#30465
      '37 '#23665#19996#30465
      '41 '#27827#21335#30465
      '42 '#28246#21271#30465
      '43 '#28246#21335#30465
      '44 '#24191#19996#30465
      '45 '#24191#35199#22766#26063#33258#27835#21306
      '46 '#28023#21335#30465
      '50 '#37325#24198#24066
      '51 '#22235#24029#30465
      '52 '#36149#24030#30465
      '53 '#20113#21335#30465
      '54 '#35199#34255#33258#27835#21306
      '61 '#38485#35199#30465
      '62 '#29976#32899#30465
      '63 '#38738#28023#30465
      '64 '#23425#22799#22238#26063#33258#27835#21306
      '65 '#26032#30086#32500#21566#23572#33258#27835#21306
      '71 '#21488#28286#30465
      '81 '#39321#28207#29305#21035#34892#25919#21306
      '82 '#28595#38376#29305#21035#34892#25919#21306)
  end
  object cmbCity: TComboBox
    Left = 233
    Top = 12
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 1
  end
  object cmbBank: TComboBox
    Left = 48
    Top = 44
    Width = 145
    Height = 21
    Style = csDropDownList
    DropDownCount = 15
    ItemHeight = 13
    TabOrder = 2
  end
  object edtFilter: TEdit
    Left = 233
    Top = 44
    Width = 145
    Height = 21
    TabOrder = 3
  end
  object btnSearch: TButton
    Left = 385
    Top = 11
    Width = 75
    Height = 22
    Caption = #26597#25214'(&F)'
    TabOrder = 4
    OnClick = btnSearchClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 72
    Width = 468
    Height = 427
    Align = alBottom
    Caption = 'Panel1'
    TabOrder = 5
    object grdWY: TDBGridEh
      Left = 1
      Top = 1
      Width = 466
      Height = 425
      Align = alClient
      AllowedSelections = [gstRecordBookmarks, gstRectangle, gstAll]
      DataSource = dsWY
      EditActions = [geaCopyEh, geaPasteEh]
      Flat = True
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -13
      FooterFont.Name = #23435#20307
      FooterFont.Style = []
      Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = #23435#20307
      TitleFont.Style = []
      UseMultiTitle = True
      OnDblClick = btnOKClick
      Columns = <
        item
          EditButtons = <>
          FieldName = 'BANK_CODE'
          Footers = <>
          Title.Caption = #32852#34892#21495
          Width = 201
        end
        item
          ButtonStyle = cbsEllipsis
          EditButtons = <>
          FieldName = 'BANK_NAME'
          Footers = <>
          Title.Caption = #32852#34892#21517#31216
          Width = 243
        end>
    end
  end
  object btnOK: TButton
    Left = 384
    Top = 43
    Width = 75
    Height = 22
    Caption = #30830#23450'(&O)'
    TabOrder = 6
    OnClick = btnOKClick
  end
  object cdsWY: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ProviderPub'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 208
    Top = 216
  end
  object dsWY: TDataSource
    DataSet = cdsWY
    Left = 272
    Top = 176
  end
end
