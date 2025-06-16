import 'package:flutter/material.dart';

class Pantalla2 extends StatefulWidget {
  const Pantalla2({super.key});

  @override
  State<Pantalla2> createState() => _Pantalla2State();
}

class _Pantalla2State extends State<Pantalla2> {
  final _promedioCtrl = TextEditingController();
  final _ingresoCtrl = TextEditingController();

  void _evaluar() {
    final promedio = double.tryParse(_promedioCtrl.text) ?? 0;
    final ingreso = double.tryParse(_ingresoCtrl.text) ?? 0;

    final esApto = (promedio >= 9 && ingreso < 3000);

    _mostrarDialogo(
      esApto
          ? 'El estudiante es elegible para la beca'
          : 'Lo siento, el estudiante no es elegible para la beca',
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
    _promedioCtrl.dispose();
    _ingresoCtrl.dispose();
    super.dispose();
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
                TextField(
                  controller: _promedioCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Promedio de calificaciones',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _ingresoCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Ingreso mensual familiar (\$)',
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
