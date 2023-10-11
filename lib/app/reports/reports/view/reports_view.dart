import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/reports/assignment_report/view/assignment_report_view.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

import '../../home_work_videos_report/view/home_work_videos_report_view.dart';
import '../../lessons_reports/view/lessons_reports_view.dart';
import '../../pdf_report/view/pdf_report_view.dart';
import '../../quiz_report/view/quiz_with_feedback_report_view.dart';
import '../../quiz_report/view/quiz_without_feedback_report_view.dart';
import '../../quiz_video_reports/view/quiz_video_report_view.dart';
import '../../revision_reports/view/revision_report_view.dart';
import '../../summary_reports/view/summary_reports_view.dart';
import '../view_model/reports_view_model.dart';

class ReportsView extends StatelessWidget {
  String courseId;

  ReportsView(this.courseId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ReportsViewModel>(
      onModelReady: (viewModel) {},
      builder: (context, viewModel, child) {
        return SafeArea(
          bottom: false,
          right: false,
          left: false,
          top: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: mainColor,
              elevation: 0,
              centerTitle: true,
              title: appBarTitle(tr('reports')),
            ),
            backgroundColor: backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                reportCard(tr('lecture_videos')).onTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LessonsReportsView(courseId),
                    ),
                  );
                }),
                reportCard(tr('summary_videos')).onTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SummaryReportsView(courseId),
                    ),
                  );
                }),

                ///
                ///
                ///
                ///pdf oly for this app


                reportCard(tr('Test_videos_and_assignments')).onTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizVideoReportView(courseId),
                    ),
                  );
                }),
                reportCard(tr('Quizzes_and_assignments')).onTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuizWithFeedbackReportView(courseId),
                    ),
                  );
                }),
                reportCard(tr('pdf')).onTap(
                      () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfReportView(courseId),
                      ),
                    );
                  },
                ),
                reportCard(tr('pdf_videos')).onTap(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeWorkVideoReportView(courseId),
                    ),
                  );
                }),

                ///
                ///
                ///
                /// not use in this app
                // reportCard(tr('revisions')).onTap(
                //   () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => RevisionReportView(courseId),
                //       ),
                //     );
                //   },
                // ),
                // reportCard(tr('assignments')).onTap(() {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => AssignmentReportView(
                //         courseId,
                //       ),
                //     ),
                //   );
                // }),
              ],
            ),
          ),
        );
      },
    );
  }

  Container reportCard(text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: mainColor,
      ),
      child: Center(child: mediumText(text, color: whiteColor)),
    );
  }
}
