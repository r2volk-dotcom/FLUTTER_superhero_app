import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';
import 'package:superhero_app/data/model/superhero_response.dart';
import 'package:superhero_app/data/repository.dart';
import 'package:superhero_app/screens/superhero_detail_screen.dart';

class SuperheroSearchScreen extends StatefulWidget {
  const SuperheroSearchScreen({super.key});

  @override
  State<SuperheroSearchScreen> createState() => _SuperheroSearchScreenState();
}

class _SuperheroSearchScreenState extends State<SuperheroSearchScreen> {
  Future<SuperheroResponse?>? _superheroInfo;
  Repository repository = Repository();
  bool textoVacio = true;

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
                  textoVacio = text.isEmpty;
                  _superheroInfo = repository.fetchSuperHeroInfo(text);
                });
              },
            ),
          ),
          bodyList(),
        ],
      ),
    );
  }

  FutureBuilder<SuperheroResponse?> bodyList() {
    return FutureBuilder(
      future: _superheroInfo,
      builder: (context, snapshot) {
        if (textoVacio) {
          return Text("Introduce un texto");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.hasData) {
          var superheroList = snapshot.data?.result;
          return Expanded(
            child: ListView.builder(
              itemCount: superheroList?.length ?? 0,
              itemBuilder: (context, index) {
                if (superheroList != null) {
                  return itemSuperhero(superheroList[index]);
                } else {
                  return Text("Error");
                }
              },
            ),
          );
        } else {
          return Text("No hay resultados");
        }
      },
    );
  }

  Padding itemSuperhero(SuperheroDetailResponse item) => Padding(
    padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
    child: GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>SuperheroDetailScreen(superhero: item))),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.red,
        ),
        child: Column(
          children: [
            Image.network(
              item.url,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment(0, -0.6),
            ),
            Text(item.name),
          ],
        ),
      ),
    ),
  );
}
