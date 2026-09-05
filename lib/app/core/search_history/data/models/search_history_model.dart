import 'dart:convert';

class SearchHistoryModel {
  final String? id;
  final String? searchText;
  final String? searchSource;
  final String? createdAt;

  SearchHistoryModel({
    this.id,
    this.searchText,
    this.searchSource,
    this.createdAt,
  });

  factory SearchHistoryModel.fromRawJson(String str) =>
      SearchHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) =>
      SearchHistoryModel(
        id: json["id"],
        searchText: json["searchText"],
        searchSource: json["searchSource"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "searchText": searchText,
    "searchSource": searchSource,
    "createdAt": createdAt,
  };
}
