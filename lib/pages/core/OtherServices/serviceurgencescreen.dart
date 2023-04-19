import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/util/serveur.dart';

import '../../../util/Colores.dart';
import '../../../wedget/Emergencybuttom.dart';


class MyHomeP extends StatefulWidget {
  @override
  _MyHomePState createState() => _MyHomePState();
}

class _MyHomePState extends State<MyHomeP> {
  Future<Map<String, String>> fetchDataFromBackend() async {
    try {
      final response = await http.get(Uri.parse('http://${localhost.server}:3000/api/data'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'text': data['text'].toString(),
          'bottom': data['bottom'].toString(),
        };
      } else {
        // Handle error response
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Handle network or server error
      print('Error: $e');
    }
    return {}; // Return an empty map if fetching data fails
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyW,
      appBar: AppBar(
        backgroundColor: AppColors.blueG,
        title: Text("Les numéros d'urgence"),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: fetchDataFromBackend(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Data is still loading
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Error occurred while fetching data
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Data has been fetched successfully
            final data = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( "SAMU :                 ",
                      style: TextStyle(
                        color: AppColors.blueG,
                        fontSize: 16,
                        fontFamily: "castoro",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MyEmergencyButton(
                      phoneNumber: '    190     ',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( "Protection civil :",
                      style: TextStyle(
                        color: AppColors.blueG,
                        fontSize: 16,
                        fontFamily: "castoro",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MyEmergencyButton(
                      phoneNumber: '    198     ',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text( "POLICE :               ",
                      style: TextStyle(
                        color: AppColors.blueG,
                        fontSize: 16,
                        fontFamily: "castoro",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MyEmergencyButton(
                      phoneNumber: '    197    ',
                    ),
                  ],
                ),
              ],
            );
          } else {
            // Data is null or empty
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
