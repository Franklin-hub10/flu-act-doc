import 'package:flutter/material.dart';
import 'package:flutter_application_actividad_autonoma/materiascreen.dart';
import 'package:intl/intl.dart';


class EstudianteScreen extends StatefulWidget {
  const EstudianteScreen({super.key});
  @override
  State<EstudianteScreen> createState() => _EstudianteScreenState();
}

class _EstudianteScreenState extends State<EstudianteScreen> {
  final _nombreCtrl = TextEditingController();
  final _notaCtrl = TextEditingController();

  final Estudiante _estu = Estudiante();
  Materia? _seleccionada;

  // ---------- Helpers ----------
  void _alert(String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(titulo, style: const TextStyle(color: Colors.white)),
        content: Text(mensaje, style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'))
        ],
      ),
    );
  }

  void _addMateria() {
    final nombre = _nombreCtrl.text.trim();
    if (nombre.isEmpty) return;
    setState(() {
      _seleccionada = Materia(nombre);
      _estu.agregarMateria(_seleccionada!);
      _nombreCtrl.clear();
    });
  }

  void _addNota() {
    final nota = double.tryParse(_notaCtrl.text);
    if (nota == null || _seleccionada == null) return;
    setState(() {
      _seleccionada!.agregarNota(nota);
      _notaCtrl.clear();
      _alert('Materia actual', _seleccionada!.info());
    });
  }

  void _mostrarPromGeneral() {
    final prom = _estu.promedioGeneral.toStringAsFixed(2);
    _alert('Promedio general del estudiante', prom);
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    final f = NumberFormat('#.##');

    return Scaffold(
      appBar: AppBar(title: const Text('Ej03 · Materias / Estudiante')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(labelText: 'Nueva materia'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: _addMateria, child: const Text('Agregar Materia')),
            const Divider(),
            DropdownButton<Materia>(
              value: _seleccionada,
              dropdownColor: Colors.black,
              hint: const Text('Seleccione materia'),
              items: _estu.materias
                  .map((m) => DropdownMenuItem(value: m, child: Text(m.nombre)))
                  .toList(),
              onChanged: (m) => setState(() => _seleccionada = m),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _notaCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Agregar nota'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: _addNota, child: const Text('Añadir Nota')),
            const Divider(),
            Expanded(
              child: ListView(
                children: _estu.materias
                    .map((m) => ListTile(
                          title: Text(m.nombre),
                          subtitle: Text('Promedio: ${f.format(m.promedio)}'),
                        ))
                    .toList(),
              ),
            ),
            ElevatedButton(
                onPressed: _mostrarPromGeneral,
                child: const Text('Promedio general')),
          ],
        ),
      ),
    );
  }
}
