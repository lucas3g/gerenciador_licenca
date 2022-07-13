import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/get_licencas_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/save_licenca_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/update_licenca_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/events/licenca_events.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/states/licenca_states.dart';

class LicencaBloc extends Bloc<LicencaEvents, LicencaStates> {
  final GetLicencasUseCase getLicencasUseCase;
  final SaveLicencaUseCase saveLicencaUseCase;
  final UpdateLicencaUseCase updateLicencaUseCase;

  LicencaBloc({
    required this.getLicencasUseCase,
    required this.saveLicencaUseCase,
    required this.updateLicencaUseCase,
  }) : super(LicencaInitialState()) {
    on<GetLicencaEvent>(_getLicenca);
    on<SaveLicencaEvent>(_saveLicenca);
    on<UpdateLicencaEvent>(_updateLicenca);
  }

  Future<void> _getLicenca(GetLicencaEvent event, emit) async {
    emit(LicencaLoadingState());

    final result = await getLicencasUseCase(event.codCliente);

    result.fold(
      (l) => emit(LicencaErrorState(message: l.message)),
      (r) => emit(LicencaSuccessState(licencasEntity: r)),
    );
  }

  Future<void> _saveLicenca(SaveLicencaEvent event, emit) async {
    emit(LicencaLoadingState());

    final result = await saveLicencaUseCase(event.licencaEntity);

    result.fold(
      (l) => emit(LicencaErrorState(message: l.message)),
      (r) => emit(LicencaSaveSucessState(result: r)),
    );
  }

  Future<void> _updateLicenca(UpdateLicencaEvent event, emit) async {
    emit(LicencaLoadingState());

    final result =
        await updateLicencaUseCase(event.licencaEntity, event.idDevice);

    result.fold(
      (l) => emit(LicencaErrorState(message: l.message)),
      (r) => emit(LicencaUpdateSucessState(result: r)),
    );
  }
}
