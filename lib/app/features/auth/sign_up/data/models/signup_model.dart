import 'dart:convert';

class Signupmodel {
  final String name;
  final String email;
  final String password;
  final String gender;
  final DateTime birthDate;
  final String? avatarUrl;

  Signupmodel({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.birthDate,
    this.avatarUrl,
  });

  factory Signupmodel.fromRawJson(String str) =>
      Signupmodel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Signupmodel.fromJson(Map<String, dynamic> json) => Signupmodel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    gender: json["gender"],
    birthDate: DateTime.parse(json["birthDate"]),
    avatarUrl: json["avatarUrl"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "gender": gender,
    "birthDate":
        "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
    "avatarUrl": avatarUrl,
  };
}
