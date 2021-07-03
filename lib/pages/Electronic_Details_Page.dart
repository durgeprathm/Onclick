import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Insert_Data_Notification.dart';
import 'package:onclickproperty/Adaptor/Insert_electronic_get_owner_details_data.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Type.dart';
import 'package:onclickproperty/Model/Electronics_type.dart';
import 'package:onclickproperty/Model/Electronicsitems.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Electronics_Items_Page.dart';
import 'package:onclickproperty/pages/View_Elecronic_Owner_Details_Page.dart';
import 'package:onclickproperty/pages/Zooming_Products_Images.dart';
import 'package:onclickproperty/pages/owner_details/getting_user_data_screen.dart';

class ElectronicDetailsPage extends StatefulWidget {
  @override
  final String indexFetch;
  ElectronicDetailsPage(this.indexFetch);
  _ElectronicDetailsPageState createState() => _ElectronicDetailsPageState();
}

class _ElectronicDetailsPageState extends State<ElectronicDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  InsertDataNotification insertdatanotification = new InsertDataNotification();
  bool showspinner = false;
  bool showsimilarproducts = false;
  bool showsyoumightlike = false;
  String title;
  List<String> tempimageList = [];
  List<String> sepratedImages = [];
  List<String> ImagesList = [];
  List<String> ImagesListAll = [];
  List<ElectronicItems> ElectronicListFetch = new List();
  List<ElectronicItems> ElectronicProductslist = new List();
  List<ElectronicItems> ElectronicAllProductslist = new List();
  List<ElectronicsType> ElectronicTypelist = new List();
  String UID;
  String UserFullName;
  String UserEmail;
  String UserMobile;
  String _selectdate;

  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    print(UID);

    UserFullName = await SharedPreferencesConstants.instance
        .getStringValue("userfullname");
    print(UserFullName);

    UserEmail = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID);
    print(UserEmail);

    UserMobile = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
    print(UserMobile);
    sepratedImages =ElectronicListFetch[0].ElectronicImages.split("#");
    print("///////sepratedImages//////////////${sepratedImages}");
  }

  List<String> ElectronicImageList = [
    "images/air-conditioner.png",
    "images/fridge1.png",
    "images/air-conditioner.png",
    "images/laptop.png",
    "images/washing-machine.png",
    "images/monitor.png",
    "images/camera.png",
    "images/print1 (1).png",
    "images/mobile.png",
    "images/microwave.png",
    "images/computer.png",
    "images/game-controller.png",
    "images/game-controller.png",
  ];

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    double picsize = MediaQuery.of(context).size.width / 2;
    double cardsizewidth = MediaQuery.of(context).size.width * 0.60;
    double cardsizeheight = MediaQuery.of(context).size.height * 0.40;
    double picsizeheight = MediaQuery.of(context).size.height * 0.22;
    final imageList = [
      'https://cdn.mos.cms.futurecdn.net/6t8Zh249QiFmVnkQdCCtHK.jpg',
      'https://cdn.mos.cms.futurecdn.net/k9Md6R78D8aN4tbGDRWUSE.jpg',
      'https://cdn.arstechnica.net/wp-content/uploads/2016/01/IMG_2860-980x653.jpg',
      'https://www.windowslatest.com/wp-content/uploads/2017/09/Windows-10-PC.jpg',
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          "${ElectronicListFetch.isNotEmpty ? ElectronicListFetch[0].ElectronicTitle : ""}",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.normal,
            color: primarycolor,
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 15.0, top: 10.0),
        //     child: FaIcon(
        //       FontAwesomeIcons.shoppingCart,
        //       size: 20.0,
        //       color: primarycolor,
        //     ),
        //   )
        // ],
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) {
                                  return ZoomingProductsImages(
                                      sepratedImages, title);
                                }),
                              );
                              print(
                                  "///////sending images to zoom//////////////////////${sepratedImages}");
                            },
                            child: ClipRRect(
                              child: Container(
                                height: 200,
                                width: picsize,
                                child: new Swiper(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new Image.network(
                                      sepratedImages[index],
                                      fit: BoxFit.fill,
                                      //---------------------------
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                          ),
                                        );
                                      },

                                      //--------------------------
                                    );
                                  },
                                  pagination: SwiperPagination(),
                                  itemCount: sepratedImages.length,
                                  itemWidth: 300.0,
                                  layout: SwiperLayout.DEFAULT,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "${ElectronicListFetch.isNotEmpty ? ElectronicListFetch[0].ElectronicDescription : ""}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.rupeeSign,
                                size: 20.0,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "${ElectronicListFetch.isNotEmpty ? ElectronicListFetch[0].ElectronicPrice :""}.00",
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                            child: Material(
                              //borderRadius: BorderRadius.circular(10.0),
                              elevation: 2.0,
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Products Details",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Condition",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch.isNotEmpty ? ElectronicListFetch[0].ElectronicCondition : ""}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Brand Name",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch.isNotEmpty ? ElectronicListFetch[0].ElectronicBrandname : ""}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                              "Wattage",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch.isNotEmpty ? ElectronicListFetch[0].ElectronicWattage :""}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                              "Model",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch.isNotEmpty ? ElectronicListFetch[0].ElectronicModel : ""}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                              "Appliances Type",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch.isNotEmpty ? ElectronicListFetch[0].ElectronicAppliancestypename : ""}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                              "Posted By",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${ElectronicListFetch.isNotEmpty ? ElectronicListFetch[0].ElectronicYouAre : ""}",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  //borderRadius: new BorderRadius.circular(10.0),
                                  ),
                              color: primarycolor,
                              //minWidth: MediaQuery.of(context).size.width/3,
                              padding:
                                  EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                              onPressed: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(builder: (_) {
                                //     return GettingUserDataScreen("2",widget.ElectronicListFetch[widget.indexFetch].Electronicid.toString());
                                //   }),
                                // );
                                print("UID/////////////////${UID}");
                                print(
                                    "FullName/////////////////${UserFullName}");
                                print(
                                    "ID/////////////////${ElectronicListFetch[0].Electronicid}");
                                print("EmailID/////////////////${UserEmail}");
                                print(
                                    "MobileNumber/////////////////${UserMobile}");
                                print(
                                    "_selectdate/////////////////${_selectdate}");

                                _getRegistrationSubmitData(
                                    "0",
                                    UID,
                                    UserFullName,
                                    ElectronicListFetch[0]
                                        .Electronicid
                                        .toString(),
                                    UserEmail,
                                    UserMobile,
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
                              height: cardsizeheight,
                              width: cardsizewidth,
                              child: ListView.builder(
                                  itemCount: ElectronicProductslist.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ImagesList = ElectronicProductslist[index]
                                        .ElectronicImages
                                        .split("#");
                                    print(
                                        "///////ImagesList//////////////${ImagesList}");
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Material(
                                        elevation: 2,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (_) {
                                              return ElectronicDetailsPage(
                                                  ElectronicProductslist[index].Electronicid.toString());
                                            }));
                                          },
                                          child: Container(
                                            height: cardsizeheight,
                                            width: cardsizewidth,
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(8.0),
                                                    topRight:
                                                        Radius.circular(8.0),
                                                  ),
                                                  child: Container(
                                                    height: picsizeheight,
                                                    width: cardsizewidth,
                                                    child: new Swiper(
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return new Image
                                                            .network(
                                                          ImagesList[index],
                                                          fit: BoxFit.fill,
                                                          //---------------------------
                                                          loadingBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  ImageChunkEvent
                                                                      loadingProgress) {
                                                            if (loadingProgress ==
                                                                null)
                                                              return child;
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: loadingProgress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes
                                                                    : null,
                                                              ),
                                                            );
                                                          },

                                                          //--------------------------
                                                        );
                                                      },
                                                      pagination:
                                                          SwiperPagination(),
                                                      itemCount:
                                                          ImagesList.length,
                                                      itemWidth: picsizeheight,
                                                      //itemHeight: picsizeheight,
                                                      layout:
                                                          SwiperLayout.DEFAULT,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                      "${ElectronicProductslist[index].ElectronicTitle}"),
                                                  subtitle: Text(
                                                      "${ElectronicProductslist[index].ElectronicBrandname}"),
                                                  trailing: Text(
                                                      "${ElectronicProductslist[index].ElectronicPrice}.00"),
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
                          //heading for You might like products
                          Visibility(
                            visible: showsyoumightlike,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("You Might Also Like",
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
                          //Conatiner for You might like products
                          Visibility(
                            visible: showsyoumightlike,
                            child: Container(
                              height: cardsizeheight,
                              width: cardsizewidth,
                              child: ListView.builder(
                                  itemCount: ElectronicAllProductslist.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ImagesListAll =
                                        ElectronicAllProductslist[index]
                                            .ElectronicImages
                                            .split("#");
                                    print(
                                        "///////ImagesListAll//////////////${ImagesListAll}");
                                    return Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Material(
                                        elevation: 2,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (_) {
                                              return ElectronicDetailsPage(
                                                  ElectronicAllProductslist[index].Electronicid.toString());
                                            }));
                                          },
                                          child: Container(
                                            height: cardsizeheight,
                                            width: cardsizewidth,
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(8.0),
                                                    topRight:
                                                        Radius.circular(8.0),
                                                  ),
                                                  child: Container(
                                                    height: picsizeheight,
                                                    width: cardsizewidth,
                                                    child: new Swiper(
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return new Image
                                                            .network(
                                                          ImagesListAll[index],
                                                          fit: BoxFit.fill,
                                                          //---------------------------
                                                          loadingBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  Widget child,
                                                                  ImageChunkEvent
                                                                      loadingProgress) {
                                                            if (loadingProgress ==
                                                                null)
                                                              return child;
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: loadingProgress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes
                                                                    : null,
                                                              ),
                                                            );
                                                          },

                                                          //--------------------------
                                                        );
                                                      },
                                                      pagination:
                                                          SwiperPagination(),
                                                      itemCount:
                                                          ImagesListAll.length,
                                                      itemWidth: picsizeheight,
                                                      //itemHeight: picsizeheight,
                                                      layout:
                                                          SwiperLayout.DEFAULT,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  title: Text(
                                                      "${ElectronicAllProductslist[index].ElectronicTitle}"),
                                                  subtitle: Text(
                                                      "${ElectronicAllProductslist[index].ElectronicBrandname}"),
                                                  trailing: Text(
                                                      "${ElectronicAllProductslist[index].ElectronicPrice}.00"),
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
                          SizedBox(
                            height: 5.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, top: 2.0, bottom: 8.0),
                            child: Center(
                              child: Text(
                                "Top Categories",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                child: ListView.builder(
                                    itemCount: ElectronicTypelist.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_) {
                                              return LaptopItemsPage(
                                                  ElectronicTypelist[index]
                                                      .ElectronicsTypeID
                                                      .toString(),
                                                  ElectronicTypelist[index]
                                                      .ElectronicsTypeName
                                                      .toString());
                                            }),
                                          );
                                        },
                                        child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Container(
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 42,
                                                    backgroundColor:
                                                        primarycolor,
                                                    child: CircleAvatar(
                                                      radius: 40,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Image.asset(
                                                        ElectronicImageList[
                                                            index],
                                                        width: 40.0,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      ElectronicTypelist[index]
                                                          .ElectronicsTypeName,
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      );
                                    })),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    showspinner = true;
    getUserdata();
    _getElectronicIndivibleProductsDetails(widget.indexFetch);
    // Timer(Duration(seconds: 3), () => makeFalse());
    // setState(() {
    //   sepratedImages = imagesHashValue;
    // });
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  }

  makeFalse() {
    setState(() {
      showspinner = false;
    });
  }

  void _getElectronicProducts(String itemid, String exceptid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicProducts fetchelectronicproductsdata =
          new FetchElectronicProducts();
      var fetchelectronicproducts = await fetchelectronicproductsdata
          .getFetchElectronicProducts("2", "1", itemid, exceptid);
      if (fetchelectronicproducts != null) {
        var resid = fetchelectronicproducts["resid"];

        if (resid == 200) {
          var fetchelectronicprodcutssd =
              fetchelectronicproducts["electronicsproductdetailslist"];
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
            this.ElectronicProductslist = tempfetchelectronicprodcutslist;
            print(
                "//////ElectronicProductslist/////////${ElectronicProductslist.length}");

            if (ElectronicProductslist.isEmpty ||
                ElectronicProductslist == null ||
                ElectronicProductslist.length >= 1) {
              print("no Products");
              showsimilarproducts = true;
              showspinner = false;
            } else {
              showsimilarproducts = false;
              showspinner = false;
            }
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

  void _getAllElectronicProducts(String electid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicProducts fetchelectronicproductsdata =
          new FetchElectronicProducts();
      var fetchelectronicproducts = await fetchelectronicproductsdata
          .getFetchElectronicProducts("3", "2", "", electid);
      if (fetchelectronicproducts != null) {
        var resid = fetchelectronicproducts["resid"];

        if (resid == 200) {
          var fetchelectronicprodcutssd =
              fetchelectronicproducts["electronicsallproductdetailslist"];
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
            this.ElectronicAllProductslist = tempfetchelectronicprodcutslist;

            print(
                "//////ElectronicAllProductslist/////////${ElectronicAllProductslist.length}");

            if (ElectronicAllProductslist.isEmpty ||
                ElectronicAllProductslist == null ||
                ElectronicAllProductslist.length < 1) {
              print("no ALL  Products");
              showsyoumightlike = true;
              showspinner = false;
            } else {
              showsyoumightlike = false;
              showspinner = false;
            }
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

  void _getElectronicType() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicType fetchelectronictypedata = new FetchElectronicType();
      var fetchelectronictype =
          await fetchelectronictypedata.getFetchElectronicType("0");
      if (fetchelectronictype != null) {
        var resid = fetchelectronictype["resid"];
        if (resid == 200) {
          var fetchelectronicsd = fetchelectronictype["electronicstype"];
          print(fetchelectronicsd.length);
          List<ElectronicsType> tempfetchelectroniclist = [];
          for (var n in fetchelectronicsd) {
            ElectronicsType pro = ElectronicsType(
              int.parse(n["ElectronicsTypeId"]),
              n["ElectronicsTypeName"],
            );
            tempfetchelectroniclist.add(pro);
          }
          setState(() {
            this.ElectronicTypelist = tempfetchelectroniclist;
          });
          print(
              "//////ElectronicTypelist/////////${ElectronicTypelist.length}");
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



  void _getElectronicIndivibleProductsDetails(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicProducts fetchelectronicproductsdata =
      new FetchElectronicProducts();
      var fetchelectronicproducts = await fetchelectronicproductsdata
          .getFetchElectronicProducts("4", "4", itemid, "");
      if (fetchelectronicproducts != null) {
        var resid = fetchelectronicproducts["resid"];
        if (resid == 200) {
          var fetchelectronicprodcutssd =
          fetchelectronicproducts["electronicslist"];
          print(fetchelectronicprodcutssd.length);
          print(
              "-----------fetchelectronicprodcutssd--------------------------");
          print(fetchelectronicprodcutssd);
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
            //------------------------------------------------------------------------------
            _getelectronicseendetails("6",ElectronicListFetch[0].Electronicid.toString());
            print("Electronicid/////////////////////${ElectronicListFetch[0].Electronicid.toString()}");
            var electid = ElectronicListFetch[0].ElectronicAppliancestypeid.toString();
            var exceptid = ElectronicListFetch[0].Electronicid.toString();
            _getElectronicProducts(electid, exceptid);
            print("////electid////////${electid}");
            print("////exceptid////////${exceptid}");
            _getAllElectronicProducts(electid);
            _getElectronicType();
            title = ElectronicListFetch[0].ElectronicTitle.toString();
            //------------------------------------------------------------------------------
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

  _getRegistrationSubmitData(String actionId, String userid, String username,
      String typeid, String email, String mobileno, String date) async {
    setState(() {
      showspinner = true;
    });
    try {
      InsertElectronicGetOwnerDetails UsertData =
          new InsertElectronicGetOwnerDetails();
      var UsertDatafetch = await UsertData.insertElectronicGetOwnerDetails(
        actionId,
        userid,
        username,
        typeid,
        email,
        mobileno,
        date,
      );
      if (UsertDatafetch != null) {
        print("User data ///${UsertDatafetch}");
        var resid = UsertDatafetch['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "You Will Get Details Soon !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(builder: (_) {
          //     return LaptopItemsPage(
          //         ElectroicProductslist[0]
          //             .ElectronicAppliancestypeid
          //             .toString(),
          //         ElectroicProductslist[0]
          //             .ElectronicAppliancestypename
          //             .toString());
          //   }),
          // );
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return ViewElectronicDetailsPage(
                  ElectronicListFetch[0].Electronicid.toString());
            }),
          );
        } else if (resid == 204) {
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




  //sending notification
  Future<String> _getelectronicseendetails(
      String actionId,
      String ElectonicID,
      ) async {
    setState(() {
      showspinner = true;
    });
    try {
      var insertnotificationData =
      await insertdatanotification.getInsertDataNotification(
        actionId,
        ElectonicID,
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
