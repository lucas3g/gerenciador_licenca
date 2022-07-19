// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/clientes_bloc.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/licenca_bloc.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/states/licenca_states.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/licenca_page.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/reports/reports_page.dart';
import 'package:gerenciador_licenca/app/theme/app_theme.dart';
import 'package:asuka/asuka.dart' as asuka;

class DashBoardPage extends StatefulWidget {
  final LicencaBloc licencaBloc;
  final ClientesBloc clientesBloc;
  const DashBoardPage({
    Key? key,
    required this.licencaBloc,
    required this.clientesBloc,
  }) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final controllerPage = PageController();
  int _selectedIndex = 0;

  Future showModalSairSistema() async {
    await asuka.showDialog(
      barrierColor: Colors.black12,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sair do sistema?',
              style: AppTheme.textStyles.textoSairApp,
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Modular.to.navigate('/auth/');
                    },
                    child: const Text('Sair da conta'),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text('Sair'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTheme.textStyles.titleAppBar,
        title: const Text('DashBoard - Gerenciador de Licenças'),
        actions: [
          IconButton(
            onPressed: () async {
              await showModalSairSistema();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
                controllerPage.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
                widget.licencaBloc.emit(LicencaInitialState());
              });
            },
            labelType: NavigationRailLabelType.all,
            indicatorColor: AppTheme.colors.primary,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.attach_money_rounded),
                selectedIcon: Icon(Icons.attach_money_rounded),
                label: Text('Licenças'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.receipt_long_rounded),
                selectedIcon: Icon(Icons.receipt_long),
                label: Text('Relatórios'),
              ),
            ],
          ),
          const VerticalDivider(),
          Expanded(
            child: PageView(
              controller: controllerPage,
              children: [
                LicencaPage(
                  licencaBloc: widget.licencaBloc,
                  clientesBloc: widget.clientesBloc,
                ),
                const ReportsPage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
