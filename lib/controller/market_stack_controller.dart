import 'package:basalt/helper/helper.dart';
import 'package:basalt/helper/hide.dart';
import 'package:basalt/model/market_stock_model.dart';

class MarketStockReportController{


  Future<List<StockReport>> getStockMarketReport()async {
    List<StockReport> listStockReports = [];
    try{
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
      toastMessage("Failed");
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