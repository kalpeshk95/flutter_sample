// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'holding_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HoldingResponse _$HoldingResponseFromJson(Map<String, dynamic> json) {
  return _HoldingResponse.fromJson(json);
}

/// @nodoc
mixin _$HoldingResponse {
  Data? get data => throw _privateConstructorUsedError;

  /// Serializes this HoldingResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HoldingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HoldingResponseCopyWith<HoldingResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HoldingResponseCopyWith<$Res> {
  factory $HoldingResponseCopyWith(
          HoldingResponse value, $Res Function(HoldingResponse) then) =
      _$HoldingResponseCopyWithImpl<$Res, HoldingResponse>;
  @useResult
  $Res call({Data? data});

  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class _$HoldingResponseCopyWithImpl<$Res, $Val extends HoldingResponse>
    implements $HoldingResponseCopyWith<$Res> {
  _$HoldingResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HoldingResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data?,
    ) as $Val);
  }

  /// Create a copy of HoldingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $DataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HoldingResponseImplCopyWith<$Res>
    implements $HoldingResponseCopyWith<$Res> {
  factory _$$HoldingResponseImplCopyWith(_$HoldingResponseImpl value,
          $Res Function(_$HoldingResponseImpl) then) =
      __$$HoldingResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Data? data});

  @override
  $DataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$HoldingResponseImplCopyWithImpl<$Res>
    extends _$HoldingResponseCopyWithImpl<$Res, _$HoldingResponseImpl>
    implements _$$HoldingResponseImplCopyWith<$Res> {
  __$$HoldingResponseImplCopyWithImpl(
      _$HoldingResponseImpl _value, $Res Function(_$HoldingResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of HoldingResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$HoldingResponseImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HoldingResponseImpl implements _HoldingResponse {
  const _$HoldingResponseImpl({this.data});

  factory _$HoldingResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HoldingResponseImplFromJson(json);

  @override
  final Data? data;

  @override
  String toString() {
    return 'HoldingResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HoldingResponseImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of HoldingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HoldingResponseImplCopyWith<_$HoldingResponseImpl> get copyWith =>
      __$$HoldingResponseImplCopyWithImpl<_$HoldingResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HoldingResponseImplToJson(
      this,
    );
  }
}

abstract class _HoldingResponse implements HoldingResponse {
  const factory _HoldingResponse({final Data? data}) = _$HoldingResponseImpl;

  factory _HoldingResponse.fromJson(Map<String, dynamic> json) =
      _$HoldingResponseImpl.fromJson;

  @override
  Data? get data;

  /// Create a copy of HoldingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HoldingResponseImplCopyWith<_$HoldingResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  List<UserHolding>? get userHolding => throw _privateConstructorUsedError;

  /// Serializes this Data to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res, Data>;
  @useResult
  $Res call({List<UserHolding>? userHolding});
}

/// @nodoc
class _$DataCopyWithImpl<$Res, $Val extends Data>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userHolding = freezed,
  }) {
    return _then(_value.copyWith(
      userHolding: freezed == userHolding
          ? _value.userHolding
          : userHolding // ignore: cast_nullable_to_non_nullable
              as List<UserHolding>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<UserHolding>? userHolding});
}

/// @nodoc
class __$$DataImplCopyWithImpl<$Res>
    extends _$DataCopyWithImpl<$Res, _$DataImpl>
    implements _$$DataImplCopyWith<$Res> {
  __$$DataImplCopyWithImpl(_$DataImpl _value, $Res Function(_$DataImpl) _then)
      : super(_value, _then);

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userHolding = freezed,
  }) {
    return _then(_$DataImpl(
      userHolding: freezed == userHolding
          ? _value._userHolding
          : userHolding // ignore: cast_nullable_to_non_nullable
              as List<UserHolding>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataImpl implements _Data {
  const _$DataImpl({final List<UserHolding>? userHolding})
      : _userHolding = userHolding;

  factory _$DataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataImplFromJson(json);

  final List<UserHolding>? _userHolding;
  @override
  List<UserHolding>? get userHolding {
    final value = _userHolding;
    if (value == null) return null;
    if (_userHolding is EqualUnmodifiableListView) return _userHolding;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Data(userHolding: $userHolding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            const DeepCollectionEquality()
                .equals(other._userHolding, _userHolding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_userHolding));

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      __$$DataImplCopyWithImpl<_$DataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataImplToJson(
      this,
    );
  }
}

abstract class _Data implements Data {
  const factory _Data({final List<UserHolding>? userHolding}) = _$DataImpl;

  factory _Data.fromJson(Map<String, dynamic> json) = _$DataImpl.fromJson;

  @override
  List<UserHolding>? get userHolding;

  /// Create a copy of Data
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserHolding _$UserHoldingFromJson(Map<String, dynamic> json) {
  return _UserHolding.fromJson(json);
}

/// @nodoc
mixin _$UserHolding {
  String? get symbol => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;
  double? get ltp => throw _privateConstructorUsedError;
  double? get avgPrice => throw _privateConstructorUsedError;
  double? get close => throw _privateConstructorUsedError;

  /// Serializes this UserHolding to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserHolding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserHoldingCopyWith<UserHolding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserHoldingCopyWith<$Res> {
  factory $UserHoldingCopyWith(
          UserHolding value, $Res Function(UserHolding) then) =
      _$UserHoldingCopyWithImpl<$Res, UserHolding>;
  @useResult
  $Res call(
      {String? symbol,
      int? quantity,
      double? ltp,
      double? avgPrice,
      double? close});
}

/// @nodoc
class _$UserHoldingCopyWithImpl<$Res, $Val extends UserHolding>
    implements $UserHoldingCopyWith<$Res> {
  _$UserHoldingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserHolding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = freezed,
    Object? quantity = freezed,
    Object? ltp = freezed,
    Object? avgPrice = freezed,
    Object? close = freezed,
  }) {
    return _then(_value.copyWith(
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      ltp: freezed == ltp
          ? _value.ltp
          : ltp // ignore: cast_nullable_to_non_nullable
              as double?,
      avgPrice: freezed == avgPrice
          ? _value.avgPrice
          : avgPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      close: freezed == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserHoldingImplCopyWith<$Res>
    implements $UserHoldingCopyWith<$Res> {
  factory _$$UserHoldingImplCopyWith(
          _$UserHoldingImpl value, $Res Function(_$UserHoldingImpl) then) =
      __$$UserHoldingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? symbol,
      int? quantity,
      double? ltp,
      double? avgPrice,
      double? close});
}

/// @nodoc
class __$$UserHoldingImplCopyWithImpl<$Res>
    extends _$UserHoldingCopyWithImpl<$Res, _$UserHoldingImpl>
    implements _$$UserHoldingImplCopyWith<$Res> {
  __$$UserHoldingImplCopyWithImpl(
      _$UserHoldingImpl _value, $Res Function(_$UserHoldingImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserHolding
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = freezed,
    Object? quantity = freezed,
    Object? ltp = freezed,
    Object? avgPrice = freezed,
    Object? close = freezed,
  }) {
    return _then(_$UserHoldingImpl(
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
      ltp: freezed == ltp
          ? _value.ltp
          : ltp // ignore: cast_nullable_to_non_nullable
              as double?,
      avgPrice: freezed == avgPrice
          ? _value.avgPrice
          : avgPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      close: freezed == close
          ? _value.close
          : close // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserHoldingImpl implements _UserHolding {
  const _$UserHoldingImpl(
      {this.symbol, this.quantity, this.ltp, this.avgPrice, this.close});

  factory _$UserHoldingImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserHoldingImplFromJson(json);

  @override
  final String? symbol;
  @override
  final int? quantity;
  @override
  final double? ltp;
  @override
  final double? avgPrice;
  @override
  final double? close;

  @override
  String toString() {
    return 'UserHolding(symbol: $symbol, quantity: $quantity, ltp: $ltp, avgPrice: $avgPrice, close: $close)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserHoldingImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.ltp, ltp) || other.ltp == ltp) &&
            (identical(other.avgPrice, avgPrice) ||
                other.avgPrice == avgPrice) &&
            (identical(other.close, close) || other.close == close));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, symbol, quantity, ltp, avgPrice, close);

  /// Create a copy of UserHolding
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserHoldingImplCopyWith<_$UserHoldingImpl> get copyWith =>
      __$$UserHoldingImplCopyWithImpl<_$UserHoldingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserHoldingImplToJson(
      this,
    );
  }
}

abstract class _UserHolding implements UserHolding {
  const factory _UserHolding(
      {final String? symbol,
      final int? quantity,
      final double? ltp,
      final double? avgPrice,
      final double? close}) = _$UserHoldingImpl;

  factory _UserHolding.fromJson(Map<String, dynamic> json) =
      _$UserHoldingImpl.fromJson;

  @override
  String? get symbol;
  @override
  int? get quantity;
  @override
  double? get ltp;
  @override
  double? get avgPrice;
  @override
  double? get close;

  /// Create a copy of UserHolding
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserHoldingImplCopyWith<_$UserHoldingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
