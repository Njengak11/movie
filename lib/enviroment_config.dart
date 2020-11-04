import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnviromentConfig{ 
  final movieApiKey = const String.fromEnvironment('movieApikey');
}

final enviromentConfigProvider = Provider<EnviromentConfig>((ref){
  return EnviromentConfig();
});