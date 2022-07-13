import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/new_licenca_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/licenca_repository.dart';

abstract class IUpdateLicencaUseCase {
  Future<Either<ILicencaException, bool>> call(
      NewLicencaEntity licencasEntity, String idDevice);
}

class UpdateLicencaUseCase implements IUpdateLicencaUseCase {
  final ILicencaRepository licencaRepository;

  UpdateLicencaUseCase({
    required this.licencaRepository,
  });
  @override
  Future<Either<ILicencaException, bool>> call(
      NewLicencaEntity licencasEntity, String idDevice) async {
    return await licencaRepository.updateLicenca(licencasEntity, idDevice);
  }
}
