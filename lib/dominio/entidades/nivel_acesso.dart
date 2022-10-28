class NivelAcesso {
  static int FUNCIONARIO = 0;
  static int GERENTE = 1;
  static int ADMINISTRADOR = 2;

  static String paraTexto(int nivel) {
    if (nivel == FUNCIONARIO) {
      return "Funcionário";
    }
    if (nivel == GERENTE) {
      return "Gerente";
    }
    return "Administrador";
  }

  static int paraInteiro(String nivel) {
    if (nivel == "Funcionário") {
      return FUNCIONARIO;
    }
    if (nivel == "Gerente") {
      return GERENTE;
    }
    return ADMINISTRADOR;
  }
}
