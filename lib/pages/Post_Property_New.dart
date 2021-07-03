import 'dart:convert';
import 'dart:io';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Insert_Data_Notification.dart';
import 'package:onclickproperty/Adaptor/fetch_House_Type.dart';
import 'package:onclickproperty/Adaptor/fetch_Property_Type.dart';
import 'package:onclickproperty/Adaptor/fetch_features.dart';
import 'package:onclickproperty/Adaptor/property_image.dart';
import 'package:onclickproperty/Model/Feature_type.dart';
import 'package:onclickproperty/Model/House_Type.dart';
import 'package:onclickproperty/Model/Property_Type.dart';
import 'package:onclickproperty/Model/SubPropertyType.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:onclickproperty/utilities/constants.dart';
import 'package:onclickproperty/utilities/numerictextinputformatter.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class PostPropertynew extends StatefulWidget {
  @override
  _PostPropertynewState createState() => _PostPropertynewState();
}

//step1
final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
InsertDataNotification insertdatanotification = new InsertDataNotification();

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

var uuid = new Uuid();
String _sessionToken;
List<dynamic> _placeList = [];
String lat;
String long;

DateTime value = DateTime.now();
int changedCount = 0;
int savedCount = 0;
final format = DateFormat("yyyy-MM-dd");
bool autoValidate = false;
bool showResetIcon = false;
bool readOnly = false;
String _selectedPropertyTypeid;
String _selectedPropertyType;
String _selectedBHKType;
String _selectedBHKID;
String _selectedResidentialPropertyType;
String _selectedCommercialPropertyType;
String _selectedProjectResidentialPropertyType;
String _selectedProjectCommercialPropertyType;
String SubPropertyTypeID;
String _selectedcommercial;
String SubPropertyTypeName;
//Radio button List property for
enum ListPropertyForProject { Buy }

ListPropertyForProject Projectpropertyfor;
String Projectpropertyforstr;
//Radio button List property for
enum ListPropertyFor { Buy, Rent }

ListPropertyFor commonpropertyfor;
String CommonpropertyStr;
String PossessionDate;
String _selectedFloor;
String _selectedTotalFloor;
String _Description;
String _Deposite;
String _ExpectedRent;
String _OtherCharges;
String _RoadWidth;
String _PriceYouExpect;
String _MaintancePrice;
String _BuiltUpArea;
String _CarpetArea;
String Bathroom;
String Balconies;
String PinCode;
String StreetName;
String SoceityName;
String Area;
String SearchLocation;
String ContactNumber;
String alterContactNumber;
String Negotiablecheck;
String _selectdate;
String _stdcode;
String _telephonenumber;
//List images = [];
List<Object> images = List<Object>();
Future<File> _imageFile;
List<File> imageslistfile = [];

bool selectbutton = false;
bool afterselect = false;
bool showimage = false;
bool groundfloorCheckone = false;
bool groundfloorChecktwo = false;
bool checkmaintenance = false;

//Possession Date
DateTime selectedDate = DateTime.now();
var formatedDate =
    "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";

//boolean variables
bool isListPropertyForVisible = true;
bool isListPropertyForProjectVisible = false;
bool isResidentialPropertyTypeVisible = true;
bool isCommercialPropertyTypeVisible = false;
bool isProjectResidentialPropertyTypeVisible = false;
bool isProjectCommercialPropertyTypeVisible = false;
bool isBhkTypeVisible = true;
bool isresidentalland = true;
bool isPossessionDateVisible = true;

bool step1 = true;
bool step2 = true;
bool step3 = true;
bool step4 = true;

bool showPlaceList = false;
String UID;

//Step 2

bool _isNegotiable = false;
bool _islift = false;

//Drop down menu for select floor
List<String> _selectFloor = [];

//Drop down menu total floor
List<String> _totalFloor = [];

//Drop down menu property Age
List<String> _propertyAge = [
  'New Construction',
  'Less than 5 year',
  '5-10 year',
  '10-20 year',
  '20-30 year',
  'more than 30 year',
];
String _selectedPropertyAge;

//Drop down menu Facing
List<String> _facing = [
  'North ',
  'South',
  'East',
  'West',
  'North-East',
  'South-East',
  'North-West',
  'South-West',
];
String _selectedFacing;

//Drop down menu Parking
List<String> _parking = [
  'Bike',
  'Car',
  'Bike & Car',
  'None',
];
String _selectedParking;

//Drop down menu Maintenance
List<String> _maintenance = [
  'Included (Tax or Govt. charges)',
  'Excluded',
];
String _selectedMaintenance;

//Drop down menu preferred tenants
List<String> _preferredTenants = [
  'Anyone',
  'Family',
  'Bachelors',
];
String _selectedPreferredTenants;

//Drop down menu Furnishing
List<String> _furnishing = [
  'Fully Furnished',
  'Semi Furnished',
  'Unfurnished',
];
String _selectedFurnishing;

//step3

//Drop down menu Water supply
List<String> _waterSupply = [
  'Corporation',
  'Borewell',
  'Both',
];
String _selectedWaterSupply;

//Drop down menu Power cutting
List<String> _powerCutting = [
  'Rare',
  'No',
];
String _selectedPowerCutting;

//Drop down menu non veg allowed
List<String> _nonVegAllowed = [
  'Yes',
  'No',
];
String _selectedNonVegAllowed;

//Features bools
bool forvalidatingbuyrent = false;
bool isLiftSelected = false;
bool isParkSelected = false;
bool isChildrensPlayAreaSelected = false;
bool isSecuritySelected = false;
bool isHouseKeepingSelected = false;
bool isPowerBackupSelected = false;
bool isSwimmingPoolSelected = false;
bool isGymSelected = false;
bool isFireSafetySelected = false;
bool isServantRoomSelected = false;
bool isClubHouseSelected = false;
bool isAcSelected = false;
bool isInternetServicesSelected = false;
bool isInterComSelected = false;
bool isRainWaterHarvestingSelected = false;
bool isShoppinCenterSelected = false;
bool isGasPipelineSelected = false;
bool isSewageTreatmentPlantSelected = false;

//step 4

//Drop down menu Posted by
List<String> _postedBy = [
  'Owner',
  'Builder',
  'Agent',
];
String _selectedPostedBy;

//Drop down menu Posted by
List<String> _city = [
  'Mumbai',
  'Thane',
  'Nagpur',
  'Navi Mumbai',
  'Nashik',
  'Aurangabad',
];

String _selectedCity;

TextEditingController _textpossessionDate = TextEditingController();
TextEditingController _textPropertyType = TextEditingController();
TextEditingController _textSearchLocation = TextEditingController();
TextEditingController _textArea = TextEditingController();
TextEditingController _textSoceityName = TextEditingController();
TextEditingController _textStreetName = TextEditingController();
TextEditingController _textContactNumber = TextEditingController();
TextEditingController _textresidentialPropertyType = TextEditingController();
TextEditingController _textcommercialPropertyType = TextEditingController();
TextEditingController _textprojectResidentialPropertyType =
    TextEditingController();
TextEditingController _textbhkType = TextEditingController();
TextEditingController _textPinCode = TextEditingController();
TextEditingController _textpreferTen = TextEditingController();
TextEditingController _textnonveg = TextEditingController();
TextEditingController _textwatersupplier = TextEditingController();
TextEditingController _textpowercuting = TextEditingController();
TextEditingController _TextAlternateConatactNumber = TextEditingController();
TextEditingController _TextstdcodeNumber = TextEditingController();
TextEditingController _TexttelephoneNumber = TextEditingController();
TextEditingController _textNumberOfBathrooms = TextEditingController();
TextEditingController _textBuiltUpSqFt = TextEditingController();
TextEditingController _textCarpetAreaSqFt = TextEditingController();
TextEditingController _textPriceYouExpect = TextEditingController();
TextEditingController _textRoadWidth = TextEditingController();
TextEditingController _textOtherCharges = TextEditingController();
TextEditingController _textExpectedRentPerMonth = TextEditingController();
TextEditingController _textExpectedDeposite = TextEditingController();
TextEditingController _textDescription = TextEditingController();
TextEditingController _textNumberOfBalconies = TextEditingController();
TextEditingController _textMaintanice = TextEditingController();

class _PostPropertynewState extends State<PostPropertynew> {
  _onSearchlocation() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestionforserchloction(_textSearchLocation.text);
  }

  void getSuggestionforserchloction(String input) async {
    String kPLACES_API_KEY = "AIzaSyA8k5z6GiCXvSa9JifqxE7-0v4z22kcbKw";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    Uri req = Uri.parse(request);
    var response = await http.get(req);
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
    SearchLocation = '$address';
    double dlat, dlong;
    print('getLatLong');
    locationFromAddress(query).then((locations) {
      final output = locations[0].toString();
      print(output);
      print(locations[0].latitude);
      print(locations[0].longitude);
      dlat = locations[0].latitude;
      dlong = locations[0].longitude;
      lat = locations[0].latitude.toString();
      long = locations[0].longitude.toString();

      placemarkFromCoordinates(dlat, dlong).then((placemarks) {
        final output = placemarks[0].toString();
        print(placemarks[0].locality);
        print('postalCode${placemarks[0].postalCode}');

        _selectedCity = placemarks[0].locality.toString();
        PinCode = placemarks[0].postalCode.toString();
      });
    });
  }

  bool showspinner = false;
  List<PropertType> propertyTypelist = new List();
  List<HouseType> bhkTypelist = new List();
  List<SubPropertyType> residentialPropertyTypelist = new List();
  List<SubPropertyType> commercialPropertyTypelist = new List();
  List<SubPropertyType> projectResidentialPropertyTypelist = new List();
  List<SubPropertyType> projectcommercialPropertyTypelist = new List();
  List<FeaturesType> FeaturesTypelist = [];
  List<String> Featuresinputlist = [];

  // var _mfgDate;
  DateTime sDateTime;

  @override
  Widget build(BuildContext context) {


    //sending notification
    Future<String> _getpostnotificationdetails(
        String actionId,
        String  CityName,
        String Propertyid
        ) async {
      setState(() {
        showspinner = true;
      });
      try {
        var insertnotificationData =
        await insertdatanotification.getInsertDataNotification(
          actionId,
          CityName,
            Propertyid
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





    Future<String> _getImageSubmitData(
        List images,
        String User_ID,
        String Post_property_type,
        String pos_bay_now,
        String post_residential_type,
        String Post_residential_bhk_type,
        String Post_project_possession_date,
        String Post_floor,
        String Post_total_floor,
        String Post_property_age,
        String Post_property_size,
        String Post_carpet_area,
        String Post_facing,
        String Post_excepted_price,
        String Post_excepted_rent,
        String Post_Excepted_deposite,
        String Post_power_cut,
        String Post_other_charge,
        String Post_Maintance,
        String Post_furnishing,
        String Post_tenants,
        String Post_date,
        String Post_parking,
        String Post_description,
        String Post_roadwidth,
        String Post_no_bathroom,
        String Post_no_balconies,
        String Post_water_supply,
        String Post_non_veg_allowed,
        String Post_features_available,
        String Post_i_am,
        String Post_Mobile_No,
        String Post_city,
        String Post_pincode,
        String Post_socity,
        String Post_street,
        String Post_negotiable,
        String Post_Search_location,
        String Post_latitude,
        String Post_longtitude,
        String Post_Alertnate_No,
        String Post_STD_Code,
        String Post_Telephone_No) async {
      setState(() {
        showspinner = true;
      });
      PropertyImageSubmit propertySubmitData = new PropertyImageSubmit();
      var propertydata = await propertySubmitData.PropertyuploadData(
          images,
          User_ID,
          Post_property_type,
          pos_bay_now,
          post_residential_type,
          Post_residential_bhk_type,
          Post_project_possession_date,
          Post_floor,
          Post_total_floor,
          Post_property_age,
          Post_property_size,
          Post_carpet_area,
          Post_facing,
          Post_excepted_price,
          Post_excepted_rent,
          Post_Excepted_deposite,
          Post_power_cut,
          Post_other_charge,
          Post_Maintance,
          Post_furnishing,
          Post_tenants,
          Post_date,
          Post_parking,
          Post_description,
          Post_roadwidth,
          Post_no_bathroom,
          Post_no_balconies,
          Post_water_supply,
          Post_non_veg_allowed,
          Post_features_available,
          Post_i_am,
          Post_Mobile_No,
          Post_city,
          Post_pincode,
          Post_socity,
          Post_street,
          Post_negotiable,
          Post_Search_location,
          Post_latitude,
          Post_longtitude,
          Post_Alertnate_No,
          Post_STD_Code,
          Post_Telephone_No);
      if (propertydata != null) {
        print("property data ///${propertydata}");
        var resid = propertydata['resid'];
        print("response from server ${resid}");
        if (resid == 200) {
          var Propertyid = propertydata['Propertyid'];
          print("response from Propertyid ${Propertyid}");
          setState(() {
            showspinner = false;
          });
          Fluttertoast.showToast(
              // msg: "Data Successfully Save !",
              msg: "Thanks You For Posting Your Property!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          _getpostnotificationdetails("0",Post_city,Propertyid);

          _textpossessionDate.clear();
          _textPropertyType.clear();
          _textSearchLocation.clear();
          _textArea.clear();
          _textSoceityName.clear();
          _textStreetName.clear();
          _textContactNumber.clear();
          _textresidentialPropertyType.clear();
          _textcommercialPropertyType.clear();
          _textprojectResidentialPropertyType.clear();
          _textbhkType.clear();
          _textPinCode.clear();
          _textpreferTen.clear();
          _textnonveg.clear();
          _textwatersupplier.clear();
          _textpowercuting.clear();
          _TextAlternateConatactNumber.clear();
          _TextstdcodeNumber.clear();
          _TexttelephoneNumber.clear();
          _textNumberOfBathrooms.clear();
          _textBuiltUpSqFt.clear();
          _textCarpetAreaSqFt.clear();
          _textPriceYouExpect.clear();
          _textRoadWidth.clear();
          _textOtherCharges.clear();
          _textExpectedRentPerMonth.clear();
          _textExpectedDeposite.clear();
          _textDescription.clear();
          _textNumberOfBalconies.clear();

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
    }





    final List<CoolStep> steps = [
      CoolStep(
          title: "STEP 1",
          subtitle: "Please fill some of the basic information to get started",
          content: Form(
            key: _formKey1,
            child: Column(
              children: <Widget>[
                //Property type
                propertyType(),

                //List Property For
                Visibility(
                  child: listPropertyFor(),
                  visible: isListPropertyForVisible,
                ),

                //List Property For Project
                Visibility(
                  child: listPropertyForProject(),
                  visible: isListPropertyForProjectVisible,
                ),

                //Residential property type
                Visibility(
                  child: residentialPropertyType(),
                  visible: isResidentialPropertyTypeVisible,
                ),

                //Commercial property type
                Visibility(
                  child: commercialPropertyType(),
                  visible: isCommercialPropertyTypeVisible,
                ),

                //Project Residential property type
                Visibility(
                  child: projectResidentialPropertyType(),
                  visible: isProjectResidentialPropertyTypeVisible,
                ),

                //Project Commercial property type
                Visibility(
                  child: projectCommercialPropertyType(),
                  visible: isProjectCommercialPropertyTypeVisible,
                ),
                //BHK Type
                Visibility(
                  child: bhkType(),
                  visible: isBhkTypeVisible &&
                          _selectedResidentialPropertyType !=
                              "Residential Land" ||
                      isProjectResidentialPropertyTypeVisible == true,
                ),

                //Possession Date
                Visibility(
                  child: possessionDate(context),
                  visible: isPossessionDateVisible,
                ),
              ],
            ),
          ),
          validation: () {
            if (!_formKey1.currentState.validate()) {
              return 'Fill Form Correctely';
            }
          }),
      CoolStep(
        title: "STEP 2",
        subtitle: "Please Provide details about your property",
        content: Form(
          key: _formKey2,
          child: Column(
            children: <Widget>[
              Visibility(visible: isresidentalland, child: selectFloor()),
              Visibility(visible: isresidentalland, child: totalFloor()),
              propertyAge(),
              builtUpArea(),
              carpetArea(),
              facing(),
              parking(),
              maintenance(),
              Visibility(visible: checkmaintenance, child: MaintancePrice()),
              Visibility(child: preferredTenants(), visible: isRent()),
              Visibility(visible: isresidentalland, child: furnishing()),
              Visibility(child: expectedRentPerMonth(), visible: isRent()),
              Visibility(child: expectedDeposite(), visible: isRent()),
              Visibility(child: priceYouExpect(), visible: isSell()),
              Visibility(
                child: negotiable(),
                visible: isSell(),
              ),
              roadWidth(),
              otherCharges(),
              description(),
            ],
          ),
        ),
        validation: () {
          if (!_formKey2.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
      CoolStep(
          title: "STEP 3",
          subtitle:
              "Please Provide additional details about your property to get max visibility",
          content: Form(
            key: _formKey3,
            child: Column(
              children: <Widget>[
                numberOfBathrooms(),
                numberOfBalconies(),
                waterSupply(),
                powerCutting(),
                Visibility(
                  child: nonVegAllowed(),
                  visible: isRent(),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Select the features available',
                    style: kTextStyleForTitles,
                  ),
                )),
                features(),
              ],
            ),
          ),
          validation: () {
            if (!_formKey3.currentState.validate()) {
              return 'Fill Form Correctely';
            }
          }),
      CoolStep(
        title: "STEP 4",
        subtitle: "Please fill some of the basic information to get started",
        content: Form(
          key: _formKey4,
          child: Column(
            children: <Widget>[
              postedBy(),
              contactNumber(),
              AlternatecontactNumber(),
              TelephoneNumber(),
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Provide location details',
                  style: kTextStyleForTitles,
                ),
              )),
              // city(),
              searchLocation(),
              area(),
              societyName(),
              streetName(),
              // pinCode(),
            ],
          ),
        ),
        validation: () {
          if (!_formKey4.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
      CoolStep(
        title: "STEP 5",
        subtitle: "Please fill some of the basic information to get started",
        content: Form(
          key: _formKey5,
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // RaisedButton(
                      //     color: Colors.blue,
                      //     child: new Text(
                      //       "Choose File",
                      //       style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //     onPressed: () async {
                      //       List<File> result = await FilePicker.getMultiFile(
                      //           type: FileType.image);
                      //       if (result != null) {
                      //         setState(() {
                      //           print("inside if in image picker");
                      //           images.clear();
                      //           images = result;
                      //         });
                      //       } else {
                      //         print("inside else in image picker");
                      //       }
                      //
                      //       // print("Inside Pressed Button $images");
                      //     }),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height / 20,
                      // ),
                      // Container(
                      //     height: MediaQuery.of(context).size.height,
                      //     child: images.length != 0
                      //         ? GridView.count(
                      //             crossAxisCount: 3,
                      //             crossAxisSpacing: 4.0,
                      //             mainAxisSpacing: 8.0,
                      //             children:
                      //                 List.generate(images.length, (index) {
                      //               return Center(
                      //                 child: Image.file(images[index]),
                      //               );
                      //             }),
                      //           )
                      //         : Center(
                      //             child: Text('No image selected.'),
                      //           )),
                      //---------------------------------------- ------------------------------------
                      SizedBox(
                        height: 50.0,
                      ),
                      buildImagePickerGridView(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey5.currentState.validate()) {
            return 'Fill Form Correctely';
          }
        },
      ),
    ];

    final stepper = CoolStepper(
      onCompleted: () {
        print("propertytypeid:- ${_selectedPropertyTypeid}");
        print("propertytype:- ${_selectedPropertyType}");

        print("Commercial Property Id:- ${SubPropertyTypeID}");
        print("Commercial Property Name:- ${SubPropertyTypeName}");

        print("Commercial Property Id:- ${SubPropertyTypeID}");
        print("Commercial Property Name:- ${SubPropertyTypeName}");

        print("project Residential Property Id:- ${SubPropertyTypeID}");
        print("project Residential Property Name:- ${SubPropertyTypeName}");

        print("Project :- ${Projectpropertyforstr}");
        print("common property  :- ${CommonpropertyStr}");

        print("project Commerical Property Id:- ${SubPropertyTypeID}");
        print("project Commerical Property Name:- ${SubPropertyTypeName}");

        print("BHKid:- ${_selectedBHKID}");
        print("BHKtype:- ${_selectedBHKType}");
        if (_selectedBHKID == null || _selectedBHKID.isEmpty) {
          _selectedBHKID = "";
        }
        print("Possession Date:- ${PossessionDate}");
        if (PossessionDate == null || PossessionDate.isEmpty) {
          PossessionDate = "";
        }
        print("Select Floor:-${_selectedFloor}");
        if (_selectedFloor == null || _selectedFloor.isEmpty) {
          _selectedFloor = "";
        }
        print("Select Total Floor:-${_selectedTotalFloor}");
        if (_selectedTotalFloor == null || _selectedTotalFloor.isEmpty) {
          _selectedTotalFloor = "";
        }
        print("Property Age:- ${_selectedPropertyAge}");
        if (_selectedPropertyAge == null || _selectedPropertyAge.isEmpty) {
          _selectedPropertyAge = "";
        }

        print("Facing:-${_selectedFacing}");
        if (_selectedFacing == null || _selectedFacing.isEmpty) {
          _selectedFacing = "";
        }
        print("Parking:-${_selectedParking}");
        if (_selectedParking == null || _selectedParking.isEmpty) {
          _selectedParking = "";
        }

        print("Maintenance:-${_selectedMaintenance}");
        if (_selectedMaintenance == null || _selectedMaintenance.isEmpty) {
          _selectedMaintenance = "";
        }

        print("Preferred Tenants:-${_selectedPreferredTenants}");
        if (_selectedPreferredTenants == null ||
            _selectedPreferredTenants.isEmpty) {
          _selectedPreferredTenants = "";
        }

        print("Furnishing:-${_selectedFurnishing}");
        if (_selectedFurnishing == null || _selectedFurnishing.isEmpty) {
          _selectedFurnishing = "";
        }

        print("Built Up Area(sq.ft):-${_BuiltUpArea}");
        if (_BuiltUpArea == null || _BuiltUpArea.isEmpty) {
          _BuiltUpArea = "";
        }

        print("Carpet Area(sq.ft):-${_CarpetArea}");
        if (_CarpetArea == null || _CarpetArea.isEmpty) {
          _CarpetArea = "";
        }

        print("Price You Expect:-${_PriceYouExpect}");
        if (_PriceYouExpect == null || _PriceYouExpect.isEmpty) {
          _PriceYouExpect = "";
        }

        print("Negotiable:-${Negotiablecheck}");
        if (Negotiablecheck == null || Negotiablecheck.isEmpty) {
          Negotiablecheck = "";
        }

        print("Road Width:-  ${_RoadWidth}");
        if (_RoadWidth == null || _RoadWidth.isEmpty) {
          _RoadWidth = "";
        }

        print("Other Charges:-  ${_OtherCharges}");

        if (_OtherCharges == null || _OtherCharges.isEmpty) {
          _OtherCharges = "";
        }

        print("ExpectedRent:-  ${_ExpectedRent}");

        if (_ExpectedRent == null || _ExpectedRent.isEmpty) {
          _ExpectedRent = "";
        }

        print("Deposite:-  ${_Deposite}");

        if (_Deposite == null || _Deposite.isEmpty) {
          _Deposite = "";
        }

        print("Description:- ${_Description}");

        if (_Description == null || _Description.isEmpty) {
          _Description = "";
        }

        print("Bathroom:- ${Bathroom}");

        if (Bathroom == null || Bathroom.isEmpty) {
          Bathroom = "";
        }

        print("Balconies:- ${Balconies}");

        if (Balconies == null || Balconies.isEmpty) {
          Balconies = "";
        }
//-----------------------------------------------------------------------
        print("Water Supply:- ${_selectedWaterSupply}");

//        if (_selectedWaterSupply == null || _selectedWaterSupply.isEmpty) {
//          _selectedWaterSupply = "";
//        }
        print("Power Cutting:- ${_selectedPowerCutting}");
//        if (_selectedPowerCutting == null || _selectedPowerCutting.isEmpty) {
//          _selectedPowerCutting = "";
//        }

        print("Non-Veg Allowed:- ${_selectedNonVegAllowed}");
        if (_selectedNonVegAllowed == null || _selectedNonVegAllowed.isEmpty) {
          _selectedNonVegAllowed = "";
        }

        print("Posted By:- ${_selectedPostedBy}");
//        if (_selectedPostedBy == null || _selectedPostedBy.isEmpty) {
//          _selectedPostedBy = "";
//        }
        print("City:- ${_selectedCity}");
        if (_selectedCity == null || _selectedCity.isEmpty) {
          _selectedCity = "";
        }
        //-------------------------------------------------------------------------------------------------
        print("Contact Number:- ${ContactNumber}");
        if (ContactNumber == null || ContactNumber.isEmpty) {
          ContactNumber = "";
        }
        print("Alternate Contact Number:- ${alterContactNumber}");
        if (alterContactNumber == null || alterContactNumber.isEmpty) {
          alterContactNumber = "";
        }

        print("STD Code:- ${_stdcode}");
        if (_stdcode == null || _stdcode.isEmpty) {
          _stdcode = "";
        }
        print("Telephone Number:- ${_telephonenumber}");
        if (_telephonenumber == null || _telephonenumber.isEmpty) {
          _telephonenumber = "";
        }

        print("Search Location:- ${SearchLocation}");
        if (SearchLocation == null || SearchLocation.isEmpty) {
          SearchLocation = "";
        }
        print("Area:- ${Area}");
        if (Area == null || Area.isEmpty) {
          Area = "";
        }

        print("lat:- ${lat}");
        if (lat == null || lat.isEmpty) {
          lat = "";
        }

        print("Long:- ${long}");
        if (long == null || long.isEmpty) {
          long = "";
        }

        print("Soceity Name:- ${SoceityName}");
        if (SoceityName == null || SoceityName.isEmpty) {
          SoceityName = "";
        }
        print("Street Name:- ${StreetName}");
        if (StreetName == null || StreetName.isEmpty) {
          StreetName = "";
        }
        print("Pin Code:- ${PinCode}");
        if (PinCode == null || PinCode.isEmpty) {
          PinCode = "";
        }
        print("images:- ${images}");
        print("Features :- ${Featuresinputlist}");
        String Featureas = Featuresinputlist.join("#");
        if (Featureas == null || Featureas.isEmpty) {
          Featureas = "";
        }

        print(
            "///imageslistfile//////////////////////${imageslistfile}///////");
        print("Steps completed!");
        if (_selectedPropertyTypeid == "1") {
          _getImageSubmitData(
              imageslistfile,
              UID,
              _selectedPropertyTypeid,
              CommonpropertyStr,
              SubPropertyTypeID,
              _selectedBHKID,
              PossessionDate,
              _selectedFloor,
              _selectedTotalFloor,
              _selectedPropertyAge,
              _BuiltUpArea,
              _CarpetArea,
              _selectedFacing,
              _PriceYouExpect,
              _ExpectedRent,
              _Deposite,
              _selectedPowerCutting,
              _OtherCharges,
              _selectedMaintenance == 'Excluded'
                  ? _MaintancePrice
                  : _selectedMaintenance,
              _selectedFurnishing,
              _selectedPreferredTenants,
              _selectdate,
              _selectedParking,
              _Description,
              _RoadWidth,
              Bathroom,
              Balconies,
              _selectedWaterSupply,
              _selectedNonVegAllowed,
              Featureas,
              _selectedPostedBy,
              ContactNumber,
              _selectedCity != null ? _selectedCity : '',
              PinCode,
              SoceityName,
              StreetName,
              Negotiablecheck,
              SearchLocation,
              lat,
              long,
              alterContactNumber,
              _stdcode,
              _telephonenumber);
        } else if (_selectedPropertyTypeid == "2") {
          _getImageSubmitData(
              imageslistfile,
              UID,
              _selectedPropertyTypeid,
              CommonpropertyStr,
              SubPropertyTypeID,
              "0",
              PossessionDate,
              _selectedFloor,
              _selectedTotalFloor,
              _selectedPropertyAge,
              _BuiltUpArea,
              _CarpetArea,
              _selectedFacing,
              _PriceYouExpect,
              _ExpectedRent,
              _Deposite,
              _selectedPowerCutting,
              _OtherCharges,
              _selectedMaintenance,
              _selectedFurnishing,
              _selectedPreferredTenants,
              _selectdate,
              _selectedParking,
              _Description,
              _RoadWidth,
              Bathroom,
              Balconies,
              _selectedWaterSupply,
              _selectedNonVegAllowed,
              Featureas,
              _selectedPostedBy,
              ContactNumber,
              _selectedCity,
              PinCode,
              SoceityName,
              StreetName,
              Negotiablecheck,
              SearchLocation,
              lat,
              long,
              alterContactNumber,
              _stdcode,
              _telephonenumber);
        } else if (_selectedPropertyTypeid == "3") {
          _getImageSubmitData(
              imageslistfile,
              UID,
              _selectedPropertyTypeid,
              Projectpropertyforstr,
              SubPropertyTypeID,
              _selectedBHKID,
              PossessionDate,
              _selectedFloor,
              _selectedTotalFloor,
              _selectedPropertyAge,
              _BuiltUpArea,
              _CarpetArea,
              _selectedFacing,
              _PriceYouExpect,
              _ExpectedRent,
              _Deposite,
              _selectedPowerCutting,
              _OtherCharges,
              _selectedMaintenance,
              _selectedFurnishing,
              _selectedPreferredTenants,
              _selectdate,
              _selectedParking,
              _Description,
              _RoadWidth,
              Bathroom,
              Balconies,
              _selectedWaterSupply,
              _selectedNonVegAllowed,
              Featureas,
              _selectedPostedBy,
              ContactNumber,
              _selectedCity,
              PinCode,
              SoceityName,
              StreetName,
              Negotiablecheck,
              SearchLocation,
              lat,
              long,
              alterContactNumber,
              _stdcode,
              _telephonenumber);
        } else if (_selectedPropertyTypeid == "4") {
          _getImageSubmitData(
              imageslistfile,
              UID,
              _selectedPropertyTypeid,
              Projectpropertyforstr,
              SubPropertyTypeID,
              "",
              PossessionDate,
              _selectedFloor,
              _selectedTotalFloor,
              _selectedPropertyAge,
              _BuiltUpArea,
              _CarpetArea,
              _selectedFacing,
              _PriceYouExpect,
              _ExpectedRent,
              _Deposite,
              _selectedPowerCutting,
              _OtherCharges,
              _selectedMaintenance,
              _selectedFurnishing,
              _selectedPreferredTenants,
              _selectdate,
              _selectedParking,
              _Description,
              _RoadWidth,
              Bathroom,
              Balconies,
              _selectedWaterSupply,
              _selectedNonVegAllowed,
              Featureas,
              _selectedPostedBy,
              ContactNumber,
              _selectedCity,
              PinCode,
              SoceityName,
              StreetName,
              Negotiablecheck,
              SearchLocation,
              lat,
              long,
              alterContactNumber,
              _stdcode,
              _telephonenumber);
        }
      },
      steps: steps,
      config: CoolStepperConfig(
        backText: "PREV",
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Post Property"),
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: stepper,
            ),
    );
  }

  //------------------------------------------------------------------------------

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
    setState(() async {
      if (chooseType == 0) {
        FilePickerResult result =
            await FilePicker.platform.pickFiles(type: FileType.image);
        _imageFile = Future<File>.value(File(result.paths[0]));

        //_imageFile = ImagePicker.(source: ImageSource.gallery);
      } else {
        final _picker = ImagePicker();
        PickedFile image = await _picker.getImage(
            source: ImageSource.camera, imageQuality: 50);
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
        // print(imageslistfile);
      }
    });
  }

  //----------------------------------------------------------------------------------
//step1
  Padding possessionDate(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Possession Date:',
            style: kTextStyle,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: InkWell(
                    child: Text(
                      PossessionDate != null ? PossessionDate : '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(16),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.calendarDay,
                      color: kPrimaryColor,
                    ),
                    tooltip: 'Tap to open date picker',
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ),
              ],
            ),
            // DateTimeField(
            //   format: format,
            //   controller: _textpossessionDate,
            //   onShowPicker: (context, currentValue) async {
            //     return showDatePicker(
            //         context: context,
            //         firstDate: DateTime(1900),
            //         initialDate: currentValue ?? DateTime.now(),
            //         lastDate: DateTime(2100));
            // final date = await showDatePicker(
            //     context: context,
            //     firstDate: DateTime(1900),
            //     initialDate: currentValue ?? DateTime.now(),
            //     lastDate: DateTime(2100));
            // if (date != null) {
            //   final time = await showTimePicker(
            //     context: context,
            //     initialTime:
            //         TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            //   );
            //   return DateTimeField.combine(date, time);
            // } else {
            //   return currentValue;
            // }
            //   },
            //   autovalidate: autoValidate,
            //   validator: (date) => date == null ? 'This is required' : null,
            //   onChanged: (date) => setState(() {
            //     var formattedDate = "${value.year}-${value.month}-${value.day}";
            //     changedCount++;
            //     PossessionDate = formattedDate.toString();
            //     print("Possession Date:- ${PossessionDate}");
            //   }),
            //   onSaved: (value) {
            //     _textpossessionDate.text = value.toString();
            //   },
            //   resetIcon: showResetIcon ? Icon(Icons.delete) : null,
            //   readOnly: readOnly,
            //   decoration: InputDecoration(
            //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            //     hintText: "Possession Date",
            //     suffixIcon: Padding(
            //       padding:
            //           const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
            //       child: FaIcon(
            //         FontAwesomeIcons.calendarDay,
            //         color: primarycolor,
            //       ),
            //     ),
            //     //border: OutlineInputBorder(),
            //   ),
            // ),
          ),
        ],
      ),
    );
  }

  Padding bhkType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<HouseType>(
              searchBoxController: _textbhkType,
              items: bhkTypelist,
              showClearButton: true,
              showSearchBox: true,
              label: 'BHK Type',
              hint: "BHK Type",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (HouseType value) {
                _textbhkType.text = value.HouseTypeName.toString();
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
                    _selectedBHKID = newValue.HouseTypeID.toString();
                    _selectedBHKType = newValue.HouseTypeName.toString();
                    print("BHKid:- ${_selectedBHKID}");
                    print("BHKtype:- ${_selectedBHKType}");
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Padding projectCommercialPropertyType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<SubPropertyType>(
              searchBoxController: _textprojectResidentialPropertyType,
              items: projectcommercialPropertyTypelist,
              showClearButton: true,
              showSearchBox: true,
              label: 'Project Commercial Property Type',
              hint: 'Project Commercial Property Type',
              autoValidateMode: AutovalidateMode.onUserInteraction,
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
              onSaved: (SubPropertyType value) {
                _textprojectResidentialPropertyType.text =
                    value.SubPropertyName.toString();
              },
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                } else {
                  return null;
                }
              },
              onChanged: (newValue) {
                setState(
                  () {
                    SubPropertyTypeID = newValue.SubPropertyId.toString();
                    SubPropertyTypeName = newValue.SubPropertyName.toString();
                    print(
                        "project Commerical Property Id:- ${SubPropertyTypeID}");
                    print(
                        "project Commerical Property Name:- ${SubPropertyTypeName}");
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Padding projectResidentialPropertyType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<SubPropertyType>(
              searchBoxController: _textprojectResidentialPropertyType,
              items: projectResidentialPropertyTypelist,
              showClearButton: true,
              showSearchBox: true,
              label: 'Project Residential Property Type',
              hint: 'Project Residential Property Type',
              autoValidateMode: AutovalidateMode.onUserInteraction,
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
              onSaved: (SubPropertyType value) {
                _textprojectResidentialPropertyType.text =
                    value.SubPropertyName.toString();
              },
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onChanged: (newValue) {
                setState(
                  () {
                    SubPropertyTypeID = newValue.SubPropertyId.toString();
                    SubPropertyTypeName = newValue.SubPropertyName.toString();
                    print(
                        "project Residential Property Id:- ${SubPropertyTypeID}");
                    print(
                        "project Residential Property Name:- ${SubPropertyTypeName}");
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Padding commercialPropertyType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<SubPropertyType>(
              searchBoxController: _textcommercialPropertyType,
              items: commercialPropertyTypelist,
              showClearButton: true,
              showSearchBox: true,
              label: 'Commercial Property Type',
              hint: "Commercial Property Type",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              onSaved: (SubPropertyType value) {
                _textcommercialPropertyType.text =
                    value.SubPropertyName.toString();
              },
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
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
                    _selectedcommercial=newValue.toString();
                    print("_selectedcommercial:- ${_selectedcommercial}");
                    SubPropertyTypeID = newValue.SubPropertyId.toString();
                    SubPropertyTypeName = newValue.SubPropertyName.toString();
                    print("Commercial Property Id:- ${SubPropertyTypeID}");
                    print("Commercial Property Name:- ${SubPropertyTypeName}");
                    if (_selectedcommercial ==
                        commercialPropertyTypelist[17].SubPropertyName) {
                      isresidentalland = false;
                    } else {
                      isresidentalland = true;
                    }
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Padding residentialPropertyType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<SubPropertyType>(
              searchBoxController: _textresidentialPropertyType,
              items: residentialPropertyTypelist,
              showClearButton: true,
              showSearchBox: true,
              label: 'Residential Property Type',
              hint: "Residential Property Type",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (SubPropertyType value) {
                _textresidentialPropertyType.text =
                    value.SubPropertyName.toString();
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
                    _selectedResidentialPropertyType = newValue.toString();
                    SubPropertyTypeID = newValue.SubPropertyId.toString();
                    SubPropertyTypeName = newValue.SubPropertyName.toString();
                    print("Residential Property Id:- ${SubPropertyTypeID}");
                    print("Residential Property Name:- ${SubPropertyTypeName}");
                    if (_selectedResidentialPropertyType ==
                        residentialPropertyTypelist[3].SubPropertyName) {
                      isBhkTypeVisible = false;
                      isresidentalland = false;
                    } else {
                      isBhkTypeVisible = true;
                      isresidentalland = true;
                    }
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Padding listPropertyForProject() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'List Property For',
            style: kTextStyle,
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RadioListTile<ListPropertyForProject>(
                    activeColor: Colors.green[200],
                    title: Text(
                      'Sell',
                      style: kTextStyleForContent,
                    ),
                    value: ListPropertyForProject.Buy,
                    groupValue: Projectpropertyfor,
                    onChanged: (value) {
                      setState(() {
                        Projectpropertyfor = value;
                        var tempProjectpropertyfor = Projectpropertyfor;
                        if (tempProjectpropertyfor ==
                            ListPropertyForProject.Buy) {
                          Projectpropertyforstr = "Buy";
                        } else {
                          Projectpropertyforstr = null;
                        }
                        print("Project :- ${Projectpropertyforstr}");
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: forvalidatingbuyrent,
            child: Text(
              'This is required',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 8.0,
                  color: Colors.red),
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Padding listPropertyFor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'List Property For',
            style: kTextStyle,
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RadioListTile<ListPropertyFor>(
                    activeColor: Colors.green[200],
                    title: Text(
                      'Sell',
                      style: kTextStyleForContent,
                    ),
                    value: ListPropertyFor.Buy,
                    groupValue: commonpropertyfor,
                    onChanged: (ListPropertyFor value) {
                      setState(() {
                        commonpropertyfor = value;
                        var tempcommonpropertyfor = commonpropertyfor;
                        if (tempcommonpropertyfor == ListPropertyFor.Buy) {
                          CommonpropertyStr = "Buy";
                        } else {
                          CommonpropertyStr = null;
                        }
                        print("common property  :- ${CommonpropertyStr}");
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<ListPropertyFor>(
                    activeColor: Colors.green[200],
                    title: Text(
                      _selectedPropertyTypeid == "2" ? 'Lease' : 'Rent',
                      style: kTextStyleForContent,
                    ),
                    value: ListPropertyFor.Rent,
                    groupValue: commonpropertyfor,
                    onChanged: (ListPropertyFor value) {
                      setState(() {
                        commonpropertyfor = value;
                        var tempcommonpropertyfor = commonpropertyfor;
                        if (tempcommonpropertyfor == ListPropertyFor.Rent) {
                          CommonpropertyStr =
                              _selectedPropertyTypeid == "2" ? 'Lease' : "Rent";
                        } else {
                          CommonpropertyStr = null;
                        }

                        print("common property :- ${CommonpropertyStr}");
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.0,
          ),
        ],
      ),
    );
  }

  Padding propertyType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<PropertType>(
              searchBoxController: _textPropertyType,
              items: propertyTypelist,
              showClearButton: true,
              showSearchBox: true,
              label: 'Property Type',
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (PropertType value) {
                _textPropertyType.text = value.PropertyTypeName.toString();
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
                _selectedPropertyTypeid = newValue.PropertyTypeID.toString();
                _selectedPropertyType = newValue.PropertyTypeName;
                print("propertytypeid:- ${_selectedPropertyTypeid}");
                print("propertytype:- ${_selectedPropertyType}");

                if (_selectedPropertyTypeid == "4") {
                  _getFetchingSubPropertyType("3", _selectedPropertyTypeid);
                } else {
                  _getFetchingSubPropertyType(
                      _selectedPropertyTypeid, _selectedPropertyTypeid);
                }

                setState(
                  () {
                    _selectedPropertyType = newValue.toString();

                    String residential = propertyTypelist[0].PropertyTypeName;
                    String commercial = propertyTypelist[1].PropertyTypeName;
                    String projectResidential =
                        propertyTypelist[2].PropertyTypeName;
                    String projectCommercial =
                        propertyTypelist[3].PropertyTypeName;

                    if (_selectedPropertyType == residential) {
                      isProjectCommercialPropertyTypeVisible = false;
                      isListPropertyForVisible = true;
                      isResidentialPropertyTypeVisible = true;
                      isCommercialPropertyTypeVisible = false;
                      isBhkTypeVisible = true;
                      isPossessionDateVisible = true;
                      isProjectResidentialPropertyTypeVisible = false;
                      isListPropertyForProjectVisible = false;
                    } else if (_selectedPropertyType == commercial) {
                      isProjectCommercialPropertyTypeVisible = false;
                      isCommercialPropertyTypeVisible = true;
                      isListPropertyForVisible = true;
                      isResidentialPropertyTypeVisible = false;
                      isBhkTypeVisible = false;
                      isPossessionDateVisible = true;
                      isProjectResidentialPropertyTypeVisible = false;
                      isListPropertyForProjectVisible = false;
                    } else if (_selectedPropertyType == projectResidential) {
                      isProjectCommercialPropertyTypeVisible = false;
                      isProjectResidentialPropertyTypeVisible = true;
                      isListPropertyForVisible = false;
                      isResidentialPropertyTypeVisible = false;
                      isBhkTypeVisible = true;
                      isPossessionDateVisible = true;
                      isCommercialPropertyTypeVisible = false;
                      isListPropertyForProjectVisible = true;
                    } else if (_selectedPropertyType == projectCommercial) {
                      isProjectCommercialPropertyTypeVisible = true;
                      isListPropertyForVisible = false;
                      isResidentialPropertyTypeVisible = false;
                      isBhkTypeVisible = false;
                      isPossessionDateVisible = true;
                      isCommercialPropertyTypeVisible = false;
                      isProjectResidentialPropertyTypeVisible = false;
                      isListPropertyForProjectVisible = true;
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

//step2
  Padding selectFloor() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<String>(
              items: _selectFloor,
              showClearButton: true,
              showSearchBox: true,
              label: 'Floor',
              hint: "Select Floor",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _selectedFloor = value;
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
                _selectedFloor = newValue;
                if (newValue == "Ground Floor") {
                  setState(() {
                    groundfloorCheckone = true;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding totalFloor() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<String>(
              items: _totalFloor,
              showClearButton: true,
              showSearchBox: true,
              label: 'Total Floor',
              hint: "Select Total Floor",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                } else {
                  if (groundfloorCheckone || groundfloorChecktwo) {
                    if (_selectedFloor != "Ground Floor") {
                      return 'Total Floor must be greater or equal to floor';
                    }
                  } else {
                    if (int.parse(value) <
                        int.parse(
                            _selectedFloor == null || _selectedFloor == "0"
                                ? "0"
                                : _selectedFloor)) {
                      return 'Total Floor must be greater or equal to floor';
                    }
                  }
                }
              },
              onSaved: (String value) {
                _selectedTotalFloor = value;
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
                _selectedTotalFloor = newValue;
                if (newValue == "Ground Floor") {
                  setState(() {
                    groundfloorChecktwo = true;
                  });
                }
              },
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: DropdownButtonFormField(
          //     hint: Text(
          //       'Total Floor',
          //       style: style,
          //     ),
          //     value: _selectedTotalFloor,
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
          //           _selectedTotalFloor = newValue;
          //           print("Select Total Floor:-${_selectedTotalFloor}");
          //         },
          //       );
          //     },
          //     items: _totalFloor.map((totalFloor) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           totalFloor,
          //           style: kTextStyleForContent,
          //         ),
          //         value: totalFloor,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),
        ],
      ),
    );
  }

  Padding propertyAge() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<String>(
              items: _propertyAge,
              showClearButton: true,
              showSearchBox: true,
              label: 'Property Age',
              hint: "Select Property Age",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _selectedPropertyAge = value;
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
                _selectedPropertyAge = newValue;
              },
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: DropdownButtonFormField(
          //     hint: Text(
          //       'Property Age',
          //       style: style,
          //     ),
          //     value: _selectedPropertyAge,
          //     validator: (value) {
          //       if (value == null) {
          //         return 'This is required';
          //       }
          //     },
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
          //     onChanged: (newValue) {
          //       setState(() {
          //         _selectedPropertyAge = newValue;
          //         print("Property Age:- ${_selectedPropertyAge}");
          //       });
          //     },
          //     items: _propertyAge.map((propertyAge) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           propertyAge,
          //           style: kTextStyleForContent,
          //         ),
          //         value: propertyAge,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),
        ],
      ),
    );
  }

  Padding facing() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<String>(
              items: _facing,
              showClearButton: true,
              showSearchBox: true,
              label: 'Facing',
              hint: "Select Facing",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _selectedFacing = value;
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
                _selectedFacing = newValue;
              },
            ),
          ),

          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: DropdownButtonFormField(
          //     hint: Text(
          //       'Facing',
          //       style: style,
          //     ),
          //     value: _selectedFacing,
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
          //           _selectedFacing = newValue;
          //           print("Facing:-${_selectedFacing}");
          //         },
          //       );
          //     },
          //     items: _facing.map((faceing) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           faceing,
          //           style: kTextStyleForContent,
          //         ),
          //         value: faceing,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),
        ],
      ),
    );
  }

  Padding parking() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<String>(
              items: _parking,
              showClearButton: true,
              showSearchBox: true,
              label: 'Parking',
              hint: "Select Parking",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _selectedParking = value;
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
                _selectedParking = newValue;
              },
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: DropdownButtonFormField(
          //     hint: Text(
          //       'Parking',
          //       style: style,
          //     ),
          //     value: _selectedParking,
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
          //           _selectedParking = newValue;
          //           print("Parking:-${_selectedParking}");
          //         },
          //       );
          //     },
          //     items: _parking.map((parking) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           parking,
          //           style: kTextStyleForContent,
          //         ),
          //         value: parking,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),
        ],
      ),
    );
  }

  Padding maintenance() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<String>(
              items: _maintenance,
              showClearButton: true,
              showSearchBox: true,
              label: 'Maintenance',
              hint: "Select Maintenance",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _selectedMaintenance = value;
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
                _selectedMaintenance = newValue;
                print(
                    "/////Maintaince////////////////////${_selectedMaintenance}");
                setState(() {
                  if (_selectedMaintenance == 'Excluded') {
                    checkmaintenance = true;
                  } else if (_selectedMaintenance ==
                      'Included (Tax or Govt. charges)') {
                    checkmaintenance = false;
                  }
                });
              },
            ),
          ),

          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: DropdownButtonFormField(
          //     hint: Text(
          //       'Maintenance',
          //       style: style,
          //     ),
          //     value: _selectedMaintenance,
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
          //           _selectedMaintenance = newValue;
          //           print("Maintenance:-${_selectedMaintenance}");
          //         },
          //       );
          //     },
          //     items: _maintenance.map((maintenance) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           maintenance,
          //           style: kTextStyleForContent,
          //         ),
          //         value: maintenance,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),
        ],
      ),
    );
  }

  Padding MaintancePrice() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textMaintanice,
              keyboardType: TextInputType.number,
              inputFormatters: [NumericTextFormatter()],
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chartArea,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Maintance Price (in Rs.)',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty && isSell() == true) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textMaintanice.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _MaintancePrice = newValue;
                  print("Maintance Price:-${_MaintancePrice}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding preferredTenants() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: DropdownSearch(
                searchBoxController: _textprojectResidentialPropertyType,
                items: _preferredTenants,
                showClearButton: true,
                showSearchBox: true,
                label: 'Preferred Tenants',
                hint: 'Preferred Tenants',
                autoValidateMode: AutovalidateMode.onUserInteraction,
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
                onSaved: (value) {
                  _textpreferTen.text = value;
                },
                validator: (value) {
                  if (value == null) {
                    return 'This is required';
                  }
                },
                onChanged: (newValue) {
                  setState(
                    () {
                      _selectedPreferredTenants = newValue;
                      print("Preferred Tenants:-${_selectedPreferredTenants}");
                    },
                  );
                },
              )

//            DropdownButtonFormField(
//              hint: Text(
//                'Preferred Tenants',
//                style: style,
//              ),
//              value: _selectedPreferredTenants,
//              decoration: InputDecoration(
//                prefixIcon: Padding(
//                  padding:
//                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
//                  child: FaIcon(
//                    FontAwesomeIcons.list,
//                    color: primarycolor,
//                  ),
//                ),
//              ),
//              validator: (value) {
//                if (value == null && isRent() == true) {
//                  return 'This is required';
//                }
//              },
//              onChanged: (newValue) {
//                setState(
//                  () {
//                    _selectedPreferredTenants = newValue;
//                    print("Preferred Tenants:-${_selectedPreferredTenants}");
//                  },
//                );
//              },
//              items: _preferredTenants.map((PreferredTenants) {
//                return DropdownMenuItem(
//                  child: new Text(
//                    PreferredTenants,
//                    style: kTextStyleForContent,
//                  ),
//                  value: PreferredTenants,
//                );
//              }).toList(),
//              isExpanded: true,
//            ),
              ),
        ],
      ),
    );
  }

  Padding furnishing() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<String>(
              items: _furnishing,
              showClearButton: true,
              showSearchBox: true,
              label: 'Furnishing',
              hint: "Select Furnishing",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _selectedFurnishing = value;
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
                _selectedFurnishing = newValue;
              },
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: DropdownButtonFormField(
          //     hint: Text(
          //       'Furnishing',
          //       style: style,
          //     ),
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
          //     value: _selectedFurnishing,
          //     validator: (value) {
          //       if (value == null) {
          //         return 'This is required';
          //       }
          //     },
          //     onChanged: (newValue) {
          //       setState(
          //         () {
          //           _selectedFurnishing = newValue;
          //           print("Furnishing:-${_selectedFurnishing}");
          //         },
          //       );
          //     },
          //     items: _furnishing.map((furniture) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           furniture,
          //           style: kTextStyleForContent,
          //         ),
          //         value: furniture,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),
        ],
      ),
    );
  }

  Padding builtUpArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textBuiltUpSqFt,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chartArea,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Built Up Area(sq.ft)',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textBuiltUpSqFt.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _BuiltUpArea = newValue;
                  print("Built Up Area(sq.ft):-${_BuiltUpArea}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding carpetArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textCarpetAreaSqFt,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Carpet Area(sq.ft)',
                hintStyle: style,
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chartArea,
                    color: primarycolor,
                  ),
                ),
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textCarpetAreaSqFt.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _CarpetArea = newValue;
                  print("Carpet Area(sq.ft):-${_CarpetArea}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding priceYouExpect() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textPriceYouExpect,
              keyboardType: TextInputType.number,
              inputFormatters: [NumericTextFormatter()],
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chartArea,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Price You Expect (in Rs.)',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty && isSell() == true) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textPriceYouExpect.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _PriceYouExpect = newValue;
                  print("Price You Expect:-${_PriceYouExpect}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding negotiable() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CheckboxListTile(
            activeColor: primarycolor,
            title: Text(
              'Negotiable',
              style: kTextStyleForContent,
            ),
            value: _isNegotiable,
            onChanged: (bool newValue) {
              setState(() {
                _isNegotiable = newValue;
                if (newValue) {
                  Negotiablecheck = "Negotiable";
                } else {
                  Negotiablecheck = "Not Negotiable";
                }
                print("Negotiable:-${Negotiablecheck}");
              });
            },
          ),
        ],
      ),
    );
  }

  Padding roadWidth() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textRoadWidth,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chartArea,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Road Width',
                hintStyle: kTextStyleForContent,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textRoadWidth.text = value;
              },
              onChanged: (value) {
                _RoadWidth = value;
                print("Road Width:-  ${_RoadWidth}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding otherCharges() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textOtherCharges,
              keyboardType: TextInputType.number,
              inputFormatters: [NumericTextFormatter()],
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chartArea,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Other Charges',
                hintStyle: kTextStyleForContent,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textOtherCharges.text = value;
              },
              onChanged: (value) {
                _OtherCharges = value;
                print("Other Charges:-  ${_OtherCharges}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding expectedRentPerMonth() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textExpectedRentPerMonth,
              keyboardType: TextInputType.number,
              inputFormatters: [NumericTextFormatter()],
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chartArea,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Expected Rent(Per month) (in Rs.)',
                hintStyle: kTextStyleForContent,
              ),
              validator: (String value) {
                if (value.isEmpty && isRent() == true) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textExpectedRentPerMonth.text = value;
              },
              onChanged: (value) {
                _ExpectedRent = value;
                print("ExpectedRent:-  ${_ExpectedRent}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding expectedDeposite() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textExpectedDeposite,
              keyboardType: TextInputType.number,
              inputFormatters: [NumericTextFormatter()],
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chartArea,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Expected Deposite (in Rs.)',
                hintStyle: kTextStyleForContent,
              ),
              validator: (String value) {
                if (value.isEmpty && isRent() == true) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textExpectedDeposite.text = value;
              },
              onChanged: (value) {
                _Deposite = value;
                print("Deposite:-  ${_Deposite}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textDescription,
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
                hintText: 'Description',
                hintStyle: style,
              ),
              validator: (String value) {
                // if (value.isEmpty) {
                //   return 'This is required';
                // }
              },
              onSaved: (String value) {
                _textDescription.text = value;
              },
              onChanged: (value) {
                _Description = value;
                print("Description:- ${_Description}");
              },
            ),
          ),
        ],
      ),
    );
  }

//step3
  Padding numberOfBathrooms() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textNumberOfBathrooms,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.bath,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Number of Bathrooms',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textNumberOfBathrooms.text = value;
              },
              onChanged: (value) {
                Bathroom = value;
                print("Bathroom:- ${Bathroom}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding numberOfBalconies() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textNumberOfBalconies,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.bath,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Number of Balconies',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textNumberOfBalconies.text = value;
              },
              onChanged: (value) {
                Balconies = value;
                print("Balconies:- ${Balconies}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding waterSupply() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: DropdownSearch(
                searchBoxController: _textwatersupplier,
                items: _waterSupply,
                showClearButton: true,
                showSearchBox: true,
                label: 'Water Supply',
                hint: 'Water Supply',
                autoValidateMode: AutovalidateMode.onUserInteraction,
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
                onSaved: (value) {
                  _textwatersupplier.text = value;
                },
                validator: (value) {
                  if (value == null) {
                    return 'This is required';
                  }
                },
                onChanged: (newValue) {
                  setState(
                    () {
                      _selectedWaterSupply = newValue;
                      print("Water Supply:- ${_selectedWaterSupply}");
                    },
                  );
                },
              )),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Padding powerCutting() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              child: DropdownSearch(
                searchBoxController: _textpowercuting,
                items: _powerCutting,
                showClearButton: true,
                showSearchBox: true,
                label: 'Power Cutting',
                hint: 'Power Cutting',
                autoValidateMode: AutovalidateMode.onUserInteraction,
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
                onSaved: (value) {
                  _textpowercuting.text = value;
                },
                validator: (value) {
                  if (value == null) {
                    return 'This is required';
                  }
                },
                onChanged: (newValue) {
                  setState(
                    () {
                      _selectedPowerCutting = newValue;
                      print("Power Cutting:- ${_selectedPowerCutting}");
                    },
                  );
                },
              )),
          SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Padding nonVegAllowed() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch(
              searchBoxController: _textnonveg,
              items: _nonVegAllowed,
              showClearButton: true,
              showSearchBox: true,
              label: 'Non-Veg Allowed',
              hint: 'Non-Veg Allowed',
              autoValidateMode: AutovalidateMode.onUserInteraction,
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
              validator: (value) {
                if (value == null && isRent() == true) {
                  return 'This is required';
                }
              },
              onSaved: (value) {
                _textnonveg.text = value;
              },
              onChanged: (newValue) {
                setState(
                  () {
                    _selectedNonVegAllowed = newValue;
                    print("Non-Veg Allowed:- ${_selectedNonVegAllowed}");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding features() {
    bool _value = true;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.grey[50],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(0, 3),
              blurRadius: 7.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            selectbutton
                ? FlatButton(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        selectbutton = false;
                        Featuresinputlist.clear();
                        print("Featuresinputlist empty:-${Featuresinputlist}");
                        isLiftSelected = false;
                        isParkSelected = false;
                        isChildrensPlayAreaSelected = false;
                        isSecuritySelected = false;
                        isHouseKeepingSelected = false;
                        isPowerBackupSelected = false;
                        isSwimmingPoolSelected = false;
                        isGymSelected = false;
                        isFireSafetySelected = false;
                        isServantRoomSelected = false;
                        isClubHouseSelected = false;
                        isAcSelected = false;
                        isInternetServicesSelected = false;
                        isInterComSelected = false;
                        isRainWaterHarvestingSelected = false;
                        isShoppinCenterSelected = false;
                        isGasPipelineSelected = false;
                        isSewageTreatmentPlantSelected = false;
                        print("Features:- ${Featuresinputlist}");
                      });
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        'DeSelect All',
                        style: TextStyle(color: Colors.white),
                      )),
                      color: Colors.green[200],
                      width: 100.0,
                      height: 30.0,
                    ),
                  )
                : FlatButton(
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        selectbutton = true;
                        Featuresinputlist.clear();
                        print("Featuresinputlist empty:-${Featuresinputlist}");
                        isLiftSelected = true;
                        isParkSelected = true;
                        isChildrensPlayAreaSelected = true;
                        isSecuritySelected = true;
                        isHouseKeepingSelected = true;
                        isPowerBackupSelected = true;
                        isSwimmingPoolSelected = true;
                        isGymSelected = true;
                        isFireSafetySelected = true;
                        isServantRoomSelected = true;
                        isClubHouseSelected = true;
                        isAcSelected = true;
                        isInternetServicesSelected = true;
                        isInterComSelected = true;
                        isRainWaterHarvestingSelected = true;
                        isShoppinCenterSelected = true;
                        isGasPipelineSelected = true;
                        isSewageTreatmentPlantSelected = true;
                        Featuresinputlist.add(
                            FeaturesTypelist[1].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[2].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[3].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[4].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[5].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[6].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[7].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[8].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[9].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[10].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[11].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[12].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[13].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[14].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[15].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[16].featuresID.toString());
                        Featuresinputlist.add(
                            FeaturesTypelist[17].featuresID.toString());
                        print("Features:- ${Featuresinputlist}");
                      });
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        'Select All',
                        style: TextStyle(color: Colors.white),
                      )),
                      color: Colors.green[200],
                      width: 100.0,
                      height: 30.0,
                    ),
                  ),
            Container(
                //width: MediaQuery.of(context).size.width,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isLiftSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[0].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");

                        isLiftSelected = false;
                      } else if (isLiftSelected == false) {
                        isLiftSelected = true;
                        Featuresinputlist.add(
                            FeaturesTypelist[0].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isLiftSelected ? Colors.green : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(12),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Checkbox(
                                  value: isLiftSelected,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      isLiftSelected = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Image.asset(
                              "images/lift.png",
                              width: MediaQuery.of(context).size.width / 10,
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(5),
                          ),
                          Expanded(
                            flex: 2,
                            child: FeaturesTypelist.length != 0
                                ? Text(
                                    "${FeaturesTypelist[0].featuresName}",
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(12),
                                      fontWeight: FontWeight.normal,
                                      height: 1,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(12),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isParkSelected == true) {
                        isParkSelected = false;
                        Featuresinputlist.remove(
                            FeaturesTypelist[1].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                      } else if (isParkSelected == false) {
                        isParkSelected = true;
                        Featuresinputlist.add(
                            FeaturesTypelist[1].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isParkSelected ? Colors.green : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isParkSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isParkSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/park.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[1].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isChildrensPlayAreaSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[2].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isChildrensPlayAreaSelected = false;
                      } else if (isChildrensPlayAreaSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[2].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isChildrensPlayAreaSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isChildrensPlayAreaSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isChildrensPlayAreaSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isChildrensPlayAreaSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/childrenPlayArea.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[2].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 3.0,
            ),
            Container(
                //width: MediaQuery.of(context).size.width,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSecuritySelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[3].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isSecuritySelected = false;
                      } else if (isSecuritySelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[3].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isSecuritySelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                isSecuritySelected ? Colors.green : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isSecuritySelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isSecuritySelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/security.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[3].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isHouseKeepingSelected == true) {
                        isHouseKeepingSelected = false;
                        Featuresinputlist.remove(
                            FeaturesTypelist[4].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                      } else if (isHouseKeepingSelected == false) {
                        isHouseKeepingSelected = true;
                        Featuresinputlist.add(
                            FeaturesTypelist[4].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isHouseKeepingSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isHouseKeepingSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isHouseKeepingSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/houseKeeping.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[4].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isPowerBackupSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[5].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isPowerBackupSelected = false;
                      } else if (isPowerBackupSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[5].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isPowerBackupSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isPowerBackupSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isPowerBackupSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isPowerBackupSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/powerBackups.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[5].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 3.0,
            ),
            Container(
                //width: MediaQuery.of(context).size.width,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSwimmingPoolSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[6].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isSwimmingPoolSelected = false;
                      } else if (isSwimmingPoolSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[6].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isSwimmingPoolSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSwimmingPoolSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isSwimmingPoolSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isSwimmingPoolSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/swimmingPool.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[6].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isGymSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[7].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isGymSelected = false;
                      } else if (isGymSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[7].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isGymSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isGymSelected ? Colors.green : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isGymSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isGymSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/gym.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[7].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFireSafetySelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[8].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isFireSafetySelected = false;
                      } else if (isFireSafetySelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[8].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isFireSafetySelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isFireSafetySelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isFireSafetySelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isFireSafetySelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/fireSafety.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[8].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 3.0,
            ),
            Container(
                //width: MediaQuery.of(context).size.width,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isServantRoomSelected == true) {
                        isServantRoomSelected = false;

                        Featuresinputlist.remove(
                            FeaturesTypelist[9].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                      } else if (isServantRoomSelected == false) {
                        isServantRoomSelected = true;
                        Featuresinputlist.add(
                            FeaturesTypelist[9].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isServantRoomSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isServantRoomSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isServantRoomSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/servantRoom.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[9].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isClubHouseSelected == true) {
                        isClubHouseSelected = false;

                        Featuresinputlist.remove(
                            FeaturesTypelist[10].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                      } else if (isClubHouseSelected == false) {
                        isClubHouseSelected = true;
                        Featuresinputlist.add(
                            FeaturesTypelist[10].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                isClubHouseSelected ? Colors.green : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isClubHouseSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isClubHouseSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/clubHouse.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[10].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isAcSelected == true) {
                        isAcSelected = false;

                        Featuresinputlist.remove(
                            FeaturesTypelist[11].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                      } else if (isAcSelected == false) {
                        isAcSelected = true;
                        Featuresinputlist.add(
                            FeaturesTypelist[11].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isAcSelected ? Colors.green : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isAcSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isAcSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/ac.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[11].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 3.0,
            ),
            Container(
                //width: MediaQuery.of(context).size.width,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isInternetServicesSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[12].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isInternetServicesSelected = false;
                      } else if (isInternetServicesSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[12].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isInternetServicesSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isInternetServicesSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isInternetServicesSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isInternetServicesSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/internetService.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[12].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isInterComSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[13].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isInterComSelected = false;
                      } else if (isInterComSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[13].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isInterComSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                isInterComSelected ? Colors.green : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isInterComSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isInterComSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/intercom.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[13].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isRainWaterHarvestingSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[14].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isRainWaterHarvestingSelected = false;
                      } else if (isRainWaterHarvestingSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[14].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isRainWaterHarvestingSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isRainWaterHarvestingSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isRainWaterHarvestingSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isRainWaterHarvestingSelected =
                                            newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/rainWaterHarvesting.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[14].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 3.0,
            ),
            Container(
                //width: MediaQuery.of(context).size.width,
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isShoppinCenterSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[15].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isShoppinCenterSelected = false;
                      } else if (isShoppinCenterSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[15].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isShoppinCenterSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isShoppinCenterSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isShoppinCenterSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isShoppinCenterSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/shopping.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[15].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isGasPipelineSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[16].featuresID.toString());
                        print("Features remove:- ${Featuresinputlist}");
                        isGasPipelineSelected = false;
                      } else if (isGasPipelineSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[16].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isGasPipelineSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isGasPipelineSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isGasPipelineSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isGasPipelineSelected = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/gasPipeline.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[16].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSewageTreatmentPlantSelected == true) {
                        Featuresinputlist.remove(
                            FeaturesTypelist[17].featuresID.toString());
                        print("Features Remove:- ${Featuresinputlist}");
                        isSewageTreatmentPlantSelected = false;
                      } else if (isSewageTreatmentPlantSelected == false) {
                        Featuresinputlist.add(
                            FeaturesTypelist[17].featuresID.toString());
                        print("Features Add:- ${Featuresinputlist}");
                        isSewageTreatmentPlantSelected = true;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isSewageTreatmentPlantSelected
                                ? Colors.green
                                : Colors.red,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      height: MediaQuery.of(context).size.height / 7,
                      width: MediaQuery.of(context).size.width / 4,
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(12),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Checkbox(
                                    value: isSewageTreatmentPlantSelected,
                                    onChanged: (bool newValue) {
                                      setState(() {
                                        isSewageTreatmentPlantSelected =
                                            newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Image.asset(
                                "images/sewageTreatmentPlant.png",
                                width: MediaQuery.of(context).size.width / 10,
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(5),
                            ),
                            Expanded(
                              flex: 2,
                              child: FeaturesTypelist.length != 0
                                  ? Text(
                                      "${FeaturesTypelist[17].featuresName}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                        height: 1,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

//step 4
  Padding postedBy() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<String>(
              items: _postedBy,
              showClearButton: true,
              showSearchBox: true,
              label: 'Posted By',
              hint: "Select Posted By",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _selectedPostedBy = value;
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
                _selectedPostedBy = newValue;
              },
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
          //   child: DropdownButtonFormField(
          //     hint: Text(
          //       'Posted By',
          //       style: style,
          //     ),
          //     value: _selectedPostedBy,
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
          //           _selectedPostedBy = newValue;
          //           print("Posted By:- ${_selectedPostedBy}");
          //         },
          //       );
          //     },
          //     items: _postedBy.map((poBy) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           poBy,
          //           style: kTextStyleForContent,
          //         ),
          //         value: poBy,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),
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
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<String>(
              items: _city,
              showClearButton: true,
              showSearchBox: true,
              label: 'City',
              hint: "Select City",
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _selectedCity = value;
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
                _selectedCity = newValue;
              },
            ),
          ),

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
          //           FontAwesomeIcons.city,
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
          //           print("City:- ${_selectedCity}");
          //         },
          //       );
          //     },
          //     items: _city.map((cty) {
          //       return DropdownMenuItem(
          //         child: new Text(
          //           cty,
          //           style: kTextStyleForContent,
          //         ),
          //         value: cty,
          //       );
          //     }).toList(),
          //     isExpanded: true,
          //   ),
          // ),
        ],
      ),
    );
  }

  Padding contactNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textContactNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.phone,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Contact Number',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textContactNumber.text = value;
              },
              onChanged: (value) {
                setState(() {
                  showPlaceList = false;
                });
                ContactNumber = value;
                print("Contact Number:- ${ContactNumber}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding AlternatecontactNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _TextAlternateConatactNumber,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.phone,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Alterate Contact Number',
                hintStyle: style,
              ),
              // validator: (String value) {
              //   if (value.isEmpty) {
              //     return 'This is required';
              //   }
              // },
              onSaved: (String value) {
                _TextAlternateConatactNumber.text = value;
              },
              onChanged: (value) {
                setState(() {
                  showPlaceList = false;
                });
                alterContactNumber = value;
                print("Alternate Contact Number:- ${alterContactNumber}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding TelephoneNumber() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    controller: _TextstdcodeNumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      // prefixIcon: Padding(
                      //   padding:
                      //   const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                      //   child: FaIcon(
                      //     FontAwesomeIcons.phone,
                      //     color: primarycolor,
                      //   ),
                      // ),
                      hintText: 'STD Code',
                      hintStyle: style,
                    ),
                    // validator: (String value) {
                    //   if (value.isEmpty) {
                    //     return 'This is required';
                    //   }
                    // },
                    onSaved: (String value) {
                      _TextstdcodeNumber.text = value;
                    },
                    onChanged: (value) {
                      setState(() {
                        showPlaceList = false;
                      });
                      _stdcode = value;
                      print("STD Code:- ${_stdcode}");
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  child: TextFormField(
                    controller: _TexttelephoneNumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, right: 0.0, left: 0.0),
                        child: FaIcon(
                          FontAwesomeIcons.phone,
                          color: primarycolor,
                        ),
                      ),
                      hintText: 'Telephone Number',
                      hintStyle: style,
                    ),
                    // validator: (String value) {
                    //   if (value.isEmpty) {
                    //     return 'This is required';
                    //   }
                    // },
                    onSaved: (String value) {
                      _TexttelephoneNumber.text = value;
                    },
                    onChanged: (value) {
                      setState(() {
                        showPlaceList = false;
                      });
                      _telephonenumber = value;
                      print("Telephone Number:- ${_telephonenumber}");
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding searchLocation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextFormField(
              controller: _textSearchLocation,
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
                      _textSearchLocation.clear();
                      setState(() {
                        _placeList.clear();
                        showPlaceList = false;
                      });
                    }),
                hintText: 'Property Location',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textSearchLocation.text = value;
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
                      _textSearchLocation.text =
                          _placeList[index]["description"];

                      var placeId = _placeList[index]["place_id"];
                      var address = _placeList[index]["description"];
                      print('${_placeList[index]}');
                      getPlaceInfoDetails(address);
                      // lat = detail.result.geometry.location.lat;
                      // long = detail.result.geometry.location.lng;
                      setState(() {
                        showPlaceList = false;
                        _placeList.clear();
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

  Padding area() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textArea,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.chartArea,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Area',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textArea.text = value;
              },
              onChanged: (value) {
                setState(() {
                  showPlaceList = false;
                });
                Area = value;
                print("Area:- ${Area}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding societyName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textSoceityName,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.building,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Society Name',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textSoceityName.text = value;
              },
              onChanged: (value) {
                SoceityName = value;
                print("Soceity Name:- ${SoceityName}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding streetName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textStreetName,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.road,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Street Name',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textStreetName.text = value;
              },
              onChanged: (value) {
                StreetName = value;
                print("Street Name:- ${StreetName}");
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding pinCode() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textPinCode,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.mapPin,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Pin Code',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textPinCode.text = value;
              },
              onChanged: (value) {
                PinCode = value;
                print("Pin Code:- ${PinCode}");
              },
            ),
          ),
        ],
      ),
    );
  }

  //----------------------------------------------------------------------------------

  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    print("User ID:- ${UID}");

    _textpossessionDate.clear();
    _textPropertyType.clear();
    _textSearchLocation.clear();
    _textArea.clear();
    _textSoceityName.clear();
    _textStreetName.clear();
    _textContactNumber.clear();
    _textresidentialPropertyType.clear();
    _textcommercialPropertyType.clear();
    _textprojectResidentialPropertyType.clear();
    _textbhkType.clear();
    _textPinCode.clear();
    _textpreferTen.clear();
    _textnonveg.clear();
    _textwatersupplier.clear();
    _textpowercuting.clear();
    _TextAlternateConatactNumber.clear();
    _TextstdcodeNumber.clear();
    _TexttelephoneNumber.clear();
    _textNumberOfBathrooms.clear();
    _textBuiltUpSqFt.clear();
    _textCarpetAreaSqFt.clear();
    _textPriceYouExpect.clear();
    _textRoadWidth.clear();
    _textOtherCharges.clear();
    _textExpectedRentPerMonth.clear();
    _textExpectedDeposite.clear();
    _textDescription.clear();
    _textNumberOfBalconies.clear();
    print("All clear------------");
  }

  @override
  void initState() {
    _getFetchingPropertyType();
    _getBHKType();
    _getFetchingfeaturesType();
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    final DateTime now = DateTime.now();
    sDateTime = now;
    PossessionDate = DateFormat('yyyy-MM-dd').format(sDateTime);
    getUserdata();
    getFloor();
    setState(() {
      images.add("");
    });
  }

  //fetching property Type
  void _getFetchingPropertyType() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchPropertyType fetchpropertytypedata = new FetchPropertyType();
      var fetchpropertytype =
          await fetchpropertytypedata.getFetchPropertyType("0", "");
      if (fetchpropertytype != null) {
        var resid = fetchpropertytype["resid"];
        if (resid == 200) {
          var fetchpropertytypesd = fetchpropertytype["propertytype"];
          print(fetchpropertytypesd.length);
          List<PropertType> fetchpropertytypeBill = [];
          for (var n in fetchpropertytypesd) {
            PropertType pro = PropertType(
              int.parse(n["PropertryTypesID"]),
              n["PropertryTypesName"],
            );
            fetchpropertytypeBill.add(pro);
          }
          setState(() {
            this.propertyTypelist = fetchpropertytypeBill;
          });
          print("//////propertyTypelist/////////${propertyTypelist.length}");
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

  //fetching BHK Type
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

//fetching property Type
  void _getFetchingSubPropertyType(String Type, String Type2) async {
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
            if (Type2 == "1") {
              this.residentialPropertyTypelist = tempsubpropertytypelist;
              commercialPropertyTypelist = [];
              projectResidentialPropertyTypelist = [];
              projectcommercialPropertyTypelist = [];
            } else if (Type2 == "2") {
              this.commercialPropertyTypelist = tempsubpropertytypelist;
              residentialPropertyTypelist = [];
              projectResidentialPropertyTypelist = [];
              projectcommercialPropertyTypelist = [];
            } else if (Type2 == "3") {
              this.projectResidentialPropertyTypelist = tempsubpropertytypelist;
              residentialPropertyTypelist = [];
              commercialPropertyTypelist = [];
              projectcommercialPropertyTypelist = [];
            } else if (Type2 == "4") {
              this.projectcommercialPropertyTypelist = tempsubpropertytypelist;
              residentialPropertyTypelist = [];
              commercialPropertyTypelist = [];
              projectResidentialPropertyTypelist = [];
            }
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

  //fetching Features Type
  void _getFetchingfeaturesType() async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchFeatureType fetchFeaturedata = new FetchFeatureType();
      var fetchfeature = await fetchFeaturedata.getFetchFeaturesType("0");
      if (fetchfeature != null) {
        var resid = fetchfeature["resid"];
        if (resid == 200) {
          var fetchfeaturesd = fetchfeature["FeaturesList"];
          print(fetchfeaturesd);
          print(fetchfeaturesd.length);
          List<FeaturesType> tempFeaturetypelist = [];
          for (var n in fetchfeaturesd) {
            FeaturesType pro =
                FeaturesType(int.parse(n["FeaturesID"]), n["FeaturesName"]);
            tempFeaturetypelist.add(pro);
          }
          setState(() {
            this.FeaturesTypelist = tempFeaturetypelist;
          });
//          for (int i = 0; i < FeaturesTypelist.length; i++) {
//            print(
//                "//////FeaturesTypelist Name/////////${FeaturesTypelist[i].featuresName}");
//          }
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

  getFloor() {
    List<String> tempfloor = [];
    tempfloor.add('Ground Floor');
    for (int i = 1; i <= 100; i++) {
      tempfloor.add('${i}');
    }
    setState(() {
      _selectFloor = tempfloor;
      _totalFloor = tempfloor;
    });
  }

//----------------------------------------------------------------------------------------
  Future<void> _selectDate(BuildContext context) async {
    final DateTime frompicked = await showDatePicker(
      context: context,
      initialDate: sDateTime,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
      helpText: 'Select Possession Date',
      cancelText: 'Not now',
      confirmText: 'Ok',
    );
    if (frompicked != null && frompicked != sDateTime)
      setState(() {
        sDateTime = (frompicked);
        PossessionDate = DateFormat('yyyy-MM-dd').format(sDateTime);
      });
  }
}

void step1Validation() {
  print('Selected Property Type : ' + _selectedPropertyType);

  if (commonpropertyfor != null && isListPropertyForVisible == true) {
    print(commonpropertyfor);
  }

  if (Projectpropertyfor != null && isListPropertyForProjectVisible == true) {
    print(Projectpropertyfor);
  }

  if (_selectedResidentialPropertyType != null &&
      isResidentialPropertyTypeVisible == true) {
    print('Selected Residential Property Type :' +
        _selectedResidentialPropertyType);
  }

  if (_selectedCommercialPropertyType != null &&
      isCommercialPropertyTypeVisible == true) {
    print('Selected Commercial Property Type :' +
        _selectedCommercialPropertyType);
  }

  if (_selectedProjectResidentialPropertyType != null &&
      isProjectResidentialPropertyTypeVisible == true) {
    print('Selected Project Residential Property Type :' +
        _selectedProjectResidentialPropertyType);
  }

  if (_selectedProjectCommercialPropertyType != null &&
      isProjectCommercialPropertyTypeVisible == true) {
    print('Selected Project Commercial Property Type :' +
        _selectedProjectCommercialPropertyType);
  }

  if (_selectedBHKType != null && isBhkTypeVisible == true) {
    print('Selected BHK Type :' + _selectedBHKType);
  }

  print('Possession Date :' + formatedDate);
}

void step2Validation() {
  if (!_formKey2.currentState.validate()) {
    return;
  }
  _formKey2.currentState.save();

  print(_selectedFloor);
  print(_selectedTotalFloor);
  print(_selectedPropertyAge);
  print(_textBuiltUpSqFt.text);
  print(_textCarpetAreaSqFt.text);
  print(_selectedFacing);
  print(_selectedParking);
  print(_selectedMaintenance);

  if (isRent() == true) {
    print(_selectedPreferredTenants);
  }

  print(_selectedFurnishing);
  if (isRent() == true) {
    print(_textExpectedRentPerMonth.text);
  }

  if (isRent() == true) {
    print(_textExpectedDeposite.text);
  }

  if (isSell() == true) {
    print(_textPriceYouExpect.text);
  }

  if (isSell() == true) {
    print(_isNegotiable);
  }

  print(_textRoadWidth.text);
  print(_textOtherCharges.text);
  print(_textDescription.text);
}

void step3Validation() {
  if (!_formKey3.currentState.validate()) {
    return;
  }
  print(_textNumberOfBathrooms.text);
  print(_textNumberOfBalconies.text);
  print(_selectedWaterSupply);
  print(_selectedPowerCutting);
  if (isRent() == true) {
    print(_selectedNonVegAllowed);
  }
}

bool isRent() {
  if (selectedPropertyFor() == ListPropertyFor.Rent &&
      isListPropertyFor() == true) {
    return true;
  } else {
    return false;
  }
}

bool isSell() {
  if (selectedPropertyFor() == ListPropertyFor.Buy &&
          isListPropertyFor() == true ||
      selectedPropertyForProject() == ListPropertyForProject.Buy &&
          isListPropertyForProject() == true) {
    return true;
  } else {
    return false;
  }
}

ListPropertyFor selectedPropertyFor() {
  return commonpropertyfor;
}

ListPropertyForProject selectedPropertyForProject() {
  return Projectpropertyfor;
}

bool isListPropertyFor() {
  return isListPropertyForVisible;
}

bool isListPropertyForProject() {
  return isListPropertyForProjectVisible;
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
