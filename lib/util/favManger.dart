import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../pages/core/bottomNviGationBar/chatsScreen.dart';
import '../pages/core/bottomNviGationBar/settings.dart';
import '../pages/core/main_screen.dart';
import '../pages/core/profilMecancien.dart';
import 'Colores.dart';
class MyAPP extends StatefulWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  State<MyAPP> createState() => _MyAPPState();
}

class _MyAPPState extends State<MyAPP> {

  int _currentIndex = 0 ;
  final  _children = [
    MyHomePag(),
    FavoritesUI(),
    ProfileDisplayPage(),
    SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :
      _children[_currentIndex],
      bottomNavigationBar:


      DecoratedBox(
        decoration: BoxDecoration(


          gradient: LinearGradient(
            colors: [AppColors.greyW, Colors.white30],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Container(
          height: 70,

          child: GNav(
            gap: 10,
            color: AppColors.blueG,
            iconSize: 24,
            tabBackgroundColor: AppColors.greyW,
            padding: EdgeInsets.all(8),
            tabs: [
              GButton(
                icon: Icons.home ,
                text: 'Home',
                iconActiveColor: Colors.black,
                textColor: Colors.black,
              ),
              GButton(
                icon: Icons.chat,
                text: 'Chats',
                iconActiveColor: Colors.redAccent,textColor: Colors.redAccent,
                onPressed: (){  },
              ),
              GButton(
                icon: Icons.person,
                text: 'profil',
                iconActiveColor: Colors.blueAccent,
                textColor: Colors.blueAccent   ,
                onPressed: (){},
              ),
              GButton(
                icon: Icons.settings,
                text: 'settings',
                iconActiveColor: Colors.grey.shade700,textColor: Colors.grey.shade700,

              ),
            ],


            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });

            },



          ),
        ),
      ),










    );
  }
}

