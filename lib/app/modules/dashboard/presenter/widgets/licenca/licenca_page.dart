import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gerenciador_licenca/app/components/my_input_widget.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/new_licenca_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/events/licenca_events.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/licenca_bloc.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/presenter/widgets/licenca/bloc/states/licenca_states.dart';
import 'package:gerenciador_licenca/app/theme/app_theme.dart';
import 'package:gerenciador_licenca/app/utils/constants.dart';
import 'package:asuka/asuka.dart' as asuka;

enum TiposApp {
  upVendas,
  agilColetas,
  postoPlus,
  transportes,
}

class LicencaPage extends StatefulWidget {
  final LicencaBloc licencaBloc;
  const LicencaPage({Key? key, required this.licencaBloc}) : super(key: key);

  @override
  State<LicencaPage> createState() => _LicencaPageState();
}

class _LicencaPageState extends State<LicencaPage> {
  FocusNode fBusca = FocusNode();
  FocusNode fIDPhone = FocusNode();
  FocusNode fDescricao = FocusNode();
  FocusNode fF12 = FocusNode();
  FocusNode fPesquisaCliente = FocusNode();

  TextEditingController controllerBusca = TextEditingController();
  TextEditingController controllerIDPhone = TextEditingController();
  TextEditingController controllerDescricao = TextEditingController();
  TextEditingController controllerPesquisa = TextEditingController();

  GlobalKey<FormState> keyBusca = GlobalKey<FormState>();
  GlobalKey<FormState> keyIDPhone = GlobalKey<FormState>();
  GlobalKey<FormState> keyDescricao = GlobalKey<FormState>();
  GlobalKey<FormState> keyPesquisa = GlobalKey<FormState>();

  late TiposApp tiposApp = TiposApp.upVendas;

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    sub = widget.licencaBloc.stream.listen((state) {
      if (state is LicencaSaveSucessState ||
          state is LicencaUpdateSucessState) {
        widget.licencaBloc.add(
          GetLicencaEvent(
              codCliente: int.tryParse(controllerBusca.text.trim()) ?? 0),
        );
      }
    });
  }

  Future showAlertNovaLicenca({required String cnpj}) async {
    await asuka.showDialog(
      barrierColor: Colors.black12,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (context, setStateAlert) {
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
                  MyInputWidget(
                    focusNode: fDescricao,
                    hintText: 'Digite descrição da licença',
                    label: 'Descrição',
                    onChanged: (value) {},
                    textEditingController: controllerDescricao,
                    formKey: keyDescricao,
                  ),
                  const SizedBox(height: 10),
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
                    title: const Text('Transportes'),
                    value: TiposApp.transportes,
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
                          onPressed: () {
                            final newLicencaEntity = NewLicencaEntity(
                              ID_DEVICE: controllerIDPhone.text.trim(),
                              APELIDO: cnpj
                                  .replaceAll('.', '')
                                  .replaceAll('/', '')
                                  .replaceAll('-', ''),
                              ATIVO: 'S',
                              ID_EMPRESA:
                                  int.tryParse(controllerBusca.text.trim()) ??
                                      0,
                              DESCRICAO: controllerDescricao.text.trim(),
                              ID_APP: tiposApp.index + 1,
                            );

                            widget.licencaBloc.add(
                              SaveLicencaEvent(
                                licencaEntity: newLicencaEntity,
                              ),
                            );

                            Navigator.pop(context);
                          },
                          child: const Text('Salvar'),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> showModalPesquisaCliente() async {
    await asuka.showDialog(
      barrierColor: Colors.black12,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Pesquisar cliente'),
              const Divider(),
              MyInputWidget(
                autoFocus: true,
                focusNode: fPesquisaCliente,
                hintText: 'Digite o nome do cliente',
                label: 'Nome do Cliente',
                onChanged: (value) {},
                textEditingController: controllerPesquisa,
                formKey: keyPesquisa,
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: context.screenHeight * .5,
                width: context.screenWidth * .5,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: const Text('Lucas Silva'),
                      onTap: () {
                        Navigator.pop(context);
                        controllerBusca.text = '$index';
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
    controllerPesquisa.clear();
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
                  child: RawKeyboardListener(
                    focusNode: fF12,
                    onKey: (key) async {
                      if (key.isKeyPressed(LogicalKeyboardKey.f12)) {
                        controllerBusca.clear();
                        await showModalPesquisaCliente();
                      }
                    },
                    child: MyInputWidget(
                      autoFocus: false,
                      focusNode: fBusca,
                      hintText: 'Digite o código do cliente',
                      label: 'Código do Cliente',
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {
                        widget.licencaBloc.add(
                          GetLicencaEvent(
                            codCliente:
                                int.tryParse(controllerBusca.text.trim()) ?? 0,
                          ),
                        );
                      },
                      textEditingController: controllerBusca,
                      formKey: keyBusca,
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 45,
                  child: BlocBuilder<LicencaBloc, LicencaStates>(
                    bloc: widget.licencaBloc,
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is LicencaSuccessState &&
                                controllerBusca.text.trim().isNotEmpty
                            ? () async {
                                await showAlertNovaLicenca(
                                  cnpj: state.licencasEntity.cliente.CNPJCPF,
                                );
                              }
                            : null,
                        child: const Text('Cadastrar Nova Licença'),
                      );
                    },
                  ),
                ),
              ],
            ),
            const Divider(),
            BlocBuilder<LicencaBloc, LicencaStates>(
              bloc: widget.licencaBloc,
              builder: (context, state) {
                if (state is LicencaInitialState) {
                  return Container();
                }

                if (state is LicencaErrorState) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                }

                if (state is! LicencaSuccessState) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final listLicencas = state.licencasEntity;

                if (listLicencas.licencas.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Cliente: ',
                              style: AppTheme.textStyles.labelCliente,
                            ),
                            TextSpan(
                              text: listLicencas.cliente.name,
                              style: AppTheme.textStyles.textCliente,
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text('Nenhuma Licença encontrada'),
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Cliente: ',
                            style: AppTheme.textStyles.labelCliente,
                          ),
                          TextSpan(
                            text: listLicencas.cliente.name,
                            style: AppTheme.textStyles.textCliente,
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'CNPJ: ',
                            style: AppTheme.textStyles.labelCliente,
                          ),
                          TextSpan(
                            text: listLicencas.cliente.CNPJCPF,
                            style: AppTheme.textStyles.textCliente,
                          ),
                          TextSpan(
                            text: ' TELEFONE: ',
                            style: AppTheme.textStyles.labelCliente,
                          ),
                          TextSpan(
                            text: listLicencas.cliente.telefone,
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
                    SizedBox(
                      height: context.screenHeight * .65,
                      width: context.screenWidth,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          late bool visibility = false;

                          if (index == 0 ||
                              listLicencas.licencas[index].app !=
                                  listLicencas.licencas[index - 1].app) {
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
                                      listLicencas.licencas[index].app,
                                      style: AppTheme.textStyles.titleLicenca,
                                    ),
                                    Container(
                                      height: 2,
                                      width: listLicencas
                                              .licencas[index].app.length
                                              .toDouble() *
                                          11,
                                      color: Colors.grey.shade200,
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                              ListTile(
                                leading: Checkbox(
                                  value:
                                      listLicencas.licencas[index].ativo == 'S'
                                          ? true
                                          : false,
                                  onChanged: (bool? value) {
                                    final licencaEntity = NewLicencaEntity(
                                      ID_DEVICE:
                                          listLicencas.licencas[index].id,
                                      APELIDO:
                                          listLicencas.licencas[index].apelido,
                                      ATIVO:
                                          listLicencas.licencas[index].ativo ==
                                                  'S'
                                              ? 'N'
                                              : 'S',
                                      ID_EMPRESA: int.tryParse(
                                              controllerBusca.text.trim()) ??
                                          0,
                                      DESCRICAO: listLicencas
                                          .licencas[index].descricao,
                                      ID_APP:
                                          listLicencas.licencas[index].idApp,
                                    );

                                    widget.licencaBloc.add(
                                      UpdateLicencaEvent(
                                        licencaEntity: licencaEntity,
                                        idDevice: licencaEntity.ID_DEVICE,
                                      ),
                                    );
                                  },
                                  activeColor: AppTheme.colors.primary,
                                ),
                                title: Text(listLicencas.licencas[index].id),
                                subtitle: listLicencas
                                        .licencas[index].descricao.isNotEmpty
                                    ? Text(
                                        listLicencas.licencas[index].descricao)
                                    : null,
                                onTap: () {},
                                // trailing: SizedBox(
                                //   width: 40,
                                //   child: Row(
                                //     children: [
                                //       IconButton(
                                //         splashRadius: 20,
                                //         onPressed: () {},
                                //         icon: Icon(
                                //           Icons.delete_outline_rounded,
                                //           color: AppTheme.colors.primary,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemCount: listLicencas.licencas.length,
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
