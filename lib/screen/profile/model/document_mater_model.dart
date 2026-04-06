class DocumentMasterModel {
  bool status;
  String message;
  Data data;

  DocumentMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DocumentMasterModel.fromJson(Map<String, dynamic> json) {
    return DocumentMasterModel(
      status: json['status'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  List<DocumentType> documentTypes;
  List<Skill> skills;
  List<Language> languages;

  Data({
    required this.documentTypes,
    required this.skills,
    required this.languages,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      documentTypes: (json['document_types'] as List)
          .map((e) => DocumentType.fromJson(e))
          .toList(),
      skills: (json['skills'] as List)
          .map((e) => Skill.fromJson(e))
          .toList(),
      languages: (json['languages'] as List)
          .map((e) => Language.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document_types': documentTypes.map((e) => e.toJson()).toList(),
      'skills': skills.map((e) => e.toJson()).toList(),
      'languages': languages.map((e) => e.toJson()).toList(),
    };
  }
}

class DocumentType {
  int id;
  String name;

  DocumentType({
    required this.id,
    required this.name,
  });

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Skill {
  int id;
  String name;

  Skill({
    required this.id,
    required this.name,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Language {
  int id;
  String name;

  Language({
    required this.id,
    required this.name,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}