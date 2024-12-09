import 'package:chess_clock/component/timePicker.dart';
import 'package:chess_clock/pages/pro_main.dart';
import 'package:chess_clock/pages/sm_main.dart';
import 'package:chess_clock/tools/convertStringToSecons.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedTime = '';
  // Variable para almacenar el tiempo seleccionado
  void _selectTime() async {
    final result = await showTimeDialog(context);
    if (result != null) {
      setState(() {
        selectedTime = '${result['minutes']} min ${result['seconds']} sec';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            // Title
            const Text(
              '¡Bienvenido!',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),

            const Text(
              'Simple y sin publicidad',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 40),

            //Etiqueta
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Text('| ', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
                  Text('Selecciona el tiempo de juego ', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
                  Text('|', style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 10),

            //Seleccionador de tiempo
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  readOnly: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: selectedTime.isEmpty ? 'Minutos y segundos' : selectedTime,
                    fillColor: Colors.white,
                  ),
                  onTap: _selectTime, // Llama al método para abrir el popup
                ),
              ),
            ),
            const SizedBox(height: 20),

            //Etiqueta
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Text('| ', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
                  Text('Selecciona el modo que mas te guste ', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
                  Text('|', style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Text('Modo Simple ', style: TextStyle(fontSize: 18, color: Colors.grey)),

            // Cards
            Expanded(
              child: GridView(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                padding: EdgeInsets.all(10),
                children: [
                  _buildGlassCard(
                    context,
                    'Digital',
                    'Interfaz simple y claro',
                    'smDigital',
                  ),
                  _buildGlassCard(
                    context,
                    'Analógico',
                    'Para los amantes de lo clásico',
                    'smAnalogic',
                  ),
                  _buildGlassCard(
                    context,
                    'Flipper',
                    'Intuitivo y con animaciones',
                    'smFlipper',
                  ),
                  _buildGlassCard(
                    context,
                    'Flip',
                    'Intuitivo y con animaciones',
                    'smFlip',
                  ),
                ],
              ),
            ),

            // //Etiqueta
            // Text('Con Stand ', style: TextStyle(fontSize: 18, color: Colors.grey)),
            // //PRO CARDS
            // Expanded(
            //   child: GridView(
            //     scrollDirection: Axis.horizontal,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
            //     padding: EdgeInsets.all(10),
            //     children: [
            //       _buildGlassCard(
            //         context,
            //         'Digital',
            //         'Interfaz simple y claro',
            //         'proDigital',
            //       ),
            //       _buildGlassCard(
            //         context,
            //         'Analógico',
            //         'Para los amantes de lo clásico',
            //         'proAnalogic',
            //       ),
            //       _buildGlassCard(
            //         context,
            //         'Flipper',
            //         'Intuitivo y con animaciones',
            //         'proFlipper',
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(height: 30),

            //Etiqueta
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Text('| ', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
                  Text('| ', style: TextStyle(fontSize: 18, color: Colors.white)),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
                  Text('|', style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard(BuildContext context, String title, String subtitle, String mode) {
    return GestureDetector(
      onTap: () {
        // Aquí puedes implementar la lógica al tocar la tarjeta
        print('$title seleccionado');
        if (selectedTime.isNotEmpty) {
          final timeInSeconds = convertToSeconds(selectedTime);
          switch (mode) {
            case 'smDigital':
              Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(clockMode: mode, selectedTime: timeInSeconds)));
              break;
            case 'smAnalogic':
              Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(clockMode: mode, selectedTime: timeInSeconds)));
              break;
            case 'smFlipper':
              Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(clockMode: mode, selectedTime: timeInSeconds)));
              break;
            case 'smFlip':
              Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(clockMode: mode, selectedTime: timeInSeconds)));
              break;
            case 'proDigital':
              Navigator.push(context, MaterialPageRoute(builder: (context) => proClockScreen(clockMode: mode, selectedTime: timeInSeconds)));
              break;
            case 'proAnalogic':
              Navigator.push(context, MaterialPageRoute(builder: (context) => proClockScreen(clockMode: mode, selectedTime: timeInSeconds)));
              break;
            default:
              Navigator.push(context, MaterialPageRoute(builder: (context) => proClockScreen(clockMode: mode, selectedTime: timeInSeconds)));
          }
        } else {
          // Maneja el caso donde el tiempo no está seleccionado
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Por favor, selecciona el tiempo de la partida primero.')),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
