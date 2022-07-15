import 'package:dio/dio.dart';
import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/licencas_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/new_licenca_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/licenca_repository.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/adapters/licenca_adapter.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/adapters/new_licenca_adapter.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/clientes_datasource.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/licenca_datasource.dart';

class LicencaRepository implements ILicencaRepository {
  final ILicencaDataSource licencaDataSource;
  final IClientesDataSource clientesDataSource;

  LicencaRepository({
    required this.licencaDataSource,
    required this.clientesDataSource,
  });

  @override
  Future<Either<ILicencaException, LicencasEntity>> getLicencas(
      int codCliente) async {
    try {
      final resultLicencas = await licencaDataSource.getLicencas(codCliente);
      final resultClientes =
          await clientesDataSource.getClientesByCode(codCliente);

      final result = {'licencas': resultLicencas};

      if (resultClientes.toString().trim() == '[]') {
        return left(
            const LicencaException(message: 'Nenhum cliente encontrado.'));
      }

      result['cliente'] = resultClientes;

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
