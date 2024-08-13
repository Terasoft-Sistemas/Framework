object FormEP: TFormEP
  Left = 0
  Top = 0
  Caption = 'Endpoint'
  ClientHeight = 629
  ClientWidth = 1039
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
  object sbAbrir: TSpeedButton
    Left = 375
    Top = 40
    Width = 113
    Height = 22
    Caption = 'Abrir'
    Enabled = False
    OnClick = sbAbrirClick
  end
  object lblConsulta: TLabel
    Left = 24
    Top = 24
    Width = 47
    Height = 15
    Caption = 'Consulta'
  end
  object Label1: TLabel
    Left = 24
    Top = 72
    Width = 32
    Height = 15
    Caption = 'Filtros'
  end
  object sbLImparFiltros: TSpeedButton
    Left = 448
    Top = 93
    Width = 168
    Height = 22
    Caption = 'Limpar Filtros'
    OnClick = sbLImparFiltrosClick
  end
  object sbValoresFiltro: TSpeedButton
    Left = 297
    Top = 94
    Width = 145
    Height = 22
    Caption = 'Itens do Filtro'
    OnClick = sbValoresFiltroClick
  end
  object sbExportar: TSpeedButton
    Left = 512
    Top = 40
    Width = 104
    Height = 23
    Caption = 'Exportar'
    Enabled = False
    OnClick = sbExportarClick
  end
  object cbEP: TTeraComboBox
    Left = 24
    Top = 40
    Width = 241
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 0
    Text = 'Teste1'
    OnChange = cbEPChange
    Items.Strings = (
      'Teste1'
      'Teste2')
    values.Strings = (
      '0'
      '1')
  end
  object grid: TXDBGrid
    Left = 0
    Top = 204
    Width = 1039
    Height = 305
    Align = alBottom
    GridStyle.VisualStyle = vsXPStyle
    TabOrder = 1
  end
  object cbFiltros: TTeraComboBox
    Left = 24
    Top = 93
    Width = 241
    Height = 23
    Style = csDropDownList
    Enabled = False
    TabOrder = 2
    OnChange = cbFiltrosChange
  end
  object grid2: TXDBGrid
    Left = 0
    Top = 509
    Width = 1039
    Height = 120
    Align = alBottom
    GridStyle.VisualStyle = vsXPStyle
    TabOrder = 3
  end
end
