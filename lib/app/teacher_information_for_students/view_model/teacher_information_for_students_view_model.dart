import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/base_view_model.dart';
import 'package:mohamed_mekhemar/enums/screen_state.dart';
import 'package:mohamed_mekhemar/locator.dart';
import 'package:mohamed_mekhemar/services/api_service.dart';
import 'package:mohamed_mekhemar/services/navigation_service.dart';
import 'package:mohamed_mekhemar/services/shared_pref_services.dart';
import 'package:mohamed_mekhemar/utils/strings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../teacher_profile/model/teacher_data_model.dart';

class TeacherInformationForStudentsViewModel extends BaseViewModel {
  var apiServices = locator<ApiService>();
  var navigation = locator<NavigationService>();
  var pref = locator<SharedPrefServices>();
  final rateFormKey = GlobalKey<FormState>();
  TextEditingController feedBackController = TextEditingController();
  String token = '';
  String email = '';
  String firstName = '';
  String lastName = '';
  String centerName = '';
  String userImage = '';
  String bio = '';
  double rate = 0;
  bool dataState = false;
  List<Photos> photosList = [];
  List<Feedbacks> feedbacksList = [];
  List<Courses> coursesList = [];
  List<Videos> videosList = [];

  getToken() async {
    token = await pref.getString(userToken);
  }

  Future<void> launchTeacherUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch ';
    }
  }

  void launchTelegram() async {
    String url = teacherTelegramLink;
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  launchWhatsApp(String phone) async {
    var whatsappUrl = "whatsapp://send?phone=+20$phone";
    await canLaunchUrl(Uri.parse(whatsappUrl))
        ? launchUrl(Uri.parse(whatsappUrl))
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  getTeacherData(context, token) async {
    var data = await apiServices.getTeacherData(token: token);
    if (data == 'fail') {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: tr('process_fail'),
        desc: tr('unKnown_wrong'),
        btnCancelOnPress: () {},
      ).show();
    } else {
      TeacherDataModel teacherDataModel = TeacherDataModel.fromJson(data);
      print('teacherDataModel');
      print(teacherDataModel);
      bio = teacherDataModel.teacher.bio;
      rate = double.parse(teacherDataModel.teacher.rating);
      for (var i in teacherDataModel.teacher.courses) {
        coursesList.add(i);
      }
      for (var i in teacherDataModel.teacher.photos) {
        photosList.add(i);
      }
      for (var i in teacherDataModel.teacher.feedbacks) {
        feedbacksList.add(i);
      }
      for (var i in teacherDataModel.teacher.feedbacks) {
        feedbacksList.add(i);
      }
      for (var i in teacherDataModel.teacher.videos) {
        videosList.add(i);
      }
      dataState = true;
      setState(ViewState.Idle);
    }
  }

  FormFieldValidator<String>? feedBackValidator() {
    FormFieldValidator<String>? validator = (value) {
      if (value == null || value.isEmpty) {
        return tr('empty_feed_back');
      }
      return null;
    };
    return validator;
  }

  addFeedBackForOneCourse(
    context, {
    required String token,
    required String feedBackMessage,
    required String courseId,
  }) async {
    if (rateFormKey.currentState!.validate()) {
      var data = await apiServices.addFeedBackForOneCourse(
        token: token,
        feedBackMessage: feedBackMessage,
        courseId: courseId,
      );
      if (data == 'fail') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: tr('process_fail'),
          desc: tr('unKnown_wrong'),
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.SUCCES,
          animType: AnimType.BOTTOMSLIDE,
          title: tr('successful_process'),
          desc: tr('feed_back_add'),
          btnOkOnPress: () {
            setState(ViewState.Idle);
          },
        ).show();
      }
    }
  }

  addRating({
    required String token,
    required String rating,
  }) async {
    var data = await apiServices.addRating(
      token: token,
      rating: rating,
    );
  }
}
