import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/entities/user_entity.dart';
import 'package:gerenciador_licenca/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:gerenciador_licenca/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../params/params.dart';

class IAuthDataSourceMock extends Mock implements IAuthDataSource {}

void main() {
  late IAuthDataSource authDataSource;
  late AuthRepository authRepository;

  setUp(() {
    authDataSource = IAuthDataSourceMock();
    authRepository = AuthRepository(authDataSource: authDataSource);
  });

  test('deve retornar uma instancia de UserEntity', () async {
    when(
      () => authDataSource.login(loginParams),
    ).thenAnswer((_) async => {'id': 1, 'name': 'lucas'});

    final result = await authRepository.login(loginParams);

    expect(result.fold(id, id), isA<UserEntity>());
  });
}
