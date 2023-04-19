import 'package:flutter/material.dart';
import 'package:untitled/services/hopitalService.dart';
import '../../../util/Colores.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:untitled/util/serveur.dart';
class HopitalPharListView extends StatefulWidget {
  const HopitalPharListView({Key? key}) : super(key: key);

  @override
  _HopitalPharListViewState createState() => _HopitalPharListViewState();
}

class _HopitalPharListViewState extends State<HopitalPharListView> {
  late Future<List<HopitalPhar>> hopitals;
  String _selectedState = 'TOUS';
  String _searchString = '';
  bool _loading = true;
  @override
  void initState() {
    hopitals = getData();
    super.initState();
  }

  Future<List<HopitalPhar>> getData() async {
    String url = 'http://${localhost.server}:3000/hopitalphar/getall';

    var jsonData = await http.get(Uri.parse(url));

    if (jsonData.statusCode == 200) {
      List data = jsonDecode(jsonData.body);
      List<HopitalPhar> allHopitals = [];

      for (var hopitalJson in data) {
        HopitalPhar hopital = HopitalPhar.fromJson(hopitalJson);
        allHopitals .add(hopital);
      }

      setState(() {
        _loading = false;
      });

      return allHopitals;
    } else {
      throw Exception("error");
    }
  }

  List<HopitalPhar> getFilteredHotels(List<HopitalPhar> hopitals) {
    var filteredhopitalss = hopitals;

    if (_selectedState != 'TOUS') {
      filteredhopitalss = filteredhopitalss
          .where((hopital) => hopital.state == _selectedState)
          .toList();
    }

    if (_searchString.isNotEmpty) {
      filteredhopitalss = filteredhopitalss
          .where((hopital) =>
          hopital.name.toLowerCase().contains(_searchString.toLowerCase()))
          .toList();
    }

    return filteredhopitalss;
  }

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
              hintText: 'chercher les hopitals par nom',
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
                    FutureBuilder<List<HopitalPhar>>(
                      future: hopitals,
                      builder:
                          (BuildContext context, AsyncSnapshot<List<HopitalPhar>> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        } else if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final filteredhopitals = getFilteredHotels(snapshot.data!);
                        return ListView.builder(

                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredhopitals.length,
                          itemBuilder: (BuildContext context, int index) {
                            final hopital = filteredhopitals[index];
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
                                            image: NetworkImage( hopital.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(hopital.name),
                                          subtitle: Text(
                                            '${hopital.location} | ${hopital.state} | ${hopital.number}',
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
      ),
    );
  }
}