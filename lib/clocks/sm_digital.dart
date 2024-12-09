import 'package:chess_clock/tools/convertStringToSecons.dart';
import 'package:flutter/material.dart';

class smDigital extends StatelessWidget {
  final int timeValue;
  final bool isSelected; // Se mantiene final porque no cambia dentro del widget
  final String identificador;

  // int width = MediaQuery.of()
  const smDigital({
    super.key,
    required this.timeValue,
    required this.isSelected,
    required this.identificador,
  });

  @override
  Widget build(BuildContext context) {
    // Debug para verificar el valor de isSelected
    debugPrint("smDigital ($identificador) isSelected: $isSelected");
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Container(
        child: Center(
          child: Text(
            formatTime(timeValue), // Formatea los segundos a "MM:SS"
            style: TextStyle(
              color: isSelected ? Colors.grey : Colors.white,
              letterSpacing: 3,
              fontSize: 70,
              fontWeight: FontWeight.bold,
              // shadows: const [Shadow(color: Colors.grey.withOpacity(0.1), offset: Offset(2, 1), blurRadius: 10)],
            ),
          ),
        ),
      ),
    );
  }
}
