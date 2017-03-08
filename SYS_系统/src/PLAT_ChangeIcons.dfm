object FormChangeIcon: TFormChangeIcon
  Left = 222
  Top = 212
  BorderStyle = bsDialog
  Caption = '更改图表为'
  ClientHeight = 103
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 60
    Height = 12
    Caption = '旧图标为：'
  end
  object Image1: TImage
    Left = 88
    Top = 8
    Width = 49
    Height = 49
    Transparent = True
  end
  object Label2: TLabel
    Left = 168
    Top = 24
    Width = 48
    Height = 12
    Caption = '更换为：'
  end
  object ComboBoxImages: TComboBox
    Left = 240
    Top = 8
    Width = 65
    Height = 46
    Style = csOwnerDrawFixed
    ItemHeight = 40
    TabOrder = 0
    OnDrawItem = ComboBoxImagesDrawItem
  end
  object Button1: TButton
    Left = 32
    Top = 72
    Width = 80
    Height = 25
    Caption = '确定'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 128
    Top = 72
    Width = 80
    Height = 25
    Caption = '取消'
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TButton
    Left = 224
    Top = 72
    Width = 80
    Height = 25
    Caption = '浏览(&B)...'
    TabOrder = 3
    OnClick = Button3Click
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '.ico'
    Filter = '图标文件(*.ico)|*.ico'
    Left = 24
    Top = 48
  end
end
