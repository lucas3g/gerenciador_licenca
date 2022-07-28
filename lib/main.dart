// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/app_module.dart';
import 'package:gerenciador_licenca/app/app_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';

Future<void> main() async {
  await initializeDateFormatting(await findSystemLocale(), '');

  WidgetsFlutterBinding.ensureInitialized();

  await Window.initialize();

  if (Platform.isWindows) {
    await Window.hideWindowControls();
  }

  //

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );

  doWhenWindowReady(() {
    appWindow.isMaximized;
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}
