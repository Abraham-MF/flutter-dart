import 'package:flutter/material.dart';
import 'package:proyecto_movil/pantallas/bienv.dart';
import 'package:proyecto_movil/pantallas/principal.dart';
import 'package:proyecto_movil/pantallas/localizacion.dart';
import 'package:proyecto_movil/pantallas/calendario.dart';
import 'package:proyecto_movil/widgets/tarjetas.dart';
import 'package:proyecto_movil/pantallas/login.dart';
import 'pantallas/segunda.dart';
import 'pantallas/calc.dart';
class Navegador extends StatefulWidget{
  const Navegador({super.key});
  @override
  State<Navegador> createState() => _NavegadorState();

}
class _NavegadorState extends State<Navegador>{
  // Widget _cuerpo = Otra(title: "Hola a todos!!!!");
  Widget? _cuerpo;
  List<Widget> _pantallas = [];
  int _p=0;

  void _cambiaPantalla(int v){
    setState(() {
      _p = v;
      _cuerpo = _pantallas[_p];
    });
  }


  @override
  void initState(){
    super.initState();
    _pantallas.add(const Bienvenido(title: "Persistencia de datos"));
    _pantallas.add(const Calculadora(title: "Calcula"));
    _pantallas.add(const MyHomePage(title: "Hola a todos!!!!"));
    _pantallas.add(const Calendario(title: "localizacion"));
    _pantallas.add(const Login(title: "login"));
    _pantallas.add(const Localizacion(title: "localizacion"));
    _pantallas.add(
      Tarjetas(
        nombres: ['bombardino cocodrilo', 'bombardino cocodrilo', 'bombardino cocodrilo'],
        descripciones: ['Tipo: Reptil / Efecto \n ATK: 2300 | DEF: 1800 \n  \n Este imponente ser anfibio emite un rugido tan poderoso como el viento que arrastra la tormenta. Al activar su efecto, puede hacer temblar el campo de batalla, reduciendo el ataque de tu adversario en 500 puntos por cada sonido resonante que emite. ¡No subestimes su melodiosa furia!',
          'Tipo: Reptil / Efecto \n ATK: 2300 | DEF: 1800 \n \n Este imponente ser anfibio emite un rugido tan poderoso como el viento que arrastra la tormenta. Al activar su efecto, puede hacer temblar el campo de batalla, reduciendo el ataque de tu adversario en 500 puntos por cada sonido resonante que emite. ¡No subestimes su melodiosa furia!',
          'Tipo: Reptil / Efecto \n ATK: 2300 | DEF: 1800 \n \n Este imponente ser anfibio emite un rugido tan poderoso como el viento que arrastra la tormenta. Al activar su efecto, puede hacer temblar el campo de batalla, reduciendo el ataque de tu adversario en 500 puntos por cada sonido resonante que emite. ¡No subestimes su melodiosa furia!'
        ],
        rutas: [
          'assets/images/bombardino_cocodrilo.png',
          'assets/images/bombardino_cocodrilo.png',
          'assets/images/bombardino_cocodrilo.png',
        ],
        alto: 50,
        ancho: 250,
      ),
    );
    _cuerpo = _pantallas[_p];
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _cuerpo,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          // Detalle visual para observar más un icono seleccionado
          currentIndex: _p,
          onTap: (value) => _cambiaPantalla(value),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(label:"Bienvenido",icon: Icon(Icons.home,)),
            BottomNavigationBarItem(label:"calculadora",icon: Icon(Icons.calculate_outlined,)),
            BottomNavigationBarItem(label:"principal",icon: Icon(Icons.accessibility_sharp,)),
            BottomNavigationBarItem(label:"Calendario",icon: Icon(Icons.calendar_today)),
            BottomNavigationBarItem(label:"login",icon: Icon(Icons.login,)),
            BottomNavigationBarItem(label:"localizacion",icon: Icon(Icons.location_on,)),
            BottomNavigationBarItem(label:"Tarjetas",icon: Icon(Icons.credit_card,)),
          ]),
    );
  }
}