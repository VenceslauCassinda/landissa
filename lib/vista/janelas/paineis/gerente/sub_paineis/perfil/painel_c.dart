import 'package:componentes_visuais/dialogo/dialogos.dart';
import 'package:get/get.dart';
import 'package:yetu_gestor/dominio/casos_uso/manipular_entidade.dart';
import 'package:yetu_gestor/dominio/entidades/estado.dart';
import 'package:yetu_gestor/fonte_dados/provedores/provedor_entidade.dart';
import 'package:yetu_gestor/solucoes_uteis/console.dart';

import '../../../../../../contratos/casos_uso/manipular_entidade_i.dart';
import '../../../../../../dominio/entidades/entidade.dart';
import '../../layouts/layout_campo_dado.dart';
import '../../layouts/layout_produto.dart';
import '../../painel_gerente_c.dart';

class PainelPerfilC extends GetxController {
  late ManipularEntidadeI _manipularEntidadeI;
  Rx<Entidade?> entidade = Rx<Entidade?>(null);

  PainelPerfilC() {
    _manipularEntidadeI = ManipularEntidade(ProvedorEntidade());
  }

  @override
  void onInit() async {
    await pegarEntidade();
    super.onInit();
  }

  void terminarSessao() {
    PainelGerenteC c = Get.find();
    c.terminarSessao();
  }

  Future pegarEntidade() async {
    var res = await _manipularEntidadeI.todos();
    if (res.isEmpty) {
      return;
    }
    mostrar(entidade.value);
    entidade.value = res[0];
    mostrar(entidade.value);
  }

  void mostrarDialogoActualizarNome(String? dado) {
    mostrarDialogoDeLayou(LayoutCampoDado(
      label: "nome".toUpperCase(),
      dado: dado,
      accaoAoFinalizar: (novo) async {
        var nova = Entidade(
            estado: Estado.ATIVADO,
            endereco: entidade.value?.endereco,
            id: entidade.value?.id,
            nif: entidade.value?.nif,
            nome: entidade.value?.nome);
        nova.nome = novo;
        entidade.value = nova;
        voltar();
        if ((await _manipularEntidadeI.todos()).isEmpty) {
          await _manipularEntidadeI.registarEntidade(entidade.value!);
        } else {
          await _manipularEntidadeI.actualizaEntidade(entidade.value!);
        }
      },
    ));
  }

  void mostrarDialogoActualizarNif(String? dado) {
    mostrarDialogoDeLayou(LayoutCampoDado(
      label: "nif".toUpperCase(),
      dado: dado,
      accaoAoFinalizar: (novo) async {
        var nova = Entidade(
            estado: Estado.ATIVADO,
            endereco: entidade.value?.endereco,
            id: entidade.value?.id,
            nif: entidade.value?.nif,
            nome: entidade.value?.nome);
        nova.nif = novo;
        entidade.value = nova;
        if (entidade.value == null) {
          await _manipularEntidadeI.registarEntidade(entidade.value!);
        } else {
          await _manipularEntidadeI.actualizaEntidade(entidade.value!);
        }
        voltar();
      },
    ));
  }

  void mostrarDialogoActualizarEndereco(String? dado) {
    mostrarDialogoDeLayou(LayoutCampoDado(
      label: "endereço".toUpperCase(),
      dado: dado,
      accaoAoFinalizar: (novo) async {
        var nova = Entidade(
            estado: Estado.ATIVADO,
            endereco: entidade.value?.endereco,
            id: entidade.value?.id,
            nif: entidade.value?.nif,
            nome: entidade.value?.nome);
        nova.endereco = novo;
        entidade.value = nova;
        if (entidade.value == null) {
          await _manipularEntidadeI.registarEntidade(entidade.value!);
        } else {
          await _manipularEntidadeI.actualizaEntidade(entidade.value!);
        }
        voltar();
      },
    ));
  }

  void mostrarDialogoActualizarTelefone(String? dado) {
    mostrarDialogoDeLayou(LayoutCampoDado(
      label: "telefone".toUpperCase(),
      dado: dado,
      accaoAoFinalizar: (novo) async {
        var nova = Entidade(
            estado: Estado.ATIVADO,
            endereco: entidade.value?.endereco,
            id: entidade.value?.id,
            nif: entidade.value?.nif,
            nome: entidade.value?.nome);
        nova.telefone = novo;
        entidade.value = nova;
        if (entidade.value == null) {
          await _manipularEntidadeI.registarEntidade(entidade.value!);
        } else {
          await _manipularEntidadeI.actualizaEntidade(entidade.value!);
        }
        voltar();
      },
    ));
  }
}
