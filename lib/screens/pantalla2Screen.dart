import 'package:flutter/material.dart';

class Pantalla2 extends StatefulWidget {
  const Pantalla2({super.key});

  @override
  State<Pantalla2> createState() => _Pantalla2State();
}

class _Pantalla2State extends State<Pantalla2> {
  final _promCtrl = TextEditingController();
  final _ingrCtrl = TextEditingController();

  @override
  void dispose() {
    _promCtrl.dispose();
    _ingrCtrl.dispose();
    super.dispose();
  }

  void _eval() {
    final prom = double.tryParse(_promCtrl.text) ?? 0;
    final ing = double.tryParse(_ingrCtrl.text) ?? 0;

    _alert((prom >= 9 && ing < 3000)
        ? 'Estudiante elegible para la beca'
        : 'No cumple los requisitos para la beca');
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
      appBar: AppBar(title: const Text('Ejercicio 11')),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _campo(_promCtrl, 'Promedio', decimales: true),
                const SizedBox(height: 12),
                _campo(_ingrCtrl, 'Ingreso familiar (\$)', decimales: true),
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
          {bool decimales = false}) =>
      TextField(
        controller: c,
        keyboardType:
            TextInputType.numberWithOptions(decimal: decimales, signed: false),
        decoration: InputDecoration(labelText: l),
        style: const TextStyle(color: Colors.white),
      );
}
