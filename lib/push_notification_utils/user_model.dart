import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mohamed_mekhemar/utils/strings.dart';

import '../services/shared_pref_services.dart';

class LoggedUser {
  final user_id;
  final last_name;
  final parent_mobile_number;
  final user_image_url;
  final user_name;
  final user_email;
  final mobile_number;
  final user_token;
  final locale;
  final log_in_state;
  final selected_lang;
  final is_first_open;
  final user_type;
  LoggedUser({
    required this.is_first_open,
    required this.last_name,
    required this.locale,
    required this.log_in_state,
    required this.mobile_number,
    required this.parent_mobile_number,
    required this.selected_lang,
    required this.user_email,
    required this.user_id,
    required this.user_image_url,
    required this.user_name,
    required this.user_token,
    required this.user_type,
  });
  static getFromShared() {
    var prefs = SharedPrefServices();
    prefs.init();

    return LoggedUser(
      is_first_open: prefs.getString(isFirstOpen),
      last_name: prefs.getString(userLastName),
      locale: prefs.getString(appLang),
      log_in_state: prefs.getString(logInState),
      mobile_number: prefs.getString(userMobileNumberOne),
      parent_mobile_number: prefs.getString(userMobileNumberTwo),
      selected_lang: prefs.getString(appLang),
      user_email: prefs.getString(userEmail),
      user_id: prefs.getString(userid),
      user_image_url: prefs.getString(userImageUrl),
      user_name: prefs.getString(userFirstName),
      user_token: prefs.getString(userToken),
      user_type: prefs.getString(userType),
    );
  }
}
