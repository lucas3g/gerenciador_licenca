import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_licenca/app/core_module/services/client_http/client_http_interface.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/external/datasources/licenca_datasource.dart';
import 'package:mocktail/mocktail.dart';

import '../../infra/repositories/licenca_repository_test.dart';

class IClientHttpMock extends Mock implements IClientHttp {}

void main() {
  late IClientHttp clientHttp;
  late LicencaDataSource licencaDataSource;

  setUp(() {
    clientHttp = IClientHttpMock();
    licencaDataSource = LicencaDataSource(clientHttp: clientHttp);
  });

  test('deve retornar uma instancia de dynamic', () async {
    when(
      () => clientHttp.get('/licencas/1'),
    ).thenAnswer(
      (_) async => BaseResponse(
        json,
        BaseRequest(url: '/licencas', method: 'GET'),
      ),
    );

    final result = await licencaDataSource.getLicencas(1);

    expect(result, isA<dynamic>());
  });
}
