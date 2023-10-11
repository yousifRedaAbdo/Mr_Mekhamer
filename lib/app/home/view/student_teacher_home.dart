import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/home_drawer/view/home_drawer.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/enums/screen_state.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

import '../../course_content/view/course_content_view.dart';
import '../../parent_home/widgets/exit_app_dialog.dart';
import '../view_model/student_teacher_view_model.dart';
import '../widgets/course_card.dart';
import '../widgets/hidden_course_card.dart';

class StudentTeacherHomeView extends StatefulWidget {
  StudentTeacherHomeView({Key? key}) : super(key: key);

  @override
  State<StudentTeacherHomeView> createState() => _StudentTeacherHomeViewState();
}

class _StudentTeacherHomeViewState extends State<StudentTeacherHomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<StudentTeacherHomeViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getUserToken();
        if (!mounted) return;
        viewModel.getCourse(context);
      },
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async {
            bool exit = await showDialog(
              context: context,
              builder: (context) {
                return const ExitAPPDialog();
              },
            );
            return Future.value(exit);
          },
          child: Scaffold(
            backgroundColor: backgroundColor,
            drawer: const HomeDrawerView(),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: mainColor,
              title: appBarTitle(tr('mr_name')),
              centerTitle: false,
            ),
            body: viewModel.state == ViewState.Busy
                ? const Center(
                    child: CircularProgressIndicator(
                      color: mainColor,
                    ),
                  )
                : viewModel.reservation == true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: viewModel.coursesList.isEmpty
                            ? noCoursesAvail()
                            : ListView.builder(
                                itemCount: viewModel.coursesList.length,
                                itemBuilder: (context, index) {
                                  return courseCard(
                                    context: context,
                                    model: viewModel.coursesList[index],
                                    viewModel: viewModel,
                                  ).onTap(
                                    () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CourseContentView(
                                            courseId: viewModel
                                                .coursesList[index].courseId!,
                                            courseTitle: viewModel
                                                .coursesList[index].courseName!,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: viewModel.hiddenCoursesList.isEmpty
                            ? noCoursesAvail()
                            : ListView.builder(
                                itemCount: viewModel.hiddenCoursesList.length,
                                itemBuilder: (context, index) {
                                  return hiddenCourseCard(
                                    viewModel,
                                    index,
                                  ).onTap(
                                    () async {
                                      await viewModel.enrollStudentToCourse(
                                        token: viewModel.token!,
                                        courseId: viewModel
                                            .hiddenCoursesList[index].courseId!,
                                      );
                                      if (viewModel
                                          .enrollStudentToCourseState) {
                                        if (!mounted) return;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CourseContentView(
                                              courseId: viewModel
                                                  .hiddenCoursesList[index]
                                                  .courseId!,
                                              courseTitle: viewModel
                                                  .hiddenCoursesList[index]
                                                  .courseName!,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                      ),
          ),
        );
      },
    );
  }
}
Center noCoursesAvail() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/graduation_ic.png',
          height: 120,
          width: 120,
          fit: BoxFit.fill,
        ),
        heightSpace(20),
        Text(
          tr('no_courses_yet'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}

