import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class PushNotifications extends StatefulWidget {
  const PushNotifications({Key? key}) : super(key: key);

  @override
  State<PushNotifications> createState() => _PushNotificationsState();
}

class _PushNotificationsState extends State<PushNotifications> {
  @override
  void initState() {
    super.initState();
    initPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nodejs -Onesignal")),
      backgroundColor: Colors.grey[200],
      body: const Center(
        child: Text("Push Notifications"),
      ),
    );
  }

  Future<void> initPlatform() async {
    await OneSignal.shared.setAppId("0a075bcf-6425-4c41-9834-6fa9304050e0");

    //gives the device unique id. TODO: need to store it in Registeredusers collection
    await OneSignal.shared.getDeviceState().then(
        (value) => {print("here is the device ID:" + value!.userId.toString() ), print(value!.userId)});
  }
}
