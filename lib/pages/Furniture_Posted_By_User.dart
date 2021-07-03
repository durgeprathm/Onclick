import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/User_Posted_Items_Adaptor.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
import 'package:onclickproperty/Model/Furniture_Type.dart';
import 'package:onclickproperty/Model/toppropertylist_model.dart';
import 'package:onclickproperty/Providers/top_propertieslist_provider.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/User_posted_furniture_Details_Page.dart';
import 'package:onclickproperty/pages/update_property_details.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class FurniturePostedByUserListScreen extends StatefulWidget {
  @override
  _FurniturePostedByUserListScreenState createState() =>
      _FurniturePostedByUserListScreenState();
}

class _FurniturePostedByUserListScreenState
    extends State<FurniturePostedByUserListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TopPropertiesNotifier notifier;
  var _locationSearchController = TextEditingController();
  bool showspinner = false;

  List<FurnitureProducts> Furniturelist = new List();

  @override
  void initState() {
    super.initState();
    _getFurniturelist();
    //print('_PropertiesPostedByUserListScreenState initState');
    notifier = TopPropertiesNotifier();
    notifier.getMorePostedByUser('3');
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double picsize = MediaQuery.of(context).size.width / 2;
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
              title: Text(
                "Posted Furniture",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: primarycolor,
                ),
              )),
          // flexibleSpace: SomeWidget(),
          body: SafeArea(
            child: Container(
              child: showspinner
                  ?  Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                onRefresh: () async {
                  return await notifier.reloadPostedByUser('3');
                },
                child: Furniturelist.length=='0'
                    ? Container(
                  height: 50,
                  child: ListView.builder(
                      physics:
                      const AlwaysScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder:
                          (BuildContext context, int index) {
                        return const Center(
                            child: Text('No Furniture!'));
                      }),
                )
                    : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo is ScrollEndNotification &&
                          scrollInfo.metrics.extentAfter == 0) {
                        notifier.getMorePostedByUser('3');
                        return true;
                      }
                      return false;
                    },
                    child: Container(
                      child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                          itemCount: Furniturelist.length,
                          cacheExtent: 5,
                          itemBuilder: (contextt, index) {
                            List<String> imagelist =
                            Furniturelist[index].EFurniturnImages.split("#");
                            var id = Furniturelist[index].Furnitureid.toString();
                            print(
                                "//////id/////////////////////////${id}");
                            return Stack(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) {
                                        return UserPostedFurniturePage(
                                            Furniturelist[index]
                                                .Furnitureid
                                                .toString());
                                      }),
                                    );
                                  },
                                  child: Material(
                                    borderRadius:
                                    BorderRadius.circular(10.0),
                                    elevation: 5.0,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .stretch,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.only(
                                              topLeft:
                                              Radius.circular(
                                                  8.0),
                                              topRight:
                                              Radius.circular(
                                                  8.0),
                                            ),
                                            child: Container(
                                              height: 200,
                                              width: picsize,
                                              child: new Swiper(
                                                itemBuilder:
                                                    (BuildContext
                                                context,
                                                    int index) {
                                                  return new Image
                                                      .network(
                                                    imagelist[
                                                    index],
                                                    fit: BoxFit
                                                        .cover,
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
                                                pagination:
                                                SwiperPagination(),
                                                itemCount: imagelist
                                                    .length,
                                                itemWidth: 300.0,
                                                layout: SwiperLayout
                                                    .DEFAULT,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Text(
                                                    Furniturelist[index]
                                                        .Furnituretypename,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight
                                                            .bold,
                                                        fontSize:
                                                        15.0),
                                                  ),
                                                  // Text(
                                                  //   Furniturelist[index]
                                                  //       .FurniturnBrand,
                                                  //   style: TextStyle(
                                                  //       fontWeight:
                                                  //       FontWeight
                                                  //           .normal,
                                                  //       fontSize:
                                                  //       12.0),
                                                  // ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Expanded(
                                                        flex: 3,
                                                        child:
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                          child:
                                                          Row(
                                                            children: [
                                                              FaIcon(
                                                                FontAwesomeIcons.rupeeSign,
                                                                size:
                                                                20.0,
                                                                color:
                                                                primarycolor,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                5.0,
                                                              ),
                                                              Text(
                                                                  Furniturelist[index].FurniturnPrice != null ? Furniturelist[index].FurniturnPrice : '',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 12.0,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child:
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                          child:
                                                          Row(
                                                            children: [
                                                              FaIcon(
                                                                FontAwesomeIcons.industry,
                                                                size:
                                                                20.0,
                                                                color:
                                                                primarycolor,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                5.0,
                                                              ),
                                                              Text(
                                                                  Furniturelist[index].FurniturnBrand != null ? Furniturelist[index].FurniturnBrand : '',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 12.0,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child:
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                          child:
                                                          Row(
                                                            children: [
                                                              FaIcon(
                                                                FontAwesomeIcons.chartArea,
                                                                size:
                                                                20.0,
                                                                color:
                                                                primarycolor,
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                5.0,
                                                              ),
                                                              Text(
                                                                  Furniturelist[index].FurniturnMaterial != null ? Furniturelist[index].FurniturnMaterial : '',
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 12.0,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   child: InkWell(
                                                      //     borderRadius:
                                                      //         BorderRadius.circular(
                                                      //             50),
                                                      //     onTap:
                                                      //         () {},
                                                      //     child:
                                                      //         Container(
                                                      //       padding:
                                                      //           EdgeInsets.all(getProportionateScreenWidth(8)),
                                                      //       height:
                                                      //           getProportionateScreenWidth(28),
                                                      //       width: getProportionateScreenWidth(
                                                      //           28),
                                                      //       decoration:
                                                      //           BoxDecoration(
                                                      //         color: value[index].isFavourite
                                                      //             ? kPrimaryColor.withOpacity(0.15)
                                                      //             : kSecondaryColor.withOpacity(0.1),
                                                      //         shape:
                                                      //             BoxShape.circle,
                                                      //       ),
                                                      //       child: SvgPicture
                                                      //           .asset(
                                                      //         "assets/icons/Heart Icon_2.svg",
                                                      //         color: value[index].isFavourite
                                                      //             ? Color(0xFFFF4848)
                                                      //             : Color(0xFFDBDEE4),
                                                      //       ),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 20,
                                right: 30,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(50),
                                  ),
                                  child: SizedBox(
                                    height: 30,
                                    width: 80,
                                    child: InkWell(
                                        onTap: () {
                                          // sendFavData(value, index,
                                          // value[index].Id);
                                        },
                                        child: Center(
                                          child: Container(
                                            color: Furniturelist[index]
                                                .FurniturnApprove ==
                                                '0'
                                                ? Colors.redAccent
                                                : Colors.green,
                                            child:
                                            new OutlineButton(
                                                child: Center(
                                                  child: Furniturelist[index]
                                                      .FurniturnApprove ==
                                                      '0'
                                                      ? new Text(
                                                    "Pending",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12.0,
                                                        color: Colors.white),
                                                  )
                                                      : new Text(
                                                    "verified",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12.0,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                onPressed: null,
                                                shape: new RoundedRectangleBorder(
                                                    borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0))),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ]);
                          }),
                    )),
              )
                  ,
            ),
          ),
        );
  }

  void _getFurniturelist() async {
    setState(() {
      showspinner = true;
    });
    try {
      UserPostedItemsAdapoter fetchfurnituretypedata = new UserPostedItemsAdapoter();
      var fetchfurniturestype =
      await fetchfurnituretypedata.getUserPostedItemsAdapoter("0");
      if (fetchfurniturestype != null) {
        var rowcount = fetchfurniturestype["rowcount"];
       if(rowcount>=1)
         {
           var resid = fetchfurniturestype["resid"];
           if (resid == 200) {
             var fetchfurnituresd = fetchfurniturestype["UserFurnitureList"];
             print(fetchfurnituresd.length);
             List<FurnitureProducts> tempfetchFurniture = [];
             for (var n in fetchfurnituresd) {
               FurnitureProducts pro = FurnitureProducts.userposted(
                 int.parse(n["id"]),
                 n["brand"],
                 n["price"],
                 n["furniturematerial"],
                 int.parse(n["furnituretypeid"]),
                 n["furnituretypename"],
                 n["approve"],
                 n["img"],
               );
               tempfetchFurniture.add(pro);
             }
             setState(() {
               this.Furniturelist = tempfetchFurniture;
             });
             print("//////Furniturelist/////////${Furniturelist.length}");
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
         }else
           {
             setState(() {
               showspinner = false;
             });
             _scaffoldKey.currentState.showSnackBar(SnackBar(
               content: Text("No Furniture Products Posted Yet"),
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
