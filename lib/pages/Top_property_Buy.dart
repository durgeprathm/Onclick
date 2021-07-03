import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Insert_Data_Notification.dart';
import 'package:onclickproperty/Adaptor/fetch_House_Type.dart';
import 'package:onclickproperty/Adaptor/insert_fav_list.dart';
import 'package:onclickproperty/Model/House_Type.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/filltershowbottomsheet.dart';
import 'package:onclickproperty/pages/property_details.dart';
import 'package:http/http.dart' as http;
import 'package:onclickproperty/Model/toppropertylist_model.dart';
import 'package:onclickproperty/Providers/top_propertieslist_provider.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class TopPropertyBuy extends StatefulWidget {
  final String actiond;
  final String ptype;
  final String checktype;
  final String agentid;
  final String localityname;
  final String usertype;

  TopPropertyBuy(this.actiond, this.ptype, this.checktype, this.agentid,
      this.localityname, this.usertype);

  @override
  _TopPropertyBuyState createState() => _TopPropertyBuyState();
}

class _TopPropertyBuyState extends State<TopPropertyBuy> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TopPropertiesNotifier notifier;
  var _locationSearchController = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  String localityName = "Mumbai";
  bool visLocSearch = false;
  bool showspinner = false;
  List<HouseType> bhkTypelist = [];
  String UID;

  @override
  void initState() {
    _getBHKType();
    super.initState();
    notifier = TopPropertiesNotifier();
    notifier.getMore(widget.actiond, widget.ptype, widget.checktype,
        widget.agentid, widget.localityname, widget.usertype);
    getUserdata();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
  }

  _onLocationSearchChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getLocationListSuggestion(_locationSearchController.text);
  }

  void getLocationListSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyA8k5z6GiCXvSa9JifqxE7-0v4z22kcbKw";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var uri = Uri.parse(request);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  getPlaceInfoDetails(String address) async {
    final query = '$address';
    double lat, long;
    print('getLatLong');
    locationFromAddress(query).then((locations) {
      final output = locations[0].toString();
      print(output);
      print(locations[0].latitude);
      print(locations[0].longitude);
      lat = locations[0].latitude;
      long = locations[0].longitude;
      placemarkFromCoordinates(lat, long).then((placemarks) {
        final output = placemarks[0].toString();
        print(placemarks[0].locality);
        localityName = placemarks[0].locality.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double listHeight = MediaQuery.of(context).size.height * 0.69;
    double chipContainerW = MediaQuery.of(context).size.width * 0.95;
    double chipContainerH = MediaQuery.of(context).size.height * 0.05;
    double picsize = MediaQuery.of(context).size.width / 2;
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
              title: Text("OnClick Property", style: appbarTitleTextStyle)),
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: _locationSearchController,
                          decoration: InputDecoration(
                            // fillColor: Colors.grey,
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: primarycolor, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20),
                                vertical: getProportionateScreenWidth(9)),
                            // border: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            hintText: "Search Location ...",
                            prefixIcon: GestureDetector(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(builder: (_) {
                                //     return FiltterPage();
                                //   }),
                                // );
                              },
                              child: Icon(
                                Icons.search,
                                color: primarycolor,
                              ),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  _locationSearchController.clear();
                                  setState(() {
                                    _placeList.clear();
                                    visLocSearch = false;
                                  });
                                  // getLocation();
                                }),
                          ),
                          onChanged: (value) {
                            _onLocationSearchChanged();
                            setState(() {
                              visLocSearch = true;
                            });
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: visLocSearch,
                      child: Container(
                        height: 100,
                        child: Expanded(
                          child: ListView.builder(
                            // physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _placeList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_placeList[index]["description"]),
                                onTap: () {
                                  _locationSearchController.text =
                                      _placeList[index]["description"];
                                  var placeId = _placeList[index]["place_id"];
                                  var address =
                                      _placeList[index]["description"];
                                  print('${_placeList[index]}');
                                  getPlaceInfoDetails(address);
                                  // getLatLong(address);
                                  // lat = detail.result.geometry.location.lat;
                                  // long = detail.result.geometry.location.lng;
                                  setState(() {
                                    _placeList.clear();
                                    visLocSearch = false;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        width: chipContainerW,
                        height: chipContainerH,
                        child: showspinner
                            ? Center(
                                child: Text("Loading...."),
                              )
                            : Visibility(
                                visible: widget.ptype == '2' ? false : true,
                                child: ListView.builder(
                                    itemCount: bhkTypelist.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (contextt, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 2.0, left: 2.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  isScrollControlled: true,
                                                  builder: (context) =>
                                                      SingleChildScrollView(
                                                          child: Container(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child:
                                                            FillterShowBottomSheet(),
                                                      )));
                                            },
                                            child: Chip(
                                                label: Text(
                                                    '${bhkTypelist[index].HouseTypeName.toString()}'))),
                                      );
                                    }),
                              ),
                      ),
                    ),
                    value != null
                        ? RefreshIndicator(
                            onRefresh: () async {
                              return await notifier.reload(
                                  widget.actiond,
                                  widget.ptype,
                                  widget.checktype,
                                  widget.agentid,
                                  widget.localityname,
                                  widget.usertype);
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
                                        notifier.getMore(
                                            widget.actiond,
                                            widget.ptype,
                                            widget.checktype,
                                            widget.agentid,
                                            widget.localityname,
                                            widget.usertype);
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
                                                            widget.ptype);
                                                      }),
                                                    ).then((value) =>
                                                        reloadList(value));
                                                  },
                                                  child: Material(
                                                    // borderRadius:
                                                    //     BorderRadius.circular(
                                                    //         10.0),
                                                    elevation: 5.0,
                                                    child: Container(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        children: <Widget>[
                                                          Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 5,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          value[index]
                                                                              .Tagline,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15.0),
                                                                        ),
                                                                        Text(
                                                                          value[index]
                                                                              .Tagline2,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 12.0),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        SizedBox(
                                                                      // height: 30,
                                                                      // width: 30,
                                                                      child:
                                                                          InkWell(
                                                                        // borderRadius:
                                                                        //     BorderRadius.circular(
                                                                        //         50),
                                                                        onTap:
                                                                            () {
                                                                          sendFavData(
                                                                              value,
                                                                              index,
                                                                              value[index].Id);
                                                                        },
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              "assets/icons/Heart Icon_2.svg",
                                                                              color: value[index].isFavourite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                                                                              width: 20.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        SizedBox(
                                                                      // height: 40,
                                                                      // width: 30,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          launch(
                                                                              'tel:${value[index].mobile}');
                                                                        },
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Container(
                                                                            // decoration:
                                                                            // BoxDecoration(
                                                                            //   shape:
                                                                            //   BoxShape.circle,
                                                                            // ),
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              "assets/icons/Phone.svg",
                                                                              color: Colors.pink,
                                                                              width: 20.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          ClipRRect(
                                                            // borderRadius:
                                                            //     BorderRadius
                                                            //         .only(
                                                            //   topLeft: Radius
                                                            //       .circular(
                                                            //           8.0),
                                                            //   topRight: Radius
                                                            //       .circular(
                                                            //           8.0),
                                                            // ),
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
                                                                              Text(value[index].Price != null ? value[index].Price : '',
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
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Positioned(
                                              //   top: 20,
                                              //   right: 30,
                                              //   child: Card(
                                              //     elevation: 5,
                                              //     shape: RoundedRectangleBorder(
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               50),
                                              //     ),
                                              //     child: SizedBox(
                                              //       height: 30,
                                              //       width: 30,
                                              //       child: InkWell(
                                              //         // borderRadius:
                                              //         //     BorderRadius.circular(
                                              //         //         50),
                                              //         onTap: () {
                                              //           sendFavData(
                                              //               value,
                                              //               index,
                                              //               value[index].Id);
                                              //         },
                                              //         child: Center(
                                              //           child: Container(
                                              //             decoration:
                                              //                 BoxDecoration(
                                              //               shape:
                                              //                   BoxShape.circle,
                                              //             ),
                                              //             child:
                                              //                 SvgPicture.asset(
                                              //               "assets/icons/Heart Icon_2.svg",
                                              //               color: value[index]
                                              //                       .isFavourite
                                              //                   ? Color(
                                              //                       0xFFFF4848)
                                              //                   : Color(
                                              //                       0xFFDBDEE4),
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              Positioned(
                                                bottom: 80,
                                                right: 4,
                                                child: Card(
                                                  color: Colors
                                                      .transparent, //elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 250,
                                                    child: InkWell(
                                                      onTap: () {
                                                        sendFavData(
                                                            value,
                                                            index,
                                                            value[index].Id);
                                                      },
                                                      child: Container(
                                                        // decoration: BoxDecoration(color: Colors.transparent),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                            value[index]
                                                                .likecount,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15.0),
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
                        : Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //fetching BHK Type
  void _getBHKType() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchBHKType fetchbhktypedata = new FetchBHKType();
      var fetchBHKtype = await fetchbhktypedata.getFetchBHKType("0");
      if (fetchBHKtype != null) {
        var resid = fetchBHKtype["resid"];
        if (resid == 200) {
          var fetchBHKsd = fetchBHKtype["housetype"];
          print(fetchBHKsd.length);
          List<HouseType> tempfetchBHK = [];
          for (var n in fetchBHKsd) {
            HouseType pro = HouseType(
              int.parse(n["houseTypeId"]),
              n["HouseTypeName"],
            );
            tempfetchBHK.add(pro);
          }
          setState(() {
            this.bhkTypelist = tempfetchBHK;
          });
          print("//////bhkTypelist/////////${bhkTypelist.length}");
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

  sendFavData(value, int index, String pid) async {
    final item = value[index];
    setState(() {
      item.isFavourite = !item.isFavourite;
      print('sendFavData: $item');
      print('sendFavData: ${item.isFavourite}');
    });
    try {
      InsertFavList registerSubmitData = new InsertFavList();
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      String datetime = formatter.format(DateTime.now());
      var result =
          await registerSubmitData.getInsertFavList('0', UID, pid, datetime);
      if (result != null) {
        print("sendEnquiryData  ///${result}");
        var resid = result['resid'];
        var type = result['type'];
        var message = result["message"];
        if (resid == 200) {
          Fluttertoast.showToast(
              msg: "$message",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          if(type == 1)
            {
              InsertDataNotification insertdatanotification = new InsertDataNotification();
              var result =
              await insertdatanotification.getInsertDataNotification('1',pid,"");
              print("result///////////////${result}");
              if (result != null) {
                var resid = result['success'];
                if (resid == 1) {
                        print("Notification Send");
                }else if  (resid == 0)
                    {
                      print("Notification Not Send");
                    }
              } else {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Plz Try Again"),
                  backgroundColor: Colors.green,
                ));
              }
            }


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
    await notifier.getMore(widget.actiond, widget.ptype, widget.checktype,
        widget.agentid, widget.localityname, widget.usertype);
  }
}
