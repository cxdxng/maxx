// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';
import 'package:maxx/main.dart';

class GpioHandling {
  GpioHandling._privateConstructor();
  static final GpioHandling instance = GpioHandling._privateConstructor();

  bool value = false;
  void startGPIOListening() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      print(DateTime.now());
      print("object");
    });
  }

  void testingGPIO() async {
    print("STARTING GPIO TEST");
    // Get the main Raspberry Pi GPIO chip.
    // On Raspberry Pi 4 the main GPIO chip is called `pinctrl-bcm2711` and
    // on older Pi's or a Pi 4 with older kernel version it's called `pinctrl-bcm2835`.
    final chip = FlutterGpiod.instance.chips
        .singleWhere((chip) => chip.label == 'pinctrl-bcm2835');

    // Get line 22 of the GPIO chip.
    // This is the BCM 22 pin of the Raspberry Pi.
    final line = chip.lines[22];

    // request it as input anfd listen
    // for edges; both in this case.
    line.requestInput(
        consumer: "test", triggers: {SignalEdge.falling, SignalEdge.rising});

    // line.onEvent will not emit any events if no triggers
    // are requested for the line.
    // this will run forevers

    await for (final event in line.onEvent) {
      if (event.edge == SignalEdge.rising) {
        print("I AM RISING! YAAAAA");
        UIState().updateRPM(5000);
      } else {
        print("LOOOOOOL");
      }

      //print("got GPIO line signal event: $event");
    }

    line.release();
  }
}
