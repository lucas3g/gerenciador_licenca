import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/licencas_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/clientes_datasource.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/licenca_datasource.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/repositories/licenca_repository.dart';
import 'package:mocktail/mocktail.dart';

class ILicencaDataSourceMock extends Mock implements ILicencaDataSource {}

class IClientesDataSourceMock extends Mock implements IClientesDataSource {}

void main() {
  late ILicencaDataSource licencaDataSource;
  late IClientesDataSource clientesDataSource;
  late LicencaRepository licencaRepository;

  setUp(() {
    licencaDataSource = ILicencaDataSourceMock();
    clientesDataSource = IClientesDataSourceMock();
    licencaRepository = LicencaRepository(
      licencaDataSource: licencaDataSource,
      clientesDataSource: clientesDataSource,
    );
  });

  test('deve retornar uma instancia de LicencaEntity', () async {
    when(
      () => licencaDataSource.getLicencas(1),
    ).thenAnswer((_) async => json);

    final result = await licencaRepository.getLicencas(1);

    expect(result.fold(id, id), isA<LicencasEntity>());
  });
}

final json = {
  'cliente': {
    'name': 'lucas',
    'id': 4564,
    'telefone': '5499727330',
    'CNPJCPF': '041.726.830-02',
  },
  'licencas': [
    {
      'id': 'asdsadsa123',
      'app': 'Posto Plus',
      'ativo': 'S',
    },
    {
      'id': 'asd21312',
      'app': 'Posto Plus',
      'ativo': 'S',
    },
    {
      'id': 'dads21312',
      'app': 'Agil Coletas',
      'ativo': 'S',
    },
  ]
};
