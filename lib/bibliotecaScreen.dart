import 'package:flutter/material.dart';
import 'package:flutter_application_actividad_autonoma/libro.dart';


class BibliotecaScreen extends StatefulWidget {
  const BibliotecaScreen({super.key});
  @override
  State<BibliotecaScreen> createState() => _BibliotecaScreenState();
}

class _BibliotecaScreenState extends State<BibliotecaScreen> {
  final _titulo = TextEditingController();
  final _autor = TextEditingController();
  final _anio = TextEditingController();
  final _cant = TextEditingController();
  final _buscarCtrl = TextEditingController();

  final Biblioteca _bib = Biblioteca();

  // ---------- helpers ----------
  void _alert(String title, String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
            child: Text(msg, style: const TextStyle(color: Colors.white))),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'))
        ],
      ),
    );
  }

  void _agregarLibro() {
    final t = _titulo.text.trim();
    final a = _autor.text.trim();
    final anio = int.tryParse(_anio.text);
    final cant = int.tryParse(_cant.text);

    if (t.isEmpty || a.isEmpty || anio == null || cant == null) return;

    setState(() {
      final lib = Libro(t, a, anio, cant);
      _bib.agregar(lib);
      _titulo.clear();
      _autor.clear();
      _anio.clear();
      _cant.clear();
      _alert('Libro agregado', lib.info());
    });
  }

  void _buscar() {
    final q = _buscarCtrl.text.trim();
    final res = q.isEmpty ? [] : _bib.buscar(q);
    _alert(
      'Resultado de búsqueda',
      res.isEmpty ? 'No se encontraron libros con “$q”.' : res.map((l) => l.info()).join('\n'),
    );
  }

  void _mostrarTodos() => _alert('Todos los libros', _bib.infoTodos());

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ej03 · Biblioteca')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Buscador
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _buscarCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Buscar por título'),
                ),
              ),
              IconButton(
                  onPressed: _buscar,
                  icon: const Icon(Icons.search, color: Colors.orange)),
            ]),
            // Formulario agregar
            ExpansionTile(
              title: const Text('Agregar libro'),
              children: [
                TextField(
                  controller: _titulo,
                  decoration: const InputDecoration(labelText: 'Título'),
                ),
                TextField(
                  controller: _autor,
                  decoration: const InputDecoration(labelText: 'Autor'),
                ),
                TextField(
                  controller: _anio,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Año de publicación'),
                ),
                TextField(
                  controller: _cant,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Cantidad disponible'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: _agregarLibro, child: const Text('Guardar')),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
                onPressed: _mostrarTodos, child: const Text('Mostrar todos')),
          ],
        ),
      ),
    );
  }
}
