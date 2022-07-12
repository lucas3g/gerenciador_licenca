import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/entities/user_entity.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/params/login_params.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class ILoginUseCase {
  Future<Either<IAuthException, UserEntity>> call(LoginParams loginParams);
}

class LoginUseCase implements ILoginUseCase {
  final IAuthRepository authRepository;

  LoginUseCase({
    required this.authRepository,
  });

  @override
  Future<Either<IAuthException, UserEntity>> call(
      LoginParams loginParams) async {
    return await authRepository.login(loginParams);
  }
}
