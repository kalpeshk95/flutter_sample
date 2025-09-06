// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nifty_fifty_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NiftyFiftyResponse _$NiftyFiftyResponseFromJson(Map<String, dynamic> json) =>
    NiftyFiftyResponse(
      name: json['name'] as String?,
      advance: json['advance'] == null
          ? null
          : Advance.fromJson(json['advance'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      marketStatus: json['marketStatus'] == null
          ? null
          : MarketStatus.fromJson(json['marketStatus'] as Map<String, dynamic>),
      date30DAgo: json['date30dAgo'] as String?,
      date365DAgo: json['date365dAgo'] as String?,
    );

Map<String, dynamic> _$NiftyFiftyResponseToJson(NiftyFiftyResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'advance': instance.advance,
      'timestamp': instance.timestamp,
      'data': instance.data,
      'metadata': instance.metadata,
      'marketStatus': instance.marketStatus,
      'date30dAgo': instance.date30DAgo,
      'date365dAgo': instance.date365DAgo,
    };

Advance _$AdvanceFromJson(Map<String, dynamic> json) => Advance(
      declines: json['declines'] as String?,
      advances: json['advances'] as String?,
      unchanged: json['unchanged'] as String?,
    );

Map<String, dynamic> _$AdvanceToJson(Advance instance) => <String, dynamic>{
      'declines': instance.declines,
      'advances': instance.advances,
      'unchanged': instance.unchanged,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      priority: (json['priority'] as num?)?.toInt(),
      symbol: json['symbol'] as String?,
      identifier: json['identifier'] as String?,
      open: (json['open'] as num?)?.toDouble(),
      dayHigh: (json['dayHigh'] as num?)?.toDouble(),
      dayLow: (json['dayLow'] as num?)?.toDouble(),
      lastPrice: (json['lastPrice'] as num?)?.toDouble(),
      previousClose: (json['previousClose'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      pChange: (json['pChange'] as num?)?.toDouble(),
      ffmc: (json['ffmc'] as num?)?.toDouble(),
      yearHigh: (json['yearHigh'] as num?)?.toDouble(),
      yearLow: (json['yearLow'] as num?)?.toDouble(),
      totalTradedVolume: (json['totalTradedVolume'] as num?)?.toInt(),
      stockIndClosePrice: (json['stockIndClosePrice'] as num?)?.toInt(),
      totalTradedValue: (json['totalTradedValue'] as num?)?.toDouble(),
      lastUpdateTime: json['lastUpdateTime'] as String?,
      nearWkh: (json['nearWKH'] as num?)?.toDouble(),
      nearWkl: (json['nearWKL'] as num?)?.toDouble(),
      date365DAgo: json['date365dAgo'] as String?,
      chart365DPath: json['chart365dPath'] as String?,
      date30DAgo: json['date30dAgo'] as String?,
      perChange30D: (json['perChange30d'] as num?)?.toDouble(),
      chart30DPath: json['chart30dPath'] as String?,
      chartTodayPath: json['chartTodayPath'] as String?,
      series: json['series'] as String?,
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'priority': instance.priority,
      'symbol': instance.symbol,
      'identifier': instance.identifier,
      'open': instance.open,
      'dayHigh': instance.dayHigh,
      'dayLow': instance.dayLow,
      'lastPrice': instance.lastPrice,
      'previousClose': instance.previousClose,
      'change': instance.change,
      'pChange': instance.pChange,
      'ffmc': instance.ffmc,
      'yearHigh': instance.yearHigh,
      'yearLow': instance.yearLow,
      'totalTradedVolume': instance.totalTradedVolume,
      'stockIndClosePrice': instance.stockIndClosePrice,
      'totalTradedValue': instance.totalTradedValue,
      'lastUpdateTime': instance.lastUpdateTime,
      'nearWKH': instance.nearWkh,
      'nearWKL': instance.nearWkl,
      'date365dAgo': instance.date365DAgo,
      'chart365dPath': instance.chart365DPath,
      'date30dAgo': instance.date30DAgo,
      'perChange30d': instance.perChange30D,
      'chart30dPath': instance.chart30DPath,
      'chartTodayPath': instance.chartTodayPath,
      'series': instance.series,
      'meta': instance.meta,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      symbol: json['symbol'] as String?,
      companyName: json['companyName'] as String?,
      industry: json['industry'] as String?,
      activeSeries: (json['activeSeries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isFnoSec: json['isFNOSec'] as bool?,
      isCaSec: json['isCASec'] as bool?,
      isSlbSec: json['isSLBSec'] as bool?,
      isDebtSec: json['isDebtSec'] as bool?,
      isSuspended: json['isSuspended'] as bool?,
      tempSuspendedSeries: (json['tempSuspendedSeries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isEtfSec: json['isETFSec'] as bool?,
      isDelisted: json['isDelisted'] as bool?,
      isin: json['isin'] as String?,
      slbIsin: json['slb_isin'] as String?,
      listingDate: json['listingDate'] == null
          ? null
          : DateTime.parse(json['listingDate'] as String),
      isMunicipalBond: json['isMunicipalBond'] as bool?,
      isHybridSymbol: json['isHybridSymbol'] as bool?,
      quotepreopenstatus: json['quotepreopenstatus'] == null
          ? null
          : Quotepreopenstatus.fromJson(
              json['quotepreopenstatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'industry': instance.industry,
      'activeSeries': instance.activeSeries,
      'isFNOSec': instance.isFnoSec,
      'isCASec': instance.isCaSec,
      'isSLBSec': instance.isSlbSec,
      'isDebtSec': instance.isDebtSec,
      'isSuspended': instance.isSuspended,
      'tempSuspendedSeries': instance.tempSuspendedSeries,
      'isETFSec': instance.isEtfSec,
      'isDelisted': instance.isDelisted,
      'isin': instance.isin,
      'slb_isin': instance.slbIsin,
      'listingDate': instance.listingDate?.toIso8601String(),
      'isMunicipalBond': instance.isMunicipalBond,
      'isHybridSymbol': instance.isHybridSymbol,
      'quotepreopenstatus': instance.quotepreopenstatus,
    };

Quotepreopenstatus _$QuotepreopenstatusFromJson(Map<String, dynamic> json) =>
    Quotepreopenstatus(
      equityTime: json['equityTime'] as String?,
      preOpenTime: json['preOpenTime'] as String?,
      quotePreOpenFlag: json['QuotePreOpenFlag'] as bool?,
    );

Map<String, dynamic> _$QuotepreopenstatusToJson(Quotepreopenstatus instance) =>
    <String, dynamic>{
      'equityTime': instance.equityTime,
      'preOpenTime': instance.preOpenTime,
      'QuotePreOpenFlag': instance.quotePreOpenFlag,
    };

MarketStatus _$MarketStatusFromJson(Map<String, dynamic> json) => MarketStatus(
      market: json['market'] as String?,
      marketStatus: json['marketStatus'] as String?,
      tradeDate: json['tradeDate'] as String?,
      index: json['index'] as String?,
      last: (json['last'] as num?)?.toInt(),
      variation: (json['variation'] as num?)?.toDouble(),
      percentChange: (json['percentChange'] as num?)?.toDouble(),
      marketStatusMessage: json['marketStatusMessage'] as String?,
    );

Map<String, dynamic> _$MarketStatusToJson(MarketStatus instance) =>
    <String, dynamic>{
      'market': instance.market,
      'marketStatus': instance.marketStatus,
      'tradeDate': instance.tradeDate,
      'index': instance.index,
      'last': instance.last,
      'variation': instance.variation,
      'percentChange': instance.percentChange,
      'marketStatusMessage': instance.marketStatusMessage,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
      indexName: json['indexName'] as String?,
      open: (json['open'] as num?)?.toDouble(),
      high: (json['high'] as num?)?.toDouble(),
      low: (json['low'] as num?)?.toDouble(),
      previousClose: (json['previousClose'] as num?)?.toDouble(),
      last: (json['last'] as num?)?.toInt(),
      percChange: (json['percChange'] as num?)?.toDouble(),
      change: (json['change'] as num?)?.toDouble(),
      timeVal: json['timeVal'] as String?,
      yearHigh: (json['yearHigh'] as num?)?.toDouble(),
      yearLow: (json['yearLow'] as num?)?.toDouble(),
      indicativeClose: (json['indicativeClose'] as num?)?.toInt(),
      totalTradedVolume: (json['totalTradedVolume'] as num?)?.toInt(),
      totalTradedValue: (json['totalTradedValue'] as num?)?.toDouble(),
      ffmcSum: (json['ffmc_sum'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
      'indexName': instance.indexName,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'previousClose': instance.previousClose,
      'last': instance.last,
      'percChange': instance.percChange,
      'change': instance.change,
      'timeVal': instance.timeVal,
      'yearHigh': instance.yearHigh,
      'yearLow': instance.yearLow,
      'indicativeClose': instance.indicativeClose,
      'totalTradedVolume': instance.totalTradedVolume,
      'totalTradedValue': instance.totalTradedValue,
      'ffmc_sum': instance.ffmcSum,
    };
