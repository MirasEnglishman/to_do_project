import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String email;
  final String? displayName;
  final bool isEmailVerified;

  UserModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.isEmailVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? uid,
    String? email,
    String? displayName,
    bool? isEmailVerified,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }
}