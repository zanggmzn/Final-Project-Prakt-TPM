import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projekakhir_prakt/models/modelsListTeam.dart';

class PageListTeam extends StatefulWidget {

  const PageListTeam({super.key});

  @override
  State<PageListTeam> createState() => _PageListTeamState();
}

class _PageListTeamState extends State<PageListTeam> {
  List<ModelsListTeam> teams = [];

  // get teams
  Future getTeams() async {
    //take the url
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsonData = jsonDecode(response.body); //display pd body

    for (var eachTeam in jsonData['data']) {
      final team = ModelsListTeam(
        //ambil abbreviation sama city
        abbreviation: eachTeam['abbreviation'],
        city: eachTeam['city'],
      );
      teams.add(team);
    }
    //print di terminal
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              //jika loading selesai akan menampilkan team data
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: teams.length,
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(teams[index].abbreviation),
                          subtitle: Text(teams[index].city),
                        ),
                      ),
                    );
                  },
                );
              } else {
                //jika masih loading akan muter
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}