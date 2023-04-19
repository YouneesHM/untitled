import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/util/serveur.dart';
import '../../../util/Colores.dart';
class FavoritesUI extends StatefulWidget {
  @override
  _FavoritesUIState createState() => _FavoritesUIState();
}

class _FavoritesUIState extends State<FavoritesUI> {
  List<dynamic> messages = [];
  String _responseMessage = '';

  Future<String> _fetchUser() async {
    final url = 'http://${localhost.server}:3000/get/6473c2864741ea6c1f2527e9'; // Replace with the actual URL

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final userJson = json.decode(response.body);
      return userJson['companyname'];
    } else {
      throw Exception('Failed to fetch user. Error: ${response.statusCode}');
    }
  }

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
    // Reverse the dataList to show the latest data first
    List<dynamic> reversedList = List.from(messages.reversed);

    return Scaffold(
      backgroundColor: AppColors.greyW,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.blueG,
        title: Text(
          'Les messages',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: reversedList.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = reversedList[index];
                  return GestureDetector(
                    onTap: () {
                      _showDialogBox(context);
                    },
                    child: Container(
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
                        leading: FutureBuilder<String>(
                          future: _fetchUser(),
                          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                                  Text(snapshot.data ?? 'No title'),
                                ],
                              );
                            }
                          },
                        ),
                        title: Text(data['content'] ?? 'No title'),
                        trailing: Text(data['createdAt'] ?? 'No description'),
                      ),

                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDialogBox(BuildContext context) async {
    String message = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String inputMessage = '';

        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          title: Text('Envoyer un message'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  inputMessage = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your message',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Envoyer',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                Navigator.of(context).pop(inputMessage);
              },
            ),
          ],
        );
      },
    );

    if (message != null && message.isNotEmpty) {
      String response = await _sendMessageToServer(message);

      // Process the response
      print(response);

      setState(() {
        _responseMessage = response;
      });
    }
  }

  Future<String> _sendMessageToServer(String message) async {
    try {
      // Prepare the request body
      Map<String, String> requestBody = {'content': message};

      // Send the POST request to the server
      final response = await http.post(
        Uri.parse('http://${localhost.server}:3000/messages/'), // Replace with the actual URL
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return 'Message sent successfully.';
      } else {
        return 'Failed to send message. Status code: ${response.statusCode}';
      }
    } catch (error) {
      return 'Error sending message: $error';
    }
  }
}
