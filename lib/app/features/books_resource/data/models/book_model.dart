import 'dart:convert';

class BookModel {
  final String? id;
  final String? name;
  final Muhaddith? muhaddith;

  BookModel({this.id, this.name, this.muhaddith});

  factory BookModel.fromRawJson(String str) =>
      BookModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    id: json["id"],
    name: json["name"],
    muhaddith: json["muhaddith"] == null
        ? null
        : Muhaddith.fromJson(json["muhaddith"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "muhaddith": muhaddith?.toJson(),
  };
}

class Muhaddith {
  final String? id;
  final String? name;

  Muhaddith({this.id, this.name});

  factory Muhaddith.fromRawJson(String str) =>
      Muhaddith.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Muhaddith.fromJson(Map<String, dynamic> json) =>
      Muhaddith(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
