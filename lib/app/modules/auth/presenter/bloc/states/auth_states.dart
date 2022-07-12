import 'package:gerenciador_licenca/app/modules/auth/domain/entities/user_entity.dart';

abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {
  final UserEntity userEntity;

  AuthSuccessState({
    required this.userEntity,
  });
}

class AuthErrorState extends AuthStates {
  final String message;

  AuthErrorState({
    required this.message,
  });
}
