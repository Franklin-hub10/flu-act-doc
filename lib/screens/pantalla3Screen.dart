import 'package:flutter/material.dart';

class Pantalla3 extends StatefulWidget {
  const Pantalla3({super.key});

  @override
  State<Pantalla3> createState() => _Pantalla3State();
}

class _Pantalla3State extends State<Pantalla3> {
  final _edadCtrl = TextEditingController();
  final _expCtrl = TextEditingController();

  @override
  void dispose() {
    _edadCtrl.dispose();
    _expCtrl.dispose();
    super.dispose();
  }

  void _eval() {
    final edad = int.tryParse(_edadCtrl.text) ?? 0;
    final exp = int.tryParse(_expCtrl.text) ?? 0;

    _alert((edad >= 25 && edad <= 35 && exp >= 3)
        ? 'Aspirante apto para entrevista'
        : 'No cumple los requisitos para la entrevista');
  }

  void _alert(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title:
            const Text('Resultado', style: TextStyle(color: Colors.white)),
        content: Text(msg, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejercicio 12')),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _campo(_edadCtrl, 'Edad', entero: true),
                const SizedBox(height: 12),
                _campo(_expCtrl, 'Años de experiencia', entero: true),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: _eval, child: const Text('Evaluar')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextField _campo(TextEditingController c, String l,
          {bool entero = false}) =>
      TextField(
        controller: c,
        keyboardType:
            TextInputType.numberWithOptions(decimal: !entero, signed: false),
        decoration: InputDecoration(labelText: l),
        style: const TextStyle(color: Colors.white),
      );
}
