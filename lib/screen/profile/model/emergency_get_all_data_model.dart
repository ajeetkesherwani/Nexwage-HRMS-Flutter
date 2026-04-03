class EmergencyGetAllDataModel {
  bool? status;
  List<EmergencyContactData>? data;

  EmergencyGetAllDataModel({this.status, this.data});

  EmergencyGetAllDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <EmergencyContactData>[];
      json['data'].forEach((v) {
        data!.add(EmergencyContactData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['status'] = status;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class EmergencyContactData {
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

  EmergencyContactData({
    this.id,
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
    this.updatedAt,
  });

  EmergencyContactData.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['employee_id'] = employeeId;
    map['relation'] = relation;
    map['is_primary'] = isPrimary;
    map['is_dependent'] = isDependent;
    map['contact_name'] = contactName;
    map['work_phone'] = workPhone;
    map['work_phone_ext'] = workPhoneExt;
    map['personal_phone'] = personalPhone;
    map['home_phone'] = homePhone;
    map['work_email'] = workEmail;
    map['personal_email'] = personalEmail;
    map['address1'] = address1;
    map['address2'] = address2;
    map['city'] = city;
    map['state'] = state;
    map['zip'] = zip;
    map['country_id'] = countryId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}