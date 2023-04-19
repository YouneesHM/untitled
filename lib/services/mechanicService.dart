import 'dart:ffi';

class Mechanic {
  final String name;
  final String city;
  final String rating;
  final String phoneNumber ;
  bool canMove;

  Mechanic({
    required this.name,
    required this.city,
    required this.rating,
    required this.phoneNumber,
    this.canMove= false,
  });
  factory Mechanic.fromJson(Map<String, dynamic> json) {
    return Mechanic(
      name: (json['companyname'] != null ? json['companyname'] : json['name']) as String,
      city: json['city'] != null ? json['city'] as String : '',
      rating: json['rating'] != null ? json['rating'] as String :'',
      phoneNumber: json['phoneNumber'] != null ? json['phoneNumber'] as String : '',
      canMove: json['canMove'] != null ? json['canMove'] as bool : false,
    );
  }
  Map<String, dynamic> toJson() {
    return {

      "companyname": name,
      "city": city,
      "phoneNumber": phoneNumber,
      "rating": rating,
      "canMove": canMove,
    };
  }




}

