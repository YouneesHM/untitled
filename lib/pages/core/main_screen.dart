
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'package:untitled/pages/core/OurServices/mechanicPage.dart';
import 'package:untitled/util/Colores.dart';
import 'package:url_launcher/url_launcher.dart';

import 'OtherServices/caferestoscreen.dart';
import 'OtherServices/hopitalscreen.dart';
import 'OtherServices/hotelscreen.dart';
import 'OtherServices/serviceurgencescreen.dart';
import 'OurServices/BornePage.dart';
import 'OurServices/KiosquePage.dart';
import '../../util/notificationpage.dart';


class MyHomePag extends StatefulWidget {
  const MyHomePag({Key? key}) : super(key: key);

  @override
  State<MyHomePag> createState() => _MyHomePagState();
}

class _MyHomePagState extends State<MyHomePag> {




  @override
  Widget build(BuildContext context) {


    return Scaffold(



      backgroundColor: AppColors.greyW,


      appBar:AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset("assets/images/logo.png",
        height: 90,
          width: 130,
        ),
        backgroundColor: AppColors.blueG,
        elevation: 20,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.receipt_outlined),
            color: Colors.white,
            onPressed: () {
              Navigator.push(context, CupertinoPageRoute(builder:(context) => DataFetchPage()   ) ) ;

            },
          ),

        ],
      ),





        body:



      SingleChildScrollView(


        child: Stack(


          children: [

            SafeArea(
              child : Expanded (
              child: Column(

                children: [
                  Container(
                    decoration:BoxDecoration (
                        color:Color(0xFFF6F5F5),
                        borderRadius : BorderRadius.circular(20)),
                    margin: EdgeInsets.only(left:30,top: 30,right: 30,bottom: 30 ) ,

                    width:550 ,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      const   SizedBox(height: 16),

                        Row( mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              '  Nos Services :',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: "Castoro", color:Color(0xFF276678) ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CupertinoButton (
                              child : ClipRRect(
                                borderRadius: BorderRadius.circular(20),

                                child: Image.asset(
                                  "assets/images/MKANSIEN.jpg",
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder:(context) => MechanicListPage()   ) ) ;
                              },
                            ),
                            CupertinoButton (
                              child : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/google-maps.png",
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              onPressed: () {
                                launch('https://www.google.com/maps');                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CupertinoButton (
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/kioskk.png",
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context, CupertinoPageRoute(builder:(context) => KiosquePg()   ) ) ;
                              },
                            ),
                            CupertinoButton (
                              child : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "assets/images/Isos.png",
                                  height: 90,
                                  width: 90,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context, CupertinoPageRoute(builder:(context) => BornePg()   ) ) ;
                              },
                            ),
                          ],
                        )



                      ],
                    ),
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.start,
                    children:const  [
                      Text(
                        '  Autres Services :',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: "Castoro", color:Color(0xFF276678)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 250,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 4),
                          width: 250,

                          decoration: BoxDecoration(
                            color: AppColors.blueG,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 4),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(1, 6),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Material(
                                    elevation: 0,
                                    child: Ink.image(
                                      image: AssetImage(
                                        "assets/images/hotelss.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(builder: (context) => HotelListView()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              const Text(
                                'Hotel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Castoro",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          width: 230,
                          decoration: BoxDecoration(
                            color: AppColors.blueG,
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 4),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(1, 6),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Material(
                                    elevation: 0,
                                    child: Ink.image(
                                      image: AssetImage(
                                        "assets/images/cafe_resto.png",
                                      ),
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(builder: (context) => CaferestoListView  ()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Café & Resto',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Castoro",
                                ),
                              ),
                            ],
                          ),


                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          width: 230,
                          decoration: BoxDecoration(
                            color: AppColors.blueG,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 4),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(1, 6),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Material(
                                    elevation: 0,
                                    child: Ink.image(
                                      image: AssetImage(
                                        "assets/images/Hpitall.png",
                                      ),
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(builder: (context) => HopitalPharListView()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Hopitals & Pharmacies',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Castoro",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          width: 230,
                          decoration: BoxDecoration(
                            color: AppColors.blueG,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 4),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 5,
                                      offset: Offset(1, 6),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Material(
                                    elevation: 0,
                                    child: Ink.image(
                                      image: AssetImage(
                                        "assets/images/Nurgencee.png",
                                      ),
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>MyHomeP(

                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Services d'urgence",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Castoro",
                                ),
                              ),
                            ],
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






















