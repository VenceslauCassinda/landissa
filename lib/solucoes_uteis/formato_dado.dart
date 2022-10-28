import 'package:intl/intl.dart';

String formatar(double valor) {
  if (valor <= 999 && valor >= 0) {
    return "$valor".replaceAll(".0", "");
  }
  var f = NumberFormat("#,###,000");
  return f.format(valor);
}

String formatarInteiroComMilhares(int valor) {
  if (valor <= 999 && valor >= 0) {
    return "$valor".replaceAll(".0", "");
  }
  var f = NumberFormat("#,###,000");
  return f.format(valor);
}
