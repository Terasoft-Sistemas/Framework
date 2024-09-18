object Form1: TForm1
  Left = 0
  Top = 270
  Caption = 'Form1'
  ClientHeight = 769
  ClientWidth = 1254
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 1254
    Height = 769
    ActivePage = TabSheet11
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1252
    ExplicitHeight = 761
    object TabSheet1: TTabSheet
      Caption = 'Diversos'
      object SpeedButton2: TSpeedButton
        Left = 755
        Top = 15
        Width = 143
        Height = 42
        Caption = 'Arredonda Parcela'
        OnClick = SpeedButton2Click
      end
      object SpeedButton3: TSpeedButton
        Left = 755
        Top = 111
        Width = 143
        Height = 42
        Caption = 'Editar Consultas'
        OnClick = SpeedButton3Click
      end
      object SpeedButton4: TSpeedButton
        Left = 755
        Top = 159
        Width = 143
        Height = 42
        Caption = 'Consultas'
        OnClick = SpeedButton4Click
      end
      object SpeedButton5: TSpeedButton
        Left = 755
        Top = 63
        Width = 143
        Height = 42
        Caption = 'Logs '
        OnClick = SpeedButton5Click
      end
      object memoResultado: TMemo
        Left = 904
        Top = 15
        Width = 321
        Height = 681
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btnFinanceiroPedido: TButton
        Left = 191
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Financeiro Pedido Consultar'
        TabOrder = 1
        OnClick = btnFinanceiroPedidoClick
      end
      object Button1: TButton
        Left = 3
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Financeiro Pedido Inserir'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 379
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Financeiro Pedido Update'
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 567
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Financeiro Pedido Excluir'
        TabOrder = 4
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 191
        Top = 63
        Width = 182
        Height = 42
        Caption = 'WebPedido Consultar'
        TabOrder = 5
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 3
        Top = 63
        Width = 182
        Height = 42
        Caption = 'WebPedido Inserir'
        TabOrder = 6
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 379
        Top = 63
        Width = 182
        Height = 42
        Caption = 'WebPedido Update'
        TabOrder = 7
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 567
        Top = 63
        Width = 182
        Height = 42
        Caption = 'WebPedido Excluir'
        TabOrder = 8
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 3
        Top = 111
        Width = 182
        Height = 42
        Caption = 'WebPedido Vender Itens'
        TabOrder = 9
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 191
        Top = 111
        Width = 182
        Height = 42
        Caption = 'WebPedido Itens Consultar '
        TabOrder = 10
        OnClick = Button9Click
      end
      object Button10: TButton
        Left = 379
        Top = 111
        Width = 182
        Height = 42
        Caption = 'WebPedido Itens Update'
        TabOrder = 11
        OnClick = Button10Click
      end
      object Button11: TButton
        Left = 567
        Top = 111
        Width = 182
        Height = 42
        Caption = 'WebPedido Itens Excluir'
        TabOrder = 12
        OnClick = Button11Click
      end
      object btnTabelaPreco: TButton
        Left = 3
        Top = 159
        Width = 182
        Height = 42
        Caption = 'Consultar tabela Juros'
        TabOrder = 13
        OnClick = btnTabelaPrecoClick
      end
      object btnTotais: TButton
        Left = 191
        Top = 159
        Width = 182
        Height = 42
        Caption = 'Obter Totais'
        TabOrder = 14
        OnClick = btnTotaisClick
      end
      object btnSaldo: TButton
        Left = 379
        Top = 159
        Width = 182
        Height = 42
        Caption = 'Consultar Saldo Lojas'
        TabOrder = 15
        OnClick = btnSaldoClick
      end
      object Button12: TButton
        Left = 567
        Top = 159
        Width = 182
        Height = 42
        Caption = 'Consultar Saldo'
        TabOrder = 16
        OnClick = Button12Click
      end
      object Button13: TButton
        Left = 3
        Top = 207
        Width = 182
        Height = 42
        Caption = 'Valor de venda'
        TabOrder = 17
        OnClick = Button13Click
      end
      object Button14: TButton
        Left = 191
        Top = 207
        Width = 182
        Height = 42
        Caption = 'Reservas CD'
        TabOrder = 18
        OnClick = Button14Click
      end
      object Button15: TButton
        Left = 3
        Top = 255
        Width = 182
        Height = 42
        Caption = 'Entrada Fornecedor Inserir'
        TabOrder = 19
        OnClick = Button15Click
      end
      object Button17: TButton
        Left = 191
        Top = 255
        Width = 182
        Height = 42
        Caption = 'Entrada Fornecedor Consultar'
        TabOrder = 20
        OnClick = Button17Click
      end
      object Button18: TButton
        Left = 379
        Top = 255
        Width = 182
        Height = 42
        Caption = 'Entrada Fornecedor Update'
        TabOrder = 21
        OnClick = Button18Click
      end
      object Button19: TButton
        Left = 567
        Top = 255
        Width = 182
        Height = 42
        Caption = 'Entrada Fornecedor Excluir'
        TabOrder = 22
        OnClick = Button19Click
      end
      object Button20: TButton
        Left = 191
        Top = 447
        Width = 182
        Height = 46
        Caption = 'Cliente Consultar'
        TabOrder = 23
        OnClick = Button20Click
      end
      object Button21: TButton
        Left = 379
        Top = 447
        Width = 182
        Height = 46
        Caption = 'Cliente Update'
        TabOrder = 24
        OnClick = Button21Click
      end
      object Button22: TButton
        Left = 567
        Top = 447
        Width = 182
        Height = 46
        Caption = 'Cliente Excluir'
        TabOrder = 25
        OnClick = Button22Click
      end
      object Button23: TButton
        Left = 3
        Top = 447
        Width = 182
        Height = 46
        Caption = 'Cliente Inserir'
        TabOrder = 26
        OnClick = Button23Click
      end
      object Button16: TButton
        Left = 3
        Top = 351
        Width = 182
        Height = 42
        Caption = 'ContasPagar Inserir'
        TabOrder = 27
        OnClick = Button16Click
      end
      object Button24: TButton
        Left = 379
        Top = 351
        Width = 182
        Height = 42
        Caption = 'ContasPagar Update'
        TabOrder = 28
        OnClick = Button24Click
      end
      object Button25: TButton
        Left = 191
        Top = 351
        Width = 182
        Height = 42
        Caption = 'ContasPagar Consultar'
        TabOrder = 29
        OnClick = Button25Click
      end
      object Button26: TButton
        Left = 567
        Top = 351
        Width = 182
        Height = 42
        Caption = 'ContasPagar Excluir'
        TabOrder = 30
        OnClick = Button26Click
      end
      object Button27: TButton
        Left = 3
        Top = 399
        Width = 182
        Height = 42
        Caption = 'ContasPagarItens Inserir'
        TabOrder = 31
        OnClick = Button27Click
      end
      object Button28: TButton
        Left = 191
        Top = 399
        Width = 182
        Height = 42
        Caption = 'ContasPagarItens Consultar'
        TabOrder = 32
        OnClick = Button28Click
      end
      object Button29: TButton
        Left = 379
        Top = 399
        Width = 182
        Height = 42
        Caption = 'ContasPagarItens Update'
        TabOrder = 33
        OnClick = Button29Click
      end
      object Button30: TButton
        Left = 567
        Top = 399
        Width = 182
        Height = 42
        Caption = 'ContasPagarItens Excluir'
        TabOrder = 34
        OnClick = Button30Click
      end
      object Button31: TButton
        Left = 3
        Top = 303
        Width = 182
        Height = 42
        Caption = 'EntradaItens Inserir'
        TabOrder = 35
        OnClick = Button31Click
      end
      object Button32: TButton
        Left = 191
        Top = 303
        Width = 182
        Height = 42
        Caption = 'EntradaItens Consultar'
        TabOrder = 36
        OnClick = Button32Click
      end
      object Button33: TButton
        Left = 379
        Top = 303
        Width = 182
        Height = 42
        Caption = 'EntradaItens Update'
        TabOrder = 37
        OnClick = Button33Click
      end
      object Button34: TButton
        Left = 567
        Top = 303
        Width = 182
        Height = 42
        Caption = 'EntradaItens Excluir'
        TabOrder = 38
        OnClick = Button34Click
      end
      object Button35: TButton
        Left = 3
        Top = 499
        Width = 182
        Height = 46
        Caption = 'Reserva Inserir'
        TabOrder = 39
        OnClick = Button35Click
      end
      object Button36: TButton
        Left = 191
        Top = 499
        Width = 182
        Height = 46
        Caption = 'Reserva Consultar'
        TabOrder = 40
        OnClick = Button36Click
      end
      object Button37: TButton
        Left = 379
        Top = 499
        Width = 182
        Height = 46
        Caption = 'Reserva Update'
        TabOrder = 41
        OnClick = Button37Click
      end
      object Button38: TButton
        Left = 567
        Top = 499
        Width = 182
        Height = 46
        Caption = 'Reserva Excluir'
        TabOrder = 42
        OnClick = Button38Click
      end
      object Button39: TButton
        Left = 3
        Top = 551
        Width = 182
        Height = 42
        Caption = 'Documento Inserir'
        TabOrder = 43
        OnClick = Button39Click
      end
      object Button40: TButton
        Left = 191
        Top = 551
        Width = 182
        Height = 42
        Caption = 'Documento Consultar'
        TabOrder = 44
        OnClick = Button40Click
      end
      object Button41: TButton
        Left = 379
        Top = 551
        Width = 182
        Height = 42
        Caption = 'Documento Update'
        TabOrder = 45
        OnClick = Button41Click
      end
      object Button42: TButton
        Left = 567
        Top = 551
        Width = 182
        Height = 42
        Caption = 'Documento Excluir'
        TabOrder = 46
        OnClick = Button42Click
      end
      object Button43: TButton
        Left = 3
        Top = 599
        Width = 182
        Height = 42
        Caption = 'Anexo Inserir'
        TabOrder = 47
        OnClick = Button43Click
      end
      object Button44: TButton
        Left = 191
        Top = 599
        Width = 182
        Height = 42
        Caption = 'Anexo Consultar'
        TabOrder = 48
        OnClick = Button44Click
      end
      object Button45: TButton
        Left = 379
        Top = 599
        Width = 182
        Height = 42
        Caption = 'Anexo Update'
        TabOrder = 49
        OnClick = Button45Click
      end
      object Button46: TButton
        Left = 567
        Top = 599
        Width = 182
        Height = 42
        Caption = 'Anexo Excluir'
        TabOrder = 50
        OnClick = Button46Click
      end
      object Button47: TButton
        Left = 379
        Top = 207
        Width = 182
        Height = 42
        Caption = 'Obter Resumo'
        TabOrder = 51
        OnClick = Button47Click
      end
      object Button52: TButton
        Left = 3
        Top = 647
        Width = 182
        Height = 42
        Caption = 'Banco Inserir'
        TabOrder = 52
        OnClick = Button52Click
      end
      object Button53: TButton
        Left = 191
        Top = 647
        Width = 182
        Height = 42
        Caption = 'Banco Consultar'
        TabOrder = 53
        OnClick = Button53Click
      end
      object Button54: TButton
        Left = 379
        Top = 647
        Width = 182
        Height = 42
        Caption = 'Banco Update'
        TabOrder = 54
        OnClick = Button54Click
      end
      object Button55: TButton
        Left = 567
        Top = 647
        Width = 182
        Height = 42
        Caption = 'Banco Excluir'
        TabOrder = 55
        OnClick = Button55Click
      end
      object Button57: TButton
        Left = 567
        Top = 207
        Width = 182
        Height = 42
        Caption = 'Obter Portador Tabela Juros'
        TabOrder = 56
        OnClick = Button57Click
      end
      object Button68: TButton
        Left = 3
        Top = 695
        Width = 182
        Height = 42
        Caption = 'Grupo Inserir'
        TabOrder = 57
        OnClick = Button68Click
      end
      object Button69: TButton
        Left = 191
        Top = 695
        Width = 182
        Height = 42
        Caption = 'Grupo Consultar'
        TabOrder = 58
        OnClick = Button69Click
      end
      object Button70: TButton
        Left = 379
        Top = 695
        Width = 182
        Height = 42
        Caption = 'Grupo Update'
        TabOrder = 59
        OnClick = Button70Click
      end
      object Button71: TButton
        Left = 567
        Top = 695
        Width = 182
        Height = 42
        Caption = 'Grupo Excluir'
        TabOrder = 60
        OnClick = Button71Click
      end
      object Button81: TButton
        Left = 191
        Top = 743
        Width = 182
        Height = 46
        Caption = 'ClientesContato Consultar'
        TabOrder = 61
        OnClick = Button81Click
      end
      object Button82: TButton
        Left = 379
        Top = 743
        Width = 182
        Height = 46
        Caption = 'ClientesContato Update'
        TabOrder = 62
        OnClick = Button82Click
      end
      object Button83: TButton
        Left = 567
        Top = 743
        Width = 182
        Height = 46
        Caption = 'ClientesContato Excluir'
        TabOrder = 63
        OnClick = Button83Click
      end
      object Button84: TButton
        Left = 3
        Top = 743
        Width = 182
        Height = 46
        Caption = 'ClientesContato Inserir'
        TabOrder = 64
        OnClick = Button84Click
      end
      object BtnEndereco2: TButton
        Left = 191
        Top = 795
        Width = 182
        Height = 46
        Caption = 'Endereco Consultar'
        TabOrder = 65
        OnClick = BtnEndereco2Click
      end
      object BtnEndereco3: TButton
        Left = 379
        Top = 795
        Width = 182
        Height = 46
        Caption = 'Endereco Update'
        TabOrder = 66
        OnClick = BtnEndereco3Click
      end
      object BtnEndereco4: TButton
        Left = 567
        Top = 795
        Width = 182
        Height = 46
        Caption = 'Endereco Excluir'
        TabOrder = 67
        OnClick = BtnEndereco4Click
      end
      object BtnEndereco1: TButton
        Left = 3
        Top = 795
        Width = 182
        Height = 46
        Caption = 'Endereco Inserir'
        TabOrder = 68
        OnClick = BtnEndereco1Click
      end
      object Button86: TButton
        Left = 567
        Top = 847
        Width = 182
        Height = 42
        Caption = 'Valores Garantia'
        TabOrder = 69
        OnClick = Button86Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Fluxo de caixa'
      ImageIndex = 1
      object dbTeste2: TXDBGrid
        Left = 0
        Top = 116
        Width = 1246
        Height = 623
        Align = alBottom
        DataSource = dsTeste2
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 0
      end
      object Button48: TButton
        Left = 11
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Fluxo Caixa Sintetico'
        TabOrder = 1
        OnClick = Button48Click
      end
      object Button49: TButton
        Left = 199
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Fluxo Caixa Analitico'
        TabOrder = 2
        OnClick = Button49Click
      end
      object Button50: TButton
        Left = 387
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Fluxo Caixa Resumo'
        TabOrder = 3
        OnClick = Button50Click
      end
      object Button51: TButton
        Left = 575
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Fluxo Caixa Resultado'
        TabOrder = 4
        OnClick = Button51Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Entrada de Fornecedores'
      ImageIndex = 2
      object XDBGrid1: TXDBGrid
        Left = 0
        Top = 490
        Width = 1246
        Height = 249
        Align = alBottom
        DataSource = dsEntradaItens
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 0
      end
      object XDBGrid2: TXDBGrid
        Left = 0
        Top = 328
        Width = 1246
        Height = 162
        Align = alBottom
        DataSource = dsEntrada
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 1
      end
      object Button56: TButton
        Left = 3
        Top = 26
        Width = 182
        Height = 42
        Caption = 'Entrada XML'
        TabOrder = 2
        OnClick = Button56Click
      end
      object Button58: TButton
        Left = 191
        Top = 26
        Width = 182
        Height = 42
        Caption = 'Consultar Entrada'
        TabOrder = 3
        OnClick = Button58Click
      end
      object Button59: TButton
        Left = 3
        Top = 74
        Width = 182
        Height = 42
        Caption = 'Entrada Manual Cabe'#231'alho'
        TabOrder = 4
        OnClick = Button59Click
      end
      object Button60: TButton
        Left = 191
        Top = 74
        Width = 182
        Height = 42
        Caption = 'Entrada Manual Item'
        TabOrder = 5
        OnClick = Button60Click
      end
      object Button61: TButton
        Left = 379
        Top = 26
        Width = 182
        Height = 42
        Caption = 'Obter Totalizador Entrada'
        TabOrder = 6
        OnClick = Button61Click
      end
      object Button62: TButton
        Left = 379
        Top = 74
        Width = 182
        Height = 42
        Caption = 'Obter Valor Entrada'
        TabOrder = 7
        OnClick = Button62Click
      end
      object Button73: TButton
        Left = 3
        Top = 122
        Width = 182
        Height = 42
        Caption = 'Gerar Contas a Pagar'
        TabOrder = 8
        OnClick = Button73Click
      end
      object Button79: TButton
        Left = 191
        Top = 122
        Width = 182
        Height = 42
        Caption = 'Espelho da nota'
        TabOrder = 9
        OnClick = Button79Click
      end
      object Button80: TButton
        Left = 379
        Top = 122
        Width = 182
        Height = 42
        Caption = 'Baixar XML'
        TabOrder = 10
        OnClick = Button80Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'OS'
      ImageIndex = 3
      object XDBGrid3: TXDBGrid
        Left = 0
        Top = 434
        Width = 1246
        Height = 305
        Align = alBottom
        DataSource = dsOS
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 0
      end
      object Button63: TButton
        Left = 11
        Top = 23
        Width = 182
        Height = 42
        Caption = 'OS Inserir'
        TabOrder = 1
        OnClick = Button63Click
      end
      object Button64: TButton
        Left = 199
        Top = 23
        Width = 182
        Height = 42
        Caption = 'OS Consultar'
        TabOrder = 2
        OnClick = Button64Click
      end
      object Button65: TButton
        Left = 387
        Top = 23
        Width = 182
        Height = 42
        Caption = 'OS Update'
        TabOrder = 3
        OnClick = Button65Click
      end
      object Button66: TButton
        Left = 575
        Top = 23
        Width = 182
        Height = 42
        Caption = 'OS Excluir'
        TabOrder = 4
        OnClick = Button66Click
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Calculadora'
      ImageIndex = 4
      object memoSimulador: TMemo
        Left = 824
        Top = 23
        Width = 409
        Height = 681
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Button67: TButton
        Left = 11
        Top = 23
        Width = 182
        Height = 42
        Caption = 'Simular Custo'
        TabOrder = 1
        OnClick = Button67Click
      end
      object Button72: TButton
        Left = 203
        Top = 23
        Width = 182
        Height = 42
        Caption = 'Calcular Custo'
        TabOrder = 2
        OnClick = Button72Click
      end
    end
    object API: TTabSheet
      Caption = 'API'
      ImageIndex = 5
      object MemoAPI: TMemo
        Left = 655
        Top = 15
        Width = 409
        Height = 681
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object Button74: TButton
        Left = 3
        Top = 6
        Width = 182
        Height = 42
        Caption = 'Consultar CNPJ'
        TabOrder = 1
        OnClick = Button74Click
      end
      object Button75: TButton
        Left = 203
        Top = 6
        Width = 182
        Height = 42
        Caption = 'Consultar CEP'
        TabOrder = 2
        OnClick = Button75Click
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Pedido de Compra'
      ImageIndex = 6
      object XDBGrid4: TXDBGrid
        Left = 0
        Top = 297
        Width = 1246
        Height = 169
        Align = alBottom
        DataSource = dsPedidoCompra
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 0
      end
      object Button76: TButton
        Left = 15
        Top = 30
        Width = 182
        Height = 42
        Caption = 'Inserir Pedido de Compra'
        TabOrder = 1
        OnClick = Button76Click
      end
      object Button77: TButton
        Left = 15
        Top = 78
        Width = 182
        Height = 42
        Caption = 'Consultar Pedido de Compra'
        TabOrder = 2
        OnClick = Button77Click
      end
      object XDBGrid5: TXDBGrid
        Left = 0
        Top = 466
        Width = 1246
        Height = 273
        Align = alBottom
        DataSource = dsPedidoCompraItens
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 3
      end
      object Button78: TButton
        Left = 203
        Top = 30
        Width = 182
        Height = 42
        Caption = 'Inserir Itens Pedido de Compra'
        TabOrder = 4
        OnClick = Button78Click
      end
      object Button95: TButton
        Left = 203
        Top = 78
        Width = 182
        Height = 42
        Caption = 'ObterTotalizador Itens'
        TabOrder = 5
        OnClick = Button95Click
      end
      object Button96: TButton
        Left = 203
        Top = 126
        Width = 182
        Height = 46
        Caption = 'PrevisaoPedidoCompra Consultar'
        TabOrder = 6
        OnClick = Button96Click
      end
      object Button97: TButton
        Left = 391
        Top = 126
        Width = 182
        Height = 46
        Caption = 'PrevisaoPedidoCompra Update'
        TabOrder = 7
        OnClick = Button97Click
      end
      object Button98: TButton
        Left = 579
        Top = 126
        Width = 182
        Height = 46
        Caption = 'PrevisaoPedidoCompra Excluir'
        TabOrder = 8
        OnClick = Button98Click
      end
      object Button99: TButton
        Left = 15
        Top = 126
        Width = 182
        Height = 46
        Caption = 'PrevisaoPedidoCompra Inserir'
        TabOrder = 9
        OnClick = Button99Click
      end
      object Button100: TButton
        Left = 391
        Top = 78
        Width = 182
        Height = 42
        Caption = 'PedidoCompraItens ObterLista'
        TabOrder = 10
        OnClick = Button100Click
      end
      object Button101: TButton
        Left = 391
        Top = 30
        Width = 182
        Height = 42
        Caption = 'PedidoCompra ObterLista'
        TabOrder = 11
        OnClick = Button101Click
      end
      object Button102: TButton
        Left = 15
        Top = 334
        Width = 234
        Height = 42
        Caption = 'PrevisaoPedidoCompra GerarFinanceiro'
        TabOrder = 12
        OnClick = Button102Click
      end
    end
    object TabSheet7: TTabSheet
      Caption = 'Produtos'
      ImageIndex = 7
      object Button91: TButton
        Left = 191
        Top = 31
        Width = 182
        Height = 42
        Caption = 'Consultar Tabela Preco'
        TabOrder = 0
        OnClick = Button91Click
      end
      object Button90: TButton
        Left = 3
        Top = 31
        Width = 182
        Height = 42
        Caption = 'Consulta Promocao'
        TabOrder = 1
        OnClick = Button90Click
      end
      object XDBGrid6: TXDBGrid
        Left = 0
        Top = 330
        Width = 1246
        Height = 409
        Align = alBottom
        DataSource = dsProdutos
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 2
      end
    end
    object Transportadora: TTabSheet
      Caption = 'Transportadora'
      ImageIndex = 8
      object Button89: TButton
        Left = 191
        Top = 11
        Width = 182
        Height = 46
        Caption = 'Transportadora  Consultar'
        TabOrder = 0
        OnClick = Button89Click
      end
      object Button92: TButton
        Left = 379
        Top = 11
        Width = 182
        Height = 46
        Caption = 'Transportadora  Update'
        TabOrder = 1
        OnClick = Button92Click
      end
      object Button93: TButton
        Left = 567
        Top = 11
        Width = 182
        Height = 46
        Caption = 'Transportadora  Excluir'
        TabOrder = 2
        OnClick = Button93Click
      end
      object Button94: TButton
        Left = 3
        Top = 11
        Width = 182
        Height = 46
        Caption = 'Transportadora Inserir'
        TabOrder = 3
        OnClick = Button94Click
      end
    end
    object TabSheet8: TTabSheet
      Caption = 'Outras Sa'#237'das'
      ImageIndex = 9
      object Button103: TButton
        Left = 11
        Top = 19
        Width = 182
        Height = 46
        Caption = 'Saidas Inserir'
        TabOrder = 0
        OnClick = Button103Click
      end
      object Button104: TButton
        Left = 387
        Top = 19
        Width = 182
        Height = 46
        Caption = 'Saidas Update'
        TabOrder = 1
        OnClick = Button104Click
      end
      object Button105: TButton
        Left = 575
        Top = 19
        Width = 182
        Height = 46
        Caption = 'Saidas Excluir'
        TabOrder = 2
        OnClick = Button105Click
      end
      object Button106: TButton
        Left = 199
        Top = 19
        Width = 182
        Height = 46
        Caption = 'Saidas Consultar'
        TabOrder = 3
        OnClick = Button106Click
      end
      object XDBGrid7: TXDBGrid
        Left = 0
        Top = 434
        Width = 1246
        Height = 305
        Align = alBottom
        DataSource = dsSaidas
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 4
      end
      object Button107: TButton
        Left = 11
        Top = 71
        Width = 182
        Height = 46
        Caption = 'Saidas Itens Inserir'
        TabOrder = 5
        OnClick = Button107Click
      end
      object Button108: TButton
        Left = 199
        Top = 71
        Width = 182
        Height = 46
        Caption = 'SaidasItens ObterTotais'
        TabOrder = 6
        OnClick = Button108Click
      end
      object Button109: TButton
        Left = 387
        Top = 71
        Width = 182
        Height = 46
        Caption = 'Obter filiais'
        TabOrder = 7
        OnClick = Button109Click
      end
      object Button110: TButton
        Left = 11
        Top = 124
        Width = 182
        Height = 46
        Caption = 'Saidas Itens Transferencia'
        TabOrder = 8
        OnClick = Button110Click
      end
      object Button111: TButton
        Left = 199
        Top = 124
        Width = 182
        Height = 46
        Caption = 'Saidas Itens Excluir'
        TabOrder = 9
        OnClick = Button111Click
      end
      object Button85: TButton
        Left = 387
        Top = 123
        Width = 182
        Height = 46
        Caption = 'Calcular Peso'
        TabOrder = 10
        OnClick = BuButton116Click
      end
    end
    object Orcamento: TTabSheet
      Caption = 'Orcamento'
      ImageIndex = 10
      object OrcamentoConsultar: TButton
        Left = 191
        Top = 3
        Width = 182
        Height = 46
        Caption = 'Orcamento Consultar'
        TabOrder = 0
        OnClick = OrcamentoConsultarClick
      end
      object OrcamentoAlterar: TButton
        Left = 379
        Top = 3
        Width = 182
        Height = 46
        Caption = 'Orcamento Alterar'
        TabOrder = 1
        OnClick = OrcamentoAlterarClick
      end
      object OrcamentoExcluir: TButton
        Left = 567
        Top = 3
        Width = 182
        Height = 46
        Caption = 'Orcamento Excluir'
        TabOrder = 2
        OnClick = OrcamentoExcluirClick
      end
      object OrcamentoIncluir: TButton
        Left = 3
        Top = 3
        Width = 182
        Height = 46
        Caption = 'Orcamento Incluir'
        TabOrder = 3
        OnClick = OrcamentoIncluirClick
      end
      object OrcamentoItensConsultar: TButton
        Left = 191
        Top = 55
        Width = 182
        Height = 46
        Caption = 'OrcamentoItens Consultar'
        TabOrder = 4
        OnClick = OrcamentoItensConsultarClick
      end
      object OrcamentoItensAlterar: TButton
        Left = 379
        Top = 55
        Width = 182
        Height = 46
        Caption = 'OrcamentoItens Alterar'
        TabOrder = 5
        OnClick = OrcamentoItensAlterarClick
      end
      object OrcamentoItensExcluir: TButton
        Left = 567
        Top = 55
        Width = 182
        Height = 46
        Caption = 'OrcamentoItens Excluir'
        TabOrder = 6
        OnClick = OrcamentoItensExcluirClick
      end
      object OrcamentoItensIncluir: TButton
        Left = 3
        Top = 55
        Width = 182
        Height = 46
        Caption = 'OrcamentoItens Incluir'
        TabOrder = 7
        OnClick = OrcamentoItensIncluirClick
      end
    end
    object tabReserva: TTabSheet
      Caption = 'Reserva'
      ImageIndex = 11
      object btnReserva: TButton
        Left = 11
        Top = 11
        Width = 182
        Height = 46
        Caption = 'Reservar CD'
        TabOrder = 0
        OnClick = btnReservaClick
      end
    end
    object tabLiberacao: TTabSheet
      Caption = 'Libera'#231#227'o'
      ImageIndex = 12
      object btnConsultaDesconto: TButton
        Left = 11
        Top = 83
        Width = 182
        Height = 46
        Caption = 'Consultar Desconto'
        TabOrder = 0
        OnClick = btnConsultaDescontoClick
      end
      object XDBGrid8: TXDBGrid
        Left = 0
        Top = 434
        Width = 1246
        Height = 305
        Align = alBottom
        DataSource = dLiberacao
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 1
      end
      object btnConsultaPermissao: TButton
        Left = 11
        Top = 19
        Width = 182
        Height = 46
        Caption = 'Consultar Permiss'#227'o'
        TabOrder = 2
        OnClick = btnConsultaPermissaoClick
      end
      object btnPermissaoRemota: TButton
        Left = 203
        Top = 19
        Width = 182
        Height = 46
        Caption = 'Permissao remota Autorizar'
        TabOrder = 3
        OnClick = btnPermissaoRemotaClick
      end
      object Button87: TButton
        Left = 403
        Top = 19
        Width = 182
        Height = 46
        Caption = 'Permissao remota Negar'
        TabOrder = 4
        OnClick = Button87Click
      end
      object btnDescontoAutorizar: TButton
        Left = 203
        Top = 83
        Width = 182
        Height = 46
        Caption = 'Desconto Autorizar'
        TabOrder = 5
        OnClick = btnDescontoAutorizarClick
      end
      object btnDescontoNegar: TButton
        Left = 403
        Top = 83
        Width = 182
        Height = 46
        Caption = 'Desconto Negar'
        TabOrder = 6
        OnClick = btnDescontoNegarClick
      end
    end
    object TabSheet9: TTabSheet
      Caption = 'Movimento Serial'
      ImageIndex = 13
      object XDBGrid9: TXDBGrid
        Left = 0
        Top = 524
        Width = 1246
        Height = 215
        Align = alBottom
        DataSource = dMovimentoSerial
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 0
      end
      object Button88: TButton
        Left = 11
        Top = 27
        Width = 182
        Height = 46
        Caption = 'MovimentoSerial Incluir'
        TabOrder = 1
        OnClick = Button88Click
      end
      object Button113: TButton
        Left = 197
        Top = 27
        Width = 182
        Height = 46
        Caption = 'MovimentoSerial Excluir'
        TabOrder = 2
        OnClick = Button113Click
      end
      object Button114: TButton
        Left = 383
        Top = 27
        Width = 182
        Height = 46
        Caption = 'ObterLista'
        TabOrder = 3
        OnClick = Button114Click
      end
      object Button115: TButton
        Left = 568
        Top = 27
        Width = 182
        Height = 46
        Caption = 'Consulta Serial'
        TabOrder = 4
        OnClick = Button117Click
      end
    end
    object TabSheet10: TTabSheet
      Caption = 'Imprimir Contratos'
      ImageIndex = 14
      object imprimirGarantidaEstendida: TButton
        Left = 3
        Top = 11
        Width = 182
        Height = 46
        Caption = 'Imprimir Garantia Estendida'
        TabOrder = 0
        OnClick = imprimirGarantidaEstendidaClick
      end
      object imprimirRF: TButton
        Left = 191
        Top = 11
        Width = 182
        Height = 46
        Caption = 'Imprimir RF'
        TabOrder = 1
        OnClick = imprimirRFClick
      end
      object imprimirPrestamista: TButton
        Left = 567
        Top = 11
        Width = 182
        Height = 46
        Caption = 'Imprimir Prestamista'
        TabOrder = 2
        OnClick = imprimirPrestamistaClick
      end
      object imprimirRFD: TButton
        Left = 379
        Top = 11
        Width = 182
        Height = 46
        Caption = 'Imprimir RFD'
        TabOrder = 3
        OnClick = imprimirRFDClick
      end
      object imprimirContratoCarteira: TButton
        Left = 3
        Top = 63
        Width = 182
        Height = 46
        Caption = 'Imprimir Contrato Carteira'
        TabOrder = 4
        OnClick = imprimirContratoCarteiraClick
      end
    end
    object Usuario: TTabSheet
      Caption = 'Usuario'
      ImageIndex = 15
      object Button112: TButton
        Left = 3
        Top = 19
        Width = 182
        Height = 46
        Caption = 'Alterar Senha'
        TabOrder = 0
        OnClick = Button116Click
      end
    end
    object TabelaJurosDia: TTabSheet
      Caption = 'TabelaJurosDia'
      ImageIndex = 16
      object Button133: TButton
        Left = 11
        Top = 35
        Width = 182
        Height = 46
        Caption = 'Obter Indice'
        TabOrder = 0
        OnClick = Button133Click
      end
      object Memo1: TMemo
        Left = 0
        Top = 484
        Width = 1246
        Height = 255
        Align = alBottom
        ScrollBars = ssVertical
        TabOrder = 1
        ExplicitTop = 476
        ExplicitWidth = 1244
      end
    end
    object TabelaJurosPromocao: TTabSheet
      Caption = 'TabelaJurosPromocao'
      ImageIndex = 17
      object SpeedButton1: TSpeedButton
        Left = 19
        Top = 95
        Width = 182
        Height = 46
        Caption = 'Calcular coeficiente Promo'#231#227'o'
        OnClick = SpeedButton1Click
      end
      object btnObterJurosPromocao: TButton
        Left = 19
        Top = 43
        Width = 182
        Height = 46
        Caption = 'Obter'
        TabOrder = 0
        OnClick = btnObterJurosPromocaoClick
      end
      object dbGridTabelaJuros: TXDBGrid
        Left = 0
        Top = 524
        Width = 1246
        Height = 215
        Align = alBottom
        DataSource = dsJuros
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 1
      end
    end
    object TabSheet11: TTabSheet
      Caption = 'Vendas vendedor'
      ImageIndex = 18
      object btnComissao: TButton
        Left = 19
        Top = 19
        Width = 182
        Height = 46
        Caption = 'Obter Comiss'#227'o'
        TabOrder = 0
        OnClick = btnComissaoClick
      end
      object XDBGrid10: TXDBGrid
        Left = 0
        Top = 524
        Width = 1246
        Height = 215
        Align = alBottom
        DataSource = dsTeste2
        GridStyle.VisualStyle = vsXPStyle
        TabOrder = 1
      end
    end
  end
  object dsTeste2: TDataSource
    Left = 1056
    Top = 488
  end
  object OpenDialog: TOpenDialog
    Left = 1144
    Top = 488
  end
  object dsEntrada: TDataSource
    Left = 1056
    Top = 567
  end
  object dsEntradaItens: TDataSource
    Left = 1057
    Top = 642
  end
  object dsOS: TDataSource
    Left = 1152
    Top = 575
  end
  object dsPedidoCompra: TDataSource
    Left = 1048
    Top = 344
  end
  object dsPedidoCompraItens: TDataSource
    Left = 1052
    Top = 408
  end
  object dsProdutos: TDataSource
    Left = 1168
    Top = 399
  end
  object dsSaidas: TDataSource
    Left = 1048
    Top = 272
  end
  object dLiberacao: TDataSource
    Left = 1136
    Top = 208
  end
  object dMovimentoSerial: TDataSource
    Left = 1160
    Top = 336
  end
  object dsJuros: TDataSource
    Left = 1048
    Top = 208
  end
  object FDMemTable1: TFDMemTable
    BeforePost = FDMemTable1BeforePost
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 948
    Top = 538
  end
end
