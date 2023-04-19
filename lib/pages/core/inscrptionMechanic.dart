import 'package:flutter/material.dart';
import 'package:untitled/util/Colores.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/util/serveur.dart';

class MechanicPage extends StatefulWidget {
  @override
  _MechanicPageState createState() => _MechanicPageState();
}

class _MechanicPageState extends State<MechanicPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool canMov = false;
  String _selectedState = 'TOUS';
  String ratin = "0";

  Future<void> _updateName() async {
    String name = nameController.text;
    String phoneNumber = phoneController.text;
    String city = _selectedState;
    bool canMove = canMov;
    String rating = ratin;

    await http.patch(
      Uri.parse('http://${localhost.server}:3000/update/6473c2864741ea6c1f2527e9'),
      body: json.encode({
        "companyname": name,
        "city": city,
        "phoneNumber": phoneNumber,
        "rating": rating,
        "canMove": canMove,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Inscription avec succès'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> states = [
      'TOUS',
      'Ariana',
      'Beja',
      'Ben Arous',
      'Bizerte',
      'Gabes',
      'Gafsa',
      'Jendouba',
      'Kairouan',
      'Kasserine',
      'Kebili',
      'Kef',
      'Mahdia',
      'Manouba',
      'Medenine',
      'Monastir',
      'Nabeul',
      'Sfax',
      'Sidi Bouzid',
      'Siliana',
      'Sousse',
      'Tataouine',
      'Tozeur',
      'Tunis',
      'Zaghouan',
    ];
    return Scaffold(
      backgroundColor: AppColors.greyW,
      appBar: AppBar(
        backgroundColor: AppColors.blueG,
        title: Text("information de mécanicien"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Coordonnées"),
            SizedBox(height: 8.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nom du garage",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: "Numéro de téléphone",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 8.0),
                Expanded(
                  child: DropdownButtonFormField(
                    value: _selectedState,
                    items: states.map((String state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedState = value!;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text("Peut se déplacer ?"),
                SizedBox(width: 8.0),
                Switch(
                  value: canMov,
                  onChanged: (value) {
                    setState(() {
                      canMov = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.blueG),
                ),
                onPressed: _updateName,
                child: Text("Ajouter"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
