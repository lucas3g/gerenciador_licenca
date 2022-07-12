import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/licenca_bloc.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/licenca_page.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/reports/reports_page.dart';
import 'package:gerenciador_licenca/app/theme/app_theme.dart';

class DashBoardPage extends StatefulWidget {
  final LicencaBloc licencaBloc;
  const DashBoardPage({Key? key, required this.licencaBloc}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final controllerPage = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (key) {
        if (key.isKeyPressed(LogicalKeyboardKey.escape)) {
          print('esc');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: AppTheme.textStyles.titleAppBar,
          title: const Text('DashBoard - Gerenciador de Licenças'),
          actions: [
            IconButton(
              onPressed: () {
                Modular.to.navigate('/');
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
                ),
                const ReportsPage(),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
