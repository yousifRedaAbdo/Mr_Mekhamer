import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/course_content/view_model/course_content_view_model.dart';
import 'package:mohamed_mekhemar/app/course_details/model/course_details_model.dart';
import 'package:mohamed_mekhemar/app/course_details/widgets/lesson_restriction_dialog.dart';
import 'package:mohamed_mekhemar/app/course_details/widgets/restriction_dialog.dart';
import 'package:mohamed_mekhemar/app/web_view/view/web_view.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

Widget hiddenContent({
  context,
  required CourseContentViewModel viewModel,
  required Modules element,
  required String image,
  required String text,
  required String activityId,
  required String courseId,
  required String availMessages,
}) {
  /// split , with \n to move to next line
  var updateAvailMessages = availMessages.replaceAll(',', '\n').toString();
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: mainColor,
    ),
    child: Row(
      children: [
        Image.asset(
          image,
          height: 35,
        ),
        widthSpace(20),
        Flexible(child: mediumText(text, color: grey)),
      ],
    ),
  ).onTap(
    () async {
      if (element.availMessage!.contains('week')) {
        await lessonsRestrictionDialog(
          context: context,
          description:
              element.availMessage == null ? '' : element.availMessage!,
          activityId: element.id!,
          courseId: courseId,
        ).then(
          (value) async {
            print(value);
            if (value == false) {
               Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => AppWebView(
                    '${element.url}&token=${viewModel.token}',
                    element.name,
                  ),
                ),
              )..then((value) async {
                viewModel.isCourseLoaded = false;
                viewModel.updateState();
                viewModel.lessonsList = [];
                await viewModel.getToken();
                viewModel.getCourseContentLists(
                  courseId: courseId,
                  token: viewModel.token,
                );
              });
            } else if (value == true) {
              viewModel.isCourseLoaded = false;
              viewModel.updateState();
              viewModel.lessonsList = [];
              await viewModel.getToken();
              viewModel.getCourseContentLists(
                courseId: courseId,
                token: viewModel.token,
              );
            }
          },
        );
      } else {
        restrictionDialog(context, updateAvailMessages);
      }
    },
  );
}
