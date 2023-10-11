import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/course_content/view_model/course_content_view_model.dart';
import 'package:mohamed_mekhemar/app/course_details/widgets/content_card.dart';
import 'package:mohamed_mekhemar/app/course_details/widgets/hidden_content.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/comman_widgets/loading_indecator.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

// ignore: must_be_immutable
class LectureVideos extends StatelessWidget {
  String courseId;

  LectureVideos({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseContentViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        await viewModel.getCourseContentLists(
          token: viewModel.token,
          courseId: courseId,
        );
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: viewModel.isCourseLoaded
                ? LoadingIndicator()
                : viewModel.lessonsList.isEmpty
                    ? Center(
                        child: mediumText(tr('no_data')),
                      )
                    : ListView.builder(
                        itemCount: viewModel.lessonsList.length,
                        itemBuilder: (context, index) {
                          return viewModel.lessonsList[index].uservisible ==
                                  true
                              ? contentCard(
                                  context: context,
                                  image: 'assets/icons/icons_video.png',
                                  text: viewModel.lessonsList[index].name!,
                                  url: '${viewModel.lessonsList[index].url}',
                                  token: viewModel.token,
                                  activityId: viewModel.lessonsList[index].id!,
                                  courseId: courseId,
                                )
                              : hiddenContent(
                                  context: context,
                                  image: 'assets/icons/icons_video.png',
                                  text: viewModel.lessonsList[index].name!,
                                  activityId: viewModel.lessonsList[index].id!,
                                  courseId: courseId,
                                  availMessages: viewModel.lessonsList[index]
                                              .availMessage ==
                                          null
                                      ? ''
                                      : viewModel
                                          .lessonsList[index].availMessage!,
                                  viewModel: viewModel,
                                  element: viewModel.lessonsList[index],
                                );
                        },
                      ),
          ),
        );
      },
    );
  }
}
