
class Profile {
  final String firstname;
  final String lastname;
  final String email;
  final String gender ;
  final String phoneNumber;
  final String governmentList;


  Profile({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.governmentList,

  });

  factory Profile.fromJson(Map<String, dynamic> parsedjson) {
    return Profile(
      firstname: parsedjson["username"],
      lastname: parsedjson["name"],
      phoneNumber: parsedjson["phoneNumber"],
      email: parsedjson["email"],
      gender: parsedjson["role"],
      governmentList: parsedjson["governmentList"],




    );
  }
}