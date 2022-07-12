import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gerenciador_licenca/app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:gerenciador_licenca/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:gerenciador_licenca/app/modules/auth/presenter/bloc/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final LoginUseCase loginUseCase;

  AuthBloc({
    required this.loginUseCase,
  }) : super(AuthInitialState()) {
    on<LoginEvent>(_login);
  }

  Future<void> _login(LoginEvent event, emit) async {
    emit(AuthLoadingState());
    final result = await loginUseCase(event.loginParams);

    result.fold(
      (l) => emit(AuthErrorState(message: l.message)),
      (r) => emit(AuthSuccessState(userEntity: r)),
    );
  }
}
