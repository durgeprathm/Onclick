import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Type.dart';
import 'package:onclickproperty/Model/Electronics_type.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Electronics_Items_Page.dart';
import 'package:onclickproperty/pages/Post_Electronics_Page.dart';

class ElectronicsPage extends StatefulWidget {
  @override
  _ElectronicsPageState createState() => _ElectronicsPageState();
}

class _ElectronicsPageState extends State<ElectronicsPage> {
  @override
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner=false;
  List<ElectronicsType> ElectronicTypelist = new List();
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          "Electronics",
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
                    return PostElectronicsPage();
                  }),
                );
              },
              borderSide: BorderSide(
                color: primarycolor,
                style: BorderStyle.solid,
              ),
              child: Text("Post Electronics",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: 10.0,
                      color: primarycolor,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: showspinner ? Center(child: CircularProgressIndicator()) :SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Image.network(
                        'https://mindlercareerlibrarynew.imgix.net/1A-Electrical_Engineering.png',
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
                              '"Electronics"',
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
                              return LaptopItemsPage(ElectronicTypelist[1].ElectronicsTypeID.toString(),ElectronicTypelist[1].ElectronicsTypeName.toString());
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
                                      //   FontAwesomeIcons.building,
                                      //   size: 30.0,
                                      //   color: primarycolor,
                                      // ),
                                      Image.asset('images/fridge1.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Refrigerator",
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
                              return LaptopItemsPage(ElectronicTypelist[2].ElectronicsTypeID.toString(),ElectronicTypelist[2].ElectronicsTypeName.toString());
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
                                      Image.asset('images/air-conditioner.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Air Coolers",
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
                              return LaptopItemsPage(ElectronicTypelist[3].ElectronicsTypeID.toString(),ElectronicTypelist[3].ElectronicsTypeName.toString());
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
                                      Image.asset('images/laptop.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Laptops",
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
                height: 3.0,
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
                              return LaptopItemsPage(ElectronicTypelist[5].ElectronicsTypeID.toString(),ElectronicTypelist[5].ElectronicsTypeName.toString());
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
                                      Image.asset('images/monitor.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "TVs",
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
                              return LaptopItemsPage(ElectronicTypelist[7].ElectronicsTypeID.toString(),ElectronicTypelist[7].ElectronicsTypeName.toString());
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
                                      Image.asset('images/print1 (1).png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Printer",
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
                              return LaptopItemsPage(ElectronicTypelist[8].ElectronicsTypeID.toString(),ElectronicTypelist[8].ElectronicsTypeName.toString());
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
                                      Image.asset('images/mobile.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Mobile",
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
                height: 3.0,
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
                              return LaptopItemsPage(ElectronicTypelist[9].ElectronicsTypeID.toString(),ElectronicTypelist[9].ElectronicsTypeName.toString());
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
                                      Image.asset('images/microwave.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Kitchen",
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
                              return LaptopItemsPage(ElectronicTypelist[10].ElectronicsTypeID.toString(),ElectronicTypelist[10].ElectronicsTypeName.toString());
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
                                      Image.asset('images/computer.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Computers",
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
                              return LaptopItemsPage(ElectronicTypelist[11].ElectronicsTypeID.toString(),ElectronicTypelist[11].ElectronicsTypeName.toString());
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
                                      Image.asset('images/game-controller.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Games",
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
                height: 3.0,
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
                              return LaptopItemsPage(ElectronicTypelist[0].ElectronicsTypeID.toString(),ElectronicTypelist[0].ElectronicsTypeName.toString());
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
                                      Image.asset('images/air-conditioner.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Air Conditioners",
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
                              return LaptopItemsPage(ElectronicTypelist[4].ElectronicsTypeID.toString(),ElectronicTypelist[4].ElectronicsTypeName.toString());
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
                                      Image.asset('images/washing-machine.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Wash Machines",
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
                              return LaptopItemsPage(ElectronicTypelist[6].ElectronicsTypeID.toString(),ElectronicTypelist[6].ElectronicsTypeName.toString());
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
                                      Image.asset('images/camera.png',
                                        width: 40.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Cameras",
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
    _getElectronicType();
  }

  void _getElectronicType() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicType fetchelectronictypedata = new FetchElectronicType();
      var fetchelectronictype =
      await fetchelectronictypedata.getFetchElectronicType("0");
      if (fetchelectronictype != null) {
        var resid = fetchelectronictype["resid"];
        if (resid == 200) {
          var fetchelectronicsd = fetchelectronictype["electronicstype"];
          print(fetchelectronicsd.length);
          List<ElectronicsType> tempfetchelectroniclist = [];
          for (var n in fetchelectronicsd) {
            ElectronicsType pro = ElectronicsType(
              int.parse(n["ElectronicsTypeId"]),
              n["ElectronicsTypeName"],
            );
            tempfetchelectroniclist.add(pro);
          }
          setState(() {
            this.ElectronicTypelist = tempfetchelectroniclist;
          });
          print(
              "//////ElectronicTypelist/////////${ElectronicTypelist.length}");
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
