import 'package:gerenciador_licenca/app/modules/auth/domain/params/login_params.dart';

abstract class AuthEvents {}

class LoginEvent extends AuthEvents {
  final LoginParams loginParams;

  LoginEvent({
    required this.loginParams,
  });
}
