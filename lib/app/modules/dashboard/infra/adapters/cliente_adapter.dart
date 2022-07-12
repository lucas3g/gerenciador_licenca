import 'package:gerenciador_licenca/app/modules/dashboard/domain/value_object/cliente_value_object.dart';

class ClienteAdapter {
  static ClienteValueObject fromMap(dynamic map) {
    return ClienteValueObject(
      name: map['name'],
      id: map['id'],
      CNPJCPF: map['CNPJCPF'],
      telefone: map['telefone'],
    );
  }
}
