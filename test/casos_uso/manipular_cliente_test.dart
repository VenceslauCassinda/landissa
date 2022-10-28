import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_cliente_I.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_cliente.dart';
import 'package:yetu_gestor/dominio/entidades/cliente.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_cliente.dart';

import '../configuracao/test_config.dart';

void main() {
  TestConfig.prepareInitDataBase();
  Get.put(BancoDados());

  ManipularClienteI manipularClienteI = ManipularCliente(ProvedorCliente());

  test("LISTAR CLIENTES", () async {
    var lista = await manipularClienteI.todos();
    for (var cada in lista) {
      print(cada.toString());
    }
  });

  test("ADICIONAR CLIENTE", () async {
    await manipularClienteI.registarCliente(
        Cliente(estado: Estado.ATIVADO, nome: "Ady", numero: "999999"));
  });
}
