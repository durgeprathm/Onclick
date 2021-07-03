import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Model/toppropertylist_model.dart';
import 'package:onclickproperty/Providers/top_propertieslist_provider.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/property_details.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TopPropertiesNotifier notifier;
  var _locationSearchController = TextEditingController();
  bool showspinner = false;

  @override
  void initState() {
    super.initState();
    notifier = TopPropertiesNotifier();
    notifier.getMoreWishList('7', '', '', '', '', '');
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double listHeight = MediaQuery.of(context).size.height * 0.87;
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
              title: Text(
                "Shortlisted Property",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: primarycolor,
                ),
              )),
          // flexibleSpace: SomeWidget(),
          body: SafeArea(
            child: Container(
              child: value != null
                  ? RefreshIndicator(
                onRefresh: () async {
                  return await notifier.reloadWishList(
                      '7',
                      '',
                      '',
                     '',
                     '',
                      '');
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
                      }
                      ),
                ) : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo is ScrollEndNotification &&
                          scrollInfo.metrics.extentAfter == 0) {
                        notifier.getMoreWishList(
                            '7',
                            '',
                            '',
                            '',
                            '',
                            '');
                        return true;
                      }
                      return false;
                    },
                    child: Expanded(
                      child: Container(
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
                                                  value[index]
                                                      .ptypeid
                                                      .toString());
                                            }),
                                      );
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
                              ]);
                            }),
                      ),
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
