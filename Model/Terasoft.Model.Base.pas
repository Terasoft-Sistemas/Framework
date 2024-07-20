
{$i definicoes.inc}

unit Terasoft.Model.Base;
interface
  uses
    Classes,
    Terasoft.Framework.Types,
    Terasoft.Framework.DB,
    Interfaces.Conexao,
    Terasoft.Framework.Texto;

  type
    TModelBase = class
    protected
      // LIsta de regras que deverão ser
      fListaValidacoes: IListaStringLock;
      fModelName: String;
      vIConexao : IConexao;

      function getListaVaklidacoes: IListaStringLock; virtual;

      procedure doCreate; virtual;
      procedure doDestroy; virtual;
      function doCamposObrigatorios(pTag: String; pView: TComponent; pResultado: IResultadoOperacao=nil): IResultadoOperacao; virtual;

      property listaValidacoes: IListaStringLock read getListaVaklidacoes;

    public
    	constructor Create(pIConexao : IConexao); virtual;
      destructor Destroy; override;
      function validaRegrasModel(pListaCampos: IListaString=nil; pResultado: IResultadoOperacao=nil): IResultadoOperacao; virtual;
      function camposObrigatorios(pTag: String; pView: TComponent; pResultado: IResultadoOperacao=nil): IResultadoOperacao;
    end;


implementation
  uses
    SysUtils,
    Terasoft.Utils;

{ TModelBase }

constructor TModelBase.Create;
begin
  vIConexao := pIConexao;
  doCreate;
end;

destructor TModelBase.Destroy;
begin
  doDestroy;
  vIConexao := nil;
  fListaValidacoes := nil;
  inherited;
end;

procedure TModelBase.doCreate;
begin
  //Não faz nada...
end;

procedure TModelBase.doDestroy;
begin
  //Não faz nada...
end;

function TModelBase.getListaVaklidacoes: IListaStringLock;
begin
  if(fListaValidacoes=nil) then
  begin
    fListaValidacoes := getStringListLock;
    //fListaRegras.Add('padrao');
  end;
end;

function TModelBase.camposObrigatorios;
begin
  Result := checkResultadoOperacao(pResultado);
  Result := doCamposObrigatorios(pTag,pView,pResultado);
end;

function TModelBase.doCamposObrigatorios;
  var
    save: INteger;
begin
  Result := checkResultadoOperacao(pResultado);
  save := pResultado.erros;
  Result := validaRegrasModel(nil,pResultado);//.validador.valida checkResultadoOperacao(pResultado);
  if(pView=nil) then
    exit;
  if(pResultado.erros<>save) then
  begin
    //se colocamos o foco no problemático, vamos notificar o view pelo campo tag...
    if(vIConexao.validador.setFocoViewControleDataField(pResultado.propriedade['campo.erro'].asString, pView)<>nil) then
      pView.Tag := -55;
    CriaException('Existem campos obrigatórios não preenchidos.');
    abort;
  end;

end;

function TModelBase.validaRegrasModel;
  var
    save: Integer;
    s: String;
begin
  Result := checkResultadoOperacao(pResultado);
  save := pResultado.erros;
  if(fListaValidacoes<>nil) then
    for s in fListaValidacoes do
    begin
      Result := vIConexao.validador.validaModel(s,fModelName,self,pListaCampos,Result);
      if(Result.erros<>save) then
        exit;
    end;

  for s in vIConexao.validador.listaValidacoes do
  begin
    Result := vIConexao.validador.validaModel(s,fModelName,self,pListaCampos,Result);
    if(Result.erros<>save) then
      exit;
  end;


end;

end.
