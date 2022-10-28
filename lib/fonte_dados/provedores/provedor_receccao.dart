import 'package:get/get.dart';
import 'package:yetu_gestor/fonte_dados/padrao_dao/base_dados.dart';
import '../../contratos/provedores/provedor_receccao_i.dart';
import '../../dominio/entidades/receccao.dart';

class ProvedorRececcao implements ProvedorRececcaoI {
  late RececcaoDao _dao;
  ProvedorRececcao() {
    _dao = RececcaoDao(Get.find());
  }
  @override
  Future<int> receberProduto(Receccao receccao) async {
    return await _dao.adicionarRececcao(receccao);
  }

  @override
  Future<void> actualizaRececcao(Receccao receccao) async {
    await _dao.actualizaRececcao(receccao);
  }

  @override
  Future<void> removerRececcao(Receccao receccao) async {
    await _dao.removerRececcao(receccao);
  }

  @override
  Future<List<Receccao>> todas() async {
    return await _dao.todas();
  }

  @override
  Future<int> adicionarrRececcao(Receccao receccao) async {
    return await _dao.adicionarRececcao(receccao);
  }

  @override
  Future<Receccao?> pegarRececcaoDeId(int id) async {
    var res = await _dao.pegarRececcaoDeId(id);
    if (res != null) {
      return Receccao(
        estado: res.estado,
        pagavel: res.pagavel,
        paga: res.paga,
        idFuncionario: res.idFuncionario,
        idPagante: res.idPagante,
        idProduto: res.idProduto,
        custoAquisicao: res.custoAquisicao,
        precoLote: res.precoLote,
        quantidadeLotes: res.quantidadeLotes,
        quantidadePorLotes: res.quantidadePorLotes,
        data: res.data,
        dataPagamento: res.dataPagamento,
      );
    }
    return null;
  }

  @override
  Future<List<Receccao>> pegarListaRececcoesFuncionario(int id) async {
    return await _dao.todasDoFuncionario(id);
  }

  @override
  Future<void> removerTudo() async {
    await _dao.removerTudo();
  }

  @override
  Future<void> removerAntes(DateTime data) async {
    await _dao.removerAntes(data);
  }
}
