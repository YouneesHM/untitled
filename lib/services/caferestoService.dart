class Caferesto {
  final String name;

  final String number;
  final String image;
  final String state;

  Caferesto({required this.name, required this.number, required this.image, required this.state});

  factory Caferesto.fromJson(Map<String, dynamic> parsedjson) {
    return Caferesto(
      name: parsedjson["name"],
      number: parsedjson["number"],
      state: parsedjson["state"],
      image: parsedjson["image"],



    );


}
}
