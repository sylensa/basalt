import 'package:basalt/helper/helper.dart';
import 'package:basalt/helper/hide.dart';
import 'package:basalt/model/market_stock_model.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class MarketStockReportController{


  Future<List<StockReport>> getStockMarketReport()async {
    List<StockReport> listStockReports = [];
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    print("isConnected:$isConnected");
    if(isConnected){
      try{
        isOnline = isConnected;
        var js = await doGet('tickers?access_key=$authorizationKey');
        print("reports response : ${ js["data"]}");
        if (js["data"].isNotEmpty) {
          for(int i =0; i < js["data"].length; i++){
            StockReport groupListData = StockReport.fromJson(js["data"][i]);
            listStockReports.add(groupListData);
          }
          return listStockReports;
        }else{
          toastMessage("${js["message"]}");

          return listStockReports;
        }

      }catch(e){
        toastMessage("$e");
        print("$e");
        return listStockReports;
      }

    }else{
      isOnline = isConnected;
      return listStockReports;
    }

  }
  Future<List<StockReport>> getStockMarketReportSearch({String? symbol,DateTime? dateTo, DateTime? dateFrom})async {
    List<StockReport> listStockReports = [];
    try{
    var js = await doGet('tickers/$symbol?access_key=$authorizationKey&date_from=$dateFrom&date_to=$dateTo');
    print("reports response : ${ js["data"]}");
    if (js["data"].isNotEmpty) {
      for(int i =0; i < js["data"].length; i++){
        StockReport groupListData = StockReport.fromJson(js["data"][i]);
        listStockReports.add(groupListData);
      }
      return listStockReports;
    }else{
      toastMessage("${js["message"]}");
      return listStockReports;
    }
    }catch(e){
      toastMessage("Failed");
      return listStockReports;
    }
  }
}