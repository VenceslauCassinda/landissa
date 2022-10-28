import 'package:componentes_visuais/dialogo/toast.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> abrirLigacaoNoNavegador(String ligacao) async {
  if (await canLaunch("ligacao")) {
    launch("ligacao");
  } else {
    mostrarToast("Indisponível!");
  }
}