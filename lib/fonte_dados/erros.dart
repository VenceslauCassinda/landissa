class Erro implements Exception {
  late String sms;
  bool? naoMostrarErro;
  Erro(this.sms, {this.naoMostrarErro}) {
    sms = "Erro: $sms";
    if (naoMostrarErro == true) {
      print(sms);
    }
  }
}

class ErroUsuarioJaExiste extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroUsuarioJaExiste(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroLicencaExpirada extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroLicencaExpirada(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroFuncionarioJaExiste extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroFuncionarioJaExiste(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroUsuarioNaoExiste extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroUsuarioNaoExiste(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroUsuarioJaLogado extends Erro {
  bool? naoMostrarErro;
  String sms;
  ErroUsuarioJaLogado(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroUsuarioNaoLogado extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroUsuarioNaoLogado(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroProdutoExistente extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroProdutoExistente(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroProdutoComPrecoExistente extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroProdutoComPrecoExistente(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroPercentagemInvalida extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroPercentagemInvalida(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroVendaInvalida extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroVendaInvalida(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroStockInsuficiente extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroStockInsuficiente(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroPagamentoInvalido extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroPagamentoInvalido(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroFormaPagamentoExistente extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroFormaPagamentoExistente(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}

class ErroQuantidadeInsuficiente extends Erro {
  String sms;
  bool? naoMostrarErro;
  ErroQuantidadeInsuficiente(this.sms, {this.naoMostrarErro})
      : super(sms, naoMostrarErro: naoMostrarErro);
}
