import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimpleInterestScreen extends StatefulWidget {
  const SimpleInterestScreen({super.key});

  @override
  State<SimpleInterestScreen> createState() => _SimpleInterestScreenState();
}

class _SimpleInterestScreenState extends State<SimpleInterestScreen> {
  final _capitalCtrl = TextEditingController();
  final _tasaCtrl = TextEditingController();
  final _tiempoCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _capitalCtrl.dispose();
    _tasaCtrl.dispose();
    _tiempoCtrl.dispose();
    super.dispose();
  }

  void _calcular() {
    if (!_formKey.currentState!.validate()) return;

    final capital = double.parse(_capitalCtrl.text);
    final tasa = double.parse(_tasaCtrl.text);
    final tiempo = double.parse(_tiempoCtrl.text);

    final montoFinal = capital * (1 + (tasa * tiempo / 100));
    final interes = montoFinal - capital;

    final f = NumberFormat.currency(locale: 'es_EC', symbol: r'$');

    _alert(
      'Capital Inicial: ${f.format(capital)}\n'
      'Interés Generado: ${f.format(interes)}\n'
      'Monto Final: ${f.format(montoFinal)}',
    );
  }

  void _alert(String msg) => showDialog(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interés Simple')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _campo(_capitalCtrl, 'Capital Inicial (\$)'),
              const SizedBox(height: 12),
              _campo(_tasaCtrl, 'Tasa de Interés Anual (%)'),
              const SizedBox(height: 12),
              _campo(_tiempoCtrl, 'Tiempo (años)'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: _calcular, child: const Text('Calcular')),
                  ElevatedButton(
                      onPressed: () => _formKey.currentState!.reset(),
                      child: const Text('Limpiar')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _campo(TextEditingController ctrl, String label) =>
      TextFormField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label),
        validator: (v) {
          final value = double.tryParse(v ?? '');
          if (value == null || value <= 0) return 'Ingrese un número positivo';
          return null;
        },
      );
}
