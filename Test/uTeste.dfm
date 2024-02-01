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
      Caption = 'Teste 1'
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
    end
  end
end
