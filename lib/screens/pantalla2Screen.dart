import 'package:flutter/material.dart';

class Pantalla3 extends StatelessWidget {
  const Pantalla3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
          Text("Bienvenido pantalla 3"),
          BackButton(),
          OutlinedButton(onPressed: ()=>Navigator.pop(context), child: Text("Regresar"))
        ],
      ),
    );
  }
}