import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class smAnalogic extends StatelessWidget {
  final int timeValue;
  final bool isSelected; // Se mantiene final porque no cambia dentro del widget
  final String identificador;

  // int width = MediaQuery.of()
  const smAnalogic({
    super.key,
    required this.timeValue,
    required this.isSelected,
    required this.identificador,
  });

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // Debug para verificar el valor de isSelected
    debugPrint("smAnalogic ($identificador) isSelected: $isSelected");
    return Container(
      color: isSelected ? Colors.grey[800] : Colors.grey,
      child: Container(
        child: Center(
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 120, labelFormat: '{value}s', pointers: <GaugePointer>[
              NeedlePointer(
                value: timeValue.toDouble(),
                needleStartWidth: 1,
                needleEndWidth: 5,
                knobStyle: KnobStyle(
                  knobRadius: 0.05,
                  borderColor: Colors.black,
                  borderWidth: 0.02,
                  color: Colors.white,
                ),
              ),
            ], annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.5,
                  widget: Text(
                    timeValue.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))
            ])
          ]),
        ),
      ),
    );
  }
}
