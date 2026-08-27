import 'dart:convert';

class SearchBodyModel {
  final String? query;
  final String? mode;
  final bool? includeExplanation;
  final String? sort;
  final int? page;
  final int? size;
  final List<dynamic>? bookIds;
  final List<dynamic>? muhaddithIds;
  final List<dynamic>? rawiIds;
  final List<dynamic>? rulingIds;
  final List<dynamic>? topicIds;
  final List<dynamic>? types;

  SearchBodyModel({
    this.query,
    this.mode,
    this.includeExplanation,
    this.sort,
    this.page,
    this.size,
    this.bookIds,
    this.muhaddithIds,
    this.rawiIds,
    this.rulingIds,
    this.topicIds,
    this.types,
  });

  factory SearchBodyModel.fromRawJson(String str) =>
      SearchBodyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchBodyModel.fromJson(Map<String, dynamic> json) =>
      SearchBodyModel(
        query: json["query"],
        mode: json["mode"],
        includeExplanation: json["includeExplanation"],
        sort: json["sort"],
        page: json["page"],
        size: json["size"],
        bookIds: json["bookIds"] == null
            ? []
            : List<dynamic>.from(json["bookIds"]!.map((x) => x)),
        muhaddithIds: json["muhaddithIds"] == null
            ? []
            : List<dynamic>.from(json["muhaddithIds"]!.map((x) => x)),
        rawiIds: json["rawiIds"] == null
            ? []
            : List<dynamic>.from(json["rawiIds"]!.map((x) => x)),
        rulingIds: json["rulingIds"] == null
            ? []
            : List<dynamic>.from(json["rulingIds"]!.map((x) => x)),
        topicIds: json["topicIds"] == null
            ? []
            : List<dynamic>.from(json["topicIds"]!.map((x) => x)),
        types: json["types"] == null
            ? []
            : List<dynamic>.from(json["types"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "query": query,
    "mode": mode,
    "includeExplanation": includeExplanation,
    "sort": sort,
    "page": page,
    "size": size,
    "bookIds": bookIds == null
        ? []
        : List<dynamic>.from(bookIds!.map((x) => x)),
    "muhaddithIds": muhaddithIds == null
        ? []
        : List<dynamic>.from(muhaddithIds!.map((x) => x)),
    "rawiIds": rawiIds == null
        ? []
        : List<dynamic>.from(rawiIds!.map((x) => x)),
    "rulingIds": rulingIds == null
        ? []
        : List<dynamic>.from(rulingIds!.map((x) => x)),
    "topicIds": topicIds == null
        ? []
        : List<dynamic>.from(topicIds!.map((x) => x)),
    "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
  };
}
