import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/const/const.dart';
import 'dart:async';
import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:onclickproperty/Adaptor/fetch_Property_Type.dart';
import 'package:onclickproperty/Model/SubPropertyType.dart';
import 'package:onclickproperty/const/modal_progress_hud.dart';
import 'package:onclickproperty/pages/filter_property_list_screen.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CommercialTabPage extends StatefulWidget {
  @override
  _CommercialTabPageState createState() => _CommercialTabPageState();
}

enum ListPropertyFor { Buy, Lease }

class _CommercialTabPageState extends State<CommercialTabPage> {
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
  List<SubPropertyType> commercialPropertyTypelist = new List();
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
  bool _seBuy = true;
  bool _seLease = false;

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
    var url = Uri.parse(request);
    var response = await http.get(url);
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
        localityName = placemarks[0].locality.toString();
        localityPincode = placemarks[0].postalCode.toString();
      });
    });
  }

  List<int> _TypePropertyfilters = <int>[];

  Iterable<Widget> get TypePropertyWidgets sync* {
    for (final SubPropertyType actor in commercialPropertyTypelist) {
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
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.SubPropertyName,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
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
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.name,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
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
    _getFetchingSubPropertyType('2');
  }

  @override
  Widget build(BuildContext context) {
    double chipContainerW = MediaQuery.of(context).size.width * 0.95;
    double chipContainerH = MediaQuery.of(context).size.height * 0.05;
    double mainContainer = MediaQuery.of(context).size.height * 0.72;
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 5.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 15, left: 15, top: 2, bottom: 0.0),
              child: ListView(
                children: [
                  Container(
                    height: mainContainer,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(10.0),
                        ),
                        Text(
                          "Looking to",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(14.0),
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10.0),
                        ),
                        Wrap(
                          children: [
                            ChoiceChip(
                              label: !_seBuy
                                  ? Text(
                                      'Buy',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      'Buy',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                              backgroundColor: Colors.white,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                color: !_seBuy
                                    ? Colors.grey[400]
                                    : kPrimaryLightColor1,
                                width: 1.0,
                              )),
                              selectedColor: !_seBuy
                                  ? Colors.transparent
                                  : kPrimaryLightColor,
                              selected: _seBuy,
                              onSelected: (bool selected) {
                                setState(() {
                                  _seLease = false;
                                  _seBuy = true;
                                  _propertySellorBuy = "Buy";
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ChoiceChip(
                              label: !_seLease
                                  ? Text(
                                      'Lease',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      'Lease',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                              backgroundColor: Colors.white,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                color: !_seLease
                                    ? Colors.grey[400]
                                    : kPrimaryLightColor1,
                                width: 1.0,
                              )),
                              selectedColor: !_seLease
                                  ? Colors.transparent
                                  : kPrimaryLightColor,
                              selected: _seLease,
                              onSelected: (bool selected) {
                                setState(() {
                                  _seBuy = false;
                                  _seLease = true;
                                  _propertySellorBuy = "Lease";
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10.0),
                        ),
                        Container(
                          width: SizeConfig.screenWidth * 0.6,
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
                          child: TextField(
                            controller: _locationSearchController,
                            autofocus: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20),
                                  vertical: getProportionateScreenWidth(9)),
                              hintText: "Search Location ...",
                              errorText: _SearchLocationvalidate
                                  ? 'City Can\'t Be Empty'
                                  : null,
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
                                      localityName = null;
                                      localityPincode = null;
                                      visLocSearch = false;
                                    });
                                  }),
                            ),
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
                                    var address =
                                        _placeList[index]["description"];
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
                        SizedBox(
                          height: getProportionateScreenHeight(15.0),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: getProportionateScreenWidth(10),
                            ),
                            Text(
                              "₹${(_startPriceValue).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionateScreenWidth(18),
                              ),
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
                                  "₹${(_endPriceValue).toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: getProportionateScreenWidth(18),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.plus,
                                  size: 10.0,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                Text(
                                  "Crores",
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
                            values: selectedRange,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            activeColor: primarycolor,
                            inactiveColor: Colors.transparent,
                            onChanged: (RangeValues newRange) {
                              setState(() {
                                selectedRange = newRange;
                                _startPriceValue = newRange.start;
                                _endPriceValue = newRange.end;
                              });
                            },
                            onChangeStart: (RangeValues newRange) {
                              setState(() {
                                selectedRange = newRange;
                                _startPriceValue = newRange.start;
                                _endPriceValue = newRange.end;
                              });
                            },
                            onChangeEnd: (RangeValues newRange) {
                              setState(() {
                                selectedRange = newRange;
                                _startPriceValue = newRange.start;
                                _endPriceValue = newRange.end;
                              });
                            },
                            semanticFormatterCallback: (double newValue) {
                              return '${newValue.round()} dollars';
                            }),
                        SizedBox(
                          height: getProportionateScreenHeight(10.0),
                        ),
                        Text(
                          "Type Of Property",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(14.0),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(5.0)),
                        Wrap(
                          children: TypePropertyWidgets.toList(),
                        ),
                        SizedBox(height: getProportionateScreenHeight(5.0)),
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
                                fontSize: getProportionateScreenWidth(15),
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
                                  fontSize: getProportionateScreenWidth(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: _visShowMore, child: showmoreWidget()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 5.0, bottom: 0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                            color: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Search',
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(18),
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _locationSearchController.text.isEmpty
                                    ? _SearchLocationvalidate = true
                                    : _SearchLocationvalidate = false;
                                localityName == null
                                    ? _SearchLocationvalidate = true
                                    : _SearchLocationvalidate = false;
                              });

                              var error = !_SearchLocationvalidate;
                              if (error) {
                                print(
                                    '_propertySellorBuy: $_propertySellorBuy');
                                print('localityName: $localityName');

                                String JoinedtypeOfProperty =
                                    _TypePropertyfilters.length != 0
                                        ? _TypePropertyfilters.join("#")
                                        : '';

                                String JoinedPostedBy =
                                    _PostedByFilters.length != 0
                                        ? _PostedByFilters.join("#")
                                        : '';
                                print(
                                    'JoinedtypeOfProperty $JoinedtypeOfProperty');

                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) {
                                    return FilterPropertyListScreen(
                                        '2',
                                        '0',
                                        _propertySellorBuy,
                                        localityName,
                                        localityPincode != null
                                            ? localityPincode
                                            : '',
                                        '',
                                        JoinedtypeOfProperty,
                                        _startValueArea.toStringAsFixed(0),
                                        _endValueArea.toStringAsFixed(0),
                                        _bathroomType != null
                                            ? _bathroomType
                                            : '',
                                        _startPriceValue.toStringAsFixed(0),
                                        _endPriceValue.toStringAsFixed(0),
                                        '',
                                        JoinedPostedBy,
                                        _locationSearchController.text
                                            .toString());
                                  }),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
            this.commercialPropertyTypelist = tempsubpropertytypelist;
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

  Widget showmoreWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // showMoreAmenitiesWidget(),
        showMorePostedByWidget(),
        SizedBox(
          height: getProportionateScreenHeight(20),
        ),
        showMoreAreaWidget(),
        // SizedBox(
        //   height: getProportionateScreenHeight(20),
        // ),
        // showMoreNoOfBathroomsWidget(),
        // SizedBox(
        //   height: getProportionateScreenHeight(20),
        // ),
        // showMoreFurnishingStatusWidget(),
        // SizedBox(
        //   height: getProportionateScreenHeight(15),
        // ),
        // showMoreRERAApprovedWidget()
      ],
    );
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

  Widget showMorePostedByWidget() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Posted By",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: getProportionateScreenWidth(14),
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

class PostedBy {
  const PostedBy(this.name);

  final String name;
}
