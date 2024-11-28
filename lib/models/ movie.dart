class Movie {
  final int idPelicula;
  final String nombre;
  final String descripcion;

  Movie({
    required this.idPelicula,
    required this.nombre,
    required this.descripcion,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      idPelicula: json['idPelicula'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }
}
