import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_sunlight/constant/colors.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color2,
        body: Center(
          child: FadeTransition(
            opacity: fadeAnimation,
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 2.5),
              height: MediaQuery.of(context).size.height,
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: 'developed by\n',
                  style: GoogleFonts.anonymousPro(
                    fontSize: 18,
                    color: white,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'souleymane diomandé\n',
                      style: TextStyle(fontSize: 30),
                    ),
                    TextSpan(
                      text: '\nprototype designed by\n',
                    ),
                    TextSpan(
                      text: 'dani macuk\n\n ',
                      style: TextStyle(fontSize: 25),
                    ),
                    TextSpan(
                      text: ' Tiktok: souley.dev\n',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, height: 0.5),
                    ),
                    TextSpan(
                      text: 'Insta: souley.dev\n',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, height: 0.5),
                    ),
                    TextSpan(
                      text: ' danimac.uk',
                      style: TextStyle(fontStyle: FontStyle.italic, height: 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
