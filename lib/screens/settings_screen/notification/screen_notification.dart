import 'package:flutter/material.dart';
import 'package:money_fi/screens/settings_screen/notification/notifi_service.dart';

// ignore: camel_case_types
class screennotification extends StatefulWidget {
  const screennotification({super.key});

  @override
  State<screennotification> createState() => _screennotificationState();
}

NotificationService notificationService = NotificationService();

// ignore: camel_case_types
class _screennotificationState extends State<screennotification> {
  @override
  void initState() {
    super.initState();
    notificationService.initializaionnotification();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(230, 72, 151, 148),
          centerTitle: true,
          title: const Text(
            "Notification",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: const Color.fromARGB(230, 72, 151, 148),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              notificationService.sendnotification("you just taped", "welcome");
            },
            child: const Text("send massege"),
          ),
        ),
      ),
    );
  }
}
