import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/pages/auth/signin.dart';
import 'package:untitled/util/serveur.dart';
import 'package:untitled/util/Colores.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();



  Future<void> save() async {
    final url = Uri.parse('http://${localhost.server}:3000/signup');
    final headers = <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    final body = <String, String>{
      'email': user.email,
      'password': user.password,
      'username': user.username,
    };

    final response = await http.post(url, headers: headers, body: body);
    print(response.body);

    Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
  }


  User user = User('', '', '');

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyW,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/inscri.png',
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
                      height: 350,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _usernameController,
                        onChanged: (value) {
                          user.username = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrez quelque chose';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: AppColors.blueG,
                          ),
                          hintText: 'Nom d\'utilisateur',
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
                      child: TextFormField(
                        controller: TextEditingController(text: user.email),
                        onChanged: (value) {
                          user.email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrez quelque chose';
                          } else if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return null;
                          } else {
                            return 'Entrez une adresse email valide';
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
                      child: TextFormField(
                        controller: TextEditingController(text: user.password),
                        onChanged: (value) {
                          user.password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Entrez quelque chose';
                          }
                          return null;
                        },
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              save();
                            } else {
                              print("not ok");
                            }
                          },
                          child: Text(
                            "S'inscrire",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Castoro",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(95, 20, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Vous avez déjà un compte ?",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Castoro",
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signin(),
                                ),
                              );
                            },
                            child: Text(
                              "CONNEXION",
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