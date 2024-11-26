int convertToSeconds(String time) {
  final parts = time.split(' '); // Divide el String en partes (minutos y segundos)
  final minutes = int.tryParse(parts[0]) ?? 0; // Convierte los minutos
  final seconds = int.tryParse(parts[2]) ?? 0; // Convierte los segundos
  return (minutes * 60) + seconds; // Retorna el total en segundos
}

String formatTime(int seconds) {
  int minutes = seconds ~/ 60;
  int remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
}
