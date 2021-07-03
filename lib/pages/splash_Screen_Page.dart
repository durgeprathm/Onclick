import 'dart:async';
import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Introduction_Page.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:onclickproperty/pages/sign_in/sign_in_screen.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isIntroIn = false;
  bool isLoggedIn = false;
  _SplashScreenState() {
    SharedPreferencesConstants.instance
        .getBooleanValue(SharedPreferencesConstants.INTROSCREENCHECK)
        .then((value) => setState(() {
              isIntroIn = value;
            }));

    print("SharedPreferencesConstants isIntroIn: $isIntroIn");

    SharedPreferencesConstants.instance
        .getBooleanValue(SharedPreferencesConstants.LOGGEDIN)
        .then((value) => setState(() {
              isLoggedIn = value;
            }));
    print(" SharedPreferencesConstant sisLoggedIn: $isLoggedIn");
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => _showNextScreen());
  }

  // Future<bool> _getPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _username = prefs.getString('username');
  //     if (_username == null) {
  //       return USERCHECK = false;
  //     } else {
  //       return USERCHECK = true;
  //     }
  //   });
  //   print(_username);
  // }

  _showNextScreen() async {
    print("_showNextScreen isIntroIn: $isIntroIn");
    print("_showNextScreen isLoggedIn: $isLoggedIn");
    if (isIntroIn) {
      if (isLoggedIn) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
      }
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => IntroductionPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.0),
                      Center(
                        child: Image(
                          image: AssetImage("images/OnClicklogo.png"),
                          width: 250,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       SizedBox(height: 50.0),
              //       Padding(
              //         padding: EdgeInsets.all(0),
              //         child: Image(
              //           image: AssetImage("images/qisystems.png"),
              //           width: 50,
              //         ),
              //       ),
              //       Text(
              //         "Powered By Q.I. Systems",
              //         style: subTextStyle,
              //       ),
              //       Expanded(
              //           child: Text(
              //         "www.qisystems.in",
              //         style: dashboadrNavTextStyle,
              //       ))
              //     ],
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
