import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/reports/home_work_videos_report/view_model/home_work_videos_report_view_model.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

import 'home_work_videos_report_detail_view.dart';

class HomeWorkVideoReportView extends StatelessWidget {
  String courseId;

  HomeWorkVideoReportView(this.courseId);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeWorkVideoReportDetailsViewModel>(
      onModelReady: (viewModel) async {
        await viewModel.getToken();
        viewModel.getHomeWorkVideosReport(
            courseId: courseId, token: viewModel.token);
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
                  tr('pdf_videos'),
                ),
              ),
              body: viewModel.dataState == false
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : viewModel.homeWorkVideoList.isEmpty
                      ? Center(
                          child: mediumText(tr('no_data')),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            itemCount: viewModel.homeWorkVideoList.length,
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
                                        viewModel
                                            .homeWorkVideoList[index].name!,
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
                                          SeenAndUnseenView(
                                        viewModel
                                            .homeWorkVideoList[index].name!,
                                        courseId,
                                        viewModel
                                            .homeWorkVideoList[index].instance!,
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
        ;
      },
    );
  }
}
