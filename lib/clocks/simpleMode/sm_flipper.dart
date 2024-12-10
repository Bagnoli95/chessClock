import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

class smFlipper extends StatelessWidget {
  final int timeValue;
  final bool isSelected;
  final String identificador;

  const smFlipper({
    super.key,
    required this.timeValue,
    required this.isSelected,
    required this.identificador,
  });

  @override
  Widget build(BuildContext context) {
    double minutos = (timeValue / 60).floorToDouble();
    double segundos = timeValue % 60;
    debugPrint("smFlipper: timeValue: ($timeValue), minutos: ($minutos), segundos: ($segundos)");

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //MINUTOS
            AnimatedFlipCounter(
              duration: const Duration(milliseconds: 65),
              value: minutos,
              wholeDigits: 2,
              fractionDigits: 0,
              textStyle: TextStyle(
                fontSize: 120,
                color: isSelected ? Colors.grey : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            //SEPARADOR
            Text(':',
                style: TextStyle(
                  fontSize: 120,
                  color: isSelected ? Colors.grey : Colors.white,
                  fontWeight: FontWeight.bold,
                )),

            //SEGUNDOS
            AnimatedFlipCounter(
              duration: const Duration(milliseconds: 65),
              value: segundos,
              wholeDigits: 2,
              fractionDigits: 0,
              textStyle: TextStyle(
                fontSize: 120,
                color: isSelected ? Colors.grey : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
