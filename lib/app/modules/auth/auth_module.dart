import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:gerenciador_licenca/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:gerenciador_licenca/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:gerenciador_licenca/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:gerenciador_licenca/app/modules/auth/presenter/auth_page.dart';
import 'package:gerenciador_licenca/app/modules/auth/presenter/bloc/auth_bloc.dart';

class AuthModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<IAuthDataSource>((i) => AuthDataSource(clientHttp: i())),

    //REPOSITORIRES
    Bind.factory<IAuthRepository>((i) => AuthRepository(authDataSource: i())),

    //USECASES
    Bind.factory<ILoginUseCase>((i) => LoginUseCase(authRepository: i())),

    //BLOC
    Bind.singleton<AuthBloc>((i) => AuthBloc(loginUseCase: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (contenxt, args) => AuthPage(
        authBloc: Modular.get<AuthBloc>(),
      ),
    ),
  ];
}
