import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/course_content/view_model/course_content_view_model.dart';
import 'package:mohamed_mekhemar/app/course_details/widgets/content_card.dart';
import 'package:mohamed_mekhemar/app/course_details/widgets/hidden_content.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/comman_widgets/loading_indecator.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

class QuizVideosView extends StatelessWidget {
  String courseId;

  QuizVideosView({
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
                : viewModel.quizVideos.isEmpty
                    ? Center(
                        child: mediumText(tr('no_data')),
                      )
                    : ListView.builder(
                        itemCount: viewModel.quizVideos.length,
                        itemBuilder: (context, index) {
                          return viewModel.quizVideos[index].uservisible == true
                              ? contentCard(
                                  context: context,
                                  image: 'assets/icons/icons_video.png',
                                  text: viewModel.quizVideos[index].name!,
                                  url: '${viewModel.quizVideos[index].url}',
                                  token: viewModel.token,
                                  activityId: viewModel.quizVideos[index].id!,
                                  courseId: courseId,
                                )
                              : hiddenContent(
                                  context: context,
                                  image: 'assets/icons/icons_video.png',
                                  text: viewModel.quizVideos[index].name!,
                                  activityId: viewModel.quizVideos[index].id!,
                                  courseId: courseId,
                                  availMessages: viewModel
                                              .quizVideos[index].availMessage ==
                                          null
                                      ? ''
                                      : viewModel
                                          .quizVideos[index].availMessage!,
                                  viewModel: viewModel,
                                  element: viewModel.quizVideos[index],
                                );
                        },
                      ),
          ),
        );
      },
    );
  }
}
