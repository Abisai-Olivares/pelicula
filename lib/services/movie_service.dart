import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/%20movie.dart';

class MovieService {
  final String baseUrl = 'http://192.168.105.65:8080/api';

Future<List<Movie>> fetchMovies() async {
final response = await http.get(Uri.parse('http://10.0.2.2:8080/api/pelicula'));
  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    print(data);  // Verifica el formato de los datos que llega
    return data.map((movie) => Movie.fromJson(movie)).toList();
  } else {
    throw Exception('Error al cargar las películas');
  }
}

  Future<void> updateMovie(Movie movie) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pelicula'), 
      body: json.encode({
        'idPelicula': movie.idPelicula, 
        'nombre': movie.nombre,
        'descripcion': movie.descripcion,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar la película');
    }
  }
}
