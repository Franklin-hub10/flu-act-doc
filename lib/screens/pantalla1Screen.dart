import 'package:flutter/material.dart';

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  final _edadCtrl = TextEditingController();
  final _promCtrl = TextEditingController();
  String _ingles = 'Básico';

  @override
  void dispose() {
    _edadCtrl.dispose();
    _promCtrl.dispose();
    super.dispose();
  }

  void _eval() {
    final edad = int.tryParse(_edadCtrl.text) ?? 0;
    final prom = double.tryParse(_promCtrl.text) ?? 0;
    final okIngl = _ingles == 'Intermedio' || _ingles == 'Avanzado';

    _alert(
      (edad >= 16 && edad <= 25 && okIngl && prom >= 8)
          ? 'El estudiante es apto para el intercambio'
          : 'No cumple los requisitos para el intercambio',
    );
  }

  void _alert(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Resultado',
            style: TextStyle(color: Colors.white)),
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
      appBar: AppBar(title: const Text('Ejercicio 10')),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _campo(_edadCtrl, 'Edad', entero: true),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _ingles,
                  dropdownColor: Colors.black,
                  decoration:
                      const InputDecoration(labelText: 'Nivel de inglés'),
                  items: const [
                    DropdownMenuItem(value: 'Básico', child: Text('Básico')),
                    DropdownMenuItem(
                        value: 'Intermedio', child: Text('Intermedio')),
                    DropdownMenuItem(value: 'Avanzado', child: Text('Avanzado')),
                  ],
                  onChanged: (v) => setState(() => _ingles = v!),
                ),
                const SizedBox(height: 12),
                _campo(_promCtrl, 'Promedio', decimales: true),
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
          {bool entero = false, bool decimales = false}) =>
      TextField(
        controller: c,
        keyboardType: TextInputType.numberWithOptions(
            decimal: decimales, signed: false),
        decoration: InputDecoration(labelText: l),
        style: const TextStyle(color: Colors.white),
      );
}
