class NotificationsModel {
  List<Data>? data;
  int? count;

  NotificationsModel({this.data, this.count});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  String? id;
  String? useridfrom;
  String? useridto;
  String? subject;
  String? fullmessage;
  String? fullmessageformat;
  String? fullmessagehtml;
  String? smallmessage;
  String? component;
  String? eventtype;
  String? contexturl;
  String? contexturlname;
  String? timeread;
  String? timecreated;
  String? customdata;
  String? userimage;

  Data({
    this.id,
    this.useridfrom,
    this.useridto,
    this.subject,
    this.fullmessage,
    this.fullmessageformat,
    this.fullmessagehtml,
    this.smallmessage,
    this.component,
    this.eventtype,
    this.contexturl,
    this.contexturlname,
    this.timeread,
    this.timecreated,
    this.customdata,
    this.userimage,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    useridfrom = json['useridfrom'] ?? '';
    useridto = json['useridto'] ?? '';
    subject = json['subject'] ?? '';
    fullmessage = json['fullmessage'] ?? '';
    fullmessageformat = json['fullmessageformat'] ?? '';
    fullmessagehtml = json['fullmessagehtml'] ?? '';
    smallmessage = json['smallmessage'] ?? '';
    component = json['component'] ?? '';
    eventtype = json['eventtype'] ?? '';
    contexturl = json['contexturl'] ?? '';
    contexturlname = json['contexturlname'] ?? '';
    timeread = json['timeread'] ?? '';
    timecreated = json['timecreated'] ?? '';
    customdata = json['customdata'] ?? '';
    userimage = json['userimage'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['useridfrom'] = useridfrom;
    data['useridto'] = useridto;
    data['subject'] = subject;
    data['fullmessage'] = fullmessage;
    data['fullmessageformat'] = fullmessageformat;
    data['fullmessagehtml'] = fullmessagehtml;
    data['smallmessage'] = smallmessage;
    data['component'] = component;
    data['eventtype'] = eventtype;
    data['contexturl'] = contexturl;
    data['contexturlname'] = contexturlname;
    data['timeread'] = timeread;
    data['timecreated'] = timecreated;
    data['customdata'] = customdata;
    data['userimage'] = userimage;
    return data;
  }
}
