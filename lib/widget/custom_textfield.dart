import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_sunlight/constant/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String iconPath;
  
  final bool isPassword;
  const CustomTextField(
      {super.key,
      required this.iconPath,
      this.isPassword = false,
      required this.hintText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();

  bool isFocus = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        isFocus = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        focusNode: _focusNode,
        style: GoogleFonts.anonymousPro(fontSize: 15),
        obscuringCharacter: '*',
        obscureText: widget.isPassword,
        cursorColor: Colors.black,
        cursorHeight: 15,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.anonymousPro(
              fontSize: 12, color: const Color(0xff8F8F8F)),
          prefixIcon: SvgPicture.asset(
            widget.iconPath,
            color: isFocus ? color2 : null,
          ),
          prefixIconConstraints: widget.iconPath == "assets/eye.svg"
              ? const BoxConstraints(minHeight: 18, minWidth: 40)
              : const BoxConstraints(minHeight: 12, minWidth: 40),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xffC8D9F9),
            ),
          ),
        ),
      ),
    );
  }
}
