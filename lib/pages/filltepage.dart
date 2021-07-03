import 'package:flutter/material.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/Commercial_Tab.dart';
import 'package:onclickproperty/pages/Projects_Tab.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

import 'Residential_Tab.dart';

class FiltterPage extends StatefulWidget {
  @override
  _FiltterPageState createState() => _FiltterPageState();
}

class _FiltterPageState extends State<FiltterPage> {
  bool showspinner = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: primarycolor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text( "OnClick Property",
              style: appbarTitleTextStyle,),
          automaticallyImplyLeading: false,
          // backgroundColor: Color(0xff5808e5),
          bottom: TabBar(
            labelStyle: TextStyle(
                fontFamily: "Muli",
                fontSize:
                getProportionateScreenWidth(
                    14)),
            labelColor: primarycolor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: primarycolor,
            tabs: [
              Tab(text: 'Residential'),
              Tab(text: 'Commercial'),
              Tab(text: 'Projects'),
            ],
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: showspinner,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            child: TabBarView(
              children: [
                ResidentialTabPage(showProgressCircle),
                CommercialTabPage(),
                ProjectsTabPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showProgressCircle(value) {
    if (value) {
      setState(() {
        showspinner = true;
      });
    } else {
      setState(() {
        showspinner = false;
      });
    }
  }
}
