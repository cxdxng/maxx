// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gpiod/flutter_gpiod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {"/": (context) => UI()},
  ));
}

class UI extends StatefulWidget {
  UI({Key? key}) : super(key: key);

  @override
  State<UI> createState() => _UIState();

}

class _UIState extends State<UI> {
  double rpmVal = 850;
  double oilTempVal = 25;
  int outsideTemp = 0;
  String bImage = "assets/background.jpg";
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("INIT STATE");
    testingGPIO();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(bImage), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRPM(),
                  Column(
                    children: [
                      buildOutdoorTemp(),
                      SizedBox(
                        height: 20,
                      ),
                      buildVoltage()
                    ],
                  ),
                  buildOilTemp(),
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "REV IT!",
                    style: TextStyle(fontSize: 22),
                  )),
              
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildRPM() {
    return SizedBox(
      width: 400,
      height: 400,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        animationDuration: 2000,
        axes: [
          RadialAxis(
            backgroundImage: AssetImage("assets/dark_theme_gauge.png"),
            radiusFactor: 1,
            minimum: 0,
            maximum: 6000,
            startAngle: 170,
            endAngle: 370,
            labelOffset: 25,
            tickOffset: 60,
            axisLabelStyle: GaugeTextStyle(color: Colors.white),
            majorTickStyle: MajorTickStyle(color: Colors.white),
            minorTickStyle: MinorTickStyle(color: Colors.grey[700]),
            pointers: [
              NeedlePointer(
                value: rpmVal,
                enableAnimation: true,
                lengthUnit: GaugeSizeUnit.factor,
                needleStartWidth: 1,
                needleEndWidth: 8,
                needleLength: 0.6,
                needleColor: Colors.redAccent,
                knobStyle: makeKnob(),
              )
            ],
            annotations: const <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.5,
                  widget: Text('RPM x1000',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
            ],
          )
        ],
      ),
    );
  }

  SizedBox buildOilTemp() {
    return SizedBox(
      width: 400,
      height: 400,
      child: SfRadialGauge(
        enableLoadingAnimation: true,
        animationDuration: 2000,
        axes: [
          RadialAxis(
            backgroundImage: AssetImage("assets/dark_theme_gauge.png"),
            radiusFactor: 1,
            minimum: 0,
            maximum: 130,
            startAngle: 170,
            endAngle: 370,
            labelOffset: 20,
            tickOffset: 60,
            axisLabelStyle: GaugeTextStyle(color: Colors.white),
            majorTickStyle: MajorTickStyle(color: Colors.white),
            minorTickStyle: MinorTickStyle(color: Colors.grey[700]),
            ranges: [
              GaugeRange(
                rangeOffset: 110,
                startValue: 0,
                endValue: 50,
                color: Colors.blue,
                startWidth: 15.0,
                endWidth: 15.0,
              ),
              GaugeRange(
                rangeOffset: 110,
                startValue: 51,
                endValue: 70,
                color: Colors.cyan[700],
                startWidth: 15.0,
                endWidth: 15.0,
              ),
              GaugeRange(
                rangeOffset: 110,
                startValue: 71,
                endValue: 110,
                color: Colors.green[700],
                startWidth: 15.0,
                endWidth: 15.0,
              ),
              GaugeRange(
                rangeOffset: 110,
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
                needleLength: 0.6,
                needleColor: Colors.redAccent,
                knobStyle: makeKnob(),
              )
            ],
            annotations: const <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.5,
                  widget: Text('Oil Temp °C',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold))),
            ],
          )
        ],
      ),
    );
  }

  SizedBox buildOutdoorTemp() {
    return SizedBox(
      width: 200,
      height: 200,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              interval: 1,
              radiusFactor: 1,
              startAngle: 270,
              endAngle: 270,
              showTicks: false,
              showLabels: false,
              axisLineStyle: const AxisLineStyle(thickness: 20),
              pointers: const <GaugePointer>[
                RangePointer(
                    value: 26,
                    width: 20,
                    color: Colors.white,
                    enableAnimation: true,
                    gradient: SweepGradient(
                        colors: <Color>[Color(0xff6699CC), Color(0xFFFF3C38)],
                        stops: <double>[0.25, 0.75]),
                    cornerStyle: CornerStyle.bothCurve)
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Added image widget as an annotation

                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Text("$outsideTemp°C",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                    angle: 270,
                    positionFactor: 0.1)
              ])
        ],
      ),
    );
  }

  SizedBox buildVoltage() {
    return SizedBox(
      width: 200,
      height: 200,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              startAngle: 180,
              endAngle: 360,
              radiusFactor: 1,
              canScaleToFit: true,
              interval: 10,
              showLabels: false,
              showAxisLine: false,
              pointers: const <GaugePointer>[
                MarkerPointer(
                    value: 90,
                    elevation: 4,
                    markerWidth: 25,
                    markerHeight: 25,
                    color: Color(0xFFF67280),
                    markerType: MarkerType.invertedTriangle,
                    markerOffset: -7)
              ],
              annotations: const [
                GaugeAnnotation(
                    angle: 270,
                    positionFactor: 0.1,
                    widget: Text('14,2 V',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ],
              ranges: <GaugeRange>[
                GaugeRange(
                  startValue: 0,
                  endValue: 100,
                  sizeUnit: GaugeSizeUnit.factor,
                  gradient: const SweepGradient(
                      colors: <Color>[Colors.red, Colors.green],
                      stops: <double>[0.25, 0.75]),
                  startWidth: 0.4,
                  endWidth: 0.4,
                  color: const Color(0xFF00A8B5),
                )
              ],
              showTicks: false),
        ],
      ),
    );
  }

  KnobStyle makeKnob() {
    return KnobStyle(
        knobRadius: 0.08,
        sizeUnit: GaugeSizeUnit.factor,
        color: Colors.black,
        borderWidth: 0.05,
        borderColor: Colors.black);
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


  void testingGPIO() async {

    int riseTime = 0;
    int fallTime = 1;
    
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
        consumer: "riseAndFall", triggers: {SignalEdge.falling, SignalEdge.rising});

    // line.onEvent will not emit any events if no triggers
    // are requested for the line.
    // this will run forevers

    await for (final event in line.onEvent) {
      if (event.edge == SignalEdge.rising) {
        riseTime = event.timestampNanos;
        print("I AM RISING! Timestamp: ${event.timestampNanos}");
        
      } else {
        fallTime = event.timestampNanos;
        setState(() {
          oilTempVal = ((fallTime-riseTime)~/(1e+6)).roundToDouble();
        });
        print("I AM FALLING! Timestamp: ${event.timestampNanos}");
        print(outsideTemp);
      }

      //print("got GPIO line signal event: $event");
    }

    line.release();
  }

  
}