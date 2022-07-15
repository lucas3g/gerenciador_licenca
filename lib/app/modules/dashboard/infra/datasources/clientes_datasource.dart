abstract class IClientesDataSource {
  Future<List<dynamic>> getClientes(String nome);
  Future<dynamic> getClientesByCode(int codCliente);
}
