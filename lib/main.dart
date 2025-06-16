import 'package:flutter/material.dart';
import 'screens/pantalla1Screen.dart';
import 'screens/pantalla2Screen.dart';
import 'screens/pantalla3Screen.dart';

void main() => runApp(const EjerciciosApp());

class EjerciciosApp extends StatelessWidget {
  const EjerciciosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicios con Stack')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _navButton(context, 'Ejercicio 10', const Pantalla1()),
            const SizedBox(height: 12),
            _navButton(context, 'Ejercicio 11', const Pantalla2()),
            const SizedBox(height: 12),
            _navButton(context, 'Ejercicio 12', const Pantalla3()),
          ],
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, String texto, Widget pantalla) {
    return ElevatedButton(
      onPressed: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => pantalla)),
      child: Text(texto),
    );
  }
}
