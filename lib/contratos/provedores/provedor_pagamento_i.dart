import '../../dominio/entidades/forma_pagamento.dart';
import '../../dominio/entidades/pagamento.dart';
import '../../dominio/entidades/pagamento_final.dart';

abstract class ProvedorPagamentoI {
  Future<int> registarPagamento(Pagamento pagamento);
  Future<List<Pagamento>> pegarLista();
  Future<int> adicionarFormaPagamento(FormaPagamento forma);
  Future<List<FormaPagamento>> pegarListaFormasPagamento();
  Future<bool> existeFormaDeDescricao(String descricao);
  Future<int> removerFormaDeId(int idForma);
  Future<int> registarPagamentoFinal(PagamentoFinal pagamentoFinal);
}
