import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/movie_service.dart';
import 'movie.dart';

final movieFutureProvider = FutureProvider.autoDispose<List<Movie>>((ref)async{
  ref.maintainState = true;

  final movieService = ref.read(movieServiceProvider);
  final movies = await movieService.getMovies();
});
class Home extends ConsumerWidget{ 
  @override 
  Widget build(BuildContext context, ScopedReader watch){
    return Scaffold( 
      appBar: AppBar( 
        elevation: 0,
        centerTitle: true,
        title: Text('Moviiies'),
      ),
      body: watch(movieFutureProvider).when(
         error: (e, s){ 
           return Text('error');
         },
         
         loading: ()=> Center( 
           child: CircularProgressIndicator(),
         ),
         data: (movies){
           return GridView.extent(
             maxCrossAxisExtent: 200,
             crossAxisSpacing: 12,
             mainAxisSpacing: 12,
             childAspectRatio: 0.7,
             children: 
               movies.map((movie) => Text(movie.title)).toList(),
             );
         }
         ),
    );
  }
}