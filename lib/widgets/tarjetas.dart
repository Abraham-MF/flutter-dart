import 'package:flutter/material.dart';

class Tarjetas extends StatefulWidget{
  Tarjetas({
    super.key,
    required this.nombres,
    required this.descripciones,
    required this.rutas,
    required this.alto,
    required this.ancho,

});

  late List<String> nombres;
  late List<String> descripciones;
  late List<String> rutas;
  final double alto;
  final double ancho;


  @override

  State<Tarjetas> createState() => _TarjetasState();
}

class _TarjetasState extends State<Tarjetas> {
  @override
  Widget build(BuildContext context) {
    if (widget.nombres.isEmpty ||
        widget.descripciones.isEmpty ||
        widget.rutas.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Tarjetas")),
        body: const Center(child: Text("No se enviaron datos.")),
      );
    }

    if (widget.nombres.length != widget.descripciones.length ||
        widget.nombres.length != widget.rutas.length) {
      return Scaffold(
        appBar: AppBar(title: const Text("Tarjetas")),
        body: const Center(
          child: Text(
            "Error: Las listas no tienen la misma longitud.",
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Tarjetas"),
      ),
      body: SingleChildScrollView(
      child: Column(
      children: List.generate(widget.nombres.length, (i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: widget.alto,
              width: widget.ancho,
              child: Card(
                elevation: 3,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: widget.alto - 16,
                        width: widget.ancho * 0.4,
                        child: Image.asset(
                          widget.rutas[i],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.nombres[i],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(widget.descripciones[i]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
      }),
      ),
      ),
    );
  }
}

