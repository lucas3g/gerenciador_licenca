abstract class ILicencaDataSource {
  Future<dynamic> getLicencas(int codCliente);
  Future<bool> saveLicenca(dynamic licenca);
  Future<bool> updateLicenca(dynamic licenca, String idDevice);
}
