import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/entities/user_entity.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../params/params.dart';

class IAuthRepositoryMock extends Mock implements IAuthRepository {}

void main() {
  late IAuthRepository authRepository;
  late LoginUseCase loginUseCase;

  setUp(() {
    authRepository = IAuthRepositoryMock();
    loginUseCase = LoginUseCase(authRepository: authRepository);
  });

  test('deve retornar uma instancia de UserEntity', () async {
    when(
      () => authRepository.login(loginParams),
    ).thenAnswer((_) async => right(UserEntity(id: 1, name: 'name')));

    final result = await loginUseCase(loginParams);

    expect(result.fold(id, id), isA<UserEntity>());
  });
}
