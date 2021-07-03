import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

//Color primarycolor = Color(0xffFD3753);
//Color primarycolor = Colors.lightBlueAccent;
Color primarycolor = Color(0xff01A0C7);
Color correctcolor = Color(0xff54e346);
Color seemorecolor = Colors.green;

final kTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  color: Colors.black,
  letterSpacing: 1,
);

final kTextStyleForContent = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
  color: Colors.black,
  letterSpacing: 0.3,
);

TextStyle dashboadrNavTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 12.0,
    color: Colors.black,
    letterSpacing: .6);

TextStyle subTextStyle = TextStyle(
    // fontSize: ScreenUtil.getInstance().setSp(45),
    fontSize: 16.0,
    color: Colors.black,
    letterSpacing: .6);

final kTextStyleForTitles = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  color: Colors.black,
  letterSpacing: 1,
);

TextStyle style = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w400,
  color: Colors.black,
  letterSpacing: 0.3,
);

// const titleStyle = TextStyle(fontSize: 19.0,color: Colors.white);
const bodyStyle = TextStyle(fontSize: 17.0, color: Colors.white);

//first Page
const pageFirstDecoration = const PageDecoration(
  titleTextStyle: TextStyle(
      fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
  bodyTextStyle: bodyStyle,
  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Color(0xff0C5D52),
  imagePadding: EdgeInsets.zero,
);

//second page
const SecondpageDecoration = const PageDecoration(
  titleTextStyle: TextStyle(
      fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
  bodyTextStyle: bodyStyle,
  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Color(0xffB9DEAA),
  imagePadding: EdgeInsets.zero,
);

//Third page
const ThirdpageDecoration = const PageDecoration(
  titleTextStyle: TextStyle(
      fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
  bodyTextStyle: bodyStyle,
  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Color(0xff00A1E0),
  imagePadding: EdgeInsets.zero,
);

//Fourth page
const FourthpageDecoration = const PageDecoration(
  titleTextStyle: TextStyle(
      fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
  bodyTextStyle: bodyStyle,
  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Color(0xff0B79EA),
  imagePadding: EdgeInsets.zero,
);

//fourth
const pagefifthDecoration = const PageDecoration(
  titleTextStyle: TextStyle(
      fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
  bodyTextStyle: bodyStyle,
  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Color(0xff307E92),
  imagePadding: EdgeInsets.zero,
);

const String errorOtpText = 'The OTP you entered is invalid';
const String errorMobileNoMatchText = 'The mobile no you entered is invalid';
const String errorMobileValideMatchText = 'Please enter valid mobile no';
