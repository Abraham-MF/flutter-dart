import 'dart:js_interop';
import 'package:shared_preferences/shared_preferences.dart';
// PUB.dev Todas las librerias de dart
// Para persistencias https://pub.dev/packages/shared_preferences
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Bienvenido extends StatefulWidget {
  const Bienvenido({super.key, required this.title});
  final String title;

  @override
  State<Bienvenido> createState() => _BienvenidoState();
}

class _BienvenidoState extends State<Bienvenido> {
  TextEditingController _cachar = TextEditingController();
  void _guardarNombre(String n) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("Hola", n);
    _CoFirestore(n);
  }

  void _CoFirestore(String nombre) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      //'usuarios' como nombre de colección en Firestore
      await db.collection("nombres").add({
        'nombre': nombre,
      });
      print("Nombre guardado en Firestore.");
    } catch (error) {
      print("Error al guardar el nombre en Firestore: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              width: 250,
              height: 100,
              child: Text("Ingresa tu nombre",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40 ),
              ),
            ),
            Container(
              child:
              TextField(
                // Propiedad para cachar
                controller: _cachar,
                style: TextStyle(fontSize: 20,
                  height: 1,
                ),
                decoration: InputDecoration(
                  labelText: 'Tu nombre',
                      border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    if (_cachar.text.isNotEmpty) {
                      _guardarNombre(_cachar.text);
                      print("bienvenido: ${_cachar.text}");
                      _cachar.clear();
                    }
                  },
                  child: Text("Aceptar"),
                ),
              ],
            )

          ],

        ),
      ),
      floatingActionButton: Row(

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}