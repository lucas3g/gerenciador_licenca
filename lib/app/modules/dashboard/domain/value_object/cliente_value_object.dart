// ignore_for_file: non_constant_identifier_names

class ClienteValueObject {
  final String name;
  final int id;
  final String CNPJCPF;
  final String telefone;

  ClienteValueObject({
    required this.name,
    required this.id,
    required this.CNPJCPF,
    required this.telefone,
  });
}
