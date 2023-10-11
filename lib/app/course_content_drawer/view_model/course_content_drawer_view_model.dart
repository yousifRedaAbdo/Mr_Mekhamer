

import 'package:mohamed_mekhemar/base_view_model.dart';
import 'package:mohamed_mekhemar/enums/screen_state.dart';
import 'package:mohamed_mekhemar/locator.dart';
import 'package:mohamed_mekhemar/services/navigation_service.dart';
import 'package:mohamed_mekhemar/services/shared_pref_services.dart';
import 'package:mohamed_mekhemar/utils/strings.dart';

class CourseContentDrawerViewModel extends BaseViewModel {
  var navigation = locator<NavigationService>();
  var pref = locator<SharedPrefServices>();

  String userRole = '';
  String token = '';

  getUserRole() async {
    userRole = await pref.getString(userType);
    setState(ViewState.Idle);
  }

  getToken() async {
    token = await pref.getString(userToken);
    setState(ViewState.Idle);
  }
}
