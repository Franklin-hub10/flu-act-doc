import 'package:flutter/material.dart';

class Pantalla3 extends StatefulWidget {
  const Pantalla3({super.key});

  @override
  State<Pantalla3> createState() => _Pantalla3State();
}

class _Pantalla3State extends State<Pantalla3> {
  final _edadCtrl = TextEditingController();
  final _experienciaCtrl = TextEditingController();

  void _evaluar() {
    final edad = int.tryParse(_edadCtrl.text) ?? 0;
    final experiencia = int.tryParse(_experienciaCtrl.text) ?? 0;

    final esApto = (edad >= 25 && edad <= 35 && experiencia >= 3);

    _mostrarDialogo(
      esApto
          ? 'El aspirante puede ser seleccionado para una entrevista'
          : 'Lo siento, el aspirante no cumple con los requisitos para la entrevista',
    );
  }

  void _mostrarDialogo(String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Resultado'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _edadCtrl.dispose();
    _experienciaCtrl.dispose();
    super.dispose();
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
                TextField(
                  controller: _edadCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _experienciaCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Años de experiencia laboral',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: _evaluar, child: const Text('Evaluar')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
