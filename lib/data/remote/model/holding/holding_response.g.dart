// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HoldingResponseImpl _$$HoldingResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$HoldingResponseImpl(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HoldingResponseImplToJson(
        _$HoldingResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$DataImpl _$$DataImplFromJson(Map<String, dynamic> json) => _$DataImpl(
      userHolding: (json['userHolding'] as List<dynamic>?)
          ?.map((e) => UserHolding.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DataImplToJson(_$DataImpl instance) =>
    <String, dynamic>{
      'userHolding': instance.userHolding,
    };

_$UserHoldingImpl _$$UserHoldingImplFromJson(Map<String, dynamic> json) =>
    _$UserHoldingImpl(
      symbol: json['symbol'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      ltp: (json['ltp'] as num?)?.toDouble(),
      avgPrice: (json['avgPrice'] as num?)?.toDouble(),
      close: (json['close'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$UserHoldingImplToJson(_$UserHoldingImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'quantity': instance.quantity,
      'ltp': instance.ltp,
      'avgPrice': instance.avgPrice,
      'close': instance.close,
    };
