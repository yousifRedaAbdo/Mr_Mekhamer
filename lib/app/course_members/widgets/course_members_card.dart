import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/course_members/model/course_member_model.dart';
import 'package:mohamed_mekhemar/app/course_members/view_model/course_member_view_model.dart';
import 'package:mohamed_mekhemar/app/edit_profile_from_teacher/view/edit_profile_view_from_teacher.dart';

import 'package:mohamed_mekhemar/app/single_student_report/view/single_student_report_view.dart';
import 'package:mohamed_mekhemar/comman_widgets/inputField.dart';
import 'package:mohamed_mekhemar/enums/screen_state.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

Widget courseMembersCard({
  required BuildContext context,
  required String id,
  required int index,
  required Groupmember member,
  required CourseMembersViewModel viewModel,
}) {
  return Container(
    color: index.isEven ? mainColor : whiteColor,
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleStudentReportView(
              member.fullName,
              member.id,
              id,
            ),
          ),
        );
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          courseMemberText(
            '${tr('name')} : ${member.fullName}',
            index,
          ),
          courseMemberText(
            '${tr('email')} : ${member.email}',
            index,
          ),
          courseMemberText(
            '${tr('phone')}  ${member.phone}',
            index,
          ),
          courseMemberText(
            '${tr('center')} : ${member.centerName}',
            index,
          ),
          Wrap(
            children: [
              ElevatedButton(
                onPressed: () {
                  changePass(context, viewModel: viewModel, member: member);
                },
                child: Text(tr('set_password')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: index.isEven ? whiteColor : mainColor,
                  foregroundColor: index.isEven ? mainColor : whiteColor,
                ),
              ),
              widthSpace(20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditStudentProfileView(
                        member.token,
                      ),
                    ),
                  ).then((value) {
                    viewModel.getData = false;
                    viewModel.setState(ViewState.Busy);
                    viewModel.getMembers(courseId: id);
                  });
                },
                child: Text(tr('edit_profile')),
                style: ElevatedButton.styleFrom(
                  backgroundColor: index.isEven ? whiteColor : mainColor,
                  foregroundColor: index.isEven ? mainColor : whiteColor,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget courseMemberText(text, index, {double size = 14}) {
  return Text(
    text,
    style: TextStyle(
      color: index.isEven ? whiteColor : mainColor,
      fontSize: size,
      height: 1.5,
    ),
  );
}

Future<void> changePass(
  context, {
  required CourseMembersViewModel viewModel,
  required Groupmember member,
}) async {
  return showDialog<void>(
    context: context, barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(tr('set_password')),
        content: Form(
          key: viewModel.changePassKey,
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                InputField(
                  hint: tr('password'),
                  inputType: TextInputType.text,
                  controller: viewModel.setPasswordController,
                  icon: Icons.password,
                  validator: viewModel.passwordValidator(),
                )
              ],
            ),
          ),
        ),
        actions: [
          RoundedLoadingButton(
            elevation: 0,
            width: 100,
            color: mainColor,
            successColor: successfulColor,
            errorColor: errorColor,
            height: 40,
            controller: viewModel.btnController,
            onPressed: () {
              viewModel
                  .setNewPassword(
                token: member.token,
                password: viewModel.setPasswordController.text,
              )
                  .then((value) {
                if (value) {
                  viewModel.btnController.success();
                  Timer(Duration(seconds: 2), () {
                    viewModel.setPasswordController.clear();
                    Navigator.pop(context);
                  });
                } else {
                  viewModel.btnController.error();
                  Timer(Duration(seconds: 2), () {
                    viewModel.setPasswordController.clear();
                    Navigator.pop(context);
                  });
                }
              });
            },
            child: Text(tr('set')),
          ),
        ],
      );
    },
  );
}
