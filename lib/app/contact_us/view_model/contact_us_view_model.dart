import 'package:mohamed_mekhemar/app/auth/view_model/auth_view_model.dart';
import 'package:mohamed_mekhemar/base_view_model.dart';
import 'package:mohamed_mekhemar/locator.dart';
import 'package:mohamed_mekhemar/services/api_service.dart';
import 'package:mohamed_mekhemar/services/shared_pref_services.dart';
import 'package:mohamed_mekhemar/utils/strings.dart';

class ContactUsViewModel extends BaseViewModel {
  AuthenticationViewModel authenticationViewModel = AuthenticationViewModel();
  ApiService apiService = locator<ApiService>();
  var pref = locator<SharedPrefServices>();
  String token = '';

  getToken() async {
    token = await pref.getString(userToken);
    print('token : $token');
  }
}
