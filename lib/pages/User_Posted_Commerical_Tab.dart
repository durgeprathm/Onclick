import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/Fetch_User_Posted_Items_Count.dart';
import 'package:onclickproperty/Model/UserPostedCount.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Commercial/Commercial_property_tab.dart';
import 'package:onclickproperty/pages/User_Posted_common_tab.dart';
import 'package:onclickproperty/pages/Residential_property_tab.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class UserPostedCommercialTab extends StatefulWidget {
  @override
  _UserPostedCommercialTabState createState() => _UserPostedCommercialTabState();
}

class _UserPostedCommercialTabState extends State<UserPostedCommercialTab> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner = false;
  List<UserPostedCount> Userpostedcountlist = new List();

  void initState() {
    _getAllPropertyCount();
  }

  Widget build(BuildContext context) {
    return showspinner ?  Center(child: CircularProgressIndicator())
        :  DefaultTabController(
        key: _scaffoldKey,
        length: 2, // length of tabs
        initialIndex: 0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Material(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Material(
                          color: Colors.white30,
                          child: TabBar(
                            labelStyle: TextStyle(
                                fontFamily: "Muli",
                                fontSize:
                                getProportionateScreenWidth(
                                    14)),
                            labelColor: primarycolor,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: primarycolor,
                            tabs: [
                              Tab(text: 'Sell [${Userpostedcountlist[0].CommercialBuyCount}]'),
                              Tab(text: 'Lease [${Userpostedcountlist[0].CommericalLeaseCount}]'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 5.0,
              ),
              Container(
                  height:
                  //MediaQuery.of(context).size.height * 0.50,
                  MediaQuery.of(context).size.height * 0.7,
                  //width: MediaQuery.of(context).size.width * 0.25, //height of TabBarView
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: kPrimaryLightColor,
                              width: 0.5))),
                  child: TabBarView(
                    children: <Widget>[
                      UserPostedCommonPropertyTabtabScreen(2,"Buy"),
                      UserPostedCommonPropertyTabtabScreen(2,"Lease"),
                    ],
                  )),
            ]));
  }
  void _getAllPropertyCount() async {
    setState(() {
      showspinner = true;
    });
    try {
      UserPostedItemsCount userpostedcount = new UserPostedItemsCount();
      var userpostedcountdata =
      await userpostedcount.getUserPostedItemsCount("1");
      if (userpostedcountdata != null) {
        var resid = userpostedcountdata["resid"];
        if (resid == 200) {
          var userpostedcountsd = userpostedcountdata["UserPostedItemsCount"];
          print(userpostedcountsd.length);
          List<UserPostedCount> tempuserpostedcountlist = [];
          for (var n in userpostedcountsd) {
            UserPostedCount pro = UserPostedCount.property(
              n["ResidentalCount"],
              n["CommercialCount"],
              n["ProjectCount"],
              n["ResidentialSellCount"],
              n["ResidentialRentCount"],
              n["CommericalSellCount"],
              n["CommericalLeaseCount"],
              n["ProejectResidentalCount"],
              n["ProjectCommericalCount"],
            );
            tempuserpostedcountlist.add(pro);
          }
          setState(() {
            this.Userpostedcountlist = tempuserpostedcountlist;
          });
          print(
              "//////Userpostedcountlist/////////${Userpostedcountlist.length}");

          // print(
          //     "//////UserpostedcountlistDetails/////////${Userpostedcountlist}");
          setState(() {
            showspinner = false;
          });
        } else {
          setState(() {
            showspinner = false;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Plz Try Again"),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        setState(() {
          showspinner = false;
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Some Technical Problem Plz Try Again Later"),
            backgroundColor: Colors.green,
          ));
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
