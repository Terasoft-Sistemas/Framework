unit EventosNFeDao;

interface

uses
  FireDAC.Comp.Client,
  EventosNFeModel,
  System.SysUtils,
  Interfaces.Conexao;

type
  TEventosNFeDao = class

  private
  vIConexao : IConexao;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;


    function incluir(AEventosNFeModel: TEventosNFeModel): Boolean;
    function alterar(AEventosNFeModel: TEventosNFeModel): Boolean;
    function excluir(AEventosNFeModel: TEventosNFeModel): Boolean;

end;

implementation

uses
  System.StrUtils;//, SistemaControl;
{ TEventosNFeDao }

function TEventosNFeDao.alterar(AEventosNFeModel: TEventosNFeModel): Boolean;
begin

end;

constructor TEventosNFeDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TEventosNFeDao.Destroy;
begin
  inherited;

end;

function TEventosNFeDao.excluir(AEventosNFeModel: TEventosNFeModel): Boolean;
var
  lSQL: String;
  lQry: TFDQuery;
begin
  try
    lQry := vIConexao.CriarQuery;

  finally
    lQry.Free;
  end;

end;

function TEventosNFeDao.incluir(AEventosNFeModel: TEventosNFeModel): Boolean;
var
  lSQL: String;
  lQry: TFDQuery;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSQL :=
    ' insert into eventos_nfe (id,               '+#13+
    '                        id_nfe,             '+#13+
    '                        datahora,           '+#13+
    '                        evento,             '+#13+
    '                        id_evento,          '+#13+
    '                        chnfe,              '+#13+
    '                        tpevento,           '+#13+
    '                        nseqevento,         '+#13+
    '                        verevento,          '+#13+
    '                        descevento,         '+#13+
    '                        xcorrecao,          '+#13+
    '                        xconduso,           '+#13+
    '                        txt,                '+#13+
    '                        xml,                '+#13+
    '                        status,             '+#13+
    '                        protocolo_retorno,  '+#13+
    '                        retorno_sefaz,      '+#13+
    '                        filial,             '+#13+
    '                        empresa,            '+#13+
    '                        justificativa)      '+#13+
    ' values (:id,                               '+#13+
    '       :id_nfe,                             '+#13+
    '       :datahora,                           '+#13+
    '       :evento,                             '+#13+
    '       :id_evento,                          '+#13+
    '       :chnfe,                              '+#13+
    '       :tpevento,                           '+#13+
    '       :nseqevento,                         '+#13+
    '       :verevento,                          '+#13+
    '       :descevento,                         '+#13+
    '       :xcorrecao,                          '+#13+
    '       :xconduso,                           '+#13+
    '       :txt,                                '+#13+
    '       :xml,                                '+#13+
    '       :status,                             '+#13+
    '       :protocolo_retorno,                  '+#13+
    '       :retorno_sefaz,                      '+#13+
    '       :filial,                             '+#13+
    '       :empresa,                            '+#13+
    '       :justificativa)                      '+#13;

    lQry.SQL.Add(LSQL);
    lQry.ParamByName('ID').Value                := vIConexao.Generetor('GEN_EVENTOS').ToInteger;
    lQry.ParamByName('ID_NFE').Value            := AEventosNFeModel.ID_NFE;
    lQry.ParamByName('DATAHORA').Value          := AEventosNFeModel.DATAHORA;
    lQry.ParamByName('EVENTO').Value            := AEventosNFeModel.EVENTO;
    lQry.ParamByName('ID_EVENTO').Value         := AEventosNFeModel.ID_EVENTO;
    lQry.ParamByName('CHNFE').Value             := AEventosNFeModel.CHNFE;
    lQry.ParamByName('TPEVENTO').Value          := AEventosNFeModel.TPEVENTO;
    lQry.ParamByName('NSEQEVENTO').Value        := AEventosNFeModel.NSEQEVENTO;
    lQry.ParamByName('VEREVENTO').Value         := AEventosNFeModel.VEREVENTO;
    lQry.ParamByName('DESCEVENTO').Value        := AEventosNFeModel.DESCEVENTO;
    lQry.ParamByName('XCORRECAO').Value         := AEventosNFeModel.XCORRECAO;
    lQry.ParamByName('XCONDUSO').Value          := AEventosNFeModel.XCONDUSO;
    lQry.ParamByName('TXT').Value               := AEventosNFeModel.TXT;
    lQry.ParamByName('XML').Value               := AEventosNFeModel.XML;
    lQry.ParamByName('STATUS').Value            := AEventosNFeModel.STATUS;
    lQry.ParamByName('PROTOCOLO_RETORNO').Value := AEventosNFeModel.PROTOCOLO_RETORNO;
    lQry.ParamByName('RETORNO_SEFAZ').Value     := AEventosNFeModel.RETORNO_SEFAZ;
    lQry.ParamByName('FILIAL').Value            := AEventosNFeModel.FILIAL;
    lQry.ParamByName('EMPRESA').Value           := AEventosNFeModel.EMPRESA;
    lQry.ParamByName('JUSTIFICATIVA').Value     := AEventosNFeModel.JUSTIFICATIVA;
    lQry.ExecSQL;

    Result := true;

  finally
    lQry.Free;
  end;
end;

end.
