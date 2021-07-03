import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Type.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
import 'package:onclickproperty/Model/Furniture_Type.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/FurnitureUpdatedDetails_User_Posted.dart';
import 'package:onclickproperty/pages/Furniture_Items_Page.dart';
import 'package:onclickproperty/pages/Zooming_Products_Images.dart';
import 'package:onclickproperty/pages/owner_details/getting_user_data_screen.dart';

class UserPostedFurniturePage extends StatefulWidget {
  @override
  final String indexFetch;
  UserPostedFurniturePage(this.indexFetch);
  _UserPostedFurniturePageState createState() => _UserPostedFurniturePageState();
}

class _UserPostedFurniturePageState extends State<UserPostedFurniturePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner = false;
  bool showsimilarproducts = false;
  bool showsyoumightlike = false;
  bool showsubtype = false;
  String Checkid;
  String title;
  List<String> tempimageList = [];
  List<String> sepratedImages = [];
  List<String> ImagesList = [];
  List<String> ImagesListAll = [];
  List<FurnitureProducts> FurnitureProductslist = new List();

  // List<String> FurnitureImageList = [
  //   "images/bed.png",
  //   "images/chair.png",
  //   "images/sofa.png",
  //   "images/archive.png",
  //   "images/dresser.png",
  //   "images/bedside-table.png",
  //   "images/book-shelf.png",
  //   "images/books.png",
  //   "images/recliner.png",
  //   "images/window.png",
  //   "images/child.png",
  //   "images/work-station.png",
  // ];

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
        title: showspinner ? Text("") : Text(
          "${FurnitureProductslist[0].FurniturnTitle}",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.normal,
            color: primarycolor,
          ),
        ),
        actions: [

        ],
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0,bottom: 0.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap:()
                      {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return ZoomingProductsImages(sepratedImages,title);
                        }),);
                        print("///////sending images to zoom//////////////////////${sepratedImages}");
                      },
                      child: ClipRRect(
                        // borderRadius: BorderRadius.only(
                        //   topLeft: Radius.circular(8.0),
                        //   topRight: Radius.circular(8.0),
                        // ),
                        child: Stack(
                          children:<Widget> [
                            Container(
                              height: 200,
                              width: picsize,
                              child: new Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return new Image.network(
                                    sepratedImages[index],
                                    fit: BoxFit.fill,

                                    //---------------------------
                                    loadingBuilder: (BuildContext
                                    context,
                                        Widget child,
                                        ImageChunkEvent
                                        loadingProgress) {
                                      if (loadingProgress ==
                                          null) return child;
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
                                pagination: SwiperPagination(),
                                itemCount: sepratedImages.length,
                                itemWidth: 300.0,
                                layout: SwiperLayout.DEFAULT,
                              ),
                            ),
                            Positioned(
                              bottom:5,
                              left: 360,
                              //right:35,
                              // top:35,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: ()
                                          {

                                          },
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
                      FurnitureProductslist[0].FurniturnDescription == null ? "" :"${FurnitureProductslist[0].FurniturnDescription}",
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
                          FurnitureProductslist[0].FurniturnPrice==null ? ""  : "${FurnitureProductslist[0].FurniturnPrice}.00",
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
                                        FurnitureProductslist[0].FurnitureCondition==null ? "" : "${FurnitureProductslist[0].FurnitureCondition}",
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
                                        FurnitureProductslist[0].FurniturnBrand==null ? "" : "${FurnitureProductslist[0].FurniturnBrand}",
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
                                        FurnitureProductslist[0].FurniturnQuntity==null ? "" :  "${FurnitureProductslist[0].FurniturnQuntity}",
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
                                          FurnitureProductslist[0].FurnitureSubTypename==null ?"" : "${FurnitureProductslist[0].FurnitureSubTypename}",
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
                                        FurnitureProductslist[0].FurniturnMaterial==null ? "" :"${FurnitureProductslist[0].FurniturnMaterial}",
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
                                        FurnitureProductslist[0].Furnituretypename==null ? "" :  "${FurnitureProductslist[0].Furnituretypename}",
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
                                        FurnitureProductslist[0].FurniturnYouAre ==null ? "" :"${FurnitureProductslist[0].FurniturnYouAre}",
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
                        padding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return FurnitureUserPostedUpdatedPage(FurnitureProductslist[0].Furnitureid.toString());
                            }),
                          );
                        },
                        child: Text("Update Details",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5.0,
                    // ),
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
    setState(() {
      showspinner = true;
    });
    _getFurnitureProducts(widget.indexFetch.toString());
    print("/////////furnitureid////////////////////////${widget.indexFetch.toString()}//////");
    // showspinner = true;
    // Timer(Duration(seconds: 3), () => makeFalse());
  }

  // makeFalse() {
  //   setState(() {
  //     showspinner = false;
  //   });
  // }

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
        print("///////////////////-----------------------Furniture Response-------------------------");
        print(fetchfurnitureproducts);
        print("///////////////////-----------------------Furniture Response-------------------------");
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
              var imagesHashValue =
                  FurnitureProductslist[0].FurniturnImages;
              print("///////imagesHashValue//////////////${imagesHashValue}");
              setState(() {
                sepratedImages = imagesHashValue.split("#");
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
