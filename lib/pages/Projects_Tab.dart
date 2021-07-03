import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onclickproperty/Adaptor/fetch_House_Type.dart';
import 'package:onclickproperty/Model/House_Type.dart';
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

class ProjectsTabPage extends StatefulWidget {
  @override
  _ProjectsTabPageState createState() => _ProjectsTabPageState();
}

enum ListPropertyFor { Residential, Commercial }

class _ProjectsTabPageState extends State<ProjectsTabPage> {
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
  ListPropertyFor _ListPropertyValue = ListPropertyFor.Residential;
  String _lookingType = "Residential";
  String localityName;
  String localityPincode;
  Position position;
  double long;
  double lat;
  List<SubPropertyType> projectPropertyTypelist = [];

  String SubPropertyTypeID;
  bool _SearchLocationvalidate = false;
  List<HouseType> bhkTypelist = [];
  String _selectedBHKID;
  bool visBHKType = false;
  String _lookingTypeId;
  bool _seResidential = true;
  bool _seCommerical = false;

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
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                )
              : Text(
                  actor.HouseTypeName,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
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

  List<int> _TypePropertyfilters = <int>[];

  Iterable<Widget> get TypePropertyWidgets sync* {
    for (final SubPropertyType actor in projectPropertyTypelist) {
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
    _getFetchingSubPropertyType('3');
    _getBHKType();
    setState(() {
      var tempString = _ListPropertyValue;
      if (tempString == ListPropertyFor.Residential) {
        _lookingType = "Residential";
        _lookingTypeId = '3';
        visBHKType = true;
      } else {
        _lookingType = "Commerical";
        _lookingTypeId = '4';
        visBHKType = false;
      }
    });
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
                              label: !_seResidential
                                  ? Text(
                                      'Residential',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      'Residential',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                              backgroundColor: Colors.white,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                color: !_seResidential
                                    ? Colors.grey[400]
                                    : kPrimaryLightColor1,
                                width: 1.0,
                              )),
                              selectedColor: !_seResidential
                                  ? Colors.transparent
                                  : kPrimaryLightColor,
                              selected: _seResidential,
                              onSelected: (bool selected) {
                                setState(() {
                                  _seCommerical = false;
                                  _seResidential = true;
                                  _lookingType = "Residential";
                                  _lookingTypeId = '3';
                                  visBHKType = true;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ChoiceChip(
                              label: !_seCommerical
                                  ? Text(
                                      'Commerical',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      'Commerical',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                              backgroundColor: Colors.white,
                              shape: StadiumBorder(
                                  side: BorderSide(
                                color: !_seCommerical
                                    ? Colors.grey[400]
                                    : kPrimaryLightColor1,
                                width: 1.0,
                              )),
                              selectedColor: !_seCommerical
                                  ? Colors.transparent
                                  : kPrimaryLightColor,
                              selected: _seCommerical,
                              onSelected: (bool selected) {
                                setState(() {
                                  _seResidential = false;
                                  _seCommerical = true;
                                  _lookingType = "Commerical";
                                  _lookingTypeId = '4';
                                  visBHKType = false;
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
                        SizedBox(height: getProportionateScreenHeight(15.0)),
                        showMorePostedByWidget(),
                        SizedBox(height: getProportionateScreenHeight(15.0)),
                        Visibility(
                          visible: visBHKType,
                          child: Container(
                              padding: EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "No.Of Bedrooms",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          getProportionateScreenWidth(14.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(5.0),
                                  ),
                                  Wrap(
                                    children: noOfBedroomsWidgets.toList(),
                                  ),
                                ],
                              )),
                        ),
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
                                print('localityName: $localityName');

                                String JoinedBedRooms =
                                    _noOfBedroomsFilter.length != 0
                                        ? _noOfBedroomsFilter.join("#")
                                        : '';
                                String JoinedtypeOfProperty =
                                    _TypePropertyfilters.length != 0
                                        ? _TypePropertyfilters.join("#")
                                        : '';

                                String JoinedPostedBy =
                                    _PostedByFilters.length != 0
                                        ? _PostedByFilters.join("#")
                                        : '';

                                print('JoinedBedRooms $JoinedBedRooms');
                                print(
                                    'JoinedtypeOfProperty $JoinedtypeOfProperty');

                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (_) {
                                    return FilterPropertyListScreen(
                                        '3',
                                        '0',
                                        _lookingTypeId,
                                        localityName,
                                        localityPincode != null
                                            ? localityPincode
                                            : '',
                                        JoinedBedRooms,
                                        JoinedtypeOfProperty,
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
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
            projectPropertyTypelist = tempsubpropertytypelist;
          });
          print(
              "//////propertyTypelist/////////${tempsubpropertytypelist.length}");
          print("//////propertyTypelist 2/////////${tempsubpropertytypelist}");
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
