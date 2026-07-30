import 'dart:convert';

class Questionsmodelresponse {
  final String id;
  final Hadith hadith;
  final String askerText;
  final bool isActive;
  final String answerText;
  final DateTime createdAt;
  final DateTime updatedAt;

  Questionsmodelresponse({
    required this.id,
    required this.hadith,
    required this.askerText,
    required this.isActive,
    required this.answerText,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Questionsmodelresponse.fromRawJson(String str) =>
      Questionsmodelresponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Questionsmodelresponse.fromJson(Map<String, dynamic> json) =>
      Questionsmodelresponse(
        id: json["id"],
        hadith: Hadith.fromJson(json["hadith"]),
        askerText: json["askerText"],
        isActive: json["isActive"],
        answerText: json["answerText"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hadith": hadith.toJson(),
    "askerText": askerText,
    "isActive": isActive,
    "answerText": answerText,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Hadith {
  final String id;
  final String text;
  final String normalText;
  final int hadithNumber;
  final String type;
  final String sanad;
  final Book muhaddith;
  final Book rawi;
  final Book book;
  final Book ruling;

  Hadith({
    required this.id,
    required this.text,
    required this.normalText,
    required this.hadithNumber,
    required this.type,
    required this.sanad,
    required this.muhaddith,
    required this.rawi,
    required this.book,
    required this.ruling,
  });

  factory Hadith.fromRawJson(String str) => Hadith.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hadith.fromJson(Map<String, dynamic> json) => Hadith(
    id: json["id"],
    text: json["text"],
    normalText: json["normalText"],
    hadithNumber: json["hadithNumber"],
    type: json["type"],
    sanad: json["sanad"],
    muhaddith: Book.fromJson(json["muhaddith"]),
    rawi: Book.fromJson(json["rawi"]),
    book: Book.fromJson(json["book"]),
    ruling: Book.fromJson(json["ruling"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "normalText": normalText,
    "hadithNumber": hadithNumber,
    "type": type,
    "sanad": sanad,
    "muhaddith": muhaddith.toJson(),
    "rawi": rawi.toJson(),
    "book": book.toJson(),
    "ruling": ruling.toJson(),
  };
}

class Book {
  final String id;
  final String name;

  Book({required this.id, required this.name});

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Book.fromJson(Map<String, dynamic> json) =>
      Book(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
