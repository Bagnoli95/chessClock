import 'package:chess_clock/clocks/sm_analogic.dart';
import 'package:chess_clock/clocks/sm_digital.dart';
import 'package:chess_clock/pages/pro_main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class smClockScreen extends StatefulWidget {
  bool appMode;
  smClockScreen({super.key, required this.appMode});

  @override
  State<smClockScreen> createState() => _smClockScreenState();
}

class _smClockScreenState extends State<smClockScreen> {
  bool leftSelected = false;
  bool rightSelected = false;
  late int leftTime;
  late int rightTime;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    leftTime = 600; // Ejemplo: 10 minutos en segundos
    rightTime = 600; // Ejemplo: 10 minutos en segundos
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
    return Column(
      children: [
        //LEFT
        Expanded(
          flex: 45,
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
              child: (widget.appMode) ? smDigital(timeValue: leftTime, isSelected: leftSelected, identificador: "Left") : smAnalogic(timeValue: leftTime, isSelected: leftSelected, identificador: "Left"),
            ),
          ),
        ),

        //CENTER
        Expanded(
          flex: 10,
          child: Container(
            // margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            color: Colors.black,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => proClockScreen(appMode: true)),
                  );
                },
                child: Text('SM'),
              ),
            ),
          ),
        ),

        //RIGHT
        Expanded(
          flex: 45,
          child: GestureDetector(
            onTap: () {
              setState(() {
                leftSelected = false;
                rightSelected = true;
              });
              startTimer(true);
            },
            child: (widget.appMode) ? smDigital(timeValue: rightTime, isSelected: rightSelected, identificador: "Right") : smAnalogic(timeValue: leftTime, isSelected: leftSelected, identificador: "Left"),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    stopTimer(); // Detenemos el temporizador al salir de la pantalla
    super.dispose();
  }
}
