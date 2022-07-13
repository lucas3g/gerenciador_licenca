import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/new_licenca_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/licenca_repository.dart';

abstract class ISaveLicencaUseCase {
  Future<Either<ILicencaException, bool>> call(NewLicencaEntity licencaEntity);
}

class SaveLicencaUseCase implements ISaveLicencaUseCase {
  final ILicencaRepository licencaRepository;

  SaveLicencaUseCase({
    required this.licencaRepository,
  });

  @override
  Future<Either<ILicencaException, bool>> call(
      NewLicencaEntity licencaEntity) async {
    return await licencaRepository.saveLicenca(licencaEntity);
  }
}
