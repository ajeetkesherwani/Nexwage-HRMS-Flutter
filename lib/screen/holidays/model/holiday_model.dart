class HolidayModel {
  bool? status;
  String? message;
  Data? data;

  HolidayModel({this.status, this.message, this.data});

  HolidayModel.fromJson(Map<String, dynamic> json) {
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
  List<Past>? past;
  List<Upcoming>? upcoming;

  Data({this.past, this.upcoming});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['past'] != null) {
      past = <Past>[];
      json['past'].forEach((v) {
        past!.add(new Past.fromJson(v));
      });
    }
    if (json['upcoming'] != null) {
      upcoming = <Upcoming>[];
      json['upcoming'].forEach((v) {
        upcoming!.add(new Upcoming.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.past != null) {
      data['past'] = this.past!.map((v) => v.toJson()).toList();
    }
    if (this.upcoming != null) {
      data['upcoming'] = this.upcoming!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Past {
  String? holidayName;
  String? startDate;
  String? endDate;
  String? description;
  String? type;

  Past(
      {this.holidayName,
        this.startDate,
        this.endDate,
        this.description,
        this.type});

  Past.fromJson(Map<String, dynamic> json) {
    holidayName = json['holiday_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holiday_name'] = this.holidayName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}

class Upcoming {
  String? holidayName;
  String? startDate;
  String? endDate;
  String? description;
  String? type;

  Upcoming(
      {this.holidayName,
        this.startDate,
        this.endDate,
        this.description,
        this.type});

  Upcoming.fromJson(Map<String, dynamic> json) {
    holidayName = json['holiday_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holiday_name'] = this.holidayName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['type'] = this.type;
    return data;
  }
}
