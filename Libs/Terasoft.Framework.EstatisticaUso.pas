
{$i definicoes.inc}

unit Terasoft.Framework.EstatisticaUso;

interface
  uses
    Classes,SysUtils,
    Terasoft.Framework.JSON,
    Interfaces.Conexao,
    Terasoft.Framework.Types;

  type
    IEstatisticaUsoSessao = interface
    ['{B958AB15-F535-4A8B-B5BE-80164B13349D}']
          //property identificador getter/setter
      function getIdentificador: TBytes;
      procedure setIdentificador(const pValue: TBytes);

      function toJSON: ITlkJSONObject;

      procedure dump;

      function getIDStr: TipoWideStringFramework;

    //property conexao getter/setter
      function getConexao: IConexao;

      property conexao: IConexao read getConexao;
      property identificador: TBytes read getIdentificador write setIdentificador;

    end;

  function getEstatisticaUsoSessao(pConexao: IConexao): IEstatisticaUsoSessao;

implementation
  uses
    FuncoesConfig,
    Terasoft.Framework.FuncoesArquivos,
    Terasoft.Framework.Bytes;

  type
    TEstatisticaUsoImpl = class(TInterfacedObject, IEstatisticaUsoSessao)
    protected
      fIdentificador: TBytes;
      fConexao: IConexao;
      fDH: TDateTime;

    //property conexao getter/setter
      function getConexao: IConexao;

      function toJSON: ITlkJSONObject;

      procedure dump;

      function getIDStr: TipoWideStringFramework;

    //property identificador getter/setter
      function getIdentificador: TBytes;
      procedure setIdentificador(const pValue: TBytes);
    public
      constructor Create(pConexao: IConexao);
    end;

function getEstatisticaUsoSessao;
begin
  if(pConexao=nil) then
    raise Exception.Create('getEstatisticaUsoSessao: Não forneceu uma conexão válida.');
  Result := TEstatisticaUsoImpl.Create(pConexao);
end;

{ TEstatisticaUsoImpl }

constructor TEstatisticaUsoImpl.Create;
begin
  inherited Create;
  fConexao := pConexao;
  fDH := Now;
end;

procedure TEstatisticaUsoImpl.dump;
  var
    s: String;
begin
  s := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)) + 'Stats\' + gNomeInstanciaSistema);
  ForceDirectories(s);
  s := s + getIDStr + '.conexao.json';
  fDH := Now;
  stringToFile(GenerateText(toJSON.json,false),s);
end;

function TEstatisticaUsoImpl.getConexao: IConexao;
begin
  Result := fConexao;
end;

procedure TEstatisticaUsoImpl.setIdentificador(const pValue: TBytes);
begin
  fIdentificador := pValue;
end;

function TEstatisticaUsoImpl.toJSON: ITlkJSONObject;
  var
    lEmpresa: TlkJSONobject;
begin
  Result := TlkJSON.cria;
  Result.json.Add('id',getIDStr);
  Result.json.Add('dh',DateTimeToStr(Now));

  Result.json.Add('instancia',gNomeInstanciaSistema);
  lEmpresa := TlkJSONobject.Generate;
  Result.json.Add('empresa',lEmpresa);
  lEmpresa.Add('id',fConexao.empresa.ID);
  lEmpresa.Add('cnpj',fConexao.empresa.EMPRESA_CNPJ);
  lEmpresa.Add('loja',fConexao.empresa.LOJA);
  lEmpresa.Add('conexao',fConexao.gdb.databaseName);

end;

function TEstatisticaUsoImpl.getIdentificador: TBytes;
begin
  if(length(fIdentificador)=0) then
  begin
    fIdentificador := randomBytes(32);
  end;
  Result := fIdentificador;
end;

function TEstatisticaUsoImpl.getIDStr: TipoWideStringFramework;
begin
  Result := bytesToBase32(getIdentificador);
end;

end.

