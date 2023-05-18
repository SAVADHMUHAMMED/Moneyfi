import 'package:flutter/material.dart';

class ScreenAbout extends StatelessWidget {
  const ScreenAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(230, 72, 151, 148),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(230, 72, 151, 148),
        centerTitle: true,
        title: const Text(
          'About',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'MONEY FI',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            Text(
              'Developed By SAVADH',
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
            ),
            Text(
              'Version 1.2.0',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
