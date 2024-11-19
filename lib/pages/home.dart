import 'package:chess_clock/pages/pro_main.dart';
import 'package:chess_clock/pages/sm_main.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            // Title
            const Text(
              '¡Bienvenido!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Selecciona el modo que mas te guste',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),

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
                  _buildGlassCard(
                    context,
                    'Digital pro',
                    'Combina la aplicación con el stand pro',
                    'proDigital',
                  ),
                  _buildGlassCard(
                    context,
                    'Analógico pro',
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
        switch (mode) {
          case 'smDigital':
            Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(clockMode: true)));
            break;
          case 'smAnalogic':
            Navigator.push(context, MaterialPageRoute(builder: (context) => smClockScreen(clockMode: false)));
            break;
          case 'proDigital':
            Navigator.push(context, MaterialPageRoute(builder: (context) => proClockScreen(clockMode: true)));
            break;
          default:
            Navigator.push(context, MaterialPageRoute(builder: (context) => proClockScreen(clockMode: false)));
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
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
