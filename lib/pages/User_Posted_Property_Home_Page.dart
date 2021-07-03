import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/Fetch_User_Posted_Items_Count.dart';
import 'package:onclickproperty/Model/UserPostedCount.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/User_Posted_Commerical_Tab.dart';
import 'package:onclickproperty/pages/User_Posted_Project_Tab.dart';
import 'package:onclickproperty/pages/User_Residental_Tab.dart';


class UserPostedPropertyHomePage extends StatefulWidget {
  @override
  _UserPostedPropertyHomePageState createState() =>
      _UserPostedPropertyHomePageState();
}

class _UserPostedPropertyHomePageState
    extends State<UserPostedPropertyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner = false;
  List<UserPostedCount> Userpostedcountlist = new List();

  @override
  void initState() {
    _getAllPropertyCount();
    //super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        key: _scaffoldKey,
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              "Posted Property",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: primarycolor,
              ),
            ),
            bottom: TabBar(
              labelColor: primarycolor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: primarycolor,
              tabs: [
                Tab(
                  text:
                  showspinner ? "" : 'Residental [${Userpostedcountlist[0].ResidentalCount}]',
                ),
                Tab(
                    text:
                    showspinner ? "" :   'Commercial [${Userpostedcountlist[0].CommericalCount}]'),
                Tab(text: showspinner ? "" : 'Project [${Userpostedcountlist[0].ProjectCount}]'),
              ],
            ),
          ),
          body:showspinner ?  Center(child: CircularProgressIndicator())
              :  TabBarView(
            children: [
              UserPostedResidentalTab(),
              UserPostedCommercialTab(),
              UserPostedProjectTab(),
            ],
          ),
        ));
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
