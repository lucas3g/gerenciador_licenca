abstract class ClientesEvents {}

class GetClientesByNomeEvent extends ClientesEvents {
  final String nome;
  GetClientesByNomeEvent({
    required this.nome,
  });
}
