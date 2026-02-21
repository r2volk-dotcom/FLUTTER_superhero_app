import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/repository.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  Future<SuperheroResponse?>? _superheroInfo;
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SuperHero Seach")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Busca un Superheroe",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  _superheroInfo = repository.fetchSuperHeroInfo(text);
                  print("el texto es $_superheroInfo");
                });
              },
            ),
          ),
          bodyList()        
        ],
      ),
    );
  }

  FutureBuilder<SuperheroResponse?> bodyList() {
    return FutureBuilder(future: _superheroInfo, builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if (snapshot.hasError){
            return Text("Error: ${snapshot.error}");
          }else if(snapshot.hasData){
            var superheroList = snapshot.data?.result;
            return Expanded(
              child: ListView.builder(
                itemCount: superheroList?.length ?? 0,
                itemBuilder: (context,index){
                  if (superheroList != null){
                    return itemSuperhero(superheroList[index]);
                  }else{
                    return Text("Error");
                  }
                },
              ),
            );
          }else{
            return Text("No hay resultados");
          }
        });
  }

  Padding itemSuperhero(SuperheroDetailResponse item) => Padding(
    padding: const EdgeInsets.all(32),
    child: Container(
  // Le dice al Container que recorte (clippee) a sus hijos
  // usando la forma definida en la decoración (en este caso, el borderRadius)
  clipBehavior: Clip.hardEdge,

  decoration: BoxDecoration(
    // Define bordes redondeados de 16 píxeles en las 4 esquinas
    borderRadius: BorderRadius.circular(16),

    // Color de fondo del Container
    color: Colors.red,
  ),

  // Widget hijo del Container
  child: Column(
    // Organiza los hijos en vertical (uno debajo del otro)
    children: [

      Image.network(
        // URL de la imagen que se carga desde internet
        item.url,

        // Altura fija de la imagen
        height: 250,

        // Ocupa todo el ancho disponible del Container
        width: double.infinity,

        // Hace que la imagen llene todo el espacio manteniendo proporción
        // Si sobra imagen, la recorta
        fit: BoxFit.cover,

        // Ajusta qué parte de la imagen se prioriza al recortar
        // (0, -0.6) significa centrado horizontal y un poco hacia arriba verticalmente
        alignment: Alignment(0, -0.6),
      ),

      // Muestra el nombre del superhéroe debajo de la imagen
      Text(item.name),
    ],
  ),
),
  );
}
