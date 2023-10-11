import 'package:flutter/material.dart';
import 'package:mohamed_mekhemar/utils/colors.dart';

Future<void> lodingDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          color: mainColor,
        ),
      );
    },
  );
}
