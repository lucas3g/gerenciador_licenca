import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/licencas_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/new_licenca_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';

abstract class ILicencaRepository {
  Future<Either<ILicencaException, LicencasEntity>> getLicencas(int codCliente);
  Future<Either<ILicencaException, bool>> saveLicenca(
      NewLicencaEntity licencaEntity);
  Future<Either<ILicencaException, bool>> updateLicenca(
      NewLicencaEntity licencaEntity, String idDevice);
}
