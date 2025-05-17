import 'dart:js_interop';
// PUB.dev Todas las librerias de dart
// Para persistencias https://pub.dev/packages/shared_preferences
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Localizacion extends StatefulWidget{
  const Localizacion({super.key,required this.title});

  final String title;

  @override
  State<Localizacion> createState() => _LocalizacionState();
}

class _LocalizacionState extends State<Localizacion> {

  String _lat="";
  String _long="";

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _obtenerCoordenadas() async{
    Position pos =await _determinePosition();
    setState(() {
      _lat=pos.latitude.toString();
      _long=pos.longitude.toString();
    });
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
            Text("Localizacion",
            style: TextStyle(
              fontSize: 40,
            ),
            ),
            SizedBox(
              height: 35,
            ),
            MaterialButton(
                onPressed: (){
                  _obtenerCoordenadas();
                },
                color: Theme.of(context).colorScheme.inversePrimary,
                child: Text("obtener coordenadas",
                style: TextStyle(
                  fontSize: 26,
                ),
                ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment:  MainAxisAlignment.start,
              children: [
                Text("latitud: $_lat\n longitud: $_long",
                style: TextStyle(
                  fontSize: 24
                ),
                ),
              ],

            ),

          ],

        ),
      ),
      floatingActionButton: Row(

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}