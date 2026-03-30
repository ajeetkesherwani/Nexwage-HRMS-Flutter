import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../screen/attendance_screen/provider/attendance_provider.dart';
import '../device_id/device_service.dart';

class AttendanceService {

  static Future<void> markAttendance(BuildContext context) async {
    try {
      Position? position = await _getUserLocation();
      String timestamp = DateTime.now().toIso8601String();
      if (position == null) {
        _showSnack(context, "Unable to fetch location");
        return;
      }

      double latitude = position.latitude;
      double longitude = position.longitude;

      final prefs = await SharedPreferences.getInstance();

      double officeLat = prefs.getDouble('officeLatitude') ?? 0.0;
      double officeLng = prefs.getDouble('officeLongitude') ?? 0.0;
      double allowedRadius = prefs.getDouble('attendanceRadius') ?? 100;
      bool allowOutside = prefs.getBool('allowOutsideLocation') ?? false;

      double distance = Geolocator.distanceBetween(
        latitude,
        longitude,
        officeLat,
        officeLng,
      );

      print("Latitude: $latitude");
      print("Longitude: $longitude");
      print("Distance: $distance meters");
      print("Device ID: ${DeviceManager.deviceId}");
      print("Time Stamp: $timestamp");
      print("officeLat: $officeLat");
      print("officeLng: $officeLng");
      print("allowedRadius: $allowedRadius");
      print("allowOutside: $allowOutside");

      if (!(allowOutside || distance <= allowedRadius)) {
        DialogHelper.showOutOfRange(context, distance);
        return;
      }

      final provider =
      Provider.of<AttendanceProvider>(context, listen: false);

      await provider.PostAttendanceData(
        latitude: latitude,
        longitude: longitude,
        device_id: DeviceManager.deviceId,
        timestamp: DateTime.now().toIso8601String(),
      );

      if (provider.error == null) {
        final data = provider.postWalletResponse?.data;

        if (data != null) {
          String shiftStart = data.shift?.start ?? "09:00";
          String shiftEnd = data.shift?.end ?? "18:00";

          await prefs.setString('shiftStart', shiftStart);
          await prefs.setString('shiftEnd', shiftEnd);
          await prefs.setString(
              'punchTime', DateTime.now().toIso8601String());

          provider.shiftStart = shiftStart;
          provider.shiftEnd = shiftEnd;
        }

        DialogHelper.showSuccess(context);

      } else if (provider.error!.toLowerCase().contains("already")) {
        DialogHelper.showAlreadyMarked(context);
      } else {
        _showSnack(context, provider.error!);
      }

    } catch (e) {
      _showSnack(context, "Something went wrong");
    }
  }

  // 🔹 LOCATION METHOD
  static Future<Position?> _getUserLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition();
  }

  static void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}




class DialogHelper {

  static void showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Success"),
        content: const Text("Attendance Marked Successfully"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  static void showAlreadyMarked(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Already Marked"),
        content: const Text("Attendance already marked today"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  static void showOutOfRange(BuildContext context, double distance) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Out of Range"),
        content: Text(
            "You are ${distance.toStringAsFixed(0)}m away from office"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Try Again"),
          )
        ],
      ),
    );
  }
}