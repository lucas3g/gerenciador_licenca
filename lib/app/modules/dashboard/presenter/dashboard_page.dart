import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/license_page.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/reports/reports_page.dart';
import 'package:gerenciador_licenca/app/theme/app_theme.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final controllerPage = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: AppTheme.textStyles.titleAppBar,
        title: const Text('DashBoard'),
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
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('Licenças'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.book),
                label: Text('Relatórios'),
              ),
            ],
          ),
          const VerticalDivider(),
          Expanded(
              child: PageView(
            controller: controllerPage,
            children: const [
              LicencaPage(),
              ReportsPage(),
            ],
          ))
        ],
      ),
    );
  }
}
