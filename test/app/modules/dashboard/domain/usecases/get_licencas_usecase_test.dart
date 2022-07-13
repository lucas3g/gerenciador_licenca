// import 'package:flutter_test/flutter_test.dart';
// import 'package:gerenciador_licenca/app/core_module/types/either.dart';
// import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/licencas_entity.dart';
// import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/licenca_repository.dart';
// import 'package:gerenciador_licenca/app/modules/dashboard/domain/usecases/get_licencas_usecase.dart';
// import 'package:gerenciador_licenca/app/modules/dashboard/domain/value_object/cliente_value_object.dart';
// import 'package:gerenciador_licenca/app/modules/dashboard/domain/value_object/licenca_value_object.dart';
// import 'package:mocktail/mocktail.dart';

// class ILicencaRepositoryMock extends Mock implements ILicencaRepository {}

// void main() {
//   late ILicencaRepository licencaRepository;
//   late GetLicencasUseCase getLicencasUseCase;

//   setUp(() {
//     licencaRepository = ILicencaRepositoryMock();
//     getLicencasUseCase =
//         GetLicencasUseCase(licencaRepository: licencaRepository);
//   });

//   test('deve retornar uma instancia de LicencaEntity', () async {
//     when(
//       () => licencaRepository.getLicencas(1),
//     ).thenAnswer(
//       (_) async => right(
//         LicencasEntity(
//           cliente: ClienteValueObject(
//               name: 'name', CNPJCPF: 'CNPJCPF', telefone: 'telefone'),
//           licencas: [LicencaValueObject(id: '1', app: 'app', ativo: 'ativo')],
//         ),
//       ),
//     );

//     final result = await getLicencasUseCase(1);

//     expect(result.fold(id, id), isA<LicencasEntity>());
//   });
// }
