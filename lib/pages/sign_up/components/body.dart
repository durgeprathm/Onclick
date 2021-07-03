import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Insert_Regsitartion_Details.dart';
import 'package:onclickproperty/components/socal_card.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _showProgressBar = false;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;
  bool isUserSignedIn = false;

  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: _showProgressBar,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  // 4%
                  Text("Register Account", style: headingStyle),
                  Text(
                    "Complete your details or continue \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.08),
                  SignUpForm(_getLoading),
                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SocalCard(
                  //       icon: "assets/icons/google-icon.svg",
                  //       press: () {
                  //         onGoogleSignIn(context);
                  //       },
                  //     ),
                  //     SocalCard(
                  //       icon: "assets/icons/facebook-2.svg",
                  //       press: () {},
                  //     ),
                  //     // SocalCard(
                  //     //   icon: "assets/icons/twitter.svg",
                  //     //   press: () {},
                  //     // ),
                  //   ],
                  // ),
                  // SizedBox(height: getProportionateScreenHeight(20)),
                  // Text(
                  //   'By continuing your confirm that you agree \nwith our Term and Condition',
                  //   textAlign: TextAlign.center,
                  //   style: Theme.of(context).textTheme.caption,
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _getLoading(value) {
    if (value == true) {
      setState(() {
        _showProgressBar = true;
      });
    } else {
      setState(() {
        _showProgressBar = false;
      });
    }
  }

  Future<User> _handleSignIn() async {
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      user = _auth.currentUser;
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    if (user != null) {
      var _cdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
      // setState(() {
      //   _showProgressBar = false;
      // });
      print('${user.displayName}');
      print('${user.phoneNumber}');
      print('${user.email}');
      print('${user.photoURL}');
      _sendUserData(
          user.displayName != null ? user.displayName : '',
          user.photoURL != null ? user.photoURL : '',
          user.displayName != null ? user.displayName : '',
          _cdate.toString(),
          user.email != null ? user.email : '',
          user.phoneNumber != null ? user.phoneNumber : '');
      // _sendUserData()
    } else {
      // setState(() {
      //   _showProgressBar = false;
      // });
    }
    // var userSignedIn = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) =>
    //           WelcomeUserWidget(user, _googleSignIn)),
    // );

    // setState(() {
    //   isUserSignedIn = userSignedIn == null ? true : false;
    // });
  }

  _sendUserData(String full_Name, String image, String UserName, String Date,
      String Email_ID, String Mobile_Number) async {
    setState(() {
      _showProgressBar = true;
    });
    FirebaseMessaging.instance.getToken().then((token) async {
      print('Token: $token');
      RegistrationDetailsInsert registerSubmitData =
          new RegistrationDetailsInsert();
      var result = await registerSubmitData.getRegistrationDetailsInsert(
          '1', full_Name, image, Date, Email_ID, Mobile_Number, token);
      if (result != null) {
        print("property data ///${result}");
        var resid = result['resid'];
        var message = result["message"];
        if (resid == 200) {
          var UserID = result["id"];
          var UserFullName = result["fullname"];
          var UserEmail = result["email"];
          var UserMobNo = result["mobileno"];
          // prefs.setString('username', UserNameres);
          // prefs.setString('dsmid', UserIDres);

          SharedPreferencesConstants.instance
              .setStringValue(SharedPreferencesConstants.USERID, UserID);
          SharedPreferencesConstants.instance.setStringValue(
              SharedPreferencesConstants.USERFULLNAME, UserFullName);
          SharedPreferencesConstants.instance.setStringValue(
              SharedPreferencesConstants.USEREMAILID, UserEmail);
          SharedPreferencesConstants.instance
              .setStringValue(SharedPreferencesConstants.USERMOBNO, UserMobNo);
          SharedPreferencesConstants.instance
              .setBooleanValue(SharedPreferencesConstants.LOGGEDIN, true);

          setState(() {
            _showProgressBar = false;
          });

          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return HomePage();
            }),
          );
        } else {
          setState(() {
            _showProgressBar = false;
          });
          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        setState(() {
          _showProgressBar = true;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Plz Try Again"),
          backgroundColor: Colors.green,
        ));
      }
    }).catchError((e) {
      print(e);
      setState(() {
        _showProgressBar = true;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Plz Try Again"),
        backgroundColor: Colors.green,
      ));
    });
  }
}
