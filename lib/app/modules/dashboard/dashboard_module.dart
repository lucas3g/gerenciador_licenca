import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/licenca_repository.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/get_licencas_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/external/datasources/licenca_datasource.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/licenca_datasource.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/repositories/licenca_repository.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/dashboard_page.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/licenca_bloc.dart';

class DashBoardModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [
    //DATASOURCES
    Bind.factory<ILicencaDataSource>(
      (i) => LicencaDataSource(clientHttp: i()),
    ),

    //REPOSITORIES
    Bind.factory<ILicencaRepository>(
      (i) => LicencaRepository(licencaDataSource: i()),
    ),

    //USECASES
    Bind.factory<IGetLicencasUseCase>(
      (i) => GetLicencasUseCase(licencaRepository: i()),
    ),

    //BLOC
    Bind.singleton<LicencaBloc>(
      (i) => LicencaBloc(getLicencasUseCase: i()),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (contenxt, args) => DashBoardPage(
        licencaBloc: Modular.get<LicencaBloc>(),
      ),
    ),
  ];
}
