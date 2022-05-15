// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter_gpiod/flutter_gpiod.dart';

class GpioHandling{
  GpioHandling._privateConstructor();
  static final GpioHandling instance = GpioHandling._privateConstructor();


  bool value = false;
  void startGPIOListening(){
    Timer.periodic(Duration(seconds: 1), (timer) {
      print(DateTime.now());
    });

  }

  void testingGPIO()async{
    final chip = FlutterGpiod.instance.chips.singleWhere((chip) => chip.label == 'pinctrl-bcm2835');
    final line = chip.lines[22];


    // request it as input again, but this time we're also listening
    // for edges; both in this case.
    line.requestInput(consumer: "test",triggers: {SignalEdge.falling, SignalEdge.rising});

    // line.onEvent will not emit any events if no triggers
    // are requested for the line.
    // this will run forever
    await for (final event in line.onEvent) {
      print("got GPIO line signal event: $event");
    }

    line.release();
  }
}