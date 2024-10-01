unit Interfaces.PixGestao;

interface

  type
    TResultadoPixGestao = record
      Data,
      Valor,
      Status,
      EndToEndId,
      IdentificadorId,
      Sender_Nome,
      Sender_CPF_CNPJ : String;
  end;

   IPixGestao = interface
    ['{3AFB3A3B-C6D1-4C52-BC4B-72D20D7AA41E}']

    function consultarPix(pID: String)  : IPixGestao;
    function resultado                  : TResultadoPixGestao;

  end;

implementation

end.
