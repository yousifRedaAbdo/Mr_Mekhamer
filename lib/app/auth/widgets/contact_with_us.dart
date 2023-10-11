import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';

import '../../../base_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/spaces.dart';
import '../../../utils/strings.dart';
import '../../../utils/texts.dart';
import '../../contact_us/view/contact_us_view.dart';
import '../../contact_us/view_model/contact_us_view_model.dart';
import '../view_model/auth_view_model.dart';

class ContactUsView extends StatelessWidget {
  String activityId;
  String courseId;
  String availMessages;

  ContactUsView({
    Key? key,
    required this.activityId,
    required this.courseId,
    required this.availMessages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<ContactUsViewModel>(
      onModelReady: (viewModel) {
        viewModel.getToken();
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
                title: appBarTitle(tr('contact')),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  contactWithUs(
                    context: context,
                    teacherNumber: teacherContactNumber,
                    techNumber: tecContactNumber,
                  ),
                  heightSpace(25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
