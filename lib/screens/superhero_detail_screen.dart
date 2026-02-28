import 'package:flutter/material.dart';
import 'package:superhero_app/data/model/superhero_detail_response.dart';

class SuperheroDetailScreen extends StatelessWidget {
  final SuperheroDetailResponse superhero;

  const SuperheroDetailScreen({super.key, required this.superhero});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Superhero ${superhero.name}")),
      body: Column(
        children: [
          Image.network(
            superhero.url,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: Alignment(0, -0.6),
          ),
          Text(superhero.name, style: TextStyle(fontSize: 28)),
          Text(
            superhero.realName,
            style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
          ),
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                barraHabilidad(
                  "Power",
                  superhero.powerStatsResponse.power,
                  Colors.red,
                ),
                barraHabilidad(
                  "Strength",
                  superhero.powerStatsResponse.strength,
                  Colors.grey,
                ),
                barraHabilidad(
                  "Intelligence",
                  superhero.powerStatsResponse.intelligence,
                  Colors.blue,
                ),
                barraHabilidad(
                  "Strength",
                  superhero.powerStatsResponse.strength,
                  Colors.yellow,
                ),
                barraHabilidad(
                  "Strength",
                  superhero.powerStatsResponse.strength,
                  Colors.grey,
                ),
                barraHabilidad(
                  "Strength",
                  superhero.powerStatsResponse.strength,
                  Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column barraHabilidad(String habilidad, String alto, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(height: double.parse(alto), width: 30, color: color),
        Text(habilidad),
      ],
    );
  }
}
