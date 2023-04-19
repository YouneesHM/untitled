import 'package:flutter/material.dart';
import '../../../services/caferestoService.dart';
import '../../../util/Colores.dart';
import 'package:http/http.dart' as http ;
import 'dart:convert';
import 'package:untitled/util/serveur.dart';
class CaferestoListView extends StatefulWidget {
  const CaferestoListView({Key? key}) : super(key: key);

  @override
  _CaferestoListViewState createState() => _CaferestoListViewState();
}

class _CaferestoListViewState extends State<CaferestoListView> {
  late Future<List<Caferesto >> caferstos;
  String _selectedState = 'TOUS';
  String _searchString = '';
  bool _loading = true;

  @override
  void initState() {
    caferstos = getData();
    super.initState();
  }

  Future<List<Caferesto >> getData() async {
    String url = 'http://${localhost.server}:3000/caferesto/getall';

    var jsonData = await http.get(Uri.parse(url));

    if (jsonData.statusCode == 200) {
      List data = jsonDecode(jsonData.body);
      List<Caferesto > allcafes = [];

      for (var cafeJson in data) {
        Caferesto  cafe = Caferesto .fromJson(cafeJson);
        allcafes.add(cafe);
      }

      setState(() {
        _loading = false;
      });

      return allcafes;
    } else {
      throw Exception("error");
    }
  }

  List<Caferesto > getFilteredcafes(List<Caferesto > cafes) {
    var filteredcafes = cafes;

    if (_selectedState != 'TOUS') {
      filteredcafes  = filteredcafes
          .where((cafe) => cafe.state == _selectedState)
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
              hintText: 'chercher cafes & restaurants par nom',
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
                    FutureBuilder<List<Caferesto>>(
                      future: caferstos,
                      builder:
                          (BuildContext context, AsyncSnapshot<List<Caferesto>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        } else if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final filteredcafes = getFilteredcafes(snapshot.data!);
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredcafes.length,
                          itemBuilder: (BuildContext context, int index) {
                            final hotel = filteredcafes[index];
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
                                            '| ${hotel.state} | ${hotel.number}',
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