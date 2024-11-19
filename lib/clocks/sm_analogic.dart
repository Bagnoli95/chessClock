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
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 120,
              labelFormat: '{value}s',
              startAngle: 270,
              endAngle: 270,
              showFirstLabel: false,
              showLastLabel: true,
              axisLabelStyle: GaugeTextStyle(
                color: isSelected ? Colors.grey : Colors.black,
                fontSize: 12,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times',
              ),
              axisLineStyle: AxisLineStyle(
                thickness: 0.1,
                thicknessUnit: GaugeSizeUnit.factor,
                color: Colors.black,
              ),
              pointers: <GaugePointer>[
                NeedlePointer(
                  value: timeValue.toDouble(),
                  needleStartWidth: 1,
                  needleEndWidth: 8,
                  needleLength: 0.55,
                  needleColor: Colors.red,
                  knobStyle: KnobStyle(
                    knobRadius: 0.05,
                    borderColor: Colors.black,
                    borderWidth: 0.02,
                    color: Colors.black,
                  ),
                ),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    angle: 90,
                    positionFactor: 0.5,
                    widget: Text(
                      timeValue.toString(),
                      style: TextStyle(
                        color: isSelected ? Colors.grey : Colors.black,
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times',
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
