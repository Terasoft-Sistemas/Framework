object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 725
  ClientWidth = 1244
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1244
    Height = 725
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Diversos'
      object memoResultado: TMemo
        Left = 816
        Top = 15
        Width = 409
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
    end
    object TabSheet2: TTabSheet
      Caption = 'Fluxo de caixa'
      ImageIndex = 1
      object dbTeste2: TXDBGrid
        Left = 0
        Top = 72
        Width = 1236
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
  end
  object dsTeste2: TDataSource
    Left = 1056
    Top = 544
  end
end
