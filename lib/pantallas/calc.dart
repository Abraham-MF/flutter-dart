import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key, required this.title});
  final String title;

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {

  bool _punto = false;
  String _texto1= "0";
  String _texto2 = "0";
  String _lastChar = "";
  double? _valor1 = null;
  double? _valor2 = null;
  bool _nuevoNumero = false; // Nuevo flag para saber cuándo reiniciar _texto1
  bool _contadorSimbolo = false;

  void _presionaSimbolo(String a) {
    setState(() {
      _valor1 = double.tryParse(_texto1);

      // Manejo del punto decimal
      if (a == "." && !_punto) {
        print("Entro");
        _punto = true;
        if (_texto1.isEmpty || _texto1 == "0" || (_contadorSimbolo && _texto1.isNotEmpty)) {
          _texto1 = "0."; // Si no hay nada antes, inicia con "0."
          print("Entro con 0");
        } else if (!_texto1.contains(".")) {
          _texto1 += "."; // Si ya hay un número, solo agrega el punto
          print("Entro con otro numero");
        }
      }

      if (a == "+") _procesarOperacion("+");
      if (a == "-") _procesarOperacion("-");
      if (a == "x") _procesarOperacion("x");
      if (a == "/") _procesarOperacion("/");

      if (a == "=") {
        _igualdades(_lastChar);
        _contadorSimbolo = true;
        _nuevoNumero = true;
      }
    });
  }

  void _procesarOperacion(String operador) {
    if (!_contadorSimbolo) {
      if (_lastChar.isNotEmpty && _lastChar != operador) _igualdades(_lastChar);

      if (_valor2 == null) {
        _valor2 = _valor1;
        _texto1 = "0";
        _texto2 = _valor2.toString();
      } else if (!_nuevoNumero) {
        _igualdades(operador);
      }

      _contadorSimbolo = true;
    }
    _lastChar = operador;
    _punto = false;
  }

  void _presionaNumero(int n) {
    setState(() {
      print("Cuando presionaste era ${_punto}");

      if (_nuevoNumero) {
        if(_texto1 != "0."){
          _texto1 = n.toString();
        }else{
          _texto1 += n.toString();
        }
        _nuevoNumero = false;
      } else {
        if (_texto1 == "0" && n != 0) {
          _texto1 = n.toString();
        } else {
          if(_texto1[0] != "0" || _punto ) _texto1 += n.toString();
        }
      }
      _contadorSimbolo = false;
    });
  }

  void _igualdades(String simbolo){
    {
      switch(simbolo){
        case "":
          _texto1= _valor1.toString();
          break;
        case "+":
          _valor1 = double.tryParse(_texto1);
          _valor1 = _valor1! + _valor2!;
          _texto2 = _valor1.toString();
          _texto1 = _valor1.toString();
          _valor2 = _valor1;
          _nuevoNumero= true;
          break;
        case "-":
          _valor1 = double.tryParse(_texto1);
          _valor1 = _valor2! - _valor1!;
          _texto2 = _valor1.toString();
          _texto1 = _valor1.toString();
          _valor2 = _valor1;
          _nuevoNumero= true;
          break;
        case "x":
          _valor1 = double.tryParse(_texto1);
          _valor1 = _valor1! * _valor2!;
          _texto2 = _valor1.toString();
          _texto1 = _valor1.toString();
          _valor2 = _valor1;
          _nuevoNumero= true;
          break;
        case "/":
          _valor1 = double.tryParse(_texto1);
          _valor1 = _valor2! / _valor1!;
          _texto2 = _valor1.toString();
          _texto1 = _valor1.toString();
          _valor2 = _valor1;
          _nuevoNumero= true;
          break;
      }
      _punto = false;
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
              width: 320,
              color: Colors.deepPurple,
              height: 20,
              child: Text("$_texto2",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 10 ),
              ),
            ),

            Container(
              width: 320,
              color: Color.fromRGBO(128, 71, 243, 0.30196078431372547),
              height: 40,
              child: Text("$_texto1",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(9);},
                    child: Text("9"),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(8);},
                    child: Text("8"),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(7);},
                    child: Text("7"),
                  ),

                  OutlinedButton(onPressed: (){_presionaSimbolo("+");}, child: Text("+"),)

                ]

            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(6);},
                    child: Text("6"),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(5);},
                    child: Text("5"),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(4);},
                    child: Text("4"),
                  ),

                  OutlinedButton(onPressed: (){_presionaSimbolo("-");}, child: Text("-"),)

                ]

            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(3);},
                    child: Text("3"),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(2);},
                    child: Text("2"),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(1);},
                    child: Text("1"),
                  ),

                  OutlinedButton(onPressed: (){_presionaSimbolo("x");}, child: Text("x"),)

                ]

            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaSimbolo(".");},
                    child: Text("."),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),
                    onPressed:(){_presionaNumero(0);},
                    child: Text("0"),
                  ),

                  OutlinedButton(
                    style: ButtonStyle(

                    ),

                    onPressed: (){_presionaSimbolo("=");}, child: Text("="),
                  ),

                  OutlinedButton(onPressed:(){_presionaSimbolo("/");}, child: Text("/"),)

                ]

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