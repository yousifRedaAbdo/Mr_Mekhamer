import 'package:mohamed_mekhemar/push_notification_utils/sharedPreferenceKeys.dart';
import 'package:mohamed_mekhemar/utils/strings.dart';

import '../services/shared_pref_services.dart';
import 'notification_model.dart';
import 'notification_service.dart';

/*
* this function is used to fire when the app want to make a notification
 */

@pragma('vm:entry-point')
void alarmMAngerFunction() async {
  int oldNotificationsCount = getOldNotificationsCount();
  try {
    int? newNotificationsCount = await getNotificationsCountAndSaveIt();

    if (newNotificationsCount != null) {
      saveToFirebase(newNotificationsCount > oldNotificationsCount);
      if (newNotificationsCount > oldNotificationsCount) {
        showNotificationWithoutSave();
      } else {


      }
    } else {

      // failed to get them
    }
  } catch (e) {}
}

void saveToFirebase(bool displayed) {

}

int getOldNotificationsCount() {
  var prefs = SharedPrefServices();
  prefs.init();
  final numOfNotfs = prefs.getString(
    SharedPreferenceKeys.numberOfNotifications,
    defaultValue: "0",
  );

  return int.parse(numOfNotfs);
}

Future<int?> getNotificationsCountAndSaveIt() async {
  var prefs = SharedPrefServices();
  NotificationsModel notificationsModel;
  prefs.init();
  final token = prefs.getString(userToken);

  if (token.isNotEmpty) {
    final response = await NotificationService().getUserNotifications(
      token: token,
    );

    if (response != "fail") {
      notificationsModel = NotificationsModel.fromJson(response);

      /// last notification displayed
      prefs.saveString(
        SharedPreferenceKeys.lastNotificationdisplayed,
        DateTime.now().toString(),
      );

      ///   save number of notifications
      prefs.saveString(SharedPreferenceKeys.numberOfNotifications,
          notificationsModel.count.toString());

      return notificationsModel.count;
    }
  }
  return null;
}

/*
this function is responsiple for displaying notification
it firstly check the old saved number of notifications in the SharedPrefs
it check if the new number greater than or equal old number if its greater its displaying
a notification and saving the new number of notfs ,if the new is less than or equal it just save it
Mohammed monem
 */

showNotificationWithoutSave() async {
  final NotificationService _notificationService = NotificationService();
  await _notificationService.init();

  _notificationService.showNotification(
    "اشعار جديد ",
    "مرحب بك في أكاديمية التـفــــــوق",
  );
}

showNotification() async {
  final NotificationService _notificationService = NotificationService();
  await _notificationService.init();

  var prefs = SharedPrefServices();
  prefs.init();

  prefs.saveString(
    SharedPreferenceKeys.lastNotificationCheck,
    DateTime.now().toString(),
  );

  try {
    final token = prefs.getString(userToken);

    if (token.isNotEmpty) {
      final response = await NotificationService().getUserNotifications(
        token: token,
      );

      if (response != "fail") {
        NotificationsModel notificationsModel =
            NotificationsModel.fromJson(response);

        final numOfNotfs =
            prefs.getString(SharedPreferenceKeys.numberOfNotifications);

        int oldNotificationCount = int.parse(
          numOfNotfs == "" ? "0" : numOfNotfs,
        );

        if ((notificationsModel.count ?? 0) > (oldNotificationCount)) {
          _notificationService.showNotification(
            "اشعار جديد ${notificationsModel.count.toString()}لديك ",
            notificationsModel.data![0].contexturlname,
          );

          prefs.saveString(
            SharedPreferenceKeys.lastNotificationdisplayed,
            DateTime.now().toString(),
          );
        }
        prefs.saveString(SharedPreferenceKeys.numberOfNotifications,
            notificationsModel.count.toString());
      }
    } else {
      prefs.saveString(
        SharedPreferenceKeys.errorsInNotificationget,
        "api error failed to retrieve notifications",
      );
    }
  } catch (e) {
    prefs.saveString(
      SharedPreferenceKeys.errorsInNotificationget,
      e.toString(),
    );
    print(
      e.toString(),
    );
  }
}
