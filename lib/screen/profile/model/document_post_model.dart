class DocumentPostModel {
  bool? status;
  String? message;
  Data? data;

  DocumentPostModel({this.status, this.message, this.data});

  DocumentPostModel.fromJson(Map<String, dynamic> json) {
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
  String? documentTitle;
  int? employeeId;
  String? documentTypeId;
  String? expiryDate;
  String? description;
  String? isNotify;
  String? documentFile;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.documentTitle,
        this.employeeId,
        this.documentTypeId,
        this.expiryDate,
        this.description,
        this.isNotify,
        this.documentFile,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    documentTitle = json['document_title'];
    employeeId = json['employee_id'];
    documentTypeId = json['document_type_id'];
    expiryDate = json['expiry_date'];
    description = json['description'];
    isNotify = json['is_notify'];
    documentFile = json['document_file'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_title'] = this.documentTitle;
    data['employee_id'] = this.employeeId;
    data['document_type_id'] = this.documentTypeId;
    data['expiry_date'] = this.expiryDate;
    data['description'] = this.description;
    data['is_notify'] = this.isNotify;
    data['document_file'] = this.documentFile;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
