import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/contact_us/view_model/contact_us_view_model.dart';
import 'package:mohamed_mekhemar/base_screen.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/extensions.dart';
import 'package:mohamed_mekhemar/utils/spaces.dart';
import 'package:mohamed_mekhemar/utils/strings.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../auth/widgets/contact_with_us.dart';

Widget contactWithUs({
  required String techNumber,
  required String teacherNumber,
  context,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          mediumText(tr('tec_&_res'),color: Colors.black),
        ],
      ).onTap(() {
        launchWhatsApp(mobileNumber: techNumber);
      }),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          normalMainBlueText(
            techNumber,
          ),
          Image.asset(
            'assets/images/whats_app.png',
            height: 40,
            width: 40,
          ),
        ],
      ).onTap(() {
        launchWhatsApp(mobileNumber: techNumber);
      }),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          mediumText(
            tr('contact_center'),
            color: Colors.black
          ),
        ],
      ).onTap(() {
        launchWhatsApp(mobileNumber: teacherNumber);
      }),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          normalMainBlueText(
            teacherNumber,
          ),
          Image.asset(
            'assets/images/whats_app.png',
            height: 40,
            width: 40,
          ),
        ],
      ).onTap(() {
        launchWhatsApp(mobileNumber: teacherNumber);
      }),
    ],
  );
}

launchWhatsApp({
  required String mobileNumber,
}) async {
  final link = WhatsAppUnilink(
    phoneNumber: '002$mobileNumber',
  );
  await launch('$link');
}
