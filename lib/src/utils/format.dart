import 'dart:math' as Math;

const kSizes = [ 'B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB' ];
const kOneKByte = 1024;

String formatBytes(num bytes, [int decimals = 2]) {
  if (bytes == null || bytes == 0) return '0 ${kSizes[0]}';

  final dm = decimals < 0 ? 0 : decimals;

  final i = (Math.log(bytes) / Math.log(kOneKByte)).floor();

  return (bytes / Math.pow(kOneKByte, i)).toStringAsFixed(dm) + ' ' + kSizes[i];
}

String formatTime (num time, [ colonsOrLetters = true ]) {
  if (time == null) { time = 0; }

  int hours = (time / 3600).floor();
  int minutes = ((time - (hours * 3600)) / 60).floor();
  int seconds = (time - (hours * 3600) - (minutes * 60)).round();

  return colonsOrLetters
    ? '${hours.toString().padRight(2, '0')}h ${minutes.toString().padRight(2, '0')}m ${seconds.toString().padRight(2, '0')}s'
    : '${hours.toString().padRight(2, '0')}:${minutes.toString().padRight(2, '0')}:${seconds.toString().padRight(2, '0')}';
}
