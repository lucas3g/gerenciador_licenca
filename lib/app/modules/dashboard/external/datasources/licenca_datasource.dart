import 'dart:convert';

import 'package:gerenciador_licenca/app/core_module/constants/constants.dart';
import 'package:gerenciador_licenca/app/core_module/services/client_http/client_http_interface.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/licenca_datasource.dart';

class LicencaDataSource implements ILicencaDataSource {
  final IClientHttp clientHttp;

  LicencaDataSource({
    required this.clientHttp,
  });

  @override
  Future getLicencas(int codCliente) async {
    clientHttp.setHeaders({'cnpj': 'licenca'});

    final responseLicenca =
        await clientHttp.get('$baseUrl/licencas/$codCliente');

    clientHttp.setHeaders({'Content-Type': 'application/json'});

    final responseCliente = await clientHttp
        .get('$baseUrlCliente/getLicencaHelpCodigo/$codCliente');

    if (responseLicenca.statusCode != 200) {
      throw const LicencaException(message: 'Erro ao buscar licenca');
    }

    if (responseCliente.data.toString().trim() == '[]') {
      throw const LicencaException(message: 'Cliente não encontrado');
    }

    late dynamic result = {'licencas': responseLicenca.data};

    result['cliente'] = jsonDecode(responseCliente.data)['dados'][0];

    return result;
  }

  @override
  Future<bool> saveLicenca(dynamic licenca) async {
    clientHttp.setHeaders({'cnpj': 'licenca'});

    final response = await clientHttp.post('$baseUrl/licenca', data: licenca);

    clientHttp.setHeaders({'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      throw const LicencaException(message: 'Erro ao salvar licenca');
    }

    return true;
  }

  @override
  Future<bool> updateLicenca(licenca, String idDevice) async {
    clientHttp.setHeaders({'cnpj': 'licenca'});

    final response =
        await clientHttp.put('$baseUrl/licenca/$idDevice', data: licenca);

    clientHttp.setHeaders({'Content-Type': 'application/json'});

    if (response.statusCode != 200) {
      throw const LicencaException(message: 'Erro ao atualizar licenca');
    }

    return true;
  }
}
