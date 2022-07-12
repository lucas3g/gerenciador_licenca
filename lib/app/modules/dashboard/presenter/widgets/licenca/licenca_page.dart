import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciador_licenca/app/components/my_input_widget.dart';
import 'package:gerenciador_licenca/app/theme/app_theme.dart';
import 'package:gerenciador_licenca/app/utils/constants.dart';
import 'package:asuka/asuka.dart' as asuka;

enum TiposApp { postoPlus, transportes, agilColetas, upVendas }

class LicencaPage extends StatefulWidget {
  const LicencaPage({Key? key}) : super(key: key);

  @override
  State<LicencaPage> createState() => _LicencaPageState();
}

class _LicencaPageState extends State<LicencaPage> {
  FocusNode fBusca = FocusNode();
  FocusNode fIDPhone = FocusNode();

  TextEditingController controllerBusca = TextEditingController();
  TextEditingController controllerIDPhone = TextEditingController();

  GlobalKey<FormState> keyBusca = GlobalKey<FormState>();
  GlobalKey<FormState> keyIDPhone = GlobalKey<FormState>();

  late TiposApp tiposApp = TiposApp.postoPlus;

  final listaTeste = [
    {'id': 'asdsad213sad12', 'app': 'Posto Plus'},
    {'id': '3434asd123452s', 'app': 'Agil Coletas'},
    {'id': 'fdsfds123asd12', 'app': 'Transportes'},
    {'id': 'fdsfds123asd12', 'app': 'Agil Coletas'},
    {'id': 'fds12321xzcxzc', 'app': 'Posto Plus'},
    {'id': '123dfdscvaqwe2', 'app': 'Posto Plus'},
    {'id': '2353asxcxa1s23', 'app': 'Agil Coletas'},
    {'id': '345sadsa123s23', 'app': 'Agil Coletas'},
    {'id': '657413adxcsd32', 'app': 'Transportes'},
    {'id': '988312sdasih12', 'app': 'Transportes'},
  ];

  late String appOld = '';

  void mudaApp(String app) {
    appOld = app;
  }

  Future showAlertNovaLicenca() async {
    await asuka.showDialog(
      barrierColor: Colors.black12,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(builder: (context, setStateAlert) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nova licença', style: AppTheme.textStyles.titleLicenca),
                const Divider(),
                MyInputWidget(
                  focusNode: fIDPhone,
                  hintText: 'Digite o código do celular',
                  label: 'Código do celular',
                  onChanged: (value) {},
                  textEditingController: controllerIDPhone,
                  formKey: keyIDPhone,
                  maxLength: 20,
                ),
                const SizedBox(height: 10),
                RadioListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  activeColor: AppTheme.colors.primary,
                  title: const Text('Posto Plus'),
                  value: TiposApp.postoPlus,
                  groupValue: tiposApp,
                  onChanged: (TiposApp? value) {
                    setStateAlert(() {
                      tiposApp = value!;
                    });
                  },
                ),
                RadioListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  activeColor: AppTheme.colors.primary,
                  title: const Text('Agil Coletas'),
                  value: TiposApp.agilColetas,
                  groupValue: tiposApp,
                  onChanged: (TiposApp? value) {
                    setStateAlert(() {
                      tiposApp = value!;
                    });
                  },
                ),
                RadioListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  activeColor: AppTheme.colors.primary,
                  title: const Text('Transportes'),
                  value: TiposApp.transportes,
                  groupValue: tiposApp,
                  onChanged: (TiposApp? value) {
                    setStateAlert(() {
                      tiposApp = value!;
                    });
                  },
                ),
                RadioListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  activeColor: AppTheme.colors.primary,
                  title: const Text('Up Vendas'),
                  value: TiposApp.upVendas,
                  groupValue: tiposApp,
                  onChanged: (TiposApp? value) {
                    setStateAlert(() {
                      tiposApp = value!;
                    });
                  },
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          controllerIDPhone.clear();
                        },
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Salvar'),
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: context.screenWidth * .2,
                  child: MyInputWidget(
                    focusNode: fBusca,
                    hintText: 'Digite o código do cliente',
                    label: 'Código do Cliente',
                    onChanged: (value) {},
                    textEditingController: controllerBusca,
                    formKey: keyBusca,
                    inputFormaters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      await showAlertNovaLicenca();
                    },
                    child: const Text('Cadastrar Nova Licença'),
                  ),
                ),
              ],
            ),
            const Divider(),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Cliente: ',
                    style: AppTheme.textStyles.labelCliente,
                  ),
                  TextSpan(
                    text: 'Cooprolat',
                    style: AppTheme.textStyles.textCliente,
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Licenças',
                    style: AppTheme.textStyles.titleLicenca,
                  ),
                  Container(
                    height: 2,
                    width: 150,
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  listaTeste.sort((a, b) => a['app']!.compareTo(b['app']!));

                  late bool visibility = false;

                  if (index == 0 ||
                      listaTeste[index]["app"] !=
                          listaTeste[index - 1]["app"]) {
                    visibility = true;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: visibility,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listaTeste[index]["app"]!,
                              style: AppTheme.textStyles.titleLicenca,
                            ),
                            Container(
                              height: 2,
                              width:
                                  listaTeste[index]["app"]!.length.toDouble() *
                                      11,
                              color: Colors.grey.shade200,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Checkbox(
                          value: true,
                          onChanged: (value) {},
                          activeColor: AppTheme.colors.primary,
                        ),
                        title: Text(listaTeste[index]['id']!),
                        onTap: () {},
                        trailing: SizedBox(
                          width: 40,
                          child: Row(
                            children: [
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: AppTheme.colors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: listaTeste.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
