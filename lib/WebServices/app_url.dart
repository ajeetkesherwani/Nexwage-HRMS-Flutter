class AppUrl {
 //local
  //static const String baseUrl = 'http://35.154.123.59';
 //static const String baseUrl = 'http://192.168.1.17:7001';


 //live
 static const String baseUrl = 'https://teknikoglobal.in/other/nexwage';


  static const String sendOtp = '$baseUrl/api/employee/login';
  static const String getProfile = '$baseUrl/api/employee/profile';
  static const String getCms = '$baseUrl/api/cms';
  static const String appVersion = '$baseUrl/api/app-version';
  static const String postAttendance = '$baseUrl/api/employee/attendance/punch-in';
  static const String holiDay = '$baseUrl/api/employee/holidays';
  static const String panchOut = '$baseUrl/api/employee/attendance/punch-out';
  static const String todayAttendance = '$baseUrl/api/employee/attendance/today';
  static const String home = '$baseUrl/api/employee/home';
  static const String leave = '$baseUrl/api/employee/leave-summary';
  static const String leaveType = '$baseUrl/api/employee/leaves/types';
  static const String applyLeave = '$baseUrl/api/employee/leaves/apply';
  static const String emergencyContactPost = '$baseUrl/api/employee/profile/contacts';

 static const String getMonthlyAttendance =
     '$baseUrl/api/employee/attendance/calendar';
 static const String annualReport = '$baseUrl/api/employee/attendance/history';


}
