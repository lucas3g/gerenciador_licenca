import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/cliente_entity.dart';

class ListClientesAdapter {
  static ClienteEntity fromMap(dynamic map) {
    return ClienteEntity(
      nome: map['NOME'],
      codigo: int.parse(map['ID']),
    );
  }
}
