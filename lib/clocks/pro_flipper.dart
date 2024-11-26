import 'package:flutter/material.dart';

class proFlipper extends StatelessWidget {
  final int timeValue;
  final bool isSelected; // Se mantiene final porque no cambia dentro del widget
  final String identificador;

  const proFlipper({
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
    debugPrint("proDigital ($identificador) isSelected: $isSelected");
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
