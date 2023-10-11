import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/access_to_course/view/access_to_course_view.dart';
import 'package:mohamed_mekhemar/app/codes_info/view/codes_information_view.dart';
import 'package:mohamed_mekhemar/app/home/view/student_teacher_home.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/comman_widgets/drawer_card.dart';
import 'package:mohamed_mekhemar/routs/routs_names.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';

import '../../course_members/view/course_members_view.dart';
import '../../reports/reports/view/reports_view.dart';
import '../view_model/course_content_drawer_view_model.dart';

class CourseContentDrawerView extends StatelessWidget {
  String id;
  // String forumUrl;
  // bool isForumListEmpty;

  CourseContentDrawerView({
    Key? key,
    required this.id,
    // required this.forumUrl,
    // required this.isForumListEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseContentDrawerViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        viewModel.getUserRole();
      },
      builder: (context, viewModel, child) {
        return Drawer(
            backgroundColor: mainColor,
            child: viewModel.userRole == ''
                ? const Center(
                    child: CircularProgressIndicator(
                      color: whiteColor,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        heightSpace(50),
                        drawerCard(
                          text: tr('home'),
                        ).onTap(() {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StudentTeacherHomeView()),
                              (Route<dynamic> route) => false);
                        }),
                        heightSpace(10),
                        viewModel.userRole == 'teacher'
                            ? drawerCard(
                                text: 'course_members'.tr(),
                              ).onTap(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CourseMembersView(id),
                                    ),
                                  );
                                },
                              )
                            : Container(),
                        heightSpace(10),
                        viewModel.userRole == 'teacher'
                            ? drawerCard(
                                text: tr('access_by'),
                              ).onTap(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AccessToCourseReportView(id),
                                  ),
                                );
                              })
                            : Container(),
                        heightSpace(10),
                        viewModel.userRole == 'teacher'
                            ? drawerCard(
                                text: 'code_info'.tr(),
                              ).onTap(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CodesInformation(id),
                                  ),
                                );
                              })
                            : Container(),
                        heightSpace(10),
                        viewModel.userRole == 'teacher'
                            ? drawerCard(
                                text: 'reports'.tr(),
                              ).onTap(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportsView(id),
                                  ),
                                );
                              })
                            : Container(),
                        heightSpace(10),
                        viewModel.userRole == 'teacher'
                            ? drawerCard(
                                text: 'create_user'.tr(),
                              ).onTap(
                                () {
                                  viewModel.navigation
                                      .navigateTo(RouteName.signUp);
                                },
                              )
                            : Container(),
                      ],
                    ),
                  ));
      },
    );
  }
}
