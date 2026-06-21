import 'package:hadith_app/app/core/helper/enums.dart';

class UserModel {
  int id;
  String name;
  String email;
  String passWord;
  String? avatarUrl;
  bool isActivated;
  EnGender gender;
  EnUserType userType;
  DateTime birthdate;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.passWord,
    required this.avatarUrl,
    required this.isActivated,
    required this.gender,
    required this.userType,
    required this.birthdate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    passWord: json['passWord'] as String,
    avatarUrl: json['avatarUrl'] as String?,
    isActivated: json['isActivated'] as bool,
    gender: EnGender.values[json['gender'] as int],
    userType: EnUserType.values[json['userType'] as int],
    birthdate: DateTime.parse(json['birthdate'] as String),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );
}
