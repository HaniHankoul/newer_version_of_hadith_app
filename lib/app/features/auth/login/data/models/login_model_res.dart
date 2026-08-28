import 'dart:convert';

class Loginmodelresponse {
  final String accessToken;
  final String? refreshToken;
  final String? tokenType;
  final int? expiresIn;
  final User? user;

  Loginmodelresponse({
    required this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
    this.user,
  });

  factory Loginmodelresponse.fromRawJson(String str) =>
      Loginmodelresponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Loginmodelresponse.fromJson(Map<String, dynamic> json) =>
      Loginmodelresponse(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        tokenType: json["tokenType"],
        expiresIn: json["expiresIn"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "tokenType": tokenType,
    "expiresIn": expiresIn,
    "user": user?.toJson(),
  };
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final dynamic avatarUrl;
  final String? status;
  final String? gender;
  final String? type;
  final DateTime? birthDate;

  User({
    this.id,
    this.name,
    this.email,
    this.avatarUrl,
    this.status,
    this.gender,
    this.type,
    this.birthDate,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    avatarUrl: json["avatarUrl"],
    status: json["status"],
    gender: json["gender"],
    type: json["type"],
    birthDate: json["birthDate"] == null
        ? null
        : DateTime.parse(json["birthDate"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatarUrl": avatarUrl,
    "status": status,
    "gender": gender,
    "type": type,
    "birthDate": birthDate == null
        ? null
        : "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
  };
}
