import 'package:flutter/material.dart';

class Pantalla1 extends StatefulWidget {
  const Pantalla1({super.key});

  @override
  State<Pantalla1> createState() => _Pantalla1State();
}

class _Pantalla1State extends State<Pantalla1> {
  final _edadCtrl = TextEditingController();
  final _promedioCtrl = TextEditingController();
  String _nivelIngles = 'Básico';

  void _evaluar() {
    final edad = int.tryParse(_edadCtrl.text) ?? 0;
    final promedio = double.tryParse(_promedioCtrl.text) ?? 0;
    final inglesOk =
        _nivelIngles == 'Intermedio' || _nivelIngles == 'Avanzado';

    final esApto =
        (edad >= 16 && edad <= 25 && inglesOk && promedio >= 8);

    _mostrarDialogo(
      esApto
          ? 'El estudiante es apto para participar en el programa de intercambio'
          : 'Lo siento, el estudiante no cumple con los requisitos para el programa de intercambio',
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
    _promedioCtrl.dispose();
    super.dispose();
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
                TextField(
                  controller: _edadCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _nivelIngles,
                  items: const [
                    DropdownMenuItem(value: 'Básico', child: Text('Básico')),
                    DropdownMenuItem(
                        value: 'Intermedio', child: Text('Intermedio')),
                    DropdownMenuItem(
                        value: 'Avanzado', child: Text('Avanzado')),
                  ],
                  onChanged: (v) => setState(() => _nivelIngles = v!),
                  decoration: const InputDecoration(
                    labelText: 'Nivel de inglés',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _promedioCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Promedio de calificaciones',
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
