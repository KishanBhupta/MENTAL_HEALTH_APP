import 'dart:async';

import 'package:get/get.dart';

class DeBouncer {

  DeBouncer? _instance;

  DeBouncer get getDeBouncer {
    if(_instance!=null){
      return _instance!;
    }else{
      _instance = DeBouncer();
      return _instance!;
    }
  }

}