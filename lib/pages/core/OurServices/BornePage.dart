import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../services/borneService.dart';
import '../../../util/Colores.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled/util/serveur.dart';


class BornePg extends StatefulWidget {


  @override
  _BornePgState createState() => _BornePgState();
}

class _BornePgState extends State<BornePg> {

 late Future<List<Borne>> bornes;
  String _selectedState = 'TOUS';
  String _searchString = '';
  bool _loading = true;
  double rating = 0;


  @override
  void initState() {
    super.initState();
    bornes = getData();
  }

  Future<List<Borne>> getData() async {
    String url = 'http://${localhost.server}:3000/borne/getall';

    var jsonData = await http.get(Uri.parse(url));

    if (jsonData.statusCode == 200) {
      List data = jsonDecode(jsonData.body);
      List<Borne> allBornes = [];

      for (var borneJson in data) {
        Borne borne = Borne.fromJson(borneJson);
        allBornes.add(borne);
      }

      setState(() {
        _loading = false;
      });

      return allBornes;
    } else {
      throw Exception("Error ");
    }

  }



 Future<void> updateRating(String hospitalName, double newRating) async {
   print('newRating: $newRating');
   final response = await http.patch(
       Uri.parse('http://${localhost.server}:3000/borne/update/$hospitalName'),
       body: {'rating': newRating});
   if (response.statusCode != 200) {
     throw Exception('Failed to update rating');
   }

   final responseAvg = await http.get(Uri.parse('http://${localhost.server}:3000/borne/getall'));
   if (responseAvg.statusCode == 200) {
     final newAvg = double.parse(responseAvg.body);
     setState(() {
       rating = newAvg;
     });
   } else {
     throw Exception('Failed to fetch rating');
   }
 }


















 List<Borne > getFilteredHospitals(List<Borne > kiosques) {
   var filteredcafes = kiosques;

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

   return Scaffold(
     backgroundColor: AppColors.greyW,
     appBar: AppBar(

       title:Container(
         decoration: BoxDecoration(
           color:AppColors.blueG,
           borderRadius: BorderRadius.circular(10.0),
         ),
         child:TextField(
           decoration: InputDecoration(
             hintText: 'chercher les SOS ',
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
     body: _loading
         ? Center(child: CircularProgressIndicator())
         :       SingleChildScrollView(
       child:Column(
           children: [
       Padding(
       padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
       child: Column(
         children: [
           const SizedBox(height: 10),
           DropdownButtonFormField<String>(
             value: _selectedState,
             items: states
                 .map((state) => DropdownMenuItem<String>(
               value: state,
               child: Text(state),
             ))
                 .toList(),
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
              const SizedBox(height: 10),
              FutureBuilder<List<Borne>>(
                  future: bornes, // this is a Future<List<Borne>>
                  builder: (BuildContext context, AsyncSnapshot<List<Borne>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final borneList =  getFilteredHospitals(snapshot.data!); // wait for the future to complete and get the List<Borne>

                    return ListView.builder(

                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: borneList.length,
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
                                          ),
                                          image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/Isos.png',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 90,
                                        decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(1, 3),
                                              blurRadius: 19,
                                            ),
                                          ],
                                          color: Color(0xFFD3E0EA),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            Center(
                                              child: Text(
                                                borneList[index]
                                                    .rating
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16),

                                  Expanded(
                                    child: ListTile(
                                      onTap: () {},
                                      title: Text(
                                          borneList[index].name),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [

                                          Text(borneList[index].city),
                                          RatingBar.builder(
                                            itemSize: 30,
                                            ignoreGestures:false,
                                            initialRating: rating,
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
                                                  updateRating(borneList[index].name, newRatingDouble); // pass double to function
                                                });
                                              }

                                          )



                        ],
                    ),
                    trailing:
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: borneList[index].isFavorite
                            ? AppColors.blanc
                            : AppColors.blanc,
                      ),
                      onPressed: () {
                        setState(() {
                          borneList[index].isFavorite =
                          !borneList[index].isFavorite;
                        });
                      },
                    ),
                  ),
                ),

              ],
              ),
              ),
            ],
          );
        },
      );
    }

              ),


            ],

          ),
      ),
   ],
       )
               )
   );


  }

  }


