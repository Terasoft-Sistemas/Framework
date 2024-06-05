{$i definicoes.inc}

{$if defined(DEVEL_BALLOON)}
  {$define MODO_HOMOLOGACAO}
  {$define __TESTAR_CREDIPAR__}
{$endif}

{$if defined(DXE5)}
  {$if defined(__VENDAS__) or defined(__DEBUG_ANTONIO__) }
    {$define __AUTOMATIZA_CREDIPAR__}
  {$endif}
{$endif}

