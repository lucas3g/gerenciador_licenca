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
    final response = await clientHttp.get('/licencas/$codCliente');

    if (response.statusCode != 200) {
      throw const LicencaException(message: 'Erro ao buscar licenca');
    }

    return response.data;
  }
}
