import 'package:flutter/material.dart';

const kSecondaryColor = Color(0xFF000000);
const kTextColor = Colors.black;
const kShadowColor = Color(0x19000000);
const kColorWhite = Color(0xffffffff);
const kColorFieldBorder = Color(0xFFD8D8D8);
const kPrimaryColor = Color(0xFF054791);
const kColorDarkBlue = Color(0xFF006DAF);
const kColorLightBlue = Color(0xFF00BCE7);
const kColorAddButton = Color(0xFFC6E9FF);
const kColorRed = Color(0xffFF0000);
const kColorGreen = Color(0xFF3ED409);
const kAnimationDuration = Duration(milliseconds: 200);

const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kSecondaryColor,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

/// Form Error
final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: kTextColor),
  );
}
