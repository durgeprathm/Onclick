import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onclickproperty/Adaptor/fetch_otp.dart';
import 'package:onclickproperty/components/custom_surfix_icon.dart';
import 'package:onclickproperty/components/form_error.dart';
import 'package:onclickproperty/helper/keyboard.dart';
import 'package:onclickproperty/pages/otp/otp_screen.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class RegisterProfileForm extends StatefulWidget {
  Function setLoading;

  RegisterProfileForm(this.setLoading);

  @override
  _RegisterProfileFormState createState() =>
      _RegisterProfileFormState(this.setLoading);
}

class _RegisterProfileFormState extends State<RegisterProfileForm> {
  _RegisterProfileFormState(this.setLoading);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Function setLoading;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  int _getOtpNo = 0;
  String phoneNumber;

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
          buildPhoneNumberFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
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
                  getOtpData();
                  // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                } else {
                  setLoading(false);
                }
              },
              child: Text(
                'Confirm',
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

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      maxLength: 10,
      maxLengthEnforced: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        } else if (value.length >= 10) {
          removeError(error: kValidPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        } else if (value.length < 10) {
          addError(error: kValidPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  void getOtpData() async {
    setState(() {
      setLoading(true);
    });

    FetchOTP fetchlogindata = FetchOTP();
    var result = await fetchlogindata.FetchOTPData('0', phoneNumber.toString());
    print(result);
    var resID = result["resid"];
    var message = result["message"];
    print(resID);
    if (resID == 200) {
      setState(() {
        setLoading(false);
      });
      _getOtpNo = result["OTP"];
      Fluttertoast.showToast(
          msg: "$message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) {
          return OtpScreen(phoneNumber.toString(), _getOtpNo);
        }),
      );
    } else {
      setState(() {
        setLoading(false);
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
  }
}
