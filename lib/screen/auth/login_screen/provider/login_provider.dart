// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../../widget/navigator_method.dart';
// import '../../../bottom_bar/ui/bottom_bar_screen.dart';
// import '../../../home_screen/ui/home_screen.dart';
// import '../model/login_model.dart';
// import '../repo/login_repo.dart';
//
// class LoginProvider with ChangeNotifier {
//   final _repo = LoginRepository();
//   bool loading = false;
//   LoginModel? otpModel;
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passController = TextEditingController();
//
//
//
//   Future<void> sendOtpProvider(BuildContext context) async {
//     String username = emailController.text.trim();
//     String password = passController.text.trim();
//
//     if (username.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter username & password")),
//       );
//       return;
//     }
//
//     try {
//       loading = true;
//       notifyListeners();
//
//       var response = await _repo.sendOtp(username, password);
//
//       print("FULL LOGIN API RESPONSE: $response");
//
//       otpModel = LoginModel.fromJson(response);
//
//       if (otpModel?.status == true && otpModel?.data != null) {
//         final company = otpModel!.data!.company;
//
//         if (company == null) {
//           throw Exception("Company data is null");
//         }
//         String token = otpModel?.data?.token ?? "";
//         String companyName = company.companyName ?? "";
//         String tradingName = company.tradingName ?? "";
//         String email = company.email ?? "";
//         String contactNo = company.contactNo ?? "";
//         String website = company.website ?? "";
//
//         // ✅ DIRECT VALUES (NO PARSE NEEDED)
//         double officeLatitude = company.officeLatitude ?? 0.0;
//         double officeLongitude = company.officeLongitude ?? 0.0;
//         double attendanceRadius =
//         (company.attendanceRadius ?? 0).toDouble();
//         bool allowOutsideLocation = company.allowOutsideLocation ?? false;
//
//         // 🔥 DEBUG CHECK (VERY IMPORTANT)
//         print("====== DEBUG COMPANY DATA ======");
//         print("Lat: $officeLatitude");
//         print("Lng: $officeLongitude");
//         print("Radius: $attendanceRadius");
//         print("AllowOutside: $allowOutsideLocation");
//         print("================================");
//
//         // ✅ SAVE TO PREFS
//         final prefs = await SharedPreferences.getInstance();
//
//         await prefs.setString('auth_token', token);
//         await prefs.setString('company_name', companyName);
//         await prefs.setString('tradingName', tradingName);
//         await prefs.setString('email', email);
//         await prefs.setString('contactNo', contactNo);
//         await prefs.setString('website', website);
//         await prefs.setDouble('officeLatitude', officeLatitude);
//         await prefs.setDouble('officeLongitude', officeLongitude);
//         await prefs.setDouble('attendanceRadius', attendanceRadius);
//         await prefs.setBool('allowOutsideLocation', allowOutsideLocation);
//
//         // ✅ VERIFY SAVE (OPTIONAL BUT BEST)
//         print("=========== STORED DATA ===========");
//         print("TOKEN: ${prefs.getString('auth_token')}");
//         print("Company Name: ${prefs.getString('company_name')}");
//         print("Office Latitude: ${prefs.getDouble('officeLatitude')}");
//         print("Office Longitude: ${prefs.getDouble('officeLongitude')}");
//         print("Attendance Radius: ${prefs.getDouble('attendanceRadius')}");
//         print("Allow Outside Location: ${prefs.getBool('allowOutsideLocation')}");
//         print("===================================");
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(otpModel?.message ?? "Login Successful")),
//         );
//
//         // ✅ NAVIGATION
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MainScreen()),
//         );
//
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(otpModel?.message ?? "Login Failed")),
//         );
//       }
//
//     } catch (e, stackTrace) {
//       // 🔥 SHOW REAL ERROR
//       print("LOGIN ERROR: $e");
//       print("STACK TRACE: $stackTrace");
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: ${e.toString()}")),
//       );
//
//     } finally {
//       loading = false;
//       notifyListeners();
//     }
//   }
//
//
// }
//


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../widget/navigator_method.dart';
import '../../../bottom_bar/ui/bottom_bar_screen.dart';
import '../../../home_screen/ui/home_screen.dart';
import '../model/login_model.dart';
import '../repo/login_repo.dart';

class LoginProvider with ChangeNotifier {
  final _repo = LoginRepository();

  bool loading = false;
  LoginModel? otpModel;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<void> sendOtpProvider(BuildContext context) async {
    String username = emailController.text.trim();
    String password = passController.text.trim();

    // ✅ VALIDATION
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter username & password")),
      );
      return;
    }

    try {
      loading = true;
      notifyListeners();

      var response = await _repo.sendOtp(username, password);

      print("FULL LOGIN API RESPONSE: $response");

      otpModel = LoginModel.fromJson(response);

      // ✅ SUCCESS CONDITION
      if (otpModel?.status == true && otpModel?.data != null) {
        final company = otpModel!.data!.company;

        if (company == null) {
          throw Exception("Company data is null");
        }

        // ✅ DATA
        String token = otpModel?.data?.token ?? "";
        String companyName = company.companyName ?? "";
        String tradingName = company.tradingName ?? "";
        String email = company.email ?? "";
        String contactNo = company.contactNo ?? "";
        String website = company.website ?? "";

        double officeLatitude = company.officeLatitude ?? 0.0;
        double officeLongitude = company.officeLongitude ?? 0.0;
        double attendanceRadius =
        (company.attendanceRadius ?? 0).toDouble();
        bool allowOutsideLocation =
            company.allowOutsideLocation ?? false;

        // 🔥 DEBUG
        print("====== DEBUG COMPANY DATA ======");
        print("Lat: $officeLatitude");
        print("Lng: $officeLongitude");
        print("Radius: $attendanceRadius");
        print("AllowOutside: $allowOutsideLocation");
        print("================================");

        // ✅ SAVE DATA
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('auth_token', token);
        await prefs.setString('company_name', companyName);
        await prefs.setString('tradingName', tradingName);
        await prefs.setString('email', email);
        await prefs.setString('contactNo', contactNo);
        await prefs.setString('website', website);
        await prefs.setDouble('officeLatitude', officeLatitude);
        await prefs.setDouble('officeLongitude', officeLongitude);
        await prefs.setDouble('attendanceRadius', attendanceRadius);
        await prefs.setBool(
            'allowOutsideLocation', allowOutsideLocation);

        // ✅ VERIFY
        print("=========== STORED DATA ===========");
        print("TOKEN: ${prefs.getString('auth_token')}");
        print("Company Name: ${prefs.getString('company_name')}");
        print("Office Latitude: ${prefs.getDouble('officeLatitude')}");
        print("Office Longitude: ${prefs.getDouble('officeLongitude')}");
        print("Attendance Radius: ${prefs.getDouble('attendanceRadius')}");
        print("Allow Outside Location: ${prefs.getBool('allowOutsideLocation')}");
        print("===================================");

        // ✅ SUCCESS MESSAGE
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(otpModel?.message ?? "Login Successful")),
        );

        // 🔥 VERY IMPORTANT FIX
        if (!context.mounted) return;


        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(otpModel?.message ?? "Login Failed")),
        );
      }

    } catch (e, stackTrace) {
      print("LOGIN ERROR: $e");
      print("STACK TRACE: $stackTrace");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );

    } finally {
      loading = false;
      notifyListeners();
    }
  }
}