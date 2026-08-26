import 'dart:convert';

class Avatarmodel {
  final String avatarUrl;
  final String avatarPublicId;

  Avatarmodel({required this.avatarUrl, required this.avatarPublicId});

  factory Avatarmodel.fromRawJson(String str) =>
      Avatarmodel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Avatarmodel.fromJson(Map<String, dynamic> json) => Avatarmodel(
    avatarUrl: json["avatarUrl"],
    avatarPublicId: json["avatarPublicId"],
  );

  Map<String, dynamic> toJson() => {
    "avatarUrl": avatarUrl,
    "avatarPublicId": avatarPublicId,
  };
}
