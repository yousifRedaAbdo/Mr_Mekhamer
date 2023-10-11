import 'package:mohamed_mekhemar/app/codes_info/model/codes_informaion_model.dart';
import 'package:mohamed_mekhemar/base_view_model.dart';
import 'package:mohamed_mekhemar/enums/screen_state.dart';
import 'package:mohamed_mekhemar/locator.dart';
import 'package:mohamed_mekhemar/services/api_service.dart';
import 'package:mohamed_mekhemar/services/navigation_service.dart';
import 'package:mohamed_mekhemar/services/shared_pref_services.dart';
import 'package:mohamed_mekhemar/utils/strings.dart';

class CodesInformationViewModel extends BaseViewModel {
  var navigation = locator<NavigationService>();
  var pref = locator<SharedPrefServices>();
  var api = locator<ApiService>();
  List<Data> patches = [];
  bool isDataLoading = true;
  bool isError = false;

  String userRole = '';
  String token = '';

  getUserRole() async {
    userRole = await pref.getString(userType);
    setState(ViewState.Idle);
  }

  gatAllPatches({required String courseId}) async {
    token = await pref.getString(userToken);
    var data =
        await api.getCodesInformation(courseId: courseId, token: '$token');
    if (data != 'fail') {
      GetCodesInfoModel model = GetCodesInfoModel.fromJson(data);
      for (var i in model.data!) {
        patches.add(i);
      }
      isDataLoading = false;
      setState(ViewState.Idle);
    } else {
      isError = true;
      setState(ViewState.Idle);
    }
  }
}
