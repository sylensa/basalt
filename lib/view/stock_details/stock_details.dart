import 'package:basalt/controller/connectivity_provider.dart';
import 'package:basalt/controller/market_stack_controller.dart';
import 'package:basalt/helper/helper.dart';
import 'package:basalt/model/eod_stock_details_model.dart';
import 'package:basalt/model/market_stock_model.dart';
import 'package:basalt/view/widgets/no_internet.dart';
import 'package:basalt/view/widgets/p_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StockDetails extends StatefulWidget {
   StockDetails({Key? key,required this.stockReport}) : super(key: key);
   StockReport stockReport;
  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  bool progressCode= true;
  List<EodStockDetails> listEodStockDetails = [];
  int limit = 10;
  int offset = 0;
  RefreshController _refreshController =  RefreshController(initialRefresh: false);
  void _onRefresh() async{
    await   getEODReport(isLoading: false);
    if(mounted){
      setState(() {

      });
    }
    _refreshController.refreshCompleted();
  }
  void _onLoading() async{
    await getEODReport(isLoading: true);
    if(mounted){
      setState(() {

      });
    }
    _refreshController.loadComplete();
  }
  getEODReport({bool isLoading = false}) async {
    try{
      List<EodStockDetails> eodStockDetails = await MarketStockReportController().getStockMarketReportDetails(symbol: widget.stockReport.symbol,limit: limit,offset: listEodStockDetails.length);
      if(isLoading){
        listEodStockDetails.addAll(eodStockDetails);
      }else{
        listEodStockDetails.insertAll(0,eodStockDetails);

      }
    }catch(e){
      print("error:$e");
    }
    setState(() {
      progressCode = false;
    });
  }

  getStockDetailsWidget(){

      if(listEodStockDetails.isNotEmpty){
        return     Expanded(
          child: SmartRefresher(
            reverse: false,
            enablePullDown: true,
            enablePullUp: true,
            footer: CustomFooter(
              builder: (BuildContext context,LoadStatus? mode){
                Widget body ;
                if(mode==LoadStatus.idle){
                  body =  Text("No more Data");
                }
                else if(mode==LoadStatus.loading){
                  body =  CupertinoActivityIndicator();
                }
                else if(mode == LoadStatus.failed){
                  body = Text("Load Failed!Click retry!");
                }
                else if(mode == LoadStatus.canLoading){
                  body = Text("release to load more");
                }
                else{
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child:body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: listEodStockDetails.length,
                itemBuilder: (BuildContext context, int index){

                  return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 10,right: 10,left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  sText("Open:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].open}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  sText("High:",align: TextAlign.left,size: 12),
                                  sText("${listEodStockDetails[index].high}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  sText("Low:",align: TextAlign.left,size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].low}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText("Close:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].close}",size: 12,weight: FontWeight.bold),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText("Adj High:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].adjHigh}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText("Adj Low:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].adjLow}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText("Adj Close:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].adjClose}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText("Adj Open:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].adjOpen}",size: 12,weight: FontWeight.bold),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText("Split Factor:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].splitFactor}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText("Dividend:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].dividend}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText("Symbol:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].symbol}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  sText("Ex:",size: 12),
                                  SizedBox(width: 5,),
                                  sText("${listEodStockDetails[index].exchange}",size: 12,weight: FontWeight.bold),
                                ],
                              ),
                              SizedBox(height: 5,),
                            ],
                          ),
                        ],
                      )
                  );

                }),
          ),
        ) ;
      }else if(progressCode){
        return  Expanded(child: Center(child: progress()));
      }else{
        return Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: sText("Empty Results")),
            SizedBox(height: 20,),
            SizedBox(
              width: 150,
              height: 40,
              child: PButton(
                  rounded: false,
                  textColor: Colors.white,
                  text: 'TRY AGAIN',
                  onPressed: ()async{
                    setState(() {
                      progressCode = true;
                      isOnline = true;
                      listEodStockDetails.clear();
                    });
                    await  getEODReport();
                  }),
            )
          ],
        ));
      }




  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEODReport();
  }
  @override
  Widget build(BuildContext context) {
    isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
    print("object:$isOnline");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!isOnline){
        showNoConnectionToast(context);
      }
    });
    return Scaffold(
      appBar:AppBar(
        title: sText("${widget.stockReport.name}",color: Colors.white,size: 20,weight: FontWeight.bold),
        elevation: 0,
        centerTitle: true,
      ) ,
      body:Column(
        children: [
          SizedBox(height: 10,),
          getStockDetailsWidget()
        ],
      ),
    );
  }
}
