// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NetworkResponse<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(NetworkExceptions error) failure,
    required TResult Function(String message) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(NetworkExceptions error)? failure,
    TResult? Function(String message)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(NetworkExceptions error)? failure,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SUCCESS<T> value) success,
    required TResult Function(FAILURE<T> value) failure,
    required TResult Function(LOADING<T> value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SUCCESS<T> value)? success,
    TResult? Function(FAILURE<T> value)? failure,
    TResult? Function(LOADING<T> value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SUCCESS<T> value)? success,
    TResult Function(FAILURE<T> value)? failure,
    TResult Function(LOADING<T> value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkResponseCopyWith<T, $Res> {
  factory $NetworkResponseCopyWith(
          NetworkResponse<T> value, $Res Function(NetworkResponse<T>) then) =
      _$NetworkResponseCopyWithImpl<T, $Res, NetworkResponse<T>>;
}

/// @nodoc
class _$NetworkResponseCopyWithImpl<T, $Res, $Val extends NetworkResponse<T>>
    implements $NetworkResponseCopyWith<T, $Res> {
  _$NetworkResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SUCCESSImplCopyWith<T, $Res> {
  factory _$$SUCCESSImplCopyWith(
          _$SUCCESSImpl<T> value, $Res Function(_$SUCCESSImpl<T>) then) =
      __$$SUCCESSImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$SUCCESSImplCopyWithImpl<T, $Res>
    extends _$NetworkResponseCopyWithImpl<T, $Res, _$SUCCESSImpl<T>>
    implements _$$SUCCESSImplCopyWith<T, $Res> {
  __$$SUCCESSImplCopyWithImpl(
      _$SUCCESSImpl<T> _value, $Res Function(_$SUCCESSImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SUCCESSImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$SUCCESSImpl<T> implements SUCCESS<T> {
  const _$SUCCESSImpl({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'NetworkResponse<$T>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SUCCESSImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SUCCESSImplCopyWith<T, _$SUCCESSImpl<T>> get copyWith =>
      __$$SUCCESSImplCopyWithImpl<T, _$SUCCESSImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(NetworkExceptions error) failure,
    required TResult Function(String message) loading,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(NetworkExceptions error)? failure,
    TResult? Function(String message)? loading,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(NetworkExceptions error)? failure,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SUCCESS<T> value) success,
    required TResult Function(FAILURE<T> value) failure,
    required TResult Function(LOADING<T> value) loading,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SUCCESS<T> value)? success,
    TResult? Function(FAILURE<T> value)? failure,
    TResult? Function(LOADING<T> value)? loading,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SUCCESS<T> value)? success,
    TResult Function(FAILURE<T> value)? failure,
    TResult Function(LOADING<T> value)? loading,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SUCCESS<T> implements NetworkResponse<T> {
  const factory SUCCESS({required final T data}) = _$SUCCESSImpl<T>;

  T get data;

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SUCCESSImplCopyWith<T, _$SUCCESSImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FAILUREImplCopyWith<T, $Res> {
  factory _$$FAILUREImplCopyWith(
          _$FAILUREImpl<T> value, $Res Function(_$FAILUREImpl<T>) then) =
      __$$FAILUREImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({NetworkExceptions error});

  $NetworkExceptionsCopyWith<$Res> get error;
}

/// @nodoc
class __$$FAILUREImplCopyWithImpl<T, $Res>
    extends _$NetworkResponseCopyWithImpl<T, $Res, _$FAILUREImpl<T>>
    implements _$$FAILUREImplCopyWith<T, $Res> {
  __$$FAILUREImplCopyWithImpl(
      _$FAILUREImpl<T> _value, $Res Function(_$FAILUREImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$FAILUREImpl<T>(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as NetworkExceptions,
    ));
  }

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NetworkExceptionsCopyWith<$Res> get error {
    return $NetworkExceptionsCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$FAILUREImpl<T> implements FAILURE<T> {
  const _$FAILUREImpl({required this.error});

  @override
  final NetworkExceptions error;

  @override
  String toString() {
    return 'NetworkResponse<$T>.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FAILUREImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FAILUREImplCopyWith<T, _$FAILUREImpl<T>> get copyWith =>
      __$$FAILUREImplCopyWithImpl<T, _$FAILUREImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(NetworkExceptions error) failure,
    required TResult Function(String message) loading,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(NetworkExceptions error)? failure,
    TResult? Function(String message)? loading,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(NetworkExceptions error)? failure,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SUCCESS<T> value) success,
    required TResult Function(FAILURE<T> value) failure,
    required TResult Function(LOADING<T> value) loading,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SUCCESS<T> value)? success,
    TResult? Function(FAILURE<T> value)? failure,
    TResult? Function(LOADING<T> value)? loading,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SUCCESS<T> value)? success,
    TResult Function(FAILURE<T> value)? failure,
    TResult Function(LOADING<T> value)? loading,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FAILURE<T> implements NetworkResponse<T> {
  const factory FAILURE({required final NetworkExceptions error}) =
      _$FAILUREImpl<T>;

  NetworkExceptions get error;

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FAILUREImplCopyWith<T, _$FAILUREImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LOADINGImplCopyWith<T, $Res> {
  factory _$$LOADINGImplCopyWith(
          _$LOADINGImpl<T> value, $Res Function(_$LOADINGImpl<T>) then) =
      __$$LOADINGImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$LOADINGImplCopyWithImpl<T, $Res>
    extends _$NetworkResponseCopyWithImpl<T, $Res, _$LOADINGImpl<T>>
    implements _$$LOADINGImplCopyWith<T, $Res> {
  __$$LOADINGImplCopyWithImpl(
      _$LOADINGImpl<T> _value, $Res Function(_$LOADINGImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$LOADINGImpl<T>(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LOADINGImpl<T> implements LOADING<T> {
  const _$LOADINGImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NetworkResponse<$T>.loading(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LOADINGImpl<T> &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LOADINGImplCopyWith<T, _$LOADINGImpl<T>> get copyWith =>
      __$$LOADINGImplCopyWithImpl<T, _$LOADINGImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(NetworkExceptions error) failure,
    required TResult Function(String message) loading,
  }) {
    return loading(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data)? success,
    TResult? Function(NetworkExceptions error)? failure,
    TResult? Function(String message)? loading,
  }) {
    return loading?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(NetworkExceptions error)? failure,
    TResult Function(String message)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SUCCESS<T> value) success,
    required TResult Function(FAILURE<T> value) failure,
    required TResult Function(LOADING<T> value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SUCCESS<T> value)? success,
    TResult? Function(FAILURE<T> value)? failure,
    TResult? Function(LOADING<T> value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SUCCESS<T> value)? success,
    TResult Function(FAILURE<T> value)? failure,
    TResult Function(LOADING<T> value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LOADING<T> implements NetworkResponse<T> {
  const factory LOADING(final String message) = _$LOADINGImpl<T>;

  String get message;

  /// Create a copy of NetworkResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LOADINGImplCopyWith<T, _$LOADINGImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
