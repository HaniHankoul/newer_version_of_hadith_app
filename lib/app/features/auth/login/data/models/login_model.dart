import 'dart:convert';

class Loginmodel {
  final String email;
  final String password;

  Loginmodel({required this.email, required this.password});

  factory Loginmodel.fromRawJson(String str) =>
      Loginmodel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Loginmodel.fromJson(Map<String, dynamic> json) =>
      Loginmodel(email: json["email"], password: json["password"]);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
