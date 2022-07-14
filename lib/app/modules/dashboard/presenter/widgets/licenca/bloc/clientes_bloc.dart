import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/get_clientes_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/events/clientes_events.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/states/clientes_states.dart';

class ClientesBloc extends Bloc<ClientesEvents, ClientesStates> {
  final GetClientesUseCase getClientesUseCase;

  ClientesBloc({
    required this.getClientesUseCase,
  }) : super(ClientesInitialState()) {
    on<GetClientesByNomeEvent>(_getClientesByNome);
  }

  Future _getClientesByNome(GetClientesByNomeEvent event, emit) async {
    emit(ClientesLoadingState());

    final result = await getClientesUseCase(event.nome);

    result.fold(
      (l) => emit(ClientesErrorState(message: l.message)),
      (r) => emit(ClientesSuccessState(clientes: r)),
    );
  }
}
