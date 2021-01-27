import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moodmatch/models/user_api_response.dart';
import 'package:moodmatch/api.dart';
import 'package:moodmatch/push_notifications/push_notification_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;

  PushNotificationService(this._fcm);

  // If you want to test the push notification locally,
  // you need to get the token and input to the Firebase console
  // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
  Future initialise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String matcherUuid = '';

    // get token
    String token = await _fcm.getToken();

    // if no device id key found handle it as a new user
    if (!(prefs.containsKey('deviceId'))) {
      print('new');
      prefs.setString('deviceId', token);
      UserApiResponse userApiResponse = await Api.newUser(token);
      if (userApiResponse.status == 'ok') {
        matcherUuid = userApiResponse.matcherUuid;
        prefs.setString('matcherUuid', matcherUuid);
        prefs.setInt('matchId', 0);
      } else {
        throw (Api.latestError);
      }
    }

    // check for token refresh if refreshed update shared pref and DB
    _fcm.onTokenRefresh.listen((newToken) async {
      // check if pref token is same as new token
      if (!(prefs.getString('deviceId') == newToken)) {
        print('refresh');
        prefs.setString('deviceId', newToken);
        bool success =
            await Api.updateDeviceId(newToken, prefs.getString('matcherUuid'));
        if (!success) {
          throw (Api.latestError);
        }
      }
    });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
//        showDialog(
//          context: context,
//          builder: (context) => AlertDialog(
//            content: ListTile(
//              title: Text(message['notification']['title']),
//              subtitle: Text(message['notification']['body']),
//            ),
//            actions: <Widget>[
//              FlatButton(
//                child: Text('Ok'),
//                onPressed: () => Navigator.of(context).pop(),
//              ),
//            ],
//          ),
//        );
        var notification = PushNotificationMessage(
          title: message['notification']['title'],
          body: message['notification']['body'],
        );

        // show notification UI here
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}
