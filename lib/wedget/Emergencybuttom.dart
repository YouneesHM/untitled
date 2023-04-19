import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../util/Colores.dart';
import '../wedget/Emergencybuttom.dart';
class MyEmergencyButton extends StatelessWidget {
  final String phoneNumber;

  const MyEmergencyButton({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 44, vertical: 10),
      child: Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.blueG),
            ),
            onPressed: () async {
              try {
                final trimmedPhoneNumber = phoneNumber.trim(); // Remove leading/trailing whitespace
                await launch("tel:$trimmedPhoneNumber");
              } on PlatformException catch (e) {
                print(e.toString());
              }
            },
            child: Text(phoneNumber),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}