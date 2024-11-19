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
            const SizedBox(height: 50),
            // Title
            const Text(
              '¡Bienvenido!',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),

            const Text(
              'Simple y sin publicidad',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            //Etiqueta
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
                  Text('Selecciona el tiempo de juego ', style: TextStyle(fontSize: 16, color: Colors.white)),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
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

            //Etiqueta
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
                  Text('Selecciona el modo que mas te guste ', style: TextStyle(fontSize: 16, color: Colors.white)),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1, endIndent: 6)),
                ],
              ),
            ),
            const SizedBox(height: 10),

            Text('Modo Simple ', style: TextStyle(fontSize: 16, color: Colors.grey)),

            // Cards
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                padding: EdgeInsets.all(10),
                children: [
                  _buildGlassCard(
                    context,
                    'Digital',
                    'Juega con un amigo solamente con tu dispositivo',
                    'smDigital',
                  ),
                  _buildGlassCard(
                    context,
                    'Analógico',
                    'Juega con un amigo solamente con tu dispositivo',
                    'smAnalogic',
                  ),
                ],
              ),
            ),

            //Etiqueta
            Text('con stand ', style: TextStyle(fontSize: 16, color: Colors.grey)),
            //PRO CARDS
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                padding: EdgeInsets.all(10),
                children: [
                  _buildGlassCard(
                    context,
                    'Digital',
                    'Combina la aplicación con el stand pro',
                    'proDigital',
                  ),
                  _buildGlassCard(
                    context,
                    'Analógico',
                    'Combina la aplicación con el stand pro',
                    'proAnalogic',
                  ),
                ],
              ),
            ),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(clockMode: true, selectedTime: timeInSeconds)));
              break;
            case 'smAnalogic':
              Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(clockMode: false, selectedTime: timeInSeconds)));
              break;
            case 'proDigital':
              Navigator.push(context, MaterialPageRoute(builder: (context) => proClockScreen(clockMode: true, selectedTime: timeInSeconds)));
              break;
            default:
              Navigator.push(context, MaterialPageRoute(builder: (context) => proClockScreen(clockMode: false, selectedTime: timeInSeconds)));
          }
        } else {
          // Maneja el caso donde el tiempo no está seleccionado
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Por favor, selecciona un tiempo primero.')),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
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
