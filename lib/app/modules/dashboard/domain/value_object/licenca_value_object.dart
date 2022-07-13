class LicencaValueObject {
  final String id;
  final String app;
  final int idApp;
  final String descricao;
  final String apelido;
  String ativo;

  LicencaValueObject({
    required this.id,
    required this.app,
    required this.ativo,
    required this.idApp,
    required this.descricao,
    required this.apelido,
  });
}
