import 'package:flutter/material.dart';

Future<Map<String, int>?> showTimeDialog(BuildContext context) async {
  int currentMinute = 0;
  int currentSecond = 0;

  return await showDialog<Map<String, int>>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey[900], // Fondo oscuro
        title: Text(
          'Selecciona el tiempo',
          style: TextStyle(color: Colors.white),
        ),
        content: SizedBox(
          height: 250, // Altura para los scrollables
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Lista para seleccionar los minutos
              _buildWheel(
                title: 'Minutos',
                onSelectedItemChanged: (index) {
                  currentMinute = index;
                },
                selectedIndex: currentMinute,
              ),
              // Lista para seleccionar los segundos
              _buildWheel(
                title: 'Segundos',
                onSelectedItemChanged: (index) {
                  currentSecond = index;
                },
                selectedIndex: currentSecond,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(null); // Cierra sin devolver valor
            },
            child: Text('Cancelar', style: TextStyle(color: Colors.redAccent)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop({
                'minutes': currentMinute,
                'seconds': currentSecond,
              }); // Devuelve los valores seleccionados
            },
            child: Text('Aceptar', style: TextStyle(color: Colors.greenAccent)),
          ),
        ],
      );
    },
  );
}

Widget _buildWheel({
  required String title,
  required ValueChanged<int> onSelectedItemChanged,
  required int selectedIndex,
}) {
  return Expanded(
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        Expanded(
          child: ListWheelScrollView.useDelegate(
            controller: FixedExtentScrollController(initialItem: selectedIndex),
            itemExtent: 40,
            perspective: 0.005,
            diameterRatio: 1.5,
            useMagnifier: true,
            magnification: 2,
            physics: FixedExtentScrollPhysics(),
            onSelectedItemChanged: onSelectedItemChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return Center(
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                );
              },
              childCount: 60, // Hasta 59
            ),
          ),
        ),
      ],
    ),
  );
}
