import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_sunlight/constant/colors.dart';
import 'package:login_sunlight/screen/contact_screen.dart';
import 'package:login_sunlight/widget/custom_button.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController containercontroller;
  late AnimationController containerScaleController;
  late Animation<double> scaleContainerAnimation;
  late Animation<double> animationContainer;

  late AnimationController text1Controller;
  late Animation<Offset> text1Animation;

  late AnimationController text2Controller;
  late Animation<Offset> text2Animation;

  bool isText1 = true;
  bool letsGo = false;

  @override
  void initState() {
    containercontroller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animationContainer = Tween<double>(
      begin: 1,
      end: 1.1,
    ).animate(CurvedAnimation(
        parent: containercontroller, curve: Curves.linearToEaseOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          containercontroller
              .reverse(); // Inverse l'animation une fois qu'elle est terminée
        } else if (status == AnimationStatus.dismissed) {
          containercontroller
              .forward(); // Relance l'animation une fois qu'elle est inversée
        }
      });
    containercontroller.forward();

    text1Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    text1Animation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: text1Controller, curve: Curves.decelerate));
    text1Controller.forward();

    text2Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    text2Animation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
            CurvedAnimation(parent: text2Controller, curve: Curves.decelerate));

    containerScaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    scaleContainerAnimation =
        Tween<double>(begin: 1, end: 4).animate(containerScaleController);

    displayText2();

    super.initState();
  }

  @override
  void dispose() {
    containercontroller.dispose();
    super.dispose();
  }

  void displayText2() async {
    await Future.delayed(
      const Duration(seconds: 3),
      () async {
        text2Controller.forward();
        isText1 = false;
      },
    );
    await Future.delayed(const Duration(milliseconds: 10), () {
      containercontroller.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color3,
      body: Center(
          child: AnimatedBuilder(
              animation: containercontroller,
              builder: (context, child) {
                return Transform.scale(
                  scale: animationContainer.value,
                  child: ScaleTransition(
                    scale: scaleContainerAnimation,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      alignment: Alignment.center,
                      height: 290,
                      width: 290,
                      decoration: const BoxDecoration(
                        color: color2,
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 4),
                        opacity: letsGo ? 0.0 : 1.0,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SlideTransition(
                                position: text1Animation,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: isText1 ? 1.0 : 0.0,
                                  child: text1(),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SlideTransition(
                                position: text2Animation,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity: isText1 ? 0.0 : 1.0,
                                  child: text2(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  Widget text1() {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        text: 'Create your ',
        style: GoogleFonts.anonymousPro(
          fontSize: 20,
          color: white,
        ),
        children: const <TextSpan>[
          TextSpan(
            text: 'raindrops',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          TextSpan(
            text: ' account',
          ),
        ],
      ),
    );
  }

  Widget text2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "You’re all set!",
          style: GoogleFonts.anonymousPro(fontSize: 20, color: white),
        ),
        IgnorePointer(
          ignoring: isText1 == true,
          child: CustomButton(
            onPressed: () {
              setState(() {
                letsGo = true;
              });
              containerScaleController.forward().whenComplete(() =>
                  Get.to(const ContactScreen(), transition: Transition.fadeIn));
            },
            buttonColor: white,
            textColor: color2,
            text: "Let's Go!",
            width: 150,
          ),
        )
      ],
    );
  }
}
