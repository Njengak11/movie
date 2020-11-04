import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/enviroment_config.dart';
import 'package:movie/home/movie.dart';


final movieServiceProvider = Provider<MovieService>((ref){
  final config = ref.read(enviromentConfigProvider);

  return MovieService(config, Dio());
});

class MovieService{ 
  MovieService(this._enviromentConfig, this._dio);

  final Dio _dio;
  final EnviromentConfig _enviromentConfig;

  Future<List<Movie>> getMovies() async {
    final response = await _dio.get(
      "https://api.themoviedb.org/3/movie/popular?api_key=${_enviromentConfig.movieApiKey}&language=en-US&page=1"
    );


  final results = List<Map<String, dynamic>>.from(response.data['results']);
  
  List<Movie> movies = results.map((movieData) => Movie.fromMap(movieData)).toList(growable:false);
  return movies;
  }
}

//c5b271887c8dbb7e832614fc6c836de5

//"https://api.themoviedb.org/3/movie/popular?api_key=${_enviromentConfig.movieApiKey}&language=en-US&page=1"