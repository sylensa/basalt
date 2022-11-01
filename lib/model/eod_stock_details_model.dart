// To parse this JSON data, do
//
//     final stockDetailsModel = stockDetailsModelFromJson(jsonString);

import 'dart:convert';

StockDetailsModel stockDetailsModelFromJson(String? str) => StockDetailsModel.fromJson(json.decode(str!));

String? stockDetailsModelToJson(StockDetailsModel data) => json.encode(data.toJson());

class StockDetailsModel {
  StockDetailsModel({
    this.pagination,
    this.data,
  });

  Pagination? pagination;
  Data? data;

  factory StockDetailsModel.fromJson(Map<String, dynamic> json) => StockDetailsModel(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination == null ? null : pagination!.toJson(),
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.name,
    this.symbol,
    this.hasIntraday,
    this.hasEod,
    this.country,
    this.eod,
  });

  String? name;
  String? symbol;
  bool? hasIntraday;
  bool? hasEod;
  String? country;
  List<EodStockDetails>? eod;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"] == null ? null : json["name"],
    symbol: json["symbol"] == null ? null : json["symbol"],
    hasIntraday: json["has_intraday"] == null ? null : json["has_intraday"],
    hasEod: json["has_eod"] == null ? null : json["has_eod"],
    country: json["country"],
    eod: json["eod"] == null ? null : List<EodStockDetails>.from(json["eod"].map((x) => EodStockDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "symbol": symbol == null ? null : symbol,
    "has_intraday": hasIntraday == null ? null : hasIntraday,
    "has_eod": hasEod == null ? null : hasEod,
    "country": country,
    "eod": eod == null ? null : List<dynamic>.from(eod!.map((x) => x.toJson())),
  };
}

class EodStockDetails {
  EodStockDetails({
    this.open,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.adjHigh,
    this.adjLow,
    this.adjClose,
    this.adjOpen,
    this.adjVolume,
    this.splitFactor,
    this.dividend,
    this.symbol,
    this.exchange,
    this.date,
  });

  dynamic open;
  dynamic high;
  dynamic low;
  dynamic close;
  dynamic volume;
  dynamic adjHigh;
  dynamic adjLow;
  dynamic adjClose;
  dynamic adjOpen;
  dynamic adjVolume;
  dynamic splitFactor;
  dynamic dividend;
  String? symbol;
  String? exchange;
  String? date;

  factory EodStockDetails.fromJson(Map<String, dynamic> json) => EodStockDetails(
    open: json["open"] == null ? null : json["open"].toDouble(),
    high: json["high"] == null ? null : json["high"].toDouble(),
    low: json["low"] == null ? null : json["low"].toDouble(),
    close: json["close"] == null ? null : json["close"].toDouble(),
    volume: json["volume"] == null ? null : json["volume"],
    adjHigh: json["adj_high"] == null ? null : json["adj_high"].toDouble(),
    adjLow: json["adj_low"] == null ? null : json["adj_low"].toDouble(),
    adjClose: json["adj_close"] == null ? null : json["adj_close"].toDouble(),
    adjOpen: json["adj_open"] == null ? null : json["adj_open"].toDouble(),
    adjVolume: json["adj_volume"] == null ? null : json["adj_volume"],
    splitFactor: json["split_factor"] == null ? null : json["split_factor"],
    dividend: json["dividend"] == null ? null : json["dividend"],
    symbol: json["symbol"] == null ? null : json["symbol"],
    exchange: json["exchange"] == null ? null : json["exchange"],
    date: json["date"] == null ? null : json["date"],
  );

  Map<String, dynamic> toJson() => {
    "open": open == null ? null : open,
    "high": high == null ? null : high,
    "low": low == null ? null : low,
    "close": close == null ? null : close,
    "volume": volume == null ? null : volume,
    "adj_high": adjHigh == null ? null : adjHigh,
    "adj_low": adjLow == null ? null : adjLow,
    "adj_close": adjClose == null ? null : adjClose,
    "adj_open": adjOpen == null ? null : adjOpen,
    "adj_volume": adjVolume == null ? null : adjVolume,
    "split_factor": splitFactor == null ? null : splitFactor,
    "dividend": dividend == null ? null : dividend,
    "symbol": symbol == null ? null : symbol,
    "exchange": exchange == null ? null : exchange,
    "date": date == null ? null : date,
  };
}


class Pagination {
  Pagination({
    this.limit,
    this.offset,
    this.count,
    this.total,
  });

  int? limit;
  int? offset;
  int? count;
  int? total;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    limit: json["limit"] == null ? null : json["limit"],
    offset: json["offset"] == null ? null : json["offset"],
    count: json["count"] == null ? null : json["count"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "limit": limit == null ? null : limit,
    "offset": offset == null ? null : offset,
    "count": count == null ? null : count,
    "total": total == null ? null : total,
  };
}


