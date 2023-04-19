import 'dart:ffi';

class Borne {
  final String name;
  final String city;
  final String rating;

  final String phoneNumber ;
  bool isFavorite;

  Borne({
    required this.name,
    required this.city,
    required this.rating,
    required this.phoneNumber,
    this.isFavorite = false,
  });
  factory Borne.fromJson(Map<String, dynamic> parsedjson) {
    return Borne(
      name: parsedjson["name"],
      city: parsedjson["city"]  ,
      phoneNumber: parsedjson["phoneNumber"],
      rating: parsedjson["rating"].toString(),
      isFavorite: parsedjson["isFavorite"],



    );



  }
  Map<String, dynamic> toJson() {
    return {

      "name": name,
      "city": city,
      "phoneNumber": phoneNumber,
      "rating": rating,
      "isFavorite": isFavorite,
    };
  }








}