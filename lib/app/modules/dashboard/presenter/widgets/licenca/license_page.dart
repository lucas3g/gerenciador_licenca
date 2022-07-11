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
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppTheme.colors.primary,
                    ),
                    title: const Text('ID: 298fda878qwe13'),
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
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
