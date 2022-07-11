import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/components/my_input_widget.dart';
import 'package:gerenciador_licenca/app/theme/app_theme.dart';
import 'package:gerenciador_licenca/app/utils/constants.dart';
import 'package:gerenciador_licenca/app/utils/formatters.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  FocusNode fUser = FocusNode();
  FocusNode fPass = FocusNode();

  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  GlobalKey<FormState> keyUser = GlobalKey<FormState>();
  GlobalKey<FormState> keyPass = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: context.screenWidth * .5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.colors.primary,
                  blurRadius: 5,
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'EL',
                    style: AppTheme.textStyles.titleLogin,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Sistemas',
                    style: AppTheme.textStyles.titleLoginBlack,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fUser,
                hintText: 'Digite seu Usuário',
                label: 'Usuário',
                onChanged: (_) {},
                onFieldSubmitted: (value) {
                  fPass.requestFocus();
                },
                textEditingController: controllerUser,
                formKey: keyUser,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 15),
              MyInputWidget(
                focusNode: fPass,
                hintText: 'Digite sua Senha',
                label: 'Senha',
                onChanged: (_) {},
                onFieldSubmitted: (value) {},
                textEditingController: controllerPass,
                formKey: keyPass,
                obscureText: true,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(context.screenWidth * .2, 40),
                    ),
                    onPressed: () {
                      Modular.to.navigate('/dash/');
                    },
                    child: const Text('Entrar'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(context.screenWidth * .2, 40),
                    ),
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text('Sair'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
