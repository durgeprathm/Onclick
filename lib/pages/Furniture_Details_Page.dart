import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/Insert_Data_Notification.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Type.dart';
import 'package:onclickproperty/Adaptor/insert_request_userdata.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
import 'package:onclickproperty/Model/Furniture_Type.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/Furniture_Items_Page.dart';
import 'package:onclickproperty/pages/Getting_User_Data_Page.dart';
import 'package:onclickproperty/pages/View_Furniture_Owner_Details_Page.dart';
import 'package:onclickproperty/pages/Zooming_Products_Images.dart';


class FurnitureDetailsPage extends StatefulWidget {
  @override
  final int indexFetch;
  FurnitureDetailsPage(this.indexFetch);
  _FurnitureDetailsPageState createState() => _FurnitureDetailsPageState();
}

class _FurnitureDetailsPageState extends State<FurnitureDetailsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  InsertDataNotification insertdatanotification = new InsertDataNotification();
  bool showspinner = false;
  bool showsimilarproducts = false;
  bool showsyoumightlike = false;
  bool showsubtype = false;
  String Checkid;
  String title;
  String _selectdate;
  List<String> tempimageList = [];
  List<String> sepratedImages = [];
  List<String> ImagesList = [];
  List<String> ImagesListAll = [];
  List<FurnitureProducts> FurnitureListFetch = new List();
  List<FurnitureProducts> FurnitureProductslist = new List();
  List<FurnitureProducts> FurnitureAllProductslist = new List();
  List<FurnitureType> FurnitureTypelist = new List();
  String UID;
  String UserFullName;
  String UserEmail;
  String UserMobile;

  List<String> FurnitureImageList = [
    "images/bed.png",
    "images/chair.png",
    "images/sofa.png",
    "images/archive.png",
    "images/dresser.png",
    "images/bedside-table.png",
    "images/book-shelf.png",
    "images/books.png",
    "images/recliner.png",
    "images/window.png",
    "images/child.png",
    "images/work-station.png",
  ];
  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);

    UserFullName = await SharedPreferencesConstants.instance
        .getStringValue("userfullname");
    print(UserFullName);

    UserEmail = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USEREMAILID);
    print(UserEmail);

    UserMobile = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
    print(UserMobile);
  }

  @override
  Widget build(BuildContext context) {
    double cardsizewidth = MediaQuery.of(context).size.width * 0.55;
    double cardsizeheight = MediaQuery.of(context).size.height * 0.38;
    double picsizeheight = MediaQuery.of(context).size.height * 0.25;
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    double picsize = MediaQuery.of(context).size.width;
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
          "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].FurniturnTitle: ""}",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.normal,
            color: primarycolor,
          ),
        ),
        actions: [],
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8.0, right: 8.0, bottom: 0.0),
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
                              // borderRadius: BorderRadius.only(
                              //   topLeft: Radius.circular(8.0),
                              //   topRight: Radius.circular(8.0),
                              // ),
                              child: Stack(
                                children: <Widget>[
                                  Container(
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
                                  Positioned(
                                    bottom: 5,
                                    left: 360,
                                    //right:35,
                                    // top:35,
                                    child: Container(
                                        alignment: Alignment.center,
                                        child: Center(
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: FaIcon(
                                                  FontAwesomeIcons.shareAlt,
                                                  size: 20.0,
                                                  color: primarycolor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].FurniturnDescription : ""}",
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
                                "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].FurniturnPrice : "" }",
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
                                              "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].FurnitureCondition : ""}",
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
                                              "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].FurniturnBrand : ""}",
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
                                              "Quntity",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].FurniturnQuntity : ""}",
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
                                    Visibility(
                                      visible: showsubtype,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Furniture Sub Type",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].FurnitureSubTypename  :""}",
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: showsubtype,
                                      child: Divider(
                                        height: 5.0,
                                        thickness: 1.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Furniture material",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].FurniturnMaterial : ""}",
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
                                              "Furniture Type",
                                              style: TextStyle(
                                                  fontSize: 15.0,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].Furnituretypename : ""}",
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
                                              "${FurnitureListFetch.isNotEmpty ? FurnitureListFetch[0].FurniturnYouAre : ""}",
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
                                //     return GettingUserDataScreen("1",widget.FurnitureListFetch[widget.indexFetch].Furnitureid.toString());
                                //   }),
                                // );
                                print("//////////UID//////////${UID}");
                                print(
                                    "//////////UserName//////////${UserFullName}");
                                print(
                                    "//////////EmailID//////////${UserEmail}");
                                print(
                                    "//////////MobileNumber//////////${UserMobile}");
                                print(
                                    "//////////_selectdate//////////${_selectdate}");
                                print(
                                    "//////////FurnitutrID//////////${FurnitureListFetch[0].Furnitureid.toString()}");
                                _getRegistrationSubmitData(
                                    "0",
                                    UID,
                                    UserFullName,
                                    FurnitureListFetch[0].Furnitureid
                                        .toString(),
                                    UserEmail,
                                    UserMobile,
                                    _selectdate);
                                // print(resid);
                              },
                              child: Text("Get Owner Details",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          //you Similar Products heading
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
                          //you Similar Products Container
                          Visibility(
                            visible: showsimilarproducts,
                            child: Container(
                              height: cardsizeheight,
                              width: cardsizewidth,
                              child: ListView.builder(
                                  itemCount: FurnitureProductslist.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ImagesList = FurnitureProductslist[index]
                                        .EFurniturnImages
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
                                              return FurnitureDetailsPage(
                                                   FurnitureProductslist[index].Furnitureid);
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
                                                      "${FurnitureProductslist[index].FurniturnTitle}"),
                                                  subtitle: Text(
                                                      "${FurnitureProductslist[index].FurniturnBrand}"),
                                                  trailing: Text(
                                                      "${FurnitureProductslist[index].FurniturnPrice}.00"),
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
                          //you may like heading
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
                          //you may like Conatiner
                          Visibility(
                            visible: showsyoumightlike,
                            child: Container(
                              height: cardsizeheight,
                              width: cardsizewidth,
                              child: ListView.builder(
                                  itemCount: FurnitureAllProductslist.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    ImagesListAll =
                                        FurnitureAllProductslist[index]
                                            .EFurniturnImages
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
                                              return FurnitureDetailsPage(
                                                  FurnitureAllProductslist[index].Furnitureid);
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
                                                      "${FurnitureAllProductslist[index].FurniturnTitle}"),
                                                  subtitle: Text(
                                                      "${FurnitureAllProductslist[index].FurniturnBrand}"),
                                                  trailing: Text(
                                                      "${FurnitureAllProductslist[index].FurniturnPrice}.00"),
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
                                    itemCount: FurnitureTypelist.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_) {
                                              return FurnitureItemsPage(
                                                  FurnitureTypelist[index]
                                                      .FurnitureTypeID
                                                      .toString(),
                                                  FurnitureTypelist[index]
                                                      .FurnitureTypeName
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
                                                        FurnitureImageList[
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
                                                      FurnitureTypelist[index]
                                                          .FurnitureTypeName,
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
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: FlatButton(
                  //         shape: RoundedRectangleBorder(
                  //           //borderRadius: new BorderRadius.circular(10.0),
                  //         ),
                  //         color: primarycolor,
                  //         //minWidth: MediaQuery.of(context).size.width/3,
                  //         padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                  //         onPressed: () {
                  //           //   Navigator.of(context).push(
                  //           //     MaterialPageRoute(builder: (_) {
                  //           //       return HomePage();
                  //           //     }),
                  //           //   );
                  //         },
                  //         child: Text("GO TO CART",
                  //             textAlign: TextAlign.center,
                  //             style: style.copyWith(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold)),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: FlatButton(
                  //         shape: RoundedRectangleBorder(
                  //           // borderRadius: new BorderRadius.circular(10.0),
                  //         ),
                  //         color: primarycolor,
                  //         //minWidth: MediaQuery.of(context).size.width/3,
                  //         padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                  //         onPressed: () {
                  //           //   Navigator.of(context).push(
                  //           //     MaterialPageRoute(builder: (_) {
                  //           //       return HomePage();
                  //           //     }),
                  //           //   );
                  //         },
                  //         child: Text("BUY NOW",
                  //             textAlign: TextAlign.center,
                  //             style: style.copyWith(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold)),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
    );
  }

  @override
  void initState() {
    showspinner = true;
    getUserdata();
    _getFurnitureIndivisibleProductsDetails(widget.indexFetch.toString());
    _getfurnitureseendetails("4",widget.indexFetch.toString());
    print("furnitureid//////////${widget.indexFetch.toString()}");
    Timer(Duration(seconds: 3), () => makeFalse());
    _getFurnitureType();
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  }

  makeFalse() {
    setState(() {
      showspinner = false;
    });
  }

  void _getFurnitureProducts(String itemid, String exceptid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchFurnitureProducts fetchfurnitureproductsdata =
          new FetchFurnitureProducts();
      var fetchfurnitureproducts = await fetchfurnitureproductsdata
          .getFetchFurnitureProducts("2", "1", itemid, exceptid);
      if (fetchfurnitureproducts != null) {
        var resid = fetchfurnitureproducts["resid"];

        if (resid == 200) {
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
            print(
                "//////FurnitureProductslist before/////////${FurnitureProductslist.length}");

            if (FurnitureProductslist.isEmpty ||
                FurnitureProductslist == null ||
                FurnitureProductslist.length >= 1) {
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

  void _getFurnitureAllProducts(String exceptid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchFurnitureProducts fetchfurnitureproductsdata =
          new FetchFurnitureProducts();
      var fetchfurnitureproducts = await fetchfurnitureproductsdata
          .getFetchFurnitureProducts("3", "2", "", exceptid);
      if (fetchfurnitureproducts != null) {
        var resid = fetchfurnitureproducts["resid"];

        if (resid == 200) {
          var fetchfurnitureprodcutssd =
              fetchfurnitureproducts["furnitureallproductlist"];
          print(fetchfurnitureprodcutssd.length);
          List<FurnitureProducts> tempfetchfurnitureAllprodcutslist = [];
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
            tempfetchfurnitureAllprodcutslist.add(pro);
          }
          setState(() {
            this.FurnitureAllProductslist = tempfetchfurnitureAllprodcutslist;

            print(
                "//////FurnitureAllProductslist before/////////${FurnitureAllProductslist.length}");

            if (FurnitureAllProductslist.isEmpty ||
                FurnitureAllProductslist == null ||
                FurnitureAllProductslist.length >= 1) {
              print("no All Products");
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

  void _getFurnitureType() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchFurnitureType fetchfurnituretypedata = new FetchFurnitureType();
      var fetchfurniturestype =
          await fetchfurnituretypedata.getFetchFurnitureType("0");
      if (fetchfurniturestype != null) {
        var resid = fetchfurniturestype["resid"];
        if (resid == 200) {
          var fetchfurnituresd = fetchfurniturestype["furnituretype"];
          print(fetchfurnituresd.length);
          List<FurnitureType> tempfetchFurniture = [];
          for (var n in fetchfurnituresd) {
            FurnitureType pro = FurnitureType(
              int.parse(n["FurnitureID"]),
              n["FurnitureName"],
            );
            tempfetchFurniture.add(pro);
          }
          setState(() {
            this.FurnitureTypelist = tempfetchFurniture;
          });
          print("//////FurnitureTypelist/////////${FurnitureTypelist.length}");
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

  void _getFurnitureIndivisibleProductsDetails(String itemid) async {
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
              this.FurnitureListFetch = tempfetchfurnitureprodcutslist;
              //------------------------------------------
              var imagesHashValue =
                  FurnitureListFetch[0].EFurniturnImages;
              print("///////imagesHashValue//////////////${imagesHashValue}");
              setState(() {
                sepratedImages = imagesHashValue.split("#");
              });
              //----------------------------------
              title =
                  FurnitureListFetch[0].FurniturnTitle.toString();
//------------------------------------------------------------------------------------------
              //for checking subtype
              Checkid =
                  FurnitureListFetch[0].Furnituretypeid.toString();
              print(Checkid);
              if (Checkid == "1" || Checkid == "2" || Checkid == "3") {
                showsubtype = true;
              } else {
                showsubtype = false;
              }

              var electid =
              FurnitureListFetch[0].Furnituretypeid.toString();
              var exceptid =
              FurnitureListFetch[0].Furnitureid.toString();

              _getFurnitureProducts(electid, exceptid);

              print("////electid////////${electid}");
              print("////exceptid////////${exceptid}");

              _getFurnitureAllProducts(electid);
//------------------------------------------------------------------------------------------
              showspinner = false;
            });

            print(
                "//////FurnitureListFetch/////////${FurnitureListFetch.length}");
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




  _getRegistrationSubmitData(String actionId, String userid, String username,
      String typeid, String email, String mobileno, String date) async {
    setState(() {
      showspinner = true;
    });
    try {
      InsertUserRequest UsertData = new InsertUserRequest();
      var UsertDatafetch = await UsertData.insertUserRequest(
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
          // Navigator.of(context).pushReplacement(
          // MaterialPageRoute(builder: (_) {
          //   return FurnitureItemsPage(
          //       FurnitureProductslist[0].Furnituretypeid.toString(),
          //       FurnitureProductslist[0].Furnituretypename);

          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return ViewFurnitureDetailsPage(
                  FurnitureListFetch[0].Furnitureid.toString());
            }),
          );
          // }),
          // );
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
  Future<String> _getfurnitureseendetails(
      String actionId,
      String FurnitureID,
      ) async {
    setState(() {
      showspinner = true;
    });
    try {
      var insertnotificationData =
      await insertdatanotification.getInsertDataNotification(
        actionId,
        FurnitureID,
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
