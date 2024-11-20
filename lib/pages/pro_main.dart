import 'package:chess_clock/clocks/pro_analogic.dart';
import 'package:chess_clock/clocks/pro_digital.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class proClockScreen extends StatefulWidget {
  bool clockMode;
  int selectedTime;
  proClockScreen({super.key, required this.clockMode, required this.selectedTime});

  @override
  State<proClockScreen> createState() => _proClockScreenState();
}

class _proClockScreenState extends State<proClockScreen> {
  bool leftSelected = false;
  bool rightSelected = false;
  late int leftTime;
  late int rightTime;
  late int maxTime;
  late double position_x, position_y, position_z;

  Timer? timer;
  late StreamSubscription<AccelerometerEvent> accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    leftTime = widget.selectedTime; // Ejemplo: 10 minutos en segundos
    rightTime = widget.selectedTime; // Ejemplo: 10 minutos en segundos
    maxTime = widget.selectedTime;
    position_x = 0;
    position_y = 0;
    position_z = 0;
    // Escuchamos los eventos del acelerómetro
    accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      handleDeviceTilt(event.x, event.y, event.z); // Detectamos la inclinación del dispositivo
    });
  }

  void handleDeviceTilt(double x, double y, double z) {
    position_x = (x * 100).round() / 100;
    position_y = (y * 100).round() / 100;
    position_z = (z * 100).round() / 100;
    // Detectamos inclinación hacia la derecha (x > 5.0) o hacia la izquierda (x < -5.0)
    if (y > 3.0 && !rightSelected) {
      setState(() {
        leftSelected = false;
        rightSelected = true;
      });
      startTimer(true);
    } else if (y < -3.0 && !leftSelected) {
      setState(() {
        leftSelected = true;
        rightSelected = false;
      });
      startTimer(false);
    }
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
    debugPrint("proClockScreen: LeftSelected: ($leftSelected), RightSelected: ($rightSelected)");
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            //LEFT
            Expanded(
              flex: 50,
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(1.5708),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height * 0.45,
                    height: MediaQuery.of(context).size.width,
                    child: (widget.clockMode)
                        ? proDigital(
                            timeValue: leftTime,
                            isSelected: leftSelected,
                            identificador: "Left",
                          )
                        : proAnalogic(
                            timeValue: leftTime,
                            isSelected: leftSelected,
                            identificador: "Left",
                            maxTime: maxTime,
                          ),
                  ),
                ),
              ),
            ),

            // //CENTER
            // Expanded(
            //   flex: 10,
            //   child: Container(
            //     // margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            //     color: Colors.black,
            //     child: Center(
            //         child: Column(
            //       children: [
            //         Text('Valor de X: $position_x', style: TextStyle(color: Colors.white)),
            //         Text('Valor de Y: $position_y', style: TextStyle(color: Colors.white)),
            //         Text('Valor de Z: $position_z', style: TextStyle(color: Colors.white)),
            //       ],
            //     )),
            //   ),
            // ),

            //RIGHT
            Expanded(
              flex: 50,
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(1.5708),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.height * 0.45,
                    height: MediaQuery.of(context).size.width,
                    child: (widget.clockMode)
                        ? proDigital(
                            timeValue: rightTime,
                            isSelected: rightSelected,
                            identificador: "Right",
                          )
                        : proAnalogic(
                            timeValue: rightTime,
                            isSelected: rightSelected,
                            identificador: "Right",
                            maxTime: maxTime,
                          ),
                  ),
                ),
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
    accelerometerSubscription.cancel(); // Cancelamos la suscripción al acelerómetro
    super.dispose();
  }
}
