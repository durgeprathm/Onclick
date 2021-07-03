import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Insert_Data_Notification.dart';
import 'package:onclickproperty/Adaptor/Property_User_Data_Insert.dart';
import 'package:onclickproperty/Adaptor/fetch_Property_Details.dart';
import 'package:onclickproperty/Adaptor/insert_fav_list.dart';
import 'package:onclickproperty/Model/PropertyDetails.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Galary_page.dart';
import 'package:onclickproperty/pages/View_Property_Owners_Details.dart';
import 'package:onclickproperty/utilities/constants.dart';

class PropertyDetailsPage extends StatefulWidget {
  @override
  String PropertyID;
  String PropertyTypeID;
  bool isFavourite = true;

  PropertyDetailsPage(this.PropertyID, this.PropertyTypeID);

  _PropertyDetailsPageState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  InsertDataNotification insertdatanotification = new InsertDataNotification();
  bool showsimilarproducts = false;
  bool showspinner = false;
  bool Buycheck = false;
  bool Rentcheck = false;
  bool ShowFeature = false;
  List<String> imageList = [];
  List<String> simialarimageList = [];
  List<String> FeaturesList = [];
  List<PropertyDetails> PropertyDetailslist = [];
  List<PropertyDetails> SimilarPropertyDetailslist = [];
  String CITYNAME;
  String Commonprice;
  bool isFavourite = false;
  String UID;
  String _selectdate;
  String Fullname;
  String Email;
  String Mobile;
  sendFavData(value, int index, String pid) async {
    setState(() {
      final item = value[index];
      print('item: ${!item.PropertyisFavourite}');
      isFavourite = !item.PropertyisFavourite;
      print('sendFavData: ${isFavourite}');
      PropertyDetailslist[0].PropertyisFavourite = !item.PropertyisFavourite;
    });
    // setState(() {
    //   showspinner = true;
    // });
    try {
      InsertFavList registerSubmitData = new InsertFavList();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      String datetime = formatter.format(DateTime.now());
      var result =
          await registerSubmitData.getInsertFavList('0', UID, pid, datetime);
      if (result != null) {
        print("sendEnquiryData  ///${result}");
        var resid = result['resid'];
        var message = result["message"];
        if (resid == 200) {
          // setState(() {
          //   showspinner = false;
          // });

          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(builder: (_) {
          //     return HomePage();
          //   }),
          // );
        } else {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        // setState(() {
        //   showspinner = true;
        // });
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Plz Try Again"),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      print(e);
      // setState(() {
      //   showspinner = true;
      // });
    }
  }

  Widget build(BuildContext context) {
    double picsize = MediaQuery.of(context).size.width / 2;
    double cardsize = MediaQuery.of(context).size.width * 0.55;
    double cardsizeheight = MediaQuery.of(context).size.height * 0.29;
    double similarcardsizeheight = MediaQuery.of(context).size.height * 0.38;
    double picsizeheight = MediaQuery.of(context).size.height * 0.25;
    double cardsizewidth = MediaQuery.of(context).size.width * 0.55;
    print('isFavourite: $isFavourite');
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text("OnClick Property", style: appbarTitleTextStyle),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: GestureDetector(
              onTap: () {
                sendFavData(PropertyDetailslist, 0,
                    PropertyDetailslist[0].PropertyId.toString());
              },
              child: isFavourite
                  ? Icon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.red,
                    )
                  : Icon(
                      FontAwesomeIcons.heart,
                      color: Colors.grey,
                    ),
            ),
          ),
        ],
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return GalleryPage(imageList);
                              }),
                            );
                          },
                          child: Container(
                            height: 200,
                            width: picsize,
                            child: imageList.length != 0
                                ? new Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return new Image.network(
                                        imageList[index],
                                        fit: BoxFit.fill,
                                      );
                                    },
                                    pagination: SwiperPagination(),
                                    itemCount: imageList.length,
                                    itemWidth: 300.0,
                                    layout: SwiperLayout.DEFAULT,
                                  )
                                : Text(''),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, right: 4.0, left: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Visibility(
                                visible: Buycheck,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.rupeeSign,
                                      size: 20.0,
                                      color: primarycolor,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      PropertyDetailslist.length != 0
                                          ? "${PropertyDetailslist[0].PropertyPrice}"
                                          : '',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: Rentcheck,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Excepted Rent :- ",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.rupeeSign,
                                      size: 15.0,
                                      color: primarycolor,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      PropertyDetailslist.length != 0
                                          ? "${PropertyDetailslist[0].PropertyExceptRent}"
                                          : '',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: Rentcheck,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Excepted Deposite :- ",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.rupeeSign,
                                      size: 16.0,
                                      color: primarycolor,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      PropertyDetailslist.length != 0
                                          ? "${PropertyDetailslist[0].PropertyExceptRent}"
                                          : '',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    PropertyDetailslist.length != 0
                                        ? "${PropertyDetailslist[0].PropertyHouseTypeName}"
                                        : '',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.dotCircle,
                                    size: 10.0,
                                    color: primarycolor,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    PropertyDetailslist.length != 0
                                        ? "${PropertyDetailslist[0].PropertySize} Sq.ft"
                                        : '',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.dotCircle,
                                    size: 10.0,
                                    color: primarycolor,
                                  ),
                                  SizedBox(
                                    width: 2.0,
                                  ),
                                  Text(
                                    PropertyDetailslist.length != 0
                                        ? "${PropertyDetailslist[0].PropertyFurnishing}"
                                        : '',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.building,
                                                  size: 15.0,
                                                  color: primarycolor,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Property Type",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 23.0,
                                                ),
                                                Text(
                                                  PropertyDetailslist.length !=
                                                          0
                                                      ? "${PropertyDetailslist[0].PropertyTypeName}"
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.key,
                                                  size: 15.0,
                                                  color: primarycolor,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Possession",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 23.0,
                                                ),
                                                Text(
                                                  PropertyDetailslist.length !=
                                                          0
                                                      ? "${PropertyDetailslist[0].PropertyPossessionDate}"
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 10.0,
                                    thickness: 1.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.home,
                                                  size: 15.0,
                                                  color: primarycolor,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Preferred Tenants",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 23.0,
                                                ),
                                                Text(
                                                  PropertyDetailslist.length !=
                                                          0
                                                      ? "${PropertyDetailslist[0].PropertyTenants}"
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.parking,
                                                  size: 15.0,
                                                  color: primarycolor,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Parking",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 23.0,
                                                ),
                                                Text(
                                                  PropertyDetailslist.length !=
                                                          0
                                                      ? "${PropertyDetailslist[0].PropertyPaking}"
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 10.0,
                                    thickness: 1.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.birthdayCake,
                                                  size: 15.0,
                                                  color: primarycolor,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Age of Building",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 23.0,
                                                ),
                                                Text(
                                                  PropertyDetailslist.length !=
                                                          0
                                                      ? "${PropertyDetailslist[0].PropertyAge}"
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.calendar,
                                                  size: 15.0,
                                                  color: primarycolor,
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  "Posted On",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 23.0,
                                                ),
                                                Text(
                                                  PropertyDetailslist.length !=
                                                          0
                                                      ? "${PropertyDetailslist[0].PropertyPostDate}"
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 5.0,
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Overview",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Furnishing Status",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          PropertyDetailslist.length != 0
                                              ? "${PropertyDetailslist[0].PropertyFurnishing}"
                                              : '',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5.0,
                                  thickness: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Facing",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          PropertyDetailslist.length != 0
                                              ? "${PropertyDetailslist[0].PropertyFacing}"
                                              : '',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5.0,
                                  thickness: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Water Supply",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          PropertyDetailslist.length != 0
                                              ? "${PropertyDetailslist[0].PropertyWaterSupply}"
                                              : '',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5.0,
                                  thickness: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Floor",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          PropertyDetailslist.length != 0
                                              ? "${PropertyDetailslist[0].PropertyFloor} / ${PropertyDetailslist[0].PropertyTotalFloor}"
                                              : '',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5.0,
                                  thickness: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Bathroom",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          PropertyDetailslist.length != 0
                                              ? "${PropertyDetailslist[0].PropertyBathRoom}"
                                              : '',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5.0,
                                  thickness: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Gated Security",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Available",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5.0,
                                  thickness: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Non Veg Allowed",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          PropertyDetailslist.length != 0
                                              ? "${PropertyDetailslist[0].PropertyNonVegAllow}"
                                              : '',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 5.0,
                                  thickness: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "Maintenance",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          PropertyDetailslist.length != 0
                                              ? "${PropertyDetailslist[0].PropertyMaintance}"
                                              : '',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: ShowFeature,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                          child: Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Features",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: GridView.count(
                                    crossAxisCount: 3,
                                    children: List.generate(FeaturesList.length,
                                        (index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 5.0),
                                        child: Material(
                                          elevation: 2.0,
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                FaIcon(
                                                  FontAwesomeIcons.checkSquare,
                                                  size: 30.0,
                                                  color: Colors.green,
                                                ),
                                                SizedBox(
                                                  height: 3.0,
                                                ),
                                                Text(
                                                  "${FeaturesList[index]}",
                                                  style:
                                                      TextStyle(fontSize: 15.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "What Are Positives",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Chip(
                                        label:
                                            Text('Easy Cab/Auto Availability'),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Chip(
                                        label: Text('Safe At Night'),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Chip(
                                        label: Text('No Power Cuts'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Chip(
                                        label: Text('Clean And Hygienic'),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Chip(
                                        label: Text('Well-Maintained Road'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              //borderRadius: new BorderRadius.circular(10.0),
                              ),
                          color: primarycolor,
                          //minWidth: MediaQuery.of(context).size.width/3,
                          padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (_) {
                            //     return GettingUserDataScreen(
                            //         "6",
                            //         PropertyDetailslist[0]
                            //             .PropertyId
                            //             .toString());
                            //   }),
                            // );
                            print(
                                "PropertyId:- ${PropertyDetailslist[0].PropertyId}");
                            print("UID:- ${UID}");
                            print("fullnumber:- ${Fullname}");
                            print("EmailID:- ${Email}");
                            print("MobileNumber:- ${Mobile}");
                            print("_selectdate:- ${_selectdate}");

                            _getPropertyUserData(
                                "0",
                                PropertyDetailslist[0].PropertyId.toString(),
                                UID,
                                Fullname,
                                Email,
                                Mobile,
                                _selectdate);
                          },
                          child: Text("Get Owner Details",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      //heading for similar products
                      Visibility(
                        visible: showsimilarproducts,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Similar Products",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    )),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Container for similar products
                      Visibility(
                        visible: showsimilarproducts,
                        child: Container(
                          height: similarcardsizeheight,
                          width: cardsizewidth,
                          child: ListView.builder(
                              itemCount: SimilarPropertyDetailslist.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                simialarimageList =
                                    SimilarPropertyDetailslist[index]
                                        .PropertyImages
                                        .split("#");
                                print(
                                    "///////simialarimageList//////////////${simialarimageList}");
                                if (SimilarPropertyDetailslist[index]
                                        .PropertyBuyNow ==
                                    "Buy") {
                                  Commonprice =
                                      SimilarPropertyDetailslist[index]
                                          .PropertyPrice
                                          .toString();
                                } else if (SimilarPropertyDetailslist[index]
                                        .PropertyBuyNow ==
                                    "Rent") {
                                  Commonprice =
                                      SimilarPropertyDetailslist[index]
                                          .PropertyExceptRent
                                          .toString();
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Material(
                                    elevation: 2,
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_) {
                                          return PropertyDetailsPage(
                                              SimilarPropertyDetailslist[index]
                                                  .PropertyId
                                                  .toString(),
                                              SimilarPropertyDetailslist[index]
                                                  .PropertyTypeId
                                                  .toString());
                                        }));
                                      },
                                      child: Container(
                                        height: cardsizeheight,
                                        width: cardsizewidth,
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8.0),
                                                topRight: Radius.circular(8.0),
                                              ),
                                              child: Container(
                                                height: picsizeheight,
                                                width: cardsizewidth,
                                                child: new Swiper(
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return new Image.network(
                                                      simialarimageList[index],
                                                      fit: BoxFit.fill,
                                                    );
                                                  },
                                                  pagination:
                                                      SwiperPagination(),
                                                  itemCount:
                                                      simialarimageList.length,
                                                  itemWidth: picsizeheight,
                                                  //itemHeight: picsizeheight,
                                                  layout: SwiperLayout.DEFAULT,
                                                ),
                                              ),
                                            ),
                                            ListTile(
                                              title: Text(
                                                  "${SimilarPropertyDetailslist[index].PropertyBuyNow.toString()}"),
                                              subtitle: Text(
                                                  "${SimilarPropertyDetailslist[index].PropertySize.toString()} sq.Feet"),
                                              trailing: Text("${Commonprice}"),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    CITYNAME = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.CITY);
    print("/////////CITYNAME/////////////////${CITYNAME}");
    _getSimilarPropertyDetails(
        widget.PropertyID.toString(), widget.PropertyTypeID, CITYNAME);

    Fullname = await SharedPreferencesConstants.instance
        .getStringValue("userfullname");

    Email = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID);

    print(await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID));
    Mobile = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
  }

  @override
  initState() {
    getUserdata();
    print(
        "//////////PropertyID/////////////////${widget.PropertyID.toString()}");
    print(
        "//////////PropertyTypeID/////////////////${widget.PropertyTypeID.toString()}");
    _getPropertyDetails(widget.PropertyID.toString(), widget.PropertyTypeID);

    _getpropertiesseendetails("2", widget.PropertyID.toString());

    print("Call properties details");
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  } //fetching Property Details

  void _getPropertyDetails(String PropertyID, String PropertyTypeID) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchPropertyDetails fetchPropertyDetailsdata =
          new FetchPropertyDetails();
      var fetchpropertydetails = await fetchPropertyDetailsdata
          .getFetchPropertyDetails("0", "0", PropertyID, PropertyTypeID, "");
      if (fetchpropertydetails != null) {
        var resid = fetchpropertydetails["resid"];
        if (resid == 200) {
          var fetchpropertydetailssd =
              fetchpropertydetails["propertyresidentialdetails"];
          print(fetchpropertydetailssd.length);
          List<PropertyDetails> temppropertydetailslist = [];
          for (var n in fetchpropertydetailssd) {
            PropertyDetails pro = PropertyDetails(
              int.parse(n["id"]),
              int.parse(n["rid"]),
              n["propertytypeid"],
              n["propertytypename"],
              n["baynow"],
              n["residentialtypeid"],
              n["residentialtypename"],
              n["residentialbhktypeid"],
              n["residentialbhktypename"],
              n["projectpossession"],
              n["floor"],
              n["totalfloor"],
              n["propertyage"],
              n["propertysize"],
              n["carpetarea"],
              n["facing"],
              n["price"],
              n["erent"],
              n["edeposite"],
              n["powercut"],
              n["othercharge"],
              n["maintenance"],
              n["furnishing"],
              n["tenants"],
              n["postdate"],
              n["parking"],
              n["description"],
              n["negotiable"],
              n["roadwidth"],
              n["nobathroom"],
              n["nobalconies"],
              n["watersupply"],
              n["nonvegallowed"],
              n["featureslist"],
              n["postedby"],
              n["imageslist"],
              n["like"] == '0' ? false : true,
            );
            print('like : ${n["like"]}');
            temppropertydetailslist.add(pro);
          }

          print(temppropertydetailslist);
          setState(() {
            this.PropertyDetailslist = temppropertydetailslist;
            isFavourite = PropertyDetailslist[0].PropertyisFavourite;
            imageList = PropertyDetailslist[0].PropertyImages.split("#");
            var purpose = PropertyDetailslist[0].PropertyBuyNow.toString();

            if (purpose == 'Buy') {
              Buycheck = true;
              Rentcheck = false;
            } else if (purpose == 'Rent') {
              Rentcheck = true;
              Buycheck = false;
            }
            if (PropertyDetailslist[0].PropertyFeatures == 0 ||
                PropertyDetailslist[0].PropertyFeatures == null ||
                PropertyDetailslist[0].PropertyFeatures.isEmpty) {
              ShowFeature = false;
            } else {
              FeaturesList = PropertyDetailslist[0].PropertyFeatures.split("#");
              ShowFeature = true;
            }
          });
          // print(
          //     "//////PropertyDetailslist/////////${PropertyDetailslist.length}");
          // print(
          //     "//////PropertyDetailslist Details/////////$PropertyDetailslist");
          setState(() {
            showspinner = false;
          });
        } else {
          setState(() {
            showspinner = false;
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Plz Try Again"),
          //   backgroundColor: Colors.green,
          // ));
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

  void _getSimilarPropertyDetails(
      String withoutID, String PropertyTypeID, String CityName) async {
    print("///////in Simiar Property/////////");
    setState(() {
      showspinner = true;
    });
    try {
      FetchPropertyDetails fetchPropertyDetailsdata =
          new FetchPropertyDetails();
      var fetchpropertydetails =
          await fetchPropertyDetailsdata.getFetchPropertyDetails(
              "1", "1", withoutID, PropertyTypeID, CityName);
      print(
          "////////similarfetchpropertydetails///////////////////////${fetchpropertydetails}");
      if (fetchpropertydetails != null) {
        var resid = fetchpropertydetails["resid"];
        if (resid == 200) {
          var rowcount = fetchpropertydetails["rowcount"];
          if (rowcount > 0) {
            print("in rowcount");
            var fetchpropertydetailssd =
                fetchpropertydetails["propertyresidentialdetails"];
            print(
                "////fetchpropertydetailssd/////////////${fetchpropertydetailssd.length}");
            List<PropertyDetails> temppropertydetailslist = [];
            for (var n in fetchpropertydetailssd) {
              PropertyDetails pro = PropertyDetails(
                  int.parse(n["id"]),
                  int.parse(n["rid"]),
                  n["propertytypeid"],
                  n["propertytypename"],
                  n["baynow"],
                  n["residentialtypeid"],
                  n["residentialtypename"],
                  n["residentialbhktypeid"],
                  n["residentialbhktypename"],
                  n["projectpossession"],
                  n["floor"],
                  n["totalfloor"],
                  n["propertyage"],
                  n["propertysize"],
                  n["carpetarea"],
                  n["facing"],
                  n["price"],
                  n["erent"],
                  n["edeposite"],
                  n["powercut"],
                  n["othercharge"],
                  n["maintenance"],
                  n["furnishing"],
                  n["tenants"],
                  n["postdate"],
                  n["parking"],
                  n["description"],
                  n["negotiable"],
                  n["roadwidth"],
                  n["nobathroom"],
                  n["nobalconies"],
                  n["watersupply"],
                  n["nonvegallowed"],
                  n["featureslist"],
                  n["postedby"],
                  n["imageslist"],
                  false);
              temppropertydetailslist.add(pro);
            }
            print(
                "//////////temppropertydetailslist/////////////////////////////////${temppropertydetailslist}");
            setState(() {
              this.SimilarPropertyDetailslist = temppropertydetailslist;
              if (SimilarPropertyDetailslist.isEmpty ||
                  SimilarPropertyDetailslist == null ||
                  SimilarPropertyDetailslist.length == 0) {
                print("no ALL  Products");
                showsimilarproducts = false;
                showspinner = false;
                print("In if");
              } else {
                print("In else");
                print(
                    "//////SimilarPropertyDetailslist/////////${SimilarPropertyDetailslist.length}");
                showsimilarproducts = true;
                showspinner = false;
              }
            });
          } else {
            showsimilarproducts = true;
            showspinner = false;
          }
        } else {
          setState(() {
            showspinner = false;
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Plz Try Again"),
          //   backgroundColor: Colors.green,
          // ));
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

  Future<String> _getPropertyUserData(
    String actionId,
    String PropertyID,
    String UserID,
    String full_Name,
    String Email_ID,
    String Mobile_Number,
    String Date,
  ) async {
    setState(() {
      showspinner = true;
    });
    try {
      InsertPropertyUserData PropertyData = new InsertPropertyUserData();
      var PropertyUserData = await PropertyData.getInsertPropertyUserData(
          actionId,
          PropertyID,
          UserID,
          full_Name,
          Email_ID,
          Mobile_Number,
          Date);
      if (PropertyUserData != null) {
        print("PropertyUser Data///${PropertyUserData}");
        var resid = PropertyUserData['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "You Will Get Details Soon !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(builder: (_) {
          //     return HomePage();
          //   }),
          // );
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return ViewPropertyOwnerDetailsPage(
                  PropertyDetailslist[0].PropertyId.toString());
            }),
          );
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

  Future<String> _getpropertiesseendetails(
    String actionId,
    String PropertyID,
  ) async {
    setState(() {
      showspinner = true;
    });
    try {
      var insertnotificationData =
          await insertdatanotification.getInsertDataNotification(
        actionId,
        PropertyID,
            ""
      );
      print("insertnotificationData///////////${insertnotificationData}");
      if (insertnotificationData != null) {
        print("insertnotificationData///${insertnotificationData}");
        var resid = insertnotificationData['success'];
        print("response from server ${resid}");
        if (resid == 1) {
          setState(() {
            showspinner = false;
            print("Notification Send");
          });
        } else {
          setState(() {
            showspinner = false;
            print("Notification Not  Send");
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Plz Try Again"),
          //   backgroundColor: Colors.green,
          // ));
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
