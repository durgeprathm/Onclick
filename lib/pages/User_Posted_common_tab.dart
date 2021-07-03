import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Model/toppropertylist_model.dart';
import 'package:onclickproperty/Providers/top_propertieslist_provider.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/list_of%20_people_like_properties.dart';
import 'package:onclickproperty/pages/update_property_details.dart';

class UserPostedCommonPropertyTabtabScreen extends StatefulWidget {
  @override
  int Propertytypeid;
  String purpose;
  UserPostedCommonPropertyTabtabScreen(this.Propertytypeid, this.purpose);
  _UserPostedCommonPropertyTabtabScreenState createState() =>
      _UserPostedCommonPropertyTabtabScreenState();
}

class _UserPostedCommonPropertyTabtabScreenState
    extends State<UserPostedCommonPropertyTabtabScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TopPropertiesNotifier notifier;
  var _locationSearchController = TextEditingController();
  bool showspinner = false;

  @override
  void initState() {
    super.initState();
    print('_PropertiesPostedByUserListScreenState initState');
    notifier = TopPropertiesNotifier();
    notifier.getMorePostedByUserTab(
        '8', widget.Propertytypeid.toString(), widget.purpose.toString());
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  int propertyidcreated;
  @override
  Widget build(BuildContext context) {
    double picsize = MediaQuery.of(context).size.width / 2;
    return ValueListenableBuilder<List<PropertyListModel>>(
      valueListenable: notifier,
      builder:
          (BuildContext context, List<PropertyListModel> value, Widget child) {
        return Scaffold(
          key: _scaffoldKey,
          body: SafeArea(
            child: Container(
              child: value != null
                  ? RefreshIndicator(
                      onRefresh: () async {
                        return await notifier.reloadPostedByUsertab(
                            '8',
                            widget.Propertytypeid.toString(),
                            widget.purpose.toString());
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
                                    itemCount: value.length,
                                    cacheExtent: 5,
                                    itemBuilder: (contextt, index) {
                                      List<String> imagelist =
                                          value[index].Topimglink.split("#");
                                      print(
                                          "/////////LENGTH/////////////${imagelist.length}");
                                      var id = value[index].Id.toString();
                                      print(
                                          "//////id/////////////////////////${id}");
                                      propertyidcreated =
                                          550000 + int.parse(id);
                                      print(
                                          "//propertyidcreated///////////////////////${propertyidcreated}");
                                      return Stack(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) {
                                                  return UpdatePropertyDetailsPage(
                                                      value[index]
                                                          .Id
                                                          .toString(),
                                                      value[index]
                                                          .ptypeid
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
                                                                  Widget
                                                                      child,
                                                                  ImageChunkEvent
                                                                      loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null)
                                                                  return child;
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    value: loadingProgress.expectedTotalBytes !=
                                                                            null
                                                                        ? loadingProgress.cumulativeBytesLoaded /
                                                                            loadingProgress.expectedTotalBytes
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
                                                              value[index].Tagline !=
                                                                      null
                                                                  ? value[index]
                                                                      .Tagline
                                                                  : "",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      15.0),
                                                            ),
                                                            Text(
                                                              value[index].Tagline2 !=
                                                                      null
                                                                  ? value[index]
                                                                      .Tagline2
                                                                  : "",
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
                                                                      .center,
                                                              children: [
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
                                                                          FontAwesomeIcons.wrench,
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
                                                                            value[index].Price != null ? value[index].Price : "",
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
                                                                          FontAwesomeIcons.wrench,
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
                                                                            value[index].Furnishing != null ? value[index].Furnishing : "",
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
                                                                  flex: 1,
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
                                                                        //
                                                                        Text(
                                                                            value[index].PropertySize != null ? value[index].PropertySize : '',
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12.0,
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
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
                                                      color: value[index]
                                                                  .Approve ==
                                                              '0'
                                                          ? Colors.redAccent
                                                          : Colors.green,
                                                      child: new FlatButton(
                                                          child: Center(
                                                            child: value[index]
                                                                        .Approve !=
                                                                    null
                                                                ? value[index]
                                                                            .Approve ==
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
                                                                      )
                                                                : "",
                                                          ),
                                                          onPressed: null,
                                                          shape: new RoundedRectangleBorder(
                                                              borderRadius:
                                                                  new BorderRadius
                                                                          .circular(
                                                                      30.0))),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 20,
                                          left: 20,
                                          child: Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: SizedBox(
                                              height: 30,
                                              width: 100,
                                              child: InkWell(
                                                  onTap: () {},
                                                  child: Center(
                                                    child: Container(
                                                      color: Colors.brown,
                                                      child: new FlatButton(
                                                          child: Center(
                                                            child: new Text(
                                                              propertyidcreated !=
                                                                      null
                                                                  ? "OC" +
                                                                      propertyidcreated
                                                                          .toString()
                                                                  : "",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          onPressed: null,
                                                          shape: new RoundedRectangleBorder(
                                                              borderRadius:
                                                                  new BorderRadius
                                                                          .circular(
                                                                      30.0))),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 170,
                                          right: 10,
                                          child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: InkWell(
                                              // borderRadius:
                                              //     BorderRadius.circular(
                                              //         50),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (_) {
                                                    return ListOfPeopleLikeProperties(
                                                      value[index]
                                                          .Id
                                                          .toString(),
                                                    );
                                                  }),
                                                );
                                              },
                                              child: Center(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/Heart Icon_2.svg",
                                                    color: value[index]
                                                            .isFavourite
                                                        ? Color(0xFFFF4848)
                                                        : Color(0xFFDBDEE4),
                                                    width: 20,
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
            ),
          ),
        );
      },
    );
  }
}
