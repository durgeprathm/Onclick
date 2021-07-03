import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onclickproperty/Adaptor/Fetch_Notification_Data.dart';
import 'package:onclickproperty/Adaptor/fetch_all_dashboard_property.dart';
import 'package:onclickproperty/Model/all_dashboard_property_model.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/Commercial/Commercial_property_tab.dart';
import 'package:onclickproperty/pages/Notification_page.dart';
import 'package:onclickproperty/pages/Register_As_Loan_Agent.dart';
import 'package:onclickproperty/pages/Register_As_Rental_Agent.dart';
import 'package:onclickproperty/pages/Residential_property_tab.dart';
import 'package:onclickproperty/pages/Post_Advertisement_Page.dart';
import 'package:onclickproperty/pages/Post_Electronics_Page.dart';
import 'package:onclickproperty/pages/Post_Service_Advertisement_page.dart';
import 'package:onclickproperty/pages/contactus/contact_us_screen.dart';
import 'package:onclickproperty/pages/filltepage.dart';
import 'package:onclickproperty/pages/profile/profile_screen.dart';
import 'package:onclickproperty/pages/project/project_property_tab.dart';
import 'package:onclickproperty/pages/sign_in/sign_in_screen.dart';
import 'package:onclickproperty/pages/wish_list_screen.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../const/shared_preference_constants.dart';
import 'Post_Furniture_Page.dart';
import 'Post_Property_New.dart';
import '../Adaptor/new_token_insert.dart';
import 'package:need_resume/need_resume.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Geolocator geolocator = Geolocator();
  StreamSubscription<Position> _postionStream;
  Address _address;
  bool visLocSearch = false;
  var _locationSearchController = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];

  bool _showProgressBar = false;
  String localityName = "Nagpur";
  String localityPincode = "440024";

  Position position;
  double long;
  double lat;
  String profilePic;
  String userfullName;
  int counter = 0;
  @override
  void initState() {
    super.initState();
    _getnotificationcount();
    _getallProperties(localityName, localityPincode);
    _getallCommercialProperties(localityName, localityPincode);
    _getallProjectProperties(localityName, localityPincode);
    getLocation();
    getUserdata();
    sendNewToken();
  }



  // @override
  // void onResume() {
  //   print("on resume ");
  //   _getnotificationcount();
  // }

  @override
  void dispose() {
    super.dispose();
    _postionStream.cancel();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     //do your stuff
  //     print("on resume ");
  //     super.initState();
  //    // _getnotificationcount();
  //
  //   }
  //   if(state == AppLifecycleState.paused){
  //     print("on Paused ");
  //     super.initState();
  //    // _getnotificationcount();
  //   }
  //   if(state == AppLifecycleState.inactive){
  //     print("on inactive ");
  //     super.initState();
  //     // _getnotificationcount();
  //   }
  //   if(state == AppLifecycleState.detached){
  //     print("on detached ");
  //     super.initState();
  //     // _getnotificationcount();
  //   }
  //   if(state == AppLifecycleState.resumed){
  //     print("on detached ");
  //     super.initState();
  //     // _getnotificationcount();
  //   }
  //   if(state == AppLifecycleState.values){
  //     print("on values ");
  //     super.initState();
  //     // _getnotificationcount();
  //   }
  //
  // }



getUserdata() async {
    var tempprofilePic = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERPROFILEPIC);
    var tempFullName = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERFULLNAME);
    setState(() {
      profilePic = tempprofilePic;
      userfullName = tempFullName;
      print('profilePic:$profilePic');
      print('userfullName:$userfullName');
    });
  }

  void getLocation() async {
    checkingServiceEOD();
//    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.medium, distanceFilter: 10);
//    if (isLocationServiceEnabled) {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    if (position != null) {
      setState(() {
        print(position.latitude);
        print(position.longitude);
        final coordinates =
            new Coordinates(position.latitude, position.longitude);
        convertCoordinatesToAddress(coordinates).then((value) {
          if (value != null) {
            _address = value;
            localityName = _address.locality;
            if (_address.postalCode != null) {
              localityPincode = _address.postalCode;
              _getallProperties(localityName, localityPincode);
              _getallCommercialProperties(localityName, localityPincode);
              _getallProjectProperties(localityName, localityPincode);
            } else {
              _getallProperties(localityName, '');
              _getallCommercialProperties(localityName, '');
              _getallProjectProperties(localityName, '');
            }
          }
        });
      });
    }
//    }
  }

  void checkingServiceEOD() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled) {
      print('Location Service is enabled');
      // getLocation();
    } else {
      print('Location Service is disabled');
      await Geolocator.requestPermission();
    }
  }

  convertCoordinatesToAddress(Coordinates coordinates) async {
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return address.first;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Image(
              image: AssetImage("assets/images/oncllickdashboadlogo.jpeg"),
              width: 135,
            ),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            // ),
            // Text(
            //   "OnClick Property",
            //   style: appbarTitleTextStyle,
            // )
          ],
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(20.0),
        //     child: GestureDetector(
        //       onTap: () {
        //         Navigator.of(context).push(
        //           MaterialPageRoute(builder: (_) {
        //             return NotificationPage();
        //           }),
        //         );
        //       },
        //       child: FaIcon(
        //         FontAwesomeIcons.bell,
        //         color: primarycolor,
        //       ),
        //     ),
        //   ),
        //   SizedBox(
        //     width: MediaQuery.of(context).size.width / 45,
        //   )
        // ],
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Stack(
              children: <Widget>[
                new IconButton(
                  iconSize: 28.0,
                    color: primarycolor,
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) {
                          return NotificationPage();
                        }),
                      );
                      setState(() {
                        counter = 0;
                      });
                    }),
                counter != 0
                    ? new Positioned(
                        right: 9,
                        top: 8,
                        child: new Container(
                          padding: EdgeInsets.all(2),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          child: Text(
                            '$counter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : new Container()
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              // child: Text('OnClick Property',
              // ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getProportionateScreenHeight(50)),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: profilePic != null
                        ? NetworkImage(
                            '$profilePic',
                          )
                        : AssetImage('images/user.jpg'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '$userfullName',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Divider(
            //     height: 8.0,
            //     thickness: 3,
            //   ),
            ListTile(
              title: Text(
                'View Profile',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return ProfileScreen();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.infoCircle,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Shortlisted Property',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return WishListScreen();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.solidHeart,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Post Property',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return PostPropertynew();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.building,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Post Furniture',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return PostFurniturePage();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.chair,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Post Advertisement',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return PostAdvertisement();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.ad,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Post Electronics',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return PostElectronicsPage();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.microchip,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),
            ListTile(
              title: Text(
                'Post Services',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return PostServiceAdvertisementPage();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.cog,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),

            ListTile(
              title: Text(
                'Loan Agent',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return RegisterAsLoanAgent();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.personBooth,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),
            ListTile(
              title: Text(
                // 'Register As Rental Agent',
                'Agreement Agent',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return RegisterAsRentalAgent();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.houseUser,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),
            // ListTile(
            //   title: Text(
            //     'Post Agreement',
            //     style: TextStyle(
            //       fontSize: getProportionateScreenWidth(13),
            //       fontWeight: FontWeight.bold,
            //       color: primarycolor,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (_) {
            //         return PostAgreementScreen();
            //       }),
            //     );
            //   },
            //   leading: FaIcon(
            //     FontAwesomeIcons.page4,
            //     size: 20.0,
            //     color: Colors.green,
            //   ),
            // ),
            // Divider(
            //   //height: 2.0,
            //   thickness: 1,
            // ),
            // ListTile(
            //   title: Text(
            //     'Rent Agreement',
            //     style: TextStyle(
            //       fontSize: getProportionateScreenWidth(13),
            //       fontWeight: FontWeight.bold,
            //       color: primarycolor,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (_) {
            //         return AgreeMentPage();
            //       }),
            //     );
            //   },
            //   leading: FaIcon(
            //     FontAwesomeIcons.book,
            //     size: 20.0,
            //     color: Colors.green,
            //   ),
            // ),
            // Divider(
            //   //height: 2.0,
            //   thickness: 1,
            // ),
            ListTile(
              title: Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) {
                    return ContactUsScreen();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.phone,
                size: 20.0,
                color: Colors.green,
              ),
            ),
            Divider(
              //height: 2.0,
              thickness: 1,
            ),

            // ListTile(
            //   title: Text(
            //     'Top City',
            //     style: TextStyle(
            //       fontSize: getProportionateScreenWidth(13),
            //       fontWeight: FontWeight.bold,
            //       color: primarycolor,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (_) {
            //         return CityListPage("3");
            //       }),
            //     );
            //   },
            //   leading: FaIcon(
            //     FontAwesomeIcons.city,
            //     size: 20.0,
            //     color: Colors.green,
            //   ),
            // ),
            // Divider(
            //   //height: 2.0,
            //   thickness: 1,
            // ),
            // ListTile(
            //   title: Text(
            //     'City Agent',
            //     style: TextStyle(
            //       fontSize: getProportionateScreenWidth(13),
            //       fontWeight: FontWeight.bold,
            //       color: primarycolor,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (_) {
            //         return CityListPage("0");
            //       }),
            //     );
            //   },
            //   leading: FaIcon(
            //     FontAwesomeIcons.user,
            //     size: 20.0,
            //     color: Colors.green,
            //   ),
            // ),
            // Divider(
            //   //height: 2.0,
            //   thickness: 1,
            // ),
            // ListTile(
            //   title: Text(
            //     'City Builder',
            //     style: TextStyle(
            //       fontSize: getProportionateScreenWidth(13),
            //       fontWeight: FontWeight.bold,
            //       color: primarycolor,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (_) {
            //         return CityListPage("1");
            //       }),
            //     );
            //   },
            //   leading: FaIcon(
            //     FontAwesomeIcons.ccDiscover,
            //     size: 20.0,
            //     color: Colors.green,
            //   ),
            // ),
            // Divider(
            //   //height: 2.0,
            //   thickness: 1,
            // ),
            // ListTile(
            //   title: Text(
            //     'City Owner',
            //     style: TextStyle(
            //       fontSize: getProportionateScreenWidth(13),
            //       fontWeight: FontWeight.bold,
            //       color: primarycolor,
            //     ),
            //   ),
            //   onTap: () {
            //     Navigator.pop(context);
            //     Navigator.of(context).push(
            //       MaterialPageRoute(builder: (_) {
            //         return CityListPage("2");
            //       }),
            //     );
            //   },
            //   leading: FaIcon(
            //     FontAwesomeIcons.users,
            //     size: 20.0,
            //     color: Colors.green,
            //   ),
            // ),
            // Divider(
            //   //height: 2.0,
            //   thickness: 1,
            // ),
            ListTile(
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  fontWeight: FontWeight.bold,
                  color: primarycolor,
                ),
              ),
              onTap: () async {
                await SharedPreferencesConstants.instance.removeAll();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) {
                    return SignInScreen();
                  }),
                );
              },
              leading: FaIcon(
                FontAwesomeIcons.powerOff,
                size: 20.0,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _showProgressBar,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, bottom: 0.0, left: 10.0),
                      child: Container(
                        height: SizeConfig.screenHeight * 0.04,
                        width: SizeConfig.screenWidth * 0.6,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, left: 10.0),
                              child: GestureDetector(
                                onTap: () async {
                                  getLocation();
                                  setState(() {
                                    _locationSearchController.clear();
                                  });
                                  // initApp();
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.mapMarkerAlt,
                                  color: primarycolor,
                                ),
                              ),
                            ),
                            Text(
                              "${_address?.featureName ?? 'Mumbai'}, ${_address?.locality ?? 'Maharashtra'}, ${_address?.postalCode ?? 'India'}",
                              style: locationAddheadingStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                      child: Container(
                        width: SizeConfig.screenWidth * 0.6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey, // red as border color
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) {
                                return FiltterPage();
                              }),
                            );
                          },
                          child: TextField(
                            controller: _locationSearchController,
                            autofocus: false,
                            enabled: false,
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

                              hintText:
                                  "Search cities, localities, projects etc.",
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (_) {
                                      return FiltterPage();
                                    }),
                                  );
                                },
                                child: Icon(
                                  Icons.search,
                                  color: primarycolor,
                                ),
                              ),
                              // suffixIcon: IconButton(
                              //     icon: Icon(Icons.cancel),
                              //     onPressed: () {
                              //       _locationSearchController.clear();
                              //       setState(() {
                              //         _placeList.clear();
                              //         visLocSearch = false;
                              //       });
                              //       getLocation();
                              //     }),
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
                    ),
                    Visibility(
                      visible: visLocSearch,
                      child: Container(
                        height: 100,
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
                                var address = _placeList[index]["description"];
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
                    Visibility(
                      visible: !visLocSearch,
                      child: Container(
                        // margin: const EdgeInsets.all(10.0),
                        child: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: ClipRect(
                            /** Banner Widget **/
                            child: Banner(
                              message: "20% off !!",
                              location: BannerLocation.bottomStart,
                              color: Colors.red,
                              child: Container(
                                color: Colors.white,
                                height: 150,
                                child: Image.network(
                                  'https://onclickproperty.com//Onclick_Image/Post_Property_Images/0MohnishWelekar1614164872.jpeg',
                                  width: MediaQuery.of(context).size.width,
                                ), //Padding
                              ), //Container
                            ), //Banner
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 2,
                          margin: EdgeInsets.only(
                              bottom: 10, left: 10, right: 10, top: 0),
                        ), //ClipRect
                      ),
                    ),
                    //container
                    DefaultTabController(
                        length: 3, // length of tabs
                        initialIndex: 0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Material(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Material(
                                          color: Colors.white30,
                                          child: TabBar(
                                            labelStyle: TextStyle(
                                                fontFamily: "Muli",
                                                fontSize:
                                                    getProportionateScreenWidth(
                                                        14)),
                                            labelColor: primarycolor,
                                            unselectedLabelColor: Colors.grey,
                                            indicatorColor: primarycolor,
                                            tabs: [
                                              Tab(
                                                text: 'Residential',
                                              ),
                                              Tab(text: 'Commercial'),
                                              Tab(text: 'Project'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                elevation: 5.0,
                              ),
                              Container(
                                  height:
                                      //MediaQuery.of(context).size.height * 0.50,
                                      MediaQuery.of(context).size.height * 0.50,
                                  //width: MediaQuery.of(context).size.width * 0.25, //height of TabBarView
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              color: kPrimaryLightColor,
                                              width: 0.5))),
                                  child: TabBarView(
                                    children: <Widget>[
                                      ResidentialPropertyTab(
                                          _getLoading, localityName),
                                      CommericalPropertyTab(),
                                      ProjectPropertyTab(
                                          _getLoading, localityName),
                                    ],
                                  )),
                            ])),
                  ]),
            ),
          ),
        ),
      ),
    );
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
        _getallProperties(localityName, localityPincode);
        _getallCommercialProperties(localityName, localityPincode);
        _getallProjectProperties(localityName, localityPincode);
      });
    });
  }

  void _getallProperties(String localityName, String localityPincode) async {
    setState(() {
      _showProgressBar = (true);
    });

    try {
      SharedPreferencesConstants.instance
          .setStringValue(SharedPreferencesConstants.CITY, localityName);
      SharedPreferencesConstants.instance
          .setStringValue(SharedPreferencesConstants.PINCODE, localityPincode);

      Provider.of<AllDashboardResTopProperty>(context, listen: false).clear();
      Provider.of<AllDashboardResRentProperty>(context, listen: false).clear();
      Provider.of<AllDashboardResSellProperty>(context, listen: false).clear();
      FetchAllDashboardProperty fetchAllDashboardProperty =
          new FetchAllDashboardProperty();
      var result = await fetchAllDashboardProperty.getFetchAllDashboardProperty(
          "0", localityName, localityPincode, "1");
      print(result);
      if (result != null) {
        int resid = result["resid"];
        if (resid == 200) {
          int rowcounttop = result["rowcounttop"];
          if (rowcounttop > 0) {
            var fetchList = result["toppropertieslist"];
            print(fetchList.length);
            List<AllDashboardPropertyItems> tempTopPropertieslist = [];
            Provider.of<AllDashboardResTopProperty>(context, listen: false)
                .clear();
            for (var n in fetchList) {
              AllDashboardPropertyItems items = AllDashboardPropertyItems(
                  n["id"],
                  n["posterid"],
                  n["aid"],
                  n["propertytype"],
                  n["price"],
                  n["topimglink"]);
              tempTopPropertieslist.add(items);
              Provider.of<AllDashboardResTopProperty>(context, listen: false)
                  .addAllDashboardProperty(items);
            }
          }

          int rowcountrent = result["rowcountrent"];
          if (rowcountrent > 0) {
            var fetchList = result["rentpropertieslist"];
            print(fetchList.length);
            List<AllDashboardPropertyItems> tempRentPropertieslist = [];
            Provider.of<AllDashboardResRentProperty>(context, listen: false)
                .clear();
            for (var n in fetchList) {
              AllDashboardPropertyItems items = AllDashboardPropertyItems(
                  n["id"],
                  n["posterid"],
                  n["aid"],
                  n["propertytype"],
                  n["price"],
                  n["rentimglink"]);
              tempRentPropertieslist.add(items);
              Provider.of<AllDashboardResRentProperty>(context, listen: false)
                  .addAllDashboardProperty(items);
            }
          }

          int rowcountsell = result["rowcountsell"];
          if (rowcountsell > 0) {
            var fetchList = result["sellpropertieslist"];
            print(fetchList.length);
            List<AllDashboardPropertyItems> tempSellPropertieslist = [];
            Provider.of<AllDashboardResSellProperty>(context, listen: false)
                .clear();
            for (var n in fetchList) {
              AllDashboardPropertyItems items = AllDashboardPropertyItems(
                  n["id"],
                  n["posterid"],
                  n["aid"],
                  n["propertytype"],
                  n["price"],
                  n["sellimglink"]);
              tempSellPropertieslist.add(items);
              Provider.of<AllDashboardResSellProperty>(context, listen: false)
                  .addAllDashboardProperty(items);
            }
          }
          setState(() {
            _showProgressBar = (false);
          });
        } else {
          setState(() {
            _showProgressBar = (false);
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Plz Try Again"),
          //   backgroundColor: Colors.green,
          // ));
        }
      } else {
        setState(() {
          _showProgressBar = (false);
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Some Technical Problem Plz Try Again Later"),
          //   backgroundColor: Colors.green,
          // ));
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _showProgressBar = (false);
        // _scaffoldKey.currentState.showSnackBar(SnackBar(
        //   content: Text("Some Technical Problem Plz Try Again Later"),
        //   backgroundColor: Colors.green,
        // ));
      });
    }
  }

  void _getallCommercialProperties(
    String localityName,
    String localityPincode,
  ) async {
    setState(() {
      _showProgressBar = (true);
    });

    try {
      SharedPreferencesConstants.instance
          .setStringValue(SharedPreferencesConstants.CITY, localityName);
      SharedPreferencesConstants.instance
          .setStringValue(SharedPreferencesConstants.PINCODE, localityPincode);
      Provider.of<AllDashboardCommTopProperty>(context, listen: false).clear();
      Provider.of<AllDashboardCommSellProperty>(context, listen: false).clear();
      Provider.of<AllDashboardCommRentProperty>(context, listen: false).clear();

      FetchAllDashboardProperty fetchAllDashboardProperty =
          new FetchAllDashboardProperty();
      var result = await fetchAllDashboardProperty.getFetchAllDashboardProperty(
          "0", localityName, localityPincode, "2");
      print(localityName);
      print("Commerical///////////// ${result}");

      //----------------------Top Properties LIST--------------------------------

      if (result != null) {
        int resid = result["resid"];
        if (resid == 200) {
          int rowcounttop = result["rowcounttop"];
          if (rowcounttop > 0) {
            var fetchList = result["toppropertieslist"];
            print(fetchList.length);
            List<AllDashboardPropertyItems> tempTopPropertieslist = [];
            Provider.of<AllDashboardCommTopProperty>(context, listen: false)
                .clear();
            for (var n in fetchList) {
              AllDashboardPropertyItems items = AllDashboardPropertyItems(
                  n["id"],
                  n["posterid"],
                  n["aid"],
                  n["propertytype"],
                  n["price"],
                  n["topimglink"]);
              tempTopPropertieslist.add(items);
              Provider.of<AllDashboardCommTopProperty>(context, listen: false)
                  .addAllDashboardProperty(items);
            }
          }

          //----------------------Sell Properties LIST--------------------------------
          int rowcountsell = result["rowcountsell"];
          if (rowcountsell > 0) {
            var fetchList = result["sellpropertieslist"];
            print(fetchList.length);
            List<AllDashboardPropertyItems> tempSellPropertieslist = [];
            Provider.of<AllDashboardCommSellProperty>(context, listen: false)
                .clear();
            for (var n in fetchList) {
              AllDashboardPropertyItems items = AllDashboardPropertyItems(
                  n["id"],
                  n["posterid"],
                  n["aid"],
                  n["propertytype"],
                  n["price"],
                  n["sellimglink"]);
              tempSellPropertieslist.add(items);
              Provider.of<AllDashboardCommSellProperty>(context, listen: false)
                  .addAllDashboardProperty(items);
            }
          }

          //----------------------RENT LIST--------------------------------
          int rowcountrent = result["rowcountrent"];
          if (rowcountrent > 0) {
            var fetchList = result["rentpropertieslist"];
            print(fetchList.length);
            List<AllDashboardPropertyItems> tempRentPropertieslist = [];
            Provider.of<AllDashboardCommRentProperty>(context, listen: false)
                .clear();
            for (var n in fetchList) {
              AllDashboardPropertyItems items = AllDashboardPropertyItems(
                  n["id"],
                  n["posterid"],
                  n["aid"],
                  n["propertytype"],
                  n["price"],
                  n["rentimglink"]);
              tempRentPropertieslist.add(items);
              Provider.of<AllDashboardCommRentProperty>(context, listen: false)
                  .addAllDashboardProperty(items);
            }
          }
          setState(() {
            _showProgressBar = (false);
          });
        } else {
          setState(() {
            _showProgressBar = (false);
          });
        }
      } else {
        setState(() {
          _showProgressBar = (false);
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _showProgressBar = (false);
        // _scaffoldKey.currentState.showSnackBar(SnackBar(
        //   content: Text("Some Technical Problem Plz Try Again Later"),
        //   backgroundColor: Colors.green,
        // ));
      });
    }
  }

  void _getallProjectProperties(
      String localityName, String localityPincode) async {
    setState(() {
      _showProgressBar = (true);
    });

    try {
      SharedPreferencesConstants.instance
          .setStringValue(SharedPreferencesConstants.CITY, localityName);
      SharedPreferencesConstants.instance
          .setStringValue(SharedPreferencesConstants.PINCODE, localityPincode);

      Provider.of<AllDashboardProjectTopProperty>(context, listen: false)
          .clear();
      Provider.of<AllDashboardProjectSellProperty>(context, listen: false)
          .clear();
      FetchAllDashboardProperty fetchAllDashboardProperty =
          new FetchAllDashboardProperty();
      var result = await fetchAllDashboardProperty.getFetchAllDashboardProperty(
          "2", localityName, localityPincode, "");
      print(result);
      if (result != null) {
        int resid = result["resid"];
        if (resid == 200) {
          int rowcounttop = result["toppropertiesrowcount"];
          if (rowcounttop > 0) {
            var fetchList = result["topproperties"];
            print(fetchList.length);
            List<AllDashboardPropertyItems> tempTopPropertieslist = [];
            Provider.of<AllDashboardProjectTopProperty>(context, listen: false)
                .clear();
            for (var n in fetchList) {
              AllDashboardPropertyItems items = AllDashboardPropertyItems(
                  n["id"],
                  n["posterid"],
                  n["aid"],
                  n["propertytype"],
                  n["price"],
                  n["topimglink"]);
              tempTopPropertieslist.add(items);
              Provider.of<AllDashboardProjectTopProperty>(context,
                      listen: false)
                  .addAllDashboardProperty(items);
            }
          }

          int rowcountrent = result["sellpropertiesrowcount"];
          if (rowcountrent > 0) {
            var fetchList = result["sellproperties"];
            print(fetchList.length);
            List<AllDashboardPropertyItems> tempRentPropertieslist = [];
            Provider.of<AllDashboardProjectSellProperty>(context, listen: false)
                .clear();
            for (var n in fetchList) {
              AllDashboardPropertyItems items = AllDashboardPropertyItems(
                  n["id"],
                  n["posterid"],
                  n["aid"],
                  n["propertytype"],
                  n["price"],
                  n["sellimglink"]);
              tempRentPropertieslist.add(items);
              Provider.of<AllDashboardProjectSellProperty>(context,
                      listen: false)
                  .addAllDashboardProperty(items);
            }
          }
          setState(() {
            _showProgressBar = (false);
          });
        } else {
          setState(() {
            _showProgressBar = (false);
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Plz Try Again"),
          //   backgroundColor: Colors.green,
          // ));
        }
      } else {
        setState(() {
          _showProgressBar = (false);
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Some Technical Problem Plz Try Again Later"),
          //   backgroundColor: Colors.green,
          // ));
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _showProgressBar = (false);
        // _scaffoldKey.currentState.showSnackBar(SnackBar(
        //   content: Text("Some Technical Problem Plz Try Again Later"),
        //   backgroundColor: Colors.green,
        // ));
      });
    }
  }

  _getLoading(value) {
    // if (value == true) {
    //   setState(() {
    //     _showProgressBar = true;
    //   });
    // } else {
    //   setState(() {
    //     _showProgressBar = false;
    //   });
    // }
  }

  void sendNewToken() {
    setState(() {
      _showProgressBar = true;
    });
    try {
      FirebaseMessaging.instance.onTokenRefresh.listen((newtoken) async {
        print('New Token: $newtoken');
        NewTokenInsert newTokenSubmit = new NewTokenInsert();
        var result = await newTokenSubmit.getNewTokenInsert(newtoken);
        if (result != null) {
          print("property data ///${result}");
          var resid = result['resid'];
          if (resid == 200) {
            setState(() {
              _showProgressBar = false;
            });
          } else {
            setState(() {
              _showProgressBar = false;
            });
          }
        } else {
          setState(() {
            _showProgressBar = false;
          });
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        _showProgressBar = false;
      });
    }
  }

  void _getnotificationcount() async {
    setState(() {
      _showProgressBar = true;
    });
    try {
      FetchNotification fetchnotification = new FetchNotification();
      var fetchnotificationdata =
      await fetchnotification.getFetchNotification("4","");
      if (fetchnotificationdata != null) {
        var resid = fetchnotificationdata["resid"];
        var rowcount = fetchnotificationdata["rowcount"];
        if (resid == 200) {
            print("//notification count//////////////////////${rowcount}");
            setState(() {
              counter=rowcount;
              _showProgressBar = false;
            });
        } else {
          setState(() {
            _showProgressBar = false;
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Plz Try Again"),
          //   backgroundColor: Colors.green,
          // ));
        }
      } else {
        setState(() {
          _showProgressBar = false;
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Some Technical Problem Plz Try Again Later"),
          //   backgroundColor: Colors.green,
          // ));
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
