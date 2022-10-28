import 'package:yetu_gestor/dominio/entidades/pagamento.dart';
import 'package:yetu_gestor/dominio/entidades/pagamento_final.dart';

import '../../dominio/entidades/forma_pagamento.dart';

abstract class ManipularPagamentoI {
  Future<int> registarPagamento(Pagamento pagamento);
  Future<int> registarPagamentoFinal(PagamentoFinal pagamentoFinal);
  Future<void> registarListaPagamentos(List<Pagamento> lista, int idVenda);
  Future<List<Pagamento>> pegarLista();
  Future<int> adicionarFormaPagamento(FormaPagamento forma);
  Future<bool> existeFormaDeDescricao(String descricao);
  Future<int> removerFormaDeId(int idForma);
  Future<List<FormaPagamento>> pegarListaFormasPagamento();
}
