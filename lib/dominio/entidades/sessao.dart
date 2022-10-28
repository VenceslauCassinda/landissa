class Sessao {
  static bool INICIADA = true;
  static bool TERMINADA = false;

  static String paraTexto(bool valor) {
    if (valor == TERMINADA) {
      return "Terminada";
    }
    return "Iniciada";
  }

  static bool paraBoleano(String valor) {
    if (valor == "Terminada") {
      return TERMINADA;
    }
    return INICIADA;
  }
}
