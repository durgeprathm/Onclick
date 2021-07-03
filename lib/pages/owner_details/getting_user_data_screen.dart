import 'package:flutter/material.dart';
import 'package:onclickproperty/pages/owner_details/components/body.dart';


class GettingUserDataScreen extends StatelessWidget {
  String CheckId;
  String ID;
  GettingUserDataScreen(this.CheckId,this.ID);
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Owner Details'),
      ),
      body: Body(CheckId,ID),
    );
  }
}
