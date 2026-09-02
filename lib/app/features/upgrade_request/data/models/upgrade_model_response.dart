import 'dart:convert';

class UpgradeModelResponse {
  final String? createdAt;
  final bool? documentAvailable;
  final String? documentOriginalName;
  final int? documentSizeBytes;
  final String? id;
  final String? notes;
  final dynamic rejectionReason;
  final dynamic reviewNotes;
  final dynamic reviewedAt;
  final String? status;
  final String? updatedAt;

  UpgradeModelResponse({
    this.createdAt,
    this.documentAvailable,
    this.documentOriginalName,
    this.documentSizeBytes,
    this.id,
    this.notes,
    this.rejectionReason,
    this.reviewNotes,
    this.reviewedAt,
    this.status,
    this.updatedAt,
  });

  factory UpgradeModelResponse.fromRawJson(String str) =>
      UpgradeModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpgradeModelResponse.fromJson(Map<String, dynamic> json) =>
      UpgradeModelResponse(
        createdAt: json["createdAt"],
        documentAvailable: json["documentAvailable"],
        documentOriginalName: json["documentOriginalName"],
        documentSizeBytes: json["documentSizeBytes"],
        id: json["id"],
        notes: json["notes"],
        rejectionReason: json["rejectionReason"],
        reviewNotes: json["reviewNotes"],
        reviewedAt: json["reviewedAt"],
        status: json["status"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt,
    "documentAvailable": documentAvailable,
    "documentOriginalName": documentOriginalName,
    "documentSizeBytes": documentSizeBytes,
    "id": id,
    "notes": notes,
    "rejectionReason": rejectionReason,
    "reviewNotes": reviewNotes,
    "reviewedAt": reviewedAt,
    "status": status,
    "updatedAt": updatedAt,
  };
}
