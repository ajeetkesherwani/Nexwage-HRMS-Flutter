class AppVersionModel {
  bool? status;
  String? message;
  Data? data;

  AppVersionModel({this.status, this.message, this.data});

  AppVersionModel.fromJson(Map<String, dynamic> json) {
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
  String? version;
  bool? forceUpdate;
  String? message;

  Data({this.version, this.forceUpdate, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    forceUpdate = json['force_update'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['version'] = this.version;
    data['force_update'] = this.forceUpdate;
    data['message'] = this.message;
    return data;
  }
}
