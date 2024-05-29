import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'model.g.dart';

@unfreezed
class UserData with _$UserData {
  factory UserData({
    required String id,
    required String displayName,
    required String email,
    required String photoUrl,
    required String serverAuthCode,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}
