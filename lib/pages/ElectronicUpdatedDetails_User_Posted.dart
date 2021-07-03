import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cool_stepper/cool_stepper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:onclickproperty/Adaptor/Post_Electronic_Details_Image.dart';
import 'package:onclickproperty/Adaptor/Updated_Electronic_Details_Image.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Porducts.dart';
import 'package:onclickproperty/Adaptor/fetch_Electronic_Type.dart';
import 'package:onclickproperty/Model/Electronics_type.dart';
import 'package:onclickproperty/Model/Electronicsitems.dart';
import 'package:onclickproperty/const/const.dart';
import 'package:onclickproperty/const/shared_preference_constants.dart';
import 'package:onclickproperty/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:onclickproperty/utilities/numerictextinputformatter.dart';
import 'package:onclickproperty/utilities/size_config.dart';
import 'package:uuid/uuid.dart';

class UpdatedElectronicsPage extends StatefulWidget {
  @override
  String Electronicid;
  UpdatedElectronicsPage(this.Electronicid);
  _UpdatedElectronicsPageState createState() => _UpdatedElectronicsPageState();
}

final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
bool showspinner = false;
String _BrandName;
String _Title;
String _Price;
String _Pincode;
String _LocationSearch;
String _PowerWatt;
String _Model;
String _Description;
String _selectdate;
String UID;
String _selectedAppliancesTypeName;
String _selectedAppliancesTypeId;
//List images;

List<Object> images = List<Object>();
Future<File> _imageFile;
List<File> imageslistfile = [];

var uuid = new Uuid();
String _sessionToken;
List<dynamic> _placeList = [];
bool showPlaceList = false;

List<String> _condition = [
  'Almost Like New',
  'Brand New',
  'Gently Used',
  'Heavily Used',
  'Unboxed',
];
String _selectedCondition;
String SearchLocation;

List<String> _city = [
  'Mumbai',
  'Thane',
  'Nagpur',
  'Navi Mumbai',
  'Aurangabad',
];
String _selectedCity;

List<String> _youAre = ['Owner', 'Agent'];
String _selectedYouAre;
double lat, long;

TextEditingController _textAlternatenumber = TextEditingController();
TextEditingController _textStdCode = TextEditingController();
TextEditingController _textTelephonenumber = TextEditingController();

String AlternatNumber;
String StdCode;
String TelephoneNumber;

List<String> oldPropertyImgList = [];
List<String> previmagesList;
String previewImages = '';

TextEditingController _textelectronictypeName = TextEditingController();
TextEditingController _textBrandName = TextEditingController();
TextEditingController _textTitle = TextEditingController();
TextEditingController _textPrice = TextEditingController();
TextEditingController _textPincode = TextEditingController();
TextEditingController _textLocationSearch = TextEditingController();
TextEditingController _textPowerWatt = TextEditingController();
TextEditingController _textModel = TextEditingController();
TextEditingController _textDescription = TextEditingController();

class _UpdatedElectronicsPageState extends State<UpdatedElectronicsPage> {
  @override
  void getUserdata() async {
    UID = await SharedPreferencesConstants.instance
        .getStringValue(SharedPreferencesConstants.USERID);
    print("User ID:- ${UID}");
  }

  getPlaceInfoDetails(String address) async {
    final query = '$address';
    print('getLatLong');
    SearchLocation = '$address';
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
        _Pincode = placemarks[0].postalCode.toString();
      });
    });
  }

  @override
  void initState() {
    getUserdata();
    _getElectronicType();
    print("Electronicid IN Update//////////${widget.Electronicid}");
    _getElectronicProducts(widget.Electronicid);
    _selectdate = DateFormat('yyyy-MM-dd').format(new DateTime.now());
    print("Date:- ${_selectdate}");
    //images.add("");
  }

  List<ElectronicsType> ElectronicTypelist = new List();
  List<ElectronicItems> ElectronicListFetch = new List();

  Widget build(BuildContext context) {
    final List<CoolStep> steps = [
      CoolStep(
        title: "Post Free Ad For Electronics",
        subtitle: "Please Fill Your Information",
        content: Form(
          key: _formKey1,
          child: Column(
            children: <Widget>[
              appliancesType(),
              brandName(),
              condition(),
              title(),
              price(),
              // pincode(),
              // city(),
              youAre(),
              searchLocation(),
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
        title: "Post Free Ad For Electronics",
        subtitle: "Additional Details",
        content: Form(
          key: _formKey2,
          child: Column(
            children: <Widget>[
              // Text(
              //   "Additional Details",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              // ),
              powerWatt(),
              model(),
              description(),
              AlternatemobileNo(),
              TelephoneNo(),
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
        title: "Post Free Ad For Electronics",
        subtitle: "Post Images",
        content: Form(
          key: _formKey3,
          child: Column(
            children: <Widget>[
              //addphotos(),
              Text(
                'Previous Property Photos:',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
              previmagesList != null
                  ? Visibility(
                      visible: oldPropertyImgList.length != 0 ? true : false,
                      child: buildNetworkImageGridView())
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'No Previous Property Photos',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
              Divider(),
              Text(
                'Add More Property Photos:',
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
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
        print("Appliances Type ID:-${_selectedAppliancesTypeId}");
        print("Appliances Type Name:-${_selectedAppliancesTypeName}");
        print("Brand Name:-${_BrandName}");
        print("Condition:-${_selectedCondition}");
        print("Title:-${_Title}");
        print("Price:-${_Price}");
        print("Pincode:-${_Pincode}");
        print("City:-${_selectedCity}");
        print("Location Search :-${SearchLocation}");
        print("You Are:-${_selectedYouAre}");
        print("Power Watt:-${_PowerWatt}");
        print("Model:-${_Model}");
        print("Description:-${_Description}");
        print("User ID:- ${UID}");
        print("electronic id:- ${widget.Electronicid}");
        print("Date:- ${_selectdate}");
        print("lat:- ${lat}");
        print("long:- ${long}");
        print("AlternatNumber:- ${AlternatNumber}");
        print("StdCode:- ${StdCode}");
        print("TelephoneNumber:- ${TelephoneNumber}");

        print("--------------images-------------------");
        print(imageslistfile);

        if (oldPropertyImgList.length != 0) {
          previewImages = oldPropertyImgList.join('#');
        }
        print("------------previewImages---------------------");
        print(previewImages);

        _updateElectronicSubmitData(
            imageslistfile,
            previewImages,
            widget.Electronicid.toString(),
            UID,
            _selectedAppliancesTypeId,
            _BrandName,
            _selectedCondition,
            _selectedCondition,
            _Title,
            _Price,
            _Pincode != null ? _Pincode : '',
            _selectedCity != null ? _selectedCity : '',
            SearchLocation,
            _selectedYouAre,
            _PowerWatt,
            _Model,
            _Description,
            _selectdate,
            lat != null ? lat.toString() : '',
            long != null ? long.toString() : '',
            AlternatNumber != null ? AlternatNumber : '',
            StdCode != null ? StdCode : '',
            TelephoneNumber != null ? TelephoneNumber : '');

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
        title: Text("Post Electronics"),
      ),
      body: showspinner
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: stepper,
            ),
    );
  }

  //----------------------------------------------------------

  Widget buildNetworkImageGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1,
      children: List.generate(oldPropertyImgList.length, (index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              Image.network(
                oldPropertyImgList[index],
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
                      oldPropertyImgList.removeAt(index);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

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
    setState(() async {
      if (chooseType == 0) {
        FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);


        _imageFile =  Future<File>.value(File(result.paths[0]));
       // _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      } else {
        final _picker = ImagePicker();
        PickedFile image = await _picker.getImage(source: ImageSource.camera,imageQuality: 50);
        _imageFile = Future<File>.value(File(image.path));
       // _imageFile = ImagePicker. pickImage(source: ImageSource.camera);
      }
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
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

  Padding appliancesType() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownSearch<ElectronicsType>(
              //searchBoxController: _textelectronictypeName,
              items: ElectronicTypelist,
              showClearButton: true,
              showSearchBox: true,
              //hint: 'Appliances Type',
              hint: _textelectronictypeName != null
                  ? "${_textelectronictypeName.text.toString()}"
                  : 'Appliances Type',
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (_textelectronictypeName.text.isEmpty) {
                  if (value == null) {
                    return 'This is required';
                  }
                }
              },
              onSaved: (ElectronicsType value) {
                _textelectronictypeName.text =
                    value.ElectronicsTypeName.toString();
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
                    _selectedAppliancesTypeName =
                        newValue.ElectronicsTypeName.toString();
                    _selectedAppliancesTypeId =
                        newValue.ElectronicsTypeID.toString();
                    print("Appliances Type ID:-${_selectedAppliancesTypeId}");
                    print(
                        "Appliances Type Name:-${_selectedAppliancesTypeName}");
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding brandName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textBrandName,
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
                hintText: 'Brand Name',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textBrandName.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _BrandName = newValue;
                  print("Brand Name:-${_BrandName}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding condition() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownButtonFormField(
              hint: Text(
                'Condition',
                style: style,
              ),
              value: _selectedCondition,
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
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onChanged: (newValue) {
                setState(
                  () {
                    _selectedCondition = newValue;
                    print("Condition:-${_selectedCondition}");
                  },
                );
              },
              items: _condition.map((face) {
                return DropdownMenuItem(
                  child: new Text(
                    face,
                    style: kTextStyleForContent,
                  ),
                  value: face,
                );
              }).toList(),
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }

  Padding title() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textTitle,
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
                hintText: 'Title',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textTitle.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _Title = newValue;
                  print("Title:-${_Title}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding price() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textPrice,
              keyboardType: TextInputType.number,
              inputFormatters: [NumericTextFormatter()],
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.moneyCheckAlt,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Price',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textPrice.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _Price = newValue;
                  print("Price:-${_Price}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding pincode() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textPincode,
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
                hintText: 'Pincode',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textPincode.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _Pincode = newValue;
                  print("Pincode:-${_Pincode}");
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
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownButtonFormField(
              hint: Text(
                'City',
                style: style,
              ),
              value: _selectedCity,
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
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onChanged: (newValue) {
                setState(
                  () {
                    _selectedCity = newValue;
                    print("City:-${_selectedCity}");
                  },
                );
              },
              items: _city.map((face) {
                return DropdownMenuItem(
                  child: new Text(
                    face,
                    style: kTextStyleForContent,
                  ),
                  value: face,
                );
              }).toList(),
              isExpanded: true,
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
                hintText: 'Search Location',
                hintStyle: style,
                suffixIcon: IconButton(
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      _textLocationSearch.clear();
                      setState(() {
                        _placeList.clear();
                        _selectedCity = null;
                        _Pincode = null;
                        showPlaceList = false;
                      });
                    }),
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

  //-------------------------------------------------------------------------------------

  Padding youAre() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: DropdownButtonFormField(
              hint: Text(
                'You Are',
                style: style,
              ),
              value: _selectedYouAre,
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
              validator: (value) {
                if (value == null) {
                  return 'This is required';
                }
              },
              onChanged: (newValue) {
                setState(
                  () {
                    _selectedYouAre = newValue;
                    print("You Are:-${_selectedYouAre}");
                  },
                );
              },
              items: _youAre.map((face) {
                return DropdownMenuItem(
                  child: new Text(
                    face,
                    style: kTextStyleForContent,
                  ),
                  value: face,
                );
              }).toList(),
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }

  Padding powerWatt() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textPowerWatt,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.batteryFull,
                    color: primarycolor,
                  ),
                ),
                hintText: 'PowerWatt',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textPowerWatt.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _PowerWatt = newValue;
                  print("Power Watt:-${_PowerWatt}");
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding model() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 5.0, right: 5.0),
            child: TextFormField(
              controller: _textModel,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 0.0, left: 0.0),
                  child: FaIcon(
                    FontAwesomeIcons.suitcase,
                    color: primarycolor,
                  ),
                ),
                hintText: 'Model',
                hintStyle: style,
              ),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textModel.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _Model = newValue;
                  print("Model:-${_Model}");
                });
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
              keyboardType: TextInputType.text,
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
                if (value.isEmpty) {
                  return 'This is required';
                }
              },
              onSaved: (String value) {
                _textDescription.text = value;
              },
              onChanged: (newValue) {
                setState(() {
                  _Description = newValue;
                  print("Description:-${_Description}");
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
                    FontAwesomeIcons.mobile,
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

  Padding addphotos() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: RaisedButton(
                color: Colors.blue,
                child: new Text(
                  "Choose File",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {

                  FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.image);

                  // List<File> result =
                  //     await FilePicker.getMultiFile(type: FileType.image);
                  if (result != null) {
                    setState(() {
                      print("inside if in image picker");
                      //images.clear();
                      images = result.paths.map((path) => File(path)).toList();
                    });
                  } else {
                    print("inside else in image picker");
                  }

                  // print("Inside Pressed Button $images");
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              child: images != null
                  ? GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 8.0,
                      children: List.generate(images.length, (index) {
                        return Center(
                          child: Image.file(images[index]),
                        );
                      }),
                    )
                  : Center(
                      child: Text('No image selected.'),
                    ))
        ],
      ),
    );
  }

  void _getElectronicType() async {
    setState(() {
      showspinner = true;
    });
    FetchElectronicType fetchelectronictypedata = new FetchElectronicType();
    var fetchelectronictype =
        await fetchelectronictypedata.getFetchElectronicType("0");
    var resid = fetchelectronictype["resid"];
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
    print("//////ElectronicTypelist/////////${ElectronicTypelist.length}");
    setState(() {
      showspinner = false;
    });
  }

  Future<String> _updateElectronicSubmitData(
      List images,
      String previousimages,
      String electronicid,
      String u_id,
      String appliances_type,
      String brand,
      String condition,
      String capacity,
      String title,
      String price,
      String pin_code,
      String city,
      String area,
      String your_are,
      String wattage,
      String model,
      String description,
      String date,
      String lat,
      String long,
      String alertnate_no,
      String std_code,
      String telphone_no) async {
    setState(() {
      showspinner = true;
    });
    try {
      UpdatedElectronicImageSubmit ElectronicSubmitData =
          new UpdatedElectronicImageSubmit();
      var ElectronicData =
          await ElectronicSubmitData.UpdatedElectronicuploadData(
              images,
              previousimages,
              electronicid,
              u_id,
              appliances_type,
              brand,
              condition,
              capacity,
              title,
              price,
              pin_code,
              city,
              area,
              your_are,
              wattage,
              model,
              description,
              date,
              lat,
              long,
              alertnate_no,
              std_code,
              telphone_no);
      if (ElectronicData != null) {
        print("property data ///${ElectronicData}");
        var resid = ElectronicData['resid'];
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

          _textAlternatenumber.clear();
          _textStdCode.clear();
          _textTelephonenumber.clear();
          _textelectronictypeName.clear();
          _textBrandName.clear();
          _textTitle.clear();
          _textPrice.clear();
          _textPincode.clear();
          _textLocationSearch.clear();
          _textPowerWatt.clear();
          _textModel.clear();
          _textDescription.clear();

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

  void _getElectronicProducts(String itemid) async {
    setState(() {
      showspinner = true;
    });
    try {
      FetchElectronicProducts fetchelectronicproductsdata =
          new FetchElectronicProducts();
      var fetchelectronicproducts = await fetchelectronicproductsdata
          .getFetchElectronicProducts("4", "4", itemid, "");
      if (fetchelectronicproducts != null) {
        var resid = fetchelectronicproducts["resid"];
        if (resid == 200) {
          var fetchelectronicprodcutssd =
              fetchelectronicproducts["electronicslist"];
          print(fetchelectronicprodcutssd.length);
          print(
              "-----------fetchelectronicprodcutssd--------------------------");
          print(fetchelectronicprodcutssd);
          List<ElectronicItems> tempfetchelectronicprodcutslist = [];
          for (var n in fetchelectronicprodcutssd) {
            ElectronicItems pro = ElectronicItems(
              int.parse(n["id"]),
              int.parse(n["uid"]),
              int.parse(n["appliancestypeid"]),
              n["appliancestypeName"],
              n["brand"],
              n["condition"],
              n["capacity"],
              n["title"],
              n["price"],
              n["mobileno"],
              n["username"],
              n["email"],
              n["pincode"],
              n["city"],
              n["area"],
              n["yourare"],
              n["wattage"],
              n["model"],
              n["description"],
              n["date"],
              n["Firstimg"],
              n["img"],
              n["alternateno"],
              n["std"],
              n["telephoneno"],
              n["lat"],
              n["long"],
            );
            tempfetchelectronicprodcutslist.add(pro);
          }
          setState(() {
            this.ElectronicListFetch = tempfetchelectronicprodcutslist;
            print(
                "//////ElectroicProductslist/////////${ElectronicListFetch.length}");
            _textelectronictypeName.text =
                ElectronicListFetch[0].ElectronicAppliancestypename;
            _textBrandName.text = ElectronicListFetch[0].ElectronicBrandname;
            _textTitle.text = ElectronicListFetch[0].ElectronicTitle;
            _textPrice.text = ElectronicListFetch[0].ElectronicPrice;
            _textPincode.text = ElectronicListFetch[0].ElectronicPincode;
            _textLocationSearch.text = ElectronicListFetch[0].ElectronicArea;
            _textPowerWatt.text = ElectronicListFetch[0].ElectronicWattage;
            _textModel.text = ElectronicListFetch[0].ElectronicModel;
            _textDescription.text =
                ElectronicListFetch[0].ElectronicDescription;

            _selectedAppliancesTypeName =
                ElectronicListFetch[0].ElectronicAppliancestypename.toString();
            print(
                "///////_selectedAppliancesTypeName////////////////////////////${_selectedAppliancesTypeName}");
            _selectedAppliancesTypeId =
                ElectronicListFetch[0].ElectronicAppliancestypeid.toString();
            print(
                "///////_selectedAppliancesTypeId////////////////////////////${_selectedAppliancesTypeId}");
            _BrandName = ElectronicListFetch[0].ElectronicBrandname.toString();
            print("///////_BrandName////////////////////////////${_BrandName}");
            _selectedCondition =
                ElectronicListFetch[0].ElectronicCondition.toString();
            print(
                "///////_selectedCondition////////////////////////////${_selectedCondition}");
            //_selectedCondition=ElectronicListFetch[0].ElectronicCapacity.toString()
            _Title = ElectronicListFetch[0].ElectronicTitle.toString();
            print("///////_Title////////////////////////////${_Title}");
            _Price = ElectronicListFetch[0].ElectronicPrice.toString();
            print("///////_Price////////////////////////////${_Price}");
            _Pincode = ElectronicListFetch[0].ElectronicPincode.toString();
            print("///////_Pincode////////////////////////////${_Pincode}");
            _selectedCity = ElectronicListFetch[0].ElectronicCity.toString();
            print(
                "///////_selectedCity////////////////////////////${_selectedCity}");
            SearchLocation = ElectronicListFetch[0].ElectronicArea.toString();
            print(
                "///////SearchLocation////////////////////////////${SearchLocation}");
            _selectedYouAre =
                ElectronicListFetch[0].ElectronicYouAre.toString();
            print(
                "///////_selectedYouAre////////////////////////////${_selectedYouAre}");
            _PowerWatt = ElectronicListFetch[0].ElectronicWattage.toString();
            print("///////_PowerWatt////////////////////////////${_PowerWatt}");
            _Model = ElectronicListFetch[0].ElectronicModel.toString();
            print("///////_Model////////////////////////////${_Model}");
            _Description =
                ElectronicListFetch[0].ElectronicDescription.toString();
            print(
                "///////_Description////////////////////////////${_Description}");
            lat = double.parse(ElectronicListFetch[0].ElectronicLat.toString());
            print("///////lat////////////////////////////${lat}");
            long =
                double.parse(ElectronicListFetch[0].ElectronicLong.toString());
            print("///////long////////////////////////////${long}");
            AlternatNumber =
                ElectronicListFetch[0].ElectronicAlternateNumber.toString();
            print(
                "///////AlternatNumber////////////////////////////${AlternatNumber}");
            StdCode = ElectronicListFetch[0].ElectronicStd.toString();
            print("///////StdCode////////////////////////////${StdCode}");
            TelephoneNumber =
                ElectronicListFetch[0].ElectronicTelephone.toString();
            print(
                "///////TelephoneNumber////////////////////////////${TelephoneNumber}");

            previmagesList = ElectronicListFetch[0].ElectronicImages.split("#");
            print("-----previmagesList---------");
            print(previmagesList);
            print(
                "/////////previmagesList length////////////////${previmagesList.length}");
            previmagesList.forEach((element) {
              oldPropertyImgList.add(element);
            });
            images.add("");
          });
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
