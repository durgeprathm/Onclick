import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  final String mobileNo;

  CompleteProfileScreen(this.mobileNo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(mobileNo),
    );
  }
}
