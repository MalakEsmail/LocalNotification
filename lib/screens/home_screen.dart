import 'package:flutter/material.dart';
import 'package:local_notification_pro/networking/notification_methods.dart';
import 'package:local_notification_pro/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstTime = true;
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstTime) {
      await NotificationMethods.init();
      listenNotification();
      if (mounted) {
        setState(() {
          firstTime = false;
        });
      }
    }
  }

  void listenNotification() {
    NotificationMethods.onNotifications.stream.listen(onClickNotification);
  }

  void onClickNotification(String? payload) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () async {
                await NotificationMethods.showNotification(
                    id: 13,
                    title: "Malak Esmail",
                    body: "hi from notification",
                    payLoad: "malak.abs");
              },
              child: Text(
                "Simple notification",
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () {},
              child:
                  Text("Scheduled notification", textAlign: TextAlign.center)),
          SizedBox(
            height: 30,
          ),
          TextButton(
              onPressed: () {},
              child: Text("Remove notification", textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
