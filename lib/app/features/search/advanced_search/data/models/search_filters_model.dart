import 'dart:convert';

class FilterModel {
  final List<Book>? books;
  final List<Book>? muhaddiths;
  final List<Book>? rawis;
  final List<Book>? rulings;
  final List<Book>? topics;
  final List<Type>? types;

  FilterModel({
    this.books,
    this.muhaddiths,
    this.rawis,
    this.rulings,
    this.topics,
    this.types,
  });

  factory FilterModel.fromRawJson(String str) =>
      FilterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    books: json["books"] == null
        ? []
        : List<Book>.from(json["books"]!.map((x) => Book.fromJson(x))),
    muhaddiths: json["muhaddiths"] == null
        ? []
        : List<Book>.from(json["muhaddiths"]!.map((x) => Book.fromJson(x))),
    rawis: json["rawis"] == null
        ? []
        : List<Book>.from(json["rawis"]!.map((x) => Book.fromJson(x))),
    rulings: json["rulings"] == null
        ? []
        : List<Book>.from(json["rulings"]!.map((x) => Book.fromJson(x))),
    topics: json["topics"] == null
        ? []
        : List<Book>.from(json["topics"]!.map((x) => Book.fromJson(x))),
    types: json["types"] == null
        ? []
        : List<Type>.from(json["types"]!.map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "books": books == null
        ? []
        : List<dynamic>.from(books!.map((x) => x.toJson())),
    "muhaddiths": muhaddiths == null
        ? []
        : List<dynamic>.from(muhaddiths!.map((x) => x.toJson())),
    "rawis": rawis == null
        ? []
        : List<dynamic>.from(rawis!.map((x) => x.toJson())),
    "rulings": rulings == null
        ? []
        : List<dynamic>.from(rulings!.map((x) => x.toJson())),
    "topics": topics == null
        ? []
        : List<dynamic>.from(topics!.map((x) => x.toJson())),
    "types": types == null
        ? []
        : List<dynamic>.from(types!.map((x) => x.toJson())),
  };
}

class Book {
  final String? id;
  final String? name;

  Book({this.id, this.name});

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Book.fromJson(Map<String, dynamic> json) =>
      Book(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class Type {
  final String? id;
  final String? label;

  Type({this.id, this.label});

  factory Type.fromRawJson(String str) => Type.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Type.fromJson(Map<String, dynamic> json) =>
      Type(id: json["id"], label: json["label"]);

  Map<String, dynamic> toJson() => {"id": id, "label": label};
}
