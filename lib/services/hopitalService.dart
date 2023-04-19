
class HopitalPhar {
  final String name;
  final String location;
  final String number;
  final String image;
  final String state;

  HopitalPhar({required this.name, required this.location, required this.number, required this.image, required this.state});

  factory HopitalPhar.fromJson(Map<String, dynamic> parsedjson) {
    return HopitalPhar(
      name: parsedjson["name"],
      location: parsedjson["location"],
      number: parsedjson["number"],
      state: parsedjson["state"],
      image: parsedjson["image"],


    );
  }
}
