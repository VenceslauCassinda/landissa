class Caixa {
  final String caixaDigital;
  final String caixaFisico;
  final String caixaFisicoAcomulado;
  final String caixaDigitalAcomulado;
  final String totalDespesas;

  static String MOTIVO_SALDO = "S_S_S_S_S";
  Caixa(
      {required this.caixaDigital,
      required this.caixaFisico,
      required this.caixaFisicoAcomulado,
      required this.caixaDigitalAcomulado,
      required this.totalDespesas});
}
