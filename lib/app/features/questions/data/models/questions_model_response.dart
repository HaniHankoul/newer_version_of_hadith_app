import 'dart:convert';

class QuestionModelResponse {
  final String? id;
  final String? hadith;
  final String? askerText;
  final bool? isActive;
  final String? answerText;
  final String? createdAt;
  final String? updatedAt;

  QuestionModelResponse({
    this.id,
    this.hadith,
    this.askerText,
    this.isActive,
    this.answerText,
    this.createdAt,
    this.updatedAt,
  });

  factory QuestionModelResponse.fromRawJson(String str) =>
      QuestionModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionModelResponse.fromJson(Map<String, dynamic> json) =>
      QuestionModelResponse(
        id: json["id"],
        hadith: json["hadith"],
        askerText: json["askerText"],
        isActive: json["isActive"],
        answerText: json["answerText"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "hadith": hadith,
    "askerText": askerText,
    "isActive": isActive,
    "answerText": answerText,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}
