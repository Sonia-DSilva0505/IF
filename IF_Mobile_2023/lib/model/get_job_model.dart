class GetJob {
  String? message;
  List<Data>? data;

  GetJob({this.message, this.data});

  GetJob.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? role;
  String? company;
  String? logo;
  String? location;
  String? mode;
  int? stipend;
  String? duration;
  String? description;
  String? about;
  String? link;
  List<String>? requirement;
  String? deadline;
  int? v;

  Data(
      {this.id,
      this.role,
      this.company,
      this.logo,
      this.location,
      this.mode,
      this.stipend,
      this.duration,
      this.description,
      this.about,
      this.link,
      this.requirement,
      this.deadline,
      this.v});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    role = json['role'];
    company = json['company'];
    logo = json['logo'];
    location = json['location'];
    mode = json['mode'];
    stipend = json['stipend'];
    duration = json['duration'];
    description = json['description'];
    about = json['about'];
    link = json['link'];
    requirement = json['requirement'].cast<String>();
    deadline = json['deadline'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['role'] = role;
    data['company'] = company;
    data['logo'] = logo;
    data['location'] = location;
    data['mode'] = mode;
    data['stipend'] = stipend;
    data['duration'] = duration;
    data['description'] = description;
    data['about'] = about;
    data['link'] = link;
    data['requirement'] = requirement;
    data['deadline'] = deadline;
    data['__v'] = v;
    return data;
  }
}
