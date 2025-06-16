class Libro {
  final String titulo;
  final String autor;
  final int anioPublicacion;
  int cantidadDisponible;

  Libro(this.titulo, this.autor, this.anioPublicacion, this.cantidadDisponible);

  String info() =>
      '$titulo — $autor · $anioPublicacion (Disp: $cantidadDisponible)';
}

class Biblioteca {
  final List<Libro> _libros = [];

  void agregar(Libro libro) => _libros.add(libro);

  List<Libro> buscar(String query) => _libros
      .where((l) => l.titulo.toLowerCase().contains(query.toLowerCase()))
      .toList();

  List<Libro> get todos => List.unmodifiable(_libros);

  String infoTodos() =>
      _libros.isEmpty ? 'No hay libros' : _libros.map((l) => l.info()).join('\n');
}
