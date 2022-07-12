import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/entities/user_entity.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/params/login_params.dart';

abstract class IAuthRepository {
  Future<Either<IAuthException, UserEntity>> login(LoginParams loginParams);
}
