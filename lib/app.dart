import 'package:flutter/material.dart';
import 'pantallas/principal.dart';
import 'navegador.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hola richi desde DART',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(
            255, 0, 0, 1.0)),
        useMaterial3: true,
      ),
      home: Navegador(),
    );
  }
}