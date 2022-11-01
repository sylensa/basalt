// To parse this JSON data, do
//
//     final marketStockReport = marketStockReportFromJson(jsonString);

import 'dart:convert';

MarketStockReportModel marketStockReportFromJson(String str) => MarketStockReportModel.fromJson(json.decode(str));

String marketStockReportToJson(MarketStockReportModel data) => json.encode(data.toJson());

class MarketStockReportModel {
  MarketStockReportModel({
    this.pagination,
    this.data,
  });

  Pagination? pagination;
  List<StockReport>? data;

  factory MarketStockReportModel.fromJson(Map<String, dynamic> json) => MarketStockReportModel(
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    data: json["data"] == null ? null : List<StockReport>.from(json["data"].map((x) => StockReport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination == null ? null : pagination!.toJson(),
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StockReport {
  StockReport({
    this.name,
    this.symbol,
    this.hasIntraday,
    this.hasEod,
    this.country,
    this.stockExchange,
  });

  String? name;
  String? symbol;
  bool? hasIntraday;
  bool? hasEod;
  dynamic country;
  StockExchange? stockExchange;

  factory StockReport.fromJson(Map<String, dynamic> json) => StockReport(
    name: json["name"] == null ? null : json["name"],
    symbol: json["symbol"] == null ? null : json["symbol"],
    hasIntraday: json["has_intraday"] == null ? null : json["has_intraday"],
    hasEod: json["has_eod"] == null ? null : json["has_eod"],
    country: json["country"],
    stockExchange: json["stock_exchange"] == null ? null : StockExchange.fromJson(json["stock_exchange"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "symbol": symbol == null ? null : symbol,
    "has_intraday": hasIntraday == null ? null : hasIntraday,
    "has_eod": hasEod == null ? null : hasEod,
    "country": country,
    "stock_exchange": stockExchange == null ? null : stockExchange!.toJson(),
  };
}

class StockExchange {
  StockExchange({
    this.name,
    this.acronym,
    this.mic,
    this.country,
    this.countryCode,
    this.city,
    this.website,
  });

  String? name;
  String? acronym;
  String? mic;
  String? country;
  String? countryCode;
  String? city;
  String? website;

  factory StockExchange.fromJson(Map<String, dynamic> json) => StockExchange(
    name: json["name"] == null ? null : json["name"],
    acronym: json["acronym"] == null ? null : json["acronym"],
    mic: json["mic"] == null ? null : json["mic"],
    country: json["country"] == null ? null : json["country"],
    countryCode: json["country_code"] == null ? null : json["country_code"],
    city: json["city"] == null ? null : json["city"],
    website: json["website"] == null ? null : json["website"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "acronym": acronym == null ? null : acronym,
    "mic": mic == null ? null : mic,
    "country": country == null ? null : country,
    "country_code": countryCode == null ? null : countryCode,
    "city": city == null ? null : city,
    "website": website == null ? null : website,
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


