import 'package:gerenciador_licenca/app/modules/dashboard/domain/value_object/cliente_value_object.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/value_object/licenca_value_object.dart';

class LicencasEntity {
  final ClienteValueObject cliente;
  final List<LicencaValueObject> licencas;

  LicencasEntity({
    required this.cliente,
    required this.licencas,
  });
}
