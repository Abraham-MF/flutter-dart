import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Otra extends StatefulWidget {
  const Otra({super.key, required this.title});
  final String title;

  @override
  State<Otra> createState() => _OtraState();
}

class _OtraState extends State<Otra> {
  int _counter = 0;

  FirebaseFirestore _ContaFireb = FirebaseFirestore.instance;

  void _ContadorFire(int nuevoValor) async {
    //aqui se obtiene la collecsion
    await _ContaFireb.collection("contadores").doc("contador2").set({
      'valor': nuevoValor,
    });
  }

  void _incrementCounter(int currentValue) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter += 25;
    });
    _ContadorFire(_counter);
  }

  void _decrementCounter(int currentValue) {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _counter -= 25;
      });
    });
    _ContadorFire(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: _ContaFireb.collection("contadores")
              .doc("contador")
              .snapshots(),
          builder: (context, snapshot) {
            int currentCounterValue = snapshot.data!['valor'] ?? 0;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Por cada click que des un richi del mundo muere',
                ),
                SizedBox(
                  height: currentCounterValue.toDouble(),
                  child: Image.network(
                      "https://uploads-ssl.webflow.com/6377bf360873283fad488724/638ca82a95fb434e6f42a283_Flutter.png"),
                ),
                Text(
                  '$currentCounterValue',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: StreamBuilder<DocumentSnapshot>(
        stream: _ContaFireb.collection("contadores")
            .doc("contador2")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          int currentCounterValue = snapshot.data!['valor'] ?? 0;

          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  _incrementCounter(currentCounterValue);
                },
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                onPressed: () {
                  _decrementCounter(currentCounterValue);
                },
                tooltip: 'Decrement',
                child: const Icon(Icons.remove),
              ),
            ],
          );
        },
      ),
    );
  }
}