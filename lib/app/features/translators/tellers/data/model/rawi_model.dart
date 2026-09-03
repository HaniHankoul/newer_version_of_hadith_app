import 'dart:convert';

class RawiModel {
  final int? serialNumber;
  final String? name;
  final String? about;

  RawiModel({this.serialNumber, this.name, this.about});

  factory RawiModel.fromRawJson(String str) =>
      RawiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RawiModel.fromJson(Map<String, dynamic> json) => RawiModel(
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
