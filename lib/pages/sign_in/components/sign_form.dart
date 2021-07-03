import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/components/custom_surfix_icon.dart';
import 'package:onclickproperty/components/form_error.dart';
import 'package:onclickproperty/helper/keyboard.dart';
import 'package:onclickproperty/pages/forget_password_page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:onclickproperty/Adaptor/Fetch_Login.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class SignForm extends StatefulWidget {
  Function setLoading;

  SignForm(this.setLoading);

  @override
  _SignFormState createState() => _SignFormState(this.setLoading);
}

class _SignFormState extends State<SignForm> {
  _SignFormState(this.setLoading);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Function setLoading;
  final _formKey = GlobalKey<FormState>();
  String username;
  String password;
  bool remember = false;
  final List<String> errors = [];
  bool showpass = true;

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUsernameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            children: [
              // Checkbox(
              //   value: remember,
              //   activeColor: kPrimaryColor,
              //   onChanged: (value) {
              //     setState(() {
              //       remember = value;
              //     });
              //   },
              // ),
              // Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ForgetPasswordPage()),
                ),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(
            width: double.infinity,
            height: getProportionateScreenHeight(56),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: kPrimaryColor,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  // if all are valid then go to success screen
                  KeyboardUtil.hideKeyboard(context);
                  uploadLoginData();
                  // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                } else {
                  setLoading(false);
                }
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(18),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: showpass,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 6) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "Enter your password",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => username = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUsernameNullError);
        }
        // else if (emailValidatorRegExp.hasMatch(value)) {
        //   removeError(error: kInvalidEmailError);
        // }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kUsernameNullError);
          return "";
        }
        // else if (!emailValidatorRegExp.hasMatch(value)) {
        //   addError(error: kInvalidEmailError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Enter your username",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  void uploadLoginData() async {
    setState(() {
      setLoading(true);
    });

    FirebaseMessaging.instance.getToken().then((token) async {
      print('Token: $token');

      FetchLogin fetchlogindata = FetchLogin();
      var result = await fetchlogindata.FetchLoginData(
          username.toString(), password.toString(), token.toString());
      print(result);
      if (result != null) {
        var resID = result["resid"];
        String message = result["message"];
        print(resID);
        if (resID == 200) {
          setState(() {
            setLoading(false);
          });
          var UserID = result["id"];
          var UserName = result["username"];
          var UserEmail = result["email"];
          var UserMobNo = result["mobileno"];
          var FullName = result["fullname"];
          var profileimg = result["profileimg"];

          SharedPreferencesConstants.instance
              .setStringValue(SharedPreferencesConstants.USERID, UserID);
          SharedPreferencesConstants.instance
              .setStringValue(SharedPreferencesConstants.USERNAME, UserName);
          SharedPreferencesConstants.instance.setStringValue(
              SharedPreferencesConstants.USERPROFILEPIC, profileimg);
          SharedPreferencesConstants.instance.setStringValue(
              SharedPreferencesConstants.USEREMAILID, UserEmail);
          SharedPreferencesConstants.instance
              .setStringValue(SharedPreferencesConstants.USERMOBNO, UserMobNo);
          SharedPreferencesConstants.instance.setStringValue(
              SharedPreferencesConstants.USERFULLNAME, FullName);
          SharedPreferencesConstants.instance
              .setBooleanValue(SharedPreferencesConstants.LOGGEDIN, true);

          print("///////////////UserName $UserID");
          print("///////////////UserId $UserName");
          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

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
            setLoading(false);
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Incorrect Username Or Password"),
          //   backgroundColor: Colors.green,
          // ));
          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        setState(() {
          setLoading(false);
        });
        Fluttertoast.showToast(
            msg: "Retry",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).catchError((e) {
      print(e);
      setState(() {
        setLoading(false);
      });
      Fluttertoast.showToast(
          msg: "Retry",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
