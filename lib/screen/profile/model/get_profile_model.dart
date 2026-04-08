class GetProfileModel {
  bool? status;
  String? message;
  Data? data;

  GetProfileModel({this.status, this.message, this.data});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? fullName;
  String? firstName;
  String? lastName;
  String? email;
  String? profilePhoto;
  String? staffId;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? address;
  String? dateOfBirthFormatted;
  String? maritalStatus;
  String? bloodGrp;
  String? skypeId;
  String? fbId;
  String? twitterId;
  String? linkedInId;
  String? whatsappId;
  Department? department;
  Designation? designation;
  Company? company;
  OfficeShift? officeShift;
  String? locationId;
  int? isActive;
  String? joiningDate;

  Data(
      {this.id,
        this.fullName,
        this.firstName,
        this.lastName,
        this.email,
        this.profilePhoto,
        this.staffId,
        this.phone,
        this.gender,
        this.dateOfBirth,
        this.address,
        this.dateOfBirthFormatted,
        this.maritalStatus,
        this.bloodGrp,
        this.skypeId,
        this.fbId,
        this.twitterId,
        this.linkedInId,
        this.whatsappId,
        this.department,
        this.designation,
        this.company,
        this.officeShift,
        this.locationId,
        this.isActive,
        this.joiningDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profilePhoto = json['profile_photo'];
    staffId = json['staff_id'];
    phone = json['phone'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    address = json['address'];
    dateOfBirthFormatted = json['date_of_birth_formatted'];
    maritalStatus = json['marital_status'];
    bloodGrp = json['blood_grp'];
    skypeId = json['skype_id'];
    fbId = json['fb_id'];
    twitterId = json['twitter_id'];
    linkedInId = json['linkedIn_id'];
    whatsappId = json['whatsapp_id'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    designation = json['designation'] != null
        ? new Designation.fromJson(json['designation'])
        : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    officeShift = json['office_shift'] != null
        ? new OfficeShift.fromJson(json['office_shift'])
        : null;
    locationId = json['location_id'];
    isActive = json['is_active'];
    joiningDate = json['joining_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['full_name'] = this.fullName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['profile_photo'] = this.profilePhoto;
    data['staff_id'] = this.staffId;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['date_of_birth_formatted'] = this.dateOfBirthFormatted;
    data['marital_status'] = this.maritalStatus;
    data['blood_grp'] = this.bloodGrp;
    data['skype_id'] = this.skypeId;
    data['fb_id'] = this.fbId;
    data['twitter_id'] = this.twitterId;
    data['linkedIn_id'] = this.linkedInId;
    data['whatsapp_id'] = this.whatsappId;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.designation != null) {
      data['designation'] = this.designation!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    if (this.officeShift != null) {
      data['office_shift'] = this.officeShift!.toJson();
    }
    data['location_id'] = this.locationId;
    data['is_active'] = this.isActive;
    data['joining_date'] = this.joiningDate;
    return data;
  }
}

class Department {
  int? id;
  String? departmentName;

  Department({this.id, this.departmentName});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentName = json['department_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['department_name'] = this.departmentName;
    return data;
  }
}

class Designation {
  int? id;
  String? designationName;

  Designation({this.id, this.designationName});

  Designation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designationName = json['designation_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['designation_name'] = this.designationName;
    return data;
  }
}

class Company {
  int? id;
  String? companyName;

  Company({this.id, this.companyName});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    return data;
  }
}

class OfficeShift {
  int? id;
  String? shiftName;

  OfficeShift({this.id, this.shiftName});

  OfficeShift.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shiftName = json['shift_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shift_name'] = this.shiftName;
    return data;
  }
}
