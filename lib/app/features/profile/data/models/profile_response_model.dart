import 'dart:convert';

class ProfileResponse {
  final String? id;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final String? status;
  final String? gender;
  final String? type;
  final DateTime? birthDate;

  ProfileResponse({
    this.id,
    this.name,
    this.email,
    this.avatarUrl,
    this.status,
    this.gender,
    this.type,
    this.birthDate,
  });

  factory ProfileResponse.fromRawJson(String str) =>
      ProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        avatarUrl: json["avatarUrl"],
        status: json["status"],
        gender: json["gender"],
        type: json["type"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "avatarUrl": avatarUrl,
    "status": status,
    "gender": gender,
    "type": type,
    "birthDate": birthDate == null
        ? null
        : "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
  };
}
