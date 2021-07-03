import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Type.dart';
import 'package:onclickproperty/Model/Furniture_Type.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Furniture_Items_Page.dart';
import 'package:onclickproperty/pages/Electronics_Items_Page.dart';
import 'package:onclickproperty/pages/Post_Furniture_Page.dart';

class FurnituresPage extends StatefulWidget {
  @override
  _FurnituresPageState createState() => _FurnituresPageState();
}

class _FurnituresPageState extends State<FurnituresPage> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner=false;
  List<FurnitureType> FurnitureTypelist = new List();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          "Furnitures",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'RobotoMono',
            fontWeight: FontWeight.bold,
            color: primarycolor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return PostFurniturePage();
                  }),
                );
              },
              borderSide: BorderSide(
                color: primarycolor,
                style: BorderStyle.solid,
              ),
              child: Text("Post Furniture",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: 10.0,
                      color: primarycolor,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body:showspinner ?  Center(child: CircularProgressIndicator())  : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        'https://i.gifer.com/MrLL.gif',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 35,
                      left: 35,
                      right:35,
                      top:35,
                      child: Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              '"Furnitures"',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35.0),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[5].FurnitureTypeID.toString(),FurnitureTypelist[5].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.asset('images/bedside-table.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Bedside Table",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[2].FurnitureTypeID.toString(),FurnitureTypelist[2].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.home,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/sofa.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Sofa Set",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[0].FurnitureTypeID.toString(),FurnitureTypelist[0].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('images/bed.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Bed Set",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[3].FurnitureTypeID.toString(),FurnitureTypelist[3].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.car,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/archive.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Wardrobe",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[11].FurnitureTypeID.toString(),FurnitureTypelist[11].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.chair,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/work-station.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Office Furniture",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[8].FurnitureTypeID.toString(),FurnitureTypelist[8].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.microchip,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/recliner.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Recliner",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[10].FurnitureTypeID.toString(),FurnitureTypelist[10].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.book,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/child.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Kids Furniture",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[9].FurnitureTypeID.toString(),FurnitureTypelist[9].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.moneyBill,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/window.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "House Decor",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[4].FurnitureTypeID.toString(),FurnitureTypelist[4].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.ccAmazonPay,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/dresser.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Dressing Table",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[6].FurnitureTypeID.toString(),FurnitureTypelist[6].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.book,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/book-shelf.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Book Shevle",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[7].FurnitureTypeID.toString(),FurnitureTypelist[7].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.moneyBill,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/books.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "TV Stand",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: GestureDetector(
                          onTap:()
                          {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return FurnitureItemsPage(FurnitureTypelist[1].FurnitureTypeID.toString(),FurnitureTypelist[1].FurnitureTypeName.toString());
                            }),);
                          },
                          child: Material(
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: MediaQuery.of(context).size.height/8,
                                width: MediaQuery.of(context).size.width/4,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // FaIcon(
                                      //   FontAwesomeIcons.ccAmazonPay,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/chair.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Dining Table",
                                          style: TextStyle(fontSize: 15.0,color: primarycolor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
        ),
      );
  }

  @override
  void initState() {
    _getFurnitureType();
  }

  void _getFurnitureType() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchFurnitureType fetchfurnituretypedata = new FetchFurnitureType();
      var fetchfurniturestype =
      await fetchfurnituretypedata.getFetchFurnitureType("0");
      if (fetchfurniturestype != null) {
        var resid = fetchfurniturestype["resid"];
        if (resid == 200) {
          var fetchfurnituresd = fetchfurniturestype["furnituretype"];
          print(fetchfurnituresd.length);
          List<FurnitureType> tempfetchFurniture = [];
          for (var n in fetchfurnituresd) {
            FurnitureType pro = FurnitureType(
              int.parse(n["FurnitureID"]),
              n["FurnitureName"],
            );
            tempfetchFurniture.add(pro);
          }
          setState(() {
            this.FurnitureTypelist = tempfetchFurniture;
          });
          print("//////FurnitureTypelist/////////${FurnitureTypelist.length}");
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
}
