// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {"/": (context) => const UI()},
  ));
}

class UI extends StatefulWidget {
  const UI({Key? key}) : super(key: key);

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  double rpmVal = 0;
  double oilTempVal = 25;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff211a1e),
        body: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRPM(),
                  buildOilTemp(),
                ],
              ),
              TextButton(
                  onPressed: () => looos(),
                  child: Text(
                    "REV IT!",
                    style: TextStyle(fontSize: 22),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  SfRadialGauge buildRPM() {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 2000,
      axes: [
        RadialAxis(
          radiusFactor: 0.8,
          minimum: 0,
          maximum: 6000,
          startAngle: 170,
          endAngle: 370,
          labelOffset: 20,
          tickOffset: 10,
          axisLabelStyle: GaugeTextStyle(color: Colors.white),
          majorTickStyle: MajorTickStyle(color: Colors.white),
          minorTickStyle: MinorTickStyle(color: Colors.grey[700]),
          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: 3000,
              color: Colors.green[700],
              startWidth: 15.0,
              endWidth: 15.0,
            ),
            GaugeRange(
              startValue: 3050,
              endValue: 5000,
              color: Colors.orange,
              startWidth: 15.0,
              endWidth: 15.0,
            ),
            GaugeRange(
              startValue: 5050,
              endValue: 6000,
              color: Colors.red,
              startWidth: 15.0,
              endWidth: 15.0,
            ),
          ],
          pointers: [
            NeedlePointer(
              value: rpmVal,
              enableAnimation: true,
              lengthUnit: GaugeSizeUnit.factor,
              needleStartWidth: 1,
              needleEndWidth: 8,
              needleLength: 0.8,
              needleColor: Colors.redAccent,
              knobStyle: makeKnob(),
              tailStyle: makeTail(),
            )
          ],
          annotations: const <GaugeAnnotation>[
            GaugeAnnotation(
                angle: 90,
                positionFactor: 0.35,
                widget: Text('RPM x1000',
                    style: TextStyle(color: Colors.white, fontSize: 16))),
          ],
        )
      ],
    );
  }

  SfRadialGauge buildOilTemp() {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 2000,
      axes: [
        RadialAxis(
          radiusFactor: 0.8,
          minimum: 0,
          maximum: 130,
          startAngle: 170,
          endAngle: 370,
          labelOffset: 20,
          tickOffset: 10,
          axisLabelStyle: GaugeTextStyle(color: Colors.white),
          majorTickStyle: MajorTickStyle(color: Colors.white),
          minorTickStyle: MinorTickStyle(color: Colors.grey[700]),
          ranges: [
            GaugeRange(
              startValue: 0,
              endValue: 50,
              color: Colors.blue,
              startWidth: 15.0,
              endWidth: 15.0,
            ),
            GaugeRange(
              startValue: 51,
              endValue: 70,
              color: Colors.cyan[700],
              startWidth: 15.0,
              endWidth: 15.0,
            ),
            GaugeRange(
              startValue: 71,
              endValue: 100,
              color: Colors.green[700],
              startWidth: 15.0,
              endWidth: 15.0,
            ),
            GaugeRange(
              startValue: 101,
              endValue: 130,
              color: Colors.red,
              startWidth: 15.0,
              endWidth: 15.0,
            ),
          ],
          pointers: [
            NeedlePointer(
                value: oilTempVal,
                enableAnimation: true,
                lengthUnit: GaugeSizeUnit.factor,
                needleStartWidth: 1,
                needleEndWidth: 8,
                needleLength: 0.8,
                needleColor: Colors.redAccent,
                tailStyle: makeTail(),
                knobStyle: makeKnob())
          ],
          annotations: const <GaugeAnnotation>[
            GaugeAnnotation(
                angle: 90,
                positionFactor: 0.35,
                widget: Text('Oil Temp.°C',
                    style: TextStyle(color: Colors.deepOrange, fontSize: 16))),
          ],
        )
      ],
    );
  }

  TailStyle makeTail() {
    return TailStyle(
        color: Colors.redAccent,
        width: 8,
        lengthUnit: GaugeSizeUnit.factor,
        length: 0.2);
  }

  KnobStyle makeKnob() {
    return KnobStyle(
        knobRadius: 0.07,
        sizeUnit: GaugeSizeUnit.factor,
        borderColor: Colors.redAccent,
        color: Colors.white,
        borderWidth: 0.05);
  }

  void updateRPM(double newValue) {
    setState(() {
      rpmVal = newValue;
    });
  }

  void updateOilTemp(double newValue) {
    setState(() {
      oilTempVal = newValue;
    });
  }

  void looos() async {
    setState(() {
      rpmVal = 5600;
      Timer(Duration(milliseconds: 1000), () {
        setState(() {
          rpmVal = 850;
        });
      });
    });
  }
}
