import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/licencas_entity.dart';

abstract class LicencaStates {}

class LicencaInitialState extends LicencaStates {}

class LicencaLoadingState extends LicencaStates {}

class LicencaSuccessState extends LicencaStates {
  final LicencasEntity licencasEntity;

  LicencaSuccessState({
    required this.licencasEntity,
  });
}

class LicencaSaveSucessState extends LicencaStates {
  final bool result;

  LicencaSaveSucessState({
    required this.result,
  });
}

class LicencaUpdateSucessState extends LicencaStates {
  final bool result;

  LicencaUpdateSucessState({
    required this.result,
  });
}

class LicencaErrorState extends LicencaStates {
  final String message;

  LicencaErrorState({
    required this.message,
  });
}
