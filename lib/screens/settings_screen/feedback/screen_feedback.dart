import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ScreenFeedback extends StatelessWidget {
  // const ScreenFeedback({super.key});

  final _key = GlobalKey<FormState>();
  TextEditingController subject = TextEditingController();
  TextEditingController body = TextEditingController();

  sendEmail(String body) async {
    final Email email = Email(
      body: body,
      subject: 'Feedback',
      recipients: ['mshadulykk76@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(230, 72, 151, 148),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(230, 72, 151, 148),
        centerTitle: true,
        title: const Text(
          'Contact Us',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SizedBox(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 100,
                      child: TextFormField(
                        minLines: 1,
                        maxLines: 10,
                        controller: body,
                        decoration: const InputDecoration(
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Your Feedback Here',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () {
                      _key.currentState!.save();

                      sendEmail(
                        body.text,
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Done',
                      style:
                          TextStyle(color: Color.fromARGB(230, 72, 151, 148)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
