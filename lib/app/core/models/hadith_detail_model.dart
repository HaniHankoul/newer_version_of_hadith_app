import 'dart:convert';

class HadithDetailModel {
  final String? id;
  final String? text;
  final String? normalText;
  final int? hadithNumber;
  final String? type;
  final String? sanad;
  final Book? muhaddith;
  final Book? rawi;
  final Book? book;
  final Book? ruling;
  final List<Book>? topics;
  final Explanation? explanation;
  final dynamic validAlternative;
  final int? commentsCount;
  final dynamic viewerState;

  HadithDetailModel({
    this.id,
    this.text,
    this.normalText,
    this.hadithNumber,
    this.type,
    this.sanad,
    this.muhaddith,
    this.rawi,
    this.book,
    this.ruling,
    this.topics,
    this.explanation,
    this.validAlternative,
    this.commentsCount,
    this.viewerState,
  });

  factory HadithDetailModel.fromRawJson(String str) =>
      HadithDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HadithDetailModel.fromJson(Map<String, dynamic> json) =>
      HadithDetailModel(
        id: json["id"],
        text: json["text"],
        normalText: json["normalText"],
        hadithNumber: json["hadithNumber"],
        type: json["type"],
        sanad: json["sanad"],
        muhaddith: json["muhaddith"] == null
            ? null
            : Book.fromJson(json["muhaddith"]),
        rawi: json["rawi"] == null ? null : Book.fromJson(json["rawi"]),
        book: json["book"] == null ? null : Book.fromJson(json["book"]),
        ruling: json["ruling"] == null ? null : Book.fromJson(json["ruling"]),
        topics: json["topics"] == null
            ? []
            : List<Book>.from(json["topics"]!.map((x) => Book.fromJson(x))),
        explanation: json["explanation"] == null
            ? null
            : Explanation.fromJson(json["explanation"]),
        validAlternative: json["validAlternative"],
        commentsCount: json["commentsCount"],
        viewerState: json["viewerState"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "normalText": normalText,
    "hadithNumber": hadithNumber,
    "type": type,
    "sanad": sanad,
    "muhaddith": muhaddith?.toJson(),
    "rawi": rawi?.toJson(),
    "book": book?.toJson(),
    "ruling": ruling?.toJson(),
    "topics": topics == null
        ? []
        : List<dynamic>.from(topics!.map((x) => x.toJson())),
    "explanation": explanation?.toJson(),
    "validAlternative": validAlternative,
    "commentsCount": commentsCount,
    "viewerState": viewerState,
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

class Explanation {
  final String? id;
  final String? text;
  final String? normalText;

  Explanation({this.id, this.text, this.normalText});

  factory Explanation.fromRawJson(String str) =>
      Explanation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Explanation.fromJson(Map<String, dynamic> json) => Explanation(
    id: json["id"],
    text: json["text"],
    normalText: json["normalText"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "normalText": normalText,
  };
}
