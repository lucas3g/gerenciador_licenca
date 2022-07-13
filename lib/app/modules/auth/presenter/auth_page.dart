import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gerenciador_licenca/app/components/my_input_widget.dart';
import 'package:gerenciador_licenca/app/modules/auth/domain/params/login_params.dart';
import 'package:gerenciador_licenca/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:gerenciador_licenca/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:gerenciador_licenca/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:gerenciador_licenca/app/theme/app_theme.dart';
import 'package:gerenciador_licenca/app/utils/constants.dart';
import 'package:gerenciador_licenca/app/utils/formatters.dart';
import 'package:gerenciador_licenca/app/utils/my_snackbar.dart';

class AuthPage extends StatefulWidget {
  final AuthBloc authBloc;
  const AuthPage({Key? key, required this.authBloc}) : super(key: key);

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

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    sub = widget.authBloc.stream.listen((state) async {
      if (state is AuthSuccessState) {
        await Future.delayed(const Duration(milliseconds: 600));
        Modular.to.navigate('/dash/');
      }

      if (state is AuthErrorState) {
        Modular.to.navigate('/dash/');
        MySnackBar(message: state.message);
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    widget.authBloc.close();
    super.dispose();
  }

  void login() {
    final loginParams = LoginParams(
      user: controllerUser.text.trim(),
      password: controllerPass.text.trim(),
    );

    widget.authBloc.add(
      LoginEvent(loginParams: loginParams),
    );
  }

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
                autoFocus: true,
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
                onFieldSubmitted: (value) {
                  login();
                },
                textEditingController: controllerPass,
                formKey: keyPass,
                obscureText: true,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<AuthBloc, AuthStates>(
                      bloc: widget.authBloc,
                      builder: (context, state) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(context.screenWidth * .2, 40),
                          ),
                          onPressed: state is AuthLoadingState
                              ? null
                              : () {
                                  login();
                                },
                          child: state is AuthLoadingState
                              ? const Center(
                                  child: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const Text('Entrar'),
                        );
                      }),
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
