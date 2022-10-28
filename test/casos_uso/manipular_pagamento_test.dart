import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_pagamento_i.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_pagamento.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/forma_pagamento.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_pagamento.dart';

import '../configuracao/test_config.dart';

void main() {
  TestConfig.prepareInitDataBase();
  Get.put(BancoDados());

  ManipularPagamentoI manipularPagamentoI =
      ManipularPagamento(ProvedorPagamento());
  test("ADICIONAR FORMA DE PAGAMENTO", () async {
    // await manipularPagamentoI.adicionarFormaPagamento(
        // FormaPagamento(estado: Estado.ATIVADO, tipo: 1, descricao: "CHASH"));
    await manipularPagamentoI.adicionarFormaPagamento(FormaPagamento(estado: Estado.ATIVADO, tipo: 2, descricao: "TRANFERENCIA"));
  });

  test("LISTAR PAGAMENTOS", () async {
    var lista = await manipularPagamentoI.pegarListaFormasPagamento();
    for (var cada in lista) {
      print(cada.toString());
    }
  });
}
