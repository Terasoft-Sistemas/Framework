object frmEditorConsultas: TfrmEditorConsultas
  Left = 0
  Top = 0
  Caption = 'Editor de Consultas'
  ClientHeight = 659
  ClientWidth = 1111
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object gridEP: TXDBGrid
    Left = 0
    Top = 0
    Width = 1111
    Height = 265
    Align = alTop
    DataSource = dsEP
    GridStyle.VisualStyle = vsXPStyle
    ReadOnly = True
    TabOrder = 0
  end
  object pnGestao: TPanel
    Left = 0
    Top = 265
    Width = 1111
    Height = 64
    Align = alTop
    TabOrder = 1
    ExplicitLeft = 1
    ExplicitTop = 260
    ExplicitWidth = 1040
    DesignSize = (
      1111
      64)
    object btnNovo: TBitBtn
      Left = 707
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNovoClick
      ExplicitLeft = 636
    end
    object btnEditar: TBitBtn
      Left = 788
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditarClick
      ExplicitLeft = 717
    end
    object btnCancelar: TBitBtn
      Left = 869
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
      ExplicitLeft = 798
    end
    object btnGravar: TBitBtn
      Left = 950
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Gravar'
      TabOrder = 3
      OnClick = btnGravarClick
      ExplicitLeft = 879
    end
    object Testar: TBitBtn
      Left = 1031
      Top = 16
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Testar'
      TabOrder = 4
      OnClick = TestarClick
      ExplicitLeft = 960
    end
  end
  object pnEdicao: TPanel
    Left = 0
    Top = 329
    Width = 1111
    Height = 330
    Align = alClient
    Caption = 'pnEdicao'
    Enabled = False
    TabOrder = 2
    ExplicitLeft = 320
    ExplicitTop = 408
    ExplicitWidth = 185
    ExplicitHeight = 41
    object PC: TPageControl
      Left = 1
      Top = 1
      Width = 1109
      Height = 328
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 1038
      ExplicitHeight = 283
      object tsDados: TTabSheet
        Caption = 'Dados'
        ImageIndex = 1
        object lblDescricao: TLabel
          Left = 16
          Top = 88
          Width = 51
          Height = 15
          Caption = 'Descri'#231#227'o'
          FocusControl = edDescricao
        end
        object edNome: TDBLabeledEdit
          Left = 16
          Top = 32
          Width = 321
          Height = 23
          DataField = 'NOME'
          DataSource = dsEP
          TabOrder = 0
          EditLabel.Width = 100
          EditLabel.Height = 15
          EditLabel.Caption = 'Nome do Relat'#243'rio'
        end
        object edDescricao: TDBMemo
          Left = 16
          Top = 109
          Width = 1001
          Height = 137
          DataField = 'descricao'
          DataSource = dsEP
          TabOrder = 1
          WordWrap = False
        end
      end
      object tsQuery: TTabSheet
        Caption = 'Query'
        object DBMemo1: TDBMemo
          Left = 0
          Top = 0
          Width = 1101
          Height = 298
          Align = alClient
          DataField = 'query'
          DataSource = dsEP
          TabOrder = 0
          ExplicitLeft = 264
          ExplicitTop = 64
          ExplicitWidth = 185
          ExplicitHeight = 89
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Filtros'
        ImageIndex = 2
        object gridFiltros: TXDBGrid
          Left = 0
          Top = 0
          Width = 320
          Height = 298
          Align = alLeft
          DataSource = dsFiltros
          GridStyle.VisualStyle = vsXPStyle
          TabOrder = 0
        end
        object pnGestaoPropriedadesFiltro: TPanel
          Left = 320
          Top = 0
          Width = 97
          Height = 298
          Align = alLeft
          TabOrder = 1
          ExplicitHeight = 253
          object btnFiltroEditar: TBitBtn
            Left = 6
            Top = 55
            Width = 75
            Height = 25
            Caption = 'Editar'
            TabOrder = 0
            OnClick = btnFiltroEditarClick
          end
          object btnFiltroCancelar: TBitBtn
            Left = 6
            Top = 117
            Width = 75
            Height = 25
            Caption = 'Cancelar'
            TabOrder = 1
            OnClick = btnFiltroCancelarClick
          end
          object btnFiltroSalvar: TBitBtn
            Left = 6
            Top = 86
            Width = 75
            Height = 25
            Caption = 'Salvar'
            TabOrder = 2
            OnClick = btnFiltroSalvarClick
          end
          object btnFiltroNovo: TBitBtn
            Left = 6
            Top = 24
            Width = 75
            Height = 25
            Caption = 'Novo'
            TabOrder = 3
            OnClick = btnFiltroNovoClick
          end
          object btnFiltroExcluir: TBitBtn
            Left = 6
            Top = 148
            Width = 75
            Height = 25
            Caption = 'Excluir'
            TabOrder = 4
            OnClick = btnFiltroExcluirClick
          end
        end
        object pnPropFiltro: TPanel
          Left = 417
          Top = 0
          Width = 684
          Height = 298
          Align = alClient
          TabOrder = 2
          Visible = False
          ExplicitLeft = 414
          ExplicitWidth = 613
          ExplicitHeight = 253
          object lblNome: TLabel
            Left = 24
            Top = 8
            Width = 46
            Height = 15
            Caption = 'lblNome'
            FocusControl = edPropFiltroNome
          end
          object edPropFiltroValor: TLabeledEdit
            Left = 24
            Top = 200
            Width = 353
            Height = 23
            EditLabel.Width = 86
            EditLabel.Height = 15
            EditLabel.Caption = 'Campo do Filtro'
            TabOrder = 2
            Text = ''
          end
          object edPropFiltroDescricao: TLabeledEdit
            Left = 24
            Top = 88
            Width = 353
            Height = 23
            EditLabel.Width = 98
            EditLabel.Height = 15
            EditLabel.Caption = 'Descri'#231#227'o do Filtro'
            TabOrder = 0
            Text = ''
          end
          object edPropFiltroValores: TLabeledEdit
            Left = 24
            Top = 136
            Width = 353
            Height = 23
            EditLabel.Width = 84
            EditLabel.Height = 15
            EditLabel.Caption = 'Valores do Filtro'
            TabOrder = 1
            Text = ''
          end
          object mmProFiltroValores: TMemo
            Left = 383
            Top = 13
            Width = 290
            Height = 276
            Lines.Strings = (
              'mmProFiltroValores')
            TabOrder = 3
          end
          object edPropFiltroNome: TComboBox
            Left = 24
            Top = 29
            Width = 353
            Height = 23
            TabOrder = 4
            Text = 'edPropFiltroNome'
            Items.Strings = (
              '@loja'
              '@lojas')
          end
        end
      end
    end
  end
  object dsEP: TDataSource
    AutoEdit = False
    OnStateChange = dsEPStateChange
    Left = 240
    Top = 56
  end
  object dsFiltros: TDataSource
    AutoEdit = False
    Left = 360
    Top = 96
  end
end
