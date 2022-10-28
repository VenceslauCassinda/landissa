class Estado {
  static int ELIMINADO = -1;
  static int DESACTIVADO = 0;
  static int ATIVADO = 1;

  static String paraTexto(int estado) {
    if (estado == ELIMINADO) {
      return "Eliminado";
    }
    if (estado == DESACTIVADO) {
      return "Desactivado";
    }
    return "Activado";
  }

  static int paraInteiro(String estado) {
    if (estado == "Eliminado") {
      return ELIMINADO;
    }
    if (estado == "Desactivado") {
      return DESACTIVADO;
    }
    return ATIVADO;
  }
}
