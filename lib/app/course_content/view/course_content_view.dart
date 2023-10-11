import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

import '../../course_content_drawer/view/course_content_drawer.dart';
import '../../course_details/view/home_work_videos_view.dart';
import '../../course_details/view/lessons_view.dart';
import '../../course_details/view/pdf_activity_view.dart';
import '../../course_details/view/quiz_videos_view.dart';
import '../../course_details/view/quiz_view.dart';
import '../../course_details/view/summery.dart';
import '../view_model/course_content_view_model.dart';

// ignore: must_be_immutable
class CourseContentView extends StatelessWidget {
  String courseTitle;
  String courseId;

  CourseContentView({
    Key? key,
    required this.courseTitle,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseContentViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.incCourseView(
          courseId: courseId,
        );
        await viewModel.getUserRole();
      },
      builder: (context, viewModel, child) {
        return viewModel.userRole == ''
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                ),
              )
            : DefaultTabController(
                length: 6,
                child: Scaffold(
                  backgroundColor: mainColor,
                  drawer: CourseContentDrawerView(
                    id: courseId,
                  ),
                  appBar: AppBar(
                    title: appBarTitle(courseTitle),
                    elevation: 0,
                    centerTitle: true,
                    backgroundColor: mainColor,
                    bottom: TabBar(
                      isScrollable: true,
                      indicator: const BoxDecoration(
                        color: backgroundColor,
                      ),
                      automaticIndicatorColorAdjustment: true,
                      unselectedLabelColor: whiteColor,
                      labelColor: mainColor,
                      indicatorColor: whiteColor,
                      tabs: [
                        Tab(text: tr('lecture_videos')),
                        Tab(text: tr('summary_videos')),
                        Tab(text: tr('Quizzes_and_assignments')),
                        Tab(text: tr('Test_videos_and_assignments')),
                        ///contain pdf
                        Tab(text: "pdf"),
                        Tab(text: tr('pdf_videos')),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      LectureVideos(
                        courseId: courseId,
                      ),
                      SummaryVideosView(
                        courseId: courseId,
                      ),
                      QuizView(
                        courseId: courseId,
                      ),
                      QuizVideosView(
                        courseId: courseId,
                      ),
                      ///contain pdf
                      PdfActivityView(
                        courseId: courseId,
                      ),
                      HomeWorkVideosView(
                        courseId: courseId,
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
