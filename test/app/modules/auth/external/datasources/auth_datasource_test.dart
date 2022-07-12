import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_licenca/app/core_module/services/client_http/client_http_interface.dart';
import 'package:gerenciador_licenca/app/modules/auth/external/adapters/params_to_json.dart';
import 'package:gerenciador_licenca/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../params/params.dart';

class IClientHttpMock extends Mock implements IClientHttp {}

void main() {
  late IClientHttp clientHttp;
  late AuthDataSource authDataSource;

  setUp(() {
    clientHttp = IClientHttpMock();
    authDataSource = AuthDataSource(clientHttp: clientHttp);
  });

  test('deve retornar uma instacia de dynamic', () async {
    when(
      () => clientHttp.post('/user', data: ParamsToJson.toJson(loginParams)),
    ).thenAnswer((_) async => BaseResponse(
        {'id': 1, 'name': 'lucas'}, BaseRequest(url: '/user', method: 'POST')));

    final result = authDataSource.login(loginParams);

    expect(result, isA<dynamic>());
  });
}
