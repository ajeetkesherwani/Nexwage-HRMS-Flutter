class PostSocialModel {
  bool? status;
  String? message;
  Data? data;

  PostSocialModel({this.status, this.message, this.data});

  PostSocialModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? onSiteAttendance;
  String? firstName;
  String? lastName;
  String? staffId;
  String? oldEmpId;
  String? email;
  String? contactNo;
  String? dateOfBirth;
  String? gender;
  int? officeShiftId;
  int? companyId;
  int? departmentId;
  int? designationId;
  int? reportingTo;
  String? locationId;
  int? roleUsersId;
  String? statusId;
  String? joiningDate;
  String? exitDate;
  String? maritalStatus;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? cv;
  String? skypeId;
  String? fbId;
  String? twitterId;
  String? linkedInId;
  String? whatsappId;
  int? basicSalary;
  String? payslipType;
  String? attendanceType;
  String? pensionType;
  int? pensionAmount;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? profilePhoto;

  Data(
      {this.id,
        this.onSiteAttendance,
        this.firstName,
        this.lastName,
        this.staffId,
        this.oldEmpId,
        this.email,
        this.contactNo,
        this.dateOfBirth,
        this.gender,
        this.officeShiftId,
        this.companyId,
        this.departmentId,
        this.designationId,
        this.reportingTo,
        this.locationId,
        this.roleUsersId,
        this.statusId,
        this.joiningDate,
        this.exitDate,
        this.maritalStatus,
        this.address,
        this.city,
        this.state,
        this.country,
        this.zipCode,
        this.cv,
        this.skypeId,
        this.fbId,
        this.twitterId,
        this.linkedInId,
        this.whatsappId,
        this.basicSalary,
        this.payslipType,
        this.attendanceType,
        this.pensionType,
        this.pensionAmount,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.profilePhoto});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    onSiteAttendance = json['on_site_attendance'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    staffId = json['staff_id'];
    oldEmpId = json['old_emp_id'];
    email = json['email'];
    contactNo = json['contact_no'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    officeShiftId = json['office_shift_id'];
    companyId = json['company_id'];
    departmentId = json['department_id'];
    designationId = json['designation_id'];
    reportingTo = json['reporting_to'];
    locationId = json['location_id'];
    roleUsersId = json['role_users_id'];
    statusId = json['status_id'];
    joiningDate = json['joining_date'];
    exitDate = json['exit_date'];
    maritalStatus = json['marital_status'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    zipCode = json['zip_code'];
    cv = json['cv'];
    skypeId = json['skype_id'];
    fbId = json['fb_id'];
    twitterId = json['twitter_id'];
    linkedInId = json['linkedIn_id'];
    whatsappId = json['whatsapp_id'];
    basicSalary = json['basic_salary'];
    payslipType = json['payslip_type'];
    attendanceType = json['attendance_type'];
    pensionType = json['pension_type'];
    pensionAmount = json['pension_amount'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhoto = json['profile_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['on_site_attendance'] = this.onSiteAttendance;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['staff_id'] = this.staffId;
    data['old_emp_id'] = this.oldEmpId;
    data['email'] = this.email;
    data['contact_no'] = this.contactNo;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['office_shift_id'] = this.officeShiftId;
    data['company_id'] = this.companyId;
    data['department_id'] = this.departmentId;
    data['designation_id'] = this.designationId;
    data['reporting_to'] = this.reportingTo;
    data['location_id'] = this.locationId;
    data['role_users_id'] = this.roleUsersId;
    data['status_id'] = this.statusId;
    data['joining_date'] = this.joiningDate;
    data['exit_date'] = this.exitDate;
    data['marital_status'] = this.maritalStatus;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['zip_code'] = this.zipCode;
    data['cv'] = this.cv;
    data['skype_id'] = this.skypeId;
    data['fb_id'] = this.fbId;
    data['twitter_id'] = this.twitterId;
    data['linkedIn_id'] = this.linkedInId;
    data['whatsapp_id'] = this.whatsappId;
    data['basic_salary'] = this.basicSalary;
    data['payslip_type'] = this.payslipType;
    data['attendance_type'] = this.attendanceType;
    data['pension_type'] = this.pensionType;
    data['pension_amount'] = this.pensionAmount;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_photo'] = this.profilePhoto;
    return data;
  }
}
