class QualificationGetDataModel {
  bool? status;
  List<Data>? data;

  QualificationGetDataModel({this.status, this.data});

  QualificationGetDataModel.fromJson(Map<String, dynamic> json) {
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
  int? educationLevelId;
  String? institutionName;
  String? fromYear;
  String? toYear;
  String? languageSkillId;
  String? generalSkillId;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? attachment;
  String? attachmentUrl;
  EducationLevel? educationLevel;

  Data(
      {this.id,
        this.employeeId,
        this.educationLevelId,
        this.institutionName,
        this.fromYear,
        this.toYear,
        this.languageSkillId,
        this.generalSkillId,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.attachment,
        this.attachmentUrl,
        this.educationLevel});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    educationLevelId = json['education_level_id'];
    institutionName = json['institution_name'];
    fromYear = json['from_year'];
    toYear = json['to_year'];
    languageSkillId = json['language_skill_id'];
    generalSkillId = json['general_skill_id'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    attachment = json['attachment'];
    attachmentUrl = json['attachment_url'];
    educationLevel = json['education_level'] != null
        ? new EducationLevel.fromJson(json['education_level'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['education_level_id'] = this.educationLevelId;
    data['institution_name'] = this.institutionName;
    data['from_year'] = this.fromYear;
    data['to_year'] = this.toYear;
    data['language_skill_id'] = this.languageSkillId;
    data['general_skill_id'] = this.generalSkillId;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['attachment'] = this.attachment;
    data['attachment_url'] = this.attachmentUrl;
    if (this.educationLevel != null) {
      data['education_level'] = this.educationLevel!.toJson();
    }
    return data;
  }
}

class EducationLevel {
  int? id;
  String? name;

  EducationLevel({this.id, this.name});

  EducationLevel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
