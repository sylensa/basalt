import 'package:basalt/helper/helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityProvider with ChangeNotifier{
  bool _isOnline = true;
  bool get isOnline => _isOnline;

  ConnectivityProvider(){
    Connectivity _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((result) async{
      if(result.name.toString().toLowerCase() == "none"){
        _isOnline = false;
        notifyListeners();
      }else{
        _isOnline = true;
        notifyListeners();
      }
      print("result:${result.name}");
      print("_isOnline:$_isOnline");

    });
  }
}