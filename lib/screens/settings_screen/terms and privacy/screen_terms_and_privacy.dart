import 'package:flutter/material.dart';

class ScreenTermsAndConditions extends StatelessWidget {
  const ScreenTermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(230, 72, 151, 148),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(230, 72, 151, 148),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 150,
                width: double.maxFinite,
                // color: Colors.blue,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // color: Colors.amber,
                      height: 100,
                      // color: Colors.amber,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Terms Of Service',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              Text(
                                'Update 12/02/2023',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                width: double.maxFinite,
                // color: Colors.blue,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        '1 - Terms and Conditions',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Text(
                    'You agree that by accessing the Site, you have read, understood, and agree to be bound by all of these Terms of Service. If you do not agree with all of these Terms of Service, then you are expressly prohibited from using the Site and you must discontinue use immediately.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ]),
              ),
              Container(
                height: 180,
                width: double.maxFinite,
                // color: Colors.blue,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        '2 - Privacy Policy',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Text(
                    'You can use our services in a variety of ways to manage your privacy. For example, you can sign up for a Google Account if you want to create and manage content like emails and photos, or see more relevant search results. And you can use many Google services when you’re signed out or without creating an account at all, like searching on Google or watching YouTube videos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
