class Materia {
  final String nombre;
  final List<double> notas = [];
  Materia(this.nombre);

  void agregarNota(double n) => notas.add(n);

  double get promedio =>
      notas.isEmpty ? 0 : notas.reduce((a, b) => a + b) / notas.length;

  String info() =>
      'Materia: $nombre\nPromedio: ${promedio.toStringAsFixed(2)}';
}

class Estudiante {
  final List<Materia> materias = [];

  void agregarMateria(Materia m) => materias.add(m);

  double get promedioGeneral {
    if (materias.isEmpty) return 0;
    final suma = materias.map((m) => m.promedio).reduce((a, b) => a + b);
    return suma / materias.length;
  }
}
