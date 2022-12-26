import 'package:yetu_gestor/contratos/casos_uso/manipular_produto_i.dart';
import 'package:yetu_gestor/dominio/entidades/produto.dart';
import 'package:yetu_gestor/dominio/entidades/funcionario.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';
import 'package:yetu_gestor/solucoes_uteis/utils.dart';
import '../../contratos/casos_uso/manipular_entrada_i.dart';
import '../../contratos/casos_uso/manipular_receccao_i.dart';
import '../../contratos/provedores/provedor_receccao_i.dart';
import '../entidades/entrada.dart';
import '../entidades/estado.dart';
import '../entidades/receccao.dart';

class ManipularRececcao implements ManipularRececcaoI {
  final ManipularEntradaI _manipularEntradaI;
  final ProvedorRececcaoI _provedorRececcaoI;
  final ManipularProdutoI _manipularProdutoI;
  ManipularRececcao(this._provedorRececcaoI, this._manipularEntradaI,
      this._manipularProdutoI) {}

  @override
  Future<int> receberProduto(
      Produto produto,
      int quantidadePorLotes,
      int quantidadeLotes,
      double precoLote,
      double custo,
      Funcionario funcionario,
      String motivo,
      bool pagavel) async {
    var data = DateTime.now();
    var quantidadeTotal = quantidadePorLotes * quantidadeLotes;
    var receccao = Receccao(
        custoAquisicao: custo,
        pagavel: pagavel,
        paga: false,
        precoLote: precoLote,
        quantidadeLotes: quantidadeLotes,
        quantidadePorLotes: quantidadePorLotes,
        estado: Estado.ATIVADO,
        idFuncionario: funcionario.id,
        idProduto: produto.id,
        data: data);
    var id = await _provedorRececcaoI.adicionarrRececcao(receccao);
    produto.precoCompra = receccao.precoCompraProduto.toDouble();
    await _manipularProdutoI.actualizarProduto(produto);
    await _manipularEntradaI.registarEntrada(Entrada(
        produto: produto,
        estado: Estado.ATIVADO,
        idProduto: produto.id,
        idRececcao: id,
        quantidade: quantidadeTotal,
        motivo: motivo,
        data: data));
    return id;
  }

  @override
  Future<void> actualizaRececcao(Receccao receccao) async {
    await _provedorRececcaoI.actualizaRececcao(receccao);
  }

  @override
  Future<void> removerRececcao(Receccao receccao) async {
    await _provedorRececcaoI.removerRececcao(receccao);
  }

  @override
  Future<List<Receccao>> todas() async {
    return await _provedorRececcaoI.todas();
  }

  @override
  Future<List<Receccao>> pegarListaRececcoesFuncionario(
      Funcionario funcionario) async {
    return await _provedorRececcaoI
        .pegarListaRececcoesFuncionario(funcionario.id!);
  }

  @override
  Future<void> removerTudo() async {
    await _provedorRececcaoI.removerTudo();
  }

  @override
  Future<void> removerAntes(DateTime data) async {
    await _provedorRececcaoI.removerAntes(data);
  }

  @override
  Future<List<Receccao>> pegarRececcoesDaData(DateTime data) async {
    var lista = await todas();
    lista
        .removeWhere((element) => comapararDatas(element.data!, data) == false);
    return lista;
  }

  @override
  Future<List<Receccao>> pegarListaRececcoesPagas(
      Funcionario funcionario, DateTime data) async {
    var lista = await pegarListaRececcoesFuncionario(funcionario);
    List<Receccao> resposta = [];
    for (var cada in lista) {
      if (comapararDatas(data, cada.data!) == true &&
          cada.pagavel == true &&
          cada.paga == true) {
        resposta.add(cada);
      }
    }
    return resposta;
  }
}
