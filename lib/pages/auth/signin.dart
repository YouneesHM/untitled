import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/pages/auth/signup.dart';
import 'package:untitled/util/Colores.dart';
import 'package:untitled/util/serveur.dart';
import 'dart:convert';

import '../../util/favManger.dart';

class _SigninState extends State<Signin> {
  bool _isPasswordObscured = true;
  final _formKey = GlobalKey<FormState>();
  User user = User('', '', '');

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      var res = await http.post(
        Uri.parse("http://${localhost.server}:3000/signin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': user.email,
          'password': user.password,
        }),
      );

      if (res.statusCode == 200) {
        var responseJson = jsonDecode(res.body);
        if (responseJson.containsKey('isValid') &&
            responseJson['isValid'] is bool) {
          bool isValid = responseJson['isValid'];
          if (isValid) {
            // Email and password are valid in the database
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyAPP()), // Corrected reference to MyApp
            );
            return;
          }
        }
      }

      // Email or password is incorrect, show the dialogue
      showIncorrectCredentialsDialog();
    }
  }

  void showIncorrectCredentialsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('échec'),
          content: Text(' Email ou Mot de passe est incorrect.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyW,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/LOGINCOVER.png',
              fit: BoxFit.cover,
            ),
            Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 400,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller:
                        TextEditingController(text: user.email),
                        onChanged: (value) {
                          user.email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrez quelque chose';
                          } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Entrer un email valide';
                          }
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: AppColors.blueG,
                          ),
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: AppColors.blueG),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: AppColors.blueG),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            controller:
                            TextEditingController(text: user.password),
                            onChanged: (value) {
                              user.password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Entrez quelque chose';
                              }
                              return null;
                            },
                            obscureText: _isPasswordObscured,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.vpn_key,
                                color: AppColors.blueG,
                              ),
                              hintText: 'Mot de passe',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: AppColors.blueG),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: AppColors.blueG),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                _isPasswordObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.blueG,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(55, 16, 16, 0),
                      child: Container(
                        height: 50,
                        width: 400,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(AppColors.blueG),
                          ),
                          onPressed: save,
                          child: Text(
                            "CONNEXION",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(56, 20, 20, 20),
                      child: Row(
                        children: [
                          Text(
                            "Vous n'avez pas de compte ? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()),
                              );
                            },
                            child: Text(
                              "Inscrivez-vous",
                              style: TextStyle(
                                color: AppColors.blueG,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
}

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class User {
  String email;
  String password;
  String username;

  User(this.email, this.password, this.username);
}
