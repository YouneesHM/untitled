import 'package:flutter/material.dart';
import 'package:untitled/services/hotelService.dart';
import '../../../util/Colores.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/util/serveur.dart';
class HotelListView extends StatefulWidget {
  const HotelListView({Key? key}) : super(key: key);

  @override
  _HotelListViewState createState() => _HotelListViewState();
}

class _HotelListViewState extends State<HotelListView> {
  late Future<List<Hotel>> hotels;
  String _selectedState = 'TOUS';
  String _searchString = '';
  bool _loading = true;

  @override
  void initState() {
    hotels = getData();
    super.initState();
  }

  Future<List<Hotel>> getData() async {
    String url = 'http://${localhost.server}:3000/hotels/getall';

    var jsonData = await http.get(Uri.parse(url));

    if (jsonData.statusCode == 200) {
      List data = jsonDecode(jsonData.body);
      List<Hotel> allHotels = [];

      for (var hotelJson in data) {
        Hotel hotel = Hotel.fromJson(hotelJson);
        allHotels.add(hotel);
      }

      setState(() {
        _loading = false;
      });

      return allHotels;
    } else {
      throw Exception("error");
    }
  }

  List<Hotel> getFilteredHotels(List<Hotel> hotels) {
    var filteredHotels = hotels;

    if (_selectedState != 'TOUS') {
      filteredHotels = filteredHotels
          .where((hotel) => hotel.state == _selectedState)
          .toList();
    }

    if (_searchString.isNotEmpty) {
      filteredHotels = filteredHotels
          .where((hotel) =>
          hotel.name.toLowerCase().contains(_searchString.toLowerCase()))
          .toList();
    }

    return filteredHotels;
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
              hintText: 'chercher les hotels par nom',
              prefixIcon: Icon(Icons.search_rounded, color: Colors.white,),
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
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
                      FutureBuilder<List<Hotel>>(
                        future: hotels,
                        builder:
                            (BuildContext context, AsyncSnapshot<List<Hotel>> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('${snapshot.error}'));
                          } else if (!snapshot.hasData) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          final filteredHotels = getFilteredHotels(snapshot.data!);
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredHotels.length,
                            itemBuilder: (BuildContext context, int index) {
                              final hotel = filteredHotels[index];
                              return Column(

                                children: [
                                  SizedBox(height:10 ),
                                  Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(1, 3),
                                                blurRadius: 19,
                                              ),
                                            ],
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage( hotel.image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),

                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: Text(hotel.name),
                                            subtitle: Text(
                                              ' | ${hotel.state} | ${hotel.number}',
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
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
    );
  }
}


