import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/insert_fav_list.dart';
import 'package:onclickproperty/Model/toppropertylist_model.dart';
import 'package:onclickproperty/Providers/top_propertieslist_provider.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/filter_config_screen.dart';
import 'package:onclickproperty/pages/property_details.dart';
import 'package:onclickproperty/pages/sort_show_bottom_sheet.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class FilterPropertyListScreen extends StatefulWidget {
  final String tabType;
  final String actionid;
  final String lookingfor;
  final String location;
  final String pincode;
  final String bedrooms;
  final String propertytypes;
  final String squrefeetstart;
  final String squrefeetend;
  final String bathroom;
  final String pricestart;
  final String priceend;
  final String Furniture;
  final String PostedBy;
  final String address;

  FilterPropertyListScreen(
      this.tabType,
      this.actionid,
      this.lookingfor,
      this.location,
      this.pincode,
      this.bedrooms,
      this.propertytypes,
      this.squrefeetstart,
      this.squrefeetend,
      this.bathroom,
      this.pricestart,
      this.priceend,
      this.Furniture,
      this.PostedBy,
      this.address);

  @override
  _FilterPropertyListScreenState createState() =>
      _FilterPropertyListScreenState(
          this.tabType,
          this.actionid,
          this.lookingfor,
          this.location,
          this.pincode,
          this.bedrooms,
          this.propertytypes,
          this.squrefeetstart,
          this.squrefeetend,
          this.bathroom,
          this.pricestart,
          this.priceend,
          this.Furniture,
          this.PostedBy,
          this.address);
}

class _FilterPropertyListScreenState extends State<FilterPropertyListScreen> {
  final String tabType;
  final String actionid;
  final String lookingfor;
  final String location;
  final String pincode;
  String bedrooms;
  String propertytypes;
  final String squrefeetstart;
  final String squrefeetend;
  String bathroom;
  final String pricestart;
  final String priceend;
  String Furniture;
  final String address;
  String PostedBy;

  _FilterPropertyListScreenState(
      this.tabType,
      this.actionid,
      this.lookingfor,
      this.location,
      this.pincode,
      this.bedrooms,
      this.propertytypes,
      this.squrefeetstart,
      this.squrefeetend,
      this.bathroom,
      this.pricestart,
      this.priceend,
      this.Furniture,
      this.PostedBy,
      this.address);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TopPropertiesNotifier notifier;
  bool showspinner = false;
  String UID;
  String title;
  int sortRadioValue = 1;

  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
  }

  @override
  void initState() {
    super.initState();
    if (tabType == '1') {
      title = 'Residential';
    } else if (tabType == '2') {
      title = 'Commerical';
    } else if (tabType == '3') {
      title = 'Project';
    }
    notifier = TopPropertiesNotifier();
    notifier.getMoreFilterPropertyList(
        tabType,
        actionid,
        lookingfor,
        location,
        pincode,
        bedrooms,
        propertytypes,
        squrefeetstart,
        squrefeetend,
        bathroom,
        pricestart,
        priceend,
        Furniture,
        PostedBy,
        sortRadioValue.toString());
    getUserdata();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double picsize = MediaQuery.of(context).size.width / 2;
    double listHeight = MediaQuery.of(context).size.height * 0.75;
    double bottomHeight = MediaQuery.of(context).size.height * 0.07;

    return ValueListenableBuilder<List<PropertyListModel>>(
      valueListenable: notifier,
      builder:
          (BuildContext context, List<PropertyListModel> value, Widget child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
              title: Text(
                "${title} Property",
                style: appbarTitleTextStyle,
              )),
          // flexibleSpace: SomeWidget(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                      child: Container(
                        width: SizeConfig.screenWidth * 0.6,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: primarycolor,
                            ),
                            SizedBox(
                              width: getProportionateScreenWidth(5),
                            ),
                            Text(
                              '$address',
                              style: locationAddheadingStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    value != null
                        ? RefreshIndicator(
                            onRefresh: () async {
                              return await notifier.reloadFilterPropertyList(
                                  tabType,
                                  actionid,
                                  lookingfor,
                                  location,
                                  pincode,
                                  bedrooms,
                                  propertytypes,
                                  squrefeetstart,
                                  squrefeetend,
                                  bathroom,
                                  pricestart,
                                  priceend,
                                  Furniture,
                                  PostedBy,
                                  sortRadioValue.toString());
                            },
                            child: value.isEmpty
                                ? Container(
                                    height: 50,
                                    child: ListView.builder(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemCount: 1,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return const Center(
                                              child: Text('No Properties!'));
                                        }),
                                  )
                                : NotificationListener<ScrollNotification>(
                                    onNotification:
                                        (ScrollNotification scrollInfo) {
                                      if (scrollInfo is ScrollEndNotification &&
                                          scrollInfo.metrics.extentAfter == 0) {
                                        notifier.getMoreFilterPropertyList(
                                            tabType,
                                            actionid,
                                            lookingfor,
                                            location,
                                            pincode,
                                            bedrooms,
                                            propertytypes,
                                            squrefeetstart,
                                            squrefeetend,
                                            bathroom,
                                            pricestart,
                                            priceend,
                                            Furniture,
                                            PostedBy,
                                            sortRadioValue.toString());
                                        return true;
                                      }
                                      return false;
                                    },
                                    child: Container(
                                      height: listHeight,
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Divider(),
                                              ),
                                          itemCount: value.length,
                                          cacheExtent: 5,
                                          itemBuilder: (contextt, index) {
                                            List<String> imagelist =
                                                value[index]
                                                    .Topimglink
                                                    .split("#");
                                            var id = value[index].Id.toString();
                                            print(
                                                "//////id/////////////////////////${id}");
                                            return Stack(children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                        return PropertyDetailsPage(
                                                            value[index]
                                                                .Id
                                                                .toString(),
                                                            tabType.toString());
                                                      }),
                                                    ).then((value) =>
                                                        reloadList(value));
                                                  },
                                                  child: Material(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    elevation: 5.0,
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: <Widget>[
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                              topRight: Radius
                                                                  .circular(
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
                                                                  );
                                                                },
                                                                pagination:
                                                                    SwiperPagination(),
                                                                itemCount:
                                                                    imagelist
                                                                        .length,
                                                                itemWidth:
                                                                    300.0,
                                                                layout:
                                                                    SwiperLayout
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
                                                                    value[index]
                                                                        .Tagline,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontSize:
                                                                            15.0),
                                                                  ),
                                                                  Text(
                                                                    value[index]
                                                                        .Tagline2,
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .normal,
                                                                        fontSize:
                                                                            12.0),
                                                                  ),
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
                                                                              const EdgeInsets.all(3.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              FaIcon(
                                                                                FontAwesomeIcons.wrench,
                                                                                size: 20.0,
                                                                                color: primarycolor,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5.0,
                                                                              ),
                                                                              Text(value[index].Price,
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
                                                                              const EdgeInsets.all(3.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              FaIcon(
                                                                                FontAwesomeIcons.wrench,
                                                                                size: 20.0,
                                                                                color: primarycolor,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5.0,
                                                                              ),
                                                                              Text(value[index].Furnishing,
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
                                                                              const EdgeInsets.all(3.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              FaIcon(
                                                                                FontAwesomeIcons.chartArea,
                                                                                size: 20.0,
                                                                                color: primarycolor,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 5.0,
                                                                              ),
                                                                              Text(value[index].PropertySize,
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
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: InkWell(
                                                      // borderRadius:
                                                      //     BorderRadius.circular(
                                                      //         50),
                                                      onTap: () {
                                                        sendFavData(
                                                            value,
                                                            index,
                                                            value[index].Id);
                                                      },
                                                      child: Center(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            // color: value[index]
                                                            //         .isFavourite
                                                            //     ? kPrimaryColor
                                                            //         .withOpacity(
                                                            //             0.20)
                                                            //     : kSecondaryColor
                                                            //         .withOpacity(
                                                            //             0.1),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/icons/Heart Icon_2.svg",
                                                            color: value[index]
                                                                    .isFavourite
                                                                ? Color(
                                                                    0xFFFF4848)
                                                                : Color(
                                                                    0xFFDBDEE4),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ]);
                                          }),
                                    )),
                          )
                        : Center(child: CircularProgressIndicator()),
                    Visibility(
                      visible: value != null
                          ? value.length != 0
                              ? true
                              : false
                          : false,
                      child: Container(
                        height: bottomHeight,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                              child: Container(
                                            color: Colors.transparent,
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: SortShowBottomSheet(
                                                sortRadioValue,
                                                getSortRadioValue),
                                          )));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  height: bottomHeight,
                                  // color: Colors.blueGrey,
                                  child: ListTile(
                                    leading: FaIcon(
                                      FontAwesomeIcons.sort,
                                      color: primarycolor,
                                    ),
                                    title: Text(
                                      "Sort",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              // color: Colors.grey,
                              thickness: 1,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                              child: Container(
                                            color: Colors.transparent,
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: FilterConfigScreen(
                                                tabType,
                                                actionid,
                                                lookingfor,
                                                location,
                                                pincode,
                                                bedrooms,
                                                propertytypes,
                                                squrefeetstart,
                                                squrefeetend,
                                                bathroom,
                                                pricestart,
                                                priceend,
                                                Furniture,
                                                PostedBy,
                                                sortRadioValue.toString(),
                                                getFilterData),
                                          )));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  height: bottomHeight,
                                  child: ListTile(
                                    leading: FaIcon(
                                      FontAwesomeIcons.filter,
                                      color: primarycolor,
                                    ),
                                    title: Text("Filter"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  sendFavData(value, int index, String pid) async {
    final item = value[index];
    setState(() {
      item.isFavourite = !item.isFavourite;
      print('sendFavData: $item');
      print('sendFavData: ${item.isFavourite}');
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

  reloadList(value) async {
    print("reloadList Call: $value");
    notifier = TopPropertiesNotifier();
    await notifier
      ..getMoreFilterPropertyList(
          tabType,
          actionid,
          lookingfor,
          location,
          pincode,
          bedrooms,
          propertytypes,
          squrefeetstart,
          squrefeetend,
          bathroom,
          pricestart,
          priceend,
          Furniture,
          PostedBy,
          sortRadioValue.toString());
  }

  getSortRadioValue(value) {
    setState(() {
      sortRadioValue = value;
      reloadList(true);
    });
  }

  getFilterData(JoinedBedRooms, JoinedtypeOfProperty, JoinedPostedBy,
      _bathroomType, JoinedFurnishing) async {
    // print(JoinedBedRooms); print(JoinedtypeOfProperty); print(JoinedPostedBy); print(_bathroomType);print(JoinedFurnishing);
    setState(() {
      bedrooms = JoinedBedRooms;
      propertytypes = JoinedtypeOfProperty;
      PostedBy = JoinedPostedBy;
      bathroom = _bathroomType;
      Furniture = JoinedFurnishing;
    });

    notifier = TopPropertiesNotifier();
    await notifier
      ..getMoreFilterPropertyList(
          tabType,
          actionid,
          lookingfor,
          location,
          pincode,
          bedrooms,
          propertytypes,
          squrefeetstart,
          squrefeetend,
          bathroom,
          pricestart,
          priceend,
          Furniture,
          PostedBy,
          sortRadioValue.toString());
  }
}
