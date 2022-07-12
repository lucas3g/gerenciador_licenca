import 'package:gerenciador_licenca/app/modules/dashboard/domain/value_object/licenca_value_object.dart';

class LicencaAdapterValueObject {
  static LicencaValueObject fromMap(dynamic map) {
    return LicencaValueObject(
      id: map['id'],
      app: map['app'],
      ativo: map['ativo'],
    );
  }
}
