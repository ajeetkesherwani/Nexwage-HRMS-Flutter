class GetReimbursementModel {
  bool? status;
  List<Data>? data;

  GetReimbursementModel({this.status, this.data});

  GetReimbursementModel.fromJson(Map<String, dynamic> json) {
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
  String? startDate;
  String? endDate;
  String? amount;
  String? description;
  String? receiptFile;
  String? status;
  int? categoryId;
  Category? category;

  Data(
      {this.id,
        this.startDate,
        this.endDate,
        this.amount,
        this.description,
        this.receiptFile,
        this.status,
        this.categoryId,
        this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    amount = json['amount'];
    description = json['description'];
    receiptFile = json['receipt_file'];
    status = json['status'];
    categoryId = json['category_id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['receipt_file'] = this.receiptFile;
    data['status'] = this.status;
    data['category_id'] = this.categoryId;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
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
