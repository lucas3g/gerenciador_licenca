import 'package:gerenciador_licenca/app/modules/auth/domain/params/login_params.dart';

class ParamsToJson {
  static Map<String, dynamic> toJson(LoginParams loginParams) {
    return {
      'user': loginParams.user,
      'senha': loginParams.password,
    };
  }
}
