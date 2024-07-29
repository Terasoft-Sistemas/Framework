unit ClienteModel;
interface
uses
  Classes,
  Terasoft.Types,
  Spring.Collections,
  Interfaces.Conexao,
  Terasoft.Framework.Texto,
  Terasoft.Framework.Types,
  Terasoft.Model.Base,
  FireDAC.Comp.Client;

type
  TClienteModel = class(Terasoft.Model.Base.TModelBase)

  private
    FClientesLista: IList<TClienteModel>;
    FAcao: TAcao;
    FLengthPageView: String;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    Fconfirm_trabalho_conjuge: Variant;
    Fusa_mdfe: Variant;
    Fdigitapressao: Variant;
    Fcardiopatias: Variant;
    Fobservacao_cobranca: Variant;
    Fpais_id: Variant;
    Fnascimento_dependente2: Variant;
    Fcredito_cli: Variant;
    Fsalariocon_cli: Variant;
    Fseprocado_cli: Variant;
    Fendereco_cli: Variant;
    Ftipo_residencia: Variant;
    Fcontador_id: Variant;
    Falteracao_ortopedicas: Variant;
    Fnascimento_dependente3: Variant;
    Fmae_cli: Variant;
    Ftelefone_cli: Variant;
    Frazao_cli: Variant;
    Fusar_desconto_produto: Variant;
    Freducao_icms: Variant;
    Fenvia_sms: Variant;
    Fdiapasao: Variant;
    Fonicolise: Variant;
    Fdst: Variant;
    Femail_cobranca: Variant;
    Fbairro_entrega: Variant;
    Ftipo_suframa: Variant;
    Fnumero_end: Variant;
    Fobservacao_ped_orc: Variant;
    Fexpedicao_rg: Variant;
    Frenda_cli: Variant;
    Fcelular_cli: Variant;
    Fvalor_aluguel: Variant;
    Finscricao_municipal: Variant;
    Fmaterial: Variant;
    Fbanco_id: Variant;
    Fcnae: Variant;
    Fdata_vencimento_cb: Variant;
    Fportador: Variant;
    Fdata_alteracao: Variant;
    Fbanco_cli: Variant;
    Fcidcobranca_cli: Variant;
    Fonicotrofia: Variant;
    Fpratica_esporte: Variant;
    Fnascimento_dependente6: Variant;
    Flimite_sms: Variant;
    Fregiao_id: Variant;
    Fbeneficio_cli: Variant;
    Fconvenio_cli: Variant;
    Fusar_controle_kg: Variant;
    Fmonofilamento: Variant;
    Fpatologia: Variant;
    Falergico_obs: Variant;
    Fdesconto_nf: Variant;
    Fdependente2: Variant;
    Fnaturalidade_cli: Variant;
    Fuftrabalho_cli: Variant;
    Focupacao_id: Variant;
    Fconfirm_trabalho: Variant;
    Fparcela_maxima: Variant;
    Fdedos_garra: Variant;
    Fnascimento_dependente4: Variant;
    Fuf_entrega: Variant;
    Ftelefone_internacional: Variant;
    Fdependente3: Variant;
    Fmae_aval: Variant;
    Fobservacao_cli: Variant;
    Fbairtrabalho_cli: Variant;
    Fcnpj_cpf_cli: Variant;
    Ffantasia_cli: Variant;
    Fobservacao_implantacao: Variant;
    Fdesconto_bol: Variant;
    Fusa_cte: Variant;
    Fnascimento_dependente5: Variant;
    Fdesconto_financeiro: Variant;
    Fdata_nasc_aval: Variant;
    Fcidade_aval_cli: Variant;
    Fsacador_avalista_id: Variant;
    Fnome_trabalho_anterior: Variant;
    Fusa_nfse: Variant;
    Fungueal: Variant;
    Falteracao_cor: Variant;
    Ftabagismo: Variant;
    Fconsumidor_final: Variant;
    Ftipo_apuracao: Variant;
    Fendereco_aval_cli: Variant;
    Fisento_icms: Variant;
    Ftempo_servico: Variant;
    Fpai_cli: Variant;
    Femail_cli: Variant;
    Fbairro_cli: Variant;
    Ftransportadora_id: Variant;
    Foutras_patologias: Variant;
    Fdependente6: Variant;
    Fnascimento_dependente: Variant;
    Ftelefone_aval_cli: Variant;
    Ffax_cli: Variant;
    Fgrupo_economico_id: Variant;
    Fconfirm_endereco_anterior: Variant;
    Fconfirm_endereco: Variant;
    Ftrabalho_anterior_admissao: Variant;
    Ftrabalho_admissao: Variant;
    Fpe_plano: Variant;
    Fonicofose: Variant;
    Fcelular_aval_cli: Variant;
    Fdescricao: Variant;
    Fnascimento_cli: Variant;
    Ffoneref2_cli: Variant;
    Fendcobranca_cli: Variant;
    Fcodigo_anterior: Variant;
    Ftelefone_trabalho_anterior: Variant;
    Fdependente4: Variant;
    Funidade_consumidora_cb: Variant;
    Frg_aval: Variant;
    Ftipo_saida: Variant;
    Fcodigo_ven: Variant;
    Ffoneref3_cli: Variant;
    Fceptrabalho_cli: Variant;
    Fsub_atividade_id: Variant;
    Frenda_trabalho_anterior: Variant;
    Fpodactilia: Variant;
    Fpe_cavo: Variant;
    Fdependente5: Variant;
    Fctb: Variant;
    Fcep_entrega: Variant;
    Fuf_cli: Variant;
    Fimportacao_dados: Variant;
    Fnumero_entrega: Variant;
    Foutras_alteracao_laminas: Variant;
    Ffrequencia: Variant;
    Fpreco_id: Variant;
    Ftitular_conta_cb: Variant;
    Fcodigo_concessionaria_cb: Variant;
    Fnomecon_cli: Variant;
    Festadocivil_cli: Variant;
    Ffoneref1_cli: Variant;
    Fperfusao_d: Variant;
    Falergico: Variant;
    Fdependente: Variant;
    Ffone_com_aval: Variant;
    Fcnpj_cpf_aval_cli: Variant;
    Fconvenio_cod: Variant;
    Finscricao_rg_cli: Variant;
    Fcodigo_cli: Variant;
    Fdata_inatividade: Variant;
    Ffuncao_trabalho_anterior: Variant;
    Fperfusao_e: Variant;
    Fonicomicose: Variant;
    Fonicogrifose: Variant;
    Fid: Variant;
    Fusa_nfe: Variant;
    Fpulsos: Variant;
    Fonicorrexe: Variant;
    Fdiabetes_familiares: Variant;
    Fmulta: Variant;
    Ftelefone_mae: Variant;
    Fbairro_aval_cli: Variant;
    Faceite_bol: Variant;
    Fvaucher: Variant;
    Fex_estado: Variant;
    Fdiabetes: Variant;
    Findice_juros_id: Variant;
    Foperadora_celular: Variant;
    Fcodigo_vendedor_cb: Variant;
    Fprofcon_cli: Variant;
    Fpedido_minimo: Variant;
    Fcomissao: Variant;
    Fhiperhidrose: Variant;
    Fcirurgia_mmii: Variant;
    Fimagem: Variant;
    Fsuframa: Variant;
    Fstatus: Variant;
    Fultima_compra: Variant;
    Floja: Variant;
    Fcep_cli: Variant;
    Fzemopay_banco_id: Variant;
    Fproduto_tipo_id: Variant;
    Ftempo_residencia: Variant;
    Fex_codigo_postal: Variant;
    Fcomplemento_entrega: Variant;
    Fetilista: Variant;
    Fobservacao_nfe: Variant;
    Fcomplemento_cobranca: Variant;
    Fcfop_id: Variant;
    Fcarta_cli: Variant;
    Fcidtrabalho_cli: Variant;
    Ftipo_emissao_nfe: Variant;
    Fsenha: Variant;
    Fregime_trabalho: Variant;
    Ffissuras: Variant;
    Fgranulada: Variant;
    Fgravidez: Variant;
    Fprospeccao_id: Variant;
    Fjuros_bol: Variant;
    Fcontato_cobranca: Variant;
    Fsexo_dependente2: Variant;
    Frevendedor: Variant;
    Freferencia2_cli: Variant;
    Fzemopay_taxa_id: Variant;
    Fparentesco_ref2: Variant;
    Ffrieira: Variant;
    Fisento_st: Variant;
    Fsystime: Variant;
    Fcondicoes_pagamento: Variant;
    Fsexo_dependente3: Variant;
    Frgcon_cli: Variant;
    Fcontatoagencia_cli: Variant;
    Freferencia3_cli: Variant;
    Fufcobranca_cli: Variant;
    Fstatus_implantacao: Variant;
    Fabatimento_bol: Variant;
    Fonicocriptose: Variant;
    Fstatus_carta: Variant;
    Fcomplemento: Variant;
    Fdata_retorno: Variant;
    Fbaircobranca_cli: Variant;
    Fmatriz_cliente_id: Variant;
    Fdisidrose: Variant;
    Fformato_unha: Variant;
    Ftelefone_pai: Variant;
    Fobs_geral: Variant;
    Fdata_nasc_conjugue: Variant;
    Fclassif_cli: Variant;
    Freferencia1_cli: Variant;
    Fpercentual_desconto: Variant;
    Fparentesco_ref1: Variant;
    Fusa_nfce: Variant;
    Fbromidrose: Variant;
    Fsexo_dependente6: Variant;
    Finstrucao_boleto: Variant;
    Ftelefone_conjuge: Variant;
    Fcarga_tributaria: Variant;
    Favalista_cli: Variant;
    Fpsoriase_pe: Variant;
    Fcidade_entrega: Variant;
    Fcelular_cli2: Variant;
    Fconta_cli: Variant;
    Fesporao_calcaneo: Variant;
    Fisquemica: Variant;
    Fmotivo_visita: Variant;
    Fdestro_canhoto: Variant;
    Fsexo_dependente4: Variant;
    Ftela: Variant;
    Fendereco_entrega: Variant;
    Fdescricao_reparcelamento: Variant;
    Flimite_compra: Variant;
    Fcontato_cli: Variant;
    Fendtrabalho_cli: Variant;
    Fbloquear_alteracao_tabela: Variant;
    Fdia_vencimento: Variant;
    Fexostose_subungueal: Variant;
    Ffrete: Variant;
    Fsexo_dependente5: Variant;
    Ftelefone_cobranca: Variant;
    Fquantidade_terminais: Variant;
    Fatividade_id: Variant;
    Fcepcobranca_cli: Variant;
    Fatividade_cli: Variant;
    Fzemopay: Variant;
    Fcod_municipio_entrega: Variant;
    Findicacao: Variant;
    Ftinea_pedis: Variant;
    Fpressao: Variant;
    Fpatologia_obs: Variant;
    Fcelular_cobrnaca: Variant;
    Fnfe: Variant;
    Femail2: Variant;
    Fcadastro_cli: Variant;
    Ffonetrabalho_cli: Variant;
    Flocaltrabalho_cli: Variant;
    Fhalux_rigidus: Variant;
    Fanidrose: Variant;
    Fcalcado_mais_usado: Variant;
    Fsexo_dependente: Variant;
    Fisento_ipi: Variant;
    Furl_cli: Variant;
    Fendereco: Variant;
    Fneuropatica: Variant;
    Fpsoriase: Variant;
    Ftratamento_medicamento: Variant;
    Fnumero_calcado: Variant;
    Fdata_faturamento_cb: Variant;
    Fhora_retorno: Variant;
    Fsexo_cli: Variant;
    Fcpfcon_cli: Variant;
    Fusuario_cli: Variant;
    Ffoneagencia_cli: Variant;
    Fagencia_cli: Variant;
    Ffuncaotrabalho_cli: Variant;
    Fnao_contribuinte: Variant;
    Fzemopay_id: Variant;
    Flistar_rad: Variant;
    Fhalux_valgus: Variant;
    Falteracao_pele: Variant;
    Fmal_perfurante: Variant;
    Fdesc_financeiro: Variant;
    Fcod_municipio: Variant;
    Freduzir_base_icms: Variant;
    Ftipo_cli: Variant;
    Fcidade_cli: Variant;
    Fuf_naturalidade_cli: Variant;
    Fescolaridade_cli: Variant;
    Fnumbeneficio_cli: Variant;
    Ffonte_beneficio_cli: Variant;
    Ftipo_funcionario_publico_cli: Variant;
    Fcodigo_ocupacao_cli: Variant;
    Ftipodocidentificacaoconj_cli: Variant;
    Fdocidentificacaoconj_cli: Variant;
    Ftipodoc_cli: variant;
    Fcnpj_trabalho_cli: Variant;
    Fcpf_conjuge_cli: Variant;
    Fnome_contador_cli: Variant;
    Ftelefone_contador_cli: Variant;
    FCamposInvalidos: TStringlist;
    procedure SetAcao(const Value: TAcao);
    procedure SetCountView(const Value: String);
    procedure SetClientesLista(const Value: IList<TClienteModel>);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);
    procedure Setabatimento_bol(const Value: Variant);
    procedure Setaceite_bol(const Value: Variant);
    procedure Setagencia_cli(const Value: Variant);
    procedure Setalergico(const Value: Variant);
    procedure Setalergico_obs(const Value: Variant);
    procedure Setalteracao_cor(const Value: Variant);
    procedure Setalteracao_ortopedicas(const Value: Variant);
    procedure Setalteracao_pele(const Value: Variant);
    procedure Setanidrose(const Value: Variant);
    procedure Setatividade_cli(const Value: Variant);
    procedure Setatividade_id(const Value: Variant);
    procedure Setavalista_cli(const Value: Variant);
    procedure Setbaircobranca_cli(const Value: Variant);
    procedure Setbairro_aval_cli(const Value: Variant);
    procedure Setbairro_cli(const Value: Variant);
    procedure Setbairro_entrega(const Value: Variant);
    procedure Setbairtrabalho_cli(const Value: Variant);
    procedure Setbanco_cli(const Value: Variant);
    procedure Setbanco_id(const Value: Variant);
    procedure Setbeneficio_cli(const Value: Variant);
    procedure Setbloquear_alteracao_tabela(const Value: Variant);
    procedure Setbromidrose(const Value: Variant);
    procedure Setcadastro_cli(const Value: Variant);
    procedure Setcalcado_mais_usado(const Value: Variant);
    procedure Setcardiopatias(const Value: Variant);
    procedure Setcarga_tributaria(const Value: Variant);
    procedure Setcarta_cli(const Value: Variant);
    procedure Setcelular_aval_cli(const Value: Variant);
    procedure Setcelular_cli(const Value: Variant);
    procedure Setcelular_cli2(const Value: Variant);
    procedure Setcelular_cobrnaca(const Value: Variant);
    procedure Setcep_cli(const Value: Variant);
    procedure Setcep_entrega(const Value: Variant);
    procedure Setcepcobranca_cli(const Value: Variant);
    procedure Setceptrabalho_cli(const Value: Variant);
    procedure Setcfop_id(const Value: Variant);
    procedure Setcidade_aval_cli(const Value: Variant);
    procedure Setcidade_cli(const Value: Variant);
    procedure Setcidade_entrega(const Value: Variant);
    procedure Setcidcobranca_cli(const Value: Variant);
    procedure Setcidtrabalho_cli(const Value: Variant);
    procedure Setcirurgia_mmii(const Value: Variant);
    procedure Setclassif_cli(const Value: Variant);
    procedure Setcnae(const Value: Variant);
    procedure Setcnpj_cpf_aval_cli(const Value: Variant);
    procedure Setcnpj_cpf_cli(const Value: Variant);
    procedure Setcod_municipio(const Value: Variant);
    procedure Setcod_municipio_entrega(const Value: Variant);
    procedure Setcodigo_anterior(const Value: Variant);
    procedure Setcodigo_cli(const Value: Variant);
    procedure Setcodigo_concessionaria_cb(const Value: Variant);
    procedure Setcodigo_ven(const Value: Variant);
    procedure Setcodigo_vendedor_cb(const Value: Variant);
    procedure Setcomissao(const Value: Variant);
    procedure Setcomplemento(const Value: Variant);
    procedure Setcomplemento_cobranca(const Value: Variant);
    procedure Setcomplemento_entrega(const Value: Variant);
    procedure Setcondicoes_pagamento(const Value: Variant);
    procedure Setconfirm_endereco(const Value: Variant);
    procedure Setconfirm_endereco_anterior(const Value: Variant);
    procedure Setconfirm_trabalho(const Value: Variant);
    procedure Setconfirm_trabalho_conjuge(const Value: Variant);
    procedure Setconsumidor_final(const Value: Variant);
    procedure Setconta_cli(const Value: Variant);
    procedure Setcontador_id(const Value: Variant);
    procedure Setcontato_cli(const Value: Variant);
    procedure Setcontato_cobranca(const Value: Variant);
    procedure Setcontatoagencia_cli(const Value: Variant);
    procedure Setconvenio_cli(const Value: Variant);
    procedure Setconvenio_cod(const Value: Variant);
    procedure Setcpfcon_cli(const Value: Variant);
    procedure Setcredito_cli(const Value: Variant);
    procedure Setctb(const Value: Variant);
    procedure Setdata_alteracao(const Value: Variant);
    procedure Setdata_faturamento_cb(const Value: Variant);
    procedure Setdata_inatividade(const Value: Variant);
    procedure Setdata_nasc_aval(const Value: Variant);
    procedure Setdata_nasc_conjugue(const Value: Variant);
    procedure Setdata_retorno(const Value: Variant);
    procedure Setdata_vencimento_cb(const Value: Variant);
    procedure Setdedos_garra(const Value: Variant);
    procedure Setdependente(const Value: Variant);
    procedure Setdependente2(const Value: Variant);
    procedure Setdependente3(const Value: Variant);
    procedure Setdependente4(const Value: Variant);
    procedure Setdependente5(const Value: Variant);
    procedure Setdependente6(const Value: Variant);
    procedure Setdesc_financeiro(const Value: Variant);
    procedure Setdesconto_bol(const Value: Variant);
    procedure Setdesconto_financeiro(const Value: Variant);
    procedure Setdesconto_nf(const Value: Variant);
    procedure Setdescricao(const Value: Variant);
    procedure Setdescricao_reparcelamento(const Value: Variant);
    procedure Setdestro_canhoto(const Value: Variant);
    procedure Setdia_vencimento(const Value: Variant);
    procedure Setdiabetes(const Value: Variant);
    procedure Setdiabetes_familiares(const Value: Variant);
    procedure Setdiapasao(const Value: Variant);
    procedure Setdigitapressao(const Value: Variant);
    procedure Setdisidrose(const Value: Variant);
    procedure Setdst(const Value: Variant);
    procedure Setemail_cli(const Value: Variant);
    procedure Setemail_cobranca(const Value: Variant);
    procedure Setemail2(const Value: Variant);
    procedure Setendcobranca_cli(const Value: Variant);
    procedure Setendereco(const Value: Variant);
    procedure Setendereco_aval_cli(const Value: Variant);
    procedure Setendereco_cli(const Value: Variant);
    procedure Setendereco_entrega(const Value: Variant);
    procedure Setendtrabalho_cli(const Value: Variant);
    procedure Setenvia_sms(const Value: Variant);
    procedure Setesporao_calcaneo(const Value: Variant);
    procedure Setestadocivil_cli(const Value: Variant);
    procedure Setetilista(const Value: Variant);
    procedure Setex_codigo_postal(const Value: Variant);
    procedure Setex_estado(const Value: Variant);
    procedure Setexostose_subungueal(const Value: Variant);
    procedure Setexpedicao_rg(const Value: Variant);
    procedure Setfantasia_cli(const Value: Variant);
    procedure Setfax_cli(const Value: Variant);
    procedure Setfissuras(const Value: Variant);
    procedure Setfone_com_aval(const Value: Variant);
    procedure Setfoneagencia_cli(const Value: Variant);
    procedure Setfoneref1_cli(const Value: Variant);
    procedure Setfoneref2_cli(const Value: Variant);
    procedure Setfoneref3_cli(const Value: Variant);
    procedure Setfonetrabalho_cli(const Value: Variant);
    procedure Setformato_unha(const Value: Variant);
    procedure Setfrequencia(const Value: Variant);
    procedure Setfrete(const Value: Variant);
    procedure Setfrieira(const Value: Variant);
    procedure Setfuncao_trabalho_anterior(const Value: Variant);
    procedure Setfuncaotrabalho_cli(const Value: Variant);
    procedure Setgranulada(const Value: Variant);
    procedure Setgravidez(const Value: Variant);
    procedure Setgrupo_economico_id(const Value: Variant);
    procedure Sethalux_rigidus(const Value: Variant);
    procedure Sethalux_valgus(const Value: Variant);
    procedure Sethiperhidrose(const Value: Variant);
    procedure Sethora_retorno(const Value: Variant);
    procedure Setid(const Value: Variant);
    procedure Setimagem(const Value: Variant);
    procedure Setimportacao_dados(const Value: Variant);
    procedure Setindicacao(const Value: Variant);
    procedure Setindice_juros_id(const Value: Variant);
    procedure Setinscricao_municipal(const Value: Variant);
    procedure Setinscricao_rg_cli(const Value: Variant);
    procedure Setinstrucao_boleto(const Value: Variant);
    procedure Setisento_icms(const Value: Variant);
    procedure Setisento_ipi(const Value: Variant);
    procedure Setisento_st(const Value: Variant);
    procedure Setisquemica(const Value: Variant);
    procedure Setjuros_bol(const Value: Variant);
    procedure Setlimite_compra(const Value: Variant);
    procedure Setlimite_sms(const Value: Variant);
    procedure Setlistar_rad(const Value: Variant);
    procedure Setlocaltrabalho_cli(const Value: Variant);
    procedure Setloja(const Value: Variant);
    procedure Setmae_aval(const Value: Variant);
    procedure Setmae_cli(const Value: Variant);
    procedure Setmal_perfurante(const Value: Variant);
    procedure Setmaterial(const Value: Variant);
    procedure Setmatriz_cliente_id(const Value: Variant);
    procedure Setmonofilamento(const Value: Variant);
    procedure Setmotivo_visita(const Value: Variant);
    procedure Setmulta(const Value: Variant);
    procedure Setnao_contribuinte(const Value: Variant);
    procedure Setnascimento_cli(const Value: Variant);
    procedure Setnascimento_dependente(const Value: Variant);
    procedure Setnascimento_dependente2(const Value: Variant);
    procedure Setnascimento_dependente3(const Value: Variant);
    procedure Setnascimento_dependente4(const Value: Variant);
    procedure Setnascimento_dependente5(const Value: Variant);
    procedure Setnascimento_dependente6(const Value: Variant);
    procedure Setnaturalidade_cli(const Value: Variant);
    procedure Setneuropatica(const Value: Variant);
    procedure Setnfe(const Value: Variant);
    procedure Setnome_trabalho_anterior(const Value: Variant);
    procedure Setnomecon_cli(const Value: Variant);
    procedure Setnumero_calcado(const Value: Variant);
    procedure Setnumero_end(const Value: Variant);
    procedure Setnumero_entrega(const Value: Variant);
    procedure Setobs_geral(const Value: Variant);
    procedure Setobservacao_cli(const Value: Variant);
    procedure Setobservacao_cobranca(const Value: Variant);
    procedure Setobservacao_implantacao(const Value: Variant);
    procedure Setobservacao_nfe(const Value: Variant);
    procedure Setobservacao_ped_orc(const Value: Variant);
    procedure Setocupacao_id(const Value: Variant);
    procedure Setonicocriptose(const Value: Variant);
    procedure Setonicofose(const Value: Variant);
    procedure Setonicogrifose(const Value: Variant);
    procedure Setonicolise(const Value: Variant);
    procedure Setonicomicose(const Value: Variant);
    procedure Setonicorrexe(const Value: Variant);
    procedure Setonicotrofia(const Value: Variant);
    procedure Setoperadora_celular(const Value: Variant);
    procedure Setoutras_alteracao_laminas(const Value: Variant);
    procedure Setoutras_patologias(const Value: Variant);
    procedure Setpai_cli(const Value: Variant);
    procedure Setpais_id(const Value: Variant);
    procedure Setparcela_maxima(const Value: Variant);
    procedure Setparentesco_ref1(const Value: Variant);
    procedure Setparentesco_ref2(const Value: Variant);
    procedure Setpatologia(const Value: Variant);
    procedure Setpatologia_obs(const Value: Variant);
    procedure Setpe_cavo(const Value: Variant);
    procedure Setpe_plano(const Value: Variant);
    procedure Setpedido_minimo(const Value: Variant);
    procedure Setpercentual_desconto(const Value: Variant);
    procedure Setperfusao_d(const Value: Variant);
    procedure Setperfusao_e(const Value: Variant);
    procedure Setpodactilia(const Value: Variant);
    procedure Setportador(const Value: Variant);
    procedure Setpratica_esporte(const Value: Variant);
    procedure Setpreco_id(const Value: Variant);
    procedure Setpressao(const Value: Variant);
    procedure Setproduto_tipo_id(const Value: Variant);
    procedure Setprofcon_cli(const Value: Variant);
    procedure Setprospeccao_id(const Value: Variant);
    procedure Setpsoriase(const Value: Variant);
    procedure Setpsoriase_pe(const Value: Variant);
    procedure Setpulsos(const Value: Variant);
    procedure Setquantidade_terminais(const Value: Variant);
    procedure Setrazao_cli(const Value: Variant);
    procedure Setreducao_icms(const Value: Variant);
    procedure Setreduzir_base_icms(const Value: Variant);
    procedure Setreferencia1_cli(const Value: Variant);
    procedure Setreferencia2_cli(const Value: Variant);
    procedure Setreferencia3_cli(const Value: Variant);
    procedure Setregiao_id(const Value: Variant);
    procedure Setregime_trabalho(const Value: Variant);
    procedure Setrenda_cli(const Value: Variant);
    procedure Setrenda_trabalho_anterior(const Value: Variant);
    procedure Setrevendedor(const Value: Variant);
    procedure Setrg_aval(const Value: Variant);
    procedure Setrgcon_cli(const Value: Variant);
    procedure Setsacador_avalista_id(const Value: Variant);
    procedure Setsalariocon_cli(const Value: Variant);
    procedure Setsenha(const Value: Variant);
    procedure Setseprocado_cli(const Value: Variant);
    procedure Setsexo_cli(const Value: Variant);
    procedure Setsexo_dependente(const Value: Variant);
    procedure Setsexo_dependente2(const Value: Variant);
    procedure Setsexo_dependente3(const Value: Variant);
    procedure Setsexo_dependente4(const Value: Variant);
    procedure Setsexo_dependente5(const Value: Variant);
    procedure Setsexo_dependente6(const Value: Variant);
    procedure Setstatus(const Value: Variant);
    procedure Setstatus_carta(const Value: Variant);
    procedure Setstatus_implantacao(const Value: Variant);
    procedure Setsub_atividade_id(const Value: Variant);
    procedure Setsuframa(const Value: Variant);
    procedure Setsystime(const Value: Variant);
    procedure Settabagismo(const Value: Variant);
    procedure Settela(const Value: Variant);
    procedure Settelefone_aval_cli(const Value: Variant);
    procedure Settelefone_cli(const Value: Variant);
    procedure Settelefone_cobranca(const Value: Variant);
    procedure Settelefone_conjuge(const Value: Variant);
    procedure Settelefone_internacional(const Value: Variant);
    procedure Settelefone_mae(const Value: Variant);
    procedure Settelefone_pai(const Value: Variant);
    procedure Settelefone_trabalho_anterior(const Value: Variant);
    procedure Settempo_residencia(const Value: Variant);
    procedure Settempo_servico(const Value: Variant);
    procedure Settinea_pedis(const Value: Variant);
    procedure Settipo_apuracao(const Value: Variant);
    procedure Settipo_cli(const Value: Variant);
    procedure Settipo_emissao_nfe(const Value: Variant);
    procedure Settipo_residencia(const Value: Variant);
    procedure Settipo_saida(const Value: Variant);
    procedure Settipo_suframa(const Value: Variant);
    procedure Settitular_conta_cb(const Value: Variant);
    procedure Settrabalho_admissao(const Value: Variant);
    procedure Settrabalho_anterior_admissao(const Value: Variant);
    procedure Settransportadora_id(const Value: Variant);
    procedure Settratamento_medicamento(const Value: Variant);
    procedure Setuf_cli(const Value: Variant);
    procedure Setuf_entrega(const Value: Variant);
    procedure Setufcobranca_cli(const Value: Variant);
    procedure Setuftrabalho_cli(const Value: Variant);
    procedure Setultima_compra(const Value: Variant);
    procedure Setungueal(const Value: Variant);
    procedure Setunidade_consumidora_cb(const Value: Variant);
    procedure Seturl_cli(const Value: Variant);
    procedure Setusa_cte(const Value: Variant);
    procedure Setusa_mdfe(const Value: Variant);
    procedure Setusa_nfce(const Value: Variant);
    procedure Setusa_nfe(const Value: Variant);
    procedure Setusa_nfse(const Value: Variant);
    procedure Setusar_controle_kg(const Value: Variant);
    procedure Setusar_desconto_produto(const Value: Variant);
    procedure Setusuario_cli(const Value: Variant);
    procedure Setvalor_aluguel(const Value: Variant);
    procedure Setvaucher(const Value: Variant);
    procedure Setzemopay(const Value: Variant);
    procedure Setzemopay_banco_id(const Value: Variant);
    procedure Setzemopay_id(const Value: Variant);
    procedure Setzemopay_taxa_id(const Value: Variant);
    procedure Setuf_naturalidade_cli(const Value: Variant);
    procedure Setescolaridade_cli(const Value: Variant);
    procedure Setfonte_beneficio_cli(const Value: Variant);
    procedure Setnumbeneficio_cli(const Value: Variant);
    procedure Settipo_funcionario_publico_cli(const Value: Variant);
    procedure Setcodigo_ocupacao_cli(const Value: Variant);
    procedure Setdocidentificacaoconj_cli(const Value: Variant);
    procedure Settipodocidentificacaoconj_cli(const Value: Variant);
    procedure Settipodoc_cli(const Value: variant);
    procedure Setcnpj_trabalho_cli(const Value: Variant);
    procedure Setcpf_conjuge_cli(const Value: Variant);
    procedure Setnome_contador_cli(const Value: Variant);
    procedure Settelefone_contador_cli(const Value: Variant);
    procedure SetCamposInvalidos(const Value: TStringlist);
  protected
    procedure doCreate; override;
    procedure doDestroy; override;
  public
    property codigo_cli: Variant read Fcodigo_cli write Setcodigo_cli;
    property fantasia_cli: Variant read Ffantasia_cli write Setfantasia_cli;
    property razao_cli: Variant read Frazao_cli write Setrazao_cli;
    property cnpj_cpf_cli: Variant read Fcnpj_cpf_cli write Setcnpj_cpf_cli;
    property inscricao_rg_cli: Variant read Finscricao_rg_cli write Setinscricao_rg_cli;
    property endereco_cli: Variant read Fendereco_cli write Setendereco_cli;
    property endereco: Variant read Fendereco write Setendereco;
    property bairro_cli: Variant read Fbairro_cli write Setbairro_cli;
    property cidade_cli: Variant read Fcidade_cli write Setcidade_cli;
    property uf_cli: Variant read Fuf_cli write Setuf_cli;
    property cep_cli: Variant read Fcep_cli write Setcep_cli;
    property telefone_cli: Variant read Ftelefone_cli write Settelefone_cli;
    property fax_cli: Variant read Ffax_cli write Setfax_cli;
    property email_cli: Variant read Femail_cli write Setemail_cli;
    property url_cli: Variant read Furl_cli write Seturl_cli;
    property tipo_cli: Variant read Ftipo_cli write Settipo_cli;
    property atividade_cli: Variant read Fatividade_cli write Setatividade_cli;
    property endcobranca_cli: Variant read Fendcobranca_cli write Setendcobranca_cli;
    property baircobranca_cli: Variant read Fbaircobranca_cli write Setbaircobranca_cli;
    property cidcobranca_cli: Variant read Fcidcobranca_cli write Setcidcobranca_cli;
    property ufcobranca_cli: Variant read Fufcobranca_cli write Setufcobranca_cli;
    property cepcobranca_cli: Variant read Fcepcobranca_cli write Setcepcobranca_cli;
    property localtrabalho_cli: Variant read Flocaltrabalho_cli write Setlocaltrabalho_cli;
    property endtrabalho_cli: Variant read Fendtrabalho_cli write Setendtrabalho_cli;
    property bairtrabalho_cli: Variant read Fbairtrabalho_cli write Setbairtrabalho_cli;
    property cidtrabalho_cli: Variant read Fcidtrabalho_cli write Setcidtrabalho_cli;
    property uftrabalho_cli: Variant read Fuftrabalho_cli write Setuftrabalho_cli;
    property ceptrabalho_cli: Variant read Fceptrabalho_cli write Setceptrabalho_cli;
    property fonetrabalho_cli: Variant read Ffonetrabalho_cli write Setfonetrabalho_cli;
    property funcaotrabalho_cli: Variant read Ffuncaotrabalho_cli write Setfuncaotrabalho_cli;
    property referencia2_cli: Variant read Freferencia2_cli write Setreferencia2_cli;
    property foneref2_cli: Variant read Ffoneref2_cli write Setfoneref2_cli;
    property referencia3_cli: Variant read Freferencia3_cli write Setreferencia3_cli;
    property foneref3_cli: Variant read Ffoneref3_cli write Setfoneref3_cli;
    property seprocado_cli: Variant read Fseprocado_cli write Setseprocado_cli;
    property referencia1_cli: Variant read Freferencia1_cli write Setreferencia1_cli;
    property foneref1_cli: Variant read Ffoneref1_cli write Setfoneref1_cli;
    property cadastro_cli: Variant read Fcadastro_cli write Setcadastro_cli;
    property nascimento_cli: Variant read Fnascimento_cli write Setnascimento_cli;
    property celular_cli: Variant read Fcelular_cli write Setcelular_cli;
    property pai_cli: Variant read Fpai_cli write Setpai_cli;
    property mae_cli: Variant read Fmae_cli write Setmae_cli;
    property contato_cli: Variant read Fcontato_cli write Setcontato_cli;
    property observacao_cli: Variant read Fobservacao_cli write Setobservacao_cli;
    property banco_cli: Variant read Fbanco_cli write Setbanco_cli;
    property agencia_cli: Variant read Fagencia_cli write Setagencia_cli;
    property conta_cli: Variant read Fconta_cli write Setconta_cli;
    property renda_cli: Variant read Frenda_cli write Setrenda_cli;
    property foneagencia_cli: Variant read Ffoneagencia_cli write Setfoneagencia_cli;
    property contatoagencia_cli: Variant read Fcontatoagencia_cli write Setcontatoagencia_cli;
    property codigo_ven: Variant read Fcodigo_ven write Setcodigo_ven;
    property usuario_cli: Variant read Fusuario_cli write Setusuario_cli;
    property estadocivil_cli: Variant read Festadocivil_cli write Setestadocivil_cli;
    property nomecon_cli: Variant read Fnomecon_cli write Setnomecon_cli;
    property cpfcon_cli: Variant read Fcpfcon_cli write Setcpfcon_cli;
    property rgcon_cli: Variant read Frgcon_cli write Setrgcon_cli;
    property profcon_cli: Variant read Fprofcon_cli write Setprofcon_cli;
    property salariocon_cli: Variant read Fsalariocon_cli write Setsalariocon_cli;
    property convenio_cli: Variant read Fconvenio_cli write Setconvenio_cli;
    property convenio_cod: Variant read Fconvenio_cod write Setconvenio_cod;
    property carta_cli: Variant read Fcarta_cli write Setcarta_cli;
    property expedicao_rg: Variant read Fexpedicao_rg write Setexpedicao_rg;
    property naturalidade_cli: Variant read Fnaturalidade_cli write Setnaturalidade_cli;
    property uf_naturalidade_cli: Variant read Fuf_naturalidade_cli write Setuf_naturalidade_cli;
    property escolaridade_cli: Variant read Fescolaridade_cli write Setescolaridade_cli;
    property tempo_servico: Variant read Ftempo_servico write Settempo_servico;
    property beneficio_cli: Variant read Fbeneficio_cli write Setbeneficio_cli;
    property descricao: Variant read Fdescricao write Setdescricao;
    property reduzir_base_icms: Variant read Freduzir_base_icms write Setreduzir_base_icms;
    property isento_icms: Variant read Fisento_icms write Setisento_icms;
    property loja: Variant read Floja write Setloja;
    property data_alteracao: Variant read Fdata_alteracao write Setdata_alteracao;
    property limite_compra: Variant read Flimite_compra write Setlimite_compra;
    property tipo_saida: Variant read Ftipo_saida write Settipo_saida;
    property cod_municipio: Variant read Fcod_municipio write Setcod_municipio;
    property ultima_compra: Variant read Fultima_compra write Setultima_compra;
    property status: Variant read Fstatus write Setstatus;
    property portador: Variant read Fportador write Setportador;
    property sexo_cli: Variant read Fsexo_cli write Setsexo_cli;
    property classif_cli: Variant read Fclassif_cli write Setclassif_cli;
    property data_retorno: Variant read Fdata_retorno write Setdata_retorno;
    property hora_retorno: Variant read Fhora_retorno write Sethora_retorno;
    property avalista_cli: Variant read Favalista_cli write Setavalista_cli;
    property cnpj_cpf_aval_cli: Variant read Fcnpj_cpf_aval_cli write Setcnpj_cpf_aval_cli;
    property bairro_aval_cli: Variant read Fbairro_aval_cli write Setbairro_aval_cli;
    property cidade_aval_cli: Variant read Fcidade_aval_cli write Setcidade_aval_cli;
    property telefone_aval_cli: Variant read Ftelefone_aval_cli write Settelefone_aval_cli;
    property celular_aval_cli: Variant read Fcelular_aval_cli write Setcelular_aval_cli;
    property endereco_aval_cli: Variant read Fendereco_aval_cli write Setendereco_aval_cli;
    property isento_ipi: Variant read Fisento_ipi write Setisento_ipi;
    property revendedor: Variant read Frevendedor write Setrevendedor;
    property credito_cli: Variant read Fcredito_cli write Setcredito_cli;
    property fone_com_aval: Variant read Ffone_com_aval write Setfone_com_aval;
    property rg_aval: Variant read Frg_aval write Setrg_aval;
    property mae_aval: Variant read Fmae_aval write Setmae_aval;
    property data_nasc_aval: Variant read Fdata_nasc_aval write Setdata_nasc_aval;
    property unidade_consumidora_cb: Variant read Funidade_consumidora_cb write Setunidade_consumidora_cb;
    property codigo_concessionaria_cb: Variant read Fcodigo_concessionaria_cb write Setcodigo_concessionaria_cb;
    property codigo_vendedor_cb: Variant read Fcodigo_vendedor_cb write Setcodigo_vendedor_cb;
    property titular_conta_cb: Variant read Ftitular_conta_cb write Settitular_conta_cb;
    property data_faturamento_cb: Variant read Fdata_faturamento_cb write Setdata_faturamento_cb;
    property data_vencimento_cb: Variant read Fdata_vencimento_cb write Setdata_vencimento_cb;
    property celular_cli2: Variant read Fcelular_cli2 write Setcelular_cli2;
    property operadora_celular: Variant read Foperadora_celular write Setoperadora_celular;
    property data_nasc_conjugue: Variant read Fdata_nasc_conjugue write Setdata_nasc_conjugue;
    property email2: Variant read Femail2 write Setemail2;
    property descricao_reparcelamento: Variant read Fdescricao_reparcelamento write Setdescricao_reparcelamento;
    property id: Variant read Fid write Setid;
    property dependente: Variant read Fdependente write Setdependente;
    property nascimento_dependente: Variant read Fnascimento_dependente write Setnascimento_dependente;
    property sexo_dependente: Variant read Fsexo_dependente write Setsexo_dependente;
    property dependente2: Variant read Fdependente2 write Setdependente2;
    property nascimento_dependente2: Variant read Fnascimento_dependente2 write Setnascimento_dependente2;
    property sexo_dependente2: Variant read Fsexo_dependente2 write Setsexo_dependente2;
    property dependente3: Variant read Fdependente3 write Setdependente3;
    property nascimento_dependente3: Variant read Fnascimento_dependente3 write Setnascimento_dependente3;
    property sexo_dependente3: Variant read Fsexo_dependente3 write Setsexo_dependente3;
    property observacao_ped_orc: Variant read Fobservacao_ped_orc write Setobservacao_ped_orc;
    property preco_id: Variant read Fpreco_id write Setpreco_id;
    property suframa: Variant read Fsuframa write Setsuframa;
    property complemento: Variant read Fcomplemento write Setcomplemento;
    property numero_end: Variant read Fnumero_end write Setnumero_end;
    property atividade_id: Variant read Fatividade_id write Setatividade_id;
    property pais_id: Variant read Fpais_id write Setpais_id;
    property regiao_id: Variant read Fregiao_id write Setregiao_id;
    property cfop_id: Variant read Fcfop_id write Setcfop_id;
    property tipo_suframa: Variant read Ftipo_suframa write Settipo_suframa;
    property tipo_apuracao: Variant read Ftipo_apuracao write Settipo_apuracao;
    property condicoes_pagamento: Variant read Fcondicoes_pagamento write Setcondicoes_pagamento;
    property consumidor_final: Variant read Fconsumidor_final write Setconsumidor_final;
    property nfe: Variant read Fnfe write Setnfe;
    property carga_tributaria: Variant read Fcarga_tributaria write Setcarga_tributaria;
    property desconto_financeiro: Variant read Fdesconto_financeiro write Setdesconto_financeiro;
    property quantidade_terminais: Variant read Fquantidade_terminais write Setquantidade_terminais;
    property telefone_internacional: Variant read Ftelefone_internacional write Settelefone_internacional;
    property cnae: Variant read Fcnae write Setcnae;
    property endereco_entrega: Variant read Fendereco_entrega write Setendereco_entrega;
    property bairro_entrega: Variant read Fbairro_entrega write Setbairro_entrega;
    property cidade_entrega: Variant read Fcidade_entrega write Setcidade_entrega;
    property uf_entrega: Variant read Fuf_entrega write Setuf_entrega;
    property cep_entrega: Variant read Fcep_entrega write Setcep_entrega;
    property status_carta: Variant read Fstatus_carta write Setstatus_carta;
    property email_cobranca: Variant read Femail_cobranca write Setemail_cobranca;
    property contato_cobranca: Variant read Fcontato_cobranca write Setcontato_cobranca;
    property telefone_cobranca: Variant read Ftelefone_cobranca write Settelefone_cobranca;
    property celular_cobrnaca: Variant read Fcelular_cobrnaca write Setcelular_cobrnaca;
    property observacao_cobranca: Variant read Fobservacao_cobranca write Setobservacao_cobranca;
    property complemento_cobranca: Variant read Fcomplemento_cobranca write Setcomplemento_cobranca;
    property observacao_nfe: Variant read Fobservacao_nfe write Setobservacao_nfe;
    property desconto_nf: Variant read Fdesconto_nf write Setdesconto_nf;
    property obs_geral: Variant read Fobs_geral write Setobs_geral;
    property systime: Variant read Fsystime write Setsystime;
    property tela: Variant read Ftela write Settela;
    property limite_sms: Variant read Flimite_sms write Setlimite_sms;
    property telefone_pai: Variant read Ftelefone_pai write Settelefone_pai;
    property telefone_mae: Variant read Ftelefone_mae write Settelefone_mae;
    property telefone_conjuge: Variant read Ftelefone_conjuge write Settelefone_conjuge;
    property multa: Variant read Fmulta write Setmulta;
    property juros_bol: Variant read Fjuros_bol write Setjuros_bol;
    property indice_juros_id: Variant read Findice_juros_id write Setindice_juros_id;
    property ctb: Variant read Fctb write Setctb;
    property banco_id: Variant read Fbanco_id write Setbanco_id;
    property instrucao_boleto: Variant read Finstrucao_boleto write Setinstrucao_boleto;
    property dependente4: Variant read Fdependente4 write Setdependente4;
    property nascimento_dependente4: Variant read Fnascimento_dependente4 write Setnascimento_dependente4;
    property sexo_dependente4: Variant read Fsexo_dependente4 write Setsexo_dependente4;
    property dependente5: Variant read Fdependente5 write Setdependente5;
    property nascimento_dependente5: Variant read Fnascimento_dependente5 write Setnascimento_dependente5;
    property sexo_dependente5: Variant read Fsexo_dependente5 write Setsexo_dependente5;
    property dependente6: Variant read Fdependente6 write Setdependente6;
    property nascimento_dependente6: Variant read Fnascimento_dependente6 write Setnascimento_dependente6;
    property sexo_dependente6: Variant read Fsexo_dependente6 write Setsexo_dependente6;
    property isento_st: Variant read Fisento_st write Setisento_st;
    property frete: Variant read Ffrete write Setfrete;
    property prospeccao_id: Variant read Fprospeccao_id write Setprospeccao_id;
    property desc_financeiro: Variant read Fdesc_financeiro write Setdesc_financeiro;
    property imagem: Variant read Fimagem write Setimagem;
    property pratica_esporte: Variant read Fpratica_esporte write Setpratica_esporte;
    property frequencia: Variant read Ffrequencia write Setfrequencia;
    property destro_canhoto: Variant read Fdestro_canhoto write Setdestro_canhoto;
    property numero_calcado: Variant read Fnumero_calcado write Setnumero_calcado;
    property calcado_mais_usado: Variant read Fcalcado_mais_usado write Setcalcado_mais_usado;
    property material: Variant read Fmaterial write Setmaterial;
    property cirurgia_mmii: Variant read Fcirurgia_mmii write Setcirurgia_mmii;
    property tratamento_medicamento: Variant read Ftratamento_medicamento write Settratamento_medicamento;
    property alergico: Variant read Falergico write Setalergico;
    property alergico_obs: Variant read Falergico_obs write Setalergico_obs;
    property patologia: Variant read Fpatologia write Setpatologia;
    property patologia_obs: Variant read Fpatologia_obs write Setpatologia_obs;
    property diabetes: Variant read Fdiabetes write Setdiabetes;
    property diabetes_familiares: Variant read Fdiabetes_familiares write Setdiabetes_familiares;
    property etilista: Variant read Fetilista write Setetilista;
    property cardiopatias: Variant read Fcardiopatias write Setcardiopatias;
    property tabagismo: Variant read Ftabagismo write Settabagismo;
    property dst: Variant read Fdst write Setdst;
    property pressao: Variant read Fpressao write Setpressao;
    property gravidez: Variant read Fgravidez write Setgravidez;
    property outras_patologias: Variant read Foutras_patologias write Setoutras_patologias;
    property motivo_visita: Variant read Fmotivo_visita write Setmotivo_visita;
    property formato_unha: Variant read Fformato_unha write Setformato_unha;
    property onicotrofia: Variant read Fonicotrofia write Setonicotrofia;
    property onicorrexe: Variant read Fonicorrexe write Setonicorrexe;
    property onicogrifose: Variant read Fonicogrifose write Setonicogrifose;
    property onicolise: Variant read Fonicolise write Setonicolise;
    property onicomicose: Variant read Fonicomicose write Setonicomicose;
    property psoriase: Variant read Fpsoriase write Setpsoriase;
    property onicocriptose: Variant read Fonicocriptose write Setonicocriptose;
    property granulada: Variant read Fgranulada write Setgranulada;
    property alteracao_cor: Variant read Falteracao_cor write Setalteracao_cor;
    property onicofose: Variant read Fonicofose write Setonicofose;
    property exostose_subungueal: Variant read Fexostose_subungueal write Setexostose_subungueal;
    property ungueal: Variant read Fungueal write Setungueal;
    property outras_alteracao_laminas: Variant read Foutras_alteracao_laminas write Setoutras_alteracao_laminas;
    property bromidrose: Variant read Fbromidrose write Setbromidrose;
    property anidrose: Variant read Fanidrose write Setanidrose;
    property hiperhidrose: Variant read Fhiperhidrose write Sethiperhidrose;
    property isquemica: Variant read Fisquemica write Setisquemica;
    property frieira: Variant read Ffrieira write Setfrieira;
    property tinea_pedis: Variant read Ftinea_pedis write Settinea_pedis;
    property neuropatica: Variant read Fneuropatica write Setneuropatica;
    property fissuras: Variant read Ffissuras write Setfissuras;
    property disidrose: Variant read Fdisidrose write Setdisidrose;
    property mal_perfurante: Variant read Fmal_perfurante write Setmal_perfurante;
    property psoriase_pe: Variant read Fpsoriase_pe write Setpsoriase_pe;
    property alteracao_pele: Variant read Falteracao_pele write Setalteracao_pele;
    property halux_valgus: Variant read Fhalux_valgus write Sethalux_valgus;
    property halux_rigidus: Variant read Fhalux_rigidus write Sethalux_rigidus;
    property esporao_calcaneo: Variant read Fesporao_calcaneo write Setesporao_calcaneo;
    property pe_cavo: Variant read Fpe_cavo write Setpe_cavo;
    property pe_plano: Variant read Fpe_plano write Setpe_plano;
    property dedos_garra: Variant read Fdedos_garra write Setdedos_garra;
    property podactilia: Variant read Fpodactilia write Setpodactilia;
    property alteracao_ortopedicas: Variant read Falteracao_ortopedicas write Setalteracao_ortopedicas;
    property indicacao: Variant read Findicacao write Setindicacao;
    property monofilamento: Variant read Fmonofilamento write Setmonofilamento;
    property diapasao: Variant read Fdiapasao write Setdiapasao;
    property digitapressao: Variant read Fdigitapressao write Setdigitapressao;
    property pulsos: Variant read Fpulsos write Setpulsos;
    property perfusao_d: Variant read Fperfusao_d write Setperfusao_d;
    property perfusao_e: Variant read Fperfusao_e write Setperfusao_e;
    property usa_nfe: Variant read Fusa_nfe write Setusa_nfe;
    property usa_nfce: Variant read Fusa_nfce write Setusa_nfce;
    property usa_mdfe: Variant read Fusa_mdfe write Setusa_mdfe;
    property usa_cte: Variant read Fusa_cte write Setusa_cte;
    property usa_nfse: Variant read Fusa_nfse write Setusa_nfse;
    property usar_controle_kg: Variant read Fusar_controle_kg write Setusar_controle_kg;
    property complemento_entrega: Variant read Fcomplemento_entrega write Setcomplemento_entrega;
    property numero_entrega: Variant read Fnumero_entrega write Setnumero_entrega;
    property cod_municipio_entrega: Variant read Fcod_municipio_entrega write Setcod_municipio_entrega;
    property ex_codigo_postal: Variant read Fex_codigo_postal write Setex_codigo_postal;
    property ex_estado: Variant read Fex_estado write Setex_estado;
    property parcela_maxima: Variant read Fparcela_maxima write Setparcela_maxima;
    property transportadora_id: Variant read Ftransportadora_id write Settransportadora_id;
    property comissao: Variant read Fcomissao write Setcomissao;
    property dia_vencimento: Variant read Fdia_vencimento write Setdia_vencimento;
    property listar_rad: Variant read Flistar_rad write Setlistar_rad;
    property contador_id: Variant read Fcontador_id write Setcontador_id;
    property vaucher: Variant read Fvaucher write Setvaucher;
    property matriz_cliente_id: Variant read Fmatriz_cliente_id write Setmatriz_cliente_id;
    property inscricao_municipal: Variant read Finscricao_municipal write Setinscricao_municipal;
    property envia_sms: Variant read Fenvia_sms write Setenvia_sms;
    property valor_aluguel: Variant read Fvalor_aluguel write Setvalor_aluguel;
    property tempo_residencia: Variant read Ftempo_residencia write Settempo_residencia;
    property tipo_residencia: Variant read Ftipo_residencia write Settipo_residencia;
    property parentesco_ref1: Variant read Fparentesco_ref1 write Setparentesco_ref1;
    property parentesco_ref2: Variant read Fparentesco_ref2 write Setparentesco_ref2;
    property trabalho_admissao: Variant read Ftrabalho_admissao write Settrabalho_admissao;
    property trabalho_anterior_admissao: Variant read Ftrabalho_anterior_admissao write Settrabalho_anterior_admissao;
    property nome_trabalho_anterior: Variant read Fnome_trabalho_anterior write Setnome_trabalho_anterior;
    property telefone_trabalho_anterior: Variant read Ftelefone_trabalho_anterior write Settelefone_trabalho_anterior;
    property funcao_trabalho_anterior: Variant read Ffuncao_trabalho_anterior write Setfuncao_trabalho_anterior;
    property renda_trabalho_anterior: Variant read Frenda_trabalho_anterior write Setrenda_trabalho_anterior;
    property regime_trabalho: Variant read Fregime_trabalho write Setregime_trabalho;
    property confirm_endereco: Variant read Fconfirm_endereco write Setconfirm_endereco;
    property confirm_endereco_anterior: Variant read Fconfirm_endereco_anterior write Setconfirm_endereco_anterior;
    property confirm_trabalho: Variant read Fconfirm_trabalho write Setconfirm_trabalho;
    property confirm_trabalho_conjuge: Variant read Fconfirm_trabalho_conjuge write Setconfirm_trabalho_conjuge;
    property desconto_bol: Variant read Fdesconto_bol write Setdesconto_bol;
    property produto_tipo_id: Variant read Fproduto_tipo_id write Setproduto_tipo_id;
    property pedido_minimo: Variant read Fpedido_minimo write Setpedido_minimo;
    property reducao_icms: Variant read Freducao_icms write Setreducao_icms;
    property abatimento_bol: Variant read Fabatimento_bol write Setabatimento_bol;
    property usar_desconto_produto: Variant read Fusar_desconto_produto write Setusar_desconto_produto;
    property codigo_anterior: Variant read Fcodigo_anterior write Setcodigo_anterior;
    property senha: Variant read Fsenha write Setsenha;
    property ocupacao_id: Variant read Focupacao_id write Setocupacao_id;
    property sub_atividade_id: Variant read Fsub_atividade_id write Setsub_atividade_id;
    property zemopay: Variant read Fzemopay write Setzemopay;
    property zemopay_taxa_id: Variant read Fzemopay_taxa_id write Setzemopay_taxa_id;
    property zemopay_id: Variant read Fzemopay_id write Setzemopay_id;
    property zemopay_banco_id: Variant read Fzemopay_banco_id write Setzemopay_banco_id;
    property data_inatividade: Variant read Fdata_inatividade write Setdata_inatividade;
    property importacao_dados: Variant read Fimportacao_dados write Setimportacao_dados;
    property observacao_implantacao: Variant read Fobservacao_implantacao write Setobservacao_implantacao;
    property status_implantacao: Variant read Fstatus_implantacao write Setstatus_implantacao;
    property nao_contribuinte: Variant read Fnao_contribuinte write Setnao_contribuinte;
    property grupo_economico_id: Variant read Fgrupo_economico_id write Setgrupo_economico_id;
    property aceite_bol: Variant read Faceite_bol write Setaceite_bol;
    property bloquear_alteracao_tabela: Variant read Fbloquear_alteracao_tabela write Setbloquear_alteracao_tabela;
    property tipo_emissao_nfe: Variant read Ftipo_emissao_nfe write Settipo_emissao_nfe;
    property percentual_desconto: Variant read Fpercentual_desconto write Setpercentual_desconto;
    property sacador_avalista_id: Variant read Fsacador_avalista_id write Setsacador_avalista_id;
    property tipodoc_cli: variant read Ftipodoc_cli write Settipodoc_cli;
    property tipo_funcionario_publico_cli: Variant read Ftipo_funcionario_publico_cli write Settipo_funcionario_publico_cli;
    property numbeneficio_cli: Variant read Fnumbeneficio_cli write Setnumbeneficio_cli;
    property fonte_beneficio_cli: Variant read Ffonte_beneficio_cli write Setfonte_beneficio_cli;
    property codigo_ocupacao_cli: Variant read Fcodigo_ocupacao_cli write Setcodigo_ocupacao_cli;
    property docidentificacaoconj_cli: Variant read Fdocidentificacaoconj_cli write Setdocidentificacaoconj_cli;
    property tipodocidentificacaoconj_cli: Variant read Ftipodocidentificacaoconj_cli write Settipodocidentificacaoconj_cli;
    property cnpj_trabalho_cli: Variant read Fcnpj_trabalho_cli write Setcnpj_trabalho_cli;
    property cpf_conjuge_cli: Variant read Fcpf_conjuge_cli write Setcpf_conjuge_cli;
    property nome_contador_cli: Variant read Fnome_contador_cli write Setnome_contador_cli;
    property telefone_contador_cli: Variant read Ftelefone_contador_cli write Settelefone_contador_cli;

    constructor Create(pIConexao: IConexao); override;
    destructor Destroy; override;

    function Incluir  : String;
    function Salvar   : String;
    function Alterar(pID : String): TClienteModel;
    function Excluir(pID : String): String;

    procedure obterLista;

    function carregaClasse(pId: String): TClienteModel;
    function ufCliente(pId: String): Variant;
    function nomeCliente(pId: String): Variant;
    function comissaoCliente(pId: String): Variant;
    function diasAtraso(pCodigoCliente: String): Variant;

    function obterListaConsulta: IFDDataset;
    function ObterListaMemTable: IFDDataset;
    function ObterBairros: IFDDataset;
    procedure bloquearCNPJCPF(pCliente, pCNPJCPF: String);
    procedure camposObrigatorios(pTag: String; pClienteModel : TClienteModel);

    property ClientesLista: IList<TClienteModel> read FClientesLista write SetClientesLista;

   	property Acao :TAcao read FAcao write SetAcao;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;
    property CamposInvalidos: TStringlist read FCamposInvalidos write SetCamposInvalidos;
  end;

implementation

uses
  ClienteDao,
  System.SysUtils,
  Terasoft.Utils,
  System.Rtti,
  Terasoft.Configuracoes;

{ TClienteModel }

procedure TClienteModel.camposObrigatorios(pTag: String; pClienteModel : TClienteModel);
var
  i        : Integer;
  lValor   : String;
  lCampo   : String;
  lNome    : String;
  lMsg     : String;
  lField   : TStringList;
  lCtx     : TRttiContext;
  lProp    : TRttiProperty;
  lConfiguracoes : TerasoftConfiguracoes;
begin
  CamposInvalidos := TStringList.Create;
  lConfiguracoes := vIConexao.getTerasoftConfiguracoes as TerasoftConfiguracoes;
  lMsg   := '';
  lValor := lConfiguracoes.valorTag(pTag, '', tvMemo);
  if Trim(lValor) = '' then
    exit;
  lField      := TStringList.Create;
  lField.Text := lValor;
  lCtx := TRttiContext.Create;
  for i := 0 to lField.Count - 1 do
  begin
    lCampo := Trim(Copy(lField.Strings[i], 1, (Pos(';', lField.Strings[i])) - 1));
    lNome  := Trim(Copy(lField.Strings[i], (Pos(';', lField.Strings[i])) + 1, 60));
    lProp  := lCtx.GetType(TClienteModel).GetProperty(lCampo);
    if not Assigned(lProp) then
    begin
      CriaException(' Configurações de campos obrigatórios inválido.');
      abort;
    end;
    if lProp.GetValue(pClienteModel).AsString = '' then
    begin
      CamposInvalidos.Add(lCampo);
      lMsg := lMsg + lNome + ',';
    end;
  end;
//  if Trim(lMsg) <> '' then
//  begin
//    CriaException(' Campo(s) obrigatório(s): ' + copy(lMsg, 1, Length(lMsg) -1) + '.');
//    abort;
//  end;
end;

function TClienteModel.Incluir: String;
begin
  self.Fdata_alteracao := DateToStr(vIConexao.DataServer);
  self.Floja           := vIConexao.getEmpresa.LOJA;

  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TClienteModel.Excluir(pID: String): String;
begin
  self.CODIGO_CLI := pID;
  self.Acao       := tacExcluir;
  Result          := self.Salvar;
end;

function TClienteModel.Alterar(pID: String): TClienteModel;
var
  lClienteModel : TClienteModel;
begin
  lClienteModel := TClienteModel.Create(vIConexao);
  try
    lClienteModel       := lClienteModel.carregaClasse(pID);
    lClienteModel.Acao  := tacAlterar;
    Result              := lClienteModel;
  finally
  end;
end;

function TClienteModel.carregaClasse(pId: String): TClienteModel;
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create(vIConexao);
  try
    Result := lClienteDao.carregaClasse(pId);
  finally
    lClienteDao.Free;
  end;
end;

function TClienteModel.comissaoCliente(pId: String): Variant;
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create(vIConexao);
  try
    Result    := lClienteDao.comissaoCliente(pId);
  finally
    lClienteDao.Free;
  end;
end;

constructor TClienteModel.Create(pIConexao : IConexao);
begin
  inherited;
end;

destructor TClienteModel.Destroy;
begin
  inherited;
end;

function TClienteModel.diasAtraso(pCodigoCliente: String): Variant;
var
  lClienteDao: TClienteDao;
  lDataVencimento: TDate;
begin
  lClienteDao := TClienteDao.Create(vIConexao);

  if pCodigoCliente = '000000' then
    exit;

  try
    lDataVencimento := lClienteDao.diasAtraso(pCodigoCliente);

    if vIConexao.DataServer <= lDataVencimento then
    begin
      Result := 0;
      exit;
    end;

    Result := FormatFloat('####0', (vIConexao.DataServer - lDataVencimento) );
  finally
    lClienteDao.Free;
  end;
end;

procedure TClienteModel.doCreate;
begin
  inherited;
  fModelName := 'CLIENTES';
end;

procedure TClienteModel.doDestroy;
begin
  FClientesLista := nil;
  inherited;
end;

function TClienteModel.nomeCliente(pId: String): Variant;
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create(vIConexao);
  try
    Result    := lClienteDao.nomeCliente(pId);
  finally
    lClienteDao.Free;
  end;
end;

procedure TClienteModel.obterLista;
var
  lClienteLista: TClienteDao;
begin
  lClienteLista := TClienteDao.Create(vIConexao);
  try
    lClienteLista.TotalRecords    := FTotalRecords;
    lClienteLista.WhereView       := FWhereView;
    lClienteLista.CountView       := FCountView;
    lClienteLista.OrderView       := FOrderView;
    lClienteLista.StartRecordView := FStartRecordView;
    lClienteLista.LengthPageView  := FLengthPageView;
    lClienteLista.IDRecordView    := FIDRecordView;
    lClienteLista.obterLista;
    FTotalRecords                 := lClienteLista.TotalRecords;
    FClientesLista                := lClienteLista.ClientesLista;
  finally
    lClienteLista.Free;
  end;
end;

function TClienteModel.obterListaConsulta: IFDDataset;
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create(vIConexao);
  try
    lClienteDao.TotalRecords      := FTotalRecords;
    lClienteDao.WhereView         := FWhereView;
    lClienteDao.CountView         := FCountView;
    lClienteDao.OrderView         := FOrderView;
    lClienteDao.StartRecordView   := FStartRecordView;
    lClienteDao.LengthPageView    := FLengthPageView;
    lClienteDao.IDRecordView      := FIDRecordView;

    Result := lClienteDao.obterListaConsulta;
    FTotalRecords := lClienteDao.TotalRecords;
  finally
    lClienteDao.Free;
  end;
end;

function TClienteModel.ObterListaMemTable: IFDDataset;
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create(vIConexao);

  lClienteDao.TotalRecords      := FTotalRecords;
  lClienteDao.WhereView         := FWhereView;
  lClienteDao.CountView         := FCountView;
  lClienteDao.OrderView         := FOrderView;
  lClienteDao.StartRecordView   := FStartRecordView;
  lClienteDao.LengthPageView    := FLengthPageView;
  lClienteDao.IDRecordView      := FIDRecordView;

  try
    Result := lClienteDao.ObterListaMemTable;
    FTotalRecords := lClienteDao.TotalRecords;
  finally
    lClienteDao.Free;
  end;
end;

function TClienteModel.ObterBairros: IFDDataset;
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create(vIConexao);

  lClienteDao.TotalRecords      := FTotalRecords;
  lClienteDao.WhereView         := FWhereView;
  lClienteDao.CountView         := FCountView;
  lClienteDao.OrderView         := FOrderView;
  lClienteDao.IDRecordView      := FIDRecordView;

  try
    Result := lClienteDao.ObterBairros;
    FTotalRecords := lClienteDao.TotalRecords;
  finally
    lClienteDao.Free;
  end;
end;

procedure TClienteModel.bloquearCNPJCPF(pCliente, pCNPJCPF: String);
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create(vIConexao);
  try
    lClienteDao.bloquearCNPJCPF(pCliente,pCNPJCPF);
  finally
    lClienteDao.Free;
  end;
end;

function TClienteModel.Salvar: String;
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create(vIConexao);
  Result      := '';
  try
    case FAcao of
      Terasoft.Types.tacIncluir: Result := lClienteDao.incluir(Self);
      Terasoft.Types.tacAlterar: Result := lClienteDao.alterar(Self);
      Terasoft.Types.tacExcluir: Result := lClienteDao.excluir(Self);
    end;
  finally
    lClienteDao.Free;
  end;
end;

procedure TClienteModel.Setabatimento_bol(const Value: Variant);
begin
  Fabatimento_bol := Value;
end;

procedure TClienteModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TClienteModel.Setaceite_bol(const Value: Variant);
begin
  Faceite_bol := Value;
end;

procedure TClienteModel.Setagencia_cli(const Value: Variant);
begin
  Fagencia_cli := Value;
end;

procedure TClienteModel.Setalergico(const Value: Variant);
begin
  Falergico := Value;
end;

procedure TClienteModel.Setalergico_obs(const Value: Variant);
begin
  Falergico_obs := Value;
end;

procedure TClienteModel.Setalteracao_cor(const Value: Variant);
begin
  Falteracao_cor := Value;
end;

procedure TClienteModel.Setalteracao_ortopedicas(const Value: Variant);
begin
  Falteracao_ortopedicas := Value;
end;

procedure TClienteModel.Setalteracao_pele(const Value: Variant);
begin
  Falteracao_pele := Value;
end;

procedure TClienteModel.Setanidrose(const Value: Variant);
begin
  Fanidrose := Value;
end;

procedure TClienteModel.Setatividade_cli(const Value: Variant);
begin
  Fatividade_cli := Value;
end;

procedure TClienteModel.Setatividade_id(const Value: Variant);
begin
  Fatividade_id := Value;
end;

procedure TClienteModel.Setavalista_cli(const Value: Variant);
begin
  Favalista_cli := Value;
end;

procedure TClienteModel.Setbaircobranca_cli(const Value: Variant);
begin
  Fbaircobranca_cli := Value;
end;

procedure TClienteModel.Setbairro_aval_cli(const Value: Variant);
begin
  Fbairro_aval_cli := Value;
end;

procedure TClienteModel.Setbairro_cli(const Value: Variant);
begin
  Fbairro_cli := Value;
end;

procedure TClienteModel.Setbairro_entrega(const Value: Variant);
begin
  Fbairro_entrega := Value;
end;

procedure TClienteModel.Setbairtrabalho_cli(const Value: Variant);
begin
  Fbairtrabalho_cli := Value;
end;

procedure TClienteModel.Setbanco_cli(const Value: Variant);
begin
  Fbanco_cli := Value;
end;

procedure TClienteModel.Setbanco_id(const Value: Variant);
begin
  Fbanco_id := Value;
end;

procedure TClienteModel.Setbeneficio_cli(const Value: Variant);
begin
  Fbeneficio_cli := Value;
end;

procedure TClienteModel.Setbloquear_alteracao_tabela(const Value: Variant);
begin
  Fbloquear_alteracao_tabela := Value;
end;

procedure TClienteModel.Setbromidrose(const Value: Variant);
begin
  Fbromidrose := Value;
end;

procedure TClienteModel.Setcadastro_cli(const Value: Variant);
begin
  Fcadastro_cli := Value;
end;

procedure TClienteModel.Setcalcado_mais_usado(const Value: Variant);
begin
  Fcalcado_mais_usado := Value;
end;

procedure TClienteModel.SetCamposInvalidos(const Value: TStringlist);
begin
  FCamposInvalidos := Value;
end;

procedure TClienteModel.Setcardiopatias(const Value: Variant);
begin
  Fcardiopatias := Value;
end;

procedure TClienteModel.Setcarga_tributaria(const Value: Variant);
begin
  Fcarga_tributaria := Value;
end;

procedure TClienteModel.Setcarta_cli(const Value: Variant);
begin
  Fcarta_cli := Value;
end;

procedure TClienteModel.Setcelular_aval_cli(const Value: Variant);
begin
  Fcelular_aval_cli := Value;
end;

procedure TClienteModel.Setcelular_cli(const Value: Variant);
begin
  Fcelular_cli := Value;
end;

procedure TClienteModel.Setcelular_cli2(const Value: Variant);
begin
  Fcelular_cli2 := Value;
end;

procedure TClienteModel.Setcelular_cobrnaca(const Value: Variant);
begin
  Fcelular_cobrnaca := Value;
end;

procedure TClienteModel.Setcepcobranca_cli(const Value: Variant);
begin
  Fcepcobranca_cli := Value;
end;

procedure TClienteModel.Setceptrabalho_cli(const Value: Variant);
begin
  Fceptrabalho_cli := Value;
end;

procedure TClienteModel.Setcep_cli(const Value: Variant);
begin
  Fcep_cli := Value;
end;

procedure TClienteModel.Setcep_entrega(const Value: Variant);
begin
  Fcep_entrega := Value;
end;

procedure TClienteModel.Setcfop_id(const Value: Variant);
begin
  Fcfop_id := Value;
end;

procedure TClienteModel.Setcidade_aval_cli(const Value: Variant);
begin
  Fcidade_aval_cli := Value;
end;

procedure TClienteModel.Setcidade_cli(const Value: Variant);
begin
  Fcidade_cli := Value;
end;

procedure TClienteModel.Setcidade_entrega(const Value: Variant);
begin
  Fcidade_entrega := Value;
end;

procedure TClienteModel.Setcidcobranca_cli(const Value: Variant);
begin
  Fcidcobranca_cli := Value;
end;

procedure TClienteModel.Setcidtrabalho_cli(const Value: Variant);
begin
  Fcidtrabalho_cli := Value;
end;

procedure TClienteModel.Setcirurgia_mmii(const Value: Variant);
begin
  Fcirurgia_mmii := Value;
end;

procedure TClienteModel.Setclassif_cli(const Value: Variant);
begin
  Fclassif_cli := Value;
end;

procedure TClienteModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TClienteModel.Setcpfcon_cli(const Value: Variant);
begin
  Fcpfcon_cli := Value;
end;

procedure TClienteModel.Setcpf_conjuge_cli(const Value: Variant);
begin
  Fcpf_conjuge_cli := Value;
end;

procedure TClienteModel.Setcredito_cli(const Value: Variant);
begin
  Fcredito_cli := Value;
end;

procedure TClienteModel.Setctb(const Value: Variant);
begin
  Fctb := Value;
end;

procedure TClienteModel.Setdata_alteracao(const Value: Variant);
begin
  Fdata_alteracao := Value;
end;

procedure TClienteModel.Setdata_faturamento_cb(const Value: Variant);
begin
  Fdata_faturamento_cb := Value;
end;

procedure TClienteModel.Setdata_inatividade(const Value: Variant);
begin
  Fdata_inatividade := Value;
end;

procedure TClienteModel.Setdata_nasc_aval(const Value: Variant);
begin
  Fdata_nasc_aval := Value;
end;

procedure TClienteModel.Setdata_nasc_conjugue(const Value: Variant);
begin
  Fdata_nasc_conjugue := Value;
end;

procedure TClienteModel.Setdata_retorno(const Value: Variant);
begin
  Fdata_retorno := Value;
end;

procedure TClienteModel.Setdata_vencimento_cb(const Value: Variant);
begin
  Fdata_vencimento_cb := Value;
end;

procedure TClienteModel.Setdedos_garra(const Value: Variant);
begin
  Fdedos_garra := Value;
end;

procedure TClienteModel.Setdependente(const Value: Variant);
begin
  Fdependente := Value;
end;

procedure TClienteModel.Setdependente2(const Value: Variant);
begin
  Fdependente2 := Value;
end;

procedure TClienteModel.Setdependente3(const Value: Variant);
begin
  Fdependente3 := Value;
end;

procedure TClienteModel.Setdependente4(const Value: Variant);
begin
  Fdependente4 := Value;
end;

procedure TClienteModel.Setdependente5(const Value: Variant);
begin
  Fdependente5 := Value;
end;

procedure TClienteModel.Setdependente6(const Value: Variant);
begin
  Fdependente6 := Value;
end;

procedure TClienteModel.Setdesconto_bol(const Value: Variant);
begin
  Fdesconto_bol := Value;
end;

procedure TClienteModel.Setdesconto_financeiro(const Value: Variant);
begin
  Fdesconto_financeiro := Value;
end;

procedure TClienteModel.Setdesconto_nf(const Value: Variant);
begin
  Fdesconto_nf := Value;
end;

procedure TClienteModel.Setdescricao(const Value: Variant);
begin
  Fdescricao := Value;
end;

procedure TClienteModel.Setdescricao_reparcelamento(const Value: Variant);
begin
  Fdescricao_reparcelamento := Value;
end;

procedure TClienteModel.Setdesc_financeiro(const Value: Variant);
begin
  Fdesc_financeiro := Value;
end;

procedure TClienteModel.Setdestro_canhoto(const Value: Variant);
begin
  Fdestro_canhoto := Value;
end;

procedure TClienteModel.Setdiabetes(const Value: Variant);
begin
  Fdiabetes := Value;
end;

procedure TClienteModel.Setdiabetes_familiares(const Value: Variant);
begin
  Fdiabetes_familiares := Value;
end;

procedure TClienteModel.Setdiapasao(const Value: Variant);
begin
  Fdiapasao := Value;
end;

procedure TClienteModel.Setdia_vencimento(const Value: Variant);
begin
  Fdia_vencimento := Value;
end;

procedure TClienteModel.Setdigitapressao(const Value: Variant);
begin
  Fdigitapressao := Value;
end;

procedure TClienteModel.Setdisidrose(const Value: Variant);
begin
  Fdisidrose := Value;
end;

procedure TClienteModel.Setdocidentificacaoconj_cli(const Value: Variant);
begin
  Fdocidentificacaoconj_cli := Value;
end;

procedure TClienteModel.Setdst(const Value: Variant);
begin
  Fdst := Value;
end;

procedure TClienteModel.Setemail2(const Value: Variant);
begin
  Femail2 := Value;
end;

procedure TClienteModel.Setemail_cli(const Value: Variant);
begin
  Femail_cli := Value;
end;

procedure TClienteModel.Setemail_cobranca(const Value: Variant);
begin
  Femail_cobranca := Value;
end;

procedure TClienteModel.Setendcobranca_cli(const Value: Variant);
begin
  Fendcobranca_cli := Value;
end;

procedure TClienteModel.Setendereco(const Value: Variant);
begin
  Fendereco := Value;
end;

procedure TClienteModel.Setendereco_aval_cli(const Value: Variant);
begin
  Fendereco_aval_cli := Value;
end;

procedure TClienteModel.Setendereco_cli(const Value: Variant);
begin
  Fendereco_cli := Value;
end;

procedure TClienteModel.Setendereco_entrega(const Value: Variant);
begin
  Fendereco_entrega := Value;
end;

procedure TClienteModel.Setendtrabalho_cli(const Value: Variant);
begin
  Fendtrabalho_cli := Value;
end;

procedure TClienteModel.Setenvia_sms(const Value: Variant);
begin
  Fenvia_sms := Value;
end;

procedure TClienteModel.Setescolaridade_cli(const Value: Variant);
begin
  Fescolaridade_cli := Value;
end;

procedure TClienteModel.Setesporao_calcaneo(const Value: Variant);
begin
  Fesporao_calcaneo := Value;
end;

procedure TClienteModel.Setestadocivil_cli(const Value: Variant);
begin
  Festadocivil_cli := Value;
end;

procedure TClienteModel.Setetilista(const Value: Variant);
begin
  Fetilista := Value;
end;

procedure TClienteModel.Setexostose_subungueal(const Value: Variant);
begin
  Fexostose_subungueal := Value;
end;

procedure TClienteModel.Setexpedicao_rg(const Value: Variant);
begin
  Fexpedicao_rg := Value;
end;

procedure TClienteModel.Setex_codigo_postal(const Value: Variant);
begin
  Fex_codigo_postal := Value;
end;

procedure TClienteModel.Setex_estado(const Value: Variant);
begin
  Fex_estado := Value;
end;

procedure TClienteModel.Setfantasia_cli(const Value: Variant);
begin
  Ffantasia_cli := Value;
end;

procedure TClienteModel.Setfax_cli(const Value: Variant);
begin
  Ffax_cli := Value;
end;

procedure TClienteModel.Setfissuras(const Value: Variant);
begin
  Ffissuras := Value;
end;

procedure TClienteModel.Setfoneagencia_cli(const Value: Variant);
begin
  Ffoneagencia_cli := Value;
end;

procedure TClienteModel.Setfoneref1_cli(const Value: Variant);
begin
  Ffoneref1_cli := Value;
end;

procedure TClienteModel.Setfoneref2_cli(const Value: Variant);
begin
  Ffoneref2_cli := Value;
end;

procedure TClienteModel.Setfoneref3_cli(const Value: Variant);
begin
  Ffoneref3_cli := Value;
end;

procedure TClienteModel.Setfonetrabalho_cli(const Value: Variant);
begin
  Ffonetrabalho_cli := Value;
end;

procedure TClienteModel.Setfone_com_aval(const Value: Variant);
begin
  Ffone_com_aval := Value;
end;

procedure TClienteModel.Setfonte_beneficio_cli(const Value: Variant);
begin
  Ffonte_beneficio_cli := Value;
end;

procedure TClienteModel.Setformato_unha(const Value: Variant);
begin
  Fformato_unha := Value;
end;

procedure TClienteModel.Setfrequencia(const Value: Variant);
begin
  Ffrequencia := Value;
end;

procedure TClienteModel.Setfrete(const Value: Variant);
begin
  Ffrete := Value;
end;

procedure TClienteModel.Setfrieira(const Value: Variant);
begin
  Ffrieira := Value;
end;

procedure TClienteModel.Setfuncaotrabalho_cli(const Value: Variant);
begin
  Ffuncaotrabalho_cli := Value;
end;

procedure TClienteModel.Setfuncao_trabalho_anterior(const Value: Variant);
begin
  Ffuncao_trabalho_anterior := Value;
end;

procedure TClienteModel.Setgranulada(const Value: Variant);
begin
  Fgranulada := Value;
end;

procedure TClienteModel.Setgravidez(const Value: Variant);
begin
  Fgravidez := Value;
end;

procedure TClienteModel.Setgrupo_economico_id(const Value: Variant);
begin
  Fgrupo_economico_id := Value;
end;

procedure TClienteModel.Sethalux_rigidus(const Value: Variant);
begin
  Fhalux_rigidus := Value;
end;

procedure TClienteModel.Sethalux_valgus(const Value: Variant);
begin
  Fhalux_valgus := Value;
end;

procedure TClienteModel.Sethiperhidrose(const Value: Variant);
begin
  Fhiperhidrose := Value;
end;

procedure TClienteModel.Sethora_retorno(const Value: Variant);
begin
  Fhora_retorno := Value;
end;

procedure TClienteModel.Setid(const Value: Variant);
begin
  Fid := Value;
end;

procedure TClienteModel.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TClienteModel.Setimagem(const Value: Variant);
begin
  Fimagem := Value;
end;

procedure TClienteModel.Setimportacao_dados(const Value: Variant);
begin
  Fimportacao_dados := Value;
end;

procedure TClienteModel.Setindicacao(const Value: Variant);
begin
  Findicacao := Value;
end;

procedure TClienteModel.Setindice_juros_id(const Value: Variant);
begin
  Findice_juros_id := Value;
end;

procedure TClienteModel.Setinscricao_municipal(const Value: Variant);
begin
  Finscricao_municipal := Value;
end;

procedure TClienteModel.Setinscricao_rg_cli(const Value: Variant);
begin
  Finscricao_rg_cli := Value;
end;

procedure TClienteModel.Setinstrucao_boleto(const Value: Variant);
begin
  Finstrucao_boleto := Value;
end;

procedure TClienteModel.Setisento_icms(const Value: Variant);
begin
  Fisento_icms := Value;
end;

procedure TClienteModel.Setisento_ipi(const Value: Variant);
begin
  Fisento_ipi := Value;
end;

procedure TClienteModel.Setisento_st(const Value: Variant);
begin
  Fisento_st := Value;
end;

procedure TClienteModel.Setisquemica(const Value: Variant);
begin
  Fisquemica := Value;
end;

procedure TClienteModel.Setjuros_bol(const Value: Variant);
begin
  Fjuros_bol := Value;
end;

procedure TClienteModel.SetClientesLista;
begin
  FClientesLista := Value;
end;

procedure TClienteModel.Setcnae(const Value: Variant);
begin
  Fcnae := Value;
end;

procedure TClienteModel.Setcnpj_cpf_aval_cli(const Value: Variant);
begin
  Fcnpj_cpf_aval_cli := Value;
end;

procedure TClienteModel.Setcnpj_cpf_cli(const Value: Variant);
begin
  Fcnpj_cpf_cli := Value;
end;

procedure TClienteModel.Setcnpj_trabalho_cli(const Value: Variant);
begin
  Fcnpj_trabalho_cli := Value;
end;

procedure TClienteModel.Setcodigo_anterior(const Value: Variant);
begin
  Fcodigo_anterior := Value;
end;

procedure TClienteModel.Setcodigo_cli(const Value: Variant);
begin
  Fcodigo_cli := Value;
end;

procedure TClienteModel.Setcodigo_concessionaria_cb(const Value: Variant);
begin
  Fcodigo_concessionaria_cb := Value;
end;

procedure TClienteModel.Setcodigo_ocupacao_cli(const Value: Variant);
begin
  Fcodigo_ocupacao_cli := Value;
end;

procedure TClienteModel.Setcodigo_ven(const Value: Variant);
begin
  Fcodigo_ven := Value;
end;

procedure TClienteModel.Setcodigo_vendedor_cb(const Value: Variant);
begin
  Fcodigo_vendedor_cb := Value;
end;

procedure TClienteModel.Setcod_municipio(const Value: Variant);
begin
  Fcod_municipio := Value;
end;

procedure TClienteModel.Setcod_municipio_entrega(const Value: Variant);
begin
  Fcod_municipio_entrega := Value;
end;

procedure TClienteModel.Setcomissao(const Value: Variant);
begin
  Fcomissao := Value;
end;

procedure TClienteModel.Setcomplemento(const Value: Variant);
begin
  Fcomplemento := Value;
end;

procedure TClienteModel.Setcomplemento_cobranca(const Value: Variant);
begin
  Fcomplemento_cobranca := Value;
end;

procedure TClienteModel.Setcomplemento_entrega(const Value: Variant);
begin
  Fcomplemento_entrega := Value;
end;

procedure TClienteModel.Setcondicoes_pagamento(const Value: Variant);
begin
  Fcondicoes_pagamento := Value;
end;

procedure TClienteModel.Setconfirm_endereco(const Value: Variant);
begin
  Fconfirm_endereco := Value;
end;

procedure TClienteModel.Setconfirm_endereco_anterior(const Value: Variant);
begin
  Fconfirm_endereco_anterior := Value;
end;

procedure TClienteModel.Setconfirm_trabalho(const Value: Variant);
begin
  Fconfirm_trabalho := Value;
end;

procedure TClienteModel.Setconfirm_trabalho_conjuge(const Value: Variant);
begin
  Fconfirm_trabalho_conjuge := Value;
end;

procedure TClienteModel.Setconsumidor_final(const Value: Variant);
begin
  Fconsumidor_final := Value;
end;

procedure TClienteModel.Setcontador_id(const Value: Variant);
begin
  Fcontador_id := Value;
end;

procedure TClienteModel.Setcontatoagencia_cli(const Value: Variant);
begin
  Fcontatoagencia_cli := Value;
end;

procedure TClienteModel.Setcontato_cli(const Value: Variant);
begin
  Fcontato_cli := Value;
end;

procedure TClienteModel.Setcontato_cobranca(const Value: Variant);
begin
  Fcontato_cobranca := Value;
end;

procedure TClienteModel.Setconta_cli(const Value: Variant);
begin
  Fconta_cli := Value;
end;

procedure TClienteModel.Setconvenio_cli(const Value: Variant);
begin
  Fconvenio_cli := Value;
end;

procedure TClienteModel.Setconvenio_cod(const Value: Variant);
begin
  Fconvenio_cod := Value;
end;

procedure TClienteModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TClienteModel.Setlimite_compra(const Value: Variant);
begin
  Flimite_compra := Value;
end;

procedure TClienteModel.Setlimite_sms(const Value: Variant);
begin
  Flimite_sms := Value;
end;

procedure TClienteModel.Setlistar_rad(const Value: Variant);
begin
  Flistar_rad := Value;
end;

procedure TClienteModel.Setlocaltrabalho_cli(const Value: Variant);
begin
  Flocaltrabalho_cli := Value;
end;

procedure TClienteModel.Setloja(const Value: Variant);
begin
  Floja := Value;
end;

procedure TClienteModel.Setmae_aval(const Value: Variant);
begin
  Fmae_aval := Value;
end;

procedure TClienteModel.Setmae_cli(const Value: Variant);
begin
  Fmae_cli := Value;
end;

procedure TClienteModel.Setmal_perfurante(const Value: Variant);
begin
  Fmal_perfurante := Value;
end;

procedure TClienteModel.Setmaterial(const Value: Variant);
begin
  Fmaterial := Value;
end;

procedure TClienteModel.Setmatriz_cliente_id(const Value: Variant);
begin
  Fmatriz_cliente_id := Value;
end;

procedure TClienteModel.Setmonofilamento(const Value: Variant);
begin
  Fmonofilamento := Value;
end;

procedure TClienteModel.Setmotivo_visita(const Value: Variant);
begin
  Fmotivo_visita := Value;
end;

procedure TClienteModel.Setmulta(const Value: Variant);
begin
  Fmulta := Value;
end;

procedure TClienteModel.Setnao_contribuinte(const Value: Variant);
begin
  Fnao_contribuinte := Value;
end;

procedure TClienteModel.Setnascimento_cli(const Value: Variant);
begin
  Fnascimento_cli := Value;
end;

procedure TClienteModel.Setnascimento_dependente(const Value: Variant);
begin
  Fnascimento_dependente := Value;
end;

procedure TClienteModel.Setnascimento_dependente2(const Value: Variant);
begin
  Fnascimento_dependente2 := Value;
end;

procedure TClienteModel.Setnascimento_dependente3(const Value: Variant);
begin
  Fnascimento_dependente3 := Value;
end;

procedure TClienteModel.Setnascimento_dependente4(const Value: Variant);
begin
  Fnascimento_dependente4 := Value;
end;

procedure TClienteModel.Setnascimento_dependente5(const Value: Variant);
begin
  Fnascimento_dependente5 := Value;
end;

procedure TClienteModel.Setnascimento_dependente6(const Value: Variant);
begin
  Fnascimento_dependente6 := Value;
end;

procedure TClienteModel.Setnaturalidade_cli(const Value: Variant);
begin
  Fnaturalidade_cli := Value;
end;

procedure TClienteModel.Setneuropatica(const Value: Variant);
begin
  Fneuropatica := Value;
end;

procedure TClienteModel.Setnfe(const Value: Variant);
begin
  Fnfe := Value;
end;

procedure TClienteModel.Setnomecon_cli(const Value: Variant);
begin
  Fnomecon_cli := Value;
end;

procedure TClienteModel.Setnome_contador_cli(const Value: Variant);
begin
  Fnome_contador_cli := Value;
end;

procedure TClienteModel.Setnome_trabalho_anterior(const Value: Variant);
begin
  Fnome_trabalho_anterior := Value;
end;

procedure TClienteModel.Setnumbeneficio_cli(const Value: Variant);
begin
  Fnumbeneficio_cli := Value;
end;

procedure TClienteModel.Setnumero_calcado(const Value: Variant);
begin
  Fnumero_calcado := Value;
end;

procedure TClienteModel.Setnumero_end(const Value: Variant);
begin
  Fnumero_end := Value;
end;

procedure TClienteModel.Setnumero_entrega(const Value: Variant);
begin
  Fnumero_entrega := Value;
end;

procedure TClienteModel.Setobservacao_cli(const Value: Variant);
begin
  Fobservacao_cli := Value;
end;

procedure TClienteModel.Setobservacao_cobranca(const Value: Variant);
begin
  Fobservacao_cobranca := Value;
end;

procedure TClienteModel.Setobservacao_implantacao(const Value: Variant);
begin
  Fobservacao_implantacao := Value;
end;

procedure TClienteModel.Setobservacao_nfe(const Value: Variant);
begin
  Fobservacao_nfe := Value;
end;

procedure TClienteModel.Setobservacao_ped_orc(const Value: Variant);
begin
  Fobservacao_ped_orc := Value;
end;

procedure TClienteModel.Setobs_geral(const Value: Variant);
begin
  Fobs_geral := Value;
end;

procedure TClienteModel.Setocupacao_id(const Value: Variant);
begin
  Focupacao_id := Value;
end;

procedure TClienteModel.Setonicocriptose(const Value: Variant);
begin
  Fonicocriptose := Value;
end;

procedure TClienteModel.Setonicofose(const Value: Variant);
begin
  Fonicofose := Value;
end;

procedure TClienteModel.Setonicogrifose(const Value: Variant);
begin
  Fonicogrifose := Value;
end;

procedure TClienteModel.Setonicolise(const Value: Variant);
begin
  Fonicolise := Value;
end;

procedure TClienteModel.Setonicomicose(const Value: Variant);
begin
  Fonicomicose := Value;
end;

procedure TClienteModel.Setonicorrexe(const Value: Variant);
begin
  Fonicorrexe := Value;
end;

procedure TClienteModel.Setonicotrofia(const Value: Variant);
begin
  Fonicotrofia := Value;
end;

procedure TClienteModel.Setoperadora_celular(const Value: Variant);
begin
  Foperadora_celular := Value;
end;

procedure TClienteModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TClienteModel.Setoutras_alteracao_laminas(const Value: Variant);
begin
  Foutras_alteracao_laminas := Value;
end;

procedure TClienteModel.Setoutras_patologias(const Value: Variant);
begin
  Foutras_patologias := Value;
end;

procedure TClienteModel.Setpais_id(const Value: Variant);
begin
  Fpais_id := Value;
end;

procedure TClienteModel.Setpai_cli(const Value: Variant);
begin
  Fpai_cli := Value;
end;

procedure TClienteModel.Setparcela_maxima(const Value: Variant);
begin
  Fparcela_maxima := Value;
end;

procedure TClienteModel.Setparentesco_ref1(const Value: Variant);
begin
  Fparentesco_ref1 := Value;
end;

procedure TClienteModel.Setparentesco_ref2(const Value: Variant);
begin
  Fparentesco_ref2 := Value;
end;

procedure TClienteModel.Setpatologia(const Value: Variant);
begin
  Fpatologia := Value;
end;

procedure TClienteModel.Setpatologia_obs(const Value: Variant);
begin
  Fpatologia_obs := Value;
end;

procedure TClienteModel.Setpedido_minimo(const Value: Variant);
begin
  Fpedido_minimo := Value;
end;

procedure TClienteModel.Setpercentual_desconto(const Value: Variant);
begin
  Fpercentual_desconto := Value;
end;

procedure TClienteModel.Setperfusao_d(const Value: Variant);
begin
  Fperfusao_d := Value;
end;

procedure TClienteModel.Setperfusao_e(const Value: Variant);
begin
  Fperfusao_e := Value;
end;

procedure TClienteModel.Setpe_cavo(const Value: Variant);
begin
  Fpe_cavo := Value;
end;

procedure TClienteModel.Setpe_plano(const Value: Variant);
begin
  Fpe_plano := Value;
end;

procedure TClienteModel.Setpodactilia(const Value: Variant);
begin
  Fpodactilia := Value;
end;

procedure TClienteModel.Setportador(const Value: Variant);
begin
  Fportador := Value;
end;

procedure TClienteModel.Setpratica_esporte(const Value: Variant);
begin
  Fpratica_esporte := Value;
end;

procedure TClienteModel.Setpreco_id(const Value: Variant);
begin
  Fpreco_id := Value;
end;

procedure TClienteModel.Setpressao(const Value: Variant);
begin
  Fpressao := Value;
end;

procedure TClienteModel.Setproduto_tipo_id(const Value: Variant);
begin
  Fproduto_tipo_id := Value;
end;

procedure TClienteModel.Setprofcon_cli(const Value: Variant);
begin
  Fprofcon_cli := Value;
end;

procedure TClienteModel.Setprospeccao_id(const Value: Variant);
begin
  Fprospeccao_id := Value;
end;

procedure TClienteModel.Setpsoriase(const Value: Variant);
begin
  Fpsoriase := Value;
end;

procedure TClienteModel.Setpsoriase_pe(const Value: Variant);
begin
  Fpsoriase_pe := Value;
end;

procedure TClienteModel.Setpulsos(const Value: Variant);
begin
  Fpulsos := Value;
end;

procedure TClienteModel.Setquantidade_terminais(const Value: Variant);
begin
  Fquantidade_terminais := Value;
end;

procedure TClienteModel.Setrazao_cli(const Value: Variant);
begin
  Frazao_cli := Value;
end;

procedure TClienteModel.Setreducao_icms(const Value: Variant);
begin
  Freducao_icms := Value;
end;

procedure TClienteModel.Setreduzir_base_icms(const Value: Variant);
begin
  Freduzir_base_icms := Value;
end;

procedure TClienteModel.Setreferencia1_cli(const Value: Variant);
begin
  Freferencia1_cli := Value;
end;

procedure TClienteModel.Setreferencia2_cli(const Value: Variant);
begin
  Freferencia2_cli := Value;
end;

procedure TClienteModel.Setreferencia3_cli(const Value: Variant);
begin
  Freferencia3_cli := Value;
end;

procedure TClienteModel.Setregiao_id(const Value: Variant);
begin
  Fregiao_id := Value;
end;

procedure TClienteModel.Setregime_trabalho(const Value: Variant);
begin
  Fregime_trabalho := Value;
end;

procedure TClienteModel.Setrenda_cli(const Value: Variant);
begin
  Frenda_cli := Value;
end;

procedure TClienteModel.Setrenda_trabalho_anterior(const Value: Variant);
begin
  Frenda_trabalho_anterior := Value;
end;

procedure TClienteModel.Setrevendedor(const Value: Variant);
begin
  Frevendedor := Value;
end;

procedure TClienteModel.Setrgcon_cli(const Value: Variant);
begin
  Frgcon_cli := Value;
end;

procedure TClienteModel.Setrg_aval(const Value: Variant);
begin
  Frg_aval := Value;
end;

procedure TClienteModel.Setsacador_avalista_id(const Value: Variant);
begin
  Fsacador_avalista_id := Value;
end;

procedure TClienteModel.Setsalariocon_cli(const Value: Variant);
begin
  Fsalariocon_cli := Value;
end;

procedure TClienteModel.Setsenha(const Value: Variant);
begin
  Fsenha := Value;
end;

procedure TClienteModel.Setseprocado_cli(const Value: Variant);
begin
  Fseprocado_cli := Value;
end;

procedure TClienteModel.Setsexo_cli(const Value: Variant);
begin
  Fsexo_cli := Value;
end;

procedure TClienteModel.Setsexo_dependente(const Value: Variant);
begin
  Fsexo_dependente := Value;
end;

procedure TClienteModel.Setsexo_dependente2(const Value: Variant);
begin
  Fsexo_dependente2 := Value;
end;

procedure TClienteModel.Setsexo_dependente3(const Value: Variant);
begin
  Fsexo_dependente3 := Value;
end;

procedure TClienteModel.Setsexo_dependente4(const Value: Variant);
begin
  Fsexo_dependente4 := Value;
end;

procedure TClienteModel.Setsexo_dependente5(const Value: Variant);
begin
  Fsexo_dependente5 := Value;
end;

procedure TClienteModel.Setsexo_dependente6(const Value: Variant);
begin
  Fsexo_dependente6 := Value;
end;

procedure TClienteModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TClienteModel.Setstatus(const Value: Variant);
begin
  Fstatus := Value;
end;

procedure TClienteModel.Setstatus_carta(const Value: Variant);
begin
  Fstatus_carta := Value;
end;

procedure TClienteModel.Setstatus_implantacao(const Value: Variant);
begin
  Fstatus_implantacao := Value;
end;

procedure TClienteModel.Setsub_atividade_id(const Value: Variant);
begin
  Fsub_atividade_id := Value;
end;

procedure TClienteModel.Setsuframa(const Value: Variant);
begin
  Fsuframa := Value;
end;

procedure TClienteModel.Setsystime(const Value: Variant);
begin
  Fsystime := Value;
end;

procedure TClienteModel.Settabagismo(const Value: Variant);
begin
  Ftabagismo := Value;
end;

procedure TClienteModel.Settela(const Value: Variant);
begin
  Ftela := Value;
end;

procedure TClienteModel.Settelefone_aval_cli(const Value: Variant);
begin
  Ftelefone_aval_cli := Value;
end;

procedure TClienteModel.Settelefone_cli(const Value: Variant);
begin
  Ftelefone_cli := Value;
end;

procedure TClienteModel.Settelefone_cobranca(const Value: Variant);
begin
  Ftelefone_cobranca := Value;
end;

procedure TClienteModel.Settelefone_conjuge(const Value: Variant);
begin
  Ftelefone_conjuge := Value;
end;

procedure TClienteModel.Settelefone_contador_cli(const Value: Variant);
begin
  Ftelefone_contador_cli := Value;
end;

procedure TClienteModel.Settelefone_internacional(const Value: Variant);
begin
  Ftelefone_internacional := Value;
end;

procedure TClienteModel.Settelefone_mae(const Value: Variant);
begin
  Ftelefone_mae := Value;
end;

procedure TClienteModel.Settelefone_pai(const Value: Variant);
begin
  Ftelefone_pai := Value;
end;

procedure TClienteModel.Settelefone_trabalho_anterior(const Value: Variant);
begin
  Ftelefone_trabalho_anterior := Value;
end;

procedure TClienteModel.Settempo_residencia(const Value: Variant);
begin
  Ftempo_residencia := Value;
end;

procedure TClienteModel.Settempo_servico(const Value: Variant);
begin
  Ftempo_servico := Value;
end;

procedure TClienteModel.Settinea_pedis(const Value: Variant);
begin
  Ftinea_pedis := Value;
end;

procedure TClienteModel.Settipodocidentificacaoconj_cli(const Value: Variant);
begin
  Ftipodocidentificacaoconj_cli := Value;
end;

procedure TClienteModel.Settipodoc_cli(const Value: variant);
begin
  Ftipodoc_cli := Value;
end;

procedure TClienteModel.Settipo_apuracao(const Value: Variant);
begin
  Ftipo_apuracao := Value;
end;

procedure TClienteModel.Settipo_cli(const Value: Variant);
begin
  Ftipo_cli := Value;
end;

procedure TClienteModel.Settipo_emissao_nfe(const Value: Variant);
begin
  Ftipo_emissao_nfe := Value;
end;

procedure TClienteModel.Settipo_funcionario_publico_cli(const Value: Variant);
begin
  Ftipo_funcionario_publico_cli := Value;
end;

procedure TClienteModel.Settipo_residencia(const Value: Variant);
begin
  Ftipo_residencia := Value;
end;

procedure TClienteModel.Settipo_saida(const Value: Variant);
begin
  Ftipo_saida := Value;
end;

procedure TClienteModel.Settipo_suframa(const Value: Variant);
begin
  Ftipo_suframa := Value;
end;

procedure TClienteModel.Settitular_conta_cb(const Value: Variant);
begin
  Ftitular_conta_cb := Value;
end;

procedure TClienteModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TClienteModel.Settrabalho_admissao(const Value: Variant);
begin
  Ftrabalho_admissao := Value;
end;

procedure TClienteModel.Settrabalho_anterior_admissao(const Value: Variant);
begin
  Ftrabalho_anterior_admissao := Value;
end;

procedure TClienteModel.Settransportadora_id(const Value: Variant);
begin
  Ftransportadora_id := Value;
end;

procedure TClienteModel.Settratamento_medicamento(const Value: Variant);
begin
  Ftratamento_medicamento := Value;
end;

procedure TClienteModel.Setufcobranca_cli(const Value: Variant);
begin
  Fufcobranca_cli := Value;
end;

procedure TClienteModel.Setuftrabalho_cli(const Value: Variant);
begin
  Fuftrabalho_cli := Value;
end;

procedure TClienteModel.Setuf_cli(const Value: Variant);
begin
  Fuf_cli := Value;
end;

procedure TClienteModel.Setuf_entrega(const Value: Variant);
begin
  Fuf_entrega := Value;
end;

procedure TClienteModel.Setuf_naturalidade_cli(const Value: Variant);
begin
  Fuf_naturalidade_cli := Value;
end;

procedure TClienteModel.Setultima_compra(const Value: Variant);
begin
  Fultima_compra := Value;
end;

procedure TClienteModel.Setungueal(const Value: Variant);
begin
  Fungueal := Value;
end;

procedure TClienteModel.Setunidade_consumidora_cb(const Value: Variant);
begin
  Funidade_consumidora_cb := Value;
end;

procedure TClienteModel.Seturl_cli(const Value: Variant);
begin
  Furl_cli := Value;
end;

procedure TClienteModel.Setusar_controle_kg(const Value: Variant);
begin
  Fusar_controle_kg := Value;
end;

procedure TClienteModel.Setusar_desconto_produto(const Value: Variant);
begin
  Fusar_desconto_produto := Value;
end;

procedure TClienteModel.Setusa_cte(const Value: Variant);
begin
  Fusa_cte := Value;
end;
procedure TClienteModel.Setusa_mdfe(const Value: Variant);
begin
  Fusa_mdfe := Value;
end;
procedure TClienteModel.Setusa_nfce(const Value: Variant);
begin
  Fusa_nfce := Value;
end;
procedure TClienteModel.Setusa_nfe(const Value: Variant);
begin
  Fusa_nfe := Value;
end;
procedure TClienteModel.Setusa_nfse(const Value: Variant);
begin
  Fusa_nfse := Value;
end;
procedure TClienteModel.Setusuario_cli(const Value: Variant);
begin
  Fusuario_cli := Value;
end;
procedure TClienteModel.Setvalor_aluguel(const Value: Variant);
begin
  Fvalor_aluguel := Value;
end;
procedure TClienteModel.Setvaucher(const Value: Variant);
begin
  Fvaucher := Value;
end;
procedure TClienteModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;
procedure TClienteModel.Setzemopay(const Value: Variant);
begin
  Fzemopay := Value;
end;
procedure TClienteModel.Setzemopay_banco_id(const Value: Variant);
begin
  Fzemopay_banco_id := Value;
end;
procedure TClienteModel.Setzemopay_id(const Value: Variant);
begin
  Fzemopay_id := Value;
end;
procedure TClienteModel.Setzemopay_taxa_id(const Value: Variant);
begin
  Fzemopay_taxa_id := Value;
end;
function TClienteModel.ufCliente(pId: String): Variant;
var
  lClienteDao: TClienteDao;
begin
  lClienteDao := TClienteDao.Create(vIConexao);
  try
    Result := lClienteDao.ufCliente(pId);
  finally
    lClienteDao.Free;
  end;
end;
end.
