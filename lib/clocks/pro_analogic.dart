import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class proAnalogic extends StatelessWidget {
  final int timeValue;
  final bool isSelected; // Se mantiene final porque no cambia dentro del widget
  final String identificador;

  const proAnalogic({
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
    debugPrint("proAnalogic ($identificador) isSelected: $isSelected");
    return Container(
      color: isSelected ? Colors.grey : Colors.grey[800],
      child: Center(
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 120,
            labelFormat: '{value}s',
            startAngle: 270,
            endAngle: 270,
            showFirstLabel: false,
            showLastLabel: true,
            pointers: <GaugePointer>[
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
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  positionFactor: 0.5,
                  widget: Text(
                    timeValue.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
