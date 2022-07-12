import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/licencas_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/licenca_repository.dart';

abstract class IGetLicencasUseCase {
  Future<Either<ILicencaException, LicencasEntity>> call(int codCliente);
}

class GetLicencasUseCase implements IGetLicencasUseCase {
  final ILicencaRepository licencaRepository;

  GetLicencasUseCase({
    required this.licencaRepository,
  });

  @override
  Future<Either<ILicencaException, LicencasEntity>> call(int codCliente) async {
    return await licencaRepository.getLicencas(codCliente);
  }
}
