import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/spaces.dart';
import '../utils/texts.dart';

Widget drawerCard({
  required String text,
}) {
  return Card(
    child: Container(
      height: 55,
      color: mainColorWithOpacity,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            color: grey,
            width: 15,
            height: 55,
          ),
          widthSpace(10),
          title(text, color: whiteColor)
        ],
      ),
    ),
  );
}
