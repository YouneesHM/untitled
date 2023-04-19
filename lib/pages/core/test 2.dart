import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/util/Colores.dart';
import 'package:untitled/util/serveur.dart';

class FavoritesUI extends StatefulWidget {
  @override
  _FavoritesUIState createState() => _FavoritesUIState();
}

class _FavoritesUIState extends State<FavoritesUI> {
  List<dynamic> messages = [];

  Future<void> fetchMessages() async {
    final response = await http.get(Uri.parse('http://${localhost.server}:3000/messages/'));

    if (response.statusCode == 200) {
      setState(() {
        messages = jsonDecode(response.body);
        messages = List.from(messages.reversed); // Reverse the messages list
      });
    } else {
      print('Failed to fetch messages. Error code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyW,
      appBar: AppBar(
        backgroundColor: AppColors.blueG,
        title: Text('Messages'),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          final content = message['content'] as String?; // Added null-check

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(4, 8),
                ),
              ],
            ),
            margin: EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              leading: FutureBuilder<void>(
                future: fetchMessages(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Icon(Icons.person); // Icon added here
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        Icon(Icons.person), // Icon added here
                        Text('Error: ${snapshot.error}'),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Icon(Icons.person),
                        SizedBox(height: 10),// Icon added here
                        Text('No title'),
                      ],
                    );
                  }
                },
              ),
              title: Text(content ?? ''), // Use default value when content is null
            ),
          );
        },
      ),
    );
  }
}
