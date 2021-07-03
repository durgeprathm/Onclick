import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Model/toppropertylist_model.dart';
import 'package:onclickproperty/Providers/post_service_provider.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Service_Details_Page.dart';
import 'package:onclickproperty/pages/owner_details/getting_user_data_screen.dart';
import 'package:onclickproperty/pages/property_details.dart';
import 'package:onclickproperty/utilities/size_config.dart';

class ServicesPostedByUserListScreen extends StatefulWidget {
  @override
  _ServicesPostedByUserListScreenState createState() =>
      _ServicesPostedByUserListScreenState();
}

class _ServicesPostedByUserListScreenState
    extends State<ServicesPostedByUserListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PostServiceProvider notifier;
  var _locationSearchController = TextEditingController();
  bool showspinner = false;

  @override
  void initState() {
    super.initState();
    notifier = PostServiceProvider();
    notifier.getMore('4');
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double picsize = MediaQuery.of(context).size.width / 2;
    return ValueListenableBuilder<List<Services>>(
      valueListenable: notifier,
      builder: (BuildContext context, List<Services> value, Widget child) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.transparent,
              title: Text(
                "Posted Services",
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
                        return await notifier.reload('4');
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
                                        child: Text('No Services!'));
                                  }),
                            )
                          : NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo is ScrollEndNotification &&
                                    scrollInfo.metrics.extentAfter == 0) {
                                  notifier.getMore('4');
                                  return true;
                                }
                                return false;
                              },
                              child: Container(
                                child: GridView.builder(
                                    itemCount: value.length,
                                    cacheExtent: 5,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Material(
                                          elevation: 2,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  height: 20,
                                                  width: 60,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            // sendFavData(value, index,
                                                            // value[index].Id);
                                                          },
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
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Center(
                                                  child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        primarycolor,
                                                    backgroundImage: AssetImage(
                                                        'images/musician.png'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      value[index]
                                                          .servicetypename,
                                                      style: TextStyle(
                                                        color: Colors.brown,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child:
                                                        Text(value[index].name),
                                                  ),
                                                ),
                                                Center(
                                                  child:
                                                      Text(value[index].city),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                              builder: (_) {
                                                            return ServiceDetailsPage(value[index].id.toString());
                                                          }),
                                                        );
                                                      },
                                                      child: Text(
                                                        "GET DETAILS",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      color: primarycolor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          2)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.0,
                                    )),
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
