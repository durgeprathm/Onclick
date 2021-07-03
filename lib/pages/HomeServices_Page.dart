import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onclickproperty/Adaptor/fetch_homeservice.dart';
import 'package:onclickproperty/Model/HomeServiceType.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/pages/Post_Service_Advertisement_page.dart';
import 'package:onclickproperty/pages/service_provider_page.dart';
import 'package:onclickproperty/utilities/constants.dart';

class HomeServicesPage extends StatefulWidget {
  @override
  _HomeServicesPageState createState() => _HomeServicesPageState();
}

class _HomeServicesPageState extends State<HomeServicesPage> {
  FetchServiceType fetchServiceType = new FetchServiceType();
  List<HomeServiceType> servicestype = [];
  bool loader = false;

  _getServiceType() async {
    setState(() {
      loader = true;
    });
    var response = await fetchServiceType.getserviceType("0");
    var resid = response["resid"];
    var rowcount = response["rowcount"];
    var servicesd = response["homeserviceList"];
    List<HomeServiceType> servicestypeTemp = [];

    if (resid == 200) {
      if (rowcount > 0) {
        for (var n in servicesd) {
          HomeServiceType homeServiceType = new HomeServiceType(
              n["serviceid"], n["servicename"], n["servicedecp"]);
          servicestypeTemp.add(homeServiceType);
        }
      }
    }
    setState(() {
      servicestype = servicestypeTemp;
      loader = false;
    });
  }

  @override
  void initState() {
    _getServiceType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            // CircleAvatar(
            //   radius: 18,
            //   backgroundImage: AssetImage('images/onclickser.png'),
            // ),
            // SizedBox(
            //   width: 5.0,
            // ),
            Text(
              "Home Services",
              style: appbarTitleTextStyle,
            ),
          ],
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
                    return PostServiceAdvertisementPage();
                  }),
                );
              },
              borderSide: BorderSide(
                color: primarycolor,
                style: BorderStyle.solid,
              ),
              child: Text("Post Service",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      fontSize: 10.0,
                      color: primarycolor,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: loader
              ? Center(child: Container(child: CircularProgressIndicator()))
              : Container(
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Image.network(
                                'https://thumbs.gfycat.com/AffectionateQuickBurro-small.gif',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 35,
                              left: 35,
                              right: 35,
                              top: 35,
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Text(
                                      '"Best Services Offered by Onclick"',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return ServiceProviderList(
                                    servicestype[0].typeid,
                                    servicestype[0].servicename,
                                    'images/musician.png');
                              }),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      servicestype[0].servicename,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('images/paint-roll.png'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      servicestype[0].servicedecsp,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return ServiceProviderList(
                                    servicestype[1].typeid,
                                    servicestype[1].servicename,
                                    'images/musician.png');
                              }),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      servicestype[1].servicename,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('images/carpenter.png'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      servicestype[1].servicedecsp,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return ServiceProviderList(
                                    servicestype[2].typeid,
                                    servicestype[2].servicename,
                                    'images/musician.png');
                              }),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      servicestype[2].servicename,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('images/plumber.png'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      servicestype[2].servicedecsp,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return ServiceProviderList(
                                    servicestype[3].typeid,
                                    servicestype[3].servicename,
                                    'images/musician.png');
                              }),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      servicestype[3].servicename,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('images/electrician.png'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      servicestype[3].servicedecsp,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return ServiceProviderList(
                                    servicestype[4].typeid,
                                    servicestype[4].servicename,
                                    'images/musician.png');
                              }),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      servicestype[4].servicename,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('images/smart.png'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      servicestype[4].servicedecsp,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return ServiceProviderList(
                                    servicestype[5].typeid,
                                    servicestype[5].servicename,
                                    'images/musician.png');
                              }),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      servicestype[5].servicename,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('images/farming.png'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      servicestype[5].servicedecsp,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return ServiceProviderList(
                                    servicestype[6].typeid,
                                    servicestype[6].servicename,
                                    'images/musician.png');
                              }),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      servicestype[6].servicename,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('images/fashion.png'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      servicestype[6].servicedecsp,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return ServiceProviderList(
                                    servicestype[7].typeid,
                                    servicestype[7].servicename,
                                    'images/musician.png');
                              }),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      servicestype[7].servicename,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                          'images/delivery-truck.png'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      servicestype[7].servicedecsp,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return ServiceProviderList(
                                    servicestype[8].typeid,
                                    servicestype[8].servicename,
                                    'images/musician.png');
                              }),
                            );
                          },
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            elevation: 5.0,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8.0),
                                child: Column(
                                  children: [
                                    Text(
                                      servicestype[8].servicename,
                                      style: TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          AssetImage('images/room-service.png'),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      servicestype[8].servicedecsp,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15.0),
                                    ),
                                  ],
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
      ),
    );
  }
}
