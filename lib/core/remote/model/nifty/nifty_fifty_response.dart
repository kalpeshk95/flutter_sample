// To parse this JSON data, do
//
//     final niftyFiftyResponse = niftyFiftyResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'nifty_fifty_response.g.dart';

NiftyFiftyResponse niftyFiftyResponseFromJson(String str) => NiftyFiftyResponse.fromJson(json.decode(str));

String niftyFiftyResponseToJson(NiftyFiftyResponse data) => json.encode(data.toJson());

@JsonSerializable()
class NiftyFiftyResponse {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "advance")
  Advance? advance;
  @JsonKey(name: "timestamp")
  String? timestamp;
  @JsonKey(name: "data")
  List<Datum>? data;
  @JsonKey(name: "metadata")
  Metadata? metadata;
  @JsonKey(name: "marketStatus")
  MarketStatus? marketStatus;
  @JsonKey(name: "date30dAgo")
  String? date30DAgo;
  @JsonKey(name: "date365dAgo")
  String? date365DAgo;

  NiftyFiftyResponse({
    this.name,
    this.advance,
    this.timestamp,
    this.data,
    this.metadata,
    this.marketStatus,
    this.date30DAgo,
    this.date365DAgo,
  });

  factory NiftyFiftyResponse.fromJson(Map<String, dynamic> json) => _$NiftyFiftyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NiftyFiftyResponseToJson(this);
}

@JsonSerializable()
class Advance {
  @JsonKey(name: "declines")
  String? declines;
  @JsonKey(name: "advances")
  String? advances;
  @JsonKey(name: "unchanged")
  String? unchanged;

  Advance({
    this.declines,
    this.advances,
    this.unchanged,
  });

  factory Advance.fromJson(Map<String, dynamic> json) => _$AdvanceFromJson(json);

  Map<String, dynamic> toJson() => _$AdvanceToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "priority")
  int? priority;
  @JsonKey(name: "symbol")
  String? symbol;
  @JsonKey(name: "identifier")
  String? identifier;
  @JsonKey(name: "open")
  double? open;
  @JsonKey(name: "dayHigh")
  double? dayHigh;
  @JsonKey(name: "dayLow")
  double? dayLow;
  @JsonKey(name: "lastPrice")
  double? lastPrice;
  @JsonKey(name: "previousClose")
  double? previousClose;
  @JsonKey(name: "change")
  double? change;
  @JsonKey(name: "pChange")
  double? pChange;
  @JsonKey(name: "ffmc")
  double? ffmc;
  @JsonKey(name: "yearHigh")
  double? yearHigh;
  @JsonKey(name: "yearLow")
  double? yearLow;
  @JsonKey(name: "totalTradedVolume")
  int? totalTradedVolume;
  @JsonKey(name: "stockIndClosePrice")
  int? stockIndClosePrice;
  @JsonKey(name: "totalTradedValue")
  double? totalTradedValue;
  @JsonKey(name: "lastUpdateTime")
  String? lastUpdateTime;
  @JsonKey(name: "nearWKH")
  double? nearWkh;
  @JsonKey(name: "nearWKL")
  double? nearWkl;
  @JsonKey(name: "date365dAgo")
  String? date365DAgo;
  @JsonKey(name: "chart365dPath")
  String? chart365DPath;
  @JsonKey(name: "date30dAgo")
  String? date30DAgo;
  @JsonKey(name: "perChange30d")
  double? perChange30D;
  @JsonKey(name: "chart30dPath")
  String? chart30DPath;
  @JsonKey(name: "chartTodayPath")
  String? chartTodayPath;
  @JsonKey(name: "series")
  String? series;
  @JsonKey(name: "meta")
  Meta? meta;

  Datum({
    this.priority,
    this.symbol,
    this.identifier,
    this.open,
    this.dayHigh,
    this.dayLow,
    this.lastPrice,
    this.previousClose,
    this.change,
    this.pChange,
    this.ffmc,
    this.yearHigh,
    this.yearLow,
    this.totalTradedVolume,
    this.stockIndClosePrice,
    this.totalTradedValue,
    this.lastUpdateTime,
    this.nearWkh,
    this.nearWkl,
    this.date365DAgo,
    this.chart365DPath,
    this.date30DAgo,
    this.perChange30D,
    this.chart30DPath,
    this.chartTodayPath,
    this.series,
    this.meta,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "symbol")
  String? symbol;
  @JsonKey(name: "companyName")
  String? companyName;
  @JsonKey(name: "industry")
  String? industry;
  @JsonKey(name: "activeSeries")
  List<String>? activeSeries;
  @JsonKey(name: "isFNOSec")
  bool? isFnoSec;
  @JsonKey(name: "isCASec")
  bool? isCaSec;
  @JsonKey(name: "isSLBSec")
  bool? isSlbSec;
  @JsonKey(name: "isDebtSec")
  bool? isDebtSec;
  @JsonKey(name: "isSuspended")
  bool? isSuspended;
  @JsonKey(name: "tempSuspendedSeries")
  List<String>? tempSuspendedSeries;
  @JsonKey(name: "isETFSec")
  bool? isEtfSec;
  @JsonKey(name: "isDelisted")
  bool? isDelisted;
  @JsonKey(name: "isin")
  String? isin;
  @JsonKey(name: "slb_isin")
  String? slbIsin;
  @JsonKey(name: "listingDate")
  DateTime? listingDate;
  @JsonKey(name: "isMunicipalBond")
  bool? isMunicipalBond;
  @JsonKey(name: "isHybridSymbol")
  bool? isHybridSymbol;
  @JsonKey(name: "quotepreopenstatus")
  Quotepreopenstatus? quotepreopenstatus;

  Meta({
    this.symbol,
    this.companyName,
    this.industry,
    this.activeSeries,
    this.isFnoSec,
    this.isCaSec,
    this.isSlbSec,
    this.isDebtSec,
    this.isSuspended,
    this.tempSuspendedSeries,
    this.isEtfSec,
    this.isDelisted,
    this.isin,
    this.slbIsin,
    this.listingDate,
    this.isMunicipalBond,
    this.isHybridSymbol,
    this.quotepreopenstatus,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class Quotepreopenstatus {
  @JsonKey(name: "equityTime")
  String? equityTime;
  @JsonKey(name: "preOpenTime")
  String? preOpenTime;
  @JsonKey(name: "QuotePreOpenFlag")
  bool? quotePreOpenFlag;

  Quotepreopenstatus({
    this.equityTime,
    this.preOpenTime,
    this.quotePreOpenFlag,
  });

  factory Quotepreopenstatus.fromJson(Map<String, dynamic> json) => _$QuotepreopenstatusFromJson(json);

  Map<String, dynamic> toJson() => _$QuotepreopenstatusToJson(this);
}

@JsonSerializable()
class MarketStatus {
  @JsonKey(name: "market")
  String? market;
  @JsonKey(name: "marketStatus")
  String? marketStatus;
  @JsonKey(name: "tradeDate")
  String? tradeDate;
  @JsonKey(name: "index")
  String? index;
  @JsonKey(name: "last")
  int? last;
  @JsonKey(name: "variation")
  double? variation;
  @JsonKey(name: "percentChange")
  double? percentChange;
  @JsonKey(name: "marketStatusMessage")
  String? marketStatusMessage;

  MarketStatus({
    this.market,
    this.marketStatus,
    this.tradeDate,
    this.index,
    this.last,
    this.variation,
    this.percentChange,
    this.marketStatusMessage,
  });

  factory MarketStatus.fromJson(Map<String, dynamic> json) => _$MarketStatusFromJson(json);

  Map<String, dynamic> toJson() => _$MarketStatusToJson(this);
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "indexName")
  String? indexName;
  @JsonKey(name: "open")
  double? open;
  @JsonKey(name: "high")
  double? high;
  @JsonKey(name: "low")
  double? low;
  @JsonKey(name: "previousClose")
  double? previousClose;
  @JsonKey(name: "last")
  int? last;
  @JsonKey(name: "percChange")
  double? percChange;
  @JsonKey(name: "change")
  double? change;
  @JsonKey(name: "timeVal")
  String? timeVal;
  @JsonKey(name: "yearHigh")
  double? yearHigh;
  @JsonKey(name: "yearLow")
  double? yearLow;
  @JsonKey(name: "indicativeClose")
  int? indicativeClose;
  @JsonKey(name: "totalTradedVolume")
  int? totalTradedVolume;
  @JsonKey(name: "totalTradedValue")
  double? totalTradedValue;
  @JsonKey(name: "ffmc_sum")
  double? ffmcSum;

  Metadata({
    this.indexName,
    this.open,
    this.high,
    this.low,
    this.previousClose,
    this.last,
    this.percChange,
    this.change,
    this.timeVal,
    this.yearHigh,
    this.yearLow,
    this.indicativeClose,
    this.totalTradedVolume,
    this.totalTradedValue,
    this.ffmcSum,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => _$MetadataFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
