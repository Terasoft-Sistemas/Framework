{$i definicoes.inc}

{$define MODO_HOMOLOGACAO}

{$if not defined(__RELEASE__)}
  {$define __TESTAR_LOGISTICA__}
{$endif}

{$if defined(DXE5)}
  {$if defined(__VENDAS__) or defined(__DEBUG_ANTONIO__) }
    {$define __AUTOMATIZA_LOGISTICA__}
  {$endif}
{$endif}


