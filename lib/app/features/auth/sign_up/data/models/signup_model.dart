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
    name: (json["name"] ?? '').toString(),
    email: (json["email"] ?? '').toString(),
    password: (json["password"] ?? '').toString(),
    gender: (json["gender"] ?? '').toString(),
    birthDate:
        DateTime.tryParse((json["birthDate"] ?? '').toString()) ??
        DateTime.now(),
    avatarUrl: (json["avatarUrl"] ?? '').toString(),
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
