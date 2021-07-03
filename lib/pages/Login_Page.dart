import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Fetch_Login.dart';
import 'package:onclickproperty/Adaptor/Insert_Regsitartion_Details.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/MobileOTP_showbottomsheet.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onclickproperty/pages/forget_password_page.dart';

import 'home_page.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  bool showpass = true;
  String UserName;
  String Password;
  String UserIDres;
  String UserNameres;
  final _usernametext = TextEditingController();
  final _passwordtext = TextEditingController();
  bool _uvalidate = false;
  bool _pvalidate = false;

  // final fb = FacebookLogin();

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;
  bool isUserSignedIn = false;
  bool _showProgressBar = false;

  // FacebookAccessToken _token;
  // FacebookUserProfile _profile;
  String _email;
  String _imageUrl;

  @override
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
    final emailField = TextField(
      controller: _usernametext,
      obscureText: false,
      style: style,
      onChanged: (value) {
        UserName = value;
      },
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.user,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Username",
        errorText: _uvalidate ? 'Please Enter Username' : null,
      ),
    );
    final passwordField = TextField(
      controller: _passwordtext,
      obscureText: showpass,
      style: style,
      onChanged: (value) {
        Password = value;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          errorText: _pvalidate ? 'Please Enter Password' : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
            child: FaIcon(
              FontAwesomeIcons.key,
              color: primarycolor,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
            child: GestureDetector(
              onTap: () {
                if (showpass) {
                  setState(() {
                    showpass = false;
                  });
                } else {
                  setState(() {
                    showpass = true;
                  });
                }
              },
              child: showpass
                  ? FaIcon(
                      FontAwesomeIcons.eye,
                      color: Colors.grey,
                    )
                  : FaIcon(
                      FontAwesomeIcons.eyeSlash,
                      color: Colors.grey,
                    ),
            ),
          )),
    );
    final SignInButon = Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        color: primarycolor,
        //minWidth: MediaQuery.of(context).size.width/3,
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) {
              return LogInPage();
            }),
          );
        },
        child: Text("Sign In",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final SignUPButon = Expanded(
      child: OutlineButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
        onPressed: () {
          // showModalBottomSheet(
          //     context: context,
          //     isScrollControlled: true,
          //     builder: (context) => SingleChildScrollView(
          //             child: Container(
          //           padding: EdgeInsets.only(
          //               bottom: MediaQuery.of(context).viewInsets.bottom),
          //           child: MobileOTPShowBottomSheet(),
          //         )));

          _modalBottomSheetMenu();

          // _showMyDialog();
        },
        borderSide: BorderSide(
          color: primarycolor,
          style: BorderStyle.solid,
        ),
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: primarycolor, fontWeight: FontWeight.bold)),
      ),
    );
    final finaloginButon = FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      color: primarycolor,
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      onPressed: () async {
        setState(() {
          _showProgressBar = true;
        });
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        if (_usernametext.text.isEmpty || _passwordtext.text.isEmpty) {
          _usernametext.text.isEmpty ? _uvalidate = true : _uvalidate = false;
          _passwordtext.text.isEmpty ? _pvalidate = true : _pvalidate = false;
          setState(() {
            _showProgressBar = false;
          });
        } else {
          uploadLoginData();
        }
      },
      child: Text("Login",
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
    );
    final FaceBookButon = Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        color: Color(0xff23689b),
        //minWidth: MediaQuery.of(context).size.width/3,
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
        onPressed: () {
          // onFBSignIn(context);
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (_) {
          //     return HomePage();
          //   }),
          // );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: 10.0),
            FaIcon(
              FontAwesomeIcons.facebook,
              color: Colors.white,
            ),
            SizedBox(width: 10.0),
            Text("Facebook",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
    final googleButon = Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        color: Colors.redAccent,
        //minWidth: MediaQuery.of(context).size.width/3,
        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
        onPressed: () {
          onGoogleSignIn(context);
          // Navigator.of(context).push(
          //   MaterialPageRoute(builder: (_) {
          //     return HomePage();
          //   }),
          // );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(width: 10.0),
            FaIcon(
              FontAwesomeIcons.googlePlusG,
              color: Colors.white,
            ),
            SizedBox(width: 10.0),
            Text("Google",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
    final MobileNumberField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          child: FaIcon(
            FontAwesomeIcons.user,
            color: primarycolor,
          ),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Mobile Number",
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: _showProgressBar,
        child: SafeArea(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: ListView(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                      // width: 250.0,
                      // child: Image.asset(
                      //   "images/OnClicklogo.png",
                      //   fit: BoxFit.contain,
                      // ),
                    ),
                    Image.asset(
                      "images/OnClicklogo.png",
                      fit: BoxFit.contain,
                      width: 90.0,
                      height: 60.0,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SignInButon,
                        SizedBox(width: 10.0),
                        SignUPButon
                      ],
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    finaloginButon,
                    SizedBox(
                      height: 7.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return ForgetPasswordPage();
                            }));
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                                wordSpacing: 5.0,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Or Login With",
                          style: TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaceBookButon,
                        SizedBox(width: 10.0),
                        googleButon
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
              color: Colors.transparent,
              child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0))),
                  child: SingleChildScrollView(
                      child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: MobileOTPShowBottomSheet(),
                  )))
              // new Center(
              //   child: new Text("This is a modal sheet"),
              // )),
              );
        });
  }

  void uploadLoginData() async {
    FirebaseMessaging.instance.getToken().then((token) async {
      print('Token: $token');

      FetchLogin fetchlogindata = FetchLogin();
      var result = await fetchlogindata.FetchLoginData(
          UserName, Password, token.toString());
      print(result);
      var resID = result["resid"];
      print(resID);
      if (resID == 200) {
        var UserID = result["id"];
        var UserName = result["username"];
        var UserFirstName = result["fullname"];
        var UserEmail = result["email"];
        var UserMobNo = result["mobileno"];
        var profileimg = result["profileimg"];

        SharedPreferencesConstants.instance
            .setStringValue(SharedPreferencesConstants.USERID, UserID);
        SharedPreferencesConstants.instance
            .setStringValue(SharedPreferencesConstants.USERNAME, UserName);
        SharedPreferencesConstants.instance.setStringValue(
            SharedPreferencesConstants.USERFULLNAME, UserFirstName);
        SharedPreferencesConstants.instance
            .setStringValue(SharedPreferencesConstants.USEREMAILID, UserEmail);
        SharedPreferencesConstants.instance
            .setStringValue(SharedPreferencesConstants.USERMOBNO, UserMobNo);
        SharedPreferencesConstants.instance
            .setBooleanValue(SharedPreferencesConstants.LOGGEDIN, true);

        print("///////////////UserName $UserID");
        print("///////////////UserId $UserName");
        print("///////////////UserFirstName $UserFirstName");
        print("///////////////UserEmail $UserEmail");
        print("///////////////UserMobNo $UserMobNo");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage()),
        );
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (_) {
        //     return HomePage();
        //   }),
        // );
      } else {
        setState(() {
          _showProgressBar = false;
        });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Incorrect Username Or Password"),
          backgroundColor: Colors.green,
        ));
      }
    }).catchError((e) {
      print(e);
      setState(() {
        _showProgressBar = false;
      });
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Incorrect Username Or Password"),
        backgroundColor: Colors.green,
      ));
    });
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

  // Future<UserCredential> _handleFBSignIn() async {
  //   UserCredential user;
  //   final res = await fb.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]);
  //
  //   switch (res.status) {
  //     case FacebookLoginStatus.success:
  //       // Logged in
  //       final res = await fb.expressLogin();
  //       final FacebookAccessToken accessToken = res.accessToken;
  //       print('Access token: ${accessToken.token}');
  //
  //       final facebookAuthCred =
  //           FacebookAuthProvider.credential(accessToken.token);
  //       user = await _auth.signInWithCredential(facebookAuthCred);
  //
  //       final profile = await fb.getUserProfile();
  //       print('Hello, ${profile.name}! You ID: ${profile.userId}');
  //
  //       // Get user profile image url
  //       final imageUrl = await fb.getProfileImageUrl(width: 100);
  //       print('Your profile image: $imageUrl');
  //
  //       // Get email (since we request email permission)
  //       final email = await fb.getUserEmail();
  //       // But user can decline permission
  //       if (email != null) print('And your email is $email');
  //
  //       break;
  //     case FacebookLoginStatus.cancel:
  //       // User cancel log in
  //       break;
  //     case FacebookLoginStatus.error:
  //       // Log in failed
  //       print('Error while log in: ${res.error}');
  //       break;
  //   }
  //
  //   return user;
  // }

  // Future<void> _handleFBSignIn() async {
  //   final token = await fb.accessToken;
  //   FacebookUserProfile profile;
  //   String email;
  //   String imageUrl;
  //
  //   if (token != null) {
  //     profile = await fb.getUserProfile();
  //     if (token.permissions?.contains(FacebookPermission.email.name) ?? false) {
  //       email = await fb.getUserEmail();
  //     }
  //     imageUrl = await fb.getProfileImageUrl(width: 100);
  //   }
  //
  //   setState(() {
  //     _token = token;
  //     _profile = profile;
  //     _email = email;
  //     _imageUrl = imageUrl;
  //   });
  //
  //
  // }

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

  // void onFBSignIn(BuildContext context) async {
  //   await fb.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]);
  //   await _handleFBSignIn();
  //
  //   // if (_token != null) {
  //   //   // setState(() {
  //   //   //   _showProgressBar = false;
  //   //   // });
  //   //   print('${_token}');
  //   //   print('${_profile.firstName}');
  //   //   print('${_email}');
  //   //   print('${_imageUrl}');
  //   //   // _sendUserData()
  //   // } else {
  //   //   // setState(() {
  //   //   //   _showProgressBar = false;
  //   //   // });
  //   // }
  //   // var userSignedIn = await Navigator.push(
  //   //   context,
  //   //   MaterialPageRoute(
  //   //       builder: (context) =>
  //   //           WelcomeUserWidget(user, _googleSignIn)),
  //   // );
  //
  //   // setState(() {
  //   //   isUserSignedIn = userSignedIn == null ? true : false;
  //   // });
  // }

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
          '1', full_Name, image, Date, Email_ID, Mobile_Number,token);
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
