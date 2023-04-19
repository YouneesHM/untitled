import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:untitled/services/mechanicService.dart';
import '../../../util/demande.dart';
import '../../../util/Colores.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/util/serveur.dart';

class MechanicListPage extends StatefulWidget {
  @override
  _MechanicListPageState createState() => _MechanicListPageState();
}

class _MechanicListPageState extends State<MechanicListPage> {
  late Future<List<Mechanic>> mechanics;
  String _selectedState = 'TOUS';
  String _searchString = '';
  bool _loading = true;
  double rating = 0;

  @override
  void initState() {
    super.initState();
    mechanics = getData();
  }

  Future<List<Mechanic>> getData() async {
    String getAllUrl = 'http://${localhost.server}:3000/getall';
    String mechanicGetAllUrl = 'http://${localhost.server}:3000/mechanic/getall';

    try {
      var jsonData = await Future.wait([
        http.get(Uri.parse(getAllUrl)),
        http.get(Uri.parse(mechanicGetAllUrl)),
      ]);

      List<Mechanic> allMechanics = [];

      for (var response in jsonData) {
        if (response.statusCode == 200) {
          List data = jsonDecode(response.body);

          for (var borneJson in data) {
            try {
              if (borneJson != null) {
                Mechanic? borne = Mechanic.fromJson(borneJson);
                if (borne != null) {
                  allMechanics.add(borne);
                }
              }
            } catch (e) {
              print('Error parsing mechanic JSON: $e');
              print('JSON data: $borneJson');
            }
          }
        } else {
          throw Exception("Error: ${response.statusCode}");
        }
      }

      setState(() {
        _loading = false;
      });

      return allMechanics;
    } catch (e) {
      print('Error fetching mechanic data: $e');
      throw Exception('Failed to fetch mechanic data');
    }
  }






  Future<void> updateRating(String hospitalName, double newRating) async {
    print('newRating: $newRating');
    final response = await http.patch(
        Uri.parse('http://${localhost.server}:3000/mechanic/update/$hospitalName'),
        body: {'rating': newRating});
    if (response.statusCode != 200) {
      throw Exception('Failed to update rating');
    }

    final responseAvg = await http.get(Uri.parse('http://${localhost.server}:3000/mechanic/getall'));
    if (responseAvg.statusCode == 200) {
      final newAvg = double.parse(responseAvg.body);
      setState(() {
        rating = newAvg;
      });
    } else {
      throw Exception('Failed to fetch rating');
    }
  }

  List<Mechanic > getFilteredcafes(List<Mechanic > cafes) {
    var filteredcafes = cafes;

    if (_selectedState != 'TOUS') {
      filteredcafes  = filteredcafes
          .where((cafe) => cafe.city == _selectedState)
          .toList();
    }

    if (_searchString.isNotEmpty) {
      filteredcafes  = filteredcafes
          .where((cafe) =>
          cafe.name.toLowerCase().contains(_searchString.toLowerCase()))
          .toList();
    }

    return filteredcafes ;
  }

  @override
  Widget build(BuildContext context) {
    final List<String> states = ['TOUS', 'Ariana', 'Beja', 'Ben Arous', 'Bizerte', 'Gabes', 'Gafsa', 'Jendouba', 'Kairouan', 'Kasserine', 'Kebili', 'Kef', 'Mahdia', 'Manouba', 'Medenine', 'Monastir', 'Nabeul', 'Sfax', 'Sidi Bouzid', 'Siliana', 'Sousse', 'Tataouine', 'Tozeur', 'Tunis', 'Zaghouan',];
    return
      Scaffold(

        backgroundColor: AppColors.greyW,
        appBar:  AppBar(

          title:Container(
            decoration: BoxDecoration(
              color:AppColors.blueG,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:TextField(
              decoration: InputDecoration(
                hintText: 'chercher les mécansiens ',
                prefixIcon: Icon(Icons.search_rounded, color: Colors.white,),
                hintStyle: TextStyle(color: Colors.white),

              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _searchString = value;
                });
              },
            ),

          ),
          backgroundColor: AppColors.blueG ,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
          ),
        ),

        body:
        _loading
            ? Center(child: CircularProgressIndicator()) :
        Column(

          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedState,
                    items: states.map((state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedState = value!),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Add some spacing between the dropdown and button
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(AppColors.blueG),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DemandePage(),
                              ),
                            );
                          },
                          child: Text('Demander'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder<List<Mechanic>>(
                    future: mechanics,
                    builder: (BuildContext context, AsyncSnapshot<List<Mechanic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final mechanicList = getFilteredcafes(snapshot.data!);

                      // Sort mechanics by rating (higher to lower)
                      mechanicList.sort((a, b) => b.rating.compareTo(a.rating));

                      // Sort mechanics by city (Mahdia first)
                      mechanicList.sort((a, b) {
                        if (a.city == 'Mahdia' && b.city != 'Mahdia') {
                          return -1; // a is Mahdia, b is not Mahdia
                        } else if (a.city != 'Mahdia' && b.city == 'Mahdia') {
                          return 1; // a is not Mahdia, b is Mahdia
                        } else {
                          return 0; // both are Mahdia or both are not Mahdia
                        }
                      });

                      return ListView.builder(


                         shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics(),
                         itemCount: mechanicList.length,
                         itemBuilder: (BuildContext context, int index) {
                           return Column(
                             children: [
                               const SizedBox(height: 10),
                               Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                   color: AppColors.blanc,
                                 ),
                                 child: Row(
                                   children: [
                                     Column(
                                         children: [


                                           Container(
                                             width: 90,
                                             height: 90,
                                             decoration: const BoxDecoration(
                                               boxShadow: [
                                                 BoxShadow(
                                                   color: Colors.grey,
                                                   offset: Offset(1, 3),
                                                   blurRadius: 19,
                                                 ),
                                               ],
                                               borderRadius: BorderRadius.only(
                                                   topLeft: Radius.circular(10),
                                                   topRight: Radius.circular(10)),
                                               image: DecorationImage(
                                                 image: AssetImage(
                                                     'assets/images/MKANSIEN.jpg'),
                                                 fit: BoxFit.cover,


                                               ),
                                             ),

                                           ),

                                           Container(
                                             width: 90,
                                             decoration: const BoxDecoration(
                                               boxShadow: [ BoxShadow(
                                                 color: Colors.grey,
                                                 offset: Offset(1, 3),
                                                 blurRadius: 19,
                                               ),
                                               ],
                                               color: Color(0xFFD3E0EA),
                                               borderRadius: BorderRadius.only(
                                                 bottomLeft: Radius.circular(10),
                                                 bottomRight: Radius.circular(
                                                     10),),),
                                             child: Row(
                                                 mainAxisAlignment: MainAxisAlignment
                                                     .center,
                                                 children: [
                                                   const Icon(Icons.star,
                                                     color: Colors.amber,),
                                                   Center(
                                                     child: Text(
                                                       style: const TextStyle(
                                                         color: Colors.black,
                                                       ),
                                                       mechanicList[index]
                                                           .rating.toString(),
                                                     ),
                                                   ),
                                                 ]
                                             ),
                                           ),

                                         ]
                                     ),


                                     const SizedBox(width: 16),
                                     Expanded(
                                       child: ListTile(
                                         onTap: () {},
                                         title: Text(
                                             mechanicList[index].name),
                                         subtitle: Column(
                                           crossAxisAlignment: CrossAxisAlignment
                                               .start,
                                           children: [

                                             Text('${mechanicList[index]
                                                 .phoneNumber} || ${mechanicList[index]
                                                 .city}'),
                                             RatingBar.builder(
                                                 ignoreGestures:false,
                                                 initialRating: rating,
                                                 itemSize: 30,
                                                 minRating: 1,
                                                 direction: Axis.horizontal,
                                                 itemCount: 5,
                                                 allowHalfRating: true,
                                                 glowColor: AppColors.blueG,
                                                 itemPadding:
                                                 const EdgeInsets.symmetric(horizontal: 2.0),
                                                 itemBuilder: (context, _) =>
                                                 const Icon(
                                                   Icons.star,
                                                   color: Colors.amber,
                                                   shadows: [
                                                     Shadow(
                                                       color: Colors.black,
                                                       blurRadius: 3,
                                                       offset: Offset(0, 3),
                                                     ),
                                                   ],
                                                 ),
                                                 onRatingUpdate: (newRating) {
                                                   setState(() {
                                                     final newRatingDouble = newRating.toDouble(); // convert int to double
                                                     updateRating(mechanicList[index].name, newRatingDouble); // pass double to function
                                                   });
                                                 }

                                             )
                                           ],
                                         ),
                                         trailing:
                                         IconButton(
                                           icon: Icon(
                                             Icons.lens_sharp,
                                             color: mechanicList[index]
                                                 .canMove ? Colors.green: Colors
                                                 .grey,
                                           ),
                                           onPressed: () {

                                           },
                                         ),

                                       ),
                                     ),

                                   ],
                                 ),
                               ),
                             ],
                           );
                         }

                     );
                   }
                ),
              ),
            )


          ],
        ),
    );

  }
}



