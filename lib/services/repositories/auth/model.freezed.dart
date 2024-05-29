// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return _UserData.fromJson(json);
}

/// @nodoc
mixin _$UserData {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  set displayName(String value) => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  set email(String value) => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  set photoUrl(String value) => throw _privateConstructorUsedError;
  String get serverAuthCode => throw _privateConstructorUsedError;
  set serverAuthCode(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) = _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call({String id, String displayName, String email, String photoUrl, String serverAuthCode});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData> implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? email = null,
    Object? photoUrl = null,
    Object? serverAuthCode = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      serverAuthCode: null == serverAuthCode
          ? _value.serverAuthCode
          : serverAuthCode // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataImplCopyWith<$Res> implements $UserDataCopyWith<$Res> {
  factory _$$UserDataImplCopyWith(_$UserDataImpl value, $Res Function(_$UserDataImpl) then) =
      __$$UserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String displayName, String email, String photoUrl, String serverAuthCode});
}

/// @nodoc
class __$$UserDataImplCopyWithImpl<$Res> extends _$UserDataCopyWithImpl<$Res, _$UserDataImpl>
    implements _$$UserDataImplCopyWith<$Res> {
  __$$UserDataImplCopyWithImpl(_$UserDataImpl _value, $Res Function(_$UserDataImpl) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? email = null,
    Object? photoUrl = null,
    Object? serverAuthCode = null,
  }) {
    return _then(_$UserDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: null == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      serverAuthCode: null == serverAuthCode
          ? _value.serverAuthCode
          : serverAuthCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataImpl with DiagnosticableTreeMixin implements _UserData {
  _$UserDataImpl(
      {required this.id,
      required this.displayName,
      required this.email,
      required this.photoUrl,
      required this.serverAuthCode});

  factory _$UserDataImpl.fromJson(Map<String, dynamic> json) => _$$UserDataImplFromJson(json);

  @override
  String id;
  @override
  String displayName;
  @override
  String email;
  @override
  String photoUrl;
  @override
  String serverAuthCode;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserData(id: $id, displayName: $displayName, email: $email, photoUrl: $photoUrl, serverAuthCode: $serverAuthCode)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'UserData'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('photoUrl', photoUrl))
      ..add(DiagnosticsProperty('serverAuthCode', serverAuthCode));
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      __$$UserDataImplCopyWithImpl<_$UserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataImplToJson(
      this,
    );
  }
}

abstract class _UserData implements UserData {
  factory _UserData(
      {required String id,
      required String displayName,
      required String email,
      required String photoUrl,
      required String serverAuthCode}) = _$UserDataImpl;

  factory _UserData.fromJson(Map<String, dynamic> json) = _$UserDataImpl.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  String get displayName;
  set displayName(String value);
  @override
  String get email;
  set email(String value);
  @override
  String get photoUrl;
  set photoUrl(String value);
  @override
  String get serverAuthCode;
  set serverAuthCode(String value);
  @override
  @JsonKey(ignore: true)
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith => throw _privateConstructorUsedError;
}
