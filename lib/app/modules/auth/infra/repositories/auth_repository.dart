import 'package:dio/dio.dart';
import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/entities/user_entity.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/params/login_params.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:gerenciador_licenca/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:gerenciador_licenca/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDataSource authDataSource;

  AuthRepository({
    required this.authDataSource,
  });

  @override
  Future<Either<IAuthException, UserEntity>> login(
      LoginParams loginParams) async {
    try {
      final result = await authDataSource.login(loginParams);

      final map = UserAdapter.fromMap(result);

      return right(map);
    } on IAuthException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(AuthException(message: e.message));
    } catch (e) {
      return left(AuthException(message: e.toString()));
    }
  }
}
