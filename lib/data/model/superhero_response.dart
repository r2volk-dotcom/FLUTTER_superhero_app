// Definimos una clase llamada SuperheroResponse
import 'package:superhero_app/data/model/superhero_detail_response.dart';

class SuperheroResponse {

  // Variable de tipo String
  final String response;
  final List<SuperheroDetailResponse> result;

  // Constructor de la clase
  SuperheroResponse({required this.response, required this.result});

  // Constructor factory
  // Se usa para crear un objeto a partir de un JSON (Map)
  factory SuperheroResponse.fromJson(Map<String, dynamic> json) {
    var list = json["result"] as List;
    
    List<SuperheroDetailResponse> heroList = list.map((hero) => SuperheroDetailResponse.fromJson(hero)).toList();


    // Retorna una nueva instancia de SuperheroResponse
    // Extrae el valor de la clave "response" del JSON
    return SuperheroResponse(
      response: json["response"],
      result: heroList
    );
  }
}
