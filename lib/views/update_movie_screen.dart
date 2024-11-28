import 'package:flutter/material.dart';
import 'package:movie_app/models/%20movie.dart';
import 'package:provider/provider.dart';
import '../viewmodels/movie_viewmodel.dart';

class UpdateMovieScreen extends StatefulWidget {
  final Movie movie;

  UpdateMovieScreen({required this.movie});

  @override
  _UpdateMovieScreenState createState() => _UpdateMovieScreenState();
}

class _UpdateMovieScreenState extends State<UpdateMovieScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    // Inicializa los controladores con los valores de la película
    _nameController = TextEditingController(text: widget.movie.nombre);
    _descriptionController = TextEditingController(text: widget.movie.descripcion);
  }

  @override
  void dispose() {
    // Asegúrate de liberar los controladores cuando el widget se destruya
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Actualizar Película')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(
              onPressed: () {
                // Crear un nuevo objeto Movie con los datos actualizados
                final updatedMovie = Movie(
                  idPelicula: widget.movie.idPelicula,
                  nombre: _nameController.text,  // Ahora 'nombre' no es nulo
                  descripcion: _descriptionController.text,
                );

                // Llamar a la función para actualizar la película
                context.read<MovieViewModel>().updateMovie(updatedMovie);

                // Volver a la pantalla anterior
                Navigator.pop(context);
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
