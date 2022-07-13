import 'package:gerenciador_licenca/app/modules/dashboard/domain/value_object/licenca_value_object.dart';

class LicencaAdapterValueObject {
  static LicencaValueObject fromMap(dynamic map) {
    return LicencaValueObject(
      id: map['ID_DEVICE'],
      app: map['DESC_APP'],
      ativo: map['ATIVO'],
      descricao: map['DESCRICAO'],
      idApp: map['ID_APP'],
      apelido: map['APELIDO'],
    );
  }
}
