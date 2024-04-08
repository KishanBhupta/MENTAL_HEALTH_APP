import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeBouncer {

  static final DeBouncer _instance = DeBouncer._internal();

  Timer? timer;

  Duration debounceWait = 1.5.seconds;

  factory DeBouncer() {
    return _instance;
  }

  DeBouncer._internal();

  void startTimer({required VoidCallback runTask}) {
    if(timer!=null){
      timer!.cancel();
    }
    timer = Timer(debounceWait,runTask);
  }

}