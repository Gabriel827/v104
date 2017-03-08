object FormLinkProperty: TFormLinkProperty
  Left = 201
  Top = 107
  BorderStyle = bsDialog
  Caption = '属性'
  ClientHeight = 311
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 12
  object Button1: TButton
    Left = 96
    Top = 280
    Width = 81
    Height = 25
    Caption = '确定'
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 192
    Top = 280
    Width = 81
    Height = 25
    Caption = '取消'
    ModalResult = 2
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 298
    Height = 273
    ActivePage = TabSheet1
    Align = alTop
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = '常规'
      object Bevel1: TBevel
        Left = 16
        Top = 8
        Width = 257
        Height = 57
        Shape = bsBottomLine
      end
      object Image1: TImage
        Left = 16
        Top = 8
        Width = 49
        Height = 49
        Transparent = True
      end
      object LabelTitle: TLabel
        Left = 80
        Top = 24
        Width = 60
        Height = 12
        Caption = 'LabelTitle'
      end
      object Label2: TLabel
        Left = 16
        Top = 96
        Width = 54
        Height = 12
        Caption = '链接名称:'
      end
      object Label3: TLabel
        Left = 16
        Top = 120
        Width = 54
        Height = 12
        Caption = '链接对象:'
      end
      object LabelTitleName: TLabel
        Left = 72
        Top = 96
        Width = 36
        Height = 12
        Caption = 'Label1'
      end
      object LableTarget: TLabel
        Left = 72
        Top = 120
        Width = 36
        Height = 12
        Caption = 'Label1'
      end
    end
  end
end
