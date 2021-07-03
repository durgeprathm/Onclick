import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/Fetch_Updated.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Porducts.dart';
import 'package:onclickproperty/Model/Electronicsitems.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
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

class ViewElectronicDetailsPage extends StatefulWidget {
  @override
  String Electronicid;
  ViewElectronicDetailsPage(this.Electronicid);
  _ViewElectronicDetailsPageState createState() =>
      _ViewElectronicDetailsPageState();
}

class _ViewElectronicDetailsPageState extends State<ViewElectronicDetailsPage> {
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
  List<ElectronicItems> ElectronicListFetch = new List();

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
          "Electronic Owner Details",
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
                            "${ElectronicListFetch[0].ElectronicUserName != null ? ElectronicListFetch[0].ElectronicUserName : ''}",
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
                            "${ElectronicListFetch[0].ElectronicMobileNumber != null ? ElectronicListFetch[0].ElectronicMobileNumber : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Visibility(
                            visible: ElectronicListFetch[0].ElectronicAlternateNumber != null ? true : false,
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
                            visible: ElectronicListFetch[0].ElectronicAlternateNumber != null ? true : false,
                            child: Text(
                              "${ElectronicListFetch[0].ElectronicAlternateNumber != null ? ElectronicListFetch[0].ElectronicAlternateNumber : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: ElectronicListFetch[0].ElectronicAlternateNumber != null ? true : false,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Visibility(
                            visible: MainTelephone != null ? true : false,
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
                            visible: MainTelephone != null ? true : false,
                            child: Text(
                              "${MainTelephone != null ? MainTelephone : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: MainTelephone != null ? true : false,
                              child: SizedBox(
                                  height: SizeConfig.screenHeight * 0.03)),
                          Visibility(
                            visible: ElectronicListFetch[0].ElectronicEmail != null ? true : false,
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
                            visible: ElectronicListFetch[0].ElectronicEmail != null ? true : false,
                            child: Text(
                              "${ElectronicListFetch[0].ElectronicEmail != null ? ElectronicListFetch[0].ElectronicEmail : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Visibility(
                              visible: ElectronicListFetch[0].ElectronicEmail != null ? true : false,
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
                            "${ElectronicListFetch[0].ElectronicCity != null ? ElectronicListFetch[0].ElectronicCity : ''}",
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
                            "${ElectronicListFetch[0].ElectronicArea != null ? ElectronicListFetch[0].ElectronicArea : ''}",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(12),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Visibility(
                            visible: ElectronicListFetch[0].ElectronicPincode != null ? true : false,
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
                            visible: ElectronicListFetch[0].ElectronicPincode != null ? true : false,
                            child: Text(
                              "${ElectronicListFetch[0].ElectronicPincode != null ? ElectronicListFetch[0].ElectronicPincode : ''}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(12),
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenHeight * 0.03),
                          Row(
                            children: [
                              Expanded(
                                child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  color: kPrimaryColor,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (_) {
                                        return LaptopItemsPage(
                                            ElectronicListFetch[0]
                                                .ElectronicAppliancestypeid
                                                .toString(),
                                            ElectronicListFetch[0]
                                                .ElectronicAppliancestypename
                                                .toString());
                                      }),
                                    );
                                  },
                                  child: Text(
                                    'See Furniture Details',
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              ),
            ),
    );
  }

  @override
  void initState() {
    _getElectronicProducts(widget.Electronicid.toString());
    print("///////itemsid//////////////${widget.Electronicid}");
  }

  void _getElectronicProducts(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicProducts fetchelectronicproductsdata =
          new FetchElectronicProducts();
      var fetchelectronicproducts = await fetchelectronicproductsdata
          .getFetchElectronicProducts("4", "4", itemid, "");
      if (fetchelectronicproducts != null) {
        print(fetchelectronicproducts);
        var resid = fetchelectronicproducts["resid"];
        if (resid == 200) {
          var fetchelectronicprodcutssd =
              fetchelectronicproducts["electronicslist"];
          print(fetchelectronicprodcutssd.length);
          List<ElectronicItems> tempfetchelectronicprodcutslist = [];
          for (var n in fetchelectronicprodcutssd) {
            ElectronicItems pro = ElectronicItems(
              int.parse(n["id"]),
              int.parse(n["uid"]),
              int.parse(n["appliancestypeid"]),
              n["appliancestypeName"],
              n["brand"],
              n["condition"],
              n["capacity"],
              n["title"],
              n["price"],
              n["mobileno"],
              n["username"],
              n["email"],
              n["pincode"],
              n["city"],
              n["area"],
              n["yourare"],
              n["wattage"],
              n["model"],
              n["description"],
              n["date"],
              n["Firstimg"],
              n["img"],
              n["alternateno"],
              n["std"],
              n["telephoneno"],
              n["lat"],
              n["long"],
            );
            tempfetchelectronicprodcutslist.add(pro);
          }
          setState(() {
            this.ElectronicListFetch = tempfetchelectronicprodcutslist;
            print(
                "//////ElectroicProductslist/////////${ElectronicListFetch.length}");
            print(
                "///////sepratedImages//////////////${ElectronicListFetch[0].ElectronicImages}");
            Std=ElectronicListFetch[0].ElectronicStd;
            Telephone==ElectronicListFetch[0].ElectronicTelephone;
            print("///before/////////${MainTelephone}");
            if(Std !=null && Telephone!=null)
              {
                MainTelephone=Std+"-"+Telephone;
                print("///IN/////////${MainTelephone}");
              }
            print("///after/////////${MainTelephone}");
          });
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
