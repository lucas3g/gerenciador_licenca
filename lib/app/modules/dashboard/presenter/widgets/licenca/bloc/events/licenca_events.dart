import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/new_licenca_entity.dart';

abstract class LicencaEvents {}

class GetLicencaEvent extends LicencaEvents {
  final int codCliente;

  GetLicencaEvent({
    required this.codCliente,
  });
}

class SaveLicencaEvent extends LicencaEvents {
  final NewLicencaEntity licencaEntity;

  SaveLicencaEvent({
    required this.licencaEntity,
  });
}

class UpdateLicencaEvent extends LicencaEvents {
  final NewLicencaEntity licencaEntity;
  final String idDevice;

  UpdateLicencaEvent({
    required this.licencaEntity,
    required this.idDevice,
  });
}
