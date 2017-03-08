object frmDownloadData: TfrmDownloadData
  Left = 255
  Top = 181
  BorderStyle = bsDialog
  Caption = #19979#36733#26381#21153#22120#25968#25454
  ClientHeight = 214
  ClientWidth = 529
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 12
  object Label1: TLabel
    Left = 24
    Top = 152
    Width = 456
    Height = 12
    Caption = #19979#36733#26381#21153#22120#25968#25454#65306#20174#26381#21153#22120#19979#36733#22522#30784#36164#26009#21644#24403#21069#21333#20301#36134#22871#12289#24403#21069#30331#24405#27169#22359#30340#19994#21153#25968#25454#12290
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 513
    Height = 129
    TabOrder = 0
    object lblTables: TLabel
      Left = 16
      Top = 24
      Width = 108
      Height = 12
      Caption = #25968#25454#34920#36827#24230#65306'  0/0 '
    end
    object lblRows: TLabel
      Left = 16
      Top = 72
      Width = 108
      Height = 12
      Caption = #25968#25454#34892#36827#24230#65306'  0/0 '
    end
    object pbarTables: TProgressBar
      Left = 16
      Top = 48
      Width = 473
      Height = 12
      Smooth = True
      Step = 1
      TabOrder = 0
    end
    object pbarRows: TProgressBar
      Left = 16
      Top = 96
      Width = 473
      Height = 12
      Smooth = True
      Step = 1
      TabOrder = 1
    end
  end
  object btnStart: TButton
    Left = 24
    Top = 176
    Width = 81
    Height = 25
    Caption = #19979#36733'(&D)'
    TabOrder = 1
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 120
    Top = 176
    Width = 81
    Height = 25
    Caption = #20572#27490'(&P)'
    TabOrder = 2
    OnClick = btnStopClick
  end
  object btnClose: TButton
    Left = 424
    Top = 176
    Width = 81
    Height = 25
    Caption = #20851#38381'(&C)'
    TabOrder = 3
    OnClick = btnCloseClick
  end
  object cdsTables: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProviderData'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 368
    Top = 24
  end
  object cdsFromTable: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProviderData'
    RemoteServer = DataModulePub.MidasConnectionPub
    Left = 368
    Top = 72
  end
  object cdsToTable: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProviderData'
    RemoteServer = DataModulePub.MidasConnectionLocal
    Left = 408
    Top = 72
  end
  object cdsToExec: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProviderExec'
    RemoteServer = DataModulePub.MidasConnectionLocal
    Left = 448
    Top = 72
  end
end
