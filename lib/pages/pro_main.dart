import 'package:chess_clock/clocks/pro_analogic.dart';
import 'package:chess_clock/clocks/pro_digital.dart';
import 'package:chess_clock/clocks/sm_digital.dart';
import 'package:chess_clock/pages/sm_main.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class proClockScreen extends StatefulWidget {
  bool appMode;
  proClockScreen({super.key, required this.appMode});

  @override
  State<proClockScreen> createState() => _proClockScreenState();
}

class _proClockScreenState extends State<proClockScreen> {
  bool leftSelected = false;
  bool rightSelected = false;
  late int leftTime;
  late int rightTime;

  Timer? timer;
  late StreamSubscription<AccelerometerEvent> accelerometerSubscription;

  @override
  void initState() {
    super.initState();
    leftTime = 600; // Ejemplo: 10 minutos en segundos
    rightTime = 600; // Ejemplo: 10 minutos en segundos
    // Escuchamos los eventos del acelerómetro
    accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      handleDeviceTilt(event.x); // Detectamos la inclinación del dispositivo
    });
  }

  void handleDeviceTilt(double x) {
    // Detectamos inclinación hacia la derecha (x > 5.0) o hacia la izquierda (x < -5.0)
    if (x > 5.0 && !rightSelected) {
      setState(() {
        leftSelected = false;
        rightSelected = true;
      });
      startTimer(true);
    } else if (x < -5.0 && !leftSelected) {
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
    return Column(
      children: [
        //LEFT
        Expanded(
          flex: 45,
          child: Center(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(1.5708),
              child: SizedBox(
                width: MediaQuery.of(context).size.height * 0.45,
                height: MediaQuery.of(context).size.width,
                child: (widget.appMode) ? proDigital(timeValue: leftTime, isSelected: leftSelected, identificador: "Left") : proAnalogic(timeValue: leftTime, isSelected: leftSelected, identificador: "Left"),
              ),
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
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //SM DIGITAL
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(appMode: true)));
                  },
                  child: Text('smDigital'),
                ),
                //SM ANALOG
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(appMode: false)));
                  },
                  child: Text('smAnalog'),
                ),
                //PRO DIGITAL
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => proClockScreen(appMode: true)));
                  },
                  child: Text('proDigital'),
                ),
                //PRO ANALOG
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => proClockScreen(appMode: false)));
                  },
                  child: Text('proAnalog'),
                ),
              ],
            )),
          ),
        ),

        //RIGHT
        Expanded(
          flex: 45,
          child: Center(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(1.5708),
              child: SizedBox(
                width: MediaQuery.of(context).size.height * 0.45,
                height: MediaQuery.of(context).size.width,
                child: (widget.appMode) ? proDigital(timeValue: rightTime, isSelected: rightSelected, identificador: "Right") : proAnalogic(timeValue: leftTime, isSelected: leftSelected, identificador: "Left"),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    stopTimer(); // Detenemos el temporizador al salir de la pantalla
    accelerometerSubscription.cancel(); // Cancelamos la suscripción al acelerómetro
    super.dispose();
  }
}
