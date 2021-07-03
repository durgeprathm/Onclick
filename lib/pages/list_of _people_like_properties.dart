import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_LikeBy_Data.dart';
import 'package:onclickproperty/Model/FurnitureProducts.dart';
import 'package:onclickproperty/Model/LIkeBY.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Furniture_Details_Page.dart';

class ListOfPeopleLikeProperties extends StatefulWidget {
  @override
  String itemID;
  ListOfPeopleLikeProperties(this.itemID);
  _ListOfPeopleLikePropertiesState createState() =>
      _ListOfPeopleLikePropertiesState(this.itemID);
}

class _ListOfPeopleLikePropertiesState
    extends State<ListOfPeopleLikeProperties> {
  @override
  _ListOfPeopleLikePropertiesState(this.itemID);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String itemID;
  String itemName;
  bool showNoProduct = false;
  bool showspinner = false;
  String Getimage;
  int difference;
  String today;
  String likedate;
  int before;
  List<LikeBy> Fetchlikebylist = new List();
  TextStyle NameListstyle = TextStyle(
      fontFamily: 'RobotoMono',fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle Mobilestyle = TextStyle(fontFamily: 'RobotoMono',
      fontSize: 17, fontWeight: FontWeight.bold, color: Colors.blueGrey);
  TextStyle emailstyle = TextStyle(fontFamily: 'RobotoMono',
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blueGrey);
  TextStyle likedetailsstyle =TextStyle(fontFamily: 'RobotoMono',
      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.lightGreen);

  Widget build(BuildContext context) {
    double containerheight = MediaQuery.of(context).size.height * 0.16;
    double containerwidth = MediaQuery.of(context).size.width * 0.99;
    double addbtnheight = MediaQuery.of(context).size.height * 0.04;
    double addbtnwidth = MediaQuery.of(context).size.width * 0.60;
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            "Property Like By ",
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
                    "images/noproductsfound.jpg",
                  ),
                )
              : SafeArea(
                  key: _scaffoldKey,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: Fetchlikebylist.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Material(
                                  elevation: 1.0,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                        height: containerheight,
                                        width: containerwidth,
                                        child: Row(
                                          children: [
                                            Material(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              child: Container(
                                                child: CircleAvatar(
                                                  radius: 37,
                                                  backgroundColor: primarycolor,
                                                  child: CircleAvatar(
                                                    radius: 35,
                                                    //radius: 25.0,
                                                    backgroundImage: NetworkImage(
                                                        "${Fetchlikebylist[index].profile}",
                                                    ),
                                                  ),
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    4,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: addbtnheight,
                                                    width: addbtnwidth,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Text(
                                                          "${Fetchlikebylist[index].fullname}",
                                                          style: NameListstyle,
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                      "${Fetchlikebylist[index].mobileno}",
                                                      style: Mobilestyle),
                                                  Text(
                                                      "${Fetchlikebylist[index].email}",
                                                      style: emailstyle),
                                                  Text(
                                                      Fetchlikebylist[index]
                                                                  .date !=
                                                              null
                                                          ? Fetchlikebylist[
                                                                          index]
                                                                      .date ==
                                                                  '0'
                                                              ? 'Like Today.'
                                                              : "Like ${Fetchlikebylist[index].date} Days Ago."
                                                          : '',
                                                      style: likedetailsstyle),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }

  @override
  void initState() {
    _getLikeByData(itemID);
  }

  void _getLikeByData(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchLikeByData fetchlikebydata = new FetchLikeByData();
      var fetchdata = await fetchlikebydata.getFetchLikeByData("0", itemid);
      if (fetchdata != null) {
        var resid = fetchdata["resid"];
        var rowcount = fetchdata["rowcount"];
        if (resid == 200) {
          if (rowcount > 0) {
            var fetchdatassd = fetchdata["LikebyList"];
            print(fetchdatassd.length);
            List<LikeBy> tempfetchdatalist = [];
            for (var n in fetchdatassd) {
              LikeBy pro = LikeBy(n["likeid"], n["time"], n["userid"],
                  n["fullname"], n["phoneno"], n["email"], n["profile"]);
              tempfetchdatalist.add(pro);
            }
            setState(() {
              this.Fetchlikebylist = tempfetchdatalist;
              showspinner = false;
            });

            print("//////Fetchlikebylist/////////${Fetchlikebylist.length}");
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
}
