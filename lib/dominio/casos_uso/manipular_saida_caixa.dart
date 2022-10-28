import 'package:yetu_gestor/contratos/casos_uso/manipular_saida_caixa_i.dart';
import 'package:yetu_gestor/contratos/provedores/provedor_saida_caixa_i.dart';
import 'package:yetu_gestor/dominio/entidades/saida_caixa.dart';

class ManipularSaidaCaixa implements ManipularSaidaCaixaI {
  final ProvedorSaidaCaixaI _provedorSaidaCaixaI;
  ManipularSaidaCaixa(this._provedorSaidaCaixaI);
  @override
  Future<bool> actualizarSaidaCaixa(SaidaCaixa saidaCaixa) async {
    return await _provedorSaidaCaixaI.actualizarSaidaCaixa(saidaCaixa);
  }

  @override
  Future<int> adicionarSaidaCaixa(SaidaCaixa saidaCaixa) async {
    return await _provedorSaidaCaixaI.adicionarSaidaCaixa(saidaCaixa);
  }

  @override
  Future<List<SaidaCaixa>> pegarLista() async {
    return await _provedorSaidaCaixaI.pegarLista();
  }

  @override
  Future<int> removerSaidaCaixaDeId(int id) async {
    return await _provedorSaidaCaixaI.removerSaidaCaixaDeId(id);
  }

  @override
  Future<void> removerAntesDe(DateTime data) async {
    await _provedorSaidaCaixaI.removerAntesDe(data);
  }

  @override
  Future<void> removerTudo() async {
    await _provedorSaidaCaixaI.removerTudo();
  }
}
