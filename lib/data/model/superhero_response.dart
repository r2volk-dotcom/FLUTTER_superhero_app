// Definimos una clase llamada SuperheroResponse
class SuperheroResponse {

  // Variable de tipo String
  final String response;

  // Constructor de la clase
  SuperheroResponse({required this.response});

  // Constructor factory
  // Se usa para crear un objeto a partir de un JSON (Map)
  factory SuperheroResponse.fromJson(Map<String, dynamic> json) {

    // Retorna una nueva instancia de SuperheroResponse
    // Extrae el valor de la clave "response" del JSON
    return SuperheroResponse(
      response: json["response"],
    );
  }
}
