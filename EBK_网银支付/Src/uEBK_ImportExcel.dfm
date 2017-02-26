object FrmEBKImportExcel: TFrmEBKImportExcel
  Left = 266
  Top = 157
  BorderStyle = bsSingle
  Caption = 'Excel'#25968#25454#23548#20837
  ClientHeight = 426
  ClientWidth = 571
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 571
    Height = 426
    Align = alClient
    TabOrder = 0
    object PageControl2: TPageControl
      Left = 1
      Top = 1
      Width = 569
      Height = 424
      ActivePage = TabSheet5
      Align = alClient
      TabOrder = 0
      OnChange = PageControl2Change
      object TabSheet5: TTabSheet
        Caption = #25903#20184#25968#25454#23548#20837
        ImageIndex = 1
        object PageControlmx: TPageControl
          Left = 0
          Top = 0
          Width = 561
          Height = 397
          ActivePage = TabSheet6
          Align = alClient
          Style = tsButtons
          TabOrder = 0
          object TabSheet6: TTabSheet
            Caption = #25552#20379'Excel'#25968#25454#28304#20449#24687
            object GroupBox5: TGroupBox
              Left = 8
              Top = 81
              Width = 525
              Height = 85
              Caption = #36873#25321'EXCEL'#25991#20214
              TabOrder = 0
              object SpeedButton2: TSpeedButton
                Left = 468
                Top = 46
                Width = 23
                Height = 22
                Caption = '...'
                Flat = True
                OnClick = SpeedButton2Click
              end
              object Label6: TLabel
                Left = 15
                Top = 24
                Width = 240
                Height = 12
                Caption = 'Excel'#25968#25454#23548#20837#21151#33021#38656#35201#33719#24471'Excel'#25991#20214#30340#20301#32622
              end
              object EditImportgzmxfn: TEdit
                Left = 14
                Top = 47
                Width = 443
                Height = 20
                ImeName = #20013#25991' ('#31616#20307') - '#25340#38899#21152#21152'3.11'
                TabOrder = 0
              end
            end
            object GroupBox6: TGroupBox
              Left = 8
              Top = 176
              Width = 525
              Height = 118
              Caption = #21451#24773#25552#31034
              TabOrder = 1
              object Label7: TLabel
                Left = 13
                Top = 20
                Width = 408
                Height = 24
                Caption = 
                  'Excel'#25968#25454#23548#20837#21151#33021#23545'Excel'#34920#26684#24335#26377#19968#23450#35201#27714#65292#40664#35748#20026#27599#19968#24037#20316#34920#30340#31532#19968#13#10#34892#25968#25454#26159#26631#39064#21015#65307#34892#26041#21521#19981#33021#26377#31354#34892#65292#21015#26041#21521#19981#33021#26377#31354#21015 +
                  #65292#21542#21017#25968#25454#20250#38169#20081#12290
                Color = clActiveCaption
                Font.Charset = ANSI_CHARSET
                Font.Color = clHotLight
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentColor = False
                ParentFont = False
                Transparent = True
              end
            end
            object GroupBox1: TGroupBox
              Left = 9
              Top = 11
              Width = 523
              Height = 57
              Caption = #23548#20837#25968#25454#26465#20214
              TabOrder = 2
              object Label23: TLabel
                Left = 16
                Top = 27
                Width = 60
                Height = 12
                Caption = #32467#31639#26041#24335#65306
              end
              object Label5: TLabel
                Left = 259
                Top = 28
                Width = 24
                Height = 12
                Alignment = taRightJustify
                Caption = #29992#36884
              end
              object ComboBoxYWLX: TComboBox
                Left = 83
                Top = 23
                Width = 158
                Height = 20
                Style = csDropDownList
                ItemHeight = 12
                TabOrder = 0
                OnChange = ComboBoxYWLXChange
                Items.Strings = (
                  #20840#37096
                  #36716#36134#25903#31080
                  #30005#27719
                  #29616#37329#25903#31080)
              end
              object cmbUseage: TComboBox
                Left = 288
                Top = 23
                Width = 225
                Height = 20
                Style = csDropDownList
                ImeName = #20013#25991' ('#31616#20307') - '#21152#21152#36755#20837#27861'4.0'
                ItemHeight = 12
                MaxLength = 30
                TabOrder = 1
                Items.Strings = (
                  '00000008 '#24037#36164
                  '00000009 '#22870#37329
                  '00000006 '#25253#38144
                  '00000007 '#24046#26053#36153
                  '0000061 '#27941#36148
                  '0000065 '#34917#36148
                  '00000082 '#20195#25910#23398#36153
                  '0000053 '#20854#23427)
              end
            end
          end
          object TabSheet7: TTabSheet
            Caption = #35774#32622#25968#25454#21015#23545#24212#20851#31995
            Enabled = False
            ImageIndex = 2
            object GroupBox7: TGroupBox
              Left = 8
              Top = 1
              Width = 497
              Height = 293
              Caption = #35774#32622#23545#24212#20851#31995
              TabOrder = 0
              object Label8: TLabel
                Left = 10
                Top = 19
                Width = 372
                Height = 24
                Caption = #27599#19968#20010'Excel'#25991#20214#33267#23569#21253#25324#19968#20010#24037#20316#34920'('#22914#40664#35748#21517#31216#20026#65306'sheet1),'#31995#32479#40664#13#10#35748#23548#20837#31532#19968#20010#24037#20316#34920#20013#30340#25968#25454#65292#20854#20182#34920#23558#24573#30053#12290
              end
              object grd: TDBGridEh
                Left = 2
                Top = 48
                Width = 493
                Height = 243
                Align = alBottom
                DataSource = dsRls
                FooterColor = clWindow
                FooterFont.Charset = ANSI_CHARSET
                FooterFont.Color = clWindowText
                FooterFont.Height = -12
                FooterFont.Name = #23435#20307
                FooterFont.Style = []
                FrozenCols = 2
                ReadOnly = True
                TabOrder = 0
                TitleFont.Charset = ANSI_CHARSET
                TitleFont.Color = clWindowText
                TitleFont.Height = -12
                TitleFont.Name = #23435#20307
                TitleFont.Style = []
                Columns = <
                  item
                    EditButtons = <>
                    FieldName = 'NAME'
                    Footers = <>
                    Title.Caption = #23383#27573#21517#31216
                    Width = 121
                  end
                  item
                    EditButtons = <>
                    FieldName = 'TYPE'
                    Footers = <>
                    Title.Caption = #25968#25454#31867#22411
                    Width = 96
                  end
                  item
                    AutoDropDown = True
                    EditButtons = <>
                    FieldName = 'ExcelName'
                    Footers = <>
                    Title.Caption = 'Excel'#23545#24212#21015
                    Width = 278
                  end>
              end
            end
            object btnSave: TButton
              Left = 8
              Top = 305
              Width = 75
              Height = 25
              Caption = #20445#23384#27169#26495
              TabOrder = 1
              OnClick = btnSaveClick
            end
            object btnOpen: TButton
              Left = 88
              Top = 305
              Width = 75
              Height = 25
              Caption = #25171#24320#27169#26495
              TabOrder = 2
              OnClick = btnOpenClick
            end
          end
          object TabSheet8: TTabSheet
            Caption = #25968#25454#27491#30830#24615#26816#26597
            Enabled = False
            ImageIndex = 3
            object GroupBox9: TGroupBox
              Left = 8
              Top = 1
              Width = 489
              Height = 293
              Caption = #25968#25454#27491#30830#24615#26816#26597
              TabOrder = 0
              object Label4: TLabel
                Left = 14
                Top = 19
                Width = 348
                Height = 24
                Caption = #25552#31034#65306#22914#26524#26816#26597#19981#36890#36807#65292#20250#22312#34920#20013#23558#38169#35823#20449#24687#30340#20301#32622#26631#35760#20026#32418#33394#65292#13#10#26368#21518#19968#34892#26631#27880#38169#35823#21407#22240#65281#35831#25171#24320#34920#23545#29031#38169#35823#21407#22240#20462#25913#21518#20877#35797#65281
              end
              object Labelmxdrts: TLabel
                Left = 17
                Top = 264
                Width = 48
                Height = 12
                Caption = #23548#20837#25552#31034
              end
              object lbl1: TLabel
                Left = 16
                Top = 50
                Width = 360
                Height = 12
                Caption = #27880#24847#65306#25968#25454#24517#39035#36830#32493#65292#20013#38388#19981#33021#26377#31354#34892#65292#21542#21017#31354#34892#21518#30340#25968#25454#19981#23548#20837#65281
                Font.Charset = ANSI_CHARSET
                Font.Color = clRed
                Font.Height = -12
                Font.Name = #23435#20307
                Font.Style = []
                ParentFont = False
              end
              object Memojcjg: TMemo
                Left = 12
                Top = 70
                Width = 461
                Height = 211
                BorderStyle = bsNone
                Color = clScrollBar
                HideSelection = False
                ImeName = #20013#25991' ('#31616#20307') - '#25340#38899#21152#21152
                Lines.Strings = (
                  '')
                ReadOnly = True
                TabOrder = 0
              end
            end
          end
          object TabSheet9: TTabSheet
            Caption = #32467#26524#26597#30475
            ImageIndex = 3
            object GroupBox8: TGroupBox
              Left = 8
              Top = 8
              Width = 497
              Height = 286
              Caption = #23548#20837#20449#24687'..'
              TabOrder = 0
              object Memomx: TMemo
                Left = 16
                Top = 25
                Width = 457
                Height = 244
                BorderStyle = bsNone
                Color = clScrollBar
                HideSelection = False
                ImeName = #20013#25991' ('#31616#20307') - '#25340#38899#21152#21152
                Lines.Strings = (
                  '')
                ReadOnly = True
                ScrollBars = ssBoth
                TabOrder = 0
              end
            end
          end
        end
        object btnmxPrior: TButton
          Left = 272
          Top = 332
          Width = 75
          Height = 25
          Caption = #19978#19968#27493
          TabOrder = 1
          OnClick = btnmxPriorClick
        end
        object btnmxNext: TButton
          Left = 352
          Top = 332
          Width = 75
          Height = 25
          Caption = #19979#19968#27493
          TabOrder = 2
          OnClick = btnmxNextClick
        end
        object btnmxExit: TButton
          Left = 434
          Top = 332
          Width = 75
          Height = 25
          Caption = #36864#20986
          TabOrder = 3
          OnClick = btnmxExitClick
        end
      end
    end
  end
  object OpenDialogmx: TOpenDialog
    Filter = 'Excel'#25991#20214'(*.xls)|*.xls'
    Left = 399
    Top = 382
  end
  object con1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\TEMP\11.xls;Exte' +
      'nded Properties=Excel 8.0;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 455
    Top = 398
  end
  object tbl1: TADOTable
    Connection = con1
    CursorType = ctStatic
    TableDirect = True
    Left = 439
    Top = 382
  end
  object dsRls: TDataSource
    Left = 495
    Top = 350
  end
  object cdsData: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 471
    Top = 390
  end
  object sd: TSaveDialog
    Filter = #27169#26495#25991#20214'(*.xml)|*.xml'
    Left = 455
    Top = 382
  end
  object OD: TOpenDialog
    Filter = #27169#26495#25991#20214'(*.xml)|*.xml'
    Left = 527
    Top = 350
  end
end
