import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/get_licencas_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/events/licenca_events.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/states/licenca_states.dart';

class LicencaBloc extends Bloc<LicencaEvents, LicencaStates> {
  final GetLicencasUseCase getLicencasUseCase;

  LicencaBloc({
    required this.getLicencasUseCase,
  }) : super(LicencaInitialState()) {
    on<GetLicencaEvent>(_getLicenca);
  }

  Future<void> _getLicenca(GetLicencaEvent event, emit) async {
    emit(LicencaLoadingState());

    final result = await getLicencasUseCase(event.codCliente);

    result.fold(
      (l) => emit(LicencaErrorState(message: l.message)),
      (r) => emit(LicencaSuccessState(licencasEntity: r)),
    );
  }
}
