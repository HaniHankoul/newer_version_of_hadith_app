import 'dart:convert';

class FavoriteModel {
  final List<Item>? items;
  final Pagination? pagination;

  FavoriteModel({this.items, this.pagination});

  factory FavoriteModel.fromRawJson(String str) =>
      FavoriteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Item {
  final String? id;
  final String? text;
  final String? normalText;
  final int? hadithNumber;
  final String? type;
  final String? sanad;
  final Book? book;
  final Book? rawi;
  final Book? ruling;
  final Book? muhaddith;
  final List<dynamic>? topics;
  final bool? hasExplanation;
  final bool? hasSubValid;

  Item({
    this.id,
    this.text,
    this.normalText,
    this.hadithNumber,
    this.type,
    this.sanad,
    this.book,
    this.rawi,
    this.ruling,
    this.muhaddith,
    this.topics,
    this.hasExplanation,
    this.hasSubValid,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    text: json["text"],
    normalText: json["normalText"],
    hadithNumber: json["hadithNumber"],
    type: json["type"],
    sanad: json["sanad"],
    book: json["book"] == null ? null : Book.fromJson(json["book"]),
    rawi: json["rawi"] == null ? null : Book.fromJson(json["rawi"]),
    ruling: json["ruling"] == null ? null : Book.fromJson(json["ruling"]),
    muhaddith: json["muhaddith"] == null
        ? null
        : Book.fromJson(json["muhaddith"]),
    topics: json["topics"] == null
        ? []
        : List<dynamic>.from(json["topics"]!.map((x) => x)),
    hasExplanation: json["hasExplanation"],
    hasSubValid: json["hasSubValid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "normalText": normalText,
    "hadithNumber": hadithNumber,
    "type": type,
    "sanad": sanad,
    "book": book?.toJson(),
    "rawi": rawi?.toJson(),
    "ruling": ruling?.toJson(),
    "muhaddith": muhaddith?.toJson(),
    "topics": topics == null ? [] : List<dynamic>.from(topics!.map((x) => x)),
    "hasExplanation": hasExplanation,
    "hasSubValid": hasSubValid,
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

class Pagination {
  final int? page;
  final int? size;
  final int? totalItems;
  final int? totalPages;
  final bool? hasNext;
  final bool? hasPrevious;

  Pagination({
    this.page,
    this.size,
    this.totalItems,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  });

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json["page"],
    size: json["size"],
    totalItems: json["totalItems"],
    totalPages: json["totalPages"],
    hasNext: json["hasNext"],
    hasPrevious: json["hasPrevious"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "size": size,
    "totalItems": totalItems,
    "totalPages": totalPages,
    "hasNext": hasNext,
    "hasPrevious": hasPrevious,
  };
}
