import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/Fetch_Notification_Data.dart';
import 'package:onclickproperty/Model/Notification.dart';
import 'package:onclickproperty/Model/NotificationType.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Electronic_Details_Page.dart';
import 'package:onclickproperty/pages/Furniture_Details_Page.dart';
import 'package:onclickproperty/pages/View_Loan_Agent_details.dart';
import 'package:onclickproperty/pages/View_Rental_Agent_Details.dart';
import 'package:onclickproperty/pages/View_Service_Details_Page.dart';
import 'package:onclickproperty/pages/property_details.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showNoProduct = false;
  bool showspinner = false;
  bool showspinnerwhentype = false;
  String NotificationTypeID;
  List<Notificationitems> Notificationlist = new List();
  List<NotificationType> NotificationTypelist = new List();
  TextEditingController _notificationType = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            "Notifications",
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'RobotoMono',
              fontWeight: FontWeight.normal,
              color: primarycolor,
            ),
          )),
      // flexibleSpace: SomeWidget(),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : showNoProduct
              ? Center(
                  child: Image.asset(
                    "images/nonotification.png",
                  ),
                )
              : SafeArea(
                  key: _scaffoldKey,
                  child: Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 20.0, left: 12.0, right: 12.0),
                          child: Container(
                            child: DropdownSearch<NotificationType>(
                              searchBoxController: _notificationType,
                              items: NotificationTypelist,
                              showClearButton: true,
                              showSearchBox: true,
                              label: 'Notification Type',
                              validator: (value) {
                                // if (value == null) {
                                //   return 'This is required';
                                // }
                              },
                              onSaved: (NotificationType value) {
                                _notificationType.text =
                                    value.NotificationTypeName.toString();
                              },
                              dropdownSearchDecoration: InputDecoration(
                                hintStyle: style,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 0.0, left: 0.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.list,
                                    color: primarycolor,
                                  ),
                                ),
                                //border: OutlineInputBorder(),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  NotificationTypeID =
                                      newValue.NotificationTypeID.toString();
                                  print(
                                      "NotificationTypeID///////////${NotificationTypeID}");
                                  if (NotificationTypeID == null ||
                                      NotificationTypeID.isEmpty) {
                                    _getnotification();
                                  } else {
                                    _getnotificationWithRespectiveType(
                                        NotificationTypeID);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      showspinnerwhentype
                          ? Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: Notificationlist.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 6.0),
                                      child: Column(
                                        children: [
                                          Material(
                                            elevation: 2.0,
                                            child: ListTile(
                                              leading: Image.asset(
                                                "assets/images/oncllickdashboadlogo.jpeg",
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    8,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  _getImageSubmitData(
                                                      "1",
                                                      Notificationlist[index]
                                                          .notification_Id);

                                                  if (Notificationlist[index]
                                                          .notification_item ==
                                                      "1") {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                        return PropertyDetailsPage(
                                                          Notificationlist[
                                                                  index]
                                                              .notification_itemID
                                                              .toString(),
                                                          Notificationlist[
                                                                  index]
                                                              .notificationitems_subtype
                                                              .toString(),
                                                        );
                                                      }),
                                                    );
                                                  } else if (Notificationlist[
                                                              index]
                                                          .notification_item ==
                                                      "2") {
                                                    var furnitureid = int.parse(
                                                         Notificationlist[index]
                                                            .notification_itemID);
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                        return FurnitureDetailsPage(
                                                            furnitureid);
                                                      }),
                                                    );
                                                  } else if (Notificationlist[
                                                              index]
                                                          .notification_item ==
                                                      "3") {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                        return ElectronicDetailsPage(
                                                            Notificationlist[
                                                                    index]
                                                                .notification_itemID
                                                                .toString());
                                                      }),
                                                    );
                                                  } else if (Notificationlist[
                                                              index]
                                                          .notification_item ==
                                                      "4") {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                        return ViewLoanAgentDetailsPage(
                                                            Notificationlist[
                                                                    index]
                                                                .notification_itemID
                                                                .toString(),"0");
                                                      }),
                                                    );
                                                  } else if (Notificationlist[
                                                              index]
                                                          .notification_item ==
                                                      "5") {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                        return ViewRentDetailsPage(
                                                            Notificationlist[
                                                                    index]
                                                                .notification_itemID
                                                                .toString(),"0");
                                                      }),
                                                    );
                                                  } else if (Notificationlist[
                                                              index]
                                                          .notification_item ==
                                                      "6") {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                        return ViewServiceDetailsPage(
                                                            Notificationlist[
                                                                    index]
                                                                .notification_itemID
                                                                .toString(),"0");
                                                      }),
                                                    );
                                                  }
                                                });
                                              },
                                              title: Text(
                                                "${Notificationlist[index].notification_title}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${Notificationlist[index].notification_body}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 10.0,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        Notificationlist[index]
                                                                    .notification_date !=
                                                                null
                                                            ? Notificationlist[
                                                                            index]
                                                                        .notification_date ==
                                                                    '0'
                                                                ? 'Today.'
                                                                : "${Notificationlist[index].notification_date} Days Ago."
                                                            : '',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                      Notificationlist[index]
                                                                  .notification_status ==
                                                              '1'
                                                          ? CircleAvatar(
                                                              backgroundColor:
                                                                  primarycolor,
                                                              radius: 5,
                                                            )
                                                          : CircleAvatar(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              radius: 5,
                                                            ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                    ],
                  ),
                ),
    );
  }

  void initState() {
    _getnotification();
    _getNotificationType();
  }

//fetching All Notification
  void _getnotification() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchNotification fetchnotification = new FetchNotification();
      var fetchnotificationdata =
          await fetchnotification.getFetchNotification("0", "");
      print("fetchnotificationdata////////////${fetchnotificationdata}");
      if (fetchnotificationdata != null) {
        var resid = fetchnotificationdata["resid"];
        var rowcount = fetchnotificationdata["rowcount"];

        if (resid == 200) {
          if (rowcount > 0) {
            var fetchnotificationsd = fetchnotificationdata["NotificationList"];
            print(fetchnotificationsd.length);
            List<Notificationitems> tempnotificationlist = [];
            for (var n in fetchnotificationsd) {
              Notificationitems pro = Notificationitems(
                n["notificationId"],
                n["notificationuserid"],
                n["notificationtitle"],
                n["notificationbody"],
                n["notificationitemID"],
                n["notificationitem"],
                n["notificationitemssubtype"],
                n["notificationdate"],
                n["notificationstatus"],
                n["notificationforwhat"],
              );
              tempnotificationlist.add(pro);
            }
            setState(() {
              this.Notificationlist = tempnotificationlist;
              showspinner = false;
            });

            print("//////Notificationlist/////////${Notificationlist.length}");
          } else {
            setState(() {
              showNoProduct = true;
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

  //fetching Notification Type
  void _getNotificationType() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchNotification FetchNotificationdata = new FetchNotification();
      var FetchNotificationdatatype =
          await FetchNotificationdata.getFetchNotification("2", "");
      if (FetchNotificationdatatype != null) {
        var resid = FetchNotificationdatatype["resid"];
        if (resid == 200) {
          var fetchpropertytypesd =
              FetchNotificationdatatype["NotificationTypeList"];
          print(fetchpropertytypesd.length);
          List<NotificationType> tempNotificationType = [];
          for (var n in fetchpropertytypesd) {
            NotificationType pro = NotificationType(
              n["ItemsId"],
              n["ItemsName"],
            );
            tempNotificationType.add(pro);
          }
          setState(() {
            this.NotificationTypelist = tempNotificationType;
          });
          print(
              "//////NotificationTypelist/////////${NotificationTypelist.length}");
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

  //fetching All Notification  with respective Notification Type
  void _getnotificationWithRespectiveType(String notificationTypeID) async {
    setState(() {
      showspinnerwhentype = true;
    });
    try {
      FetchNotification fetchnotification = new FetchNotification();
      var fetchnotificationdata =
          await fetchnotification.getFetchNotification("3", notificationTypeID);
      if (fetchnotificationdata != null) {
        var resid = fetchnotificationdata["resid"];
        var rowcount = fetchnotificationdata["rowcount"];

        if (resid == 200) {
          if (rowcount > 0) {
            var fetchnotificationsd = fetchnotificationdata["NotificationList"];
            print(fetchnotificationsd.length);
            List<Notificationitems> tempnotificationlist = [];
            for (var n in fetchnotificationsd) {
              Notificationitems pro = Notificationitems(
                n["notificationId"],
                n["notificationuserid"],
                n["notificationtitle"],
                n["notificationbody"],
                n["notificationitemID"],
                n["notificationitem"],
                n["notificationitemssubtype"],
                n["notificationdate"],
                n["notificationstatus"],
                n["notificationforwhat"],
              );
              tempnotificationlist.add(pro);
            }
            setState(() {
              this.Notificationlist = tempnotificationlist;
              showspinnerwhentype = false;
            });

            print("//////Notificationlist/////////${Notificationlist.length}");
          } else {
            setState(() {
              showspinnerwhentype = true;
            });
          }
        } else {
          setState(() {
            showspinnerwhentype = false;
          });
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Plz Try Again"),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        setState(() {
          showspinnerwhentype = false;
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

  Future<String> _getImageSubmitData(
    String actionid,
    String notification_id,
  ) async {
    setState(() {
      showspinner = false;
    });
    try {
      FetchNotification notificationSubmitData = new FetchNotification();
      var notificationData = await notificationSubmitData.getFetchNotification(
        actionid,
        notification_id,
      );
      if (notificationData != null) {
        print("notificationData  ///${notificationData}");
        var resid = notificationData['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "Data Successfully Save !",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
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
