import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_viewmodel.dart';
import 'update_movie_screen.dart';
import 'camera_screen.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  @override
  void initState() {
    super.initState();
    // Posponer la llamada para evitar el error de "setState() or markNeedsBuild() called during build"
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieViewModel>().fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MovieViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Películas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () async {
              final cameras = await availableCameras();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CameraScreen(cameras: cameras),
                ),
              );
            },
          ),
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: viewModel.movies.length,
              itemBuilder: (context, index) {
                final movie = viewModel.movies[index];
                return ListTile(
                  title: Text(movie.nombre),
                  subtitle: Text(movie.descripcion),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UpdateMovieScreen(movie: movie),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
