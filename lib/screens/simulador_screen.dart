import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SavingsSimulatorScreen extends StatefulWidget {
  const SavingsSimulatorScreen({super.key});

  @override
  State<SavingsSimulatorScreen> createState() => _SavingsSimulatorScreenState();
}

class _SavingsSimulatorScreenState extends State<SavingsSimulatorScreen> {
  final _ahorroCtrl = TextEditingController();
  final _mesesCtrl = TextEditingController();
  final _tasaCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  double _total = 0;
  List<double> _detalleMes = [];

  @override
  void dispose() {
    _ahorroCtrl.dispose();
    _mesesCtrl.dispose();
    _tasaCtrl.dispose();
    super.dispose();
  }

  void _calcular() {
    if (!_formKey.currentState!.validate()) return;

    final ahorroMensual = double.parse(_ahorroCtrl.text);
    final meses = int.parse(_mesesCtrl.text);
    final tasa = _tasaCtrl.text.isEmpty ? 0 : double.parse(_tasaCtrl.text) / 100;

    _detalleMes = [];
    double acumulado = 0;

    for (var i = 1; i <= meses; i++) {
      acumulado += ahorroMensual;
      if (tasa > 0) acumulado += acumulado * tasa;
      _detalleMes.add(acumulado);
    }

    _total = acumulado;
    _mostrarResultado();
  }

  void _mostrarResultado() {
    final f = NumberFormat.currency(locale: 'es_EC', symbol: r'$');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Resultado', style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Ahorrado: ${f.format(_total)}',
                  style: const TextStyle(
                      fontSize: 18, color: Colors.orange)),
              const SizedBox(height: 12),
              const Text('Detalle mes a mes:',
                  style: TextStyle(fontSize: 16, color: Colors.white70)),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: _detalleMes.length,
                  itemBuilder: (_, i) => Text(
                    'Mes ${i + 1}: ${f.format(_detalleMes[i])}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simulador de Ahorro')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _campo(_ahorroCtrl, 'Ahorro mensual (\$)'),
              const SizedBox(height: 12),
              _campo(_mesesCtrl, 'Cantidad de meses', numeroEntero: true),
              const SizedBox(height: 12),
              _campo(_tasaCtrl, 'Tasa de interés mensual (%) (opcional)',
                  obligatorio: false),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _calcular, child: const Text('Calcular')),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _campo(TextEditingController ctrl, String label,
          {bool numeroEntero = false, bool obligatorio = true}) =>
      TextFormField(
        controller: ctrl,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label),
        validator: (v) {
          if (!obligatorio && (v == null || v.isEmpty)) return null;
          final value = double.tryParse(v ?? '');
          if (value == null || value <= 0) return 'Ingrese un número positivo';
          if (numeroEntero && value % 1 != 0) {
            return 'Debe ser un número entero';
          }
          return null;
        },
      );
}
