import 'dart:convert';
import 'dart:io';

import 'package:cool_stepper/cool_stepper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Insert_Data_Notification.dart';
import 'package:onclickproperty/Adaptor/Post_Furniture_Details_Image.dart';
import 'package:onclickproperty/Adaptor/fetch_Furniture_Type.dart';
import 'package:onclickproperty/Model/Furniture_Type.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:onclickproperty/utilities/numerictextinputformatter.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../const/const.dart';

class PostFurniturePage extends StatefulWidget {
  @override
  _PostFurniturePageState createState() => _PostFurniturePageState();
}

class _PostFurniturePageState extends State<PostFurniturePage> {
  @override
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  InsertDataNotification insertdatanotification = new InsertDataNotification();
  final format = DateFormat("yyyy-MM-dd");
  FToast fToast;
  bool autoValidate = false;
  bool showspinner = false;
  bool showdropdown = false;
  bool showdropdownlist = false;
  String FurnitureTypeID;
  String FurnitureTypeType;
  String FurnitureSubType;
  String BrandName;
  String title;
  String Price;
  String Pincode;
  String City;
  String FurnitureMaterial;
  String Quntity;
  String AdDescription;
  //List images;
  String _selectdate;
  String UID;
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  double lat;
  double long;
  bool showPlaceList = false;
  String AlternatNumber;
  String StdCode;
  String TelephoneNumber;

  List<Object> images = List<Object>();
  Future<File> _imageFile;
  List<File> imageslistfile = [];

  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    print("User ID:- ${UID}");

    _FurnitureTypeText.clear();
    _FurnitureSubTypeText.clear();
    _BrandText.clear();
    _TitleText.clear();
    _PriceText.clear();
    _PincodeText.clear();
    _CityText.clear();
    _FurnitureMaterialText.clear();
    _QuntityText.clear();
    _AdDescriptionText.clear();
    _textLocationSearch.clear();
    _textAlternatenumber.clear();
    _textStdCode.clear();
    _textTelephonenumber.clear();

    print("All Clear");
  }

  @override
  void initState() {
    getUserdata();
    _getFurnitureType();
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    images.add("");
  }

  List<String> selectedFurnitureSubType1 = [
    'Signal',
    'Double',
  ];
  List<String> selectedFurnitureSubType2 = [
    '1 Seater',
    '2 Seater',
    '4 Seater',
    '6 Seater',
    '8 Seater',
    '10 Seater',
  ];
  String Condition;
  List<String> selectedCondition = [
    "Almost Like New",
    "Brand New",
    "Gently Used",
    "Heavily Used",
    "UnBoxed",
  ];
  List<String> _Selectedcity = [
    'Mumbai',
    'Thane',
    'Nagpur',
    'Navi Mumbai',
    'Nashik',
    'Aurangabad',
  ];
  List<String> _SelectAreyou = [
    'Owner',
    'Agent',
  ];
  String AreYou;
  String _SearchLocation;
  List<FurnitureType> FurnitureTypelist = new List();

  TextEditingController _FurnitureTypeText = TextEditingController();
  TextEditingController _FurnitureSubTypeText = TextEditingController();
  TextEditingController _BrandText = TextEditingController();
  TextEditingController _TitleText = TextEditingController();
  TextEditingController _PriceText = TextEditingController();
  TextEditingController _PincodeText = TextEditingController();
  TextEditingController _CityText = TextEditingController();
  TextEditingController _FurnitureMaterialText = TextEditingController();
  TextEditingController _QuntityText = TextEditingController();
  TextEditingController _AdDescriptionText = TextEditingController();
  TextEditingController _textLocationSearch = TextEditingController();
  TextEditingController _textAlternatenumber = TextEditingController();
  TextEditingController _textStdCode = TextEditingController();
  TextEditingController _textTelephonenumber = TextEditingController();

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
    _SearchLocation = query;
    print('getLatLong');
    locationFromAddress(query).then((locations) {
      final output = locations[0].toString();
      print(output);
      double latd, longd;
      print(locations[0].latitude);
      print(locations[0].longitude);
      latd = locations[0].latitude;
      longd = locations[0].longitude;
      lat = locations[0].latitude;
      long = locations[0].longitude;

      placemarkFromCoordinates(latd, longd).then((placemarks) {
        final output = placemarks[0].toString();
        print(placemarks[0].locality);
        print('postalCode${placemarks[0].postalCode}');

        City = placemarks[0].locality.toString();
        Pincode = placemarks[0].postalCode.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<CoolStep> steps = [
      CoolStep(
        title: "Basic Information OF Furniture",
        subtitle: "Please fill some of the basic information to get started",
        content: Form(
          key: _formKey1,
          child: Column(
            children: [
              DropdownSearch<FurnitureType>(
                searchBoxController: _FurnitureTypeText,
                items: FurnitureTypelist,
                showClearButton: true,
                showSearchBox: true,
                hint: 'Furniture Type',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null) {
                    return 'This is required';
                  }
                },
                onSaved: (FurnitureType value) {
                  _FurnitureTypeText.text = value.FurnitureTypeName.toString();
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
                      FurnitureTypeID = newValue.FurnitureTypeID.toString();
                      FurnitureTypeType = newValue.FurnitureTypeName.toString();
                      print("FurnitureTypeID:- ${FurnitureTypeID}");
                      print("FurnitureTypeID:- ${FurnitureTypeType}");
                      showdropdown = false;
                      showdropdownlist = false;
                      if (FurnitureTypeID == "1") {
                        setState(() {
                          showdropdown = true;
                          showdropdownlist = true;
                        });
                      } else if (FurnitureTypeID == "2" ||
                          FurnitureTypeID == "3") {
                        setState(() {
                          showdropdown = true;
                          showdropdownlist = false;
                        });
                      }
                    },
                  );
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              Visibility(
                visible: showdropdown,
                child: DropdownSearch(
                  searchBoxController: _FurnitureSubTypeText,
                  items: showdropdownlist
                      ? selectedFurnitureSubType1
                      : selectedFurnitureSubType2,
                  showClearButton: true,
                  showSearchBox: true,
                  hint: 'Furniture SubType',
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) {
                      return 'This is required';
                    }
                  },
                  onSaved: (value) {
                    _FurnitureSubTypeText.text = value.toString();
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
                    ), //border: OutlineInputBorder(),
                  ),
                  onChanged: (newValue) {
                    setState(
                      () {
                        FurnitureSubType = newValue;
                        print("Furniture SubType:-${FurnitureSubType}");
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                    child: FaIcon(
                      FontAwesomeIcons.list,
                      color: primarycolor,
                    ),
                  ),
                ),
                hint: Text(
                  'Condition',
                  style: style,
                ),
                value: Condition,
                validator: (value) {
                  if (value == null) {
                    return 'This is required';
                  }
                },
                onChanged: (newValue) {
                  setState(
                    () {
                      Condition = newValue;
                      print("Condition:-${Condition}");
                    },
                  );
                },
                items: selectedCondition.map((Conditions) {
                  return DropdownMenuItem(
                    child: new Text(
                      Conditions,
                      style: kTextStyleForContent,
                    ),
                    value: Conditions,
                  );
                }).toList(),
                isExpanded: true,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _BrandText,
                obscureText: false,
                style: style,
                onChanged: (value) {
                  BrandName = value;
                  print("BrandName:-${BrandName}");
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This is required';
                  }
                },
                //validator: ShopownerNameValidate,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                    child: FaIcon(
                      FontAwesomeIcons.industry,
                      color: primarycolor,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Enter Brand",
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _TitleText,
                obscureText: false,
                style: style,
                onChanged: (value) {
                  title = value;
                  print("title:-${title}");
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This is required';
                  }
                },
                //validator: ShopownerNameValidate,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                    child: FaIcon(
                      FontAwesomeIcons.heading,
                      color: primarycolor,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Enter Title",
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                controller: _PriceText,
                obscureText: false,
                style: style,
                keyboardType: TextInputType.number,
                inputFormatters: [NumericTextFormatter()],
                onChanged: (value) {
                  Price = value;
                  print("Price:-${Price}");
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This is required';
                  }
                },
                //validator: ShopownerNameValidate,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                    child: FaIcon(
                      FontAwesomeIcons.moneyBill,
                      color: primarycolor,
                    ),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Enter Price",
                ),
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey1.currentState.validate()) {
            return "Fill form correctly";
          }
          return null;
        },
      ),
      CoolStep(
        title: "Basic Information OF Shop Owner",
        subtitle: "Please fill some of the basic information to get started",
        content: Container(
          child: Form(
            key: _formKey2,
            child: Column(
              children: [
                // TextFormField(
                //   controller: _PincodeText,
                //   obscureText: false,
                //   style: style,
                //   keyboardType: TextInputType.number,
                //   onChanged: (value) {
                //     Pincode = value;
                //     print("Pincode:-${Pincode}");
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'This is required';
                //     }
                //   },
                //   //validator: ShopownerNameValidate,
                //   decoration: InputDecoration(
                //     prefixIcon: Padding(
                //       padding: const EdgeInsets.only(
                //           top: 12.0, right: 0.0, left: 0.0),
                //       child: FaIcon(
                //         FontAwesomeIcons.codepen,
                //         color: primarycolor,
                //       ),
                //     ),
                //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                //     hintText: "Enter Pin Code",
                //   ),
                // ),
                // SizedBox(
                //   height: 15.0,
                // ),
                // DropdownButtonFormField(
                //   hint: Text(
                //     'City',
                //     style: style,
                //   ),
                //   value: City,
                //   decoration: InputDecoration(
                //     prefixIcon: Padding(
                //       padding: const EdgeInsets.only(
                //           top: 12.0, right: 0.0, left: 0.0),
                //       child: FaIcon(
                //         FontAwesomeIcons.city,
                //         color: primarycolor,
                //       ),
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value == null) {
                //       return 'This is required';
                //     }
                //   },
                //   onChanged: (newValue) {
                //     setState(
                //       () {
                //         City = newValue;
                //         print("City:- ${City}");
                //       },
                //     );
                //   },
                //   items: _Selectedcity.map((citys) {
                //     return DropdownMenuItem(
                //       child: new Text(
                //         citys,
                //         style: kTextStyleForContent,
                //       ),
                //       value: citys,
                //     );
                //   }).toList(),
                //   isExpanded: true,
                // ),
                // SizedBox(
                //   height: 15.0,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: TextFormField(
                        controller: _textLocationSearch,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                  top: 12.0, right: 0.0, left: 0.0),
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
                                  City = null;
                                  Pincode = null;
                                  showPlaceList = false;
                                });
                              }),
                          hintText: 'Location',
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
                SizedBox(
                  height: 15.0,
                ),
                DropdownButtonFormField(
                  hint: Text(
                    'You Are',
                    style: style,
                  ),
                  value: AreYou,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 0.0, left: 0.0),
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        color: primarycolor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'This is required';
                    }
                  },
                  onChanged: (newValue) {
                    setState(
                      () {
                        showPlaceList = false;
                        AreYou = newValue;
                        print("AreYou:- ${AreYou}");
                      },
                    );
                  },
                  items: _SelectAreyou.map((AreYou) {
                    return DropdownMenuItem(
                      child: new Text(
                        AreYou,
                        style: kTextStyleForContent,
                      ),
                      value: AreYou,
                    );
                  }).toList(),
                  isExpanded: true,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _FurnitureMaterialText,
                  obscureText: false,
                  style: style,
                  onChanged: (value) {
                    FurnitureMaterial = value;
                    print("FurnitureMaterial:- ${FurnitureMaterial}");
                  },
                  //validator: ShopownerNameValidate,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 0.0, left: 0.0),
                      child: FaIcon(
                        FontAwesomeIcons.circle,
                        color: primarycolor,
                      ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Enter Furniture Material",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This is required';
                    }
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _QuntityText,
                  obscureText: false,
                  style: style,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    Quntity = value;
                    print("Quntity:- ${Quntity}");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This is required';
                    }
                  },
                  //validator: ShopownerNameValidate,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 0.0, left: 0.0),
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        color: primarycolor,
                      ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Enter Quntity",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _AdDescriptionText,
                  obscureText: false,
                  style: style,
                  maxLines: 2,
                  onChanged: (value) {
                    AdDescription = value;
                    print("AdDescription:- ${AdDescription}");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This is required';
                    }
                  },
                  //validator: ShopownerNameValidate,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, right: 0.0, left: 0.0),
                      child: FaIcon(
                        FontAwesomeIcons.audioDescription,
                        color: primarycolor,
                      ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Enter Ad Description",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
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
                      padding: const EdgeInsets.only(
                          top: 0.0, right: 0.0, left: 0.0),
                      child: FaIcon(
                        FontAwesomeIcons.mobileAlt,
                        color: primarycolor,
                      ),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Alternate Mobile Number",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
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
              ],
            ),
          ),
        ),
        validation: () {
          if (!_formKey2.currentState.validate()) {
            return "Fill form correctly";
          }
          return null;
        },
      ),
      CoolStep(
        title: "STEP 3",
        subtitle: "Please fill some of the basic information to get started",
        content: Form(
          key: _formKey3,
          child: Column(
            children: <Widget>[
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       children: [
              //         RaisedButton(
              //             color: Colors.blue,
              //             child: new Text(
              //               "Choose File",
              //               style: TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //             onPressed: () async {
              //               List<File> result = await FilePicker.getMultiFile(
              //                   type: FileType.image);
              //               if (result != null) {
              //                 setState(() {
              //                   print("inside if in image picker");
              //                   //images.clear();
              //                   images = result;
              //                 });
              //               } else {
              //                 print("inside else in image picker");
              //               }
              //
              //               // print("Inside Pressed Button $images");
              //             }),
              //         SizedBox(
              //           height: MediaQuery.of(context).size.height / 20,
              //         ),
              //         Container(
              //             height: MediaQuery.of(context).size.height,
              //             child: images != null
              //                 ? GridView.count(
              //                     crossAxisCount: 3,
              //                     crossAxisSpacing: 4.0,
              //                     mainAxisSpacing: 8.0,
              //                     children:
              //                         List.generate(images.length, (index) {
              //                       return Center(
              //                         child: Image.file(images[index]),
              //                       );
              //                     }),
              //                   )
              //                 : Center(
              //                     child: Text('No image selected.'),
              //                   ))
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 50.0,
              ),
              buildImagePickerGridView(),
            ],
          ),
        ),
        validation: () {
          if (!_formKey3.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
    ];

    final stepper = CoolStepper(
      onCompleted: () {
        print("User ID:- ${UID}");
        print("FurnitureTypeID:- ${FurnitureTypeID}");
        print("FurnitureTypeName:- ${FurnitureTypeType}");
        print("Select Floor:-${FurnitureSubType}");
        if (FurnitureSubType == null || FurnitureSubType.isEmpty) {
          FurnitureSubType = "";
        }
        print("Condition:-${Condition}");
        if (Condition == null || Condition.isEmpty) {
          Condition = "";
        }
        print("BrandName:-${BrandName}");
        if (BrandName == null || BrandName.isEmpty) {
          BrandName = "";
        }
        print("title:-${title}");
        if (title == null || title.isEmpty) {
          title = "";
        }
        print("Price:-${Price}");
        if (Price == null || Price.isEmpty) {
          Price = "";
        }
        print("Pincode:-${Pincode}");
        if (Pincode == null || Pincode.isEmpty) {
          Pincode = "";
        }
        print("City:- ${City}");
        if (City == null || City.isEmpty) {
          City = "";
        }
        print("AreYou:- ${AreYou}");
        if (AreYou == null || AreYou.isEmpty) {
          AreYou = "";
        }
        print("FurnitureMaterial:- ${FurnitureMaterial}");
        if (FurnitureMaterial == null || FurnitureMaterial.isEmpty) {
          FurnitureMaterial = "";
        }
        print("Quntity:- ${Quntity}");
        if (Quntity == null || Quntity.isEmpty) {
          Quntity = "";
        }
        print("AdDescription:- ${AdDescription}");
        if (AdDescription == null || AdDescription.isEmpty) {
          AdDescription = "";
        }

        print("SearchLocation:- ${_SearchLocation}");
        if (_SearchLocation == null || _SearchLocation.isEmpty) {
          _SearchLocation = "";
        }
        print("AlternatNumber:- ${AlternatNumber}");
        if (AlternatNumber == null || AlternatNumber.isEmpty) {
          AlternatNumber = "";
        }
        print("StdCode:- ${StdCode}");
        if (StdCode == null || StdCode.isEmpty) {
          StdCode = "";
        }
        print("TelephoneNumber:- ${TelephoneNumber}");
        if (TelephoneNumber == null || TelephoneNumber.isEmpty) {
          TelephoneNumber = "";
        }

        print("lat:- ${lat}");
        print("long:- ${long}");
        print("--------------images-------------------");
        print(imageslistfile);

        _getImageSubmitData(
            imageslistfile,
            UID,
            FurnitureTypeID,
            FurnitureSubType,
            Condition,
            BrandName,
            title,
            Price,
            Pincode,
            City,
            _SearchLocation,
            AreYou,
            FurnitureMaterial,
            Quntity,
            AdDescription,
            _selectdate,
            lat != null ? lat.toString() : '',
            long != null ? long.toString() : '',
            AlternatNumber,
            StdCode,
            TelephoneNumber);
      },
      steps: steps,
      config: CoolStepperConfig(
        backText: "PREV",
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Post Furniture"),
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: stepper,
            ),
    );
  }

  //----------------------------------------------------------
  Widget buildImagePickerGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          print('if call');
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: getProportionateScreenWidth(300),
                  height: getProportionateScreenHeight(300),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: getProportionateScreenWidth(20),
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        // images.replaceRange(index, index + 1, ['']);
                        images.removeAt(index);
                        imageslistfile.removeAt(index);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          print('else call');
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // _onAddImageClick(index);
                _showPicker(context, index);
              },
            ),
          );
        }
      }),
    );
  }

  void _showPicker(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(index);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(index);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromGallery(index) async {
    _onAddImageClick(0, index);
  }

  _imgFromCamera(index) async {
    _onAddImageClick(1, index);
  }

  Future _onAddImageClick(int chooseType, int index) async {
    // FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);
    setState(()  async {
      if (chooseType == 0) {
        FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);
        _imageFile  = Future<File>.value(File(result.paths[0]));

        //_imageFile = ImagePicker.(source: ImageSource.gallery);
      } else {
        final _picker = ImagePicker();
        PickedFile image = await _picker.getImage(source: ImageSource.camera,imageQuality: 50);
        _imageFile = Future<File>.value(File(image.path));
        //_imageFile = ImagePicker.pickImage(source: ImageSource.camera);
      }
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
    //  var dir = await path_provider.getTemporaryDirectory();
    _imageFile.then((file) async {
      if (file != null) {
        setState(() {
          ImageUploadModel imageUpload = new ImageUploadModel();
          imageUpload.isUploaded = false;
          imageUpload.uploading = false;
          imageUpload.imageFile = file;
          imageUpload.imageUrl = '';
          images.replaceRange(index, index + 1, [imageUpload]);
          images.add("");
          imageslistfile.add(file);
        });
        // print(images);
        // print(_imageFile);
         print(imageslistfile);
      }
    });
  }


  //-----------------------------------------------------------

  void _getFurnitureType() async {
    setState(() {
      showspinner = true;
    });
    FetchFurnitureType fetchfurnituretypedata = new FetchFurnitureType();
    var fetchfurniturestype =
        await fetchfurnituretypedata.getFetchFurnitureType("0");
    var resid = fetchfurniturestype["resid"];
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
  }

  Future<String> _getImageSubmitData(
    List images,
    String u_id,
    String furniture_type,
    String furniture_subtype,
    String condition,
    String brand,
    String title,
    String price,
    String pin_code,
    String city,
    String area,
    String your_are,
    String furniture_material,
    String quality,
    String description,
    String date,
    String lat,
    String long,
    String alertnate_no,
    String std_code,
    String telphone_no,
  ) async {
    setState(() {
      showspinner = true;
    });
    try {
      FurnitureImageSubmit furnitureSubmitData = new FurnitureImageSubmit();
      var FurnitureData = await furnitureSubmitData.FurnitureuploadData(
        images,
        u_id,
        furniture_type,
        furniture_subtype,
        condition,
        brand,
        title,
        price,
        pin_code,
        city,
        area,
        your_are,
        furniture_material,
        quality,
        description,
        date,
        lat,
        long,
        alertnate_no,
        std_code,
        telphone_no,
      );
      if (FurnitureData != null) {
        print("property data ///${FurnitureData}");
        var resid = FurnitureData['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          var Furnitureid = FurnitureData['Furnitureid'];
          print("response from Furnitureid ${Furnitureid}");
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


          _getpostnotificationdetails("3",City,Furnitureid);

          _FurnitureTypeText.clear();
          _FurnitureSubTypeText.clear();
          _BrandText.clear();
          _TitleText.clear();
          _PriceText.clear();
          _PincodeText.clear();
          _CityText.clear();
          _FurnitureMaterialText.clear();
          _QuntityText.clear();
          _AdDescriptionText.clear();
          _textLocationSearch.clear();
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

  //sending notification
  Future<String> _getpostnotificationdetails(
      String actionId,
      String  CityName,
      String Furnitureid
      ) async {
    setState(() {
      showspinner = true;
    });
    try {
      var insertnotificationData =
      await insertdatanotification.getInsertDataNotification(
          actionId,
          CityName,
          Furnitureid
      );
      print("insertnotificationData///////////${insertnotificationData}");
      if (insertnotificationData != null) {
        print("insertnotificationData///${insertnotificationData}");
        var resid = insertnotificationData['success'];
        print("response from server ${resid}");
        if (resid == 1) {
          setState(() {
            showspinner = false;
            print("Notification Send");
          });
        } else {
          setState(() {
            showspinner = false;
            print("Notification Not  Send");
          });
          // _scaffoldKey.currentState.showSnackBar(SnackBar(
          //   content: Text("Plz Try Again"),
          //   backgroundColor: Colors.green,
          // ));
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

  //for getting lat Long
  getLatLong(String address) async {
    // From a query
    final query = '$address';
    _SearchLocation = address;
    print('getLatLong');
    // List<Placemark> placemark = await Geolocator().placemarkFromAddress(query);
    // print(placemark[0].position.latitude);
    // lat = placemark[0].position.latitude.toString();
    // print(placemark[0].position.longitude);
    // long = placemark[0].position.longitude.toString();
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}
