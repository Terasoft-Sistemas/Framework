unit GeneratorNewDao;

interface

uses
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TGeneratorNewDao = class

  private
    vIConexao : IConexao;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function generator(pGen : String): String;
end;

implementation

uses
  System.SysUtils, System.StrUtils;

{ TGeneratorNew }

constructor TGeneratorNewDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGeneratorNewDao.Destroy;
begin

  inherited;
end;

function TGeneratorNewDao.generator(pGen: String): String;
var
  lQry      : TFDQuery;
  lSql,
  lCtrGen,
  lCtr,
  lGen      : String;
  lvalorGen : Integer;
begin
  lQry := vIConexao.criarQuery;
  try
    lQry.Open('select c.valorstring gen from configuracoes c where c.tag = '+QuotedStr('CTR_'+pGen));

    lCtrGen := ifThen(not lQry.IsEmpty, lQry.FieldByName('GEN').AsString, '');

    lQry.Open('select gen_id( '+pGen+', 1 ) from rdb$database ');

    lvalorGen := lQry.FieldByName('GEN_ID').AsInteger;

    if lCtrGen = '' then
    begin
      if lvalorGen < 1000000 then
      begin
        Result := Format('%6.6d', [lvalorGen]);
        exit;
      end;
      lQry.ExecSQL('alter sequence '+pGen+' restart with 0');

      lCtrGen := 'A';
      lQry.ExecSQL(' insert into configuracoes (tag,                                 '+
                   '                            fid,                                 '+
                   '                            perfil_id,                           '+
                   '                            valorinteiro,                        '+
                   '                            valorstring,                         '+
                   '                            valormemo,                           '+
                   '                            valornumerico,                       '+
                   '                            valorchar,                           '+
                   '                            valordata,                           '+
                   '                            valorhora,                           '+
                   '                            valordatahora)                       '+
                   '                  values ( '+QuotedStr('CTR_'+pGen)+',           '+
                   '                  ''ZZZZZZ'',                                    '+
                   '                  null,                                          '+
                   '                  null,                                          '+
                   '                  ''A'',                                         '+
                   '                  null,                                          '+
                   '                  null,                                          '+
                   '                  null,                                          '+
                   '                  null,                                          '+
                   '                  null,                                          '+
                   '                  null);                                         ');

      lGen   := lCtrGen+format('%5.5d', [0]);
      Result := lGen;
      exit;
    end;

    if lvalorGen < 100000 then begin
      Result := lCtrGen + Format('%5.5d', [lvalorGen]);
    end
    else begin
      lQry.ExecSQL('alter sequence '+pGen+' restart with 0');
      case lCtrGen[1] of
        'A': lCtr := 'B';
        'B': lCtr := 'C';
        'C': lCtr := 'D';
        'D': lCtr := 'E';
        'E': lCtr := 'F';
        'F': lCtr := 'G';
        'G': lCtr := 'H';
        'H': lCtr := 'I';
        'I': lCtr := 'J';
        'J': lCtr := 'K';
        'K': lCtr := 'L';
        'L': lCtr := 'M';
        'M': lCtr := 'N';
        'N': lCtr := 'O';
        'O': lCtr := 'P';
        'P': lCtr := 'Q';
        'Q': lCtr := 'R';
        'R': lCtr := 'S';
        'S': lCtr := 'T';
        'T': lCtr := 'U';
        'U': lCtr := 'V';
        'V': lCtr := 'X';
        'X': lCtr := 'Z';
        'Z': lCtr := 'Y';
        'Y': lCtr := 'W';
      end;
      lQry.ExecSQL('update configuracoes c set c.valorstring = '+QuotedStr(lCtr)+' where c.fid = ''ZZZZZZ'' and c.tag = '+QuotedStr('CTR_'+pGen));
      lCtrGen  := lCtr;
      Result := lCtrGen+Format('%5.5d', [0]);
    end;

  finally
    lQry.Free;
  end;
end;

end.
