class CourseDetailsModel {
  Data? data;

  CourseDetailsModel({this.data});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? courseid;
  String? coursename;
  String? free;
  String? requirements;
  String? forwhom;
  String? benefits;
  String? language;
  String? certificate;
  List<Null>? objectives;
  String? description;
  String? price;
  String? views;
  String? allenrolusers;
  int? activitiesCount;
  String? teacherId;
  String? teacherName;
  String? teacherBio;
  String? duration;
  String? promo;
  String? courseRate;
  String? teacherImage;
  String? enrol;
  String? assistant;
  List<Contents>? contents;

  Data(
      {this.courseid,
      this.coursename,
      this.free,
      this.requirements,
      this.forwhom,
      this.benefits,
      this.language,
      this.certificate,
      this.objectives,
      this.description,
      this.price,
      this.views,
      this.allenrolusers,
      this.activitiesCount,
      this.teacherId,
      this.teacherName,
      this.teacherBio,
      this.duration,
      this.promo,
      this.courseRate,
      this.teacherImage,
      this.enrol,
      this.assistant,
      this.contents});

  Data.fromJson(Map<String, dynamic> json) {
    courseid = json['courseid'] ?? 0;
    coursename = json['coursename'] ?? '';
    free = json['free'] ?? '';
    requirements = json['requirements'] ?? '';
    forwhom = json['forwhom'] ?? '';
    benefits = json['benefits'] ?? '';
    language = json['language'] ?? '';
    certificate = json['certificate'] ?? '';
    description = json['description'] ?? '';
    price = json['price'] ?? '';
    views = json['views'] ?? '';
    allenrolusers = json['allenrolusers'] ?? '';
    activitiesCount = json['activitiesCount'] ?? 0;
    teacherId = json['teacherId'] ?? '';
    teacherName = json['teacherName'] ?? '';
    teacherBio = json['teacherBio'] ?? '';
    duration = json['duration'] ?? '';
    promo = json['promo'] ?? '';
    courseRate = json['courseRate'] ?? '';
    teacherImage = json['teacherImage'] ?? '';
    enrol = json['enrol'] ?? '';
    assistant = json['assistant'] ?? '';
    if (json['contents'] != null) {
      contents = <Contents>[];
      json['contents'].forEach((v) {
        contents!.add(Contents.fromJson(v));
      });
    }
  }
}

class Contents {
  String? id;
  String? name;
  String? visible;
  String? summary;
  String? summaryformat;
  int? section;
  int? hiddenbynumsections;
  bool? uservisible;
  List<Modules>? modules;

  Contents(
      {this.id,
      this.name,
      this.visible,
      this.summary,
      this.summaryformat,
      this.section,
      this.hiddenbynumsections,
      this.uservisible,
      this.modules});

  Contents.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    visible = json['visible'] ?? '';
    summary = json['summary'] ?? '';
    summaryformat = json['summaryformat'] ?? '';
    section = json['section'] ?? 0;
    hiddenbynumsections = json['hiddenbynumsections'] ?? 0;
    uservisible = json['uservisible'] ?? false;
    if (json['modules'] != null) {
      modules = <Modules>[];
      json['modules'].forEach((v) {
        modules!.add(Modules.fromJson(v));
      });
    }
  }
}

class Modules {
  String? id;
  String? name;
  String? instance;
  String? modname;
  String? modplural;
  String? modicon;
  String? onclick;
  Null? afterlink;
  String? customdata;
  int? completion;
  bool? noviewlink;
  String? paid;
  bool? avail;
  String? quizType;
  String? resourceType;
  String? pageUrl;
  String? url;
  String? visible;
  int? visibleoncoursepage;
  bool? uservisible;
  String? availability;
  Completiondata? completiondata;
  String? availMessage;
  Contentsinfo? contentsinfo;
  List<ContentsCustom>? contents;

  Modules(
      {this.id,
      this.name,
      this.instance,
      this.modname,
      this.modplural,
      this.modicon,
      this.onclick,
      this.afterlink,
      this.customdata,
      this.noviewlink,
      this.paid,
      this.avail,
      this.quizType,
      this.resourceType,
      this.pageUrl,
      this.url,
      this.visible,
      this.visibleoncoursepage,
      this.uservisible,
      this.availability,
      this.completiondata,
      this.availMessage,
      this.contentsinfo,
      this.contents});

  Modules.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    instance = json['instance'] ?? '';
    modname = json['modname'] ?? '';
    modplural = json['modplural'] ?? '';
    modicon = json['modicon'] ?? '';
    onclick = json['onclick'] ?? '';
    afterlink = json['afterlink'];
    customdata = json['customdata'] ?? '';

    noviewlink = json['noviewlink'];
    paid = json['paid'] ?? '';
    avail = json['avail'];
    quizType = json['quiz_type'];
    resourceType = json['resource_type'];
    pageUrl = json['page_url'];
    url = json['url'];
    visible = json['visible'];
    visibleoncoursepage = json['visibleoncoursepage'];
    uservisible = json['uservisible'];
    availability = json['availability'];
    completiondata = json['completiondata'] != null
        ? Completiondata.fromJson(json['completiondata'])
        : null;
    availMessage = json['avail_message'];
    contentsinfo = json['contentsinfo'] != null
        ? Contentsinfo.fromJson(json['contentsinfo'])
        : null;
    if (json['contents'] != null) {
      contents = <ContentsCustom>[];
      json['contents'].forEach((v) {
        contents!.add(ContentsCustom.fromJson(v));
      });
    }
  }
}

class Completiondata {
  String? state;
  String? timecompleted;
  Null? overrideby;
  bool? valueused;

  Completiondata(
      {this.state, this.timecompleted, this.overrideby, this.valueused});

  Completiondata.fromJson(Map<String, dynamic> json) {
    // state = json['state'];
    // timecompleted = json['timecompleted'];
    // overrideby = json['overrideby'];
    // valueused = json['valueused'];
  }
}

class Contentsinfo {
  int? filescount;
  int? filessize;
  String? lastmodified;
  String? repositorytype;

  Contentsinfo(
      {required this.filescount,
      required this.filessize,
      required this.lastmodified,
      required this.repositorytype});

  factory Contentsinfo.fromJson(Map<String, dynamic> json) {
    return Contentsinfo(
      filescount: int.parse(json['filescount'].toString()),
      filessize: int.parse(json['filessize'].toString()),
      lastmodified: json['lastmodified'].toString(),
      repositorytype: json['repositorytype'].toString(),
    );
  }
}

class ContentsCustom {
  String? type;
  String? filename;
  String? filepath;
  String? filesize;
  String? fileurl;
  String? timecreated;
  String? timemodified;
  String? sortorder;
  String? userid;
  String? author;
  String? license;
  String? mimetype;
  bool? isexternalfile;

  ContentsCustom(
      {required this.type,
      required this.filename,
      required this.filepath,
      required this.filesize,
      required this.fileurl,
      required this.timecreated,
      required this.timemodified,
      required this.sortorder,
      required this.userid,
      required this.author,
      required this.license,
      required this.mimetype,
      required this.isexternalfile});

  factory ContentsCustom.fromJson(Map<String, dynamic> json) {
    return ContentsCustom(
      type: json['type'].toString(),
      filename: json['filename'].toString(),
      filepath: json['filepath'].toString(),
      filesize: json['filesize'].toString(),
      fileurl: json['fileurl'].toString(),
      timecreated: json['timecreated'].toString(),
      timemodified: json['timemodified'].toString(),
      sortorder: json['sortorder'].toString(),
      userid: json['userid'].toString(),
      author: json['author'].toString(),
      license: json['license'].toString(),
      mimetype: json['mimetype'].toString(),
      isexternalfile: json['isexternalfile'],
    );
  }
}
