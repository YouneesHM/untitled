import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/util/serveur.dart';
import 'package:untitled/util/Colores.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../inscrptionMechanic.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String lastName = '';
  String gender = '';
  String phoneNumber = '';
  List<String> governmentList = [
    'Ariana', 'Beja', 'Ben Arous', 'Bizerte', 'Gabes', 'Gafsa', 'Jendouba', 'Kairouan', 'Kasserine', 'Kebili', 'Kef', 'Mahdia', 'Manouba', 'Medenine', 'Monastir', 'Nabeul', 'Sfax', 'Sidi Bouzid', 'Siliana', 'Sousse', 'Tataouine', 'Tozeur', 'Tunis', 'Zaghouan',
  ];
  String selectedGovernment = '';

  @override
  Widget build(BuildContext context) {
    selectedGovernment = governmentList[0];

    return Scaffold(
      backgroundColor: AppColors.greyW,
      appBar: AppBar(
        title: const Text('Modifier le profil'),
        backgroundColor: AppColors.blueG,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nom',
                      ),
                      onChanged: (value) {
                        setState(() {
                          lastName = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      'situation : ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    RadioListTile(
                      title: Text('conducteur'),
                      value: 'condecteur',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    RadioListTile(
                      title: Text('mécanicien'),
                      value: 'mecansien',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value.toString();
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MechanicPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(),
                        labelText: 'Numéro de téléphone',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          phoneNumber = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Governorat',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedGovernment,
                      items: governmentList.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedGovernment = value.toString();
                        });
                        if (!governmentList.contains(selectedGovernment)) {
                          selectedGovernment = governmentList[0];
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: CupertinoButton(
                        onPressed: () {
                          updateProfileData();
                        },
                        child: Text('Modifier'),
                        color: AppColors.blueG,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfileData() async {
    final url = Uri.parse(
        'http://${localhost.server}:3000/update/6473c2864741ea6c1f2527e9');

    final requestBody = jsonEncode({
      'name': lastName,
      'role': gender,
      'phoneNumber': phoneNumber,
      'governmentList': selectedGovernment,
    });

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: requestBody,
      );

      if (response.statusCode == 200) {
        print('Profile data updated');
        Fluttertoast.showToast(
          webShowClose: true,
          msg: 'Le profil a été modifier avec succès',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,

        );
      } else {
        print('Failed to update profile data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating profile data: $error');
    }
  }
}