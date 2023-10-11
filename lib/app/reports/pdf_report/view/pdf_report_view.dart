import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/reports/pdf_report/view/paf_report_details_view.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';

import '../../../../utils/spaces.dart';
import '../../../../utils/texts.dart';
import '../view_model/pdf_report_view_model.dart';

class PdfReportView extends StatelessWidget {
  String courseId;

  PdfReportView(this.courseId);

  @override
  Widget build(BuildContext context) {
    return BaseView<PdfReportViewModel>(
      onModelReady: (viewModel) {
        viewModel.getAllPdf(courseId: courseId);
      },
      builder: (context, viewModel, child) {
        return Container(
          color: mainColor,
          child: SafeArea(
            top: false,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: mainColor,
                title: appBarTitle(tr('pdf')),
              ),
              body: viewModel.dataState == false
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    )
                  : viewModel.pdfList.isEmpty
                      ? Center(
                          child: mediumText(tr('no_data')),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView.builder(
                            itemCount: viewModel.pdfList.length,
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
                                      'assets/icons/icons_pdf.png',
                                      height: 35,
                                    ),
                                    widthSpace(20),
                                    Flexible(
                                      child: mediumText(
                                        viewModel.pdfList[index].name,
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
                                          PdfReportDetailsView(
                                        viewModel.pdfList[index].id,
                                        viewModel.pdfList[index].name,
                                       courseId,
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
