import 'package:flutter/material.dart';
import 'package:movie_app/models/%20movie.dart';
import '../services/movie_service.dart';

class MovieViewModel extends ChangeNotifier {
  final MovieService _movieService = MovieService();
  List<Movie> _movies = [];
  bool _isLoading = false;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

Future<void> fetchMovies() async {
  _isLoading = true;
  notifyListeners();
  try {
    _movies = await _movieService.fetchMovies();
    print(_movies);
  } catch (e) {
    print('Error fetching movies: $e');
  }
  _isLoading = false;
  notifyListeners();
}


  Future<void> updateMovie(Movie movie) async {
    await _movieService.updateMovie(movie);
    await fetchMovies();
  }
}
