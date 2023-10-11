import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/course_content/view_model/course_content_view_model.dart';
import 'package:mohamed_mekhemar/app/course_details/widgets/hidden_content.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/comman_widgets/loading_indecator.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';

import '../../../utils/texts.dart';
import '../widgets/content_card.dart';

class QuizView extends StatelessWidget {
  String courseId;

  QuizView({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('courseId = $courseId');

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
                : viewModel.quizList.isEmpty
                    ? Center(
                        child: mediumText(tr('no_data')),
                      )
                    : ListView.builder(
                        itemCount: viewModel.quizList.length,
                        itemBuilder: (context, index) {
                          return viewModel.quizList[index].uservisible == true
                              ? contentCard(
                                  context: context,
                                  image: 'assets/icons/icons_lesson.png',
                                  text: viewModel.quizList[index].name!,
                                  url: '${viewModel.quizList[index].url}',
                                  token: viewModel.token,
                                  activityId: viewModel.quizList[index].id!,
                                  courseId: courseId,
                                )
                              : hiddenContent(
                                  context: context,
                                  image: 'assets/icons/icons_lesson.png',
                                  text: viewModel.quizList[index].name!,
                                  activityId: viewModel.quizList[index].id!,
                                  courseId: courseId,
                                  availMessages: viewModel
                                              .quizList[index].availMessage ==
                                          null
                                      ? ''
                                      : viewModel.quizList[index].availMessage!,
                                  viewModel: viewModel,
                                  element: viewModel.quizList[index],
                                );
                        },
                      ),
          ),
        );
      },
    );
  }
}
