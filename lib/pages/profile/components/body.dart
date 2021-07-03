import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/Fetch_User_Posted_Items_Count.dart';
import 'package:onclickproperty/Model/UserPostedCount.dart';
import 'package:onclickproperty/pages/Electronic_Items_Posted_By_User.dart';
import 'package:onclickproperty/pages/Furniture_Posted_By_User.dart';
import 'package:onclickproperty/pages/User_Posted_Loan_Details_Page.dart';
import 'package:onclickproperty/pages/User_Posted_Property_Home_Page.dart';
import 'package:onclickproperty/pages/User_Posted_Rent_Details_Page.dart';
import 'package:onclickproperty/pages/contactus/contact_us_screen.dart';
import 'package:onclickproperty/pages/profile/edit_profile_screen.dart';
import 'package:onclickproperty/pages/properties_posted_by_user_list_screen.dart';
import 'package:onclickproperty/pages/sign_in/sign_in_screen.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:onclickproperty/pages/services_posted_by_user_list_screen.dart';
import 'package:onclickproperty/pages/advertisement_posted_by_user_list_screen.dart';

import 'profile_menu.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String profilePic;
  bool showspinner = false;
  bool showsloanagent = false;
  bool showsrentagent = false;
  List<UserPostedCount> Userpostedcountlist = new List();

  @override
  void initState() {
    super.initState();
    getUserdata();
    _getAllCount();
  }

  getUserdata() async {
    var tempprofilePic = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERPROFILEPIC);
    setState(() {
      profilePic = tempprofilePic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showspinner
        ? Center(child: CircularProgressIndicator())
        : SafeArea(
            key: _scaffoldKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(115),
                    width: getProportionateScreenWidth(115),
                    child: Stack(
                      fit: StackFit.expand,
                      overflow: Overflow.visible,
                      children: [
                        profilePic != null
                            ? CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(
                                  profilePic,
                                ),
                                backgroundColor: Colors.grey,

                                //   Image.network(
                                //   profilePic,
                                //   // fit: BoxFit.fill,
                                //   loadingBuilder: (BuildContext context, Widget child,
                                //       ImageChunkEvent loadingProgress) {
                                //     if (loadingProgress == null) return child;
                                //     return Center(
                                //       child: CircularProgressIndicator(
                                //         value: loadingProgress.expectedTotalBytes != null
                                //             ? loadingProgress.cumulativeBytesLoaded /
                                //                 loadingProgress.expectedTotalBytes
                                //             : null,
                                //       ),
                                //     );
                                //   },
                                // )
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/icons/User Icon.svg"),
                                backgroundColor: Colors.grey),
                      ],
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  ProfileMenu(
                    text: "My Account",
                    icon: "assets/icons/User Icon.svg",
                    press: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return EditProfileScreen();
                        }),
                      )
                    },
                  ),
                  // ProfileMenu(
                  //   text: "Properties [${Userpostedcountlist[0].PropertyCount}]",
                  //   icon: "assets/icons/post_property_icon.svg",
                  //   press: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(builder: (_) {
                  //         return PropertiesPostedByUserListScreen();
                  //       }),
                  //     );
                  //   },
                  // ),
                  ProfileMenu(
                    text:
                        "Properties [${Userpostedcountlist[0].PropertyCount}]",
                    icon: "assets/icons/post_property_icon.svg",
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return UserPostedPropertyHomePage();
                        }),
                      );
                    },
                  ),
                  ProfileMenu(
                    text:
                        "Furniture [${Userpostedcountlist[0].FurnitureCount}]",
                    icon: "assets/icons/furniture.svg",
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return FurniturePostedByUserListScreen();
                        }),
                      );
                    },
                  ),
                  ProfileMenu(
                    text:
                        "Electronics [${Userpostedcountlist[0].ElectronicCount}]",
                    icon: "assets/icons/electronics.svg",
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return ElectronicPostedByUserListScreen();
                        }),
                      );
                    },
                  ),
                  Visibility(
                    visible:Userpostedcountlist[0].ServiceCount == 0 ? false : true ,
                    child: ProfileMenu(
                      text: "Services [${Userpostedcountlist[0].ServiceCount}]",
                      icon: "assets/icons/Settings.svg",
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return ServicesPostedByUserListScreen();
                          }),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible:Userpostedcountlist[0].AdvertisementCount == 0 ? false : true ,
                    child: ProfileMenu(
                      text:
                          "Advertisement [${Userpostedcountlist[0].AdvertisementCount}]",
                      icon: "assets/icons/Parcel.svg",
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return AdvertisementPostedByUserListScreen();
                          }),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible:Userpostedcountlist[0].LoanAgentCount == 0 ? false : true ,
                    child: ProfileMenu(
                      text:
                          "Loan Agent [${Userpostedcountlist[0].LoanAgentCount}]",
                      icon: "assets/icons/User Icon.svg",
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return LoanAgentDetailsPage();
                          }),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible:Userpostedcountlist[0].RentalAgentCount == 0 ? false : true ,
                    child: ProfileMenu(
                      text:
                          "Rent Agent [${Userpostedcountlist[0].RentalAgentCount}]",
                      icon: "assets/icons/User Icon.svg",
                      press: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return RentDetailsPage();
                          }),
                        );
                      },
                    ),
                  ),
                  ProfileMenu(
                    text: "Contact Us",
                    icon: "assets/icons/Question mark.svg",
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return ContactUsScreen();
                        }),
                      );
                    },
                  ),
                  ProfileMenu(
                    text: "Log Out",
                    icon: "assets/icons/Log out.svg",
                    press: () async {
                      await SharedPreferencesConstants.instance.removeAll();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) {
                          return SignInScreen();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }

  void _getAllCount() async {
    setState(() {
      showspinner = true;
    });
    try {
      UserPostedItemsCount userpostedcount = new UserPostedItemsCount();
      var userpostedcountdata =
          await userpostedcount.getUserPostedItemsCount("0");
      if (userpostedcountdata != null) {
        var resid = userpostedcountdata["resid"];
        if (resid == 200) {
          var userpostedcountsd = userpostedcountdata["UserPostedItemsCount"];
          print(userpostedcountsd.length);
          List<UserPostedCount> tempuserpostedcountlist = [];
          for (var n in userpostedcountsd) {
            UserPostedCount pro = UserPostedCount(
              n["PropertyCount"],
              n["FurnitureCount"],
              n["ElectronicCount"],
              n["ServicesCount"],
              n["AdvertismentCount"],
              n["LoanAgentCount"],
              n["RentaAgentCount"],
            );
            tempuserpostedcountlist.add(pro);
          }
          setState(() {
            this.Userpostedcountlist = tempuserpostedcountlist;
          });
          print(
              "//////Userpostedcountlist/////////${Userpostedcountlist.length}");
          var Loan = Userpostedcountlist[0].LoanAgentCount.toString();
          var Rent = Userpostedcountlist[0].RentalAgentCount.toString();



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
