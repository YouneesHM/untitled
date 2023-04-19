import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/profilServices.dart';
import 'package:untitled/util/Colores.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/util/serveur.dart';


class ProfileDisplayPage extends StatefulWidget {
  @override
  _ProfileDisplayPageState createState() => _ProfileDisplayPageState();
}

class _ProfileDisplayPageState extends State<ProfileDisplayPage> {
  late Future<List<Profile>> profii2;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    profii2 = getData2();
  }

  Future<List<Profile>> getData2() async {
    String url = 'http://${localhost.server}:3000/get/6473c2864741ea6c1f2527e9';

    var jsonData = await http.get(Uri.parse(url));

    if (jsonData.statusCode == 200) {
      dynamic data = jsonDecode(jsonData.body);

      if (data is List) {
        List<Profile> allData = [];

        for (var mechanicJson in data) {
          print('Parsing JSON: $mechanicJson');
          Profile profile = Profile.fromJson(mechanicJson);
          allData.add(profile);
        }

        setState(() {
          _loading = false;
        });

        return allData;
      } else if (data is Map<String, dynamic>) {
        // Assuming the object has a single profile
        Profile profile = Profile.fromJson(data);
        setState(() {
          _loading = false;
        });
        return [profile];
      } else {
        throw Exception("Invalid data format");
      }
    } else {
      throw Exception("Error fetching data from URL");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyW,
      appBar: AppBar(
        elevation: 20,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.blueG,
        title: Text(
          'Mon Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: AppColors.blanc,
            fontFamily: "Castoro",
          ),
        ),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<List<Profile>>(
        future: profii2,
        builder: (BuildContext context,
            AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<Profile> combinedData = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: combinedData
                  .map((profile) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading:
                        Icon(Icons.person, color: Colors.black),
                        title: Text(
                          'Nom et Prénom :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.blueG,
                            fontFamily: "Castoro",
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              ' ${profile.lastname}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.alternate_email,
                            color: Colors.black),
                        title: Text(
                          'Email :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.blueG,
                            fontFamily: "Castoro",
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              '${profile.email}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.directions_car,
                          color: Colors.black,
                        ),
                        title: Text(
                          'role :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.blueG,
                            fontFamily: "Castoro",
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              '${profile.gender}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.phone, color: Colors.black),
                        title: Text(
                          'Numéro de téléphone :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.blueG,
                            fontFamily: "Castoro",
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              '${profile.phoneNumber}',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.location_city_sharp,
                          color: Colors.black,
                        ),
                        title: Text(
                          'Gouvernorat:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: AppColors.blueG,
                            fontFamily: "Castoro",
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              '${profile.governmentList}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}
