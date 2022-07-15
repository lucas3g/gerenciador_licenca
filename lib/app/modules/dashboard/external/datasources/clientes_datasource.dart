import 'dart:convert';

import 'package:gerenciador_licenca/app/core_module/constants/constants.dart';
import 'package:gerenciador_licenca/app/core_module/services/client_http/client_http_interface.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/clientes_datasource.dart';

class ClientesDataSource implements IClientesDataSource {
  final IClientHttp clientHttp;

  ClientesDataSource({
    required this.clientHttp,
  });

  @override
  Future<List> getClientes(String nome) async {
    final response = await clientHttp
        .get('$baseUrlCliente/getLicencaHelpDescricao/${Uri.encodeFull(nome)}');

    if (response.statusCode != 200) {
      throw const LicencaException(
          message: 'Erro ao buscar clientes pela descrição');
    }

    if (response.data.toString().trim() == '[]') {
      return [];
    }

    return jsonDecode(response.data)['dados'];
  }

  @override
  Future<dynamic> getClientesByCode(int codCliente) async {
    final response = await clientHttp
        .get('$baseUrlCliente/getLicencaHelpCodigo/$codCliente');

    if (response.statusCode != 200) {
      throw const LicencaException(
          message: 'Erro ao buscar clientes por codigo');
    }

    if (response.data.toString().trim() == '[]') {
      return [];
    }

    return jsonDecode(response.data)['dados'][0];
  }
}
