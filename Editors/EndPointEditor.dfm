object frmEditorConsultas: TfrmEditorConsultas
  Left = 0
  Top = 0
  Caption = 'Editor de Consultas'
  ClientHeight = 699
  ClientWidth = 1111
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
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
    DesignSize = (
      1111
      64)
    object btnNovo: TBitBtn
      Left = 711
      Top = 17
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Novo'
      TabOrder = 0
      OnClick = btnNovoClick
    end
    object btnEditar: TBitBtn
      Left = 790
      Top = 17
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditarClick
    end
    object btnCancelar: TBitBtn
      Left = 869
      Top = 17
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnGravar: TBitBtn
      Left = 950
      Top = 17
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Gravar'
      TabOrder = 3
      OnClick = btnGravarClick
    end
    object btnReconsultar: TBitBtn
      Left = 632
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Reconsultar'
      TabOrder = 4
    end
  end
  object pnEdicao: TPanel
    Left = 0
    Top = 329
    Width = 1111
    Height = 370
    Align = alClient
    Caption = 'pnEdicao'
    Enabled = False
    TabOrder = 2
    object PC: TPageControl
      Left = 1
      Top = 1
      Width = 1109
      Height = 368
      ActivePage = tsDados
      Align = alClient
      TabOrder = 0
      OnChange = PCChange
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
          EditLabel.Layout = tlCenter
        end
        object edDescricao: TDBMemo
          Left = 16
          Top = 109
          Width = 1001
          Height = 137
          DataField = 'descricao'
          DataSource = dsEP
          TabOrder = 3
          WordWrap = False
        end
        object edPermissao: TLabeledEdit
          Left = 376
          Top = 30
          Width = 217
          Height = 23
          EditLabel.Width = 54
          EditLabel.Height = 15
          EditLabel.Caption = 'Permiss'#227'o'
          TabOrder = 1
          Text = ''
        end
        object edPermissaoLoja: TLabeledEdit
          Left = 608
          Top = 30
          Width = 217
          Height = 23
          EditLabel.Width = 79
          EditLabel.Height = 15
          EditLabel.Caption = 'Permiss'#227'o Loja'
          TabOrder = 2
          Text = ''
        end
      end
      object tsQuery: TTabSheet
        Caption = 'Query'
        object DBMemo1: TDBMemo
          Left = 0
          Top = 0
          Width = 1101
          Height = 217
          Align = alTop
          DataField = 'query'
          DataSource = dsEP
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object edGroupBy: TLabeledEdit
          Left = 3
          Top = 288
          Width = 936
          Height = 23
          EditLabel.Width = 114
          EditLabel.Height = 15
          EditLabel.Caption = 'Cl'#225'usula "GROUP BY"'
          TabOrder = 2
          Text = ''
        end
        object edWhere: TLabeledEdit
          Left = 3
          Top = 240
          Width = 936
          Height = 23
          EditLabel.Width = 97
          EditLabel.Height = 15
          EditLabel.Caption = 'Cl'#225'usula "WHERE"'
          TabOrder = 1
          Text = ''
        end
      end
      object tsFiltros: TTabSheet
        Caption = 'Filtros'
        ImageIndex = 2
        object gridFiltros: TXDBGrid
          Left = 0
          Top = 0
          Width = 320
          Height = 338
          Align = alLeft
          DataSource = dsFiltros
          GridStyle.VisualStyle = vsXPStyle
          TabOrder = 0
        end
        object pnGestaoPropriedadesFiltro: TPanel
          Left = 320
          Top = 0
          Width = 97
          Height = 338
          Align = alLeft
          TabOrder = 1
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
          Height = 338
          Align = alClient
          TabOrder = 2
          Visible = False
          object lblNome: TLabel
            Left = 24
            Top = 8
            Width = 33
            Height = 15
            Caption = 'Nome'
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
            DropDownCount = 20
            TabOrder = 4
            Text = 'edPropFiltroNome'
            Items.Strings = (
              '@loja'
              '@lojas'
              '@busca'
              '@periodo.data'
              '@periodo.null'
              '@periodo.hora'
              '@inteiro'
              '@agrupamento'
              '@string'
              '@periodo.datahora'
              '@periodo.datahora.null')
          end
        end
      end
      object tsFormatações: TTabSheet
        Caption = 'Formata'#231#245'es'
        ImageIndex = 3
        object gridCampos: TXDBGrid
          Left = 0
          Top = 0
          Width = 249
          Height = 338
          Align = alLeft
          DataSource = dsCampos
          GridStyle.VisualStyle = vsXPStyle
          ReadOnly = True
          TabOrder = 0
          OnCellClick = gridCamposCellClick
        end
        object pnGestaoFormatacoes: TPanel
          Left = 249
          Top = 0
          Width = 88
          Height = 338
          Align = alLeft
          TabOrder = 1
          object btnGestaoformatacoesEditar: TBitBtn
            Left = 7
            Top = 55
            Width = 75
            Height = 25
            Caption = 'Editar'
            TabOrder = 0
            OnClick = btnGestaoformatacoesEditarClick
          end
          object btnGestaoformatacoesCancelar: TBitBtn
            Left = 6
            Top = 117
            Width = 75
            Height = 25
            Caption = 'Cancelar'
            TabOrder = 1
            OnClick = btnGestaoformatacoesCancelarClick
          end
          object btnGestaoformatacoesSalvar: TBitBtn
            Left = 6
            Top = 86
            Width = 75
            Height = 25
            Caption = 'Salvar'
            TabOrder = 2
            OnClick = btnGestaoformatacoesSalvarClick
          end
          object cbOrdenarCampos: TCheckBox
            Left = 8
            Top = 160
            Width = 97
            Height = 17
            Caption = 'Ordenar'
            TabOrder = 3
            OnClick = cbOrdenarCamposClick
          end
        end
        object pnPropCampo: TPanel
          Left = 337
          Top = 0
          Width = 764
          Height = 338
          Align = alClient
          TabOrder = 2
          object edtFormatacaoCampoFormato: TLabeledEdit
            Left = 32
            Top = 123
            Width = 169
            Height = 23
            EditLabel.Width = 45
            EditLabel.Height = 15
            EditLabel.Caption = 'Formato'
            TabOrder = 3
            Text = ''
          end
          object edtFormatacaoCampoTamanho: TLabeledEdit
            Left = 32
            Top = 176
            Width = 169
            Height = 23
            EditLabel.Width = 49
            EditLabel.Height = 15
            EditLabel.Caption = 'Tamanho'
            TabOrder = 4
            Text = ''
          end
          object edtFormatacaoCampoVisivel: TCheckBox
            Left = 32
            Top = 16
            Width = 97
            Height = 17
            Caption = 'Vis'#237'vel'
            TabOrder = 0
          end
          object edtFormatacaoCampoSumario: TCheckBox
            Left = 232
            Top = 16
            Width = 97
            Height = 17
            Caption = 'Sum'#225'rio'
            TabOrder = 1
          end
          object edtFormatacaoCampoTitulo: TLabeledEdit
            Left = 32
            Top = 70
            Width = 169
            Height = 23
            EditLabel.Width = 30
            EditLabel.Height = 15
            EditLabel.Caption = 'T'#237'tulo'
            TabOrder = 2
            Text = ''
          end
          object edtFormatacaoCampoExpressao: TLabeledEdit
            Left = 232
            Top = 176
            Width = 393
            Height = 23
            EditLabel.Width = 52
            EditLabel.Height = 15
            EditLabel.Caption = 'Express'#227'o'
            TabOrder = 5
            Text = ''
          end
          object edtFormatacaoCampoOperacoes: TRadioGroup
            Left = 232
            Top = 56
            Width = 265
            Height = 89
            Caption = 'Opera'#231#245'es'
            Columns = 2
            Items.Strings = (
              'Nada'
              'Soma'
              'M'#233'dia,'
              'Min'
              'Max'
              'Count'
              'Express'#227'o')
            TabOrder = 6
            OnClick = edtFormatacaoCampoOperacoesClick
          end
          object edtFormatacaoCampoPosicao: TLabeledEdit
            Left = 32
            Top = 232
            Width = 169
            Height = 23
            EditLabel.Width = 41
            EditLabel.Height = 15
            EditLabel.Caption = 'Posi'#231#227'o'
            TabOrder = 7
            Text = ''
          end
          object edtFormatacaoCampoAlinhamento: TRadioGroup
            Left = 232
            Top = 205
            Width = 321
            Height = 60
            Caption = 'Alinhamento'
            Columns = 2
            Items.Strings = (
              'Padr'#227'o'
              'Esquerda'
              'Direita'
              'Centro')
            TabOrder = 8
          end
        end
      end
      object tsImpressoes: TTabSheet
        Caption = 'Impress'#245'es'
        ImageIndex = 4
        object gridImpressoes: TXDBGrid
          Left = 0
          Top = 0
          Width = 281
          Height = 338
          Align = alLeft
          DataSource = dsImpressoes
          GridStyle.VisualStyle = vsXPStyle
          ReadOnly = True
          TabOrder = 0
          OnCellClick = gridCamposCellClick
        end
        object Panel1: TPanel
          Left = 281
          Top = 0
          Width = 91
          Height = 338
          Align = alLeft
          TabOrder = 1
          object btnImpressoesEditar: TBitBtn
            Left = 6
            Top = 55
            Width = 75
            Height = 25
            Caption = 'Editar'
            TabOrder = 0
            OnClick = btnImpressoesEditarClick
          end
          object btnImpressoesCancelar: TBitBtn
            Left = 6
            Top = 117
            Width = 75
            Height = 25
            Caption = 'Cancelar'
            TabOrder = 1
            OnClick = btnImpressoesCancelarClick
          end
          object btnImpressoesSalvar: TBitBtn
            Left = 6
            Top = 86
            Width = 75
            Height = 25
            Caption = 'Salvar'
            TabOrder = 2
            OnClick = btnImpressoesSalvarClick
          end
          object btnImpressoesNovo: TBitBtn
            Left = 6
            Top = 24
            Width = 75
            Height = 25
            Caption = 'Novo'
            TabOrder = 3
            OnClick = btnImpressoesNovoClick
          end
          object btnImpressoesExcluir: TBitBtn
            Left = 6
            Top = 148
            Width = 75
            Height = 25
            Caption = 'Excluir'
            TabOrder = 4
            OnClick = btnImpressoesExcluirClick
          end
        end
        object pnImpressoes: TPanel
          Left = 372
          Top = 0
          Width = 729
          Height = 338
          Align = alClient
          TabOrder = 2
          object PCImpressoes: TPageControl
            Left = 1
            Top = 1
            Width = 727
            Height = 336
            ActivePage = tsImpressaoFormatacao
            Align = alClient
            TabOrder = 0
            OnChange = PCImpressoesChange
            object tsImpressaoDados: TTabSheet
              Caption = 'Dados'
              object edtImpressaoNome: TLabeledEdit
                Left = 32
                Top = 32
                Width = 369
                Height = 23
                EditLabel.Width = 33
                EditLabel.Height = 15
                EditLabel.Caption = 'Nome'
                TabOrder = 0
                Text = ''
              end
              object edtImpressaoDescricao: TLabeledEdit
                Left = 32
                Top = 88
                Width = 369
                Height = 23
                EditLabel.Width = 51
                EditLabel.Height = 15
                EditLabel.Caption = 'Descri'#231#227'o'
                TabOrder = 1
                Text = ''
              end
              object edtImpressaoTitulo: TLabeledEdit
                Left = 32
                Top = 144
                Width = 369
                Height = 23
                EditLabel.Width = 30
                EditLabel.Height = 15
                EditLabel.Caption = 'T'#237'tulo'
                TabOrder = 2
                Text = ''
              end
              object edImpressaoOrientacao: TRadioGroup
                Left = 440
                Top = 32
                Width = 185
                Height = 105
                Caption = 'Orienta'#231#227'o'
                Items.Strings = (
                  'Retrato'
                  'Paisagem')
                TabOrder = 3
              end
            end
            object tsImpressaoFormatacao: TTabSheet
              Caption = 'Formata'#231#227'o'
              ImageIndex = 1
              object gridImpressaoFormatacaoCampo: TXDBGrid
                Left = 0
                Top = 0
                Width = 249
                Height = 306
                Align = alLeft
                DataSource = dsCampos
                GridStyle.VisualStyle = vsXPStyle
                ReadOnly = True
                TabOrder = 0
                OnCellClick = gridImpressaoFormatacaoCampoCellClick
              end
              object pnGestaoImpressao: TPanel
                Left = 249
                Top = 0
                Width = 88
                Height = 306
                Align = alLeft
                TabOrder = 1
                object btnImpressaoEditar: TBitBtn
                  Left = 6
                  Top = 55
                  Width = 75
                  Height = 25
                  Caption = 'Editar'
                  TabOrder = 0
                  OnClick = btnImpressaoEditarClick
                end
                object btnImpressaoCancelar: TBitBtn
                  Left = 6
                  Top = 117
                  Width = 75
                  Height = 25
                  Caption = 'Cancelar'
                  TabOrder = 1
                  OnClick = btnImpressaoCancelarClick
                end
                object btnImpressaoSalvar: TBitBtn
                  Left = 6
                  Top = 86
                  Width = 75
                  Height = 25
                  Caption = 'Salvar'
                  TabOrder = 2
                  OnClick = btnImpressaoSalvarClick
                end
                object cbOrdenarCampos2: TCheckBox
                  Left = 11
                  Top = 160
                  Width = 71
                  Height = 17
                  Caption = 'Ordenar'
                  TabOrder = 3
                  OnClick = cbOrdenarCampos2Click
                end
              end
              object pnImpressaoFormatacao: TPanel
                Left = 337
                Top = 0
                Width = 382
                Height = 306
                Align = alClient
                TabOrder = 2
                object edtImpressaoFormatoVisivel: TCheckBox
                  Left = 6
                  Top = 8
                  Width = 97
                  Height = 17
                  Caption = 'Vis'#237'vel'
                  TabOrder = 0
                end
                object edtImpressaoFormatoSumário: TCheckBox
                  Left = 184
                  Top = 8
                  Width = 97
                  Height = 17
                  Caption = 'Sum'#225'rio'
                  TabOrder = 1
                end
                object edtImpressaoFormatoLabel: TLabeledEdit
                  Left = 6
                  Top = 46
                  Width = 169
                  Height = 23
                  EditLabel.Width = 30
                  EditLabel.Height = 15
                  EditLabel.Caption = 'T'#237'tulo'
                  TabOrder = 2
                  Text = ''
                end
                object edtImpressaoTituloSumario: TLabeledEdit
                  Left = 181
                  Top = 46
                  Width = 169
                  Height = 23
                  EditLabel.Width = 93
                  EditLabel.Height = 15
                  EditLabel.Caption = 'Titulo no sum'#225'rio'
                  TabOrder = 3
                  Text = ''
                end
                object edtImpressaoFormatoTamanho: TLabeledEdit
                  Left = 6
                  Top = 94
                  Width = 169
                  Height = 23
                  EditLabel.Width = 49
                  EditLabel.Height = 15
                  EditLabel.Caption = 'Tamanho'
                  TabOrder = 4
                  Text = ''
                end
                object edtImpressaoFormatoTamanhoSumario: TLabeledEdit
                  Left = 181
                  Top = 94
                  Width = 169
                  Height = 23
                  EditLabel.Width = 112
                  EditLabel.Height = 15
                  EditLabel.Caption = 'Tamanho no sum'#225'rio'
                  TabOrder = 5
                  Text = ''
                end
                object edtImpressaoFormatoAlinhamento: TRadioGroup
                  Left = 6
                  Top = 221
                  Width = 170
                  Height = 60
                  Caption = 'Alinhamento'
                  Columns = 2
                  Items.Strings = (
                    'Padr'#227'o'
                    'Esquerda'
                    'Direita'
                    'Centro')
                  TabOrder = 8
                end
                object edtImpressaoFormatoAlinhamentoSumario: TRadioGroup
                  Left = 182
                  Top = 221
                  Width = 171
                  Height = 60
                  Caption = 'Alinhamento Sum'#225'rio'
                  Columns = 2
                  Items.Strings = (
                    'Padr'#227'o'
                    'Esquerda'
                    'Direita'
                    'Centro')
                  TabOrder = 9
                end
                object edtImpressaoFormatoFormato: TLabeledEdit
                  Left = 6
                  Top = 144
                  Width = 169
                  Height = 23
                  EditLabel.Width = 45
                  EditLabel.Height = 15
                  EditLabel.Caption = 'Formato'
                  TabOrder = 6
                  Text = ''
                end
                object edtImpressaoFormatoFormatoSumario: TLabeledEdit
                  Left = 181
                  Top = 144
                  Width = 169
                  Height = 23
                  EditLabel.Width = 108
                  EditLabel.Height = 15
                  EditLabel.Caption = 'Formato no sum'#225'rio'
                  TabOrder = 7
                  Text = ''
                end
                object edtImpressaoFormatoPosicao: TLabeledEdit
                  Left = 6
                  Top = 192
                  Width = 169
                  Height = 23
                  EditLabel.Width = 41
                  EditLabel.Height = 15
                  EditLabel.Caption = 'Posi'#231#227'o'
                  TabOrder = 10
                  Text = ''
                end
                object edtImpressaoFormatoPosicaoSumario: TLabeledEdit
                  Left = 182
                  Top = 192
                  Width = 169
                  Height = 23
                  EditLabel.Width = 104
                  EditLabel.Height = 15
                  EditLabel.Caption = 'Posi'#231#227'o no sum'#225'rio'
                  TabOrder = 11
                  Text = ''
                end
              end
            end
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
  object dsCampos: TDataSource
    AutoEdit = False
    Left = 424
    Top = 88
  end
  object dsImpressoes: TDataSource
    Left = 496
    Top = 112
  end
end
