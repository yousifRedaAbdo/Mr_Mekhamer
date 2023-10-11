import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/course_members/widgets/course_members_card.dart';
import 'package:mohamed_mekhemar/app/course_members/widgets/course_members_search.dart';
import 'package:mohamed_mekhemar/app/course_members/widgets/student_count.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

import '../view_model/course_member_view_model.dart';

// ignore: must_be_immutable
class CourseMembersView extends StatelessWidget {
  String id;
  CourseMembersView(this.id, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<CourseMembersViewModel>(
      onModelReady: (viewModel) {
        viewModel.getMembers(courseId: id);
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: backgroundColor,
            elevation: 10,
            child: const Icon(
              Icons.download,
              color: mainColor,
            ),
            onPressed: () {
              viewModel.generateCourseMembersReportPDF
                  .generateReport(viewModel.searchList);
            },
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: mainColor,
            title: appBarTitle('course_members'.tr()),
            centerTitle: true,
          ),
          body: !viewModel.getData
              ? const Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                  ),
                )
              : Column(
                  children: [
                    courseMembersSearch(viewModel),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: backgroundColor,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            studentCount(
                                viewModel.searchList.length.toString()),
                            heightSpace(10),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: viewModel.searchList.length,
                                itemBuilder: (context, index) {
                                  return courseMembersCard(
                                    context: context,
                                    id: id,
                                    index: index,
                                    member: viewModel.searchList[index],
                                    viewModel: viewModel,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
