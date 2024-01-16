unit EmpresaDao;

interface
uses
  EmpresaModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  Interfaces.Conexao;

type
  TEmpresaDao = class

  private
    vIConexao : IConexao;

  public
    procedure carregar(pEmpresaModel: TEmpresaModel);

    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;
  end;

implementation

procedure TEmpresaDao.carregar(pEmpresaModel: TEmpresaModel);
var
  lQry: TFDQuery;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

   try
      lQry.Open(' select * from empresa ');

      try
        pEmpresaModel.ID                    := lQry.fieldByName('ID').AsString;
        pEmpresaModel.SYSTIME               := lQry.fieldByName('SYSTIME').AsString;
        pEmpresaModel.CODIGO                := lQry.fieldByName('CODIGO_EMP').AsString;
        pEmpresaModel.FANTASIA              := lQry.fieldByName('FANTASIA_EMP').AsString;
        pEmpresaModel.RAZAO_SOCIAL          := lQry.fieldByName('RAZAO_EMP').AsString;
        pEmpresaModel.CNPJ                  := lQry.fieldByName('CNPJ_EMP').AsString;
        pEmpresaModel.INSCRICAO_ESTADUAL    := lQry.fieldByName('INSCRICAO_EMP').AsString;
        pEmpresaModel.INSCRICAO_MUNICIPAL   := lQry.fieldByName('INSCRICAO_MUNICIPAL').AsString;
        pEmpresaModel.ENDERECO              := lQry.fieldByName('ENDERECO_EMP').AsString;
        pEmpresaModel.BAIRRO                := lQry.fieldByName('BAIRRO_EMP').AsString;
        pEmpresaModel.CIDADE                := lQry.fieldByName('CIDADE_EMP').AsString;
        pEmpresaModel.UF                    := lQry.fieldByName('UF_EMP').AsString;
        pEmpresaModel.NUMERO                := lQry.fieldByName('NUMERO_END').AsString;
        pEmpresaModel.COMPLEMENTO           := lQry.fieldByName('COMPLEMENTO').AsString;
        pEmpresaModel.CODIGO_MUNUCIPIO      := lQry.fieldByName('COD_MUNICIPIO').AsString;
        pEmpresaModel.TELEFONE              := lQry.fieldByName('TELEFONE_EMP').AsString;
        pEmpresaModel.CONTATO               := lQry.fieldByName('CONTATO_EMP').AsString;
        pEmpresaModel.EMAIL                 := lQry.fieldByName('EMAIL_EMP').AsString;
        pEmpresaModel.URL                   := lQry.fieldByName('URL_EMP').AsString;
        pEmpresaModel.CEP                   := lQry.fieldByName('CEP_EMP').AsString;
        pEmpresaModel.REGIME_TRIBUTARIO     := lQry.fieldByName('REGIME_NFE').AsString;
        pEmpresaModel.JUROS_BOL             := lQry.fieldByName('JUROS_BOL').AsString;
        pEmpresaModel.LOJA                  := lQry.fieldByName('LOJA').AsString;
        pEmpresaModel.LIMITE_ATRASO         := lQry.fieldByName('LIMITE_ATRAZO').AsString;

      finally
        lQry.Close;
      end;

   finally
     lQry.Free;
   end;
end;


constructor TEmpresaDao.Create(pIConexao: IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TEmpresaDao.Destroy;
begin

  inherited;
end;

end.
