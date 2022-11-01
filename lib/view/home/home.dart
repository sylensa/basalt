import 'package:basalt/controller/connectivity_provider.dart';
import 'package:basalt/controller/market_stack_controller.dart';
import 'package:basalt/helper/helper.dart';
import 'package:basalt/model/market_stock_model.dart';
import 'package:basalt/view/stock_details/stock_details.dart';
import 'package:basalt/view/widgets/multi_purpose_card.dart';
import 'package:basalt/view/widgets/no_internet.dart';
import 'package:basalt/view/widgets/p_button.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  DateTime? dateFrom;
  DateTime? dateTo;
  bool progressCode= true;
  late AppLifecycleState appLifecycle;

  List<StockReport> listStockReports = [];
  StockReport? selectedStockReport ;
  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(2021, 8, 10),
    DateTime(2021, 8, 13),
  ];
  getReport() async {
      try{
        listStockReports = await MarketStockReportController().getStockMarketReport();
      }catch(e){
        print("error:$e");
      }
    setState(() {
      progressCode = false;
    });
  }

  getAllResultWidget(){
    if(!isOnline){
      return Expanded(
        child: Center(
          child:  NoInternet(onTryAgainClicked: () async{
            setState(() {
              progressCode = true;
              isOnline = true;
            });
           await  getReport();
          })
        ),
      );
    }else{
      if(listStockReports.isNotEmpty){
        return   Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index){
                  return  Column(
                    children: [
                      MultiPurposeCourseCard(
                        title: listStockReports[index].name!,
                        subTitle: listStockReports[index].stockExchange!.name!,
                        onTap: (){
                          goTo(context, StockDetails(stockReport: listStockReports[index],));
                        },
                      ),
                      SizedBox(height: 20,)
                    ],
                  );
                })
        );
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
                    });
                    await  getReport();
                  }),
            )
          ],
        ));
      }
    }



  }

  String _getValueText(CalendarDatePicker2Type datePickerType, List<DateTime?> values,) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReport();
  }
  @override
  Widget build(BuildContext context) {
     isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
     WidgetsBinding.instance.addPostFrameCallback((_) {
       if(!isOnline){
         showNoConnectionToast(context);
       }
     });
    return Scaffold(
      appBar: AppBar(
        title: sText("Basalt",color: Colors.white,weight: FontWeight.bold,size: 20),
        elevation: 0,

      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Autocomplete<StockReport>(

                      optionsBuilder: (textEditing) {
                        if (textEditing.text.isEmpty) {
                          return const Iterable<StockReport>.empty();
                        }
                        return listStockReports.where(
                              (element) =>
                          element.name!.toLowerCase().contains(
                            textEditing.text.toLowerCase(),
                          ) ||
                              element.symbol!.toLowerCase().contains(
                                textEditing.text.toLowerCase(),
                              ),
                        );
                      },
                      displayStringForOption: (stockReport) => stockReport.name!,
                      onSelected: (selected) {
                        setState(() {
                          selectedStockReport = selected;
                        });
                        goTo(context, StockDetails(stockReport: selectedStockReport!,));

                      },
                      fieldViewBuilder:
                          (context, controller, node, onSubmit) {
                        return TextFormField(
                          controller: controller,
                          autovalidateMode: AutovalidateMode.always,
                          onFieldSubmitted: (value) {
                            onSubmit();
                          },
                          // validator: (value) {
                          //   if (selectedStockReport == null) {
                          //     return "Select a company";
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          focusNode: node,
                          decoration: textDecorSuffix(
                              size: 15,
                              icon: Icon(Icons.search,color: Colors.grey),
                              suffIcon:IconButton(onPressed: ()async{
                                final config = CalendarDatePicker2WithActionButtonsConfig(
                                  calendarType: CalendarDatePicker2Type.range,
                                  selectedDayHighlightColor: Colors.purple[800],
                                  shouldCloseDialogAfterCancelTapped: true,
                                );
                                final values = await showCalendarDatePicker2Dialog(
                                  context: context,
                                  config: config,
                                  dialogSize: const Size(325, 400),
                                  borderRadius: BorderRadius.circular(15),
                                  initialValue: _dialogCalendarPickerValue,
                                  dialogBackgroundColor: Colors.white,
                                  selectableDayPredicate: (day) => !day
                                      .difference(_dialogCalendarPickerValue[0]!
                                      .subtract(const Duration(days: 5)))
                                      .isNegative,
                                );
                                if (values != null) {
                                  // ignore: avoid_print
                                  print(_getValueText(config.calendarType, values,));
                                  setState(() {
                                    _dialogCalendarPickerValue = values;
                                  });

                                  print("values:${values.first}");
                                  print("values:${values.last}");
                                }

                              }, icon:  Icon(Icons.filter_alt,color: Colors.grey,),),
                              label: "Searching",
                              enabled: true,
                              showBorder: true
                          ),
                        );
                      },
                    )
                ),

              ],
            ),
            SizedBox(height: 20,),
              getAllResultWidget()


          ],
        ),
      ),
    );
  }
}
