import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseFirestore _ContaFireb = FirebaseFirestore.instance;

  void _ContadorFire(int nuevoValor) async {
    // Actualiza el valor en Firestore
    await _ContaFireb.collection("contadores").doc("contador").set({
      'valor': nuevoValor,
    });
  }

  void _incrementCounter(int currentValue) {
    _ContadorFire(currentValue + 25);
  }

  void _decrementCounter(int currentValue) {
    _ContadorFire(currentValue - 25);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot>(
          stream: _ContaFireb.collection("contadores").doc("contador").snapshots(),
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
                  child: Image.network("https://uploads-ssl.webflow.com/6377bf360873283fad488724/638ca82a95fb434e6f42a283_Flutter.png"),
                ),
                Text(
                  '$currentCounterValue',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: StreamBuilder<DocumentSnapshot>(
        stream: _ContaFireb.collection("contadores").doc("contador").snapshots(),
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