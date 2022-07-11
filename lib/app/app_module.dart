import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/core_module/core_module.dart';
import 'package:gerenciador_licenca/app/modules/auth/auth_module.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/dashboard_module.dart';

class AppModule extends Module {
  @override
  final List<Module> imports = [
    CoreModule(),
    AuthModule(),
    DashBoardModule(),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: AuthModule()),
    ModuleRoute('/dash', module: DashBoardModule()),
  ];
}
