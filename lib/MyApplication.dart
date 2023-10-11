import 'package:flutter/material.dart';

class myApplication {
  // static Future<bool> checkInternet() async {
  //   var result = await Connectivity().checkConnectivity();
  //   if (result == ConnectivityResult.mobile ||
  //       result == ConnectivityResult.wifi) {
  //     final flag = true;
  //     return flag;
  //   } else {
  //     final flag = false;
  //     return flag;
  //   }
  // }

  // static double hightClc(BuildContext context, int myHeight) {
  //   return MediaQuery.of(context).size.height * myHeight / 812;
  // }
  //
  // static double widthClc(BuildContext context, int myWidth) {
  //   return MediaQuery.of(context).size.width * myWidth / 375;
  // }

   navigateTo(Widget page, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => page)));
  }

   navigateToRemove(BuildContext context, Widget widget, {data}) =>
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (Route<dynamic> route) => false,
      );

   navigateToReplace(Widget page, BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => page)));
  }

  //  showToast({
  //   required String text,
  //   required color,
  // }) {
  //   Fluttertoast.showToast(
  //     msg: text,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     backgroundColor: color,
  //     textColor: Colors.white,
  //     fontSize: 16,
  //   );
   }

