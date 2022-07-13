import 'dart:convert';

import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/new_licenca_entity.dart';

class NewLicencaAdapter {
  static Map<String, dynamic> toMap(NewLicencaEntity licenca) {
    return {
      'ID_DEVICE': licenca.ID_DEVICE,
      'APELIDO': licenca.APELIDO,
      'ATIVO': licenca.ATIVO,
      'ID_EMPRESA': licenca.ID_EMPRESA,
      'DESCRICAO': licenca.DESCRICAO,
      'ID_APP': licenca.ID_APP,
    };
  }

  static String toJson(NewLicencaEntity licenca) => json.encode(toMap(licenca));
}
