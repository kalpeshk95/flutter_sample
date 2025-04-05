// To parse this JSON data, do
//
//     final holdingResponse = holdingResponseFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'holding_response.freezed.dart';
part 'holding_response.g.dart';

HoldingResponse holdingResponseFromJson(String str) => HoldingResponse.fromJson(json.decode(str));

String holdingResponseToJson(HoldingResponse data) => json.encode(data.toJson());

@freezed
class HoldingResponse with _$HoldingResponse {
  const factory HoldingResponse({
    Data? data,
  }) = _HoldingResponse;

  factory HoldingResponse.fromJson(Map<String, dynamic> json) => _$HoldingResponseFromJson(json);
}

@freezed
class Data with _$Data {
  const factory Data({
    List<UserHolding>? userHolding,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class UserHolding with _$UserHolding {
  const factory UserHolding({
    String? symbol,
    int? quantity,
    double? ltp,
    double? avgPrice,
    double? close,
  }) = _UserHolding;

  factory UserHolding.fromJson(Map<String, dynamic> json) => _$UserHoldingFromJson(json);
}
