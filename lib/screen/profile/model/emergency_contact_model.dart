class EmergencyContactModel {
  bool? status;
  String? message;
  Data? data;

  EmergencyContactModel({this.status, this.message, this.data});

  EmergencyContactModel.fromJson(Map<String, dynamic> json) {
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
  String? relation;
  String? contactName;
  String? personalPhone;
  String? personalEmail;
  int? employeeId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.relation,
        this.contactName,
        this.personalPhone,
        this.personalEmail,
        this.employeeId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    relation = json['relation'];
    contactName = json['contact_name'];
    personalPhone = json['personal_phone'];
    personalEmail = json['personal_email'];
    employeeId = json['employee_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relation'] = this.relation;
    data['contact_name'] = this.contactName;
    data['personal_phone'] = this.personalPhone;
    data['personal_email'] = this.personalEmail;
    data['employee_id'] = this.employeeId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
