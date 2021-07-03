import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/Fetch_Updated.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_Property_Details.dart';
import 'package:onclickproperty/Model/Electronicsitems.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
import 'package:onclickproperty/Model/PropertyDetails.dart';
import 'package:onclickproperty/Model/UpdateServices.dart';
import 'package:onclickproperty/components/form_error.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/Electronics_Items_Page.dart';
import 'package:onclickproperty/pages/Furniture_Details_Page.dart';
import 'package:onclickproperty/pages/HomeServices_Page.dart';
import 'package:onclickproperty/pages/Updated_Service_Page.dart';
import 'package:onclickproperty/pages/furnitures_Page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class ViewPropertyOwnerDetailsPage extends StatefulWidget {
  @override
  String Propertyid;
  ViewPropertyOwnerDetailsPage(this.Propertyid);
  _ViewPropertyOwnerDetailsPageState createState() =>
      _ViewPropertyOwnerDetailsPageState();
}

class _ViewPropertyOwnerDetailsPageState
    extends State<ViewPropertyOwnerDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner = false;
  List<UpdatedService> Fetchupdatedservicelist = new List();
  String ServiceID;
  String Servicetypename;
  String Name;
  String city;
  String Area;
  String Mobilenumber;
  String Pincode;
  String Email;
  String aadharnumber;
  String Imagefront;
  String Imageback;
  String Alternatenumber;
  String Std;
  String Telephone;
  String MainTelephone;
  bool checkaadhar = false;
  bool checkPincode = false;
  bool checkEmail = false;
  bool checkImageBack = false;
  bool checkImageFront = false;
  bool checkTelephone = false;
  bool checkAltmobile = false;
  List<PropertyDetails> PropertyDetailslist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: FaIcon(
        //     FontAwesomeIcons.arrowLeft,
        //     color: primarycolor,
        //   ),
        //   onPressed: () {
        //     // Navigator.pop(context);
        //     // Navigator.pop(context);
        //     Navigator.of(context).push(
        //       MaterialPageRoute(builder: (_) {
        //         return FurnituresPage();
        //       }),
        //     );
        //   },
        // ),
        title: Text(
          "Property Owner Details",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Center(
                            child: SizedBox(
                              height: 115,
                              width: 115,
                              child: Stack(
                                fit: StackFit.expand,
                                overflow: Overflow.visible,
                                children: [
                                  CircleAvatar(
                                      backgroundImage:
                                          AssetImage("images/musician.png"),
                                      backgroundColor: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(height: SizeConfig.screenHeight * 0.01),
                          // Center(
                          //   child: Text(
                          //     "${FurnitureProductslist[0]. != null ? Servicetypename : ''}",
                          //     style: TextStyle(
                          //       fontSize: getProportionateScreenWidth(15),
                          //       fontWeight: FontWeight.bold,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${PropertyDetailslist[0].Username != null ? PropertyDetailslist[0].Username : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Text(
                            "Mobile Number:",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${PropertyDetailslist[0].MobileNumber != null ? PropertyDetailslist[0].MobileNumber : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Visibility(
                            visible: PropertyDetailslist[0].Alternateno != null
                                ? true
                                : false,
                            child: Text(
                              "Alternate Mobile Number:",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: PropertyDetailslist[0].Alternateno != null
                                ? true
                                : false,
                            child: Text(
                              "${PropertyDetailslist[0].Alternateno != null ? PropertyDetailslist[0].Alternateno : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible:
                                  PropertyDetailslist[0].Alternateno != null
                                      ? true
                                      : false,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Visibility(
                            visible: PropertyDetailslist[0].Telephoneno != null
                                ? true
                                : false,
                            child: Text(
                              "Telephone Number:",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: PropertyDetailslist[0].Telephoneno != null
                                ? true
                                : false,
                            child: Text(
                              "${PropertyDetailslist[0].Telephoneno != null ? PropertyDetailslist[0].Telephoneno : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible:
                                  PropertyDetailslist[0].Telephoneno != null
                                      ? true
                                      : false,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Visibility(
                            visible: PropertyDetailslist[0].Email != null
                                ? true
                                : false,
                            child: Text(
                              "Email:",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: PropertyDetailslist[0].Email != null
                                ? true
                                : false,
                            child: Text(
                              "${PropertyDetailslist[0].Email != null ? PropertyDetailslist[0].Email : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: PropertyDetailslist[0].Email != null
                                  ? true
                                  : false,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: FlatButton(
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(20)),
                          //         color: kPrimaryColor,
                          //         onPressed: () {
                          //           Navigator.pop(context);
                          //           Navigator.pop(context);
                          //           Navigator.of(context).pushReplacement(
                          //             MaterialPageRoute(builder: (_) {
                          //               return LaptopItemsPage(
                          //                   ElectronicListFetch[0]
                          //                       .ElectronicAppliancestypeid
                          //                       .toString(),
                          //                   ElectronicListFetch[0]
                          //                       .ElectronicAppliancestypename
                          //                       .toString());
                          //             }),
                          //           );
                          //         },
                          //         child: Text(
                          //           'See Furniture Details',
                          //           style: TextStyle(
                          //             fontSize: getProportionateScreenWidth(18),
                          //             color: Colors.white,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ]),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void initState() {
    _getPropertyDetails(widget.Propertyid.toString());
    print("///////itemsid//////////////${widget.Propertyid}");
  }

  void _getPropertyDetails(String PropertyID) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchPropertyDetails fetchPropertyDetailsdata =
          new FetchPropertyDetails();
      var fetchpropertydetails = await fetchPropertyDetailsdata
          .getFetchPropertyDetails("2", "2", PropertyID, "", "");
      if (fetchpropertydetails != null) {
        var resid = fetchpropertydetails["resid"];
        if (resid == 200) {
          var fetchpropertydetailssd =
              fetchpropertydetails["propertyownerdetails"];
          print(fetchpropertydetailssd.length);
          List<PropertyDetails> temppropertydetailslist = [];
          for (var n in fetchpropertydetailssd) {
            PropertyDetails pro = PropertyDetails.owner(
              int.parse(n["id"]),
              n["username"],
              n["email"],
              n["mobileno"],
              n["alternateno"],
              n["telphoneno"],
            );
            print('like : ${n["like"]}');
            temppropertydetailslist.add(pro);
            this.PropertyDetailslist = temppropertydetailslist;
          }
          print(temppropertydetailslist);
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
