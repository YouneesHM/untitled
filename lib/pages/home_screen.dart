import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/auth/signin.dart';
import 'package:untitled/pages/auth/signup.dart';
import 'package:untitled/util/Colores.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return
          Scaffold(
              backgroundColor: Colors.white24,
            body: SingleChildScrollView(
             scrollDirection: Axis.vertical,
              child: Stack(

                children:
                [

                  Image.asset("assets/images/fond.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                  ),

                  Container(
                    decoration:BoxDecoration (
                        color:Colors.white70,
                        borderRadius : BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(left:70,top: 250,right: 40,) ,


                    child: Column(

                      children:[


                     const    Text(
                            'SALUT!',
                            style: TextStyle(
                              fontSize: 35,
                                color: AppColors.blueG ,
                              fontWeight: FontWeight.bold,fontFamily: "Castoro"), ),
                      const   SizedBox(
                          height:30 ,
                        ),
                   const       Text(  "Grâce à NotyCar, ",
                            style:(TextStyle
                              (fontSize:20,fontWeight: FontWeight.bold,
                              color: Colors.black, fontFamily: "Castoro",
                            ))),
                      const  SizedBox(
                          height:20 ,
                        ),
                   const     Text(  "trouver rapidement un mécanicien",
                            style:(TextStyle
                              (fontSize:16,fontWeight: FontWeight.bold,
                                color: Colors.black, fontFamily: "Castoro",
                            ))),
                     const   SizedBox(
                          height:10 ,
                        ),
                  const        Text(  " un kiosque                                                 ",
                            style:(TextStyle
                              (fontSize:16,fontWeight: FontWeight.bold,
                              color: Colors.black, fontFamily: "Castoro",
                            ))),
                  const        SizedBox(
                          height:10 ,
                        ),
                        const        Text(  "  un service d'assistance  SOS                 ",
                            style:(TextStyle
                              (fontSize:16,fontWeight: FontWeight.bold,
                              color: Colors.black, fontFamily: "Castoro",
                            ))),
                        const        SizedBox(
                          height:10 ,
                        ),
                  const        Text(  " ainsi que d'autres services utiles       ",
                            style:(TextStyle
                              (fontSize:16,fontWeight: FontWeight.bold,
                              color: Colors.black, fontFamily: "Castoro",
                            ))),

                     const    SizedBox(
                          height:100,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.blueG),
                          ),
                          onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(builder:(context) =>  Signin()   ) ) ;
                          },
                          child: const Text("          CONNEXION          "),
                        ),
                 const         SizedBox(
                          height:20,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppColors.blueG),
                          ),
                          onPressed: () {
                            Navigator.push(context, CupertinoPageRoute(builder:(context) =>  Signup()   ) ) ;
                          },
                          child: const  Text("          S'INSCRIRE            "),
                        ),
                        const         SizedBox(
                          height:20,
                        ),

                      ],

                    ),

                  ),



                ],

              ),
            ),

            );



  }

}