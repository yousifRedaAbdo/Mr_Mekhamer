import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/app/teacher_profile/view/edit_image_view.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';
import 'package:mohamed_mekhemar/utils/texts.dart';

import '../view_modl/teacher_profile_view_model.dart';

ElevatedButton addPhotosButton(
    BuildContext context, TeacherProfileViewModel viewModel) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: mainColor,
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditImageView(),
        ),
      );
    },
    child: roundedButtonText(tr('edit_image')),
  );
}
