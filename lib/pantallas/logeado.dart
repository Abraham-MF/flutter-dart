import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class logeado extends StatefulWidget {
  const logeado({super.key});

  @override
  State<logeado> createState() => _logeadoState();
}

class _logeadoState extends State<logeado> {
  String nombreUsuario = '';

  @override
  void initState() {
    super.initState();
    _NombreFire();
  }

  Future<void> _NombreFire() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final doc = await FirebaseFirestore.instance.collection('usuarios').doc(uid).get();
        setState(() {
          nombreUsuario = doc.data()?['nombre'] ?? 'Usuario';
        });
      }
    } catch (e) {
      print('Error al obtener el nombre: $e');
      setState(() {
        nombreUsuario = 'Usuario';
      });
    }
  }

  Future<void> _cerrarSesion() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login(title: '')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logeado'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _cerrarSesion,
            tooltip: 'Cerrar sesión',
          )
        ],
      ),
      body: Center(
        child: Text(
          'Bienvenido, $nombreUsuario',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
