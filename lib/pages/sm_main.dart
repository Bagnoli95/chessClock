import 'package:chess_clock/clocks/simpleMode/sm_analogic.dart';
import 'package:chess_clock/clocks/simpleMode/sm_digital.dart';
import 'package:chess_clock/clocks/simpleMode/sm_flip.dart';
import 'package:chess_clock/clocks/simpleMode/sm_flipper.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:wakelock_plus/wakelock_plus.dart';

class smClockScreen extends StatefulWidget {
  String clockMode;
  int selectedTime;
  smClockScreen({super.key, required this.clockMode, required this.selectedTime});

  @override
  State<smClockScreen> createState() => _smClockScreenState();
}

class _smClockScreenState extends State<smClockScreen> {
  bool leftSelected = false;
  bool rightSelected = false;
  late int leftTime;
  late int rightTime;
  late int maxTime;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    leftTime = widget.selectedTime; // Ejemplo: 10 minutos en segundos
    rightTime = widget.selectedTime; // Ejemplo: 10 minutos en segundos
    maxTime = widget.selectedTime;
    WakelockPlus.enable(); // Mantener la pantalla encendida
  }

  void startTimer(bool isLeft) {
    stopTimer(); // Detenemos cualquier temporizador en ejecución
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (isLeft) {
          if (leftTime > 0) {
            leftTime--;
          } else {
            t.cancel(); // Detener cuando llegue a 0
          }
        } else {
          if (rightTime > 0) {
            rightTime--;
          } else {
            t.cancel(); // Detener cuando llegue a 0
          }
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel(); // Detenemos cualquier temporizador en ejecución
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("smClockScreen: LeftSelected: ($leftSelected), RightSelected: ($rightSelected)");
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            //LEFT
            Expanded(
              flex: 50,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    leftSelected = true;
                    rightSelected = false;
                  });
                  startTimer(false);
                },
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(3.14159),
                  child: (widget.clockMode == "smDigital")
                      ? smDigital(
                          timeValue: leftTime,
                          isSelected: leftSelected,
                          identificador: "Left",
                        )
                      : (widget.clockMode == "smAnalogic")
                          ? smAnalogic(
                              timeValue: leftTime,
                              isSelected: leftSelected,
                              identificador: "Left",
                              maxTime: maxTime,
                            )
                          : smFlipper(
                              timeValue: leftTime,
                              isSelected: leftSelected,
                              identificador: "Left",
                            ),
                  // : (widget.clockMode == "smFlipper")
                  //     ? smFlipper(
                  //         timeValue: leftTime,
                  //         isSelected: leftSelected,
                  //         identificador: "Left",
                  //       )
                  //     : smFlip(
                  //         timeValue: leftTime,
                  //         isSelected: leftSelected,
                  //         identificador: "Left",
                  //       ),
                ),
              ),
            ),

            //CENTER
            // Expanded(
            //   flex: 6,
            //   child: Container(
            //     color: Colors.black,
            //     child: Center(child: Text('soy un menu')),
            //   ),
            // ),

            //RIGHT
            Expanded(
              flex: 50,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    leftSelected = false;
                    rightSelected = true;
                  });
                  startTimer(true);
                },
                child: (widget.clockMode == "smDigital")
                    ? smDigital(
                        timeValue: rightTime,
                        isSelected: rightSelected,
                        identificador: "Right",
                      )
                    : (widget.clockMode == "smAnalogic")
                        ? smAnalogic(
                            timeValue: rightTime,
                            isSelected: rightSelected,
                            identificador: "Right",
                            maxTime: maxTime,
                          )
                        : smFlipper(
                            timeValue: rightTime,
                            isSelected: rightSelected,
                            identificador: "Right",
                          ),
                // : (widget.clockMode == "smFlipper")
                //     ? smFlipper(
                //         timeValue: rightTime,
                //         isSelected: rightSelected,
                //         identificador: "Right",
                //       )
                //     : smFlip(
                //         timeValue: rightTime,
                //         isSelected: rightSelected,
                //         identificador: "Right",
                //       ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    stopTimer(); // Detenemos el temporizador al salir de la pantalla
    WakelockPlus.disable(); // Permitir que la pantalla se apague nuevamente
    super.dispose();
  }
}
