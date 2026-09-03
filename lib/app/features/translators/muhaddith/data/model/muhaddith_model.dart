import 'dart:convert';

class MuhaddithModel {
  final int? serialNumber;
  final String? name;
  final String? about;

  MuhaddithModel({this.serialNumber, this.name, this.about});

  factory MuhaddithModel.fromRawJson(String str) =>
      MuhaddithModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MuhaddithModel.fromJson(Map<String, dynamic> json) => MuhaddithModel(
    serialNumber: json["serialNumber"],
    name: json["name"],
    about: json["about"],
  );

  Map<String, dynamic> toJson() => {
    "serialNumber": serialNumber,
    "name": name,
    "about": about,
  };
}
