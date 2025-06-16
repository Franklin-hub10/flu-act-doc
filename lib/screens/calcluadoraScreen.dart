import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TipCalculatorScreen extends StatefulWidget {
  const TipCalculatorScreen({super.key});

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  final _montoCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _porcentaje = 0.10; // 10 % por defecto

  @override
  void dispose() {
    _montoCtrl.dispose();
    super.dispose();
  }

  void _calcular() {
    if (!_formKey.currentState!.validate()) return;

    final monto = double.parse(_montoCtrl.text);
    final propina = monto * _porcentaje;
    final total = monto + propina;

    final formato = NumberFormat.currency(locale: 'es_EC', symbol: r'$');

    _alert(
      'Propina: ${formato.format(propina)}\n'
      'Total a pagar: ${formato.format(total)}',
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
      appBar: AppBar(title: const Text('Calculadora de Propinas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _montoCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration:
                    const InputDecoration(labelText: 'Monto de la cuenta (\$)'),
                validator: (v) {
                  final value = double.tryParse(v ?? '');
                  if (value == null || value <= 0) {
                    return 'Ingrese un valor numérico positivo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Propina:', style: TextStyle(color: Colors.white)),
                  const SizedBox(width: 12),
                  DropdownButton<double>(
                    value: _porcentaje,
                    dropdownColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    items: const [
                      DropdownMenuItem(
                          value: 0.10, child: Text('10 % (servicio básico)')),
                      DropdownMenuItem(value: 0.15, child: Text('15 %')),
                      DropdownMenuItem(value: 0.20, child: Text('20 %')),
                      DropdownMenuItem(
                          value: -1,
                          child: Text('Personalizado…',
                              style: TextStyle(color: Colors.orange))),
                    ],
                    onChanged: (val) async {
                      if (val == -1) {
                        final custom = await _dialogoPersonalizado(context);
                        if (custom != null) setState(() => _porcentaje = custom);
                      } else {
                        setState(() => _porcentaje = val!);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _calcular, child: const Text('Calcular')),
            ],
          ),
        ),
      ),
    );
  }

  Future<double?> _dialogoPersonalizado(BuildContext context) async {
    final ctrl = TextEditingController();
    return showDialog<double>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Propina personalizada (%)',
            style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: ctrl,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(hintText: 'Ej. 12'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () {
                final v = double.tryParse(ctrl.text);
                if (v != null && v > 0) Navigator.pop(context, v / 100);
              },
              child: const Text('Aceptar')),
        ],
      ),
    );
  }
}
