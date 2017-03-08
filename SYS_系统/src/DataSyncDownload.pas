unit DataSyncDownload;

interface

uses
  Windows, Messages, SysUtils,Variants, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, StdCtrls, ComCtrls, ExtCtrls, DBClient;

type
  TfrmDownloadData = class(TForm)
    GroupBox1: TGroupBox;
    lblTables: TLabel;
    pbarTables: TProgressBar;
    lblRows: TLabel;
    pbarRows: TProgressBar;
    btnStart: TButton;
    btnStop: TButton;
    btnClose: TButton;
    cdsTables: TClientDataSet;
    cdsFromTable: TClientDataSet;
    cdsToTable: TClientDataSet;
    cdsToExec: TClientDataSet;
    Label1: TLabel;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
    iTablePos: Integer;
    iTableCount: Integer;
    iRowPos: Integer;
    iRowCount: Integer;
    bTerminated: Boolean;
    szTableName: string;
    szTableDesc: string;
    szRowFilter: string;
    function CheckToTableFields: Boolean;
    procedure POfflineExecSQL(const ASQL: string);
    procedure RunDBUpdateScript;
    procedure DownloadTables;
    procedure DownloadRows;
    procedure UpdateLabels;
  public
    { Public declarations }
  end;

procedure DownloadDataDialogShowModal;

implementation

uses Hash, DataModuleMain, Pub_Function, Pub_Global;

{$R *.DFM}

procedure DownloadDataDialogShowModal;
var
  frmDownloadData: TfrmDownloadData;
begin
  frmDownloadData := TfrmDownloadData.Create(nil);
  try
    frmDownloadData.ShowModal;
  finally
    frmDownloadData.Free;
  end;
end;

{ TfrmDataSync }

function TfrmDownloadData.CheckToTableFields: Boolean;
begin
  Result := False;

  with cdsToTable do
  try
    Close;

    RemoteServer := DataModuleMain.DataModulePub.MidasConnectionLocal;
    ProviderName := 'DataSetProviderData';
    try
      Data := DataRequest('select * from ' + szTableName + ' where 1=0');

      // OFFLINE_DATE  // ԭʼ��������ʱ���������������ʱ��
      if Fields.FindField(OFFLINE_DATE) = nil then
        POfflineExecSQL('alter table ' + szTableName + ' add ' +
                        OFFLINE_DATE + ' datetime default getdate()');
                              
      // OFFLINE_FLAG  // ����������״̬��0:ԭʼ�������ݣ�1:�����������ݣ�
      if Fields.FindField(OFFLINE_FLAG) = nil then
        POfflineExecSQL('alter table ' + szTableName + ' add ' +
                        OFFLINE_FLAG + ' int default 1');

      // OFFLINE_FLAG  // ����������Ψһ���ROWID 
      if Fields.FindField(OFFLINE_ROWID) = nil then
      begin
        POfflineExecSQL('alter table ' + szTableName + ' add ' +
                        OFFLINE_ROWID + ' varchar(50) default ''''');
      end;

      Result := True;

    except
    end;
  finally
    cdsToTable.Close;
  end;
end;

procedure TfrmDownloadData.POfflineExecSQL(const ASQL: string);
begin
  cdsToExec.Close;
  cdsToExec.DataRequest(ASQL);
end;

procedure TfrmDownloadData.RunDBUpdateScript;
begin
  ///////////////////////////////////////////////////////////////////////
end;

procedure TfrmDownloadData.DownloadTables;

  procedure AddRowFilter(KeyField, KeyValue: string);
  begin
    if (Trim(KeyField) <> '') and (KeyValue <> '') then
    begin
      if szRowFilter <> '' then
        szRowFilter := szRowFilter + ' and ';
      szRowFilter := szRowFilter + KeyField + '=''' + KeyValue + '''';
    end;
  end;

  procedure AddRowFilter_SubString(KeyField, KeyValue: string);
  begin
    if (Trim(KeyField) <> '') and (KeyValue <> '') then
    begin
      if szRowFilter <> '' then
        szRowFilter := szRowFilter + ' and ';
      szRowFilter := szRowFilter + 'substring(' + KeyField + ',1,4)=''' + KeyValue + '''';
    end;
  end;

var
  szSQL: string;
begin
  iTablePos := 0;
  iTableCount := 0;

  if GProSign='AQR' then
    szSQL := 'select * from PUB_OFFLINE_TABLE' +
             ' where ISSYNC = ''1'' and (ModName=''PUB'' or ModName=''GL'' or ModName=''' + GProSign + ''')'
  else
    szSQL := 'select * from PUB_OFFLINE_TABLE' +
             ' where ISSYNC = ''1'' and (ModName=''PUB'' or ModName=''' + GProSign + ''')';

  try
    POpenSQL(cdsTables, szSQL);

    iTableCount := cdsTables.RecordCount;
    pbarTables.Max := iTableCount;
    pbarTables.Position := 0;

    // ѭ��������Ҫͬ�������ݱ�
    cdsTables.FindFirst;

    while (iTablePos < iTableCount) and (not bTerminated) do
    begin
      Inc(iTablePos);

      szTableName := cdsTables.FieldByName('TableName').AsString;
      szTableDesc := cdsTables.FieldByName('TableDesc').AsString;
      if szTableDesc = '' then
        szTableDesc := szTableName;

      // �������ݱ����ȡ���λ�����׹�������
      szRowFilter := '';
      AddRowFilter(cdsTables.FieldByName('GSDM').AsString, GszGSDM);
      AddRowFilter(cdsTables.FieldByName('ZTH').AsString, GszZTH);
      AddRowFilter(cdsTables.FieldByName('KJND').AsString, GszKJND);
      AddRowFilter_SubString(cdsTables.FieldByName('KJQJ').AsString, GszKJND);

      // ���ص�ǰ���ݱ�ķ���������
      try
        DownloadRows;
      except
        on E: Exception do
        begin
          Application.MessageBox(PChar('�������ݣ�' + szTableName + '�����ɹ������Ȱ�װ���߻�����'),'ϵͳ��ʾ',MB_ICONInformation+MB_OK);
          Exit;
        end;
      end;

      cdsTables.FindNext;
    end;

    if not bTerminated then
      ShowMessage('����������������ɣ�')
    else
      ShowMessage('�û���ֹͣ���β�������������������δ��ɡ�');

  finally
    cdsTables.Close;
  end;
end;

procedure TfrmDownloadData.DownloadRows;

  function GetRowID(ADataSet: TDataSet): string;
  var
    i: Integer;
    s: string;
  begin
    s := '';
    for i := 0 to ADataSet.FieldCount - 1 do
    begin
      s := '<' + ADataSet.Fields[i].FieldName + '>' + ADataSet.Fields[i].AsString;
    end;
    Result := THash_MD5.CalcString(s);
  end;

var
  i: Integer;
  szSQL, szWhere: string;
  toField: TField;
begin
  // ���Ŀ����Ƿ����ͬ������ֶ�
  if not CheckToTableFields then Exit;

  // ɾ��Ŀ����Ӧ��¼��
  szSQL := 'delete from ' + szTableName + ' where ' + OFFLINE_FLAG + '=0 ';
  if szRowFilter <> '' then
    szSQL := szSQL + ' and ' + szRowFilter;

  POfflineExecSQL(szSQL);

  UpdateLabels;
  lblRows.Caption := '���ڶ�ȡ��' + szTableDesc + '������...';
  pbarRows.Position := 0;
  Application.ProcessMessages;

  try
    szSQL := 'select * from ' + szTableName;
    if szRowFilter <> '' then
      szSQL := szSQL + ' where ' + szRowFilter;

    cdsFromTable.Data := cdsFromTable.DataRequest(szSQL);

    iRowPos := 0;
    iRowCount := cdsFromTable.RecordCount;
    pbarRows.Max := iRowCount;
    pbarRows.Position := 0;

    cdsToTable.Data := cdsToTable.DataRequest(szSQL);

    try
      // ѭ��������Ҫͬ���ļ�¼��
      cdsFromTable.FindFirst;
      while (iRowPos < iRowCount) and (not bTerminated) do
      begin
        Inc(iRowPos);
        UpdateLabels;

        cdsToTable.Append;
        for i := 0 to cdsFromTable.FieldCount - 1 do
        begin
          toField := cdsToTable.FindField(cdsFromTable.Fields[i].FieldName);
          if toField <> nil then
          begin
            if GDBType = ORACLE then
            begin
              if (cdsFromTable.Fields[i].AsString = '_') or
                 (cdsFromTable.Fields[i].IsNull) then
                toField.AsString := ''
              else
                toField.AsVariant := cdsFromTable.Fields[i].AsVariant;
            end else
              toField.AsVariant := cdsFromTable.Fields[i].AsVariant;
          end;
        end;
        toField := cdsToTable.FindField(OFFLINE_ROWID);
        if toField <> nil then
          toField.AsString := GetRowID(cdsFromTable);

        cdsToTable.Post;
        cdsFromTable.Next;
      end;

      if not bTerminated then
      begin
        lblRows.Caption := '���ڴ���' + szTableDesc + '�����������ݣ����Ե�...';
        Application.ProcessMessages;
        cdsToTable.ApplyUpdates(-1, szTableName);

        // ԭʼ����������ɺ����� OFFLINE_FLAG �ֶ�ֵΪ 0��ԭʼ�������ݣ���
        POfflineExecSQL('update ' + szTableName + ' set ' + OFFLINE_FLAG + '=0 ');
      end;

    finally
      cdsToTable.Close;
    end;
  finally
    cdsFromTable.Close;
  end;
end;

procedure TfrmDownloadData.UpdateLabels;
begin
  pbarTables.Position := iTablePos;
  pbarRows.Position := iRowPos;
  lblTables.Caption := Format('���ڴ���� %d/%d �����ݱ� %s��%s��',
                              [iTablePos, iTableCount, szTableName, szTableDesc]);
  lblRows.Caption := Format('�������أ�%s�������ݣ��� %d/%d ��',
                            [szTableDesc, iRowPos, iRowCount]);

  Application.ProcessMessages;
end;

procedure TfrmDownloadData.btnStartClick(Sender: TObject);
begin
  bTerminated := False;
  btnStart.Enabled := False;
  try
    try
      DataModuleMain.DataModulePub.MidasConnectionLocal.Connected := True;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('�������߻���ʱ�������⡣������Ϣ��' + #13#10#13#10 + E.Message),'ϵͳ��ʾ',MB_ICONInformation+MB_OK);
        Exit;
      end;
    end;

    RunDBUpdateScript;
    DownloadTables;
  finally
    btnStart.Enabled := True;
  end;
end;

procedure TfrmDownloadData.btnStopClick(Sender: TObject);
begin
  bTerminated := True;
end;

procedure TfrmDownloadData.btnCloseClick(Sender: TObject);
begin
  bTerminated := True;
  Close;
end;

end.
