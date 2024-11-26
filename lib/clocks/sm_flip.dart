import 'package:flip_board/flip_clock.dart';
import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flip_board/flip_board.dart';

class smFlip extends StatelessWidget {
  final int timeValue;
  final bool isSelected;
  final String identificador;

  const smFlip({
    super.key,
    required this.timeValue,
    required this.isSelected,
    required this.identificador,
  });

  @override
  Widget build(BuildContext context) {
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
          child: Column(
        children: [
          //hora
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            padding: const EdgeInsets.all(16.0),
            child: FlipClock(
              digitSize: 54.0,
              width: 46.0,
              height: 62.0,
              separatorColor: Colors.green,
              hingeColor: Colors.black,
              showBorder: true,
            ),
          ),

          //Contador regresivo
          //       Widget _flipCountdown(ColorScheme colors) =>
          // Container(
          //   decoration: BoxDecoration(
          //     color: colors.secondary,
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          //   padding: const EdgeInsets.all(24.0),
          //   child: FlipCountdownClock(
          //     duration: const Duration(minutes: 1),
          //     digitSize: 54.0,
          //     width: 46.0,
          //     height: 62.0,
          //     digitColor: colors.surface,
          //     backgroundColor: colors.onSurface,
          //     separatorColor: colors.onSurface,
          //     borderColor: colors.primary,
          //     hingeColor: colors.surface,
          //     borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          //     onDone: () => print('Buzzzz!'),
          //   ),
          // ),
        ],
      )),
    );
  }
}
//https://pub.dev/packages/flip_board
//https://pub.dev/packages/animated_flip_counter
