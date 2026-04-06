class EmergencyGetByIdUpdateModel {
  bool? status;
  String? message;
  Data? data;

  EmergencyGetByIdUpdateModel({this.status, this.message, this.data});

  EmergencyGetByIdUpdateModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  String? relation;
  int? isPrimary;
  int? isDependent;
  String? contactName;
  String? workPhone;
  String? workPhoneExt;
  String? personalPhone;
  String? homePhone;
  String? workEmail;
  String? personalEmail;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? zip;
  int? countryId;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.employeeId,
        this.relation,
        this.isPrimary,
        this.isDependent,
        this.contactName,
        this.workPhone,
        this.workPhoneExt,
        this.personalPhone,
        this.homePhone,
        this.workEmail,
        this.personalEmail,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.zip,
        this.countryId,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    relation = json['relation'];
    isPrimary = json['is_primary'];
    isDependent = json['is_dependent'];
    contactName = json['contact_name'];
    workPhone = json['work_phone'];
    workPhoneExt = json['work_phone_ext'];
    personalPhone = json['personal_phone'];
    homePhone = json['home_phone'];
    workEmail = json['work_email'];
    personalEmail = json['personal_email'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    countryId = json['country_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['relation'] = this.relation;
    data['is_primary'] = this.isPrimary;
    data['is_dependent'] = this.isDependent;
    data['contact_name'] = this.contactName;
    data['work_phone'] = this.workPhone;
    data['work_phone_ext'] = this.workPhoneExt;
    data['personal_phone'] = this.personalPhone;
    data['home_phone'] = this.homePhone;
    data['work_email'] = this.workEmail;
    data['personal_email'] = this.personalEmail;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['country_id'] = this.countryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
