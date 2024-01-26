object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 741
  ClientWidth = 1248
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
    Width = 1248
    Height = 741
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
        Lines.Strings = (
          'memoResultado')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object btnFinanceiroPedido: TButton
        Left = 3
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Financeiro Pedido Consultar'
        TabOrder = 1
        OnClick = btnFinanceiroPedidoClick
      end
      object Button1: TButton
        Left = 191
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
        Left = 571
        Top = 15
        Width = 182
        Height = 42
        Caption = 'Financeiro Pedido Excluir'
        TabOrder = 4
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 3
        Top = 87
        Width = 182
        Height = 42
        Caption = 'PedidoWeb Consultar'
        TabOrder = 5
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 191
        Top = 87
        Width = 182
        Height = 42
        Caption = 'PedidoWeb Inserir'
        TabOrder = 6
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 379
        Top = 87
        Width = 182
        Height = 42
        Caption = 'PedidoWeb Update'
        TabOrder = 7
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 571
        Top = 87
        Width = 182
        Height = 42
        Caption = 'PedidoWeb Excluir'
        TabOrder = 8
        OnClick = Button7Click
      end
    end
  end
end
