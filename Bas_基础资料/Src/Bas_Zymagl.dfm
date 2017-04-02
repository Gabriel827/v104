object Bas_PwdFrm: TBas_PwdFrm
  Left = 285
  Top = 143
  BorderStyle = bsDialog
  Caption = #32844#21592#23494#30721#31649#29702
  ClientHeight = 471
  ClientWidth = 845
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #26032#23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 576
    Top = 0
    Width = 269
    Height = 471
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object Button3: TButton
      Left = 171
      Top = 413
      Width = 75
      Height = 25
      Caption = #20851#38381
      TabOrder = 0
      OnClick = Button3Click
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 176
      Width = 249
      Height = 225
      Caption = #23494#30721#21021#22987#21270
      TabOrder = 1
      object Label3: TLabel
        Left = 25
        Top = 147
        Width = 221
        Height = 12
        Caption = #65288#27880#65306#36523#20221#35777#20026#31354#26102#65292#21021#22987#23494#30721#20026#31354#65289
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = #26032#23435#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Button1: TButton
        Left = 163
        Top = 184
        Width = 75
        Height = 25
        Caption = #21021#22987#21270#23494#30721
        TabOrder = 0
        OnClick = Button1Click
      end
      object edtInitPassword: TEdit
        Left = 88
        Top = 96
        Width = 150
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 1
      end
      object RadioButtonCSMM: TRadioButton
        Left = 13
        Top = 97
        Width = 74
        Height = 17
        Caption = #21021#22987#23494#30721
        Checked = True
        TabOrder = 2
        TabStop = True
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 24
        Width = 230
        Height = 57
        Caption = #36873#25321#33539#22260
        TabOrder = 3
        object rbAll: TRadioButton
          Left = 128
          Top = 24
          Width = 89
          Height = 17
          Caption = #20840#37096#21021#22987#21270
          TabOrder = 0
        end
        object rbNo: TRadioButton
          Left = 5
          Top = 24
          Width = 89
          Height = 17
          Caption = #26410#21021#22987#32844#21592
          Checked = True
          TabOrder = 1
          TabStop = True
        end
      end
      object RadioButtonSFZMM: TRadioButton
        Left = 13
        Top = 124
        Width = 204
        Height = 17
        Caption = #36523#20221#35777#21518#20845#20301#20026#23494#30721
        TabOrder = 4
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 8
      Width = 249
      Height = 153
      Caption = #23494#30721#20462#25913
      TabOrder = 2
      object Label2: TLabel
        Left = 11
        Top = 25
        Width = 60
        Height = 12
        Caption = #22995#21517#25110#20195#30721
      end
      object Label4: TLabel
        Left = 35
        Top = 55
        Width = 36
        Height = 12
        Caption = #26032#23494#30721
      end
      object Label5: TLabel
        Left = 23
        Top = 88
        Width = 48
        Height = 12
        Caption = #30830#35748#23494#30721
      end
      object Editquery: TEdit
        Left = 78
        Top = 20
        Width = 117
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        TabOrder = 0
        OnKeyDown = EditqueryKeyDown
      end
      object btnsearch: TButton
        Left = 203
        Top = 18
        Width = 38
        Height = 25
        Caption = #26597#25214
        TabOrder = 1
        OnClick = btnsearchClick
      end
      object EditNewpass: TEdit
        Left = 78
        Top = 51
        Width = 160
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        PasswordChar = '*'
        TabOrder = 2
      end
      object EditNewPass2: TEdit
        Left = 78
        Top = 82
        Width = 160
        Height = 20
        ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
        PasswordChar = '*'
        TabOrder = 3
      end
      object btnMoid: TButton
        Left = 163
        Top = 113
        Width = 75
        Height = 25
        Caption = #20462#25913
        TabOrder = 4
        OnClick = btnMoidClick
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 576
    Height = 471
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 48
      Height = 12
      Caption = #32844#21592#21015#34920
    end
    object THDBGrid1: TTHDBGrid
      Left = 8
      Top = 24
      Width = 553
      Height = 433
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
      GridTail = False
      GridTailColor = clBlack
      GridTailHeight = 20
      DataSource = DataSource1
      ImeName = #20013#25991'('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgKeyAppend, dgKeyInsert]
      TabOrder = 0
      TitleFont.Charset = GB2312_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = #26032#23435#20307
      TitleFont.Style = []
      ShowLock = False
      RowsHeight = 18
      Col = 1
      Row = 1
      Columns = <
        item
          FieldName = 'bmdm'
          Title.Caption = #37096#38376#20195#30721
          Width = 65
          DataTypePro = dpString
          DataTypeApp = daNone
          MaxColWidth = 0
          DataWidth = 0
          DataDec = 0
          LoadButton = False
          Sortable = False
          ColColor = clBlack
          CheckBox = False
          PopDateAllowed = False
          PopComboBoxAllowed = False
          CalcMode = ccUser
          CodeIndent = '  '
          ShowZero = False
        end
        item
          FieldName = 'bmmc'
          Title.Caption = #37096#38376#21517#31216
          Width = 264
          DataTypePro = dpString
          DataTypeApp = daNone
          MaxColWidth = 0
          DataWidth = 0
          DataDec = 0
          LoadButton = False
          Sortable = False
          ColColor = clBlack
          CheckBox = False
          PopDateAllowed = False
          PopComboBoxAllowed = False
          CalcMode = ccUser
          CodeIndent = '  '
          ShowZero = False
        end
        item
          FieldName = 'zydm'
          Title.Caption = #32844#21592#20195#30721
          Width = 66
          DataTypePro = dpString
          DataTypeApp = daNone
          MaxColWidth = 0
          DataWidth = 0
          DataDec = 0
          LoadButton = False
          Sortable = False
          ColColor = clBlack
          CheckBox = False
          PopDateAllowed = False
          PopComboBoxAllowed = False
          CalcMode = ccUser
          CodeIndent = '  '
          ShowZero = False
        end
        item
          FieldName = 'zyxm'
          Title.Caption = #32844#21592#21517#31216
          Width = 134
          DataTypePro = dpString
          DataTypeApp = daNone
          MaxColWidth = 0
          DataWidth = 0
          DataDec = 0
          LoadButton = False
          Sortable = False
          ColColor = clBlack
          CheckBox = False
          PopDateAllowed = False
          PopComboBoxAllowed = False
          CalcMode = ccUser
          CodeIndent = '  '
          ShowZero = False
        end>
    end
    object Button2: TButton
      Left = 88
      Top = 0
      Width = 41
      Height = 25
      Caption = #31579#36873
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button4: TButton
      Left = 136
      Top = 0
      Width = 41
      Height = 25
      Caption = #24674#22797
      TabOrder = 2
      OnClick = Button4Click
    end
  end
  object cdszyxx: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdszyxxAfterScroll
    Left = 80
    Top = 168
  end
  object DataSource1: TDataSource
    DataSet = cdszyxx
    Left = 128
    Top = 168
  end
  object THFilterZYXX: TTHFilter
    GridCols = <
      item
        Width = 50
        Caption = #32844#21592#20195#30721
        AutoEnter = False
        ColName = 'ZYDM'
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
        Font.Height = -13
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
        Caption = #32844#21592#22995#21517
        AutoEnter = False
        ColName = 'ZYXM'
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
        Font.Height = -13
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
        Caption = #21161#35760#30721
        AutoEnter = False
        ColName = 'ZJM'
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
        Font.Height = -13
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
        Font.Height = -13
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
        Caption = #32844#21153
        AutoEnter = False
        ColName = 'ZW'
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
        Font.Height = -13
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
        Caption = #30005#35805
        AutoEnter = False
        ColName = 'TEL'
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
        Font.Height = -13
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
        Caption = 'EMail '#22320#22336
        AutoEnter = False
        ColName = 'EMAIL'
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
        Font.Height = -13
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
        Caption = #25991#21270#31243#24230
        AutoEnter = False
        ColName = 'WHCD'
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
        Font.Height = -13
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
        Caption = #36134#21495
        AutoEnter = False
        ColName = 'GRZH'
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
        Caption = #22791#27880#20449#24687
        AutoEnter = False
        ColName = 'BZ'
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
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        TitleFont.Charset = GB2312_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = #23435#20307
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
      end>
    DatasetFilter = cdszyxx
    UseOnFilterRecord = True
    GridItems = <>
    LeftCols = 2
    UseFormName = False
    OnFilter = THFilterZYXXFilter
    Left = 200
    Top = 162
  end
end
