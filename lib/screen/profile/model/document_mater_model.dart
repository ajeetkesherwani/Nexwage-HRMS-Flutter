class DocumentMasterModel {
  bool? status;
  String? message;
  Data? data;

  DocumentMasterModel({this.status, this.message, this.data});

  DocumentMasterModel.fromJson(Map<String, dynamic> json) {
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
  List<DocumentTypes>? documentTypes;
  List<Skills>? skills;
  List<Languages>? languages;
  List<QualificationEducationLevel>? qualificationEducationLevel;

  Data(
      {this.documentTypes,
        this.skills,
        this.languages,
        this.qualificationEducationLevel});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['document_types'] != null) {
      documentTypes = <DocumentTypes>[];
      json['document_types'].forEach((v) {
        documentTypes!.add(new DocumentTypes.fromJson(v));
      });
    }
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(new Skills.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
    if (json['qualification_education_level'] != null) {
      qualificationEducationLevel = <QualificationEducationLevel>[];
      json['qualification_education_level'].forEach((v) {
        qualificationEducationLevel!
            .add(new QualificationEducationLevel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documentTypes != null) {
      data['document_types'] =
          this.documentTypes!.map((v) => v.toJson()).toList();
    }
    if (this.skills != null) {
      data['skills'] = this.skills!.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    if (this.qualificationEducationLevel != null) {
      data['qualification_education_level'] =
          this.qualificationEducationLevel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocumentTypes {
  int? id;
  String? name;

  DocumentTypes({this.id, this.name});

  DocumentTypes.fromJson(Map<String, dynamic> json) {
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

class Skills {
  int? id;
  String? name;

  Skills({this.id, this.name});

  Skills.fromJson(Map<String, dynamic> json) {
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

class Languages {
  int? id;
  String? name;

  Languages({this.id, this.name});

  Languages.fromJson(Map<String, dynamic> json) {
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

class QualificationEducationLevel {
  int? id;
  String? name;

  QualificationEducationLevel({this.id, this.name});

  QualificationEducationLevel.fromJson(Map<String, dynamic> json) {
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
