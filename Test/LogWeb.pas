unit LogWeb;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Terasoft.Framework.DB,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, XDBGrids, Vcl.ExtCtrls,
  Data.DB, Vcl.Buttons, Vcl.StdCtrls, querySelectData;

type
  TfromLogWeb = class(TForm)
    Panel1: TPanel;
    gridInstancias: TXDBGrid;
    gridExecucao: TXDBGrid;
    dsInst: TDataSource;
    dsExec: TDataSource;
    dsCon: TDataSource;
    gridConexoes: TXDBGrid;
    gridEventos: TXDBGrid;
    dsEv: TDataSource;
    SpeedButton2: TSpeedButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    cbDeadlock: TCheckBox;
    cbComConexoes: TCheckBox;
    qsdPeriodo: TQuerySelectData;
    procedure FormCreate(Sender: TObject);
    procedure dsInstDataChange(Sender: TObject; Field: TField);
    procedure SpeedButton1Click(Sender: TObject);
    procedure dsExecDataChange(Sender: TObject; Field: TField);
    procedure dsConDataChange(Sender: TObject; Field: TField);
    procedure SpeedButton2Click(Sender: TObject);
    procedure gridInstanciasCellDblClick(Column: TXColumn);
    procedure gridExecucaoCellDblClick(Column: TXColumn);
    procedure gridConexoesCellDblClick(Column: TXColumn);
    procedure gridEventosCellDblClick(Column: TXColumn);
    procedure gridInstanciasCellClick(Column: TXColumn);
    procedure gridExecucaoCellClick(Column: TXColumn);
    procedure gridConexoesCellClick(Column: TXColumn);
    procedure cbDeadlockClick(Sender: TObject);
    procedure cbComConexoesClick(Sender: TObject);
  private
    { Private declarations }
  protected
    gdb: IGDB;
    dsInstancias, dsExecucao, dsConexoes, dsEventos: IDataset;

    procedure abrirEventos;
    procedure abrirInstancias;
    procedure abrirExecucao;
    procedure abrirConexoes;
  public
    { Public declarations }
  end;

var
  fromLogWeb: TfromLogWeb;

implementation
  uses
    Terasoft.Framework.MultiConfig;

{$R *.dfm}

procedure TfromLogWeb.abrirConexoes;
begin
  if(dsConexoes=nil) then
  begin
    dsConexoes := gdb.criaDataset;
  end;
  dsConexoes.query(
        'select'+#13+
           '    c.dh,'+#13+
           '    c.chave,'+#13+
           '    c.mobile,'+#13+
           '    c.empresa_id,'+#13+
           '    c.empresa_cnpj,'+#13+
           '    c.empresa_loja,'+#13+
           '    c.conexao'+#13+
           'from'+#13+
           '    webcoleta_conexoes c'+#13+
           'where'+#13+
           '    c.execucao = :id '+#13+
           '    and c.evento=''CONEXAO'''+#13+
           'order by 1',
     'id',[dsExecucao.dataset.fieldByName('chave').AsString]);

  if(dsCon.DataSet=nil) then
    dsCon.DataSet := dsConexoes.dataset;

end;

procedure TfromLogWeb.abrirEventos;
begin
  if(dsEventos=nil) then
  begin
    dsEventos := gdb.criaDataset;
  end;
  dsEventos.query(
        'select'+#13+
           '    c.dh,'+#13+
           '    c.seq,'+#13+
           '    c.evento,'+#13+
           '    c.descricao,'+#13+
           '    c.valor01,'+#13+
           '    c.valor02,'+#13+
           '    c.valor03'+#13+
           'from'+#13+
           '    webcoleta_eventos c'+#13+
           'where'+#13+
           '    c.conexao = :id'+#13+
           'order by conexao desc, seq desc',
     'id',[dsConexoes.dataset.fieldByName('chave').AsString]);

  if(dsEv.DataSet=nil) then
    dsEv.DataSet := dsEventos.dataset;

end;


procedure TfromLogWeb.abrirExecucao;
  var
    queryWhere: String;
    cEventos: String;
begin
  if(dsExecucao=nil) then
  begin
    dsExecucao := gdb.criaDataset;
  end;

  queryWhere :=  ' c.instancia = :id and c.evento=''SISTEMA'' ' ;

  if(cbDeadlock.Checked) then
    queryWhere := queryWhere + ' and c.chave in ' +
        ' ( select distinct c.execucao from webcoleta_eventos e, webcoleta_conexoes c where e.evento in (''DEADLOCK'',''USERDEADLOCK'') and c.chave=e.conexao ) '
  else if(cbComConexoes.Checked) then
    queryWhere := queryWhere + ' and c.chave in ' +
        ' ( select distinct c.execucao from webcoleta_eventos e, webcoleta_conexoes c where e.evento in (''AUTENTICACAO'') and c.chave=e.conexao ) ';

  queryWhere := queryWhere + qsdPeriodo.expandeWhere(tcprefixodata_And,true,0,StrToTime('23:59:59'));

  dsExecucao.query(
      'select c.dh,c.execucao,c.chave'+#13+
         'from webcoleta_conexoes c'+#13+
         'where ' + queryWhere + //c.instancia = :id and c.evento=''SISTEMA'' '+#13+
         'order by 1 desc',
     'id',[dsInstancias.dataset.fieldByName('instancia').AsString]);
  dsExecucao.dataset.FieldByName('execucao').Visible := false;
  dsExecucao.dataset.FieldByName('chave').Visible := false;

  if(dsExec.DataSet=nil) then
    dsExec.DataSet := dsExecucao.dataset;

end;

procedure TfromLogWeb.abrirInstancias;
  var
    queryWhere: String;
begin
  if(dsInstancias=nil) then
    dsInstancias := gdb.criaDataset;
  queryWhere := ' c.evento = ''SISTEMA'' ' +#13;
  if(cbDeadlock.Checked) then
    queryWhere := queryWhere + ' and c.chave in ' +
        ' ( select distinct c.execucao from webcoleta_eventos e, webcoleta_conexoes c where e.evento in (''DEADLOCK'',''USERDEADLOCK'') and c.chave=e.conexao ) '
  else if(cbComConexoes.Checked) then
    queryWhere := queryWhere + ' and c.chave in ' +
        ' ( select distinct c.execucao from webcoleta_eventos e, webcoleta_conexoes c where e.evento in (''AUTENTICACAO'') and c.chave=e.conexao ) ';


  queryWhere := queryWhere + qsdPeriodo.expandeWhere(tcprefixodata_And,true,0,StrToTime('23:59:59'));

  dsInstancias.query('select distinct c.instancia'+#13+
       'from webcoleta_conexoes c'+#13+
       'where ' + queryWhere +
       'order by 1',
     '',[]);

  if(dsInst.DataSet=nil) then
    dsInst.DataSet := dsInstancias.dataset;

end;

procedure TfromLogWeb.cbComConexoesClick(Sender: TObject);
begin
  abrirInstancias;
end;

procedure TfromLogWeb.cbDeadlockClick(Sender: TObject);
begin
  abrirInstancias;
end;

procedure TfromLogWeb.dsConDataChange(Sender: TObject; Field: TField);
begin
  abrirEventos;
end;

procedure TfromLogWeb.dsExecDataChange(Sender: TObject; Field: TField);
begin
  abrirConexoes;
end;

procedure TfromLogWeb.dsInstDataChange(Sender: TObject; Field: TField);
begin
  abrirExecucao;
end;

procedure TfromLogWeb.FormCreate(Sender: TObject);
  var
    p: TDatabaseParts;
begin
  qsdPeriodo.dataInicio := date;
  qsdPeriodo.dataFim := date;
  if(gdb=nil) then
  begin
    //p := getDatabaseParts('FB://licenca.ip.inf.br/12099:C:\SCI\Arquivos\Database\WEB0000.FDB');
    gdb := criaGDB(GDBDRIVER_FIREDAC);
    gdb.testarPortaFirebird := false;
    gdb.charset := GDBFIB_CHARSETPTBR;
    gdb.conectar(instanciaMultiConfig.readString('coleta','database','FB://licenca.ip.inf.br/12099:C:\SCI\Arquivos\Database\WEB0000.FDB'));
  end;
  abrirInstancias;
  //abrirExecucao;
end;

procedure TfromLogWeb.gridConexoesCellClick(Column: TXColumn);
begin
  abrirEventos;
end;

procedure TfromLogWeb.gridConexoesCellDblClick(Column: TXColumn);
begin
  abrirConexoes;
end;

procedure TfromLogWeb.gridEventosCellDblClick(Column: TXColumn);
begin
  abrirEventos;
end;

procedure TfromLogWeb.gridExecucaoCellClick(Column: TXColumn);
begin
  abrirConexoes;
end;

procedure TfromLogWeb.gridExecucaoCellDblClick(Column: TXColumn);
begin
  abrirExecucao;
end;

procedure TfromLogWeb.gridInstanciasCellClick(Column: TXColumn);
begin
  abrirExecucao;
end;

procedure TfromLogWeb.gridInstanciasCellDblClick(Column: TXColumn);
begin
  abrirInstancias;
end;

procedure TfromLogWeb.SpeedButton1Click(Sender: TObject);
begin
  abrirInstancias;
end;

procedure TfromLogWeb.SpeedButton2Click(Sender: TObject);
begin
  abrirEventos;
end;

end.
