import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Post_Advertisements_Details_Image.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class PostAdvertisement extends StatefulWidget {
  @override
  _PostAdvertisementState createState() => _PostAdvertisementState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

String _CompanyName;
String _CompanyType;
String _CompanyWebsite;
String _WorkEmail;
String _TitleOfYourAd;
String _DescriptionOfYourAd;
String _Name;
String _MobileNo;
File images;
List<File> listfile = [];
bool showspinner = false;
String _selectdate;
String UID;

List<String> _city = [
  'Mumbai',
  'Thane',
  'Nagpur',
  'Navi Mumbai',
  'Aurangabad',
];
String _selectedCity;

TextEditingController _textCompanyName = TextEditingController();
TextEditingController _textCompanyType = TextEditingController();
TextEditingController _textCompanyWebsite = TextEditingController();
TextEditingController _textWorkEmail = TextEditingController();
TextEditingController _textTitleOfYourAd = TextEditingController();
TextEditingController _textDescriptionOfYourAd = TextEditingController();
TextEditingController _textName = TextEditingController();
TextEditingController _textMobileNo = TextEditingController();
TextEditingController _textAlternatenumber = TextEditingController();
TextEditingController _textStdCode = TextEditingController();
TextEditingController _textTelephonenumber = TextEditingController();

String AlternatNumber;
String StdCode;
String TelephoneNumber;

Geolocator geolocator = Geolocator();
StreamSubscription<Position> _postionStream;
Address _address;
bool visLocSearch = false;
var _locationSearchController = TextEditingController();
bool _SearchLocationvalidate = false;
var uuid = new Uuid();
String _sessionToken;
List<dynamic> _placeList = [];
String localityPincode;
Position position;
double long;
double lat;
String cArea;

class _PostAdvertisementState extends State<PostAdvertisement> {
  @override
  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    print("User ID:- ${UID}");
    _Name = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERFULLNAME);
    _textName.text = _Name;
    print("User _Name:- ${_Name}");
    _MobileNo = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERMOBNO);
    _textMobileNo.text = _MobileNo;
    print("User MobileNo:- ${_MobileNo}");

    _textCompanyName.clear();
    _textCompanyType.clear();
    _textCompanyWebsite.clear();
    _textWorkEmail.clear();
    _textTitleOfYourAd.clear();
    _textDescriptionOfYourAd.clear();
    _textName.clear();
    _textMobileNo.clear();
    _textAlternatenumber.clear();
    _textStdCode.clear();
    _textTelephonenumber.clear();
    print("==============All clear----------");
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

  getPlaceInfoDetails(String address) async {
    final query = '$address';
    cArea = '$address';
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
        print('postalCode${placemarks[0].postalCode}');

        _selectedCity = placemarks[0].locality.toString();
        localityPincode = placemarks[0].postalCode.toString();
      });
    });
  }

  @override
  void initState() {
    getUserdata();
    //_getFurnitureType();
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    print("Date:-${_selectdate}");
  }

  Widget build(BuildContext context) {
    final List<CoolStep> steps = [
      CoolStep(
        title: "Post Free Ad",
        subtitle: "Company Information",
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              companyName(),
              city(),
              companyType(),
              companyWebsite(),
              workEmail(),
              titileOfYourAd(),
              descriptionOfYourAd(),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
      CoolStep(
        title: "Post Free Ad",
        subtitle: "Your Information",
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              FrontIMage(),
              Divider(
                height: 5.0,
                thickness: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              name(),
              mobileNo(),
              AlternatemobileNo(),
              TelephoneNo(),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
    ];

    final stepper = CoolStepper(
      onCompleted: () {
        print("images:-${listfile}");
        print("Company Name:-${_CompanyName}");
        print("City:-${_selectedCity}");
        print("Company Type:-${_CompanyType}");
        print("Company Website:-${_CompanyWebsite}");
        print("Work Email:-${_WorkEmail}");
        print("Title of your ad:-${_TitleOfYourAd}");
        print("Description of your ad:-${_DescriptionOfYourAd}");
        print("Your Name:-${_Name}");
        print("Mobile No:-${_MobileNo}");
        print("AlternatNumber:-${AlternatNumber}");
        print("StdCode:-${StdCode}");
        print("TelephoneNumber:-${TelephoneNumber}");
        print("User ID:- ${UID}");
        print("Date:-${_selectdate}");

        _getImageAdvertisementData(
            listfile,
            UID,
            _CompanyName,
            _CompanyType,
            _CompanyWebsite,
            _TitleOfYourAd,
            _DescriptionOfYourAd,
            _selectedCity,
            _selectdate,
            _WorkEmail,
            lat != null ? lat.toString() : '',
            long != null ? long.toString() : '',
            AlternatNumber != null ? AlternatNumber.toString() : '',
            StdCode != null ? StdCode.toString() : '',
            TelephoneNumber != null ? TelephoneNumber.toString() : '');

        print("Steps completed!");
      },
      steps: steps,
      config: CoolStepperConfig(
        backText: "PREV",
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Post Advertisements"),
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: stepper,
            ),
    );
  }

  Padding FrontIMage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Photo Of Advertisement",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        RaisedButton(
                            color: Colors.blue,
                            child: new Text(
                              "Choose Banner",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              // File result = await FilePicker.getFile(
                              //     type: FileType.image);
                              FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

                              if (result != null) {
                                setState(() {
                                  print("inside if in image picker");
                                  listfile.clear();
                                  images = File(result.paths[0]);
                                  listfile.add(images);
                                  print("images:-${listfile}");
                                });
                              } else {
                                print("inside else in image picker");
                              }
                              // print("Inside Pressed Button $images");
                            }),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 5,
                    width: MediaQuery.of(context).size.width,
                    child: images != null
                        ? Center(
                            child: Image.file(images),
                          )
                        : Center(
                            child: Text('No image selected.'),
                          ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding companyName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textCompanyName,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.industry,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Company Name',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textCompanyName.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _CompanyName = newValue;
                  print("Company Name:-${_CompanyName}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding city() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: DropdownButtonFormField(
          //     hint: Text(
          //       'City',
          //       style: style,
          //     ),
          //     value: _selectedCity,
          //     decoration: InputDecoration(
          //       prefixIcon: Padding(
          //         padding:
          //             const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
          //         child: FaIcon(
          //           FontAwesomeIcons.list,
          //           color: primarycolor,
          //         ),
          //       ),
          //     ),
          //     validator: (value) {
          //       if (value == null) {
          //         return 'This is required';
          //       }
          //     },
          //     onChanged: (newValue) {
          //       setState(
          //         () {
          //           _selectedCity = newValue;
          //           print("City:-${_selectedCity}");
          //         },
          //       );
          //     },
          //     items: _city.map((face) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           face,
          //           style: kTextStyleForContent,
          //         ),
          //         value: face,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),
          Container(
            // padding: EdgeInsets.only(left: 5.0, right: 5.0),
            // width: SizeConfig.screenWidth * 0.6,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            )),
            child: TextFormField(
              controller: _locationSearchController,
              autofocus: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenWidth(9)),
                hintText: "Company Location ...",
                errorText:
                    _SearchLocationvalidate ? 'City Can\'t Be Empty' : null,
                prefixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    color: primarycolor,
                  ),
                ),
                suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      _locationSearchController.clear();
                      setState(() {
                        _placeList.clear();
                        _selectedCity = null;
                        localityPincode = null;
                        visLocSearch = false;
                      });
                    }),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onChanged: (value) {
                _onLocationSearchChanged();
                setState(() {
                  visLocSearch = true;
                });
              },
            ),
          ),
          Visibility(
            visible: visLocSearch,
            child: Container(
              height: getProportionateScreenHeight(100.0),
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
          // SizedBox(
          //   height: getProportionateScreenHeight(15.0),
          // ),
        ],
      ),
    );
  }

  Padding companyType() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textCompanyType,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.industry,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Company Type',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textCompanyName.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _CompanyType = newValue;
                  print("Company Type:-${_CompanyType}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding companyWebsite() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textCompanyWebsite,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.sitemap,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Company Website',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textCompanyWebsite.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _CompanyWebsite = newValue;
                  print("Company Website:-${_CompanyWebsite}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding workEmail() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textWorkEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.envelope,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Work Email',
                hintStyle: style,
              ),
              validator: validateEmail,
              onSaved: (String value) {
                _textWorkEmail.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _WorkEmail = newValue;
                  print("Work Email:-${_WorkEmail}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding titileOfYourAd() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textTitleOfYourAd,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.heading,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Title of your Advertisement',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textTitleOfYourAd.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _TitleOfYourAd = newValue;
                  print("Title of your ad:-${_TitleOfYourAd}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding descriptionOfYourAd() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textDescriptionOfYourAd,
              keyboardType: TextInputType.multiline,
              maxLength: 1000,
              maxLines: 3,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.audioDescription,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Description of your Advertsiment',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textDescriptionOfYourAd.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _DescriptionOfYourAd = newValue;
                  print("Description of your ad:-${_DescriptionOfYourAd}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding name() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textName,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Full Name',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textName.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _Name = newValue;
                  print("Your Name:-${_Name}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding mobileNo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textMobileNo,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.mobileAlt,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Mobile Number',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textMobileNo.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _MobileNo = newValue;
                  print("Mobile No:-${_MobileNo}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding AlternatemobileNo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textAlternatenumber,
              obscureText: false,
              style: style,
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                AlternatNumber = value;
                print("AlternatNumber:- ${AlternatNumber}");
              },
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'This is required';
              //   }
              // },
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 0.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.mobileAlt,
                    color: primarycolor,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: "Alternate Mobile Number",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding TelephoneNo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _textStdCode,
                    obscureText: false,
                    style: style,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      StdCode = value;
                      print("StdCode:- ${StdCode}");
                    },
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'This is required';
                    //   }
                    // },
                    decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 0.0, right: 0.0, left: 0.0),
                      //   child: FaIcon(
                      //     FontAwesomeIcons.audioDescription,
                      //     color: primarycolor,
                      //   ),
                      // ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "STD Code",
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 32,
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: _textTelephonenumber,
                    obscureText: false,
                    style: style,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      TelephoneNumber = value;
                      print("TelephoneNumber:- ${TelephoneNumber}");
                    },
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'This is required';
                    //   }
                    // },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, right: 0.0, left: 0.0),
                        child: FaIcon(
                          FontAwesomeIcons.phone,
                          color: primarycolor,
                        ),
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Telephone",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //validation for email id
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);

    if (value == null || value == null) {
      return 'Please Enter Email';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter Valid Email';
      else
        return null;
    }
  }

  Future<String> _getImageAdvertisementData(
      List images,
      String u_id,
      String company_name,
      String company_type,
      String company_web,
      String company_title,
      String company_description,
      String company_city,
      String date,
      String company_email,
      String lat,
      String long,
      String alertnate_no,
      String std_code,
      String telphone_no) async {
    setState(() {
      showspinner = true;
    });
    try {
      AdvertisementImageSubmit advertisementSubmitData =
          new AdvertisementImageSubmit();
      var advertisementData =
          await advertisementSubmitData.AdvertisementuploadData(
              images,
              u_id,
              company_name,
              company_type,
              company_web,
              company_title,
              company_description,
              cArea != null ? cArea : '',
              company_city != null ? company_city : '',
              localityPincode != null ? localityPincode : '',
              date,
              company_email,
              lat,
              long,
              alertnate_no,
              std_code,
              telphone_no);
      if (advertisementData != null) {
        print("property data ///${advertisementData}");
        var resid = advertisementData['resid'];
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

           _textCompanyName.clear();
           _textCompanyType.clear();
           _textCompanyWebsite.clear();
           _textWorkEmail.clear();
           _textTitleOfYourAd.clear();
           _textDescriptionOfYourAd.clear();
           _textName.clear();
           _textMobileNo.clear();
           _textAlternatenumber.clear();
           _textStdCode.clear();
           _textTelephonenumber.clear();


          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) {
              return HomePage();
            }),
          );
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
