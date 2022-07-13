import 'package:dio/dio.dart';
import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/licencas_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/new_licenca_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/licenca_repository.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/adapters/licenca_adapter.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/adapters/new_licenca_adapter.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/licenca_datasource.dart';

class LicencaRepository implements ILicencaRepository {
  final ILicencaDataSource licencaDataSource;

  LicencaRepository({
    required this.licencaDataSource,
  });

  @override
  Future<Either<ILicencaException, LicencasEntity>> getLicencas(
      int codCliente) async {
    try {
      final result = await licencaDataSource.getLicencas(codCliente);

      final map = LicencaAdapter.fromMap(result);

      return right(map);
    } on ILicencaException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(LicencaException(message: e.message));
    } catch (e) {
      return left(LicencaException(message: e.toString()));
    }
  }

  @override
  Future<Either<ILicencaException, bool>> saveLicenca(
      NewLicencaEntity licencaEntity) async {
    try {
      final result = await licencaDataSource
          .saveLicenca(NewLicencaAdapter.toJson(licencaEntity));

      return right(result);
    } on ILicencaException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(LicencaException(message: e.message));
    } catch (e) {
      return left(LicencaException(message: e.toString()));
    }
  }

  @override
  Future<Either<ILicencaException, bool>> updateLicenca(
      NewLicencaEntity licencaEntity, String idDevice) async {
    try {
      final result = await licencaDataSource.updateLicenca(
          NewLicencaAdapter.toJson(licencaEntity), idDevice);

      return right(result);
    } on ILicencaException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(LicencaException(message: e.message));
    } catch (e) {
      return left(LicencaException(message: e.toString()));
    }
  }
}
