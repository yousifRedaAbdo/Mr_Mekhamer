import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/reports/quiz_video_reports/view/quiz_video_report_details_view.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

import '../view_model/quiz_video_report_view_model.dart';

class QuizVideoReportView extends StatelessWidget {
  String courseId;

  QuizVideoReportView(this.courseId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<QuizVideoReportViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        viewModel.getQuizVideos(courseId: courseId, token: viewModel.token);
      },
      builder: (context, viewModel, child) {
        return Container(
          color: mainColor,
          child: SafeArea(
            bottom: false,
            right: false,
            left: false,
            top: true,
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: mainColor,
                elevation: 0,
                centerTitle: true,
                title: appBarTitle(
                  tr('Test_videos_and_assignments'),
                ),
              ),
              body: viewModel.dataState == false
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : viewModel.quizVideos.isEmpty
                      ? Center(
                          child: mediumText(tr('no_data')),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            itemCount: viewModel.quizVideos.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: mainColor,
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/icons_video.png',
                                      height: 35,
                                    ),
                                    widthSpace(20),
                                    Flexible(
                                      child: mediumText(
                                        viewModel.quizVideos[index].name!,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ).onTap(
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QuizVideoReportDetailsView(
                                        viewModel.quizVideos[index].name!,
                                        courseId,
                                        viewModel.quizVideos[index].instance!,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
            ),
          ),
        );
      },
    );
  }
}
