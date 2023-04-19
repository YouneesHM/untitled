class Hotel {
  final String name;

  final String number;
  final String state;
  final String image;


  Hotel({required this.name, required this.number, required this.state, required this.image});


  factory Hotel.fromJson(Map<String, dynamic> parsedjson) {
    return Hotel(
        name: parsedjson["name"],

        number: parsedjson["number"],
        state: parsedjson["state"],
        image: parsedjson["image"],



    );




  }
}



