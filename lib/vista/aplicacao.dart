import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yetu_gestor/vista/janelas/login/janela_login.dart';
import 'aplicacao_c.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class Aplicacao extends StatelessWidget {
  late AplicacaoC _controlador;

  Aplicacao() {
    _controlador = Get.put(AplicacaoC());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: [Locale('pt', 'BR')],
        theme: ThemeData(
            primaryColor: const Color.fromRGBO(86, 0, 78, 1),
            accentColor: const Color.fromRGBO(86, 0, 78, 1),
            colorScheme: ThemeData()
                .colorScheme
                .copyWith(secondary: const Color.fromRGBO(86, 0, 78, 1))),
        debugShowCheckedModeBanner: false,
        home: JanelaLogin(),
      ),
    );
  }
}
