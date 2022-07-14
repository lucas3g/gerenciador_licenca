import 'package:dio/dio.dart';
import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/cliente_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/clientes_repository.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/adapters/list_clientes_adapter.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/infra/datasources/clientes_datasource.dart';

class ClientesRepository implements IClientesRepository {
  final IClientesDataSource clientesDataSource;

  ClientesRepository({
    required this.clientesDataSource,
  });

  @override
  Future<Either<ILicencaException, List<ClienteEntity>>> getClientes(
      String nome) async {
    try {
      final result = await clientesDataSource.getClientes(nome);

      final List<ClienteEntity> clientes = [];

      for (var cliente in result) {
        clientes.add(ListClientesAdapter.fromMap(cliente));
      }

      return right(clientes);
    } on ILicencaException catch (e) {
      return left(e);
    } on DioError catch (e) {
      return left(LicencaException(message: e.message));
    } catch (e) {
      return left(LicencaException(message: e.toString()));
    }
  }
}
