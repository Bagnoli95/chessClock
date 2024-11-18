import 'package:flutter/material.dart';

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
      color: isSelected ? Colors.grey : Colors.grey[800],
      child: Container(
        child: Center(
          child: Text(
            formatTime(timeValue), // Formatea los segundos a "MM:SS"
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              letterSpacing: 3,
              fontSize: 50,
              shadows: const [Shadow(color: Colors.blueAccent, offset: Offset(2, 1), blurRadius: 10)],
            ),
          ),
        ),
      ),
    );
  }
}
