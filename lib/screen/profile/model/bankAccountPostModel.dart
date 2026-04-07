class BankAccountPostModel {
  bool? status;
  String? message;
  Data? data;

  BankAccountPostModel({this.status, this.message, this.data});

  BankAccountPostModel.fromJson(Map<String, dynamic> json) {
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
  int? employeeId;
  String? accountTitle;
  String? accountNumber;
  String? bankName;
  String? bankCode;
  String? bankBranch;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.employeeId,
        this.accountTitle,
        this.accountNumber,
        this.bankName,
        this.bankCode,
        this.bankBranch,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    accountTitle = json['account_title'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    bankBranch = json['bank_branch'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['account_title'] = this.accountTitle;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['bank_branch'] = this.bankBranch;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
