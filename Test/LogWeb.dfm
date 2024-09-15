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
  PixelsPerInch = 96
  TextHeight = 15
  object SpeedButton2: TSpeedButton
    Left = 0
    Top = 181
    Width = 624
    Height = 22
    Align = alTop
    OnClick = SpeedButton2Click
    ExplicitLeft = -8
    ExplicitTop = 203
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 178
    Width = 624
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 194
    ExplicitWidth = 247
  end
  object Panel1: TPanel
    Left = 0
    Top = 41
    Width = 624
    Height = 137
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
    ExplicitTop = 35
    object Splitter2: TSplitter
      Left = 372
      Top = 1
      Height = 135
      ExplicitLeft = 376
      ExplicitTop = 72
      ExplicitHeight = 100
    end
    object Splitter3: TSplitter
      Left = 153
      Top = 1
      Height = 135
      ExplicitLeft = 152
      ExplicitTop = 72
      ExplicitHeight = 100
    end
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
      Left = 156
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
      Left = 375
      Top = 1
      Width = 248
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
    Top = 203
    Width = 624
    Height = 238
    Align = alClient
    DataSource = dsEv
    GridStyle.VisualStyle = vsXPStyle
    ReadOnly = True
    TabOrder = 1
    OnCellDblClick = gridEventosCellDblClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 41
    Align = alTop
    TabOrder = 2
    ExplicitLeft = 216
    ExplicitTop = -6
    ExplicitWidth = 185
    DesignSize = (
      624
      41)
    object SpeedButton1: TSpeedButton
      Left = 552
      Top = 6
      Width = 72
      Height = 35
      Anchors = [akTop, akRight]
      Caption = '>>'
      OnClick = SpeedButton1Click
    end
    object cbDeadlock: TCheckBox
      Left = 32
      Top = 13
      Width = 97
      Height = 17
      Caption = 'Deadlock'
      TabOrder = 0
      OnClick = cbDeadlockClick
    end
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
