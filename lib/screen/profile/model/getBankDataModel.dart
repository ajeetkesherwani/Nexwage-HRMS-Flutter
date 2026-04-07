class GetBankAccountModel {
  bool? status;
  Data? data;

  GetBankAccountModel({this.status, this.data});

  GetBankAccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? employeeId;
  String? accountTitle;
  String? accountNumber;
  String? bankName;
  String? bankCode;
  String? bankBranch;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.employeeId,
        this.accountTitle,
        this.accountNumber,
        this.bankName,
        this.bankCode,
        this.bankBranch,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    accountTitle = json['account_title'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    bankBranch = json['bank_branch'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['account_title'] = this.accountTitle;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['bank_branch'] = this.bankBranch;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
