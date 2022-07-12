import 'package:gerenciador_licenca/app/modules/auth/domain/params/login_params.dart';

abstract class IAuthDataSource {
  Future<dynamic> login(LoginParams loginParams);
}
