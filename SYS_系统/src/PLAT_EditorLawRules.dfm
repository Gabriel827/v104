object FormLawRuleEditor: TFormLawRuleEditor
  Left = 158
  Top = 164
  BorderStyle = bsDialog
  Caption = '����µ����߷���'
  ClientHeight = 239
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '����'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 48
    Height = 12
    Caption = '��    ��'
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 48
    Height = 12
    Caption = '��    ��'
  end
  object Label3: TLabel
    Left = 16
    Top = 80
    Width = 48
    Height = 12
    Caption = '��    ��'
  end
  object Label4: TLabel
    Left = 208
    Top = 80
    Width = 36
    Height = 12
    Caption = '�ؼ���'
  end
  object Label5: TLabel
    Left = 16
    Top = 112
    Width = 48
    Height = 12
    Caption = 'ժ    Ҫ'
  end
  object Label6: TLabel
    Left = 16
    Top = 144
    Width = 48
    Height = 12
    Caption = '�ļ�����'
  end
  object Label7: TLabel
    Left = 208
    Top = 47
    Width = 36
    Height = 12
    Caption = '��  ��'
    Visible = False
  end
  object edtLRName: TEdit
    Left = 72
    Top = 11
    Width = 121
    Height = 20
    ImeName = '���� (����) - ƴ���Ӽ�3.11'
    TabOrder = 0
  end
  object edtLRTitle: TEdit
    Left = 72
    Top = 43
    Width = 121
    Height = 20
    ImeName = '���� (����) - ƴ���Ӽ�3.11'
    TabOrder = 1
  end
  object edtLRAuthor: TEdit
    Left = 72
    Top = 75
    Width = 121
    Height = 20
    ImeName = '���� (����) - ƴ���Ӽ�3.11'
    TabOrder = 2
  end
  object edtLRKeyWords: TEdit
    Left = 258
    Top = 75
    Width = 150
    Height = 20
    ImeName = '���� (����) - ƴ���Ӽ�3.11'
    TabOrder = 3
  end
  object edtLRAbstract: TEdit
    Left = 72
    Top = 107
    Width = 335
    Height = 20
    ImeName = '���� (����) - ƴ���Ӽ�3.11'
    TabOrder = 4
  end
  object LRFileName: TFilenameEdit
    Left = 71
    Top = 139
    Width = 338
    Height = 21
    DialogTitle = '���'
    ImeName = '���� (����) - ƴ���Ӽ�3.11'
    NumGlyphs = 1
    TabOrder = 5
  end
  object Button1: TButton
    Left = 168
    Top = 200
    Width = 105
    Height = 25
    Caption = 'ȷ��'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 296
    Top = 200
    Width = 105
    Height = 25
    Caption = 'ȡ��'
    ModalResult = 2
    TabOrder = 7
  end
  object ComboBoxGroupItems: TComboBox
    Left = 259
    Top = 43
    Width = 150
    Height = 20
    Style = csDropDownList
    ImeName = '���� (����) - ƴ���Ӽ�3.11'
    ItemHeight = 12
    TabOrder = 8
    Visible = False
  end
  object CheckBoxInMenu: TCheckBox
    Left = 16
    Top = 176
    Width = 137
    Height = 17
    Caption = '��ʾ�ڲ˵���Ŀ��'
    TabOrder = 9
  end
end
