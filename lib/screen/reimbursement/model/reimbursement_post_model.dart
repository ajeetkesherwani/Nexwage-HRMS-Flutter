class ReimbursementPostModel {
  bool? status;
  String? message;
  Data? data;

  ReimbursementPostModel({this.status, this.message, this.data});

  ReimbursementPostModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryId;
  String? amount;
  String? description;
  String? startDate;
  String? endDate;
  int? companyId;
  int? employeeId;
  String? status;
  String? receiptFile;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.categoryId,
        this.amount,
        this.description,
        this.startDate,
        this.endDate,
        this.companyId,
        this.employeeId,
        this.status,
        this.receiptFile,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    amount = json['amount'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    companyId = json['company_id'];
    employeeId = json['employee_id'];
    status = json['status'];
    receiptFile = json['receipt_file'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['company_id'] = this.companyId;
    data['employee_id'] = this.employeeId;
    data['status'] = this.status;
    data['receipt_file'] = this.receiptFile;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
