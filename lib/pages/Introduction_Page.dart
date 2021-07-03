import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
// import 'package:onclickproperty/pages/Login_Page.dart';
import 'package:onclickproperty/pages/sign_in/sign_in_screen.dart';

class IntroductionPage extends StatefulWidget {
  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  bool isIntroIn = false;
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Buy,Sell,or rent Your Property",
          body: "10M+ listings Across India",
          image: _buildFirstImage('img1'),
          decoration: pageFirstDecoration,
        ),
        PageViewModel(
          title: "Use Smart Search & Filters",
          image: _buildSecondImage('img1'),
          // body:"Choose Properties Which You Like",
          bodyWidget: Column(
            children: [
              Text("Choose Properties Which Are",
                  style: TextStyle(fontSize: 23.0, color: Colors.white)),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.checkSquare,
                        color: Colors.brown,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("Verfied", style: bodyStyle),
                    ],
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.user,
                        color: Colors.brown,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("From Owners", style: bodyStyle),
                    ],
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.photoVideo,
                        color: Colors.brown,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text("With Photo", style: bodyStyle),
                    ],
                  ),
                ],
              ),
            ],
          ),
          //image: _buildImage('img2'),
          decoration: SecondpageDecoration,
        ),
        PageViewModel(
          title: "Read Reviews from Residents",
          body: "Make An Informed Decision",
          image: _buildthirdImage('img3'),
          decoration: ThirdpageDecoration,
        ),
        PageViewModel(
          title: "Get Detailed Price Insights",
          body: "Empowerieng your Financial Prospects",
          image: _buildfourthImage('img2'),
          // footer: RaisedButton(
          //   onPressed: () {
          //     introKey.currentState?.animateScroll(0);
          //   },
          //   child: const Text(
          //     'FooButton',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   color: Colors.lightBlue,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8.0),
          //   ),
          // ),
          decoration: FourthpageDecoration,
        ),
        PageViewModel(
          title: "Sell Or rent-out Easy & Free",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/OnClicklogo.png', width: 200.0),
            ],
          ),
          image: _buildfifthImage('img1'),
          decoration: pagefifthDecoration,
        ),
      ],
      //onSkip: () => _onIntroEnd(context), // You can voerride onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text(
        'Skip',
        style: TextStyle(color: Colors.white),
      ),
      onSkip: () => _onSkipButton(context),
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text('Done',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
      onDone: () => _onIntroEnd(context),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white,
        //color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  Widget _buildFirstImage(String assetName) {
    return Align(
      child: Image.asset(
          "assets/images/gif1.gif",
          width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _buildSecondImage(String assetName) {
    return Align(
      child: Image.asset(
          "assets/images/gif2.gif",
          width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _buildthirdImage(String assetName) {
    return Align(
      child: Image.asset(
          "assets/images/gif3.gif",
          width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _buildfourthImage(String assetName) {
    return Align(
      child: Image.asset(
          "assets/images/gif4.gif", width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _buildfifthImage(String assetName) {
    return Align(
      child: Image.asset(
          "assets/images/gif1.gif", width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  void _onIntroEnd(context) async {
    print("_onIntroEnd Call:");
    SharedPreferencesConstants.instance
        .setBooleanValue(SharedPreferencesConstants.INTROSCREENCHECK, true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => SignInScreen()),
    );
  }

  void _onSkipButton(context) async {
    print("_onSkipButton Call:");

    SharedPreferencesConstants.instance
        .setBooleanValue(SharedPreferencesConstants.INTROSCREENCHECK, true);
    // isIntroIn = await SharedPreferencesConstants.instance
    //     .getBooleanValue(SharedPreferencesConstants.INTROSCREENCHECK);
    // print("isIntroIn  Call: $isIntroIn");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => SignInScreen()),
    );
  }
}
