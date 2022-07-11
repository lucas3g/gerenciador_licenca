import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/modules/auth/presenter/auth_page.dart';

class AuthModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (contenxt, args) => const AuthPage()),
  ];
}
