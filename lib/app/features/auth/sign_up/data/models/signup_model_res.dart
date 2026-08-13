import 'dart:convert';

class Signupmodelresponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final User user;

  Signupmodelresponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory Signupmodelresponse.fromRawJson(String str) =>
      Signupmodelresponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Signupmodelresponse.fromJson(Map<String, dynamic> json) =>
      Signupmodelresponse(
        accessToken: (json["accessToken"] ?? '').toString(),
        refreshToken: (json["refreshToken"] ?? '').toString(),
        tokenType: (json["tokenType"] ?? '').toString(),
        expiresIn: (json["expiresIn"] is int)
            ? json["expiresIn"] as int
            : int.tryParse((json["expiresIn"] ?? '').toString()) ?? 0,
        user: User.fromJson(Map<String, dynamic>.from(json["user"] ?? {})),
      );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "tokenType": tokenType,
    "expiresIn": expiresIn,
    "user": user.toJson(),
  };
}

class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final String status;
  final String gender;
  final String type;
  final DateTime birthDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.status,
    required this.gender,
    required this.type,
    required this.birthDate,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: (json["id"] ?? '').toString(),
    name: (json["name"] ?? '').toString(),
    email: (json["email"] ?? '').toString(),
    avatarUrl: (json["avatarUrl"] ?? '').toString(),
    status: (json["status"] ?? '').toString(),
    gender: (json["gender"] ?? '').toString(),
    type: (json["type"] ?? '').toString(),
    birthDate:
        DateTime.tryParse((json["birthDate"] ?? '').toString()) ??
        DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatarUrl": avatarUrl,
    "status": status,
    "gender": gender,
    "type": type,
    "birthDate":
        "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
  };
}
