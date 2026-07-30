import 'dart:convert';

class CommentModelResponse {
  final String id;
  final Hadith hadith;
  final User user;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;

  CommentModelResponse({
    required this.id,
    required this.hadith,
    required this.user,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CommentModelResponse.fromRawJson(String str) =>
      CommentModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModelResponse.fromJson(Map<String, dynamic> json) =>
      CommentModelResponse(
        id: json["id"],
        hadith: Hadith.fromJson(json["hadith"]),
        user: User.fromJson(json["user"]),
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hadith": hadith.toJson(),
    "user": user.toJson(),
    "text": text,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Hadith {
  final String id;
  final String name;

  Hadith({required this.id, required this.name});

  factory Hadith.fromRawJson(String str) => Hadith.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hadith.fromJson(Map<String, dynamic> json) =>
      Hadith(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class User {
  final String id;
  final String name;
  final String email;
  final String type;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "type": type,
  };
}
