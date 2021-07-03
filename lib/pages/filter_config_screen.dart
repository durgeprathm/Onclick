import 'dart:async';
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onclickproperty/Adaptor/fetch_House_Type.dart';
import 'package:onclickproperty/Adaptor/fetch_Property_Type.dart';
import 'package:onclickproperty/Model/House_Type.dart';
import 'package:onclickproperty/Model/SubPropertyType.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/helper/keyboard.dart';
import 'package:onclickproperty/pages/filter_property_list_screen.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class FilterConfigScreen extends StatefulWidget {
  String tabType;
  String actionid;
  String lookingfor;
  String location;
  String pincode;
  String bedrooms;
  String propertytypes;
  String squrefeetstart;
  String squrefeetend;
  String bathroom;
  String pricestart;
  String priceend;
  String Furniture;
  String postedBy;

  // String address;
  String sortRadioValue;
  Function getFilterData;

  FilterConfigScreen(
      this.tabType,
      this.actionid,
      this.lookingfor,
      this.location,
      this.pincode,
      this.bedrooms,
      this.propertytypes,
      this.squrefeetstart,
      this.squrefeetend,
      this.bathroom,
      this.pricestart,
      this.priceend,
      this.Furniture,
      this.postedBy,
      // this.address,
      this.sortRadioValue,
      this.getFilterData);

  @override
  _FilterConfigScreenState createState() => _FilterConfigScreenState(
      this.tabType,
      this.actionid,
      this.lookingfor,
      this.location,
      this.pincode,
      this.bedrooms,
      this.propertytypes,
      this.squrefeetstart,
      this.squrefeetend,
      this.bathroom,
      this.pricestart,
      this.priceend,
      this.Furniture,
      this.postedBy,
      // this.address,
      this.sortRadioValue,
      this.getFilterData);
}

enum ListPropertyFor { Buy, Rent }

class _FilterConfigScreenState extends State<FilterConfigScreen> {
  String tabType;
  String actionid;
  String lookingfor;
  String location;
  String pincode;
  String bedrooms;
  String propertytypes;
  String squrefeetstart;
  String squrefeetend;
  String bathroom;
  String pricestart;
  String priceend;
  String Furniture;
  String postedBy;

  // String address;
  String sortRadioValue;
  Function getFilterData;

  _FilterConfigScreenState(
      this.tabType,
      this.actionid,
      this.lookingfor,
      this.location,
      this.pincode,
      this.bedrooms,
      this.propertytypes,
      this.squrefeetstart,
      this.squrefeetend,
      this.bathroom,
      this.pricestart,
      this.priceend,
      this.Furniture,
      this.postedBy,
      // this.address,
      this.sortRadioValue,
      this.getFilterData);

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showspinner = false;

  Geolocator geolocator = Geolocator();
  StreamSubscription<Position> _postionStream;
  Address _address;
  bool visLocSearch = false;
  var _locationSearchController = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  ListPropertyFor _ListPropertyValue = ListPropertyFor.Buy;
  String _propertySellorBuy = "Buy";
  String localityName;
  String localityPincode;
  Position position;
  double long;
  double lat;
  List<SubPropertyType> residentialPropertyTypelist = new List();
  List<HouseType> bhkTypelist = new List();
  String _selectedBHKID;
  String SubPropertyTypeID;
  bool _SearchLocationvalidate = false;

  var selectedRange = RangeValues(0.0, 100.0);
  double _startPriceValue = 0;
  double _endPriceValue = 100;
  static const double _minValue = 0;
  static const double _maxValue = 100;
  static const double _divisions = 100;

  var selectedRangeArea = RangeValues(0.0, 4000.0);
  double _startValueArea = 0;
  double _endValueArea = 4000;
  static const double _minValueArea = 0;
  static const double _maxValueArea = 4000;
  static const double _divisionsArea = 4000;
  bool _visShowMore = false;
  String _bathroomType;

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
    var uri  = Uri.parse(request);
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

        localityName = placemarks[0].locality.toString();
        localityPincode = placemarks[0].postalCode.toString();
      });
    });
  }

  final List<noOfBedroomsFilterEntry> _cast = <noOfBedroomsFilterEntry>[
    const noOfBedroomsFilterEntry("1 RK / 1 BHK"),
    const noOfBedroomsFilterEntry("2 BHK"),
    const noOfBedroomsFilterEntry("3 BHK"),
    const noOfBedroomsFilterEntry("4+ BHK"),
  ];
  List<int> _noOfBedroomsFilter = <int>[];

  Iterable<Widget> get noOfBedroomsWidgets sync* {
    for (final HouseType actor in bhkTypelist) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(
            color: !_noOfBedroomsFilter.contains(actor.HouseTypeID)
                ? Colors.grey[400]
                : kPrimaryLightColor1,
            width: 1.0,
          )),
          showCheckmark: false,
          selectedColor: !_noOfBedroomsFilter.contains(actor.HouseTypeID)
              ? Colors.transparent
              : kPrimaryLightColor,
          avatar: !_noOfBedroomsFilter.contains(actor.HouseTypeID)
              ? FaIcon(
                  FontAwesomeIcons.plus,
                  size: getProportionateScreenWidth(10),
                  color: Colors.grey,
                )
              : FaIcon(
                  FontAwesomeIcons.check,
                  size: getProportionateScreenWidth(10),
                  color: kPrimaryColor,
                ),
          label: !_noOfBedroomsFilter.contains(actor.HouseTypeID)
              ? Text(
                  actor.HouseTypeName,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.HouseTypeName,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
          selected: _noOfBedroomsFilter.contains(actor.HouseTypeID),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _noOfBedroomsFilter.add(actor.HouseTypeID);
              } else {
                _noOfBedroomsFilter.removeWhere((int name) {
                  return name == actor.HouseTypeID;
                });
              }
            });
          },
        ),
      );
    }
  }

  final List<TypePropertyEntry> __TypePropertycast = <TypePropertyEntry>[
    const TypePropertyEntry("Residential Apartment"),
    const TypePropertyEntry("Independent House/Villa"),
    const TypePropertyEntry("Plot/Land"),
    const TypePropertyEntry("Builder Floor"),
    const TypePropertyEntry("Serviced Apartment"),
    const TypePropertyEntry("Studio Apartment"),
  ];
  List<int> _TypePropertyfilters = <int>[];

  Iterable<Widget> get TypePropertyWidgets sync* {
    for (final SubPropertyType actor in residentialPropertyTypelist) {
      yield Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 0.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(
            color: !_TypePropertyfilters.contains(actor.SubPropertyId)
                ? Colors.grey[400]
                : kPrimaryLightColor1,
            width: 1.0,
          )),
          showCheckmark: false,
          selectedColor: !_TypePropertyfilters.contains(actor.SubPropertyId)
              ? Colors.transparent
              : kPrimaryLightColor,
          avatar: !_TypePropertyfilters.contains(actor.SubPropertyId)
              ? FaIcon(
                  FontAwesomeIcons.plus,
                  size: getProportionateScreenWidth(10),
                  color: Colors.grey,
                )
              : FaIcon(
                  FontAwesomeIcons.check,
                  size: getProportionateScreenWidth(10),
                  color: kPrimaryColor,
                ),
          label: !_TypePropertyfilters.contains(actor.SubPropertyId)
              ? Text(
                  actor.SubPropertyName,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.SubPropertyName,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
          selected: _TypePropertyfilters.contains(actor.SubPropertyId),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _TypePropertyfilters.add(actor.SubPropertyId);
              } else {
                _TypePropertyfilters.removeWhere((int name) {
                  return name == actor.SubPropertyId;
                });
              }
            });
          },
        ),
      );
    }
  }

  final List<AmeneitiesEntry> _AmeneitiesEntrycast = <AmeneitiesEntry>[
    const AmeneitiesEntry("Parking"),
    const AmeneitiesEntry("Lift"),
    const AmeneitiesEntry("Power Backup"),
    const AmeneitiesEntry("Gas Pipeline"),
    const AmeneitiesEntry("Swimming Pool"),
    const AmeneitiesEntry("Gymansium"),
    const AmeneitiesEntry("Club House"),
    const AmeneitiesEntry("WheelChair Friendly"),
    const AmeneitiesEntry("Pet Friendly"),
  ];
  List<String> _AmeneitiesEntryfilters = <String>[];

  Iterable<Widget> get AmeneitiesEntryWidgets sync* {
    for (final AmeneitiesEntry actor in _AmeneitiesEntrycast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(
            color: !_AmeneitiesEntryfilters.contains(actor.name)
                ? Colors.grey[400]
                : kPrimaryLightColor1,
            width: 1.0,
          )),
          showCheckmark: false,
          selectedColor: !_AmeneitiesEntryfilters.contains(actor.name)
              ? Colors.transparent
              : kPrimaryLightColor,
          avatar: !_AmeneitiesEntryfilters.contains(actor.name)
              ? FaIcon(
                  FontAwesomeIcons.plus,
                  size: getProportionateScreenWidth(10),
                  color: Colors.grey,
                )
              : FaIcon(
                  FontAwesomeIcons.check,
                  size: getProportionateScreenWidth(10),
                  color: kPrimaryColor,
                ),
          label: !_AmeneitiesEntryfilters.contains(actor.name)
              ? Text(
                  actor.name,
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.name,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
          selected: _AmeneitiesEntryfilters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _AmeneitiesEntryfilters.add(actor.name);
              } else {
                _AmeneitiesEntryfilters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  final List<BathroomEntry> _BathroomEntrycast = <BathroomEntry>[
    const BathroomEntry("1+"),
    const BathroomEntry("2+"),
    const BathroomEntry("3+"),
    const BathroomEntry("4+"),
    const BathroomEntry("5+"),
  ];
  List<String> _BathroomEntryfilters = <String>[];

  Iterable<Widget> get BathroomEntryWidgets sync* {
    for (final BathroomEntry actor in _BathroomEntrycast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: ChoiceChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(
            color: !_BathroomEntryfilters.contains(actor.name)
                ? Colors.grey[400]
                : kPrimaryLightColor1,
            width: 1.0,
          )),
          selectedColor: !_BathroomEntryfilters.contains(actor.name)
              ? Colors.transparent
              : kPrimaryLightColor,
          label: !_BathroomEntryfilters.contains(actor.name)
              ? Text(
                  actor.name,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.name,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
          selected: _BathroomEntryfilters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _BathroomEntryfilters.clear();
                _BathroomEntryfilters.add(actor.name);
                _bathroomType = actor.name;
                print('_BathroomEntrycast value $value');
                print('name == actor.name ${actor.name}');
              } else {
                _BathroomEntryfilters.clear();
                _bathroomType = null;
              }
            });
          },
        ),
      );
    }
  }

  final List<FurnishingEntry> _FurnishingEntrycast = <FurnishingEntry>[
    const FurnishingEntry("Fully Furnished"),
    const FurnishingEntry("Unfurnished"),
    const FurnishingEntry("Semi Furnished"),
  ];
  List<String> _FurnishingEntryilters = <String>[];

  Iterable<Widget> get _FurnishingEntryWidgets sync* {
    for (final FurnishingEntry actor in _FurnishingEntrycast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(
            color: !_FurnishingEntryilters.contains(actor.name)
                ? Colors.grey[400]
                : kPrimaryLightColor1,
            width: 1.0,
          )),
          showCheckmark: false,
          selectedColor: !_FurnishingEntryilters.contains(actor.name)
              ? Colors.transparent
              : kPrimaryLightColor,
          avatar: !_FurnishingEntryilters.contains(actor.name)
              ? FaIcon(
                  FontAwesomeIcons.plus,
                  size: getProportionateScreenWidth(10),
                  color: Colors.grey,
                )
              : FaIcon(
                  FontAwesomeIcons.check,
                  size: getProportionateScreenWidth(10),
                  color: kPrimaryColor,
                ),
          label: !_FurnishingEntryilters.contains(actor.name)
              ? Text(
                  actor.name,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.name,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
          selected: _FurnishingEntryilters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _FurnishingEntryilters.add(actor.name);
              } else {
                _FurnishingEntryilters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  final List<RERAEntry> _RERAEntrycast = <RERAEntry>[
    const RERAEntry("RERA Approved Properties"),
    const RERAEntry("RERA Approved Agents"),
  ];
  List<String> _RERAEntryfilters = <String>[];

  Iterable<Widget> get RERAEntryWidgets sync* {
    for (final RERAEntry actor in _RERAEntrycast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(
            color: !_RERAEntryfilters.contains(actor.name)
                ? Colors.grey[400]
                : kPrimaryLightColor1,
            width: 1.0,
          )),
          showCheckmark: false,
          selectedColor: !_RERAEntryfilters.contains(actor.name)
              ? Colors.transparent
              : kPrimaryLightColor,
          avatar: !_RERAEntryfilters.contains(actor.name)
              ? FaIcon(
                  FontAwesomeIcons.plus,
                  size: getProportionateScreenWidth(10),
                  color: Colors.grey,
                )
              : FaIcon(
                  FontAwesomeIcons.check,
                  size: getProportionateScreenWidth(10),
                  color: kPrimaryColor,
                ),
          label: !_RERAEntryfilters.contains(actor.name)
              ? Text(
                  actor.name,
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.name,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
          selected: _RERAEntryfilters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _RERAEntryfilters.add(actor.name);
              } else {
                _RERAEntryfilters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  final List<PostedBy> _PostedBycast = <PostedBy>[
    const PostedBy("Owner"),
    const PostedBy("Builder"),
    const PostedBy("Agent"),
  ];
  List<String> _PostedByFilters = <String>[];

  Iterable<Widget> get _PostedByWidgets sync* {
    for (final PostedBy actor in _PostedBycast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: FilterChip(
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(
            color: !_PostedByFilters.contains(actor.name)
                ? Colors.grey[400]
                : kPrimaryLightColor1,
            width: 1.0,
          )),
          showCheckmark: false,
          selectedColor: !_PostedByFilters.contains(actor.name)
              ? Colors.transparent
              : kPrimaryLightColor,
          avatar: !_PostedByFilters.contains(actor.name)
              ? FaIcon(
                  FontAwesomeIcons.plus,
                  size: getProportionateScreenWidth(10),
                  color: Colors.grey,
                )
              : FaIcon(
                  FontAwesomeIcons.check,
                  size: getProportionateScreenWidth(10),
                  color: kPrimaryColor,
                ),
          label: !_PostedByFilters.contains(actor.name)
              ? Text(
                  actor.name,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.name,
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
          selected: _PostedByFilters.contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                _PostedByFilters.add(actor.name);
              } else {
                _PostedByFilters.removeWhere((String name) {
                  return name == actor.name;
                });
              }
            });
          },
        ),
      );
    }
  }

  @override
  void initState() {
    _getBHKType();
    if (tabType == '1') {
      _getFetchingSubPropertyType('1');
    } else if (tabType == '2') {
      _getFetchingSubPropertyType('2');
    } else if (tabType == '3') {
      _getFetchingSubPropertyType('3');
    }

    setState(() {
      if (bedrooms.isNotEmpty) {
        var tempBedRoomList = bedrooms.split('#');
        tempBedRoomList.forEach((element) {
          _noOfBedroomsFilter.add(int.tryParse(element));
        });
      }
      if (propertytypes.isNotEmpty) {
        var tempTypeProperty = propertytypes.split('#');
        tempTypeProperty.forEach((element) {
          _TypePropertyfilters.add(int.tryParse(element));
        });
      }
      _PostedByFilters = postedBy.split('#');
      _BathroomEntryfilters.add(bathroom);
      _FurnishingEntryilters = Furniture.split('#');
    });
  }

  bool _seBuy = true;
  bool _seRent = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff757575),
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: Wrap(
            children: [
              ListTile(
                leading: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back) // the arrow back icon
                      ),
                ),
                title: Text(
                  "Filter",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(16)),
                ),
                trailing: TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kPrimaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: kPrimaryColor))),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(12),
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    String JoinedBedRooms = _noOfBedroomsFilter.length != 0
                        ? _noOfBedroomsFilter.join("#")
                        : '';
                    String JoinedtypeOfProperty =
                        _TypePropertyfilters.length != 0
                            ? _TypePropertyfilters.join("#")
                            : '';
                    String JoinedPostedBy = _PostedByFilters.length != 0
                        ? _PostedByFilters.join("#")
                        : '';
                    String JoinedFurnishing = _FurnishingEntryilters.length != 0
                        ? _FurnishingEntryilters.join("#")
                        : '';
                    getFilterData(
                        JoinedBedRooms,
                        JoinedtypeOfProperty,
                        JoinedPostedBy,
                        _bathroomType != null ? _bathroomType : '',
                        tabType == '1' ? JoinedFurnishing : '');
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Visibility(
                  visible: tabType == '1' ? true : false,
                  child: getResFilter()),
              Visibility(
                  visible: tabType == '2' ? true : false,
                  child: getCommFilter()),
              Visibility(
                  visible: tabType == '3' ? true : false,
                  child: getProjectFilter()),
            ],
          ),
        ));
  }

  Padding getResFilter() {
    double mainContainer = MediaQuery.of(context).size.height * 0.72;
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 2, bottom: 0.0),
      child: Container(
        height: mainContainer,
        child: ListView(
          children: [
            Text(
              "No.Of Bedrooms",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(12.0),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(5.0),
            ),
            Wrap(
              children: noOfBedroomsWidgets.toList(),
            ),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            Text(
              "Type Of Property",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(12.0),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(5.0)),
            Wrap(
              children: TypePropertyWidgets.toList(),
            ),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            Visibility(
              visible: !_visShowMore,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: kPrimaryLightColor,
                  child: FaIcon(
                    FontAwesomeIcons.lightbulb,
                    // size: getProportionateScreenWidth(35),
                    // color: kPrimaryColor,
                    color: kPrimaryColor,
                  ),
                ),
                title: Text(
                  'Looking For Something Specific?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
                subtitle: GestureDetector(
                  onTap: () {
                    setState(() {
                      _visShowMore = true;
                      // showmoreone = false;
                    });
                  },
                  child: Text(
                    'Add more Filters',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.normal,
                      fontSize: getProportionateScreenWidth(10),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(visible: _visShowMore, child: showmoreWidget()),
            SizedBox(height: getProportionateScreenHeight(15.0)),
          ],
        ),
      ),
    );
  }

  Padding getCommFilter() {
    double mainContainer = MediaQuery.of(context).size.height * 0.72;
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 2, bottom: 0.0),
      child: Container(
        height: mainContainer,
        child: ListView(
          children: [
            Text(
              "Type Of Property",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(12.0),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(5.0)),
            Wrap(
              children: TypePropertyWidgets.toList(),
            ),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            showMorePostedByWidget(),
            SizedBox(height: getProportionateScreenHeight(15.0)),
          ],
        ),
      ),
    );
  }

  Padding getProjectFilter() {
    print('lookingfor $lookingfor');
    double mainContainer = MediaQuery.of(context).size.height * 0.72;
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15, top: 2, bottom: 0.0),
      child: Container(
        height: mainContainer,
        child: ListView(
          children: [
            Text(
              "Type Of Property",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(12.0),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(5.0)),
            Wrap(
              children: TypePropertyWidgets.toList(),
            ),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            showMorePostedByWidget(),
            SizedBox(height: getProportionateScreenHeight(15.0)),
            Visibility(
              visible: lookingfor == '3' ? true : false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "No.Of Bedrooms",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(12.0),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(5.0),
                  ),
                  Wrap(
                    children: noOfBedroomsWidgets.toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getFetchingSubPropertyType(String Type) async {
    setState(() {
      showspinner = (true);
    });

    try {
      FetchPropertyType fetchpropertytypedata = new FetchPropertyType();
      var fetchpropertytype =
          await fetchpropertytypedata.getFetchPropertyType("1", Type);
      if (fetchpropertytype != null) {
        var resid = fetchpropertytype["resid"];
        if (resid == 200) {
          var fetchpropertytypesd = fetchpropertytype["PropertyTypeList"];
          print(fetchpropertytypesd);
          print(fetchpropertytypesd.length);
          List<SubPropertyType> tempsubpropertytypelist = [];
          for (var n in fetchpropertytypesd) {
            SubPropertyType pro = SubPropertyType(
              int.parse(n["SubPropertytypeID"]),
              n["SubPropertyName"],
            );
            tempsubpropertytypelist.add(pro);
          }
          setState(() {
            this.residentialPropertyTypelist = tempsubpropertytypelist;
            showspinner = (false);
          });
          print(
              "//////propertyTypelist/////////${tempsubpropertytypelist.length}");
          print("//////propertyTypelist 2/////////${tempsubpropertytypelist}");
        } else {
          setState(() {
            showspinner = (false);
          });
          // showspinner(false);
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("Plz Try Again"),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        setState(() {
          showspinner = (false);
        });
        // showspinner(false);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Some Technical Problem Plz Try Again Later"),
          backgroundColor: Colors.green,
        ));
      }
    } catch (e) {
      setState(() {
        showspinner = (false);
      });
      // showspinner(false);
      print(e);
    }
  }

  double _discretize(double value, double divisions) {
    double x = value - _minValue;
    double range = _maxValue - _minValue;

    double result = x / range;
    return (result * divisions).round() / divisions * range + _minValue;
  }

  void _getBHKType() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchBHKType fetchbhktypedata = new FetchBHKType();
      var fetchBHKtype = await fetchbhktypedata.getFetchBHKType("0");
      if (fetchBHKtype != null) {
        var resid = fetchBHKtype["resid"];
        if (resid == 200) {
          var fetchBHKsd = fetchBHKtype["housetype"];
          print(fetchBHKsd.length);
          List<HouseType> tempfetchBHK = [];
          for (var n in fetchBHKsd) {
            HouseType pro = HouseType(
              int.parse(n["houseTypeId"]),
              n["HouseTypeName"],
            );
            tempfetchBHK.add(pro);
          }
          setState(() {
            this.bhkTypelist = tempfetchBHK;
          });
          print("//////bhkTypelist/////////${bhkTypelist.length}");
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

  Widget showmoreWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // showMoreAmenitiesWidget(),
        showMorePostedByWidget(),
        SizedBox(
          height: getProportionateScreenHeight(15),
        ),
        // showMoreAreaWidget(),
        // SizedBox(
        //   height: getProportionateScreenHeight(20),
        // ),
        showMoreNoOfBathroomsWidget(),
        SizedBox(
          height: getProportionateScreenHeight(10),
        ),
        showMoreFurnishingStatusWidget(),
        // SizedBox(
        //   height: getProportionateScreenHeight(15),
        // ),
        // showMoreRERAApprovedWidget()
      ],
    );
  }

  Widget showMoreAmenitiesWidget() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Amenities",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),
        Wrap(
          children: AmeneitiesEntryWidgets.toList(),
        ),
      ],
    ));
  }

  Widget showMoreAreaWidget() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Area",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: getProportionateScreenWidth(15),
            ),
            Row(
              children: [
                Text(
                  "${(_startValueArea).toStringAsFixed(0)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(18),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(3.0),
                ),
                Text("sq.ft",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: getProportionateScreenWidth(12),
                    )),
              ],
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Text(
              "to",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: getProportionateScreenWidth(18),
              ),
            ),
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Row(
              children: [
                Text(
                  "${(_endValueArea).toStringAsFixed(0)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: getProportionateScreenWidth(18),
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(3.0),
                ),
                FaIcon(
                  FontAwesomeIcons.plus,
                  size: getProportionateScreenWidth(10),
                  color: Colors.black,
                ),
                SizedBox(
                  width: getProportionateScreenWidth(3.0),
                ),
                Text(
                  "sq.ft",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: getProportionateScreenWidth(12),
                  ),
                ),
              ],
            ),
          ],
        ),
        RangeSlider(
            values: selectedRangeArea,
            min: 0,
            max: 4000,
            divisions: 4000,
            activeColor: primarycolor,
            inactiveColor: Colors.transparent,
            onChanged: (RangeValues newRange) {
              setState(() {
                selectedRangeArea = newRange;
                _startValueArea = newRange.start;
                _endValueArea = newRange.end;
              });
            },
            onChangeStart: (RangeValues newRange) {
              setState(() {
                selectedRangeArea = newRange;
                _startValueArea = newRange.start;
                _endValueArea = newRange.end;
              });
            },
            onChangeEnd: (RangeValues newRange) {
              setState(() {
                selectedRangeArea = newRange;
                _startValueArea = newRange.start;
                _endValueArea = newRange.end;
              });
            },
            semanticFormatterCallback: (double newValue) {
              return '${newValue.round()} dollars';
            }),
      ],
    ));
  }

  Widget showMoreNoOfBathroomsWidget() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "No Of Bathrooms",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(12),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),
        Wrap(
          children: BathroomEntryWidgets.toList(),
        ),
        SizedBox(
          height: getProportionateScreenHeight(3.0),
        ),
      ],
    ));
  }

  Widget showMoreFurnishingStatusWidget() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Furnishing Status",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(12),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),
        Wrap(
          children: _FurnishingEntryWidgets.toList(),
        ),
        SizedBox(
          height: getProportionateScreenHeight(3),
        ),
      ],
    ));
  }

  Widget showMoreRERAApprovedWidget() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RERA Approved",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(14),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),
        Wrap(
          children: RERAEntryWidgets.toList(),
        ),
        SizedBox(
          height: getProportionateScreenHeight(3),
        ),
      ],
    ));
  }

  Widget showMorePostedByWidget() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Posted By",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(12),
          ),
        ),
        SizedBox(
          height: getProportionateScreenHeight(5),
        ),
        Wrap(
          children: _PostedByWidgets.toList(),
        ),
        SizedBox(
          height: getProportionateScreenHeight(3),
        ),
      ],
    ));
  }
}

class noOfBedroomsFilterEntry {
  const noOfBedroomsFilterEntry(this.name);

  final String name;
}

class TypePropertyEntry {
  const TypePropertyEntry(this.TypePropertyname);

  final String TypePropertyname;
}

class AmeneitiesEntry {
  const AmeneitiesEntry(this.name);

  final String name;
}

class BathroomEntry {
  const BathroomEntry(this.name);

  final String name;
}

class FurnishingEntry {
  const FurnishingEntry(this.name);

  final String name;
}

class PostedBy {
  const PostedBy(this.name);

  final String name;
}

class RERAEntry {
  const RERAEntry(this.name);

  final String name;
}
