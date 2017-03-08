object FormSetKJND: TFormSetKJND
  Left = 348
  Top = 175
  BorderStyle = bsDialog
  Caption = #36873#25321#26597#35810#21382#21490#25968#25454#30340#20250#35745#24180#24230
  ClientHeight = 178
  ClientWidth = 264
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object LabelKJND: TLabel
    Left = 71
    Top = 59
    Width = 48
    Height = 12
    Alignment = taRightJustify
    Caption = #20250#35745#24180#24230
  end
  object ButtonOK: TButton
    Left = 44
    Top = 146
    Width = 73
    Height = 23
    Caption = #30830#23450'(&O)'
    TabOrder = 0
    OnClick = ButtonOKClick
  end
  object ButtonCancel: TButton
    Left = 144
    Top = 146
    Width = 73
    Height = 23
    Caption = #21462#28040'(&C)'
    TabOrder = 1
    OnClick = ButtonCancelClick
  end
  object SpinEditKJND: TSpinEditZW
    Left = 80
    Top = 53
    Width = 121
    Height = 21
    MaxValue = 9999
    MinValue = 1980
    TabOrder = 2
    Value = 1998
    Visible = False
  end
  object ListViewKjnd: TListView
    Left = 16
    Top = 15
    Width = 230
    Height = 115
    Columns = <
      item
        Caption = #20250#35745#24180#24230
        Width = 200
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
    OnDblClick = ListViewKjndDblClick
  end
  object LggExchanger1: TLggExchanger
    AllowDblLgg = True
    Form = Owner
    Options = [aoFormCaption, aoMenuItem, aoLabel, aoBitBtn, aoCheckBox, aoRadioButton, aoSpeedItem, aoPanel, aoGroupBox, aoRadioGroup, aoTHStringGrid, aoTHDBGrid, aoTHFilter, aoTabSet, aoPageControl, aoComboBox, aoStatusBar, aoTHBevel, aoListView, aoSprint, aoRxLabel, aoFinder]
    Left = 288
    Top = 8
  end
end
