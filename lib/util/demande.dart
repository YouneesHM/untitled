import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:untitled/util/Colores.dart';
import 'package:untitled/util/serveur.dart';
import '../pages/core/OurServices/mechanicPage.dart';

class DemandePage extends StatefulWidget {
  @override
  _DemandePageState createState() => _DemandePageState();
}

class _DemandePageState extends State<DemandePage> {
  final _formKey = GlobalKey<FormState>();
  String description = '';
  String nom = '';
  String user = '';

  Future<String> _fetchUser(String userId) async {
    final url = 'http://${localhost.server}:3000/get/6473c2864741ea6c1f2527e9';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final userJson = json.decode(response.body);
      return userJson['name'];
    } else {
      throw Exception('Failed to fetch user. Error: ${response.statusCode}');
    }
  }

  Future<void> _envoyerDemande() async {
    final url = 'http://${localhost.server}:3000/demande/';

    final response = await http.post(
      Uri.parse(url),
      body: {'objet': nom, 'description': description},
    );

    if (response.statusCode == 200) {
      print('Demande envoyée à $nom : $description');
      _showSuccessDialog();
    } else {
      print('Failed to send demande. Error: ${response.statusCode}');
      // Handle error response from the backend
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<String>(
          future: _fetchUser(user),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userName = snapshot.data!;
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                title: Text(
                  'Demande reçue avec succès',
                  // Set the text color to white
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Utilisateur: $userName',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description de la demande: $description',
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'OK',
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => MechanicListPage()),
                      );
                    },
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                title: Text(
                  'Demande reçue avec succès',
                  // Set the text color to white
                ),
                content: Text(
                  'Description de la demande: $description',
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'OK',
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MechanicListPage()),
                      );
                    },
                  ),
                ],
              );
            } else {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                title: Text(
                  'Demande reçue avec succès',
                  // Set the text color to white
                ),
                content: CircularProgressIndicator(),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyW,
      appBar: AppBar(
        backgroundColor: AppColors.blueG,
        title: Text(
          'Demande de réparation',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    nom = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'objet',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'svp entrez votre objet!!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'Description de la panne',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.blueG),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _envoyerDemande();
                  }
                },
                child: Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
