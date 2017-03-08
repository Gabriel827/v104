object FormSelectLawRule: TFormSelectLawRule
  Left = 120
  Top = 124
  Width = 544
  Height = 336
  Caption = '选择政策法规'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 250
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Panel1'
    TabOrder = 0
    object DBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 534
      Height = 248
      Align = alClient
      DataSource = DataSource1
      ImeName = '中文 (简体) - 拼音加加3.11'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = '宋体'
      TitleFont.Style = []
      OnDblClick = DBGridDblClick
    end
  end
  object ButtonOK: TButton
    Left = 248
    Top = 270
    Width = 105
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '确定'
    ModalResult = 1
    TabOrder = 1
    OnClick = ButtonOKClick
  end
  object Button2: TButton
    Left = 376
    Top = 271
    Width = 105
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '取消'
    ModalResult = 2
    TabOrder = 2
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 72
    Top = 312
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 312
  end
end
