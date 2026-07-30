import 'dart:convert';

class Searchfilters {
  final List<Book> books;
  final List<Book> muhaddiths;
  final List<Book> rawis;
  final List<Book> rulings;
  final List<Book> topics;
  final List<Type> types;

  Searchfilters({
    required this.books,
    required this.muhaddiths,
    required this.rawis,
    required this.rulings,
    required this.topics,
    required this.types,
  });

  factory Searchfilters.fromRawJson(String str) =>
      Searchfilters.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Searchfilters.fromJson(Map<String, dynamic> json) => Searchfilters(
    books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
    muhaddiths: List<Book>.from(
      json["muhaddiths"].map((x) => Book.fromJson(x)),
    ),
    rawis: List<Book>.from(json["rawis"].map((x) => Book.fromJson(x))),
    rulings: List<Book>.from(json["rulings"].map((x) => Book.fromJson(x))),
    topics: List<Book>.from(json["topics"].map((x) => Book.fromJson(x))),
    types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "books": List<dynamic>.from(books.map((x) => x.toJson())),
    "muhaddiths": List<dynamic>.from(muhaddiths.map((x) => x.toJson())),
    "rawis": List<dynamic>.from(rawis.map((x) => x.toJson())),
    "rulings": List<dynamic>.from(rulings.map((x) => x.toJson())),
    "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
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

class Type {
  final String id;
  final String label;

  Type({required this.id, required this.label});

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Type.fromJson(Map<String, dynamic> json) =>
      Type(id: json["id"], label: json["label"]);

  Map<String, dynamic> toJson() => {"id": id, "label": label};
}
