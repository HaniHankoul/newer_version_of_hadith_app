import 'dart:convert';

class FakeHadithPage {
  final List<FakeHadithResponse> items;
  final FakeHadithPagination? pagination;

  FakeHadithPage({this.items = const [], this.pagination});

  factory FakeHadithPage.fromJson(Map<String, dynamic> json) => FakeHadithPage(
    items: json['items'] == null
        ? []
        : List<FakeHadithResponse>.from(
            json['items'].map((item) => FakeHadithResponse.fromJson(item)),
          ),
    pagination: json['pagination'] == null
        ? null
        : FakeHadithPagination.fromJson(json['pagination']),
  );
}

class FakeHadithPagination {
  final int? page;
  final int? size;
  final int? totalItems;
  final int? totalPages;
  final bool? hasNext;
  final bool? hasPrevious;

  FakeHadithPagination({
    this.page,
    this.size,
    this.totalItems,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  });

  factory FakeHadithPagination.fromJson(Map<String, dynamic> json) =>
      FakeHadithPagination(
        page: json['page'],
        size: json['size'],
        totalItems: json['totalItems'],
        totalPages: json['totalPages'],
        hasNext: json['hasNext'],
        hasPrevious: json['hasPrevious'],
      );
}

class FakeHadithResponse {
  final String? createdAt;
  final String? id;
  final String? normalText;
  final Ruling? ruling;
  final SubValid? subValid;
  final String? text;
  final String? updatedAt;

  FakeHadithResponse({
    this.createdAt,
    this.id,
    this.normalText,
    this.ruling,
    this.subValid,
    this.text,
    this.updatedAt,
  });

  factory FakeHadithResponse.fromRawJson(String str) =>
      FakeHadithResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FakeHadithResponse.fromJson(Map<String, dynamic> json) =>
      FakeHadithResponse(
        createdAt: json["createdAt"],
        id: json["id"],
        normalText: json["normalText"],
        ruling: json["ruling"] == null ? null : Ruling.fromJson(json["ruling"]),
        subValid: json["subValid"] == null
            ? null
            : SubValid.fromJson(json["subValid"]),
        text: json["text"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "id": id,
    "normalText": normalText,
    "ruling": ruling?.toJson(),
    "subValid": subValid?.toJson(),
    "text": text,
    "updatedAt": updatedAt,
  };
}

class Ruling {
  final String? id;
  final String? name;

  Ruling({this.id, this.name});

  factory Ruling.fromRawJson(String str) => Ruling.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ruling.fromJson(Map<String, dynamic> json) =>
      Ruling(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class SubValid {
  final Ruling? book;
  final int? hadithNumber;
  final bool? hasExplanation;
  final bool? hasSubValid;
  final String? id;
  final Ruling? muhaddith;
  final String? normalText;
  final Ruling? rawi;
  final Ruling? ruling;
  final String? sanad;
  final String? text;
  final List<Ruling>? topics;
  final String? type;

  SubValid({
    this.book,
    this.hadithNumber,
    this.hasExplanation,
    this.hasSubValid,
    this.id,
    this.muhaddith,
    this.normalText,
    this.rawi,
    this.ruling,
    this.sanad,
    this.text,
    this.topics,
    this.type,
  });

  factory SubValid.fromRawJson(String str) =>
      SubValid.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubValid.fromJson(Map<String, dynamic> json) => SubValid(
    book: json["book"] == null ? null : Ruling.fromJson(json["book"]),
    hadithNumber: json["hadithNumber"],
    hasExplanation: json["hasExplanation"],
    hasSubValid: json["hasSubValid"],
    id: json["id"],
    muhaddith: json["muhaddith"] == null
        ? null
        : Ruling.fromJson(json["muhaddith"]),
    normalText: json["normalText"],
    rawi: json["rawi"] == null ? null : Ruling.fromJson(json["rawi"]),
    ruling: json["ruling"] == null ? null : Ruling.fromJson(json["ruling"]),
    sanad: json["sanad"],
    text: json["text"],
    topics: json["topics"] == null
        ? []
        : List<Ruling>.from(json["topics"]!.map((x) => Ruling.fromJson(x))),
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "book": book?.toJson(),
    "hadithNumber": hadithNumber,
    "hasExplanation": hasExplanation,
    "hasSubValid": hasSubValid,
    "id": id,
    "muhaddith": muhaddith?.toJson(),
    "normalText": normalText,
    "rawi": rawi?.toJson(),
    "ruling": ruling?.toJson(),
    "sanad": sanad,
    "text": text,
    "topics": topics == null
        ? []
        : List<dynamic>.from(topics!.map((x) => x.toJson())),
    "type": type,
  };
}
