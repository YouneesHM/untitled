import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class MapScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
         automaticallyImplyLeading: true,
          title: Text('Google Maps Demo'),
        ),
        body: Center(
          child: MaterialButton(
            child: Text('Open Google Maps'),
            onPressed: () {
              launch('https://www.google.com/maps');
            },
          ),
        ),
      ),
    );
  }
}
