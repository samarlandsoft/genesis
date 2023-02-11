import 'dart:developer';

void logDebug(String message) {
  final time = DateTime.now();
  final formattedTime =
      '${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}:${time.second}';

  log('***** $formattedTime > $message');
}
