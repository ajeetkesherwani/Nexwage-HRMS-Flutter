class ExperienceGetAllDataModel {
  bool? status;
  List<Data>? data;

  ExperienceGetAllDataModel({this.status, this.data});

  ExperienceGetAllDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? employeeId;
  String? companyName;
  String? fromYear;
  String? toYear;
  String? post;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? remark;
  String? attachment;

  Data(
      {this.id,
        this.employeeId,
        this.companyName,
        this.fromYear,
        this.toYear,
        this.post,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.remark,
        this.attachment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    companyName = json['company_name'];
    fromYear = json['from_year'];
    toYear = json['to_year'];
    post = json['post'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    remark = json['remark'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['company_name'] = this.companyName;
    data['from_year'] = this.fromYear;
    data['to_year'] = this.toYear;
    data['post'] = this.post;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['remark'] = this.remark;
    data['attachment'] = this.attachment;
    return data;
  }
}
