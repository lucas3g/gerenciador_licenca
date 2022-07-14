import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/clientes_repository.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/licenca_repository.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/get_clientes_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/get_licencas_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/save_licenca_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/update_licenca_usecase.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/external/datasources/clientes_datasource.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/external/datasources/licenca_datasource.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/clientes_datasource.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/licenca_datasource.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/repositories/clientes_repository.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/repositories/licenca_repository.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/dashboard_page.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/clientes_bloc.dart';
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
    Bind.factory<IClientesDataSource>(
      (i) => ClientesDataSource(clientHttp: i()),
    ),

    //REPOSITORIES
    Bind.factory<ILicencaRepository>(
      (i) => LicencaRepository(licencaDataSource: i()),
    ),
    Bind.factory<IClientesRepository>(
      (i) => ClientesRepository(clientesDataSource: i()),
    ),

    //USECASES
    Bind.factory<IGetLicencasUseCase>(
      (i) => GetLicencasUseCase(licencaRepository: i()),
    ),
    Bind.factory<ISaveLicencaUseCase>(
      (i) => SaveLicencaUseCase(licencaRepository: i()),
    ),
    Bind.factory<IUpdateLicencaUseCase>(
      (i) => UpdateLicencaUseCase(licencaRepository: i()),
    ),
    Bind.factory<IGetClientesUseCase>(
      (i) => GetClientesUseCase(clientesRepository: i()),
    ),

    //BLOC
    Bind.singleton<LicencaBloc>(
      (i) => LicencaBloc(
        getLicencasUseCase: i(),
        saveLicencaUseCase: i(),
        updateLicencaUseCase: i(),
      ),
    ),
    Bind.singleton<ClientesBloc>(
      (i) => ClientesBloc(
        getClientesUseCase: i(),
      ),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (contenxt, args) => DashBoardPage(
        licencaBloc: Modular.get<LicencaBloc>(),
        clientesBloc: Modular.get<ClientesBloc>(),
      ),
    ),
  ];
}
