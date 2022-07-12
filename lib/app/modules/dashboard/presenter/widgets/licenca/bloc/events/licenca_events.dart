abstract class LicencaEvents {}

class GetLicencaEvent extends LicencaEvents {
  final int codCliente;

  GetLicencaEvent({
    required this.codCliente,
  });
}
