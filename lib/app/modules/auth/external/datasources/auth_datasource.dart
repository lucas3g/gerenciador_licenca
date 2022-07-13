import 'package:gerenciador_licenca/app/core_module/constants/constants.dart';
import 'package:gerenciador_licenca/app/core_module/services/client_http/client_http_interface.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/params/login_params.dart';
import 'package:gerenciador_licenca/app/modules/auth/external/adapters/params_to_json.dart';
import 'package:gerenciador_licenca/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthDataSource implements IAuthDataSource {
  final IClientHttp clientHttp;

  AuthDataSource({
    required this.clientHttp,
  });

  @override
  Future login(LoginParams loginParams) async {
    final response = await clientHttp.post(
      '$baseUrlCliente/user',
      data: ParamsToJson.toJson(loginParams),
    );

    await Future.delayed(const Duration(seconds: 1));

    if (response.statusCode != 200) {
      throw const AuthException(message: 'Erro ao tentar fazer login');
    }

    return response.data;
  }
}
