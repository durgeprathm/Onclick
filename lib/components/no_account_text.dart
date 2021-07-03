import 'package:flutter/material.dart';
import 'package:onclickproperty/pages/register_profile/register_profile_screen.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, SignUpScreen.routeName);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) {
                return RegisterProfileScreen();
              }),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
