import 'package:basalt/helper/helper.dart';
import 'package:basalt/helper/hide.dart';
import 'package:basalt/model/eod_stock_details_model.dart';
import 'package:basalt/model/market_stock_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MarketStockReportController{


  Future<List<StockReport>> getStockMarketReport()async {
    List<StockReport> listStockReports = [];
      try{
        var js = await doGet('tickers?access_key=$authorizationKey&limit=10');
        print("reports response : ${ js["data"]}");
        if (js["data"].isNotEmpty) {
          for(int i =0; i < js["data"].length; i++){
            StockReport stockReport = StockReport.fromJson(js["data"][i]);
            listStockReports.add(stockReport);
          }
          return listStockReports;
        }else{
          return listStockReports;
        }

      }catch(e){
        return listStockReports;
      }

  }

  Future<List<EodStockDetails>> getStockMarketReportDetails({String? symbol,int limit = 10,int offset = 0})async {
    List<EodStockDetails> listEodStockDetails = [];
    try{
    var js = await doGet('tickers/$symbol/eod?access_key=$authorizationKey&limit=$limit&offset=$offset');
    print("eod reports response : ${ js["data"]["eod"]}");
    if (js["data"]["eod"].isNotEmpty) {
      for(int i =0; i < js["data"]["eod"].length; i++){
        EodStockDetails eodStockDetails = EodStockDetails.fromJson(js["data"]["eod"][i]);
        listEodStockDetails.add(eodStockDetails);
      }
      return listEodStockDetails;
    }else{
      return listEodStockDetails;
    }
    }catch(e){
      return listEodStockDetails;
    }
  }
}