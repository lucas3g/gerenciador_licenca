import 'package:gerenciador_licenca/app/core_module/types/either.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/entities/cliente_entity.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/exceptions/licenca_exception.dart';
import 'package:gerenciador_licenca/app/modules/dashboard/domain/repositories/clientes_repository.dart';

abstract class IGetClientesUseCase {
  Future<Either<ILicencaException, List<ClienteEntity>>> call(String nome);
}

class GetClientesUseCase implements IGetClientesUseCase {
  final IClientesRepository clientesRepository;

  GetClientesUseCase({
    required this.clientesRepository,
  });

  @override
  Future<Either<ILicencaException, List<ClienteEntity>>> call(
      String nome) async {
    if (nome.trim().isEmpty) {
      return left(
        const LicencaException(message: 'Nome não pode ser vazio.'),
      );
    }

    final result = await clientesRepository.getClientes(nome);

    return result;
  }
}
