class GetDocumentDataModel {
  bool? status;
  List<Data>? data;

  GetDocumentDataModel({this.status, this.data});

  GetDocumentDataModel.fromJson(Map<String, dynamic> json) {
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
  int? documentTypeId;
  String? documentTitle;
  String? description;
  String? documentFile;
  String? expiryDate;
  String? isNotify;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.employeeId,
        this.documentTypeId,
        this.documentTitle,
        this.description,
        this.documentFile,
        this.expiryDate,
        this.isNotify,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    documentTypeId = json['document_type_id'];
    documentTitle = json['document_title'];
    description = json['description'];
    documentFile = json['document_file'];
    expiryDate = json['expiry_date'];
    isNotify = json['is_notify'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['document_type_id'] = this.documentTypeId;
    data['document_title'] = this.documentTitle;
    data['description'] = this.description;
    data['document_file'] = this.documentFile;
    data['expiry_date'] = this.expiryDate;
    data['is_notify'] = this.isNotify;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
