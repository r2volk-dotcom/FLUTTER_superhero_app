import 'dart:convert';
import 'package:superhero_app/data/model/superhero_response.dart';

// Importa el paquete http para hacer peticiones a internet
import 'package:http/http.dart' as http;

// Clase Repository
class Repository {

  // Método asincrónico que devuelve un Future
  // Puede devolver un SuperheroResponse o null
  Future<SuperheroResponse?> fetchSuperHeroInfo(String name) async {

    // Se hace una petición GET a la API
    final response = await http.get(
      Uri.parse(
        "https://superheroapi.com/api/0b14b6e414cb3fa16858bf911326039a/search/$name",
      ),
    );

    // Si la respuesta del servidor fue exitosa
    if (response.statusCode == 200) {

      // Convierte el JSON (String) en un Map
      var decodedJson = jsonDecode(response.body);

      // Convierte el Map en un objeto SuperheroResponse
      SuperheroResponse superheroResponse = SuperheroResponse.fromJson(decodedJson);

      // Devuelve el objeto creado
      return superheroResponse;
    } else {
      // Si algo falla, devuelve null
      return null;
    }
  }
}
