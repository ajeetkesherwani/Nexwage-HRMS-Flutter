class QualificationPostModel {
  bool? status;
  String? message;
  Data? data;

  QualificationPostModel({this.status, this.message, this.data});

  QualificationPostModel.fromJson(Map<String, dynamic> json) {
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
  String? institutionName;
  int? employeeId;
  String? educationLevelId;
  String? languageSkillId;
  String? generalSkillId;
  String? fromYear;
  String? toYear;
  String? description;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.institutionName,
        this.employeeId,
        this.educationLevelId,
        this.languageSkillId,
        this.generalSkillId,
        this.fromYear,
        this.toYear,
        this.description,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    institutionName = json['institution_name'];
    employeeId = json['employee_id'];
    educationLevelId = json['education_level_id'];
    languageSkillId = json['language_skill_id'];
    generalSkillId = json['general_skill_id'];
    fromYear = json['from_year'];
    toYear = json['to_year'];
    description = json['description'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['institution_name'] = this.institutionName;
    data['employee_id'] = this.employeeId;
    data['education_level_id'] = this.educationLevelId;
    data['language_skill_id'] = this.languageSkillId;
    data['general_skill_id'] = this.generalSkillId;
    data['from_year'] = this.fromYear;
    data['to_year'] = this.toYear;
    data['description'] = this.description;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
