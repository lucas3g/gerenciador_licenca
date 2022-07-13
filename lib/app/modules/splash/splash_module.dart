import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/modules/splash/presenter/splash_page.dart';

class SplashModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const SplashPage()),
  ];
}
