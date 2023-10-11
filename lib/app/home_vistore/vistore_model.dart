class VistorModel {
  List<Data>? data = [];

  VistorModel({this.data});

  VistorModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
 late int? id;
 late String? videourl;

  Data({this.id, this.videourl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videourl = json['videourl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['videourl'] = this.videourl;
    return data;
  }
}
