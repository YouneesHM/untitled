import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/pages/core/bottomNviGationBar/profil.dart';
import 'package:untitled/util/Colores.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../home_screen.dart';
import 'package:untitled/util/serveur.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}


class _SettingScreenState extends State<SettingScreen> {
  Future<void> _delteName() async {


    try {
      final response = await http.delete(
        Uri.parse(
            'http://${localhost.server}:3000/delete/648adc437256a10cb052b9b6'),
        body: json.encode({

        }),
        headers: {'Content-Type': 'application/json'},
      );

      // Handle the response as needed
      if (response.statusCode == 200) {
        // Success
        print('Data posted successfully');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('votre compte a ete supprimer'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder:(context) => HomePage()));
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Failure
        print('Data posted successfully');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('votre compte a ete supprimer'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder:(context) => HomePage()));
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle any exceptions
      print('Exception occurred: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Exception occurred: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pushReplacement(context, CupertinoPageRoute(builder:(context) => HomePage()));

                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyW,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.blueG,
        title: const Text('Paramètres'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/CRUD.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextButton(

                onPressed: () {
                  // Navigate to profile page
                  Navigator.push(context, CupertinoPageRoute(builder:(context) => ProfilePage()));
                },
                child: Text('modifier votre profil', style: TextStyle(color: AppColors.blueG,fontSize: 22,fontFamily:"castoro" ),),
              ),
              Expanded(
                child: Container(
                 ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(

                    onPressed: _delteName,
                    child: Text('supprimer votre compte !!', style: TextStyle(color: Colors.grey,fontSize: 14,fontFamily:"castoro" ),),
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors.blueG),
                    ),
                    onPressed: (){
                      // Navigate to home page
                      Navigator.push(context, CupertinoPageRoute(builder:(context) => HomePage()));
                    },
                    child: Text('Déconnexion'),
                  ),
                ],
              ),


            ],
          ),


        ],
      ),
    );
  }
}


