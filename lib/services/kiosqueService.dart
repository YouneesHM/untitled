class Kiosque {
  final String name;
  final String city;
  final String rating;
  final String phoneNumber ;
  bool isFavorite;

  Kiosque({
    required this.name,
    required this.city,
    required this.rating,
    required this.phoneNumber,
    this.isFavorite = false,
  });

  factory Kiosque.fromJson(Map<String, dynamic> parsedjson) {
    return Kiosque(
      name: parsedjson["name"],
      city: parsedjson["city"]  ,
      phoneNumber: parsedjson["phoneNumber"],
      rating: parsedjson["rating"],
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
