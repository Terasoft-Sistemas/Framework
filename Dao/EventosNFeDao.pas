unit EventosNFeDao;

interface

uses
  FireDAC.Comp.Client,
  EventosNFeModel,
  System.SysUtils,
  Terasoft.ConstrutorDao,
  Interfaces.Conexao;

type
  TEventosNFeDao = class

  private
  vIConexao   : IConexao;
  vConstrutor : TConstrutorDao;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;


    function incluir(AEventosNFeModel: TEventosNFeModel): Boolean;
    function alterar(AEventosNFeModel: TEventosNFeModel): Boolean;
    function excluir(AEventosNFeModel: TEventosNFeModel): Boolean;

    procedure setParams(var pQry: TFDQuery; pEventosNFeModel : TEventosNFeModel);
    function where: String;
end;

implementation

uses
  System.StrUtils, System.Variants;//, SistemaControl;
{ TEventosNFeDao }

function TEventosNFeDao.alterar(AEventosNFeModel: TEventosNFeModel): Boolean;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIconexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('EVENTOS_NFE','ID');

  try
    lQry.SQL.Add(lSQL);
    lQry.ParamByName('ID').Value := AEventosNFeModel.ID;
    setParams(lQry, AEventosNFeModel);
    lQry.ExecSQL;

    Result := AEventosNFeModel.ID;

  finally
    lSQL := '';
    lQry.Free;

  end;
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
  lQry: TFDQuery;

begin

  lQry := vIconexao.CriarQuery;

  try
   lQry.ExecSQL('delete from EVENTOS_NFE where ID = :ID',[AEventosNFeModel.ID]);
   lQry.ExecSQL;
   Result := AEventosNFeModel.ID;

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

    lSQL := vConstrutor.gerarInsert('EVENTOS_NFE','ID');

  finally

  end;
end;

procedure TEventosNFeDao.setParams(var pQry: TFDQuery; pEventosNFeModel: TEventosNFeModel);
begin
  pQry.ParamByName('ID_NFE').Value              := ifThen(pEventosNFeModel.ID_NFE             = '', Unassigned, pEventosNFeModel.ID_NFE);
  pQry.ParamByName('DATAHORA').Value            := ifThen(pEventosNFeModel.DATAHORA           = '', Unassigned, pEventosNFeModel.DATAHORA);
  pQry.ParamByName('EVENTO').Value              := ifThen(pEventosNFeModel.EVENTO             = '', Unassigned, pEventosNFeModel.EVENTO);
  pQry.ParamByName('ID_EVENTO').Value           := ifThen(pEventosNFeModel.ID_EVENTO          = '', Unassigned, pEventosNFeModel.ID_EVENTO);
  pQry.ParamByName('CHNFE').Value               := ifThen(pEventosNFeModel.CHNFE              = '', Unassigned, pEventosNFeModel.CHNFE);
  pQry.ParamByName('TPEVENTO').Value            := ifThen(pEventosNFeModel.TPEVENTO           = '', Unassigned, pEventosNFeModel.TPEVENTO);
  pQry.ParamByName('NSEQEVENTO').Value          := ifThen(pEventosNFeModel.NSEQEVENTO         = '', Unassigned, pEventosNFeModel.NSEQEVENTO);
  pQry.ParamByName('VEREVENTO').Value           := ifThen(pEventosNFeModel.VEREVENTO          = '', Unassigned, pEventosNFeModel.VEREVENTO);
  pQry.ParamByName('DESCEVENTO').Value          := ifThen(pEventosNFeModel.DESCEVENTO         = '', Unassigned, pEventosNFeModel.DESCEVENTO);
  pQry.ParamByName('XCORRECAO').Value           := ifThen(pEventosNFeModel.XCORRECAO          = '', Unassigned, pEventosNFeModel.XCORRECAO);
  pQry.ParamByName('XCONDUSO').Value            := ifThen(pEventosNFeModel.XCONDUSO           = '', Unassigned, pEventosNFeModel.XCONDUSO);
  pQry.ParamByName('TXT').Value                 := ifThen(pEventosNFeModel.TXT                = '', Unassigned, pEventosNFeModel.TXT);
  pQry.ParamByName('XML').Value                 := ifThen(pEventosNFeModel.XML                = '', Unassigned, pEventosNFeModel.XML);
  pQry.ParamByName('STATUS').Value              := ifThen(pEventosNFeModel.STATUS             = '', Unassigned, pEventosNFeModel.STATUS);
  pQry.ParamByName('PROTOCOLO_RETORNO').Value   := ifThen(pEventosNFeModel.PROTOCOLO_RETORNO  = '', Unassigned, pEventosNFeModel.PROTOCOLO_RETORNO);
  pQry.ParamByName('RETORNO_SEFAZ').Value       := ifThen(pEventosNFeModel.RETORNO_SEFAZ      = '', Unassigned, pEventosNFeModel.RETORNO_SEFAZ);
  pQry.ParamByName('FILIAL').Value              := ifThen(pEventosNFeModel.FILIAL             = '', Unassigned, pEventosNFeModel.FILIAL);
  pQry.ParamByName('EMPRESA').Value             := ifThen(pEventosNFeModel.EMPRESA            = '', Unassigned, pEventosNFeModel.EMPRESA);
  pQry.ParamByName('JUSTIFICATIVA').Value       := ifThen(pEventosNFeModel.JUSTIFICATIVA      = '', Unassigned, pEventosNFeModel.JUSTIFICATIVA);
end;

function TEventosNFeDao.where: String;
begin

end;

end.
