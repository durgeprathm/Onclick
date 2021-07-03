import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/Fetch_Updated.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Porducts.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
import 'package:onclickproperty/Model/UpdateServices.dart';
import 'package:onclickproperty/components/form_error.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/Furniture_Details_Page.dart';
import 'package:onclickproperty/pages/HomeServices_Page.dart';
import 'package:onclickproperty/pages/Updated_Service_Page.dart';
import 'package:onclickproperty/pages/furnitures_Page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class ViewFurnitureDetailsPage extends StatefulWidget {
  @override
  String Furnitureid;
  ViewFurnitureDetailsPage(this.Furnitureid);
  _ViewFurnitureDetailsPageState createState() =>
      _ViewFurnitureDetailsPageState();
}

class _ViewFurnitureDetailsPageState extends State<ViewFurnitureDetailsPage> {
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
  List<FurnitureProducts> FurnitureProductslist = new List();

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
          "Furniture Owner Details",
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
                            "${FurnitureProductslist[0].FurniturnUserName != null ? FurnitureProductslist[0].FurniturnUserName : ''}",
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
                            "${FurnitureProductslist[0].FurniturnMobileNumber != null ? FurnitureProductslist[0].FurniturnMobileNumber : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Visibility(
                            visible: checkAltmobile,
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
                            visible: checkAltmobile,
                            child: Text(
                              "${FurnitureProductslist[0].FurniturnAlternateno != null ? FurnitureProductslist[0].FurniturnAlternateno : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: checkAltmobile,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Visibility(
                            visible: checkTelephone,
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
                            visible: checkTelephone,
                            child: Text(
                              "${MainTelephone != null ? MainTelephone : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: checkTelephone,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Visibility(
                            visible: checkEmail,
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
                            visible: checkEmail,
                            child: Text(
                              "${FurnitureProductslist[0].FurniturnEmail != null ? FurnitureProductslist[0].FurniturnEmail : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: checkEmail,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Text(
                            "City:",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${FurnitureProductslist[0].FurniturnCity != null ? FurnitureProductslist[0].FurniturnCity : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Text(
                            "Area",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "${FurnitureProductslist[0].FurniturnArea != null ? FurnitureProductslist[0].FurniturnArea : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Visibility(
                            visible: checkPincode,
                            child: Text(
                              "Pincode",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(15),
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: checkPincode,
                            child: Text(
                              "${FurnitureProductslist[0].FurniturnPincode != null ? FurnitureProductslist[0].FurniturnPincode : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: FlatButton(
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(20)),
                          //         color: kPrimaryColor,
                          //         onPressed: () {
                          //           Navigator.of(context).push(
                          //             MaterialPageRoute(builder: (_) {
                          //               return FurnitureDetailsPage(
                          //                 FurnitureProductslist[0].Furnitureid,
                          //                 FurnitureProductslist,
                          //               );
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
    _getFurnitureProducts(widget.Furnitureid.toString());
  }

  void _getFurnitureProducts(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchFurnitureProducts fetchfurnitureproductsdata =
          new FetchFurnitureProducts();
      var fetchfurnitureproducts = await fetchfurnitureproductsdata
          .getFetchFurnitureProducts("4", "3", itemid, "");
      if (fetchfurnitureproducts != null) {
        var resid = fetchfurnitureproducts["resid"];
        var rowcount = fetchfurnitureproducts["rowcount"];
        print(
            "///////////////////-----------------------Furniture Response-------------------------");
        print(fetchfurnitureproducts);
        print(
            "///////////////////-----------------------Furniture Response-------------------------");
        if (resid == 200) {
          if (rowcount > 0) {
            var fetchfurnitureprodcutssd =
                fetchfurnitureproducts["furnitureproductlist"];
            print(fetchfurnitureprodcutssd.length);
            List<FurnitureProducts> tempfetchfurnitureprodcutslist = [];
            for (var n in fetchfurnitureprodcutssd) {
              FurnitureProducts pro = FurnitureProducts(
                int.parse(n["id"]),
                int.parse(n["uid"]),
                int.parse(n["furnituretypeID"]),
                n["furniturename"],
                n["furnituresubtype"],
                n["condition"],
                n["brand"],
                n["title"],
                n["price"],
                n["mobileno"],
                n["username"],
                n["email"],
                n["pincode"],
                n["city"],
                n["area"],
                n["yourare"],
                n["furniturematerial"],
                n["model"],
                n["quality"],
                n["description"],
                n["alternateno"],
                n["std"],
                n["telephoneno"],
                n["date"],
                n["lat"],
                n["long"],
                n["Firstimg"],
                n["img"],
              );
              tempfetchfurnitureprodcutslist.add(pro);
            }
            setState(() {
              this.FurnitureProductslist = tempfetchfurnitureprodcutslist;
              var imagesHashValue = FurnitureProductslist[0].FurniturnImages;
              print("///////imagesHashValue//////////////${imagesHashValue}");
              setState(() {
                // sepratedImages = imagesHashValue.split("#");
              });

              showspinner = false;
            });

            print(
                "//////FurnitureProductslist/////////${FurnitureProductslist.length}");
          } else {
            setState(() {
              //showNoProduct = true;
              showspinner = false;
            });
          }
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
