import 'package:flip_board/flip_clock.dart';
import 'package:flutter/material.dart';

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
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlipCountdownClock(
            duration: Duration(seconds: timeValue),
            flipDirection: AxisDirection.down,
            digitSize: 60,
            width: 65,
            height: 100,
            digitColor: Colors.white,
            backgroundColor: Colors.grey,
            separatorColor: Colors.white,
            borderColor: Colors.black,
            hingeColor: Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            onDone: () => print('Buzzzz!'),
          ),
        ],
      )),
    );
  }
}
