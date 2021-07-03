import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/utilities/size_config.dart';

const kPrimaryColor = Color(0xFF01A0C7);
const kPrimaryLightColor = Color(0xFFdcf8ff);
const kPrimaryLightColor1 = Color(0xFFa0cfe3);

// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
// );
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);


final appbarTitleTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.bold,
  color: primarycolor,
);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final subsDetailsheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final subscriptioheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final locationAddheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final subsSubheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final subGrayheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  color: Colors.black,
  height: 1.5,
);

final rateheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final subStatusheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(14),
  fontWeight: FontWeight.normal,
  color: Colors.black,
  height: 1.5,
);

final extraVisiheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
final extraVisiDetailsheadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(15),
  color: Colors.black54,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kUsernameNullError = "Please Enter your username";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kValidPhoneNumberNullError = "Please Enter valid phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
