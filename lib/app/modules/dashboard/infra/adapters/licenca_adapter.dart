import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/licencas_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/value_object/licenca_value_object.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/adapters/cliente_adapter.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/adapters/licenca_adapter_value_object.dart';

class LicencaAdapter {
  static LicencasEntity fromMap(dynamic map) {
    return LicencasEntity(
      cliente: ClienteAdapter.fromMap(map['cliente']),
      licencas: _retornaLista(map['licencas']),
    );
  }

  static List<LicencaValueObject> _retornaLista(dynamic map) {
    final List<LicencaValueObject> list = [];

    for (var licenca in map) {
      list.add(LicencaAdapterValueObject.fromMap(licenca));
    }

    return list;
  }
}
