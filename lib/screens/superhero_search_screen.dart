import 'package:flutter/material.dart';
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
          FutureBuilder(future: _superheroInfo, builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }else if (snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            }else if(snapshot.hasData){
              var superheroList = snapshot.data?.result;
              return SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: superheroList?.length ?? 0,
                  itemBuilder: (context,index){
                    if (superheroList != null){
                      return Text(superheroList[index].name);
                    }else{
                      return Text("Error");
                    }
                  },
                ),
              );
            }else{
              return Text("No hay resultados");
            }
          })        
        ],
      ),
    );
  }
}
