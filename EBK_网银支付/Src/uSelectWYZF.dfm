object FrmSelect: TFrmSelect
  Left = 444
  Top = 125
  Width = 643
  Height = 508
  Caption = #36873#25321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 12
  object lvSelect: TListView
    Left = 0
    Top = 46
    Width = 491
    Height = 424
    Align = alClient
    Columns = <
      item
        Caption = #20195#30721
        Width = 120
      end
      item
        Caption = #21517#31216
        Width = 250
      end>
    HideSelection = False
    HotTrackStyles = [htHandPoint]
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnColumnClick = lvSelectColumnClick
    OnDblClick = BitBtnOKClick
  end
  object grdSelect: TDBGridEh
    Left = 0
    Top = 46
    Width = 491
    Height = 424
    Align = alClient
    DataSource = ds
    EditActions = [geaCopyEh, geaSelectAllEh]
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -12
    FooterFont.Name = #23435#20307
    FooterFont.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDblClick = BitBtnOKClick
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 627
    Height = 46
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object LabelInput: TLabel
      Left = 14
      Top = 18
      Width = 24
      Height = 12
      Alignment = taRightJustify
      Caption = #36807#28388
    end
    object Label1: TLabel
      Left = 306
      Top = 19
      Width = 132
      Height = 12
      Caption = #21487#20197#25353#29031#25340#38899#39318#23383#27597#36807#28388
    end
    object EditInput: TEdit
      Left = 47
      Top = 14
      Width = 250
      Height = 20
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 0
      OnChange = EditInputChange
    end
  end
  object PanelRight: TPanel
    Left = 491
    Top = 46
    Width = 136
    Height = 424
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object BitBtnOK: TBitBtn
      Left = 27
      Top = 0
      Width = 91
      Height = 25
      Caption = #30830#23450'(&O)'
      Default = True
      TabOrder = 0
      OnClick = BitBtnOKClick
      NumGlyphs = 2
    end
    object BitBtnCancel: TBitBtn
      Left = 27
      Top = 32
      Width = 91
      Height = 25
      Cancel = True
      Caption = #21462#28040'(&C)'
      TabOrder = 1
      OnClick = BitBtnCancelClick
      NumGlyphs = 2
    end
  end
  object ds: TDataSource
    Left = 152
    Top = 160
  end
end
