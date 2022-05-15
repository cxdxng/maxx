// ignore_for_file: prefer_const_constructors

import 'dart:async';

class GpioHandling{
  GpioHandling._privateConstructor();
  static final GpioHandling instance = GpioHandling._privateConstructor();


  bool value = false;
  void startGPIOListening(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      print(DateTime.now());
    });

  } 
}