import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_i.dart';
import 'package:yetu_gestor/contratos/casos_uso/manipular_stock_i.dart';
import 'package:yetu_gestor/contratos/provedores/provedor_dividas_i.dart';
import 'package:yetu_gestor/dominio/entidades/divida.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/dominio/entidades/saida.dart';
import 'package:yetu_gestor/solucoes_uteis/utils.dart';

import '../../contratos/casos_uso/manipular_divida_i.dart';

class ManipularDivida implements ManipularDividaI {
  final ProvedorDividaI _dividaI;
  final ManipularSaidaI _manipularSaidaI;
  final ManipularStockI _manipularStockI;

  ManipularDivida(this._dividaI, this._manipularSaidaI, this._manipularStockI);
  @override
  Future<bool> actualizarDivida(Divida divida) async {
    return await _dividaI.actualizarDivida(divida);
  }

  @override
  Future<List<Divida>> pegarListaTodasDividas() async {
    return await _dividaI.pegarListaTodasDividas();
  }

  @override
  Future<int> registarDivida(Divida divida) async {
    await _manipularSaidaI.registarSaida(Saida(
        estado: Estado.ATIVADO,
        idProduto: divida.idProduto,
        quantidade: divida.quantidadeDevida,
        data: divida.data,
        motivo: Saida.MOTIVO_DIVIDA));
    return await _dividaI.registarDivida(divida);
  }

  @override
  Future<bool> removerDivida(Divida divida) async {
    if (divida.paga == false) {
      await _manipularStockI.aumentarQuantidadeStock(
          divida.idProduto!, divida.quantidadeDevida!);
    }
    return await _dividaI.removerDivida(divida);
  }

  @override
  Future<bool> removerTodasDividas() async {
    return await _dividaI.removerTodasDividas();
  }

  @override
  removerAntes(DateTime dataSelecionada) async {
    var res = await pegarListaTodasDividas();
    for (var cada in res) {
      if (comapararDatas(cada.data!, dataSelecionada)) {
        await removerDivida(cada);
      }
    }
  }
}
