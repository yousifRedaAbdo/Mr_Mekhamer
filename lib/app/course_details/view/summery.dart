import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/course_content/view_model/course_content_view_model.dart';
import 'package:mohamed_mekhemar/app/course_details/widgets/content_card.dart';
import 'package:mohamed_mekhemar/app/course_details/widgets/hidden_content.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/comman_widgets/loading_indecator.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

class SummaryVideosView extends StatelessWidget {
  // List<Modules> homeWorkList;
  String courseId;

  SummaryVideosView({
    Key? key,
    // required this.homeWorkList,
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
                : viewModel.summaryVideosList.isEmpty
                    ? Center(
                        child: mediumText(tr('no_data')),
                      )
                    : ListView.builder(
                        itemCount: viewModel.summaryVideosList.length,
                        itemBuilder: (context, index) {
                          return viewModel
                                      .summaryVideosList[index].uservisible ==
                                  true
                              ? contentCard(
                                  context: context,
                                  image: 'assets/icons/icons_video.png',
                                  text:
                                      viewModel.summaryVideosList[index].name!,
                                  url:
                                      '${viewModel.summaryVideosList[index].url}',
                                  token: viewModel.token,
                                  activityId:
                                      viewModel.summaryVideosList[index].id!,
                                  courseId: courseId,
                                )
                              : hiddenContent(
                                  context: context,
                                  image: 'assets/icons/icons_video.png',
                                  text:
                                      viewModel.summaryVideosList[index].name!,
                                  activityId:
                                      viewModel.summaryVideosList[index].id!,
                                  courseId: courseId,
                                  availMessages: viewModel
                                              .summaryVideosList[index]
                                              .availMessage ==
                                          null
                                      ? ''
                                      : viewModel.summaryVideosList[index]
                                          .availMessage!,

                                  viewModel: viewModel,
                                  element: viewModel.summaryVideosList[index],
                                );
                        },
                      ),
          ),
        );
      },
    );
  }
}
