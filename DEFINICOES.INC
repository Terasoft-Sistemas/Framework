{$I c:\Windows\DEFINICOESMACHINE.INC}

{$I DEFINICOESLOCAIS.INC}

{$if not defined(__DEFINICOES_INC__)}
  {$define __DEFINICOES_INC__}
{$ifend}

{$define INIBIRCONTROLEWTS}

{$if defined(__USAR_CONTROLE_WTS__)}
  {$undef INIBIRCONTROLEWTS}
{$ifend}

{$if defined(SISTEMA_SYSCOM)and not defined(BLOCO_X_SOMENTE_ENVIO)}
  {$define BLOCO_X_SOMENTE_ENVIO}
{$ifend}

{$if defined (__ACBR_TRUNK1__)}
  {$if defined(__ACBR_TRUNK2__)}
   {$undef __ACBR_TRUNK2__}
  {$ifend}
{$ifend}

{$if defined(__VENDAS__)}
  {$if not defined(__RELEASE__)}
    {$define __IMPLEMENTAR_GNRE__}
  {$ifend}

 {$define __SINCRONIZA_INTERATIVO__}

{$ifend}

{$if defined (__ACBR_TRUNK2__)}
  {$if defined(__ACBR_TRUNK1__)}
   {$undef __ACBR_TRUNK1__}
  {$ifend}
{$ifend}

{$if not defined (__ACBR_TRUNK1__) and not defined(__ACBR_TRUNK2__)}
  {$define __ACBR_TRUNK2__}
{$ifend}

{$define __INIBIRFULLDEBUGFASTMM4__}

{$if not defined(__USARSCRIPTS__)}
  {$define __USARSCRIPTS__}
{$ifend}


{$ifdef FIREMONKEY}
  {$ifdef VCL}
    {$undef VCL}
  {$endif}
{$else}
  {$ifndef VCL}
    {$define VCL}
  {$endif}
{$endif}

{$IFNDEF DEBUG}
  {$IFDEF DEVEL_BALLOON}
    //{$DEFINE  DEBUG}a
  {$ENDIF}
{$ENDIF}

{$IFDEF DEBUG}
  {$IFDEF DEVEL_BALLOON}
    {$DEFINE IGNORARIB}
    //{$DEFINE  PROCURA_DATASET_ANTIGO}
//    {$DEFINE  UPGRADEDATASETHABILITADO}
  {$ENDIF}
{$ENDIF}

{$if not defined(__RELEASE__)}
  {$if defined(DEVEL_BALLOON)}
    {$define DEPURACAOBALLOON}
  {$ifend}
{$ifend}


    {$DEFINE IGNORARIB}

  {$define __USAIBPT2__}

{$IFNDEF __RELEASE__}
  {$IFNDEF PROCURA_DATASET_ANTIGO}
    //{$DEFINE  PROCURA_DATASET_ANTIGO}
  {$ENDIF}

  {$ifdef __ANTONIO__}
//    {$undef __USARSCRIPTS__}
      {$DEFINE __REALIZATESTES__}
      {$define __PESQUISAAVANCADA__}
      {$define __NOTIFICAPROBLEMATAG__}
      {$define __USADRSEMCALCULONIVEIS__}
//      {$define __USAIBPT2__}
      {$if defined(__USAIBPT1__)}
//        {$undef __USAIBPT1__}
      {$ifend}

  {$endif}

  {$ifdef __CLAUDIO__}
      {$DEFINE __REALIZATESTES__}
      {$define __PESQUISAAVANCADA__}
      {$define __NOTIFICAPROBLEMATAG__}
  {$endif}

{$ENDIF}

{$if defined(__IMPLEMENTA_ECOMMERCE__)}
  {$if defined(__DBEMUSO_SCI__)}

    {$if not defined(__IMPLEMENTA_WOO__)}
      {$define __IMPLEMENTA_WOO__}
    {$ifend}

  {$ifend}

{$ifend}


{$ifdef __REALIZATESTES__}
  {$define __VERIFICAPERFILUSATAG__}
{$endif}

{$ifdef __USARCONFIGSCI__}
  {$if not defined(INIBIRCHECAGEMUPDATE)}
    {$define INIBIRCHECAGEMUPDATE}
  {$ifend}

  {$ifdef __USARPERFIL__}
    {$undef __USARPERFIL__}
  {$endif}

  {$ifdef __ANTONIO__}
//    {$define __USARPERFIL__}
  {$endif}

  {$ifdef __CLAUDIO__}
//    {$define __USARPERFIL__}
  {$endif}

  {$ifndef __USARPERFIL__}
    {$define __USARPERFIL__}
  {$endif}

  {$if defined(__VENDAS__)}
    {$if not defined(__IMPLEMENTA_MKX__)}
      //{$define __IMPLEMENTA_MKX__}
    {$ifend}
  {$ifend}

{$else}
//  {$define __SISTEMA_CONFIGURADEPURACAOREMOTA__}
  {$define __DB_CONFIGURATEMPOINATIVIDADE__}
  {$define __USARPERFIL__}
{$endif}


{$IFDEF VER140}
// Delphi 6 / C++Builder 6
  {$DEFINE D6}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
{$ENDIF}

{$IFDEF VER150}
  // Delphi 7 (and 7.1)
  {$DEFINE D7}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
{$ENDIF}

{$IFDEF VER160}
  // Delphi 8 for .Net
  {$DEFINE D8}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
{$ENDIF}

{$IFDEF VER170}
  // Delphi 2005 (Win32/.Net)
  {$DEFINE D2005}
  {$DEFINE D9}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D9_UP}
  {$DEFINE D2005_UP}
{$ENDIF}

{$IFDEF VER180}
  // Delphi 2006 / C++Builder 2006 (Win32/.Net) and Delphi/C++Builder 2007 for Win32
  {$DEFINE D2006}
  {$DEFINE D10}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D9_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
{$ENDIF}

{$IFDEF VER185}
  //Delphi 2007 / C++Builder 2007 for Win32 *
  {$DEFINE D2007}
  {$DEFINE D11}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D9_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
{$ENDIF}

{$IFDEF VER190}
  // Delphi 2007 for .Net *
  {$DEFINE D2007}
  {$DEFINE D11}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D9_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
{$ENDIF}

{$IFDEF VER200}
  // Delphi 2009 / C++Builder 2009 (Win32)
  {$DEFINE D2009}
  {$DEFINE D12}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D9_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D12+}
  {$DEFINE D12_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
  {$DEFINE D2009_UP}
{$ENDIF}

{$IFDEF VER210}
  //Delphi 2010 / C++Builder 2010 (Win32)
  {$DEFINE D2010}
  {$DEFINE D14}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D9_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D12+}
  {$DEFINE D12_UP}
  {$DEFINE D14+}
  {$DEFINE D14_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
  {$DEFINE D2009_UP}
  {$DEFINE D2010_UP}
{$ENDIF}

{$IFDEF VER220}
  // Delphi XE / C++Builder XE (Win32)
  {$DEFINE DXE}
  {$DEFINE D15}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D9_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D12+}
  {$DEFINE D12_UP}
  {$DEFINE D14+}
  {$DEFINE D14_UP}
  {$DEFINE D15+}
  {$DEFINE D15_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
  {$DEFINE D2009_UP}
  {$DEFINE D2010_UP}
  {$DEFINE DXE_UP}
{$ENDIF}

{$IFDEF VER230}
  // Delphi XE2 / C++Builder XE2 (Win32/Win64)
  {$DEFINE DXE2}
  {$DEFINE D16}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D9_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D12+}
  {$DEFINE D12_UP}
  {$DEFINE D14+}
  {$DEFINE D14_UP}
  {$DEFINE D15+}
  {$DEFINE D15_UP}
  {$DEFINE D16+}
  {$DEFINE D16_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
  {$DEFINE D2009_UP}
  {$DEFINE D2010_UP}
  {$DEFINE DXE_UP}
  {$DEFINE DXE2_UP}
{$ENDIF}

{$IFDEF VER240}
  // Delphi XE3 / C++Builder XE3 (Win32/Win64)
  {$DEFINE DXE3}
  {$DEFINE D17}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D8_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D12+}
  {$DEFINE D12_UP}
  {$DEFINE D14+}
  {$DEFINE D14_UP}
  {$DEFINE D15+}
  {$DEFINE D15_UP}
  {$DEFINE D16+}
  {$DEFINE D16_UP}
  {$DEFINE D17+}
  {$DEFINE D17_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
  {$DEFINE D2009_UP}
  {$DEFINE D2010_UP}
  {$DEFINE DXE_UP}
  {$DEFINE DXE2_UP}
  {$DEFINE DXE3_UP}
{$ENDIF}

{$IFDEF VER250}
  // Delphi XE4 / C++Builder XE4 (Win32/Win64)
  {$DEFINE DXE4}
  {$DEFINE D18}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D9_UP}
  {$DEFINE D9+}
  {$DEFINE D9_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D12+}
  {$DEFINE D12_UP}
  {$DEFINE D14+}
  {$DEFINE D14_UP}
  {$DEFINE D15+}
  {$DEFINE D15_UP}
  {$DEFINE D16+}
  {$DEFINE D16_UP}
  {$DEFINE D17+}
  {$DEFINE D17_UP}
  {$DEFINE D18+}
  {$DEFINE D18_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
  {$DEFINE D2009_UP}
  {$DEFINE D2010_UP}
  {$DEFINE DXE_UP}
  {$DEFINE DXE2_UP}
  {$DEFINE DXE3_UP}
  {$DEFINE DXE4_UP}
{$ENDIF}

{$IFDEF VER260}
  // Delphi XE5 / C++Builder XE5 (Win32/Win64)
  {$define VERSAODEFINIDA}
  {$DEFINE DXE5}
  {$DEFINE D19}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D8_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D12+}
  {$DEFINE D12_UP}
  {$DEFINE D14+}
  {$DEFINE D14_UP}
  {$DEFINE D15+}
  {$DEFINE D15_UP}
  {$DEFINE D16+}
  {$DEFINE D16_UP}
  {$DEFINE D17+}
  {$DEFINE D17_UP}
  {$DEFINE D18+}
  {$DEFINE D18_UP}
  {$DEFINE D19+}
  {$DEFINE D19_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
  {$DEFINE D2009_UP}
  {$DEFINE D2010_UP}
  {$DEFINE DXE_UP}
  {$DEFINE DXE2_UP}
  {$DEFINE DXE3_UP}
  {$DEFINE DXE4_UP}
  {$DEFINE DXE5_UP}
{$ENDIF}

{$IFDEF VER340}
  // Delphi Sydney
  {$define VERSAODEFINIDA}
  {$DEFINE D2021}
  {$DEFINE D19}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D8_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D12+}
  {$DEFINE D12_UP}
  {$DEFINE D14+}
  {$DEFINE D14_UP}
  {$DEFINE D15+}
  {$DEFINE D15_UP}
  {$DEFINE D16+}
  {$DEFINE D16_UP}
  {$DEFINE D17+}
  {$DEFINE D17_UP}
  {$DEFINE D18+}
  {$DEFINE D18_UP}
  {$DEFINE D19+}
  {$DEFINE D19_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
  {$DEFINE D2009_UP}
  {$DEFINE D2010_UP}
  {$DEFINE DXE_UP}
  {$DEFINE DXE2_UP}
  {$DEFINE DXE3_UP}
  {$DEFINE DXE4_UP}
  {$DEFINE DXE5_UP}
  {$DEFINE D2021_UP}
{$ENDIF}

{$IFDEF VER350}
  // Delphi 11 - 2021
  {$define VERSAODEFINIDA}
  {$DEFINE D2021}
  {$DEFINE D19}
  {$DEFINE D6+}
  {$DEFINE D6_UP}
  {$DEFINE D7+}
  {$DEFINE D7_UP}
  {$DEFINE D8+}
  {$DEFINE D8_UP}
  {$DEFINE D9+}
  {$DEFINE D8_UP}
  {$DEFINE D10+}
  {$DEFINE D10_UP}
  {$DEFINE D11+}
  {$DEFINE D11_UP}
  {$DEFINE D12+}
  {$DEFINE D12_UP}
  {$DEFINE D14+}
  {$DEFINE D14_UP}
  {$DEFINE D15+}
  {$DEFINE D15_UP}
  {$DEFINE D16+}
  {$DEFINE D16_UP}
  {$DEFINE D17+}
  {$DEFINE D17_UP}
  {$DEFINE D18+}
  {$DEFINE D18_UP}
  {$DEFINE D19+}
  {$DEFINE D19_UP}
  {$DEFINE D2005_UP}
  {$DEFINE D2006_UP}
  {$DEFINE D2007_UP}
  {$DEFINE D2009_UP}
  {$DEFINE D2010_UP}
  {$DEFINE DXE_UP}
  {$DEFINE DXE2_UP}
  {$DEFINE DXE3_UP}
  {$DEFINE DXE4_UP}
  {$DEFINE DXE5_UP}
  {$DEFINE D2021_UP}
{$ENDIF}


{$if not defined(VERSAODEFINIDA)}
  {$MESSAGE Error   'Versão não definida'}
{$ifend}

{$undef VERSAODEFINIDA}



{$if not defined ( D8_UP ) and not defined (__RELEASE__)}
  {$define DEBUG}
{$ifend}

{$if not defined(D2021_UP)}
  {$define __LEGADO__}
{$ifend}


{$if defined(__RELEASE__)}
  {$if defined(DXE_UP)}
    {$define __DLL_DELAYED__}
  {$ifend}
{$ifend}

    {$define __DLL_DELAYED__}


{$if not defined(__ESPERA_IDGLOBAL__)}
  {$if defined(__SERVICO_SCI__) or defined(__VENDAS__) or defined(__SCI__) or defined(__SCI_SVC__) or  defined(ECOMMERCE_SVC) }
    {$define __ESPERA_IDGLOBAL__}
  {$ifend}
{$ifend}

