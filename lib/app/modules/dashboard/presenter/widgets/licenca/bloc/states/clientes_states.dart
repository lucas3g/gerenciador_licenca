import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/cliente_entity.dart';

abstract class ClientesStates {}

class ClientesInitialState extends ClientesSuccessState {
  ClientesInitialState() : super(clientes: []);
}

class ClientesLoadingState extends ClientesStates {}

class ClientesSuccessState extends ClientesStates {
  final List<ClienteEntity> clientes;

  ClientesSuccessState({
    required this.clientes,
  });
}

class ClientesErrorState extends ClientesStates {
  final String message;

  ClientesErrorState({
    required this.message,
  });
}
