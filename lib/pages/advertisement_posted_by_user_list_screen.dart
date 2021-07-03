import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Model/toppropertylist_model.dart';
import 'package:onclickproperty/Providers/post_advertisments_provider.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Advertiment_Details.dart';
import 'package:onclickproperty/pages/owner_details/getting_user_data_screen.dart';
import 'package:onclickproperty/pages/property_details.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class AdvertisementPostedByUserListScreen extends StatefulWidget {
  @override
  _AdvertisementPostedByUserListScreenState createState() =>
      _AdvertisementPostedByUserListScreenState();
}

class _AdvertisementPostedByUserListScreenState
    extends State<AdvertisementPostedByUserListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PostAdvertisementProvider notifier;
  var _locationSearchController = TextEditingController();
  bool showspinner = false;

  @override
  void initState() {
    super.initState();
    notifier = PostAdvertisementProvider();
    notifier.getMore('5');
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double picsize = MediaQuery.of(context).size.width / 2;
    return ValueListenableBuilder<List<Advertisements>>(
      valueListenable: notifier,
      builder: (BuildContext context, List<Advertisements> value, Widget child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
              title: Text(
                "Posted Advertisement",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(20),
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
                        return await notifier.reload('5');
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
                                        child: Text('No Advertisements!'));
                                  }),
                            )
                          : NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo is ScrollEndNotification &&
                                    scrollInfo.metrics.extentAfter == 0) {
                                  notifier.getMore('5');
                                  return true;
                                }
                                return false;
                              },
                              child:Container(
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
                                      value[index].Image.split("#");
                                      var id = value[index].id.toString();
                                      print(
                                          "//////id/////////////////////////${id}");
                                      return Stack(children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) {
                                                      return AdvertimentDetailsPage(
                                                          value[index]
                                                              .id
                                                              .toString(),);
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
                                                        height: 150,
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
                                                              value[index]
                                                                  .companyname,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  15.0),
                                                            ),
                                                            Text(
                                                              value[index]
                                                                  .address,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  fontSize:
                                                                  12.0),
                                                            ),
                                                            Text(
                                                              value[index]
                                                                  .companywebsite,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  fontSize:
                                                                  12.0,
                                                              color: Colors.blue),
                                                            ),
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
                                                          .Aprrove ==
                                                          '0'
                                                          ? Colors.redAccent
                                                          : Colors.green,
                                                      child:
                                                      new OutlineButton(
                                                          child: Center(
                                                            child: value[index]
                                                                .Aprrove ==
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
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
        );
      },
    );
  }
}
