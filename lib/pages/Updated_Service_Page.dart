import 'dart:convert';
import 'dart:io';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Fetch_Updated.dart';
import 'package:onclickproperty/Adaptor/Update_Service_Adaptor.dart';
import 'package:onclickproperty/Adaptor/fetch_homeservice.dart';
import 'package:onclickproperty/Model/HomeServiceType.dart';
import 'package:onclickproperty/Model/UpdateServices.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../const/const.dart';
import 'home_page.dart';

class UpdateServicePage extends StatefulWidget {
  @override
  String id;

  UpdateServicePage(this.id);

  _UpdateServicePageState createState() => _UpdateServicePageState();
}

final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
FetchServiceType fetchServiceType = new FetchServiceType();
List<HomeServiceType> servicestype = [];
List<String> serviceTypeString = [];
List<String> serviceIdTypeString = [];
String _Name;
String _MobileNo;
String _LocationSearch;
String _Email;
String _AadharNumber;
String _selectdate;
String UID;
String fontimg;
String backimg;
File images;
File images2;
List<File> listfile1 = [];
List<File> listfile2 = [];
bool showspinner = false;
bool visFrontNetImage = false;
bool visBackNetImage = false;
var uuid = new Uuid();
String _sessionToken;
List<dynamic> _placeList = [];
double lat, long;
bool showPlaceList = false;

List<String> _city = [
  'Mumbai',
  'Thane',
  'Nagpur',
  'Navi Mumbai',
  'Aurangabad',
];
String _selectedCity;
String localityPincode;
List<String> _service = [
  'Painter',
  'Carpenter',
  'Plumber',
  'Electrician',
  'Pest-control',
  'Gardener',
  'Laundry',
  'Other',
  'packer Movers',
];
String _selectedService;
String _serviceid;
String AlternatNumber;
String StdCode;
String TelephoneNumber;

TextEditingController _textName = TextEditingController();
TextEditingController _textMobileNo = TextEditingController();
TextEditingController _textLocationSearch = TextEditingController();
TextEditingController _textEmail = TextEditingController();
TextEditingController _textAadharNumber = TextEditingController();
TextEditingController _textServiceName = TextEditingController();
TextEditingController _textAlternatenumber = TextEditingController();
TextEditingController _textStdCode = TextEditingController();
TextEditingController _textTelephonenumber = TextEditingController();

class _UpdateServicePageState extends State<UpdateServicePage> {
  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    print("User ID:- ${UID}");
  }

  @override
  void initState() {
    getUserdata();
    _getServiceType();
    _getservicesdata(widget.id.toString());
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    print("Date:-${_selectdate}");
  }

  List<UpdatedService> Fetchupdatedservicelist = new List();
  HomeServiceType _homeServiceType;

  Widget build(BuildContext context) {
    final List<CoolStep> steps = [
      CoolStep(
        title: "Update Advertisement for Services",
        subtitle: "Please fill info",
        content: Form(
          key: _formKey1,
          child: Column(
            children: <Widget>[
              name(),
              mobileNo(),
              AlternatemobileNo(),
              Telephoneno(),
              searchLocation(),
              service(),
              email(),
            ],
          ),
        ),
        validation: () {
          if (!_formKey1.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
      CoolStep(
        title: "Update Advertisement for Services",
        subtitle: "Please fill info",
        content: Form(
          key: _formKey2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              aadharNumber(),
              FrontIMage(),
              BackIMage(),
            ],
          ),
        ),
        validation: () {
          if (!_formKey2.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
    ];

    final stepper = CoolStepper(
      onCompleted: () {
        print("in complete");
        print("images1 list:-${listfile1}");
        print("images2 list:-${listfile2}");
        print("City:-${_selectedCity}");
        print("Your Name:-${_Name}");
        print("Mobile No:-${_MobileNo}");
        print("Location Search:-${_LocationSearch}");
        print("Service:-${_selectedService}");
        print("Your Email:-${_Email}");
        print("Aadhar Number:-${_AadharNumber}");
        print("Date:-${_selectdate}");
        print("AlternatNumber:-${AlternatNumber}");
        print("StdCode:-${StdCode}");
        print("TelephoneNumber:-${TelephoneNumber}");

        _getImageServiceAdData(
          fontimg != null ? '1' : '0',
          listfile1,
          listfile2,
          fontimg,
          backimg,
          _Name,
          _MobileNo,
          _selectedCity,
          localityPincode != null ? localityPincode : '',
          _LocationSearch,
          lat != null ? lat.toString() : '',
          long != null ? long.toString() : '',
          _selectedService,
          _Email,
          _AadharNumber,
          _selectdate,
          _serviceid,
          AlternatNumber != null ? AlternatNumber.toString() : '',
          StdCode != null ? StdCode.toString() : '',
          TelephoneNumber != null ? TelephoneNumber.toString() : '',
        );
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
        title: Text("Update Advertisement Services"),
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: stepper,
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
              validator: fullNameValidate,
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
                hintText: 'Mobile no.',
                hintStyle: style,
              ),
              validator: validateMobile,
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

  Padding Telephoneno() {
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

  //-----------------------------for location------------------------------------------------
  Padding searchLocation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextFormField(
              controller: _textLocationSearch,
              decoration: InputDecoration(
                prefixIcon: Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                    child: FaIcon(
                      FontAwesomeIcons.search,
                      color: primarycolor,
                    )),
                suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      _textLocationSearch.clear();
                      setState(() {
                        _placeList.clear();
                        _selectedCity = null;
                        localityPincode = null;
                        showPlaceList = false;
                      });
                    }),
                hintText: 'Search Location',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textLocationSearch.text = value;
              },
              onChanged: (value) {
                setState(() {
                  showPlaceList = true;
                });
                _onSearchlocation();
              },
            ),
          ),
          Visibility(
            visible: showPlaceList,
            child: Container(
              height: 100,
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics()
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_placeList[index]["description"]),
                    onTap: () {
                      _textLocationSearch.text =
                          _placeList[index]["description"];

                      var placeId = _placeList[index]["place_id"];
                      var address = _placeList[index]["description"];
                      print('${_placeList[index]}');
                      getPlaceInfoDetails(address);
                      // lat = detail.result.geometry.location.lat;
                      // long = detail.result.geometry.location.lng;
                      setState(() {
                        _placeList.clear();
                        showPlaceList = false;
                      });
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  _onSearchlocation() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestionforserchloction(_textLocationSearch.text);
  }

  void getSuggestionforserchloction(String input) async {
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
        print('postalCode${placemarks[0].postalCode}');

        _selectedCity = placemarks[0].locality.toString();
        localityPincode = placemarks[0].postalCode.toString();
      });
    });
  }

  Padding service() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Service Type:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12),
                  fontWeight: FontWeight.bold),
            ),
            DropdownSearch<HomeServiceType>(
              // searchBoxController: _textServiceName,
              items: servicestype,
              showClearButton: true,
              showSearchBox: true,
              showSelectedItem: true,
              compareFn: (HomeServiceType i, HomeServiceType s) => i.isEqual(s),
              selectedItem: _homeServiceType,
              hint: _textServiceName != null
                  ? "${_textServiceName.text.toString()}"
                  : 'select service',
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (_textServiceName.text.isEmpty) {
                  if (value == null) {
                    return 'This is required';
                  }
                }
              },
              onSaved: (HomeServiceType value) {
                _textServiceName.text = value.servicename.toString();
              },
              dropdownSearchDecoration: InputDecoration(
                hintStyle: style,
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.list,
                    color: primarycolor,
                  ),
                ),
                //border: OutlineInputBorder(),
              ),
              onChanged: (newValue) {
                setState(
                  () {
                    _selectedService = newValue.typeid.toString();
                    // _selectedBHKType = newValue.HouseTypeName.toString();
                    print("_selectedService:- ${_selectedService}");
                    print(
                        "_selectedservicename:- ${newValue.servicename.toString()}");
                    //print("BHKtype:- ${_selectedBHKType}");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding email() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textEmail,
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
                hintText: 'Email',
                hintStyle: style,
              ),
              validator: validateEmail,
              onSaved: (String value) {
                _textEmail.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _Email = newValue;
                  print("Your Email:-${_Email}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding aadharNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textAadharNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.idCardAlt,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Aadhar Number',
                hintStyle: style,
              ),
              validator: validateAadharCard,
              onSaved: (String value) {
                _textAadharNumber.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _AadharNumber = newValue;
                  print("Aadhar Number:-${_AadharNumber}");
                });
              },
            ),
          ),
        ],
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
                  "Front Photo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Visibility(
                          visible: !visFrontNetImage,
                          child: RaisedButton(
                              color: Colors.blue,
                              child: new Text(
                                "Choose Photo",
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
                                    listfile1.clear();
                                    images = File(result.paths[0]);
                                    listfile1.add(images);
                                    print("images:-${images}");
                                  });
                                } else {
                                  print("inside else in image picker");
                                }
                                // print("Inside Pressed Button $images");
                              }),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset("images/frontAadharnew.jpg"),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Visibility(
                      visible: !visFrontNetImage,
                      child: Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2,
                            child: images != null
                                ? Center(
                                    child: Stack(
                                      children: [
                                        Image.file(images),
                                        Positioned(
                                          right: 10,
                                          top: 5,
                                          child: InkWell(
                                            child: Icon(
                                              Icons.delete,
                                              size: getProportionateScreenWidth(
                                                  20),
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                visFrontNetImage = false;
                                                fontimg = null;
                                                listfile1.clear();
                                                images = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Text('No image selected.'),
                                  )),
                      ),
                    ),
                    Visibility(
                      visible: visFrontNetImage,
                      child: Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2,
                            child: fontimg != null
                                ? Center(
                                    child: Stack(
                                      children: [
                                        Image.network(fontimg),
                                        Positioned(
                                          right: 10,
                                          top: 5,
                                          child: InkWell(
                                            child: Icon(
                                              Icons.delete,
                                              size: getProportionateScreenWidth(
                                                  20),
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                visFrontNetImage = false;
                                                fontimg = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Text('No image selected.'),
                                  )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding BackIMage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Back Photo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Visibility(
                          visible: !visBackNetImage,
                          child: RaisedButton(
                              color: Colors.blue,
                              child: new Text(
                                "Choose Photo",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                /*File result = await FilePicker.getFile(
                                    type: FileType.image);*/
                                FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);
                                if (result != null) {
                                  setState(() {
                                    print("inside if in image picker");
                                    listfile2.clear();
                                    images2 = File(result.paths[0]);
                                    print("images2:-${images2}");
                                    listfile2.add(images2);
                                  });
                                } else {
                                  print("inside else in image picker");
                                }
                                // print("Inside Pressed Button $images");
                              }),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Image.asset("images/backadharnew.jpg"),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Visibility(
                      visible: !visBackNetImage,
                      child: Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2,
                            child: images2 != null
                                ? Center(
                                    child: Stack(
                                      children: [
                                        Image.file(images2),
                                        Positioned(
                                          right: 10,
                                          top: 5,
                                          child: InkWell(
                                            child: Icon(
                                              Icons.delete,
                                              size: getProportionateScreenWidth(
                                                  20),
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                visBackNetImage = false;
                                                backimg = null;
                                                listfile2.clear();
                                                images2 = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Text('No image selected.'),
                                  )),
                      ),
                    ),
                    Visibility(
                      visible: visBackNetImage,
                      child: Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height / 5,
                            width: MediaQuery.of(context).size.width / 2,
                            child: backimg != null
                                ? Center(
                                    child: Stack(
                                      children: [
                                        Image.network(backimg),
                                        Positioned(
                                          right: 10,
                                          top: 5,
                                          child: InkWell(
                                            child: Icon(
                                              Icons.delete,
                                              size: getProportionateScreenWidth(
                                                  20),
                                              color: Colors.red,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                visBackNetImage = false;
                                                backimg = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Text('No image selected.'),
                                  )),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //validation for full name
  String fullNameValidate(String value) {
    String patttern = r'^[a-z A-Z,.\-]+$';
    RegExp regExp = new RegExp(patttern);

    if (value.isEmpty || value == null) {
      return 'Please Enter Full Name';
    } else {
      if (!regExp.hasMatch(value)) {
        return 'Please enter valid full name';
      } else {
        return null;
      }
    }
  }

  // validation for mobile Number
  String validateMobile(String value) {
    Pattern pattern = r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
    RegExp regex = new RegExp(pattern);
    if (value == null || value == null) {
      return 'Please Enter Mobile Number';
    } else {
      if (!regex.hasMatch(value) && value.length != 10)
        return 'Mobile Number must be of 10 digit';
      else
        return null;
    }
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

  // validation for Aadhar Number
  String validateAadharCard(String value) {
    Pattern pattern = r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}';
    RegExp regex = new RegExp(pattern);
    if (value == null || value == null) {
      return 'Please Enter Aadhar Number';
    } else {
      if (!regex.hasMatch(value) && value.length != 12)
        return 'Aadhar Number must be of 12 digit';
      else
        return null;
    }
  }

  Future<String> _getImageServiceAdData(
    String actionId,
    List listfile1,
    List listfile2,
    String aadharfront,
    String aadharback,
    String Name,
    String Mobile_no,
    String city,
    String pincode,
    String area,
    String lat,
    String long,
    String service_type,
    String Email,
    String adhar_no,
    String date,
    String service_id,
    String alternateno,
    String stdcode,
    String telphoneno,
  ) async {
    setState(() {
      showspinner = true;
    });
    try {
      UpdateServiceAdImageSubmit serviceadSubmitData =
          new UpdateServiceAdImageSubmit();
      var ServiceadData = await serviceadSubmitData.ServiceAduploadData(
        fontimg != null ? '1' : '0',
        listfile1,
        listfile2,
        fontimg,
        backimg,
        Name,
        Mobile_no,
        city,
        pincode,
        area,
        lat,
        long,
        service_type,
        Email,
        adhar_no,
        date,
        service_id,
        alternateno,
        stdcode,
        telphoneno,
      );
      if (ServiceadData != null) {
        print("property data ///${ServiceadData}");
        var resid = ServiceadData['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              msg: "Data Updated Successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          _textName.clear();
          _textMobileNo.clear();
          _textLocationSearch.clear();
          _textEmail.clear();
          _textAadharNumber.clear();
          _textServiceName.clear();
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

  void _getservicesdata(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchUpdateList fetchupdatlist = new FetchUpdateList();
      var fetchupdatedsdata =
          await fetchupdatlist.getFetchUpdateList("0", "1", itemid);
      print(fetchupdatedsdata);
      if (fetchupdatedsdata != null) {
        var resid = fetchupdatedsdata["resid"];
        var rowcount = fetchupdatedsdata["rowcount"];
        if (resid == 200) {
          if (rowcount > 0) {
            var fetchupdatedsdatasd = fetchupdatedsdata["UserserviceList"];
            print(fetchupdatedsdatasd.length);
            List<UpdatedService> tempfetchupdatedlist = [];
            for (var n in fetchupdatedsdatasd) {
              UpdatedService pro = UpdatedService(
                n["id"],
                n["name"],
                n["mobileno"],
                n["city"],
                n["pincode"],
                n["area"],
                n["lat"],
                n["long"],
                n["servicetypeid"],
                n["servicetypename"],
                n["email"],
                n["adharno"],
                n["img1"],
                n["img2"],
                n["posteddate"],
                n["alternateno"],
                n["std"],
                n["telephoneno"],
              );
              tempfetchupdatedlist.add(pro);
            }
            setState(() {
              this.Fetchupdatedservicelist = tempfetchupdatedlist;
              _serviceid = Fetchupdatedservicelist[0].Serviceid.toString();

              _selectedService =
                  Fetchupdatedservicelist[0].servicetypeid.toString();
              _textServiceName.text =
                  Fetchupdatedservicelist[0].Servicetypename.toString();
              print(
                  "////servicename///////${Fetchupdatedservicelist[0].Servicetypename.toString()}");
              _Name = Fetchupdatedservicelist[0].name.toString();
              _textName.text = Fetchupdatedservicelist[0].name.toString();
              // city = Fetchupdatedservicelist[0].City.toString();
              _LocationSearch = Fetchupdatedservicelist[0].area.toString();
              _textLocationSearch.text =
                  Fetchupdatedservicelist[0].area.toString();
              _selectedCity = Fetchupdatedservicelist[0].City.toString();
              localityPincode = Fetchupdatedservicelist[0].pincode.toString();
              _MobileNo = Fetchupdatedservicelist[0].Mobilenumber.toString();
              _textMobileNo.text =
                  Fetchupdatedservicelist[0].Mobilenumber.toString();

              _textEmail.text = Fetchupdatedservicelist[0].Email.toString();
              _Email = Fetchupdatedservicelist[0].Email.toString();
              _AadharNumber =
                  Fetchupdatedservicelist[0].addharcardnumber.toString();
              _textAadharNumber.text =
                  Fetchupdatedservicelist[0].addharcardnumber.toString();

              fontimg = Fetchupdatedservicelist[0].imgfront.toString();
              backimg = Fetchupdatedservicelist[0].imgback.toString();
              if (fontimg != null) {
                visFrontNetImage = true;
              } else {
                visFrontNetImage = false;
              }
              if (backimg != null) {
                visBackNetImage = true;
              } else {
                visFrontNetImage = false;
              }
              print("fontimg ${fontimg}");
              print("backimg ${backimg}");
              _textAlternatenumber.text =
                  Fetchupdatedservicelist[0].Alternatenumber.toString();
              _textStdCode.text = Fetchupdatedservicelist[0].StdCode.toString();
              _textTelephonenumber.text =
                  Fetchupdatedservicelist[0].Telephone.toString();
              AlternatNumber =
                  Fetchupdatedservicelist[0].Alternatenumber.toString();
              StdCode = Fetchupdatedservicelist[0].StdCode.toString();
              TelephoneNumber = Fetchupdatedservicelist[0].Telephone.toString();
              showspinner = false;
            });

            print(
                "//////Fetchupdatedservicelist/////////${Fetchupdatedservicelist.length}");
          } else {
            setState(() {
              //showNoProduct = true;
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

  _getServiceType() async {
    setState(() {
      showspinner = true;
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
      servicestypeTemp.forEach((element) {
        serviceTypeString.add(element.servicename);
        serviceIdTypeString.add(element.typeid);
      });
      print("///servicestype/////////////////////${servicestype}");
      showspinner = false;
    });
  }
}
