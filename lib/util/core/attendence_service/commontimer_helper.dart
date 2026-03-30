import 'package:shared_preferences/shared_preferences.dart';

class TimerHelper {

  /// 🔥 Get remaining duration from local
  static Future<Duration> getRemainingTime() async {
    final prefs = await SharedPreferences.getInstance();

    String? shiftEnd = prefs.getString('shiftEnd');
    String? punchTime = prefs.getString('punchTime');

    if (shiftEnd == null || punchTime == null) {
      return Duration.zero;
    }

    DateTime now = DateTime.now();

    final endParts = shiftEnd.split(":");

    final endDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(endParts[0]),
      int.parse(endParts[1]),
    );

    if (now.isAfter(endDateTime)) {
      return Duration.zero;
    }

    return endDateTime.difference(now);
  }

  /// 🔥 Format duration to text
  static String format(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return "$hours:$minutes:$seconds";
  }
}