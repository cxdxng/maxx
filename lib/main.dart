// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:flutter_gpiod/flutter_gpiod.dart';
import 'package:maxx/gpioHandling.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {"/": (context) => UI()},
  ));
}

class UI extends StatefulWidget {
  const UI({Key? key}) : super(key: key);

  @override
  State<UI> createState() => UIState();
}

class UIState extends State<UI> {
  double rpmVal = 850;
  double oilTempVal = 25;
  String bImage = "assets/background.jpg";
  static int lool = 0;
  GpioHandling handler = GpioHandling.instance;

  @override
  Widget build(BuildContext context) {
    handler.testingGPIO();
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
                  onPressed: () => handler.startGPIOListening(),
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
                      children: const <Widget>[
                        // Added image widget as an annotation

                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Text('28°C',
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
    //setState(() {
    rpmVal = newValue;
    print(rpmVal);
    //});
  }

  void updateOilTemp(double newValue) {
    setState(() {
      oilTempVal = newValue;
    });
  }
}
