// import 'dart:convert';

// class Searchmodel {
//   final String query;
//   final String? mode;
//   final bool? includeExplanation;
//   final List<String>? muhaddithIds;
//   final List<String>? rawiIds;
//   final List<String>? types;
//   final List<String>? rulingIds;
//   final List<String>? bookIds;
//   final List<String>? topicIds;
//   final int? page;
//   final int? size;
//   final String? sort;

//   Searchmodel({
//     required this.query,
//     this.mode,
//     this.includeExplanation,
//     this.muhaddithIds,
//     this.rawiIds,
//     this.types,
//     this.rulingIds,
//     this.bookIds,
//     this.topicIds,
//     this.page,
//     this.size,
//     this.sort,
//   });

//   factory Searchmodel.fromRawJson(String str) =>
//       Searchmodel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Searchmodel.fromJson(Map<String, dynamic> json) => Searchmodel(
//     query: json["query"],
//     mode: json["mode"],
//     includeExplanation: json["includeExplanation"],
//     muhaddithIds: json["muhaddithIds"] == null
//         ? []
//         : List<String>.from(json["muhaddithIds"]!.map((x) => x)),
//     rawiIds: json["rawiIds"] == null
//         ? []
//         : List<String>.from(json["rawiIds"]!.map((x) => x)),
//     types: json["types"] == null
//         ? []
//         : List<String>.from(json["types"]!.map((x) => x)),
//     rulingIds: json["rulingIds"] == null
//         ? []
//         : List<String>.from(json["rulingIds"]!.map((x) => x)),
//     bookIds: json["bookIds"] == null
//         ? []
//         : List<String>.from(json["bookIds"]!.map((x) => x)),
//     topicIds: json["topicIds"] == null
//         ? []
//         : List<String>.from(json["topicIds"]!.map((x) => x)),
//     page: json["page"],
//     size: json["size"],
//     sort: json["sort"],
//   );

//   Map<String, dynamic> toJson() => {
//     "query": query,
//     "mode": mode,
//     "includeExplanation": includeExplanation,
//     "muhaddithIds": muhaddithIds == null
//         ? []
//         : List<dynamic>.from(muhaddithIds!.map((x) => x)),
//     "rawiIds": rawiIds == null
//         ? []
//         : List<dynamic>.from(rawiIds!.map((x) => x)),
//     "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
//     "rulingIds": rulingIds == null
//         ? []
//         : List<dynamic>.from(rulingIds!.map((x) => x)),
//     "bookIds": bookIds == null
//         ? []
//         : List<dynamic>.from(bookIds!.map((x) => x)),
//     "topicIds": topicIds == null
//         ? []
//         : List<dynamic>.from(topicIds!.map((x) => x)),
//     "page": page,
//     "size": size,
//     "sort": sort,
//   };
// }
import 'dart:convert';

class Searchmodel {
  final List<Item> items;
  final Pagination pagination;

  Searchmodel({required this.items, required this.pagination});

  factory Searchmodel.fromRawJson(String str) =>
      Searchmodel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Searchmodel.fromJson(Map<String, dynamic> json) => Searchmodel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "pagination": pagination.toJson(),
  };
}

class Item {
  final String id;
  final String text;
  final String normalText;
  final int hadithNumber;
  final Type type;
  final String sanad;
  final Book book;
  final Book? rawi;
  final Book ruling;
  final Book muhaddith;
  final List<Book> topics;
  final bool hasExplanation;
  final bool hasSubValid;

  Item({
    required this.id,
    required this.text,
    required this.normalText,
    required this.hadithNumber,
    required this.type,
    required this.sanad,
    required this.book,
    required this.rawi,
    required this.ruling,
    required this.muhaddith,
    required this.topics,
    required this.hasExplanation,
    required this.hasSubValid,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    text: json["text"],
    normalText: json["normalText"],
    hadithNumber: json["hadithNumber"],
    type: typeValues.map[json["type"]]!,
    sanad: json["sanad"],
    book: Book.fromJson(json["book"]),
    rawi: json["rawi"] == null ? null : Book.fromJson(json["rawi"]),
    ruling: Book.fromJson(json["ruling"]),
    muhaddith: Book.fromJson(json["muhaddith"]),
    topics: List<Book>.from(json["topics"].map((x) => Book.fromJson(x))),
    hasExplanation: json["hasExplanation"],
    hasSubValid: json["hasSubValid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "normalText": normalText,
    "hadithNumber": hadithNumber,
    "type": typeValues.reverse[type],
    "sanad": sanad,
    "book": book.toJson(),
    "rawi": rawi?.toJson(),
    "ruling": ruling.toJson(),
    "muhaddith": muhaddith.toJson(),
    "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
    "hasExplanation": hasExplanation,
    "hasSubValid": hasSubValid,
  };
}

class Book {
  final String id;
  final String name;

  Book({required this.id, required this.name});

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Book.fromJson(Map<String, dynamic> json) =>
      Book(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

enum Type { MARFU }

final typeValues = EnumValues({"marfu": Type.MARFU});

class Pagination {
  final int page;
  final int size;
  final int totalItems;
  final int totalPages;
  final bool hasNext;
  final bool hasPrevious;

  Pagination({
    required this.page,
    required this.size,
    required this.totalItems,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
