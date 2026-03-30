class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({this.status, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? token;
  Employee? employee;
  Company? company;

  Data({this.token, this.employee, this.company});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Employee {
  var id;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? username;
  String? profilePhoto;

  Employee(
      {this.id,
        this.firstName,
        this.lastName,
        this.fullName,
        this.email,
        this.username,
        this.profilePhoto});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    email = json['email'];
    username = json['username'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}

class Company {
  int? id;
  String? companyName;
  String? tradingName;
  String? email;
  String? contactNo;
  String? website;
  String? companyLogo;
  double? officeLatitude;
  double? officeLongitude;
  double? attendanceRadius;
  bool? allowOutsideLocation;
  bool? allowWorkOnLeave;
  int? overtimeMinMinutes;

  Company({
    this.id,
    this.companyName,
    this.tradingName,
    this.email,
    this.contactNo,
    this.website,
    this.companyLogo,
    this.officeLatitude,
    this.officeLongitude,
    this.attendanceRadius,
    this.allowOutsideLocation,
    this.allowWorkOnLeave,
    this.overtimeMinMinutes,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    companyName = json['company_name'];
    tradingName = json['trading_name'];
    email = json['email'];
    contactNo = json['contact_no'];
    website = json['website'];
    companyLogo = json['company_logo'];

    // ✅ SAFE DOUBLE CONVERSION
    officeLatitude = (json['office_latitude'] as num?)?.toDouble();
    officeLongitude = (json['office_longitude'] as num?)?.toDouble();
    attendanceRadius = (json['attendance_radius'] as num?)?.toDouble();

    // ✅ SAFE BOOL
    allowOutsideLocation = json['allow_outside_location'] == true;
    allowWorkOnLeave = json['allow_work_on_leave'] == true;

    // ✅ FIXED (was Null before ❌)
    overtimeMinMinutes = json['overtime_min_minutes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'trading_name': tradingName,
      'email': email,
      'contact_no': contactNo,
      'website': website,
      'company_logo': companyLogo,
      'office_latitude': officeLatitude,
      'office_longitude': officeLongitude,
      'attendance_radius': attendanceRadius,
      'allow_outside_location': allowOutsideLocation,
      'allow_work_on_leave': allowWorkOnLeave,
      'overtime_min_minutes': overtimeMinMinutes,
    };
  }
}
