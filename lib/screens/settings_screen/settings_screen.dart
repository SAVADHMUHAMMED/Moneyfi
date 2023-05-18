import 'package:flutter/material.dart';
import 'package:money_fi/screens/settings_screen/notification/screen_notification.dart';
import 'package:money_fi/screens/settings_screen/terms%20and%20privacy/screen_terms_and_privacy.dart';
import '../../db/db_category/catergory_db.dart';
import '../../db/db_transaction/transaction_db.dart';
import 'about/screen_about.dart';
import 'feedback/screen_feedback.dart';

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(230, 72, 151, 148),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(230, 72, 151, 148),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const ScreenAbout()),
                    ),
                  );
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Color.fromARGB(230, 72, 151, 148),
                    ),
                    title: Text(
                      'About',
                      style:
                          TextStyle(color: Color.fromARGB(230, 72, 151, 148)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: ((context) => screennotification())),
                  );
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.notification_add,
                      color: Color.fromARGB(230, 72, 151, 148),
                    ),
                    title: Text(
                      'Notification',
                      style:
                          TextStyle(color: Color.fromARGB(230, 72, 151, 148)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // print('Feedback send');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScreenFeedback(),
                  ));
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.message,
                      color: Color.fromARGB(230, 72, 151, 148),
                    ),
                    title: Text(
                      'Feedback',
                      style:
                          TextStyle(color: Color.fromARGB(230, 72, 151, 148)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const ScreenTermsAndConditions()),
                    ),
                  );
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.my_library_books,
                      color: Color.fromARGB(230, 72, 151, 148),
                    ),
                    title: Text(
                      'Terms and Privacy Policy',
                      style:
                          TextStyle(color: Color.fromARGB(230, 72, 151, 148)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.send,
                      color: Color.fromARGB(230, 72, 151, 148),
                    ),
                    title: Text(
                      'Share',
                      style:
                          TextStyle(color: Color.fromARGB(230, 72, 151, 148)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: ((context) {
                      return AlertDialog(
                        content: const Text(
                          'Do you want to Delete all data!!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: (() {
                                  CategoryDB.instance.deleteAllCategory();
                                  TransactionDB.instance.deleteAllTransaction();
                                  Navigator.of(context).pop();
                                }),
                                child: const Text(
                                  'yes',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: (() {
                                  Navigator.of(context).pop();
                                }),
                                child: const Text(
                                  'no',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  );
                },
                child: const Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.delete_outline,
                      color: Color.fromARGB(230, 72, 151, 148),
                    ),
                    title: Text(
                      'Delete all data',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'MONEY FI',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
