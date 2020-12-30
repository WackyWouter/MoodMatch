import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          color: Colors.red,
          child: Text("send"),
          onPressed: () async {
            http.Response response = await createNotification();

            print(response.statusCode);
            print(response.body);
          },
        ),
      ),
    );
  }
}

Future<http.Response> createNotification() {
  String serverKey =
      'AAAA1Ribx88:APA91bG0wUJiecoh_t1D6GsKILWXHA8WjnrSoSdLXMr_dpx_Q6l3rIsUg9XbiubPPvpOxez5PMLi4CPt6rVN4AKppzAvtBU96E1jOerAC3x34mte1ARVZi0iod-IWYDM24wld6FG4F5Z';

  return http.post(
    'https://fcm.googleapis.com/fcm/send',
    headers: <String, String>{
      'Authorization': 'key=' + serverKey,
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      "to":
          "eMCKrFvZSNyoTaoN9J5Qik:APA91bG58zbQnk_MFSiC9JVDX2Sm1dL_EsnPfkL9At0ghCgxKfoBRBtYazDtswI1Sxh4boXG4OI1jp63Gxr06CGf9tMF0vM8ERzbH6Jqf8ISVEsIY_xxGcMcv-xZ1p790aminT_bzvG2",
      "collapse_key": "New Message",
      "priority": "high",
      "notification": {
        "title": "MoodMatch",
        "body": "Your partner is not in the mood. Test."
      },
      "data": {"click_action": "FLUTTER_NOTIFICATION_CLICK", "status": "done"}
    }),
  );
}
