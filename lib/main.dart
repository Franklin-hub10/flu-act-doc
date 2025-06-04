import 'package:flutter/material.dart';
import 'package:flutter_application_actividad_autonoma/screens/pantalla1Screen.dart';
import 'package:flutter_application_actividad_autonoma/screens/pantalla2Screen.dart';
import 'package:flutter_application_actividad_autonoma/screens/pantalla3Screen.dart';


void main() {
  runApp(EjerciciosApp());
}

class EjerciciosApp extends StatelessWidget {
  const EjerciciosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Cuerpo());
  }
}

class Cuerpo extends StatelessWidget {
  const Cuerpo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ejercicios")),
      body: Column(
        children: [
          btnEjercicio1(context),
          btnEjercicio2(context)

        
        ],
      ),
    );
  }
}

Widget btnEjercicio1(context) {
  return FilledButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Pantalla1()),
    ),
    child: Text("Pantalla 1"),
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(173, 20, 20, 0.5)),
    ),
  );
}


Widget btnEjercicio2(context){
return
ElevatedButton( 
  onPressed: () => 
  Navigator.push(context, MaterialPageRoute(builder: (context) => Pantalla2())),
  child: Text("Pantalla 2"),);
}