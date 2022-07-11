import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gerenciador_licenca/app/components/my_input_widget.dart';
import 'package:gerenciador_licenca/app/theme/app_theme.dart';
import 'package:gerenciador_licenca/app/utils/constants.dart';

class LicencaPage extends StatefulWidget {
  const LicencaPage({Key? key}) : super(key: key);

  @override
  State<LicencaPage> createState() => _LicencaPageState();
}

class _LicencaPageState extends State<LicencaPage> {
  FocusNode fBusca = FocusNode();

  TextEditingController controllerBusca = TextEditingController();

  GlobalKey<FormState> keyBusca = GlobalKey<FormState>();
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
                    onPressed: () {},
                    child: const Text('Cadastrar Nova Licença'),
                  ),
                ),
              ],
            ),
            const Divider(),
            Center(
              child: Text(
                'Licenças',
                style: AppTheme.textStyles.titleLicenca,
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
                    title: Text('$index'),
                    onTap: () {},
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
