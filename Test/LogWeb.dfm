object fromLogWeb: TfromLogWeb
  Left = 0
  Top = 0
  Caption = 'fromLogWeb'
  ClientHeight = 441
  ClientWidth = 1051
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object SpeedButton2: TSpeedButton
    Left = 0
    Top = 221
    Width = 1051
    Height = 22
    Align = alTop
    OnClick = SpeedButton2Click
    ExplicitLeft = -8
    ExplicitTop = 203
    ExplicitWidth = 624
  end
  object Splitter1: TSplitter
    Left = 0
    Top = 218
    Width = 1051
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 194
    ExplicitWidth = 247
  end
  object Panel1: TPanel
    Left = 0
    Top = 81
    Width = 1051
    Height = 137
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 0
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
      Width = 675
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
    Top = 243
    Width = 1051
    Height = 198
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
    Width = 1051
    Height = 81
    Align = alTop
    TabOrder = 2
    object SpeedButton1: TSpeedButton
      Left = 978
      Top = 1
      Width = 72
      Height = 79
      Align = alRight
      Caption = '>>'
      OnClick = SpeedButton1Click
      ExplicitLeft = 552
      ExplicitTop = 6
      ExplicitHeight = 35
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
    object cbComConexoes: TCheckBox
      Left = 32
      Top = 50
      Width = 97
      Height = 17
      Caption = 'Com conex'#245'es'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = cbComConexoesClick
    end
    object qsdPeriodo: TQuerySelectData
      Left = 156
      Top = 15
      Width = 241
      Height = 52
      Caption = ''
      TabOrder = 2
      campo = 'c.dh'
      Estilo = lwd_Horizontal
      Glyph.Data = {
        9E010000424D9E0100000000000036000000280000000C0000000A0000000100
        18000000000068010000C40E0000C40E000000000000000000004D4D4D606060
        5B5B5B5C5C5C5E5E5E5F5F5F5B5B5B5757575151515656566060604E4E4E5555
        55F8F8F8F9F9F9F6F6F6F4F4F4F2F2F2EBEBEBBEBEBEA4A4A4989898DFDFDF57
        5757565656F8F8F8FBFBFBE8E8E8E3E3E3E8E8E8EFEFEFEFEFEFE4E4E4E6E6E6
        A7A7A7535353565656F8F8F8F7F7F7E0E0E0DCDCDCE6E6E6E9E9E9EFEFEFE4E4
        E4F7F7F7CBCBCB505050555555F8F8F8F8F8F8E2E2E2DEDEDEE1E1E1EDEDEDEF
        EFEFE7E7E7FDFDFDE8E8E84F4F4F555555F8F8F8FFFFFFFCFCFCFDFDFDDFDFDF
        EBEBEBEFEFEFE4E4E4FFFFFFF3F3F3545454555555F7F7F7B1B1B0FEFEFEE6E6
        E6F5F5F5FDFDFED8D8D8FFFFFFCDCDCDF6F6F65454541D1D5D52528B9999B358
        58A6B1B1C45858B06464AD8484B25858ABB3B3C15858991F1F5E03038701018E
        2F31930202AA2C2CAD0202B30404BD2D2D9B0400B230309A04029404048A5151
        B60404A00404B00608BA0000C60000CE0002D20002CE0000C20602B60000AA51
        51B5}
      CaptionInicio = 'Data inicial'
      CaptionFim = 'Data final'
      CheckedInicio = True
      CheckedFim = True
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
