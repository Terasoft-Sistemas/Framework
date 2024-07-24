unit FuncionarioModel;

interface

uses
  Terasoft.Types,
  Spring.Collections,
  Interfaces.Conexao;

type
  TFuncionarioModel = class

  private
    vIConexao : IConexao;
    FFuncionariosLista: IList<TFuncionarioModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FTIPO_COMISSAO: Variant;
    FGERENTE_ID: Variant;
    FIDRecordView: String;
    FCODIGO_FUN: Variant;
    FNOME_FUN: Variant;
    FFGTS_BANCO: Variant;
    FFGTS_RETRATACAO: Variant;
    FUF_RG: Variant;
    FBANCO_FUN: Variant;
    FREPRESENTANTE: Variant;
    FQUADRO_HORARIO: Variant;
    FNACIONALIDADE: Variant;
    FSINAIS: Variant;
    FCOMISSAO_MONTADOR: Variant;
    FCATEGORIA_RESERVISTA: Variant;
    FFUNCAO_FUN: Variant;
    FTEMPO_TAREFA: Variant;
    FPESO: Variant;
    FCOR: Variant;
    FMOTORISTA: Variant;
    FRG: Variant;
    FDESCONTO_FUN: Variant;
    FMSG_FINALIZAR_TAREFA: Variant;
    FCARTEIRA_TRABALHO: Variant;
    FREGIAO_ID: Variant;
    FTECNICO_FUN: Variant;
    FEMAIL: Variant;
    FPAI: Variant;
    FEMAIL_FUN: Variant;
    FCONJUGE: Variant;
    FASO_FUN: Variant;
    FCAUSA_DEMISSAO: Variant;
    FNASCIMENTO_FUN: Variant;
    FCOD_USER: Variant;
    FCARTEIRA_RESERVISTA: Variant;
    FIMAGEM2_FUN: Variant;
    FUF_FUN: Variant;
    FCLT: Variant;
    FQTDE_VALE_TRANSPORTE: Variant;
    FCODIGO_ANTERIOR: Variant;
    FALTURA: Variant;
    FFGTS: Variant;
    FCNH: Variant;
    FVENC_EXPERIENCIA_FUN: Variant;
    FESCOLARIDADE_FUN: Variant;
    FCOMIS_FUN: Variant;
    FCPF_FUN: Variant;
    FFON1_FUN: Variant;
    FVENC_EXPERIENCIA_PRORROGADO: Variant;
    FEMAIL_SMTP: Variant;
    FEMAIL_SENHA: Variant;
    FGERENTE: Variant;
    FNOME_COMPLETO: Variant;
    FEMAIL_SSL: Variant;
    FOLHO: Variant;
    FSALARIO: Variant;
    FID: Variant;
    FDATA_EXAME_FUN: Variant;
    FCAIXA: Variant;
    FCEP_FUN: Variant;
    FCATEGORIA_CNH: Variant;
    FCABELO: Variant;
    FLOCACAO_FUN: Variant;
    FEMAIL_RESPOSTA: Variant;
    FTITULO_ELEITOR: Variant;
    FDIRETORIO_FUN: Variant;
    FIMAGEM_FUN: Variant;
    FLOJA: Variant;
    FSTATUS_FUN: Variant;
    FEMAIL_HOST: Variant;
    FDEMITIDO: Variant;
    FCBO: Variant;
    FNACIONALIDADE_MAE: Variant;
    FPIS: Variant;
    FBAI_FUN: Variant;
    FEMAIL_NOME: Variant;
    FEMAIL_PORTA: Variant;
    FSYSTIME: Variant;
    FDATA_RG: Variant;
    FLOJA_ID: Variant;
    FCOMPLEMENTO: Variant;
    FEMAIL_ENDERECO: Variant;
    FSMS: Variant;
    FCONTA_FUN: Variant;
    FDIA_FECHAMENTO_COMISSAO: Variant;
    FCONTATO: Variant;
    FDATA_VENC_EXAME_FUN: Variant;
    FCID_FUN: Variant;
    FATALHOS_WEB: Variant;
    FEMISSOR_RG: Variant;
    FMENU_WEB: Variant;
    FNACIONALIDADE_PAI: Variant;
    FMATRICULA: Variant;
    FLOCAL_NASCIMENTO: Variant;
    FAGENCIA_FUN: Variant;
    FCEL_FUN: Variant;
    FMONTADOR: Variant;
    FTIPO: Variant;
    FSECAO: Variant;
    FFONE_RECADO_FUN: Variant;
    FTIPO_VEN: Variant;
    FTIPO_ESTOQUE: Variant;
    FVALOR_VALE_TRANSPORTE: Variant;
    FASO2_FUN: Variant;
    FADMISSAO_FUN: Variant;
    FAGENDA: Variant;
    FFGTS_DATA: Variant;
    FTIPO_SALARIO: Variant;
    FMAE: Variant;
    FESTADO_CIVIL: Variant;
    FEND_FUN: Variant;
    FOBS_CARACTERISTICA: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetFuncionariosLista(const Value: IList<TFuncionarioModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetGERENTE_ID(const Value: Variant);
    procedure SetTIPO_COMISSAO(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetCODIGO_FUN(const Value: Variant);
    procedure SetNOME_FUN(const Value: Variant);
    procedure SetADMISSAO_FUN(const Value: Variant);
    procedure SetAGENCIA_FUN(const Value: Variant);
    procedure SetAGENDA(const Value: Variant);
    procedure SetALTURA(const Value: Variant);
    procedure SetASO_FUN(const Value: Variant);
    procedure SetASO2_FUN(const Value: Variant);
    procedure SetATALHOS_WEB(const Value: Variant);
    procedure SetBAI_FUN(const Value: Variant);
    procedure SetBANCO_FUN(const Value: Variant);
    procedure SetCABELO(const Value: Variant);
    procedure SetCAIXA(const Value: Variant);
    procedure SetCARTEIRA_RESERVISTA(const Value: Variant);
    procedure SetCARTEIRA_TRABALHO(const Value: Variant);
    procedure SetCATEGORIA_CNH(const Value: Variant);
    procedure SetCATEGORIA_RESERVISTA(const Value: Variant);
    procedure SetCAUSA_DEMISSAO(const Value: Variant);
    procedure SetCBO(const Value: Variant);
    procedure SetCEL_FUN(const Value: Variant);
    procedure SetCEP_FUN(const Value: Variant);
    procedure SetCID_FUN(const Value: Variant);
    procedure SetCLT(const Value: Variant);
    procedure SetCNH(const Value: Variant);
    procedure SetCOD_USER(const Value: Variant);
    procedure SetCODIGO_ANTERIOR(const Value: Variant);
    procedure SetCOMIS_FUN(const Value: Variant);
    procedure SetCOMISSAO_MONTADOR(const Value: Variant);
    procedure SetCOMPLEMENTO(const Value: Variant);
    procedure SetCONJUGE(const Value: Variant);
    procedure SetCONTA_FUN(const Value: Variant);
    procedure SetCONTATO(const Value: Variant);
    procedure SetCOR(const Value: Variant);
    procedure SetCPF_FUN(const Value: Variant);
    procedure SetDATA_EXAME_FUN(const Value: Variant);
    procedure SetDATA_RG(const Value: Variant);
    procedure SetDATA_VENC_EXAME_FUN(const Value: Variant);
    procedure SetDEMITIDO(const Value: Variant);
    procedure SetDESCONTO_FUN(const Value: Variant);
    procedure SetDIA_FECHAMENTO_COMISSAO(const Value: Variant);
    procedure SetDIRETORIO_FUN(const Value: Variant);
    procedure SetEMAIL(const Value: Variant);
    procedure SetEMAIL_ENDERECO(const Value: Variant);
    procedure SetEMAIL_FUN(const Value: Variant);
    procedure SetEMAIL_HOST(const Value: Variant);
    procedure SetEMAIL_NOME(const Value: Variant);
    procedure SetEMAIL_PORTA(const Value: Variant);
    procedure SetEMAIL_RESPOSTA(const Value: Variant);
    procedure SetEMAIL_SENHA(const Value: Variant);
    procedure SetEMAIL_SMTP(const Value: Variant);
    procedure SetEMAIL_SSL(const Value: Variant);
    procedure SetEMISSOR_RG(const Value: Variant);
    procedure SetEND_FUN(const Value: Variant);
    procedure SetESCOLARIDADE_FUN(const Value: Variant);
    procedure SetESTADO_CIVIL(const Value: Variant);
    procedure SetFGTS(const Value: Variant);
    procedure SetFGTS_BANCO(const Value: Variant);
    procedure SetFGTS_DATA(const Value: Variant);
    procedure SetFGTS_RETRATACAO(const Value: Variant);
    procedure SetFON1_FUN(const Value: Variant);
    procedure SetFONE_RECADO_FUN(const Value: Variant);
    procedure SetFUNCAO_FUN(const Value: Variant);
    procedure SetGERENTE(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIMAGEM_FUN(const Value: Variant);
    procedure SetIMAGEM2_FUN(const Value: Variant);
    procedure SetLOCACAO_FUN(const Value: Variant);
    procedure SetLOCAL_NASCIMENTO(const Value: Variant);
    procedure SetLOJA(const Value: Variant);
    procedure SetLOJA_ID(const Value: Variant);
    procedure SetMAE(const Value: Variant);
    procedure SetMATRICULA(const Value: Variant);
    procedure SetMENU_WEB(const Value: Variant);
    procedure SetMONTADOR(const Value: Variant);
    procedure SetMOTORISTA(const Value: Variant);
    procedure SetMSG_FINALIZAR_TAREFA(const Value: Variant);
    procedure SetNACIONALIDADE(const Value: Variant);
    procedure SetNACIONALIDADE_MAE(const Value: Variant);
    procedure SetNACIONALIDADE_PAI(const Value: Variant);
    procedure SetNASCIMENTO_FUN(const Value: Variant);
    procedure SetNOME_COMPLETO(const Value: Variant);
    procedure SetOBS_CARACTERISTICA(const Value: Variant);
    procedure SetOLHO(const Value: Variant);
    procedure SetPAI(const Value: Variant);
    procedure SetPESO(const Value: Variant);
    procedure SetPIS(const Value: Variant);
    procedure SetQTDE_VALE_TRANSPORTE(const Value: Variant);
    procedure SetQUADRO_HORARIO(const Value: Variant);
    procedure SetREGIAO_ID(const Value: Variant);
    procedure SetREPRESENTANTE(const Value: Variant);
    procedure SetRG(const Value: Variant);
    procedure SetSALARIO(const Value: Variant);
    procedure SetSECAO(const Value: Variant);
    procedure SetSINAIS(const Value: Variant);
    procedure SetSMS(const Value: Variant);
    procedure SetSTATUS_FUN(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetTECNICO_FUN(const Value: Variant);
    procedure SetTEMPO_TAREFA(const Value: Variant);
    procedure SetTIPO(const Value: Variant);
    procedure SetTIPO_ESTOQUE(const Value: Variant);
    procedure SetTIPO_SALARIO(const Value: Variant);
    procedure SetTIPO_VEN(const Value: Variant);
    procedure SetTITULO_ELEITOR(const Value: Variant);
    procedure SetUF_FUN(const Value: Variant);
    procedure SetUF_RG(const Value: Variant);
    procedure SetVALOR_VALE_TRANSPORTE(const Value: Variant);
    procedure SetVENC_EXPERIENCIA_FUN(const Value: Variant);
    procedure SetVENC_EXPERIENCIA_PRORROGADO(const Value: Variant);

  public

    property  CODIGO_FUN                    : Variant read FCODIGO_FUN                   write SetCODIGO_FUN;
    property  NOME_FUN                      : Variant read FNOME_FUN                     write SetNOME_FUN;
    property  END_FUN                       : Variant read FEND_FUN                      write SetEND_FUN;
    property  BAI_FUN                       : Variant read FBAI_FUN                      write SetBAI_FUN;
    property  CEP_FUN                       : Variant read FCEP_FUN                      write SetCEP_FUN;
    property  CID_FUN                       : Variant read FCID_FUN                      write SetCID_FUN;
    property  UF_FUN                        : Variant read FUF_FUN                       write SetUF_FUN;
    property  FON1_FUN                      : Variant read FFON1_FUN                     write SetFON1_FUN;
    property  CEL_FUN                       : Variant read FCEL_FUN                      write SetCEL_FUN;
    property  EMAIL_FUN                     : Variant read FEMAIL_FUN                    write SetEMAIL_FUN;
    property  CPF_FUN                       : Variant read FCPF_FUN                      write SetCPF_FUN;
    property  TIPO_VEN                      : Variant read FTIPO_VEN                     write SetTIPO_VEN;
    property  COMIS_FUN                     : Variant read FCOMIS_FUN                    write SetCOMIS_FUN;
    property  TECNICO_FUN                   : Variant read FTECNICO_FUN                  write SetTECNICO_FUN;
    property  DESCONTO_FUN                  : Variant read FDESCONTO_FUN                 write SetDESCONTO_FUN;
    property  STATUS_FUN                    : Variant read FSTATUS_FUN                   write SetSTATUS_FUN;
    property  COD_USER                      : Variant read FCOD_USER                     write SetCOD_USER;
    property  BANCO_FUN                     : Variant read FBANCO_FUN                    write SetBANCO_FUN;
    property  AGENCIA_FUN                   : Variant read FAGENCIA_FUN                  write SetAGENCIA_FUN;
    property  CONTA_FUN                     : Variant read FCONTA_FUN                    write SetCONTA_FUN;
    property  LOJA                          : Variant read FLOJA                         write SetLOJA;
    property  CAIXA                         : Variant read FCAIXA                        write SetCAIXA;
    property  FUNCAO_FUN                    : Variant read FFUNCAO_FUN                   write SetFUNCAO_FUN;
    property  NASCIMENTO_FUN                : Variant read FNASCIMENTO_FUN               write SetNASCIMENTO_FUN;
    property  ADMISSAO_FUN                  : Variant read FADMISSAO_FUN                 write SetADMISSAO_FUN;
    property  ASO_FUN                       : Variant read FASO_FUN                      write SetASO_FUN;
    property  ESCOLARIDADE_FUN              : Variant read FESCOLARIDADE_FUN             write SetESCOLARIDADE_FUN;
    property  FONE_RECADO_FUN               : Variant read FFONE_RECADO_FUN              write SetFONE_RECADO_FUN;
    property  VENC_EXPERIENCIA_FUN          : Variant read FVENC_EXPERIENCIA_FUN         write SetVENC_EXPERIENCIA_FUN;
    property  DATA_EXAME_FUN                : Variant read FDATA_EXAME_FUN               write SetDATA_EXAME_FUN;
    property  DATA_VENC_EXAME_FUN           : Variant read FDATA_VENC_EXAME_FUN          write SetDATA_VENC_EXAME_FUN;
    property  IMAGEM_FUN                    : Variant read FIMAGEM_FUN                   write SetIMAGEM_FUN;
    property  IMAGEM2_FUN                   : Variant read FIMAGEM2_FUN                  write SetIMAGEM2_FUN;
    property  DIRETORIO_FUN                 : Variant read FDIRETORIO_FUN                write SetDIRETORIO_FUN;
    property  ASO2_FUN                      : Variant read FASO2_FUN                     write SetASO2_FUN;
    property  LOCACAO_FUN                   : Variant read FLOCACAO_FUN                  write SetLOCACAO_FUN;
    property  RG                            : Variant read FRG                           write SetRG;
    property  PIS                           : Variant read FPIS                          write SetPIS;
    property  ID                            : Variant read FID                           write SetID;
    property  SALARIO                       : Variant read FSALARIO                      write SetSALARIO;
    property  REGIAO_ID                     : Variant read FREGIAO_ID                    write SetREGIAO_ID;
    property  GERENTE                       : Variant read FGERENTE                      write SetGERENTE;
    property  GERENTE_ID                    : Variant read FGERENTE_ID                   write SetGERENTE_ID;
    property  MOTORISTA                     : Variant read FMOTORISTA                    write SetMOTORISTA;
    property  COR                           : Variant read FCOR                          write SetCOR;
    property  CABELO                        : Variant read FCABELO                       write SetCABELO;
    property  OLHO                          : Variant read FOLHO                         write SetOLHO;
    property  ALTURA                        : Variant read FALTURA                       write SetALTURA;
    property  PESO                          : Variant read FPESO                         write SetPESO;
    property  SINAIS                        : Variant read FSINAIS                       write SetSINAIS;
    property  OBS_CARACTERISTICA            : Variant read FOBS_CARACTERISTICA           write SetOBS_CARACTERISTICA;
    property  ESTADO_CIVIL                  : Variant read FESTADO_CIVIL                 write SetESTADO_CIVIL;
    property  CONJUGE                       : Variant read FCONJUGE                      write SetCONJUGE;
    property  LOCAL_NASCIMENTO              : Variant read FLOCAL_NASCIMENTO             write SetLOCAL_NASCIMENTO;
    property  NACIONALIDADE                 : Variant read FNACIONALIDADE                write SetNACIONALIDADE;
    property  MAE                           : Variant read FMAE                          write SetMAE;
    property  NACIONALIDADE_MAE             : Variant read FNACIONALIDADE_MAE            write SetNACIONALIDADE_MAE;
    property  PAI                           : Variant read FPAI                          write SetPAI;
    property  NACIONALIDADE_PAI             : Variant read FNACIONALIDADE_PAI            write SetNACIONALIDADE_PAI;
    property  CBO                           : Variant read FCBO                          write SetCBO;
    property  MATRICULA                     : Variant read FMATRICULA                    write SetMATRICULA;
    property  TIPO_SALARIO                  : Variant read FTIPO_SALARIO                 write SetTIPO_SALARIO;
    property  SECAO                         : Variant read FSECAO                        write SetSECAO;
    property  QUADRO_HORARIO                : Variant read FQUADRO_HORARIO               write SetQUADRO_HORARIO;
    property  CARTEIRA_TRABALHO             : Variant read FCARTEIRA_TRABALHO            write SetCARTEIRA_TRABALHO;
    property  EMISSOR_RG                    : Variant read FEMISSOR_RG                   write SetEMISSOR_RG;
    property  UF_RG                         : Variant read FUF_RG                        write SetUF_RG;
    property  CARTEIRA_RESERVISTA           : Variant read FCARTEIRA_RESERVISTA          write SetCARTEIRA_RESERVISTA;
    property  CATEGORIA_RESERVISTA          : Variant read FCATEGORIA_RESERVISTA         write SetCATEGORIA_RESERVISTA;
    property  TITULO_ELEITOR                : Variant read FTITULO_ELEITOR               write SetTITULO_ELEITOR;
    property  CNH                           : Variant read FCNH                          write SetCNH;
    property  CATEGORIA_CNH                 : Variant read FCATEGORIA_CNH                write SetCATEGORIA_CNH;
    property  FGTS                          : Variant read FFGTS                         write SetFGTS;
    property  FGTS_DATA                     : Variant read FFGTS_DATA                    write SetFGTS_DATA;
    property  FGTS_RETRATACAO               : Variant read FFGTS_RETRATACAO              write SetFGTS_RETRATACAO;
    property  FGTS_BANCO                    : Variant read FFGTS_BANCO                   write SetFGTS_BANCO;
    property  DEMITIDO                      : Variant read FDEMITIDO                     write SetDEMITIDO;
    property  CAUSA_DEMISSAO                : Variant read FCAUSA_DEMISSAO               write SetCAUSA_DEMISSAO;
    property  SMS                           : Variant read FSMS                          write SetSMS;
    property  EMAIL                         : Variant read FEMAIL                        write SetEMAIL;
    property  QTDE_VALE_TRANSPORTE          : Variant read FQTDE_VALE_TRANSPORTE         write SetQTDE_VALE_TRANSPORTE;
    property  VALOR_VALE_TRANSPORTE         : Variant read FVALOR_VALE_TRANSPORTE        write SetVALOR_VALE_TRANSPORTE;
    property  AGENDA                        : Variant read FAGENDA                       write SetAGENDA;
    property  EMAIL_HOST                    : Variant read FEMAIL_HOST                   write SetEMAIL_HOST;
    property  EMAIL_ENDERECO                : Variant read FEMAIL_ENDERECO               write SetEMAIL_ENDERECO;
    property  EMAIL_SENHA                   : Variant read FEMAIL_SENHA                  write SetEMAIL_SENHA;
    property  EMAIL_PORTA                   : Variant read FEMAIL_PORTA                  write SetEMAIL_PORTA;
    property  EMAIL_NOME                    : Variant read FEMAIL_NOME                   write SetEMAIL_NOME;
    property  EMAIL_SSL                     : Variant read FEMAIL_SSL                    write SetEMAIL_SSL;
    property  EMAIL_SMTP                    : Variant read FEMAIL_SMTP                   write SetEMAIL_SMTP;
    property  TIPO                          : Variant read FTIPO                         write SetTIPO;
    property  REPRESENTANTE                 : Variant read FREPRESENTANTE                write SetREPRESENTANTE;
    property  EMAIL_RESPOSTA                : Variant read FEMAIL_RESPOSTA               write SetEMAIL_RESPOSTA;
    property  ATALHOS_WEB                   : Variant read FATALHOS_WEB                  write SetATALHOS_WEB;
    property  NOME_COMPLETO                 : Variant read FNOME_COMPLETO                write SetNOME_COMPLETO;
    property  CONTATO                       : Variant read FCONTATO                      write SetCONTATO;
    property  VENC_EXPERIENCIA_PRORROGADO   : Variant read FVENC_EXPERIENCIA_PRORROGADO  write SetVENC_EXPERIENCIA_PRORROGADO;
    property  LOJA_ID                       : Variant read FLOJA_ID                      write SetLOJA_ID;
    property  COMPLEMENTO                   : Variant read FCOMPLEMENTO                  write SetCOMPLEMENTO;
    property  CLT                           : Variant read FCLT                          write SetCLT;
    property  TIPO_COMISSAO                 : Variant read FTIPO_COMISSAO                write SetTIPO_COMISSAO;
    property  DIA_FECHAMENTO_COMISSAO       : Variant read FDIA_FECHAMENTO_COMISSAO      write SetDIA_FECHAMENTO_COMISSAO;
    property  TEMPO_TAREFA                  : Variant read FTEMPO_TAREFA                 write SetTEMPO_TAREFA;
    property  DATA_RG                       : Variant read FDATA_RG                      write SetDATA_RG;
    property  CODIGO_ANTERIOR               : Variant read FCODIGO_ANTERIOR              write SetCODIGO_ANTERIOR;
    property  MENU_WEB                      : Variant read FMENU_WEB                     write SetMENU_WEB;
    property  SYSTIME                       : Variant read FSYSTIME                      write SetSYSTIME;
    property  MONTADOR                      : Variant read FMONTADOR                     write SetMONTADOR;
    property  COMISSAO_MONTADOR             : Variant read FCOMISSAO_MONTADOR            write SetCOMISSAO_MONTADOR;
    property  MSG_FINALIZAR_TAREFA          : Variant read FMSG_FINALIZAR_TAREFA         write SetMSG_FINALIZAR_TAREFA;
    property  TIPO_ESTOQUE                  : Variant read FTIPO_ESTOQUE                 write SetTIPO_ESTOQUE;

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function Incluir : String;
    function Alterar(pID : String) : TFuncionarioModel;
    function Excluir(pID : String) : String;
    function carregaClasse(pId: String): TFuncionarioModel;
    function Salvar : String;
    procedure obterLista;

    function comissaoPorTipo(pCodVendedor, pIdTipoVenda : String): Double;
    function comissaoPorGrupo(pCodVendedor, pIdGrupo: String): Double;

    property FuncionariosLista: IList<TFuncionarioModel> read FFuncionariosLista write SetFuncionariosLista;
   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

  end;

implementation

uses
  FuncionarioDao, GrupoComissaoFuncionarioModel, System.SysUtils;

{ TFuncionarioModel }

function TFuncionarioModel.Alterar(pID: String): TFuncionarioModel;
var
  lFuncionarioModel : TFuncionarioModel;
begin
  lFuncionarioModel := TFuncionarioModel.Create(vIConexao);
  try
    lFuncionarioModel      := lFuncionarioModel.carregaClasse(pID);
    lFuncionarioModel.Acao := tacAlterar;
    Result                 := lFuncionarioModel;
  finally

  end;
end;

function TFuncionarioModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

function TFuncionarioModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TFuncionarioModel.carregaClasse(pId: String): TFuncionarioModel;
var
  lFuncionarioModel: TFuncionarioDao;
begin
  lFuncionarioModel := TFuncionarioDao.Create(vIConexao);
  try
    Result := lFuncionarioModel.carregaClasse(pId);
  finally
    lFuncionarioModel.Free;
  end;
end;

function TFuncionarioModel.comissaoPorGrupo(pCodVendedor, pIdGrupo: String): Double;
var
  lGrupoComissaoFuncionario : TGrupoComissaoFuncionarioModel;
begin
  lGrupoComissaoFuncionario := TGrupoComissaoFuncionarioModel.Create(vIConexao);
  try
    lGrupoComissaoFuncionario.WhereView := ' and funcionario_grupo_comissao.grupo_comissao_id = '+ QuotedStr(pIdGrupo) +
                                           ' and funcionario_grupo_comissao.funcionario_id    = '+ QuotedStr(pCodVendedor);

    Result := lGrupoComissaoFuncionario.ObterLista.objeto.FieldByName('PERCENTUAL').AsFloat;
  finally
    lGrupoComissaoFuncionario.Free;
  end;
end;

function TFuncionarioModel.comissaoPorTipo(pCodVendedor, pIdTipoVenda: String): Double;
var
  lFuncionarioDao: TFuncionarioDao;
begin
  lFuncionarioDao := TFuncionarioDao.Create(vIConexao);
  try
    Result := lFuncionarioDao.comissaoVendedor(pCodVendedor, pIdTipoVenda);
  finally
    lFuncionarioDao.Free;
  end;
end;

constructor TFuncionarioModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TFuncionarioModel.Destroy;
begin
  FFuncionariosLista := nil;
  vIConexao := nil;
  inherited;
end;

procedure TFuncionarioModel.obterLista;
var
  lFuncionarioLista: TFuncionarioDao;
begin
  lFuncionarioLista := TFuncionarioDao.Create(vIConexao);

  try
    lFuncionarioLista.TotalRecords    := FTotalRecords;
    lFuncionarioLista.WhereView       := FWhereView;
    lFuncionarioLista.CountView       := FCountView;
    lFuncionarioLista.OrderView       := FOrderView;
    lFuncionarioLista.StartRecordView := FStartRecordView;
    lFuncionarioLista.LengthPageView  := FLengthPageView;
    lFuncionarioLista.IDRecordView    := FIDRecordView;

    lFuncionarioLista.obterLista;

    FTotalRecords  := lFuncionarioLista.TotalRecords;
    FFuncionariosLista := lFuncionarioLista.FuncionariosLista;

  finally
    lFuncionarioLista.Free;
  end;
end;

function TFuncionarioModel.Salvar: String;
var
  lFuncionarioDao: TFuncionarioDao;
begin
  lFuncionarioDao := TFuncionarioDao.Create(vIConexao);

  Result := '';

  try

  finally
    lFuncionarioDao.Free;
  end;
end;

procedure TFuncionarioModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TFuncionarioModel.SetADMISSAO_FUN(const Value: Variant);
begin
  FADMISSAO_FUN := Value;
end;

procedure TFuncionarioModel.SetAGENCIA_FUN(const Value: Variant);
begin
  FAGENCIA_FUN := Value;
end;

procedure TFuncionarioModel.SetAGENDA(const Value: Variant);
begin
  FAGENDA := Value;
end;

procedure TFuncionarioModel.SetALTURA(const Value: Variant);
begin
  FALTURA := Value;
end;

procedure TFuncionarioModel.SetASO2_FUN(const Value: Variant);
begin
  FASO2_FUN := Value;
end;

procedure TFuncionarioModel.SetASO_FUN(const Value: Variant);
begin
  FASO_FUN := Value;
end;

procedure TFuncionarioModel.SetATALHOS_WEB(const Value: Variant);
begin
  FATALHOS_WEB := Value;
end;

procedure TFuncionarioModel.SetBAI_FUN(const Value: Variant);
begin
  FBAI_FUN := Value;
end;

procedure TFuncionarioModel.SetBANCO_FUN(const Value: Variant);
begin
  FBANCO_FUN := Value;
end;

procedure TFuncionarioModel.SetCABELO(const Value: Variant);
begin
  FCABELO := Value;
end;

procedure TFuncionarioModel.SetCAIXA(const Value: Variant);
begin
  FCAIXA := Value;
end;

procedure TFuncionarioModel.SetCARTEIRA_RESERVISTA(const Value: Variant);
begin
  FCARTEIRA_RESERVISTA := Value;
end;

procedure TFuncionarioModel.SetCARTEIRA_TRABALHO(const Value: Variant);
begin
  FCARTEIRA_TRABALHO := Value;
end;

procedure TFuncionarioModel.SetCATEGORIA_CNH(const Value: Variant);
begin
  FCATEGORIA_CNH := Value;
end;

procedure TFuncionarioModel.SetCATEGORIA_RESERVISTA(const Value: Variant);
begin
  FCATEGORIA_RESERVISTA := Value;
end;

procedure TFuncionarioModel.SetCAUSA_DEMISSAO(const Value: Variant);
begin
  FCAUSA_DEMISSAO := Value;
end;

procedure TFuncionarioModel.SetCBO(const Value: Variant);
begin
  FCBO := Value;
end;

procedure TFuncionarioModel.SetCEL_FUN(const Value: Variant);
begin
  FCEL_FUN := Value;
end;

procedure TFuncionarioModel.SetCEP_FUN(const Value: Variant);
begin
  FCEP_FUN := Value;
end;

procedure TFuncionarioModel.SetCID_FUN(const Value: Variant);
begin
  FCID_FUN := Value;
end;

procedure TFuncionarioModel.SetCLT(const Value: Variant);
begin
  FCLT := Value;
end;

procedure TFuncionarioModel.SetCNH(const Value: Variant);
begin
  FCNH := Value;
end;

procedure TFuncionarioModel.SetCODIGO_ANTERIOR(const Value: Variant);
begin
  FCODIGO_ANTERIOR := Value;
end;

procedure TFuncionarioModel.SetCODIGO_FUN(const Value: Variant);
begin
  FCODIGO_FUN := Value;
end;

procedure TFuncionarioModel.SetCOD_USER(const Value: Variant);
begin
  FCOD_USER := Value;
end;

procedure TFuncionarioModel.SetCOMISSAO_MONTADOR(const Value: Variant);
begin
  FCOMISSAO_MONTADOR := Value;
end;

procedure TFuncionarioModel.SetCOMIS_FUN(const Value: Variant);
begin
  FCOMIS_FUN := Value;
end;

procedure TFuncionarioModel.SetCOMPLEMENTO(const Value: Variant);
begin
  FCOMPLEMENTO := Value;
end;

procedure TFuncionarioModel.SetCONJUGE(const Value: Variant);
begin
  FCONJUGE := Value;
end;

procedure TFuncionarioModel.SetCONTATO(const Value: Variant);
begin
  FCONTATO := Value;
end;

procedure TFuncionarioModel.SetCONTA_FUN(const Value: Variant);
begin
  FCONTA_FUN := Value;
end;

procedure TFuncionarioModel.SetCOR(const Value: Variant);
begin
  FCOR := Value;
end;

procedure TFuncionarioModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFuncionarioModel.SetCPF_FUN(const Value: Variant);
begin
  FCPF_FUN := Value;
end;

procedure TFuncionarioModel.SetDATA_EXAME_FUN(const Value: Variant);
begin
  FDATA_EXAME_FUN := Value;
end;

procedure TFuncionarioModel.SetDATA_RG(const Value: Variant);
begin
  FDATA_RG := Value;
end;

procedure TFuncionarioModel.SetDATA_VENC_EXAME_FUN(const Value: Variant);
begin
  FDATA_VENC_EXAME_FUN := Value;
end;

procedure TFuncionarioModel.SetDEMITIDO(const Value: Variant);
begin
  FDEMITIDO := Value;
end;

procedure TFuncionarioModel.SetDESCONTO_FUN(const Value: Variant);
begin
  FDESCONTO_FUN := Value;
end;

procedure TFuncionarioModel.SetDIA_FECHAMENTO_COMISSAO(const Value: Variant);
begin
  FDIA_FECHAMENTO_COMISSAO := Value;
end;

procedure TFuncionarioModel.SetDIRETORIO_FUN(const Value: Variant);
begin
  FDIRETORIO_FUN := Value;
end;

procedure TFuncionarioModel.SetEMAIL(const Value: Variant);
begin
  FEMAIL := Value;
end;

procedure TFuncionarioModel.SetEMAIL_ENDERECO(const Value: Variant);
begin
  FEMAIL_ENDERECO := Value;
end;

procedure TFuncionarioModel.SetEMAIL_FUN(const Value: Variant);
begin
  FEMAIL_FUN := Value;
end;

procedure TFuncionarioModel.SetEMAIL_HOST(const Value: Variant);
begin
  FEMAIL_HOST := Value;
end;

procedure TFuncionarioModel.SetEMAIL_NOME(const Value: Variant);
begin
  FEMAIL_NOME := Value;
end;

procedure TFuncionarioModel.SetEMAIL_PORTA(const Value: Variant);
begin
  FEMAIL_PORTA := Value;
end;

procedure TFuncionarioModel.SetEMAIL_RESPOSTA(const Value: Variant);
begin
  FEMAIL_RESPOSTA := Value;
end;

procedure TFuncionarioModel.SetEMAIL_SENHA(const Value: Variant);
begin
  FEMAIL_SENHA := Value;
end;

procedure TFuncionarioModel.SetEMAIL_SMTP(const Value: Variant);
begin
  FEMAIL_SMTP := Value;
end;

procedure TFuncionarioModel.SetEMAIL_SSL(const Value: Variant);
begin
  FEMAIL_SSL := Value;
end;

procedure TFuncionarioModel.SetEMISSOR_RG(const Value: Variant);
begin
  FEMISSOR_RG := Value;
end;

procedure TFuncionarioModel.SetEND_FUN(const Value: Variant);
begin
  FEND_FUN := Value;
end;

procedure TFuncionarioModel.SetESCOLARIDADE_FUN(const Value: Variant);
begin
  FESCOLARIDADE_FUN := Value;
end;

procedure TFuncionarioModel.SetESTADO_CIVIL(const Value: Variant);
begin
  FESTADO_CIVIL := Value;
end;

procedure TFuncionarioModel.SetFGTS(const Value: Variant);
begin
  FFGTS := Value;
end;

procedure TFuncionarioModel.SetFGTS_BANCO(const Value: Variant);
begin
  FFGTS_BANCO := Value;
end;

procedure TFuncionarioModel.SetFGTS_DATA(const Value: Variant);
begin
  FFGTS_DATA := Value;
end;

procedure TFuncionarioModel.SetFGTS_RETRATACAO(const Value: Variant);
begin
  FFGTS_RETRATACAO := Value;
end;

procedure TFuncionarioModel.SetFON1_FUN(const Value: Variant);
begin
  FFON1_FUN := Value;
end;

procedure TFuncionarioModel.SetFONE_RECADO_FUN(const Value: Variant);
begin
  FFONE_RECADO_FUN := Value;
end;

procedure TFuncionarioModel.SetFUNCAO_FUN(const Value: Variant);
begin
  FFUNCAO_FUN := Value;
end;

procedure TFuncionarioModel.SetFuncionariosLista;
begin
  FFuncionariosLista := Value;
end;

procedure TFuncionarioModel.SetGERENTE(const Value: Variant);
begin
  FGERENTE := Value;
end;

procedure TFuncionarioModel.SetGERENTE_ID(const Value: Variant);
begin
  FGERENTE_ID := Value;
end;

procedure TFuncionarioModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TFuncionarioModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TFuncionarioModel.SetIMAGEM2_FUN(const Value: Variant);
begin
  FIMAGEM2_FUN := Value;
end;

procedure TFuncionarioModel.SetIMAGEM_FUN(const Value: Variant);
begin
  FIMAGEM_FUN := Value;
end;

procedure TFuncionarioModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFuncionarioModel.SetLOCACAO_FUN(const Value: Variant);
begin
  FLOCACAO_FUN := Value;
end;

procedure TFuncionarioModel.SetLOCAL_NASCIMENTO(const Value: Variant);
begin
  FLOCAL_NASCIMENTO := Value;
end;

procedure TFuncionarioModel.SetLOJA(const Value: Variant);
begin
  FLOJA := Value;
end;

procedure TFuncionarioModel.SetLOJA_ID(const Value: Variant);
begin
  FLOJA_ID := Value;
end;

procedure TFuncionarioModel.SetMAE(const Value: Variant);
begin
  FMAE := Value;
end;

procedure TFuncionarioModel.SetMATRICULA(const Value: Variant);
begin
  FMATRICULA := Value;
end;

procedure TFuncionarioModel.SetMENU_WEB(const Value: Variant);
begin
  FMENU_WEB := Value;
end;

procedure TFuncionarioModel.SetMONTADOR(const Value: Variant);
begin
  FMONTADOR := Value;
end;

procedure TFuncionarioModel.SetMOTORISTA(const Value: Variant);
begin
  FMOTORISTA := Value;
end;

procedure TFuncionarioModel.SetMSG_FINALIZAR_TAREFA(const Value: Variant);
begin
  FMSG_FINALIZAR_TAREFA := Value;
end;

procedure TFuncionarioModel.SetNACIONALIDADE(const Value: Variant);
begin
  FNACIONALIDADE := Value;
end;

procedure TFuncionarioModel.SetNACIONALIDADE_MAE(const Value: Variant);
begin
  FNACIONALIDADE_MAE := Value;
end;

procedure TFuncionarioModel.SetNACIONALIDADE_PAI(const Value: Variant);
begin
  FNACIONALIDADE_PAI := Value;
end;

procedure TFuncionarioModel.SetNASCIMENTO_FUN(const Value: Variant);
begin
  FNASCIMENTO_FUN := Value;
end;

procedure TFuncionarioModel.SetNOME_COMPLETO(const Value: Variant);
begin
  FNOME_COMPLETO := Value;
end;

procedure TFuncionarioModel.SetNOME_FUN(const Value: Variant);
begin
  FNOME_FUN := Value;
end;

procedure TFuncionarioModel.SetOBS_CARACTERISTICA(const Value: Variant);
begin
  FOBS_CARACTERISTICA := Value;
end;

procedure TFuncionarioModel.SetOLHO(const Value: Variant);
begin
  FOLHO := Value;
end;

procedure TFuncionarioModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFuncionarioModel.SetPAI(const Value: Variant);
begin
  FPAI := Value;
end;

procedure TFuncionarioModel.SetPESO(const Value: Variant);
begin
  FPESO := Value;
end;

procedure TFuncionarioModel.SetPIS(const Value: Variant);
begin
  FPIS := Value;
end;

procedure TFuncionarioModel.SetQTDE_VALE_TRANSPORTE(const Value: Variant);
begin
  FQTDE_VALE_TRANSPORTE := Value;
end;

procedure TFuncionarioModel.SetQUADRO_HORARIO(const Value: Variant);
begin
  FQUADRO_HORARIO := Value;
end;

procedure TFuncionarioModel.SetREGIAO_ID(const Value: Variant);
begin
  FREGIAO_ID := Value;
end;

procedure TFuncionarioModel.SetREPRESENTANTE(const Value: Variant);
begin
  FREPRESENTANTE := Value;
end;

procedure TFuncionarioModel.SetRG(const Value: Variant);
begin
  FRG := Value;
end;

procedure TFuncionarioModel.SetSALARIO(const Value: Variant);
begin
  FSALARIO := Value;
end;

procedure TFuncionarioModel.SetSECAO(const Value: Variant);
begin
  FSECAO := Value;
end;

procedure TFuncionarioModel.SetSINAIS(const Value: Variant);
begin
  FSINAIS := Value;
end;

procedure TFuncionarioModel.SetSMS(const Value: Variant);
begin
  FSMS := Value;
end;

procedure TFuncionarioModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TFuncionarioModel.SetSTATUS_FUN(const Value: Variant);
begin
  FSTATUS_FUN := Value;
end;

procedure TFuncionarioModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TFuncionarioModel.SetTECNICO_FUN(const Value: Variant);
begin
  FTECNICO_FUN := Value;
end;

procedure TFuncionarioModel.SetTEMPO_TAREFA(const Value: Variant);
begin
  FTEMPO_TAREFA := Value;
end;

procedure TFuncionarioModel.SetTIPO(const Value: Variant);
begin
  FTIPO := Value;
end;

procedure TFuncionarioModel.SetTIPO_COMISSAO(const Value: Variant);
begin
  FTIPO_COMISSAO := Value;
end;

procedure TFuncionarioModel.SetTIPO_ESTOQUE(const Value: Variant);
begin
  FTIPO_ESTOQUE := Value;
end;

procedure TFuncionarioModel.SetTIPO_SALARIO(const Value: Variant);
begin
  FTIPO_SALARIO := Value;
end;

procedure TFuncionarioModel.SetTIPO_VEN(const Value: Variant);
begin
  FTIPO_VEN := Value;
end;

procedure TFuncionarioModel.SetTITULO_ELEITOR(const Value: Variant);
begin
  FTITULO_ELEITOR := Value;
end;

procedure TFuncionarioModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TFuncionarioModel.SetUF_FUN(const Value: Variant);
begin
  FUF_FUN := Value;
end;

procedure TFuncionarioModel.SetUF_RG(const Value: Variant);
begin
  FUF_RG := Value;
end;

procedure TFuncionarioModel.SetVALOR_VALE_TRANSPORTE(const Value: Variant);
begin
  FVALOR_VALE_TRANSPORTE := Value;
end;

procedure TFuncionarioModel.SetVENC_EXPERIENCIA_FUN(const Value: Variant);
begin
  FVENC_EXPERIENCIA_FUN := Value;
end;

procedure TFuncionarioModel.SetVENC_EXPERIENCIA_PRORROGADO(
  const Value: Variant);
begin
  FVENC_EXPERIENCIA_PRORROGADO := Value;
end;

procedure TFuncionarioModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
