object fromLogWeb: TfromLogWeb
  Left = 0
  Top = 0
  Caption = 'fromLogWeb'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object SpeedButton1: TSpeedButton
    Left = 0
    Top = 0
    Width = 624
    Height = 35
    Align = alTop
    OnClick = SpeedButton1Click
  end
  object SpeedButton2: TSpeedButton
    Left = 0
    Top = 172
    Width = 624
    Height = 22
    Align = alTop
    OnClick = SpeedButton2Click
    ExplicitLeft = 360
    ExplicitTop = 344
    ExplicitWidth = 23
  end
  object Panel1: TPanel
    Left = 0
    Top = 35
    Width = 624
    Height = 137
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    object gridInstancias: TXDBGrid
      Left = 1
      Top = 1
      Width = 152
      Height = 135
      Align = alLeft
      DataSource = dsInst
      GridStyle.VisualStyle = vsXPStyle
      ReadOnly = True
      TabOrder = 0
      OnCellClick = gridInstanciasCellClick
      OnCellDblClick = gridInstanciasCellDblClick
    end
    object gridExecucao: TXDBGrid
      Left = 153
      Top = 1
      Width = 216
      Height = 135
      Align = alLeft
      DataSource = dsExec
      GridStyle.VisualStyle = vsXPStyle
      ReadOnly = True
      TabOrder = 1
      OnCellClick = gridExecucaoCellClick
      OnCellDblClick = gridExecucaoCellDblClick
    end
    object gridConexoes: TXDBGrid
      Left = 369
      Top = 1
      Width = 254
      Height = 135
      Align = alClient
      DataSource = dsCon
      GridStyle.VisualStyle = vsXPStyle
      ReadOnly = True
      TabOrder = 2
      OnCellClick = gridConexoesCellClick
      OnCellDblClick = gridConexoesCellDblClick
    end
  end
  object gridEventos: TXDBGrid
    Left = 0
    Top = 194
    Width = 624
    Height = 247
    Align = alClient
    DataSource = dsEv
    GridStyle.VisualStyle = vsXPStyle
    ReadOnly = True
    TabOrder = 1
    OnCellDblClick = gridEventosCellDblClick
  end
  object dsInst: TDataSource
    AutoEdit = False
    OnDataChange = dsInstDataChange
    Left = 64
    Top = 64
  end
  object dsExec: TDataSource
    AutoEdit = False
    OnDataChange = dsExecDataChange
    Left = 232
    Top = 56
  end
  object dsCon: TDataSource
    OnDataChange = dsConDataChange
    Left = 456
    Top = 83
  end
  object dsEv: TDataSource
    Left = 232
    Top = 264
  end
end
