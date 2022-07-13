import 'package:gerenciador_licenca/app/modules/dashboard/domain/value_object/cliente_value_object.dart';

class ClienteAdapter {
  static ClienteValueObject fromMap(dynamic map) {
    return ClienteValueObject(
      name: map['NOME'],
      CNPJCPF: map['CNPJ'],
      telefone: map['FONE'] ?? '' ?? map['CELULAR'] ?? '',
    );
  }
}
