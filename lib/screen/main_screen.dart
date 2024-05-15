import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_sunlight/constant/colors.dart';
import 'package:login_sunlight/constant/extention.dart';
import 'package:login_sunlight/screen/success_screen.dart';
import 'package:login_sunlight/widget/custom_textfield.dart';

import '../widget/custom_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController cloudController;
  late Animation<double> cloudAnimation;

  late AnimationController sunController;
  late Animation<Offset> sunAnimation;

  late AnimationController personController;
  late Animation<double> personScaleAnimation;
  late Animation<Offset> personSlideAnimation;

  late AnimationController formController;
  late Animation<Offset> formSlideAnimation;
  late Animation<double> formFadeAnimation;
  late Animation<double> titleScaleAnimation;

  late AnimationController loginController;
  late AnimationController loginSunController;
  late Animation<double> sunScaleTransition;
  late Animation<Offset> loginSlideAnimation;

  bool _isVisible = true;
  String personImagePathWithUmbrella =
      "assets/undraw_walking_in_rain_vo9p 2.svg";
  String personImagePath = "assets/undraw_walking_in_rain_vo9p 2-2.svg";
  late String currentPersonImage = personImagePathWithUmbrella;

  @override
  void initState() {
    cloudController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 684),
    );
    cloudAnimation = Tween<double>(begin: 1, end: 5).animate(
        CurvedAnimation(parent: cloudController, curve: Curves.easeInOut));

    sunController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 684),
    );
    sunAnimation = Tween<Offset>(
            begin: const Offset(0, -1), end: const Offset(0, 0))
        .animate(
            CurvedAnimation(parent: sunController, curve: Curves.easeInOut));

    personController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 684),
    );
    personScaleAnimation = Tween<double>(begin: 1, end: 0.77).animate(
        CurvedAnimation(parent: personController, curve: Curves.easeInOut));
    personSlideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.32)).animate(
            CurvedAnimation(parent: personController, curve: Curves.easeInOut));

    formController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    formSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: const Offset(0, 0))
            .animate(formController);
    formFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: formController, curve: Curves.easeInOut));
    titleScaleAnimation = Tween<double>(begin: 1, end: 0.77).animate(
        CurvedAnimation(parent: formController, curve: Curves.easeInOut));

    loginController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    sunScaleTransition = Tween<double>(begin: 1, end: 30).animate(
        CurvedAnimation(parent: loginController, curve: Curves.easeIn));

    loginSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 1))
            .animate(loginController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: Stack(
        children: [
          SlideTransition(
            position: loginSlideAnimation,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: buildBlob(),
                ),
                Positioned(
                  top: 200,
                  left: 44,
                  child: SlideTransition(
                    position: personSlideAnimation,
                    child: ScaleTransition(
                      scale: personScaleAnimation,
                      child: Column(
                        children: [
                          AnimatedContainer(
                            height: 309,
                            width: 287,
                            duration: const Duration(milliseconds: 1000),
                            child: SvgPicture.asset(currentPersonImage),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "raindrops",
                            style: GoogleFonts.anonymousPro(
                              fontSize: 39,
                              fontWeight: FontWeight.bold,
                              color: _isVisible ? color2 : white,
                            ),
                          ),
                          SizedBox(
                            width: 315,
                            child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(
                                text: 'Only grab your umbrella when you ',
                                style: GoogleFonts.anonymousPro(
                                  fontSize: 20,
                                  color: _isVisible ? color2 : white,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: 'really',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: ' need it.',
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: _isVisible ? 1.0 : 0.0,
                          child: CustomButton(
                            text: "Get started",
                            width: 340,
                            textColor: white,
                            buttonColor: color2,
                            onPressed: () {
                              setState(() {
                                cloudController.forward();
                                sunController.forward();
                                personController.forward();
                                formController.forward();
                                currentPersonImage = personImagePath;
                                _isVisible = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    130.0.H,
                  ],
                ),
                buildLoginForm(),
                Positioned(
                  bottom: 0,
                  child: SvgPicture.asset("assets/Wave.svg"),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height,
            child: SlideTransition(
              position: sunAnimation,
              child: ScaleTransition(
                  scale: sunScaleTransition,
                  child: SvgPicture.asset("assets/Sun.svg")),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    sunController.dispose();
    loginController.dispose();
    cloudController.dispose();
    personController.dispose();
    personController.dispose();
    super.dispose();
  }

  Widget buildBlob() {
    return Container(
      padding: const EdgeInsets.only(top: 100),
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          ScaleTransition(
            scale: cloudAnimation,
            child: SvgPicture.asset(
              "assets/blob.svg",
              fit: BoxFit.none,
            ),
          ),
          Positioned(
            top: 15,
            right: 16,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: _isVisible ? 1.0 : 0.0,
              child: SvgPicture.asset("assets/Droplets.svg"),
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoginForm() {
    return SlideTransition(
      position: formSlideAnimation,
      child: FadeTransition(
        opacity: formFadeAnimation,
        child: IgnorePointer(
          ignoring: _isVisible,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ScaleTransition(
                  scale: titleScaleAnimation,
                  child: Text(
                    "sign up for rain alerts",
                    style: GoogleFonts.anonymousPro(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: white,
                    ),
                  ),
                ),
                18.0.H,
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const CustomTextField(
                          hintText: "Email address",
                          iconPath: "assets/email.svg",
                        ),
                        7.0.H,
                        const CustomTextField(
                          hintText: "Password",
                          isPassword: true,
                          iconPath: "assets/eye.svg",
                        ),
                        18.0.H,
                        CustomButton(
                          text: "Create Account",
                          textColor: color2,
                          buttonColor: color3,
                          onPressed: () {
                            setState(() {
                              loginController
                                  .forward()
                                  .whenComplete(() => Get.to(
                                        const SuccessScreen(),
                                        transition: Transition.fadeIn,
                                      ));
                            });
                          },
                        ),
                        CustomButton(
                          text: "Back",
                          textColor: white,
                          buttonColor: color2,
                          onPressed: () {
                            setState(() {
                              cloudController.reverse(from: 0.5);
                              sunController.reverse(from: 0.5);
                              personController.reverse(from: 0.5);
                              formController.reverse(from: 0.5);
                              currentPersonImage = personImagePathWithUmbrella;
                              _isVisible = true;
                            });
                          },
                        ),
                      ],
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
