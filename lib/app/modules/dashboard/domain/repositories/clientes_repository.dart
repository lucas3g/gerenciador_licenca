import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/cliente_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';

abstract class IClientesRepository {
  Future<Either<ILicencaException, List<ClienteEntity>>> getClientes(
      String nome);
}
