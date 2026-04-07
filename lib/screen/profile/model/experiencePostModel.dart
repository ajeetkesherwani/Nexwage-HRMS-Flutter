class ExperiencePostModel {
  bool? status;
  String? message;
  Data? data;

  ExperiencePostModel({this.status, this.message, this.data});

  ExperiencePostModel.fromJson(Map<String, dynamic> json) {
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
  String? companyName;
  int? employeeId;
  String? post;
  String? fromYear;
  String? toYear;
  String? description;
  String? remark;
  String? attachment;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.companyName,
        this.employeeId,
        this.post,
        this.fromYear,
        this.toYear,
        this.description,
        this.remark,
        this.attachment,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    employeeId = json['employee_id'];
    post = json['post'];
    fromYear = json['from_year'];
    toYear = json['to_year'];
    description = json['description'];
    remark = json['remark'];
    attachment = json['attachment'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_name'] = this.companyName;
    data['employee_id'] = this.employeeId;
    data['post'] = this.post;
    data['from_year'] = this.fromYear;
    data['to_year'] = this.toYear;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['attachment'] = this.attachment;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
