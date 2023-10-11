import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/course_details/model/course_details_model.dart';
import 'package:mohamed_mekhemar/app/course_details/model/pdf_model.dart'
    as pdf;
import 'package:mohamed_mekhemar/base_view_model.dart';
import 'package:mohamed_mekhemar/enums/screen_state.dart';
import 'package:mohamed_mekhemar/locator.dart';
import 'package:mohamed_mekhemar/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/shared_pref_services.dart';
import '../../../utils/strings.dart';
import '../../contact_us/model/check_code_model.dart';

class CourseContentViewModel extends BaseViewModel {
  var pref = locator<SharedPrefServices>();
  var apiServices = locator<ApiService>();
  final codeFormKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  String userRole = '';
  List<String> moduleIds = [];
  bool isCourseLoaded = true;
  bool isCodeValid = true;

  getUserRole() async {
    userRole = await pref.getString(userType);
    setState(ViewState.Idle);
  }

  List<Modules> quizList = [];
  List<Modules> lessonsList = [];
  List<Modules> quizVideos = [];
  List<Modules> homeWorkVideos = [];
  List<Modules> summaryVideosList = [];
  List<String> pdfLinksList = [];
  List<String> pdfLinksListAfter = [];
  List<String> pdfNameList = [];
  List<pdf.Modules> pdfList = [];

  String token = '';

  getToken() async {
    token = await pref.getString(userToken);
  }

  clearLists() {
    quizList.clear();
    lessonsList.clear();
    quizVideos.clear();
    homeWorkVideos.clear();
    summaryVideosList.clear();
    pdfLinksList.clear();
    pdfLinksListAfter.clear();
    pdfNameList.clear();
    pdfNameList.clear();
  }

  getCourseContentLists({
    required String courseId,
    required String token,
  }) async {
    var data =
        await apiServices.getCourseContent(courseId: courseId, token: token);
    if (data == 'fail') {
      print('error');
    } else {
      clearLists();
      CourseDetailsModel courseDetailsModel = CourseDetailsModel.fromJson(data);

      ///lessons
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;
        for (var element in x!) {
          if (element.modname == 'resource' &&
              element.resourceType == 'lesson') {
            lessonsList.add(element);
          }
        }
      }

      ///summary
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;
        for (var element in x!) {
          if (element.modname == 'resource' &&
              element.resourceType == 'summary') {
            summaryVideosList.add(element);
          }
        }
      }

      ///homework videos
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;
        for (var element in x!) {
          if (element.resourceType == 'homework') {
            homeWorkVideos.add(element);
          }
        }
      }

      ///quiz list
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;
        for (var element in x!) {
          if (element.quizType == 'quiz') {
            quizList.add(element);
          }
        }
      }

      ///quiz videos
      for (var i in courseDetailsModel.data!.contents!) {
        var x = i.modules;
        for (var element in x!) {
          if (element.resourceType == 'quiz' && element.modname == 'resource') {
            quizVideos.add(element);
          }
        }
      }
      isCourseLoaded = false;
    }
    setState(ViewState.Idle);
  }

  /// pdf
  getPdfUrl({
    required String courseId,
    required String token,
  }) async {
    var data =
        await apiServices.getCourseContent(courseId: courseId, token: token);
    if (data == 'fail') {
    } else {
      var courseDetailsModel = pdf.PDFModel.fromJson(data);
      for (var i = 0; i < courseDetailsModel.data!.contents!.length; i++) {
        for (var x in courseDetailsModel.data!.contents![i].modules!) {
          if (x.modname == 'testnew') {
            pdfList.add(x);
            if (x.forPDF != null) {
              pdfLinksList.add(x.forPDF![0].fileurl!);
              pdfNameList.add(x.forPDF![0].filename!);
            }
          }
        }
      }

      for (var element in pdfLinksList) {
        pdfLinksListAfter
            .add(element.replaceAll('?forcedownload=1', '?token=$token'));
      }

      setState(ViewState.Idle);
    }
  }

  /// lessons operations

  checkCode(
    context, {
    required String token,
    required String courseId,
    required String activityId,
    required String code,
  }) async {
    if (codeFormKey.currentState!.validate()) {
      var data = await apiServices.checkCode(
        token: token,
        courseId: courseId,
        activityId: activityId,
        code: code,
      );
      if (data == 'fail') {
        return 'fail';
      } else {
        CheckCodeModel checkCodeModel = CheckCodeModel.fromJson(data);
        if (checkCodeModel.status == 'success') {
          return 'success';
        } else if (checkCodeModel.status == 'fail') {
          return 'not valid code';
        }
      }
    }
  }

  FormFieldValidator<String>? codeValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('enter_code');
      }
      return null;
    };
    return validator;
  }

  launchWhatsApp(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=+20$phone";
    await canLaunchUrl(Uri.parse(whatsappUrl))
        ? launchUrl(Uri.parse(whatsappUrl))
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  updateState() {
    setState(ViewState.Idle);
  }

  incCourseView({
    required String courseId,
  }) async {
    var data = await apiServices.incCourseView(courseId: courseId);
    if (data == 'fail') {
      print('can not inc course view');
    }
    print(data);
  }
}
