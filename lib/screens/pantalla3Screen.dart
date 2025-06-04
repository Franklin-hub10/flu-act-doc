import 'package:flutter/material.dart';

class Pantalla2 extends StatelessWidget {
  const Pantalla2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
          Text("Bienvenido pantalla 2"),
          BackButton(),
          OutlinedButton(onPressed: ()=>Navigator.pop(context), child: Text("Regresar"))
        ],
      ),
    );
  }
}